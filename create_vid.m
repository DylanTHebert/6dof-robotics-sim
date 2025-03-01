%make movie
function ann = create_vid(rbtree_welder_bot, con_sol, path, framerate, name)
    N = max(size(con_sol))
    name = append(name, '.avi')
%set(gca, 'CameraPosition', [100 5000 2000]);
% Animate The Solution
%veiw point 660x 50y 200z
for i = 1:N
    f = figure(1)
    f.Position = [50 50 1300 1300];
    current_handle = gcf;
    show(rbtree_welder_bot,con_sol(i,:));
    hold on
    plot3(path(1,:),path(2,:),path(3,:));
    axis([-150,1500,-500,1000,-150,1000]);
    view([660 -250 200])
    camzoom(2)
    F(i) = getframe(current_handle) ;
    hold off
    drawnow
end
% create the video writer with 1 fps
writerObj = VideoWriter(name, 'MPEG-4');
writerObj.FrameRate = framerate;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);

end