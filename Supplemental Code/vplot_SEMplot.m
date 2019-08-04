function [fig,bar_images,bar_areas,vplot,SEM] = vplot_SEMplot(names,Area_array,Replicates,FolderToSavePicture)
%% Makes a violin plot and an SEM plot of the categories that are in Replicates. An 
%% example of Replicates is a replicate (e.g. Control 1, Control 2) or a group of replicates
%% (e.g. Control).

%% This section preps the data to be plotted. 
for replicate = 1:length(Replicates)
    
    %logical vector of replicate. Selects which names contain each
    %replicate.
    t_or_f = count(names,Replicates(replicate)); 
    
    %Total number of pictures in each replicate. Used in barplot
    count_of_image(replicate) = sum(t_or_f);

    %parameter setup
    P.(Replicates{replicate}) = {};
    
    % Looks for all the values in Area_array that contain replicate name,
    % put them in P.
    for it = 1:length(t_or_f)
        
        if t_or_f(it) == 1
            
            P.(Replicates{replicate}) = [P.(Replicates{replicate});Area_array.(names{it})]; 
            
        else
            
            continue
        
        end
        
    end
    
    % Data conversion
    P.(Replicates{replicate}) = cell2mat(P.(Replicates{replicate}));

end

%% Error plot prep. This calculates the mean and SEM of each replicate, in 
%% the order of the list Replicates

% Parameter prep
x = [];
y = [];
err = [];

% Calculate mean and SEM
for replicate = 1:length(Replicates)
    
    mean_of_replicate = mean(P.(Replicates{replicate}));
    
    x = [x,replicate];
    
    y = [y,mean_of_replicate];
    
    SEM_replicate = std(P.(Replicates{replicate}))/sqrt(length(P.(Replicates{replicate})));
    
    err = [err,SEM_replicate];
    
end

%% Prep for barplot of how many areas quantified per replicate

for replicate = 1:length(Replicates)
    
    % Calculate the number of areas quantified per replicate
    count_areas_per_replicate(replicate) = length(P.(Replicates{replicate}));
    
end

%% Plot figure section
% Barplot of how many images per replicate
fig = figure;
cat = categorical(Replicates);

subplot(3,2,1);
bar_images = bar(cat,count_of_image);
ylabel('Number of pictures per replicate')

% Barplot of how many areas per replicate
subplot(3,2,3);

bar_areas = bar(cat,count_areas_per_replicate);
ylabel('Number of areas per replicate')

% Violinplot

subplot(3,2,[2,4]);
vplot = violinplot(P);
ylabel('Size of each quantified area (in pixels)')

% Plot SEM figure
subplot(3,2,[5,6]);
SEM = errorbar(x,y,err,'o');
xlim([0.5 length(Replicates) + 0.5]);
ylabel('Average and SEM of quantified area per replicate (in pixels)')

% Final figure adjustments
fig.Position = [198,0,1680,1260];

% Save figure
print([FolderToSavePicture 'Plot processed ' date],'-dpng')



end

