class UEnemyAim : UAnimInstance
{
	TObjectPtr<AAuraEnemy> Owner;

	UPROPERTY(BlueprintReadOnly)
	float MoveSpeed = 0.;

	UFUNCTION(BlueprintOverride)
	void BlueprintInitializeAnimation()
	{
		Owner = Cast<AAuraEnemy>(TryGetPawnOwner());
	}

	UFUNCTION(BlueprintOverride)
	void BlueprintUpdateAnimation(float DeltaTimeX)
	{
		if (Owner != nullptr)
		{
			MoveSpeed = Owner.Get().MovementComponent.Velocity.Size2D();
		}
	}
};