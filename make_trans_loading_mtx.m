function out_tml = make_trans_loading_mtx(in_tmd)

num_states = numel(in_tmd.states);

out_tml = zeros(num_states, num_states, numel(in_tmd.trans));

for a = 1:numel(in_tmd.trans)
    init_index = state_lookup(in_tmd.states, in_tmd.trans(a).init);
    final_index = state_lookup(in_tmd.states, in_tmd.trans(a).final);
    out_tml(final_index,init_index,a) = 1;
    out_tml(init_index,init_index,a) = -1;
end

out_tml = reshape(out_tml,num_states*num_states,[]);

end

function out_index = state_lookup(in_states, in_lookup)
    dummy = 1:numel(in_states);
    out_index = dummy(strcmp(in_states,in_lookup));
end