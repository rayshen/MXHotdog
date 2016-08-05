//
//  MXFileHelper.m
//  MXVersionManager
//
//  Created by shenzw on 8/4/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "MXFileHelper.h"

@implementation MXFileHelper
+(MXFileHelper*)shared{
  static MXFileHelper *sharedMyManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyManager = [[[self class] alloc] init];
  });
  return sharedMyManager;
}

-(void)downloadFileWithURLString:(NSString*)urlString finish:(FinishBlock)finish{
  NSLog(@"download with url:%@",urlString);
  NSURL * url = [NSURL URLWithString:urlString];
  NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
  NSURLSessionDownloadTask * downloadTask =[defaultSession downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
  {
    if(error == nil)
    {
      NSLog(@"Temporary file =%@",location);
      NSError *err = nil;
      NSFileManager *fileManager = [NSFileManager defaultManager];
      NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
      NSString *filePath = [NSString stringWithFormat:@"%@/\%@",docsDir,@"bundle.zip"];
      NSURL *docsDirURL = [NSURL fileURLWithPath:filePath];
      if([fileManager fileExistsAtPath:filePath]){
        [fileManager removeItemAtURL:docsDirURL error:nil];
      }
      if ([fileManager moveItemAtURL:location
                               toURL:docsDirURL
                               error: &err])
      {
        NSLog(@"File is saved to =%@",docsDirURL.absoluteString);
        finish(1,filePath);
      }
      else
      {
        NSLog(@"failed to move: %@",[err userInfo]);
        finish(0,nil);
      }
    }
  }];
  [downloadTask resume];
}
@end
