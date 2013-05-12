//
//  basicCard.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Card.h"

@interface BasicCard : Card

@end

@interface TaoBasicCard : BasicCard

//当sender选择为patient打出一张桃时，此method被触发
///////////////////////////////////////////////////////////////////////

-(BOOL)useBy:(Player *)sender ForPlayer:(Player *)patient;
@end


@interface ShanBasicCard : BasicCard

@end

@interface ShaBasicCard : BasicCard

//当attacker使用weapon对defender打出一张杀时，此method被触发。若玩家最终放弃使用该杀，则返回 NO
-(BOOL)attackFrom:(id)attacker To:(id)defender WithEquipment:(id)weapon;

@end