//
//  NSUserDefaults+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (NPExtension)

+ (void)np_setObject:(id)value forKey:(NSString *)key;
+ (id)np_objectForKey:(NSString *)key;


+ (void)np_setInteger:(NSInteger)value forKey:(NSString *)key;
+ (NSInteger)np_integerForKey:(NSString *)key;


+ (void)np_setFloat:(float)value forKey:(NSString *)key;
+ (float)np_floatForKey:(NSString *)key;

+ (void)np_setBool:(BOOL)value forKey:(NSString *)key;
+ (BOOL)np_boolForKey:(NSString *)key;

@end
