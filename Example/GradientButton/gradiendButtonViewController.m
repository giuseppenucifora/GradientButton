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
    BOOL didUpdateConstraints;
    
}

@end

@implementation gradiendButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //button = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    button = [GradientButton newAutoLayoutView];
    //[button setCenter:self.view.center];
    [button setTitle:@"Prove" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setbackgroundLayerWithColors:@[[UIColor redColor],[UIColor blueColor]] startPoint:CGPointMake(0, 0)];
    
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) viewDidAppear:(BOOL)animated {
    
    
    NSLog(@"viewdidappear : %f %f %f %f",button.bounds.origin.x,button.bounds.origin.y,button.bounds.size.width,button.bounds.size.height);
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
     });*/
    
}

- (void) updateViewConstraints {
    if(!didUpdateConstraints) {
        
        [button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [button autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [button autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:40];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:40];
        [button autoSetDimension:ALDimensionHeight toSize:50];
        
        didUpdateConstraints = YES;
    }
    [super updateViewConstraints];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
