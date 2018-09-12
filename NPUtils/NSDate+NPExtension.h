//
//  NSDate+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/27.
//  Copyright © 2016年 HzB. All rights reserved.
//


#import <Foundation/Foundation.h>


extern NSString *const NPDateFormat_YMd;
extern NSString *const NPDateFormat_Hms;
extern NSString *const NPDateFormat_YMdHm;
extern NSString *const NPDateFormat_YMdHms;
extern NSString *const NPDateFormat_YMdH;
extern NSString *const NPDateFormat_Hm;

@interface NSDate (NPExtension)

///星期几
- (NSString *)np_weekStr;

+ (NSString *)np_pastTimeTextOfpastDate:(NSDate *)pastDate;

@end


#pragma mark -
///把时间转换后的字符串缓存起来
@interface NSObject(NPCacheDateText)

- (NSString *)np_date:(NSString *)date
            format:(NSString *)format;

@end
