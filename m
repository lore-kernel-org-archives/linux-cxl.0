Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE41F4617
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492768; cv=none; b=TsUt7rXWtNdXkbUnIjFaIthJSf01ea6Dc06iashotfVU/RT7VRVEmTXc0XluGodQWPGuWZjr184Bn/7+y2ADOrTyQB0Vt8Z3tCnd38ChZldVHvfXzZOrQeOKCTzRiHUKgv4VaIAJmOphSlMXCIeUFLgoawzIAJeXgY7A8i4Dzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492768; c=relaxed/simple;
	bh=2ZX64nz1TfAw6cwrSb1yjBEzw5UWHSD56wT1HVqhmEI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1/OASbu2p6e+MGEjmXVitz1JvcUeVk+9Mn+siEO1Tellu4QMAFom66FTxLzLrsmW8dCunsINcJ/wsjVqVWM+z4SKrJeyVaNx2tf06dwaEvDbM+rvIx/NXPyVZcUATNKP/V8h386pYZFpau592wuzP07KKakZ1GaxcUzb46jvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjtQR292lz6L5dG;
	Thu, 24 Apr 2025 19:04:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D661140146;
	Thu, 24 Apr 2025 19:06:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 13:06:01 +0200
Date: Thu, 24 Apr 2025 12:05:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Message-ID: <20250424120559.00001699@huawei.com>
In-Reply-To: <20250317164204.2299371-7-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-7-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:33 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   2 +-
>  include/hw/cxl/cxl_device.h  |   3 ++
>  include/hw/cxl/cxl_mailbox.h |   6 +++
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4bb51bf3e8..51ead2b152 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -125,6 +125,7 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
> +        #define SET_DC_REGION_CONFIG 0x2
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3494,6 +3495,98 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
> +                                                CXLEventRecordHdr *hdr)
> +{
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length = sizeof(struct CXLEventDynamicCapacity);
> +    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +}
> +
> +/*
> + * CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602)
> + */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in;

= (void *)payload_in;

> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region;
> +
> +    if (ct3d->dc.num_regions == 0) {

As before. I don't think we need to check this.

> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /*
> +     * TODO: Fail with CXL_MBOX_INVALID_SECURITY_STATE if
> +     * device has been locked
> +     */
> +
> +    in = (void *)payload_in;
> +    region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * TODO: Fail if sanitize bit doesn't match current config and "the device
> +     * does not support reconfiguration of the Sanitize on Release setting."
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 1) != (region->flags & 1)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
Maybe need locking if we enable extent creation on a different CCI
to this one.  That's only going to happen in fairly complex setups however..


> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    /* FIXME: for now, validity flag is cleared */
Given we are just saying we don't know how many tags are available that
is presumably valid?

> +    dcEvent.validity_flags = 0;
> +    /* FIXME: Currently only support 1 host */

Not a fixme, a fact of life :)

> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                        CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                        (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3620,6 +3713,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0},
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0},
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},

Space.

>  };
>  
>  /*

> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 8e1c7c5f15..820c411cbb 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -8,6 +8,7 @@
>  #ifndef CXL_MAILBOX_H
>  #define CXL_MAILBOX_H
>  
> +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
>  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -15,6 +16,11 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)

Are there any other commands that need updating to include the
more detailed stuff these flags adds around resets?

>  
>  #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>  #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)

