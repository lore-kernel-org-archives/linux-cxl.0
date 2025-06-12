Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606F28C013
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740487; cv=none; b=i9k4QM0axY1HZ5hY0ZtMXsFUWugsfmHyLT/ySAN7HLy6Shzj9oTOACxAxu4JdADsqR1mONStPGpcXi0PC91cLAMfG6GrW9I9ejIDocJwAAMHVoRTiqBk2mKd2ldNe142uOYWTF+kHk0HVqyYaeevd7mx+x+GyySKg5crlh59HP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740487; c=relaxed/simple;
	bh=g949gMGb1Z1oNc93brkzoD46ccpBcDntGirSBkhaBzI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGGYUGeGi7phfQbJwXM6LaV4HzktNd9DZNXACcTr1N8VBhUQ5c5jStF9haij/XhfMkRoFIyj5lUCKkxYY2sPg+WqxHWEr93iC6E6sXwqLq5cyM3JSqhV4QcVdmc4b4oXJefUFEjuy/uBrtyHx79bbfmaCeic7SkrKiTmloize+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ5K94CZtz6K9CR;
	Thu, 12 Jun 2025 22:59:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4684C1402CB;
	Thu, 12 Jun 2025 23:01:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 17:01:20 +0200
Date: Thu, 12 Jun 2025 16:01:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<chenbaozi@phytium.com.cn>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] pci-host/cxl: Support creation of a new CXL
 Host Bridge
Message-ID: <20250612160119.000060e2@huawei.com>
In-Reply-To: <20250530103320.534173-3-wangyuquan1236@phytium.com.cn>
References: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
	<20250530103320.534173-3-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 18:33:20 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
I'd stick to simpler text.
Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR)

> could be considered as a prototype of an independent cxl host bridge
> which combines gpex features (ecam, mmio windows & irq) and CHBCR
> at meanwhile.
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original pcie host topology. In the previous, the pxb-cxl-host with

PCIe or PCIE

> any cxl root ports and cxl endpoint devices would occupy the BDF

CXL

> number of the original pcie domain. This new type provide a solution
> to resolve the problem.

This isn't describing a problem as such.  I think the problem is with
the generated ACPI tables etc being wrong.  Perhaps some more details? 

> 
> CXLFixedWindow struct adds a new member 'target_chb' to record the
> target list of CXLHostBridge and adjusts the logic of
> 'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to allow different
> types of cxl host bridge.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>


A few comments inline.  I don't mind this support being added as
long as we get the user in (so SBSA patch as well).

> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e010163174..183bc19a4b 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c

> -static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> -                                           CXLFixedMemoryWindowOptions *object,
> -                                           Error **errp)
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                                    CXLFixedMemoryWindowOptions *object,
> +                                    Error **errp)
>  {
>      ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
> @@ -83,14 +85,16 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
>                  bool ambig;
>  
>                  o = object_resolve_path_type(fw->targets[i],
> -                                             TYPE_PXB_CXL_DEV,
> -                                             &ambig);
> -                if (!o) {
> +                    TYPE_DEVICE, &ambig);

Keep alignment as it was.  If nothing else it makes it more obvious what
exactly is changing in this diff.


> +
> +                if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV) ||
> +                    object_dynamic_cast(o, TYPE_CXL_HOST)) {
> +                    fw->target_hbs[i] = o;
> +                } else {
>                      error_setg(errp, "Could not resolve CXLFM target %s",
> -                               fw->targets[i]);
> +                        fw->targets[i]);

Check for unnecessary white space changes like this one as they make it
harder to read the patch.

>                      return;
>                  }
> -                fw->target_hbs[i] = PXB_CXL_DEV(o);
>              }
>          }
>      }

> diff --git a/hw/pci-host/cxl.c b/hw/pci-host/cxl.c
> new file mode 100644
> index 0000000000..8323456864
> --- /dev/null
> +++ b/hw/pci-host/cxl.c
> @@ -0,0 +1,145 @@

Needs SPDX header I think.

> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci-host/cxl_host_bridge.h"

> +
> +static void cxl_host_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    CXLHostBridge *host = CXL_HOST(dev);
> +    CXLComponentState *cxl_cstate = &host->cxl_cstate;
> +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> +    PCIBus *cxlbus;

