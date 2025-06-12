Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CC2989BD
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741468; cv=none; b=hZbJvXVxf3f0uD+7XP6/F9XyUSa/3alqDmrVas55cYmlk0w9/eivq0PHKzyRWI+6a1EqUOEXWAp/RrD+fMHXdG1auobwLT++ZNiTeoJogcYBK8FooJ8B2uFn1IVpX/UuiB+0//gNSY1IT58df1jQXHINNkeY8kXDVdocYGt4sEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741468; c=relaxed/simple;
	bh=8uIRdESD1gNusE0xGsHCUaacHPBk7GBXJoQs05DIhp4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcLl5JiFM5YJRPOK2ckR8vQ6sga7YoImW6vMZnjGFjw55OBBiuEOUqRS6ds200y2CDnkWPtckmXOnBGM2hIW6q9uuEdknfy5yEqtzJvizt7wUfkgQHgIqsD3A6TBFAD5cNou+FblfUoAQejdazFKJtAUwneAnx0oMv+JQFj/15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ5dC4X0vz6K5Yp;
	Thu, 12 Jun 2025 23:13:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A83114020C;
	Thu, 12 Jun 2025 23:17:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 17:17:41 +0200
Date: Thu, 12 Jun 2025 16:17:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <rad@semihalf.com>, <peter.maydell@linaro.org>,
	<leif.lindholm@oss.qualcomm.com>, <chenbaozi@phytium.com.cn>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v5] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
Message-ID: <20250612161739.0000400c@huawei.com>
In-Reply-To: <20250530105430.1662-1-wangyuquan1236@phytium.com.cn>
References: <20250530105430.1662-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 18:54:30 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This creates a specific cxl host bridge (0001:00) with two cxl
> root ports on sbsa-ref. And the memory layout provides separate
> space windows for the cxl host bridge in the sbsa-ref memmap:
> 
> - 64K  CXL Host Bridge Component Registers (CHBCR)
> - 64K  CXL_PIO
> - 128M CXL_MMIO
> - 256M CXL_ECAM
> - 4G   CXL_MMIO_HIGH
> 
> To provide CFMWs on sbsa-ref, this extends 1TB space from the
> hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:
> 
> - 1T   CXL_FIXED_WINDOW
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
> 
> v4 -> v5:
> - Updates fw->target_chbs[0] to fw->target_hbs[0]
> 
> Background
> ==========
> Currently the base CXL support for arm platforms is only on Jonathan's patches[2].
> SBSA-REF can be more like a real machine, thus my initial purpose is to support the
> simplest cxl VH topology on sbsa-ref to verify the basic cxl function usage,
> therefore, some real machine could refer the cxl running result on sbsa-ref.  
> 
> This series leverages Jonathan's patches to design [SBSA_CXL_CHBCR] and
> [SBSA_CXL_FIXED_WINDOW] spaces for sbsa-ref layout. 
> 
> Regard to the burden of edk2 firmware, I try to build a static CEDT table and add
> acpi0016, acpi0017 and other cxl relevant contents into acpi tables[3][4]. Hence it
> doesn't need to communicate cxl contents via DT to edk2. 
> 
> The New CXL HOST
> ================
> This patch will use the new cxl host bridge to establish the cxl topology[5].
> 
> CXL FIXED WINDOW design
> =======================
> 0xA0000000000 is chosen as the base address of this space because of 3 reasons:
> 1) It is more suitable to choose a static address instead of that
> implementation in virt, since a dynamic address space layout of
> sbsa-ref is not appropriate for its original purpose as a reference
> platform.
> 
> 2) The Hotplug Memory address range should in the range of maximum
> addressable range of sbsa-ref platform(0x10000000000-0x80ffffffffff).
> It is satisfied the requirements of memory hotplug in linux kernel.
> 
> 3) The start pfn of CFMW should exceed the reserved_pfn_range for
> onlined numa node.
> 
> Usage of cxl on sbsa-ref
> ========================
> With the 'create_cxl' and 'create_cxl_fixed_window', users don't need to input
> '-device pxb-cxl' , '-device cxl-rp' and '-M cxl-fmw' parameters.
> 
> Thus, to run sbsa-ref with a cxl device could use:
> qemu-system-aarch64 \
> -object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
> -device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \
> 
> Incompatibility problem
> =======================
> Although the new cxl host bridge has been separated from the original pcie host, the
> incompatibility problem of "-device qemu-xhci" is not resolved. Because the new device
> to plug by qemu command would be enumerated at the largest domain(0001), for example,
> if we add "-device qemu-xhci" to boot sbsa-ref with cxl, the lspci would show:
> 
>     root@ubuntu-jammy-arm64:~# lspci
>     0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
>     0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
>     0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
>     0001:00:00.0 PCI bridge: Intel Corporation Device 7075
>     0001:00:01.0 PCI bridge: Intel Corporation Device 7075
>     0001:00:02.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
>     0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> 
>     root@ubuntu-jammy-arm64:~# lspci -tv
>     -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
>     |           +-01.0-[02]--
>     |           \-02.0  Red Hat, Inc. QEMU XHCI Host Controller
>     \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>                 +-01.0  Intel Corporation 82574L Gigabit Network Connection
>                 \-02.0  Device 1234:1111
> 
> Hence we should add "bus=pcie.0" when we want to plug some devices on the original
> pcie bus, for example:
> -device qemu-xhci,bus=pcie.0 \
> or
> -device nvme,serial=deadbeef,bus=pcie.0,drive=hdd \
> -drive file=../disk/hdd.qcow2,format=qcow2,id=hdd,if=none \
> 
> So the result is:
>     root@ubuntu-jammy-arm64:~# lspci
>     0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
>     0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
>     0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
>     0000:00:03.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
>     0001:00:00.0 PCI bridge: Intel Corporation Device 7075
>     0001:00:01.0 PCI bridge: Intel Corporation Device 7075
>     0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> 
>     root@ubuntu-jammy-arm64:~# lspci -tv
>     -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
>     |           \-01.0-[02]--
>     \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>                 +-01.0  Intel Corporation 82574L Gigabit Network Connection
>                 +-02.0  Device 1234:1111
>                 \-03.0  Red Hat, Inc. QEMU XHCI Host Controller
> 
> Dynamic cxl topology problem
> ============================
> Actually the ideal expectation is sbsa-ref could also have a dynamic cxl topology by user
> parameters. According to my knowledge, it should pass a dtb to firmware to match the requird

