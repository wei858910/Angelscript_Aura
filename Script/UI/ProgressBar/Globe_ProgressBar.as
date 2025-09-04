class UGlobe_ProgressBar : UUI_AuraWidget
{
	UPROPERTY(BindWidget)
	USizeBox SizeBox_Root;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Ghost;

	UPROPERTY(BindWidget)
	UImage Image_Background;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Globe;

	UPROPERTY(BindWidget)
	UImage Image_Glass;

	UPROPERTY(Category = GlobeProgressBar)
	int BoxWidth = 250;
	UPROPERTY(Category = GlobeProgressBar)
	int BoxHeight = 250;

	UPROPERTY(Category = GlobeProgressBar)
	float32 GlobePadding = 10;

	UPROPERTY(Category = GlobeProgressBar)
	FSlateBrush BackgroundBrush;

	UPROPERTY(Category = GlobeProgressBar)
	FProgressBarStyle ProgressBarGlobeStyle;

	UPROPERTY(Category = GlobeProgressBar)
	FProgressBarStyle GhostProgressBarGlobeStyle;

	UPROPERTY(Category = GlobeProgressBar)
	FSlateBrush GlassBrush;

	private float32 Value;
	private float32 MaxValue;
	private float32 Percent;
	private const float32 ChaseSpeed = 0.1f;

	void UpdateBoxSize()
	{
		SizeBox_Root.SetWidthOverride(BoxWidth);
		SizeBox_Root.SetHeightOverride(BoxHeight);
	}

	void UpdateBackgroundBrush()
	{
		Image_Background.SetBrush(BackgroundBrush);
	}

	void UpdateGlobeStyle()
	{
		ProgressBar_Globe.WidgetStyle = ProgressBarGlobeStyle;
		ProgressBar_Ghost.WidgetStyle = GhostProgressBarGlobeStyle;
	}

	void UpdateGlobePadding()
	{
		UOverlaySlot ProgressBarSlot = WidgetLayout::SlotAsOverlaySlot(ProgressBar_Globe);
		if (ProgressBarSlot != nullptr)
		{
			ProgressBarSlot.SetPadding(FMargin(GlobePadding, GlobePadding, GlobePadding, GlobePadding));
		}
	}

	void UpdateGlassBrush()
	{
		Image_Glass.SetBrush(GlassBrush);
	}

	void UpdateGlassPadding()
	{

		UOverlaySlot GlassSlot = WidgetLayout::SlotAsOverlaySlot(Image_Glass);
		if (GlassSlot != nullptr)
		{
			GlassSlot.SetPadding(FMargin(GlobePadding, GlobePadding, GlobePadding, GlobePadding));
		}
	}

	UFUNCTION(BlueprintOverride)
	void PreConstruct(bool IsDesignTime)
	{
		UpdateBoxSize();
		UpdateBackgroundBrush();
		UpdateGlobeStyle();
		UpdateGlobePadding();
		UpdateGlassBrush();
		UpdateGlassPadding();
	}

	void SetProgressBarPercent(float32 NewValue, float32 NewMaxValue)
	{
		if (NewValue == Value && NewMaxValue == MaxValue)
		{
			return;
		}

		Value = NewValue;
		MaxValue = NewMaxValue;
		Percent = AuraMath::SafeDivide(Value, MaxValue);

		float NewPercent = AuraMath::SafeDivide(NewValue, NewMaxValue);

		float MainPercent = ProgressBar_Globe.Percent;
		float GhostPercent = ProgressBar_Ghost.Percent;

		if (NewPercent < MainPercent)
		{
			if (NewPercent < GhostPercent)
			{
				ProgressBar_Globe.SetPercent(NewPercent);
			}
		}
		else
		{
			if (NewPercent > GhostPercent)
			{
				ProgressBar_Ghost.SetPercent(NewPercent);
			}
			else
			{
				ProgressBar_Globe.SetPercent(NewPercent);
			}
		}
	}

	void ChasingProgress(float DeltaTime)
	{
		float32 MainPercent = ProgressBar_Globe.Percent;
		float32 GhostPercent = ProgressBar_Ghost.Percent;

		if (MainPercent == GhostPercent && MainPercent == Percent)
		{
			return;
		}

		UProgressBar ChasingProgressBar = (MainPercent != Percent) ? ProgressBar_Globe : ProgressBar_Ghost;

		float32 DeltePercent = ChaseSpeed * float32(DeltaTime);

		if (ChasingProgressBar.Percent < Percent)
		{
			ChasingProgressBar.SetPercent(Math::Min(ChasingProgressBar.Percent + DeltePercent, Percent));
		}
		else
		{
			ChasingProgressBar.SetPercent(Math::Max(ChasingProgressBar.Percent - DeltePercent, Percent));
		}
	}

	UFUNCTION(BlueprintOverride)
	void Tick(FGeometry MyGeometry, float InDeltaTime)
	{
		ChasingProgress(InDeltaTime);
	}
};