class UGlobe_ProgressBar : UUserWidget
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
};