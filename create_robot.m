%create robot using rigidbody tree
%get my HTMS b/c I can use them here
joint_order = [ 'z', 'z','y' 'y' 'x' 'y' 'x' ];
vec_joint_order = [0 0 1; 0 1 0; 0 1 0; 1 0 0; 0 1 0; 1 0 0;];
%link_lengths = [0 0.161 0.44 0.09024 0.32976 0.08 0.08];
link_lengths = [0 0.161 0.44 0.09024 0.32976 0.08];
link_lengths = link_lengths*1000;
%mesh file names locally as 
mesh_file = ["base.stl" "body1.stl" "body2.stl" "body3.stl" "body4.stl" "body5_2.stl", "body6.stl","body7.stl"];
%rotational limitations
%rot_limits = []
[H0e, t, htm_all] = get_htm(joint_order,link_lengths);
%make the robot  tree
rbtree_welder_bot = rigidBodyTree('DataFormat','row');
%create bodies and joints
body1 = rigidBody('b1');
joint1 = rigidBodyJoint('joint1','revolute');
joint1.JointAxis = vec_joint_order(1,:);
body2 = rigidBody('b2');
joint2 = rigidBodyJoint('joint2','revolute');
joint2.JointAxis = vec_joint_order(2,:);
body3 = rigidBody('b3');
joint3  = rigidBodyJoint('joint3','revolute');
joint3.JointAxis = vec_joint_order(3,:);
body4 = rigidBody('b4');
joint4 = rigidBodyJoint('joint4','revolute');
joint4.JointAxis = vec_joint_order(4,:);
body5 = rigidBody('b5');
joint5 = rigidBodyJoint('joint5','revolute');
joint5.JointAxis = vec_joint_order(5,:);
body6 = rigidBody('b6');
joint6 = rigidBodyJoint('joint6','revolute');
joint6.JointAxis = vec_joint_order(6,:);
%create transforms
htm_all2 = double(subs(htm_all,t,[0 -pi/3 pi/2 0 pi/2 0]));
htm_all2(:,:,1);
%little offset that didn't originally plan for
setFixedTransform(joint1, htm_all2(:,:,1));
setFixedTransform(joint2, htm_all2(:,:,2));
setFixedTransform(joint3, htm_all2(:,:,3));
setFixedTransform(joint4, htm_all2(:,:,4));
setFixedTransform(joint5, htm_all2(:,:,5));
setFixedTransform(joint6, htm_all2(:,:,6));
%asign joints to bodies
body1.Joint = joint1;
body2.Joint = joint2;
body3.Joint = joint3;
body4.Joint = joint4;
body5.Joint = joint5;
body6.Joint = joint6;
%add visuals to bodies
addVisual(rbtree_welder_bot.Base, "Mesh", mesh_file(1));
addVisual(body1, "Mesh", mesh_file(2));
addVisual(body2, "Mesh", mesh_file(3));
addVisual(body3, "Mesh", mesh_file(4));
addVisual(body4, "Mesh", mesh_file(5));
addVisual(body5, "Mesh", mesh_file(6));
%addVisual(body6, "Mesh", mesh_file(7));
%add bodies to tree
basename = rbtree_welder_bot.BaseName;
addBody(rbtree_welder_bot,body1,basename);
rbtree_welder_bot.BodyNames;
addBody(rbtree_welder_bot,body2,'b1');
addBody(rbtree_welder_bot,body3,'b2');
addBody(rbtree_welder_bot,body4,'b3');
addBody(rbtree_welder_bot,body5,'b4');
addBody(rbtree_welder_bot,body6,'b5');


%axis([-1.5,1.5,-1.5,1.5,-1.5,1.5])



%throw some meshes on the robot
%try some kinematics
% 
% showdetails(rbtree_welder_bot);
% show(rbtree_welder_bot);
% axis([-150,1500,-500,1000,-150,1000]);
% view([660 -250 200])
% camzoom(2)
%inverse kin parameters, paths
r = 500;
% height = 150;
% distr = linspace(0,pi/2,60);
% x = r*cos(distr);
% y = r*sin(distr);
% z = ones(size(distr))*height;
% circle_path = [x;y;z];
orientation = [0 0 -1; 0 -1 0; -1 0 0];
initialguess = [pi/4 0 0 0 pi/2 0];
% 
% %create set of solution vectors
% con_sol = inv_kin(circle_path, orientation,rbtree_welder_bot,initialguess);
% 
% %create video
% framerate = 20;
% create_vid(rbtree_welder_bot, con_sol, circle_path, framerate)

