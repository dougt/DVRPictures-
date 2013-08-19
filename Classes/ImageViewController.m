//
//  ImageViewController.m
//  DVR Pictures+
//
//  Created by DougT on 2/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "TiVoContainer.h"

@implementation ImageViewController

const int kTagOffset = 100;

const CGFloat kScrollObjHeight	= 320;
const CGFloat kScrollObjWidth	= 480;


-(void) setBaseURL: (id) url
{
    baseURL = [url copy];
}

-(void) setImageStore: (id) store
{
    imageStore = store;
    imageStore.delegate = self;
}

- (void)layoutScrollImages: (int) numberOfImages
{
	UIImageView *view = nil;
	NSArray *subviews = [ourScrollView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[ourScrollView setContentSize:CGSizeMake((numberOfImages * kScrollObjWidth), [ourScrollView bounds].size.height)];
}


- (void) tivoContaierTitleUpdated: (NSString*) title {    
}

- (void) updateImage: (NSString*) url newImage: (UIImage*) image
{
    for (int i = 0; i < [containers count]; i++)
    {
        NSString* str = [baseURL stringByAppendingString: [[containers objectAtIndex: i] getURL]];
        str = [str stringByAppendingString: @"?Width=320&Height=480&Format=image/jpeg"];
        
        if ([str isEqualToString: url])
        {
            UIImageView* v = (UIImageView*) [self.view viewWithTag: kTagOffset+i];
            v.image = image;
            return;
        }
    }
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url
{
    [self updateImage: url newImage: [sender getImage:url]];
}

- (void) tivoContainerUpdated: (NSMutableArray *) arr {

    containers = arr;
    [containers retain];
    
     for (int i = 0; i < [arr count] && i < 10; i++)
     {
         NSString* str = [baseURL stringByAppendingString: [[arr objectAtIndex: i] getURL]];
         str = [str stringByAppendingString: @"?Width=320&Height=480&Format=image/jpeg"];
         printf("Image: %s\n", [str UTF8String]);

         [imageStore getImage:str];
         
         //UIImageView *imageView = [[UIImageView alloc] initWithImage:];
         UIImage *image = [UIImage imageNamed:@"favorites-57x57.png"];
         UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
         // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
         CGRect rect = imageView.frame;
         rect.size.height = kScrollObjHeight;
         rect.size.width = kScrollObjWidth;
         imageView.frame = rect;
         imageView.tag = kTagOffset+i;	// tag our images for later use when we place them in serial fashion
         [ourScrollView addSubview:imageView];
         [imageView release];
     }

    [self layoutScrollImages: [arr count]];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    [ourScrollView setBackgroundColor:[UIColor blackColor]];
    [ourScrollView setCanCancelContentTouches:NO];
    ourScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    ourScrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
    ourScrollView.scrollEnabled = YES;
    
    // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
    // if you want free-flowing scroll, don't set this property.
    ourScrollView.pagingEnabled = YES;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
    [baseURL release];
    imageStore.delegate = owner;
    [containers release];


}

-(void) setOwner: (id) o
{
    owner = o;    
}


@end
