#import "ViewController.h"
#import <office365_exchange_sdk/office365_exchange_sdk.h>

@interface FolderListViewController : ViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSString *token;
@property (strong, nonatomic) MSOutlookClient *client;
@property (weak, nonatomic) MSOutlookFolder* currentFolder;
@end
