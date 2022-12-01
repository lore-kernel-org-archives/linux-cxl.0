Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF2BC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 23:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLAXE5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLAXE4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 18:04:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D63A9EA6
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 15:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669935894; x=1701471894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NJaYWrjN1dWCNJ+8bV7Z4k16ZHYjzZL3IYXD4Bolmbw=;
  b=YD21P9yb7jjuaM/v2KKYdmGLFbiqHNE90Nolf69gaRDdL/z/OqK9/SLd
   6wx1xmUjb8G7M8QdH6ZP3cMi5OWk7HTVjZVpOMNA2BHb6nlh9hPB/fMyc
   vd9u2nyoHnExf/QWlOH6Qd4tRlHYEEJryZvPA1x0a8B6uNQ1YdWMQOKSX
   dl08yXCwqq6bUKweMr/O8f+8Z1NS+cdEjf579o04YUpFGef209l0x7hTg
   9WDtDb5CQZ4gw266Xirkh2YVGCU8FfNkr73U2xmWX5gaRG/9F0Ys0Pmdf
   LFarrmr9pOk00VF+Wr8F7197JZRGSHU95eSxwYRS0yvF8FylCwsNth27v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296172290"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296172290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:04:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708258949"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708258949"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:04:54 -0800
Message-ID: <1e3e3ef4-4268-3823-187f-4347f52c52e0@intel.com>
Date:   Thu, 1 Dec 2022 16:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 5/5] cxl/region: Manage CPU caches relative to DPA
 invalidation events
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, nvdimm@lists.linux.dev,
        dave@stgolabs.net
References: <166993219354.1995348.12912519920112533797.stgit@dwillia2-xfh.jf.intel.com>
 <166993222098.1995348.16604163596374520890.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <166993222098.1995348.16604163596374520890.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/1/2022 3:03 PM, Dan Williams wrote:
