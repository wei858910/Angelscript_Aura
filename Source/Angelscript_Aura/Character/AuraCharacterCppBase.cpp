// Fill out your copyright notice in the Description page of Project Settings.


#include "AuraCharacterCppBase.h"


// Sets default values
AAuraCharacterCppBase::AAuraCharacterCppBase()
{
	PrimaryActorTick.bCanEverTick = false;
}

void AAuraCharacterCppBase::OnRep_PlayerState()
{
	Super::OnRep_PlayerState();
	BP_OnRep_PlayerState();
}



