//
//  CDMFourthViewController.m
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import "CDMFourthViewController.h"

@interface CDMFourthViewController ()

@end

@implementation CDMFourthViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Webpage", @"Webpage");
        self.tabBarItem.image = [UIImage imageNamed:@"safari.png"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cdm.nmusd.us"]]];
}

 
- (IBAction)goHome:(id)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cdm.nmusd.us"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
