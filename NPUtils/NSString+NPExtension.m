//
//  NSString+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "NSString+NPExtension.h"
#import "CommonCrypto/CommonDigest.h"

#pragma mark - NPEncryption 加密
@implementation NSString (NPEncryption)

- (NSString *)np_MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (NSString *)np_SHA1String
{

    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    NSString *text = [result uppercaseString];
    return [text copy];
}


@end

#pragma mark -
#pragma mark - NPNull 字符串为 NULL,nil，@"" 时处理
@implementation NSString (NPEmpty)

//判断字符串是否为null @“”
+ (BOOL)np_isEmptyString:(NSString *)string
{
//    if ([string isKindOfClass:[NSString class]] &&
//        string.length > 0) {
//        return YES;
//    }
//    return NO;
    
    if (!string) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (string.length < 1) {
        return YES;
    }
    return NO;
}


//判断是否为空字符串，如为空转为特定字符串，否则原值返回
+ (NSString *)np_handleEmptyStr:(NSString *)str
{
    return [NSString np_handleEmptyStr:str replaceStr:nil];
}

//判断是否为空字符串，如为空则替换字符串，否则原值返回
+ (NSString *)np_handleEmptyStr:(NSString *)str
                  replaceStr:(NSString *)replaceStr
{
    return [self np_handleEmptyStr:str replace:replaceStr tail:nil];
}

+ (NSString *)np_handleEmptyStr:(NSString *)str
                     replace:(NSString *)replace
                        tail:(NSString *)tail{
    if ([NSString np_isEmptyString:str]) {
        if (replace) {
            return replace;
        }
        return @"未知";
        
    }else{
        if (tail) {
            return [NSString stringWithFormat:@"%@%@",str,tail];
        }
        return str;
    }
}

@end


#pragma mark -
#pragma mark - NPValue 数值相关
@implementation NSString (NPValue)

+ (NSString *)np_stringWithValue:(id)value{
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    NSString *valueStr = [NSString stringWithFormat:@"%@",value];
    return valueStr;
}

//判断是否为整形
+ (BOOL)np_isPureIntValue:(id)value{
    
    NSScanner* scan = [NSScanner scannerWithString:[self np_stringWithValue:value]];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
+ (BOOL)np_isPureFloatValue:(id)value{
    NSScanner* scan = [NSScanner scannerWithString:[self np_stringWithValue:value]];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)np_quantityUnitValue:(NSInteger)value{
    NSString *newStr = nil;
    if (value > 9999) {
        if (value % 10000 == 0) {
            NSInteger newCount = value / 10000;
            newStr = [NSString stringWithFormat:@"%zdw",newCount];
        }else if (value % 1000 == 0){
            double newCount = value / 10000;
            newStr = [NSString stringWithFormat:@"%.1lf",newCount];
        }else{
            double newCount = value / 10000.0;
            newStr = [NSString stringWithFormat:@"%.2fw",newCount];
        }
    }
    else{
        newStr = [NSString stringWithFormat:@"%zd",value];
    }
    return newStr;

}

@end


#pragma mark -
#pragma mark - NPSize 计算字符串尺寸
@implementation NSString (NPSize)

//计算字体的宽
+ (CGFloat)np_widthWithText:(NSString *)text
                    font:(UIFont *)font
                  height:(CGFloat)height{
    
    //    float width = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = font;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 0;
    CGFloat width = [label sizeThatFits:CGSizeMake(0, height)].width;
    return width;
}

//计算字体高
+ (CGFloat)np_heightWithText:(NSString *)text
                     font:(UIFont *)font
                    width:(CGFloat)width{
    //    NSString *newTitle = [NSString stringWithFormat:@"%@0",title];
    //    float height = [newTitle boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = font;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 0;
    CGFloat height = [label sizeThatFits:CGSizeMake(width, 0)].height;
    return height;
}

- (CGFloat)np_widthWithFont:(UIFont *)font
                  height:(CGFloat)height{
    UILabel *label = [[UILabel alloc]init];
    label.text = self;
    label.font = font;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 0;
    CGFloat width = [label sizeThatFits:CGSizeMake(0, height)].width;
    return width;

}

- (CGFloat)np_heihgtWithFont:(UIFont *)font
                    width:(CGFloat)width{
    UILabel *label = [[UILabel alloc]init];
    label.text = self;
    label.font = font;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 0;
    CGFloat height = [label sizeThatFits:CGSizeMake(width, 0)].height;
    return height;
}

@end

#pragma mark -
#pragma mark - NPURL url相关
@implementation NSString (NPURL)

- (NSURL *)np_url{
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
}

- (NSString *)np_encodeUrl
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */(__bridge CFStringRef)self,
                                                                                       NULL, /* charactersToLeaveUnescaped */
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    return  outputStr;
}

