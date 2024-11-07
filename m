Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE02170C0;
	Thu,  7 Nov 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011772; cv=none; b=DqtxZYW/0Pfn56svgtAMK1sGHBciIbiRWsZS2Db4KU99io/JO1oKs2hO6mxmvvdg+O7DRuJWVfptD0ctb6kodNCweBTjnTPW+euv0cUGBL7m5DL3d3g2sXgzMbDSkZaM5TSOLuqE/EccImfcmPNOHRduPBW8Iclw9SwiQtPiduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011772; c=relaxed/simple;
	bh=XfqqrtBGoSGJ2BwEfPXR/s3qyCN+FjRyQHY0z68HSak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXlkvFPbwo6E81AdVLMnaRcgyfyCp8P/bg9KFGG+GIPKdRQQrk7Rk3vxlKxPhmC7cX8yxDIp+NqYhvXO/Eq8VExAPaXF04gysqDUdlg4qm1fR3GGui+2O05ELse7n+zwx2T11DXZN7fgKCIrQTg4sHT1xuncFeH3MqoFZnGjWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWu+cpfm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWu+cpfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731011771; x=1762547771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfqqrtBGoSGJ2BwEfPXR/s3qyCN+FjRyQHY0z68HSak=;
  b=eWu+cpfmzKwgF0I6y0RrefIUklJ/x9LzzZMsMKD7TbVye0nNwOUq5WUE
   ukw/Yi9NZ5b3FUtlrp3E93i5EMcTdUzf9U+OsPhLcrqPPfWbPnJELF36f
   Ige/jCBn2BQ2Z78cnDrOQ6mRuVOUAvaE6HmFv+x7VkdAmrvPvSgPAM2qE
   oYw4tcfIe99VTHDaOfa1z/sSdNu+V01Um+Px1dYYpe8Kd6uFIUO4O81N+
   NM8VFcqBHtDjlH9XtBZhT7iqP+vhlQjmPYG/NBjDtHjwYbUAxqoxAGsgL
   k0fSCjcK57dKx1+u7TIm6t+34NKbBJWsG7AYNMKfm9Tskiv/PuVqjMC+c
   g==;
X-CSE-ConnectionGUID: rTEn5CG5RduTTUMkvK3z1g==
X-CSE-MsgGUID: MGMd/teGSv2I4p3A/PFkEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41439442"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41439442"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:36:10 -0800
X-CSE-ConnectionGUID: HAtO8oC8QT6krMNPj4K8JA==
X-CSE-MsgGUID: nhO0GC84RjmtJKwCFbdd+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="122739705"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:36:09 -0800
Date: Thu, 7 Nov 2024 12:36:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
References: <20241104084110.583710-1-ying.huang@intel.com>
 <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
 <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Nov 06, 2024 at 10:43:30AM +0800, Ying Huang wrote:
> Alison Schofield <alison.schofield@intel.com> writes:
> 
> > On Mon, Nov 04, 2024 at 04:41:10PM +0800, Ying Huang wrote:
> >> According to the description of the "Window Restrictions" field of
> >> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
> >> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
> >> formerly known as "CXL Type 2 Memory" and renamed to "Device
> >> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
> >> and renamed to "Host-only Coherent".  Because type 3 memory can only
> >> be host-only coherent before, while it can be host-only coherent or
> >> device coherent with "Back-Invalidate" now.
> >> 
> >> To avoid confusion about type 2/3 memory and device/host-only coherent
> >> in Linux kernel, the patch renames corresponding bit definition from
> >> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
> >> ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
> >> code consistent with the spec too.
> >> 
> >> The patch also renames the corresponding cxl_decoder flags
> >> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.
> >> 
> >> No functionality change is expected.
> >> 
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >> Reviewed-by: Gregory Price <gourry@gourry.net>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Dave Jiang <dave.jiang@intel.com>
> >> Cc: Alison Schofield <alison.schofield@intel.com>
> >> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Cc: Alejandro Lucero <alucerop@amd.com>
> >> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> >> ---
> >>  drivers/cxl/acpi.c           |  8 ++++----
> >>  drivers/cxl/core/port.c      |  8 ++++----
> >>  drivers/cxl/cxl.h            | 14 +++++++-------
> >>  include/acpi/actbl1.h        | 10 +++++-----
> >>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
> >>  5 files changed, 29 insertions(+), 29 deletions(-)
> >> 
> >> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> >> index 82b78e331d8e..aca8cbb7540d 100644
> >> --- a/drivers/cxl/acpi.c
> >> +++ b/drivers/cxl/acpi.c
> >> @@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
> >>  {
> >>  	unsigned long flags = CXL_DECODER_F_ENABLE;
> >>  
> >> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> >> -		flags |= CXL_DECODER_F_TYPE2;
> >> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> >> -		flags |= CXL_DECODER_F_TYPE3;
> >> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
> >> +		flags |= CXL_DECODER_F_DEVMEM;
> >> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
> >> +		flags |= CXL_DECODER_F_HOSTONLYMEM;
> >>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> >>  		flags |= CXL_DECODER_F_RAM;
> >>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index a5e6f3d23cfb..8524714968fd 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
> >>  
> >>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
> >>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> >> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> >> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> >> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
> >> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYMEM);
> >>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> >>  
> > Hi Ying,
> 
> Hi, Alison,
> 
> >
> > The commit log explains that type3 can now be 'either/or', so does
> > cap_type3_show() need to emit true for either:
> > 	(flags & CXL_DECODER_F_HOSTONLYMEM)
> > 	or
> > 	(flags & CXL_DECODER_F_DEVMEM) & 'back invalidate')
> >
> > Does this explanation in the ABI need updating:
> > What:           /sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> > Date:           June, 2021
> > KernelVersion:  v5.14
> > Contact:        linux-cxl@vger.kernel.org
> > Description:
> >                 (RO) When a CXL decoder is of devtype "cxl_decoder_root", it
> >                 represents a fixed memory window identified by platform
> >                 firmware. A fixed window may only support a subset of memory
> >                 types. The 'cap_*' attributes indicate whether persistent
> >                 memory, volatile memory, accelerator memory, and / or expander
> >                 memory may be mapped behind this decoder's memory window.
> 
> I think so too.  However, I prefer to keep this patch just mechanic
> renaming and do these changes in another patch.  Do you agree?
> 

