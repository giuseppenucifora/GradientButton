//
//  GradientButton.m
//  Pods
//
//  Created by Giuseppe Nucifora on 11/01/16.
//
//

#import "GradientButton.h"

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
        [self addObserver:self forKeyPath:@"bounds" options:0 context:nil];
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:@"bounds" options:0 context:nil];
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"bounds" options:0 context:nil];
        _colors = [[NSMutableArray alloc] init];
        _cgColors = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 
 UIColor *topColor = [@"fd843e" colorFromHex];
 UIColor *bottomColor = [@"ff4e50" colorFromHex];
 
 CAGradientLayer *checkoutButtonViewGradient = [CAGradientLayer layer];
 checkoutButtonViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
 checkoutButtonViewGradient.frame = _checkoutButton.bounds;
 checkoutButtonViewGradient.startPoint = CGPointMake(0, 0);
 
 [_checkoutButton.layer insertSublayer:checkoutButtonViewGradient atIndex:0];
 */





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
    
    [self removeObserver:self forKeyPath:@"bounds"];
}


@end
