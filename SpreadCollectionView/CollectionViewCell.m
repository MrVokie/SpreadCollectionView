//
//  CollectionViewCell.m
//  test
//
//  Created by Vokie on 15/7/4.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIViewAdditions.h"
#import "TriangleView.h"

@interface CollectionViewCell ()
@property (nonatomic, retain) TriangleView *triangleView;

@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        
        [self addAllViews];
        [self addPointingView];
    }
    
    return self;
    
}



- (void)addAllViews {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [self addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


- (void)addPointingView {
    self.triangleView = [[TriangleView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 8, self.titleLabel.bottom - 8, 16, 8)];
    self.triangleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.triangleView];
}


- (void)setIsHiddened:(BOOL)isHiddened {
    _isHiddened = isHiddened;
    if (!_isHiddened) {
        self.triangleView.hidden = NO;

    }else{
        self.triangleView.hidden = YES;

    }
}





@end
