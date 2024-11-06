Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60828A47;
	Wed,  6 Nov 2024 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861229; cv=none; b=k0GJEn1pWnOBEMsXUFP2MLzSq7ghQsq04dXUkgEmfEY+7J4NfjqoYxMVc5Kvr5S/8Uh7jseMHf+8Xp9BL8FZVEhl9MuZqtv/8YnekIP16u1wWpokUG3o+jbtPCnm8x+mqV3iZ9WmLUAqQqsgJnhWnLp6onhcaBwhNsbn38oLGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861229; c=relaxed/simple;
	bh=DdfIxqlQlz3pdCPcOkvTnG+GvT+X5p3zUaHfIjMSHnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kf3Mn/BYJrsY3Ob6NRo7is6ehtSNQf0Q+A4z7nr39ZR7ywgro9nmRb3EOFd4vusCHvcEhrETAudI4rLe3ZaX3hPd2e7PplWMnnkZsriH7m4sD/56DoEpa/uhyUY+0yN/uDA3niu9dSd8bqnOdYrs0uwtQSzunbUacT7xPOJZG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lN3cGSRQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lN3cGSRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730861227; x=1762397227;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DdfIxqlQlz3pdCPcOkvTnG+GvT+X5p3zUaHfIjMSHnU=;
  b=lN3cGSRQ5okF1I6w7t9baENknA081B5YHJCtKWMDghglmgwDlaZmkEkb
   fSSMVdmk5XGpQrMDWsZrXvJ5EcCMyBG0Kpv2A7SkoVFfiWB2MTwzft1di
   IsZ//9HK6SfraQIGfdOqpvdLIS1SVQHwYI4MVvR32p2xJPpT0UGpuKmSA
   Cb/fciA3z++2+vZLpuwflAUT2WzVogIDWDWtD6NEo/qosgibFOLPudxdJ
   4UtBXe72H433Dp6AQKkIjwvRs5ARJGGwycbloox8OtoQPm/cjjm3P9r9c
   TJeAyS48A9VHxz9Rl+TLilgx/a7GAJYkCwuNv9wN8/Sk3BiIH4W58htfB
   w==;
X-CSE-ConnectionGUID: 7sVBUeqbRGqY+Lj/aH04Yw==
X-CSE-MsgGUID: 1SBmpl9bQ6KQqrY5etx+SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30070024"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30070024"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 18:47:06 -0800
X-CSE-ConnectionGUID: CbFnNrQiToaCZ/0W8Q4nWw==
X-CSE-MsgGUID: ui+bkFSxSEehf9kIMW+7Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="89115602"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 18:47:03 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Gregory Price" <gourry@gourry.net>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alejandro
 Lucero <alucerop@amd.com>,  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
In-Reply-To: <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan> (Alison Schofield's message
	of "Tue, 5 Nov 2024 18:27:32 -0800")
References: <20241104084110.583710-1-ying.huang@intel.com>
	<ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
Date: Wed, 06 Nov 2024 10:43:30 +0800
Message-ID: <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alison Schofield <alison.schofield@intel.com> writes:

> On Mon, Nov 04, 2024 at 04:41:10PM +0800, Ying Huang wrote:
>> According to the description of the "Window Restrictions" field of
>> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
>> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
>> formerly known as "CXL Type 2 Memory" and renamed to "Device
>> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
>> and renamed to "Host-only Coherent".  Because type 3 memory can only
>> be host-only coherent before, while it can be host-only coherent or
>> device coherent with "Back-Invalidate" now.
>> 
>> To avoid confusion about type 2/3 memory and device/host-only coherent
>> in Linux kernel, the patch renames corresponding bit definition from
>> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
>> ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
>> code consistent with the spec too.
>> 
>> The patch also renames the corresponding cxl_decoder flags
>> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.
>> 
>> No functionality change is expected.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>  drivers/cxl/acpi.c           |  8 ++++----
>>  drivers/cxl/core/port.c      |  8 ++++----
>>  drivers/cxl/cxl.h            | 14 +++++++-------
>>  include/acpi/actbl1.h        | 10 +++++-----
>>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>>  5 files changed, 29 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 82b78e331d8e..aca8cbb7540d 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>>  {
>>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>>  
>> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
>> -		flags |= CXL_DECODER_F_TYPE2;
>> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
>> -		flags |= CXL_DECODER_F_TYPE3;
>> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
>> +		flags |= CXL_DECODER_F_DEVMEM;
>> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
>> +		flags |= CXL_DECODER_F_HOSTONLYMEM;
>>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>>  		flags |= CXL_DECODER_F_RAM;
>>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index a5e6f3d23cfb..8524714968fd 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
>>  
>>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
>> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
>> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYMEM);
>>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>>  
> Hi Ying,

