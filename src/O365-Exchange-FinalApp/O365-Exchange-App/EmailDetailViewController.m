//
//  EmailDetailViewController.m
//  O365-Exchange-App
//
//  Created by Lucas Damian Napoli on 28/10/14.
//  Copyright (c) 2014 MS Open Tech. All rights reserved.
//

#import "EmailDetailViewController.h"

@interface EmailDetailViewController ()

@end

@implementation EmailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.tintColor = [UIColor colorWithRed:13.0/255.0 green:92.0/255.0 blue:173.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:13.0/255.0 green:92.0/255.0 blue:173.0/255.0 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.author.text = self.currentMsg.From.EmailAddress.Name;
    self.subject.text = self.currentMsg.Subject;
    
    /*
     self.emailBody.numberOfLines = 0;
    [self.emailBody sizeToFit];
    self.emailBody.text = self.currentMsg.Body.Content;
    */
    [self.emailBody loadHTMLString:self.currentMsg.Body.Content  baseURL: nil];

    NSDate *msgDate = self.currentMsg.DateTimeSent;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    self.date.text = [formatter stringFromDate:msgDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