I don't know. I was just questioning where and how far the naming scheme
needs to change.

Maybe Jonathan, as the Suggested-by, can chime in and move this ahead.


> --
> Best Regards,
> Huang, Ying
> 
> >
> >>  static ssize_t target_type_show(struct device *dev,
> >> @@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
> >>  
> >>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
> >>  {
> >> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> >> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_PMEM;
> >>  
> >>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> >>  }
> >>  
> >>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
> >>  {
> >> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> >> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_RAM;
> >>  
> >>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> >>  }
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index 0fc96f8bf15c..b9083ce1cf74 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> >>   * Additionally indicate whether decoder settings were autodetected,
> >>   * user customized.
> >>   */
> >> -#define CXL_DECODER_F_RAM   BIT(0)
> >> -#define CXL_DECODER_F_PMEM  BIT(1)
> >> -#define CXL_DECODER_F_TYPE2 BIT(2)
> >> -#define CXL_DECODER_F_TYPE3 BIT(3)
> >> -#define CXL_DECODER_F_LOCK  BIT(4)
> >> -#define CXL_DECODER_F_ENABLE    BIT(5)
> >> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> >> +#define CXL_DECODER_F_RAM         BIT(0)
> >> +#define CXL_DECODER_F_PMEM        BIT(1)
> >> +#define CXL_DECODER_F_DEVMEM      BIT(2)
> >> +#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
> >> +#define CXL_DECODER_F_LOCK        BIT(4)
> >> +#define CXL_DECODER_F_ENABLE      BIT(5)
> >> +#define CXL_DECODER_F_MASK        GENMASK(5, 0)
> >>  
> >>  enum cxl_decoder_type {
> >>  	CXL_DECODER_DEVMEM = 2,
> >> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> >> index 199afc2cd122..e195909928df 100644
> >> --- a/include/acpi/actbl1.h
> >> +++ b/include/acpi/actbl1.h
> >> @@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
> >>  
> >>  /* Values for Restrictions field above */
> >>  
> >> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> >> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> >> -#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
> >> -#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
> >> -#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> >> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
> >> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
> >> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
> >> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
> >> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
> >>  
> >>  /* 2: CXL XOR Interleave Math Structure */
> >>  
> >> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> >> index 90d5afd52dd0..9d919fc99f6b 100644
> >> --- a/tools/testing/cxl/test/cxl.c
> >> +++ b/tools/testing/cxl/test/cxl.c
> >> @@ -209,7 +209,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 0,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 4UL,
> >> @@ -224,7 +224,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 1,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 8UL,
> >> @@ -239,7 +239,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 0,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 4UL,
> >> @@ -254,7 +254,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 1,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 8UL,
> >> @@ -269,7 +269,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 0,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 4UL,
> >> @@ -284,7 +284,7 @@ static struct {
> >>  			},
> >>  			.interleave_ways = 0,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M,
> >> @@ -301,7 +301,7 @@ static struct {
> >>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> >>  			.interleave_ways = 0,
> >>  			.granularity = 4,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 8UL,
> >> @@ -317,7 +317,7 @@ static struct {
> >>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> >>  			.interleave_ways = 1,
> >>  			.granularity = 0,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 8UL,
> >> @@ -333,7 +333,7 @@ static struct {
> >>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> >>  			.interleave_ways = 2,
> >>  			.granularity = 0,
> >> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >>  			.qtg_id = FAKE_QTG_ID,
> >>  			.window_size = SZ_256M * 16UL,
> >> -- 
> >> 2.39.2
> >> 
