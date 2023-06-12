//
//  EventsCBridge.c
//  EventsSystem
//
//  Created by Ankit Saini on 24/05/23.
//

#include "EventsCBridge.h"
#include <string.h>
#include <stdlib.h>

int main() {
//  myFunction();  // call the function
  return 0;
}

EventsKeyValue* eventsMemory;

EventsKeyValue* addEventsToMemory(EventsKeyValue* keyValueArray, int size, EventsKeyValue* savedEventsMemory, int savedEventsSize) {

    if (savedEventsMemory == NULL) {
        size_t totalSize = size * sizeof(EventsKeyValue);

        // Allocate memory for the struct array
        eventsMemory = (EventsKeyValue*)malloc(totalSize);
        if (eventsMemory == NULL) {
            printf("Failed to allocate memory for the struct array.\n");
            return NULL;
        }
        // Copy the struct array to the allocated memory
        memcpy(eventsMemory, keyValueArray, totalSize);
        return eventsMemory;
    }
    else {
        if (savedEventsMemory == NULL) {
            return NULL;
        }
        //create a new array with old and new event array
        EventsKeyValue updateKeyValues[size + savedEventsSize];
        int i = 0;
        for (i = 0; i < savedEventsSize; i++) {
            updateKeyValues[i] = savedEventsMemory[i];
        }
        for (int j = 0; j < size; j++) {
            updateKeyValues[i + j] = keyValueArray[j];
        }
        //Free old memory - no need as we are doing realloc
//        free(savedEventsMemory);
        //reallocate and save the update events in updated memory
        size_t updateEventsSize = (size + savedEventsSize) * sizeof(EventsKeyValue);
        eventsMemory = (EventsKeyValue*)realloc(eventsMemory, updateEventsSize);

        if (eventsMemory == NULL) {
            printf("Failed to allocate memory for the struct array.\n");
            return NULL;
        }
        memcpy(eventsMemory, updateKeyValues, updateEventsSize);
        return eventsMemory;
    }
}

int getEventsForTime(int timeInSeonds, int currentTimeStamp, EventsKeyValue* savedMemory, int savedEventSize, char* key) {
    int totalEvents = 0;
    if (savedMemory == NULL) {
        return -1;
    }
    for (int i = 0; i < savedEventSize; i++) {
        if(((currentTimeStamp - savedMemory[i].timestamp) <= timeInSeonds) && strcmp(key,savedMemory[i].key) == 0) {
            totalEvents = totalEvents + savedMemory[i].value;
        }
    }
    return totalEvents;
}
