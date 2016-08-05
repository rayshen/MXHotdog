//
//  MXFileHelper.h
//  MXVersionManager
//
//  Created by shenzw on 8/4/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishBlock) (NSInteger status,id data);
@interface MXFileHelper : NSObject<NSURLSessionDelegate>
+(MXFileHelper*)shared;
-(void)downloadFileWithURLString:(NSString*)urlString finish:(FinishBlock)finish;
@end
