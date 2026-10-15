"""Draw public previews from simulated CSV data only; no paper images or tables."""
from pathlib import Path
import argparse
import csv
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
ROOT = ap.parse_args().root.resolve()
P = ROOT / 'projects'
F = ROOT / 'figures'
F.mkdir(exist_ok=True)
plt.rcParams.update({'font.family': 'DejaVu Sans', 'font.size': 10,
                     'axes.titleweight': 'bold', 'savefig.facecolor': 'white'})

def rows(p):
    with p.open(encoding='utf-8-sig', newline='') as f:
        return list(csv.DictReader(f))

def save(fig, name):
    fig.savefig(F / (name + '.png'), dpi=180)
    fig.savefig(F / (name + '.svg'))
    plt.close(fig)

d2 = P / 'InGaAs_PTAPD_Shao2025_Fig2_2D'
spectrum = rows(d2 / 'figure2_spectrum.csv')
fig, ax = plt.subplots(figsize=(8.5, 5.2))
for case, color in [('Control', '#2563eb'), ('PT', '#ef4444')]:
    data = sorted([r for r in spectrum if r['case'] == case], key=lambda r: float(r['wavelength_nm']))
    assert len(data) == 23
    ax.plot([float(r['wavelength_nm']) for r in data],
            [float(r['responsivity_A_per_W']) for r in data], 'o-',
            color=color, ms=3.5, label=case)
ax.set(xlabel='Wavelength (nm)', ylabel='Optical responsivity estimate (A/W)',
       title='Figure 2 baseline | 2D EMW, absorber absorption, eta = 1')
ax.grid(alpha=.2)
ax.legend()
fig.subplots_adjust(left=.12, right=.97, bottom=.20, top=.87)
fig.text(.12, .055, '25-nm mesh, 1.5-ps FDTD; no avalanche or electrical collection.\n'
         'PT peak: 0.738 A/W at 1620 nm. Independent study of DOI: 10.1109/TED.2025.3544972', fontsize=9, color='#475569')
save(fig, 'figure2_simulation')

d3 = P / 'InGaAs_PTAPD_Shao2025_Fig3_2D'
mapping = json.loads((d3 / 'case_map.json').read_text(encoding='utf-8'))
fields = []
for n, m in mapping.items():
    if m['role'] != 'baseline':
        continue
    data = np.genfromtxt(d3 / f'n{n}_field_samples.csv', delimiter=',', names=True)
    x = np.unique(data['x_nm'])
    z = np.unique(data['z_nm'])
    values = data['I2'].reshape(len(z), len(x))
    assert np.isfinite(values).all()
    fields.append((m['snapshot_fs'], x, z, values))
fields.sort(key=lambda a: a[0])
assert len(fields) == 4
common = max(a[3].max() for a in fields)
fig, axes = plt.subplots(1, 4, figsize=(12, 5.5), sharey=True)
fig.subplots_adjust(left=.07, right=.88, bottom=.22, top=.81, wspace=.12)
for ax, (t, x, z, values) in zip(axes, fields):
    im = ax.imshow(values / common, origin='lower', extent=[x.min(), x.max(), z.min(), z.max()],
                   vmin=0, vmax=1, cmap='turbo', aspect='auto')
    ax.set(xlabel='x (nm)', title=f'{t:.1f} fs', xticks=[-250, 0, 250])
    for zz in [0, 100, 350, 450, 650, 700]:
        ax.axhline(zz, color='white', ls=':', lw=.5)
axes[0].set_ylabel('Paper-depth coordinate z (nm)')
cb = fig.colorbar(im, cax=fig.add_axes([.90, .23, .015, .56]))
cb.set_label('Simulated |E|² / common sampled maximum')
fig.suptitle('Figure 3 baseline | native transient fields, 1615 nm', y=.94, fontsize=15)
fig.text(.5, .87, '2D three slots; one common scale across the four frames', ha='center', color='#475569')
fig.text(.07, .06, 'Snapshots from independent native FDTD endpoints; 25-nm mesh and 0.01-fs time step.\n'
         'Yee E-field time is up to 0.005 fs earlier than solver duration; no time shift applied.\n'
         'The 3D paper hotspot position and early modal buildup are not quantitatively reproduced.', fontsize=9, color='#475569')
save(fig, 'figure3_simulation')

d4 = P / 'InGaAs_PTAPD_Shao2025_Fig4_Fig7_2D'
audit = json.loads((d4 / 'field_endpoint_audit.json').read_text(encoding='utf-8'))
fig, axes = plt.subplots(1, 3, figsize=(12, 5.4), gridspec_kw={'width_ratios': [1, 1, 1.05]})
fig.subplots_adjust(left=.065, right=.97, bottom=.23, top=.79, wspace=.40)
maps = {}
for ax, (node, label) in zip(axes[:2], [(9, 'Control'), (17, 'PT: cylinder section')]):
    data = np.genfromtxt(d4 / f'n{node}_field_grid.csv', delimiter=',', names=True)
    E = data['E_V_cm'].reshape(101, 121) * 1e-6
    maps[node] = E
    im = ax.imshow(E, origin='lower', extent=[-.9375, .9375, 0, 700],
                   vmin=0, vmax=.85, cmap='turbo', aspect='auto')
    for zz in [100, 350, 400, 450, 650]:
        ax.axhline(zz, color='white', ls=':', lw=.7)
    if node == 17:
        for c in [-.625, 0, .625]:
            ax.add_patch(Rectangle((c-.25, 0), .5, 220, fill=False, ec='white', lw=1))
    ax.set(xlabel='x (um)', ylabel='z (nm)',
           title=f'{label}\nMultiplier peak {audit[str(node)]["max_multiplier_E_V_cm"]*1e-6:.6f} MV/cm')
    fig.colorbar(im, ax=ax, fraction=.047, pad=.025, label='|E| (MV/cm)')
