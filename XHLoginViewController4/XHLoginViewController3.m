//
//  XHLoginViewController3.m
//  XHLogin
//
//  Created by 曾 宪华 on 13-12-12.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHLoginViewController3.h"


@interface XHLoginViewController3 ()

@end

@implementation XHLoginViewController3

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
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/2.1, width/1.21, 41)];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.layer.cornerRadius = 3.0f;
    _usernameField.placeholder = @"一卡通号";
    _usernameField.font = [UIFont fontWithName:fontName size:16.0f];

    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"IDCard"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    _usernameField.leftViewMode = UITextFieldViewModeAlways;
    _usernameField.leftView = usernameIconContainer;
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/1.76, width/1.21, 41)];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.layer.cornerRadius = 3.0f;
    _passwordField.placeholder = @"一卡通密码";
    _passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.leftView = passwordIconContainer;
    
    
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake((width - width/1.3)/2, height/1.32, width/1.3, 41)];
    _loginButton.backgroundColor = darkColor;
    _loginButton.layer.cornerRadius = 3.0f;
    _loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake((width - width/1.3)/2, height/1.32, width/1.3, 41)];
    _logoutButton.backgroundColor = darkColor;
    _logoutButton.layer.cornerRadius = 3.0f;
    _logoutButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [_logoutButton setTitle:@"注销" forState:UIControlStateNormal];
    [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logoutButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - width/1.245)/2, height/7.1, width/1.245, height/12.62)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor =  [UIColor whiteColor];
    _titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    _titleLabel.text = @"欢迎使用先声";
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - width/1.21)/2, height/4.5, width/1.21, height/9.99)];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.backgroundColor = [UIColor clearColor];
    _subTitleLabel.textColor =  [UIColor whiteColor];
    _subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.font =  [UIFont fontWithName:boldFontName size:16.0f];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *count = [ud objectForKey:@"UUID"];
    if(count.length == 0){
        _subTitleLabel.text = @"请首先使用一卡通验证登陆\n新用户需要在\"个人资料\"中补全资料";
        [self.view addSubview:self.loginButton];
        [self.view addSubview:self.passwordField];
    }
    else{
        _subTitleLabel.text = @"您已登陆,欲注销请输入一卡通号";;
        [self.view addSubview:self.logoutButton];
    }
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subTitleLabel];
    [self.view addSubview:self.usernameField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
