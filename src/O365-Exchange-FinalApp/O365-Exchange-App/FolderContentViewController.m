#import "FolderContentViewController.h"
#import "FileListCellTableViewCell.h"
#import "EmailDetailViewController.h"
#import <office365_exchange_sdk/office365_exchange_sdk.h>

@interface FolderContentViewController ()

@end

@implementation FolderContentViewController

NSArray<MSOutlookMessage> *folderMessages;

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
    self.folderName.text = self.currentFolder.DisplayName;   

}

-(void) viewDidAppear:(BOOL)animated{
    self.currentMsg = nil;
    [self getFolderContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [folderMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* identifier = @"msgListCell";
    FileListCellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier: identifier ];
    
    MSOutlookMessage *msg = [folderMessages objectAtIndex:indexPath.row];
    
    cell.title.text = msg.From.EmailAddress.Name;

    cell.subtitle.text = [msg.BodyPreview substringToIndex:30];
    
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    EmailDetailViewController *controller = (EmailDetailViewController *)segue.destinationViewController;
    controller.currentMsg = self.currentMsg;
    controller.token = self.token;
    controller.client = self.client;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentMsg= [folderMessages objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"msgDetail" sender:self];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return ([identifier isEqualToString:@"msgDetail"] && self.currentMsg);
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void) getFolderContent{
    double x = ((self.navigationController.view.frame.size.width) - 20)/ 2;
    double y = ((self.navigationController.view.frame.size.height) - 150)/ 2;
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(x, y, 20, 20)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:spinner];
    spinner.hidesWhenStopped = YES;
    [spinner startAnimating];
    
    NSURLSessionTask* task = [[[[[self.client getMe] getFolders] getById:self.currentFolder.Id] getMessages] read:^(NSArray<MSOutlookMessage> *resultMessages, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [spinner stopAnimating];
                           folderMessages = resultMessages;
                           [self.tableView reloadData];
                       });
        
    }];
    
    [task resume];
}



@end
