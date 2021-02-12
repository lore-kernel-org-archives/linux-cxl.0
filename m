Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA18C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Feb 2021 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3355664E95
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Feb 2021 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBLRZM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:25:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2564 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBLRZD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Feb 2021 12:25:03 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcgDL0wgKz67nKb;
        Sat, 13 Feb 2021 01:17:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 18:24:20 +0100
Received: from localhost (10.47.28.230) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 17:24:19 +0000
Date:   Fri, 12 Feb 2021 17:23:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>
Subject: Re: [RFC v2 2/2] Basic CXL DOE for CDAT and Compliance Mode
Message-ID: <20210212172317.00003c1d@Huawei.com>
In-Reply-To: <1612902963-10071-1-git-send-email-cbrowy@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
        <1612902963-10071-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.28.230]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 9 Feb 2021 15:36:03 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

Split this into two patches for v3.  CDAT in one, compliance mode in the other.

I'd also move the actual elements out into the cxl components so that we
can register only what makes sense for a given device.   My guess
is that for now that will be static const anyway.

Coming together fine. Hopefully I'll start poking at the linux side of things
next week.  First job being simply providing a file to allow us to dump
the whole CDAT table.  Let me know if you get this loading an .aml file
in the meantime as that'll make it easier to test (if not I'll hack it
on top of these patches)

If needed I'll add it to iASL as well (may well be already in hand!)

I think my version of this stuff did a useful job in improving my understanding
of what we were trying to do, but that done I'm assuming we'll just abandon it
as the disposable prototype it was :)

Jonathan


> ---
>  hw/cxl/cxl-component-utils.c   | 132 +++++++++++++++++++
>  hw/mem/cxl_type3.c             | 172 ++++++++++++++++++++++++
>  include/hw/cxl/cxl_cdat.h      | 120 +++++++++++++++++
>  include/hw/cxl/cxl_compl.h     | 289 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_component.h | 126 ++++++++++++++++++
>  include/hw/cxl/cxl_device.h    |   3 +
>  include/hw/cxl/cxl_pci.h       |   4 +
>  7 files changed, 846 insertions(+)
>  create mode 100644 include/hw/cxl/cxl_cdat.h
>  create mode 100644 include/hw/cxl/cxl_compl.h
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index e1bcee5..fc6c538 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -195,3 +195,135 @@ void cxl_component_create_dvsec(CXLComponentState *cxl, uint16_t length,
>      range_init_nofail(&cxl->dvsecs[type], cxl->dvsec_offset, length);
>      cxl->dvsec_offset += length;
>  }
> +
> +/* Return the sum of bytes */
> +static void cdat_ent_init(CDATStruct *cs, void *base, uint32_t len)
> +{
> +    cs->base = base;
> +    cs->length = len;
> +}
> +
> +void cxl_doe_cdat_init(CXLComponentState *cxl_cstate)
> +{
> +    uint8_t sum = 0;
> +    uint32_t len = 0;
> +    int i, j;
> +
> +    cxl_cstate->cdat_ent_len = 7;
> +    cxl_cstate->cdat_ent =
> +        g_malloc0(sizeof(CDATStruct) * cxl_cstate->cdat_ent_len);
> +
> +    cdat_ent_init(&cxl_cstate->cdat_ent[0],
> +                  &cxl_cstate->cdat_header, sizeof(cxl_cstate->cdat_header));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[1],
> +                  &cxl_cstate->dsmas, sizeof(cxl_cstate->dsmas));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[2],
> +                  &cxl_cstate->dslbis, sizeof(cxl_cstate->dslbis));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[3],
> +                  &cxl_cstate->dsmscis, sizeof(cxl_cstate->dsmscis));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[4],
> +                  &cxl_cstate->dsis, sizeof(cxl_cstate->dsis));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[5],
> +                  &cxl_cstate->dsemts, sizeof(cxl_cstate->dsemts));
> +    cdat_ent_init(&cxl_cstate->cdat_ent[6],
> +                  &cxl_cstate->sslbis, sizeof(cxl_cstate->sslbis));
> +
> +    /* Set the DSMAS entry, ent = 1 */
> +    cxl_cstate->dsmas.header.type = CDAT_TYPE_DSMAS;
> +    cxl_cstate->dsmas.header.reserved = 0x0;
> +    cxl_cstate->dsmas.header.length = sizeof(cxl_cstate->dsmas);
> +    cxl_cstate->dsmas.DSMADhandle = 0x0;
> +    cxl_cstate->dsmas.flags = 0x0;
> +    cxl_cstate->dsmas.reserved2 = 0x0;
> +    cxl_cstate->dsmas.DPA_base = 0x0;
> +    cxl_cstate->dsmas.DPA_length = 0x40000;

