class AAuraCharacter : AAuraCharacterBase
{
	UPROPERTY(DefaultComponent)
	USpringArmComponent SpringArm;
	default SpringArm.TargetArmLength = 750;
	default SpringArm.SetRelativeRotation(FRotator(-45., 0, 0));
	default SpringArm.bInheritPitch = false;
	default SpringArm.bInheritYaw = false;
	default SpringArm.bInheritRoll = false;

	UPROPERTY(DefaultComponent, Attach = SpringArm)
	UCameraComponent Camra;

	// Character 相关属性设置
	default CharacterMovement.bOrientRotationToMovement = true;
	default CharacterMovement.RotationRate = FRotator(0, 400, 0);
	default CharacterMovement.bSnapToPlaneAtStart = true;
	default CharacterMovement.bConstrainToPlane = true;

	default bUseControllerRotationPitch = false;
	default bUseControllerRotationRoll = false;
	default bUseControllerRotationYaw = false;
};