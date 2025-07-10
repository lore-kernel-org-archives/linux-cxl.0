Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8222FC3DC;
	Thu, 10 Jul 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190155; cv=none; b=n4Xa5UIJiEF/pa+S8GNnDl2z1JxrZZ9rFl2l2PqO1trTFQ+Y751hMVKqaBIVybI3RK+CIwUK4vYVpnL+RpcPaWkSUNGC2yC2gSkzclL+alDkvPnEsyGyXNsSiQEJNhgk792re1VeP1nEA8kn7HXCLQDZs9EL+kYuq7hg0jNVOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190155; c=relaxed/simple;
	bh=d/2Thj7QzTOJw5AZ8nZ5HFtZgzYZVxzUHzUzuqnWPmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE9bt9smzQcRo0jJ2gDxLTsosdemERrkvTPq+AUJ//Rv7YsJUHz0Ozjsufa2EaEtr08nUUK5gdaIt08ME7mSioblhxz331eHUGXSv42nAd0JFNwPhkrVG1QCwOiFOTMLFetFzgA44fPI8DgX35Wmsn0KTDxfRf68iVJtg690bS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpCIKzN0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpCIKzN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752190154; x=1783726154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d/2Thj7QzTOJw5AZ8nZ5HFtZgzYZVxzUHzUzuqnWPmI=;
  b=SpCIKzN0Bj5Qy5umfwuKiAkwe8SxcNSNV8sU5/+/WQ1sQDFlIT8VS03u
   RBvLGhAJZYRIbm/goWXZekdorymmu6iBeM/85NZ5jGFha41uG3J7YUfG/
   1Cmwr9gxaeW51SMCffZqfLZBLXJhc8d/jBTI2SmBsvYelfnSrSWvJPaXm
   spmMYIu8zXDzKqV1/luNTKJgIwEM7AilW8dyPu1ZjdNyY24g5ygRlrqxq
   KtS3kGpF5QbK+vydgZIpfzqsWiqhzstJMJlj2GyKr0EQIRnFDw9LVSb1o
   BQnPqu0NEhXkQ8+0Um2p6KYiUbb3XR6EHvuZc62lYxTG9WluUs25v4j4r
   Q==;
X-CSE-ConnectionGUID: LaKbZIkASsy4VYAco8S7RQ==
X-CSE-MsgGUID: iumNgw00TGO8PEAlhDNIlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65066041"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65066041"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 16:29:13 -0700
X-CSE-ConnectionGUID: jIZCSzKASCegDzaYVVI2Hw==
X-CSE-MsgGUID: sORncGVtTIagJcEl1/5nLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156942010"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 16:29:11 -0700
Message-ID: <e2ee3643-1592-4c85-8f59-82ba81bbe0c7@intel.com>
Date: Thu, 10 Jul 2025 16:29:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] cxl/core: Introduce a new helper
 cxl_resource_contains_addr()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710065647.98094-1-ming.li@zohomail.com>
 <20250710065647.98094-2-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250710065647.98094-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/25 11:56 PM, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function cxl_resource_contains_addr() to check if the resource
> range contains the input address.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h | 1 +
>  drivers/cxl/core/hdm.c  | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..6b78b10da3e1 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -80,6 +80,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
> +bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
>  
>  enum cxl_rcrb {
>  	CXL_RCRB_DOWNSTREAM,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ab1007495f6b..088caa6b6f74 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -547,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  	return base;
>  }
>  
> +bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr)
> +{
> +	struct resource _addr = DEFINE_RES_MEM(addr, 1);
> +
> +	return resource_contains(res, &_addr);
> +}
> +
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);

