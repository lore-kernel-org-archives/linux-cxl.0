Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66F364E95;
	Fri,  9 Jan 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975376; cv=none; b=F6SoPskWDCKt/y6kJKhpuZHJS0khyUYhxE3wDNJ3sMVp8UETjJKxqPq+a4tXVbbaEDApq8PQoans3oiy8mwBxdkQHojGp3VPGWwjrThFgm/vB4qagMXZ+AZHCri+GfAilq+FEdjvsU+7nOiRsG39mlPqXNWR/9nXh9faVxbQDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975376; c=relaxed/simple;
	bh=i6ziRs7xP8EdphHahYr54YtBLvoZn8TnI7VuCpmR/EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOnjpF5rWmVAaX/Oi+D1NZIz1sYCIk0NASsVKcdfrflH3APAFrTtSGJqG0OXR+c9jNXbFr5JeiCjDv4wSREKrqHKoRgGIz2OWFKdVs5vJj/UwWKsOo9j+SlEbH/XSiAC9D4J3YSwIOh5Ca8PykRhb+noqXn8MvtB+2sUETN9ocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeXxRFaw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeXxRFaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767975375; x=1799511375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i6ziRs7xP8EdphHahYr54YtBLvoZn8TnI7VuCpmR/EQ=;
  b=UeXxRFawAy2j5S3YymSpwG9mtrli0IdhTurkzjj/UMecs8Z4QD3etDUV
   XdNshlz0S1ISDGEn3IB359pRzbodLCGhQsnWU08NhtUk98rMxcI1tdTD1
   cDusOJue/lI/wVACIUbemLbVNAHpAIAD4oHKHqhlnI+Mhx+EQr279quG+
   MhSLwMoxi9eWItblgNzJB1+Hs6fymjGkatHN7kGqBRSc1og3dBzYaaCw2
   OZ/wEvll3Xu4XTpd6uH631d3OnP4rBfYJxxWQN+5lJzNmNh9tylpEmvl/
   gZSqrHzysEDSpCi6z5fdwyUG2yboDeUwTaIsFwpqOka0dH0EkMnPU3hry
   A==;
X-CSE-ConnectionGUID: nPlaT5igSnmbBtfAx3YRTw==
X-CSE-MsgGUID: 7V1+QjBWSeWhGGM/x1lhPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="68557668"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="68557668"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:16:14 -0800
X-CSE-ConnectionGUID: LQb8HWI5TzuuYM0vaVVquA==
X-CSE-MsgGUID: uytYVIhKQseixR3b664iaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203127917"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:16:13 -0800
Message-ID: <abb4fedd-df10-4993-9567-9be185094d6a@intel.com>
Date: Fri, 9 Jan 2026 09:16:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cxl/hdm: Fix newline character in dev_err() messages
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260109122952.639231-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109122952.639231-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 5:29 AM, Robert Richter wrote:
> The newline character is not placed at the end of the string. This
> causes unintended line wraps, broken log level and unterminated log
> messages. Fix that for all messages.
> 
> Note that the messages are changed to use colons now instead of
> parentheses, which is more common use.
> 
> Fixes: 24b18197184a ("cxl/hdm: Extend DVSEC range register emulation for region enumeration")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

Applied to cxl/next
4c9922387b35b325a645cc42f8daf9a9e4db690b


>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 031672e92b0b..28611b350cf6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -966,7 +966,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>  	if (rc) {
>  		dev_err(&port->dev,
> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>  			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
>  		return rc;
>  	}
> @@ -1117,7 +1117,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>  			port->id, cxld->id, *dpa_base,
>  			*dpa_base + dpa_size + skip - 1, rc);
>  		return rc;
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
> prerequisite-patch-id: c142edda207a3a69ae242182e51e9a8b8d78cf72