Look to move the instances of these down into the memory device and expose
cdat_ent_init() to there.

That way, we can add whatever elements make sense for each type
of component.

Also have a cdat_ents_finalize() or similar to call at the end
which calculates overall length + checksum.

Should also be easy enough to add a simple bit of code to call
cdat_ent_init() for each element of a passed in CDAT.aml file.

> +
> +    /* Set the DSLBIS entry, ent = 2 */
> +    cxl_cstate->dslbis.header.type = CDAT_TYPE_DSLBIS;
> +    cxl_cstate->dslbis.header.reserved = 0;
> +    cxl_cstate->dslbis.header.length = sizeof(cxl_cstate->dslbis);
> +    cxl_cstate->dslbis.handle = 0;
> +    cxl_cstate->dslbis.flags = 0;
> +    cxl_cstate->dslbis.data_type = 0;
> +    cxl_cstate->dslbis.reserved2 = 0;
> +    cxl_cstate->dslbis.entry_base_unit = 0;
> +    cxl_cstate->dslbis.entry[0] = 0;
> +    cxl_cstate->dslbis.entry[1] = 0;
> +    cxl_cstate->dslbis.entry[2] = 0;
> +    cxl_cstate->dslbis.reserved3 = 0;
> +
> +    /* Set the DSMSCIS entry, ent = 3 */
> +    cxl_cstate->dsmscis.header.type = CDAT_TYPE_DSMSCIS;
> +    cxl_cstate->dsmscis.header.reserved = 0;
> +    cxl_cstate->dsmscis.header.length = sizeof(cxl_cstate->dsmscis);
> +    cxl_cstate->dsmscis.DSMASH_handle = 0;
> +    cxl_cstate->dsmscis.reserved2[0] = 0;
> +    cxl_cstate->dsmscis.reserved2[1] = 0;
> +    cxl_cstate->dsmscis.reserved2[2] = 0;
> +    cxl_cstate->dsmscis.memory_side_cache_size = 0;
> +    cxl_cstate->dsmscis.cache_attributes = 0;
> +
> +    /* Set the DSIS entry, ent = 4 */
> +    cxl_cstate->dsis.header.type = CDAT_TYPE_DSIS;
> +    cxl_cstate->dsis.header.reserved = 0;
> +    cxl_cstate->dsis.header.length = sizeof(cxl_cstate->dsis);
> +    cxl_cstate->dsis.flags = 0;
> +    cxl_cstate->dsis.handle = 0;
> +    cxl_cstate->dsis.reserved2 = 0;
> +
> +    /* Set the DSEMTS entry, ent = 5 */
> +    cxl_cstate->dsemts.header.type = CDAT_TYPE_DSEMTS;
> +    cxl_cstate->dsemts.header.reserved = 0;
> +    cxl_cstate->dsemts.header.length = sizeof(cxl_cstate->dsemts);
> +    cxl_cstate->dsemts.DSMAS_handle = 0;
> +    cxl_cstate->dsemts.EFI_memory_type_attr = 0;
> +    cxl_cstate->dsemts.reserved2 = 0;
> +    cxl_cstate->dsemts.DPA_offset = 0;
> +    cxl_cstate->dsemts.DPA_length = 0;
> +
> +    /* Set the SSLBIS entry, ent = 6 */
> +    cxl_cstate->sslbis.sslbis_h.header.type = CDAT_TYPE_SSLBIS;
> +    cxl_cstate->sslbis.sslbis_h.header.reserved = 0;
> +    cxl_cstate->sslbis.sslbis_h.header.length = sizeof(cxl_cstate->sslbis);
> +    cxl_cstate->sslbis.sslbis_h.data_type = 0;
> +    cxl_cstate->sslbis.sslbis_h.reserved2[0] = 0;
> +    cxl_cstate->sslbis.sslbis_h.reserved2[1] = 0;
> +    cxl_cstate->sslbis.sslbis_h.reserved2[2] = 0;
> +    /* Set the SSLBE entry */
> +    cxl_cstate->sslbis.sslbe[0].port_x_id = 0;
> +    cxl_cstate->sslbis.sslbe[0].port_y_id = 0;
> +    cxl_cstate->sslbis.sslbe[0].latency_bandwidth = 0;
> +    cxl_cstate->sslbis.sslbe[0].reserved = 0;
> +    /* Set the SSLBE entry */
> +    cxl_cstate->sslbis.sslbe[1].port_x_id = 1;
> +    cxl_cstate->sslbis.sslbe[1].port_y_id = 1;
> +    cxl_cstate->sslbis.sslbe[1].latency_bandwidth = 0;
> +    cxl_cstate->sslbis.sslbe[1].reserved = 0;
> +    /* Set the SSLBE entry */
> +    cxl_cstate->sslbis.sslbe[2].port_x_id = 2;
> +    cxl_cstate->sslbis.sslbe[2].port_y_id = 2;
> +    cxl_cstate->sslbis.sslbe[2].latency_bandwidth = 0;
> +    cxl_cstate->sslbis.sslbe[2].reserved = 0;
> +
> +    /* Set CDAT header, ent = 0 */
> +    cxl_cstate->cdat_header.revision = CXL_CDAT_REV;
> +    cxl_cstate->cdat_header.reserved[0] = 0;
> +    cxl_cstate->cdat_header.reserved[1] = 0;
> +    cxl_cstate->cdat_header.reserved[2] = 0;
> +    cxl_cstate->cdat_header.reserved[3] = 0;
> +    cxl_cstate->cdat_header.reserved[4] = 0;
> +    cxl_cstate->cdat_header.reserved[5] = 0;
> +    cxl_cstate->cdat_header.sequence = 0;
> +
> +    for (i = cxl_cstate->cdat_ent_len - 1; i >= 0; i--) {
> +        /* Add length of each CDAT struct to total length */
> +        len = cxl_cstate->cdat_ent[i].length;
> +        cxl_cstate->cdat_header.length += len;
> +
> +        /* Calculate checksum of each CDAT struct */
> +        for (j = 0; j < len; j++) {
> +            sum += *(uint8_t *)(cxl_cstate->cdat_ent[i].base + j);
> +        }
> +    }
> +    cxl_cstate->cdat_header.checksum = ~sum + 1;
> +}
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d091e64..86c762f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -13,6 +13,150 @@
>  #include "qemu/rcu.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/cxl/cxl.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +
> +uint32_t cxl_doe_compliance_init(DOECap *doe_cap)
local to file, static and remove from header.
> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->doe->pdev)->cxl_cstate;
> +    uint32_t req;
> +    uint32_t byte_cnt = 0;
> +
> +    DOE_DBG(">> %s\n",  __func__);
> +
> +    req = ((struct cxl_compliance_mode_cap *)pcie_doe_get_req(doe_cap))
> +        ->req_code;
> +    switch (req) {
> +    case CXL_COMP_MODE_CAP:
> +        byte_cnt = sizeof(struct cxl_compliance_mode_cap_rsp);

Use a local variable to cap_rsp or assign it via a structure here.
Basically get rid of the repitition of
cxl_cstate->doe_resp.cap_rsp
in the interests of readability.


> +        cxl_cstate->doe_resp.cap_rsp.header.vendor_id = CXL_VENDOR_ID;
> +        cxl_cstate->doe_resp.cap_rsp.header.doe_type = CXL_DOE_COMPLIANCE;
> +        cxl_cstate->doe_resp.cap_rsp.header.reserved = 0x0;
> +        cxl_cstate->doe_resp.cap_rsp.header.length =
> +            dwsizeof(struct cxl_compliance_mode_cap_rsp);
> +        cxl_cstate->doe_resp.cap_rsp.rsp_code = 0x0;
> +        cxl_cstate->doe_resp.cap_rsp.version = 0x1;
> +        cxl_cstate->doe_resp.cap_rsp.length = 0x1c;
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
> +            dwsizeof(struct cxl_compliance_mode_status_rsp);
> +        cxl_cstate->doe_resp.status_rsp.rsp_code = 0x1;
> +        cxl_cstate->doe_resp.status_rsp.version = 0x1;
> +        cxl_cstate->doe_resp.status_rsp.length = 0x14;
> +        cxl_cstate->doe_resp.status_rsp.cap_bitfield = 0x3;
> +        cxl_cstate->doe_resp.status_rsp.cache_size = 0;
> +        cxl_cstate->doe_resp.status_rsp.cache_size_units = 0;
> +        break;
> +    default:

I guess the intent at somepoint is to actually hook some of these up?

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

Currently this is local to this file, so drop it form the header and
mark it static.  

> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->doe->pdev)->cxl_cstate;
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
> +    return DOE_SUCCESS;
> +}
> +
> +bool cxl_doe_cdat_rsp(DOECap *doe_cap)
Local to this file I think so drop it from header and mark it static.

