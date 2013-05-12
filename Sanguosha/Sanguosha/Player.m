
//
//  Player.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-22.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Player.h"

#import "EquipmentCard.h"
#import "BasicCard.h"
#import "KitsCard.h"
#import "LateKitsCard.h"

#import "Environment.h"


@implementation Player
@synthesize position = _position;
@synthesize bloodLeft = _bloodLeft;
@synthesize maxBlood = _maxBlood;
@synthesize ableToAttack = _ableToAttack;
@synthesize equipments = _equipments;
@synthesize handcards = _handcards;
@synthesize alive = _alive;
@synthesize tag = _tag;
@synthesize judgecards = _judgecards;




-(id)initWithBlood:(NSUInteger )blood position:(NSUInteger)position Tag:(NSString *)tag{
    self = [super init];
    if (self) {
        self.position = position;
        self.bloodLeft = 4;
        self.maxBlood = 4;
        self.ableToAttack = YES;
        self.tag  = tag;
        self.alive = YES;
        self.equipments = [NSMutableDictionary dictionaryWithCapacity:4];
        self.handcards = [NSMutableArray array];
        self.judgecards = [NSMutableArray array];
    

       
    }
    return self;
}
// 若handsCardOn == YES, 展示每一张手牌。
// 若tagOn == YES,为每一张展示的牌注明编号。
/////////////////////////////////////////////////////////////////////////
-(void)displayStatusWithHandsCard:(BOOL)handsCardOn WithTag:(BOOL)tagOn{
    
    int index;
    
    NSString *status;
    NSInteger count;
    NSString *bloodAmount = @"";
    NSString *cardsAmount = @"";
    status = self.alive?@"是":@"否";
    NSLog(@" ");
    NSLog(@"名称：%@    存活:%@   位置：%lu",self ,status,self.position);
    for (count = 0; count < self.bloodLeft; count++) {
        bloodAmount = [bloodAmount stringByAppendingString:@"♥ "];
    }
    for (; count < self.maxBlood; count++) {
        bloodAmount = [bloodAmount stringByAppendingString:@"* "];
    }
    if (!handsCardOn) {
        for (count = 0; count < [self.handcards count]; count++) {
            if (tagOn) {
                cardsAmount = [cardsAmount stringByAppendingFormat:@"%lu)# ",4 + count];

            }else{
                cardsAmount = [cardsAmount stringByAppendingString:@"# "];
            }
        }
        NSLog(@"血量：%@    手牌数：%@",bloodAmount,cardsAmount);

    }else{
        NSLog(@"血量：%@",bloodAmount);
    }

    

    


    
    NSString *weapon = [self.equipments objectForKey:WEAPONKEY]?[[self.equipments objectForKey:WEAPONKEY] description]:@"空 ";
    NSString *defense = [self.equipments objectForKey:DEFENSEKEY]?[[self.equipments objectForKey:DEFENSEKEY] description]:@" 空 ";
    NSString *defenseHorse = [self.equipments objectForKey:DEFENSEHORSEKEY]?[[self.equipments objectForKey:DEFENSEHORSEKEY] description]:@" 空 ";
    NSString *attackHorse = [self.equipments objectForKey:ATTACKHORSEKEY]?[[self.equipments objectForKey:ATTACKHORSEKEY] description]:@" 空 ";
    if (tagOn) {
        weapon = [NSString stringWithFormat:@"0)%@",weapon];
        defense = [NSString stringWithFormat:@"1)%@",defense];
        defenseHorse = [NSString stringWithFormat:@"2)%@",defenseHorse];
        attackHorse = [NSString stringWithFormat:@"3)%@",attackHorse];
    }

    
    NSLog(@"武器: %@ 盾牌: %@ +1马: %@ -1马： %@",weapon,defense,defenseHorse,attackHorse);
    
    
    NSString *judgeCardDescription = @"判定区： ";
    
    for (NSInteger index = 0; index < [self.judgecards count]; index++) {
        if (tagOn) {
            judgeCardDescription = [judgeCardDescription stringByAppendingFormat:@"%ld)%@  ",index + 4 + [self.handcards count],[self.judgecards objectAtIndex:index]];

        }else{
            judgeCardDescription = [judgeCardDescription stringByAppendingFormat:@"%ld)%@  ",index,[self.judgecards objectAtIndex:index]];
        }
    }
    
    if ([self.judgecards count] == 0) {
        judgeCardDescription = [judgeCardDescription stringByAppendingString:@"(空）"];
    }
    NSLog(@"%@",judgeCardDescription);

    if (handsCardOn) {
        
        NSString *handCard = [NSString stringWithFormat:@"%@的手牌: ",self ];
        
        for (index = 0; index < [self.handcards count]; index++) {
            if (!tagOn) {
                handCard = [handCard stringByAppendingFormat:@"%d)%@  ",index,[self.handcards objectAtIndex:index]];

            }else{
                handCard = [handCard stringByAppendingFormat:@"%d)%@  ",index + 4,[self.handcards objectAtIndex:index]];

            }
        }
        NSLog(@"%@",handCard);

    }

    
}


