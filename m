Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D4C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9745164FFA
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 11:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCLLxL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:53:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2688 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhCLLwk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Mar 2021 06:52:40 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DxkbH3VC6z67yCj;
        Fri, 12 Mar 2021 19:48:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 12:52:38 +0100
Received: from localhost (10.47.81.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 11:52:37 +0000
Date:   Fri, 12 Mar 2021 11:51:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <mst@redhat.com>, <vishal.l.verma@intel.com>,
        <tyshao@avery-design.com.tw>, <hchkuo@avery-design.com.tw>
Subject: Re: [RFC PATCH v3 cxl-2.0-doe 2/2] CXL DOE support for CDAT and
 Compliance Mode
Message-ID: <20210312115123.000078e4@Huawei.com>
In-Reply-To: <1615323876-17716-1-git-send-email-cbrowy@avery-design.com>
References: <1615322029-13038-1-git-send-email-cbrowy@avery-design.com>
        <1615323876-17716-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.238]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 9 Mar 2021 16:04:36 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

Hi Chris,

As for patch 1, description needed here.  Let's move this series towards
the form needed for a final submission.

2 features, 2 patches...  If nothing else makes each one small enough to be
suitable for review with morning coffee :)


> ---
>  hw/cxl/cxl-component-utils.c   |  93 ++++++++++++
>  hw/mem/cxl_type3.c             | 184 ++++++++++++++++++++++++
>  include/hw/cxl/cxl_cdat.h      | 127 +++++++++++++++++
>  include/hw/cxl/cxl_compl.h     | 252 +++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_component.h |  74 ++++++++++
>  include/hw/cxl/cxl_device.h    |   4 +
>  include/hw/cxl/cxl_pci.h       |   2 +
>  7 files changed, 736 insertions(+)
>  create mode 100644 include/hw/cxl/cxl_cdat.h
>  create mode 100644 include/hw/cxl/cxl_compl.h
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 41d36f802a..1a2408dc76 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c

...

