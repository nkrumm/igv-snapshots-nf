#!/usr/bin/env nextflow

params.bam = "../40502_B01_OPXv6_ND0364.final.bam"
params.command_file = "test/commands.bat"
params.output = "."

bam_ch = file(params.bam)
bai_ch = file(params.bam + ".bai")
command_file_ch = file(params.command_file)

process create_snapshots {
    container 'nkrumm/igv-screenshot'
    echo true

    input:
        file(bam) from bam_ch
        file(bai) from bai_ch
        file(command_file) from command_file_ch

    output:
        file "snapshots.zip"

    publishDir params.output, overwrite: true

    """
    mkdir SnapshotOutput
    xvfb-run --auto-servernum --server-num=1 /install/bin/IGV_Linux_2.7.2/igv.sh -b ${command_file}
    zip snapshots.zip SnapshotOutput/*.png
    """
}

