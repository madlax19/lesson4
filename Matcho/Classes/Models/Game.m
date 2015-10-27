//
//  Game.m
//  Matcho
//
//  Created by Anton Lookin on 10/27/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Game.h"

@interface Game ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation Game


- (instancetype)initWithCardCount:(NSUInteger)count
						usingDeck:(Deck *)deck {
	self = [super init];
	
	if (self) {
		for (NSUInteger i = 0; i < count; i++) {
			Card *card = [deck drawRandomCard];
			
			if (card) {
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}
	}
	
	return self;
}


- (NSMutableArray *)cards {
	if (!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
	Card *card = [self cardAtIndex:index];
	
	if (!card.isMatched) {
		if (card.isChosen) {
			card.chosen = NO;
		} else {
			NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
			
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[chosenCards addObject:otherCard];
				}
			}
			
			if ([chosenCards count]) {
				int matchScore = [card match:chosenCards];
				if (matchScore) {
					self.score += (matchScore * MATCH_BONUS);
					
					card.chosen = YES;
					card.matched = YES;
					for (Card *otherCard in chosenCards) {
						otherCard.matched = YES;
					}
				} else {
					int penalty = MISMATCH_PENALTY;
					
					self.score -= penalty;
					
					card.chosen = YES;
					for (Card *otherCard in chosenCards) {
						otherCard.chosen = NO;
					}
				}
			} else {
				self.score -= COST_TO_CHOOSE;
				card.chosen = YES;
			}
		}
	}
}


- (Card *)cardAtIndex:(NSUInteger)index {
	return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end
