//
//  Dijskstra.m
//  InterviewPractice
//
//  Created by John Lee on 2/19/17.
//  Copyright © 2017 John Lee. All rights reserved.
//

#import "Dijskstra.h"

// Graph
@interface Vertex : NSObject

@property(nonatomic, readonly) NSString *key;
- (instancetype)initWithKey:(NSString *)key;
@end

@implementation Vertex


- (instancetype)initWithKey:(NSString *)key {
  self = [super init];
  if (self) {
    _key = key;
  }
  return self;
}

@end


@interface Edge : NSObject

@property(nonatomic, readonly) Vertex *from;
@property(nonatomic, readonly) Vertex *to;
@property int weight;

@end

@implementation Edge

@end

// Priority Queue
@interface PriorityQueue : NSObject
// Assume priortiy queue has knowledge of current path weights

- (BOOL)isEmpty;
- (void)insert:(Vertex *)vertex;
- (Vertex *)removeMin;

@end

@implementation PriorityQueue
@end


@interface Dijskstra()
@property(nonatomic, readonly) NSDictionary <Vertex *, NSArray<Edge*> *> *graph;

@end
@implementation Dijskstra

// Algorithm
- (void)runDijkstrasOnVertex:(Vertex *)source {
  NSMutableDictionary <Vertex *, NSNumber *> *pathWeights = [NSMutableDictionary new];
  NSMutableDictionary <Vertex *, Vertex *> *previousNodeDict = [NSMutableDictionary new];
  PriorityQueue *pq = [[PriorityQueue alloc] init];
  
  // Add all graph vertices to pq.
  for (Vertex *v in self.graph.allKeys) {
    int weight = INT_MAX;
    if (v == source) {
      weight = 0;
    }
    [pathWeights setValue:@(weight)
                   forKey:v];
    [pq insert:v];
  }
  
  while (!pq.isEmpty) {
    Vertex *v = [pq removeMin];
    for (Edge *edge in [self.graph objectForKey:v]) {
      int toWeight = [pathWeights objectForKey:edge.to];
      if (toWeight > edge.weight) {
        [pathWeights setObject:@(edge.weight)
                        forKey:edge.to];
        [previousNodeDict setObject:edge.from
                             forKey:edge.to];
      }
    }
  }

}

@end
