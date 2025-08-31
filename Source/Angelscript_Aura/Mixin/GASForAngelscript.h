// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "AbilitySystemComponent.h"
#include "UObject/Object.h"
#include "GASForAngelscript.generated.h"

/**
 * 
 */
UCLASS(Meta = (ScriptMixin = "UAbilitySystemComponent"))
class ANGELSCRIPT_AURA_API UGASForAngelscript : public UObject
{
	GENERATED_BODY()
public:
	UFUNCTION(ScriptCallable)
	static void SetReplicationMode(UAbilitySystemComponent* ASC, const EGameplayEffectReplicationMode NewReplicationMode)
	{
		ASC->SetReplicationMode(NewReplicationMode);
	}
};
