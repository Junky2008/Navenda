public class MovementManager
{
	private GLib.List<Movement> Movements;

	public MovementManager()
	{

	}

	public void addMovement(Movement movement)
	{
		Movements.append(movement);
	}

	public void updateMovement(Movement movement)
	{

	}

	public void* run()
	{
		while(true)
		{
			Thread.usleep(1000);
			for(int i = 0; i < Movements.length(); i++)
			{
				Movements.nth_data(i).update();
				if(Movements.nth_data(i).remove())
				{
					Movements.remove(Movements.nth_data(i));
				}
			}
		}
	}
}
