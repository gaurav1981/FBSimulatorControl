/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <FBControlCore/FBControlCore.h>

#import "FBControlCoreFixtures.h"
#import "FBControlCoreValueTestCase.h"

@interface FBiOSTargetFormatTests : FBControlCoreValueTestCase

@end

@implementation FBiOSTargetFormatTests

- (void)testValueSemantics
{
  NSArray *values = @[
    [FBiOSTargetFormat formatWithFields:@[FBiOSTargetFormatName, FBiOSTargetFormatUDID, FBiOSTargetFormatState]],
    [FBiOSTargetFormat formatWithFields:@[FBiOSTargetFormatName, FBiOSTargetFormatUDID, FBiOSTargetFormatOSVersion, FBiOSTargetFormatModel]],
    [FBiOSTargetFormat formatWithFields:@[]],
  ];
  [self assertEqualityOfCopy:values];
  [self assertUnarchiving:values];
  [self assertJSONSerialization:values];
  [self assertJSONDeserialization:values];
}

- (void)testCorrectFormatStrings
{
  NSDictionary<NSString *, NSArray<FBiOSTargetFormatKey> *> *inputs = @{
    @"%n%o" : @[FBiOSTargetFormatName, FBiOSTargetFormatOSVersion],
    @"%a%m" : @[FBiOSTargetFormatArchitecture, FBiOSTargetFormatModel],
  };

  for (NSString *input in inputs.allKeys) {
    NSArray<FBiOSTargetFormatKey> *expected = inputs[input];
    NSError *error = nil;
    FBiOSTargetFormat *format = [FBiOSTargetFormat formatWithString:input error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(format);
    XCTAssertEqualObjects(format.fields, expected);
  }
}

@end
