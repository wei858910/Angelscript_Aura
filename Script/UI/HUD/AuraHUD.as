class AAuraHUD : AHUD
{
	UPROPERTY(NotEditable)
	TObjectPtr<UUI_Overlay> UIOverlay;

	UPROPERTY()
	TSubclassOf<UUI_AuraWidget> UIOverlayClass;

	UPROPERTY(NotEditable)
	TObjectPtr<UWidgetController> WidgetController;

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
			AAuraPlayerController AuraPlayerController = Cast<AAuraPlayerController>(OwningPlayerController);
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
};