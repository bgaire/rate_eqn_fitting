function [out_curve, out_curve_states] = predict_curve(in_rate, in_scale, in_loading_mtx, in_tmd, in_drive_level, in_off_time, in_on_time, in_times)

[in_tm_nat, in_tm_drive, in_vis_nat, in_vis_drive] = make_trans_mtx(in_loading_mtx, in_tmd, in_rate);

%Assume evenly spaced times
time_step = mean(diff(in_times));
off_exp = expm(in_tm_nat*in_off_time);
comb_exp = expm((in_tm_nat+in_tm_drive*in_drive_level)*in_on_time)*off_exp;

off_step = expm(in_tm_nat*time_step);
comb_step = expm((in_tm_nat+in_tm_drive*in_drive_level)*time_step);

comb_vis = in_vis_nat+in_vis_drive*in_drive_level;

[e_vecs, e_vals] = eig(comb_exp,'vector');
[~,max_val] = max(abs(e_vals));

steady_state = e_vecs(:,max_val);

steady_state = steady_state/sum(steady_state);

out_curve_states = zeros(numel(steady_state),numel(in_times));
out_curve = zeros(1,numel(in_times));

out_curve_states(:,1) = steady_state;
out_curve(1) = in_scale*in_vis_nat*steady_state;
for a = 2:length(in_times)
    if in_times(a) < in_off_time
        out_curve_states(:,a) = off_step*out_curve_states(:,a-1);
        out_curve(a) = in_scale*in_vis_nat*out_curve_states(:,a);
    else
        out_curve_states(:,a) = comb_step*out_curve_states(:,a-1);
        out_curve(a) = in_scale*comb_vis*out_curve_states(:,a);
    end
end

end