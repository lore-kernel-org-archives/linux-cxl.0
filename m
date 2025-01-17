Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAD1FECA1
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114322; cv=none; b=UMeZ1t+v8dJuM8Ysfr9aKS8f/Cq1ny45m7uH3ekLLB9vKU7yDQeqJTMa4lOefstmvHQvFQ8Yfy03coRxwCsKlpgYOX2G5rnocFu1bAFVrfp5Vmq1WQXUwvB6/xj3EjI7bmfq70zg6AgAQNLlycxl6tHjFNkAFY07NBLIBH7TTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114322; c=relaxed/simple;
	bh=nKwib8uLvdQ5ZJNcNzp0F0bxiqKLUVpq7eXmugAOedU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Keo5EKw9iojJI+lXk1Hw37aslu6YUdfqLs8M82gNPtvdj7oBk6u728028qTOLgJXJ6VAuFIXxbec3jA0y2M1YmLJYdUGcXmbMaoH6ba8au/HvS1baJWTfrVdhpUirMR2ThscSaV7gtg3lUn8XnWHpfkF9ybgsPcOpIimz5KVUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZHtT26CDz6M4Pj;
	Fri, 17 Jan 2025 19:43:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BDE0140CB9;
	Fri, 17 Jan 2025 19:45:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 12:45:16 +0100
Date: Fri, 17 Jan 2025 11:45:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<chenbaozi@phytium.com.cn>
Subject: Re: [PATCH 1/1] cxl/cxl-host: Support creation of a new CXL Host
 Bridge
Message-ID: <20250117114514.00003772@huawei.com>
In-Reply-To: <20250117034343.26356-2-wangyuquan1236@phytium.com.cn>
References: <20250117034343.26356-1-wangyuquan1236@phytium.com.cn>
	<20250117034343.26356-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 11:43:43 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
> could be considered as a prototype of an independent cxl host bridge
> which combines gpex features (ecam, mmio windows & irq) and pxb-cxl
> features(CHBCR) at meanwhile.
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original pcie host topology. In the previous, the pxb-cxl-host with
> any cxl root ports and cxl endpoint devices would occupy the BDF
> number of the original pcie domain. This new type provide a solution
> to resolve the problem.
> 
> Also the CXLFixedWindow struct adds a new member 'target_chb' to
> record the target list of CXLHostBridge. And necessary is to adjust
> the logic of 'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to
> allow different types of cxl host bridge.
> 
> Move 'cxl_get_hb_cstate' & 'cxl_get_hb_passthrough' from pxb code
> into cxl-host code.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This needs review form people more familiar with host bridges in general
than I am, but I'll give some comments.

Firstly there are some mechanical renames in here which are probably
fine but belong in a separate precursor patch.

Please have one series that introduces this and makes use of it.
There are functions that are exposed more widely than previously
without it being clear why.

Also, the new host bridge support needs to be it's own thing, not
in cxl-host.c which is the Host support (so cfmws routing) not
the host bridge support.  Probably wants to be in hw/pci-host/cxl.c
alongside gpex etc.

Jonathan

> ---
>  hw/cxl/cxl-host-stubs.c             |   2 +
>  hw/cxl/cxl-host.c                   | 220 ++++++++++++++++++++++++++--
>  hw/pci-bridge/pci_expander_bridge.c |  20 +--
>  include/hw/cxl/cxl.h                |  23 +++
>  include/hw/cxl/cxl_component.h      |   4 +-
>  include/hw/cxl/cxl_host.h           |   6 +
>  6 files changed, 242 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index cae4afcdde..aea94933ba 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -11,5 +11,7 @@
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
>  void cxl_machine_init(Object *obj, CXLState *state) {};
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                        CXLFixedMemoryWindowOptions *object, Error **errp) {};
>  
>  const MemoryRegionOps cfmws_ops;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e9f2543c43..81a5948874 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -16,15 +16,37 @@
>  #include "qapi/qapi-visit-machine.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
> +#include "hw/irq.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci-bridge/pci_expander_bridge.h"
>  
> -static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> -                                           CXLFixedMemoryWindowOptions *object,
> -                                           Error **errp)
> +CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb, int type)
> +{
> +    if (type == 0) {
> +        CXLHost *pxbhost = PXB_CXL_HOST(hb);
> +        return &pxbhost->cxl_cstate;
> +    } else {
> +        CXLHostBridge *cxlhost = CXL_HOST(hb);
> +        return &cxlhost->cxl_cstate;
> +    }
> +}
> +
> +bool cxl_get_hb_passthrough(PCIHostState *hb, int type)
> +{
> +    if (type == 0) {
> +        CXLHost *pxbhost = PXB_CXL_HOST(hb);
> +        return pxbhost->passthrough;
> +    } else {
> +        return false;
> +    }
> +}
As below. To me these add nothing useful. I'd put the code inline.

