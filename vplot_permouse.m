function vplot_permouse(names,Area_array,Replicates)


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

end

