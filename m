Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B372882B6
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245911; cv=none; b=DG/Bn5jU7/l19G+3Qqd+1wYtK4bhcnp7SUOGeLR4oXWTECMjgJ2Xee6H5nxuK6+ntM+NTWq0OHoAiu00l95ff9G1jbCt+VJddh5KdjAwJyBUUOSE3ADkwtxfOcL1H7g5f+jK2ArE9BHr5EtEE9q61QP1/+joGDfaGCRe1GxhM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245911; c=relaxed/simple;
	bh=hD4JeQyqAwMIQCkTrX2G/BQwAmkntwT4vJ6Ld/2gNX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvcUbTx6+kMXzt7FO+TwbwdpUYtQFqZuYfd0YFEPgOlejoN1kceFcCX+rJ7+/jxgYJA3Q/h/wEdQRc3miGji8IGR1LKDz4KS7+0v3DuzdkjKzwMxeM3HLKL6Xyz43aduS576Hcx+JitnAndXou/4mpYc4f/FQ2Mu6bd6t8TKWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7Xh1UMq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7Xh1UMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752245910; x=1783781910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hD4JeQyqAwMIQCkTrX2G/BQwAmkntwT4vJ6Ld/2gNX4=;
  b=Y7Xh1UMqkteoNmy6dLzl7/37ahz3E7XiF8hi7TkGDbn0nUB1GXyhNqvw
   t81egQvXRLoF+MHvrGm+hO0E88XOGo3Wy0nx7PNbZiN09VZxYGWkyPj/7
   2wurq4G6+HBDbqi7MJGE7ssjBMUXwjCitOgJvDMyU1Y30JBwlmo/OnNt/
   D9Mu69nrBIIm7k9p2O5woHDPd02BJETiFD520uXedBH4Vlqqrtm6kC8MV
   4LI8ioOnMESW6OJKBmojnh9MxHoP/VACP3Km5v24qMG4N7fktaJBLRmfy
   dojb6NBp85DU03VbK0wa7KlzGycz7kT+A2OQMvln15U2U0OVMxnKMlHUM
   w==;
X-CSE-ConnectionGUID: GiO1PPGiTbG5jMPMG1FumQ==
X-CSE-MsgGUID: dpH9pek/QKSH4M+phUHYmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54703745"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54703745"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:58:29 -0700
X-CSE-ConnectionGUID: 86diDEcqQEmZSewJXrJ5bQ==
X-CSE-MsgGUID: dsZQFHlgQTq1DZYyOBqP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="162070519"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.35]) ([10.125.111.35])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:58:29 -0700
Message-ID: <108cc808-ff36-4386-bc63-6f38a13dccbd@intel.com>
Date: Fri, 11 Jul 2025 07:58:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REWORK][PATCH] cxl: Remove core/acpi.c and cxl core dependency
 on ACPI
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250610172938.139428-1-dave.jiang@intel.com>
 <5282f0d4-a25b-4fc5-9890-9f50052bd4df@intel.com>
 <aHD3cDOZ4R3Vm7YA@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aHD3cDOZ4R3Vm7YA@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 4:37 AM, Robert Richter wrote:
> Hi Dave,
> 
> On 03.07.25 16:49:11, Dave Jiang wrote:
>>
>>
>> On 6/10/25 10:29 AM, Dave Jiang wrote:
>>> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
>>> cxl_core when adding the extended linear cache support. Add a callback
>>> in the cxl_root_decoder to retrieve the extended linear cache size from
>>> ACPI via the cxl_acpi driver.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Applied to cxl/next
>> 1a45e1cd694fdf2d2a22e3c70a6917ff39fe77ab
> 
> I am sorry to come back to this patch that late in the process. While
> rebasing my current region rework and address translation patches I
> came across your patch and realized that I have a much more simpler
> rework of that in my patch queue. I extracted that patch below from my
> series I am working on. Could you take a look at it? The changes are
> less intrusive and part of my rework required for address translation.
> If it looks good to you and during review, I rather prefer to replace
> your patch with this one. Note that I have follow on patches that
> reduce more code and remove the cxl_extended_linear_cache_resize()
> function entirely.
> 
> Patch below bases on:
> 
>  ac0fe6a57317 cxl: make cxl_bus_type constant

