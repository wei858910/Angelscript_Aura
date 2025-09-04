
namespace AuraMath
{
	float32 SafeDivide(float32 Num1, float32 Num2)
	{
		if (Num2 == 0.f)
			return 0.f;

		return Num1 / Num2;
	}
} // namespace AuraMath