-(void)reduceBlood:(NSInteger)num ByCard:(id)card ByPlayer:(Player *)p1{
    self.bloodLeft -= num;
    NSLog(@"%@损失了%ld滴血。",self ,num);
    
    if (self.bloodLeft <= 0) {
        NSLog(@"%@进入濒死状态。",self );
        [[Environment defaultEnvironment] IsGameEndedWithDeadPlayer:self];

    }
   
    return;
}



//判定阶段，返回是否可以出牌
/////////////////////////////////////////////////////////////////////////
-(BOOL)judgePhase{
    BOOL ableToPlay = YES;
    NSArray *participants = [[Environment defaultEnvironment]participants];
    
    NSInteger count = [self.judgecards count];
    for(NSInteger index = 0;index < count;index++){
        LateKitsCard *card = [self.judgecards objectAtIndex:0];
        if ([card isMemberOfClass:[LBSSKitsCard class]]) {
            
            
            if ([card judgeForPlayer:self]) {
                NSLog(@"%@的%@生效",self ,card);
                ableToPlay = NO;
            }else{
                
                NSLog(@"%@的%@失效",self ,card);
                
            }
            
            [self.judgecards removeObjectAtIndex:0];
            [[[Environment defaultEnvironment]usefCards]addObject:card];
            
            
        }else if([card isMemberOfClass:[SDKitsCard class]]){
            if ([card judgeForPlayer:self]) {
                NSLog(@"%@的%@生效。",self ,card);
                [self reduceBlood:3 ByCard:card ByPlayer:self];
                [self.judgecards removeObjectAtIndex:0];
                [[[Environment defaultEnvironment]usefCards]addObject:card];

                
            }else{
                NSLog(@"%@的%@失效。",self ,card);
                BOOL Full = YES;
                
                for (NSInteger index = 1; index < [[Environment defaultEnvironment] alivePlayers];index++  ) {
                    Player *p = [participants objectAtIndex:(index + self.position) % [[Environment defaultEnvironment] alivePlayers]];
                    
                    BOOL SHANDIAN = NO;
                    
                    for (Card *card0 in p.judgecards){
                        if ([card0 isMemberOfClass:[SDKitsCard class]]) {
                            SHANDIAN = YES;
                            break;
                        }
                    }
                    
                    if (!SHANDIAN) {
                        [p.judgecards addObject:card];
                        Full = NO;
                        break;
                    }
                    
                }
                
                if (!Full) {
                    [self.judgecards removeObjectAtIndex:0];
                }
                
                
                
            }
        }else{
            [NSException raise:@"Invalid 延时性锦囊" format:nil];
        }
    }
    

    return ableToPlay;
}

//拿牌阶段
////////////////////////////////////////////
-(void)retrieveCards:(NSUInteger) num{
    NSLog(@"%@从牌堆中摸出%lu张牌： ",self.description ,num);
    
    for (int index = 0; index < num; index++) {
        Card *cardA = [[Environment defaultEnvironment] popCard];
        [self.handcards addObject:cardA];
        
    }
}