> +
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                                    CXLFixedMemoryWindowOptions *object,
> +                                    Error **errp)
>  {
>      ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
> @@ -81,18 +103,24 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
>              int i;
>  
>              for (i = 0; i < fw->num_targets; i++) {
> -                Object *o;
> +                Object *pxb_cxl, *cxl_host;
>                  bool ambig;
>  
> -                o = object_resolve_path_type(fw->targets[i],
> +                pxb_cxl = object_resolve_path_type(fw->targets[i],
>                                               TYPE_PXB_CXL_DEV,
>                                               &ambig);

Do a resolve without type then dynamic cast to check which one it is.
Should end up simpler and you only need one object pointer.


> -                if (!o) {
> -                    error_setg(errp, "Could not resolve CXLFM target %s",
> -                               fw->targets[i]);
> +                if (!pxb_cxl) {
> +                    cxl_host = object_resolve_path_type(fw->targets[i],
> +                                             TYPE_CXL_HOST,
> +                                             &ambig);
> +                    if (!cxl_host) {
> +                        error_setg(errp, "Could not resolve CXLFM target %s",
> +                                   fw->targets[i]);
>                      return;
> +                    }

Indent looks suspicious.

> +                    fw->target_chb[i] = CXL_HOST(cxl_host);
>                  }
> -                fw->target_hbs[i] = PXB_CXL_DEV(o);
> +                fw->target_hbs[i] = PXB_CXL_DEV(pxb_cxl);
This is casting something we might know is null. Make it conditional on pxb_cxl.

>              }
>          }
>      }
> @@ -162,23 +190,36 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      uint8_t target;
>      bool target_found;
>      PCIDevice *rp, *d;
> +    int type;
>  
>      /* Address is relative to memory region. Convert to HPA */
>      addr += fw->base;
>  
>      rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
> -    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
> -    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> -        return NULL;
> +    if (fw->target_chb[rb_index]) {
> +        type = CXL_HOST_BRIDGE_TYPE;
> +        hb = PCI_HOST_BRIDGE(fw->target_chb[rb_index]);
> +        CXLHostBridge *host = fw->target_chb[rb_index];
> +
> +        hb_cstate = &host->cxl_cstate;
> +        cache_mem = hb_cstate->crb.cache_mem_registers;
> +        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +        rp = pcie_find_port_by_pn(hb->bus, target);
> +    } else {
> +        type = PXB_CXL_HOST_TYPE;

use a bool or just duplicate the small amount of code that follows that is type
dependent.  Then can split the cxl_get_hb_passthrough() and cxl_get_hb_cstate()
dependent on the type. There is little benefit that I can see in combining them
as the two paths do very different things


> +        hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
> +        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> +            return NULL;
> +        }
>      }
>  
> -    if (cxl_get_hb_passthrough(hb)) {
> +    if (cxl_get_hb_passthrough(hb, type)) {
>          rp = pcie_find_port_first(hb->bus);
>          if (!rp) {
>              return NULL;
>          }
>      } else {
> -        hb_cstate = cxl_get_hb_cstate(hb);
> +        hb_cstate = cxl_get_hb_cstate(hb, type);
>          if (!hb_cstate) {
>              return NULL;
>          }
> @@ -372,3 +413,154 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
>          }
>      }
>  }

All of the elements specific to the new host bridge need to go in a separate
file under hw/pci/pci-host I think.

That way we can build it only for SBSA-ref for now, not x86 etc where
I don't see any reason to move away from PXB-CXL.
(Note that I very much still need that on ARM as well because for me
a fixed reference platform like SBSA-REF isn't useful for normal work.
I appreciate it has it's uses though!).

> +
> +static void cxl_host_set_irq(void *opaque, int irq_num, int level)
> +{
> +    CXLHostBridge *host = opaque;
> +
> +    qemu_set_irq(host->irq[irq_num], level);
> +}

...

> +
> +void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host,
> +                                Error **errp)
> +{
> +    CXLComponentState *cxl_cstate = &host->cxl_cstate;
> +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> +    hwaddr offset;
> +
> +    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
> +    if (offset > memory_region_size(&cxl_state->host_mr)) {
> +        error_setg(errp, "Insufficient space for sbsa cxl host register space");
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);

Do you need this complexity?  I need it for PXB because we have a dynamic
set up and lots of PXBs is an important test case. For your use, can
we not just create each host bridge with provided memory region for
that one?

> +    cxl_state->next_mr_idx++;
> +}

