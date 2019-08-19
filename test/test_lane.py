import unittest
import numpy as np
from eksternlab import Lane


class TestLane(unittest.TestCase):
    def test_perfect_circle(self):
        t = np.linspace(0.1, np.pi/2.0-0.1, 500)
        x = -0.5 + np.sin(t)
        y = np.cos(t)

        lane = Lane(x, y)
        h = lane.height(smooth=5)
        self.assertTrue(np.allclose(h(x), y, atol=0.1))

        angle = lane.slope(smooth=5)
        expect = t
        self.assertTrue(np.allclose(expect, angle(x), atol=0.1))

        radius = lane.radius_of_curvature(smooth=5)
        self.assertTrue(np.allclose(radius(x)[10:-10], -1.0, atol=0.1))

if __name__ == '__main__':
    unittest.main()
