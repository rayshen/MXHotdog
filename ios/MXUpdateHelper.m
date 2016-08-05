//
//  MXUpdateHelper.m
//  Knowme
//
//  Created by shenzw on 8/4/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "MXUpdateHelper.h"

@implementation MXUpdateHelper
+(void)checkUpdate:(FinishBlock)finish{
  NSString *url = @"http://szw.link/rnhotdog/versioninfo.php";
  NSMutableURLRequest *newRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
  [newRequest setHTTPMethod:@"GET"];
  [NSURLConnection sendAsynchronousRequest:newRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
    if(connectionError == nil){
      //请轻虐我的阿里云虚拟空间
      //请求自己服务器的API，判断当前的JS版本是否最新
      /*
       {
       "version":"1.0.5",
       "fileurl":"http://localhost:8888/RNBundle_1.0.1.zip",
       "message":"有新版本，请更新到我们最新的版本",
       "force:"NO"
       }
       */
      NSError *error;
      NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
      if(!error){
        //假设，这里需要做一个版本的存储
        NSString *curVersion = @"1.0.0";
        NSString *newVersion = jsonDic[@"version"];
        //一般情况下不一样，就是旧版本了
        //具体怎么做可以自己更详细实现，build版本，version等
        if(![curVersion isEqualToString:newVersion]){
          finish(1,jsonDic);
        }else{
          finish(0,nil);
        }
      }else{
        NSLog(@"json解析失败");
        finish(0,nil);
      }
    }
  }];
}
@end
