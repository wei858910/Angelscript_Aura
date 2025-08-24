class AAuraPlayerController : APlayerController
{
	UPROPERTY(Category = "输入")
	UInputAction MoveAction;

	UPROPERTY(Category = "输入")
	UInputMappingContext IMC_AuraContext;

	UEnhancedInputComponent EnhancedInputCompoent;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		EnhancedInputCompoent = UEnhancedInputComponent::Create(this);
		UEnhancedInputLocalPlayerSubsystem EnhancedInputSubsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
		EnhancedInputSubsystem.AddMappingContext(IMC_AuraContext, 0, FModifyContextOptions());

		EnhancedInputCompoent.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"Move"));
		PushInputComponent(EnhancedInputCompoent);
	}

	UFUNCTION()
	private void Move(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction)
	{
		FVector2D Value = ActionValue.Axis2D;
		Print(f"{Value.ToString()}");

		FVector ControllerForwardVector = GetControlRotation().ForwardVector;
		FVector ControlerRightVector = GetControlRotation().RightVector;

		APawn ControlledAura = GetControlledPawn();
		if (ControlledAura != nullptr)
		{
			ControlledAura.AddMovementInput(ControllerForwardVector, Value.Y);
			ControlledAura.AddMovementInput(ControlerRightVector, Value.X);
		}
	}
};