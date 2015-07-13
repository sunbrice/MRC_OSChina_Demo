//
//  TweetModel.m
//  MRC_开源中国
//
//  Created by 峰哥哥 on 15/5/29.
//  Copyright (c) 2015年 峰哥哥-.-. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel
-(void)setAuthor:(NSString *)author
{
    if(_author!=author)
    {
        [_author release];
        _author=[author retain];
    }
}
-(void)setBody:(NSString *)body
{
    if(_body!=body)
    {
        [_body release];
        _body=[body retain];
    }
}
@end
