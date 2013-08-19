//
//  ImageViewController.h
//  DVR Pictures+
//
//  Created by DougT on 2/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStore.h"

@interface ImageViewController : UIViewController {
    IBOutlet UIScrollView * ourScrollView;
    
    id owner;
    ImageStore* imageStore;
    NSString* baseURL;
    NSMutableArray* containers;
}

-(void) setOwner: (id) owner;
-(void) setImageStore: (id) imageStore;
-(void) setBaseURL: (id) baseURL;


@end