> +void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
> +{
> +    uint8_t sum = 0;
> +    int i, curr = 0, ent = 0;
> +    CDATStruct cdat_st[1024];
> +    struct cdat_sub_header hdr;
> +    FILE *fp;
> +    uint8_t iasl_hdr[IASL_HEADER_LEN];
> +    size_t rcount;
> +
> +    fp = fopen(cxl_cstate->cdat_filename, "r");
> +
> +    if (fp) {
> +        /* Read iASL header */
> +        rcount= fread(&iasl_hdr, sizeof(iasl_hdr), 1, fp);
> +	if (rcount == 0)
> +            error_setg(errp, "File read failed");
> +	    
> +
> +        for (i = 0; i < IASL_HEADER_LEN; i++) {
> +            sum += iasl_hdr[i];
> +        }
> +        sum = (~sum + 1) & 0xFF;
> +
> +        curr = ftell(fp);
> +
> +        /* Read CDAT structures */
> +        while (fread(&hdr, sizeof(hdr), 1, fp)) {
> +            cdat_len_check(&hdr, errp);
> +
> +            cdat_st[ent].base2 = curr;
> +            cdat_st[ent].length = hdr.length;
> +            ent++;
> +
> +            fseek(fp, curr + hdr.length, SEEK_SET);
> +            curr = ftell(fp);
> +        }
> +        /* Check the last structure */
> +        fseek(fp, 0, SEEK_END);
> +        assert(curr == ftell(fp));
> +    } else {
> +        error_setg(errp, "Please specify the CDAT file by using ',cdat='");

It definitely wants to be optional.  Fine to not provide one.
I'd hope we can generate one that makes 'sense' for whatever memory etc
is configured though and have that as the fallback if one isn't provided.
That will be a lot more convenient if people are working on other aspects
of support and don't happen to care about exactly what is in CDAT on
a given day.

> +    }
> +    cxl_cstate->cdat_file = fp;
> +
> +    cxl_cstate->cdat_ent_len = ent;
> +    cxl_cstate->cdat_ent = g_malloc0(sizeof(CDATStruct) * ent);
> +    memcpy(cxl_cstate->cdat_ent, cdat_st, sizeof(CDATStruct) * ent);
> +
> +    /* Set CDAT header, ent = 0 */
> +    cxl_cstate->cdat_header.revision = CXL_CDAT_REV;
> +    cxl_cstate->cdat_header.sequence = 0;
> +    cxl_cstate->cdat_header.length += curr + sizeof(cxl_cstate->cdat_header);
> +
> +    sum += cxl_cstate->cdat_header.revision +
> +           cxl_cstate->cdat_header.sequence + cxl_cstate->cdat_header.length;
> +
> +    cxl_cstate->cdat_header.checksum = ~sum + 1;
> +}
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index bf33ddb915..33f571e1a5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -13,6 +13,156 @@
>  #include "qemu/rcu.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/cxl/cxl.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +
> +uint32_t cxl_doe_compliance_init(DOECap *doe_cap)
> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->pdev)->cxl_cstate;
> +    uint32_t req;
> +    uint32_t byte_cnt = 0;
> +
> +    DOE_DBG(">> %s\n",  __func__);
> +
> +    req = ((struct cxl_compliance_mode_cap *)pcie_doe_get_req(doe_cap))
> +        ->req_header.req_code;
> +    switch (req) {
> +    case CXL_COMP_MODE_CAP:
> +        byte_cnt = sizeof(struct cxl_compliance_mode_cap_rsp);
> +        cxl_cstate->doe_resp.cap_rsp.header.vendor_id = CXL_VENDOR_ID;
> +        cxl_cstate->doe_resp.cap_rsp.header.doe_type = CXL_DOE_COMPLIANCE;
> +        cxl_cstate->doe_resp.cap_rsp.header.reserved = 0x0;
> +        cxl_cstate->doe_resp.cap_rsp.header.length =
> +            DIV_ROUND_UP(sizeof(struct cxl_compliance_mode_cap_rsp), 4);
> +        cxl_cstate->doe_resp.cap_rsp.rsp_header.rsp_code = 0x0;
> +        cxl_cstate->doe_resp.cap_rsp.rsp_header.version = 0x1;
> +        cxl_cstate->doe_resp.cap_rsp.rsp_header.length = 0x1c;
> +        cxl_cstate->doe_resp.cap_rsp.status = 0x0;
> +        cxl_cstate->doe_resp.cap_rsp.available_cap_bitmask = 0x3;
> +        cxl_cstate->doe_resp.cap_rsp.enabled_cap_bitmask = 0x3;
> +        break;
> +    case CXL_COMP_MODE_STATUS:
> +        byte_cnt = sizeof(struct cxl_compliance_mode_status_rsp);
> +        cxl_cstate->doe_resp.status_rsp.header.vendor_id = CXL_VENDOR_ID;
> +        cxl_cstate->doe_resp.status_rsp.header.doe_type = CXL_DOE_COMPLIANCE;
> +        cxl_cstate->doe_resp.status_rsp.header.reserved = 0x0;
> +        cxl_cstate->doe_resp.status_rsp.header.length =
> +            DIV_ROUND_UP(sizeof(struct cxl_compliance_mode_status_rsp), 4);
> +        cxl_cstate->doe_resp.status_rsp.rsp_header.rsp_code = 0x1;
> +        cxl_cstate->doe_resp.status_rsp.rsp_header.version = 0x1;
> +        cxl_cstate->doe_resp.status_rsp.rsp_header.length = 0x14;
> +        cxl_cstate->doe_resp.status_rsp.cap_bitfield = 0x3;
> +        cxl_cstate->doe_resp.status_rsp.cache_size = 0;
> +        cxl_cstate->doe_resp.status_rsp.cache_size_units = 0;
> +        break;

Given there are only two types in reality.  Can we get rid of all the others
in the big union?  Right now it looks like those aren't handled, but reality
is they are the same as the ones here.


> +    default:
> +        break;
> +    }
> +
> +    DOE_DBG("  REQ=%x, RSP BYTE_CNT=%d\n", req, byte_cnt);
> +    DOE_DBG("<< %s\n",  __func__);
> +    return byte_cnt;
> +}
> +
> +
> +bool cxl_doe_compliance_rsp(DOECap *doe_cap)
> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->pdev)->cxl_cstate;
> +    uint32_t byte_cnt;
> +    uint32_t dw_cnt;
> +
> +    DOE_DBG(">> %s\n",  __func__);
> +
> +    byte_cnt = cxl_doe_compliance_init(doe_cap);
> +    dw_cnt = byte_cnt / 4;
> +    memcpy(doe_cap->read_mbox,
> +           cxl_cstate->doe_resp.data_byte, byte_cnt);
> +
> +    doe_cap->read_mbox_len += dw_cnt;
> +
> +    DOE_DBG("  LEN=%x, RD MBOX[%d]=%x\n", dw_cnt - 1,
> +            doe_cap->read_mbox_len,
> +            *(doe_cap->read_mbox + dw_cnt - 1));
> +
> +    DOE_DBG("<< %s\n",  __func__);
> +
> +    return true;
> +}
> +
> +bool cxl_doe_cdat_rsp(DOECap *doe_cap)
> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->pdev)->cxl_cstate;
> +    uint16_t ent;
> +    uint32_t base = 0;
> +    uint32_t len = 0 ;
> +    size_t rcount;
> +    struct cxl_cdat *req = pcie_doe_get_req(doe_cap);
> +
> +    ent = req->entry_handle;
> +    if (ent == 0) {
> +        len = sizeof(cxl_cstate->cdat_header);
> +    } else if (ent <= cxl_cstate->cdat_ent_len) {
> +        base = cxl_cstate->cdat_ent[ent - 1].base2;
> +        len = cxl_cstate->cdat_ent[ent - 1].length;
> +    }
> +
> +    struct cxl_cdat_rsp rsp = {
> +        .header = {
> +            .vendor_id = CXL_VENDOR_ID,
> +            .doe_type = CXL_DOE_TABLE_ACCESS,
> +            .reserved = 0x0,
> +            .length = (sizeof(struct cxl_cdat_rsp) + len) / 4,
> +        },
> +        .req_code = CXL_DOE_TAB_RSP,
> +        .table_type = CXL_DOE_TAB_TYPE_CDAT,
> +        .entry_handle = (ent < cxl_cstate->cdat_ent_len) ? ent + 1 : CXL_DOE_TAB_ENT_MAX,
> +    };
> +
> +    memcpy(doe_cap->read_mbox, &rsp, sizeof(rsp));
> +
> +    if (ent == 0) {
> +        memcpy(doe_cap->read_mbox + sizeof(rsp) / 4,
> +               &cxl_cstate->cdat_header, len);
> +    } else if (ent <= cxl_cstate->cdat_ent_len) {
> +        fseek(cxl_cstate->cdat_file, base, SEEK_SET);
> +        rcount= fread(doe_cap->read_mbox + sizeof(rsp) / 4, len, 1, cxl_cstate->cdat_file);
> +	if (rcount == 0)
> +	    DOE_DBG("fread returned 0\n");
> +    }
> +
> +    doe_cap->read_mbox_len += rsp.header.length;
> +    DOE_DBG("%s: INCR RD_MBOX OFF=%x\n", __func__, doe_cap->read_mbox_len);
> +
> +    for (int i = 0; i < doe_cap->read_mbox_len; i++) {
> +        DOE_DBG("  RD_MBOX[%d]=%08x\n", i, doe_cap->read_mbox[i]);
> +    }

