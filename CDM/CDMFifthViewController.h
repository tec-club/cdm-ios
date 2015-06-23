//
//  CDMFifthViewController.h
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDMFifthViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *listData;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBack;


@end
