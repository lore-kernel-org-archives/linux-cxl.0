Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E777111
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456526; cv=none; b=QziB6Z8Xr4tS9DcYH+Kt6VepnfwnOxMFNJrhAnXtoptTtwdJIR6BfIfFKBY7eSKsFgkJIMMDa2U464HQ3mYXdQEcPlzxsCP9Wmz2TO9u4T3/joPUxFZyAQz/TYjkknIXIU6FIHpqaSmpYCgwZikHThNk680jZQZl18pYFSERGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456526; c=relaxed/simple;
	bh=RSulnjkPmyW1ozuxXgGsiNTIoKZP7coElIKpYxq8AYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pivsRJpTOsjZampsCed7EXfwH3KVo0BU6jcvfKyUl8AV4P/9GAdxL7AWWPMR75SlIsJ3hKmpPG02YBZcDkosNyV7KrfhCAyhzsypsYBB68p4JIT3IGalbGqlqBMew+5rt6u6Jri3viegyF9IyrgLGRP9CeZiDsKZCgBXOlVVePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpWbz2pRHz6M4nb;
	Fri, 25 Jul 2025 23:13:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E7E4C1400C8;
	Fri, 25 Jul 2025 23:15:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 17:15:19 +0200
Date: Fri, 25 Jul 2025 16:15:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <rad@semihalf.com>, <peter.maydell@linaro.org>,
	<leif.lindholm@oss.qualcomm.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v6] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
Message-ID: <20250725161518.000027b3@huawei.com>
In-Reply-To: <20250617041946.82587-1-wangyuquan1236@phytium.com.cn>
References: <20250617041946.82587-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:19:46 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This creates a specific CXL host bridge (0001:00) with two cxl
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

A few comments inline.  Mostly code style things.

Jonathan

>  docs/system/arm/sbsa.rst |   4 ++
>  hw/arm/Kconfig           |   1 +
>  hw/arm/sbsa-ref.c        | 137 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 141 insertions(+), 1 deletion(-)
> 

> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c

> +static void create_cxl(SBSAMachineState *sms)
> +{
> +    hwaddr base_ecam = sbsa_ref_memmap[SBSA_CXL_ECAM].base;
This is a lot of local variables. Some of them are only used once
I think.  Maybe just push the look ups in sbsa_ref_memmap to where
they are used?

> +    hwaddr size_ecam = sbsa_ref_memmap[SBSA_CXL_ECAM].size;
> +    hwaddr base_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].base;
> +    hwaddr size_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].size;
> +    hwaddr base_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base;
> +    hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size;
> +    hwaddr base_pio = sbsa_ref_memmap[SBSA_CXL_PIO].base;
> +    hwaddr base_chbcr = sbsa_ref_memmap[SBSA_CXL_CHBCR].base;
> +    hwaddr size_chbcr = sbsa_ref_memmap[SBSA_CXL_CHBCR].size;
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

Superficially seems to me that the naming makes this obvious (excellent)
so no need for comment?

> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
> +                             ecam_reg, 0, size_ecam);
    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1)),
                             0, sbsa_ref_memmap[SBSA_CXL_ECAM].size);

> +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
    memory_region_add_subregion(get_system_memory(),
                                sbsa_ref_memmap[SBSA_CXL_ECAM].base,
                                ecam_alias);

both look simple enough to read to me and cut down on code length.

Maybe don't go quite that far, but in general it feels like this code
could be more compact whilst retaining it's readability.

> +
> +    /* Map CXL MMIO space */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
> +                             mmio_reg, base_mmio, size_mmio);
> +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);

Similar to above. Bringing as much as possible inline probably makes sense.

> +
> +    /* Map CXL MMIO_HIGH space */
> +    mmio_alias_high = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
> +                             mmio_reg, base_mmio_high, size_mmio_high);
> +    memory_region_add_subregion(get_system_memory(),
> +                                base_mmio_high, mmio_alias_high);
> +
> +    /* Map CXL IO port space */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, base_pio);
> +
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                           qdev_get_gpio_in(sms->gic, irq + i));
> +        cxl_host_set_irq_num(CXL_HOST(dev), i, irq + i);
> +    }
> +
> +    /* Map CXL CHBCR space */
> +    memory_region_init(chbcr, OBJECT(sms), "cxl_host_reg", size_chbcr);
> +    memory_region_add_subregion(sysmem, base_chbcr, chbcr);
> +
> +    cxl = PCI_HOST_BRIDGE(dev);

> +
> +    for (i = 0; i < 4; i++) {
> +        cxlrp = pci_new(-1, "cxl-rp");
> +        p = PCIE_PORT(cxlrp);
> +        s = PCIE_SLOT(cxlrp);

Could just do

         PCIE_PORT(cxlrp)->port = i;
and similar for slot. Seems simper than the local
variables. If not drag those variables in this scope so it is
clear they only effect this code.

> +        p->port = i;
> +        s->slot = i;
> +        pci_realize_and_unref(cxlrp, cxl->bus, &error_fatal);

       pci_realize_and_unref(cxlrp, PCI_HOST_BRIDGE(dev)->bus, &error_fatal);

> +    }
> +
> +    host = CXL_HOST(dev);
> +    cxl_host_hook_up_registers(&sms->cxl_devices_state, host);
> +
> +    create_cxl_fixed_window(sms, sysmem, host);
> +}
> +
>  static void create_pcie(SBSAMachineState *sms)
>  {
>      hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> @@ -823,6 +956,8 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_pcie(sms);
>  
> +    create_cxl(sms);
> +
>      create_secure_ec(secure_sysmem);
>  
>      sms->bootinfo.ram_size = machine->ram_size;