> +{
> +    CXLComponentState *cxl_cstate = &CT3(doe_cap->doe->pdev)->cxl_cstate;
> +    uint16_t ent;
> +    void *base;
> +    uint32_t len;
> +    struct cxl_cdat *req = pcie_doe_get_req(doe_cap);
> +
> +    ent = req->entry_handle;
> +    base = cxl_cstate->cdat_ent[ent].base;
> +    len = cxl_cstate->cdat_ent[ent].length;
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
> +        .entry_handle = (++ent < cxl_cstate->cdat_ent_len) ? ent : CXL_DOE_TAB_ENT_MAX,
> +    };
> +
> +    memcpy(doe_cap->read_mbox, &rsp, sizeof(rsp));
> +    memcpy(doe_cap->read_mbox + sizeof(rsp) / 4, base, len);
> +
> +    doe_cap->read_mbox_len += rsp.header.length;
> +    DOE_DBG("  read_mbox_len=%x\n", doe_cap->read_mbox_len);
> +
> +    for (int i = 0; i < doe_cap->read_mbox_len; i++) {
> +        DOE_DBG("  RD MBOX[%d]=%08x\n", i, doe_cap->read_mbox[i]);
> +    }
> +
> +    return DOE_SUCCESS;
> +}
> +
> +static uint32_t ct3d_config_read(PCIDevice *pci_dev,
> +                            uint32_t addr, int size)
> +{
> +    CXLType3Dev *ct3d = CT3(pci_dev);
> +    PCIEDOE *doe = &ct3d->doe;
> +    DOECap *doe_cap;
> +
> +    doe_cap = pcie_doe_covers_addr(doe, addr);
> +    if (doe_cap) {
> +        DOE_DBG(">> %s addr=%x, size=%x\n", __func__, addr, size);
> +        return pcie_doe_read_config(doe_cap, addr, size);
> +    } else {
> +        return pci_default_read_config(pci_dev, addr, size);
> +    }
> +}
> +
> +static void ct3d_config_write(PCIDevice *pci_dev,
> +                            uint32_t addr, uint32_t val, int size)
> +{
> +    CXLType3Dev *ct3d = CT3(pci_dev);
> +    PCIEDOE *doe = &ct3d->doe;
> +    DOECap *doe_cap;
> +
> +    doe_cap = pcie_doe_covers_addr(doe, addr);
> +    if (doe_cap) {
> +        DOE_DBG(">> %s addr=%x, val=%x, size=%x\n", __func__, addr, val, size);
> +        pcie_doe_write_config(doe_cap, addr, val, size);
> +    } else {
> +        pci_default_write_config(pci_dev, addr, val, size);
> +    }
> +}
>  
>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
> @@ -210,6 +354,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> +    unsigned short msix_num = 2;
> +    int rc;
> +    int i;
>  
>      if (!ct3d->cxl_dstate.pmem) {
>          cxl_setup_memory(ct3d, errp);
> @@ -239,6 +386,28 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                           PCI_BASE_ADDRESS_MEM_TYPE_64,
>                       &ct3d->cxl_dstate.device_registers);
> +
> +    msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    for (i = 0; i < msix_num; i++) {
> +        msix_vector_use(pci_dev, i);
> +    }
> +
> +    /* msi_init(pci_dev, 0x60, 16, true, false, NULL); */

