//
//  PlayingCard.m
//  Matchismo
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard

+ (NSArray *)suits {
    return @[@"♣", @"♠", @"♦", @"♥"];
}

+ (NSArray *)ranks {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return ([[PlayingCard ranks] count] - 1);
}

-(instancetype) initWithSuit:(NSString *)suit andRank:(NSInteger)rank {
	self = [super init];
	if (self) {
		self.suit = suit;
		self.rank = rank;
	}
	return self;
}


-(void)	setSuit:(NSString *)suit {
	if ([[PlayingCard suits] containsObject:suit]) {
		_suit = suit;
	}
}


-(void) setRank:(NSUInteger)rank {
	if (rank <= [PlayingCard maxRank]) {
		_rank = rank;
	}
}

-(NSString*) color{
    if([self.suit isEqualToString:[PlayingCard suits][2]] || [self.suit isEqualToString:[PlayingCard suits][3]]) {
        return @"red";
    }
    return @"black";
}


-(NSString *) contents {
	return [NSString stringWithFormat:@"%@%@", [PlayingCard ranks][self.rank], self.suit];
}

- (BOOL)suitColorMatch: (Card *) card{
    PlayingCard* pc = (PlayingCard *) card;
    if([self.color isEqualToString:pc.color] && ![self.suit isEqualToString: pc.suit]){
        return YES;
    }
    return NO;
}


- (int) match:(NSArray *)otherCards {
    int sum = 0;
    for(id object in otherCards) {
        if([object isMemberOfClass:[Card class]]) {
            Card *card = (Card *) object;
            if ([self.contents isEqualToString:card.contents]){
                sum = sum + 10;
            }
        } else {
            PlayingCard *playingCard = (PlayingCard *) object;
            if ([self.suit isEqualToString:playingCard.suit]) {
                sum = sum + 1;
            }
            
            if (self.rank == playingCard.rank) {
                sum = sum + 4;
            }
        }
    }
    
    return sum;
}


@end
