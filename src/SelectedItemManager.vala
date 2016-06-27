public class SelectedItemManager
{
	private int selectedItem;
	private int Min;
	private int Max;

	public SelectedItemManager()
	{
		selectedItem = 0;
		Min = 0;
		Max = 0;
	}

	public int getSelected()
	{
		return selectedItem;
	}

	public void next()
	{
		if(selectedItem < Max)
		{
			selectedItem++;
		}
	}

	public void previous()
	{
		if(selectedItem > Min)
		{
			selectedItem--;
		}
	}

	public void setMax(int max)
	{
		Max = max;
	}

	public void setMin(int min)
	{
		Min = min;
	}
}