Tidy this up or parameterize it.

> +
> +    pcie_doe_init(pci_dev, &ct3d->doe);
> +    rc = pcie_cap_doe_add(&ct3d->doe, 0x160, true, 0);

check rc here.

> +    rc = pcie_cap_doe_add(&ct3d->doe, 0x190, true, 1);
> +    if (rc) {
> +        error_setg(errp, "fail to add DOE cap");
> +        return;
> +    }
> +
> +    pcie_doe_register_protocol(&ct3d->doe, CXL_VENDOR_ID, CXL_DOE_COMPLIANCE,
> +                               cxl_doe_compliance_rsp);
> +    pcie_doe_register_protocol(&ct3d->doe, CXL_VENDOR_ID, CXL_DOE_TABLE_ACCESS,
> +                               cxl_doe_cdat_rsp);
> +
> +    cxl_doe_cdat_init(cxl_cstate);
>  }
>  
>  static uint64_t cxl_md_get_addr(const MemoryDeviceState *md)
> @@ -357,6 +526,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
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
> index 0000000..fbbd494
> --- /dev/null
> +++ b/include/hw/cxl/cxl_cdat.h
> @@ -0,0 +1,120 @@
> +#include "hw/cxl/cxl_pci.h"
> +
> +
> +enum {
> +    CXL_DOE_COMPLIANCE             = 0,
> +    CXL_DOE_TABLE_ACCESS           = 2,
> +    CXL_DOE_MAX_PROTOCOL
> +};
> +
> +#define CXL_DOE_PROTOCOL_COMPLIANCE ((CXL_DOE_COMPLIANCE << 16) | CXL_VENDOR_ID)
> +#define CXL_DOE_PROTOCOL_CDAT     ((CXL_DOE_TABLE_ACCESS << 16) | CXL_VENDOR_ID)
> +
> +/*
> + * DOE CDAT Table Protocol (CXL Spec)
> + */
> +#define CXL_DOE_TAB_REQ 0
> +#define CXL_DOE_TAB_RSP 0
> +#define CXL_DOE_TAB_TYPE_CDAT 0
> +#define CXL_DOE_TAB_ENT_MAX 0xFFFF
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
> +
... Note I'm just snipping out these big defines as I check them
against the spec :) Hence the gap.
...

