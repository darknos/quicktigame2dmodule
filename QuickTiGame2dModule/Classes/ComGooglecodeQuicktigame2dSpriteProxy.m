// Copyright (c) 2012 quicktigame2d project
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// * Neither the name of the project nor the names of its contributors may be
//   used to endorse or promote products derived from this software without
//   specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
#import "ComGooglecodeQuicktigame2dSpriteProxy.h"
#import "ComGooglecodeQuicktigame2dTransformProxy.h"
#import "TiUtils.h"

@implementation ComGooglecodeQuicktigame2dSpriteProxy

- (id)init {
    self = [super init];
    if (self != nil) {
        sprite = [[QuickTiGame2dSprite alloc] init];
    }
    return self;
}

- (void)dealloc {
    [sprite release];
    [super dealloc];
}

- (QuickTiGame2dSprite*)sprite {
    return sprite;
}

/*
 * notification event that is issued by game engine
 * onload, ongainedfocus, enterframe, onlostfocus, ondispose
 */
- (void)onNotification:(NSString*)type userInfo:(NSDictionary*)userInfo {
    [self fireEvent:type withObject:userInfo];
}

- (void)onAdd {
    [self fireEvent:@"add"];
}

- (void)onRemove {
    [self fireEvent:@"remove"];
}

#pragma Public APIs

-(void)dispose:(id)args {
    RELEASE_TO_NIL(sprite)
}

-(id)collidesWith:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);

    QuickTiGame2dSprite* other = ((ComGooglecodeQuicktigame2dSpriteProxy*)args).sprite;
    
    return NUMBOOL(sprite.x < other.x + other.width && other.x < sprite.x + sprite.width &&
        sprite.y < other.y + other.height && other.y < sprite.y + sprite.height);
}

-(id)contains:(id)args {
    if ([args count] < 2) {
        NSLog(@"[WARN] Too few arguments for sprite.contains(x, y)");
        return NUMBOOL(FALSE);
    }
    
    NSInteger x = [[args objectAtIndex:0] intValue];
    NSInteger y = [[args objectAtIndex:1] intValue];
    
    return NUMBOOL(x >= sprite.x && x <= sprite.x + sprite.width &&
           y >= sprite.y && y <= sprite.y + sprite.height);
    
}

-(void)setImage:(id)value {
    sprite.image = [[TiUtils stringValue:value] copy];
    [sprite updateImageSize];
}

-(id)image {
    return sprite.image;
}

- (id)width {
    return NUMINT(sprite.width);
}

- (void)setWidth:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.width = [value intValue];
}

- (id)height {
    return NUMINT(sprite.height);
}

- (void)setHeight:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.height = [value intValue];
}

- (id)x {
    return NUMFLOAT(sprite.x);
}

- (void)setX:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.x = [value floatValue];
}

- (id)y {
    return NUMFLOAT(sprite.y);
}

- (void)setY:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.y = [value floatValue];
}

- (id)z {
    return NUMFLOAT(sprite.z);
}

- (void)setZ:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.z = [value floatValue];
}

- (void)move:(id)args {
    if ([args count] < 2) {
        NSLog(@"[WARN] Too few arguments for sprite.move(x, y)");
    }
    
    NSInteger x = [[args objectAtIndex:0] intValue];
    NSInteger y = [[args objectAtIndex:1] intValue];
    
    if ([args count] < 3) {
        [sprite move:x y:y];
    } else {
        [sprite move:x y:y z:[[args objectAtIndex:2] intValue]];
    }
}

- (id)angle {
    return NUMFLOAT([sprite angle]);
}

- (void)setAngle:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.angle = [value floatValue];
}

- (void)rotate:(id)args {
    [sprite rotate:[[args objectAtIndex:0] floatValue]];
}

- (void)rotateFrom:(id)args {
    if ([args count] >= 3) {
        [sprite rotate:
         [[args objectAtIndex:0] floatValue]
               centerX:[[args objectAtIndex:1] floatValue]
               centerY:[[args objectAtIndex:2] floatValue]
         ];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.rotateFrom(angle, centerX, centerY)");
    }
}

- (void)rotateX:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [sprite rotateX:[args floatValue]];
}

