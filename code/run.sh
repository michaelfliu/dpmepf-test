XDG_CACHE_HOME=/scratch/cache \
python3.9 dp_mepf.py \
    --n_iter 200_000 \
    --ckpt_iter 10_000 \
    --restart_iter 10_000 \
    --syn_eval_iter 5_000 \
    --dataset celebahq \
    --gen_output tanh \
    --data_scale 0_1 \
    --keep_best_syn_data \
    --exp_name /scratch/dpmepf/run1 \
    --image_size 256 \
    --dp_val_noise_scaling 10. \
    --batch_size 5 \
    --extra_input_scaling imagenet_norm \
    --matched_moments mean \
    --dp_tgt_eps 1. \
    --lr 3e-5 \
    --m_avg_lr 3e-4 \
    --seed 1 \