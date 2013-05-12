
//
//  kitsCard.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "KitsCard.h"
#import "Player.h"
#import "EquipmentCard.h"
#import "BasicCard.h"
#import "Environment.h"

@implementation KitsCard
-(BOOL)WXKJForCardForPlayer:(Player *)player ByPlayer:(Player *)sender{
    
    NSArray *participants = [[Environment defaultEnvironment] participants];
    for (NSInteger index = 0;index < [participants count];index++){
        Player *p = [participants objectAtIndex:(player.position + index) % [participants count] ];
        if (!p.alive) {
            continue;
        }
        if([p shouldUseWXKJForCard:self ForPlayer:player ByPlayer:sender]){
            return YES;
        };
    }
    return NO;
}


@end

@implementation WXKJKitsCard//无懈可击
-(BOOL)useBy:(Player *)gamer{

    
    [super useBy:gamer];
    if ([self WXKJForCardForPlayer:gamer ByPlayer:nil]) {
        NSLog(@"%@的%@使用无效。",gamer ,self);
        return NO;
    }
    return YES;
    
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 无懈可击%@ ",cardTag];
}
@end

@implementation WJQFKitsCard//万箭齐发

-(BOOL)useBy:(Player *)gamer{
    NSArray *participants = [[Environment defaultEnvironment] participants];
    [super useBy:gamer];
    NSUInteger position = gamer.position;
    for (NSUInteger index = 1; index < [participants count];index++ ) {
        Player *receiver = [participants objectAtIndex:(position + index) % [participants count]];
        if (!receiver.alive) {
            continue;
        }
        if ([self WXKJForCardForPlayer:receiver ByPlayer:gamer]) {
            NSLog(@"%@对%@的%@使用无效。",gamer ,receiver ,self);
        }else{
            if (![receiver shouldUseShanForCard:self ByPlayer:gamer DefenseEquippmentEnabled:YES]) {
                [receiver reduceBlood:1 ByCard:self ByPlayer:gamer];
            }
        }
        
 
    }
    return YES;
}




-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 万箭齐发%@ ",cardTag];
}
@end



@implementation NMRQKitsCard//南蛮入侵

-(BOOL)useBy:(Player *)gamer{
    NSArray *partipants = [[Environment defaultEnvironment]participants];
    [super useBy:gamer];
    NSUInteger position = gamer.position;
    for (NSUInteger index = 1; index < [partipants count];index++ ) {
        Player *receiver = [partipants objectAtIndex:(position + index) % [partipants count]];
        if (!receiver.alive) {
            continue;
        }
        if ([self WXKJForCardForPlayer:receiver ByPlayer:gamer]) {
            NSLog(@"%@对%@的%@使用无效。",gamer ,receiver ,self);
        }else{
            if (![receiver shouldUseShaForCard:self ByPlayer:gamer]) {
                [receiver reduceBlood:1 ByCard:self ByPlayer:gamer];
            }
        }
    }
    return YES;
}


-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 南蛮入侵%@ ",cardTag];
}
@end


@implementation JDKitsCard//决斗

-(BOOL)useBy:(Player *)gamer{
    NSArray *partipants = [[Environment defaultEnvironment]participants];

    NSInteger choice;
    NSInteger count = 0;
    Player *receiver;
    
    [[Environment defaultEnvironment]displayStatus];
    
    while (1) {
        NSLog(@"请%@输入想要决斗的人的位置(输入-1放弃使用杀):",gamer );
        choice = [gamer choiceFrom:-1 To:[partipants count] - 1];
        if (choice == gamer.position) {
            NSLog(@"不能对自己使用决斗，无效输入。");
            continue;
        }
        if (choice == -1) {
            NSLog(@"%@放弃使用%@.",gamer ,self);
            return NO;
            
        }
        
        receiver = [partipants objectAtIndex:choice];
        if (!receiver.alive) {
            NSLog(@"%@阵亡，已退出游戏。",receiver );
            continue;
        }
        break;
    }
    


    
    [super useBy:gamer];
    NSLog(@"对%@使用%@",receiver ,self);
    
    if ([self WXKJForCardForPlayer:receiver ByPlayer:gamer]) {
        NSLog(@"%@对%@的%@使用无效。",gamer ,receiver ,self);
        return NO;
    }
    
    

    
    while (1) {
        if (count % 2 == 0) {
            if (![receiver shouldUseShaForCard:self ByPlayer:gamer]) {
                [receiver reduceBlood:1 ByCard:self ByPlayer:gamer];
                return YES;
            }
        }else{
            if (![gamer shouldUseShaForCard:self ByPlayer:gamer]) {
                [gamer reduceBlood:1 ByCard:self ByPlayer:gamer];
                return YES;
            }
        }
        count++;
    }

    

    
}


