//
//  equipmentCard.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Card.h"

@interface EquipmentCard : Card
@property (nonatomic,strong) NSString *tag;
-(id)initWithNum:(NSInteger)num Type:(Suit)type WithTag:(NSString *)tag;

@end

@interface WeaponEquipmentCard : EquipmentCard
@property NSInteger distance;
-(id)initWithNum:(NSInteger)num Type:(Suit)type WithTag:(NSString *)tag Distance:(NSUInteger)distance;

@end


@interface DefenseEquipmentCard : EquipmentCard

//当玩家选择使用防具时，此method被触发,返回是否生效.
///////////////////////////////////////////////////////////
-(BOOL)defendFor:(Card *)card ForPlayer:(Player *)gamer;
@end

@interface DefenseHorseCard : EquipmentCard

@end

@interface AttackHorseCard : EquipmentCard

@end