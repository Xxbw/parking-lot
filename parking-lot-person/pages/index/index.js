// index.js
// 获取应用实例
const app = getApp()

Page({
  data: {
    result:[]
    
  },
  
  onLoad: function(option) {
    this.setData({
      result:option
    })
    
  },
  back(){
    wx.navigateTo({
      url: '/pages/home/home',
    })
  }
  
})
