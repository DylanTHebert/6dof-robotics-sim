function [H0e_check, t, htm_all] = get_htm(joint_order, link_lengths)
n = max(size(link_lengths));
%generate htms for the robot
%assume the axis are aligned such that transaltion is always in the x
%direction, in other words the next joint position is some x-displacemetn
%from the previous, except for the first, which is a z translation, b/c
%robot designs are normally like that, whatever
%symbolic thetas
t = sym('t',[1 n]) ;
htm = sym([1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]);
%each type of rotation matrix
% for i = 1:n
%    if(joint_order(i) == 'z')
%        %create htm
%        htm(:,:,i) = [cos(t(i)) -sin(t(i)) 0 0; sin(t(i)) cos(t(i)) 0 0; 0 0 1 link_lengths(i); 0 0 0 1];
%        %htm(:,:,i) = [1 0 0 0; 0 1 0 0; 0 0 1 link_lengths(i); 0 0 0 1 ];
%    elseif(joint_order(i) == 'x')
%        htm(:,:,i) = [1 0 0 link_lengths(i); 0 cos(t(i)) -sin(t(i)) 0; 0 sin(t(i)) cos(t(i)) 0; 0 0 0 1];       
%        %htm(:,:,i) = [1 0 0 link_lengths(i); 0 1 0 0; 0 0 1 0; 0 0 0 1 ];
%    else
%        htm(:,:,i) = [cos(t(i)) 0 sin(t(i)) link_lengths(i); 0 1 0 0; -sin(t(i)) 0 cos(t(i)) 0; 0 0 0 1];
%        %htm(:,:,i) = [1 0 0 0; 0 1 0 link_lengths(i); 0 0 1 0; 0 0 0 1 ];
%    end
% end
htm(:,:,1) = [1 0 0 0; 0 1 0 0; 0 0 1 link_lengths(1); 0 0 0 1 ];
htm(:,:,2) = [cos(t(2)) 0 sin(t(2)) 50; 0 1 0 0; -sin(t(2)) 0 cos(t(2)) link_lengths(2); 0 0 0 1];%z and x translation/bc robot design is not simple:( 
htm(:,:,3) = [cos(t(3)) 0 sin(t(3)) link_lengths(3); 0 1 0 0; -sin(t(3)) 0 cos(t(3)) 0;0 0 0 1];
htm(:,:,4) = [1 0 0 link_lengths(4); 0 cos(t(4)) -sin(t(4)) 0; 0 sin(t(4)) cos(t(4)) 35; 0 0 0 1];%same here
htm(:,:,5) = [cos(t(5)) 0 sin(t(5)) link_lengths(5); 0 1 0 0; -sin(t(5)) 0 cos(t(5)) 0;0 0 0 1];
htm(:,:,6) = [1 0 0 link_lengths(6); 0 cos(t(6)) -sin(t(6)) 0; 0 sin(t(6)) cos(t(6)) 0; 0 0 0 1];
H0e_check = htm(:,:,1);
for i = 1:n-1
    %total HTM
    H0e_check = H0e_check*htm(:,:,i+1);
end
htm_all = htm;
end