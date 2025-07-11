Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C52ECE9F;
	Fri, 11 Jul 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248415; cv=none; b=EXrXqSYhI5REm+sHcpuQmdByz2UStFGXdLrq5tRGBLN+1/k4UElPwIrnw4e7mvY4irf2dR6yhUYbH+SopTudiX2nrtKxJE4O/UUuvHshlZBLNpHx9yiBzS0QxUQNLmFZk2BV2fDrUKTuAINqN0Bfst107GxmIL1SKDStwqTHhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248415; c=relaxed/simple;
	bh=XNCM0zw/FXw6A1kF9Q+03tG+VYlzeOeyPeRqVbv5a3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbTVG2bhMF5M3zwTXUcBrQsq9HFxx8MJjfp/fuvhKxZZtT8WJqNsYjGlrEBjM96T5ppGBgQVoHhKycKakV83TklD1sr7gcc8JqEiGXHwZFzn9YHGAQOuVl9odFelT9SKQlLoAjOlIdPsEOramIYbLkHyD1r2jGY2sHUD+ApMF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjuaDXEK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjuaDXEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248413; x=1783784413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XNCM0zw/FXw6A1kF9Q+03tG+VYlzeOeyPeRqVbv5a3w=;
  b=GjuaDXEK3RjIxYHRHOyjRlZF0TwQx73bXewPfwK867np9ZFrQxoO44RU
   SVo/AMoKCWd3mC+gFRdtBny4VS+3myyi5WcQqdJc4a3ckd4LytU81PnkJ
   seImCVSrgpdtnvJN6nvveVMPVZUBp9UHLvq7qazIa+hJKUxg6IU9lVqoZ
   yC5chovmxyEVzdBm9cSvLGShxJjbglJ1RtEmM5pobzcJ7URf7mQrXXyH2
   5sWgStRpwc6Kl3ZKRqoJG42jOuv5pXNR6DUiWSq9+mzvm/WdJ1cDaW+vg
   tgnLz9VcuMIO6KK+Qh4e8x7FXaYjdHhMkhyIM3AMUyvgvNxPYpxZiCkzI
   g==;
X-CSE-ConnectionGUID: 3Fo21fK0RW6JJg6iF/FH5A==
X-CSE-MsgGUID: JFsDZ5dNRxOf3nyMvVTXDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54680042"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54680042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:40:13 -0700
X-CSE-ConnectionGUID: SLKbPDtrRn++FSKnrfiFXw==
X-CSE-MsgGUID: dqokDKlDSpKvJpNYNHibjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="162080011"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.35]) ([10.125.111.35])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:40:12 -0700
Message-ID: <c0ccfb66-cd4a-4799-b039-ae54d215dbea@intel.com>
Date: Fri, 11 Jul 2025 08:40:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20250711151529.787470-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250711151529.787470-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 8:15 AM, Robert Richter wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thank you!

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

