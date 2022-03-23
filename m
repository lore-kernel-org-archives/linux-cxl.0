Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC207C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Mar 2022 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbiCWSTo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbiCWSTk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 14:19:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E337E0C9
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 11:18:07 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNxPd3yy4z67L3x;
        Thu, 24 Mar 2022 02:16:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 19:18:04 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 18:18:03 +0000
Date:   Wed, 23 Mar 2022 18:18:00 +0000
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
Subject: Re: [PATCH v8 17/46] hw/cxl/device: Add a memory device (8.2.8.5)
Message-ID: <20220323181800.0000404d@huawei.com>
In-Reply-To: <b61e4534-988c-14b6-b21b-4040ee72475b@ilande.co.uk>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-18-Jonathan.Cameron@huawei.com>
        <b61e4534-988c-14b6-b21b-4040ee72475b@ilande.co.uk>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 19 Mar 2022 08:32:29 +0000
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 18/03/2022 15:06, Jonathan Cameron via wrote:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > A CXL memory device (AKA Type 3) is a CXL component that contains some
> > combination of volatile and persistent memory. It also implements the
> > previously defined mailbox interface as well as the memory device
> > firmware interface.
> > 
> > Although the memory device is configured like a normal PCIe device, the
> > memory traffic is on an entirely separate bus conceptually (using the
> > same physical wires as PCIe, but different protocol).
> > 
> > Once the CXL topology is fully configure and address decoders committed,
> > the guest physical address for the memory device is part of a larger
> > window which is owned by the platform.  The creation of these windows
> > is later in this series.
> > 
> > The following example will create a 256M device in a 512M window:
> > -object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
> > -device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0"
> > 
> > Note: Dropped PCDIMM info interfaces for now.  They can be added if
> > appropriate at a later date.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---

...

> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > new file mode 100644
> > index 0000000000..a8d7cfcc81
> > --- /dev/null
> > +++ b/hw/mem/cxl_type3.c
> > @@ -0,0 +1,153 @@
> > +#include "qemu/osdep.h"
> > +#include "qemu/units.h"
> > +#include "qemu/error-report.h"
> > +#include "hw/mem/memory-device.h"
> > +#include "hw/mem/pc-dimm.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qapi/error.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/range.h"
> > +#include "qemu/rcu.h"
> > +#include "sysemu/hostmem.h"
> > +#include "hw/cxl/cxl.h"
> > +
> > +static void build_dvsecs(CXLType3Dev *ct3d)
> > +{
> > +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > +    uint8_t *dvsec;
> > +
> > +    dvsec = (uint8_t *)&(struct cxl_dvsec_device){
> > +        .cap = 0x1e,
> > +        .ctrl = 0x6,
> > +        .status2 = 0x2,
> > +        .range1_size_hi = 0,
> > +#ifdef SET_PMEM_PADDR
> > +        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | ct3d->size,
> > +#else
> > +        .range1_size_lo = 0x3,
> > +#endif  
> 
> Generally you don't want #ifdefs like this to control functionality: it should either 
> be removed if it is for unimplemented features, or controlled via a qdev property in 
> ct3_props below.

Oops. That should have been long gone. It's a leftover from a much earlier
attempt to handle the memory address spaces.
The size property of a type3 devices is also not used for anything worthwhile
any more as there seems little reason to not just use the hostmem region size
instead.
So I'll drop that whilst tidying this up which also involves a bunch of
changes to tests and docs.

> 
> > +        .range1_base_hi = 0,
> > +        .range1_base_lo = 0,
> > +    };
> > +    cxl_component_create_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
> > +                               PCIE_CXL_DEVICE_DVSEC,
> > +                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> > +
> > +    dvsec = (uint8_t *)&(struct cxl_dvsec_register_locator){
> > +        .rsvd         = 0,
> > +        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
> > +        .reg0_base_hi = 0,
> > +        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
> > +        .reg1_base_hi = 0,
> > +    };
> > +    cxl_component_create_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> > +                               REG_LOC_DVSEC_REVID, dvsec);
> > +}
> > +

...

> > diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> > index 82f86d117e..609b2b36fc 100644
> > --- a/hw/mem/meson.build
> > +++ b/hw/mem/meson.build
> > @@ -3,6 +3,7 @@ mem_ss.add(files('memory-device.c'))
> >   mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
> >   mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
> >   mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
> > +mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> >   
> >   softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
> >   
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 8102d2a813..72da811c52 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -230,4 +230,21 @@ REG64(CXL_MEM_DEV_STS, 0)
> >       FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
> >       FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
> >   
> > +typedef struct cxl_type3_dev {
> > +    /* Private */
> > +    PCIDevice parent_obj;
> > +
> > +    /* Properties */
> > +    uint64_t size;
> > +    HostMemoryBackend *hostmem;
> > +
> > +    /* State */
> > +    CXLComponentState cxl_cstate;
> > +    CXLDeviceState cxl_dstate;
> > +} CXLType3Dev;
> > +
> > +#define TYPE_CXL_TYPE3_DEV "cxl-type3"
> > +
> > +#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> > +  
> 
> Ah okay this is an old style initialiser, and new code shouldn't be using them 
> anymore (I believe there should be no remaining instances in git master). Drop the 
> typedef from struct cxl_type3_dev and replace with:
> 
> #define TYPE_CXL_TYPE3_DEV "cxl-type3"
> OBJECT_DECLARE_SIMPLE_TYPE(CXLType3Dev, CXL_TYPE3_DEV))
> 
> Note this will alter the generated QOM CAST from CT3() to CXL_TYPE3_DEV(): I would 
> argue that the _DEV suffix is QOM legacy naming and recommend removing it from both 
> of the above to give you TYPE_CXL_TYPE3 and CXL_TYPE3 respectively.

Code has been around a while and being out of tree this sort of stuff is only
likely to get picked up by reviewers (thanks!)
Now updated to this newer approach - this code mostly went away in patch 20
where a class is introduced, but I've switched to your new suggested naming
and gotten rid of CT3() which was left behind.

Thanks,

Jonathan


