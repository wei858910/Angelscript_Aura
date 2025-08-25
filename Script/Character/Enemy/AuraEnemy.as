class AAuraEnemy : AAuraCharacterBase
{
	default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);

	void HighLightEnemy()
	{
		if (IsValid(Mesh))
		{
			// Mesh.bRenderCustomDepth = true;
			Mesh.SetRenderCustomDepth(true);
			Mesh.SetCustomDepthStencilValue(0);
		}

		if (IsValid(Weapon))
		{
			Weapon.SetRenderCustomDepth(true);
			Weapon.SetCustomDepthStencilValue(0);
		}
	}

	void UnHighLight()
	{
		if (IsValid(Mesh))
		{
			// Mesh.bRenderCustomDepth = true;
			Mesh.SetRenderCustomDepth(false);
		}

		if (IsValid(Weapon))
		{
			Weapon.SetRenderCustomDepth(false);
		}
	}
};