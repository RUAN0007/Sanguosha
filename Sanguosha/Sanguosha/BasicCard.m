//
//  basicCard.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "BasicCard.h"

#import "Player.h"
#import "EquipmentCard.h"
#import "Environment.h"

@implementation BasicCard

@end

@implementation TaoBasicCard
-(BOOL)useBy:(Player *)sender ForPlayer:(Player *)patient{
    if (patient.bloodLeft == patient.maxBlood) {
        NSLog(@"%@的血量是满的。",patient );
        return NO;
    }else{
        [self useBy:sender];
        patient.bloodLeft++;
        NSLog(@"%@增加一点血量。",patient );
        return YES;
    }
    
    
}

-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 桃%@ ",cardTag];
}
@end

@implementation ShanBasicCard


-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 闪%@ ",cardTag];
}
@end


@implementation ShaBasicCard



//使用方天画戟
/////////////////////////////////////////////////////////////////////////

-(BOOL)useFTHJByPlayer:(Player *)attacker{
    
    NSArray *participants = [[Environment defaultEnvironment]participants];
    
    NSLog(@"%@使用了方天画戟,可以砍最多3个人。",attacker );
    NSInteger count = [participants count];
    
    BOOL attackAble[count];
    for (int index = 0; index < count; index++) {
        attackAble[index] = YES;
    }
    
    NSInteger playerCount = 1;
    [[Environment defaultEnvironment] displayStatus];
    do {
        NSInteger choice;
        Player *defender;
        while (1) {
            NSLog(@" ");
            NSLog(@"输入%@要砍的第%ld个人的位置。（输入-1结束）",attacker ,playerCount);
            
            choice = [attacker choiceFrom:-1 To:count - 1];
            if (choice == -1) {
                if(playerCount == 1) {
                    NSLog(@"%@放弃使用%@",attacker ,[self description]);
                    return NO;
                }else{
                    return YES;
                    NSLog(@"%@停止使用%@",attacker ,[attacker.equipments objectForKey:WEAPONKEY]);

                }
            }
            if (choice == attacker.position) {
                NSLog(@"不能砍自己。");
                continue;
            }
            
            defender = [participants objectAtIndex:choice];
            
            if (defender.alive == NO) {
                NSLog(@"%@阵亡，已退出游戏。",defender );
                continue;
            }
            
            if (![[Environment defaultEnvironment] accessibleFrom:attacker To:defender WithWeapon:YES]) {
                NSLog(@"距离太远，鞭长莫及啊。。。");
                continue;
            }
            
            if (!attackAble[choice]) {
                NSLog(@"此人已被砍过。");
                continue;
            }
            if (playerCount == 1) {
                [super useBy:attacker];
            }
            
            NSLog(@"第%ld个目标为%@。",playerCount,defender );
            
            if(![defender shouldUseShanForCard:self ByPlayer:attacker DefenseEquippmentEnabled:YES]){
                [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
            };
            attackAble[choice] = NO;

            
            break;
        }
        playerCount++;
        
    } while (playerCount != 4);
    return YES;
}

//attacker使用weapon对defender打出一张杀
/////////////////////////////////////////////////////////////////////////
-(BOOL)attackFrom:(Player *)attacker To:(Player *)defender WithEquipment:(WeaponEquipmentCard *)weapon{
    attacker.ableToAttack = NO;
    
    if ([weapon.tag  isEqualToString:@"青红剑"]) {
        
        
        NSLog(@"%@使用了青红剑",attacker );
        if (![defender shouldUseShanForCard:self ByPlayer:attacker DefenseEquippmentEnabled:NO]) {
            [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
        }
        
        
        
    }else if ([weapon.tag  isEqualToString:@"雌雄双股剑"]){
        
        NSLog(@"是否发动雌雄双股剑（1为是，0为否）");
        NSInteger choice = [attacker choiceFrom:0 To:1];
        if (choice == 1) {
            NSLog(@"%@对%@使用了雌雄双股剑。",attacker ,defender );
            
            [defender displayStatusWithHandsCard:YES WithTag:NO];
            NSLog(@"请%@输入-1让%@摸一张牌 或输入弃牌的编号。",defender ,attacker );
            
            NSInteger defenderInput = [defender choiceFrom:-1 To:[defender.handcards count] - 1];
            
            if (defenderInput == -1) {
                Card *card = [[Environment defaultEnvironment] popCard];
                NSLog(@"%@从牌堆中摸出一张牌",attacker );
                [attacker.handcards addObject:card];
                
            }else{
                Card *card = [defender.handcards objectAtIndex:defenderInput];
                NSLog(@"%@弃置了%@",defender ,card);
                [defender.handcards removeObjectAtIndex:defenderInput];
                [[[Environment defaultEnvironment]usefCards] addObject:card];
            }
            

        }
        if (![defender shouldUseShanForCard:self ByPlayer:attacker DefenseEquippmentEnabled:YES]) {
            [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
        }
    }else{
        NSLog(@"对%@使用",defender );

        if ([defender shouldUseShanForCard:self ByPlayer:attacker DefenseEquippmentEnabled:YES]) {
            if ([weapon.tag  isEqualToString:@"青龙偃月刀"]) {
                NSInteger choice;
                NSLog(@"是否使用青龙偃月刀？（1为是，0为否）");
                choice = [attacker choiceFrom:0 To:1];
                
                if (choice == 1) {
                    NSLog(@"%@使用了青龙偃月刀。",attacker );
                    if([self UseQLYYDFrom:attacker To:defender]){
                        [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
                    };
                    
                }
            } else if ([weapon.tag  isEqualToString:@"贯石斧"] &&([attacker equipmentsNum] + [attacker.handcards count] >= 2
                                                              ) ){
                NSLog(@"是否使用贯石斧？（1为是，0为否）");
                NSInteger choice = [attacker choiceFrom:0 To:1];
                if (choice == 1) {
                    NSLog(@"%@对%@使用了贯石斧",attacker ,defender );
                    NSUInteger cardCount = 1;
                    
                    while (cardCount != 3) {
                        
                        WeaponEquipmentCard *weapon = [attacker.equipments objectForKey:WEAPONKEY];
                        DefenseEquipmentCard *defense = [attacker.equipments objectForKey:DEFENSEKEY];
                        DefenseHorseCard *defenseHorse = [attacker.equipments objectForKey:DEFENSEHORSEKEY];
                        AttackHorseCard *attackHorse = [attacker.equipments objectForKey:ATTACKHORSEKEY];
                        
                        while (1) {
                            [attacker displayStatusWithHandsCard:YES WithTag:YES];
                            NSLog(@"输入要弃置的第%lu张牌的编号（0~3为装备，4以上为手牌）",cardCount);
                            NSUInteger attackerHandsCount = [attacker.handcards count];
                            
                            NSInteger attackerChoice = [attacker choiceFrom:0 To:3 + attackerHandsCount];
                            
                            
                            
                            
                            
                            switch (attackerChoice) {
                                case 0:
                                    if (weapon) {
                                        [attacker.equipments removeObjectForKey:WEAPONKEY];
                                        [[[Environment defaultEnvironment]usefCards] addObject:weapon];
                                        NSLog(@"%@弃置了%@",attacker ,weapon);
                                    }else{
                                        NSLog(@"攻具为空，再次输入。");
                                        continue;
                                    }
                                    break;
                                case 1:
                                    if (defense) {
                                        [attacker.equipments removeObjectForKey:DEFENSEKEY];
                                        [[[Environment defaultEnvironment]usefCards] addObject:defense];

                                        NSLog(@"%@弃置了%@",attacker ,defense);
                                        
                                    }else{
                                        NSLog(@"防具为空，再次输入。");
                                        continue;
                                    }
                                    break;
                                case 2:
                                    if (defenseHorse) {
                                        [attacker.equipments removeObjectForKey:DEFENSEHORSEKEY];
                                        [[[Environment defaultEnvironment]usefCards] addObject:defenseHorse];

                                        NSLog(@"%@弃置了%@",attacker ,defenseHorse);
                                        
                                    }else{
                                        NSLog(@"防御马为空，再次输入。");
                                        continue;
                                    }
                                    
                                    break;
                                    
                                case 3:
                                    if (attackHorse) {
                                        [attacker.equipments removeObjectForKey:ATTACKHORSEKEY];
                                        [[[Environment defaultEnvironment]usefCards] addObject:attackHorse];

                                        NSLog(@"%@弃置了%@",attacker ,attackHorse);
                                        
                                    }else{
                                        NSLog(@"攻击马为空，再次输入。");
                                        continue;
                                    }
                                default:
                                    NSLog(@"%@弃置了%@",attacker ,[attacker.handcards objectAtIndex: attackerChoice - 4]);

                                    Card *card = [attacker.handcards objectAtIndex:attackerChoice - 4];
                                    [[[Environment defaultEnvironment]usefCards] addObject:card];

                                    [attacker.handcards removeObjectAtIndex:attackerChoice - 4];
                                    

                                    break;
                            }
                            break;
                        }
                        cardCount++;
                        
                    }
                    [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
                    
                    
                }
            }
        }else{
            WeaponEquipmentCard *weaponD = [defender.equipments objectForKey:WEAPONKEY];
            DefenseEquipmentCard *defense = [defender.equipments objectForKey:DEFENSEKEY];
            DefenseHorseCard *defenseHorse = [defender.equipments objectForKey:DEFENSEHORSEKEY];
            AttackHorseCard *attackHorse = [defender.equipments objectForKey:ATTACKHORSEKEY];
            
            if ([weapon.tag  isEqualToString:@"寒冰剑"]) {
                NSLog(@"是否使用寒冰剑(1为是，0为否）");
                
                NSInteger choice = [attacker choiceFrom:0 To:1];
                
                if (choice == 1) {
                    NSLog(@"%@使用了寒冰剑",attacker );
                    
                    NSUInteger cardCount = 1;
                    
                    while (cardCount != 3 && !([defender equipmentsNum]  + [defender.handcards count] == 0)) {
                        
                        
                        while (1) {
                            [defender displayStatusWithHandsCard:NO WithTag:YES];
                            NSLog(@"输入要弃置的第%lu张牌的编号（0~3为装备，4以上为手牌）",cardCount);
                            NSUInteger defendererHandsCount = [defender.handcards count];
                            
                            NSInteger attackerChoice = [attacker choiceFrom:0 To:3 + defendererHandsCount];
                            
                            
                            Card *card;
                            
                            
                            switch (attackerChoice) {

                                case 0:
                                    if (weaponD) {
                                        [defender.equipments removeObjectForKey:WEAPONKEY];
                                        NSLog(@"%@的%@被拆除。",defender ,weaponD);
                                        [[[Environment defaultEnvironment] usefCards]addObject:weaponD];
                                        
                                    }else{
                                        NSLog(@"攻具为空，再次输入。");
                                        continue;
                                    }
                                    break;
                                case 1:
                                    if (defense) {
                                        [defender.equipments removeObjectForKey:DEFENSEKEY];
                                        [[[Environment defaultEnvironment] usefCards]addObject:defense];

                                        NSLog(@"%@的%@被拆除。",attacker ,defense);
                                        
                                    }else{
                                        NSLog(@"防具为空，再次输入。");
                                        continue;
                                    }
                                    break;
                                case 2:
                                    if (defenseHorse) {
                                        [defender.equipments removeObjectForKey:DEFENSEHORSEKEY];
                                        [[[Environment defaultEnvironment] usefCards]addObject:defenseHorse];

                                        NSLog(@"%@的%@被拆除。",defender ,defenseHorse);
                                        
                                    }else{
                                        NSLog(@"防御马为空，再次输入。");
                                        continue;
                                    }
                                    
                                    break;
                                    
                                case 3:
                                    if (attackHorse) {
                                        [defender.equipments removeObjectForKey:ATTACKHORSEKEY];
                                        [[[Environment defaultEnvironment] usefCards]addObject:attackHorse];

                                        
                                        NSLog(@"%@的%@被拆除。",defender ,attackHorse);
                                        
                                    }else{
                                        NSLog(@"攻击马为空，再次输入。");
                                        continue;
                                    }
                                default:
                                    card = [defender.handcards objectAtIndex:attackerChoice - 4];
                                    [[[Environment defaultEnvironment]usefCards]addObject:card];
                                    NSLog(@"%@的%@被拆除。",defender ,card);

                                    [defender.handcards removeObjectAtIndex:attackerChoice - 4];
                                    break;
                            }
                            break;
                        }
                        cardCount++;
                        
                    }
                    
                    
                }else{
                    [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
                    
                }
            }else if([weapon.tag  isEqualToString:@"麒麟弓"]){
                [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
                NSLog(@"是否使用麒麟弓？（1为是，0为否)");
                NSInteger choice = [attacker choiceFrom:0 To:1];
                
                if (choice == 1) {
                    NSLog(@"%@发动了麒麟弓",attacker );
                    if (attackHorse && defenseHorse) {
                        NSLog(@"1拆除-1马，0拆除+1马。");
                        NSInteger attackerChoice = [attacker choiceFrom:0 To:1];
                        if (attackerChoice == 1) {
                            
                            [[[Environment defaultEnvironment]usefCards ]addObject:[defender.equipments objectForKey:ATTACKHORSEKEY]];
                            
                            [defender.equipments removeObjectForKey:ATTACKHORSEKEY];
                            
                            NSLog(@"%@的进攻马被拆除。",defender );
                        }else{
                            
                            [[[Environment defaultEnvironment]usefCards ]addObject:[defender.equipments objectForKey:DEFENSEHORSEKEY]];

                            
                            [defender.equipments removeObjectForKey:DEFENSEHORSEKEY];
                            NSLog(@"%@的防御马被拆除。",defender );
                            
                        }
                    }else if (attackHorse){
                        
                        [[[Environment defaultEnvironment]usefCards ]addObject:[defender.equipments objectForKey:ATTACKHORSEKEY]];

                        [defender.equipments removeObjectForKey:ATTACKHORSEKEY];
                        NSLog(@"%@的进攻马被拆除。",defender );
                    }else if (defenseHorse){
                        
                        [[[Environment defaultEnvironment]usefCards ]addObject:[defender.equipments objectForKey:DEFENSEHORSEKEY]];

                        [defender.equipments removeObjectForKey:DEFENSEHORSEKEY];
                        
                        NSLog(@"%@的防御马被拆除。",defender );
                    }else{
                        NSLog(@"没有可以拆除的马。");
                    }
                    
                    
                }
            }else{
                [defender reduceBlood:1 ByCard:self ByPlayer:attacker];
            }
            
        }
        
    }
    
    return YES;
}

-(BOOL)useBy:(Player *)attacker{
    WeaponEquipmentCard *weapon = [attacker.equipments objectForKey:WEAPONKEY];
    NSArray *participants = [[Environment defaultEnvironment]participants];
    NSInteger count = [participants count];
    NSInteger choice;
    Player *defender;
    
    if ([attacker.handcards count] == 1 && [weapon.tag  isEqualToString: @"方天画戟"]) {
        return [self useFTHJByPlayer:attacker];
    }
    [[Environment defaultEnvironment]displayStatus];

    
    while (1) {
        
        NSLog(@" ");
        
        
        NSLog(@"输入%@要砍的人的位置。（输入-1结束）",attacker );
        choice = [attacker choiceFrom:-1 To:count - 1];
        if (choice == -1) {
            if(self.num == 0){
                NSLog(@"%@放弃使用丈八蛇杖。",attacker );
            }else{
                NSLog(@"%@放弃使用%@",attacker ,[self description]);
            }
            return NO;
        }
        if (choice == attacker.position) {
            NSLog(@"不能自杀的样子。。。");
            continue;
        }
        
        defender = [participants objectAtIndex:choice];
        
        if (defender.alive == NO) {
            NSLog(@"%@阵亡，已退出游戏。",defender );
            continue;
        }
        
        if (![[Environment defaultEnvironment] accessibleFrom:attacker To:defender WithWeapon:YES]) {
            NSLog(@"距离太远，鞭长莫及啊。。。");
            continue;
        
            
        }
        
        
        break;
    }
    
    if (self.type != NONE) {
       [super useBy:attacker];
    }else{
        NSLog(@"%@使用了丈八蛇杖，弃置2张牌，等效打出一张杀。",attacker );
    }

    return [self attackFrom:attacker To:defender WithEquipment:weapon];
    
}


-(NSString *)description{
    NSString *cardTag = [super description];
    
    return [NSString stringWithFormat:@" 杀%@ ",cardTag];
}


//使用青龙偃月刀
/////////////////////////////////////////////////////////////////////////
-(BOOL)UseQLYYDFrom:(Player *)attacker To:(Player *)defender{
    [attacker displayStatusWithHandsCard:YES WithTag:NO];
    NSInteger inputChoice;
    while (1) {
        NSLog(@"%@可以对%@再次出张杀。(-1表示退出)",attacker ,defender );
        
        inputChoice = [attacker choiceFrom:-1 To:[attacker.handcards count]];
        
        
        if (inputChoice == -1) {
            attacker.ableToAttack = NO;
            return NO;
        }
        
        
        Card *card = [attacker.handcards objectAtIndex:inputChoice];
        if (![card isMemberOfClass:[ShaBasicCard class]]) {
            NSLog(@"%@不是杀，请再次输入。",card.description);
            continue;
        }
        
        NSLog(@"%@向%@再次打出张%@",attacker ,defender ,card);
        [attacker.handcards removeObject:card];
        [[[Environment defaultEnvironment]usefCards] addObject:card];
        
        if ([defender shouldUseShanForCard:card ByPlayer:attacker DefenseEquippmentEnabled:YES]) {
            return [self UseQLYYDFrom:attacker To:defender];
        }else{
            attacker.ableToAttack = NO;
            return YES;
        }
        break;
        
    }
    return NO;
}
@end
