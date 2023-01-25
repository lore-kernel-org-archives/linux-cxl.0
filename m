Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9AC27C76
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 23:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAYX5D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAYX5C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 18:57:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE023DB6
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674691020; x=1706227020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+X8wdO/5Wel3LYJGEme2ZGCOHkEF4BoPHEuSTHSDHuk=;
  b=nsXA61ta/bIkGn5bPRVJ+YR4SxIG5jlmZ4kfQU/XHLnL6mK4Paioi6M6
   3o1V1gRFPoO+MvctoVRJWUFew/3w+wuVUD1v+RVoRS9s4wYl8dvKDvjr3
   FFsA3G9qcao61Rx9fHwt4QEn2QqS5lZ6xj82KK18ytC/gSH8ImbSyErro
   V3NAKtYDMc0YFtrSlkSwID+MYqSMRuMfyb7H5pcQiU1NGpZkhq74IncRO
   x8q0byrGwyfS7oLQbtP6GdTQdzoTW72Is/LPJW0t+l/KyoQSD5J+2zxCN
   8Q+RN6ReYNzuMITInh44ycmn87BtgZC8qb9LGNpRiyoN5GHLYtm7xW2Wk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="391225674"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="391225674"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 15:56:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726081259"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="726081259"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.209.145.70]) ([10.209.145.70])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 15:56:58 -0800
Message-ID: <59998be3-9225-4738-ad67-b5fbb5640f19@intel.com>
Date:   Wed, 25 Jan 2023 16:56:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl: change 'cxl_nvb' naming to 'nv_bridge' to improve
 readability
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, jonathan.cameron@huawei.com
References: <167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local>
 <63d1c0b89ce33_3a36e52947f@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63d1c0b89ce33_3a36e52947f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/25/23 4:52 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> In CXL code there is 'cxl_nvb' for CXL nvdimm bridge and 'cxl_nvd' for CXL
>> nvdimm device. Having both in the code causes confusion with code reading.
>> Change all instances of 'cxl_nvb' to 'nv_bridge' in order to improve
>> readability.
>>
>> https://lore.kernel.org/linux-cxl/20230124164453.000029c6@Huawei.com/T/#md44f8d931541fcfa990d8e7e30404a9d37902d9a
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/acpi.c        |   10 +++--
>>   drivers/cxl/core/pmem.c   |   84 +++++++++++++++++++++++----------------------
>>   drivers/cxl/core/region.c |   42 +++++++++++------------
>>   drivers/cxl/cxl.h         |    4 +-
>>   drivers/cxl/cxlmem.h      |    4 +-
>>   drivers/cxl/pmem.c        |   28 ++++++++-------
>>   6 files changed, 86 insertions(+), 86 deletions(-)
> 
> Looks good, I rebased this on cxl/fixes that has the pending stable
> backport and massaged the commit message a bit:

ok thanks!

