//
//  EventsCBridge.h
//  EventsSystem
//
//  Created by Ankit Saini on 24/05/23.
//

#ifndef EventsCBridge_h
#define EventsCBridge_h

#include <stdio.h>
#include <stdbool.h>

#endif /* EventsCBridge_h */

//typedef struct {
//    const char* key;
//    int value;
//} EventsKeyValue;


typedef struct {
    char* key;
    int value;
    int timestamp;
} EventsKeyValue;

EventsKeyValue* addEventsToMemory(EventsKeyValue* keyValueArray, int size, EventsKeyValue* savedEventsMemory, int savedEventsSize);
int getEventsForTime(int timeInSeonds, int currentTimeStamp, EventsKeyValue* savedMemory, int savedEventSize, char* key);
void freeMemory(void);


typedef struct {
    EventsKeyValue event[100];
} EventsData;



