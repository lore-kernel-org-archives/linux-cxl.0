Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691813B9933
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192098; cv=none; b=BAsieXxE2ZwY1U1zCtYG9LK+0zDenhiw5cu28oR5JX5XLWSyGUnOnRjiBOlyZHTBNa3QCilbkx3dDtcPn3P9y7NZhOXfKuZfcFzZlo8hpOzCoWefpceyXd3Qqh18AO848AsLJofntbZKrPh4uzqDxc7C63sdrbTp7HReeq6c4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192098; c=relaxed/simple;
	bh=6Hb1zHPiw8+MRhgR/Va7z3aeSgIBvMnlgVPLYAWMgok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+7ZYmoEno4ys62Bx46p9lY0DCQW1eMIToXCJvlSrwCWL975jLHhDJo3BEqThs7JlwRTpactn+riUsdnfbrUw5zekDRpdKKcLmsovKugwtslXmvaSNLacggJgDB13OkTehXL+XHYKr87NEV2IIbyneHypEyBqIgikRT36r6HfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwIR2zhA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwIR2zhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788192096; x=1819728096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Hb1zHPiw8+MRhgR/Va7z3aeSgIBvMnlgVPLYAWMgok=;
  b=IwIR2zhAS1wyRXfLhat2pWEC+v+OXFV94ZSHvF2ob8xHXfzGAVbga6V8
   l0nML+b5I9oDwZvPCYi1Y+TBkNHalCPnHi48ITiUtDoK9z2TBycC4hI1s
   ZiKsv3XfT02GCAbb5SolsD/qJ7r+esCIoZu/H54aiisTa7BgnJP4i7O5w
   wyfM1422o3wO/I9gRzChaTFfFAwcmKqwFs3rSQFLDBZVEQisbJFDts+No
   Oi9D0QNhVwlhQ/a4REloDsvWBsScA4zRZnVBowrOOAtTZoVOF+5FwsfJ0
   hXLZrPIWJw+a49oG+kxu4tjh8UnBKBMz2sKgm38WAV4fYwkpNfaxudlGr
   Q==;
X-CSE-ConnectionGUID: 1k/38RBoQ1ylEw+d9SsqQQ==
X-CSE-MsgGUID: AuwxK8oDQr+ccGRGURGtGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99954391"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="99954391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:01:35 -0700
X-CSE-ConnectionGUID: wqwSQRQxScSfZm59zIbd7Q==
X-CSE-MsgGUID: sVKtzlyHT5y+fe7AYMgfqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267033280"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.14]) ([10.125.110.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:01:35 -0700
Message-ID: <8afb1842-630b-42e9-be90-e79ab7445530@intel.com>
Date: Mon, 31 Aug 2026 09:01:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/cdat: Fix uninitialized stack use in bandwidth
 gathering
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
 <20260831092216.540644-2-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260831092216.540644-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/26 2:22 AM, Guixin Liu wrote:
> cxl_endpoint_gather_bandwidth() and cxl_switch_gather_bandwidth() declare
> access_coordinate arrays on the stack and rely on their helpers to fill
> them. The helpers assign only the bandwidth members, and the combine step
> assigns even those only when both inputs are non-zero. The latency members
> are summed from stack residue on every call, and the bandwidth members
> keep that residue into the region access coordinate sysfs attributes when
> the endpoint CDAT reports no bandwidth.
> 
> Zero initialize the arrays. Zero is the value this code already uses for
> "not reported", so an unset member now reads back as unknown rather than as
> a plausible number.
> 
> Found by code inspection. Tested on a QEMU CXL topology with two endpoints
> sharing a switch upstream link and HMAT generic-port coordinates for the
> host bridge, which the calculation requires to run at all: with temporary
> printk at the combine sites, the unpatched kernel summed 0xfefefefe, the
> CONFIG_INIT_STACK_ALL_PATTERN stack filler, into the latency members, while
> the patched kernel reports the CDAT latency values there.
> 
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/cdat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..df9261ba84e5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>  	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>  	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
>  {
>  	struct xarray *res_xa __free(free_perf_xa) =
>  		kzalloc_obj(*res_xa);
> -	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX] = { };
>  	struct cxl_perf_ctx *ctx, *us_ctx;
>  	unsigned long index, us_index;
>  	int dev_count = 0;

