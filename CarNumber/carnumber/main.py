# !/usr/bin/env python
# -*- coding: utf-8 -*-
import cv2
import pandas as pd
from pandas import DataFrame
import matplotlib.pyplot as plt
import pygame

import time
import os
import threading
import ocrutil
import btn
import uuid

# 定义颜色
from carnumber import getsql

BLACK = ( 0, 0, 0)
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
BLUE = (0, 120, 215)
GRAY = (96,96,96)
RED = (220,20,60)
YELLOW = (255,255,0)
DARKBLUE = (73, 119, 142)
BG = BLACK  # 指定背景颜色

#获取时间
localtime = time.strftime('%Y-%m-%d %H:%M', time.localtime())

#信息内容
txt1=''
txt2='减速慢行'
txt3='自动识别'
txt4='一车一杆'
txt5='车牌自动识别系统'
# 窗体大小
size = 1000, 484
# 设置帧率（屏幕每秒刷新的次数）
FPS = 5
# 一共有多少车位
Total =100
# 月收入统计分析界面开关
income_switch=False

# 获取文件的路径
cdir = os.getcwd()
# 文件路径
path=cdir+'/datafile/'

tempUrl = os.path.abspath(os.path.join(os.getcwd(), ".."))
photoPath = os.path.abspath(os.path.join(tempUrl, ".."))
saveImg = photoPath+'/parking-log-images/'
#年
year = time.strftime('%Y', time.localtime(time.time()))
#月份
month = time.strftime('%#m', time.localtime(time.time()))
#日期
day = time.strftime('%#d', time.localtime(time.time()))

mdhms = time.strftime('%m%d%H%M%S', time.localtime(time.time()))

fileYear = year
fileMonth = fileYear+'/'+month
fileDay = fileMonth+'/'+day

if not os.path.exists(fileYear):
  os.mkdir(fileYear)
  os.mkdir(fileMonth)
  os.mkdir(fileDay)
else:
  if not os.path.exists(fileMonth):
    os.mkdir(fileMonth)
    os.mkdir(fileDay)
  else:
    if not os.path.exists(fileDay):
      os.mkdir(fileDay)

savePath = saveImg + fileDay

# pygame初始化
pygame.init()
# 设置窗体名称
pygame.display.set_caption('智能停车场车牌识别计费系统')
# 图标
ic_launcher = pygame.image.load('file/ic_launcher.png')
# 设置图标
pygame.display.set_icon(ic_launcher)
# 设置窗体大小
screen = pygame.display.set_mode(size)
# 设置背景颜色
screen.fill(BG)

try:
    cam = cv2.VideoCapture(0)
except:
    print('请连接摄像头')

def textback(screen):
    # 底色
    pygame.draw.rect(screen, BG, (650, 2, 350, 640))

def text0(screen,txt1,txt2,txt3,txt4,txt5):
    # 使用系统字体
    xtfont = pygame.font.SysFont('SimHei', 36)
    texttxt1 = xtfont.render(txt1, True, RED)
    # 获取文字图像位置
    text_rect = texttxt1.get_rect()
    # 设置文字图像中心点
    text_rect.centerx = 820
    text_rect.centery = 100+20
    # 绘制内容
    screen.blit(texttxt1, text_rect)

    texttxt2 = xtfont.render(txt2, True, GREEN)
    # 获取文字图像位置
    text_rect = texttxt2.get_rect()
    # 设置文字图像中心点
    text_rect.centerx = 820
    text_rect.centery = 100+70
    # 绘制内容
    screen.blit(texttxt2, text_rect)

    texttxt3 = xtfont.render(txt3, True, GREEN)
    # 获取文字图像位置
    text_rect = texttxt3.get_rect()
    # 设置文字图像中心点
    text_rect.centerx = 820
    text_rect.centery = 100+120
    # 绘制内容
    screen.blit(texttxt3, text_rect)

    texttxt4 = xtfont.render(txt4, True, RED)
    # 获取文字图像位置
    text_rect = texttxt4.get_rect()
    # 设置文字图像中心点
    text_rect.centerx = 820
    text_rect.centery = 100+170
    # 绘制内容
    screen.blit(texttxt4, text_rect)

    texttxt5 = xtfont.render(txt5, True, WHITE)
    # 获取文字图像位置
    text_rect = texttxt5.get_rect()
    # 设置文字图像中心点
    text_rect.centerx = 820
    text_rect.centery = 100+220
    # 绘制内容
    screen.blit(texttxt5, text_rect)

