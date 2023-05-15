Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C820C77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 14:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjEOOJY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEOOJX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 10:09:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D13172B
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 07:09:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKh2t73htz6J72P;
        Mon, 15 May 2023 22:05:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 15:09:18 +0100
Date:   Mon, 15 May 2023 15:09:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [RFC 4/7] hw/mem/cxl_type3: Add DC extent representative to cxl
 type3 device
Message-ID: <20230515150917.000038ef@Huawei.com>
In-Reply-To: <20230511175609.2091136-5-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530@uscas1p2.samsung.com>
        <20230511175609.2091136-5-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Add dynamic capacity extent information to the definition of
> CXLType3Dev and add get DC extent list mailbox command based on
> CXL.spec.3.0:.8.2.9.8.9.2.
> 
> With this command, we can create dc regions as below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x30000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x30000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

A few comments inline,

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h | 23 ++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 61c77e52d8..ed2ac154cb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -83,6 +83,7 @@ enum {
>          #define CLEAR_POISON           0x2
>  	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
>  		#define GET_DC_REGION_CONFIG   0x0
> +		#define GET_DYN_CAP_EXT_LIST   0x1
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -938,7 +939,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>  }
>  
>  /*
> - * cxl spec 3.0: 8.2.9.8.9.2
> + * cxl spec 3.0: 8.2.9.8.9.1

Push that back to earlier patch.

>   * Get Dynamic Capacity Configuration
>   **/
>  static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
> @@ -1001,6 +1002,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
>  	return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.2
> + * Get Dynamic Capacity Extent List (Opcode 4810h)
> + **/
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
> +		CXLDeviceState *cxl_dstate,
> +		uint16_t *len)
> +{
> +	struct get_dyn_cap_ext_list_in_pl {
> +		uint32_t extent_cnt;
> +		uint32_t start_extent_id;
> +	} QEMU_PACKED;
> +
> +	struct get_dyn_cap_ext_list_out_pl {
> +		uint32_t count;
> +		uint32_t total_extents;
> +		uint32_t generation_num;
> +		uint8_t rsvd[4];
> +		struct {
> +			uint64_t start_dpa;
> +			uint64_t len;
> +			uint8_t tag[0x10];
> +			uint16_t shared_seq;
> +			uint8_t rsvd[6];
> +		} QEMU_PACKED records[];
> +	} QEMU_PACKED;
> +
> +	struct get_dyn_cap_ext_list_in_pl *in = (void *)cmd->payload;
> +	struct get_dyn_cap_ext_list_out_pl *out = (void *)cmd->payload;
> +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +	uint16_t record_count = 0, i = 0, record_done = 0;
> +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +	CXLDCD_Extent *ent;
> +	uint16_t out_pl_len;
> +
> +	if (in->start_extent_id > ct3d->dc.total_extent_count)
> +		return CXL_MBOX_INVALID_INPUT;
> +
> +	if (ct3d->dc.total_extent_count - in->start_extent_id < in->extent_cnt)
> +		record_count = ct3d->dc.total_extent_count - in->start_extent_id;
> +	else
> +		record_count = in->extent_cnt;
> +
> +	out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +	assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +	memset(out, 0, out_pl_len);
> +	stl_le_p(&out->count, record_count);
> +	stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +	stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +	QTAILQ_FOREACH(ent, extent_list, node) {
> +		if (i++ < in->start_extent_id)
> +			continue;
> +		stq_le_p(&out->records[i].start_dpa, ent->start_dpa);

I has been incrementing for the records skipped.  By now it may be well off
the end of records.  You need a separate index for the ones you are filling
that is incremented only when you write one.
record_done for example.
	out->records[record_done].len etc


> +		stq_le_p(&out->records[i].len, ent->len);
> +		memcpy(&out->records[i].tag, ent->tag, 0x10);
> +		stw_le_p(&out->records[i].shared_seq, ent->shared_seq);
> +		record_done++;
> +		if (record_done == record_count)
> +			break;
> +	}
> +
> +	*len = out_pl_len;
> +	return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1041,6 +1109,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>  	[DCD_CONFIG][GET_DC_REGION_CONFIG] = { "DCD_GET_DC_REGION_CONFIG",
>  		cmd_dcd_get_dyn_cap_config, 2, 0 },
> +	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> +		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> +		8, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b9c375d9b4..23954711b5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -708,6 +708,7 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
>  
>  		region_base += region->len;
>  	}
> +	QTAILQ_INIT(&ct3d->dc.extents);
>  
>  	return 0;
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 8a04e53e90..20ad5e7411 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -385,6 +385,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  
>  #define DCD_MAX_REGION_NUM 8
>  
> +typedef struct CXLDCD_Extent_raw {
> +	uint64_t start_dpa;
> +	uint64_t len;
> +	uint8_t tag[0x10];
> +	uint16_t shared_seq;
> +	uint8_t rsvd[0x6];
> +} QEMU_PACKED CXLDCExtent_raw;

What's this for?

> +
> +typedef struct CXLDCD_Extent {
> +	uint64_t start_dpa;
> +	uint64_t len;
> +	uint8_t tag[0x10];
> +	uint16_t shared_seq;
> +	uint8_t rsvd[0x6];
> +
> +	QTAILQ_ENTRY(CXLDCD_Extent) node;
> +} CXLDCD_Extent;
> +typedef QTAILQ_HEAD(, CXLDCD_Extent) CXLDCDExtentList;
> +
>  typedef struct CXLDCD_Region {
>  	uint64_t base;
>  	uint64_t decode_len; /* in multiples of 256MB */
> @@ -429,6 +448,10 @@ struct CXLType3Dev {
>  	struct dynamic_capacity {
>  		uint8_t num_regions; // 1-8
>  		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> +		CXLDCDExtentList extents;
> +
> +		uint32_t total_extent_count;
> +		uint32_t ext_list_gen_seq;
>  	} dc;
>  };
>  

