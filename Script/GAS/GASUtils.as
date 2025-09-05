namespace GASUtils
{
	void ApplyGameplayEffect(AActor SourceActor, AActor TargetActor, TSubclassOf<UGameplayEffect> GameplayEffecClass, float32 InLevel = 1)
	{
		if (TargetActor == nullptr || SourceActor == nullptr)
			return;

		if (GameplayEffecClass == nullptr)
			return;

		UAbilitySystemComponent AbilitySystemComponent = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (!IsValid(AbilitySystemComponent))
			return;

		FGameplayEffectContextHandle EffectContextHandle = AbilitySystemComponent.MakeEffectContext();
		EffectContextHandle.AddSourceObject(SourceActor);

		FGameplayEffectSpecHandle EffectSpecHandle = AbilitySystemComponent.MakeOutgoingSpec(GameplayEffecClass, InLevel, EffectContextHandle);
		AbilitySystemComponent.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
	}
} // namespace GASUtils