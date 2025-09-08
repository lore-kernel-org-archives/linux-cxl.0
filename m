Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC361FDA;
	Mon,  8 Sep 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355967; cv=none; b=PAriX0+bvqA0qfzaHK4s7vn+MBWbKvnwJS4msk4RFkZ3baBS9Ga+kVS4shCekIaonDZ6LRG+JNiNLKwcLBK/ngxkTuu3S7QLFGznyTX/RZgPGxSJvvKctGIAckmg5cK43rz93K/4U7YhHu9A33FxAOZ8kg71AKfHIz93x/h5TwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355967; c=relaxed/simple;
	bh=BArk+9RUuAenGwgsVWw+f03CYYkNBYoYVP2na384Lxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atc8EyH5w1+hbDFY9PwfZhoVsCj8j0Mms9vscsDh7xOqyNXaDD4gioLCuD2k+BeqfNM1cOWK60uLe8MURGM0FfYwdn3DtvM1Ma2/SES7DDqBn55pANCdAajQPFFOJL64hC0uhx/O4ml6aRY2Oq+XuaDmmV7qKd3rMWrb6PNtiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQEzlr6o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQEzlr6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757355965; x=1788891965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BArk+9RUuAenGwgsVWw+f03CYYkNBYoYVP2na384Lxw=;
  b=mQEzlr6ouWd4wlYEX7H1VZrCFQIDTicmV7ph7PM0t1qhWXaD9/Jd6NNK
   etBP0S+tl8Vlns3BJiBi1ATrBOBu+90B9Bro9jvqJyZraCtYVu+TUckoy
   /sZ+N6/7Zp1G/bv4pjpmTY2K7loGqzOd2ct6u3VqCh49LBQRWc1szjT5O
   /2oPSFDahYvRbyqhdGCUE2nq8oNj6Z4lHs0lmDVQtsEzkSDxwYLube53q
   EviFzlWfoZae/GaoNthVFm7wXAIcDNye4b7u7VhV+kLCY+jyc2OXqTuZ9
   f+LiJ3OObIUf5aVQ1HsA57r8YlQHMD9ocQbj4qjwyu/ltXNBr36dtwBwF
   A==;
X-CSE-ConnectionGUID: jvSFvnHSS8efuTu2dbGbrw==
X-CSE-MsgGUID: CEup9h6nSPuH6AhOXz9xOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70997731"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="70997731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 11:26:04 -0700
X-CSE-ConnectionGUID: IJz3tRTJRdmk77lfEoZAlw==
X-CSE-MsgGUID: tcfX6JFdQZ+X92SlqIt8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172999960"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.113]) ([10.125.110.113])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 11:26:04 -0700
Message-ID: <25a2be9a-a702-4db2-9db7-6f76348d89fd@intel.com>
Date: Mon, 8 Sep 2025 11:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v4] cxl/test: Simulate an x86 Low Memory Hole for
 tests
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-5-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724142144.776992-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 7:20 AM, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> to 1GB.
> 
> The auto-created region of cxl-test uses mock_cfmws[0], therefore the LMH
> path in the CXL Driver will be exercised every time the cxl-test module is
> loaded. Executing unit test: cxl-topology.sh, confirms the region created
> successfully with a LMH.
> 
> Since mock_cfmws[0] range base address is typically different from the one
> published by the BIOS on real hardware, the driver would fail to create and
> attach CXL Regions when it's run on the mock environment created by
> cxl-tests.
> 
> Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> Root Decoders and Regions with Endpoint Decoders when the driver is run on
> mock devices.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/platform.c       |   9 +-
>  tools/testing/cxl/Kbuild          |   1 +
>  tools/testing/cxl/mock_platform.c | 137 ++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/cxl.c      |  10 +++
>  tools/testing/cxl/test/mock.h     |   1 +
>  5 files changed, 154 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/cxl/mock_platform.c
> 
> diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
> index 8202750742d0..ba1dafece495 100644
> --- a/drivers/cxl/core/platform.c
> +++ b/drivers/cxl/core/platform.c
> @@ -17,8 +17,9 @@
>   * also larger than that of the matching root decoder. If there are LMH's,
>   * the root decoder range end is always less than SZ_4G.
>   */
> -bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> -				    const struct cxl_endpoint_decoder *cxled)
> +__weak bool
> +platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +			       const struct cxl_endpoint_decoder *cxled)

Can you take a look at this and see if something similar can be used instead of what you are doing here? Would prefer not introduce a third type of emulation.