Spell check: required

> address space. I'm currently trying to solve this problem. I am looking for suggestions on if
> there are better ways to do it.

I wonder how many cases we actually need to cover?  If we were to support 2 host bridges
with a few root ports each (maybe 4 or 8?) and a set of static fixed memory windows

1. Target only 1st host bridge.
2. Target only 2nd host bridge
3. Target interleave granularity X across host bridges
4. Target interleave granularity Y across host bridges

Maybe longer term we'd want some of the more complex options such as different properties
for the fixed memory windows or different QoS groups (QTG) but I'm not sure
we want to go for fully configurable.  The virt patches cover testing a
general software stack - in my mind SBSA-ref is about testing a single representative
configuration.  The dance through DT and trusted world is just too messy for
a development platform / configurable test platform.

Note that I don't plan to test these at the moment precisely because every
time I touch SBSA-ref I find myself going down a rabbit hole to get to a result
I personally don't care that much about.  It's a good thing, just not particularly
useful to me!


> 
> This series patches are here to hopefully some comments to guide me!
> 
> Link:
> [1]: https://lists.nongnu.org/archive/html/qemu-arm/2024-12/msg00350.html
> [2]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
> [3]: https://edk2.groups.io/g/devel/message/120851
> [4]: https://edk2.groups.io/g/devel/topic/rfc_patch_edk2_platforms_v4/110023229
> [5]: https://lore.kernel.org/linux-cxl/20250530103320.534173-1-wangyuquan1236@phytium.com.cn/T/#t

Other than a few trivial things below this looks fine to me.

> +static void create_cxl(SBSAMachineState *sms)
> +{
> +    hwaddr base_pio = sbsa_ref_memmap[SBSA_CXL_PIO].base;
> +    int irq = sbsa_ref_irqmap[SBSA_CXL];
> +    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *chbcr = &sms->cxl_devices_state.host_mr;
> +    DeviceState *dev;
> +    CXLHostBridge *host;
> +    PCIHostState *cxl;
> +    PCIDevice *cxlrp;
> +    PCIEPort *p;
> +    PCIESlot *s;
> +    int i;
> +
> +    dev = qdev_new(TYPE_CXL_HOST);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sms->cxl_devices_state.is_enabled = true;
> +
> +    /* Map CXL ECAM space */

I'd only keep comments like this if they add information not obvious
from the code. However, I see the PCIe code has these, so maybe it's
preferred int his file.

> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
> +                             ecam_reg, 0, sbsa_ref_memmap[SBSA_CXL_ECAM].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                              sbsa_ref_memmap[SBSA_CXL_ECAM].base, ecam_alias);
> +
> +    /* Map CXL MMIO space */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
> +                             mmio_reg, sbsa_ref_memmap[SBSA_CXL_MMIO].base,
> +                                       sbsa_ref_memmap[SBSA_CXL_MMIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                           sbsa_ref_memmap[SBSA_CXL_MMIO].base, mmio_alias);
> +
> +    /* Map CXL MMIO_HIGH space */
> +    mmio_alias_high = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
> +                           mmio_reg, sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base,
> +                                     sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                    sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base, mmio_alias_high);
> +
> +    /* Map CXL IO port space */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, base_pio);
> +
> +    for (i = 0; i < CXL_HOST_NUM_IRQS; i++) {

As I commented on the supporting series, these IRQs have nothing to do with CXL
as such or the particular host bridge. They are part of the PCI spec.
I'd use PCI_NUM_PINS.

> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                           qdev_get_gpio_in(sms->gic, irq + i));
> +        cxl_host_set_irq_num(CXL_HOST(dev), i, irq + i);
> +    }
> +
> +    /* Map CXL CHBCR space */
> +    memory_region_init(chbcr, OBJECT(sms), "cxl_host_reg",
> +                       sbsa_ref_memmap[SBSA_CXL_CHBCR].size);
> +    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_CHBCR].base,
> +                                chbcr);
> +
> +    cxl = PCI_HOST_BRIDGE(dev);
> +
> +    /* Connect two cxl root ports */

I'd go with at least 4 to enable various interleave options beyond the
choice of interleave or no interleave.

> +    for (i = 0; i < 2; i++) {
> +        cxlrp = pci_new(-1, "cxl-rp");
> +        p = PCIE_PORT(cxlrp);
> +        s = PCIE_SLOT(cxlrp);
> +        p->port = i;
> +        s->slot = i;
> +        pci_realize_and_unref(cxlrp, cxl->bus, &error_fatal);
> +    }
> +
> +    host = CXL_HOST(dev);
> +    cxl_host_hook_up_registers(&sms->cxl_devices_state, host);
> +
> +    create_cxl_fixed_window(sms, sysmem, host);
> +}

