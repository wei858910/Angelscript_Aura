class UAuraAttributeSet : UAngelscriptAttributeSet
{
	UPROPERTY()
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY()
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY()
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY()
	FAngelscriptGameplayAttributeData MaxMana;

	UAuraAttributeSet()
	{
		Health.Initialize(100.f);
		MaxHealth.Initialize(100.f);

		Mana.Initialize(50.f);
		MaxMana.Initialize(50.f);
	}
};