%testing paths 
% amp = 10;
% n = 5000;
% omega = 1;
% straight_path4d = ones(4,n);
% straight_path4d(1,:) =  linspace(100,0,n);
% straight_path4d(2,:) = 500;
% staight_path4d(4,1) = 0;
% staight_path4d(3,:) = 150;
% wave = generate_wave_path(straight_path4d, amp, omega);
% hold on
% plot(wave(2,:),wave(1,:))

% %final rough circle path
% amp = 10;
% n = 100;
% omega = 10;
% r_p = 150;
% omega = .1;
% distr = linspace(-pi,pi,n);
% curved_path = ones(4,n);
% curved_path(2,:) = r_p*sin(distr);
% curved_path(1,:) = r_p*cos(distr);
% curved_path(4,1) = 0;
% curved_path(:,n) = [-r_p+(1*amp);0;0;0];
% plot(curved_path(1,:),curved_path(2,:))
% wave = generate_wave_path(curved_path, amp, omega);
% plot(wave(1,:),wave(2,:));
% %shift it into robot frame
% wave(1,:) = wave(1,:) + 500;
% wave(2,:) = wave(2,:) + 0;
% wave(3,:) = wave(3,:) + 120;
% cut_wave = wave(:,1:n-2);
% plot3(cut_wave(1,:),cut_wave(2,:),cut_wave(3,:))


%wave in zy plane just for viewing
orientation = [1 0 0; 0 1 0; 0 0 1];
amp = 50;
n = 100;
omega = .1;
norm_to_plane = [1 0 0];
straight_path4d = ones(4,n);
straight_path4d(2,:) =  linspace(0,200,n);
straight_path4d(1,:) = 650;
straight_path4d(4,1) = 0;
straight_path4d(3,:) = 500;
wave = generate_wave_path(straight_path4d, amp, omega, norm_to_plane);
hold on
cut_wave = wave(:,2:n-1);
plot3(cut_wave(1,:),cut_wave(2,:),cut_wave(3,:))


con_sol = inv_kin(cut_wave, orientation, rbtree_welder_bot, initialguess);
hold on
plot3(wave(1,:),wave(2,:),wave(3,:))
framerate = 6;
create_vid(rbtree_welder_bot, con_sol, cut_wave, framerate,'wave_circle')

cos wave
amp = 0.01;
n = 10000;
r_p = 1;
omega = 200;
omega_1 = 3;
omega_2 = 10;
distr = linspace(0,pi,n);
curved_path = ones(4,n);
curved_path(2,:) = r_p*cos(omega_1*distr);
curved_path(1,:) = distr;
curved_path(3,:) = 0;
curved_path(4,:) = 1;
curved_path(4,1) = 0;

%curved_path(:,n) = [-r_p+(1*amp);0;0;0];
plot(curved_path(1,:),curved_path(2,:))
hold on
[wave, perturb_vec] = generate_wave_path(curved_path, amp, omega);
plot(wave(1,:),wave(2,:));

%pure circle
% amp = 5;
% n = 100;
% omega = 1;
% r_p = 150;
% distr = linspace(-pi,pi,n);
% curved_path = ones(4,n);
% curved_path(2,:) = r_p*sin(distr);
% curved_path(1,:) = r_p*cos(distr);
% curved_path(4,1) = 0;
% curved_path(:,n) = [-r_p+(1*amp);0;0;0];
% plot(curved_path(1,:),curved_path(2,:))
% wave = generate_wave_path(curved_path, amp, omega);
% plot(wave(1,:),wave(2,:));
% %shift it into robot frame
% % wave(1,:) = wave(1,:) + 500;
% % wave(2,:) = wave(2,:) + 0;
% % wave(3,:) = wave(3,:) + 120;
% cut_wave = wave(:,1:n-2);
% plot(curved_path(1,:),curved_path(2,:))
% hold on
% plot(cut_wave(1,:),cut_wave(2,:))

%view the joint angles
% joint_step = linspace(0,1,n-2);
% for i = 1:6
%     figure(i)
%     hold on
%     plot(joint_step,con_sol(:,i)','g')
%     xlim([0 1])
%     ylim([-1 1])
% end