-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 决斗%@ ",cardTag];
}

@end

@implementation JDSRKitsCard  //借刀杀人

-(BOOL)useBy:(Player *)gamer{
    NSArray *partipants = [[Environment defaultEnvironment]participants];

    NSInteger choice;
    Player *attacker;
    
    [[Environment defaultEnvironment]displayStatus];

    
    WeaponEquipmentCard *weapon;

    while (1) {
        NSLog(@" ");
        NSLog(@"请%@输入使用借刀杀人的玩家位置： (-1表示不出）",gamer );
        choice = [gamer choiceFrom:-1 To:[partipants count] - 1];
        
        if (choice == -1) {
            NSLog(@"%@放弃使用%@",gamer ,self);
            return NO;
        }
        
        
        if (gamer.position == choice) {
            NSLog(@"不能对自己使用借刀杀人，请再次输入： ");
            continue;
        }
        
        attacker = [partipants objectAtIndex:choice];
        
        if (!attacker.alive) {
            NSLog(@"%@阵亡，已退出游戏。",attacker );
            continue;
        }
        
        weapon = [attacker.equipments objectForKey:WEAPONKEY];
        if (!weapon) {
            NSLog(@"该目标没有武器，无效。请再次输入。");
            continue;
        }
        break;
    }
    
    attacker = [partipants objectAtIndex:choice];
    Player *defender;
    NSInteger choice2;
    
    [[Environment defaultEnvironment]displayStatus];

    while (1) {
        
        
        NSLog(@"请%@输入被使用杀的目标角色位置。(-1表示不出）",gamer );
        
        choice2 = [gamer choiceFrom:-1 To:[partipants count] - 1];

        if (choice2 == -1) {
            NSLog(@"%@放弃使用%@",gamer ,self);
            return NO;
        }
        
        if (choice == choice2 ) {
            NSLog(@"使用借刀杀人的角色与被杀角色相同，无效。请再次输入：");
            continue;
        }
        
        
        defender = [partipants objectAtIndex:choice2];
        
        if (!defender.alive) {
            NSLog(@"%@阵亡，已退出游戏。",defender );
            continue;
        }
        
        if (![[Environment defaultEnvironment] accessibleFrom:attacker To:defender WithWeapon:YES]) {
            NSLog(@"距离太远，鞭长莫及啊。请再次输入。");
            continue;
        }
        break;
        
    }
    [super useBy:gamer];

    if ([self WXKJForCardForPlayer:attacker ByPlayer:gamer]) {
        NSLog(@"%@对%@的%@使用无效。",gamer ,attacker ,self);
        return NO;
    }
    NSLog(@"请%@对%@出一张杀，否则武器给%@",attacker ,defender ,gamer );
    
    ShaBasicCard *shaCard = [attacker shouldUseShaForCard:self ByPlayer:gamer];
    if (shaCard) {
        [shaCard attackFrom:attacker To:defender WithEquipment: weapon];

    }else{
        NSLog(@"%@的%@被被%@拿到。",attacker ,weapon,gamer );
        [attacker.equipments removeObjectForKey:WEAPONKEY];
        [gamer.handcards addObject:weapon];
    }
    
    
    return YES;
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 借刀杀人%@ ",cardTag];
}

@end

@implementation TYJYKitsCard//桃园结义

-(BOOL)useBy:(Player *)gamer{
    NSArray *participants = [[Environment defaultEnvironment] participants];
    [super useBy:gamer];
    NSUInteger position = gamer.position;
    for (NSUInteger index = 0; index < [participants count];index++ ) {
        Player *receiver = [participants objectAtIndex:(position + index) % [participants count]];
        if (!receiver.alive) {
            continue;
        }
        if (receiver.bloodLeft < receiver.maxBlood){
            

            
            if ([self WXKJForCardForPlayer:receiver ByPlayer:gamer]) {
                NSLog(@"%@对%@的%@使用无效。",gamer ,receiver ,self);
            }else{
                NSLog(@"%@的血量增加一点",receiver );
                receiver.bloodLeft++;
            }
        }    }
    return YES;
}