> +struct cdat_dsmscis {
> +    struct cdat_sub_header header;
> +    uint8_t DSMASH_handle;

DMSAS_handle;

> +    uint8_t reserved2[3];
> +    uint64_t memory_side_cache_size;
> +    uint32_t cache_attributes;
> +} QEMU_PACKED;
> +


> +
> +struct cdat_sslbis_header {
> +    struct cdat_sub_header header;
> +    uint8_t data_type;
> +    uint8_t reserved2[3];
> +    uint64_t entry_base_unit;
> +} QEMU_PACKED;
> diff --git a/include/hw/cxl/cxl_compl.h b/include/hw/cxl/cxl_compl.h
> new file mode 100644
> index 0000000..ebbe488
> --- /dev/null
> +++ b/include/hw/cxl/cxl_compl.h
> @@ -0,0 +1,289 @@
> +/*
> + * CXL Compliance Mode Protocol

Needs license etc I think

> + */

A bunch of the responses below are all of this form, perhaps we
could just have one cxl_compliance_mode_generic_status_rsp ?
if you really want to then define the others perhaps use
#define to do it rather than lots of identical structures
each specified fully.


> +struct cxl_compliance_mode_inject_mac_delay_rsp {
> +    DOEHeader header;
> +    uint8_t rsp_code;
> +    uint8_t version;
> +    uint8_t length;
> +    uint8_t status;
> +} QEMU_PACKED;
> +