//出牌阶段
/////////////////////////////////////////////////////////////////////////
-(BOOL)deliverPhase{
    WeaponEquipmentCard *weapon = [self.equipments objectForKey:WEAPONKEY];

    NSInteger choice,round = 1;
    NSLog(@"回合%ld",round++);
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@" ");
    NSLog(@"输入%@要出的牌的编号： (输入-1结束回合)：",self);
    
    if ([weapon.tag  isEqualToString:@"丈八蛇杖"]) {
        NSLog(@"输入-2发动装备区的丈八蛇杖。");
        choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
    }else{
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    }
    
    
    while (choice != -1) {
        
        Card *card;

        if(choice != -2) card = [self.handcards objectAtIndex:choice];
        
        if ([card isMemberOfClass:[ShanBasicCard class]]) {
            NSLog(@"“闪“不能在你的回合里使用。\n");
        }else if([card isMemberOfClass:[ShaBasicCard class]]){
            if (self.ableToAttack) {
                
                
                [(ShaBasicCard *)card useBy:self];
                
                
            }else{
                if ([weapon.tag  isEqualToString:@"诸葛连弩"]) {
                    NSLog(@"%@发动了诸葛连弩",self );
                    [(ShaBasicCard *)card useBy:self];

                }else{
                
                    NSLog(@"此回合你已经使用过“杀”,此“杀”无效。\n");
                }
            }
        }else if(choice == -2){
            if (self.ableToAttack && [self.handcards count] + [self equipmentsNum] >= 2) {
                [self useZBSZForAttack:YES];
            }else{
                NSLog(@"此回合你已经使用过“杀”,或你的牌数小于2张，丈八蛇杖发动失败。\n");
            }
        }else if([card isMemberOfClass:[TaoBasicCard class]]){
            [(TaoBasicCard *)card useBy:self ForPlayer:self];
        }else if([card isMemberOfClass:[WXKJKitsCard class]]){
            NSLog(@"“无懈可击“不能在你的回合里使用。\n");

        }else{
            [card useBy:self];
            weapon = [self.equipments objectForKey:WEAPONKEY];
            
        }
        
        if (self.alive == NO) {
            return NO;
        }
        NSLog(@" ");
        NSLog(@"回合%ld",round++);

        [self displayStatusWithHandsCard:YES WithTag:NO];
        
        NSLog(@" ");
        NSLog(@"输入%@要出的牌的编号： (输入-1结束回合)：",self );
        
        if ([weapon.tag  isEqualToString:@"丈八蛇杖"]) {
            NSLog(@"输入-2发动装备区的丈八蛇杖。");
            choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
        }else{
            choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
            
            
        }
        
    }

    return YES;
}
//弃牌阶段
/////////////////////////////////////////////////////////////////////////

-(void)desertPhase{
    
    NSInteger num = [self.handcards count] - self.bloodLeft;
    while (num > 0) {
        [self displayStatusWithHandsCard:YES WithTag:NO];
        
        NSLog(@"%@需要弃置%ld张牌",self ,num);
        
        NSInteger desertCardsNo;
        desertCardsNo = [self choiceFrom:0 To:[self.handcards count] - 1 ];
        NSLog(@"%@弃置了%@",self,[self.handcards objectAtIndex:desertCardsNo]);
        [[[Environment defaultEnvironment]usefCards]addObject:[self.handcards objectAtIndex:desertCardsNo]];

        [self.handcards removeObjectAtIndex:desertCardsNo];
        
        num--;
    }
}

//开始自己的回合
/////////////////////////////////////////////////////////////////////////
-(void)play{
    self.ableToAttack = YES;
    BOOL judge = YES;
    NSLog(@" ");
    if ([self.judgecards count] != 0) {
        NSLog(@"%@的判定阶段。",self );
        judge = [self judgePhase];
    }
    
    if (self.alive == NO) {
        return;
    }
    NSLog(@" ");

    NSLog(@"%@的摸牌阶段。",self );
    [self retrieveCards:2];
    
    NSLog(@" ");

    if(judge){
        
        NSLog(@"%@的出牌阶段。",self );
        if(![self deliverPhase]){
            return;
        };
    }
    
    NSLog(@" ");

    if (self.bloodLeft < [self.handcards count]) {
        NSLog(@"%@的弃牌阶段。",self );
        [self desertPhase];
    }

    
    

}