-(NSString *)description{
    NSString *cardTag = [super description];
     
    return [NSString stringWithFormat:@" 桃园结义%@ ",cardTag];
}

@end

@implementation WZSYKitsCard//无中生有

-(BOOL)useBy:(Player *)gamer{
    [super useBy:gamer];
    NSLog(@"\n");
    if ([self WXKJForCardForPlayer:gamer ByPlayer:nil]) {
        NSLog(@"%@的%@使用无效。",gamer ,self);

        return NO;
    }
    
    [gamer retrieveCards:2];
    return YES;
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 无中生有%@ ",cardTag];
}


@end

@implementation GHCQKitsCard//过河拆桥


-(BOOL)useBy:(Player *)gamer{
    
    NSArray *participants = [[Environment defaultEnvironment] participants];
    NSInteger choice;
    Player *defender;
    
    [[Environment defaultEnvironment]displayStatus];

    
    NSLog(@" ");

    while (1) {
        NSLog(@"请%@输入使用过河拆桥的目标位置",gamer );
        choice = [gamer choiceFrom:-1 To:[participants count] - 1];
        
        if (choice == -1) {
            NSLog(@"%@放弃使用%@",gamer ,self);
            return NO;
        }
        
        if (choice == gamer.position) {
            NSLog(@"无法对自己使用%@，无效。请重新输入。",self);
            continue;
        }
        
        defender = [participants objectAtIndex:choice];
        
        if (!defender.alive) {
            NSLog(@"%@阵亡，已退出游戏。",defender );
            continue;
        }
        
        if ([defender.handcards count] == 0 && [defender equipmentsNum] == 0 && [defender.judgecards count] == 0) {
            NSLog(@"%@的手牌及装备为空。输入无效。",defender );
            continue;
        }
        break;
    }
    
    [super useBy:gamer];
    NSLog(@"对%@使用%@",defender ,self);
    
    
    if ([self WXKJForCardForPlayer:defender ByPlayer:gamer]) {
        NSLog(@"%@对%@的%@使用无效。",gamer ,defender ,self);

        return NO;
        
    }
    
    [defender displayStatusWithHandsCard:NO WithTag:YES];
    
    
    WeaponEquipmentCard *weaponD = [defender.equipments objectForKey:WEAPONKEY];
    DefenseEquipmentCard *defense = [defender.equipments objectForKey:DEFENSEKEY];
    DefenseHorseCard *defenseHorse = [defender.equipments objectForKey:DEFENSEHORSEKEY];
    AttackHorseCard *attackHorse = [defender.equipments objectForKey:ATTACKHORSEKEY];
    
    NSUInteger defenderHandsCount = [defender.handcards count];
    NSUInteger defenderJudgeCount = [defender.judgecards count];
    
    while (1) {
        

        
        
        if (defenderHandsCount == 0) {
            if (defenderJudgeCount == 0) {
                NSLog(@"输入要弃置的牌的编号（0~3为装备)");
            }else{
                NSLog(@"输入要弃置的牌的编号（0~3为装备),4及以上为判定牌");
            }
        }else{
            if (defenderJudgeCount == 0) {
                NSLog(@"输入要弃置的牌的编号（0~3为装备),4及以上为手牌");
            }else{
                NSLog(@"输入要弃置的牌的编号（0~3为装备，4~%lu手牌,%lu及以上为判定牌）(-1)返回",3 + defenderHandsCount,4 + defenderHandsCount);

            }
        }
           
        NSInteger attackerChoice = [gamer choiceFrom:0 To:3 + defenderHandsCount + defenderJudgeCount];
        Card *card;

        
        
        switch (attackerChoice) {
            case 0:
                if (weaponD) {
                    [defender.equipments removeObjectForKey:WEAPONKEY];
                    [[[Environment defaultEnvironment] usefCards] addObject:weaponD];
                    NSLog(@"%@的%@被拆除。",defender ,weaponD);
                    
                }else{
                    NSLog(@"攻具为空，再次输入。");
                    continue;
                }
                break;
            case 1:
                if (defense) {
                    [defender.equipments removeObjectForKey:DEFENSEKEY];
                    [[[Environment defaultEnvironment] usefCards] addObject:defense];

                    NSLog(@"%@的%@被拆除。",defender ,defense);

                }else{
                    NSLog(@"防具为空，再次输入。");
                    continue;
                }
                break;
            case 2:
                if (defenseHorse) {
                    [defender.equipments removeObjectForKey:DEFENSEHORSEKEY];
                    [[[Environment defaultEnvironment] usefCards] addObject:defenseHorse];

                    NSLog(@"%@的%@被拆除。",defender ,defenseHorse);

                }else{
                    NSLog(@"防御马为空，再次输入。");
                    continue;
                }
                
                break;
                
            case 3:
                if (attackHorse) {
                    [defender.equipments removeObjectForKey:ATTACKHORSEKEY];
                    [[[Environment defaultEnvironment] usefCards] addObject:attackHorse];

                    NSLog(@"%@的%@被拆除。",defender ,attackHorse);

                    
                }else{
                    NSLog(@"攻击马为空，再次输入。");
                    continue;
                }
            default:

                if (attackerChoice >= 4 + defenderHandsCount) {
                    card = [defender.judgecards objectAtIndex:attackerChoice - 4 - defenderHandsCount];
                    NSLog(@"%@判定区的%@被拆除。",defender ,card);
                    
                    [defender.judgecards removeObjectAtIndex:attackerChoice - 4 - defenderHandsCount];
                }else{
                    card = [defender.handcards objectAtIndex:attackerChoice - 4];
                    NSLog(@"%@手牌的%@被拆除。",defender ,card);
                    
                    [defender.handcards removeObjectAtIndex:attackerChoice - 4];
                }
                [[[Environment defaultEnvironment] usefCards] addObject:card];

            
                break;
        }
        break;
    }

    
    
    return YES;
    
    
    
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 过河拆桥%@ ",cardTag];
}

