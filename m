Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271C13C9C4;
	Mon, 28 Apr 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879106; cv=none; b=Au+nJW+qEqIqFwyvemzgHihOXv6Cj/lCRkwkRxAr84h238Sc2yJakBqMhMet8kgkeDvnpx9/XmDDHbRbgqUZXNXN39jnHbq7djn+15sjqbK9ggG3HpfQKEqIhGahVOkjik/f85Q685o2JITkkJp8YPhXh7xWI4cCHiC/ZMzHd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879106; c=relaxed/simple;
	bh=H70EKmWtZS2gUIEgRPvrUOeEnMhDX6jyp5tLayDBKtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0qJ/rvcFscAaJ/usrZBSAWCMeAabIKj/GjGW/QEooINSOy1DPo0I3V8Uiizz3LQOWcLTmKvBWobhrAVGzAHHLb5TH6Fq/Y+LzMX1gl5/DgCgqXG5lJdIW2Sv6ZKajQhtBwQNfgHYLbhaSmWl9jO1bWFoFYKzKr9SGeVTYgKT2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9LJ3t+u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9LJ3t+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745879104; x=1777415104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H70EKmWtZS2gUIEgRPvrUOeEnMhDX6jyp5tLayDBKtk=;
  b=G9LJ3t+uESYxiPJSpC4wuM7QI+Rh3PqgaIvWiXj1tHq0kksM4iieigt4
   BxQyLX8dBHjoyT3SREe0mRvjTYnikIE6s7+csBYrJ8j78JOxNx6NIdNjX
   gqacvKEI5fAMPILnoVSk9Fu0IWyO2JNx0mtguGydsZhOdFRgOROhJ55I6
   d90FUzm+0Kq6AIa1wq/APQOiO29mDStFcwnoD2bwFIA2VOVFf+B87YuiT
   le0BKcLw+whhiDJeYlwfsPqqSMEu07NEH613xqMYf6hpaOjxeLYpc7ri6
   trvdiSNTGF4drJq9Vnsttc/pIStaCXS5uXWMBw9OocIiJIq75KxzjgzKk
   g==;
X-CSE-ConnectionGUID: 7mk0zRKLSzSKQSTwLlTRUg==
X-CSE-MsgGUID: HmvaMfpmSLmB1ElLfjAyog==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="50144202"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="50144202"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:25:03 -0700
X-CSE-ConnectionGUID: qVP7Bw8IScGQ1STTOq4e6w==
X-CSE-MsgGUID: KwTFmLMyQnOUB9zHWRPnfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="138637307"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:25:02 -0700
Message-ID: <74d30a9f-06d3-4a8e-89d3-5fbd33fc0240@intel.com>
Date: Mon, 28 Apr 2025 15:24:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] cxl/region: Rename function to
 cxl_port_pick_region_decoder()
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-6-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250428214318.1682212-6-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:43 PM, Robert Richter wrote:
> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. In the region creation path the function
> is an allocator to find a free port. In the region assembly path, it
> is recalling the decoder that platform firmware picked for validation
> purposes.
> 
> Rename function to cxl_port_pick_region_decoder() that better
> describes its use and update the function's description.
> 
> The result of cxl_port_pick_region_decoder() is recorded in a 'struct
> cxl_region_ref' in @port for later recall when other endpoints might
> also be targets of the picked decoder.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e35209168c9c..e104035e0855 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -865,10 +865,25 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +/**
> + * cxl_port_pick_region_decoder() - assign or lookup a decoder for a region
> + * @port: a port in the ancestry of the endpoint implied by @cxled
> + * @cxled: endpoint decoder to be, or currently, mapped by @port
> + * @cxlr: region to establish, or validate, decode @port
> + *
> + * In the region creation path cxl_port_pick_region_decoder() is an
> + * allocator to find a free port. In the region assembly path, it is
> + * recalling the decoder that platform firmware picked for validation
> + * purposes.
> + *
> + * The result is recorded in a 'struct cxl_region_ref' in @port for
> + * later recall when other endpoints might also be targets of the picked
> + * decoder.
> + */
>  static struct cxl_decoder *
> -cxl_region_find_decoder(struct cxl_port *port,
> -			struct cxl_endpoint_decoder *cxled,
> -			struct cxl_region *cxlr)
> +cxl_port_pick_region_decoder(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled,
> +			     struct cxl_region *cxlr)
>  {
>  	struct device *dev;
>  
> @@ -932,7 +947,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  			struct cxl_decoder *cxld;
>  
> -			cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1020,7 +1035,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  {
>  	struct cxl_decoder *cxld;
>  
> -	cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  	if (!cxld) {
>  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>  			dev_name(&port->dev));