It's trivial to sanity check this isn't broken by just doing the read, so
I'd drop the debug now you have it working.

> +
> +    return true;
> +}
> +


>  
>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
> @@ -134,6 +284,8 @@ static void ct3_finalize(Object *obj)
>  
>      g_free((void *)regs->special_ops);
>      g_free(ct3d->cxl_dstate.pmem);
> +
> +    fclose(cxl_cstate->cdat_file);

cdat will be small, perhaps we just read it in once and cache it?
That lets us not keep the file handle around or the file open once we have read it.

>  }
>  
>  static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> @@ -203,6 +355,19 @@ static MemoryRegion *cxl_md_get_memory_region(MemoryDeviceState *md,
>      return ct3d->cxl_dstate.pmem;
>  }
>  
> +static DOEProtocol doe_comp_prot[] = {
> +    {PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_cma_rsp},
> +    {CXL_VENDOR_ID, CXL_DOE_COMPLIANCE, cxl_doe_compliance_rsp},
> +    {CXL_VENDOR_ID, CXL_DOE_TABLE_ACCESS, cxl_doe_cdat_rsp},

This is kind of useful for exercising software paths, but I'm not sure
why any real hardware would do this.

Generic software is likely to stop at the first DOE that supports what
it wants, so it'll never reach the CDAT only one.

> +    { /* End of array */ },
> +};
> +
> +static DOEProtocol doe_cdat_prot[] = {
> +    {PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_cma_rsp},

Not allowed to do that according to CMA ECN.

> +    {CXL_VENDOR_ID, CXL_DOE_TABLE_ACCESS, cxl_doe_cdat_rsp},
> +    { /* End of array */ },
> +};
> +
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      CXLType3Dev *ct3d = CT3(pci_dev);
> @@ -210,6 +375,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> +    unsigned short msix_num = 2;
> +    int i;
>  
>      if (!ct3d->cxl_dstate.pmem) {
>          cxl_setup_memory(ct3d, errp);
> @@ -239,6 +406,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                           PCI_BASE_ADDRESS_MEM_TYPE_64,
>                       &ct3d->cxl_dstate.device_registers);
> +
> +    /* MSI(-X) Initailization */
> +    msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    for (i = 0; i < msix_num; i++) {
> +        msix_vector_use(pci_dev, i);
> +    }
> +    /* msi_init(pci_dev, 0x60, 16, true, false, NULL); */
> +
> +    /* DOE Initailization */
> +    pcie_doe_init(pci_dev, &ct3d->doe_comp, 0x160, doe_comp_prot, true, 0);
> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 1);
> +
> +    cxl_doe_cdat_init(cxl_cstate, errp);
>  }
>  
>  static uint64_t cxl_md_get_addr(const MemoryDeviceState *md)
> @@ -275,6 +455,7 @@ static Property ct3_props[] = {
>                       HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> +    DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat_filename),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -357,6 +538,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
>      MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
> +
> +    pc->config_write = ct3d_config_write;
> +    pc->config_read = ct3d_config_read;
>      CXLType3Class *cvc = CXL_TYPE3_DEV_CLASS(oc);
>  
>      pc->realize = ct3_realize;
> diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
> new file mode 100644
> index 0000000000..edd994d410
> --- /dev/null
> +++ b/include/hw/cxl/cxl_cdat.h
> @@ -0,0 +1,127 @@

