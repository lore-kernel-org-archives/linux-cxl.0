Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3153A1A55
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494629; cv=none; b=rCbCpnPwcgKldrawi0482AGH8jl9QZj0gcq+V4yP+b3mZX8oQ50ah6lb83rkzIvFYoJEU+3AxBfSthPsjpD17TAxSedmxWBmlln65dgFJxP3tnZaQ7vxGaD9YGqF2FIeWuCkBvfVTaiseeW3XCxWNSTDGztzPRZirNV/LnWkYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494629; c=relaxed/simple;
	bh=pU0dNZpkpLqoxjvesKaMgHgI9FszWRNh98WyTRpavdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFtxxGgur5YLW9z08WGIF5vNBlKyqylBorlaTxRPMTECBJx4vTa3BBrzKQnDqeeshqe9ThuKWLzQPItznAp6F9AV66HwjFU2d9LkbgKWx5peTI0i0o9hdFVkKmmqTK3vvo7pcFAIRMI51SUZ1YDFGj1KBrDQdt5jKVxfKUkw+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSgeDpYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSgeDpYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250B1F000FF;
	Tue, 15 Sep 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494620;
	bh=Nqyz/fo8sDe5tWT6T0Vt9gjXn3fPwXMtGCd4dYC8aHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lSgeDpYTBUoJ10iGKz8nL9N/sqb5uW9d1jg9LgV24J5n9xtW7QA0YEZ+mU8BDNkXM
	 fplQnbj2Aq+m20pOci5Ujx2HSL4q+CTclrkouquzU4TVKA5yi5BALnZqU7wWM6ynJm
	 jBDBOkJVs5P0mcpFMi3uKbxP50GdfBq3wrzrTAE1L9CH0CZR3ezol/tDvrgfXhYdMg
	 lXeVLKKi88XWkwzSe58c7CButVHXqFsILYHn1qRUTqiw7IyHABMoCuZ1hQHMv2FiH7
	 GDrBZdJQ2RfwF9Zt8WPOuLT+Xhdhc2vs0bwTW4D+1L+qCcuvVZV+GNgbouwRPjhFFQ
	 xVaZc8tpfz+2Q==
Date: Tue, 15 Sep 2026 18:50:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, Sunil V L
 <sunilvl@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/6] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017
 for CXL host bridge dependency
Message-ID: <20260915185014.697c5a38@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-3-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
	<20260907093735.2753-3-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:37:29 +0800
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
> This pairs with two kernel commits, both merged in v7.2:
> bf5418a5fe63 ("ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host
> bridge") makes the ACPI core defer ACPI0017 enumeration while its
> _DEP targets are unattached, and 3a59c3b772e5 ("ACPI: PCI: Clear _DEP
> dependencies after PCI root bridge attach") clears the dependency
> from acpi_pci_root_add() once the host bridge is attached.
> 
> Note on kernel compatibility: this is a "new QEMU feature requires a
> sufficiently new kernel" situation.  Kernels that process _DEP but
> lack the acpi_dev_clear_dependencies() call will leave the CXLM device
> deferred, so CXL memory is unusable there; kernels old enough to ignore
> _DEP entirely behave exactly as before this change.  In neither case is
> existing (non-CXL) PCIe affected.
> 
> The resulting DSDT fragment (iasl -d output) for a single CXL host
> bridge at bus 0x0C looks like:
> 
>   Device (CXLM)
>   {
>       Name (_HID, "ACPI0017")
>       Name (_DEP, Package (0x01)
>       {
>           \_SB.PC0C
>       })
>       Method (_STA, 0, NotSerialized)
>       {
>           Return (0x0B)
>       }
>       ...
>   }
> 
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Whilst by luck we don't need this for Linux to be happy on other
architectures, it may make sense to do it anyway.

When we do that maybe this should be factored out as a helper.
For now LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 2be8c6d572..e1beb2068d 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -525,6 +525,38 @@ static void build_dsdt(GArray *table_data,
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
> +        if (s->pci_bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs = 0;
> +
> +            QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;
> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg = aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
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

