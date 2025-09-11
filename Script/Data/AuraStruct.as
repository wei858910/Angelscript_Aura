USTRUCT()
struct FItemData
{
    UPROPERTY()
    EItemID ItemID;

    UPROPERTY()
    FString PotionName;

    UPROPERTY()
    UTexture2D Icon;

    UPROPERTY()
    TSubclassOf<UUI_PickupMessage> PickupMessageClass;
}