Ordering seems a little random. I'd move this cxlbus to after pex.

> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +    int i;
> +
> +    /* CHBCR MMIO init */
> +    cxl_host_reset(host);
> +    cxl_component_register_block_init(OBJECT(dev), cxl_cstate, TYPE_CXL_HOST);
> +    sysbus_init_mmio(sbd, mr);
> +
> +    /* MMFG window init */

MMCFG however, I'd just drop this comment as the code is fairly obvious.  Also dro
the CHBCR one above for the same reason.

> +    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
> +    sysbus_init_mmio(sbd, &pex->mmio);
> +
> +    /* mmio window init */

And this comment.  None of them are adding significant value.

> +    memory_region_init(&host->io_mmio, OBJECT(host), "cxl_host_mmio",
> +                        UINT64_MAX);
> +
> +    memory_region_init_io(&host->io_mmio_window, OBJECT(host),
> +                              &unassigned_io_ops, OBJECT(host),
> +                              "cxl_host_mmio_window", UINT64_MAX);
> +
> +    memory_region_add_subregion(&host->io_mmio_window, 0, &host->io_mmio);
> +    sysbus_init_mmio(sbd, &host->io_mmio_window);
> +
> +    /* ioport window init, 64K is the legacy size in x86 */
> +    memory_region_init(&host->io_ioport, OBJECT(host), "cxl_host_ioport",
> +                        64 * 1024);
> +
> +    memory_region_init_io(&host->io_ioport_window, OBJECT(host),
> +                              &unassigned_io_ops, OBJECT(host),
> +                              "cxl_host_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&host->io_ioport_window, 0, &host->io_ioport);
> +    sysbus_init_mmio(sbd, &host->io_ioport_window);
> +
> +    /* PCIe host bridge use 4 legacy IRQ lines */
> +    for (i = 0; i < CXL_HOST_NUM_IRQS; i++) {
> +        sysbus_init_irq(sbd, &host->irq[i]);
> +        host->irq_num[i] = -1;
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "cxlhost.0", cxl_host_set_irq,
> +                                 pci_swizzle_map_irq_fn, host, &host->io_mmio,
> +                                 &host->io_ioport, 0, 4, TYPE_CXL_BUS);
> +    cxlbus = pci->bus;
> +    cxlbus->flags |= PCI_BUS_CXL;
> +
> +    pci_bus_set_route_irq_fn(pci->bus, cxl_host_route_intx_pin_to_irq);
> +}


> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
> index 937a0f72ac..a00995068b 100644
> --- a/hw/pci-host/meson.build
> +++ b/hw/pci-host/meson.build
> @@ -4,6 +4,7 @@ pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
>  pci_ss.add(when: 'CONFIG_GT64120', if_true: files('gt64120.c'))
>  pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
>  pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
> +pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('cxl.c'))

I think this needs it's own config variable.

>  pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'], if_true: files('gpex-acpi.c'))
>  pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
>  pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))

> diff --git a/include/hw/pci-host/cxl_host_bridge.h b/include/hw/pci-host/cxl_host_bridge.h
> new file mode 100644
> index 0000000000..f6830dab83
> --- /dev/null
> +++ b/include/hw/pci-host/cxl_host_bridge.h
> @@ -0,0 +1,25 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hw/cxl/cxl.h"
> +#include "hw/irq.h"
> +#include "hw/pci/pcie_host.h"
> +
> +#define CXL_HOST_NUM_IRQS 4

Does that come directly from the PCIe bus spec, if so is there
a PCIe definition somewhere we can use for this?

None of the CXL spec defined stuff uses legacy interrupts
but I guess we have to support them for any PCIe device plugged
in to the bus.

> +
> +typedef struct CXLHostBridge {
> +    PCIExpressHost parent_obj;
> +
> +    CXLComponentState cxl_cstate;
> +
> +    MemoryRegion io_ioport;
> +    MemoryRegion io_mmio;
> +    MemoryRegion io_ioport_window;
> +    MemoryRegion io_mmio_window;
> +    qemu_irq irq[CXL_HOST_NUM_IRQS];
> +    int irq_num[CXL_HOST_NUM_IRQS];
> +} CXLHostBridge;
> +
> +int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
> +void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host);

