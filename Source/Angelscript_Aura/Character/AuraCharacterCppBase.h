// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Character.h"
#include "AbilitySystemInterface.h"
#include "AuraCharacterCppBase.generated.h"

UCLASS()
class ANGELSCRIPT_AURA_API AAuraCharacterCppBase : public ACharacter, public IAbilitySystemInterface
{
	GENERATED_BODY()

public:
	// Sets default values for this character's properties
	AAuraCharacterCppBase();

	virtual void OnRep_PlayerState() override;

	UFUNCTION(BlueprintImplementableEvent)
	void BP_OnRep_PlayerState();

	UPROPERTY(BlueprintReadWrite)
	TObjectPtr<UAbilitySystemComponent> AbilitySystemComponent;

	virtual UAbilitySystemComponent* GetAbilitySystemComponent() const override;
};