@end

@implementation SSQYKitsCard//顺手牵羊


-(BOOL)useBy:(Player *)gamer{
    NSArray *participants = [[Environment defaultEnvironment] participants];
    NSInteger choice;
    Player *receiver;
    
    [[Environment defaultEnvironment]displayStatus];
    

    
    while (1) {
        
        
        NSLog(@"请输入使用%@的目标位置。(-1表示放弃）",self);
        
        choice = [gamer choiceFrom:-1 To:[participants count] - 1];
        
        if (choice == -1) {
            NSLog(@"%@放弃使用%@",gamer ,self);
            return NO;
        }
        if (choice == gamer.position) {
            NSLog(@"无法对自己使用%@,重新输入",self);
            continue;
        }
        
        receiver = [participants objectAtIndex:choice];
        
        if (!receiver.alive) {
            NSLog(@"%@阵亡，已退出游戏。",receiver );
            continue;
        }
        
        if (![[Environment defaultEnvironment]accessibleFrom:gamer To:receiver WithWeapon:NO]) {
            NSLog(@"距离太远，鞭长莫及啊。请再次输入：");
            continue;
        }
        
        if ([receiver.handcards count] + [receiver.judgecards count] + [receiver equipmentsNum] == 0) {
            NSLog(@"%@的手牌，装备牌以及判定区为空，无法使用%@",receiver ,self);
            continue;
        }
        
        
        break;
    }
    [super useBy:gamer];
    NSLog(@"%@对%@使用%@",gamer ,receiver ,self);

    if ([self WXKJForCardForPlayer:receiver ByPlayer:gamer]) {
        NSLog(@"%@对%@的%@使用无效。",gamer ,receiver ,self);
        return NO;
    }
    NSLog(@" ");

    [receiver displayStatusWithHandsCard:NO WithTag:YES];
    
    NSUInteger receiverHandsCount = [receiver.handcards count];
    NSUInteger receiverJudgeCount = [receiver.judgecards count];
    
    

    
    
    WeaponEquipmentCard *weaponD = [receiver.equipments objectForKey:WEAPONKEY];
    DefenseEquipmentCard *defense = [receiver.equipments objectForKey:DEFENSEKEY];
    DefenseHorseCard *defenseHorse = [receiver.equipments objectForKey:DEFENSEHORSEKEY];
    AttackHorseCard *attackHorse = [receiver.equipments objectForKey:ATTACKHORSEKEY];
    
    Card *card;
    while (1) {
        
        if (receiverHandsCount == 0) {
            if (receiverJudgeCount == 0) {
                NSLog(@"输入要牵的牌的编号（0~3为装备)");
            }else{
                NSLog(@"输入要牵的牌的编号（0~3为装备),4及以上为判定牌");
            }
        }else{
            if (receiverJudgeCount == 0) {
                NSLog(@"输入要牵的牌的编号（0~3为装备),4及以上为手牌");
            }else{
                NSLog(@"输入要牵的牌的编号（0~3为装备，4~%lu手牌,%lu及以上为判定牌）(-1)返回",3 + receiverHandsCount,4 + receiverHandsCount);
                
            }
        }
        
        NSInteger attackerChoice = [gamer choiceFrom:0 To:3 + receiverHandsCount + receiverJudgeCount];
        
        switch (attackerChoice) {
            case 0:
                if (weaponD) {
                    [receiver.equipments removeObjectForKey:WEAPONKEY];
                    card = weaponD;
                }else{
                    NSLog(@"攻具为空，再次输入。");
                    continue;
                }
                break;
            case 1:
                if (defense) {
                    [receiver.equipments removeObjectForKey:DEFENSEKEY];
                    card = defense;
                    
                }else{
                    NSLog(@"防具为空，再次输入。");
                    continue;
                }
                break;
            case 2:
                if (defenseHorse) {
                    [receiver.equipments removeObjectForKey:DEFENSEHORSEKEY];
                    card = defenseHorse;
                    
                }else{
                    NSLog(@"防御马为空，再次输入。");
                    continue;
                }
                
                break;
                
            case 3:
                if (attackHorse) {
                    [receiver.equipments removeObjectForKey:ATTACKHORSEKEY];
                    card = attackHorse;
                    
                }else{
                    NSLog(@"攻击马为空，再次输入。");
                    continue;
                }
            default:
                if (attackerChoice >= 4 + receiverHandsCount) {
                    card = [receiver.judgecards objectAtIndex:attackerChoice - 4 - receiverHandsCount];
                    
                    [receiver.judgecards removeObjectAtIndex:attackerChoice - 4 - receiverHandsCount];
                }else{
                    card = [receiver.handcards objectAtIndex:attackerChoice - 4];
                    
                    [receiver.handcards removeObjectAtIndex:attackerChoice - 4];
                }

        }
        
        [gamer.handcards addObject:card];
        NSLog(@"%@的获得了%@的%@。",gamer ,receiver ,card);
        
        break;
    }
    
    return YES;

}

