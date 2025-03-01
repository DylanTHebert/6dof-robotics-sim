%all parameters
joint_order = ['z' 'y' 'y' 'x' 'y' 'x' ];
link_lengths = [0.33 0.44 0.100 0.32 0.08 0];
num_points = 100
spin_around_j1 = zeros(max(size(joint_order)),num_points)
%joint1 0-360
spin_around_j1(1,:) = (linspace(0,360,num_points)*(pi/180));
%joint 2 0-45
spin_around_j1(2,:) = (linspace(0,45,num_points)*(pi/180));
[H0e, t] = get_htm(joint_order,link_lengths);

%[htm_result, rotation, position] = find_FDA(H0e, spin_around_j1, t)
%plot3(position(1,:),position(2,:),position(3,:))

H0e



