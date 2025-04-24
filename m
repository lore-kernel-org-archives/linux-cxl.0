Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F324F510
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492028; cv=none; b=kYZIiX6LrlyvExY97OXW7wkToRmtYAhjLx3FehYhoWFWsxiwFGfhgJ7IOalcX0txvXMpphr7NyLX8LSzOHUevytokaMpDWF2GxgVIaS9ugc9YbzcOpz0FXcDbNIOfk8RBTOUpxjtxGeWRXB+doFeBCbLMwyaT1contXZQLJdfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492028; c=relaxed/simple;
	bh=892mnBgsufhZTpg7TuRVdai1V3/mKlllXurJovu8H/4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIB7anqIiK4sqpn0y7jWp3TzwczO8p7ji3dSpE7rATG+edbE7kjk2CzE1nZK1APwnf5PpJb1wyXbnkNS/+mzkhr2E7XoIkmvYKHUK9ku4jT/1spXvGqqyXzLlM77s4ACc+ira2VkWDC+ej4BcPDeL7DlRpTJaQldbuJWacTPuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjt5R5Sgxz6M4Qg;
	Thu, 24 Apr 2025 18:49:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E48D1400DB;
	Thu, 24 Apr 2025 18:53:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:53:38 +0200
Date: Thu, 24 Apr 2025 11:53:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 4/9] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region
 Config
Message-ID: <20250424115337.00006768@huawei.com>
In-Reply-To: <20250317164204.2299371-5-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-5-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:31 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Hi Anisa,

Just a few trivial things in here.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 97 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e9991fd1a7..4bb51bf3e8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -124,6 +124,7 @@ enum {
>          #define GET_MHD_INFO 0x0
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
> +        #define GET_HOST_DC_REGION_CONFIG 0x1
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3399,6 +3400,100 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h)
> + */
> +static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t region_cnt;
> +        uint8_t start_rid;
> +    } QEMU_PACKED *in;

= (void *)payload_in;

> +    struct {
> +        uint16_t host_id;
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint8_t dsmas_flags;
> +            uint8_t rsvd1[3];
> +            uint8_t sanitize;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out;

= (void *)payload_out;

> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint16_t record_count, out_pl_len, i;
> +    uint8_t start_rid;
> +
> +    if (ct3d->dc.num_regions == 0) {

As in earlier patch - we don't register these commands
at all unless num_regions > 0 so probably don't need this
check.

> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    in = (void *)payload_in;
> +    if (in->start_rid >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    start_rid = in->start_rid;

The saving in characters for having the local variable doesn't seem
worthwhile to me.  I'd just in->start_rid where ever you need it.

> +    record_count = MIN(ct3d->dc.num_regions - start_rid, in->region_cnt);
> +
> +    out = (void *)payload_out;
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    extra_out = (void *)(out) + out_pl_len;

Do we need the brackets around out?

> +    out_pl_len += sizeof(*extra_out);
> +
> +    assert(*len_out <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    /* TODO: For now, fix host id to be 0 */
> +    stw_le_p(&out->host_id, 0);
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[start_rid + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[start_rid + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[start_rid + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[start_rid + i].block_size);
> +        out->records[i].dsmas_flags =
> +            ct3d->dc.regions[start_rid + i].dsmas_flags;

As in previous patch. I'd build this here from specific booleans
as the relationship to the dmsas flags isn't defined that tightly.


> +        out->records[i].sanitize = 0;
> +    }
> +    /*
> +     * TODO: Assign values once extents and tags are introduced
> +     * to use.
> +     */
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
> +             ct3d->dc.total_extent_count);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3523,6 +3618,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>  static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>      [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
>          cmd_fm_get_dcd_info, 0, 0},
> +    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
> +        cmd_fm_get_host_dc_region_config, 4, 0},
Space before }

Check for any other instances of this in the rest of the series.

>  };
>  
>  /*

