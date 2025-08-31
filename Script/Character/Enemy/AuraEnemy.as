class AAuraEnemy : AAuraCharacterBase
{
	UPROPERTY(DefaultComponent)
	UAngelscriptAbilitySystemComponent AbilitySystem;
	default AbilitySystem.SetIsReplicated(true);
	default AbilitySystem.SetReplicationMode(EGameplayEffectReplicationMode::Minimal);

	TObjectPtr<UAngelscriptAttributeSet> AttributeSet;

	default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		Super::BeginPlay();
		AbilitySystem.InitAbilityActorInfo(this, this);
	}

	void HighLightEnemy()
	{
		if (IsValid(Mesh))
		{
			// Mesh.bRenderCustomDepth = true;
			Mesh.SetRenderCustomDepth(true);
			Mesh.SetCustomDepthStencilValue(0);
		}

		if (IsValid(Weapon))
		{
			Weapon.SetRenderCustomDepth(true);
			Weapon.SetCustomDepthStencilValue(0);
		}
	}

	void UnHighLight()
	{
		if (IsValid(Mesh))
		{
			// Mesh.bRenderCustomDepth = true;
			Mesh.SetRenderCustomDepth(false);
		}

		if (IsValid(Weapon))
		{
			Weapon.SetRenderCustomDepth(false);
		}
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