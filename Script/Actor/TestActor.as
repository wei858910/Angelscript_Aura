class ATestActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	UStaticMeshComponent RootMesh;

	UPROPERTY(DefaultComponent, Attach = RootMesh)
	USphereComponent Sphere;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameEffectClass;

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
		if (HasAuthority())
		{
			GASUtils::ApplyGameplayEffect(this, OtherActor, GameEffectClass);
		}
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
	}
};