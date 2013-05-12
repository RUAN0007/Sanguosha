//
//  LateKitsCard.m
//  Sanguosha
//
//  Created by Ruan Pingcheng on 13-3-22.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import "LateKitsCard.h"
#import "Player.h"
#import "Environment.h"


@implementation LateKitsCard
-(BOOL)judgeForPlayer:(id)p{
    return YES;
}

@end

@implementation LBSSKitsCard//乐不思蜀

-(BOOL)judgeForPlayer:(Player *)p{
    
    if ([self WXKJForCardForPlayer:p ByPlayer:nil]) {
        return NO;
    }
    
    Card *judgeCard = [[Environment defaultEnvironment]judgeFromPlayer:p];
    NSLog(@"%@的判定牌为%@",self,judgeCard);
    return judgeCard.type != HEART;
}

-(BOOL)useBy:(Player *)gamer{
    
    NSArray *participants = [[Environment defaultEnvironment]participants];
    
    [[Environment defaultEnvironment]displayStatus];
    
    while (1) {
        Player *receiver;
        NSLog(@"请%@输入使用乐不思蜀的目标。(-1表示放弃使用）",gamer);
        NSInteger choice = [gamer choiceFrom:-1 To:[participants count] - 1];
        
        if (choice == -1) {
            NSLog(@"%@放弃使用%@",gamer,self);
            return NO;
        }
        
        if (choice == gamer.position) {
            NSLog(@"无法对自己使用%@。无效。",self);
            continue;
        }
        

        
        receiver = [participants objectAtIndex: choice];
        
        
        if (receiver.alive == NO) {
            NSLog(@"%@阵亡，已退出游戏。",receiver);
            continue;
        }
        
        BOOL LBSSRepetition = NO;
        for (Card *card in receiver.judgecards){
            if ([card isMemberOfClass:[LBSSKitsCard class]]) {
                LBSSRepetition = YES;
                break;
            }
        }
        
        if (LBSSRepetition) {
            NSLog(@"目标已被使用%@。请输入新的目标。",self);
            continue;
        }
        
        
        [super useBy:gamer];
        NSLog(@"对%@使用了%@",receiver,self);
        
        [receiver.judgecards addObject:self];
        
        break;
        
        
    }
    
    return YES;


    
}

-(NSString *)description{
    return [NSString stringWithFormat:@" 乐不思蜀%@ ",[super description]];
}

@end

@implementation SDKitsCard//闪电

-(BOOL)judgeForPlayer:(Player *)p{
    
    if ([self WXKJForCardForPlayer:p ByPlayer:nil]) {
        return NO;
    }
    
    Card *judgeCard = [[Environment defaultEnvironment] judgeFromPlayer:p];
    NSLog(@"%@的判定牌为%@",self,judgeCard);

    return judgeCard.type == SPADE && (judgeCard.num <= 9 && judgeCard.num>= 2);
}

-(BOOL)useBy:(Player *)gamer{
    
    
    for (Card *card in gamer.judgecards){
        if ([card isMemberOfClass:[SDKitsCard class]]) {
            NSLog(@"%@的判定区内已有%@。%@使用无效。",gamer,card,self);
            return NO;
        }
        
    }
    [super useBy:gamer];
    NSLog(@"讲%@放入自己的判定区。",self);
    [gamer.judgecards addObject:self];
    return YES;
    
    

}

-(NSString *)description{
    return [NSString stringWithFormat:@" 闪电%@ ",[super description]];
}

@end