//使用丈八蛇杖时，此方法被触发
/////////////////////////////////////////////////////////////////////////
-(ShaBasicCard *)useZBSZForAttack:(BOOL)attack{
    
    NSUInteger c0,c1;
    ShaBasicCard *SHAZBSZ;
    
    Card *card0;
    Card *card1;

    
    while (1) {
        NSLog(@"丈八蛇杖使用中。请输入2张要打出的手牌:");
        c0 = [self choiceFrom:0 To:[self.handcards count] - 1];
        c1 = [self choiceFrom:0 To:[self.handcards count] - 1];
        while (c0 == c1) {
            NSLog(@"相同的卡牌，无效");
            NSLog(@"丈八蛇杖使用中。请输入2张要打出的手牌:");
            c0 = [self choiceFrom:0 To:[self.handcards count] - 1];
            c1 = [self choiceFrom:0 To:[self.handcards count] - 1];
            
        }
        card0 = [self.handcards objectAtIndex:c0];
        card1 = [self.handcards objectAtIndex:c1];
        if ((card0.type == SPADE || card0.type == CLUB) &&(card1.type  == SPADE || card1.type == CLUB) ) {
            SHAZBSZ = [[ShaBasicCard alloc]initWithNum:-1 Type:NONE];
        }else{
            SHAZBSZ = [[ShaBasicCard alloc]initWithNum:-1 Type:NONE];

        }
        break;
        
    }
    if (attack) {
        if ([SHAZBSZ useBy:self]) {

            [self.handcards removeObject:card0];
            [self.handcards removeObject:card1];
            [[[Environment defaultEnvironment]usefCards]addObject:card0];
            [[[Environment defaultEnvironment]usefCards]addObject:card1];

            
        }
        

    }else{
        NSLog(@"%@发动了丈八蛇杖，弃置了%@和%@，等效打出一张杀",self ,card0,card1);
        
        [self.handcards removeObject:card0];
        [self.handcards removeObject:card1];
        [[[Environment defaultEnvironment]usefCards]addObject:card0];
        [[[Environment defaultEnvironment]usefCards]addObject:card1];

    }
    return SHAZBSZ;

}

-(TaoBasicCard *)shouldUseTaoForPlayer:(Player *)gamer{
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@" ");

    NSLog(@"请输入编号（-1表示不出）:");
    
    NSInteger choice;
    choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1 && ![[self.handcards objectAtIndex:choice] isMemberOfClass:[TaoBasicCard class]]) {
        NSLog(@"出牌无效，请再次输入");
        NSLog(@"请输入编号（-1表示不出): ");

        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];

    }
    
    if (choice == -1) {
        return nil;
    }else{
        TaoBasicCard *tao = [self.handcards objectAtIndex:choice];
        [tao useBy:self ForPlayer:gamer];
        return tao;
    }

}


-(BOOL)shouldUseWXKJForCard:(id)card ForPlayer:(Player *)receiver ByPlayer:(Player *)sender{
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@" ");

    if (sender) {
        NSLog(@"%@:是否为%@对%@发出的%@打出一张“无懈可击”：",self,sender,receiver ,card);

    }else{
        NSLog(@"%@:是否为%@使用的%@打出一张“无懈可击”：",self,receiver ,card);

    }
    
    NSLog(@"请输入编号（-1表示不出）:");
    
    NSInteger choice;
    choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1 && ![[self.handcards objectAtIndex:choice] isMemberOfClass:[WXKJKitsCard class]]) {
        NSLog(@"出牌无效，请再次输入");
        NSLog(@"请输入编号（-1表示不出): ");
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
        
    }
    
    if (choice == -1) {
        return NO;
    }else{
        WXKJKitsCard *cardWX = [self.handcards objectAtIndex:choice];
        
        return [cardWX useBy:self];
    }

}





-(ShaBasicCard *)shouldUseShaForCard:(Card *)card ByPlayer:(Player *)sender{

    
    [self displayStatusWithHandsCard:YES WithTag:NO];
    
    NSLog(@" ");
    
    NSLog(@"%@:请为%@的%@打出一张杀(-1表示不出）",self ,sender ,card);
    WeaponEquipmentCard *weapon = [self.equipments objectForKey:WEAPONKEY];

    
    if ([weapon.tag  isEqualToString:@"丈八蛇杖"] && ([self.handcards count] + [self equipmentsNum] >= 2)) {
        NSLog(@"是否发动丈八蛇杖?（1为是，0为否)");
        NSInteger choice = [self choiceFrom:0 To:1];
        if (choice == 1) {
            return [self useZBSZForAttack:NO];
        }
        
    }
    
    NSInteger choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1 && ![[self.handcards objectAtIndex:choice] isMemberOfClass:[ShaBasicCard class]]) {
        NSLog(@"出牌无效，再次输入编号： ");
        NSLog(@"请为%@的%@打出一张杀(-1表示不出）",sender ,card);
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
        
    }
    if (choice == -1) {
        return nil;
    }else{
        ShaBasicCard *cardSha = [self.handcards objectAtIndex:choice];
        [self.handcards removeObjectAtIndex:choice];
        [[[Environment defaultEnvironment]usefCards]addObject:cardSha];
        NSLog(@"%@为%@的%@打出一张%@(-1表示不出）",self ,sender ,card,cardSha);
        return cardSha;
    }
    

}

