//
//  CDMFirstViewController.m
//  CDM
//
//  Created by Trey Fortmuller on 7/21/13.
//  Copyright (c) 2013 Trey Fortmuller. All rights reserved.
//

#import "CDMFirstViewController.h"

@interface CDMFirstViewController ()

@end

@implementation CDMFirstViewController
@synthesize listData;
@synthesize webView;
@synthesize backButton;
@synthesize goBack;
@synthesize setButton;
@synthesize savedUsername;
@synthesize savedPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Resources", @"Resources");
        self.tabBarItem.image = [UIImage imageNamed:@"home.png"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasAlreadyBeenLaunched = [defaults boolForKey:@"HasAlreadyBeenLaunched"];
    
    if (!hasAlreadyBeenLaunched) {
        [defaults setBool:YES forKey:@"HasAlreadyBeenLaunched"];
        [defaults synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"School Loop Login"
                                                        message:@"If you would like the CDM App to remember your login, enter it now."
                                                       delegate:self
                                              cancelButtonTitle:@"Skip"
                                              otherButtonTitles:@"Save", nil];
        [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [alert show];
        
    }
    
    webView.hidden = YES;
    backButton.hidden = YES;
    goBack.enabled = NO;

    
    NSArray *array = [[NSArray alloc] initWithObjects:@"School Loop", @"Bell Schedule", @"Calendar", @"Handbook", @"Webstore", nil];
    self.listData = array;
}

- (IBAction)setButtonPress:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"School Loop Login"
                                                    message:@"If you would like the CDM App to remember your login, enter it now."
                                                   delegate:self
                                          cancelButtonTitle:@"Skip"
                                          otherButtonTitles:@"Save", nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [alert show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    
    NSString *inputUser = [[alertView textFieldAtIndex:0] text];
    NSString *inputPass = [[alertView textFieldAtIndex:1] text];
    
    savedUsername = inputUser;
    savedPassword = inputPass;
    
    //NSLog(@"%@", savedUsername);
    //NSLog(@"%@", savedPassword);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:savedUsername forKey:@"userName"];
    [defaults setObject:savedPassword forKey:@"passWord"];
    
    if( [inputUser length] >=1 && [inputPass length] >=6 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        savedUsername = nil;
        savedPassword = nil;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cdm.schoolloop.com/mobile/index"]]];
    }
    else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cdm.schoolloop.com/mobile/index"]]];
    }
}

- (BOOL)webView:(UIWebView *)homeview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //NSLog(@"The if was called");
    
    NSString *URLString = [[request URL] absoluteString];
    if ([URLString isEqualToString:@"https://cdm.schoolloop.com/portal/login"] || [URLString isEqualToString:@"https://cdm.schoolloop.com/"]){
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cdm.schoolloop.com/mobile/index"]]];
        
         //NSLog(@"The if was called");
    }
    /*
    if ([URLString isEqualToString:@"https://cdm.schoolloop.com/mobile/index"]) {
        setButton.hidden = NO;
    }
    */
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if(([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] != nil) && ([[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"] != nil)) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *fillUser = [defaults objectForKey:@"userName"];
        NSString *fillPass = [defaults objectForKey:@"passWord"];
        
        //create js strings
        NSString *loadUsernameJS = [NSString stringWithFormat:@"var inputFields = document.querySelectorAll(\"input[type='text']\"); \
                                    for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '%@';}", fillUser];
        NSString *loadPasswordJS = [NSString stringWithFormat:@"var passFields = document.querySelectorAll(\"input[type='password']\"); for (var i = passFields.length>>> 0; i--;) { passFields[i].value ='%@';}", fillPass];
        
        //autofill the form
        [self.webView stringByEvaluatingJavaScriptFromString: loadUsernameJS];
        [self.webView stringByEvaluatingJavaScriptFromString: loadPasswordJS];
    }
    
    /*
     NSURLRequest *currentRequest = [webView request];
     NSURL *currentURL = [currentRequest URL];
     NSLog(@"Current URL is %@", currentURL.absoluteString);
     */
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
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    
    return cell;
}    

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString *rowValue = [listData objectAtIndex:row];
    
    if ([rowValue isEqual: @"School Loop"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cdm.schoolloop.com/mobile/index"]]];
        setButton.hidden = NO;
        
        if (savedUsername.length != 0 && savedPassword.length != 0) {
            //create js strings
            NSString *loadUsernameJS = [NSString stringWithFormat:@"var inputFields = document.querySelectorAll(\"input[type='text']\"); \
                                        for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '%@';}", savedUsername];
            NSString *loadPasswordJS = [NSString stringWithFormat:@"var passFields = document.querySelectorAll(\"input[type='password']\"); for (var i = passFields.length>>> 0; i--;) { passFields[i].value ='%@';}", savedPassword];
            
            //autofill the form
            [self.webView stringByEvaluatingJavaScriptFromString: loadUsernameJS];
            [self.webView stringByEvaluatingJavaScriptFromString: loadPasswordJS];
        }
    }
    if ([rowValue isEqual: @"Bell Schedule"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://treyfortmuller.com/me/bells.pdf"]]];
    }
    if ([rowValue isEqual: @"Calendar"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://treyfortmuller.com/me/calendar.pdf"]]];
    }
    if ([rowValue isEqual: @"Handbook"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://treyfortmuller.com/me/handbook.pdf"]]];
    }
    if ([rowValue isEqual: @"Webstore"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://webstores.activenetwork.com/school-software/corona_del_mar_higu3/index.php#.Uex2ZxZNDZQ"]]];
    }
    
    webView.hidden = NO;
    backButton.hidden = NO;
    goBack.enabled = YES;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)backButtonTap:(id)sender {
    
    webView.hidden = YES;
    backButton.hidden = YES;
    goBack.enabled = NO;
    setButton.hidden = YES;
    
    [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
