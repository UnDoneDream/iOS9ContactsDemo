//
//  ViewController.m
//  iOS9_全新获取联系人01
//
//  Created by 高宇 on 16/6/28.
//  Copyright © 2016年 高宇. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <Contacts/Contacts.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getContactData];
}

- (NSMutableArray *)listData
{
    if (_listData == nil) {
        _listData = [NSMutableArray array];
    }
    return _listData;
}


//获取联系人信息，并赋值给listData数组中
- (void)getContactData
{
    /**CNAuthorizationStatusNotDetermined 未授权
       CNAuthorizationStatusAuthorized    已授权
     */
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        CNContactStore *stroe = [[CNContactStore alloc] init];
        [stroe requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [self.listData removeAllObjects];
                CNContactStore *stroe = [[CNContactStore alloc] init];
                NSArray *keys = @[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey];
                CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                [stroe enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    [self.listData addObject:contact];
//                    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
                    [_tableView reloadData];
                    
                }];
            }else{
            }
        }];
    }
}


- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNContact *contact = self.listData[indexPath.row];
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",givenName,familyName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNContact *contact = self.listData[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.contact = contact;
    [self.navigationController pushViewController:detail animated:YES];
    
}

/**
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CNContactPickerViewController *vc = [[CNContactPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSLog(@"contact = %@",contact);
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    NSLog(@"contactProperty = %@",contactProperty);
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts
{
//    NSLog(@"contacts = %@",contacts);
    for (CNContact *contact in contacts) {
//        CNPhoneNumber *phoneNumber = [contacts]
        for (CNLabeledValue *value in contact.phoneNumbers) {
            CNPhoneNumber *phoneNumber = value.value;
            NSLog(@"value= %@,phoneNumber = %@",value,phoneNumber.stringValue);
        }
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties
{
    NSLog(@"contactProperties = %@",contactProperties);
}
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