-(BOOL)shouldUseShanForCard:(Card *)card ByPlayer:(Player *)sender DefenseEquippmentEnabled:(BOOL)defenseEnabled{
    [self displayStatusWithHandsCard:YES WithTag:NO];
    DefenseEquipmentCard *defense = [self.equipments objectForKey:DEFENSEKEY];
    if ([card isMemberOfClass:[ShaBasicCard class]]) {
        if (defenseEnabled && [defense defendFor:card ForPlayer:self]   ) {
            return YES;
        }
    }else{
        if ([defense.tag  isEqualToString:@"八卦阵"] && [defense defendFor:card ForPlayer:self]) {
            return YES;
        }
    }
    NSLog(@" ");
    if (card.type == NONE) {
        NSLog(@"请%@为%@的杀出一张“闪”： \n",self ,sender);

    }else{
        NSLog(@"请%@为%@的%@出一张“闪”： \n",self ,sender ,card);

    }

    NSLog(@"请输入编号（-1表示不出）:");
    NSInteger choice;
    choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1 && ![[self.handcards objectAtIndex:choice] isMemberOfClass:[ShanBasicCard class]]) {
        NSLog(@"出牌无效，请再次输入");
        NSLog(@"请输入编号（-1表示不出): ");
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
        
    }
    
    if (choice == -1) {
        return NO;
    }else{
        ShanBasicCard *shan = [self.handcards objectAtIndex:choice];
        [shan useBy:self];
        return YES;
    }
    

}



-(NSInteger)choiceFrom:(NSInteger)bottom To:(NSInteger)top{
    NSInteger choice;
    int input;
    while (1) {
        NSLog(@"请%@输入一个%ld到%ld的整数。",self ,bottom,top);
        fseek(stdin,0,SEEK_END);

        input = scanf("%ld",&choice);

        if (input == 0||choice < bottom || choice > top) {
            fseek(stdin,0,SEEK_END);
            NSLog(@"无效输入，再次输入: ");
            continue;
        }
    return choice;
    }
}

-(NSInteger)equipmentsNum{
    NSInteger count = 0;
    if ([self.equipments objectForKey:WEAPONKEY]) {
        count++;
    }
    if ([self.equipments objectForKey:DEFENSEKEY]) {
        count++;
    }
    if ([self.equipments objectForKey:DEFENSEHORSEKEY]) {
        count++;
    }
    if ([self.equipments objectForKey:ATTACKHORSEKEY]) {
        count++;
    }
    return count;
}

@end

@implementation CaoCao

//当可以发动技能“奸雄”的时候，此方法被触发
/////////////////////////////////////////////////////////////////////////

-(void)reduceBlood:(NSInteger)num ByCard:(Card *)card ByPlayer:(Player *)p1{
    [super reduceBlood:num ByCard:card ByPlayer:p1];
    if (card && self.alive) {
        NSLog(@"是否发动技能“奸雄”？（1为是，0为否）");
        NSInteger choice = [self choiceFrom:0 To:1];
        if (choice == 1) {
            NSLog(@"%@发动了技能“奸雄”，获得%@。",self ,card);
            [self.handcards addObject:card];
        }
    }

}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@(曹操)",self.tag ];
}

-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position{
    self = [super initWithBlood:4 position:position Tag:tag];
    return self;
}


@end

@implementation ZhangJiao

//当选择发动技能“雷击”的时候，此方法被触发
/////////////////////////////////////////////////////////////////////////