...

> +
> +/* Read Entry Request, 8.1.11.1 Table 134 */
> +struct cxl_cdat {
> +    DOEHeader header;
> +    uint8_t req_code;
> +    uint8_t table_type;
> +    uint16_t entry_handle;
> +} QEMU_PACKED;
> +
> +/* Read Entry Response, 8.1.11.1 Table 135 */
> +#define cxl_cdat_rsp    cxl_cdat    /* Same as request */

The header is the same as the request, but lots of data that this
is implying doesn't exist.  Also it doesn't have a request code
so at very least just make that field code in the structure.


> +
> +/*
> + * CDAT Table Structure (CDAT Spec)
> + */
> +#define CXL_CDAT_REV 1
> +
> +/* Data object header */
> +struct cdat_table_header {
> +    uint32_t length;    /* Length of table in bytes, including this header */
> +    uint8_t revision;   /* ACPI Specification minor version number */

No.  CDAT specification revision number. This isn't an ACPI table.

> +    uint8_t checksum;   /* To make sum of entire table == 0 */
> +    uint8_t reserved[6];
> +    uint32_t sequence;  /* ASCII table signature */

Not what the sequence number is at all.


> +} QEMU_PACKED;
> +


...

> +#endif /* CXL_CDAT_H */
> diff --git a/include/hw/cxl/cxl_compl.h b/include/hw/cxl/cxl_compl.h
> new file mode 100644
> index 0000000000..5edeaa5f27
> --- /dev/null
> +++ b/include/hw/cxl/cxl_compl.h
> @@ -0,0 +1,252 @@
> +/*
> + * CXL Compliance Structure
> + *
> + * Copyright (C) 2020 Avery Design Systems, Inc.

Time for an update to include 2021.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */

