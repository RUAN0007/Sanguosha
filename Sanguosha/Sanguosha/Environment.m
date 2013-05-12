//
//  Environment.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-4-7.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Environment.h"
#import "BasicCard.h"
#import "KitsCard.h"
#import "LateKitsCard.h"
#import "EquipmentCard.h"

@interface Environment()
-(void)shuffle;

@end

@implementation Environment

@synthesize participants = _participants;
@synthesize cards = _cards;
@synthesize usefCards = _usefCards;

//创造各种牌
/////////////////////////////////////////////////////////////////////////
+(NSMutableArray *)defaultSGScards{
    ShaBasicCard *sha0 = [[ShaBasicCard alloc]initWithNum:2 Type:CLUB];
    ShaBasicCard *sha1 = [[ShaBasicCard alloc]initWithNum:3 Type:CLUB];
    ShaBasicCard *sha2 = [[ShaBasicCard alloc]initWithNum:4 Type:CLUB];
    ShaBasicCard *sha3 = [[ShaBasicCard alloc]initWithNum:5 Type:CLUB];
    ShaBasicCard *sha4 = [[ShaBasicCard alloc]initWithNum:6 Type:CLUB];
    ShaBasicCard *sha5 = [[ShaBasicCard alloc]initWithNum:7 Type:CLUB];
    ShaBasicCard *sha6 = [[ShaBasicCard alloc]initWithNum:8 Type:CLUB];
    ShaBasicCard *sha7 = [[ShaBasicCard alloc]initWithNum:8 Type:CLUB];
    ShaBasicCard *sha8 = [[ShaBasicCard alloc]initWithNum:9 Type:CLUB];
    ShaBasicCard *sha9 = [[ShaBasicCard alloc]initWithNum:9 Type:CLUB];
    ShaBasicCard *sha10 = [[ShaBasicCard alloc]initWithNum:10 Type:CLUB];
    ShaBasicCard *sha11 = [[ShaBasicCard alloc]initWithNum:10 Type:CLUB];
    ShaBasicCard *sha12 = [[ShaBasicCard alloc]initWithNum:11 Type:CLUB];
    ShaBasicCard *sha13 = [[ShaBasicCard alloc]initWithNum:11 Type:CLUB];
    ShaBasicCard *sha14 = [[ShaBasicCard alloc]initWithNum:7 Type:SPADE];
    ShaBasicCard *sha15 = [[ShaBasicCard alloc]initWithNum:8 Type:SPADE];
    ShaBasicCard *sha16 = [[ShaBasicCard alloc]initWithNum:8 Type:SPADE];
    ShaBasicCard *sha17 = [[ShaBasicCard alloc]initWithNum:9 Type:SPADE];
    ShaBasicCard *sha18 = [[ShaBasicCard alloc]initWithNum:9 Type:SPADE];
    ShaBasicCard *sha19 = [[ShaBasicCard alloc]initWithNum:10 Type:SPADE];
    ShaBasicCard *sha20 = [[ShaBasicCard alloc]initWithNum:10 Type:SPADE];
    ShaBasicCard *sha21 = [[ShaBasicCard alloc]initWithNum:10 Type:DIAMOND];
    ShaBasicCard *sha22 = [[ShaBasicCard alloc]initWithNum:9 Type:DIAMOND];
    ShaBasicCard *sha23 = [[ShaBasicCard alloc]initWithNum:8 Type:DIAMOND];
    ShaBasicCard *sha24 = [[ShaBasicCard alloc]initWithNum:7 Type:DIAMOND];
    ShaBasicCard *sha25 = [[ShaBasicCard alloc]initWithNum:6 Type:DIAMOND];
    ShaBasicCard *sha26 = [[ShaBasicCard alloc]initWithNum:13 Type:DIAMOND];
    ShaBasicCard *sha27 = [[ShaBasicCard alloc]initWithNum:10 Type:HEART];
    ShaBasicCard *sha28 = [[ShaBasicCard alloc]initWithNum:11 Type:HEART];
    ShaBasicCard *sha29 = [[ShaBasicCard alloc]initWithNum:11 Type:HEART];
    
    ShanBasicCard *shan0 = [[ShanBasicCard alloc]initWithNum:2 Type:DIAMOND];
    ShanBasicCard *shan1 = [[ShanBasicCard alloc]initWithNum:2 Type:DIAMOND];
    ShanBasicCard *shan2 = [[ShanBasicCard alloc]initWithNum:3 Type:DIAMOND];
    ShanBasicCard *shan3 = [[ShanBasicCard alloc]initWithNum:4 Type:DIAMOND];
    ShanBasicCard *shan4 = [[ShanBasicCard alloc]initWithNum:5 Type:DIAMOND];
    ShanBasicCard *shan5 = [[ShanBasicCard alloc]initWithNum:6 Type:DIAMOND];
    ShanBasicCard *shan6 = [[ShanBasicCard alloc]initWithNum:7 Type:DIAMOND];
    ShanBasicCard *shan7 = [[ShanBasicCard alloc]initWithNum:8 Type:DIAMOND];
    ShanBasicCard *shan8 = [[ShanBasicCard alloc]initWithNum:9 Type:DIAMOND];
    ShanBasicCard *shan9 = [[ShanBasicCard alloc]initWithNum:10 Type:DIAMOND];
    ShanBasicCard *shan10 = [[ShanBasicCard alloc]initWithNum:11 Type:DIAMOND];
    ShanBasicCard *shan11 = [[ShanBasicCard alloc]initWithNum:11 Type:DIAMOND];
    ShanBasicCard *shan12 = [[ShanBasicCard alloc]initWithNum:13 Type:HEART];
    ShanBasicCard *shan13 = [[ShanBasicCard alloc]initWithNum:2 Type:HEART];
    ShanBasicCard *shan14 = [[ShanBasicCard alloc]initWithNum:2 Type:HEART];
    
    TaoBasicCard *tao0 = [[TaoBasicCard alloc]initWithNum:3 Type:HEART];
    TaoBasicCard *tao1 = [[TaoBasicCard alloc]initWithNum:4 Type:HEART];
    TaoBasicCard *tao2 = [[TaoBasicCard alloc]initWithNum:6 Type:HEART];
    TaoBasicCard *tao3 = [[TaoBasicCard alloc]initWithNum:7 Type:HEART];
    TaoBasicCard *tao4 = [[TaoBasicCard alloc]initWithNum:8 Type:HEART];
    TaoBasicCard *tao5 = [[TaoBasicCard alloc]initWithNum:9 Type:HEART];
    TaoBasicCard *tao6 = [[TaoBasicCard alloc]initWithNum:12 Type:HEART];
    TaoBasicCard *tao7 = [[TaoBasicCard alloc]initWithNum:12 Type:DIAMOND];
    
    
    WeaponEquipmentCard *ZGNL1 = [[WeaponEquipmentCard alloc]initWithNum:0 Type:DIAMOND WithTag:@"诸葛连弩" Distance:1];
    
    WeaponEquipmentCard *ZGNL0 = [[WeaponEquipmentCard alloc]initWithNum:0 Type:CLUB WithTag:@"诸葛连弩" Distance:1];
    
    WeaponEquipmentCard *HBJ = [[WeaponEquipmentCard alloc]initWithNum:2 Type:SPADE WithTag:@"寒冰剑" Distance:2];
    WeaponEquipmentCard *JLG = [[WeaponEquipmentCard alloc]initWithNum:5 Type:HEART WithTag:@"麒麟弓" Distance:5];
    WeaponEquipmentCard *JLYYD = [[WeaponEquipmentCard alloc]initWithNum:5 Type:SPADE WithTag:@"青龙偃月刀" Distance:3];
    WeaponEquipmentCard *CXSGJ = [[WeaponEquipmentCard alloc]initWithNum:2 Type:SPADE WithTag:@"雌雄双股剑" Distance:2];
    WeaponEquipmentCard *QHJ = [[WeaponEquipmentCard alloc]initWithNum:6 Type:SPADE WithTag:@"青红剑" Distance:2];
    WeaponEquipmentCard *FTHJ = [[WeaponEquipmentCard alloc]initWithNum:4 Type:DIAMOND WithTag:@"方天画戟" Distance:4];
    WeaponEquipmentCard *ZBSZ = [[WeaponEquipmentCard alloc]initWithNum:12 Type:SPADE WithTag:@"丈八蛇杖" Distance:3];
    WeaponEquipmentCard *GSF = [[WeaponEquipmentCard alloc]initWithNum:12 Type:SPADE WithTag:@"贯石斧" Distance:3];
    
    
    DefenseEquipmentCard *BGZ0 = [[DefenseEquipmentCard alloc]initWithNum:2 Type:CLUB WithTag:@"八卦阵"];
    DefenseEquipmentCard *BGZ1 = [[DefenseEquipmentCard alloc]initWithNum:2 Type:SPADE WithTag:@"八卦阵"];
    DefenseEquipmentCard *RWD = [[DefenseEquipmentCard alloc]initWithNum:2 Type:CLUB WithTag:@"仁王盾"];
    
    DefenseHorseCard *JY = [[DefenseHorseCard alloc]initWithNum:13 Type:HEART WithTag:@"+1绝影"];
    
    AttackHorseCard *DW = [[AttackHorseCard alloc]initWithNum:13 Type:SPADE WithTag:@"-1大宛"];
    AttackHorseCard *MX = [[AttackHorseCard alloc]initWithNum:13 Type:SPADE WithTag:@"-1马骍"];
    
    AttackHorseCard *CT = [[AttackHorseCard alloc]initWithNum:5 Type:HEART WithTag:@"-1赤兔"];
    
    DefenseHorseCard *DL = [[DefenseHorseCard alloc]initWithNum:13 Type:HEART WithTag:@"+1的卢"];
    DefenseHorseCard *ZHFD = [[DefenseHorseCard alloc]initWithNum:13 Type:HEART WithTag:@"+1爪黄飞电"];
    
    //sha11,sha12,sha13,sha14,sha15,sha16,sha17,sha18,sha19,sha20,sha21,sha22,sha23,sha24,sha25,sha26,sha27,sha28,sha29,
    WXKJKitsCard *WXKJ0 = [[WXKJKitsCard alloc]initWithNum:11 Type:SPADE];
    WXKJKitsCard *WXKJ1 = [[WXKJKitsCard alloc] initWithNum:12 Type:CLUB];
    WXKJKitsCard *WXKJ2 = [[WXKJKitsCard alloc]initWithNum:12 Type:DIAMOND];
    WXKJKitsCard *WXKJ3 = [[WXKJKitsCard alloc]initWithNum:13 Type:CLUB];
    
    JDSRKitsCard *JDSR0 = [[JDSRKitsCard alloc]initWithNum:12 Type:CLUB];
    JDSRKitsCard *JDSR1 = [[JDSRKitsCard alloc]initWithNum:13 Type:CLUB];
    
    GHCQKitsCard *GHCQ0 = [[GHCQKitsCard alloc]initWithNum:3 Type:SPADE];
    GHCQKitsCard *GHCQ1 = [[GHCQKitsCard alloc]initWithNum:3 Type:CLUB];
    GHCQKitsCard *GHCQ2 = [[GHCQKitsCard alloc]initWithNum:4 Type:SPADE];
    GHCQKitsCard *GHCQ3 = [[GHCQKitsCard alloc]initWithNum:4 Type:CLUB];
    GHCQKitsCard *GHCQ4 = [[GHCQKitsCard alloc]initWithNum:12 Type:HEART];
    GHCQKitsCard *GHCQ5 = [[GHCQKitsCard alloc]initWithNum:12 Type:SPADE];
    
    
    SSQYKitsCard *SSQY0 = [[SSQYKitsCard alloc]initWithNum:3 Type:SPADE];
    SSQYKitsCard *SSQY1 = [[SSQYKitsCard alloc]initWithNum:3 Type:DIAMOND];
    SSQYKitsCard *SSQY2 = [[SSQYKitsCard alloc]initWithNum:4 Type:SPADE];
    SSQYKitsCard *SSQY3 = [[SSQYKitsCard alloc]initWithNum:4 Type:DIAMOND];
    SSQYKitsCard *SSQY4 = [[SSQYKitsCard alloc]initWithNum:11 Type:SPADE];
    
    LBSSKitsCard *LBSS0 = [[LBSSKitsCard alloc]initWithNum:4 Type:CLUB];
    LBSSKitsCard *LBSS1 = [[LBSSKitsCard alloc]initWithNum:4 Type:SPADE];
    LBSSKitsCard *LBSS2 = [[LBSSKitsCard alloc]initWithNum:4 Type:HEART];
    
    SDKitsCard *SD0 = [[SDKitsCard alloc]initWithNum:12 Type:HEART];
    SDKitsCard *SD1 = [[SDKitsCard alloc]initWithNum:1 Type:SPADE];
    
    WZSYKitsCard *WZSY0 = [[WZSYKitsCard alloc]initWithNum:7 Type:HEART];
    WZSYKitsCard *WZSY1 = [[WZSYKitsCard alloc]initWithNum:8 Type:HEART];
    WZSYKitsCard *WZSY2 = [[WZSYKitsCard alloc]initWithNum:9 Type:HEART];
    WZSYKitsCard *WZSY3 = [[WZSYKitsCard alloc]initWithNum:11 Type:HEART];
    
    NMRQKitsCard *NMRQ0 = [[NMRQKitsCard alloc]initWithNum:7 Type:SPADE];
    NMRQKitsCard *NMRQ1 = [[NMRQKitsCard alloc]initWithNum:7 Type:CLUB];
    NMRQKitsCard *NMRQ2 = [[NMRQKitsCard alloc]initWithNum:13 Type:SPADE];
    
    
    WJQFKitsCard *WJQF0 = [[WJQFKitsCard alloc]initWithNum:1 Type:HEART];
    
    JDKitsCard *JD0 = [[JDKitsCard alloc]initWithNum:1 Type:SPADE];
    JDKitsCard *JD1 = [[JDKitsCard alloc]initWithNum:1 Type:DIAMOND];
    JDKitsCard *JD2 = [[JDKitsCard alloc]initWithNum:1 Type:CLUB];
    
    WGFDKitsCard *WGFD0 = [[WGFDKitsCard alloc]initWithNum:3 Type:HEART];
    WGFDKitsCard *WGFD1 = [[WGFDKitsCard alloc]initWithNum:4 Type:HEART];
    
    TYJYKitsCard *TYJY0 = [[TYJYKitsCard alloc]initWithNum:1 Type:HEART];

    NSMutableArray *card = [NSArray arrayWithObjects:sha0,sha1,sha2,sha3,LBSS0,LBSS1,LBSS2,SD0,SD1,WZSY0,WZSY1,WZSY2,WZSY3,NMRQ0,NMRQ1,NMRQ2,WJQF0,JD0,JD1,JD2,WGFD0,WGFD1,TYJY0,GHCQ0,GHCQ1,GHCQ2,GHCQ3,GHCQ4,GHCQ5,SSQY0,SSQY1,SSQY2,SSQY3,SSQY4,    ZGNL1,ZGNL0,FTHJ,QHJ,HBJ,JLG,JLYYD,CXSGJ,ZBSZ,GSF, BGZ0,BGZ1,RWD,JY,DW,MX,CT,DL,ZHFD,WXKJ0,WXKJ1,WXKJ2,WXKJ3,JDSR0,JDSR1, GHCQ0,GHCQ1,GHCQ2,GHCQ3,GHCQ4,GHCQ5,SSQY0,SSQY1,SSQY2,SSQY3,SSQY4,sha4,sha5,sha6,sha7,sha8,sha9,sha10,shan0,shan1,shan2,shan3,shan4,shan5,shan6,shan7,shan8,shan9,shan10,shan11,shan12,shan13,shan14, tao0,tao1,tao2,tao3,tao4,tao5,tao6,tao7,sha11,sha12,sha13,sha14,sha15,sha16,sha17,sha18,sha19,sha20,sha21,sha22,sha23,sha24,sha25,sha26,sha27,sha28,sha29,nil];
    
  
    return card;
}


