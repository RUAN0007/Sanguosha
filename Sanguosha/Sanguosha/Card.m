//
//  Card.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Card.h"
#import "Environment.h"

@implementation Card
@synthesize type = _type;
@synthesize num = _num;

-(id)initWithNum:(NSInteger )num Type:(Suit)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.num = num;
    }
    return self;
}

-(BOOL)useBy:(Player *)gamer{
    NSLog(@"%@出了张“%@”",gamer ,self);

    [gamer.handcards removeObject:self];
    [[[Environment defaultEnvironment] usefCards] addObject:self];
    NSLog(@" ");
    return YES;
}


-(NSString *)description{
    NSString *suitName,*numName;
    switch (self.type) {
        case SPADE:
            suitName = @"♠";
            break;
        case CLUB:
            suitName = @"♣";
            break;
        case DIAMOND:
            suitName = @"♦";
            break;
        case HEART:
            suitName = @"♥";
            break;
        default:
            break;
    }
    switch (self.num) {
        case 0:
            numName = @"A";
            break;
        case 11:
            numName = @"J";
            break;
        case 12:
            numName = @"Q";
            break;
        case 13:
            numName = @"K";
            break;
        default:
            numName = [NSString stringWithFormat:@"%lu",self.num];
            break;
    }
    return [NSString stringWithFormat:@"%@%@",suitName,numName];
}

@end
