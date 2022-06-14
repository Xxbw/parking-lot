// pages/home/home.js
const app = getApp()

Page({

    /**
     * 页面的初始数据
     */
    data: {
        carInfor:[],
        priceMoney:0,
        departureTime:0,
        entryTime:0,
        vehicleId:0,
        flag:0,
        userInfo: {},
        hasUserInfo: false,
        canIUse: wx.canIUse('button.open-type.getUserInfo'),
        canIUseGetUserProfile: false,
        canIUseOpenData: wx.canIUse('open-data.type.userAvatarUrl') && wx.canIUse('open-data.type.userNickName'), // 如需尝试获取用户信息可改为false
        dataurl:'http://localhost:8080'
    },

    //请求数据
    getInfor(){
        wx.request({
          url: this.data.dataurl + '/parking-lot/pay/getCar',
          method:"GET",
          dataType:"json",
          success:(res)=>{
            this.setData({
                carInfor:res.data.thisCar,
                priceMoney:res.data.price,
                departureTime:res.data.thisTime,
                entryTime:res.data.entryTime,
                vehicleId:res.data.vehicleId
            })
          }
        })
    },

    pay:function(e){

          let a = new Promise((resolve,reject)=>{
            var temp = e.currentTarget.dataset.articleid;
            var price = e.currentTarget.dataset.price;
            if(price == null){
              resolve(true);
            }else{
              wx.request({
                url: this.data.dataurl + '/parking-lot/pay/delCar',
                method:"GET",
                dataType:"json",
                contentType:'application/json;charset=utf-8',
                data:{
                    id:temp
                },
                success:(result)=>{
                  this.setData({
                      flag:result.data.temp
                  });
                  resolve(result.data.temp);
                },
                fail:function(err){
                  var flag = false;
                  resolve(flag)
                }
              });
            }
          });

          let b = new Promise((resolve,reject)=>{
            setTimeout(reject,5000,'网络错误')
          });

          let aa = Promise.race([a,b]);

          aa.then(
            success=>{
              var temp = '/pages/index/index';
              if(success){
                temp = '/pages/index/index?flag=true';
              }else{
                temp = '/pages/index/index?flag=false';
              }
              wx.navigateTo({
                url: temp,
              })
            },
            err=>{
              wx.showModal({
                title: '错误',
                content: err,
                showCancel: false,
                confirmText: '确定',
                success:(res) => {
                  wx.navigateTo({
                    url: '/pages/index/index?flag=false',
                  })
                }
              })
            }
          )

    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
        if (wx.getUserProfile) {
            this.setData({
              canIUseGetUserProfile: true
            })
          }
        this.getInfor()
    },

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {

    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {

    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {

    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {

    },

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },

    getUserProfile(e) {
        // 推荐使用wx.getUserProfile获取用户信息，开发者每次通过该接口获取用户个人信息均需用户确认，开发者妥善保管用户快速填写的头像昵称，避免重复弹窗
        wx.getUserProfile({
          desc: '展示用户信息', // 声明获取用户个人信息后的用途，后续会展示在弹窗中，请谨慎填写
          success: (res) => {
            console.log(res)
            this.setData({
              userInfo: res.userInfo,
              hasUserInfo: true
            })
          }
        })
      },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {

    }
})