-(id)initWithParticipants:(NSArray *)participants{
    self = [super init];
    if (self) {
        self.participants = participants;
        self.usefCards = [NSMutableArray array];
        self.cards = [Environment defaultSGScards] ;
        [self shuffle];
    }
    return self;
}

+(Environment *)defaultEnvironment{
    static Environment *defaultEnvironment = nil;
    BOOL validity;
    if(!defaultEnvironment){
        NSMutableArray *roleArray = [NSMutableArray arrayWithObjects:@"曹操",@"孙权",@"张角",@"刘备", nil];

        
        NSMutableArray *participants = [NSMutableArray arrayWithCapacity:4];
        NSString *description = @"可供选择的角色：";
        NSUInteger choice;
        
        char name[4][30];
        for (NSInteger index = 0; index < 4; index++) {
            NSLog(@"输入第%ld位玩家的名称： ",index + 1);
            fseek(stdin,0,SEEK_END);
            scanf("%s",name[index]);
            NSString *Name = [NSString stringWithCString: name[index] encoding: NSASCIIStringEncoding];
            description = @"可供选择的角色：";
            for (NSInteger count = 0; count < [roleArray count]; count++) {
                description = [description stringByAppendingFormat:@"%ld)%@   ",count,[roleArray objectAtIndex:count]];
            }
            
            NSLog(@"%@",description);
            NSLog(@"输入第%ld位玩家选择的角色编号。",index + 1);
            fseek(stdin,0,SEEK_END);

            validity = scanf("%lu",&choice);
            
            while (!validity || choice >= [roleArray count]) {
                
                NSLog(@"无效输入。");
                NSLog(@" ");
                NSLog(@"%@",description);
                NSLog(@"输入第%ld位玩家选择的角色编号。",index + 1);
                fseek(stdin, 0, SEEK_END);
                validity = scanf("%lu",&choice);

            }
            
            NSString *role = [roleArray objectAtIndex:choice];
            [roleArray removeObjectAtIndex:choice];
            
            if ([role isEqualToString:@"曹操"]) {
                Player *p = [[CaoCao alloc]initWithTag:Name Position:index];
                [participants addObject:p];
            }else if([role isEqualToString:@"刘备"]){
                Player *p = [[LiuBei alloc]initWithTag:Name Position:index];
                [participants addObject:p];
            }else if ([role isEqualToString:@"孙权"]){
                Player *p = [[SunQuan alloc]initWithTag:Name Position:index];
                [participants addObject:p];
            }else if ([role isEqualToString:@"张角"]){
                Player *p = [[ZhangJiao alloc]initWithTag:Name Position:index];
                [participants addObject:p];
            }else{
                [NSException raise:@"Invalid role" format:nil];
            }
            

            NSLog(@"第%lu位玩家选择了%@",index + 1,role);
            NSLog(@" ");

        }
        
        
        
        defaultEnvironment = [[Environment alloc]initWithParticipants:participants];
        
    
        
    }
    return defaultEnvironment;


}