-(void)Thunder{
    
    NSLog(@"是否发动技能“雷击”？（1为是，0为否）");
    NSInteger choice = [self choiceFrom:0 To:1];
    
    if (choice == 1) {
        Player *receiver;
        while (1) {
            [[Environment defaultEnvironment] displayStatus];
            NSLog(@"输入使用雷击目标的位置：");
            NSInteger count = [[[Environment defaultEnvironment] participants] count];
            NSInteger choice = [self choiceFrom:0 To:count - 1];
            
            if (choice == self.position) {
                NSLog(@"呃呃呃，不能这么想不开吧。。。重新输入目标的位置。");
                continue;
            }
            receiver = [[[Environment defaultEnvironment] participants] objectAtIndex:choice];
            break;
            
        }
        NSLog(@"%@对%@发动技能“雷击“。",self ,receiver);

        if ([[[Environment defaultEnvironment] judgeFromPlayer:receiver] type] == SPADE) {
            NSLog(@"“雷击“技能生效,%@掉了2滴血。”。",receiver);
            [receiver reduceBlood:2 ByCard:nil ByPlayer:self];
        }else{
            NSLog(@"”雷击”失效。");
        }

    }
    


}
//若八卦阵被触发或打出一张闪，询问玩家是否使用雷击
/////////////////////////////////////////////////////////////////////////
-(BOOL)shouldUseShanForCard:(Card *)card ByPlayer:(Player *)sender DefenseEquippmentEnabled:(BOOL)defenseEnabled{
    DefenseEquipmentCard *defense = [self.equipments objectForKey:DEFENSEKEY];
    [self displayStatusWithHandsCard:YES WithTag:NO];

    if ([card isMemberOfClass:[ShaBasicCard class]]) {
        if (defenseEnabled && [defense defendFor:card ForPlayer:self]   ) {
            if ([defense.tag  isEqualToString:@"八卦阵"]) {
                [self Thunder];
            }
            return YES;
        }
    }else{
        if ([defense.tag  isEqualToString:@"八卦阵"] && [defense defendFor:card ForPlayer:self]) {
            [self Thunder];

            return YES;
        }
    }
    NSLog(@" ");

    
    if (card.type == NONE) {
        NSLog(@"请%@为%@的杀出一张“闪”： \n",self ,sender);
        
    }else{
        NSLog(@"请%@为%@的%@出一张“闪”： \n",self ,sender ,card);
        
    }
    NSLog(@"请输入编号（-1表示不出）:");
    NSInteger choice;
    choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1 && ![[self.handcards objectAtIndex:choice] isMemberOfClass:[ShanBasicCard class]]) {
        NSLog(@"出牌无效，请再次输入");
        NSLog(@"请输入编号（-1表示不出): ");
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
        
    }
    
    if (choice == -1) {
        return NO;
    }else{
        ShanBasicCard *shan = [self.handcards objectAtIndex:choice];
        [shan useBy:self];
        [self Thunder];
        return YES;
    }
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@(张角)",self.tag ];
}

-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position{
    self = [super initWithBlood:3 position:position Tag:tag];
    return self;
}


@end

@implementation LiuBei

//当可以发动技能“仁德”的时候，此方法被触发。输入要给牌的编号，直到-1结束
/////////////////////////////////////////////////////////////////////////
-(NSInteger)RenDe{
    
    NSMutableArray *card = [NSMutableArray array];
    
    NSLog(@"%@发动了技能“仁德”",self );
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@"输入要给牌的编号（-1结束）");
    NSInteger choice = [self choiceFrom:-1 To:[self.handcards count] - 1];
    while (choice != -1) {
        
        
        [card addObject:[self.handcards objectAtIndex:choice]];
        [self.handcards removeObjectAtIndex:choice];
        
        [self displayStatusWithHandsCard:YES WithTag:NO];
        NSLog(@"输入要给牌的编号（-1结束）");
        choice = [self choiceFrom:-1 To:[self.handcards count] - 1];

    }
    while (1) {
        
        [[Environment defaultEnvironment] displayStatus];
        NSLog(@"输入给牌的目标位置");
        choice = [self choiceFrom:0 To:[[[Environment defaultEnvironment] participants]count] - 1];
        
        if (choice == self.position) {
            NSLog(@"无法对自己使用“仁德”技能，请再次输入。");
            continue;
        }
        break;
    }
    
    Player *receiver = [[[Environment defaultEnvironment]participants] objectAtIndex:choice];
    [receiver.handcards addObjectsFromArray:card];
    NSLog(@"%@发动技能“仁德”，给了%@%lu张牌。",self ,receiver ,[card count]);

    
    return [card count];
    
        
    
}



