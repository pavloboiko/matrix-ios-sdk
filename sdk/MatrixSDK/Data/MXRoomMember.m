/*
 Copyright 2014 OpenMarket Ltd
 
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

#import "MXRoomMember.h"

#import "MXJSONModels.h"
#import "MXTools.h"

@implementation MXRoomMember

- (instancetype)initWithMXEvent:(MXEvent*)roomMemberEvent
{
    self = [super init];
    if (self)
    {
        NSParameterAssert(roomMemberEvent.eventType == MXEventTypeRoomMember);
        
        // Use MXRoomMemberEventContent to parse the JSON event content
        MXRoomMemberEventContent *roomMemberContent = [MXRoomMemberEventContent modelFromJSON:roomMemberEvent.content];
        _displayname = roomMemberContent.displayname;
        _avatarUrl = roomMemberContent.avatarUrl;
        _membership = [MXTools membership:roomMemberContent.membership];
        _lastActiveAgo = roomMemberContent.lastActiveAgo;

        // Set who is this user
        if (roomMemberEvent.stateKey)
        {
            _userId = roomMemberEvent.stateKey;
        }
        else
        {
            _userId = roomMemberEvent.userId;
        }
    }
    return self;
}
@end
