//
//  ViewController.h
//  iOS9_全新获取联系人01
//
//  Created by 高宇 on 16/6/28.
//  Copyright © 2016年 高宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (strong, nonatomic) NSMutableArray *listData;

@end

