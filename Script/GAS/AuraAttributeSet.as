
namespace AuraAttributeSetName
{
	const FName Health = n"Health";
	const FName MaxHealth = n"MaxHealth";
	const FName Mana = n"Mana";
	const FName MaxMana = n"MaxMana";
} // namespace AuraAttributeSetName

class UAuraAttributeSet : UAngelscriptAttributeSet
{
	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData MaxMana;

	UAuraAttributeSet()
	{
		Health.Initialize(50.f);
		MaxHealth.Initialize(100.f);

		Mana.Initialize(12.f);
		MaxMana.Initialize(50.f);
	}

	UFUNCTION()
	void OnRep_AttributeDataChanged(FAngelscriptGameplayAttributeData& OldData)
	{
		OnRep_Attribute(OldData);
	}

	// 属性BaseValue预测
	UFUNCTION(BlueprintOverride)
	void PreAttributeBaseChange(FGameplayAttribute Attribute, float32& NewValue) const
	{
		Print(f"{Attribute.AttributeName}, NewValue = {NewValue}");
	}

	// 属性CurrentValue预测
	UFUNCTION(BlueprintOverride)
	void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
	{
		Print(f"{Attribute.AttributeName}, NewValue = {NewValue}");
		ClampingAttributeValue(Attribute.AttributeName, NewValue);
	}

	// 游戏效果预测
	UFUNCTION(BlueprintOverride)
	bool PreGameplayEffectExecute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent AbilitySystemComponent)
	{
		Print(f"{EvaluatedData.Attribute.AttributeName}");
		return true;
	}

	// 对属性的钳制
	void ClampingAttributeValue(FString InAttributeName, float32& NewValue)
	{
		if (InAttributeName == AuraAttributeSetName::Health)
		{
			NewValue = Math::Min(NewValue, MaxHealth.CurrentValue);
		}
	}
};