> +static void cxl_host_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> +
> +    hc->root_bus_path = cxl_host_root_bus_path;
> +    dc->realize = cxl_host_realize;
> +    dc->desc = "CXL Host Bridge";
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->fw_name = "cxl";
> +}
> +
> +static const TypeInfo cxl_host_info = {
> +    .name          = TYPE_CXL_HOST,
> +    .parent        = TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size = sizeof(CXLHostBridge),
> +    .class_init    = cxl_host_class_init,
> +};
> +
> +static void cxl_host_register(void)
> +{
> +    type_register_static(&cxl_host_info);
> +}
This stuff definitely belongs alongside the other host bridge
definitions not in cxl-host.c which is about the fixed memory
windows - so the actual host bit of routing, not the host bridge.

> +
> +type_init(cxl_host_register)
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 07d411cff5..2f1b26256b 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -56,20 +56,6 @@ static GList *pxb_dev_list;
>  
>  #define TYPE_PXB_HOST "pxb-host"
>  
> -CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
> -{
> -    CXLHost *host = PXB_CXL_HOST(hb);
> -
> -    return &host->cxl_cstate;
> -}
> -
> -bool cxl_get_hb_passthrough(PCIHostState *hb)
> -{
> -    CXLHost *host = PXB_CXL_HOST(hb);
> -
> -    return host->passthrough;
> -}
> -
>  static int pxb_bus_num(PCIBus *bus)
>  {
>      PXBDev *pxb = PXB_DEV(bus->parent_dev);
> @@ -240,7 +226,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
>   * This is a device to handle the MMIO for a CXL host bridge. It does nothing
>   * else.
>   */
> -static const TypeInfo cxl_host_info = {
> +static const TypeInfo pxb_cxl_host_info = {

I agree this could potentially be confusing, but please do the rename
in a patch that just does that.

>      .name          = TYPE_PXB_CXL_HOST,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(CXLHost),
> @@ -524,7 +510,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
>       * vendor, device, class, etc. ids are intentionally left out.
>       */
>  
> -    dc->desc = "CXL Host Bridge";
> +    dc->desc = "PXB CXL Host Bridge";
>      device_class_set_props(dc, pxb_cxl_dev_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  
> @@ -551,7 +537,7 @@ static void pxb_register_types(void)
>      type_register_static(&pxb_pcie_bus_info);
>      type_register_static(&pxb_cxl_bus_info);
>      type_register_static(&pxb_host_info);
> -    type_register_static(&cxl_host_info);
> +    type_register_static(&pxb_cxl_host_info);
>      type_register_static(&pxb_dev_info);
>      type_register_static(&pxb_pcie_dev_info);
>      type_register_static(&pxb_cxl_dev_info);
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..548a1bd28c 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -17,6 +17,7 @@
>  #include "cxl_pci.h"
>  #include "cxl_component.h"
>  #include "cxl_device.h"
> +#include "hw/pci/pcie_host.h"
>  
>  #define CXL_CACHE_LINE_SIZE 64
>  #define CXL_COMPONENT_REG_BAR_IDX 0
> @@ -24,12 +25,34 @@
>  
>  #define CXL_WINDOW_MAX 10
>  
> +#define PXB_CXL_HOST_TYPE 0
> +#define CXL_HOST_BRIDGE_TYPE 1
Only used in one place where we pick between these two.
Just use a bool down there.

> +
> +#define TYPE_CXL_HOST "cxl-host"
> +OBJECT_DECLARE_SIMPLE_TYPE(CXLHostBridge, CXL_HOST)
> +
> +#define CXL_HOST_NUM_IRQS 4
> +
>  typedef struct PXBCXLDev PXBCXLDev;
>  
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
>  typedef struct CXLFixedWindow {
>      uint64_t size;
>      char **targets;
>      PXBCXLDev *target_hbs[16];
> +    CXLHostBridge *target_chb[16];
>      uint8_t num_targets;
>      uint8_t enc_int_ways;
>      uint8_t enc_int_gran;
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 945ee6ffd0..953521d601 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -270,8 +270,8 @@ uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
>  
>  hwaddr cxl_decode_ig(int ig);
>  
> -CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
> -bool cxl_get_hb_passthrough(PCIHostState *hb);
> +CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb, int type);
> +bool cxl_get_hb_passthrough(PCIHostState *hb, int type);
>  
>  bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
>  void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
> diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> index c9bc9c7c50..d6d915141a 100644
> --- a/include/hw/cxl/cxl_host.h
> +++ b/include/hw/cxl/cxl_host.h
> @@ -16,6 +16,12 @@
>  void cxl_machine_init(Object *obj, CXLState *state);
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp);
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                        CXLFixedMemoryWindowOptions *object, Error **errp);
> +
> +int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
> +void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host,
> +                                Error **errp);
>  
>  extern const MemoryRegionOps cfmws_ops;
>  
Thanks,

Jonathan


