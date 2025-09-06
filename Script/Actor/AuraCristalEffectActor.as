class AAuraCristalEffectActor : AAuraEffectActor
{
	UPROPERTY(DefaultComponent)
	UCapsuleComponent CapsuleComponent;

	UFUNCTION(BlueprintOverride)
	void ConstructionScript()
	{
		if (HasAuthority())
		{
			CapsuleComponent.OnComponentBeginOverlap.AddUFunction(this, n"OnCristalBeginOverlap");
		}
	}

	UFUNCTION()
	private void OnCristalBeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComp, int OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
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