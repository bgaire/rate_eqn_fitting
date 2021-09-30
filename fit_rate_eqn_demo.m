load ../'October 2020'/'October 15'/'Sorted Data'/sorted_arTm_highPower.mat;
demo_tmd = make_trans_mtx_desc();
demo_load_mtx = make_trans_loading_mtx(demo_tmd);
demo_times = sorted_arTm_highPower.time_delays/1000+0.5*1980/2E6;

[demo_curve, demo_states] = predict_curve([demo_tmd.trans.rate], demo_tmd.scale, demo_load_mtx, demo_tmd, 1, 999*1980/2E6, 1000*1980/2E6, demo_times);

[demo_fit_rate, demo_fit_scale, demo_offset, ~] = fit_rate_eqn(demo_tmd, 1, 999*1980/2E6, 1000*1980/2E6, demo_times, sorted_arTm_highPower.data);
for a = 1:100
    [demo_fit_rate, demo_fit_scale, demo_offset, demo_fit] = fit_rate_eqn(demo_tmd, 1, 999*1980/2E6, 1000*1980/2E6, demo_times, sorted_arTm_highPower.data, [demo_fit_rate, demo_fit_scale, demo_offset]);
    plot(demo_times,demo_curve+0.5,demo_times,sorted_arTm_highPower.data,'*',demo_times,demo_fit);
    pause(0.1);
end
[demo_fit_rate, demo_fit_scale, demo_offset, demo_fit] = fit_rate_eqn(demo_tmd, 1, 999*1980/2E6, 1000*1980/2E6, demo_times, sorted_arTm_highPower.data, [demo_fit_rate, demo_fit_scale, demo_offset]);

plot(demo_times,demo_curve+0.5,demo_times,sorted_arTm_highPower.data,'*',demo_times,demo_fit);