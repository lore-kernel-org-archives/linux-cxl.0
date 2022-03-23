Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA04C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Mar 2022 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiCWSix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiCWSix (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 14:38:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885364BDD
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 11:37:22 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNxrW6Bfcz67Cqn;
        Thu, 24 Mar 2022 02:36:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 23 Mar 2022 19:37:19 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 18:37:19 +0000
Date:   Wed, 23 Mar 2022 18:37:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Be?= =?ISO-8859-1?Q?nn=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 23/46] hw/cxl/component: Implement host bridge MMIO
 (8.2.5, table 142)
Message-ID: <20220323183717.00006c94@huawei.com>
In-Reply-To: <10cae45f-9f3a-c7a5-c834-ae14a5fcbecf@ilande.co.uk>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-24-Jonathan.Cameron@huawei.com>
        <10cae45f-9f3a-c7a5-c834-ae14a5fcbecf@ilande.co.uk>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 19 Mar 2022 08:35:54 +0000
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 18/03/2022 15:06, Jonathan Cameron wrote:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > CXL host bridges themselves may have MMIO. Since host bridges don't have
> > a BAR they are treated as special for MMIO.  This patch includes
> > i386/pc support.
> > Also hook up the device reset now that we have have the MMIO
> > space in which the results are visible.
> > 
> > Note that we duplicate the PCI express case for the aml_build but
> > the implementations will diverge when the CXL specific _OSC is
> > introduced.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

...

> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index f762eb4a6e..b3b5f93650 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -75,6 +75,9 @@ struct PXBDev {
> >       uint8_t bus_nr;
> >       uint16_t numa_node;
> >       bool bypass_iommu;
> > +    struct cxl_dev {
> > +        CXLHost *cxl_host_bridge;
> > +    } cxl;
> >   };
> >   
> >   static PXBDev *convert_to_pxb(PCIDevice *dev)
> > @@ -92,6 +95,9 @@ static GList *pxb_dev_list;
> >   
> >   #define TYPE_PXB_HOST "pxb-host"
> >   
> > +#define TYPE_PXB_CXL_HOST "pxb-cxl-host"
> > +#define PXB_CXL_HOST(obj) OBJECT_CHECK(CXLHost, (obj), TYPE_PXB_CXL_HOST)  
> 
> Again this is a legacy QOM type declaration and should be replaced with 
> OBJECT_DECLARE_SIMPLE_TYPE(). It should also be located in the associated header file 
> if it exists (include/hw/cxl/cxl.h in this case).

Sure, though as noted below that means dragging the structure there as well.
I'm not quite sure why we want to put this in a header given it's only
used locally in this file, but fair enough that is best practice.

> 
> >   static int pxb_bus_num(PCIBus *bus)
> >   {
> >       PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> > @@ -197,6 +203,52 @@ static const TypeInfo pxb_host_info = {
> >       .class_init    = pxb_host_class_init,
> >   };
> >   
> > +static void pxb_cxl_realize(DeviceState *dev, Error **errp)
> > +{
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +    CXLHost *cxl = PXB_CXL_HOST(dev);
> > +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> > +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> > +    hwaddr offset;
> > +
> > +    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
> > +                                      TYPE_PXB_CXL_HOST);
> > +    sysbus_init_mmio(sbd, mr);
> > +
> > +    offset = memory_region_size(mr) * ms->cxl_devices_state->next_mr_idx;
> > +    if (offset > memory_region_size(&ms->cxl_devices_state->host_mr)) {
> > +        error_setg(errp, "Insufficient space for pxb cxl host register space");
> > +        return;
> > +    }
> > +
> > +    memory_region_add_subregion(&ms->cxl_devices_state->host_mr, offset, mr);
> > +    ms->cxl_devices_state->next_mr_idx++;
> > +}
> > +
> > +static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(class);
> > +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> > +
> > +    hc->root_bus_path = pxb_host_root_bus_path;
> > +    dc->fw_name = "cxl";
> > +    dc->realize = pxb_cxl_realize;
> > +    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
> > +    dc->user_creatable = false;
> > +}
> > +
> > +/*
> > + * This is a device to handle the MMIO for a CXL host bridge. It does nothing
> > + * else.
> > + */
> > +static const TypeInfo cxl_host_info = {
> > +    .name          = TYPE_PXB_CXL_HOST,
> > +    .parent        = TYPE_PCI_HOST_BRIDGE,
> > +    .instance_size = sizeof(CXLHost),
> > +    .class_init    = pxb_cxl_host_class_init,
> > +};
> > +
> >   /*
> >    * Registers the PXB bus as a child of pci host root bus.
> >    */
> > @@ -245,6 +297,12 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
> >   
> >   static void pxb_dev_reset(DeviceState *dev)
> >   {
> > +    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl.cxl_host_bridge;
> > +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> > +    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
> > +
> > +    cxl_component_register_init_common(reg_state, CXL2_ROOT_PORT);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
> >   }
> >   
> >   static gint pxb_compare(gconstpointer a, gconstpointer b)
> > @@ -281,12 +339,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
> >           dev_name = dev->qdev.id;
> >       }
> >   
> > -    ds = qdev_new(TYPE_PXB_HOST);
> > +    ds = qdev_new(type == CXL ? TYPE_PXB_CXL_HOST : TYPE_PXB_HOST);
> >       if (type == PCIE) {
> >           bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
> >       } else if (type == CXL) {
> >           bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_CXL_BUS);
> >           bus->flags |= PCI_BUS_CXL;
> > +        PXB_CXL_DEV(dev)->cxl.cxl_host_bridge = PXB_CXL_HOST(ds);
> >       } else {
> >           bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
> >           bds = qdev_new("pci-bridge");
> > @@ -475,6 +534,7 @@ static void pxb_register_types(void)
> >       type_register_static(&pxb_pcie_bus_info);
> >       type_register_static(&pxb_cxl_bus_info);
> >       type_register_static(&pxb_host_info);
> > +    type_register_static(&cxl_host_info);
> >       type_register_static(&pxb_dev_info);
> >       type_register_static(&pxb_pcie_dev_info);
> >       type_register_static(&pxb_cxl_dev_info);
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index 31af92fd5e..75e5bf71e1 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -17,8 +17,12 @@
> >   #define CXL_COMPONENT_REG_BAR_IDX 0
> >   #define CXL_DEVICE_REG_BAR_IDX 2
> >   
> > +#define CXL_WINDOW_MAX 10
> > +
> >   typedef struct CXLState {
> >       bool is_enabled;
> > +    MemoryRegion host_mr;
> > +    unsigned int next_mr_idx;
> >   } CXLState;  
> 
> ... so simply drop the typedef and place OBJECT_DECLARE_SIMPLE_TYPE here instead.

This isn't the right structure.

I've dragged the
struct CXLHost definition to here.

which need an additional include but that's fine.
> 
> >   #endif  
> 
> 
> ATB,
> 
> Mark.