> A "DPA invalidation event" is any scenario where the contents of a DPA
> (Device Physical Address) is modified in a way that is incoherent with
> CPU caches, or if the HPA (Host Physical Address) to DPA association
> changes due to a remapping event.
> 
> PMEM security events like Unlock and Passphrase Secure Erase already
> manage caches through LIBNVDIMM, so that leaves HPA to DPA remap events
> that need cache management by the CXL core. Those only happen when the
> boot time CXL configuration has changed. That event occurs when
> userspace attaches an endpoint decoder to a region configuration, and
> that region is subsequently activated.
> 
> The implications of not invalidating caches between remap events is that
> reads from the region at different points in time may return different
> results due to stale cached data from the previous HPA to DPA mapping.
> Without a guarantee that the region contents after cxl_region_probe()
> are written before being read (a layering-violation assumption that
> cxl_region_probe() can not make) the CXL subsystem needs to ensure that
> reads that precede writes see consistent results.
> 
> A CONFIG_CXL_REGION_INVALIDATION_TEST option is added to support debug
> and unit testing of the CXL implementation in QEMU or other environments
> where cpu_cache_has_invalidate_memregion() returns false. This may prove
> too restrictive for QEMU where the HDM decoders are emulated, but in
> that case the CXL subsystem needs some new mechanism / indication that
> the HDM decoder is emulated and not a passthrough of real hardware.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/Kconfig       |   18 ++++++++++++++++++
>   drivers/cxl/core/region.c |   31 +++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h         |    8 ++++++++
>   drivers/cxl/security.c    |   14 --------------
>   4 files changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 768ced3d6fe8..0ac53c422c31 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -111,4 +111,22 @@ config CXL_REGION
>   	select MEMREGION
>   	select GET_FREE_REGION
>   
> +config CXL_REGION_INVALIDATION_TEST
> +	bool "CXL: Region Cache Management Bypass (TEST)"
> +	depends on CXL_REGION
> +	help
> +	  CXL Region management and security operations potentially invalidate
> +	  the content of CPU caches without notifiying those caches to
> +	  invalidate the affected cachelines. The CXL Region driver attempts
> +	  to invalidate caches when those events occur.  If that invalidation
> +	  fails the region will fail to enable.  Reasons for cache
> +	  invalidation failure are due to the CPU not providing a cache
> +	  invalidation mechanism. For example usage of wbinvd is restricted to
> +	  bare metal x86. However, for testing purposes toggling this option
> +	  can disable that data integrity safety and proceed with enabling
> +	  regions when there might be conflicting contents in the CPU cache.
> +
> +	  If unsure, or if this kernel is meant for production environments,
> +	  say N.
> +
>   endif
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1bc2ebefa2a5..3a6c3f84015f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1403,6 +1403,8 @@ static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
>   		goto out;
>   	down_read(&cxl_dpa_rwsem);
>   	rc = cxl_region_attach(cxlr, to_cxl_endpoint_decoder(dev), pos);
> +	if (rc == 0)
> +		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   	up_read(&cxl_dpa_rwsem);
>   	up_write(&cxl_region_rwsem);
>   out:
> @@ -1900,6 +1902,30 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>   	return rc;
>   }
>   
> +static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> +{
> +	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +			dev_warn(
> +				&cxlr->dev,
> +				"Bypassing cpu_cache_invalidate_memergion() for testing!\n");
> +			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> +			return 0;
> +		} else {
> +			dev_err(&cxlr->dev,
> +				"Failed to synchronize CPU cache state\n");
> +			return -ENXIO;
> +		}
> +	}
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> +	return 0;
> +}
> +
>   static int cxl_region_probe(struct device *dev)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -1915,12 +1941,16 @@ static int cxl_region_probe(struct device *dev)
>   	if (p->state < CXL_CONFIG_COMMIT) {
>   		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
>   		rc = -ENXIO;
> +		goto out;
>   	}
>   
> +	rc = cxl_region_invalidate_memregion(cxlr);
> +
>   	/*
>   	 * From this point on any path that changes the region's state away from
>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>   	 */
> +out:
>   	up_read(&cxl_region_rwsem);
>   
>   	if (rc)
> @@ -1953,4 +1983,5 @@ void cxl_region_exit(void)
>   }
>   
>   MODULE_IMPORT_NS(CXL);
> +MODULE_IMPORT_NS(DEVMEM);
>   MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b433e541a054..e5e1abceeca7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -380,12 +380,19 @@ struct cxl_region_params {
>   	int nr_targets;
>   };
>   
> +/*
> + * Flag whether this region needs to have its HPA span synchronized with
> + * CPU cache state at region activation time.
> + */
> +#define CXL_REGION_F_INCOHERENT 0
> +
>   /**
>    * struct cxl_region - CXL region
>    * @dev: This region's device
>    * @id: This region's id. Id is globally unique across all regions
>    * @mode: Endpoint decoder allocation / access mode
>    * @type: Endpoint decoder target type
> + * @flags: Region state flags
>    * @params: active + config params for the region
>    */
>   struct cxl_region {
> @@ -393,6 +400,7 @@ struct cxl_region {
>   	int id;
>   	enum cxl_decoder_mode mode;
>   	enum cxl_decoder_type type;
> +	unsigned long flags;
>   	struct cxl_region_params params;
>   };
>   
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index cbd005ceb091..5484d4eecfd1 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -120,17 +120,12 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>   	u8 pass[NVDIMM_PASSPHRASE_LEN];
>   	int rc;
>   
> -	if (!cpu_cache_has_invalidate_memregion())
> -		return -EINVAL;
> -
>   	memcpy(pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
>   	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_UNLOCK,
>   			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0);
>   	if (rc < 0)
>   		return rc;
>   
> -	/* DIMM unlocked, invalidate all CPU caches before we read it */
> -	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>   	return 0;
>   }
>   
> @@ -144,21 +139,14 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>   	struct cxl_pass_erase erase;
>   	int rc;
>   
> -	if (!cpu_cache_has_invalidate_memregion())
> -		return -EINVAL;
> -
>   	erase.type = ptype == NVDIMM_MASTER ?
>   		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
>   	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
> -	/* Flush all cache before we erase mem device */
> -	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>   	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
>   			       &erase, sizeof(erase), NULL, 0);
>   	if (rc < 0)
>   		return rc;
>   
> -	/* mem device erased, invalidate all CPU caches before data is read */
> -	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>   	return 0;
>   }
>   
> @@ -173,5 +161,3 @@ static const struct nvdimm_security_ops __cxl_security_ops = {
>   };
>   
>   const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;
> -
> -MODULE_IMPORT_NS(DEVMEM);
> 
