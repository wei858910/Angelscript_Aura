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
};