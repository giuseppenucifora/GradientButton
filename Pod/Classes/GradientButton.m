//
//  GradientButton.m
//  Pods
//
//  Created by Giuseppe Nucifora on 11/01/16.
//
//

#import "GradientButton.h"
#import "PureLayout.h"

@interface GradientButton()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *cgColors;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) BOOL didUpdateConstraints;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation GradientButton


- (instancetype) init {
    self = [super init];
    if (self) {
        
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        _container = [UIView newAutoLayoutView];
        [_container setBackgroundColor:[UIColor clearColor]];
        [_container setAlpha:0];
        [self addSubview:_container];
        
        [_container addObserver:self forKeyPath:@"bounds" options:0 context:nil];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        _container = [UIView newAutoLayoutView];
        [_container setBackgroundColor:[UIColor clearColor]];
        [_container setAlpha:0];
         [self addSubview:_container];
        
         [_container addObserver:self forKeyPath:@"bounds" options:0 context:nil];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
        _container = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [_container setBackgroundColor:[UIColor clearColor]];
        [_container setAlpha:0];
        [self addSubview:_container];
        
         [_container addObserver:self forKeyPath:@"bounds" options:0 context:nil];
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

- (void) updateConstraints {
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [_container autoPinEdgesToSuperviewEdges];
        [_container autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_container autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_container setFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
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


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"bounds"]) {
        if(_gradientLayer) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setbackgroundLayerWithColors:_colors startPoint:_startPoint];
            });
        }
    }
}


- (void) dealloc {
    
    [_container removeObserver:self forKeyPath:@"bounds"];
}


@end
