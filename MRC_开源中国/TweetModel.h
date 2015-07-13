//
//  TweetModel.h
//  MRC_开源中国
//
//  Created by 峰哥哥 on 15/5/29.
//  Copyright (c) 2015年 峰哥哥-.-. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetModel : NSObject
//MRC用retain，ARC用strong
@property(nonatomic,retain)NSString *body;
@property(nonatomic,retain)NSString *author;
@end
