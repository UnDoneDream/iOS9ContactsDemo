//
//  DetailViewController.h
//  iOS9_全新获取联系人01
//
//  Created by 高宇 on 16/6/28.
//  Copyright © 2016年 高宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNContact;
@interface DetailViewController : UIViewController

@property (strong, nonatomic,readwrite) CNContact *contact;

@end
