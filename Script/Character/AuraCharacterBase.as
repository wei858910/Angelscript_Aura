class AAuraCharacterBase : ACharacter
{

	UPROPERTY(DefaultComponent, Attach = CharacterMesh0, AttachSocket = WeaponHandSocket)
	USkeletalMeshComponent Weapon;

	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	UFUNCTION(BlueprintOverride)
	void ConstructionScript()
	{
        // 通过脚本方式 加载资产
		// USkeletalMesh MeshAsset = Cast<USkeletalMesh>(LoadObject(nullptr, "/Game/Assets/Characters/Aura/SKM_Aura.SKM_Aura"));
		// Mesh.SetSkeletalMeshAsset(MeshAsset);
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		// CapsuleComponent.CapsuleHalfHeight = 100.f;
	}
};