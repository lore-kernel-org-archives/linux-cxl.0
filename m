Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CAFC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 03:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB0Dqu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 26 Feb 2023 22:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB0Dqt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 26 Feb 2023 22:46:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F911CAFE
        for <linux-cxl@vger.kernel.org>; Sun, 26 Feb 2023 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677469607; x=1709005607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFJhPpVA4adnYLS1eEsWvuzd7nJTu1KuJcA0IdpvaZU=;
  b=XCvvAm1YiBSXIR4gOZjYtcFKPxEoGDrjGr6E32SP70w7ulZi7a4BGtU6
   UUUakOsOsGnrWuW78fgzO2GES6mT59O6XYCZ2u7BA/EdZDD2+WkmzpFql
   f01DuILRXPyhfwV7rl0Ollygk/OBKY9I7OSLHYhPGRiv5Q1gm9J2FiDg7
   f7dR+I5mygeGwQFUvqmiLhUGy2Hvaf0sMj82T6UTH/6PTK0Wn2A28KNPI
   K0DgJvWeCwqdkqTVE7ZiARU1WyPkY5kJ+k2uCKnhhFP0GXU2vx8tjV5o9
   iF8vQhl4m0Jh5RvY/n7o0862BzprwJ3cK+fjzBpAvfEGBOjzfR5JtTrc1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="336050913"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="336050913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:46:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="919134954"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="919134954"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:46:45 -0800
Date:   Sun, 26 Feb 2023 19:46:43 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, jonathan.cameron@huawei.com,
        ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Message-ID: <Y/wno8C4bK3XNoUD@aschofie-mobl2>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-4-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 24, 2023 at 11:46:48AM -0800, Davidlohr Bueso wrote:
> Track all regions associated to a memdev in order to
> tell if the device might be in active use.

Hi David,

I took a look here as I've been poked around in this space when looking
for 'region' names to associate with memdev poison trace events. [1]

How does the list created get used?

If we only need to know that this memdev is mapped in any region,
so don't touch it, we can look at it's port->commit_end. If that
commit_end >= 0, we can look at each endpoint to find the regions
it's mapped to.

Not sure if any of that is useful for what you need to do, but
it sounded familiar.

[1] https://lore.kernel.org/linux-cxl/62d24b380514c8c39b651aca79c81a424f0b5b37.1676685180.git.alison.schofield@intel.com/

Alison

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/memdev.c |  1 +
>  drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h         |  6 ++++++
>  drivers/cxl/cxlmem.h      |  4 ++++
>  4 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 47cc625bb1b0..68c0ab06b999 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -306,6 +306,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> +	INIT_LIST_HEAD(&cxlmd->region_list);
>  
>  	cdev = &cxlmd->cdev;
>  	cdev_init(cdev, fops);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..cea9de6457b9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1730,7 +1730,10 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
>  	cxled->mode = CXL_DECODER_DEAD;
> -	cxl_region_detach(cxled);
> +	if (!cxl_region_detach(cxled)) {
> +		struct cxl_region *cxlr = cxled->cxld.region;
> +		list_del(&cxlr->node);
> +	}
>  	up_write(&cxl_region_rwsem);
>  }
>  
> @@ -1749,8 +1752,12 @@ static int attach_target(struct cxl_region *cxlr,
>  
>  	down_read(&cxl_dpa_rwsem);
>  	rc = cxl_region_attach(cxlr, cxled, pos);
> -	if (rc == 0)
> +	if (rc == 0) {
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
>  		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> +		list_add_tail(&cxlr->node, &cxlmd->region_list);
> +	}
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
>  	return rc;
> @@ -1778,6 +1785,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
>  	}
>  
>  	rc = cxl_region_detach(p->targets[pos]);
> +	if (rc == 0)
> +		list_del(&cxlr->node);
>  out:
>  	up_write(&cxl_region_rwsem);
>  	return rc;
> @@ -2654,6 +2663,26 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
>  
> +bool cxl_memdev_active_region(struct cxl_memdev *cxlmd)
> +{
> +	bool ret = false;
> +	struct cxl_region *cxlr;
> +
> +	down_read(&cxl_region_rwsem);
> +	list_for_each_entry(cxlr, &cxlmd->region_list, node) {
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		if (p->state >= CXL_CONFIG_ACTIVE) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +	up_read(&cxl_region_rwsem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_active_region, CXL);
> +
>  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  {
>  	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b834e55375e3..e211241b079b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,7 @@ struct cxl_region {
>  	struct cxl_pmem_region *cxlr_pmem;
>  	unsigned long flags;
>  	struct cxl_region_params params;
> +	struct list_head node;
>  };
>  
>  struct cxl_nvdimm_bridge {
> @@ -773,6 +774,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_port *root,
>  		      struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
> +bool cxl_memdev_active_region(struct cxl_memdev *cxlmd);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -791,6 +793,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  {
>  	return NULL;
>  }
> +static inline bool cxl_memdev_active_region(struct cxl_memdev *cxlmd)
> +{
> +	return false;
> +}
>  #endif
>  
>  /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 934076254d52..4e31f3234519 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
> +#include <linux/list.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -40,6 +41,8 @@
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
> + * @region_list: List of regions that have as target the endpoint
> + *               decoder associated with this memdev
>   */
>  struct cxl_memdev {
>  	struct device dev;
> @@ -50,6 +53,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm *cxl_nvd;
>  	int id;
>  	int depth;
> +	struct list_head region_list;
>  };
>  
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> -- 
> 2.39.2
> 