Hi, Alison,

>
> The commit log explains that type3 can now be 'either/or', so does
> cap_type3_show() need to emit true for either:
> 	(flags & CXL_DECODER_F_HOSTONLYMEM)
> 	or
> 	(flags & CXL_DECODER_F_DEVMEM) & 'back invalidate')
>
> Does this explanation in the ABI need updating:
> What:           /sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> Date:           June, 2021
> KernelVersion:  v5.14
> Contact:        linux-cxl@vger.kernel.org
> Description:
>                 (RO) When a CXL decoder is of devtype "cxl_decoder_root", it
>                 represents a fixed memory window identified by platform
>                 firmware. A fixed window may only support a subset of memory
>                 types. The 'cap_*' attributes indicate whether persistent
>                 memory, volatile memory, accelerator memory, and / or expander
>                 memory may be mapped behind this decoder's memory window.

I think so too.  However, I prefer to keep this patch just mechanic
renaming and do these changes in another patch.  Do you agree?

--
Best Regards,
Huang, Ying

>
>>  static ssize_t target_type_show(struct device *dev,
>> @@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>>  
>>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>>  {
>> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
>> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_PMEM;
>>  
>>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>>  }
>>  
>>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>>  {
>> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
>> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_RAM;
>>  
>>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>>  }
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 0fc96f8bf15c..b9083ce1cf74 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   * Additionally indicate whether decoder settings were autodetected,
>>   * user customized.
>>   */
>> -#define CXL_DECODER_F_RAM   BIT(0)
>> -#define CXL_DECODER_F_PMEM  BIT(1)
>> -#define CXL_DECODER_F_TYPE2 BIT(2)
>> -#define CXL_DECODER_F_TYPE3 BIT(3)
>> -#define CXL_DECODER_F_LOCK  BIT(4)
>> -#define CXL_DECODER_F_ENABLE    BIT(5)
>> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
>> +#define CXL_DECODER_F_RAM         BIT(0)
>> +#define CXL_DECODER_F_PMEM        BIT(1)
>> +#define CXL_DECODER_F_DEVMEM      BIT(2)
>> +#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
>> +#define CXL_DECODER_F_LOCK        BIT(4)
>> +#define CXL_DECODER_F_ENABLE      BIT(5)
>> +#define CXL_DECODER_F_MASK        GENMASK(5, 0)
>>  
>>  enum cxl_decoder_type {
>>  	CXL_DECODER_DEVMEM = 2,
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 199afc2cd122..e195909928df 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
>>  
>>  /* Values for Restrictions field above */
>>  
>> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
>> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
>> -#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
>> -#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>> -#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
>> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
>> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
>> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
>> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
>> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
>>  
>>  /* 2: CXL XOR Interleave Math Structure */
>>  
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 90d5afd52dd0..9d919fc99f6b 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -209,7 +209,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 0,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 4UL,
>> @@ -224,7 +224,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 1,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 8UL,
>> @@ -239,7 +239,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 0,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 4UL,
>> @@ -254,7 +254,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 1,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 8UL,
>> @@ -269,7 +269,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 0,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 4UL,
>> @@ -284,7 +284,7 @@ static struct {
>>  			},
>>  			.interleave_ways = 0,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M,
>> @@ -301,7 +301,7 @@ static struct {
>>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>>  			.interleave_ways = 0,
>>  			.granularity = 4,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 8UL,
>> @@ -317,7 +317,7 @@ static struct {
>>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>>  			.interleave_ways = 1,
>>  			.granularity = 0,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 8UL,
>> @@ -333,7 +333,7 @@ static struct {
>>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>>  			.interleave_ways = 2,
>>  			.granularity = 0,
>> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>>  			.qtg_id = FAKE_QTG_ID,
>>  			.window_size = SZ_256M * 16UL,
>> -- 
>> 2.39.2
>> 
