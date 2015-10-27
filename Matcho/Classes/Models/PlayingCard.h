//
//  PlayingCard.h
//  Matchismo
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

-(instancetype) initWithSuit:(NSString *)suit andRank:(NSInteger)rank;

+ (NSArray *)suits;
+ (NSUInteger)maxRank;

@end
