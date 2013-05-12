//
//  Card.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
typedef   enum  {SPADE,CLUB,DIAMOND,HEART,NONE} Suit;//None表示无属性牌
#define WEAPONKEY @"Weapon"
#define DEFENSEKEY @"Defense"
#define DEFENSEHORSEKEY @"DefenseHorse"
#define ATTACKHORSEKEY @"AttackHorse"

#define SHA @"杀"
#define SHAN @"闪"
#define TAO @"桃"
#define WXKJ @"无懈可击"

@interface Card : NSObject
@property (nonatomic) NSInteger num;
@property (nonatomic) Suit type;

-(BOOL)useBy:(id)gamer;
-(id)initWithNum:(NSInteger )num Type:(Suit)type;
@end
