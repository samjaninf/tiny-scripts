# Script de conversion video en PowerShell

Add-Type -AssemblyName System.Windows.Forms

function Show-Menu {
    param (
        [string]$Title,
        [string[]]$Options
    )

    Write-Host "$Title`n"
    for ($i = 0; $i -lt $Options.Length; $i++) {
        Write-Host "$($i + 1). $($Options[$i])"
    }
    Write-Host ""
}

function Get-ValidChoice {
    param (
        [string]$Prompt,
        [int]$MaxOptions
    )

    while ($true) {
        $choice = Read-Host "$Prompt (1-$MaxOptions)"
        if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $MaxOptions) {
            return [int]$choice
        }
        Write-Host "Choix invalide. Veuillez reessayer."
    }
}
function Convert-Video {
    param (
        [string]$InputPath,
        [string]$OutputPath,
        [string]$OutputExtension = "mp4",
        [int]$Quality = 10,
        [bool]$Recursive = $false,
        [bool]$Resize = $false,
        [int]$Width = 0,
        [int]$Height = 0
    )

    # Liste des extensions valides pour les fichiers vidéo
    $validExtensions = @(".3G2", ".3GP", ".ASF", ".AVI", ".FLV", ".M2TS", ".M4V", 
                         ".MK2", ".MKA", ".MKV", ".MOV", ".MP4", ".MPE", ".MPEG", 
                         ".MPG", ".OGG", ".OGV", ".OGX", ".RM", ".RMVB", ".TS", 
                         ".VOB", ".WAV", ".WEBM", ".WMA", ".WMV")

    # Obtenir les fichiers à convertir
    $files = @()
    if (Test-Path -Path $InputPath -PathType Container) {
        $files = if ($Recursive) {
            Get-ChildItem -Path $InputPath -Recurse | 
            Where-Object { $validExtensions -contains $_.Extension.ToUpper() }
        } else {
            Get-ChildItem -Path $InputPath | 
            Where-Object { $validExtensions -contains $_.Extension.ToUpper() }
        }
    } else {
        $files = Get-Item $InputPath
    }

    $total = 0
    $converted = 0
    $failed = 0

    foreach ($file in $files) {
        $total++
        
        # Calculer le chemin de sortie en préservant la structure de dossiers
        $relativePath = $file.FullName.Substring($InputPath.Length).TrimStart('\')
        $outputSubPath = [System.IO.Path]::GetDirectoryName($relativePath)
        $outputSubPathFull = Join-Path $OutputPath $outputSubPath
        
        # Créer le dossier de destination s'il n'existe pas
        if (-not (Test-Path -Path $outputSubPathFull)) {
            New-Item -ItemType Directory -Path $outputSubPathFull | Out-Null
        }

        $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $outputFile = Join-Path $outputSubPathFull "$outputFileName.$OutputExtension"

        # Éviter l'écrasement des fichiers existants
        $counter = 1
        while (Test-Path $outputFile) {
            $outputFile = Join-Path $outputSubPathFull "$outputFileName`_$counter.$OutputExtension"
            $counter++
        }

        $ffmpegArgs = @(
            "-hwaccel", "auto",
            "-threads", "0",
            "-i", "`"$($file.FullName)`""
        )
    
        # Choisir le codec vidéo en fonction de l'extension de sortie
        $videoCodec = switch ($OutputExtension.ToLower()) {
            "webm" { 
                @(
                    "-c:v", "libvpx-vp9", 
                    "-crf", $Quality, 
                    "-b:v", "0", 
                    "-c:a", "libvorbis",  
                    "-b:a", "320k",
                    "-vf", "format=yuv420p" 
                )
            }
            "mov" {
                @(
                    "-c:v", "prores_ks",          # Utilise le codec ProRes pour une qualité professionnelle
                    "-preset", "veryslow",        # Prend plus de temps pour la compression, mais la qualité est optimale
                    "-crf", $Quality,             # Contrôle de la qualité vidéo (réglable selon tes besoins)
                    "-c:a", "aac",                # Utilisation du codec audio AAC pour un bon compromis qualité/taille
                    "-b:a", "320k",               # Bitrate audio élevé (320k) pour une qualité audio optimale
                    "-pix_fmt", "yuv422p10"       # Utilisation de l'espace colorimétrique YUV 4:2:2 à 10 bits pour une qualité maximale
                )
            }

            "mp4" {
                @(
                    "-c:v", "libx264",            # Utilisation du codec H.264 pour une large compatibilité
                    "-preset", "veryslow",        # Prise en charge de la compression la plus optimale possible
                    "-crf", $Quality,             # Qualité vidéo réglable (plus bas pour une meilleure qualité)
                    "-c:a", "aac",                # Codec audio AAC
                    "-b:a", "320k"               # Bitrate audio élevé pour une qualité optimale
                    "-pix_fmt", "yuv422p10"      # Format de pixel YUV 422 10 bits (meilleure qualité)
                )
            }

            default { 
                @("-c:v", "libx264", "-preset", "veryslow", "-crf", $Quality) 
            }
        }

        $ffmpegArgs += $videoCodec + @(
            "-map", "0:v:0",
            "-map", "0:a:0",
            "-strict", "-2", 
            "-movflags", "+faststart",
            "`"$outputFile`""
        )

        try {
            $process = Start-Process ffmpeg -ArgumentList $ffmpegArgs -NoNewWindow -Wait -PassThru -ErrorAction Stop
            
            if ($process.ExitCode -eq 0) {
                $converted++
                Write-Host "Conversion réussie : $outputFileName.$OutputExtension"
            } else {
                $failed++
                Write-Host "Échec de conversion : $($file.Name)"
            }
        }
        catch {
            $failed++
            Write-Host "Erreur lors de la conversion : $($file.Name)"
            Write-Host "Détails de l'erreur : $_"
        }

        # Nettoyer la mémoire après chaque conversion
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }

    Write-Host "`nRésumé de la conversion:"
    Write-Host "Fichiers totaux : $total"
    Write-Host "Conversions réussies : $converted"
    Write-Host "Conversions échouées : $failed"
}


function Clean-InputPath {
    param([string]$Path)
    return ($Path.Trim('"').Trim("'")).Trim()
}

try {
    Clear-Host
    Write-Host "Outil de conversion video`n"

    # Ajouter les types necessaires
    Add-Type -AssemblyName System.Windows.Forms

    # Creer un objet OpenFileDialog pour choisir un fichier ou un dossier
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Title = "Veuillez selectionner un fichier ou un dossier"
    $fileDialog.Filter = "Tous les fichiers|*.*"

    # Demander a l'utilisateur s'il souhaite selectionner un fichier ou un dossier
    $choice = Read-Host "Voulez-vous selectionner un fichier (F) ou un dossier (D) ?"

    # Initialiser une variable pour le chemin
    $InputPath = ""

    if ($choice -eq "F") {
        # Afficher le dialogue pour un fichier
        $result = $fileDialog.ShowDialog()
        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            $InputPath = $fileDialog.FileName
            Write-Host "Fichier : $InputPath"
        } else {
            Write-Host "Aucun fichier. Annulation."
            exit
        }
    } elseif ($choice -eq "D") {
        # Astuce : utiliser OpenFileDialog pour ouvrir un dossier
        # En utilisant l'option "DisplayFolder" dans un "FileDialog" pour afficher un dossier
        $fileDialog.ValidateNames = $false
        $fileDialog.CheckFileExists = $false
        $fileDialog.CheckPathExists = $false
        $fileDialog.FileName = "Selectionnez un dossier"

        $result = $fileDialog.ShowDialog()
        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            $InputPath = [System.IO.Path]::GetDirectoryName($fileDialog.FileName)
            Write-Host "Dossier : $InputPath"
        } else {
            Write-Host "Aucun dossier. Annulation."
            exit
        }
    } else {
        Write-Host "Choix invalide. Veuillez entrer 'F' pour fichier ou 'D' pour dossier."
        exit
    }

    # Verification du chemin (fichier ou dossier)
    if (Test-Path $InputPath) {
        if (Test-Path $InputPath -PathType Leaf) {
            Write-Host "C'est un fichier."
        } elseif (Test-Path $InputPath -PathType Container) {
            Write-Host "C'est un dossier."
        }
    } else {
        Write-Host "Le chemin specifie n'est pas valide."
        exit
    }


    $Recursive = $false
    if (Test-Path -Path $InputPath -PathType Container) {
        Show-Menu -Title "Voulez-vous inclure les sous-dossiers ?" -Options "Oui", "Non"
        $recursiveChoice = Get-ValidChoice -Prompt "Votre reponse" -MaxOptions 2
        $Recursive = ($recursiveChoice -eq 1)
    }

    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Title = "Selectionnez un dossier de destination"
    $openFileDialog.Filter = "Dossier uniquement|."
    $openFileDialog.CheckFileExists = $false
    $openFileDialog.CheckPathExists = $true
    
    # Forcer la selection d'un dossier
    $openFileDialog.ValidateNames = $false
    $openFileDialog.FileName = "Selectionnez"
    
    $result = $openFileDialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $OutputPath = [System.IO.Path]::GetDirectoryName($openFileDialog.FileName)
    } else {
        Write-Host "Aucun dossier. Annulation."
        exit
    }
    

    $extensionChoices = @("mp4", "mov", "avi", "webm")
    Show-Menu -Title "Choisissez l'extension de sortie :" -Options $extensionChoices
    $extensionChoice = Get-ValidChoice -Prompt "Votre reponse" -MaxOptions $extensionChoices.Length
    $OutputExtension = $extensionChoices[$extensionChoice - 1]

    do {
        $Quality = Read-Host "Qualite (0-25, 0 etant la meilleure)"
    } while ($Quality -notmatch '^\d+$' -or [int]$Quality -lt 0 -or [int]$Quality -gt 25)

    Show-Menu -Title "Voulez-vous redimensionner la video ?" -Options "Oui", "Non"
    $resizeChoice = Get-ValidChoice -Prompt "Votre reponse" -MaxOptions 2
    $Resize = ($resizeChoice -eq 1)

    $Width = 0
    $Height = 0
    if ($Resize) {
        do {
            $Width = Read-Host "Largeur souhaitee"
        } while ($Width -notmatch '^\d+$' -or [int]$Width -le 0)

        do {
            $Height = Read-Host "Hauteur souhaitee"
        } while ($Height -notmatch '^\d+$' -or [int]$Height -le 0)
    }

    Convert-Video -InputPath $InputPath -OutputPath $OutputPath -OutputExtension $OutputExtension -Quality $Quality -Recursive $Recursive -Resize $Resize -Width $Width -Height $Height

    Write-Host "`nConversion terminee. Appuyez sur une touche pour quitter."
    Read-Host
}
catch {
    Write-Host "Une erreur inattendue s'est produite : $_"
    Read-Host "Appuyez sur une touche pour quitter."
}