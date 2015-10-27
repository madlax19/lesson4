//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype) init {
	self = [super init];
	if (self) {
		for (NSInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
			for (NSString *suit in [PlayingCard suits]) {
				[self addCard:[[PlayingCard alloc] initWithSuit:suit
														andRank:rank]];
			}
		}
	}
	return self;
}

@end
