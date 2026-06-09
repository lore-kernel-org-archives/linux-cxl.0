Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B541C2E4
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009242; cv=none; b=K5x/rnDvdCZlOG2D9juRkKnmSfAgz3FADrD+H1g6EjMctMV+S0k1rpnXL64ljHZJSy5Y+Hy70vyVA6gM/UA1xAvLzHUPtp1vNyQDEtnxxEIDYdvhP6fW4Qh1v2exz89NcuVScQkO8cjYpWbXKnzlCdxcbJHzNIKJ74RZuhEVqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009242; c=relaxed/simple;
	bh=lvgm1xRfPxe3Lrqsqx/OzOg2yLTdWat7In6+gaG17tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3+86JsPBgBlNgcLT9VXhLc1l4NfFLbj2KFgtnk2TkgUXyKHCdmnbhUYYgDiV7TsILZaC5dwRJbhX/aSd94xfxfSZC2zICUJE/DC9HFbwBc9figqdeJ62XvNXK1E/0WXH175cyUeI3X5UYIOh6P7juW2EZ2+rN2zszsX+wqWYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngmzzyV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngmzzyV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3951F00893;
	Tue,  9 Jun 2026 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781009241;
	bh=4X26vcbCVfZIBSpn5p7qHWYu06T8VSoTygDc7YdrmQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ngmzzyV8D+ZRrg4wKWrbKLcxQ4xQ64A+1/QXnRBEorASK97a076dQqjX0D/Wui9pC
	 iVzSlxS2FVIgX5pYtJsDrSxsqjIvHy2sOD8LZRVLc3Y0uG3NfM/4aOjLU83jwQUjy9
	 szu8cvIo3UQJuqBBVjkVZiZLy02pRZBA7tQgV3Oq2uvWzXGBztYzLIdgiHdiJy3pAU
	 Wi68IwapiOIxAM0pSytYhKKpXoV/CzlI5R85klE8GM76+2Rv9me1kFE9zTrbp7IOCJ
	 TDh3+rHMr0C7ozK4ZYlg4vmWoLB4bXacaXOKLSSnWouZ1oChagHriXD8OBpug3isDY
	 Y5oPbYanmt87Q==
Date: Tue, 9 Jun 2026 13:47:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
Message-ID: <20260609134659.3dc89b40@jic23-huawei>
In-Reply-To: <20260602074127.63819-3-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
	<20260602074127.63819-3-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 15:41:25 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> On RISC-V QEMU virt platform with CXL enabled, the probe ordering
> of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
> guaranteed. If cxl_acpi probes before acpi_pci_root has attached
> the CXL host bridges, the CXL port topology will be incomplete
> because to_cxl_host_bridge() silently skips devices whose PCI root
> is not yet ready.
> 
> Add a _DEP object to the ACPI0017 device in the DSDT, declaring
> its dependency on the ACPI0016 CXL host bridge devices. This tells
> the OS to defer ACPI0017 enumeration until all ACPI0016 devices
> have been attached by acpi_pci_root.
> 
> This requires a corresponding kernel change to call
> acpi_dev_clear_dependencies() in acpi_pci_root_add().
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

It may be a good idea to add a bios tables test as well.
 
We only have the x86 q35 one today because I argued at the time
the ARM64 one would be just duplication.  Now we have this new _DEP
stuff we should probably add something to cover it.

Please also include an iasl -d dump of the relevant additions to DSDT
in the patch description.  Much easier to review than the code that
generates it!

In general looks fine to me and great that you are clearing this up.
Seems it's luck that x86 and ARM64 worked without this (or strictly
speaking other things enforcing the ordering).  Ultimately we probably
want to add this to those two architectures a well.

One small thing inline.

Thanks,

Jonathan


> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 309d64b322..a5bafd1dcf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -510,6 +510,38 @@ static void build_dsdt(GArray *table_data,
>      if (s->cxl_devices_state.is_enabled) {
>          Aml *cxl_dev = aml_device("CXLM");
>          aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +
> +        /*
> +         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
> +         * defers ACPI0017 enumeration until acpi_pci_root has attached
> +         * the CXL host bridges. Without this, cxl_acpi may probe before
> +         * to_cxl_host_bridge() can resolve the PCI root and the CXL
> +         * port topology comes up empty.
> +         */
> +        if (s->bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs = 0;
> +
> +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;

I think you only care if there is at least one. Instead of counting, just set
a bool and break out early if you find one.

> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg = aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->bus->child, sibling) {
> +                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                        aml_append(dep_pkg,
> +                                   aml_name("\\_SB.PC%.02X",
> +                                            pci_bus_num(bus)));
> +                    }
> +                }
> +                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
> +            }
> +        }
> +
>          Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>          aml_append(method, aml_return(aml_int(0x0B)));
>          aml_append(cxl_dev, method);

