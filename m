Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4BC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 16:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbiC3Q5J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349092AbiC3Q5G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 12:57:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C538BDE
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 09:55:19 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KTCDg4tGbz67wfM;
        Thu, 31 Mar 2022 00:53:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 30 Mar 2022 18:55:16 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 17:55:15 +0100
Date:   Wed, 30 Mar 2022 17:55:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
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
        Dan Williams <dan.j.williams@intel.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Tong Zhang <t.zhang2@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: [PATCH v8 02/46] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Message-ID: <20220330175514.00000377@huawei.com>
In-Reply-To: <20220328142835.GA51107@bgt-140510-bm01>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-3-Jonathan.Cameron@huawei.com>
        <CGME20220328142843uscas1p231d68ea82ce825a0366392def9906500@uscas1p2.samsung.com>
        <20220328142835.GA51107@bgt-140510-bm01>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Mar 2022 14:28:41 +0000
Adam Manzanares <a.manzanares@samsung.com> wrote:

> On Fri, Mar 18, 2022 at 03:05:51PM +0000, Jonathan Cameron wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > A CXL 2.0 component is any entity in the CXL topology. All components
> > have a analogous function in PCIe. Except for the CXL host bridge, all
> > have a PCIe config space that is accessible via the common PCIe
> > mechanisms. CXL components are enumerated via DVSEC fields in the
> > extended PCIe header space. CXL components will minimally implement some
> > subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
> > 2.0 specification. Two headers and a utility library are introduced to
> > support the minimum functionality needed to enumerate components.
> > 
> > The cxl_pci header manages bits associated with PCI, specifically the
> > DVSEC and related fields. The cxl_component.h variant has data
> > structures and APIs that are useful for drivers implementing any of the
> > CXL 2.0 components. The library takes care of making use of the DVSEC
> > bits and the CXL.[mem|cache] registers. Per spec, the registers are
> > little endian.
> > 
> > None of the mechanisms required to enumerate a CXL capable hostbridge
> > are introduced at this point.
> > 
> > Note that the CXL.mem and CXL.cache registers used are always 4B wide.
> > It's possible in the future that this constraint will not hold.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > ---
> >  hw/Kconfig                     |   1 +
> >  hw/cxl/Kconfig                 |   3 +
> >  hw/cxl/cxl-component-utils.c   | 219 +++++++++++++++++++++++++++++++++
> >  hw/cxl/meson.build             |   4 +
> >  hw/meson.build                 |   1 +
> >  include/hw/cxl/cxl.h           |  16 +++
> >  include/hw/cxl/cxl_component.h | 197 +++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_pci.h       | 135 ++++++++++++++++++++
> >  8 files changed, 576 insertions(+)
> > 

...

> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > new file mode 100644
> > index 0000000000..410f8ef328
> > --- /dev/null
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -0,0 +1,219 @@
> > +/*
> > + * CXL Utility library for components
> > + *
> > + * Copyright(C) 2020 Intel Corporation.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/cxl/cxl.h"
> > +
> > +static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    CXLComponentState *cxl_cstate = opaque;
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +
> > +    if (size == 8) {  
> 
> Is there a define that can be used instead of 8 for clarity?

I can't think of one that would be clearer than the number as we
just checking if it is 8. 
> 
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL 8 byte cache mem registers not implemented\n");
> > +        return 0;
> > +    }
> > +
> > +    if (cregs->special_ops && cregs->special_ops->read) {
> > +        return cregs->special_ops->read(cxl_cstate, offset, size);
> > +    } else {
> > +        return cregs->cache_mem_registers[offset / 4];  
> 
> I think this could benefit from a define as well. 

For this one, we can use offset / sizeof(*cregs->cache_mem_registers)
Bit of a long line but clear that we are indexing into the array.

> 
> > +    }
> > +}
> > +
> > +static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> > +                                    unsigned size)
> > +{
> > +    CXLComponentState *cxl_cstate = opaque;
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +
> > +    if (size == 8) {
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL 8 byte cache mem registers not implemented\n");
> > +        return;
> > +    }
> > +    if (cregs->special_ops && cregs->special_ops->write) {
> > +        cregs->special_ops->write(cxl_cstate, offset, value, size);
> > +    } else {
> > +        cregs->cache_mem_registers[offset / 4] = value;
> > +    }
> > +}  
> 
> See comments for the read reg function they apply here as well. 
> 

...

> > +
> > +void cxl_component_register_block_init(Object *obj,
> > +                                       CXLComponentState *cxl_cstate,
> > +                                       const char *type)
> > +{
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +
> > +    memory_region_init(&cregs->component_registers, obj, type,
> > +                       CXL2_COMPONENT_BLOCK_SIZE);
> > +
> > +    /* io registers controls link which we don't care about in QEMU */
> > +    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
> > +                          CXL2_COMPONENT_IO_REGION_SIZE);
> > +    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
> > +                          ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
> > +
> > +    memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
> > +    memory_region_add_subregion(&cregs->component_registers,
> > +                                CXL2_COMPONENT_IO_REGION_SIZE,
> > +                                &cregs->cache_mem);
> > +}
> > +
> > +static void ras_init_common(uint32_t *reg_state)
> > +{
> > +    reg_state[R_CXL_RAS_UNC_ERR_STATUS] = 0;
> > +    reg_state[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
> > +    reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;  
> 
> Should we add a comment that bits 12-13, 17-31 are reserved for the two 
> previous register states, with all other bits set to 1 by default?

Ok. This one is unusual enough that it's worth calling out he reserved
bits. I'm not sure it's worth stating defaults of other bits though as we will
need a lot of words to explain all the similar spaces.

> 
> > +    reg_state[R_CXL_RAS_COR_ERR_STATUS] = 0;
> > +    reg_state[R_CXL_RAS_COR_ERR_MASK] = 0x3f;  
> 
> I think this is supposed to be 0x7f

Oops. Fixed now.

> 
> > +
> > +    /* CXL switches and devices must set */
> > +    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0;
> > +}
> > +
> > +static void hdm_init_common(uint32_t *reg_state)
> > +{
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> > +                     HDM_DECODER_ENABLE, 0);
> > +}
> > +
> > +void cxl_component_register_init_common(uint32_t *reg_state, enum reg_type type)
> > +{
> > +    int caps = 0;
> > +    switch (type) {
> > +    case CXL2_DOWNSTREAM_PORT:
> > +    case CXL2_DEVICE:
> > +        /* CAP, RAS, Link */  
> 
> Minor nit, could move the CAP comment above the switch statement and provide
> a bit more info. Something like CAP HEADER ARRAY SIZE INITITALIZATION?

This is weird enough (and kind of relies on a coincidence) that I agree more
commentary is needed.  I've introduced it with the following above the switch (type).

    /*
     * In CXL 2.0 the capabilities required for each CXL component are such that,
     * with the ordering chosen here, a single number can be used to define
     * which capabilities should be provided.
     */

and dropped CAP from this first comment.

> 
> > +        caps = 2;
> > +        break;
> > +    case CXL2_UPSTREAM_PORT:
> > +    case CXL2_TYPE3_DEVICE:
> > +    case CXL2_LOGICAL_DEVICE:
> > +        /* + HDM */
> > +        caps = 3;
> > +        break;
> > +    case CXL2_ROOT_PORT:
> > +        /* + Extended Security, + Snoop */
> > +        caps = 5;
> > +        break;
> > +    default:
> > +        abort();
> > +    }
> > +
> > +    memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
> > +
> > +    /* CXL Capability Header Register */
> > +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
> > +
> > +
> > +#define init_cap_reg(reg, id, version)                                        \
> > +    QEMU_BUILD_BUG_ON(CXL_##reg##_REGISTERS_OFFSET == 0);                     \
> > +    do {                                                                      \
> > +        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
> > +        reg_state[which] = FIELD_DP32(reg_state[which],                       \
> > +                                      CXL_##reg##_CAPABILITY_HEADER, ID, id); \
> > +        reg_state[which] =                                                    \
> > +            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER,       \
> > +                       VERSION, version);                                     \
> > +        reg_state[which] =                                                    \
> > +            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER, PTR,  \
> > +                       CXL_##reg##_REGISTERS_OFFSET);                         \
> > +    } while (0)
> > +
> > +    init_cap_reg(RAS, 2, 1);  
> 
> Is the version of the RAS cap header supposed to be 1 here?

Ah CXL 2.0 has this as version 2.  Good spot.

> 
> > +    ras_init_common(reg_state);
> > +
> > +    init_cap_reg(LINK, 4, 2);
> > +
> > +    if (caps < 3) {
> > +        return;
> > +    }
> > +
> > +    init_cap_reg(HDM, 5, 1);
> > +    hdm_init_common(reg_state);
> > +
> > +    if (caps < 5) {
> > +        return;
> > +    }
> > +
> > +    init_cap_reg(EXTSEC, 6, 1);
> > +    init_cap_reg(SNOOP, 8, 1);
> > +
> > +#undef init_cap_reg
> > +}

...


> > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > new file mode 100644
> > index 0000000000..74e9bfe1ff
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_component.h
> > @@ -0,0 +1,197 @@

...

> > +/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
> > +#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
> > +#define CXL_HDM_REGISTERS_OFFSET \
> > +    (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
> > +#define CXL_HDM_REGISTERS_SIZE (0x20 + HDM_DECODE_MAX + 10)  
> 
> Do we need to multiply HDM_DECODE_MAX here, I am under the impression that 
> HDM_DECODE_MAX represents the number of decoders and we need register space
> for each of the possible decoders.

Indeed curious.  We don't currently hit this because the code
only enables a single HDM decoder so far. 

It should be
0x10 + 0x20 * HDM_DECODE_MAX  assuming intent is to leave space for up to 10.

Previously the last few bytes would have spilled into the next cap. As those
are either DPA skip which isn't implemented yet or the top of the target
list (which I never hit as only did 4 way at most at a given decoder).

> 
> > +#define HDM_DECODER_INIT(n)                                                    \
> > +  REG32(CXL_HDM_DECODER##n##_BASE_LO,                                          \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x10)                          \
> > +            FIELD(CXL_HDM_DECODER##n##_BASE_LO, L, 28, 4)                      \
> > +  REG32(CXL_HDM_DECODER##n##_BASE_HI,                                          \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x14)                          \
> > +  REG32(CXL_HDM_DECODER##n##_SIZE_LO,                                          \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x18)                          \
> > +  REG32(CXL_HDM_DECODER##n##_SIZE_HI,                                          \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x1C)                          \
> > +  REG32(CXL_HDM_DECODER##n##_CTRL,                                             \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x20)                          \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, IG, 0, 4)                         \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, IW, 4, 4)                         \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, LOCK_ON_COMMIT, 8, 1)             \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, COMMIT, 9, 1)                     \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
> > +            FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
> > +  REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
> > +  REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
> > +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
> > +
> > +REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
> > +    FIELD(CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT, 0, 4)
> > +    FIELD(CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 4, 4)
> > +    FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
> > +    FIELD(CXL_HDM_DECODER_CAPABILITY, INTELEAVE_4K, 9, 1)
> > +    FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
> > +REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
> > +    FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
> > +    FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
> > +
> > +HDM_DECODER_INIT(0);
> > +

...


> > diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> > new file mode 100644
> > index 0000000000..810a244fab
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_pci.h

...

> > +
> > +/* CXL 2.0 - 8.1.5 (ID 0003) */
> > +struct cxl_dvsec_port_extensions {
> > +    struct dvsec_header hdr;
> > +    uint16_t status;
> > +    uint16_t control;
> > +    uint8_t alt_bus_base;
> > +    uint8_t alt_bus_limit;
> > +    uint16_t alt_memory_base;
> > +    uint16_t alt_memory_limit;
> > +    uint16_t alt_prefetch_base;
> > +    uint16_t alt_prefetch_limit;
> > +    uint32_t alt_prefetch_base_high;
> > +    uint32_t alt_prefetch_base_low;  
> 
> Limit high?
> 

Good spot. Fixed. (this one turned up when I enabled the write masks
for these registers, but I'd failed to push it down into this patch).
  
> 
> +cc (Klaus, Dave, Tong)
> 
> Other than the minor cleanups/nits.
> Looks good.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>

Thanks for taking such a close look!

Jonathan
