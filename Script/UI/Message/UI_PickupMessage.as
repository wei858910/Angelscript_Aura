class UUI_PickupMessage : UUI_AuraWidget
{
	UPROPERTY(BindWidget)
	UImage Image_Icon;

	UPROPERTY(BindWidget)
	UTextBlock Text_Message;

	UPROPERTY(BindWidgetAnim)
	UWidgetAnimation MessageAnim;

	void SetTipMessage(UTexture2D Texture, FString PotionName)
	{
		Image_Icon.SetBrushFromTexture(Texture);
		Text_Message.SetText(FText::FromString(f"拾取{PotionName}"));
	}

	void PlayMessageAnim()
	{
		if (IsValid(MessageAnim))
		{
			PlayAnimation(MessageAnim);
		}
	}

	UFUNCTION(BlueprintOverride)
	void OnAnimationFinished(const UWidgetAnimation Animation)
	{
		RemoveFromParent();
	}
}
