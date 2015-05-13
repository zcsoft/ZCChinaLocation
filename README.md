# ZCChinaLocation

基本思路是：把整个行政区域划分为几个小的矩形，然后再排除掉一些矩形区域。只要一个点在限定的区域内，并且不在排除的区域内，则判定成功，否则失败。下图中蓝色区域为限定区域，红色区域为排除区域。这种快速判定的方法是从Nokia map中挖掘出来的。


优点：快速，相对准确；

缺点：边界误差较大

围栏位置：

![image](https://github.com/zcsoft/ZCChinaLocation/blob/master/Image/area.png)


# 使用方法：

将ZCChinaLocation.h和ZCChinaLocation.m添加到工程;

  //判断纬度：44.042156， 经度132.759178是否在中国境内
  BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){44.042156,132.759178}];
