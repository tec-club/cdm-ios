//
//  CDMFirstViewController.h
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDMFirstViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *listData;
@property (nonatomic, retain) const NSString *savedUsername;
@property (nonatomic, retain) const NSString *savedPassword;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (strong, nonatomic) IBOutlet UIButton *setButton;


@end
