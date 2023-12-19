using Statistics, DataFrames, CairoMakie, CSV

# Importing Meager's MCMC draws
df = CSV.read("meager_mcmc_draws.csv", DataFrame)

"""Characteristics of the Social Wefare problem"""
g = .5 # The 'protected income' in the reference two-person problem' (as a fraction of income)
γ = 1 - 1/log(2,g)  # Implied Kolm-Atkinson inequality aversion parameter
f(x) = x^(1-γ) / (1 - γ) # The generator
# Egalitarian equivalent measure, ee(μ,σ,γ), when the outcome variable is LogNormally distributed and the Social Welfare Function is Kolm-Atkinson
ee(μ,σ,γ) = exp(μ + 0.5 * (1 - γ) * σ^2)

""" Site 1 """
# Induced distribution on the egalitarian equivalent measures
df.ee₀_1 = ee.(df."mu_k[1]", exp.(df."sigma_control_k[1]"), γ)
df.ee₁_1 = ee.(df."mu_k[1]" + df."tau_k[1]", exp.(df."sigma_control_k[1]" + df."sigma_TE_k[1]"), γ)
df.τ_ee_1 = df.ee₁_1 - df.ee₀_1
# Induced distribution on mean income
df.E₀_1 = ee.(df."mu_k[1]", exp.(df."sigma_control_k[1]"), 0)
df.E₁_1 = ee.(df."mu_k[1]" + df."tau_k[1]", exp.(df."sigma_control_k[1]" + df."sigma_TE_k[1]"), 0)
df.τ_E_1 = df.E₁_1 - df.E₀_1
# Induced distribution on mean f
df.f₀_1 = f.(df.ee₀_1)
df.f₁_1 = f.(df.ee₁_1)
df.τ_f_1 = df.f₁_1 - df.f₀_1
# Point estimates for ee
mu_k_1 = mean(df."mu_k[1]")
sigma_control_k_1 = mean(df."sigma_control_k[1]")
tau_k_1 = mean(df."tau_k[1]")
sigma_TE_k_1 = mean(df."sigma_TE_k[1]")
ee₀_1 = ee(mu_k_1, exp(sigma_control_k_1), γ)
ee₁_1 = ee(mu_k_1 + tau_k_1, exp.(sigma_control_k_1 + sigma_TE_k_1), γ)
μ₀_1 = ee(mu_k_1, exp(sigma_control_k_1), 0)
μ₁_1 = ee(mu_k_1 + tau_k_1, exp.(sigma_control_k_1 + sigma_TE_k_1), 0)

""" Site 2 """
# Induced distribution on the egalitarian equivalent measures
df.ee₀_2 = ee.(df."mu_k[2]", exp.(df."sigma_control_k[2]"), γ)
df.ee₁_2 = ee.(df."mu_k[2]" + df."tau_k[2]", exp.(df."sigma_control_k[2]" + df."sigma_TE_k[2]"), γ)
df.τ_ee_2 = df.ee₁_2 - df.ee₀_2
# Induced distribution on mean income
df.E₀_2 = ee.(df."mu_k[2]", exp.(df."sigma_control_k[2]"), 0)
df.E₁_2 = ee.(df."mu_k[2]" + df."tau_k[2]", exp.(df."sigma_control_k[2]" + df."sigma_TE_k[2]"), 0)
df.τ_E_2 = df.E₁_2 - df.E₀_2
# Induced distribution on mean f
df.f₀_2 = f.(df.ee₀_2)
df.f₁_2 = f.(df.ee₁_2)
df.τ_f_2 = df.f₁_2 - df.f₀_2
# Point estimates
mu_k_2 = mean(df."mu_k[2]")
sigma_control_k_2 = mean(df."sigma_control_k[2]")
tau_k_2 = mean(df."tau_k[2]")
sigma_TE_k_2 = mean(df."sigma_TE_k[2]")
ee₀_2 = ee(mu_k_2, exp(sigma_control_k_2), γ)
ee₁_2 = ee(mu_k_2 + tau_k_2, exp.(sigma_control_k_2 + sigma_TE_k_2), γ)
μ₀_2 = ee(mu_k_2, exp(sigma_control_k_2), 0)
μ₁_2 = ee(mu_k_2 + tau_k_2, exp.(sigma_control_k_2 + sigma_TE_k_2), 0)


