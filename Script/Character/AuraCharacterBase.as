class AAuraCharacterBase : ACharacter
{
	// UPROPERTY(DefaultComponent, Attach = 父组件名, AttachSocket = 插槽名)
	UPROPERTY(DefaultComponent, Attach = CharacterMesh0, AttachSocket = WeaponHandSocket)
	USkeletalMeshComponent Weapon;

	// default 编辑器下运行，设置一些初始值和默认值
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	// https://angelscript.hazelight.se/api/#CClass:AActor:ConstructionScript
	// 生成组件和做其他设置的地方。
	UFUNCTION(BlueprintOverride)
	void ConstructionScript()
	{
		// 通过脚本方式 加载资产 不能在 default 语句后使用
		// USkeletalMesh MeshAsset = Cast<USkeletalMesh>(LoadObject(nullptr, "/Game/Assets/Characters/Aura/SKM_Aura.SKM_Aura"));
		// Mesh.SetSkeletalMeshAsset(MeshAsset);
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		// 游戏运行时执行
		// CapsuleComponent.CapsuleHalfHeight = 100.f;
	}
};