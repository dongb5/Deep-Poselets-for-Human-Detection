function [img,img_name] = show_poselet_patch_with_annotations(poselet_patch, config)

    % Read full image
    img_name=[config.PATH_JPEGIMAGES poselet_patch.obj_annotations.image_filename '.jpg'];
    img = imread( img_name);

    % Show image
    figure;imshow(img);
   
    % Plot on the same image (do not clear when running plot)
    hold on;

    % Draw bounds
    rectangle(	'Position', ...
                [poselet_patch.obj_annotations.bounding_box.xmin      ...
                 poselet_patch.obj_annotations.bounding_box.ymin      ...
                 poselet_patch.obj_annotations.bounding_box.width     ...
                 poselet_patch.obj_annotations.bounding_box.height],  ...
                'EdgeColor', 'green');
    % Draw keypoints as circles (if present)
    if isfield(poselet_patch.obj_annotations, 'kp')
        for i=1:config.obj_config.NumLabels
            if ( poselet_patch.obj_annotations.kp.present(i) )
                color = 'green';
                if ~poselet_patch.obj_annotations.kp.visible(i)
                    color = 'yellow';
                end
                plot(poselet_patch.obj_annotations.kp.coords(i,1), ...
                     poselet_patch.obj_annotations.kp.coords(i,2), ...
                     'o', 'MarkerSize', 3, 'Color', color);
            end
        end
    end
    
    
    % Draw poselet patch bounds
    rectangle(	'Position', ...
                [poselet_patch.patch.top_left(2)...
                 poselet_patch.patch.top_left(1)...
                 poselet_patch.patch.hw(2)      ...
                 poselet_patch.patch.hw(1) ],   ...
                'EdgeColor', 'blue');
    
    % Draw keypoints inside poselet patch as circles (if present)
    if isfield(poselet_patch.patch, 'kp')
        for i=1:config.obj_config.NumLabels
            if ( poselet_patch.patch.kp.present(i) )
                color = 'blue';
                if ~poselet_patch.obj_annotations.kp.visible(i) % possible because they share the indices
                    color = 'cyan';
                end
                plot(poselet_patch.obj_annotations.kp.coords(i,1), ...
                     poselet_patch.obj_annotations.kp.coords(i,2), ...
                     'o', 'MarkerSize', 3, 'Color', color);
            end
        end
    end
    
    
    
    % Allow clearing the image later
    hold off;

end