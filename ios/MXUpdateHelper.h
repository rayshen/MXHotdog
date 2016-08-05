//
//  MXUpdateHelper.h
//  Knowme
//
//  Created by shenzw on 8/4/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishBlock) (NSInteger status,id data);

@interface MXUpdateHelper : NSObject
+(void)checkUpdate:(FinishBlock)finish;
@end
