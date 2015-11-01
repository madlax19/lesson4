//
//  Game.h
//  Matcho
//
//  Created by Anton Lookin on 10/27/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"


@interface Game : UIView

- (instancetype)initWithCardCount:(NSUInteger)count
						usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL allMatchesIsFound;
@property (nonatomic, readonly) NSString* currentEvent;

@end
