Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E0EC433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2305E64E15
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 17:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhBKRMl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:12:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2551 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBKRKb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Feb 2021 12:10:31 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dc2y43pbmz67lsC;
        Fri, 12 Feb 2021 01:03:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 18:09:47 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 17:09:46 +0000
Date:   Thu, 11 Feb 2021 17:08:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Da?= =?ISO-8859-1?Q?ud=E9?= 
        <f4bug@amsat.org>, Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 02/31] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Message-ID: <20210211170845.0000451d@Huawei.com>
In-Reply-To: <20210202005948.241655-3-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 1 Feb 2021 16:59:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> A CXL 2.0 component is any entity in the CXL topology. All components
> have a analogous function in PCIe. Except for the CXL host bridge, all
> have a PCIe config space that is accessible via the common PCIe
> mechanisms. CXL components are enumerated via DVSEC fields in the
> extended PCIe header space. CXL components will minimally implement some
> subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
> 2.0 specification. Two headers and a utility library are introduced to
> support the minimum functionality needed to enumerate components.
> 
> The cxl_pci header manages bits associated with PCI, specifically the
> DVSEC and related fields. The cxl_component.h variant has data
> structures and APIs that are useful for drivers implementing any of the
> CXL 2.0 components. The library takes care of making use of the DVSEC
> bits and the CXL.[mem|cache] registers. Per spec, the registers are
> little endian.
> 
> None of the mechanisms required to enumerate a CXL capable hostbridge
> are introduced at this point.
> 
> Note that the CXL.mem and CXL.cache registers used are always 4B wide.
> It's possible in the future that this constraint will not hold.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
A few additions to previous comments.

> ---
>  MAINTAINERS                    |   6 +
>  hw/Kconfig                     |   1 +
>  hw/cxl/Kconfig                 |   3 +
>  hw/cxl/cxl-component-utils.c   | 208 +++++++++++++++++++++++++++++++++
>  hw/cxl/meson.build             |   3 +
>  hw/meson.build                 |   1 +
>  include/hw/cxl/cxl.h           |  17 +++
>  include/hw/cxl/cxl_component.h | 187 +++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_pci.h       | 138 ++++++++++++++++++++++
>  9 files changed, 564 insertions(+)
>  create mode 100644 hw/cxl/Kconfig
>  create mode 100644 hw/cxl/cxl-component-utils.c
>  create mode 100644 hw/cxl/meson.build
>  create mode 100644 include/hw/cxl/cxl.h
>  create mode 100644 include/hw/cxl/cxl_component.h
>  create mode 100644 include/hw/cxl/cxl_pci.h
> 


> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> new file mode 100644
> index 0000000000..8d56ad5c7d
> --- /dev/null
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -0,0 +1,208 @@
> +/*
> + * CXL Utility library for components
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/pci/pci.h"
> +#include "hw/cxl/cxl.h"
> +
> +static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> +                                       unsigned size)
> +{
> +    CXLComponentState *cxl_cstate = opaque;
> +    ComponentRegisters *cregs = &cxl_cstate->crb;
> +
> +    assert(size == 4);
> +
> +    if (cregs->special_ops && cregs->special_ops->read) {
> +        return cregs->special_ops->read(cxl_cstate, offset, size);
> +    } else {
> +        return cregs->cache_mem_registers[offset / 4];
> +    }
> +}
> +
> +static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> +                                    unsigned size)
> +{
> +    CXLComponentState *cxl_cstate = opaque;
> +    ComponentRegisters *cregs = &cxl_cstate->crb;
> +
> +    assert(size == 4);
> +
> +    if (cregs->special_ops && cregs->special_ops->write) {
> +        cregs->special_ops->write(cxl_cstate, offset, value, size);
> +    } else {
> +        cregs->cache_mem_registers[offset / 4] = value;
> +    }
> +}
> +
> +/*
> + * 8.2.3
> + *   The access restrictions specified in Section 8.2.2 also apply to CXL 2.0
> + *   Component Registers.
> + *
> + * 8.2.2
> + *   • A 32 bit register shall be accessed as a 4 Bytes quantity. Partial
> + *   reads are not permitted.
> + *   • A 64 bit register shall be accessed as a 8 Bytes quantity. Partial
> + *   reads are not permitted.
> + *
> + * As of the spec defined today, only 4 byte registers exist.

The exciting exception to this is the RAS header log which is
defined as 512 bits.  Will seek clarification but I think the spec should
probably say that is a set of 32 bit registers.

A bunch of the other elements that we probably want to block in plausible
values for also seem to use 64 bit registers.

> + */
> +static const MemoryRegionOps cache_mem_ops = {
> +    .read = cxl_cache_mem_read_reg,
> +    .write = cxl_cache_mem_write_reg,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +

..
> +
> +void cxl_component_register_init_common(uint32_t *reg_state, enum reg_type type)
> +{
> +    int caps = 0;
> +    switch (type) {
> +    case CXL2_DOWNSTREAM_PORT:
> +    case CXL2_DEVICE:
> +        /* CAP, RAS, Link */
> +        caps = 2;
> +        break;
> +    case CXL2_UPSTREAM_PORT:
> +    case CXL2_TYPE3_DEVICE:
> +    case CXL2_LOGICAL_DEVICE:
> +        /* + HDM */
> +        caps = 3;
> +        break;
> +    case CXL2_ROOT_PORT:
> +        /* + Extended Security, + Snoop */
> +        caps = 5;
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    memset(reg_state, 0, 0x1000);
> +
> +    /* CXL Capability Header Register */
> +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
> +
> +
> +#define init_cap_reg(reg, id, version)                                        \
> +    _Static_assert(CXL_##reg##_REGISTERS_OFFSET != 0, "Invalid cap offset\n");\
> +    do {                                                                      \
> +        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
> +        reg_state[which] = FIELD_DP32(reg_state[which],                       \
> +                                      CXL_##reg##_CAPABILITY_HEADER, ID, id); \
> +        reg_state[which] =                                                    \
> +            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER,       \
> +                       VERSION, version);                                     \
> +        reg_state[which] =                                                    \
> +            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER, PTR,  \
> +                       CXL_##reg##_REGISTERS_OFFSET);                         \
> +    } while (0)

Seems like this would be cleaner using ARRAY_FIELD_DP32 as you did for the header.

    #define init_cap_reg(reg, id, version)                                        \
        _Static_assert(CXL_##reg##_REGISTERS_OFFSET != 0, "Invalid cap offset\n");\
        do {                                                                    \
            ARRAY_FIELD_DP32(reg_state, CXL_##reg##_CAPABILITY_HEADER, ID, id); \
            ARRAY_FIELD_DP32(reg_state, CXL_##reg##_CAPABILITY_HEADER,          \
                             VERSION, version);                                 \
            ARRAY_FIELD_DP32(reg_state, CXL_##reg##_CAPABILITY_HEADER,          \
                             PTR, CXL_##reg##_REGISTRS_OFFSET);                 \
	} while (0)
I think gives the same result.

> +
> +    init_cap_reg(RAS, 2, 1);
> +    ras_init_common(reg_state);
> +
> +    init_cap_reg(LINK, 4, 2);

Feels like we'll want to block some values for the rest of these to at least
ensure whatever is read isn't crazy.

> +
> +    if (caps < 3) {
> +        return;
> +    }
> +
> +    init_cap_reg(HDM, 5, 1);
> +    hdm_init_common(reg_state);
> +
> +    if (caps < 5) {
> +        return;
> +    }
> +
> +    init_cap_reg(EXTSEC, 6, 1);
> +    init_cap_reg(SNOOP, 8, 1);
> +
> +#undef init_cap_reg
> +}
> +
> +/*
> + * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
> + * for tracking the valid offset.
> + *
> + * This function will build the DVSEC header on behalf of the caller and then
> + * copy in the remaining data for the vendor specific bits.
> + */
> +void cxl_component_create_dvsec(CXLComponentState *cxl, uint16_t length,
> +                                uint16_t type, uint8_t rev, uint8_t *body)
> +{
> +    PCIDevice *pdev = cxl->pdev;
> +    uint16_t offset = cxl->dvsec_offset;
> +
> +    assert(offset >= PCI_CFG_SPACE_SIZE &&
> +           ((offset + length) < PCI_CFG_SPACE_EXP_SIZE));
> +    assert((length & 0xf000) == 0);
> +    assert((rev & ~0xf) == 0);
> +
> +    /* Create the DVSEC in the MCFG space */
> +    pcie_add_capability(pdev, PCI_EXT_CAP_ID_DVSEC, 1, offset, length);
> +    pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
> +                 (length << 20) | (rev << 16) | CXL_VENDOR_ID);
> +    pci_set_word(pdev->config + offset + PCIE_DVSEC_ID_OFFSET, type);
> +    memcpy(pdev->config + offset + sizeof(struct dvsec_header),
> +           body + sizeof(struct dvsec_header),
> +           length - sizeof(struct dvsec_header));
> +
> +    /* Update state for future DVSEC additions */
> +    range_init_nofail(&cxl->dvsecs[type], cxl->dvsec_offset, length);
> +    cxl->dvsec_offset += length;
> +}
...