-(NSString *)description{
    NSString *cardTag = [super description];
     
    return [NSString stringWithFormat:@" 顺手牵羊%@ ",cardTag];
}

@end

@implementation WGFDKitsCard//五谷丰登

-(BOOL)useBy:(Player *)gamer{
    [super useBy:gamer];
    
    NSArray *participants = [[Environment defaultEnvironment]participants];
    NSMutableArray *cards = [NSMutableArray array];
    
    for (NSInteger index = 0;index < [[Environment defaultEnvironment] alivePlayers];index++){
        [cards addObject:[[Environment defaultEnvironment] popCard] ];
        
    }
    
    for (NSInteger index = 0; index < [participants count]; index++) {
        Player *p = [participants objectAtIndex:(gamer.position + index) % [participants count]];
        
        if (!p.alive) {
            continue;
        }
        
        NSString *cardDescription = @"五谷丰登： ";
        for (NSInteger indx = 0; indx < [cards count]; indx++) {
            cardDescription = [cardDescription stringByAppendingFormat:@"%ld) %@   ",indx,[cards objectAtIndex:indx]];
        }
        NSLog(@"%@",cardDescription);

        if ([self WXKJForCardForPlayer:p ByPlayer:gamer]) {
            NSLog(@"%@对%@的%@使用无效。",gamer ,p ,self);
        }else{
            NSInteger choice;
            NSLog(@"%@",cardDescription);

            NSLog(@"请%@输入要拿的牌。",p );
            
            choice = [p choiceFrom:0 To:[cards count] - 1];
            
            Card *card = [cards objectAtIndex:choice];
            
            [cards removeObjectAtIndex:choice];
            
            [p.handcards addObject:card];
            
            NSLog(@"%@从牌堆中拿到%@。",p ,card);
        }
        
        
        
    }
    
    return YES;
    
}


-(NSString *)description{
    NSString *cardTag = [super description];
     
    return [NSString stringWithFormat:@" 五谷丰登%@ ",cardTag];
}

@end