-(Card *)popCard{
    if ([self.cards count] == 0) {
        self.cards = [self.usefCards copy];
        [self.usefCards removeAllObjects];
        [self shuffle];
    }
    
    Card *card = [self.cards objectAtIndex:0];
    [self.cards removeObjectAtIndex:0];
    return card;
}

-(Card *)judgeFromPlayer:(Player *)p{
    
    Card *judgeCard = [self popCard];
    NSLog(@"判定牌为%@",judgeCard);
    
    NSInteger index = p.position;
//若玩家中有张角，判断是否使用技能鬼道
//////////////////////////////////////////////////////////////////////

    for (NSInteger i = 0; i < [self.participants count]; i++) {
        Player *p0 = [self.participants objectAtIndex:(index + i) % [self.participants count]];
        if (p0.alive && [p0 isMemberOfClass:[ZhangJiao class]]) {
            NSLog(@"%@:是否发动技能“鬼道”？（1为是，0为否）",p0 );
            NSInteger choice = [p0 choiceFrom:0 To:1];
            if (choice == 1) {
                Card *subCard;

                [p0 displayStatusWithHandsCard:YES WithTag:YES];
                while (1) {
                    if ([p0.handcards count] == 0) {
                        NSLog(@"请打出一张黑色手牌替换判定牌%@(0~3为装备)",judgeCard);

                    }else{
                        NSLog(@"请打出一张黑色手牌替换判定牌%@(-1放弃使用，0~3为装备,4及以上为手牌)",judgeCard);

                    }
                    NSInteger cardChoice = [p0 choiceFrom:-1 To:[p0.handcards count] + 3];
                    
                    WeaponEquipmentCard *weapon = [p0.equipments objectForKey:WEAPONKEY];
                    DefenseEquipmentCard *defense = [p0.equipments objectForKey:DEFENSEKEY];
                    DefenseHorseCard *defenseHorse = [p0.equipments objectForKey:DEFENSEHORSEKEY];
                    AttackHorseCard *attackHorse = [p0.equipments objectForKey:ATTACKHORSEKEY];

                    switch (cardChoice) {
                        case -1:
                            NSLog(@"%@放弃使用技能“鬼道”。",p0);
                            return judgeCard;
                        case 0:
                            if (!weapon) {
                                NSLog(@"攻具为空。");
                                continue;
                            }
                            if (weapon.type == CLUB || weapon.type == SPADE) {
                                subCard = weapon;
                                [p0.equipments removeObjectForKey:WEAPONKEY];
                            }else{
                                NSLog(@"请打出一张黑色牌。");
                                continue;
                            }
                            break;
                        case 1:
                            if (!defense) {
                                NSLog(@"防具为空。");
                                continue;
                            }
                            if (defense.type == CLUB || defense.type == SPADE) {
                                subCard = defense;
                                [p0.equipments removeObjectForKey:DEFENSEKEY];
                            }else{
                                continue;
                            }
                            break;
                        case 2:
                            if (!defenseHorse) {
                                NSLog(@"防御马为空。");
                                continue;
                            }
                            if (defenseHorse.type == CLUB || defenseHorse.type == SPADE) {
                                subCard = defenseHorse;
                                [p0.equipments removeObjectForKey:DEFENSEHORSEKEY];
                            }else{
                                continue;
                            }
                            break;
                        case 3:
                            if (!attackHorse) {
                                NSLog(@"进攻马为空。");
                                continue;
                            }
                            if (attackHorse.type == CLUB || attackHorse.type == SPADE) {
                                subCard = attackHorse;
                                [p0.equipments removeObjectForKey:ATTACKHORSEKEY];
                            }else{
                                continue;
                            }
                            break;
                        default:
                            subCard = [p0.handcards objectAtIndex:cardChoice - 4];
                            if (subCard.type == CLUB || subCard.type == SPADE) {
                                [p0.handcards removeObject:subCard];
                            }else{
                                continue;
                            }
                            break;
                    }
                    break;
                }
                
                NSLog(@"%@发动技能”鬼道“,打出%@替换%@",p0 ,subCard,judgeCard);
                
                [self.usefCards addObject:subCard];
                [p0.handcards addObject:judgeCard];
                judgeCard = subCard;

                
            };
            
        }
    }
    
    return judgeCard;
}


