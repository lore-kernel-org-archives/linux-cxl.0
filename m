Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388D2253EF;
	Tue,  7 Oct 2025 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869454; cv=none; b=n6BvYyCJPE2/gLyeFLVxKKQQTJQXFuz38HTZE3GSTsJE8eDOlBb1vOFCgDEgAqcOMTPf8FTKtXHCtlE4ykZty+2Le7DO7NRwD2/HpxMOmux0zRFfWWw3J0VZNqJFY6bhbkou6AhhU3o+jB4m3cmLlymA1dCIaXNG/FRloUQSPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869454; c=relaxed/simple;
	bh=vtd3T+GPDoQyheLzXKyTXUoDIwVxAPo8mA+lodgqrgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYBzQK/uoaM1BoRMCHR5ZLQUFukkcbBmakbWzok1DiZSzXNYTIUmkZIIqrU2o1GMnRmrH0HxoQ8+i8FWRJcsKOM0iucp6HMfY3Ow7AfGZA5LSbEGIoNNxiQS4cag82mbgJh9RZkuanphStPVeyCQqIYGF0u4HH5ts/5eegG6Mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKbrsUux; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKbrsUux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759869452; x=1791405452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vtd3T+GPDoQyheLzXKyTXUoDIwVxAPo8mA+lodgqrgE=;
  b=KKbrsUux7K3lndbbB7mBgARQ44CyInOYhDjNpf/kg5/LvwmOCCERrXt7
   O9mTkXNSyOb5j21C84TsEER672zpOVO50vxx/mBykdPnyjUtLUMLtbiy3
   FwkX6n8IKuRZiwr/IlhwvnyXzyxbi9gY2IbacDFuXjtkjnifVlSNEjpDO
   WKQIY1OTmp3TpY+XnFN4HxXZQBkbgI4Hy4bR9Ey2qJMGLWNOiSMFQb+Pj
   eG1sSyW/RdUzxjofUSqD1KtVc3fBZiTZSU0brW5J4AgNfoBsNtyzaEODq
   Ggpsgpgoh/d0A4Ja3VA0JUJIPelPdwuxI7faUlwzNQ919wpInVG1b+iS1
   Q==;
X-CSE-ConnectionGUID: JfZWstCnQM+SmmU1MWVS/Q==
X-CSE-MsgGUID: rZ9KWsZBROaCZUIjvQk3sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61964761"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61964761"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:37:31 -0700
X-CSE-ConnectionGUID: PzdFIZEZRu+bllHMmbZCBw==
X-CSE-MsgGUID: AR1yChDbSaWEBs5DqEF/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184299111"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.156]) ([10.125.110.156])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:37:30 -0700
Message-ID: <0c3f38f3-0d09-41cd-be4f-d6eb4ab41e6c@intel.com>
Date: Tue, 7 Oct 2025 13:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v5] cxl/test: Simulate an x86 Low Memory Hole for
 tests
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-5-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251006155836.791418-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 8:58 AM, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range
> sizes to 1GB. The auto-created region of cxl-test uses mock_cfmws[0],
> therefore the LMH path in the CXL Driver will be exercised every time
> the cxl-test module is loaded.
> 
> Since mock_cfmws[0] range base address is typically different from the
> one published by the BIOS on real hardware, the driver would fail to
> create and attach CXL Regions when it's run on the mock environment
> created by cxl-tests. Furthermore, cxl-topology.sh, cxl-events.sh, and
> cxl-sanitize.sh, would also fail.
> 
> To make the above-mentioned tests succeed again, add two "mock" versions
> of platform_*() that check the HPA range start of mock_cfmws[0] instead
> of LMH_CFMWS_RANGE_START. When cxl_core calls a cxl_core exported
> function and that function is mocked by cxl_test, the call chain causes
> a circular dependency issue. Then add also two "redirect" versions of
> platform_*() to work out the circular dependency issue.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Just a nit below. Otherwise looks ok
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/platform_quirks.c   | 23 +++++++-----
>  drivers/cxl/core/platform_quirks.h   | 20 +++++++++--
>  tools/testing/cxl/cxl_core_exports.c | 23 ++++++++++++
>  tools/testing/cxl/exports.h          |  7 ++++
>  tools/testing/cxl/test/cxl.c         | 54 ++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mock.c        | 48 +++++++++++++++++++++++++
>  tools/testing/cxl/test/mock.h        |  4 +++
>  7 files changed, 168 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
> index 7e76e392b1ae..aecd376f2766 100644
> --- a/drivers/cxl/core/platform_quirks.c
> +++ b/drivers/cxl/core/platform_quirks.c
> @@ -1,20 +1,23 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2025 Intel Corporation. */

