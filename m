Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2A3074A2;
	Wed, 15 Oct 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542715; cv=none; b=KreI9oAF0Lng3hFzS7y1FYCAr0iSTnFGcePqFhO/du2th5Vrn+ydE8sHbAIYJN7XYnnjWgjEcOkxUOM4p8TRaHp2/YjYRsy2KwMqiDLrg/KzBf+rc8RQqhYmrrhOBMNkjk5LrH46P2QHOsxgjVqwaI1ivjXe7cji507N3YXz72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542715; c=relaxed/simple;
	bh=9pbyUAwwFE/QnPS4ZNdNETNv1vPeXcRmk7+KPeZVauw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rVywi6FtBSNmogF1F4C0iVuCgeb7FjeNCwUad4jvTes04jE463LZs+5Jh7HxC2hdOb+NIaV2Bo0daRkrCmk8qZVwivob1tfNIs9wULM55WDEL1815A9XkUDgFDkSxgtciXHnbsKHZ+SyceBWVnyCWQxelGRQjRa9zyJXQuE3pnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1ScEKp9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1ScEKp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760542713; x=1792078713;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9pbyUAwwFE/QnPS4ZNdNETNv1vPeXcRmk7+KPeZVauw=;
  b=V1ScEKp9q1xlZiUyxhZ36AUuJaf7n6/vNCV9Qe6BTrsr4TYIJq18D9k8
   kBprkFcyGJAPqsXoALwuj0bz91YM8sGw+2VpYcs3pLtcPbw1Bl0FvWBz/
   u+QNsAAexW6Q3ngZON8TcnE75CHzawPVhhDeHl18kgTxC+QVGg6cre4iB
   m9fEHz4srJEZkmGv/DG3/Ua2qQMCBUGbGPqyzxRiR6kpIhMQVcWX5cTlp
   jtbmudTvNQnxH1lwt+lfo5X2bE6D8IQZUSIkBs6qjAgay916U8P3k2n5r
   LfgOktLpNTqkrAmfXKXb+zckPaEQ0V5NRLVCOaVXQ4jOjqxkAYcG1tPwG
   g==;
X-CSE-ConnectionGUID: bAkE0eRlTP2xFgMafjeGug==
X-CSE-MsgGUID: timFh+UsQEKL93aQJL5SPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62429048"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62429048"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 08:38:31 -0700
X-CSE-ConnectionGUID: X/uJpIkAQLGgjChyA5kODQ==
X-CSE-MsgGUID: 2wH9yJ6jRlCJMstXmDpRCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="181418405"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 08:38:31 -0700
Message-ID: <de625425-bc2c-4fe8-850a-2196946ce9d8@intel.com>
Date: Wed, 15 Oct 2025 08:38:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
To: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251015024019.1189713-2-vaslot@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 7:40 PM, Vishal Aslot wrote:
> The cxl core in linux updated to supported committed
> decoders of zero size, because this is allowed by
> the CXL spec.
> 
> This patch updates cxl_test to enable decoders 1 and 2
> in the host-bridge 0 port, in a switch uport under hb0,
> and the endpoints ports with size zero simulating
> committed zero sized decoders.

Hi Vishal, first of all, really appreciate you doing this. If there's another rev of the series, let's reorder and the test patch should go after the implementation patch.

Can you add a little more in the commit log on how this is tested? i.e. this code is exercised in cxl-topology.sh unit test or something else etc etc.

> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> ---
>  tools/testing/cxl/test/cxl.c | 96 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2d135ca533d0..cb18ee41a7cf 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -719,6 +719,45 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	cxld->reset = mock_decoder_reset;
>  }
>  
> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	cxld->hpa_range = (struct range){
> +		.start = base,
> +		.end = base - 1,  /* Size 0 */
> +	};
> +
> +	cxld->interleave_ways = 2;
> +	cxld->interleave_granularity = 4096;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags = CXL_DECODER_F_ENABLE;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static void size_zero_mock_decoder_sw(struct device *dev, u64 base, int i)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	cxld->flags = CXL_DECODER_F_ENABLE;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (i == 0)
> +		cxld->interleave_ways = 2;
> +	else
> +		cxld->interleave_ways = 1;
> +	cxld->interleave_granularity = 4096;
> +	cxld->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base - 1, /* Size 0 */
> +	};
> +}
> +
>  static int first_decoder(struct device *dev, const void *data)
>  {
>  	struct cxl_decoder *cxld;
> @@ -731,6 +770,30 @@ static int first_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +static int second_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +	cxld = to_cxl_decoder(dev);
> +	if (cxld->id == 1)
> +		return 1;
> +	return 0;
> +}
> +
> +static int third_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +	cxld = to_cxl_decoder(dev);
> +	if (cxld->id == 2)
> +		return 1;
> +	return 0;
> +}
> +
>  static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  {
>  	struct acpi_cedt_cfmws *window = mock_cfmws[0];
> @@ -743,7 +806,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_dport *dport;
>  	struct device *dev;
>  	bool hb0 = false;
> -	u64 base;
> +	u64 base = window->base_hpa;
>  	int i;
>  
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -767,6 +830,20 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		port = cxled_to_port(cxled);
>  	}
>  
> +	/*
> +	 * Decoders 1 and 2 of the endpoint under host bridge 0 should be enabled as zero-sized.
> +	 * It would be even better to make sure that the parent switch uport decoder was
> +	 * also enabled before enabling the size zero decoders but there is no harm in doing it
> +	 * anyway.
> +	 */
> +	if (hb0 && (cxld->id == 1 || cxld->id == 2)) {
> +		port = to_cxl_port(cxld->dev.parent);
> +		size_zero_mock_decoder_ep(cxld, base);
> +		/* Commit the zero-sized decoder */
> +		port->commit_end = cxld->id;
> +		return;
> +	}
> +
>  	/*
>  	 * The first decoder on the first 2 devices on the first switch
>  	 * attached to host-bridge0 mock a fake / static RAM region. All
> @@ -780,7 +857,6 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		return;
>  	}
>  
> -	base = window->base_hpa;
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + size - 1,
> @@ -844,6 +920,22 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  			.end = base + size - 1,
>  		};
>  		put_device(dev);
> +
> +		/* Enable the next two decoders also and make them zero sized */

s/decoders/switch decoders/

> +		dev = device_find_child(&iter->dev, NULL, second_decoder);

Maybe just pass in the index as the data parameter and then you can just use match_decoder_by_index instead of static code second and third.

DJ

> +		WARN_ON(!dev);
> +		if (dev) {
> +			size_zero_mock_decoder_sw(dev, base, i);
> +			iter->commit_end = 1;
> +			put_device(dev);
> +		}
> +		dev = device_find_child(&iter->dev, NULL, third_decoder);
> +		WARN_ON(!dev);
> +		if (dev) {
> +			size_zero_mock_decoder_sw(dev, base, i);
> +			iter->commit_end = 2;
> +			put_device(dev);
> +		}
>  	}
>  }
>  

