Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7C35E1AA
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586926; cv=none; b=rrz1TSuKgzyNWUHVDcstDXOLQ1y4Oncze+Oopxw8zgZP3eJFr3ZWncQOCmEM1iPq9ChkvddXn9Zwvqv8ZYbsXKvZBfAY+4GVNAaoy+b9+oy7WVF8yMJAIHNyfOqkPa+6DW2XF2269QVjdfJjZyaW5wZRP0Y5mngPe9h4bHfB1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586926; c=relaxed/simple;
	bh=A3X5Q/wXoHKfRhrEC+aJpWT1meSmrYHl0fMgU5givrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEqJAAp7ggjQ5VHlkb79fxC6BpDUnvNdM1lpLq7taghAK5mfHOMZdz53Rs+fsviUJngFgB1TlOLbfvY25h/ixW7ylg5wrNOp3AG4zHLomcztE/HXfPKxWEKIWl0aSpCIp3B9HFde7o2d1DiKVR7esY6fBXBu0u3nobeZ/Rz44Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMQlUD8T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMQlUD8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791586926; x=1823122926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A3X5Q/wXoHKfRhrEC+aJpWT1meSmrYHl0fMgU5givrE=;
  b=PMQlUD8TBHn8+BLW63IHl6AKYfVP0FSYIYSQq22oFEzGNfMGTdpgqFmU
   HM5xby8oXffAhoBbABccFlVYeMBrcu12qIB+K0Rx6cbb3FhW1fjA9tlS/
   306EGt47nb+zSQBzInyqFsvpEHxlFNZAnr4YX8Wuf9wW7WjwgX4M2K9uY
   VCgL16u7n4+k7qBi8wqVe50agoh34NXsHT68dzloxPKLbJKzahcnGKe82
   F9MVLd9JHmFDlV4IyWbqGGLiHJ1vW1hi789/j3AoQxzQrElaU0t059foy
   KbCeU2NnVQj407J47KjbiKOqQYZXOyYO1vl9kXdxtD3OAEb94JxvWsB4C
   A==;
X-CSE-ConnectionGUID: HT4tyYJcTPSwaRiIzGfmqg==
X-CSE-MsgGUID: Cpf8x+oOTDOW0wf3mxMJ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="291505"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="291505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:02:05 -0700
X-CSE-ConnectionGUID: jBTESNFPTRqPhpOLJdUwBg==
X-CSE-MsgGUID: ZsieEr2vQWWVwXY61J1KhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="409190"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:02:04 -0700
Message-ID: <84dd6ea0-0a09-4076-8b68-8049739e818e@intel.com>
Date: Fri, 9 Oct 2026 16:02:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tools/testing/cxl: Skip the auto region when no
 volatile window is active
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791582353.git.alison.schofield@intel.com>
 <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 3:11 PM, Alison Schofield wrote:
> The mock auto region always uses CFMWS0. With XOR interleave arithmetic
> that window is inactive, so its HPA base is never assigned and the
> endpoint decoders are programmed at HPA 0.
> 
> No root decoder matches that range, leaving DPA allocated to endpoint
> decoders that are not part of a region.
> 
> Set up the auto region only when a volatile window is active.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
> - Avoid duplicate look up of auto region window (RichardC)
> ---
>  tools/testing/cxl/test/cxl.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index aa140307e0c3..46a87633e962 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -423,6 +423,18 @@ struct acpi_cedt_cxims *mock_cxims[1] = {
>  	[0] = &mock_cedt.cxims0.cxims,
>  };
>  
> +static struct acpi_cedt_cfmws *mock_auto_region_cfmws(void)
> +{
> +	for (int i = cfmws_start; i <= cfmws_end; i++) {
> +		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> +
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			return window;
> +	}
> +
> +	return NULL;
> +}
> +
>  struct cxl_mock_res {
>  	struct list_head list;
>  	struct range range;
> @@ -1091,7 +1103,8 @@ enum cxld_init_type {
>  static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  						 struct platform_device *pdev,
>  						 bool hb0,
> -						 struct cxl_test_decoder **td)
> +						 struct cxl_test_decoder **td,
> +						 struct acpi_cedt_cfmws **window)
>  {
>  	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
>  
> @@ -1101,6 +1114,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  	}
>  
>  	*td = NULL;
> +	*window = NULL;
>  
>  	/*
>  	 * The first decoder on the first 2 devices on the first switch
> @@ -1114,6 +1128,11 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  	    pdev->id > 4 || cxld->id > 0)
>  		return MOCK_DECODER_INIT_DEFAULT;
>  
> +	/* XOR windows are all pmem, no window to host the RAM region */
> +	*window = mock_auto_region_cfmws();
> +	if (!*window)
> +		return MOCK_DECODER_INIT_DEFAULT;
> +
>  	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
>  			    MOCK_DECODER_INIT_TYPE3_AUTO;
>  }
> @@ -1135,9 +1154,9 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
>  }
>  
>  static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
> -				      struct cxl_port *port)
> +				      struct cxl_port *port,
> +				      struct acpi_cedt_cfmws *window)
>  {
> -	struct acpi_cedt_cfmws *window = mock_cfmws[0];
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport;
> @@ -1209,9 +1228,9 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
>  				      struct cxl_port *port,
>  				      struct platform_device *pdev,
> -				      bool hb0)
> +				      bool hb0,
> +				      struct acpi_cedt_cfmws *window)
>  {
> -	struct acpi_cedt_cfmws *window = mock_cfmws[0];
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport;
> @@ -1326,6 +1345,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	struct platform_device *pdev = NULL;
> +	struct acpi_cedt_cfmws *window;
>  	struct cxl_test_decoder *td;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_port *port;
> @@ -1354,7 +1374,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		port = to_cxl_port(cxld->dev.parent);
>  	}
>  
> -	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
> +	switch (get_decoder_init_type(cxld, pdev, hb0, &td, &window)) {
>  	case MOCK_DECODER_INIT_SAVED:
>  		if (WARN_ON(!td))
>  			return false;
> @@ -1367,10 +1387,10 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		default_mock_decoder(cxld);
>  		return false;
>  	case MOCK_DECODER_INIT_TYPE3_AUTO:
> -		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0);
> +		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0, window);
>  		return false;
>  	case MOCK_DECODER_INIT_TYPE2_AUTO:
> -		mock_init_hdm_type2_cxled(cxled, port);
> +		mock_init_hdm_type2_cxled(cxled, port, window);
>  		return false;
>  	default:
>  		return false;

