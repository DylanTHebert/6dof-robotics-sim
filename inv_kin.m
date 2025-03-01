%inverse KIN
function [con_sol] = inv_kin(path_3d, orientation, robot_rbtree, initial_guess)
    %loop through them
    ik = inverseKinematics('RigidBodyTree',robot_rbtree);
    weights = [0.25 0.25 0.25 1 1 1];
    n = max(size(path_3d));
    con_sol = zeros(n,6);
    progress = "5 points";
    %assume this is constant for the most part

    for i = 1:max(size(path_3d))
        tform = [orientation path_3d(:,i); 0 0 0 1];
        [configSoln,~] = ik('b6',tform,weights,initial_guess);
        con_sol(i,:) = configSoln;
        initial_guess = configSoln;
        if(mod(i,10) == 0)
            progress
        end
        
    end

end