Hi Robert. I do like the simplicity of this. So lets go with that. Can you please post your patch directly to the mailing list as a stand alone? I'll drop my patch from cxl/next. We still should refactor the hpa_to_spa callback function into the cxl_rd_ops struct though. But that is a much smaller change.

DJ

> 
> Many thanks,
> 
> -Robert
> 
> 
> 
> 
> From fd3f1f5b33313bb10a2e51861031015ac48a8cd1 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Date: Fri, 11 Jul 2025 11:56:56 +0200
> Subject: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
> 
> From Dave [1]:
> 
> """
> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support.
> """
> 
> Current implementation calls hmat_get_extended_linear_cache_size() of
> the ACPI subsystem. That external reference causes issue running
> cxl_test as there is no way to "mock" that function and ignore it when
> using cxl test.
> 
> Instead of working around that using cxlrd ops and extensively
> expanding cxl_test code [1], just move HMAT calls out of the core
> module to cxl_acpi. Implement this by adding a @cache_size member to
> struct cxl_root_decoder. During initialization the cache size is
> determined and added to the root decoder object in cxl_acpi. Later on
> in cxl_core the cache_size parameter is used to setup extended linear
> caching.
> 
> [1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c        | 59 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 -
>  drivers/cxl/core/acpi.c   | 11 --------
>  drivers/cxl/core/core.h   |  2 --
>  drivers/cxl/core/region.c |  7 +----
>  drivers/cxl/cxl.h         |  1 +
>  6 files changed, 61 insertions(+), 20 deletions(-)
>  delete mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a1a99ec3f12c..712624cba2b6 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -335,6 +335,63 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>  	return rc;
>  }
>  
> +static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct range *hpa = &cxld->hpa_range;
> +	resource_size_t size = range_len(hpa);
> +	resource_size_t start = hpa->start;
> +	resource_size_t cache_size;
> +	struct resource res;
> +	int nid, rc;
> +
> +	res = DEFINE_RES(start, size, 0);
> +	nid = phys_to_target_node(start);
> +
> +	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * The cache range is expected to be within the CFMWS.
> +	 * Currently there is only support cache_size == cxl_size. CXL
> +	 * size is then half of the total CFMWS window size.
> +	 */
> +	size = size >> 1;
> +	if (cache_size && size != cache_size) {
> +		dev_warn(&cxld->dev,
> +			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
> +			 &cache_size, &size);
> +		return -ENXIO;
> +	}
> +
> +	cxlrd->cache_size = cache_size;
> +
> +	return 0;
> +}
> +
> +static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
> +{
> +	int rc;
> +
> +	rc = cxl_acpi_set_cache_size(cxlrd);
> +	if (!rc)
> +		return;
> +
> +	if (rc != -EOPNOTSUPP) {
> +		/*
> +		 * Failing to support extended linear cache region resize does not
> +		 * prevent the region from functioning. Only causes cxl list showing
> +		 * incorrect region size.
> +		 */
> +		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> +			 "Extended linear cache calculation failed rc:%d\n", rc);
> +	}
> +
> +	/* Ignoring return code */
> +	cxlrd->cache_size = 0;
> +}
> +
>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> @@ -394,6 +451,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  		ig = CXL_DECODER_MIN_GRANULARITY;
>  	cxld->interleave_granularity = ig;
>  
> +	cxl_setup_extended_linear_cache(cxlrd);
> +
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
>  		if (ways != 1 && ways != 3) {
>  			cxims_ctx = (struct cxl_cxims_context) {
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..5ad8fef210b5 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,7 +15,6 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-y += ras.o
> -cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> deleted file mode 100644
> index f13b4dae6ac5..000000000000
> --- a/drivers/cxl/core/acpi.c
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> -#include <linux/acpi.h>
> -#include "cxl.h"
> -#include "core.h"
> -
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size)
> -{
> -	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> -}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..9462aea9ce9d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..bc542a7142c0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3282,15 +3282,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int nid = phys_to_target_node(res->start);
>  	resource_size_t size = resource_size(res);
>  	resource_size_t cache_size, start;
> -	int rc;
> -
> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> -	if (rc)
> -		return rc;
>  
> +	cache_size = cxlrd->cache_size;
>  	if (!cache_size)
>  		return 0;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e7b66ca1d423..4643a95ca111 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -432,6 +432,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
> +	resource_size_t cache_size;
>  	atomic_t region_id;
>  	cxl_hpa_to_spa_fn hpa_to_spa;
>  	void *platform_data;

