//
//  ButtonExampleViewController.m
//  Socialize
//
//  Created by Nathaniel Griswold on 6/24/12.
//  Copyright (c) 2012 Socialize. All rights reserved.
//

#import "ButtonExampleViewController.h"

@interface ButtonExampleViewController ()
@end

static CGRect likeFrame = { 240.f, 120.f, 0.f, 0.f };
static CGRect commentFrame = { 190.f, 120.f, 0.f, 0.f };

@implementation ButtonExampleViewController
@synthesize likeButton = _likeButton;
@synthesize commentButton = _commentButton;
@synthesize entity = _entity;

- (id)initWithEntity:(id)entity {
    if (self = [super init]) {
        self.entity = entity;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        self.likeButton = [[SZLikeButton alloc] initWithFrame:likeFrame entity:self.entity viewController:self];
        self.commentButton = [[SZCommentButton alloc] initWithFrame:commentFrame entity:self.entity viewController:self];
        [self.view addSubview:self.likeButton];
        [self.view addSubview:self.commentButton];
    });
}

@end