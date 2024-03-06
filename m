Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169E1350F2
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738649; cv=none; b=sfNkh6RF56Jo2mcNcJZC0l4NbhL7taCuoO4QSR1xQGQwmFPL3y/8V4ybT5ZiZ2yorsOdZT8cDlBy5rmj0m3RAYp50CKJo4xjGiRZF1wMMH7EYI7UB1GMV5q29JvjR/xDbZYjgzSgkeEZXaxX9elxIlWhEkPGvMh7LmHL+ZLl6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738649; c=relaxed/simple;
	bh=/8uXn9c1Sm53XslH5V2aoayE8Z2j7XSVEfNuDNCn9YM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD1u0LYeZ80Lk2Df5SDnC+p0LeSELrHAq/3q896xzjr0O5l1uEaB3xu8ivIBWP3PE4vJpr/+uJidqolnu2Qa7uPhe2nCKrkbBnbgvGV7hld5S2BEHXd4KZmmjEnHYJWzqo1073z4Fin5MzjHnbpTPKgqjW4xC9acvHV6Lb3LMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqbhk2kyWz6K7F9;
	Wed,  6 Mar 2024 23:20:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CD32D1400DB;
	Wed,  6 Mar 2024 23:24:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:24:03 +0000
Date: Wed, 6 Mar 2024 15:24:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 02/13] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240306152402.0000097c@Huawei.com>
In-Reply-To: <20240304194331.1586191-3-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:33:57 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: we store region decode length as byte-wise length on the device, which
> should be divided by 256 * MiB before being returned to the host
> for "Get Dynamic Capacity Configuration" mailbox command per
> specification.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Really minor nice to have type comments inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 99 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 16 ++++++
>  2 files changed, 115 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..5792010c12 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,8 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> +#define CXL_NUM_EXTENTS_SUPPORTED 512
> +#define CXL_NUM_TAGS_SUPPORTED 0
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -80,6 +82,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1238,6 +1242,91 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
> + * (Opcode: 4800h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct {
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED *in;

If you respin a few line breaks might help on readability.
I'd stick one after each struct.

> +    struct {
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        uint8_t rsvd1[6];
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;
> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out;
    } QEMU_PACKED *out = (void *)payload_out;
(see below)

> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;

> +    uint16_t record_count;
> +    uint16_t i;
> +    uint16_t out_pl_len;
> +    uint8_t start_region_id;
> +
> +    in = (void *)payload_in;
> +    out = (void *)payload_out;

These are a bit uninteresting so could just assign them at the definitions above?


> +    start_region_id = in->start_region_id;

Perhaps something shorter like start_rid for the local variable?

> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
I'd align with just after opening bracket.

> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    extra_out = (void *)(payload_out + out_pl_len);
> +    out_pl_len += sizeof(*extra_out);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[start_region_id + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[start_region_id + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[start_region_id + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[start_region_id + i].block_size);
> +        stl_le_p(&out->records[i].dsmadhandle,
> +                 ct3d->dc.regions[start_region_id + i].dsmadhandle);
> +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> +    }
> +    /*
> +     * TODO: will assign proper values when extents and tags are introduced
> +     * to use.
Drop the to use
	* TODO: Assign values once extents and tags are introduced.

> +     */
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}

