//
//  NSUserDefaults+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

//
////NSUserDefaults 实例化
//#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
//
///**
// *  the saving objects      存储对象
// *
// *  @param __VALUE__ V
// *  @param __KEY__   K
// *
// *  @return
// */
//#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
//{\
//[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
//[[NSUserDefaults standardUserDefaults] synchronize];\
//}
//
///**
// *  get the saved objects       获得存储的对象
// */
//#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
//
///**
// *  delete objects      删除对象
// */
//#define UserDefaultRemoveObjectForKey(__KEY__) \
//{\
//[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
//[[NSUserDefaults standardUserDefaults] synchronize];\
//}

#import "NSUserDefaults+NPExtension.h"

@implementation NSUserDefaults (NPExtension)

//保存普通对象
+ (void)np_setObject:(id)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

//读取
+ (id)np_objectForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}



//保存int
+(void)np_setInteger:(NSInteger)value forKey:(NSString *)key{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

//读取
+ (NSInteger)np_integerForKey:(NSString *)key{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:key];
}

//保存float
+ (void)np_setFloat:(float)value forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    [defaults synchronize];
}

//读取
+ (float)np_floatForKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:key];
}

//保存bool
+ (void)np_setBool:(BOOL)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

//读取
+ (BOOL)np_boolForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

@end
