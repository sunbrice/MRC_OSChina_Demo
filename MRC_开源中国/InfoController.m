
//
//  InfoController.m
//  MRC_开源中国
//
//  Created by 峰哥哥 on 15/5/29.
//  Copyright (c) 2015年 峰哥哥-.-. All rights reserved.
//

#import "InfoController.h"
#import "TweetModel.h"
#import "GDataXMLNode.h"


@interface InfoController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    UITableView *_tbView;
    NSMutableArray *_dataArray;
    NSMutableData *_receivedData;
}
@end

@implementation InfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[[NSMutableArray alloc]init];
    /*在MRC下，成员变量不能用类方法创建，若要创建，记得retain一次*/
//    _dataArray=[NSMutableArray array];
//    [_dataArray retain];
    _receivedData=[[NSMutableData alloc]init];
    
    _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 455) style:UITableViewStylePlain];
    _tbView.delegate=self;
    _tbView.dataSource=self;
    [self.view addSubview:_tbView];
    
    [self downloadData];
}
-(void)downloadData
{
//    http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=0&pageSize=20
    NSURL *url=[NSURL URLWithString:@"http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=0&pageSize=20"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    /*NSURLConnection *coon=*/[NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    开始XML解析
    GDataXMLDocument *doc=[[GDataXMLDocument alloc]initWithData:_receivedData options:0 error:nil];
    GDataXMLElement *root=[doc rootElement];
    NSArray *array=[root nodesForXPath:@"//tweet" error:nil];
    for(GDataXMLElement *element in array)
    {
        TweetModel *model=[[TweetModel alloc]init];
        model.author=[[[element nodesForXPath:@"./author" error:nil]lastObject]stringValue];
        model.body=[[[element nodesForXPath:@"./body" error:nil]lastObject]stringValue];
        [_dataArray addObject:model];
//        释放model对象
        [model release];
    }
//    释放doc对象
    [doc release];
    
    [_tbView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedCellID=@"reuseID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusedCellID];
    if(!cell)
    {
//        cell不能马上释放，就发送autorelease消息
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusedCellID]autorelease];
    }
    TweetModel *model=_dataArray[indexPath.row];
    cell.textLabel.text=model.author;
    cell.detailTextLabel.text=model.body;
    
    return cell;
}
//dealloc不一定立即执行
-(void)dealloc
{
//    释放成员变量
    [_dataArray release];
    [_receivedData release];
    _tbView.delegate=nil;
    _tbView.dataSource=nil;
    [_tbView release];
//    调用父类的dealloc
    [super dealloc];
}
@end