""" Site 3 """
# Induced distribution on the egalitarian equivalent measures
df.ee₀_3 = ee.(df."mu_k[3]", exp.(df."sigma_control_k[3]"), γ)
df.ee₁_3 = ee.(df."mu_k[3]" + df."tau_k[3]", exp.(df."sigma_control_k[3]" + df."sigma_TE_k[3]"), γ)
df.τ_ee_3 = df.ee₁_3 - df.ee₀_3
# Induced distribution on mean income
df.E₀_3 = ee.(df."mu_k[3]", exp.(df."sigma_control_k[3]"), 0)
df.E₁_3 = ee.(df."mu_k[3]" + df."tau_k[3]", exp.(df."sigma_control_k[3]" + df."sigma_TE_k[3]"), 0)
df.τ_E_3 = df.E₁_3 - df.E₀_3
# Induced distribution on mean f
df.f₀_3 = f.(df.ee₀_3)
df.f₁_3 = f.(df.ee₁_3)
df.τ_f_3 = df.f₁_3 - df.f₀_3
# Point estimates
mu_k_3 = mean(df."mu_k[3]")
sigma_control_k_3 = mean(df."sigma_control_k[3]")
tau_k_3 = mean(df."tau_k[3]")
sigma_TE_k_3 = mean(df."sigma_TE_k[3]")
ee₀_3 = ee(mu_k_3, exp(sigma_control_k_3), γ)
ee₁_3 = ee(mu_k_3 + tau_k_3, exp.(sigma_control_k_3 + sigma_TE_k_3), γ)
μ₀_3 = ee(mu_k_3, exp(sigma_control_k_3), 0)
μ₁_3 = ee(mu_k_3 + tau_k_3, exp.(sigma_control_k_3 + sigma_TE_k_3), 0)


""" Site 4 """
# Induced distribution on the egalitarian equivalent measures
df.ee₀_4 = ee.(df."mu_k[4]", exp.(df."sigma_control_k[4]"), γ)
df.ee₁_4 = ee.(df."mu_k[4]" + df."tau_k[4]", exp.(df."sigma_control_k[4]" + df."sigma_TE_k[4]"), γ)
df.τ_ee_4 = df.ee₁_4 - df.ee₀_4
# Induced distribution on mean income
df.E₀_4 = ee.(df."mu_k[4]", exp.(df."sigma_control_k[4]"), 0)
df.E₁_4 = ee.(df."mu_k[4]" + df."tau_k[4]", exp.(df."sigma_control_k[4]" + df."sigma_TE_k[4]"), 0)
df.τ_E_4 = df.E₁_4 - df.E₀_4
# Induced distribution on mean f
df.f₀_4 = f.(df.ee₀_4)
df.f₁_4 = f.(df.ee₁_4)
df.τ_f_4 = df.f₁_4 - df.f₀_4
# Point estimates
mu_k_4 = mean(df."mu_k[4]")
sigma_control_k_4 = mean(df."sigma_control_k[4]")
tau_k_4 = mean(df."tau_k[4]")
sigma_TE_k_4 = mean(df."sigma_TE_k[4]")
ee₀_4 = ee(mu_k_4, exp(sigma_control_k_4), γ)
ee₁_4 = ee(mu_k_4 + tau_k_4, exp.(sigma_control_k_4 + sigma_TE_k_4), γ)
μ₀_4 = ee(mu_k_4, exp(sigma_control_k_4), 0)
μ₁_4 = ee(mu_k_4 + tau_k_4, exp.(sigma_control_k_4 + sigma_TE_k_4), 0)


""" Site 5 """
# Induced distribution on the egalitarian equivalent measures
df.ee₀_5 = ee.(df."mu_k[5]", exp.(df."sigma_control_k[5]"), γ)
df.ee₁_5 = ee.(df."mu_k[5]" + df."tau_k[5]", exp.(df."sigma_control_k[5]" + df."sigma_TE_k[5]"), γ)
df.τ_ee_5 = df.ee₁_5 - df.ee₀_5
# Induced distribution on mean income
df.E₀_5 = ee.(df."mu_k[5]", exp.(df."sigma_control_k[5]"), 0)
df.E₁_5 = ee.(df."mu_k[5]" + df."tau_k[5]", exp.(df."sigma_control_k[5]" + df."sigma_TE_k[5]"), 0)
df.τ_E_5 = df.E₁_5 - df.E₀_5
# Induced distribution on mean f
df.f₀_5 = f.(df.ee₀_5)
df.f₁_5 = f.(df.ee₁_5)
df.τ_f_5 = df.f₁_5 - df.f₀_5
 # Point estimates