> +struct cxl_compliance_mode_ignore_bit_error {
> +    DOEHeader header;
> +    uint8_t req_code;
> +    uint8_t version;
> +    uint16_t reserved;
> +    uint8_t opcode;
> +} QEMU_PACKED;
> +
This last one doesn't seem to line up with the CXL 2.0 spec.

> +struct cxl_compliance_mode_ignore_bit_error_rsp {
> +    DOEHeader header;
> +    uint8_t rsp_code;
> +    uint8_t version;
> +    uint8_t reserved[6];
> +} QEMU_PACKED;


> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 762feb5..23923df 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -132,6 +132,23 @@ HDM_DECODER_INIT(0);
>  _Static_assert((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) < 0x1000,
>                 "No space for registers");

...

>  typedef struct component_registers {
>      /*
>       * Main memory region to be registered with QEMU core.
> @@ -160,6 +177,10 @@ typedef struct component_registers {
>      MemoryRegionOps *special_ops;
>  } ComponentRegisters;
>  
> +typedef struct cdat_struct {
> +    void *base;
> +    uint32_t length;
> +} CDATStruct;
>  /*
>   * A CXL component represents all entities in a CXL hierarchy. This includes,
>   * host bridges, root ports, upstream/downstream switch ports, and devices
> @@ -173,6 +194,104 @@ typedef struct cxl_component {
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
> +
> +    union doe_request_u {
> +        /* Compliance DOE Data Objects Type=0*/
> +        struct cxl_compliance_mode_cap
> +            mode_cap;

I'd only add line breaks for the longer ones of these.

> +        struct cxl_compliance_mode_status
> +            mode_status;
> +        struct cxl_compliance_mode_halt
> +            mode_halt;
> +        struct cxl_compliance_mode_multiple_write_streaming
> +            multiple_write_streaming;
> +        struct cxl_compliance_mode_producer_consumer
> +            producer_consumer;
> +        struct cxl_compliance_mode_inject_bogus_writes
> +            inject_bogus_writes;
> +        struct cxl_compliance_mode_inject_poison
> +            inject_poison;
> +        struct cxl_compliance_mode_inject_crc
> +            inject_crc;
> +        struct cxl_compliance_mode_inject_flow_control
> +            inject_flow_control;
> +        struct cxl_compliance_mode_toggle_cache_flush
> +            toggle_cache_flush;
> +        struct cxl_compliance_mode_inject_mac_delay
> +            inject_mac_delay;
> +        struct cxl_compliance_mode_insert_unexp_mac
> +            insert_unexp_mac;
> +        struct cxl_compliance_mode_inject_viral
> +            inject_viral;
> +        struct cxl_compliance_mode_inject_almp
> +            inject_almp;
> +        struct cxl_compliance_mode_ignore_almp
> +            ignore_almp;
> +        struct cxl_compliance_mode_ignore_bit_error
> +            ignore_bit_error;
> +        char data_byte[128];
> +    } doe_request;
> +
> +    union doe_resp_u {
> +        /* Compliance DOE Data Objects Type=0*/
> +        struct cxl_compliance_mode_cap_rsp
> +            cap_rsp;
> +        struct cxl_compliance_mode_status_rsp
> +            status_rsp;
> +        struct cxl_compliance_mode_halt_rsp
> +            halt_rsp;
> +        struct cxl_compliance_mode_multiple_write_streaming_rsp
> +            multiple_write_streaming_rsp;
> +        struct cxl_compliance_mode_producer_consumer_rsp
> +            producer_consumer_rsp;
> +        struct cxl_compliance_mode_inject_bogus_writes_rsp
> +            inject_bogus_writes_rsp;
> +        struct cxl_compliance_mode_inject_poison_rsp
> +            inject_poison_rsp;
> +        struct cxl_compliance_mode_inject_crc_rsp
> +            inject_crc_rsp;
> +        struct cxl_compliance_mode_inject_flow_control_rsp
> +            inject_flow_control_rsp;
> +        struct cxl_compliance_mode_toggle_cache_flush_rsp
> +            toggle_cache_flush_rsp;
> +        struct cxl_compliance_mode_inject_mac_delay_rsp
> +            inject_mac_delay_rsp;
> +        struct cxl_compliance_mode_insert_unexp_mac_rsp
> +            insert_unexp_mac_rsp;
> +        struct cxl_compliance_mode_inject_viral
> +            inject_viral_rsp;
> +        struct cxl_compliance_mode_inject_almp_rsp
> +            inject_almp_rsp;
> +        struct cxl_compliance_mode_ignore_almp_rsp
> +            ignore_almp_rsp;
> +        struct cxl_compliance_mode_ignore_bit_error_rsp
> +            ignore_bit_error_rsp;
> +        char data_byte[520 * 4];
> +        uint32_t data_dword[520];
> +    } doe_resp;
> +
> +    /* Table entry types */
Hmm. Not sure all CXL components will have CDAT.  Root ports for
example?

