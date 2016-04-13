//
//  GradientButton.m
//  Pods
//
//  Created by Giuseppe Nucifora on 11/01/16.
//
//

#import "GradientButton.h"
#import "PureLayout.h"
#import <RZDataBinding/RZDataBinding.h>

@interface GradientButton()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *cgColors;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) BOOL didUpdateConstraints;

@end

@implementation GradientButton


- (instancetype) init {
    self = [super init];
    if (self) {
        
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        
        [self rz_addTarget:self action:@selector(valueChanged:) forKeyPathChange:@"bounds"];
    }
    return self;
}

- (void) setbackgroundLayerWithColors:(NSArray *) colors startPoint:(CGPoint) startPoint {
    if (colors && [colors count] > 0) {
        _colors = [[NSMutableArray alloc] initWithArray:colors];
        [_cgColors removeAllObjects];
        
        for (UIColor *color in colors) {
            [_cgColors addObject:(id)color.CGColor];
        }
        
        _startPoint = startPoint;
        
        //[_gradientLayer removeFromSuperlayer];
        if (!_gradientLayer) {
            _gradientLayer = [CAGradientLayer layer];
        }
        
        _gradientLayer.colors = _cgColors;
        if (self.translatesAutoresizingMaskIntoConstraints) {
            
            [_gradientLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }
        else {
            
            [_gradientLayer setFrame:self.bounds];
        }
        
        
        _gradientLayer.startPoint = _startPoint;
        
        if (!CGRectEqualToRect(_gradientLayer.frame, CGRectZero)) {
            [self.layer insertSublayer:_gradientLayer atIndex:0];
        }
        
    }
    else {
        [_gradientLayer removeFromSuperlayer];
    }
}



- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_gradientLayer) {
            [self setbackgroundLayerWithColors:_colors startPoint:_startPoint];
        }
    });
}

- (void) setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_gradientLayer) {
            [self setbackgroundLayerWithColors:_colors startPoint:_startPoint];
        }
    });
}

/*
 NSString* const kRZDBChangeKeyObject  = @"RZDBChangeObject";
 NSString* const kRZDBChangeKeyOld     = @"RZDBChangeOld";
 NSString* const kRZDBChangeKeyNew     = @"RZDBChangeNew";
 NSString* const kRZDBChangeKeyKeyPath = @"RZDBChangeKeyPath";
 */

- (void) valueChanged:(NSDictionary *) value {
    if ([value objectForKey:kRZDBChangeKeyNew]) {
        if(_gradientLayer) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setbackgroundLayerWithColors:_colors startPoint:_startPoint];
            });
        }
    }
}


@end
