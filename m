Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D8C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Mar 2022 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiCDNbu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiCDNbr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Mar 2022 08:31:47 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C21B7556
        for <linux-cxl@vger.kernel.org>; Fri,  4 Mar 2022 05:30:58 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K97xc5kwGz67tJb;
        Fri,  4 Mar 2022 21:29:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 14:30:56 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 13:30:55 +0000
Date:   Fri, 4 Mar 2022 13:30:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 21/43] hw/cxl/device: Plumb real Label Storage Area
 (LSA) sizing
Message-ID: <20220304133054.000039bd@huawei.com>
In-Reply-To: <871qzkllj1.fsf@linaro.org>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
        <20220211120747.3074-22-Jonathan.Cameron@huawei.com>
        <871qzkllj1.fsf@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Mar 2022 10:01:48 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > This should introduce no change. Subsequent work will make use of this
> > new class member.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  3 +++
> >  hw/mem/cxl_type3.c          | 24 +++++++++---------------
> >  include/hw/cxl/cxl_device.h | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index d022711b2a..ccf9c3d794 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -278,6 +278,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> >      } __attribute__((packed)) *id;
> >      _Static_assert(sizeof(*id) == 0x43, "Bad identify size");
> >  
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
> >      uint64_t size = cxl_dstate->pmem_size;
> >  
> >      if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> > @@ -292,6 +294,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> >  
> >      id->total_capacity = size / (256 << 20);
> >      id->persistent_capacity = size / (256 << 20);
> > +    id->lsa_size = cvc->get_lsa_size(ct3d);
> >  
> >      *len = sizeof(*id);
> >      return CXL_MBOX_SUCCESS;
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index da091157f2..b16262d3cc 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -13,21 +13,6 @@
> >  #include "sysemu/hostmem.h"
> >  #include "hw/cxl/cxl.h"
> >  
> > -typedef struct cxl_type3_dev {
> > -    /* Private */
> > -    PCIDevice parent_obj;
> > -
> > -    /* Properties */
> > -    uint64_t size;
> > -    HostMemoryBackend *hostmem;
> > -
> > -    /* State */
> > -    CXLComponentState cxl_cstate;
> > -    CXLDeviceState cxl_dstate;
> > -} CXLType3Dev;
> > -
> > -#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> > -  
> 
> If the structure had been in the header to start with it would be easier
> to see the changes added for this bit.
> 

Moved.. One other thing below.

> 
> >  static void build_dvsecs(CXLType3Dev *ct3d)
> >  {
> >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > @@ -186,10 +171,16 @@ static Property ct3_props[] = {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > +static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> > +{
> > +    return 0;
> > +}
> > +
> >  static void ct3_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> >      PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
> > +    CXLType3Class *cvc = CXL_TYPE3_DEV_CLASS(oc);
> >  
> >      pc->realize = ct3_realize;
> >      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> > @@ -201,11 +192,14 @@ static void ct3_class_init(ObjectClass *oc, void *data)
> >      dc->desc = "CXL PMEM Device (Type 3)";
> >      dc->reset = ct3d_reset;
> >      device_class_set_props(dc, ct3_props);
> > +
> > +    cvc->get_lsa_size = get_lsa_size;
> >  }
> >  
> >  static const TypeInfo ct3d_info = {
> >      .name = TYPE_CXL_TYPE3_DEV,
> >      .parent = TYPE_PCI_DEVICE,
> > +    .class_size = sizeof(struct CXLType3Class),
> >      .class_init = ct3_class_init,
> >      .instance_size = sizeof(CXLType3Dev),
> >      .instance_finalize = ct3_finalize,
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 8102d2a813..ebb391153a 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -230,4 +230,33 @@ REG64(CXL_MEM_DEV_STS, 0)
> >      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
> >      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
> >  
> > +typedef struct cxl_type3_dev {
> > +    /* Private */
> > +    PCIDevice parent_obj;
> > +
> > +    /* Properties */
> > +    uint64_t size;
> > +    HostMemoryBackend *hostmem;
> > +    HostMemoryBackend *lsa;
> > +
> > +    /* State */
> > +    CXLComponentState cxl_cstate;
> > +    CXLDeviceState cxl_dstate;
> > +} CXLType3Dev;
> > +
> > +#ifndef TYPE_CXL_TYPE3_DEV
> > +#define TYPE_CXL_TYPE3_DEV "cxl-type3"
> > +#endif

I'm not sure why the ifndef is needed. Probably a legacy of some
refactoring, so I've dropped that and the other definition of this
in cxl.h

> > +
> > +#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> > +OBJECT_DECLARE_TYPE(CXLType3Device, CXLType3Class, CXL_TYPE3_DEV)
> > +
> > +struct CXLType3Class {
> > +    /* Private */
> > +    PCIDeviceClass parent_class;
> > +
> > +    /* public */
> > +    uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
> > +};
> > +
> >  #endif  
> 
> 

