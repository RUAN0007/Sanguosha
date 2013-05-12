//
//  kitsCard.h
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-21.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "Card.h"

@interface KitsCard : Card
//询问每一位存活玩家是否为player对sender打出的锦囊牌使用无懈可击，若有人打出无懈可击返回YES,反之返回NO。
///////////////////////////////////////////////////////////////////////
-(BOOL)WXKJForCardForPlayer:(Player *)player ByPlayer:(Player *)sender;

@end

@interface WXKJKitsCard : KitsCard//无懈可击

@end

@interface WJQFKitsCard : KitsCard//万箭齐发

@end

@interface NMRQKitsCard : KitsCard//南蛮入侵

@end

@interface JDKitsCard : KitsCard//决斗

@end

@interface JDSRKitsCard : KitsCard//借刀杀人

@end

@interface TYJYKitsCard : KitsCard //桃园结义

@end

@interface WZSYKitsCard : KitsCard //无中生有

@end

@interface GHCQKitsCard : KitsCard//过河拆桥

@end

@interface SSQYKitsCard : KitsCard //顺手牵羊

@end

@interface WGFDKitsCard : KitsCard //五谷丰登

@end