...

> +
> +struct status_rsp {
> +    DOEHeader header;
> +    CompRspHeader rsp_header;
> +    uint8_t status;
> +} QEMU_PACKED;
> +
> +struct len_rsvd_rsp {

Prefix these so they don't look like generic things.
Also for this one, the naming made me wonder if CXL really had defined
a length field then marked it reserved (which would be odd). 
I would go with two versions of the header and name this differently.

struct compliance_rsp_header_no_len {
    uint8_t rsp_code;
    uint8_t version;
} QEMU_PACKED;

struct comp_no_data_resp {
   DOEHeader header;
   struct compliance_rsp_header_no_len resp_header; /* typedefs if you like are fine */
   uint8_t reserved[6];
} QEMU_PACKED;

> +    DOEHeader header;
> +    /* The length field in rsp_header is reserved. */
> +    CompRspHeader rsp_header;
> +    uint8_t reserved[5];
> +} QEMU_PACKED;
> +
...

> +
> +/* 14.16.4.10 */
> +struct cxl_compliance_mode_toggle_cache_flush {
> +    DOEHeader header;
> +    CompReqHeader req_header;
> +    uint8_t inj_flow_control;

?

> +} QEMU_PACKED;
> +
> +#define cxl_compliance_mode_toggle_cache_flush_rsp status_rsp
> +

...

