t_or_f = count(names,'Control');

all_data = [];

P.Control = {};
P.Imiquimod = {};

for it = 1:length(t_or_f)
    if t_or_f(it) == 1
        P.Control = [P.Control;Area_array.(names{it})]; 
    else
        P.Imiquimod = [P.Imiquimod;Area_array.(names{it})]; 
    end
end

P.Control = cell2mat(P.Control);
P.Imiquimod = cell2mat(P.Imiquimod);

violinplot(P)

