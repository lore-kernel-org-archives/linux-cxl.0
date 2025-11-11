Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45E311C3F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870205; cv=none; b=FuGA/R3Ufeb3rhOhF4PNdOwTCBn1wPOWMxFeS1ahiMbQ9mhrF27N7wx7QvF7Sc7ztdNM3+NhURkDN4qTcxj6iG9Ia+COoxm1nL0jv4WLKSzn3QUpxi8gGmR6uG4kREZ4goDeeKwdKPTwelUk5bSY1cdhdRuvoS7Aj93DioHkVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870205; c=relaxed/simple;
	bh=L1Ab7nIDPvBQtwcuauMmrw7KrW4pCuZd+p4+rtjq1tM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEpEqzFfSX8jdToMpsq+/reg6iNFM7RamSaZCr1AwsdQqe9lKiQtZYG5bGc8rNT4MM0iY64Tmb/6RJF8osMwukI3axp7q0JuRWoVqubRePbLah6LJEjDFoEF87yrqcSeIMfDUbSwOHpcOqtrqQ1ZS4SIFA/w2RLBr2+j7pvTiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5T1P4fPrzJ46CW;
	Tue, 11 Nov 2025 22:09:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 98E19140122;
	Tue, 11 Nov 2025 22:10:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:10:00 +0000
Date: Tue, 11 Nov 2025 14:09:58 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/4] cxl/test: Add cxl_test CFMWS support for extended
 linear cache
Message-ID: <20251111140958.00001a62@huawei.com>
In-Reply-To: <20251031173224.3537030-3-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
	<20251031173224.3537030-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 31 Oct 2025 10:32:22 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a module parameter to allow activation of extended linear cache
> on the auto region for cxl_test. The current platform implementation
> for extended linear cache is 1:1 of DRAM and CXL memory. A CFMWS is
> created with the size of both memory together where DRAM takes the
> first part of the memory range and CXL covers the second part. The
> current CXL auto region on cxl_test consists of 2 256M devices that
> creates a 512M region. The new extended linear cache setup will have
> 512M DRAM and 512M CXL memory for a total of 1G CFMWS. The hardware
> decoders must have their starting offset moved to after the DRAM region
> to handle the CXL regions.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Trivial comment though - feel free to ignore.
> ---
>  tools/testing/cxl/test/cxl.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index d53b72bc034f..4e9007f2d510 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -15,6 +15,7 @@
>  #include "mock.h"
>  
>  static int interleave_arithmetic;
> +static bool extended_linear_cache;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -428,6 +429,24 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  	return res;
>  }
>  
> +/*
> + * Only update CFMWS0 as this is used by the auto region.
Single line comment syntax seems fine here.  Slightly less scrolling always
preferred!

> + */
> +static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
> +{
> +	if (!extended_linear_cache)
> +		return;
> +
> +	if (index != 0)
> +		return;
> +
> +	/*
> +	 * The window size should be 2x of the CXL region size where half is
> +	 * DRAM and half is CXL
> +	 */
> +	window->window_size = MOCK_AUTO_REGION_SIZE * 2;
> +}
> +
>  static int populate_cedt(void)
>  {
>  	struct cxl_mock_res *res;
> @@ -452,6 +471,7 @@ static int populate_cedt(void)
>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
>  
> +		cfmws_elc_update(window, i);
>  		res = alloc_mock_res(window->window_size, SZ_256M);
>  		if (!res)
>  			return -ENOMEM;
> @@ -782,6 +802,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	}
>  
>  	base = window->base_hpa;
> +	if (extended_linear_cache)
> +		base += MOCK_AUTO_REGION_SIZE;
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + MOCK_AUTO_REGION_SIZE - 1,
> @@ -1608,6 +1630,8 @@ static __exit void cxl_test_exit(void)
>  
>  module_param(interleave_arithmetic, int, 0444);
>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
> +module_param(extended_linear_cache, bool, 0444);
> +MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

