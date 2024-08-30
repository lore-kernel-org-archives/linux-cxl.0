Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D718A927
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013433; cv=none; b=JyGmqu096W5c9VWK5o9dA9SU1cWM0nvMQCYl729bsxkh1BzFLRhYq0SPoR6IVg7RmkAomdf5R/NTTWyNcyKmo9rae9ZhyQjvCe0YitQxu6Fe2ghDmec/3aB+V3UonCep/0wcfl9M3NIc9kopWnLSyMVydNEl4pEfUdss8qfRHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013433; c=relaxed/simple;
	bh=K8vxo+/gNgQFT3DLamRz5iBR3W1egWsjEccWaK0rYwg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTCjwDmAkJtAjaYVJAJdKZ0PejlhflA78FZChOSPBZ1p/lqX8IGFv0/tYf52M6g8tsY5qLBSklfboe6hRoBxTBYCFP/6IqGpxxPcuxKUJiJ1XIOd6zsJiPfx9PP0+8eT1z11hytRdzuvWhNPJRo1OV+DcI4wGzC/+mPqXlvr46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwDgC6SZBz6K9F1;
	Fri, 30 Aug 2024 18:20:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 979E514073F;
	Fri, 30 Aug 2024 18:23:47 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:23:47 +0100
Date: Fri, 30 Aug 2024 11:23:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <quic_llindhol@quicinc.com>, <peter.maydell@linaro.org>,
	<marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
	<shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH 2/2] hw/arm/sbsa-ref: Support CXL Fixed Memory
 Window
Message-ID: <20240830112346.0000667c@Huawei.com>
In-Reply-To: <20240830041557.600607-3-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
	<20240830041557.600607-3-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 12:15:57 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> In order to provide CFMWs on sbsa-ref, this extends 1TB space
> from the hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory
> Window. 0xA0000000000 is chosen as the base address of this
> space because of 3 reasons:
> 
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
> Based on 'cxl_fmws_link_targets', this adds a new function
> 'sbsa_cxl_fmws_link_targets' for binding cfmws.target with the default
> pxb-cxl-bus on sbsa-ref.
> 
> In addition, this also adds 'create_cxl_fixed_window_region' which
> based on 'machine_set_cfmw' to support creating a static cfmw region on
> sbsa-ref.
> 
> Thus, to run sbsa-ref with a cxl device could use:
> qemu-system-aarch64 \
> -machine sbsa-ref \
> -cpu cortex-a57 \
> -smp 4 \
> -m 4G \
> -object memory-backend-ram,size=2G,id=mem0 \
> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
> -object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
> -device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \
> -hda ubuntu.ext4 \
> -pflash SBSA_FLASH0.fd \
> -pflash SBSA_FLASH1.fd \
> 
> I'm not sure if the new space layout would bring a series of bad
> influence, this patch is here to hopefully some comments to guide me!

I've no idea on memory layout for sbsaref so will leave those
more knowledgeable to comment on that.

I'm not sure why you can't use the generic code to set up the 
target linkage.  That 'should' work, but you will need the options
to be a match for the naming of the pxb bus.

Given you know how many fixed windows there are etc, you can
also simplify various code paths.  See inline.

Overall though this looks right to me. Again things are much simpler
if you have everything hard coded but not so useful to me as my
interest is poking the kernel stack and that needs a broad range
of flexibility I can't do in SBSA ref for all the reasons you've
hardcoded things.

Jonathan


> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  hw/arm/sbsa-ref.c                   | 73 +++++++++++++++++++++++++++++
>  hw/cxl/cxl-host-stubs.c             |  1 +
>  hw/cxl/cxl-host.c                   |  2 +-
>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>  include/hw/cxl/cxl_host.h           |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  6 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index dc924d181e..b10865920e 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -100,6 +100,7 @@ enum {
>      SBSA_AHCI,
>      SBSA_XHCI,
>      SBSA_CXL_HOST,
> +    SBSA_CXL_FIXED_WINDOW,
>  };
>  
>  struct SBSAMachineState {
> @@ -152,6 +153,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
>      [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
>      [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
> +    /* 1TB CXL FIXED WINDOW space */
> +    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
>  };
>  
>  static const int sbsa_ref_irqmap[] = {
> @@ -734,6 +737,72 @@ static void create_cxl_host_reg_region(SBSAMachineState *sms)
>      memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_HOST].base, mr);
>  }
>  
> +static void create_cxl_fixed_window_region(SBSAMachineState *sms, MemoryRegion *mem)
> +{
> +    char cxl_host[] = "pxb-cxl-bus.0";

Better to retrieve this from the object rather than hard coding.
	object_get_canonical_path(sms->cxlbus); I think?

> +    CXLFixedMemoryWindowOptionsList *list;
> +    hwaddr base, end;
> +    GList *it;
> +    strList host_target = { NULL, cxl_host };
> +    CXLFixedMemoryWindowOptions sbsa_ref_cfmwoptions = {
> +        .size = 1 * TiB,
> +        .has_interleave_granularity = false,
> +        .targets = &host_target,
> +    };
> +    CXLFixedMemoryWindowOptionsList sbsa_ref_cfmwlist = { NULL, &sbsa_ref_cfmwoptions };

Wrap all these long lines to 80 chars unless it significantly hurts readability.

> +
> +    for (list = &sbsa_ref_cfmwlist; list; list = list->next) {

It's a list of 1, so no point in parsing it like this.  Just use the values
directly for now. If you add more windows, great but that probably only makes
sense if you either:
1) Want windows that have different properties (pmem vs volatile etc)
   Maybe windows that don't support HDM-DB once that is supported in general.
2) You have more than one root bridge and want to do interleave.

