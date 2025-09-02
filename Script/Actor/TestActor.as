class ATestActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	UStaticMeshComponent RootMesh;

	UPROPERTY(DefaultComponent, Attach = RootMesh)
	USphereComponent Sphere;

	default Sphere.SetSphereRadius(150.f);

	UFUNCTION(BlueprintOverride)
	void ConstructionScript()
	{
		if (HasAuthority())
		{
			Sphere.OnComponentBeginOverlap.AddUFunction(this, n"OnTestActorBeginOverlap");
		}
	}

	UFUNCTION()
	private void OnTestActorBeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComp, int OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
	{
		if (GetLocalRole() == ENetRole::ROLE_Authority)
		{
			AAuraCharacter AuraCharacter = Cast<AAuraCharacter>(OtherActor);
			if (AuraCharacter != nullptr)
			{
				if (AuraCharacter.AttributeSet != nullptr)
				{
					float32 CurrentHealth = AuraCharacter.AttributeSet.Get().Health.CurrentValue;
					CurrentHealth += 10;
					AuraCharacter.AttributeSet.Get().Health.SetCurrentValue(CurrentHealth);
					AuraCharacter.AttributeSet.Get().Health.SetBaseValue(CurrentHealth);
				}
			}
		}
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
	}
};