z = np.linspace(.001, 699.999, 101)
axes[2].plot(maps[9][:, 80], z, c='#2563eb', label='Control')
axes[2].plot(maps[17][:, 80], z, c='#ef4444', label='PT between holes')
axes[2].plot(maps[17][:, 60], z, c='#7c3aed', ls='--', label='PT hole center')
axes[2].axhspan(450, 650, color='#cbd5e1', alpha=.3)
axes[2].set(xlabel='|E| (MV/cm)', ylabel='z (nm)', title='Native field profiles', xlim=(0, .9), ylim=(0, 700))
axes[2].grid(alpha=.2)
axes[2].legend(fontsize=8, loc='lower right')
fig.suptitle('Figure 4 baseline | dark electric field, actual reverse bias 23.8 V', y=.97, fontsize=15)
fig.text(.5, .89, 'Avalanche included; common calibrated physical model for both geometries', ha='center', color='#475569')
fig.text(.065, .055, '2D three-hole section, assumed unpublished epitaxy; native fields and Solve endpoints audited.\n'
         'The common ionization b scale (1.182) was calibrated to control breakdown only.\n'
         'No paper panels are reproduced in this figure. DOI: 10.1109/TED.2025.3544972', fontsize=9, color='#475569')
save(fig, 'figure4_simulation')

iv = rows(d4 / 'figure7_device_IV.csv')
power = rows(d4 / 'figure7_power_response.csv')
metrics = json.loads((d4 / 'comparison_metrics.json').read_text(encoding='utf-8'))
fig, axes = plt.subplots(2, 2, figsize=(11.4, 8.9))
fig.subplots_adjust(left=.09, right=.97, bottom=.19, top=.85, hspace=.40, wspace=.28)
for ax, g, label in [(axes[0, 0], 'Control', 'Control: 1550 nm'),
                     (axes[0, 1], 'PT_composite', 'PT: 1626 nm, area composite')]:
    data = [r for r in iv if r['geometry'] == g]
    v = np.array([float(r['reverse_bias_V']) for r in data])
    for key, color, name in [('dark_current_A', '#2563eb', 'Dark'),
                              ('illuminated_current_A', '#ef4444', 'Illuminated')]:
        current = np.array([float(r[key]) for r in data])
        ax.semilogy(v, np.where(current > 0, current, np.nan), color=color, label=name)
    ax.set(title=label, xlim=(0, 25), ylim=(1e-11, 1e-5), xlabel='Actual reverse inner bias (V)', ylabel='Device current (A)')
    ax.grid(alpha=.18, which='both')
    ax.legend(fontsize=9)
    ax.text(.04, .05, 'Pin = 0.3236 uW; avalanche on', transform=ax.transAxes, fontsize=9, color='#475569')
cases = [('Control', 1550, '#df8792'), ('Slanted', 1550, '#2563eb'), ('Slanted', 1626, '#ef4444')]
for g, wave, color in cases:
    data = [r for r in power if r['geometry'] == g and int(r['wavelength_nm']) == wave and float(r['bias_V']) == 23.8]
    assert len(data) == 5
    axes[1, 0].plot([float(r['power_uW']) for r in data], [float(r['photocurrent_uA']) for r in data], 'o-',
                    color=color, label=f'{"PT" if g=="Slanted" else g} {wave} nm')
axes[1, 0].set(title='Five native power endpoints per condition', xlabel='Incident power (uW)',
               ylabel='Dark-subtracted photocurrent (uA)', xlim=(0, 10.8))
axes[1, 0].grid(alpha=.18)
axes[1, 0].legend(fontsize=9)
x = np.arange(3)
for bias, offset, color in [('20', -.18, '#94a3b8'), ('23.8', .18, '#f43f5e')]:
    values = [m['simulated'][bias]['R_origin_fit_A_W'] for m in metrics['responsivities']]
    bars = axes[1, 1].bar(x+offset, values, .34, label=f'{bias} V', color=color)
    for b in bars:
        axes[1, 1].text(b.get_x()+b.get_width()/2, b.get_height()+.014, f'{b.get_height():.3f}', ha='center', fontsize=9)
axes[1, 1].set(title='AV-off collection reference: origin-fit slopes', ylabel='Responsivity (A/W)', ylim=(0, .9),
               xticks=x, xticklabels=['Control\n1550 nm', 'PT\n1550 nm', 'PT\n1626 nm'])
axes[1, 1].legend(fontsize=9)
axes[1, 1].grid(axis='y', alpha=.18)
axes[1, 1].set_axisbelow(True)
fig.suptitle('Figure 7 baseline | native EMW to SDevice, 2D three slots', y=.965, fontsize=15)
fig.text(.5, .907, 'Common ionization calibration; uniform-equivalent spot and finite PC-area tiling', ha='center', color='#475569')
fig.text(.09, .055, 'Bottom panels: avalanche off; the experimental M=1 extraction bias is unknown. Main optical projection: 0 degrees in plane.\n'
         'Known differences: PT early punch-through and leakage not reproduced; InGaAs photon-transfer deficit 5.55-9.85%.\n'
         'No empirical output-current multiplier. Independent study of DOI: 10.1109/TED.2025.3544972', fontsize=8.8, color='#475569')
save(fig, 'figure7_simulation')
print('Saved four simulation-only PNG/SVG figures in', F)