> 
> -- >8 --
> 
>  From d6d961c1216fd1bff60c17c15757a71099eb79c0 Mon Sep 17 00:00:00 2001
> From: Dave Jiang <dave.jiang@intel.com>
> Date: Wed, 25 Jan 2023 12:01:02 -0700
> Subject: [PATCH] cxl/pmem: Rename 'cxl_nvb' to 'nv_bridge' to improve
>   readability
> 
> In CXL code there is 'cxl_nvb' for CXL nvdimm bridge and 'cxl_nvd' for CXL
> nvdimm device. Having both in the code causes confusion with code reading.
> Change all instances of 'cxl_nvb' to 'nv_bridge' in order to improve
> readability.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Link: http://lore.kernel.org/r/26633055-4e38-01c3-19a5-ef83fd57b533@intel.com
> Link: https://lore.kernel.org/r/167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/acpi.c        | 10 +++---
>   drivers/cxl/core/pmem.c   | 68 +++++++++++++++++++--------------------
>   drivers/cxl/core/region.c | 42 ++++++++++++------------
>   drivers/cxl/cxl.h         |  4 +--
>   drivers/cxl/cxlmem.h      |  4 +--
>   drivers/cxl/pmem.c        | 32 +++++++++---------
>   6 files changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 13cde44c6086..212ee7bbf318 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -480,7 +480,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>   {
>   	struct cxl_decoder *cxld;
>   	struct cxl_port *root_port = data;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct device *host = root_port->dev.parent;
>   
>   	if (!is_root_decoder(match))
> @@ -490,13 +490,13 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>   	if (!(cxld->flags & CXL_DECODER_F_PMEM))
>   		return 0;
>   
> -	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
> -	if (IS_ERR(cxl_nvb)) {
> +	nv_bridge = devm_cxl_add_nvdimm_bridge(host, root_port);
> +	if (IS_ERR(nv_bridge)) {
>   		dev_dbg(host, "failed to register pmem\n");
> -		return PTR_ERR(cxl_nvb);
> +		return PTR_ERR(nv_bridge);
>   	}
>   	dev_dbg(host, "%s: add: %s\n", dev_name(&root_port->dev),
> -		dev_name(&cxl_nvb->dev));
> +		dev_name(&nv_bridge->dev));
>   	return 1;
>   }
>   
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index c2e4b1093788..fc31b9eb8f51 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -25,10 +25,10 @@ static DEFINE_IDA(cxl_nvdimm_bridge_ida);
>   
>   static void cxl_nvdimm_bridge_release(struct device *dev)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
> +	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
>   
> -	ida_free(&cxl_nvdimm_bridge_ida, cxl_nvb->id);
> -	kfree(cxl_nvb);
> +	ida_free(&cxl_nvdimm_bridge_ida, nv_bridge->id);
> +	kfree(nv_bridge);
>   }
>   
>   static const struct attribute_group *cxl_nvdimm_bridge_attribute_groups[] = {
> @@ -84,21 +84,21 @@ static struct lock_class_key cxl_nvdimm_bridge_key;
>   
>   static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct device *dev;
>   	int rc;
>   
> -	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
> -	if (!cxl_nvb)
> +	nv_bridge = kzalloc(sizeof(*nv_bridge), GFP_KERNEL);
> +	if (!nv_bridge)
>   		return ERR_PTR(-ENOMEM);
>   
>   	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
>   	if (rc < 0)
>   		goto err;
> -	cxl_nvb->id = rc;
> +	nv_bridge->id = rc;
>   
> -	dev = &cxl_nvb->dev;
> -	cxl_nvb->port = port;
> +	dev = &nv_bridge->dev;
> +	nv_bridge->port = port;
>   	device_initialize(dev);
>   	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
>   	device_set_pm_not_required(dev);
> @@ -106,18 +106,18 @@ static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
>   	dev->bus = &cxl_bus_type;
>   	dev->type = &cxl_nvdimm_bridge_type;
>   
> -	return cxl_nvb;
> +	return nv_bridge;
>   
>   err:
> -	kfree(cxl_nvb);
> +	kfree(nv_bridge);
>   	return ERR_PTR(rc);
>   }
>   
> -static void unregister_nvb(void *_cxl_nvb)
> +static void unregister_nvb(void *_nv_bridge)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
>   
> -	device_unregister(&cxl_nvb->dev);
> +	device_unregister(&nv_bridge->dev);
>   }
>   
>   /**
> @@ -130,19 +130,19 @@ static void unregister_nvb(void *_cxl_nvb)
>   struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>   						     struct cxl_port *port)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct device *dev;
>   	int rc;
>   
>   	if (!IS_ENABLED(CONFIG_CXL_PMEM))
>   		return ERR_PTR(-ENXIO);
>   
> -	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
> -	if (IS_ERR(cxl_nvb))
> -		return cxl_nvb;
> +	nv_bridge = cxl_nvdimm_bridge_alloc(port);
> +	if (IS_ERR(nv_bridge))
> +		return nv_bridge;
>   
> -	dev = &cxl_nvb->dev;
> -	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
> +	dev = &nv_bridge->dev;
> +	rc = dev_set_name(dev, "nvdimm-bridge%d", nv_bridge->id);
>   	if (rc)
>   		goto err;
>   
> @@ -150,11 +150,11 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>   	if (rc)
>   		goto err;
>   
> -	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
> +	rc = devm_add_action_or_reset(host, unregister_nvb, nv_bridge);
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return cxl_nvb;
> +	return nv_bridge;
>   
>   err:
>   	put_device(dev);
> @@ -197,7 +197,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm, CXL);
>   
>   static struct lock_class_key cxl_nvdimm_key;
>   
> -static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
> +static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *nv_bridge,
>   					   struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_nvdimm *cxl_nvd;
> @@ -231,13 +231,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>   {
>   	struct cxl_memdev *cxlmd = _cxlmd;
>   	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
>   
>   	cxl_nvd->cxlmd = NULL;
>   	cxlmd->cxl_nvd = NULL;
> -	cxlmd->cxl_nvb = NULL;
> +	cxlmd->nv_bridge = NULL;
>   	device_unregister(&cxl_nvd->dev);
> -	put_device(&cxl_nvb->dev);
> +	put_device(&nv_bridge->dev);
>   }
>   
>   /**
> @@ -248,21 +248,21 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>    */
>   int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct cxl_nvdimm *cxl_nvd;
>   	struct device *dev;
>   	int rc;
>   
> -	cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> -	if (!cxl_nvb)
> +	nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +	if (!nv_bridge)
>   		return -ENODEV;
>   
> -	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
> +	cxl_nvd = cxl_nvdimm_alloc(nv_bridge, cxlmd);
>   	if (IS_ERR(cxl_nvd)) {
>   		rc = PTR_ERR(cxl_nvd);
>   		goto err_alloc;
>   	}
> -	cxlmd->cxl_nvb = cxl_nvb;
> +	cxlmd->nv_bridge = nv_bridge;
>   
>   	dev = &cxl_nvd->dev;
>   	rc = dev_set_name(dev, "pmem%d", cxlmd->id);
> @@ -275,15 +275,15 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>   
>   	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
>   
> -	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
> +	/* @cxlmd carries an @nv_bridge reference until cxlmd_release_nvdimm */
>   	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
>   
>   err:
>   	put_device(dev);
>   err_alloc:
> -	cxlmd->cxl_nvb = NULL;
> +	cxlmd->nv_bridge = NULL;
>   	cxlmd->cxl_nvd = NULL;
> -	put_device(&cxl_nvb->dev);
> +	put_device(&nv_bridge->dev);
>   
>   	return rc;
>   }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 02f28da519e3..f03e42db7c6e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1814,7 +1814,7 @@ static struct lock_class_key cxl_pmem_region_key;
>   static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct cxl_pmem_region *cxlr_pmem;
>   	struct device *dev;
>   	int i;
> @@ -1847,12 +1847,12 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>   		 * bridge for one device is the same for all.
>   		 */
>   		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> -			if (!cxl_nvb) {
> +			nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +			if (!nv_bridge) {
>   				cxlr_pmem = ERR_PTR(-ENODEV);
>   				goto out;
>   			}
> -			cxlr->cxl_nvb = cxl_nvb;
> +			cxlr->nv_bridge = nv_bridge;
>   		}
>   		m->cxlmd = cxlmd;
>   		get_device(&cxlmd->dev);
> @@ -1880,7 +1880,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>   {
>   	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
>   	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>   
>   	/*
>   	 * Either the bridge is in ->remove() context under the device_lock(),
> @@ -1888,7 +1888,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>   	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
>   	 * lock).
>   	 */
> -	device_lock_assert(&cxl_nvb->dev);
> +	device_lock_assert(&nv_bridge->dev);
>   	cxlr->cxlr_pmem = NULL;
>   	cxlr_pmem->cxlr = NULL;
>   	device_unregister(&cxlr_pmem->dev);
> @@ -1897,15 +1897,15 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>   static void cxlr_release_nvdimm(void *_cxlr)
>   {
>   	struct cxl_region *cxlr = _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>   
> -	device_lock(&cxl_nvb->dev);
> +	device_lock(&nv_bridge->dev);
>   	if (cxlr->cxlr_pmem)
> -		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +		devm_release_action(&nv_bridge->dev, cxlr_pmem_unregister,
>   				    cxlr->cxlr_pmem);
> -	device_unlock(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> -	put_device(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
> +	cxlr->nv_bridge = NULL;
> +	put_device(&nv_bridge->dev);
>   }
>   
>   /**
> @@ -1917,14 +1917,14 @@ static void cxlr_release_nvdimm(void *_cxlr)
>   static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>   {
>   	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct device *dev;
>   	int rc;
>   
>   	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
>   	if (IS_ERR(cxlr_pmem))
>   		return PTR_ERR(cxlr_pmem);
> -	cxl_nvb = cxlr->cxl_nvb;
> +	nv_bridge = cxlr->nv_bridge;
>   
>   	dev = &cxlr_pmem->dev;
>   	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> @@ -1938,25 +1938,25 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>   	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>   		dev_name(dev));
>   
> -	device_lock(&cxl_nvb->dev);
> -	if (cxl_nvb->dev.driver)
> -		rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +	device_lock(&nv_bridge->dev);
> +	if (nv_bridge->dev.driver)
> +		rc = devm_add_action_or_reset(&nv_bridge->dev,
>   					      cxlr_pmem_unregister, cxlr_pmem);
>   	else
>   		rc = -ENXIO;
> -	device_unlock(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
>   
>   	if (rc)
>   		goto err_bridge;
>   
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	/* @cxlr carries a reference on @nv_bridge until cxlr_release_nvdimm */
>   	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
>   
>   err:
>   	put_device(dev);
>   err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> +	put_device(&nv_bridge->dev);
> +	cxlr->nv_bridge = NULL;
>   	return rc;
>   }
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..1a795a2ddbe3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -426,7 +426,7 @@ struct cxl_region_params {
>    * @id: This region's id. Id is globally unique across all regions
>    * @mode: Endpoint decoder allocation / access mode
>    * @type: Endpoint decoder target type
> - * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> + * @nv_bridge: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>    * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
>    * @flags: Region state flags
>    * @params: active + config params for the region
> @@ -436,7 +436,7 @@ struct cxl_region {
>   	int id;
>   	enum cxl_decoder_mode mode;
>   	enum cxl_decoder_type type;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct cxl_pmem_region *cxlr_pmem;
>   	unsigned long flags;
>   	struct cxl_region_params params;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..f1322f779346 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -35,7 +35,7 @@
>    * @cdev: char dev core object for ioctl operations
>    * @cxlds: The device state backing this device
>    * @detach_work: active memdev lost a port in its ancestry
> - * @cxl_nvb: coordinate removal of @cxl_nvd if present
> + * @nv_bridge: coordinate removal of @cxl_nvd if present
>    * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>    * @id: id number of this memdev instance.
>    */
> @@ -44,7 +44,7 @@ struct cxl_memdev {
>   	struct cdev cdev;
>   	struct cxl_dev_state *cxlds;
>   	struct work_struct detach_work;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>   	struct cxl_nvdimm *cxl_nvd;
>   	int id;
>   };
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 08bbbac9a6d0..7b3b24a12d6e 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -64,7 +64,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>   {
>   	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
>   	unsigned long flags = 0, cmd_mask = 0;
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct nvdimm *nvdimm;
> @@ -79,7 +79,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>   	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
>   	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
>   	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
> -	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
> +	nvdimm = __nvdimm_create(nv_bridge->nvdimm_bus, cxl_nvd,
>   				 cxl_dimm_attribute_groups, flags,
>   				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
>   				 cxl_security_ops, NULL);
> @@ -238,7 +238,7 @@ static int detach_nvdimm(struct device *dev, void *data)
>   		goto out;
>   
>   	cxl_nvd = to_cxl_nvdimm(dev);
> -	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
> +	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->nv_bridge == data)
>   		release = true;
>   out:
>   	device_unlock(dev);
> @@ -247,34 +247,34 @@ static int detach_nvdimm(struct device *dev, void *data)
>   	return 0;
>   }
>   
> -static void unregister_nvdimm_bus(void *_cxl_nvb)
> +static void unregister_nvdimm_bus(void *_nv_bridge)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> -	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
> +	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
> +	struct nvdimm_bus *nvdimm_bus = nv_bridge->nvdimm_bus;
>   
> -	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
> +	bus_for_each_dev(&cxl_bus_type, NULL, nv_bridge, detach_nvdimm);
>   
> -	cxl_nvb->nvdimm_bus = NULL;
> +	nv_bridge->nvdimm_bus = NULL;
>   	nvdimm_bus_unregister(nvdimm_bus);
>   }
>   
>   static int cxl_nvdimm_bridge_probe(struct device *dev)
>   {
> -	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
> +	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
>   
> -	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
> +	nv_bridge->nd_desc = (struct nvdimm_bus_descriptor) {
>   		.provider_name = "CXL",
>   		.module = THIS_MODULE,
>   		.ndctl = cxl_pmem_ctl,
>   	};
>   
> -	cxl_nvb->nvdimm_bus =
> -		nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
> +	nv_bridge->nvdimm_bus =
> +		nvdimm_bus_register(&nv_bridge->dev, &nv_bridge->nd_desc);
>   
> -	if (!cxl_nvb->nvdimm_bus)
> +	if (!nv_bridge->nvdimm_bus)
>   		return -ENOMEM;
>   
> -	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
> +	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, nv_bridge);
>   }
>   
>   static struct cxl_driver cxl_nvdimm_bridge_driver = {
> @@ -306,7 +306,7 @@ static int cxl_pmem_region_probe(struct device *dev)
>   	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
>   	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
>   	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>   	struct cxl_pmem_region_info *info = NULL;
>   	struct nd_interleave_set *nd_set;
>   	struct nd_region_desc ndr_desc;
> @@ -395,7 +395,7 @@ static int cxl_pmem_region_probe(struct device *dev)
>   	ndr_desc.nd_set = nd_set;
>   
>   	cxlr_pmem->nd_region =
> -		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
> +		nvdimm_pmem_region_create(nv_bridge->nvdimm_bus, &ndr_desc);
>   	if (!cxlr_pmem->nd_region) {
>   		rc = -ENOMEM;
>   		goto out_nvd;
