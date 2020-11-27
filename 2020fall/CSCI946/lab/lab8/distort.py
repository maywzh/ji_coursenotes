import Augmentor
p = Augmentor.Pipeline('C:/Users/markus/clouds/nextcloud/teaching/CSCI446/2020/Labs/Week9')
p.greyscale(probability=1)
p.invert(probability=1)
p.rotate(probability=1, max_left_rotation=20, max_right_rotation=20)
p.zoom(probability=1, max_factor=1.20, min_factor=0.8)
p.shear(probability=1, max_shear_left=10, max_shear_right=10)
p.gaussian_distortion(probability=1, grid_width=5, grid_height=5, method='in', magnitude=18, corner='bell')
p.invert(probability=1)
p.sample(10)

