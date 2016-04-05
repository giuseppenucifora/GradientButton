//
//  gradiendButtonViewController.m
//  GradientButton
//
//  Created by Giuseppe Nucifora on 01/11/2016.
//  Copyright (c) 2016 Giuseppe Nucifora. All rights reserved.
//

#import "gradiendButtonViewController.h"
#import "GradientButton.h"
#import "PureLayout/PureLayout.h"


@interface gradiendButtonViewController () {
    
    GradientButton *button;
    GradientButton *autoLayoutButton;
    BOOL didUpdateConstraints;
    
    UIButton *presentControllerButton;
}

@end

@implementation gradiendButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    button = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [button setCenter:self.view.center];
    [button setTitle:@"Normal Button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setbackgroundLayerWithColors:@[[UIColor greenColor],[UIColor whiteColor],[UIColor redColor]] startPoint:CGPointMake(0, 0)];
    
    [self.view addSubview:button];
    
    autoLayoutButton = [GradientButton newAutoLayoutView];
    
    [autoLayoutButton setTitle:@"Autolayout Button" forState:UIControlStateNormal];
    [autoLayoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [autoLayoutButton setbackgroundLayerWithColors:@[[UIColor greenColor],[UIColor whiteColor],[UIColor redColor]] startPoint:CGPointMake(0, 1)];
    
    [self.view addSubview:autoLayoutButton];
    
    presentControllerButton = [UIButton newAutoLayoutView];
    [presentControllerButton setTitle:@"Presenta Conttoller" forState:UIControlStateNormal];
    [presentControllerButton addTarget:self action:@selector(presentAction:) forControlEvents:UIControlEventTouchUpInside];
    [presentControllerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:presentControllerButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) viewDidAppear:(BOOL)animated {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [button setbackgroundLayerWithColors:@[[UIColor redColor],[UIColor blueColor], [UIColor redColor], [UIColor greenColor]] startPoint:CGPointMake(0, 1)];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect rect = button.frame;
        
        rect.size.height = 70;
        rect.size.width = 240;
        
        [button setFrame:rect];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [button.layer setCornerRadius:4];
        [button.layer setMasksToBounds:YES];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [button setbackgroundLayerWithColors:@[[UIColor whiteColor],[UIColor blueColor], [UIColor blackColor], [UIColor greenColor]] startPoint:CGPointMake(1, 0)];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect rect = button.bounds;
        
        rect.size.height = 50;
        rect.size.width = 120;
        
        [button setBounds:rect];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [button.layer setCornerRadius:25];
        [button.layer setMasksToBounds:YES];
    });
    
}

- (void) updateViewConstraints {
    if(!didUpdateConstraints) {
        
        [autoLayoutButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [autoLayoutButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:40];
        [autoLayoutButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:40];
        [autoLayoutButton autoSetDimension:ALDimensionHeight toSize:50];
        
        [presentControllerButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:autoLayoutButton];
        [presentControllerButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:autoLayoutButton];
        [presentControllerButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:autoLayoutButton];
        [presentControllerButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        didUpdateConstraints = YES;
    }
    [super updateViewConstraints];
}

- (void) presentAction:(UIButton *) sender {
    gradiendButtonViewController *viewController = [[gradiendButtonViewController alloc] init];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [viewController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
