Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E4EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 17:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFVRBh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFVRBh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 13:01:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CF0E48
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 10:01:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn65f5cSZz6GDHV;
        Fri, 23 Jun 2023 00:58:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 18:01:31 +0100
Date:   Thu, 22 Jun 2023 18:01:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Message-ID: <20230622180130.00006273@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
        <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023 12:16:31 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity device utilizes events to signal the host about the
> changes to the allocation of DC blocks. The device communicates the
> state of these blocks of dynamic capacity through an extent list that
> describes the starting DPA and length of all blocks the host can access.
> 
> Based on the dynamic capacity add or release event type,
> dynamic memory represented by the extents are either added
> or removed as devdax device.
> 
> Process the dynamic capacity add and release events.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
Hi,

I ran out of time today and will be traveling next few weeks (may have
review time, may not) so sending what I have on basis it might be useful.

Jonathan

> +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> +				struct cxl_mbox_dc_response *res,
> +				int extent_cnt, int opcode)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc, size;
> +
> +	size = struct_size(res, extent_list, extent_cnt);
> +	res->extent_list_size = cpu_to_le32(extent_cnt);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = size,
> +		.payload_in = res,
> +	};
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +
> +	return rc;
return cxl_..

> +
> +}
> +
> +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> +					int *n, struct range *extent)
> +{
> +	struct cxl_mbox_dc_response *dc_res;
> +	unsigned int size;
> +
> +	if (!extent)
> +		size = struct_size(dc_res, extent_list, 0);
> +	else
> +		size = struct_size(dc_res, extent_list, *n + 1);
> +
> +	dc_res = krealloc(*res, size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	if (extent) {
> +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> +		dc_res->extent_list[*n].length =
> +				cpu_to_le64(range_len(extent));
> +		(*n)++;
> +	}
> +
> +	*res = dc_res;
> +	return 0;
> +}
blank line.

> +/**
> + * cxl_handle_dcd_event_records() - Read DCD event records.
> + * @mds: The memory device state

>  
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +			      unsigned int *extent_gen_num)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_dc_extents *dc_extents;
> +	struct cxl_mbox_get_dc_extent get_dc_extent;
> +	unsigned int total_extent_cnt;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	/* Check GET_DC_EXTENT_LIST is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> +		return 0;
> +	}
> +
> +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);

Put it on the stack - length is fixed and small if requesting 0
extents


> +	if (!dc_extents)
> +		return -ENOMEM;
> +
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> +		.extent_cnt = 0,
> +		.start_extent_index = 0,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc_extents,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto out;
> +
> +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
> +			total_extent_cnt, *extent_gen_num);
> +out:
> +
> +	kvfree(dc_extents);
> +	if (rc < 0)
> +		return rc;
> +
> +	return total_extent_cnt;
> +
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);



> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 144232c8305e..ba45c1c3b0a9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #include <linux/memregion.h>
> +#include <linux/interrupt.h>
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -11,6 +12,8 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> +#include "../../dax/bus.h"
> +#include "../../dax/dax-private.h"
>  
>  /**
>   * DOC: cxl core region
> @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  	return 0;
>  }
>  
> +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	unsigned int extent_gen_num;
> +	int i, rc;
> +
> +	/* Designed for Non Interleaving flow with the assumption one
> +	 * cxl_region will map the complete device DC region's DPA range
> +	 */
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> +		if (rc < 0)
> +			goto err;
> +		else if (rc > 1) {
> +			rc = cxl_dev_get_dc_extents(mds, rc, 0);
> +			if (rc < 0)
> +				goto err;
> +			mds->num_dc_extents = rc;
> +			mds->dc_extents_index = rc - 1;
> +		}
> +		mds->dc_list_gen_num = extent_gen_num;
> +		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
> +	}
> +	return 0;
> +err:
> +	return rc;

Direct returns easier to review.  

