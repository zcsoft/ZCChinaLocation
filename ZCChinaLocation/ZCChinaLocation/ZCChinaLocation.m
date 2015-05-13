//
//  ZCChinaLocation.m
//  ZCChinaLocation
//
//  Created by cuibo on 5/12/15.
//  Copyright (c) 2015 cuibo. All rights reserved.
//

#import "ZCChinaLocation.h"

//矩形
@interface Rectangle : NSObject

@property(assign, nonatomic) double West;
@property(assign, nonatomic) double North;
@property(assign, nonatomic) double East;
@property(assign, nonatomic) double South;

@end

@implementation Rectangle

+ (Rectangle *)rectangleWithLa1:(double)latitude1 lo1:(double)longitude1 la2:(double)latitude2 lo2:(double)longitude2
{
    return [[Rectangle alloc]
     initWithLa1:latitude1 lo1:longitude1 la2:latitude2 lo2:longitude2];
}

- (instancetype)initWithLa1:(double)latitude1 lo1:(double)longitude1 la2:(double)latitude2 lo2:(double)longitude2
{
    self = [super init];
    if (self)
    {
        self.West = MIN(longitude1, longitude2);
        self.North = MAX(latitude1, latitude2);
        self.East = MAX(longitude1, longitude2);
        self.South = MIN(latitude1, latitude2);
    }
    return self;
}

@end



@interface ZCChinaLocation()

@property(strong, nonatomic)NSArray *regionRectangle;
@property(strong, nonatomic)NSArray *excludeRectangle;

@end

@implementation ZCChinaLocation

static id _shared;
+ (instancetype)shared
{
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //范围矩形列表
        self.regionRectangle = [[NSArray alloc] initWithObjects:
                                [Rectangle rectangleWithLa1:49.220400 lo1:079.446200 la2:42.889900 lo2:096.330000],
                                [Rectangle rectangleWithLa1:54.141500 lo1:109.687200 la2:39.374200 lo2:135.000200],
                                [Rectangle rectangleWithLa1:42.889900 lo1:073.124600 la2:29.529700 lo2:124.143255],
                                [Rectangle rectangleWithLa1:29.529700 lo1:082.968400 la2:26.718600 lo2:097.035200],
                                [Rectangle rectangleWithLa1:29.529700 lo1:097.025300 la2:20.414096 lo2:124.367395],
                                [Rectangle rectangleWithLa1:20.414096 lo1:107.975793 la2:17.871542 lo2:111.744104],
                                nil];
        
        //范围内排除的矩形列表
        self.excludeRectangle = [[NSArray alloc] initWithObjects:
                                 [Rectangle rectangleWithLa1:25.398623 lo1:119.921265 la2:21.785006 lo2:122.497559],
                                 [Rectangle rectangleWithLa1:22.284000 lo1:101.865200 la2:20.098800 lo2:106.665000],
                                 [Rectangle rectangleWithLa1:21.542200 lo1:106.452500 la2:20.487800 lo2:108.051000],
                                 [Rectangle rectangleWithLa1:55.817500 lo1:109.032300 la2:50.325700 lo2:119.127000],
                                 [Rectangle rectangleWithLa1:55.817500 lo1:127.456800 la2:49.557400 lo2:137.022700],
                                 [Rectangle rectangleWithLa1:44.892200 lo1:131.266200 la2:42.569200 lo2:137.022700],
                                 nil];
    }
    return self;
}

//判断location是否在中国
- (BOOL)isInsideChina:(CLLocationCoordinate2D)location
{
    for (int i = 0; i < self.regionRectangle.count; i++)
    {
        if([self InRectangle:self.regionRectangle[i] location:location])
        {
            for (int j = 0; j < self.excludeRectangle.count; j++)
            {
                if ([self InRectangle:self.excludeRectangle[j] location:location])
                {
                    return false;
                }
            }
            return true;
        }
    }
    return false;
}

//点是否在矩形内
- (BOOL)InRectangle:(Rectangle *)rect location:(CLLocationCoordinate2D)location
{
    return rect.West <= location.longitude && rect.East >= location.longitude && rect.North >= location.latitude && rect.South <= location.latitude;
}

@end



