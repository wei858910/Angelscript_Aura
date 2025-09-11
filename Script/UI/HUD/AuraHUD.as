class AAuraHUD : AHUD
{
	UPROPERTY(NotEditable)
	TObjectPtr<UUI_Overlay> UIOverlay;

	UPROPERTY()
	TSubclassOf<UUI_AuraWidget> UIOverlayClass;

	UPROPERTY(NotEditable)
	TObjectPtr<UWidgetController> WidgetController;

	UPROPERTY()
	UDataTable PickupItemData;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		UAuraGameInstanceSubsystem::Get().OnItemPickupedEvent.AddUFunction(this, n"OnItemPickuped");
	}

	UWidgetController GetWidgetController(AAuraPlayerController InPlayerController, AAuraPlayerState InPlayerState, UAngelscriptAbilitySystemComponent InAbilitySystem, UAuraAttributeSet InAttributeSet)
	{
		if (WidgetController != nullptr)
			return WidgetController;

		WidgetController = NewObject(nullptr, UWidgetController);

		if (WidgetController != nullptr)
		{
			WidgetController.Get().InitParams(InPlayerController, InPlayerState, InAbilitySystem, InAttributeSet);
		}

		return WidgetController;
	}

	void ShowUIOverlay()
	{
		if (IsValid(UIOverlayClass))
		{
			AAuraPlayerController AuraPlayerController = Cast<AAuraPlayerController>(GetOwningPlayerController());
			if (IsValid(AuraPlayerController))
			{
				UIOverlay = Cast<UUI_Overlay>(WidgetBlueprint::CreateWidget(UIOverlayClass, AuraPlayerController));
				if (UIOverlay != nullptr)
				{
					UIOverlay.Get().SetWidgetController(WidgetController);
					UIOverlay.Get().AddToViewport();
				}
			}
		}
	}

	UFUNCTION()
	void OnItemPickuped(EItemID ItemID)
	{
		if (IsValid(PickupItemData))
		{
			TArray<FItemData> ItemDataArray;

			PickupItemData.GetAllRows(ItemDataArray);

			for (FItemData ItemData : ItemDataArray)
			{
				if (ItemData.ItemID == ItemID)
				{
					AAuraPlayerController AuraPlayerController = Cast<AAuraPlayerController>(GetOwningPlayerController());
					UUI_PickupMessage PickupMessage = Cast<UUI_PickupMessage>(WidgetBlueprint::CreateWidget(ItemData.PickupMessageClass, AuraPlayerController));
					if (IsValid(PickupMessage))
					{
						int X = 0;
						int Y = 0;
						AuraPlayerController.GetViewportSize(X, Y);

						FVector2D Position(X, Y);
						Position.X /= 2;
						Position.Y /= 2;

						PickupMessage.SetTipMessage(ItemData.Icon, ItemData.PotionName);
						PickupMessage.SetPositionInViewport(Position);
						PickupMessage.AddToViewport();
						PickupMessage.PlayMessageAnim();
					}
				}
			}
		}
	}
};