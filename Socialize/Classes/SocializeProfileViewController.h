//
//  ProfileViewController.h
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 9/26/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocializeFullUser.h"
#import "SocializeProfileEditViewController.h"
#import "_Socialize.h"

@class ImagesCache;
@class LoadingView;
@protocol SocializeProfileViewControllerDelegate;

@interface SocializeProfileViewController : UIViewController <UINavigationControllerDelegate, SocializeProfileEditViewControllerDelegate, SocializeServiceDelegate>
+ (UIViewController*)socializeProfileViewControllerWithDelegate:(id<SocializeProfileViewControllerDelegate>)delegate;
+ (UIViewController*)currentUserProfileWithDelegate:(id<SocializeProfileViewControllerDelegate>)delegate;
+ (UIViewController*)socializeProfileViewControllerForUser:(id<SocializeUser>)user delegate:(id<SocializeProfileViewControllerDelegate>)delegate;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, assign) id<SocializeProfileViewControllerDelegate> delegate;
@property (nonatomic, retain) id<SocializeUser> user;
@property (nonatomic, retain) id<SocializeFullUser> fullUser;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *userDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *userLocationLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *profileImageActivityIndicator;
@property (nonatomic, retain) SocializeProfileEditViewController *profileEditViewController;
@property (nonatomic, retain) LoadingView *loadingView;
@property (nonatomic, retain) Socialize *socialize;
@property (nonatomic, retain) UINavigationController *navigationControllerForEdit;
@property (nonatomic, retain) ImagesCache *imagesCache;
-(void)editVCSave:(id)button;
- (void)doneButtonPressed:(UIBarButtonItem*)button;
- (void)editButtonPressed:(UIBarButtonItem*)button;

@end

@protocol SocializeProfileViewControllerDelegate
- (void)profileViewControllerDidCancel:(SocializeProfileViewController*)profileViewController;
- (void)profileViewControllerDidSave:(SocializeProfileViewController*)profileViewController;
@end