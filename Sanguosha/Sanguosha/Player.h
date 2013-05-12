//
//  Player.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-22.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Player : NSObject
@property (nonatomic) NSUInteger position;//玩家的位置
@property (nonatomic) NSInteger bloodLeft;//玩家现在的血量
@property (nonatomic) NSUInteger maxBlood;//总血量
@property (nonatomic) BOOL ableToAttack;//是否出过杀
@property (nonatomic) BOOL alive;//是否存活
@property (nonatomic,strong) NSMutableDictionary *equipments;//装备区
@property (nonatomic,strong) NSMutableArray *handcards;//手牌
@property (nonatomic,strong) NSMutableArray *judgecards;//判定区
@property (nonatomic,strong) NSString *tag;//玩家名称


//初始化
/////////////////////////////////////////////////////////////////////////
-(id)initWithBlood:(NSUInteger )blood position:(NSUInteger)position Tag:(NSString *)tag;


//展示现在的状态
/////////////////////////////////////////////////////////////////////////
-(void)displayStatusWithHandsCard:(BOOL)handsCardOn WithTag:(BOOL)tagOn;


//减血时触发此方法
/////////////////////////////////////////////////////////////////////////
-(void)reduceBlood:(NSInteger)num ByCard:(id)card ByPlayer:(Player *)p1;



//在不是自己的回合 可以使用杀的时候（如是决斗或南蛮入侵的目标），此方法被触发,返回一张杀，若不出返回nil
/////////////////////////////////////////////////////////////////////////
-(id)shouldUseShaForCard:(id)card ByPlayer:(id)sender;

//在不是自己的回合 可以使用闪的时候（如是杀或万箭齐发的目标），此方法被触发。返回是否出闪
/////////////////////////////////////////////////////////////////////////

-(BOOL)shouldUseShanForCard:(id)card ByPlayer:(id)sender DefenseEquippmentEnabled:(BOOL)defenseEnabled;

//在不是自己的回合 可以使用桃的时候（如任何人进入濒死状态），此方法被触发。返回一张桃，若不出返回nil
/////////////////////////////////////////////////////////////////////////
-(id)shouldUseTaoForPlayer:(Player *)gamer;

//在不是自己的回合 可以使用无懈可击的时候（如任何人打出任何一张锦囊牌），此方法被触发。返回是否出无懈可击
/////////////////////////////////////////////////////////////////////////
-(BOOL)shouldUseWXKJForCard:(id)card ForPlayer:(Player *)receiver ByPlayer:(Player *)sender;


//自己回合开始时，此方法被触发
/////////////////////////////////////////////////////////////////////////
-(void)play;

//玩家拿牌时此方法被触发
/////////////////////////////////////////////////////////////////////////
-(void)retrieveCards:(NSUInteger) num;

//当需输入一个最小为bottom,最大为top的数时，该方法被触发，返回玩家输入的数字
/////////////////////////////////////////////////////////////////////////
-(NSInteger)choiceFrom:(NSInteger)bottom To:(NSInteger)top;


//返回装备区中装备的数目
/////////////////////////////////////////////////////////////////////////
-(NSInteger)equipmentsNum;

@end

@interface CaoCao : Player //曹操
-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position;

@end

@interface LiuBei : Player //刘备
-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position;

@end

@interface ZhangJiao : Player//张角
-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position;

@end

@interface SunQuan : Player //孙权
-(id)initWithTag:(NSString *)tag Position:(NSUInteger)position;

@end