-(BOOL)deliverPhase{

    
    WeaponEquipmentCard *weapon = [self.equipments objectForKey:WEAPONKEY];
    NSInteger cardsGiveOut = 0;
    
    NSInteger choice,round = 1;
    NSLog(@"\n回合%ld",round++);
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@"\n");
    NSLog(@"输入%@要出的牌的编号： (输入-1结束回合,-2发动技能“仁德”)：",self );
    
    if ([weapon.tag  isEqualToString:@"丈八蛇杖"]) {
        NSLog(@"输入-3发动装备区的丈八蛇杖。");
        choice = [self choiceFrom:-3 To:[self.handcards count] - 1];
    }else{
        choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
    }
    
    
    while (choice != -1) {
        
        Card *card;
        
        if(choice != -3 && choice != -2) card = [self.handcards objectAtIndex:choice];
        
        if ([card isMemberOfClass:[ShanBasicCard class]]) {
            NSLog(@"“闪“不能在你的回合里使用。\n");
        }else if([card isMemberOfClass:[ShaBasicCard class]]){
            if (self.ableToAttack) {
                
                
                [(ShaBasicCard *)card useBy:self];
                
                
            }else{
                if ([weapon.tag  isEqualToString:@"诸葛连弩"]) {
                    NSLog(@"%@发动了诸葛连弩",self );
                    [(ShaBasicCard *)card useBy:self];
                    
                }else{
                    
                    NSLog(@"此回合你已经使用过“杀”,此“杀”无效。\n");
                }
            }
        }else if(choice == -3){
            if (self.ableToAttack && [self.handcards count] + [self equipmentsNum] >= 2) {
                [self useZBSZForAttack:YES];
            }else{
                NSLog(@"此回合你已经使用过“杀”,或你的牌数小于2张，丈八蛇杖发动失败。\n");
            }
        }else if([card isMemberOfClass:[TaoBasicCard class]]){
            [(TaoBasicCard *)card useBy:self ForPlayer:self];
        }else if([card isMemberOfClass:[WXKJKitsCard class]]){
            NSLog(@"“无懈可击“不能在你的回合里使用。\n");
            
        }else if(choice == -2){
            NSInteger pre = cardsGiveOut;
            cardsGiveOut += [self RenDe];
            if (pre < 2 && cardsGiveOut >= 2 && self.bloodLeft < self.maxBlood) {
                NSLog(@"%@增加一点血量。",self );
                self.bloodLeft ++;
            }
        }else{
            [card useBy:self];
            
        }
        weapon = [self.equipments objectForKey:WEAPONKEY];
        if (!self.alive) {
            return NO;
        }
        NSLog(@"回合%ld",round++);
        
        [self displayStatusWithHandsCard:YES WithTag:NO];
        
        NSLog(@" ");
        
        NSLog(@"输入%@要出的牌的编号： (输入-1结束回合,-2发动技能“仁德”)：",self );
        
        if ([weapon.tag  isEqualToString:@"丈八蛇杖"]) {
            NSLog(@"输入-3发动装备区的丈八蛇杖。");
            choice = [self choiceFrom:-3 To:[self.handcards count] - 1];
        }else{
            choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
            
            
        }
        
    }
    
    return YES;
}

-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position{
    self = [super initWithBlood:4 position:position Tag:tag];
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@(刘备)",self.tag ];
}

@end


@implementation SunQuan

//当可以发动技能“制衡”的时候，此方法被触发。输入要弃置牌的编号，直到-1结束。
/////////////////////////////////////////////////////////////////////////

-(void)ZhiHeng{
    NSMutableArray *exchangeCards = [NSMutableArray array];
    NSInteger count = 0;
    NSString *description = @"";
    NSLog(@"%@发动了技能“制衡”",self );
    
    
    Card *card;
    [self displayStatusWithHandsCard:YES WithTag:YES];


    BOOL exit = NO;
    NSInteger choice = 1;
    while (1) {
        NSLog(@" ");
        if ( [self.handcards count] == 0) {
            NSLog(@"输入要弃置牌的编号（-1结束，0~3为装备）");
            
        }else{
            NSLog(@"输入要弃置牌的编号（-1结束，0~3为装备，4及以上为手牌。）");
        }

        choice = [self choiceFrom:-1 To:[self.handcards count] + 3];

        
        
        switch (choice) {
            case -1:
                exit = YES;
                break;
            case 0:
                if (![self.equipments objectForKey:WEAPONKEY]) {
                    NSLog(@"攻具为空，请再次输入。");
                    continue;
                }
                card = [self.equipments objectForKey:WEAPONKEY];
                [self.equipments removeObjectForKey:WEAPONKEY];
                
                break;
            case 1:
                if (![self.equipments objectForKey:DEFENSEKEY]) {
                    NSLog(@"防具为空,请再次输入。");
                    continue;
                }
                card = [self.equipments objectForKey:DEFENSEKEY];
                [self.equipments removeObjectForKey:DEFENSEKEY];
                
                break;
            case 2:

                
                if (![self.equipments objectForKey:DEFENSEHORSEKEY]) {
                    NSLog(@"防御马为空,请再次输入。");
                    continue;
                }
                card = [self.equipments objectForKey:DEFENSEHORSEKEY];
                [self.equipments removeObjectForKey:DEFENSEHORSEKEY];
                break;
            case 3:
                if (![self.equipments objectForKey:ATTACKHORSEKEY]) {
                    NSLog(@"进攻马为空,请再次输入。");
                    continue;
                }
                card = [self.equipments objectForKey:ATTACKHORSEKEY];
                [self.equipments removeObjectForKey:ATTACKHORSEKEY];
                break;
            default:
                card = [self.handcards objectAtIndex:choice - 4];
                [self.handcards removeObjectAtIndex:choice - 4];
                break;
        }
        if (exit) {
            break;
        }
        [exchangeCards addObject:card];
        description = [description stringByAppendingFormat:@"%ld)%@ ",count++,card];
    }
    
    NSLog(@"%@发动了‘制衡’，弃置了%@,并从牌堆中摸出%lu张牌。",self ,description,[exchangeCards count]);
    [self retrieveCards:[exchangeCards count]];
       
}