mu_k_5 = mean(df."mu_k[5]")
sigma_control_k_5 = mean(df."sigma_control_k[5]")
tau_k_5 = mean(df."tau_k[5]")
sigma_TE_k_5 = mean(df."sigma_TE_k[5]")
ee₀_5 = ee(mu_k_5, exp(sigma_control_k_5), γ)
ee₁_5 = ee(mu_k_5 + tau_k_5, exp.(sigma_control_k_5 + sigma_TE_k_5), γ)
μ₀_5 = ee(mu_k_5, exp(sigma_control_k_5), 0)
μ₁_5 = ee(mu_k_5 + tau_k_5, exp.(sigma_control_k_5 + sigma_TE_k_5), 0)


# Some summary statistics
mean(df.ee₀_1)
((1-γ)*mean(df.f₀_1))^(1/(1-γ))

mean(df.ee₁_1)
((1-γ)*mean(df.f₁_1))^(1/(1-γ))

mean(df.τ_ee_1)
nrow(df[df.τ_ee_1 .> 0, :])
ee₁_1 - ee₀_1
mean(df.τ_E_1)
nrow(df[df.τ_E_1 .> 0, :])
μ₁_1 - μ₀_1

mean(df.τ_f_1)
mean(df.ee₀_2)
((1-γ)*mean(df.f₀_2))^(1/(1-γ))

mean(df.ee₁_2)
((1-γ)*mean(df.f₁_2))^(1/(1-γ))

mean(df.τ_ee_2)
nrow(df[df.τ_ee_2 .> 0, :])
ee₁_2 - ee₀_2
mean(df.τ_E_2)
nrow(df[df.τ_E_2 .> 0, :])
μ₁_2 - μ₀_2

mean(df.τ_f_2)

mean(df.ee₀_3)
((1-γ)*mean(df.f₀_3))^(1/(1-γ))

mean(df.ee₁_3)
((1-γ)*mean(df.f₁_3))^(1/(1-γ))

mean(df.τ_ee_3)
nrow(df[df.τ_ee_3 .> 0, :])
ee₁_3 - ee₀_3
mean(df.τ_E_3)
nrow(df[df.τ_E_3 .> 0, :])

μ₁_3 - μ₀_3

mean(df.τ_f_3)

mean(df.ee₀_4)
((1-γ)*mean(df.f₀_4))^(1/(1-γ))

mean(df.ee₁_4)
((1-γ)*mean(df.f₁_4))^(1/(1-γ))

mean(df.τ_ee_4)
nrow(df[df.τ_ee_4 .> 0, :])
ee₁_4 - ee₀_4
mean(df.τ_E_4)
nrow(df[df.τ_E_4 .> 0, :])
μ₁_4 - μ₀_4

mean(df.τ_f_4)

mean(df.ee₀_5)
((1-γ)*mean(df.f₀_5))^(1/(1-γ))

mean(df.ee₁_5)
((1-γ)*mean(df.f₁_5))^(1/(1-γ))

mean(df.τ_ee_5)
nrow(df[df.τ_ee_5 .> 0, :])
ee₁_5 - ee₀_5
mean(df.τ_E_5)
nrow(df[df.τ_E_5 .> 0, :])

μ₁_5 - μ₀_5

mean(df.τ_f_5)


# Figures
h = Figure()
ax1 = Axis(h[2, 1], title="Mexico")
ax2 = Axis(h[2, 2], title="Mongolia")
ax3 = Axis(h[1, 1], title="Bosnia")
ax4 = Axis(h[1, 2], title="India")
ax5 = Axis(h[3, 1], title="Morocco")
density!(ax1, df.τ_ee_1, label = "Δee(y)")
density!(ax1, df.τ_E_1, label = "ΔE[y]")
vlines!(ax1, 0, color=:gray)
# axislegend(ax1)

density!(ax2, df.τ_ee_2, label = "τ")
density!(ax2, df.τ_E_2, label = "τₑₑ")
vlines!(ax2, 0, color=:gray)
# axislegend(ax2)

density!(ax3, df.τ_ee_3, label = "τₑₑ")
density!(ax3, df.τ_E_3, label = "τ")
vlines!(ax3, 0, color=:gray)
axislegend(ax3)

density!(ax4, df.τ_ee_4, label = "Δee(y)")
density!(ax4, df.τ_E_4, label = "ΔE[y]")
vlines!(ax4, 0, color=:gray)
# axislegend(ax4)

density!(ax5, df.τ_ee_5, label = "Δee(y)")
density!(ax5, df.τ_E_5, label = "ΔE[y]")
vlines!(ax5, 0, color=:gray)
# axislegend(ax5)

xlims!.((ax1, ax2, ax3, ax4, ax5), -35, 35)

h
save("imported_multiple_sites.png", h)


CSV.write("MCMC_results_meager_expanded.csv", df)