https://lore.kernel.org/linux-cxl/20250829180928.842707-8-dave.jiang@intel.com/T/#u

>  {
>  	const struct range *r1, *r2;
>  	int niw;
> @@ -39,8 +40,8 @@ bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
>   * Similar to platform_root_decoder_contains(), it matches regions and
>   * decoders
>   */
> -bool platform_region_contains(const struct cxl_region_params *p,
> -			      const struct cxl_decoder *cxld)
> +__weak bool platform_region_contains(const struct cxl_region_params *p,
> +				     const struct cxl_decoder *cxld)
>  {
>  	const struct range *r = &cxld->hpa_range;
>  	const struct resource *res = p->res;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 77e392c4b541..64c5c8c34805 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -66,6 +66,7 @@ cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += mock_platform.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> diff --git a/tools/testing/cxl/mock_platform.c b/tools/testing/cxl/mock_platform.c
> new file mode 100644
> index 000000000000..1775c64b3c7c
> --- /dev/null
> +++ b/tools/testing/cxl/mock_platform.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/completion.h>
> +#include <linux/module.h>
> +#include <linux/range.h>
> +#include <linux/pci.h>
> +
> +#include <cxlmem.h>
> +#include <platform.h>
> +#include "test/mock.h"
> +
> +static u64 mock_cfmws0_range_start;
> +
> +void set_mock_cfmws0_range_start(u64 start)
> +{
> +	mock_cfmws0_range_start = start;
> +}
> +EXPORT_SYMBOL_NS_GPL(set_mock_cfmws0_range_start, "CXL");
> +
> +static bool is_mock_port(struct device *dev)
> +{
> +	struct cxl_mock_ops *(*get_ops_fn)(int *index);
> +	struct cxl_mock_ops *ops = NULL;
> +	void (*put_ops_fn)(int index);
> +	bool is_mock = false;
> +	int index;
> +
> +	get_ops_fn = symbol_get(get_cxl_mock_ops);
> +	if (!get_ops_fn)
> +		return false;
> +	put_ops_fn = symbol_get(put_cxl_mock_ops);
> +	if (!put_ops_fn)
> +		goto out;
> +
> +	ops = get_ops_fn(&index);
> +	if (ops)
> +		is_mock = ops->is_mock_port(dev);
> +	put_ops_fn(index);
> +
> +out:
> +	symbol_put(get_cxl_mock_ops);
> +
> +	return is_mock;
> +}
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL
> +
> +static bool
> +real_platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;

cxlsd_range
cxled_range

Makes it easier to read vs r1 and r2 and knowing what's being compared.

> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))

Can this check be turned into a helper function? Also, maybe line it up with one check per line. Otherwise it looks rather confusing. Comment applies to rest of the patch.

DJ

> +		return true;
> +
> +	return false;
> +}
> +
> +static bool
> +cxl_test_platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +					const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == mock_cfmws0_range_start && r1->start == r2->start &&
> +	    r1->end < (mock_cfmws0_range_start + SZ_4G) && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
> +
> +	if (is_mock_port(port->uport_dev))
> +		return cxl_test_platform_root_decoder_contains(cxlrd, cxled);
> +
> +	return real_platform_root_decoder_contains(cxlrd, cxled);
> +}
> +
> +static bool real_platform_region_contains(const struct cxl_region_params *p,
> +					  const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool cxl_test_platform_region_contains(const struct cxl_region_params *p,
> +					      const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == mock_cfmws0_range_start && res->start == r->start &&
> +	    res->end < (mock_cfmws0_range_start + SZ_4G) && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +bool platform_region_contains(const struct cxl_region_params *p,
> +			      const struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	if (is_mock_port(port->uport_dev))
> +		return cxl_test_platform_region_contains(p, cxld);
> +
> +	return real_platform_region_contains(p, cxld);
> +}
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..a411c055d390 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -212,7 +212,11 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
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
> @@ -453,6 +457,8 @@ static int populate_cedt(void)
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;
> +		if (i == 0)
> +			set_mock_cfmws0_range_start(res->range.start);
>  	}
>  
>  	return 0;
> @@ -744,7 +750,11 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index d1b0271d2822..792eabbd0f18 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -32,3 +32,4 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops);
>  void unregister_cxl_mock_ops(struct cxl_mock_ops *ops);
>  struct cxl_mock_ops *get_cxl_mock_ops(int *index);
>  void put_cxl_mock_ops(int index);
> +void set_mock_cfmws0_range_start(u64 start);

