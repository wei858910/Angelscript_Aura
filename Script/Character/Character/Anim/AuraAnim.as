class UAuraAnim : UAnimInstance
{
	TObjectPtr<AAuraCharacter> Owner;

	UPROPERTY(BlueprintReadOnly)
	float MoveSpeed = 0.;

	UPROPERTY(BlueprintReadOnly)
	bool bShouldMove = false;

	UFUNCTION(BlueprintOverride)
	void BlueprintInitializeAnimation()
	{
		Owner = Cast<AAuraCharacter>(TryGetPawnOwner());
	}

	UFUNCTION(BlueprintOverride)
	void BlueprintUpdateAnimation(float DeltaTimeX)
	{
		if (Owner != nullptr)
		{
			MoveSpeed = Owner.Get().MovementComponent.Velocity.Size2D();

			bShouldMove = MoveSpeed > 3. ? true : false;
		}
	}
};