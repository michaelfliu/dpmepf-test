# dp-mepf code

This old implementation contains faulty FID evaluation, but may be used to reproduce our results on MNIST and FashionMNIST as described below.

## code structure
- `models/`
  - `model_builder.py` gives access to all NNs used in the code
  - definitions for all models
  - place to put pretrained models obtained from the GFMN paper
- `data_loading.py` prepares the dataloader
- `downstream_eval.py` cifar10 classification
- `dp_analysis.py` functions to get Gaussian mechanism noise variables based on desired eps,delta guarantee
- `dp_functions.py` everything related to sensitivity bounding and DP release
- `dp_mepf.py` This is the main function to run. read through main() to get an idea of the structure
- `dp_mepf_args.py` all the flags that may be set for dp_mepf.py (includes unused features)
- `dp_merf_cifar.py` cifar10 dp-merf baseline
- `feature_matching.py` functions used for feature matching updates (regular or adam)
- `fid_eval.py` FID score computation
- `util.py` various utility functions
- `util_logging.py` utility functions specific to logging experiments


## How to run:

### 1) notable flags:
- `--seed`: value of random seed to use. we chose 1, 2, and 3
- `--matched_moments`: either `mean` or `m1_and_m2` to indicate whether we match phi_1 or both phi_1 and phi_2.
- `--tgt-eps`: the desired DP constant epsilon. the necessary noise is computed.
- `--no_io_files`: by default, io is routed to files in the log directory. this flag disables this
- `--restart_iter`: by default, program exits with exit code 3 after this many iterations to trigger a restart on the cluster we used for training. Set to None or negative number to turn off.
- `--pytorch_encoders`: uses models from the torchvision library rather than those from the Paper "Learning Implicit Generative Models by Matching Perceptual Features" by dos Santos et al. This is used for all Cifar10 and CelebA experiments

### 2) Run via command line

all experiments were performed with random seeds `1`,`2` and `3` (and `4`, `5` for CelebA and Cifar10), for matching only phi_1 or phi_1 and phi_2, and at various levels of privacy.
Below we only list one nonprivate and one private run for each dataset. the other runs can be generated by changing the `seed`, `matched_moments` and `tgt_eps` arguments accordingly.

#### a) MNIST

non-DP
`python3 dp_mepf.py  --dataset dmnist --syn_eval_iter 20_000 --labeled --net_enc_type resnet18 --batch_size 100 --downstream_dataset_size 60_000 --exp_name may11_dmnist_nondp/run_0 --matched_moments mean --lr 1e-5 --m_avg_lr 1e-3 --manual_seed 1`

DP
`python3 dp_mepf.py  --dataset dmnist --syn_eval_iter 20_000 --labeled --net_enc_type resnet18 --batch_size 100 --downstream_dataset_size 60_000 --exp_name may12_dmnist_private_res/run_0 --matched_moments mean --dp_tgt_eps 0.2 --dp_mean_bound 1. --dp_var_bound 1. --lr 1e-5 --m_avg_lr 1e-4 --manual_seed 1`




#### b) FashionMNIST

non-DP
`python3 dp_mepf.py  --dataset fmnist --syn_eval_iter 20_000 --labeled --net_enc_type resnet18 --batch_size 100 --downstream_dataset_size 60_000 --exp_name may12_fmnist_nondp_res/run_0 --matched_moments mean --lr 1e-5 --m_avg_lr 1e-3 --manual_seed 1`

DP
`python3 dp_mepf.py  --dataset fmnist --syn_eval_iter 20_000 --labeled --net_enc_type resnet18 --batch_size 100 --downstream_dataset_size 60_000 --exp_name may12_fmnist_dp_res/run_0 --matched_moments mean --dp_tgt_eps 0.2 --dp_mean_bound 1. --dp_var_bound 1. --lr 1e-4 --m_avg_lr 1e-3 --manual_seed 1`