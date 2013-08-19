//
//  RootViewController.h
//  ConnectT
//
//  Created by DougT on 1/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TiVoContainer.h"
#import "TiVoContainerLoader.h"
#import "TiVoServerLoader.h"
#import "ImageStore.h"

@interface RootViewController : UITableViewController {
    IBOutlet UITableView * tableView;
    UIActivityIndicatorView * activityIndicator;

    bool loading;
    TiVoServerLoader* tivoServerLoader;

    CGSize cellSize;
    
    NSMutableArray * tivoContainers;

    NSMutableArray * history;
    
    NSString * selectedIP;
    NSString * selectedPort;
    
    ImageStore* imageStore;

}

- (void) loadUrl: (NSString*) url with: (id) listener;

@end
