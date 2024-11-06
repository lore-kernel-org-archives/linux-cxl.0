Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2D18FDB1;
	Wed,  6 Nov 2024 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860057; cv=none; b=P38XTy51+xK3hDd5S+CYSnuTDXJZHPPBO/5CAHK6UUKIu6H4pgaJBfwgeR/7WKTyopqtnVq0IQYLMkvLUk8E0kGZQT+mJKXiYr/08z0IfoADeXcCxqAu/CFyskg8Xe6eoyB/9on1gykecvEmvjq916OI2sWSCT7M0olImV+qOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860057; c=relaxed/simple;
	bh=g6ZfMhBLEvoKOumAv6UhaSx1EUyBHwUBt/6Fc4kC0ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMUQlbvsf/KmIezABKGoJQPgUdIvks+iRlBLiKQezHRPVX9xhC85kS5zawG22Gc044TQ0CtQaM91Czzgy/GJbr9/nwTOjLvPqRGSd9aBctvlu/08MIrw3Kqu5d8InviXUdLVCHgjBTeh3/wgr+ypvEbHdLneWWGblRm/ufB6Y5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvDnsuNm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvDnsuNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730860055; x=1762396055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6ZfMhBLEvoKOumAv6UhaSx1EUyBHwUBt/6Fc4kC0ls=;
  b=dvDnsuNmDSPyZcneEK4WHrf8m6zdfJi++d2lA6bZ/auL8fdxzm/PB4RV
   A3jB4PaupXirJctd1X230oq0Pp+HNJTTE+l5Mg9dx8o0OVdqXt0cS34La
   pzbZtFuIUrSzWIYMMQJOci2/sTSwJOfEI2mkQHNboyHMxLCPImCjTJlUx
   7iDlbmCB/K8twuH0wjOgTmtEs53xenIvpdsovsgh5SRqN/NMgE+giLfNe
   WwvcRRuYyp0eoXJsNk4qpQzx2yC9iAEfJuF7KD7MU0bOPEGkdvC59LIbP
   fB3N8O+LA1zxsTNGmL1cZU1TGfEnWAROjY4mrY3ksa6l6Cvx87XqTtZmS
   w==;
X-CSE-ConnectionGUID: sUyXuCfjTDSSNus/ZDz9xg==
X-CSE-MsgGUID: kg5utyQeSrK6I770DifwVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30860092"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30860092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 18:27:34 -0800
X-CSE-ConnectionGUID: xHS75nBGRxq7yG8RZ9y2PA==
X-CSE-MsgGUID: hnnr/LmvQwOe9YLrQ8L41g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84368158"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 18:27:34 -0800
Date: Tue, 5 Nov 2024 18:27:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Gregory Price <gourry@gourry.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
References: <20241104084110.583710-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104084110.583710-1-ying.huang@intel.com>

On Mon, Nov 04, 2024 at 04:41:10PM +0800, Ying Huang wrote:
> According to the description of the "Window Restrictions" field of
> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
> formerly known as "CXL Type 2 Memory" and renamed to "Device
> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
> and renamed to "Host-only Coherent".  Because type 3 memory can only
> be host-only coherent before, while it can be host-only coherent or
> device coherent with "Back-Invalidate" now.
> 
> To avoid confusion about type 2/3 memory and device/host-only coherent
> in Linux kernel, the patch renames corresponding bit definition from
> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
> ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
> code consistent with the spec too.
> 
> The patch also renames the corresponding cxl_decoder flags
> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.
> 
> No functionality change is expected.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/acpi.c           |  8 ++++----
>  drivers/cxl/core/port.c      |  8 ++++----
>  drivers/cxl/cxl.h            | 14 +++++++-------
>  include/acpi/actbl1.h        | 10 +++++-----
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..aca8cbb7540d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> -		flags |= CXL_DECODER_F_TYPE2;
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> -		flags |= CXL_DECODER_F_TYPE3;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
> +		flags |= CXL_DECODER_F_DEVMEM;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
> +		flags |= CXL_DECODER_F_HOSTONLYMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a5e6f3d23cfb..8524714968fd 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYMEM);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>  
Hi Ying,

The commit log explains that type3 can now be 'either/or', so does
cap_type3_show() need to emit true for either:
	(flags & CXL_DECODER_F_HOSTONLYMEM)
	or
	(flags & CXL_DECODER_F_DEVMEM) & 'back invalidate')

Does this explanation in the ABI need updating:
What:           /sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
Date:           June, 2021
KernelVersion:  v5.14
Contact:        linux-cxl@vger.kernel.org
Description:
                (RO) When a CXL decoder is of devtype "cxl_decoder_root", it
                represents a fixed memory window identified by platform
                firmware. A fixed window may only support a subset of memory
                types. The 'cap_*' attributes indicate whether persistent
                memory, volatile memory, accelerator memory, and / or expander
                memory may be mapped behind this decoder's memory window.

--Alison


>  static ssize_t target_type_show(struct device *dev,
> @@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_PMEM;
>  
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_RAM;
>  
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0fc96f8bf15c..b9083ce1cf74 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   * Additionally indicate whether decoder settings were autodetected,
>   * user customized.
>   */
> -#define CXL_DECODER_F_RAM   BIT(0)
> -#define CXL_DECODER_F_PMEM  BIT(1)
> -#define CXL_DECODER_F_TYPE2 BIT(2)
> -#define CXL_DECODER_F_TYPE3 BIT(3)
> -#define CXL_DECODER_F_LOCK  BIT(4)
> -#define CXL_DECODER_F_ENABLE    BIT(5)
> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> +#define CXL_DECODER_F_RAM         BIT(0)
> +#define CXL_DECODER_F_PMEM        BIT(1)
> +#define CXL_DECODER_F_DEVMEM      BIT(2)
> +#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
> +#define CXL_DECODER_F_LOCK        BIT(4)
> +#define CXL_DECODER_F_ENABLE      BIT(5)
> +#define CXL_DECODER_F_MASK        GENMASK(5, 0)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 199afc2cd122..e195909928df 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
>  
>  /* Values for Restrictions field above */
>  
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
> -#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
> -#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
>  
>  /* 2: CXL XOR Interleave Math Structure */
>  
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 90d5afd52dd0..9d919fc99f6b 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -209,7 +209,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -224,7 +224,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -239,7 +239,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -254,7 +254,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -269,7 +269,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -284,7 +284,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M,
> @@ -301,7 +301,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -317,7 +317,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 1,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -333,7 +333,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 2,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 16UL,
> -- 
> 2.39.2
> 
