Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA375324718
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196974; cv=none; b=GTdplfXmf2oZTSVMnd+N5CiaeR9gjy1PP0/WQ3u8vU9KP69peG5hYtUQn0kYIXgwo6dCf8LS7zwCEsxI/rwToGZC1M5R8FdeCN62ivYHrFaHGGpA/he6eEa25zh5ZYVOZEfdNGqxzVjpEgvf/Yv3QwoCA9LbgVWVtpACW55uBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196974; c=relaxed/simple;
	bh=kehrW6IBE20fJpNmeK3SoMfsowkVpoRqgTGWdGaBhaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFNM5maB0Kyq5ePMudnW4otyEwy1UEFii41Rj3biYtSm8nMIUGoPhkjlXUzEWLXcfZ5UpPZng8Mfji3gwxF1eHKo3ysj5bOq05oUkngiC7vsbIHeyNdwPz0fWGBfe3ERyh5C3NA2IuIoWdAw5hfy/uw5U78ff+7P+lhlkfh5lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h78PyTNj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h78PyTNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778196973; x=1809732973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kehrW6IBE20fJpNmeK3SoMfsowkVpoRqgTGWdGaBhaE=;
  b=h78PyTNjpLNbXGia8zKWwW7vkeh+xfY8/hEtaFr7aEUvK7jyjX6QIn5E
   8NZPVHb9lhdKBdQx0AkMzabsuoKKOmwVhTnlxt8vCnTYtK5pAMOMomWGh
   EcYxLYT/TVccRRNaw6g9xjJAXDU8yuS8RqYAgOAccz6ZLH1aQyIx4eCfe
   q+l/WiH6gAvKd5CYEX3KZ1twbvf7YXVRJg4tdViNS29pYuN7vWHEizQnQ
   fG/M4YaUce2WSTp0bzMRz6LfKHh/gfAMSHkVhm+PiFaFpgou0pgaMatY4
   ElFgkUfFX0cjo38ioop+I2hhIj66t7yqMXrleLAQdScqc8nsOBjwS7b1f
   w==;
X-CSE-ConnectionGUID: ZMaSaMbQS/uyDeJJdt6ySQ==
X-CSE-MsgGUID: vMH5YPBRTjmtvtJ/I9NBAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90622692"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90622692"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:36:12 -0700
X-CSE-ConnectionGUID: 5CaUJwt3S9O5o36OtbNdvg==
X-CSE-MsgGUID: gbYxRD6dQDqgaZIK87/ZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="238401194"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:36:11 -0700
Message-ID: <705392c4-a00e-404d-bf5c-285015815c04@intel.com>
Date: Thu, 7 May 2026 16:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cxl/test: Add type2 support for mock CFMWS0
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-3-dave.jiang@intel.com>
 <afrFuzfkLtGlkmAP@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrFuzfkLtGlkmAP@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 9:38 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:32PM -0700, Dave Jiang wrote:
>> Add a module parameter 'type2_test' for triggering type2 test support
>> in cxl_test. Setup the CFMWS0 configuration to be type2 when 'type2_test'
>> is set.
> 
> Now that this joins the module param party, realizing we need some
> rules. How about starting with a simple enforcement that only one
> module param can be set at a time. Probably a count of params near
> top of cxl_test_init() will suffice.

I'll create a new patch for module param verification.

DJ

> 
> Nothing else below, but I am going to comment on type2_test usage
> in Patch 4.
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  tools/testing/cxl/test/cxl.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index c26c37cef12c..903223013e41 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -16,6 +16,7 @@
>>  
>>  static int interleave_arithmetic;
>>  static bool extended_linear_cache;
>> +static bool type2_test;
>>  
>>  #define FAKE_QTG_ID	42
>>  
>> @@ -383,6 +384,19 @@ static struct {
>>  	},
>>  };
>>  
>> +static struct acpi_cedt_cfmws type2_cfmws0 = {
>> +	.header = {
>> +		.type = ACPI_CEDT_TYPE_CFMWS,
>> +		.length = sizeof(mock_cedt.cfmws0),
>> +	},
>> +	.interleave_ways = 0,
>> +	.granularity = 4,
>> +	.restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
>> +			ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>> +	.qtg_id = FAKE_QTG_ID,
>> +	.window_size = SZ_256M * 4,
>> +};
>> +
>>  struct acpi_cedt_cfmws *mock_cfmws[] = {
>>  	[0] = &mock_cedt.cfmws0.cfmws,
>>  	[1] = &mock_cedt.cfmws1.cfmws,
>> @@ -471,6 +485,11 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
>>  	window->window_size = mock_auto_region_size * 2;
>>  }
>>  
>> +static void update_type2_cfmws(void)
>> +{
>> +	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
>> +}
>> +
>>  static int populate_cedt(void)
>>  {
>>  	struct cxl_mock_res *res;
>> @@ -492,10 +511,14 @@ static int populate_cedt(void)
>>  		chbs->length = size;
>>  	}
>>  
>> +	if (type2_test)
>> +		update_type2_cfmws();
>> +
>>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
>>  
>> -		cfmws_elc_update(window, i);
>> +		if (i == 0 && !type2_test)
>> +			cfmws_elc_update(window, i);
>>  		res = alloc_mock_res(window->window_size, SZ_256M);
>>  		if (!res)
>>  			return -ENOMEM;
>> @@ -2029,6 +2052,8 @@ module_param(interleave_arithmetic, int, 0444);
>>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>>  module_param(extended_linear_cache, bool, 0444);
>>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>> +module_param(type2_test, bool, 0444);
>> +MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
>>  module_init(cxl_test_init);
>>  module_exit(cxl_test_exit);
>>  MODULE_LICENSE("GPL v2");
>> -- 
>> 2.53.0
>>

