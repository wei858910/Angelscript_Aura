class AAuraPlayerState : APlayerState
{
	UPROPERTY(DefaultComponent)
	UAngelscriptAbilitySystemComponent AbilitySystem;

	default AbilitySystem.SetIsReplicated(true);
    default AbilitySystem.SetReplicationMode(EGameplayEffectReplicationMode::Mixed);

	TObjectPtr<UAngelscriptAttributeSet> AttributeSet;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
	}

	UAbilitySystemComponent GetAbilitySystemComponent()
	{
		return AbilitySystem;
	}

	UAngelscriptAttributeSet GetAttirbuteSet()
	{
		return AttributeSet;
	}
};