- (void)rotateY:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [sprite rotateY:[args floatValue]];
}

- (void)rotateZ:(id)args {
    ENSURE_SINGLE_ARG(args, NSNumber);
    [sprite rotateZ:[args floatValue]];
}

- (void)rotateFromAxis:(id)args {
    if ([args count] >= 4) {
        [sprite rotate:
         [[args objectAtIndex:0] floatValue]
               centerX:[[args objectAtIndex:1] floatValue]
               centerY:[[args objectAtIndex:2] floatValue]
                  axis:[[args objectAtIndex:3] floatValue]
         ];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.rotateFromAxis(angle, centerX, centerY, axis)");
    }
}

- (void)scale:(id)args {
    [sprite scale:[[args objectAtIndex:0] floatValue]];
}

- (void)scaleBy:(id)args {
    if ([args count] >= 2) {
        [sprite scale:
         [[args objectAtIndex:0] floatValue]
               scaleY:[[args objectAtIndex:1] floatValue]
         ];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.scaleBy(scaleX, scaleY)");
    }
}

- (void)scaleFromCenter:(id)args {
    if ([args count] >= 4) {
        [sprite scale:[[args objectAtIndex:0] floatValue]
               scaleY:[[args objectAtIndex:1] floatValue]
              centerX:[[args objectAtIndex:2] floatValue]
              centerY:[[args objectAtIndex:3] floatValue]
         ];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.scaleFromCenter(scaleX, scaleY, centerX, centerY)");
    }
}

- (id)scaleX {
    return NUMFLOAT(sprite.scaleX);
}

- (void)setScaleX:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.scaleX = [value floatValue];
}

- (id)scaleY {
    return NUMFLOAT(sprite.scaleY);
}

- (void)setScaleY:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.scaleY = [value floatValue];
}

- (void)color:(id)args {
    if ([args count] == 3) {
        [sprite color:
                     [[args objectAtIndex:0] floatValue]
               green:[[args objectAtIndex:1] floatValue]
                blue:[[args objectAtIndex:2] floatValue]
        ];
    } else if ([args count] >= 4) {
        [sprite color:
                      [[args objectAtIndex:0] floatValue]
                green:[[args objectAtIndex:1] floatValue]
                 blue:[[args objectAtIndex:2] floatValue]
                alpha:[[args objectAtIndex:3] floatValue]
         ];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.color(red, green, blue, alpha)");
    }
}

- (id)alpha {
    return NUMFLOAT(sprite.alpha);
}

- (void)setAlpha:(id)value {
    ENSURE_SINGLE_ARG(value, NSNumber);
    sprite.alpha = [value floatValue];
}

-(void)show:(id)args {
    sprite.alpha = 1;
}

-(void)hide:(id)args {
    sprite.alpha = 0;
}

- (void)blendFunc:(id)args {
    if ([args count] >= 2) {
        sprite.srcBlendFactor = [[args objectAtIndex:0] intValue];
        sprite.dstBlendFactor = [[args objectAtIndex:1] intValue];
    } else {
        NSLog(@"[ERROR] Too few arguments for sprite.blendFunc(sfactor, dfactor)");
    }
}

- (void)transform:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dTransformProxy);
    [sprite transform:[args transformer]];
}

- (void)clearTransforms:(id)args {
    [sprite clearTransforms];
}

- (void)clearTransform:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dTransformProxy);
    [sprite clearTransform:[args transformer]];
}

- (void)addChild:(id)args {
    NSLog(@"[WARN] sprite.addChild is deprecated. Use sprite.addTransformChild instead.");
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);
    [sprite addChild:[args sprite]];
}

- (void)removeChild:(id)args {
    NSLog(@"[WARN] sprite.removeChild is deprecated. Use sprite.removeTransformChild instead.");
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);
    [sprite removeChild:[args sprite]];
}

- (void)addTransformChild:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);
    [sprite addChild:[args sprite]];
}

- (void)removeTransformChild:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);
    [sprite removeChild:[args sprite]];
}

- (void)addTransformChildWithRelativePosition:(id)args {
    ENSURE_SINGLE_ARG(args, ComGooglecodeQuicktigame2dSpriteProxy);
    [sprite addChildWithRelativePosition:[args sprite]];
}

@end