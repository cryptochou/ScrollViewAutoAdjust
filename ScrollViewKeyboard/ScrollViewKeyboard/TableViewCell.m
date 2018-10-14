//
//  TableViewCell.m
//  ScrollViewKeyboard
//
//  Created by zhouke on 2018/10/13.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()<UITextFieldDelegate>

@end

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    NSLog(@"textFieldShouldBeginEditing---%@", textField);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSLog(@"textFieldDidBeginEditing---%@", textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    NSLog(@"textFieldShouldEndEditing---%@", textField);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    NSLog(@"textFieldDidEndEditing---%@", textField);
}


@end
