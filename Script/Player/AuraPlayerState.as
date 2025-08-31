class AAuraPlayerState : APlayerState
{
    default SetNetUpdateFrequency(100.f);

	UPROPERTY(DefaultComponent)
	UAngelscriptAbilitySystemComponent AbilitySystem;
	default AbilitySystem.SetIsReplicated(true);
    default AbilitySystem.SetReplicationMode(EGameplayEffectReplicationMode::Mixed);

	TObjectPtr<UAngelscriptAttributeSet> AttributeSet;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
	}

	UAngelscriptAbilitySystemComponent GetAbilitySystemComponent()
	{
		return AbilitySystem;
	}

	UAngelscriptAttributeSet GetAttirbuteSet()
	{
		return AttributeSet;
	}
};
