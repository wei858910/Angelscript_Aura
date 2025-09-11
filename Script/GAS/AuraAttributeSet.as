
namespace AuraAttributeSetName
{
	const FName Health = n"Health";
	const FName MaxHealth = n"MaxHealth";
	const FName Mana = n"Mana";
	const FName MaxMana = n"MaxMana";
} // namespace AuraAttributeSetName

struct FEffectProperties
{
	FEffectProperties() {}

	FGameplayEffectContextHandle EffectContextHandle;

	UPROPERTY()
	UAngelscriptAbilitySystemComponent SourceASC = nullptr;

	UPROPERTY()
	AActor SourceAvatarActor = nullptr;

	UPROPERTY()
	AController SourceController = nullptr;

	UPROPERTY()
	ACharacter SourceCharacter = nullptr;

	UPROPERTY()
	UAngelscriptAbilitySystemComponent TargetASC = nullptr;

	UPROPERTY()
	AActor TargetAvatarActor = nullptr;

	UPROPERTY()
	AController TargetController = nullptr;

	UPROPERTY()
	ACharacter TargetCharacter = nullptr;
}

class UAuraAttributeSet : UAngelscriptAttributeSet
{
	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY(ReplicatedUsing = OnRep_AttributeDataChanged)
	FAngelscriptGameplayAttributeData MaxMana;

	UAuraAttributeSet()
	{
		Health.Initialize(50.f);
		MaxHealth.Initialize(100.f);

		Mana.Initialize(12.f);
		MaxMana.Initialize(50.f);
	}

	UFUNCTION()
	void OnRep_AttributeDataChanged(FAngelscriptGameplayAttributeData& OldData)
	{
		OnRep_Attribute(OldData);
	}

	// 属性BaseValue预测
	UFUNCTION(BlueprintOverride)
	void PreAttributeBaseChange(FGameplayAttribute Attribute, float32& NewValue) const
	{
		Print(f"{Attribute.AttributeName}, NewValue = {NewValue}");
	}

	// 属性CurrentValue预测
	UFUNCTION(BlueprintOverride)
	void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
	{
		Print(f"{Attribute.AttributeName}, NewValue = {NewValue}");
	}

	// 游戏效果预测
	UFUNCTION(BlueprintOverride)
	bool PreGameplayEffectExecute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent AbilitySystemComponent)
	{
		Print(f"{EvaluatedData.GetAttribute().AttributeName}");
		return true;
	}

	// 对属性的钳制
	void ClampingAttributeValue(FString InAttributeName)
	{
		if (InAttributeName == Health.AttributeName)
		{
			Health.SetCurrentValue(Math::Clamp(Health.GetCurrentValue(), 0., MaxHealth.GetCurrentValue()));
			Health.SetBaseValue(Math::Clamp(Health.GetBaseValue(), 0., MaxHealth.GetCurrentValue()));
		}

		if (InAttributeName == Mana.AttributeName)
		{
			Mana.SetCurrentValue(Math::Clamp(Mana.CurrentValue, 0., MaxMana.CurrentValue));
			Mana.SetBaseValue(Math::Clamp(Mana.BaseValue, 0., MaxMana.CurrentValue));
		}
	}

	UFUNCTION(BlueprintOverride)
	void PostAttributeBaseChange(FGameplayAttribute Attribute, float OldValue, float NewValue) const
	{
		Print(f"Attribute Name = {Attribute.AttributeName}, OldValue = {OldValue}, NewValue = {NewValue}");
	}

	UFUNCTION(BlueprintOverride)
	void PostAttributeChange(FGameplayAttribute Attribute, float OldValue, float NewValue)
	{
		Print(f"Attribute Name = {Attribute.AttributeName}, OldValue = {OldValue}, NewValue = {NewValue}");
	}

	void SetEffectProperties(const FGameplayEffectSpec EffectSpec, UAngelscriptAbilitySystemComponent InTargetASC, FEffectProperties& Props)
	{
		Props.EffectContextHandle = EffectSpec.GetContext();
		Props.SourceASC = Cast<UAngelscriptAbilitySystemComponent>(Props.EffectContextHandle.GetOriginalInstigatorAbilitySystemComponent());

		if (IsValid(Props.SourceASC) && IsValid(Props.SourceASC.GetAbilityActorInfo().GetAvatarActor()))
		{
			Props.SourceAvatarActor = Props.SourceASC.GetAbilityActorInfo().GetAvatarActor();
			Props.SourceController = Props.SourceASC.GetAbilityActorInfo().GetPlayerController();
			if (Props.SourceController == nullptr && Props.SourceAvatarActor != nullptr)
			{
				APawn Pawn = Cast<APawn>(Props.SourceAvatarActor);
				if (IsValid(Pawn))
				{
					Props.SourceController = Pawn.GetController();
				}
			}

			if (IsValid(Props.SourceController))
			{
				Props.SourceCharacter = Cast<ACharacter>(Props.SourceController.GetControlledPawn());
			}
		}

		if (IsValid(InTargetASC))
		{
			Props.TargetASC = InTargetASC;
			Props.TargetAvatarActor = InTargetASC.GetAbilityActorInfo().GetAvatarActor();
			Props.TargetController = InTargetASC.GetAbilityActorInfo().GetPlayerController();
			Props.TargetCharacter = Cast<ACharacter>(InTargetASC.GetAbilityActorInfo().GetAvatarActor());
		}
	}

	// 属性修改后最终会调用到的地方。
	// 可以做一些， 数值范围修正
	// 其他期望的动作
	UFUNCTION(BlueprintOverride)
	void PostGameplayEffectExecute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent AbilitySystemComponent)
	{
		ClampingAttributeValue(EvaluatedData.GetAttribute().AttributeName);

		FEffectProperties EffectProperties;
		SetEffectProperties(EffectSpec, AbilitySystemComponent, EffectProperties);
	}
};