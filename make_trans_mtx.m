function [out_tm_nat, out_tm_drive, out_vis_nat, out_vis_drive] = make_trans_mtx(in_loading_mtx, in_tmd, in_rate)

sz = size(in_loading_mtx);
out_tm_nat = reshape(in_loading_mtx*reshape((1-[in_tmd.trans.driven]).*in_rate,[],1),round(sqrt(sz(1))),[]);
out_tm_drive = reshape(in_loading_mtx*reshape([in_tmd.trans.driven].*in_rate,[],1),round(sqrt(sz(1))),[]);
in_loading_mtx_pos = (in_loading_mtx+abs(in_loading_mtx))/2;
out_vis_nat = sum(reshape(in_loading_mtx_pos*reshape(in_rate.*[in_tmd.trans.visible].*(1-[in_tmd.trans.driven]),[],1),round(sqrt(sz(1))),[]),1);
out_vis_drive = sum(reshape(in_loading_mtx_pos*reshape(in_rate.*[in_tmd.trans.visible].*[in_tmd.trans.driven],[],1),round(sqrt(sz(1))),[]),1);

end