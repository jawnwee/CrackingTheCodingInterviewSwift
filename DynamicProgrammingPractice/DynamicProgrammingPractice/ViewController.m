//
//  ViewController.m
//  DynamicProgrammingPractice
//
//  Created by John Lee on 2/14/17.
//  Copyright © 2017 John Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)findMaxContiguousSubsequence:(NSArray *)array {
  NSMutableArray *trackMaxSum = [NSMutableArray new];
  int n = 0;
  int j = 0;
  int currentMax = -10000000;
  [trackMaxSum addObject:[array objectAtIndex:0]];
  for (int i = 1; i < array.count; i++) {
    int added = [[trackMaxSum objectAtIndex:(i - 1)] intValue] + [[array objectAtIndex:i] intValue];
    if (added > [[array objectAtIndex:i] intValue]) {
      [trackMaxSum addObject:@(added)];
      if ([[trackMaxSum lastObject] intValue] > currentMax) {
        currentMax = [[trackMaxSum lastObject] intValue];
        j = i;
      }
    } else {
      [trackMaxSum addObject:[array objectAtIndex:i]];
      if ([[trackMaxSum lastObject] intValue] > currentMax) {
        currentMax = [[trackMaxSum lastObject] intValue];
        n = i;
        j = i;
      }
    }
  }
}

- (int)minCoins:(int)c
          nCoin:(int)n {
  if (c == 0) {
    return 0;
  }
  int minCount = c;
  for (int i = n; i >= 1; i--) {
    int count = 1 + [self minCoins:(c-i) nCoin:n];
    if (count < minCount) {
      minCount = count;
    }
  }
  return minCount;
}

- (int)longestIncreasingSubsequence:(NSArray *)arr {
  NSMutableArray *maxLengthIndex = [[NSMutableArray alloc] initWithCapacity:arr.count + 1];
  
  int max = 1;
  int length = 0;
  for (int i = 0; i < arr.count; i++) {
    int low = 1;
    int high = length;
    while (low <= high) {
      int mid = (low + high) / 2;
      if ([[arr objectAtIndex:[maxLengthIndex[mid] intValue]] intValue]
          < [[arr objectAtIndex:i] intValue]) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    
    int currentLength = low;
    
    maxLengthIndex[currentLength] = @(i);
    
    if (currentLength > length) {
      length = currentLength;
    }
  }
  
  for (NSNumber *val in maxLengthIndex) {
    if ([val intValue] > max) {
      max = [val intValue];
    }
  }
  return max;
}

@end
