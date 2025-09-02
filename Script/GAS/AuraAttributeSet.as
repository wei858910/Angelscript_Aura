class UAuraAttributeSet : UAngelscriptAttributeSet
{
	UPROPERTY(Replicated)
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY(Replicated)
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY(Replicated)
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY(Replicated)
	FAngelscriptGameplayAttributeData MaxMana;

	UAuraAttributeSet()
	{
		Health.Initialize(100.f);
		MaxHealth.Initialize(100.f);

		Mana.Initialize(50.f);
		MaxMana.Initialize(50.f);
	}
};