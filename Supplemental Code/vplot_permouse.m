function vplot_permouse(names,Area_array,Replicates)
%% Makes a violin plot of the categories that are in Replicates

for replicate = 1:length(Replicates)

    t_or_f = count(names,Replicates(replicate));

    all_data = [];

    P.(Replicates{replicate}) = {};

    for it = 1:length(t_or_f)
        if t_or_f(it) == 1
            P.(Replicates{replicate}) = [P.(Replicates{replicate});Area_array.(names{it})]; 
        else
            continue
        end
    end

    P.(Replicates{replicate}) = cell2mat(P.(Replicates{replicate}));
end

violinplot(P)

x = [];

y = [];

err = [];

for replicate = 1:length(Replicates)
    
    mean_of_replicate = mean(P.(Replicates{replicate}));
    
    x = [x,replicate];
    
    y = [y,mean_of_replicate];
    
    SEM_replicate = std(P.(Replicates{replicate}))/sqrt(length(P.(Replicates{replicate})));
    
    err = [err,SEM_replicate];
    
end

figure;

errorbar(x,y,err,'o');

xlim([0.5 length(Replicates) + 0.5]);

end

