Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B54EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFVP6Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjFVP6Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 11:58:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8B1992
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 08:58:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn4hp5pKYz6J7Z5;
        Thu, 22 Jun 2023 23:55:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 16:58:18 +0100
Date:   Thu, 22 Jun 2023 16:58:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <20230622165817.0000220e@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
        <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023 12:16:28 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Read the Dynamic capacity configuration and store dynamic capacity region
> information in the device state which driver will use to map into the HDM
> ranges.
> 
> Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>

Hi Ira / Navneet,

I'll probably overlap with comments of others (good to see so much review!)
so feel free to ignore duplication.

Comments inline,

Jonathan



> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + * information from the device.
> + * @mds: The memory device state
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the get_dynamic_capacity command to the device
> + * and on success populate structures to be exported to sysfs.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = cxlds->dev;
> +	struct cxl_mbox_dynamic_capacity *dc;

Calling it dc is confusing.  I'd make it clear this is the mailbox
response. config_resp or dc_config_res.

> +	struct cxl_mbox_get_dc_config get_dc;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 next_dc_region_start;
> +	int rc, i;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		sprintf(mds->dc_region[i].name, "dc%d", i);
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> +		return 0;
> +	}
> +
> +	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc)
> +		return -ENOMEM;

Response to CXL_MBOX_OP_GET_DC_CONFIG has a known maximum
size. Can we provide that instead of potentially much larger?

8 + 0x28 * 8 I think so 328 bytes. Use struct_size()


But fun corner.... Mailbox is allowed to be smaller than that (256 bytes min
I think) so need to handle multiple reads with different start regions.
Which reminds me that we need to add support for running out of space
in the mailbox to qemu... So far we've just made sure everything fitted :)


> +
> +	get_dc = (struct cxl_mbox_get_dc_config) {
> +		.region_count = CXL_MAX_DC_REGION,
> +		.start_region_index = 0,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto dc_error;
The error label is a bit too generic.  Why dc_error?
"error" conveys just as small amount of info.  I'd got for goto free_resp;

> +
> +	mds->nr_dc_region = dc->avail_region_count;
> +
> +	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +			mds->nr_dc_region);
> +		rc = -EINVAL;
> +		goto dc_error;
> +	}
> +
> +	for (i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		dcr->base = le64_to_cpu(dc->region[i].region_base);
> +		dcr->decode_len =
> +			le64_to_cpu(dc->region[i].region_decode_length);
> +		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> +		dcr->len = le64_to_cpu(dc->region[i].region_length);
> +		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
> +
> +		/* Check regions are in increasing DPA order */
> +		if ((i + 1) < mds->nr_dc_region) {

Feels a bit odd to look at entries we haven't seen yet.  Maybe flip this around
to check the ones we have looked at?  So don't start until 2nd region and then check
it's start against mds->dc_region[0] etc?
Or factor out this loop contents in general and just pass in the single
value needed for checking this. Biggest advantage being direct returns in
that function as allocation and free will be in caller.


> +			next_dc_region_start =
> +				le64_to_cpu(dc->region[i + 1].region_base);
> +			if ((dcr->base > next_dc_region_start) ||
> +			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {

Unless you have a negative decode length the second condition includes the first.
So just check that.

> +				dev_err(dev,
> +					"DPA ordering violation for DC region %d and %d\n",
> +					i, i + 1);
> +				rc = -EINVAL;
> +				goto dc_error;
> +			}
> +		}
> +
> +		/* Check the region is 256 MB aligned */
> +		if (!IS_ALIGNED(dcr->base, SZ_256M)) {

That's an oddity. I wonder why those lower bits where defined as reserved...
Anyhow code is right if paranoid ;)

> +			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		/* Check Region base and length are aligned to block size */
> +		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> +		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
> +				dcr->blk_size);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		dcr->dsmad_handle =
> +			le32_to_cpu(dc->region[i].region_dsmad_handle);
> +		dcr->flags = dc->region[i].flags;

I'd just grab these at same time as all the other fields above.
A pattern where you fill values in only after checking would be fine, or one
where you fill them in all in one place. The mixture of the two is less clear
than either consistent approach.

> +		sprintf(dcr->name, "dc%d", i);
> +
> +		dev_dbg(dev,
> +			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> +			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +	}
> +
> +	/*
> +	 * Calculate entire DPA range of all configured regions which will be mapped by
> +	 * one or more HDM decoders
> +	 */
> +	mds->total_dynamic_capacity =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> +		mds->total_dynamic_capacity);
> +
> +dc_error:
> +	kvfree(dc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +



> @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  	}
>  
>  	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> +
> +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	if (mds->partition_align_bytes == 0) {
>  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
>  				 mds->volatile_only_bytes, "ram");
>  		if (rc)
>  			return rc;
> +

Scrub for this stuff before posting v2. Just noise that slows down review
a little.  If it is worth doing, do it in a separate patch.

>  		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
>  				   mds->volatile_only_bytes,
>  				   mds->persistent_only_bytes, "pmem");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 89e560ea14c0..9c0b2fa72bdd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
>
>  
> +#define CXL_MAX_DC_REGION 8
> +#define CXL_DC_REGION_SRTLEN 8

SRT? 

> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -300,6 +312,8 @@ enum cxl_devtype {
>   * @dpa_res: Overall DPA resource tree for the device
>   * @pmem_res: Active Persistent memory capacity configuration
>   * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> + *          region
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> @@ -315,6 +329,7 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct resource pmem_res;
>  	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  	enum cxl_devtype type;

...

> @@ -357,9 +379,13 @@ struct cxl_memdev_state {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -	u64 total_bytes;
> +
> +	u64 total_capacity;
> +	u64 total_static_capacity;
> +	u64 total_dynamic_capacity;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -367,6 +393,20 @@ struct cxl_memdev_state {
>  	u64 active_persistent_bytes;
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +
> +	struct cxl_dc_region_info {
> +		u8 name[CXL_DC_REGION_SRTLEN];

char? SRT?  Also isn't it a bit big? Looks like max 4 chars to me.
Put it next to flags and we can save some space.

> +		u64 base;
> +		u64 decode_len;
> +		u64 len;
> +		u64 blk_size;
> +		u32 dsmad_handle;
> +		u8 flags;
> +	} dc_region[CXL_MAX_DC_REGION];
> +
> +	size_t dc_event_log_size;

>  /*
> @@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
>  	u8 flags;
>  } __packed;
>  
> +struct cxl_mbox_get_dc_config {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_dynamic_capacity {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)

This looks to have merged oddly with existing changes. I'd
move the define into the structure definition so ti's clear which
flag it reflects and avoids this sort of interleaving in future.

> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
>  