> +    struct cdat_table_header cdat_header;
> +    struct cdat_dsmas dsmas;
> +    struct cdat_dslbis dslbis;

As I said in v1, some of these will need to be multiples so this
flat structure just doesn't work.

> +    struct cdat_dsmscis dsmscis;
> +    struct cdat_dsis dsis;
> +    struct cdat_dsemts dsemts;
> +    struct {
> +        struct cdat_sslbis_header sslbis_h;
> +        struct cdat_sslbe sslbe[3];

I'm curious.  Why 3?  This is between pairs of ports so 1USP 2DSP switch?

> +    } sslbis;


> +
> +    CDATStruct *cdat_ent;
> +    int cdat_ent_len;
>  } CXLComponentState;
>  
>  void cxl_component_register_block_init(Object *obj,
> @@ -184,4 +303,11 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>  void cxl_component_create_dvsec(CXLComponentState *cxl_cstate, uint16_t length,
>                                  uint16_t type, uint8_t rev, uint8_t *body);
>  
> +void cxl_component_create_doe(CXLComponentState *cxl_cstate,
> +                              uint16_t offset, unsigned vec);

Doesn't seem to exist.

Some of the following are local to one file so shouldn't be here iether.

> +uint32_t cxl_doe_compliance_init(DOECap *doe_cap);
> +bool cxl_doe_compliance_rsp(DOECap *doe_cap);
> +void cxl_doe_cdat_init(CXLComponentState *cxl_cstate);
> +bool cxl_doe_cdat_rsp(DOECap *doe_cap);
> +uint32_t cdat_zero_checksum(uint32_t *mbox, uint32_t dw_cnt);

Doesn't seem to exist.

>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c608ced..08bf646 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -223,6 +223,9 @@ typedef struct cxl_type3_dev {
>      /* State */
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
> +
> +    /* DOE */
> +    PCIEDOE doe;
>  } CXLType3Dev;
>  
>  #ifndef TYPE_CXL_TYPE3_DEV
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index 9ec28c9..5cab197 100644
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
> @@ -54,6 +56,8 @@ struct dvsec_header {
>  _Static_assert(sizeof(struct dvsec_header) == 10,
>                 "dvsec header size incorrect");
>  
> +/* CXL 2.0 - 8.1.11 */
> +

Clean this out next time - doesn't belong in this patch.

>  /*
>   * CXL 2.0 devices must implement certain DVSEC IDs, and can [optionally]
>   * implement others.

