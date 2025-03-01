%take in info for the wave, amplitude, frquency, waveform??
%and an array of points in 3 space
function [wave_points, perturb_vec] = generate_wave_path(path4d, amp, omega, norm_to_plane)
%path should be specified as x;y;z;g vector where g is 1 if its a welded
%point and 0 if its traversal
phi = 0;
N = max(size(path4d));
wave_points = zeros(3,N);
perturb_vec = zeros(3,N);
arc_length = 0;
%abs fix some of the issues I'm having? 
%decide what plane I'm printing on, for the moment just assume x,y, slice
%along z axis, point 0,0,0 with vector 0,0,1
%norm_to_plane  = [0;0;1];
for i=1:N
    if(i == N )
       %this point doesnt have a next point to create the vect, keep same as last one
       %find p(i)-p(i-1)
%             path_vec = path4d(1:3,i) - path4d(1:3,i-1);
%             %perturb_vec = cross norm_plane x path vec
%             perturb_vec = cross(norm_to_plane,path_vec);
%             %perturn into unit vect(norm)
%             unit_perturb_vec = perturb_vec/norm(perturb_vec);
%             %point = cos(arc_length)*unit
              %wave_points(:,i) = unit_perturb_vec * (amp*cos(arc_length*omega + phi));
              %keep same
              wave_points(:,i) = path4d(1:3,i);
              
    end
    if(path4d(4,i) == 0)
        %not connected to previous
        wave_points(:,i) = path4d(1:3,i);
        arc_length = 0;
    end
    if(path4d(4,i) == 1 && i ~= N)
        %connected to previous
        %perturb point
            %find p(i+1)-p(i)
            path_vec = path4d(1:3,i+1) - path4d(1:3,i);
            %perturb_vec = cross norm_plane x path vec
            perturb_vec(:,i) = cross(norm_to_plane,path_vec);
            %perturn into unit vect(norm)
            unit_perturb_vec = perturb_vec(:,i)/norm(perturb_vec(:,i));
            %point = point + cos(arc_length)*unit_perturb
            full_perturb = (unit_perturb_vec * (amp*cos(arc_length*omega + phi)));
            path4d(:,i);
            wave_points(:,i) = path4d(1:3,i) + full_perturb;
        %sum arc_length
        arc_length = arc_length + dist(path4d(:,i+1),path4d(:,i));
    end
    


end
