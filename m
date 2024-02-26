Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA112C520
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968805; cv=none; b=rAbT6sLFCYDjPsizAr5AZn6+XNwt8BOJLtm97lM/dJL3/uboRsbtgBLBbeIjSZKD8+R1oGAWNgCzVZEMxCpGfP0oVgRcSRiRzWtcsfIpoPkjZyf9WeyYXq5LOyfB5aodzFtJ6Yz4tRfDUihiSOUyf8gMcc3DoGtxASGDpYQLRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968805; c=relaxed/simple;
	bh=G05yC0uQzmxdAtvfuvguSQltBCY2GXprIaXLw9Edo2c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZffI2ZaCBUYtE7ShJTBQKanCw7fdleeuMVyt4YPy6mqO8IN5JfmMoB7Jsvt01dKLdo193w/aVaf2rFUHQrJGMcOMCAr0JC1QL7RPhF4A0jroN7XuxnY35HdG5PYc9dn9n+IeTrfZa6jRWwkKviDRFN8M9kAE5ephNtORTciTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk6zK098sz6JBTl;
	Tue, 27 Feb 2024 01:28:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C990140B73;
	Tue, 27 Feb 2024 01:33:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 17:33:18 +0000
Date: Mon, 26 Feb 2024 17:33:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240226173317.0000299d@Huawei.com>
In-Reply-To: <20240221182020.1086096-3-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-3-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 10:15:55 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: decode_len of a dc region is aligned to 256*MiB, divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

A few comments inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  16 ++++++
>  2 files changed, 126 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..88e3b733e3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,7 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> +#define CXL_SPEC_AFTER_R30
As below. Drop this.  Kernel code needs to be able to cope with newer specs
than it understands anyway so should be fine with the larger records (otherwise
it's buggy and needs fixing!) 

>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -80,6 +81,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
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
> +    struct get_dyn_cap_config_in_pl {
Type not needed - see below. 
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED;
   } QEMU_PACKED *in;

> +
> +    struct get_dyn_cap_config_out_pl {
Don't think giving this a type is necessary - see below.
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
> +        /*
> +         * if cxl spec version >= 3.1, extra output payload as defined
> +         * in struct get_dyn_cap_config_out_pl_extra comes here.
> +         */
> +    } QEMU_PACKED;
    } QEMU_PACKED *out;
> +
> +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;

We've (mostly) use the (void *) casting where we haven't given the structures
a type.  I think I'd prefer we kept to that style for consistency.

There is an argument we should have given all these types
for readability reasons and to avoid casting via void * but
we have gone this way now - with the exception of
the poison list - oops.   

> +    uint16_t record_count = 0;
> +    uint16_t i;
> +    uint16_t out_pl_len;
> +    uint8_t start_region_id = in->start_region_id;
> +#ifdef CXL_SPEC_AFTER_R30

Handy for testing, but I'd drop the ifdef for the final
version.  We don't need to support old specs.

> +    struct get_dyn_cap_config_out_pl_extra {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED;
> +    struct get_dyn_cap_config_out_pl_extra *extra_out;
As above, anonymous structure should work ok.
> +#endif
> +
> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +#ifdef CXL_SPEC_AFTER_R30
> +    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
> +            out_pl_len);
> +    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
> +#endif
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    out->num_regions = ct3d->dc.num_regions;
> +#ifdef CXL_SPEC_AFTER_R30
> +    out->regions_returned = record_count;
> +#endif
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                ct3d->dc.regions[start_region_id + i].base);
Qemu allows a couple of style choices, but don't think this matches any of them.
https://elixir.bootlin.com/qemu/latest/source/docs/devel/style.rst#L79

My preference is immediately after opening bracket.


> +        stq_le_p(&out->records[i].decode_len,
> +                ct3d->dc.regions[start_region_id + i].decode_len /
> +                CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                ct3d->dc.regions[start_region_id + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                ct3d->dc.regions[start_region_id + i].block_size);
> +        stl_le_p(&out->records[i].dsmadhandle,
> +                ct3d->dc.regions[start_region_id + i].dsmadhandle);
> +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> +    }
> +#ifdef CXL_SPEC_AFTER_R30
> +    /*FIXME: need to set valid values in the future*/

We need to do that before upstreaming..
For tags, 0 is fine for now.

For extents allow say 512 and count how many are in lists
I guess then subtract that.

> +    stq_le_p(&extra_out->num_extents_supported, 0);
> +    stq_le_p(&extra_out->num_extents_available, 0);
> +    stq_le_p(&extra_out->num_tags_supported, 0);
> +    stq_le_p(&extra_out->num_tags_available, 0);
> +#endif
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>  };
>  
> +static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> +    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
> +        cmd_dcd_get_dyn_cap_config, 2, 0 },
> +};
> +
>  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
>      [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
> @@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>  
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set);
> +    if (ct3d->dc.num_regions) {
> +        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
> +    }
>      cci->d = d;
>  
>      /* No separation for PCI MB as protocol handled in PCI device */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3cf3077afa..6df7fecdf1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -422,6 +422,17 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +#define DCD_MAX_REGION_NUM 8
Really trivial but call this 

DCD_MAX_NUM_REGION because it's the maximum number of
regions. The maximum region number is 7 (as zero indexed).

> +
> +typedef struct CXLDCDRegion {
> +    uint64_t base;
Probably makes sense to call out that bas also aligned to 256 MiB
as not immediately clear the comment applies to both.
Easiest will be to duplicate it.
> +    uint64_t decode_len; /* aligned to 256*MiB */
> +    uint64_t len;
> +    uint64_t block_size;
> +    uint32_t dsmadhandle;
> +    uint8_t flags;
> +} CXLDCDRegion;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -454,6 +465,11 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +
> +    struct dynamic_capacity {
> +        uint8_t num_regions; /* 0-8 regions */
> +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> +    } dc;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"