This change should've happened when the file was first introduced earlier.

DJ

>  
>  #include <linux/range.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +
>  #include "platform_quirks.h"
> -#include "cxlmem.h"
>  #include "core.h"
>  
>  /* Start of CFMWS range that end before x86 Low Memory Holes */
>  #define LMH_CFMWS_RANGE_START 0x0ULL
>  
>  /**
> - * platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
> + * __platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
>   * Endpoint Decoders. It allows matching on platforms with LMH's.
>   * @cxlrd: The Root Decoder against which @cxled is tested for matching.
>   * @cxled: The Endpoint Decoder to be tested for matching @cxlrd.
>   *
> - * platform_cxlrd_matches_cxled() is typically called from the
> + * __platform_cxlrd_matches_cxled() is typically called from the
>   * match_*_by_range() functions in region.c. It checks if an endpoint decoder
>   * matches a given root decoder and returns true to allow the driver to succeed
>   * in the construction of regions where it would otherwise fail for the presence
> @@ -29,8 +32,8 @@
>   *
>   * Return: true if an endpoint matches a root decoder, else false.
>   */
> -bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> -				  const struct cxl_endpoint_decoder *cxled)
> +bool __platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled)
>  {
>  	const struct range *rd_r, *sd_r;
>  	int align;
> @@ -47,9 +50,10 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_NS_GPL(__platform_cxlrd_matches_cxled, "CXL");
>  
>  /**
> - * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
> + * __platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
>   * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
>   * @p: Region Params against which @cxled is matched.
>   * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
> @@ -59,8 +63,8 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
>   *
>   * Return: true if a Decoder matches a Region, else false.
>   */
> -bool platform_region_matches_cxld(const struct cxl_region_params *p,
> -				  const struct cxl_decoder *cxld)
> +bool __platform_region_matches_cxld(const struct cxl_region_params *p,
> +				    const struct cxl_decoder *cxld)
>  {
>  	const struct range *r = &cxld->hpa_range;
>  	const struct resource *res = p->res;
> @@ -73,6 +77,7 @@ bool platform_region_matches_cxld(const struct cxl_region_params *p,
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_NS_GPL(__platform_region_matches_cxld, "CXL");
>  
>  void platform_res_adjust(struct resource *res,
>  			 struct cxl_endpoint_decoder *cxled,
> diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
> index a15592b4e90e..bdea00365dad 100644
> --- a/drivers/cxl/core/platform_quirks.h
> +++ b/drivers/cxl/core/platform_quirks.h
> @@ -1,4 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2025 Intel Corporation. */
> +
> +#ifndef __PLATFORM_QUIRKS_H__
> +#define __PLATFORM_QUIRKS_H__
>  
>  #include "cxl.h"
>  
> @@ -7,13 +11,17 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
>  				  const struct cxl_endpoint_decoder *cxled);
>  bool platform_region_matches_cxld(const struct cxl_region_params *p,
>  				  const struct cxl_decoder *cxld);
> +bool __platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled);
> +bool __platform_region_matches_cxld(const struct cxl_region_params *p,
> +				    const struct cxl_decoder *cxld);
>  void platform_res_adjust(struct resource *res,
>  			 struct cxl_endpoint_decoder *cxled,
>  			 const struct cxl_root_decoder *cxlrd);
>  #else
>  static inline bool
> -platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> -			       const struct cxl_endpoint_decoder *cxled)
> +platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +			     const struct cxl_endpoint_decoder *cxled)
>  {
>  	return false;
>  }
> @@ -31,3 +39,11 @@ inline void platform_res_adjust(struct resource *res,
>  {
>  }
>  #endif /* CONFIG_CXL_PLATFORM_QUIRKS */
> +
> +#ifndef CXL_TEST_ENABLE
> +#define DECLARE_TESTABLE(x) __##x
> +#define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
> +#define platform_region_matches_cxld DECLARE_TESTABLE(platform_region_matches_cxld)
> +#endif
> +
> +#endif /* __PLATFORM_QUIRKS_H__ */
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> index 6754de35598d..a9e37156d126 100644
> --- a/tools/testing/cxl/cxl_core_exports.c
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -3,6 +3,7 @@
>  
>  #include "cxl.h"
>  #include "exports.h"
> +#include "platform_quirks.h"
>  
>  /* Exporting of cxl_core symbols that are only used by cxl_test */
>  EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
> @@ -27,3 +28,25 @@ int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
>  	return _devm_cxl_switch_port_decoders_setup(port);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
> +
> +platform_cxlrd_matches_cxled_fn _platform_cxlrd_matches_cxled =
> +	__platform_cxlrd_matches_cxled;
> +EXPORT_SYMBOL_NS_GPL(_platform_cxlrd_matches_cxled, "CXL");
> +
> +bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled)
> +{
> +	return _platform_cxlrd_matches_cxled(cxlrd, cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(platform_cxlrd_matches_cxled, "CXL");
> +
> +platform_region_matches_cxld_fn _platform_region_matches_cxld =
> +	__platform_region_matches_cxld;
> +EXPORT_SYMBOL_NS_GPL(_platform_region_matches_cxld, "CXL");
> +
> +bool platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld)
> +{
> +	return _platform_region_matches_cxld(p, cxld);
> +}
> +EXPORT_SYMBOL_NS_GPL(platform_region_matches_cxld, "CXL");
> diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
> index 7ebee7c0bd67..e0e4c58dadf2 100644
> --- a/tools/testing/cxl/exports.h
> +++ b/tools/testing/cxl/exports.h
> @@ -10,4 +10,11 @@ extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
>  typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
>  extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
>  
> +typedef bool(*platform_cxlrd_matches_cxled_fn)(const struct cxl_root_decoder *cxlrd,
> +					       const struct cxl_endpoint_decoder *cxled);
> +extern platform_cxlrd_matches_cxled_fn _platform_cxlrd_matches_cxled;
> +
> +typedef bool(*platform_region_matches_cxld_fn)(const struct cxl_region_params *p,
> +					       const struct cxl_decoder *cxld);
> +extern platform_region_matches_cxld_fn _platform_region_matches_cxld;
>  #endif
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2d135ca533d0..ada431b180f4 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -9,6 +9,8 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/mm.h>
> +
> +#include <platform_quirks.h>
>  #include <cxlmem.h>
>  
>  #include "../watermark.h"
> @@ -213,7 +215,11 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
> +#if defined(CONFIG_CXL_PLATFORM_QUIRKS)
> +			.window_size = SZ_256M * 3UL,
> +#else
>  			.window_size = SZ_256M * 4UL,
> +#endif
>  		},
>  		.target = { 0 },
>  	},
> @@ -426,6 +432,13 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  	return res;
>  }
>  
> +static u64 mock_cfmws0_range_start;
> +
> +static void set_mock_cfmws0_range_start(u64 start)
> +{
> +	mock_cfmws0_range_start = start;
> +}
> +
>  static int populate_cedt(void)
>  {
>  	struct cxl_mock_res *res;
> @@ -454,6 +467,8 @@ static int populate_cedt(void)
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;
> +		if (i == 0)
> +			set_mock_cfmws0_range_start(res->range.start);
>  	}
>  
>  	return 0;
> @@ -738,7 +753,11 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *port, *iter;
> +#if defined(CONFIG_CXL_PLATFORM_QUIRKS)
> +	const int size = SZ_1G;
> +#else
>  	const int size = SZ_512M;
> +#endif
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
>  	struct device *dev;
> @@ -1103,6 +1122,39 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	cxl_endpoint_get_perf_coordinates(port, ep_c);
>  }
>  
> +static bool
> +mock_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *rd_r, *ed_r;
> +	int align;
> +
> +	rd_r = &cxlrd->cxlsd.cxld.hpa_range;
> +	ed_r = &cxled->cxld.hpa_range;
> +	align = cxled->cxld.interleave_ways * SZ_256M;
> +
> +	return rd_r->start == mock_cfmws0_range_start &&
> +	       rd_r->start == ed_r->start &&
> +	       rd_r->end < (mock_cfmws0_range_start + SZ_4G) &&
> +	       rd_r->end < ed_r->end &&
> +	       IS_ALIGNED(range_len(ed_r), align);
> +}
> +
> +static bool
> +mock_platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int align = cxld->interleave_ways * SZ_256M;
> +
> +	return res->start == mock_cfmws0_range_start &&
> +	       res->start == r->start &&
> +	       res->end < (mock_cfmws0_range_start + SZ_4G) &&
> +	       res->end < r->end &&
> +	       IS_ALIGNED(range_len(r), align);
> +}
> +
>  static struct cxl_mock_ops cxl_mock_ops = {
>  	.is_mock_adev = is_mock_adev,
>  	.is_mock_bridge = is_mock_bridge,
> @@ -1117,6 +1169,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>  	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
> +	.platform_cxlrd_matches_cxled = mock_platform_cxlrd_matches_cxled,
> +	.platform_region_matches_cxld = mock_platform_region_matches_cxld,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>  };
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 995269a75cbd..45d8fe67e3e9 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -7,6 +7,8 @@
>  #include <linux/export.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
> +
> +#include <platform_quirks.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include "mock.h"
> @@ -18,6 +20,12 @@ static struct cxl_dport *
>  redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  				   struct device *dport_dev);
>  static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> +static bool
> +redirect_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				      const struct cxl_endpoint_decoder *cxled);
> +static bool
> +redirect_platform_region_matches_cxld(const struct cxl_region_params *p,
> +				      const struct cxl_decoder *cxld);
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
> @@ -25,6 +33,8 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
>  	_devm_cxl_switch_port_decoders_setup =
>  		redirect_devm_cxl_switch_port_decoders_setup;
> +	_platform_cxlrd_matches_cxled = redirect_platform_cxlrd_matches_cxled;
> +	_platform_region_matches_cxld = redirect_platform_region_matches_cxld;
>  }
>  EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>  
> @@ -35,6 +45,8 @@ void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  	_devm_cxl_switch_port_decoders_setup =
>  		__devm_cxl_switch_port_decoders_setup;
>  	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
> +	_platform_cxlrd_matches_cxled = __platform_cxlrd_matches_cxled;
> +	_platform_region_matches_cxld = __platform_region_matches_cxld;
>  	list_del_rcu(&ops->list);
>  	synchronize_srcu(&cxl_mock_srcu);
>  }
> @@ -285,6 +297,42 @@ struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  	return dport;
>  }
>  
> +static bool
> +redirect_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				      const struct cxl_endpoint_decoder *cxled)
> +{
> +	int index;
> +	bool match;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
> +
> +	if (ops && ops->is_mock_port(port->uport_dev))
> +		match = ops->platform_cxlrd_matches_cxled(cxlrd, cxled);
> +	else
> +		match = __platform_cxlrd_matches_cxled(cxlrd, cxled);
> +	put_cxl_mock_ops(index);
> +
> +	return match;
> +}
> +
> +static bool
> +redirect_platform_region_matches_cxld(const struct cxl_region_params *p,
> +				      const struct cxl_decoder *cxld)
> +{
> +	int index;
> +	bool match;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	if (ops && ops->is_mock_port(port->uport_dev))
> +		match = ops->platform_region_matches_cxld(p, cxld);
> +	else
> +		match = __platform_region_matches_cxld(p, cxld);
> +	put_cxl_mock_ops(index);
> +
> +	return match;
> +}
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("cxl_test: emulation module");
>  MODULE_IMPORT_NS("ACPI");
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 4ed932e76aae..803d7cc0197c 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -25,6 +25,10 @@ struct cxl_mock_ops {
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
>  	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(struct cxl_port *port,
>  						       struct device *dport_dev);
> +	bool (*platform_cxlrd_matches_cxled)(const struct cxl_root_decoder *cxlrd,
> +					     const struct cxl_endpoint_decoder *cxled);
> +	bool (*platform_region_matches_cxld)(const struct cxl_region_params *p,
> +					     const struct cxl_decoder *cxld);
>  };
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);