def getPay():
    tempFlag = True
    while tempFlag:
        getVehicleFlag = getsql.getPayState(carId)
        if getVehicleFlag == 0:
            tempFlag = False
            global txt3
            txt3 = '一路平安'
        else:
            time.sleep(10)
# 游戏循环帧率设置
clock = pygame.time.Clock()
# 主线程
Running =True
while Running:
    # 从摄像头读取图片
    sucess, img = cam.read()
    # 保存图片，并退出。
    cv2.imwrite('file/test.jpg', img)
    # 加载图像
    image = pygame.image.load('file/test.jpg')
    # 设置图片大小
    image = pygame.transform.scale(image, (640, 480))
    # 绘制视频画面
    screen.blit(image, (2,2))
    #底色
    textback(screen)
    #提示信息
    text0(screen, txt1, txt2, txt3, txt4, txt5)
    getthistime = time.strftime('%H:%M:%S', time.localtime())
    txt1 = ''+getthistime
    # 创建识别按钮
    button_go = btn.Button(screen, (640, 480), 150, 60, BLUE, WHITE, "识别", 25)
    # 绘制创建的按钮
    button_go.draw_button()

    for event in pygame.event.get():
        # 关闭页面游戏退出
        if event.type == pygame.QUIT:
            # 退出
            pygame.quit()
            # 关闭摄像头
            cam.release()
            exit()
        #判断点击
        elif event.type == pygame.MOUSEBUTTONDOWN:
            # 输出鼠标点击位置
            print(str(event.pos[0])+':'+str(event.pos[1]))
            # 判断是否点击了识别按钮位置
            #识别按钮
            if 492<=event.pos[0] and event.pos[0]<=642 and 422<=event.pos[1] and event.pos[1]<=482:
                print('点击识别')
                payFlag = 0
                try:
                    # 获取车牌
                    carnumber=ocrutil.getcn()
                    # 转换当前时间 2021-12-11 16:18
                    localtime = time.strftime('%Y-%m-%d %H:%M', time.localtime())
                    # 获取车牌号列数据
                    carId = getsql.getCarInfor(carnumber)
                    if carId == 0:
                        setCarResult = getsql.setNewCar(carnumber, 0, 2)
                        if setCarResult > 0:
                            carId = getsql.getCarInfor(carnumber)
                        else:
                            print("setCarResult:", setCarResult)

                    getCarVehicle = getsql.getCarVehicel(carId)
                    if len(getCarVehicle) == 0 or getCarVehicle == None:
                        vehicleCount = getsql.getVehicleCount()
                        if vehicleCount < Total:
                            uid = str(uuid.uuid3(uuid.NAMESPACE_DNS, str(img)))
                            tempPath = savePath + '/' + uid + '.jpg'
                            photo = '/' + fileDay + '/' + uid + '.jpg'
                            savePhotos = cv2.imread('file/test.jpg')
                            if not os.path.exists(savePath):
                                os.makedirs(savePath)
                            cv2.imwrite(tempPath, savePhotos)
                            setNewVehicle = getsql.setNewVehicel(carId, localtime, 0, photo)
                            if setNewVehicle > 0:
                                txt2 = carnumber
                                txt3 = '欢迎光临'
                                print("欢迎光临")
                            else:
                                print("setNewVehicle:", setNewVehicle)
                        else:
                            txt2 = carnumber
                            txt3 = '车位已满'
                            print("车位已满")
                    else:
                        getCarMode = getsql.getCarMode(carnumber)
                        if getCarMode == 1:
                            getEntryTime = time.strftime('%Y-%m-%d %H:%M', time.localtime())
                            delCarVehicleRes = getsql.delCarVehicel(carId)
                            setRecordResult = getsql.setNewRecord(carId, getCarVehicle[0][2], getEntryTime, 0)
                            txt2 = carnumber
                            txt3 = '一路平安'
                            print("一路平安")
                        elif getCarMode == 2:
                            upCarState = getsql.upVehicleState(carId, 1)
                            txt2 = carnumber
                            txt3 = '等待支付'
                            t = threading.Thread(target=getPay)
                            # 开启线程
                            t.setDaemon(True)
                            t.start()
                        else:
                            print("未找到车辆")

                except Exception as e:
                    print("错误原因：", e)
                    continue
                pass
    # 跟新界面
    pygame.display.flip()
    # 控制游戏最大帧率为 60
    clock.tick(FPS)
#关闭摄像头
cam.release()




