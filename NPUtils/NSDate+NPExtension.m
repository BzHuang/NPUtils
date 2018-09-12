//
//  NSDate+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/27.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "NSDate+NPExtension.h"

NSString *const NPDateFormat_YMdHms = @"YYYY-MM-dd HH:mm:ss";
NSString *const NPDateFormat_YMd = @"YYYY-MM-dd";
NSString *const NPDateFormat_Hms = @"HH:mm:ss";
NSString *const NPDateFormat_YMdHm = @"YYYY-MM-dd HH:mm";
NSString *const NPDateFormat_YMdH = @"YYYY-MM-dd HH";
NSString *const NPDateFormat_Hm = @"HH:mm";

static NSDateFormatter *g_dayDateFormatter = nil;

@implementation NSDate (NPExtension)

#pragma 计算过去的时间和现在时间的差距
+ (NSString *)np_pastTimeTextOfpastDate:(NSDate *)pastDate{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitHour |
                                                         NSCalendarUnitMinute |
                                                         NSCalendarUnitSecond)
                                               fromDate:pastDate
                                                 toDate:[NSDate date] options:0];
    
    if (!g_dayDateFormatter) {
        g_dayDateFormatter = [[NSDateFormatter alloc] init];
    }
    [g_dayDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [g_dayDateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timeText = @"";
    if ([components year]) {
        timeText = [[g_dayDateFormatter stringFromDate:pastDate] substringToIndex:10];
    } else if ([components month]) {
        timeText = [[g_dayDateFormatter stringFromDate:pastDate] substringToIndex:10];
    } else if ([components day]) {
        if ([components day] > 7) {
            timeText = [[g_dayDateFormatter stringFromDate:pastDate] substringToIndex:10];
        } else {
            timeText = [NSString stringWithFormat:@"%d天前", (int)[components day]];
        }
    } else if ([components hour]) {
        timeText = [NSString stringWithFormat:@"%d小时前", (int)[components hour]];
    } else if ([components minute]) {
        if ([components minute] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d分钟前", (int)[components minute]];
        }
    } else if ([components second]) {
        if ([components second] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d秒前", (int)[components second]];
        }
    } else {
        timeText = @"刚刚";
    }
    return timeText;
}

- (NSString *)np_weekStr{

    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end


#pragma mark -

@implementation NSObject (NPCacheDateText)

- (NSMutableDictionary *)_dateDict{
    void *key = @"SHOWDATE";
    NSMutableDictionary *dict = objc_getAssociatedObject(self, key);
    if (!dict) {
        dict = [[NSMutableDictionary alloc]init];
        objc_setAssociatedObject(self, key, dict, OBJC_ASSOCIATION_RETAIN);
    }
    return dict;
}

- (NSString *)np_date:(NSString *)date
               format:(NSString *)format{

    NSString *key = [NSString stringWithFormat:@"%@%@",date,format];
    NSMutableDictionary *dateTextDict = [self _dateDict];
    NSString *dateText = [dateTextDict objectForKey:key];
    if (!dateText) {
        NSString *allDateText = date;
        if (!allDateText.length) {
            dateText = @"未知";
        }else{
            NSDate *createDate = [NSDate dateWithString:allDateText formatString:NPDateFormat_YMdHms];
            if (!createDate) {
                dateText = @"未知";
            }else{
                dateText = [createDate formattedDateWithFormat:format];
            }
        }
        [dateTextDict setObject:dateText forKey:key];
    }
    return dateText;
}

@end

