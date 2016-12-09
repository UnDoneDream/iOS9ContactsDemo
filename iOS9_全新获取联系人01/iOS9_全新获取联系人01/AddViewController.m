//
//  AddViewController.m
//  iOS9_全新获取联系人01
//
//  Created by 高宇 on 16/6/28.
//  Copyright © 2016年 高宇. All rights reserved.
//

#import "AddViewController.h"
#import <Contacts/Contacts.h>

@interface AddViewController ()
- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *homePhoneField;
@property (weak, nonatomic) IBOutlet UITextField *IPhoneField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Save:(id)sender {
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    contact.givenName = self.firstNameField.text;
    contact.familyName = self.lastNameField.text;
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberHomeFax value:[CNPhoneNumber phoneNumberWithStringValue:self.homePhoneField.text]], [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.IPhoneField.text]]];
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:request error:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
