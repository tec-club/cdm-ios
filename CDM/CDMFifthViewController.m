//
//  CDMFifthViewController.m
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import "CDMFifthViewController.h"

@interface CDMFifthViewController ()

@end

@implementation CDMFifthViewController
@synthesize listData;
@synthesize webView;
@synthesize backButton;
@synthesize goBack;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Students", @"Students");
        self.tabBarItem.image = [UIImage imageNamed:@"student.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView.hidden = YES;
    backButton.hidden = YES;
    goBack.enabled = NO;
    
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *array = [[NSArray alloc] initWithObjects:@"Trident", @"Spruce Mentality", @"Point Loma", @"Waxed Ham", nil];
    self.listData = array;
    

}

-(void)viewDidDisappear:(BOOL)animated {
    webView.hidden = YES;
    backButton.hidden = YES;
    goBack.enabled = NO;

    [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.listData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SimpleTableIdentifier];

    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    
    if (row == 0) {
        cell.detailTextLabel.text = @"Online Trident";
        //cell.detailTextLabel.textColor=[UIColor blackColor];
    }
    if (row == 1) {
        cell.detailTextLabel.text = @"Clothing";
        //cell.detailTextLabel.textColor=[UIColor blackColor];
    }
    if (row == 2) {
        cell.detailTextLabel.text = @"Band";
        //cell.detailTextLabel.textColor=[UIColor blackColor];
    }
    if (row == 3) {
        cell.detailTextLabel.text = @"Band";
        //cell.detailTextLabel.textColor=[UIColor blackColor];
    }
    
    return cell;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString *rowValue = [listData objectAtIndex:row];
    
    webView.hidden = NO;
    backButton.hidden = NO;
    goBack.enabled = YES;

    
    if ([rowValue isEqual: @"Trident"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tridentonline.net"]]];
    }
    if ([rowValue isEqual: @"Spruce Mentality"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sprucementality.com"]]];
    }
    if ([rowValue isEqual: @"Point Loma"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.facebook.com/pointlomatheband"]]];
    }
    if ([rowValue isEqual: @"Waxed Ham"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.facebook.com/WaxedHam"]]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)backButtonTap:(id)sender {
    
    webView.hidden = YES;
    backButton.hidden = YES;
    goBack.enabled = NO;

    [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
