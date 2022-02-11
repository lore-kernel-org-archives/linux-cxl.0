Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50198C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Feb 2022 16:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiBKQxe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:53:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbiBKQxa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Feb 2022 11:53:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E74D72
        for <linux-cxl@vger.kernel.org>; Fri, 11 Feb 2022 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644598408; x=1676134408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2jACV4mCRkxcOu4FZVzWjPQ+/CPFp5jnV9pIuvvpV0=;
  b=OEoCNKUi+vR1oYHytShTsWzInoMhoWJWAXon+Z8ulHEst5INP0OB9N7v
   UJyAhLDE+SIQXRULR3I0hG1whyVQxE+j4knhygtU42KtfmCsJwmm0m9xx
   vUICs4zcPHJkNWvrwEmOj3sDx0J6+LNT2qdWZQxo+W3ZVwEukmFZGHX1l
   sxVqhW366NTpFzxMxMEe11VpTTy6AW2PtPiOaejspFRNU2EeusHpUF6FZ
   TRWOFvOjyNPY+Vn4XWQTpObspuzZrOwu4BT6FLJo5Uj4MWTnYc8bkDJgw
   /SYUajX8ygornQR3rfr4zCa2gwc6dyyHdWbDfBmqxOEz2iaTY7ImOxZDa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="247357348"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="247357348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:52:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="772141065"
Received: from aalamats-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.123])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:52:52 -0800
Date:   Fri, 11 Feb 2022 08:52:50 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 20/43] hw/cxl/device: Add a memory device (8.2.8.5)
Message-ID: <20220211165250.jfhogwq2mwyqopkp@intel.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
 <20220202141037.17352-21-Jonathan.Cameron@huawei.com>
 <20220211155000.qdmehl4f327ts3ud@intel.com>
 <20220211164519.00001899@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211164519.00001899@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-02-11 16:45:19, Jonathan Cameron wrote:
