public class MovementManager
{
	private GLib.List<Movement> Movements;
	private bool paused;

	public MovementManager()
	{
		paused = false;
	}

	public void addMovement(Movement movement)
	{
		paused = true;
		for(int i = 0; i < Movements.length(); i++)
		{
			if(Movements.nth_data(i).getWidget() == movement.getWidget())
			{
				Movements.nth_data(i).updateMovment(movement);
				paused = false;
				return;
			}
		}
		Movements.append(movement);
		paused = false;
	}

	public void* run()
	{
		while(true)
		{
			Thread.usleep(1000);
			for(int i = 0; i < Movements.length(); i++)
			{
				if(!paused)
				{
					Movements.nth_data(i).update();
				}
				if(Movements.nth_data(i).remove())
				{
					Movements.remove(Movements.nth_data(i));
				}
			}
		}
	}
}
