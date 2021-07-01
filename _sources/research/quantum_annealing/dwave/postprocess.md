# Postprocessing

1. Apply Spin Reversal Transformation
2. Postprocess (Before Chain Resolution)
    - 2000Q: optimization mode/sampling mode, user-defined
    - Advantage: user-defined
3. Chain Resolution
    - majority_vote/random_weighted/discard/MinimizeEnergy
4. Postprocess samples (After Chain Resolution)
    - user-defined

## D-Wave 2000Q

Chain Resolution -> Postprocess (None/Optimization/Sampling) -> Postprocess (User-defined)
```python
sampler = EmbeddingComposite(DWaveSampler())
# or
sampler = FixedEmbeddingComposite(DWaveSampler())

# Embed Problem
# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
# 1. Chain Resolution (majority_vote/random_weighted/discard)
# 2. Postprocess (None/Optimization/Sampling)
sampleset = sampler.sample(
    bqm, num_spin_reversal_transforms, postprocess
)

# 3. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=sampleset
)
```

Postprocess (None/Optimization/Sampling) -> Chain Resolution -> Postprocess (User-defined)
```python
# Embed Problem
bqm_embed = embed_bqm(bqm)
sampler = DWaveSampler()

# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
# 1. Postprocess (None/Optimization/Sampling)
raw_sampleset = sampler.sample(
    bqm_embed, num_spin_reversal_transforms, postprocess
)

# 2. Chain Resolution (majority_vote/random_weighted/discard/MinimizeEnergy)
sampleset = unembed_sampleset(raw_sampleset)

# 3. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=sampleset
)
```

Postprocess (None/Optimization/Sampling) -> Postprocess (User-defined) -> Chain Resolution
```python
# Embed Problem
bqm_embed = embed_bqm(bqm)
sampler = DWaveSampler()

# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
# 1. Postprocess (None/Optimization/Sampling)
raw_sampleset = sampler.sample(
    bqm_embed, num_spin_reversal_transforms, postprocess
)

# 2. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)

# 3. Chain Resolution (majority_vote/random_weighted/discard/MinimizeEnergy)
sampleset = unembed_sampleset(sampleset)
```

Postprocess (None/Optimization/Sampling) -> Postprocess (User-defined) -> Chain Resolution -> Postprocess (User-defined)
```python
# Embed Problem
bqm_embed = embed_bqm(bqm)
sampler = DWaveSampler()

# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
# 1. Postprocess (None/Optimization/Sampling)
raw_sampleset = sampler.sample(
    bqm_embed, num_spin_reversal_transforms, postprocess
)

# 2. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)

# 3. Chain Resolution (majority_vote/random_weighted/discard/MinimizeEnergy)
sampleset = unembed_sampleset(sampleset)

# 4. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)
```

## D-Wave Advantage

Chain Resolution -> Postprocess (User-defined)
```python
sampler = EmbeddingComposite(DWaveSampler())
# or
sampler = FixedEmbeddingComposite(DWaveSampler())

# Embed Problem
# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
# 1. Chain Resolution (majority_vote/random_weighted/discard)
sampleset = sampler.sample(bqm, num_spin_reversal_transforms)

# 2. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=sampleset
)
```

Postprocess (User-defined) -> Chain Resolution
```python
# Embed Problem
bqm_embed = embed_bqm(bqm)
sampler = DWaveSampler()

# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
raw_sampleset = sampler.sample(bqm_embed, num_spin_reversal_transforms)

# 1. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)

# 2. Chain Resolution (majority_vote/random_weighted/discard/MinimizeEnergy)
sampleset = unembed_sampleset(sampleset)
```

Postprocess (User-defined) -> Chain Resolution -> Postprocess (User-defined)
```python
# Embed Problem
bqm_embed = embed_bqm(bqm)
sampler = DWaveSampler()

# Receive Problem
# QPU Sampling
# Apply Spin Reversal Transformation
raw_sampleset = sampler.sample(bqm_embed, num_spin_reversal_transforms)

# 1. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)

# 2. Chain Resolution (majority_vote/random_weighted/discard/MinimizeEnergy)
sampleset = unembed_sampleset(sampleset)

# 3. Postprocess (Optional, User-defined, ex.greedy)
sampleset = SteepestDescentSampler().sample(
    bqm, initial_states=raw_sampleset
)
```

## Reference

- https://docs.dwavesys.com/docs/latest/c_post-processing_1.html