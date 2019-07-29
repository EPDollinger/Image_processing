t_or_f = count(names,'Control');

for name = 1:length(names)
    ave(name) = Average_area.(names{name});
end

P.Control = {};
P.Imiquimod = {};

for it = 1:length(t_or_f)
    if t_or_f(it) == 1
        P.Control = [P.Control;ave(it)]; 
    else
        P.Imiquimod = [P.Imiquimod;ave(it)]; 
    end
end

P.Control = cell2mat(P.Control);
P.Imiquimod = cell2mat(P.Imiquimod);

violinplot(P)