> +
> +#endif /* CXL_COMPL_H */
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index acc0730d96..1294d74d78 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -18,6 +18,7 @@
>  #include "qemu/range.h"
>  #include "qemu/typedefs.h"
>  #include "hw/register.h"
> +#include "qapi/error.h"
>  
>  enum reg_type {
>      CXL2_DEVICE,
> @@ -160,6 +161,11 @@ typedef struct component_registers {
>      MemoryRegionOps *special_ops;
>  } ComponentRegisters;
>  
> +typedef struct cdat_struct {
> +    void *base;
> +    uint32_t base2;

Given base vs base2 isn't obvious naming, add some comments or
give it a more meaningful name.

> +    uint32_t length;
> +} CDATStruct;
>  /*
>   * A CXL component represents all entities in a CXL hierarchy. This includes,
>   * host bridges, root ports, upstream/downstream switch ports, and devices
> @@ -173,6 +179,70 @@ typedef struct cxl_component {
>              struct PCIDevice *pdev;
>          };
>      };
> +
> +    /*
> +     * SW write write mailbox and GO on last DW
> +     * device sets READY of offset DW in DO types to copy
> +     * to read mailbox register on subsequent cfg_read
> +     * of read mailbox register and then on cfg_write to
> +     * denote success read increments offset to next DW
> +     */

Comment doesn't seem to have anything to do with any code around here, so drop it.

> +
> +    union doe_request_u {
> +        /* Compliance DOE Data Objects Type=0*/
Space before */
> +        struct cxl_compliance_mode_cap mode_cap;
> +        struct cxl_compliance_mode_status mode_status;
> +        struct cxl_compliance_mode_halt mode_halt;
> +        struct cxl_compliance_mode_multiple_write_streaming
> +            multiple_write_streaming;
> +        struct cxl_compliance_mode_producer_consumer producer_consumer;
> +        struct cxl_compliance_mode_inject_bogus_writes inject_bogus_writes;
> +        struct cxl_compliance_mode_inject_poison inject_poison;
> +        struct cxl_compliance_mode_inject_crc inject_crc;
> +        struct cxl_compliance_mode_inject_flow_control inject_flow_control;
> +        struct cxl_compliance_mode_toggle_cache_flush toggle_cache_flush;
> +        struct cxl_compliance_mode_inject_mac_delay inject_mac_delay;
> +        struct cxl_compliance_mode_insert_unexp_mac insert_unexp_mac;
> +        struct cxl_compliance_mode_inject_viral inject_viral;
> +        struct cxl_compliance_mode_inject_almp inject_almp;
> +        struct cxl_compliance_mode_ignore_almp ignore_almp;
> +        struct cxl_compliance_mode_inject_bit_error ignore_bit_error;
> +        char data_byte[128];

We aren't accessing this as a byte anywhere, so just use a pointer
to the whole structure.  That will avoid padding this to a meaningless
length. (closer inspection this one isn't even referenced, but resp below is)

> +    } doe_request;
> +
> +    union doe_resp_u {
> +        /* Compliance DOE Data Objects Type=0*/

Space before */

> +        struct cxl_compliance_mode_cap_rsp cap_rsp;

I wonder if we can make this all shorter by using an abbreviation?

cxl_cmpl_mode_stat_rsp

and similar?

It's nice to match spec names where possible, but sometimes they just
end up as stupidly long/

> +        struct cxl_compliance_mode_status_rsp status_rsp;
> +        struct cxl_compliance_mode_halt_rsp halt_rsp;
> +        struct cxl_compliance_mode_multiple_write_streaming_rsp
> +            multiple_write_streaming_rsp;
> +        struct cxl_compliance_mode_producer_consumer_rsp producer_consumer_rsp;
> +        struct cxl_compliance_mode_inject_bogus_writes_rsp
> +            inject_bogus_writes_rsp;
> +        struct cxl_compliance_mode_inject_poison_rsp inject_poison_rsp;
> +        struct cxl_compliance_mode_inject_crc_rsp inject_crc_rsp;
> +        struct cxl_compliance_mode_inject_flow_control_rsp
> +            inject_flow_control_rsp;
> +        struct cxl_compliance_mode_toggle_cache_flush_rsp
> +            toggle_cache_flush_rsp;
> +        struct cxl_compliance_mode_inject_mac_delay_rsp inject_mac_delay_rsp;
> +        struct cxl_compliance_mode_insert_unexp_mac_rsp insert_unexp_mac_rsp;
> +        struct cxl_compliance_mode_inject_viral inject_viral_rsp;
> +        struct cxl_compliance_mode_inject_almp_rsp inject_almp_rsp;
> +        struct cxl_compliance_mode_ignore_almp_rsp ignore_almp_rsp;
> +        struct cxl_compliance_mode_inject_bit_error_rsp ignore_bit_error_rsp;
> +        char data_byte[520 * 4];

As above, I can't see a reason to have this.  If individual structures can be
variable length, put the maximums in them, not here.

> +    } doe_resp;
> +
> +    /* Table entry types */
> +    struct cdat_table_header cdat_header;
> +
> +    CDATStruct *cdat_ent;
> +    int cdat_ent_len;
> +
> +    char *cdat_filename;
> +    FILE *cdat_file;
>  } CXLComponentState;
>  
>  void cxl_component_register_block_init(Object *obj,
> @@ -184,4 +254,8 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>  void cxl_component_create_dvsec(CXLComponentState *cxl_cstate, uint16_t length,
>                                  uint16_t type, uint8_t rev, uint8_t *body);
>  
> +uint32_t cxl_doe_compliance_init(DOECap *doe_cap);
> +bool cxl_doe_compliance_rsp(DOECap *doe_cap);
> +void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
> +bool cxl_doe_cdat_rsp(DOECap *doe_cap);
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 057c5b85c6..de006ff463 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -236,6 +236,10 @@ typedef struct cxl_type3_dev {
>      /* State */
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
> +
> +    /* DOE */
> +    DOECap doe_comp;
> +    DOECap doe_cdat;
>  } CXLType3Dev;
>  
>  #ifndef TYPE_CXL_TYPE3_DEV
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index e8235b10cc..a0df324a1f 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -12,6 +12,8 @@
>  
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pcie.h"
> +#include "hw/cxl/cxl_cdat.h"
> +#include "hw/cxl/cxl_compl.h"
>  
>  #define CXL_VENDOR_ID 0x1e98
>  

