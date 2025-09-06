class AAuraPotionEffectActor : AAuraEffectActor
{
	UPROPERTY(DefaultComponent)
	USphereComponent SphereComponent;
	default SphereComponent.SetSphereRadius(150.f);

	UFUNCTION(BlueprintOverride)
	void ConstructionScript()
	{
		if (HasAuthority())
		{
			SphereComponent.OnComponentBeginOverlap.AddUFunction(this, n"OnPotionBeginOverlap");
		}
	}

	UFUNCTION()
	private void OnPotionBeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComp, int OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
	{
		if (HasAuthority())
		{
			GASUtils::ApplyGameplayEffectToTarget(this, OtherActor, GameEffectClass);
		}
		else
		{
			if (IsValid(ConsumeSound))
			{
				Gameplay::PlaySound2D(ConsumeSound);
			}
		}

		DestroyActor();
	}
};