class UWidgetController : UObject
{
	TObjectPtr<AAuraPlayerController> AuraPlayerController;

	TObjectPtr<AAuraPlayerState> AuraPlayerState;

	TObjectPtr<UAngelscriptAbilitySystemComponent> AbilitySystem;

	TObjectPtr<UAuraAttributeSet> AuraAttributeSet;

	void InitParams(AAuraPlayerController InPlayerController, AAuraPlayerState InPlayerState, UAngelscriptAbilitySystemComponent InAbilitySystem, UAuraAttributeSet InAttributeSet)
	{
		AuraPlayerController = InPlayerController;
		AuraPlayerState = InPlayerState;
		AbilitySystem = InAbilitySystem;
		AuraAttributeSet = InAttributeSet;
	}
};