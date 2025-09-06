class AAuraEffectActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	UStaticMeshComponent RootMesh;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameEffectClass;

	UPROPERTY(DefaultComponent)
	URotatingMovementComponent RotatingComponent;
	default RotatingComponent.RotationRate = FRotator(0.f, 60.f, 0.f);

	UPROPERTY()
	UMetaSoundSource SpawnSound;

	UPROPERTY()
	UMetaSoundSource GroundSound;

	UPROPERTY()
	UMetaSoundSource ConsumeSound;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		if (IsValid(SpawnSound))
		{
			Gameplay::PlaySound2D(SpawnSound);
		}
	}
};