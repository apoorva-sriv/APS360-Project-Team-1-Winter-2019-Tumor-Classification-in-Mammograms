clc;
tic

d = dirPlus('J:\data (unaugmented, 4 classes, tif)\train');
average = 109.2385;

for i = 1:numel(d)
    [filepath, name, ext] = fileparts(d{i});
    disp(i);
    I = imread(d{i});
    r = 360.*rand(5, 1);                     % https://www.mathworks.com/help/matlab/ref/rand.html
    while length(unique(r)) ~= 5
        r = 360.*rand(5, 1);                 % five unique degrees in (0, 360)
    end
    for j = 1:5
        theta = r(j);
        Irot = imrotate(I, theta);               % https://www.mathworks.com/matlabcentral/answers/10089-image-rotate
        % This check is needed to prevent errors in randperm(size. . ., 5) below if
        % size. . .  < 5.
        while size(Irot, 1) < 229
            theta = 360.*rand(1, 1);
            Irot = imrotate(I, theta);
        end
        Mrot = ~imrotate(true(size(I)), theta);
        Irot(Mrot&~imclearborder(Mrot)) = average;
        
        A = Irot;                            % https://stackoverflow.com/questions/35412197/how-can-i-crop-several-and-random-batches-from-an-image
        
        rnd_x = randperm(size(A,1)-224, 5);  %choose 5 random unique points on x-axis
        rnd_y = randperm(size(A,2)-224, 5);  %choose 5 random unique points on y-axis
        for ii = 1:5
            piece{ii} = A((rnd_x(ii):(rnd_x(ii)+223)),(rnd_y(ii):(rnd_y(ii)+223)),1:3);%Convert chosen numbers to image pieces
            
            rnd_flip = randperm(3, 1);
            switch rnd_flip
                case 2
                    piece{ii} = fliplr(piece{ii});         % horizontal flip
                case 3
                    piece{ii} = flipud(piece{ii});         % vertical flip
            end
            
            %figure(ii)
            %imshow(piece{ii});
            imwrite(piece{ii}, strcat(filepath, '\', name, '_', string(j), '_', string(ii), ext));
        end
    end
end

toc
