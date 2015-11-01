//
//  Game.m
//  Matcho
//
//  Created by Anton Lookin on 10/27/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Game.h"
#import "PlayingCard.h"

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

-(BOOL) allMatchesIsFound {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (Card *otherCard in self.cards) {
        if (!otherCard.isMatched) {
            [cards addObject:otherCard];
        }
    }
    if(cards.count > 0) {
        PlayingCard *card = cards.firstObject;
        [cards removeObject:card];
        int score = [card match: cards];
        if(score){
            return NO;
        }
    }
    return YES;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int SUIT_COLOR_BONUS = 9;
static const int JOKER_BONUS = 15;


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
                BOOL isJoker = [card.contents isEqualToString:@"Joker"];
                for (Card *otherCard in chosenCards) {
                    isJoker = isJoker || [otherCard.contents isEqualToString:@"Joker"];
                }
                if(isJoker) {
                    self.score = self.score + JOKER_BONUS;
                } else {
                    int matchScore = [card match:chosenCards];
                    if (matchScore) {
                        self.score += (matchScore * MATCH_BONUS);
                        
                        card.chosen = YES;
                        card.matched = YES;
                        for (Card *otherCard in chosenCards) {
                            otherCard.matched = YES;
                            if([card suitColorMatch:otherCard]){
                                self.score += SUIT_COLOR_BONUS;
                            }
                        }
                    } else {
                        int penalty = MISMATCH_PENALTY;
                        
                        self.score -= penalty;
                        
                        card.chosen = YES;
                        for (Card *otherCard in chosenCards) {
                            otherCard.chosen = NO;
                        }
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
