#import "JGProfileViewController.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
@interface JGProfileViewController ()
@property (nonatomic,strong) UINavigationController *navController;

@end
@implementation JGProfileViewController
@synthesize backgroundImageView,profileImageView,userTitle,userEventCount,userGroupCount,userPhotoCount,userAttentanceCount,introduction,scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [super viewDidLayoutSubviews];
    self.navController = [[UINavigationController alloc] init];
    [self.logoutButton setBackgroundImage:[UIImage imageNamed:@"Logout.png"] forState:UIControlStateNormal];
    [[userGroupCount layer] setBorderColor:[[UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70] CGColor]];
    [[userGroupCount layer] setCornerRadius:10.0];
    [userGroupCount setClipsToBounds:YES];
    [[userGroupCount layer] setBorderWidth:2.5];
    [[userEventCount layer] setBorderColor:[[UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70] CGColor]];
    [[userEventCount layer] setCornerRadius:10.0];
    [userEventCount setClipsToBounds:YES];
    [[userEventCount layer] setBorderWidth:2.5];
    [[userAttentanceCount layer] setBorderColor:[[UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70] CGColor]];
    [[userAttentanceCount layer] setCornerRadius:10.0];
    [userAttentanceCount setClipsToBounds:YES];
    [[userAttentanceCount layer] setBorderWidth:2.5];
    [[userPhotoCount layer] setBorderColor:[[UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70] CGColor]];
    [[userPhotoCount layer] setCornerRadius:10.0];
    [userPhotoCount setClipsToBounds:YES];
    [[userPhotoCount layer] setBorderWidth:2.5];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(450, 100)];
}

-(void)viewDidAppear:(BOOL)animated{

    [self.view addSubview:self.scrollView];
    [super viewDidLayoutSubviews];
    PFObject *user = [PFUser currentUser];
    [self.userTitle setText:[user objectForKey:@"username"]];
    PFRelation *membershipRelation = [user relationforKey:@"Membership"];
    PFQuery *queryGroup = [membershipRelation query];
    [queryGroup findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        NSString *groupCount =[NSString stringWithFormat:@"%d\n Groups", [results count]];
        [userGroupCount setText:groupCount];
        [introduction setText:[user objectForKey:@"Introduction"]];
        
    }];
    PFRelation *eventRelation = [user relationforKey:@"inEvent"];
    PFQuery *queryEvent = [eventRelation query];
    [queryEvent findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        NSString *eventCount =[NSString stringWithFormat:@"%d\n Events", [results count]];
        [userEventCount setText:eventCount];
        
    }];
    
    PFRelation *attentanceRelation = [user relationforKey:@"verifiedEvent"];
    PFQuery *queryAttentance = [attentanceRelation query];
    [queryAttentance findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        NSString *eventCount =[NSString stringWithFormat:@"%d\n Attentence", [results count]];
        [userAttentanceCount setText:eventCount];
    }];
  
    PFRelation *profilePhotoRelation = [user relationforKey:@"ProfilePhoto"];
    PFQuery *queryPhoto = [profilePhotoRelation query];
    [queryPhoto addDescendingOrder:@"addedDate"];
    [queryPhoto findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        // results contains photo for the group
        // NSLog(@"there are %d photos for the group", [results count]);
        if (!error && [results count] != 0) {
            
            // At this point, object has been downloaded, but the PFFile was not included
            
            //Find the photo object and it's Thumbnail
            
            PFObject *photoObject = [results objectAtIndex: 0];
            PFFile *imageFile = [photoObject objectForKey:@"ThumbnailFile"];
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                //   if (!error) {
                //reform the image by the image data in Parse
                UIImage *image = [UIImage imageWithData:data];
                [profileImageView setImage:image];
                [profileImageView setNeedsDisplay];
                [[profileImageView layer] setBorderColor:[[UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:1] CGColor]];
                [[profileImageView layer] setBorderWidth:2.0];
                [[profileImageView layer] setCornerRadius:10.0];
                [profileImageView setClipsToBounds:YES];
                for (int photoInedx = 1; photoInedx < [results count]; photoInedx++) {
                    PFObject *oldPhoto = [results objectAtIndex:photoInedx];
                    [oldPhoto deleteInBackground];
                }
                
            }];
        }
    }];
    PFRelation *userPhotoRelation = [user relationforKey:@"Photos"];
    PFQuery *queryUserPhotos = [userPhotoRelation query];
  [queryUserPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      NSString *photoCount =[NSString stringWithFormat:@"%d\n Photos",[objects count]];
      [userPhotoCount setText:photoCount];  }];
    
}
- (IBAction)logOut:(id)sender {
    if ([PFUser currentUser]) {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"LogInAgain" sender:self];
    }
}

- (IBAction) profileDone:(UIStoryboardSegue *)segue
{
}

- (IBAction)profileCancel:(UIStoryboardSegue *)segue
{
}
-(IBAction)goToGroup:(id)sender{
    [self performSegueWithIdentifier:@"GoToGroups" sender:self];
}

- (IBAction)upload:(id)sender {
    
        BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];

    if (cameraDeviceAvailable && photoLibraryAvailable) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
                [actionSheet showFromTabBar:self.tabBarController.tabBar];
            } else {
                // if we don't have at least two options, we automatically show whichever is available (camera or roll)
                [self shouldPresentPhotoCaptureController];
            }
}

-(IBAction)editProfileDetails:(id)sender{
    
}

- (BOOL)shouldStartCameraController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentModalViewController:cameraUI animated:YES];
    
    return YES;
}


- (BOOL)shouldStartPhotoLibraryPickerController {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
               && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    
    [self presentModalViewController:cameraUI animated:YES];
    
    return YES;
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissModalViewControllerAnimated:NO];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    JGProfilePictureEditViewController *viewController = [[JGProfilePictureEditViewController alloc] initWithImage:image];

    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self.navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navController pushViewController:viewController animated:NO];
    
    [self presentModalViewController:self.navController animated:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self shouldStartCameraController];
    } else if (buttonIndex == 1) {
        [self shouldStartPhotoLibraryPickerController];
    }
}

#pragma mark -

- (BOOL)shouldPresentPhotoCaptureController {
    BOOL presentedPhotoCaptureController = [self shouldStartCameraController];
    
    if (!presentedPhotoCaptureController) {
        presentedPhotoCaptureController = [self shouldStartPhotoLibraryPickerController];
    }
    
    return presentedPhotoCaptureController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