-(BOOL)deliverPhase{
    
    WeaponEquipmentCard *weapon = [self.equipments objectForKey:WEAPONKEY];
    BOOL ZhiHengEnabled = YES;
    NSInteger choice,round = 1;
    NSLog(@"回合%ld",round++);
    [self displayStatusWithHandsCard:YES WithTag:NO];
    NSLog(@" ");
    NSLog(@"输入%@要出的牌的编号： (输入-1结束回合,-2发动技能“制衡”)：",self );
    
    if ([weapon.tag  isEqualToString:@"丈八蛇杖"] ) {
        NSLog(@"输入-3发动装备区的丈八蛇杖。");
        choice = [self choiceFrom:-3 To:[self.handcards count] - 1];
    }else{
        choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
    }
    
    
    while (choice != -1) {
        
        Card *card;
        
        if(choice != -3 && choice != -2) card = [self.handcards objectAtIndex:choice];
        
        if ([card isMemberOfClass:[ShanBasicCard class]]) {
            NSLog(@"“闪“不能在你的回合里使用。\n");
        }else if([card isMemberOfClass:[ShaBasicCard class]]){
            if (self.ableToAttack) {
                
                
                [(ShaBasicCard *)card useBy:self];
                
                
            }else{
                if ([weapon.tag  isEqualToString:@"诸葛连弩"]) {
                    NSLog(@"%@发动了诸葛连弩",self );
                    [(ShaBasicCard *)card useBy:self];
                    
                }else{
                    
                    NSLog(@"此回合你已经使用过“杀”,此“杀”无效。");
                }
            }
        }else if(choice == -3){
            if (self.ableToAttack && [self.handcards count] + [self equipmentsNum] >= 2) {
                [self useZBSZForAttack:YES];
            }else{
                NSLog(@"此回合你已经使用过“杀”,或你的牌数小于2张，丈八蛇杖发动失败。");
            }
        }else if([card isMemberOfClass:[TaoBasicCard class]]){
            [(TaoBasicCard *)card useBy:self ForPlayer:self];
        }else if([card isMemberOfClass:[WXKJKitsCard class]]){
            NSLog(@"“无懈可击“不能在你的回合里使用。\n");
            
        }else if(choice == -2){
            if (ZhiHengEnabled) {
                [self ZhiHeng];
                ZhiHengEnabled = NO;
            }else{
                NSLog(@"在%@的出牌阶段已经使用过此技能。“制衡”发动无效。",self );
            }
        }else{
            [card useBy:self];
            
        }
        
        if (!self.alive) {
            return NO;
        }
        weapon = [self.equipments objectForKey:WEAPONKEY];
        
        NSLog(@"回合%ld",round++);
        
        [self displayStatusWithHandsCard:YES WithTag:NO];
        
        NSLog(@" ");
        
        NSLog(@"输入%@要出的牌的编号： (输入-1结束回合,-2发动技能“制衡”)：",self );
        
        if ([weapon.tag  isEqualToString:@"丈八蛇杖"]) {
            NSLog(@"输入-3发动装备区的丈八蛇杖。");
            choice = [self choiceFrom:-3 To:[self.handcards count] - 1];
        }else{
            choice = [self choiceFrom:-2 To:[self.handcards count] - 1];
            
            
        }
        
    }
    return YES;
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@(孙权)",self.tag ];
}

-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position{
    self = [super initWithBlood:4 position:position Tag:tag];
    return self;
}



@end