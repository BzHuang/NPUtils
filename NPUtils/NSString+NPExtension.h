//
//  NSString+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NPEncryption 加密
@interface NSString (NPEncryption)

///字符串MD5加密
- (NSString *)np_MD5String;

///SHA1加密
- (NSString *)np_SHA1String;

@end

#pragma mark -
#pragma mark - NPNull 字符串为 NULL,nil，@"" 时处理
@interface NSString (NPEmpty)


///判断字符串是否为NULL,nil，@""
+ (BOOL)np_isEmptyString:(NSString *)string;

///判断是否为空字符串，如为空转为特定字符串，否则原值返回
+ (NSString *)np_handleEmptyStr:(NSString *)str;


///判断是否为空字符串，如为空则替换字符串，否则原值返回
+ (NSString *)np_handleEmptyStr:(NSString *)str
                     replaceStr:(NSString *)replaceStr;

/**
 判断是否为空字符串，如为空则替换字符串，否则原值返回,并在后面加一段字符串

 @param str  字符串
 @param replace 替换的字符串
 @param tail 后面添加的字
 @return 处理后的字符串
 */
+ (NSString *)np_handleEmptyStr:(NSString *)str
                  replace:(NSString *)replace
                     tail:(NSString *)tail;

@end


#pragma mark -
#pragma mark - NPValue 数值相关
@interface NSString (NPValue)

///判断是否为整形
+ (BOOL)np_isPureIntValue:(id)value;

///判断是否为浮点形
+ (BOOL)np_isPureFloatValue:(id)value;


///改变数量单位  >= 10000 以万为单位
+ (NSString *)np_quantityUnitValue:(NSInteger)value;

@end;


#pragma mark -
#pragma mark - NPSize 计算字符串尺寸
@interface NSString (NPSize)

///计算字体宽度
+ (CGFloat)np_widthWithText:(NSString *)text
                    font:(UIFont *)font
                  height:(CGFloat)height;

///计算字体的高度
+ (CGFloat)np_heightWithText:(NSString *)text
                     font:(UIFont *)font
                    width:(CGFloat)width;
///计算字体的高度
- (CGFloat)np_heihgtWithFont:(UIFont *)font
                    width:(CGFloat)width;
///计算字体宽度
- (CGFloat)np_widthWithFont:(UIFont *)font
                  height:(CGFloat)height;

@end


#pragma mark -
#pragma mark - NPURL url相关
@interface NSString (NPURL)

///转为URL
- (NSURL *)np_url;

///字符串编码成url
- (NSString *)np_encodeUrl;

///把url解码成普通字符串
- (NSString *)np_decodeUrl;

@end


#pragma mark -
#pragma mark - NPPath 文件夹、目录路径相关
@interface NSString (NPPath)

///document根文件夹
+ (NSString *)np_documentFolderPath;

///caches根文件夹
+ (NSString *)np_cachesFolderPath;

/**
 生成子文件夹
 如果子文件夹不存在，则直接创建；如果已经存在，则直接返回

 @param subFolderName 子文件夹名
 @return 文件夹路径
 */
- (NSString *)np_createSubFolderWithName:(NSString *)subFolderName;

@end

#pragma mark -
#pragma mark - NPEmoji Emoji表情
@interface NSString (NPEmoji)


///是否包含表情
- (BOOL)np_isContainsEmoji;

///过滤Emoji表情 字符串
- (NSString *)np_filterEmoji;

@end

#pragma mark -
#pragma mark - NPHtml Html
@interface NSString (NPHtml)

/**
 将html 转为适合屏幕

 @param content html内容字符串
 @return 新的html
 */
+ (NSString *)np_htmlAdapterScreenContent:(NSString *)content;

/**
 从html获取图片

 @param html html内容字符串
 @return 图片链接
 */
+ (NSArray *)np_htmlGetImageurlFromHtml:(NSString *)html;

@end


#pragma mark -
#pragma mark - NPJson
@interface NSString (NPJson)

///对象序列化成字符串
+ (NSString *)np_stringWithJsonObject:(id)obj;
///对象序列化成字符串 去掉空格、换行符
+ (NSString *)np_stringHanldToJsonObject:(id)obj;

///json反序列化方法
- (id)np_jsonObject;


/**
 读取本地的txt格式json数据 并解析返回字典

 @param fileName json 数据txt格式文件名
 @return 字典
 */
+ (id)np_jsonObjectWithFileName:(NSString *)fileName;

// JSON 字符转字典
+ (NSDictionary *)np_dictionaryWithJsonString:(NSString *)jsonString;

@end

#pragma mark -
#pragma mark - NPExtension
@interface NSString(NPExtension)

///获取uuid，每次都不一样
+ (NSString *)np_UUID;

///是否中文
- ( BOOL)np_isChinese;

///把字符串转为金钱格式  0.00
+ (NSString *)np_moneyFormText:(NSString *)money;

- (NSString *)np_moneyFormat;

/** 判断金钱
 1.只能输入数字和小数点
 2.只能输入一个小数点
 3.只能以一个0开头
 4.小数点后后面只能输入两位数字 */
+ (BOOL)np_validateMoney: (NSString *)money;

@end

