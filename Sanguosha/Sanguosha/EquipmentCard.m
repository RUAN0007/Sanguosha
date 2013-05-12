//
//  equipmentCard.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "EquipmentCard.h"
#import "Environment.h"

@implementation EquipmentCard

@synthesize tag = _tag;

-(id)initWithNum:(NSInteger)num Type:(Suit)type WithTag:(NSString *)tag{
    self = [super initWithNum:num Type:type];
    if (self) {
        self.tag  = tag;
    }
    return self;
}

-(BOOL)useBy:(Player *)gamer{
    NSString *key;
    if ([self isMemberOfClass:[WeaponEquipmentCard class]]) {
        key = WEAPONKEY;
    }else if ([self isMemberOfClass:[DefenseEquipmentCard class]]){
        key = DEFENSEKEY;
    }else if([self isMemberOfClass:[DefenseHorseCard class]]){
        key = DEFENSEHORSEKEY;
    }else if([self isMemberOfClass:[AttackHorseCard class]])  {
        key = ATTACKHORSEKEY;
    }else{
        [NSException raise:@"Invalid equippment" format:@"nil"];
    }
    
    WeaponEquipmentCard *card = [gamer.equipments objectForKey:key];
    if (card) {
        NSLog(@"%@的原有装备%@被弃置",gamer ,card);
        [[[Environment defaultEnvironment]usefCards] addObject:card];
    }
    
    NSLog(@"%@将“%@”置入自己的装备区。",gamer ,self);
    [gamer.equipments setObject:self forKey:key];
    [gamer.handcards removeObject:self];
    
    return YES;
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" %@%@ ",self.tag ,cardTag];
}
@end

@implementation WeaponEquipmentCard

-(id)initWithNum:(NSInteger)num Type:(Suit)type WithTag:(NSString *)tag Distance:(NSUInteger)distance{
    self = [super initWithNum:num Type:type WithTag:tag];
    if (self) {
        self.distance = distance;
    }
    return self;
}
@end

@implementation DefenseHorseCard


@end

@implementation DefenseEquipmentCard
-(BOOL)defendFor:(Card *)card ForPlayer:(Player *)gamer{
    if ([self.tag   isEqualToString: @"仁王盾"]) {
        if (card.type == CLUB || card.type == SPADE) {
            NSLog(@"%@的仁王盾被触发。",gamer );
            return YES;
        }else{
            return NO;
        }
    }else if ([self.tag  isEqualToString:@"八卦阵"]){
        NSLog(@"%@：是否使用八卦阵？（1为是，0为否）",gamer );
        NSInteger choice;
        choice = [gamer choiceFrom:0 To:1];
        if (choice == 1) {
            Card *judge = [[Environment defaultEnvironment] judgeFromPlayer:gamer];
            NSLog(@"判定牌为%@",judge);
            if (judge.type == HEART || judge.type == DIAMOND) {
                NSLog(@"八卦阵被触发。");
                return YES;
            }else{
                NSLog(@"八卦阵失效。");
                return NO;
            }
        }else{
            return NO;
        }
        
    }
    return NO;
}



@end


@implementation AttackHorseCard


@end