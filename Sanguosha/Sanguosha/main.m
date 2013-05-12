
//
//  main.m
//  try
//
//  Created by Ruan Pingcheng on 13-3-23.
//  Copyright (c) 2013年 Ruan Pingcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Environment.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {

        
        [[Environment defaultEnvironment] start];
        
    }
    return 0;
}
