//
//  LateKitsCard.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-22.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "KitsCard.h"

@interface LateKitsCard : KitsCard
-(BOOL)judgeForPlayer:(id)p;//判定此延时性锦囊是否生效

@end

@interface LBSSKitsCard : LateKitsCard//乐不思蜀

@end

@interface SDKitsCard : LateKitsCard//闪电

@end