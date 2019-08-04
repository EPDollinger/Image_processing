function [vplot,SEM] = vplot_SEMplot(names,Area_array,Replicates)
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
    all_data = [];
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

%% Barplot of how many images per replicate
subplot(3,1,1)
cat = categorical(Replicates);
bar(cat,count_of_image)
ylabel('Number of pictures for each replicate')

%% Violinplot

subplot(3,1,2);
vplot = violinplot(P);
ylabel('Size of each quantified area (in pixels)')

%% Error plot. This plots the mean and SEM of each replicate, in 
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

%% Plot SEM figure
subplot(3,1,3);
SEM = errorbar(x,y,err,'o');
xlim([0.5 length(Replicates) + 0.5]);
ylabel('Average and SEM of quantified area per replicate (in pixels)')

end

