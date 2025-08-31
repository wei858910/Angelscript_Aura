class AAuraPlayerState : APlayerState
{
	UPROPERTY(DefaultComponent)
	UAngelscriptAbilitySystemComponent AbilitySystem;

	default AbilitySystem.SetIsReplicated(true);

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
