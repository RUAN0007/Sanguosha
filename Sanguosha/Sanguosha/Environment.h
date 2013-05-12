//
//  Environment.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-4-7.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Player.h"


@interface Environment : NSObject
@property (nonatomic,strong) NSArray *participants;//玩家的集合
@property (nonatomic,strong) NSMutableArray *cards; //牌堆
@property (nonatomic,strong) NSMutableArray *usefCards; //弃牌堆

//当可以发动技能“奸雄”的时候，此方法被触发
/////////////////////////////////////////////////////////////////////////
-(id)initWithParticipants:(NSArray *)participants;

//返回现在的环境对象（Object)
/////////////////////////////////////////////////////////////////////////
+(Environment *)defaultEnvironment;

//返回现在的环境对象（Object)
/////////////////////////////////////////////////////////////////////////
-(Card *)popCard;

//为玩家p返回一张判定牌
/////////////////////////////////////////////////////////////////////////
-(Card *)judgeFromPlayer:(Player *)p;

//判断defender是否在attacker的攻击距离内
/////////////////////////////////////////////////////////////////////////
-(BOOL)accessibleFrom:(Player *)attacker To:(Player *)defender WithWeapon:(BOOL)weaponEnabled;

//开始当前游戏
/////////////////////////////////////////////////////////////////////////
-(void)start;

//每一位玩家显示自己的状态
/////////////////////////////////////////////////////////////////////////
-(void)displayStatus;

//p进入濒死状态，判断本局游戏是否结束
/////////////////////////////////////////////////////////////////////////
-(BOOL)IsGameEndedWithDeadPlayer:(id)p;

//返回存活的玩家数目
/////////////////////////////////////////////////////////////////////////
-(NSInteger)alivePlayers;

@end