I'd quite like to see 2 enabled as that stresses a lot more of the kernel code
that won't be touched here.  However probably that's a job for the future.
For now, just call this as

	cxl_fixed_memory_window_config(&sms->cxl_devices_state,
				       &sbsa_ref_cfmwoptions, &error_fatal);
and have drop the loop.


> +        cxl_fixed_memory_window_config(&sms->cxl_devices_state, list->value, &error_fatal);
> +    }
> +
> +    base = sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].base;
> +    end = base + sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].size;
> +
> +    for (it = sms->cxl_devices_state.fixed_windows; it; it = it->next) {

As above.  Don't code for multiple windows if you only support one.
For now code it for one and if you later follow up with multiple
then that series has a precursor refactoring the code to handle a list.

So just get the first element and work on that to give simpler code
for review today.


> +        CXLFixedWindow *fw = it->data;
> +        if (base + fw->size > end) {
> +            error_report("CFMWS does not fit under PA limit");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        fw->base = base;
> +        memory_region_init_io(&fw->mr, OBJECT(sms), &cfmws_ops, fw,
> +                                "cxl-fixed-memory-region", fw->size);
> +
> +        memory_region_add_subregion(mem, fw->base, &fw->mr);
> +        base += fw->size;
> +    }
> +}
> +
> +static void sbsa_cxl_fmws_link_targets(SBSAMachineState *sms,
> +                                CXLState *cxl_state, Error **errp)
> +{
> +    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(sms->cxlbus));
> +    if (cxl_state && cxl_state->fixed_windows) {
> +        GList *it;
> +
> +        for (it = cxl_state->fixed_windows; it; it = it->next) {
> +            CXLFixedWindow *fw = it->data;
> +            int i;
> +
> +            for (i = 0; i < fw->num_targets; i++) {
> +                Object *o;
> +                bool ambig;
> +
> +                o = object_resolve_path_type(fw->targets[i],
> +                                             TYPE_PXB_CXL_BUS,
> +                                             &ambig);
> +                if (!o) {
> +                    error_setg(errp, "Could not resolve CXLFM target %s",
> +                               fw->targets[i]);
> +                    return;
> +                }
> +                fw->target_hbs[i] = pxb;
This has me confused.  The loop is looking for wrong things and then
you are setting the single target to pxb (Which is correct).

So this whole function could be written

	GList *it = glist_first(cxl_state->fixed_windows);
	CXLFixedWindow *fw = it->data;

	fw->target_hbs[0] = PXB_CXL_DEV(pci_bridge_get_device(sms->cxlbus));

Which doesn't need TYPE_PXB_CXL_BUS etc so you can drop the
moving of that to a header.

I wonder if we can just make this use the normal code however.
You've already set up targets above so why doesn't calling
cxl_fmws_link_targets() not find it?

Of is that magic string above wrong?

> +            
> +        }
> +    }
> +}
> +
>  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>  {
>      const SBSAMachineState *board = container_of(binfo, SBSAMachineState,
> @@ -869,8 +938,12 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_cxl_host_reg_region(sms);
>  
> +    create_cxl_fixed_window_region(sms, sysmem);
> +
I'd be tempted to not have blank space between the various cxl setup steps
as they are all related, however up to sbsa maintainers.

>      cxl_hook_up_pxb_registers(sms->bus, &sms->cxl_devices_state, &error_fatal);
>  
> +    sbsa_cxl_fmws_link_targets(sms, &sms->cxl_devices_state, &error_fatal);
> +
>      create_secure_ec(secure_sysmem);
>  
>      sms->bootinfo.ram_size = machine->ram_size;
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index cae4afcdde..d523be24a2 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -11,5 +11,6 @@
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
>  void cxl_machine_init(Object *obj, CXLState *state) {};
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> +void cxl_fixed_memory_window_config(CXLState *cxl_state, CXLFixedMemoryWindowOptions *object, Error **errp) {};
Wrap that line to 80 chars.

>  
>  const MemoryRegionOps cfmws_ops;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e9f2543c43..d408c7db15 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -22,7 +22,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci-bridge/pci_expander_bridge.h"
>  
> -static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
>                                             Error **errp)
>  {
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..f5431443b9 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
>                           TYPE_PXB_PCIE_BUS)
>  
> -#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
>                           TYPE_PXB_CXL_BUS)
>  
> diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> index c9bc9c7c50..5fbf5a9347 100644
> --- a/include/hw/cxl/cxl_host.h
> +++ b/include/hw/cxl/cxl_host.h
> @@ -16,6 +16,7 @@
>  void cxl_machine_init(Object *obj, CXLState *state);
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp);
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> +void cxl_fixed_memory_window_config(CXLState *cxl_state, CXLFixedMemoryWindowOptions *object, Error **errp);

Very long online. Wrap at 80 chars.
Otherwise I'm fine with exposing this.


>  
>  extern const MemoryRegionOps cfmws_ops;
>  
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..5456e24883 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
>      PXBDev parent_obj;
>  } PXBPCIEDev;
>  
> +#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>  

