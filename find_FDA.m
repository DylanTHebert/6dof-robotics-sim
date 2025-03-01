function [htm_result, rotation, position] = find_FDA(htm, joint_angle, t)
    %substitute in joint angles for each postion provided
    %joint angles are in shape(N,M) where N = # of joints,
    %M is the # of sampled points
    htm
    rotation = zeros(3,size(joint_angle,2));
    position = zeros(3,size(joint_angle,2));
    htm_result = zeros(4,4,size(joint_angle,2));
    for i = 1:size(joint_angle,2)
        htm_result(:,:,i) = subs(htm,t,joint_angle(:,i)');
        rotation(1,i) = -asin(htm_result(3,1,i));
        rotation(2,i) = atan2(htm_result(3,2,i),htm_result(3,3,i));
        rotation(3,i) = atan2(htm_result(2,1,i),htm_result(1,1,i));
        position(:,i) = htm_result(1:3,end,i);
    end
end