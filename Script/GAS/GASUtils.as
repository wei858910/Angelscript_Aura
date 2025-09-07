namespace GASUtils
{
	FActiveGameplayEffectHandle ApplyGameplayEffectToTarget(AActor SourceActor, AActor TargetActor, TSubclassOf<UGameplayEffect> GameplayEffecClass, float32 InLevel = 1)
	{
		if (TargetActor == nullptr || SourceActor == nullptr || GameplayEffecClass == nullptr)
			return FActiveGameplayEffectHandle();

		UAbilitySystemComponent AbilitySystemComponent = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (!IsValid(AbilitySystemComponent))
			return FActiveGameplayEffectHandle();

		// AbilitySystemComponent.RemoveActiveGameplayEffect()

		FGameplayEffectContextHandle EffectContextHandle = AbilitySystemComponent.MakeEffectContext();
		EffectContextHandle.AddSourceObject(SourceActor);

		FGameplayEffectSpecHandle EffectSpecHandle = AbilitySystemComponent.MakeOutgoingSpec(GameplayEffecClass, InLevel, EffectContextHandle);
		return AbilitySystemComponent.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
	}

	void RemoveGameplayEffectFromTarget(AActor SourceActor, AActor TargetActor, FActiveGameplayEffectHandle EffectHandle, float32 InLevel = 1)
	{
		if (TargetActor == nullptr || SourceActor == nullptr)
			return;

		UAbilitySystemComponent AbilitySystemComponent = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (!IsValid(AbilitySystemComponent))
			return;

		AbilitySystemComponent.RemoveActiveGameplayEffect(EffectHandle);
	}
} // namespace GASUtils