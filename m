Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54944399377
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587009; cv=none; b=jTuvQK+DKES607dyyqUjSdhgNSQkIeV3fjZlomtOsee5ljDtIaeKkbpwYyS6kd3UP9tkk2EbqYOz42D+ltKVxybFY0lBnOpQqeMDo48qWPdhjF45+K9Lr5NqFw05wSFoH9/AsAI6G7KpOceUAZj8ar3vWL7WcjRtNj2oMzdILBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587009; c=relaxed/simple;
	bh=F+YfS4V9nVmRThU24Tq9KlCYCykU8G9bjqYuhT/Ot0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG0ef4Chdnb6/V5bxNhEpgCOstkYt/AWcGXNbT9+B45HkwTNlhojUAaJJjnCSFYGygeNF+m6d4o+4nDWd3+MEVa0tOPCF7y6bF6b2bEnKQkphNo6TQjcriDVq/EqNvMKTxLY4n8raluRS41XeFWnHEW6nDXOmGKWXk8OOlu757Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJyzpiDm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJyzpiDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791587009; x=1823123009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F+YfS4V9nVmRThU24Tq9KlCYCykU8G9bjqYuhT/Ot0Y=;
  b=oJyzpiDmesXnivCyGP4yMnjcWtos5gXl6AxjVhg86nal9UYO7rS9D9Ns
   UvfRHde6onDvJ6SdGDXS8Sv4L8cSNQlsXUmYj57o97TV2w4zyF7dK7+Ic
   R0mvO3x1r6MXNx/nkDjKRckgpGRujb0edG5YySFvznsch0A/R9K8UNDAD
   Vsk413BOY37+vneOsKOdDyNUHOqFL1K9gyM3rXH+k2cuhZTRFAPfdalXz
   AXrRO74BWK6qhmQUuoz8sTLAgJ1YJSBTgN314nZkSwLI+LSCvtoekk4Bz
   6Rmuz7KML8e52p1oAdlUMjiNMPwPL3bBFEne132gSx+Fqvpisf3kS9qpT
   A==;
X-CSE-ConnectionGUID: lYLfe6/9RXS+2SAkLUlxlA==
X-CSE-MsgGUID: M/C92yV+Rp6e7yGqfYX2DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="397970"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="397970"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:03:28 -0700
X-CSE-ConnectionGUID: ycqy+8hrQ/uOYkbDMxMbng==
X-CSE-MsgGUID: Hk+EJ2BMSJyh65cnf3vneA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="439868"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:03:27 -0700
Message-ID: <af1c9e18-4563-4c3a-abcd-219ec57da7f4@intel.com>
Date: Fri, 9 Oct 2026 16:03:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tools/testing/cxl: Add CFMWS windows for region
 selection tests
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791582353.git.alison.schofield@intel.com>
 <74ce1a0d09b6bab2f93d905a49dca681ac3b4648.1791582353.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <74ce1a0d09b6bab2f93d905a49dca681ac3b4648.1791582353.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 3:11 PM, Alison Schofield wrote:
> Region selection needs topologies where multiple root decoders can
> satisfy a request and where a decoder supports both RAM and PMEM. The
> mock topology provides neither.
> 
> Add two x1 windows, one PMEM only and one supporting both RAM and PMEM,
> while preserving the existing modulo decoder identities.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  tools/testing/cxl/test/cxl.c | 71 ++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 46a87633e962..93bb520612f1 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -184,12 +184,20 @@ static struct {
>  	} cfmws6;
>  	struct {
>  		struct acpi_cedt_cfmws cfmws;
> -		u32 target[2];
> +		u32 target[1];
>  	} cfmws7;
>  	struct {
>  		struct acpi_cedt_cfmws cfmws;
> -		u32 target[3];
> +		u32 target[1];
>  	} cfmws8;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[2];
> +	} cfmws9;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[3];
> +	} cfmws10;
>  	struct {
>  		struct acpi_cedt_cxims cxims;
>  		u64 xormap_list[2];
> @@ -324,22 +332,20 @@ static struct {
>  		},
>  		.target = { 3 },
>  	},
> -	/* .cfmws6,7,8 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
>  	.cfmws6 = {
>  		.cfmws = {
>  			.header = {
>  				.type = ACPI_CEDT_TYPE_CFMWS,
>  				.length = sizeof(mock_cedt.cfmws6),
>  			},
> -			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 0,
>  			.granularity = 4,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M * 8UL,
> +			.window_size = SZ_256M * 4UL,
>  		},
> -		.target = { 0, },
> +		.target = { 2 },
>  	},
>  	.cfmws7 = {
>  		.cfmws = {
> @@ -347,16 +353,17 @@ static struct {
>  				.type = ACPI_CEDT_TYPE_CFMWS,
>  				.length = sizeof(mock_cedt.cfmws7),
>  			},
> -			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> -			.interleave_ways = 1,
> -			.granularity = 0,
> +			.interleave_ways = 0,
> +			.granularity = 4,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M * 8UL,
> +			.window_size = SZ_256M * 4UL,
>  		},
> -		.target = { 0, 1, },
> +		.target = { 1 },
>  	},
> +	/* .cfmws8,9,10 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
>  	.cfmws8 = {
>  		.cfmws = {
>  			.header = {
> @@ -364,6 +371,38 @@ static struct {
>  				.length = sizeof(mock_cedt.cfmws8),
>  			},
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> +			.interleave_ways = 0,
> +			.granularity = 4,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = FAKE_QTG_ID,
> +			.window_size = SZ_256M * 8UL,
> +		},
> +		.target = { 0, },
> +	},
> +	.cfmws9 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws9),
> +			},
> +			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> +			.interleave_ways = 1,
> +			.granularity = 0,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = FAKE_QTG_ID,
> +			.window_size = SZ_256M * 8UL,
> +		},
> +		.target = { 0, 1, },
> +	},
> +	.cfmws10 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws10),
> +			},
> +			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 8,
>  			.granularity = 1,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> @@ -406,18 +445,20 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
>  	[3] = &mock_cedt.cfmws3.cfmws,
>  	[4] = &mock_cedt.cfmws4.cfmws,
>  	[5] = &mock_cedt.cfmws5.cfmws,
> -	/* Modulo Math above, XOR Math below */
>  	[6] = &mock_cedt.cfmws6.cfmws,
>  	[7] = &mock_cedt.cfmws7.cfmws,
> +	/* Modulo Math above, XOR Math below */
>  	[8] = &mock_cedt.cfmws8.cfmws,
> +	[9] = &mock_cedt.cfmws9.cfmws,
> +	[10] = &mock_cedt.cfmws10.cfmws,
>  };
>  
>  static int cfmws_start;
>  static int cfmws_end;
>  #define CFMWS_MOD_ARRAY_START 0
> -#define CFMWS_MOD_ARRAY_END   5
> -#define CFMWS_XOR_ARRAY_START 6
> -#define CFMWS_XOR_ARRAY_END   8
> +#define CFMWS_MOD_ARRAY_END   7
> +#define CFMWS_XOR_ARRAY_START 8
> +#define CFMWS_XOR_ARRAY_END   10
>  
>  struct acpi_cedt_cxims *mock_cxims[1] = {
>  	[0] = &mock_cedt.cxims0.cxims,