> +}
> +
>  static int commit_decoder(struct cxl_decoder *cxld)
>  {
>  	struct cxl_switch_decoder *cxlsd = NULL;
> @@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
>  		return PTR_ERR(cxlr_dax);
>  
>  	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> -	if (!cxlr_dc) {
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> +	if (!cxlr_dc)
> +		return -ENOMEM;

Curious.  Looks like a bug from earlier.


>  
> +	rc = request_module("dax_cxl");
> +	if (rc) {
> +		dev_err(dev, "failed to load dax-ctl module\n");
> +		goto load_err;
> +	}
>  	dev = &cxlr_dax->dev;
>  	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>  	if (rc)
> @@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
>  	xa_init(&cxlr_dc->dax_dev_list);
>  	cxlr->cxlr_dc = cxlr_dc;
>  	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> -	if (!rc)
> -		return 0;
> +	if (rc)
> +		goto err;
> +
> +	if (!dev->driver) {
> +		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	rc = cxl_region_manage_dc(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	return 0;
> +
>  err:
>  	put_device(dev);
> +load_err:
>  	kfree(cxlr_dc);

I've lost track, but seems unlikely we now need to free this in all paths and didn't before. Doesn't
the cxl_dc_region_Release deal with it?

>  	return rc;
>  }
> @@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);



> +
> +int cxl_release_dc_extent(struct cxl_memdev_state *mds,
> +			  struct range *rel_range)
> +{
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dc_region *cxlr_dc;
> +	struct dax_region *dax_region;
> +	resource_size_t dpa_offset;
> +	struct cxl_region *cxlr;
> +	struct range hpa_range;
> +	struct dev_dax *dev_dax;
> +	resource_size_t hpa;
> +	struct device *dev;
> +	int ranges, rc = 0;






> +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
> +{
...

> +	/*
> +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> +	 * get the cxl_region, dax_region refrences.
> +	 */
> +	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
> +				match_ep_decoder_by_range);
> +	if (!dev) {
> +		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);

Odd spacing. (Tab?)

> +		return PTR_ERR(dev);
> +	}
> +

...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9c0b2fa72bdd..0440b5c04ef6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h


>  /**
> @@ -296,6 +298,13 @@ enum cxl_devtype {
>  #define CXL_MAX_DC_REGION 8
>  #define CXL_DC_REGION_SRTLEN 8
>  
> +struct cxl_dc_extent_data {
> +	u64 dpa_start;
> +	u64 length;
> +	u8 tag[16];

Define for this length probably makes sense. It's non obvious.

> +	u16 shared_extent_seq;
> +};

> +
> +struct cxl_mbox_dc_response {
> +	__le32 extent_list_size;
> +	u8 reserved[4];
> +	struct updated_extent_list {
> +		__le64 dpa_start;
> +		__le64 length;
> +		u8 reserved[8];
> +	} __packed extent_list[];

Going to need this in multiple places (e.g. release) so factor out.


> +} __packed;
> +



> @@ -826,6 +894,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +/* FIXME why not have these be static in mbox.c? */

:)

> +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range);
> +int cxl_release_dc_extent(struct cxl_memdev_state *mds, struct range *rel_range);
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +			      unsigned int *extent_gen_num);
> +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds, unsigned int cnt,
> +			   unsigned int index);
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ac1a41bc083d..558ffbcb9b34 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -522,8 +522,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  		return irq;
>  
>  	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> -					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> -					 dev_id);
> +					IRQF_SHARED | IRQF_ONESHOT, NULL,
> +					dev_id);

No comment. :)

>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> @@ -555,6 +555,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  		.warn_settings = CXL_INT_MSI_MSIX,
>  		.failure_settings = CXL_INT_MSI_MSIX,
>  		.fatal_settings = CXL_INT_MSI_MSIX,
> +		.dyncap_settings = CXL_INT_MSI_MSIX,
>  	};
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -608,6 +609,11 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> +	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> +		return rc;
> +	}

Blank line to maintain existing style.

>  	return 0;
>  }
>  
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 227800053309..b2b27033f589 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -434,7 +434,7 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)

...

> +EXPORT_SYMBOL_GPL(alloc_dev_dax_range);
> +
Single blank line seems to be style in this fiel.
>  
>  static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
>  {
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 8cd79ab34292..aa8418c7aead 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -47,8 +47,11 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
>  	__dax_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
>  void dax_driver_unregister(struct dax_device_driver *dax_drv);
>  void kill_dev_dax(struct dev_dax *dev_dax);
> +void unregister_dev_dax(void *dev);
> +void unregister_dax_mapping(void *data);
>  bool static_dev_dax(struct dev_dax *dev_dax);
> -
> +int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> +					resource_size_t size);

Keep a blank line here..

>  /*
>   * While run_dax() is potentially a generic operation that could be
>   * defined in include/linux/dax.h we don't want to grow any users
> 

