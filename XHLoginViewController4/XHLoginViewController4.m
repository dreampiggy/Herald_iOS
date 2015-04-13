//
//  XHLoginViewController4.m
//  XHLogin
//
//  Created by 曾 宪华 on 13-12-12.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHLoginViewController4.h"

@interface XHLoginViewController4 ()

@end

@implementation XHLoginViewController4

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int width = screenSize.width;
    int height = screenSize.height;
    
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    //用户图标
    UIImageView* userIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    userIconImage.image = [UIImage imageNamed:@"IDCard"];
    UIView* userIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    userIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [userIconContainer addSubview:userIconImage];
    
    //密码图标
    UIImageView* passwordIconImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage1.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer1 addSubview:passwordIconImage1];
    
    UIImageView* passwordIconImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage2.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer2 addSubview:passwordIconImage2];
    
    UIImageView* passwordIconImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage3.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer3 addSubview:passwordIconImage3];
    
    //图书馆账号
    _libraryUserField = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/3.0, width/1.21, 41)];
    _libraryUserField.backgroundColor = [UIColor whiteColor];
    _libraryUserField.layer.cornerRadius = 3.0f;
    _libraryUserField.placeholder = @"图书馆账号";
    _libraryUserField.font = [UIFont fontWithName:fontName size:16.0f];
    
    _libraryUserField.leftViewMode = UITextFieldViewModeAlways;
    _libraryUserField.leftView = userIconContainer;
    
    
    //图书馆密码
    _libraryPasswordFiled = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/2.25, width/1.21, 41)];
    _libraryPasswordFiled.backgroundColor = [UIColor whiteColor];
    _libraryPasswordFiled.layer.cornerRadius = 3.0f;
    _libraryPasswordFiled.placeholder = @"图书馆密码";
    _libraryPasswordFiled.secureTextEntry = true;
    _libraryPasswordFiled.font = [UIFont fontWithName:fontName size:16.0f];
    
    _libraryPasswordFiled.leftViewMode = UITextFieldViewModeAlways;
    _libraryPasswordFiled.leftView = passwordIconContainer1;
    
    //体育系密码
    _pePasswordField = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/1.80, width/1.21, 41)];
    _pePasswordField.backgroundColor = [UIColor whiteColor];
    _pePasswordField.layer.cornerRadius = 3.0f;
    _pePasswordField.placeholder = @"体育系密码";
    _pePasswordField.secureTextEntry = true;
    _pePasswordField.font = [UIFont fontWithName:fontName size:16.0f];
    
    _pePasswordField.leftViewMode = UITextFieldViewModeAlways;
    _pePasswordField.leftView = passwordIconContainer2;
    
    //一卡通密码
    _cardPasswordField = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/1.50, width/1.21, 41)];
    _cardPasswordField.backgroundColor = [UIColor whiteColor];
    _cardPasswordField.layer.cornerRadius = 3.0f;
    _cardPasswordField.placeholder = @"一卡通密码";
    _cardPasswordField.secureTextEntry = true;
    _cardPasswordField.font = [UIFont fontWithName:fontName size:16.0f];
    
    _cardPasswordField.leftViewMode = UITextFieldViewModeAlways;
    _cardPasswordField.leftView = passwordIconContainer3;
    
    //提交按钮
    _submitButton = [[UIButton alloc] initWithFrame:CGRectMake((width - width/1.3)/2, height/1.12, width/1.3, 41)];
    _submitButton.backgroundColor = darkColor;
    _submitButton.layer.cornerRadius = 3.0f;
    _submitButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - width/1.245)/2, height/7.1, width/1.245, height/6.31)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor =  [UIColor whiteColor];
    _titleLabel.font =  [UIFont fontWithName:boldFontName size:18.0f];
    _titleLabel.text = @"图书馆账号，图书馆密码及体育系密码默认均为一卡通号";
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.pePasswordField];
    [self.view addSubview:self.cardPasswordField];
    [self.view addSubview:self.libraryUserField];
    [self.view addSubview:self.libraryPasswordFiled];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
