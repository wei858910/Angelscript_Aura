
event void FOnItemPickup(EItemID ItemID);

class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
    FOnItemPickup OnItemPickupedEvent;
};