-(void)shuffle{
    NSUInteger count = [self.cards count];
    NSMutableArray *mutalbeCardSet = [self.cards mutableCopy];
    for (int i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger n = arc4random() % count;
        
        [mutalbeCardSet exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    self.cards = mutalbeCardSet;
    
}

-(BOOL)IsGameEndedWithDeadPlayer:(Player *)p{
//濒死状态，挨个求桃。
///////////////////////////////////////////////
    bool saveFlag;
    
    while (p.bloodLeft <= 0) {
        
        saveFlag = NO;
        for (Player *p0 in self.participants) {
            if (!p.alive) {
                continue;
            }
            NSLog(@"%@向%@求%ld个桃\n",p ,p0 ,1 - p.bloodLeft);
            
            if ([p0 shouldUseTaoForPlayer:p]) {
                saveFlag = YES;
                break;
            }
        }
        if (!saveFlag) {
            
            p.alive = NO;
            NSLog(@"%@阵亡。",p );
            break;
        };
    }
    if (p.alive) {
        return NO;
    }
//将阵亡玩家的牌置入弃牌堆
//////////////////////////////////////////////////////////////////////
    
    NSString *description = [NSString stringWithFormat: @"%@手牌，装备牌以及判定牌：",p];
    for (Card *card in p.handcards) {
        description = [description stringByAppendingFormat:@"%@ ",card];
    }
    
    WeaponEquipmentCard *weapon = [p.equipments objectForKey:WEAPONKEY];
    if (weapon) {
        description = [description stringByAppendingFormat:@"%@ ",weapon];
    }
    
    DefenseEquipmentCard *defense = [p.equipments objectForKey:DEFENSEKEY];
    if (defense) {
        description = [description stringByAppendingFormat:@"%@ ",defense];
    }
    
    DefenseHorseCard *defenseHorse = [p.equipments objectForKey:DEFENSEHORSEKEY];
    if (defenseHorse) {
        description = [description stringByAppendingFormat:@"%@ ",defenseHorse];
    }
    
    AttackHorseCard *attackHorse = [p.equipments objectForKey:ATTACKHORSEKEY];
    if (attackHorse) {
        description = [description stringByAppendingFormat:@"%@ ",attackHorse];
    }
    
    
    
    for (Card *card in p.judgecards) {
        description = [description stringByAppendingFormat:@"%@ ",card];
    }
    
    NSLog(@"%@置入弃牌堆。",description);
    
//判定阵亡玩家的对家是否存活，并判定游戏是否结束。
//////////////////////////////////////////////////////////////////////
    
    Player *partner;

    switch (p.position) {
        case 0:
            partner = [self.participants objectAtIndex:2];
            break;
        case 1:
            partner = [self.participants objectAtIndex:3];
            break;
        case 2:
            partner = [self.participants objectAtIndex:0];
            break;
        case 3:
            partner = [self.participants objectAtIndex:1];
            break;
        default:
            [NSException raise:@"Invalid Player" format:nil];
            break;
    }
    
    if (!partner.alive) {
        NSUInteger winners[2];
        NSUInteger indx = 0;
        for (NSUInteger index = 0; index < 4; index++) {
            if (index !=p.position && index != partner.position) {
                winners[indx++] = index;
            }
        }
        NSLog(@" ");
        NSString *description = @"胜利者是: ";
        for (NSUInteger index = 0; index < 2; index++) {
            Player *winner = [self.participants objectAtIndex:winners[index]];
            description = [description stringByAppendingFormat:@"%@ ",winner ];
        }
        
        NSLog(@"%@。倒霉蛋是%@ %@。",description,p,partner);
        
        
        exit(0);
        
        return YES;
    }
    return NO;
}

//判定两位玩家的距离是否足够
////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)accessibleFrom:(Player *)attacker To:(Player *)defender WithWeapon:(BOOL)weaponEnabled{
    NSInteger distanceAttack = 1;
    WeaponEquipmentCard *attackerWeapon = [attacker.equipments objectForKey:WEAPONKEY];

    if (weaponEnabled && attackerWeapon) {
        distanceAttack = attackerWeapon.distance;
    }
    
    
    
    [attacker.equipments objectForKey:ATTACKHORSEKEY]?distanceAttack++:distanceAttack;
    
    NSInteger distanceDefense1 = 1,distanceDefense2 = 1;
    NSInteger distanceDefense ;
    
    NSInteger index;
    
    index = (attacker.position - 1) % [self.participants count];
    
    while (index != defender.position) {
        if ([[self.participants objectAtIndex:index] alive]) {
            distanceDefense1++;
        }
        
        index--;
        index %= [self.participants count];
    }
    
    index = (attacker.position + 1) % [self.participants count];

    while (index != defender.position) {
        if ([[self.participants objectAtIndex:index] alive]) {
            distanceDefense2++;
        }
        
        index++;
        index %= [self.participants count];
    }
    
    distanceDefense = distanceDefense1 > distanceDefense2?distanceDefense2:distanceDefense1;
    [defender.equipments objectForKey:DEFENSEHORSEKEY]?distanceDefense++:distanceDefense;

    
    return distanceAttack >= distanceDefense;
}

-(void)start{
    
//每位玩家抓4张牌
////////////////////////////////////////////////////////////////////////////////////////////////
    for (Player *p in self.participants){
        [p retrieveCards:4];
    }
    
//每位玩家轮流出牌
////////////////////////////////////////////////////////////////////////////////////////////////
    while (1) {
        for (Player *p in self.participants){
            if(p.alive) [p play];
        }
    }

}

-(NSInteger)alivePlayers{
    NSInteger count = 0;
    for (Player *p in self.participants){
        if (p.alive) {
            count++;
        }
    }
    return count;

}

-(void)displayStatus{
    for  (Player *p in self.participants){
        if(p.alive) [p displayStatusWithHandsCard:NO WithTag:NO];
    }
    NSLog(@" ");
}

@end
