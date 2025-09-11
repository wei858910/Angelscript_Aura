
enum EGameEffectType
{
	EGET_Normal,  // 一般游戏效果类型
	EGET_Infinite // 永久性游戏效果类型
}

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

	UPROPERTY()
	EGameEffectType GameEffectType = EGameEffectType::EGET_Normal;

	UPROPERTY()
	EItemID ItemID;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		if (IsValid(SpawnSound) && !HasAuthority() && GameEffectType != EGameEffectType::EGET_Infinite)
		{
			Gameplay::PlaySound2D(SpawnSound);
		}
	}

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		if (HasAuthority())
		{
			EffectHandle = GASUtils::ApplyGameplayEffectToTarget(this, OtherActor, GameEffectClass);
		}
		else
		{
			if (IsValid(ConsumeSound) && GameEffectType != EGameEffectType::EGET_Infinite)
			{
				Gameplay::PlaySound2D(ConsumeSound);
			}

			UAuraGameInstanceSubsystem::Get().OnItemPickupedEvent.Broadcast(ItemID);
		}

		if (GameEffectType == EGameEffectType::EGET_Normal)
		{
			DestroyActor();
		}
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		if (HasAuthority())
		{
			if (GameEffectType == EGameEffectType::EGET_Infinite)
			{
				GASUtils::RemoveGameplayEffectFromTarget(this, OtherActor, EffectHandle);
			}
		}

		if (GameEffectType == EGameEffectType::EGET_Normal)
		{
			DestroyActor();
		}
	}
};