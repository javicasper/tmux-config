# tmux-config 🔥

Mi configuración personal de **tmux** (spec 2026), lista para instalar en cualquier
máquina y mantener siempre sincronizada vía git.

- Prefijo `C-a` (estilo GNU screen)
- Navegación de paneles estilo vim (`C-hjkl` con [vim-tmux-navigator])
- Tema [Catppuccin] (mocha) — requiere una Nerd Font en el cliente
- Persistencia de sesiones con [resurrect] + [continuum]
- Buscador fuzzy de sesiones con [sessionx] (`C-a o`)
- Plugins gestionados con [TPM]

## Instalación en una máquina nueva

```bash
git clone https://github.com/javicasper/tmux-config.git ~/tmux-config
cd ~/tmux-config
./install.sh
```

El `install.sh`:

1. Comprueba que `tmux` esté instalado.
2. Crea un symlink `~/.tmux.conf` → `~/tmux-config/.tmux.conf`
   (si ya tenías una config, te hace un backup con fecha).
3. Instala **TPM** si falta.
4. Instala todos los plugins automáticamente.

> En **Termux** primero: `pkg install tmux git`

## Mantenerla sincronizada

Como `~/.tmux.conf` es un **symlink al repo**, editar tu config *es* editar el repo.

**Subir cambios** (desde la máquina donde editaste):

```bash
cd ~/tmux-config
git commit -am "tweak: lo que cambié"
git push
```

**Bajar cambios** (en otra máquina):

```bash
cd ~/tmux-config
git pull
```

Luego recarga dentro de tmux con `C-a r`.

## Plugins incluidos

| Plugin | Para qué |
|---|---|
| [tpm] | Gestor de plugins |
| tmux-sensible | Defaults sensatos |
| [vim-tmux-navigator] | Saltar entre vim y tmux con `C-hjkl` |
| tmux-yank | Copiar al portapapeles del sistema |
| [resurrect] | Guardar/restaurar sesiones manualmente |
| [continuum] | Autoguardado y restauración automática |
| [sessionx] | Gestor fuzzy de sesiones con preview |
| [Catppuccin] | Tema |

[TPM]: https://github.com/tmux-plugins/tpm
[tpm]: https://github.com/tmux-plugins/tpm
[vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
[resurrect]: https://github.com/tmux-plugins/tmux-resurrect
[continuum]: https://github.com/tmux-plugins/tmux-continuum
[sessionx]: https://github.com/omerxx/tmux-sessionx
[Catppuccin]: https://github.com/catppuccin/tmux
