Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCA277C81;
	Tue,  1 Jul 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382671; cv=none; b=mqPoTZC3pYLcKl97nO702JI2iwTTkJElIoPmQj43ium9dNEqdvjzOBg1ByuehATDyVX3fDV/mhuhHAlblfZJH52RafqMQMGrOaxjKcZpjSYaMkq6qOQM7laO+plcO88QhNnPdpnpIEE8q7R+ar4+KfwMshtwwyxD++62GF0eJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382671; c=relaxed/simple;
	bh=qo6W6L+xqznsayY93zstYecbD3mdmU3COg1H4iztxHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTMZYysF8lrPjhHpdhUDhiNi21oAYPMCGmTbBuRinixhbGNuoudI3hTdw2k9YFQ3jTDr+QLm0745bTwfYEEnOJLGQe3gudceQ7diRHnv+i5L7bgZ/JV64posgOs15mPB/b7epbUoT+OvyO0uVKeRvFUHaZ1OiQ1Mmiky+L/ZvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9CVjHey; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9CVjHey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751382670; x=1782918670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qo6W6L+xqznsayY93zstYecbD3mdmU3COg1H4iztxHU=;
  b=k9CVjHeyvuOirTorwtzPn98fEQRMhuKO3xAcFg8yYMlLsK05yfoVMdUQ
   Mx+UHhI8Iu8dj8PHzLdf7hKocQBauPgArAapq966m/vCPuZL0Nbpgn2tD
   Yfoo3cYkripOQZI4jMcwvoEWEXkl3Vekj4Pn2AowGgYcOPuB0QYRlEU4G
   8xNqJ4TwAqlpnaVJB8HxsYjqrD/ulcK/RGXmovwYWN7/i5HPw2My9WE6e
   k4M+M2uE5x6Fv0jxS5RAREqmf/ImRNQYnnV/PFpiOxnoZTIBMNhiwmKLl
   DL+GSh8ZrKQmSf0VCcOh9e1mq9+4uWWWGtnN54TmHAmffJLjsKrI1AFMY
   A==;
X-CSE-ConnectionGUID: SCJeWfwBR1m69hK0+0eJRw==
X-CSE-MsgGUID: kh1qpx/lTzeuFSUCvl9xDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52886384"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="52886384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:11:09 -0700
X-CSE-ConnectionGUID: X4enlwGcThu5PCoyzbQF+w==
X-CSE-MsgGUID: zOPsIRhOSFGcLXnsr2OPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154114745"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:11:08 -0700
Message-ID: <e665d583-cfd1-41f2-85e1-3490ac4b4720@intel.com>
Date: Tue, 1 Jul 2025 08:11:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: make cxl_bus_type constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <2025070138-vigorous-negative-eae7@gregkh>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2025070138-vigorous-negative-eae7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 5:07 AM, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cxl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2: fix up the subject line to be correct
> 
>  drivers/cxl/core/port.c | 2 +-
>  drivers/cxl/cxl.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..0696f7fcef56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2293,7 +2293,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
>  	NULL,
>  };
>  
> -struct bus_type cxl_bus_type = {
> +const struct bus_type cxl_bus_type = {
>  	.name = "cxl",
>  	.uevent = cxl_bus_uevent,
>  	.match = cxl_bus_match,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..e7b66ca1d423 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -815,7 +815,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  
>  bool is_cxl_region(struct device *dev);
>  
> -extern struct bus_type cxl_bus_type;
> +extern const struct bus_type cxl_bus_type;
>  
>  struct cxl_driver {
>  	const char *name;

