//
//  CDMSecondViewController.m
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import "CDMSecondViewController.h"

@interface CDMSecondViewController ()

@end

@implementation CDMSecondViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Twitter", @"Twitter");
        self.tabBarItem.image = [UIImage imageNamed:@"twitter.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile.twitter.com/CdMASB"]]];
}


- (IBAction)goHome:(id)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile.twitter.com/CdMASB"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
