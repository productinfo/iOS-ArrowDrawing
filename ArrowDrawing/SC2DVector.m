/*
 Copyright 2014 Scott Logic Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

#import "SC2DVector.h"

@implementation SC2DVector

+ (instancetype)vectorWithPoint:(CGPoint)point
{
    return [[self alloc] initWithCGPoint:point];
}

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y
{
    self = [super init];
    if(self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (instancetype)initWithCGPoint:(CGPoint)point
{
    return [self initWithX:point.x y:point.y];
}

- (CGPoint)point
{
    return CGPointMake(self.x, self.y);
}

- (SC2DVector *)addVector:(SC2DVector *)vector
{
    SC2DVector *sum = [self copy];
    sum.x += vector.x;
    sum.y += vector.y;
    return sum;
}

- (SC2DVector *)multiplyByScalar:(CGFloat)scalar
{
    SC2DVector *multiple = [self copy];
    multiple.x *= scalar;
    multiple.y *= scalar;
    return multiple;
}

- (CGFloat)dotProductWithVector:(SC2DVector *)vector
{
    return (self.x * vector.x + self.y * vector.y);
}

- (CGFloat)length
{
    return sqrt([self dotProductWithVector:self]);
}

- (SC2DVector *)normalisedToLength:(CGFloat)length
{
    SC2DVector *normed = [self copy];
    CGFloat curSize = [self length];
    normed.x *= length / curSize;
    normed.y *= length / curSize;
    return normed;
}

- (SC2DVector *)perpendicularVector
{
    SC2DVector *perp = [SC2DVector new];
    perp.x =   self.y;
    perp.y = - self.x;
    return perp;
}

- (SC2DVector *)perpendicularVectorOfLength:(CGFloat)length
{
    SC2DVector *perp = [self perpendicularVector];
    return [perp normalisedToLength:length];
}

#pragma mark - NSCopying protocol
- (id)copyWithZone:(NSZone *)zone
{
    SC2DVector *copy = [[[self class] allocWithZone:zone] init];
    copy.x = self.x;
    copy.y = self.y;
    return copy;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{x: %0.2f, y: %0.2f, ||·||: %0.2f}", self.x, self.y, [self length]];
}

@end
