class AAuraEffectActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	UStaticMeshComponent RootMesh;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameEffectClass;

	float YawRotation = Math::RandRange(10.f, 180.f);

	UPROPERTY(DefaultComponent)
	URotatingMovementComponent RotatingComponent;
	default RotatingComponent.RotationRate = FRotator(0.f, YawRotation, 0.f);

	UPROPERTY()
	UMetaSoundSource SpawnSound;

	UPROPERTY()
	UMetaSoundSource GroundSound;

	UPROPERTY()
	UMetaSoundSource ConsumeSound;

	FActiveGameplayEffectHandle EffectHandle;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		if (IsValid(SpawnSound))
		{
			Gameplay::PlaySound2D(SpawnSound);
		}
	}

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		EffectHandle = GASUtils::ApplyGameplayEffectToTarget(this, OtherActor, GameEffectClass);
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		GASUtils::RemoveGameplayEffectToTarget(this, OtherActor, EffectHandle);
	}
};