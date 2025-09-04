class UUI_Overlay : UUI_AuraWidget
{
	UPROPERTY(BindWidget)
	UGlobe_ProgressBar WBP_Health;

	UPROPERTY(BindWidget)
	UGlobe_ProgressBar WBP_Mana;

	float32 Health = 0.f;
	float32 MaxHealth = 0.f;

	float32 Mana = 0.f;
	float32 MaxMana = 0.f;

	void OnWidgetControllerSet() override
	{
		// 为指定属性数据绑定回调
		WidgetController.Get().AbilitySystem.Get().OnAttributeChanged.AddUFunction(this, n"OnAuraAttributeSetDataChanged");
		WidgetController.Get().AbilitySystem.Get().RegisterCallbackForAttribute(UAuraAttributeSet, n"Health");
		WidgetController.Get().AbilitySystem.Get().RegisterCallbackForAttribute(UAuraAttributeSet, n"MaxHealth");

		WidgetController.Get().AbilitySystem.Get().RegisterCallbackForAttribute(UAuraAttributeSet, n"Mana");
		WidgetController.Get().AbilitySystem.Get().RegisterCallbackForAttribute(UAuraAttributeSet, n"MaxMana");

		UAuraAttributeSet AttributeSet = WidgetController.Get().AuraAttributeSet;

		// 进行UI的初始化
		if (IsValid(AttributeSet))
		{
			Health = AttributeSet.Health.CurrentValue;
			MaxHealth = AttributeSet.MaxHealth.CurrentValue;

			Mana = AttributeSet.Mana.CurrentValue;
			MaxMana = AttributeSet.MaxMana.CurrentValue;

			UpdateUI();
		}
	}

	// 属性数据绑定回调
	UFUNCTION()
	private void OnAuraAttributeSetDataChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{
		if (AttributeChangeData.Name == n"Health")
		{
			Health = AttributeChangeData.NewValue;
		}

		if (AttributeChangeData.Name == n"MaxHealth")
		{
			MaxHealth = AttributeChangeData.NewValue;
		}
		if (AttributeChangeData.Name == n"Mana")
		{
			Mana = AttributeChangeData.NewValue;
		}
		if (AttributeChangeData.Name == n"MaxMana")
		{
			MaxMana = AttributeChangeData.NewValue;
		}

		UpdateUI();
	}

	void UpdateUI()
	{
		WBP_Health.SetProgressBarPercent(Health / MaxHealth);
		WBP_Mana.SetProgressBarPercent(Mana / MaxMana);
	}
};