- (NSString *)np_decodeUrl
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                        [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

#pragma mark -
#pragma mark - NPPath 文件夹、目录路径相关
@implementation NSString (NPPath)

// document根文件夹
+ (NSString *)np_documentFolderPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// caches根文件夹
+ (NSString *)np_cachesFolderPath{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}


//如果子文件夹不存在，则直接创建；如果已经存在，则直接返回文件夹路径
- (NSString *)np_createSubFolderWithName:(NSString *)subFolderName{
    
    NSString *subFolderPath=[NSString stringWithFormat:@"%@/%@",self,subFolderName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:subFolderPath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:subFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return subFolderPath;
}

@end

#pragma mark -
#pragma mark - NPEmoji Emoji表情
@implementation NSString (NPEmoji)

//是否包含表情
- (BOOL)np_isContainsEmoji
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

//过滤表情
- (NSString *)np_filterEmoji
{
    //    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //    const char *utf8 = [string UTF8String];
    //    char *newUTF8 = malloc( sizeof(char) * len );
    //    int j = 0;
    //
    //    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    //    for ( int i = 0; i < len; i++ ) {
    //        unsigned int c = utf8;
    //        BOOL isControlChar = NO;
    //        if ( c == 4294967280 ||
    //            c == 4294967089 ||
    //            c == 4294967090 ||
    //            c == 4294967091 ||
    //            c == 4294967092 ||
    //            c == 4294967093 ||
    //            c == 4294967094 ||
    //            c == 4294967095 ||
    //            c == 4294967096 ||
    //            c == 4294967097 ||
    //            c == 4294967088 ) {
    //            i = i + 3;
    //            isControlChar = YES;
    //        }
    //        if ( c == 4294967266 || c == 4294967267 ) {
    //            i = i + 2;
    //            isControlChar = YES;
    //        }
    //        if ( c == 4294967234 ) {
    //            i = i + 1;
    //            isControlChar = YES;
    //        }
    //        if ( !isControlChar ) {
    //            newUTF8[j] = utf8;
    //            j++;
    //        }
    //    }
    //    newUTF8[j] = '\0';
    //    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
    //                                             encoding:NSUTF8StringEncoding];
    //    free( newUTF8 );
    //    return encrypted;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

@end


#pragma mark -
#pragma mark - NPHtml Html

@implementation NSString (NPHtml)

+ (NSString *)np_htmlAdapterScreenContent:(NSString *)content
{
    //    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"jsp"];
    //    NSString *path2 = [[NSBundle mainBundle]pathForResource:@"thelasttest" ofType:@"jsp"];
    //    //    NSString *_rememberWebString = [_data.recite stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //    NSString * path1_strd = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    NSString * path2_strd = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    //    NSString * strd = [NSString stringWithFormat:@"%@%@%@",path1_strd,html,path2_strd];
    //    return strd;
    
    //    html = [NSString handleNullString:html replaceString:@""];
    //    NSMutableString *content = [[NSMutableString alloc]initWithString:html];
    //    [content appendString:@"<html>"];
    //    [content appendString:@"<head>"];
    //    CGFloat maxWidth = kMainWidth - 2.0*10.0;
    //
    //    [content appendString:[NSString stringWithFormat:@"<style>*{margin-left:0;margin-right:0;padding-left:0;padding-right:0;}.aabbccdd{width:%fpx !important;height:auto !important;margin:0 !important;padding:0 !important;}p{padding:0 !important;margin-left:0 !important;margin-right:0 !important;}p *{padding:0 !important;margin:0 !important;position:relative !important;}</style>",maxWidth]];
    //    [content appendString:@"<title>webview</title>"];
    //    return content;
    
    if ([NSString np_isEmptyString:content]) {
        return @"";
    }
    NSMutableString *strContent = [[NSMutableString alloc]initWithString:content];
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width*0.9,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:100%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    return strContent;
}

+ (NSArray *)np_htmlGetImageurlFromHtml:(NSString *)html
{
    if (html.length < 1) {
        return nil;
    }
    
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:html options:0 range:NSMakeRange(0, [html length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [html substringWithRange:range];
        
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        if (match.count > 0) {
            NSTextCheckingResult * subRes = match[0];
            NSRange subRange = [subRes range];
            subRange.length = subRange.length -1;
            NSString * imagekUrl = [subString substringWithRange:subRange];
            
            //将提取出的图片URL添加到图片数组中
            [imageurlArray addObject:imagekUrl];

        }
    }
    return imageurlArray;
}

//+ (NSArray *)getImagesFromParseHtmlString:(NSString *)html{
//
//    if (![html isKindOfClass:[NSString class]] || html.length < 1) {
//        return nil;
//    }
//    NSMutableArray *imageUrlArray = [[NSMutableArray alloc]init];
//    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
//    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
//    //在页面中查找img标签
//    NSArray *images = [doc searchWithXPathQuery:@"//img"];
//
//    for (int i = 0; i < [images count]; i++){
//        //        NSString *prefix = [[[images objectAtIndex:i] objectForKey:@"src"] substringToIndex:4];
//        NSString *url = [[images objectAtIndex:i] objectForKey:@"src"];
//
//        //判断图片的下载地址是相对路径还是绝对路径，如果是以http开头，则是绝对地址，否则是相对地址
//        //        if ([prefix isEqualToString:@"http"] == NO){
//        //            url = [FILE_HOST stringByAppendingPathComponent:url];
//        //        }
//        [imageUrlArray addObject:url];
//    }
//    return imageUrlArray;
//}


@end

#pragma mark -
#pragma mark - NPJson
@implementation NSString (NPJson)


//字典序列化成字符串
+ (NSString *)np_stringWithJsonObject:(id)obj{
    
    if([NSJSONSerialization isValidJSONObject:obj]){
        NSError *error;
        NSData *dictionaryData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonListText = [[NSString alloc]initWithData:dictionaryData encoding:NSUTF8StringEncoding];
        
        return jsonListText;
    }
    return nil;
}

+ (NSString *)np_stringHanldToJsonObject:(id)obj{
    NSString *jsonListText = [self np_stringWithJsonObject:obj];
    jsonListText = [jsonListText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    jsonListText = [jsonListText stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonListText =  [jsonListText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonListText =  [jsonListText stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonListText;
}


///json反序列化方法
- (id)np_jsonObject{
    if(self.length){
        NSError *error;
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return obj;
    }
    return nil;
}

///读取本地的txt格式json数据 并解析返回字典
+ (id)np_jsonObjectWithFileName:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString * jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [jsonString np_jsonObject];
}

// json 字符转字典
+ (NSDictionary *)np_dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error)
    {
        NSLog(@"JSON解析失败");
        return nil;
    }
    return dict;
}

@end


#pragma mark -
#pragma mark - NPExtension
@implementation NSString (NPExtension)

+ (NSString *)np_UUID{
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0){
        return  [[NSUUID UUID] UUIDString];
        
    }else{
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        return (__bridge_transfer NSString *)uuid;
    }
}

- (BOOL)np_isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

+ (NSString *)np_moneyFormText:(NSString *)money{
    if ([money isKindOfClass:[NSString class]]) {
        return [money np_moneyFormat];
    }
    return @"0.00";
}

- (NSString *)np_moneyFormat{
    
    NSString *money = self;
    NSString *moneyStr = nil;
    if ([money isEqualToString:@""] || [money isEqualToString:@"."]) {
        moneyStr = @"0.00";
        return moneyStr;
    }
    
    //
    NSRange decimalRange = [money rangeOfString:@"."];
    
    if(decimalRange.location != NSNotFound){
        //假如有小数点，小数点后面最多两位
        if (decimalRange.location == 0) {
            moneyStr = [NSString stringWithFormat:@"0%@",money];
            
        }else if (money.length - decimalRange.location == 1){
            moneyStr = [NSString stringWithFormat:@"%@00",money];
            
        }else if (money.length - decimalRange.location == 2){
            moneyStr = [NSString stringWithFormat:@"%@0",money];
        }else{
            moneyStr = money;
        }
        
    }else{
        moneyStr = [NSString stringWithFormat:@"%@.00",money];
    }
    return moneyStr;
}

+ (BOOL)np_validateMoney:(NSString *)money {
    //    if ([money isEqualToString:@"0"]) {
    //        return YES;
    //    }
    //    if ([money isEqualToString:@"0.0"]) {
    //        return YES;
    //    }
    //    if ([money isEqualToString:@"0.00"]) {
    //        return YES;
    //    }
    
    NSString *reg1 = @"^[0-9]+\\.[0-9]{0,2}$";
    NSPredicate *pre1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg1];
    
    NSString *reg2 = @"^\\d+$";
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg2];
    
    NSString *reg3 = @"^0{2,}$";
    NSPredicate *pre3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg3];
    
    if (([pre1 evaluateWithObject:money] || [pre2 evaluateWithObject:money]) && (![pre3 evaluateWithObject:money])) {
        return YES;
    }
    
    return NO;
}

@end


