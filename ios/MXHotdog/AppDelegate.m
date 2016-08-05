/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "AppDelegate.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"
#import "MXBundleHelper.h"
#import "MXUpdateHelper.h"
#import "MXFileHelper.h"
#import "SSZipArchive.h"
@interface AppDelegate()<UIAlertViewDelegate>
@property (nonatomic,strong) RCTBridge *bridge;
@property (nonatomic,strong) NSDictionary *versionDic;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  
  NSURL *jsCodeLocation;
  jsCodeLocation = [MXBundleHelper getBundlePath];
  
  _bridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation
                                  moduleProvider:nil
                                   launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge moduleName:@"MXVersionManager" initialProperties:nil];
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  
  [self.window makeKeyAndVisible];
  
  
  __weak AppDelegate *weakself = self;
  //更新检测
  [MXUpdateHelper checkUpdate:^(NSInteger status, id data) {
    if(status == 1){
      weakself.versionDic = data;
      /*
       这里具体关乎用户体验的方式就多种多样了，比如自动立即更新，弹框立即更新，自动下载下次打开再更新等。
       */
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:data[@"message"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在更新", nil];
      [alert show];
      //进行下载，并更新
      //下载完，覆盖JS和assets，并reload界面
      //      [weakself.bridge reload];
    }
  }];
  return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  if(buttonIndex == 1){
    //更新
    [[MXFileHelper shared] downloadFileWithURLString:_versionDic[@"fileurl"] finish:^(NSInteger status, id data) {
      if(status == 1){
        NSLog(@"下载完成");
        NSError *error;
        NSString *filePath = (NSString *)data;
        NSString *desPath = [NSString stringWithFormat:@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
        [SSZipArchive unzipFileAtPath:filePath toDestination:desPath overwrite:YES password:nil error:&error];
        if(!error){
          NSLog(@"解压成功");
          [_bridge reload];
        }else{
          NSLog(@"解压失败");
        }
      }
    }];
  }
}
@end

