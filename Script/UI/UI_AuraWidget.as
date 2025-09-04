class UUI_AuraWidget : UUserWidget
{
	UPROPERTY(NotEditable)
	TObjectPtr<UWidgetController> WidgetController;

	void SetWidgetController(UWidgetController InWidgetController)
	{
		WidgetController = InWidgetController;

		OnWidgetControllerSet();
	}

	void OnWidgetControllerSet()
	{
	}
};