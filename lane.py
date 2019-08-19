import numpy as np
from scipy.signal import savgol_filter
from scipy.interpolate import interp1d


class Lane(object):
    """
    Utility class for extracting useful properties of a lane.

    Parameters:

    x: array
        Array with x coordinates

    y: array
        Array with height coordinates of the lane
    """
    def __init__(self, x, y):
        self.x = np.linspace(np.min(x), np.max(x), len(x))
        interpolator = interp1d(x, y)
        self.y = interpolator(self.x)

    def height(self, smooth=3):
        """
        Returns an interpolator for the height of the lane

        Parameters:

        smooth: int
            Window length in Savgol-Filter. Has to be odd.
        """
        if smooth < 3:
            raise ValueError("smooth parameter has to be larger than 3")

        if smooth % 2 == 0:
            raise ValueError('smooth parameter has to be an odd number')

        filtered_data = savgol_filter(self.y, smooth, 3)
        return interp1d(self.x, filtered_data, bounds_error=False,
                        fill_value='extrapolate')

    def slope(self, smooth=3):
        """
        Returns an interpolator for the slope angle of the lane

        Parameters:

        smooth: int
            Window length in Savgol filter. Has to be odd.
        """
        if smooth < 3:
            raise ValueError('smooth parameter has to be larger than 3')

        if smooth % 2 == 0:
            raise ValueError('smooth parameter has to be an odd number')

        dydx = savgol_filter(self.y, smooth, 3, deriv=1)
        angle = np.arctan(-dydx)
        return interp1d(self.x, angle, bounds_error=False,
                        fill_value='extrapolate')

    def radius_of_curvature(self, smooth=3):
        """
        Returns the radius of curvatur

        Parameters

        smooth: int
            Window length in Savgol filter. Has to be odd.
        """
        if smooth < 3:
            raise ValueError('smooth parameter has to be larger than 3')

        if smooth % 2 == 0:
            raise ValueError('smooth parameter has to be an odd number')

        dy2dx2 = savgol_filter(self.y, smooth, 3, deriv=2)
        dydx = savgol_filter(self.y, smooth, 3, deriv=1)
        R = (1.0 + dydx**2)**1.5
        R /= dy2dx2
        return interp1d(self.x, R, bounds_error=False,
                        fill_value='extrapolate')