> On Fri, 11 Feb 2022 07:50:00 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 22-02-02 14:10:14, Jonathan Cameron wrote:
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > 
> > > A CXL memory device (AKA Type 3) is a CXL component that contains some
> > > combination of volatile and persistent memory. It also implements the
> > > previously defined mailbox interface as well as the memory device
> > > firmware interface.
> > > 
> > > Although the memory device is configured like a normal PCIe device, the
> > > memory traffic is on an entirely separate bus conceptually (using the
> > > same physical wires as PCIe, but different protocol).
> > > 
> > > Once the CXL topology is fully configure and address decoders committed,
> > > the guest physical address for the memory device is part of a larger
> > > window which is owned by the platform.  The creation of these windows
> > > is later in this series.
> > > 
> > > The following example will create a 256M device in a 512M window:
> > > -object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
> > > -device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0"
> > > 
> > > Note: Dropped PCDIMM info interfaces for now.  They can be added if
> > > appropriate at a later date.
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c |  47 ++++++++++
> > >  hw/mem/Kconfig             |   5 ++
> > >  hw/mem/cxl_type3.c         | 170 +++++++++++++++++++++++++++++++++++++
> > >  hw/mem/meson.build         |   1 +
> > >  include/hw/cxl/cxl.h       |   1 +
> > >  include/hw/cxl/cxl_pci.h   |  22 +++++
> > >  include/hw/pci/pci_ids.h   |   1 +
> > >  7 files changed, 247 insertions(+)
> > >  create mode 100644 hw/mem/cxl_type3.c
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 16bb998735..808faec114 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -50,6 +50,8 @@ enum {
> > >      LOGS        = 0x04,
> > >          #define GET_SUPPORTED 0x0
> > >          #define GET_LOG       0x1
> > > +    IDENTIFY    = 0x40,
> > > +        #define MEMORY_DEVICE 0x0
> > >  };
> > >  
> > >  /* 8.2.8.4.5.1 Command Return Codes */
> > > @@ -216,6 +218,48 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
> > >      return CXL_MBOX_SUCCESS;
> > >  }
> > >  
> > > +/* 8.2.9.5.1.1 */
> > > +static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> > > +                                           CXLDeviceState *cxl_dstate,
> > > +                                           uint16_t *len)
> > > +{
> > > +    struct {
> > > +        char fw_revision[0x10];
> > > +        uint64_t total_capacity;
> > > +        uint64_t volatile_capacity;
> > > +        uint64_t persistent_capacity;
> > > +        uint64_t partition_align;
> > > +        uint16_t info_event_log_size;
> > > +        uint16_t warning_event_log_size;
> > > +        uint16_t failure_event_log_size;
> > > +        uint16_t fatal_event_log_size;
> > > +        uint32_t lsa_size;
> > > +        uint8_t poison_list_max_mer[3];
> > > +        uint16_t inject_poison_limit;
> > > +        uint8_t poison_caps;
> > > +        uint8_t qos_telemetry_caps;
> > > +    } __attribute__((packed)) *id;
> > > +    _Static_assert(sizeof(*id) == 0x43, "Bad identify size");
> > > +
> > > +    uint64_t size = cxl_dstate->pmem_size;
> > > +
> > > +    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> > > +        return CXL_MBOX_INTERNAL_ERROR;
> > > +    }
> > > +
> > > +    id = (void *)cmd->payload;
> > > +    memset(id, 0, sizeof(*id));
> > > +
> > > +    /* PMEM only */
> > > +    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> > > +
> > > +    id->total_capacity = size / (256 << 20);
> > > +    id->persistent_capacity = size / (256 << 20);
> > > +
> > > +    *len = sizeof(*id);
> > > +    return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> > >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > >  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> > > @@ -233,8 +277,11 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> > >      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
> > >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
> > >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > > +    [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
> > > +        cmd_identify_memory_device, 0, 0 },
> > >  };
> > >  
> > > +
> > >  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > >  {
> > >      uint16_t ret = CXL_MBOX_SUCCESS;
> > > diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> > > index 03dbb3c7df..73c5ae8ad9 100644
> > > --- a/hw/mem/Kconfig
> > > +++ b/hw/mem/Kconfig
> > > @@ -11,3 +11,8 @@ config NVDIMM
> > >  
> > >  config SPARSE_MEM
> > >      bool
> > > +
> > > +config CXL_MEM_DEVICE
> > > +    bool
> > > +    default y if CXL
> > > +    select MEM_DEVICE
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > new file mode 100644
> > > index 0000000000..c4021d2434
> > > --- /dev/null
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -0,0 +1,170 @@
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/units.h"
> > > +#include "qemu/error-report.h"
> > > +#include "hw/mem/memory-device.h"
> > > +#include "hw/mem/pc-dimm.h"
> > > +#include "hw/pci/pci.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/log.h"
> > > +#include "qemu/module.h"
> > > +#include "qemu/range.h"
> > > +#include "qemu/rcu.h"
> > > +#include "sysemu/hostmem.h"
> > > +#include "hw/cxl/cxl.h"
> > > +
> > > +typedef struct cxl_type3_dev {
> > > +    /* Private */
> > > +    PCIDevice parent_obj;
> > > +
> > > +    /* Properties */
> > > +    uint64_t size;
> > > +    HostMemoryBackend *hostmem;
> > > +
> > > +    /* State */
> > > +    CXLComponentState cxl_cstate;
> > > +    CXLDeviceState cxl_dstate;
> > > +} CXLType3Dev;
> > > +
> > > +#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> > > +
> > > +static void build_dvsecs(CXLType3Dev *ct3d)
> > > +{
> > > +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > > +    uint8_t *dvsec;
> > > +
> > > +    dvsec = (uint8_t *)&(struct cxl_dvsec_device){
> > > +        .cap = 0x1e,
> > > +        .ctrl = 0x6,
> > > +        .status2 = 0x2,
> > > +        .range1_size_hi = 0,
> > > +#ifdef SET_PMEM_PADDR
> > > +        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | ct3d->size,
> > > +#else
> > > +        .range1_size_lo = 0x3,
> > > +#endif
> > > +        .range1_base_hi = 0,
> > > +        .range1_base_lo = 0,
> > > +    };
> > > +    cxl_component_create_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
> > > +                               PCIE_CXL_DEVICE_DVSEC,
> > > +                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> > > +
> > > +    dvsec = (uint8_t *)&(struct cxl_dvsec_register_locator){
> > > +        .rsvd         = 0,
> > > +        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
> > > +        .reg0_base_hi = 0,
> > > +        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
> > > +        .reg1_base_hi = 0,
> > > +    };
> > > +    cxl_component_create_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> > > +                               REG_LOC_DVSEC_REVID, dvsec);
> > > +}
> > > +
> > > +static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > > +{
> > > +    MemoryRegion *mr;
> > > +
> > > +    if (!ct3d->hostmem) {
> > > +        error_setg(errp, "memdev property must be set");
> > > +        return;
> > > +    }  
> > 
> > This check can go away with the below.
> > 
> > > +
> > > +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> > > +    if (!mr) {
> > > +        error_setg(errp, "memdev property must be set");
> > > +        return;
> > > +    }
> > > +    memory_region_set_nonvolatile(mr, true);
> > > +    memory_region_set_enabled(mr, true);
> > > +    host_memory_backend_set_mapped(ct3d->hostmem, true);
> > > +    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
> > > +}
> > > +
> > > +
> > > +static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> > > +{
> > > +    CXLType3Dev *ct3d = CT3(pci_dev);
> > > +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > > +    ComponentRegisters *regs = &cxl_cstate->crb;
> > > +    MemoryRegion *mr = &regs->component_registers;
> > > +    uint8_t *pci_conf = pci_dev->config;
> > > +
> > > +    if (!ct3d->hostmem) {
> > > +        cxl_setup_memory(ct3d, errp);
> > > +    }  
> > 
> > I still haven't had time to review, sorry.
> 
> No problem. The first part which is being proposed as possibly getting
> picked up shortly is all your code anyway subject to a few trivial
> review comment related changes.
> 
> Things will get more interesting after that.
> 
> > We did hit this in our driver
> > development: I think this should be inverted. The original code worked a bit
> > differently.
> > 
> > if (ct3d->hostmem) {
> > 	cxl_setup_memory(ct3d, errp);
> > }
> 
> Good spot. I'll fix this in v7.
> 
> I'm curious though, what was result of it not being set?  Wrong
> pmem_size?  Given this wasn't running I'm guessing I don't
> need the rest of the stuff in cxl_setup_memory().
> 

We hit it because the ndctl/libcxl work Vishal is doing cares about the pmem
size. The last version I posted of the region driver does not actually care
about how much space the device has available but it would matter for region
creation. There's more work/thought that needs to go in from what I originally
planned based on some feedback from Dan, so I dropped it.

I think the rest is needed IFF you care about the CXL.mem traffic appearing on
the "device" but I don't know for sure.

> > 
> > > +
> > > +    pci_config_set_prog_interface(pci_conf, 0x10);
> > > +    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
> > > +
> > > +    pcie_endpoint_cap_init(pci_dev, 0x80);
> > > +    cxl_cstate->dvsec_offset = 0x100;
> > > +
> > > +    ct3d->cxl_cstate.pdev = pci_dev;
> > > +    build_dvsecs(ct3d);
> > > +
> > > +    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
> > > +                                      TYPE_CXL_TYPE3_DEV);
> > > +
> > > +    pci_register_bar(
> > > +        pci_dev, CXL_COMPONENT_REG_BAR_IDX,
> > > +        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
> > > +
> > > +    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
> > > +    pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
> > > +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > +                     &ct3d->cxl_dstate.device_registers);
> > > +}
> > > +
> > > +static void ct3d_reset(DeviceState *dev)
> > > +{
> > > +    CXLType3Dev *ct3d = CT3(dev);
> > > +    uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> > > +
> > > +    cxl_component_register_init_common(reg_state, CXL2_TYPE3_DEVICE);
> > > +    cxl_device_register_init_common(&ct3d->cxl_dstate);
> > > +}
> > > +
> > > +static Property ct3_props[] = {
> > > +    DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
> > > +    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> > > +                     HostMemoryBackend *),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void ct3_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
> > > +
> > > +    pc->realize = ct3_realize;
> > > +    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> > > +    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> > > +    pc->device_id = 0xd93; /* LVF for now */
> > > +    pc->revision = 1;
> > > +
> > > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > > +    dc->desc = "CXL PMEM Device (Type 3)";
> > > +    dc->reset = ct3d_reset;
> > > +    device_class_set_props(dc, ct3_props);
> > > +}
> > > +
> > > +static const TypeInfo ct3d_info = {
> > > +    .name = TYPE_CXL_TYPE3_DEV,
> > > +    .parent = TYPE_PCI_DEVICE,
> > > +    .class_init = ct3_class_init,
> > > +    .instance_size = sizeof(CXLType3Dev),
> > > +    .interfaces = (InterfaceInfo[]) {
> > > +        { INTERFACE_CXL_DEVICE },
> > > +        { INTERFACE_PCIE_DEVICE },
> > > +        {}
> > > +    },
> > > +};
> > > +
> > > +static void ct3d_registers(void)
> > > +{
> > > +    type_register_static(&ct3d_info);
> > > +}
> > > +
> > > +type_init(ct3d_registers);
> > > diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> > > index 82f86d117e..609b2b36fc 100644
> > > --- a/hw/mem/meson.build
> > > +++ b/hw/mem/meson.build
> > > @@ -3,6 +3,7 @@ mem_ss.add(files('memory-device.c'))
> > >  mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
> > >  mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
> > >  mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
> > > +mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> > >  
> > >  softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
> > >  
> > > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > > index 75e5bf71e1..6889362230 100644
> > > --- a/include/hw/cxl/cxl.h
> > > +++ b/include/hw/cxl/cxl.h
> > > @@ -17,6 +17,7 @@
> > >  #define CXL_COMPONENT_REG_BAR_IDX 0
> > >  #define CXL_DEVICE_REG_BAR_IDX 2
> > >  
> > > +#define TYPE_CXL_TYPE3_DEV "cxl-type3"
> > >  #define CXL_WINDOW_MAX 10
> > >  
> > >  typedef struct CXLState {
> > > diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> > > index 40c7329afe..e8235b10cc 100644
> > > --- a/include/hw/cxl/cxl_pci.h
> > > +++ b/include/hw/cxl/cxl_pci.h
> > > @@ -64,6 +64,28 @@ _Static_assert(sizeof(struct dvsec_header) == 10,
> > >   * CXL 2.0 Downstream Port: 3, 4, 7, 8
> > >   */
> > >  
> > > +/* CXL 2.0 - 8.1.3 (ID 0001) */
> > > +struct cxl_dvsec_device {
> > > +    struct dvsec_header hdr;
> > > +    uint16_t cap;
> > > +    uint16_t ctrl;
> > > +    uint16_t status;
> > > +    uint16_t ctrl2;
> > > +    uint16_t status2;
> > > +    uint16_t lock;
> > > +    uint16_t cap2;
> > > +    uint32_t range1_size_hi;
> > > +    uint32_t range1_size_lo;
> > > +    uint32_t range1_base_hi;
> > > +    uint32_t range1_base_lo;
> > > +    uint32_t range2_size_hi;
> > > +    uint32_t range2_size_lo;
> > > +    uint32_t range2_base_hi;
> > > +    uint32_t range2_base_lo;
> > > +};
> > > +_Static_assert(sizeof(struct cxl_dvsec_device) == 0x38,
> > > +               "dvsec device size incorrect");
> > > +
> > >  /* CXL 2.0 - 8.1.5 (ID 0003) */
> > >  struct cxl_dvsec_port_extensions {
> > >      struct dvsec_header hdr;
> > > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> > > index 11abe22d46..898083b86f 100644
> > > --- a/include/hw/pci/pci_ids.h
> > > +++ b/include/hw/pci/pci_ids.h
> > > @@ -53,6 +53,7 @@
> > >  #define PCI_BASE_CLASS_MEMORY            0x05
> > >  #define PCI_CLASS_MEMORY_RAM             0x0500
> > >  #define PCI_CLASS_MEMORY_FLASH           0x0501
> > > +#define PCI_CLASS_MEMORY_CXL             0x0502
> > >  #define PCI_CLASS_MEMORY_OTHER           0x0580
> > >  
> > >  #define PCI_BASE_CLASS_BRIDGE            0x06
> > > -- 
> > > 2.32.0
> > >   
> 
