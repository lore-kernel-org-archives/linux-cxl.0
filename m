Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213A1FFC4D;
	Thu, 20 Feb 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067949; cv=none; b=AhkT+bYw91H6GFXuexjPba0wFB0/o9Ye8VoMM/+2eX4JbRJRKu4F3+fp3ZUuOD6BaTeKYUuMRxCk1b8T8CgDvenwhyTAtXi6gLcl3qc8T1qdAgp1lK5qnRY1+TPmN3ZcaytYVHyL6Urqfow/IQeVqA0NKNBt/4opW2aIwlVogho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067949; c=relaxed/simple;
	bh=dY/sX52Upq9lX6eM6dG99/rTqYIMuNgkc4Xx0WWgCN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apbbQZ+BjYteru/u6CQ7OcROjnWpOPJk0733evss9fTsDmmZg9LlDJkVPeK+ouUuFdBk/AJosVZDJKbxqW1SiSc0eAN/Vaq5JqOY7+rjwqdB2RK2vJsjWkPf/LhTBA0UWom0H59Kq3n4vBd7TVkDRpnn6sDzYrJRPVCcD+W4pGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3kQG6rQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3kQG6rQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067948; x=1771603948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dY/sX52Upq9lX6eM6dG99/rTqYIMuNgkc4Xx0WWgCN4=;
  b=a3kQG6rQSfO82B8KujhPkYXYnIUytJs73zx58QkAs6MWIi2vfe0/AIYq
   tqUuM4lVaH60rNAzd0iEtO9AMlHkCFNWYWo/hF3ffyK3y0d4o9iN2esnN
   mMYgQ9ErkwDHcPXoZMpLqP0A4dk4FAwvESqKSMahdZi6e2A0irCmpUCUD
   /KG8/JiaS4McHqumDj8XQyklkVKP5Jdeky3h6T/ZjuwkD2VYk/TVE1ts/
   cUA21mEoHxIUP4MqQewxpu4s59n7FuVrUCBFRus/6+PXtTKSpJa4EnaJt
   Wtoz8iLdm/8tRaVZyHLIShW9u+OQZNV7jKGHivmLfNFAvwAze0KBgGtl/
   g==;
X-CSE-ConnectionGUID: IEW5f9eiTYGZoWuwz4B6vA==
X-CSE-MsgGUID: M7MGFh2VSOODga3DPyLKlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41112412"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="41112412"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:12:18 -0800
X-CSE-ConnectionGUID: bLt9dm1/R/6/kHAQoUZtyQ==
X-CSE-MsgGUID: ZSTlytT+SUG7T9ZgXP8VZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145939942"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:12:17 -0800
Message-ID: <d5a62c06-9897-4967-8cac-8454b8f6b24b@intel.com>
Date: Thu, 20 Feb 2025 09:12:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] cxl: Introduce parent_port_of() helper
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
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-6-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-6-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c   | 15 +++++++++------
>  drivers/cxl/core/region.c | 11 ++---------
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f9501a16b390..d19930c009ce 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -606,17 +606,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
>  
> +struct cxl_port *parent_port_of(struct cxl_port *port)
> +{
> +	if (!port || !port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
> +
>  static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port = _port;
> -	struct cxl_port *parent;
> +	struct cxl_port *parent = parent_port_of(port);
>  	struct device *lock_dev;
>  
> -	if (is_cxl_root(port))
> -		parent = NULL;
> -	else
> -		parent = to_cxl_port(port->dev.parent);
> -
>  	/*
>  	 * CXL root port's and the first level of ports are unregistered
>  	 * under the platform firmware device lock, all other ports are
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5d252dfae138..54afdb0fa61c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1734,13 +1734,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
>  	return cxled_a->pos - cxled_b->pos;
>  }
>  
> -static struct cxl_port *next_port(struct cxl_port *port)
> -{
> -	if (!port->parent_dport)
> -		return NULL;
> -	return port->parent_dport->port;
> -}
> -
>  static int match_switch_decoder_by_range(struct device *dev,
>  					 const void *data)
>  {
> @@ -1767,7 +1760,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	struct device *dev;
>  	int rc = -ENXIO;
>  
> -	parent = next_port(port);
> +	parent = parent_port_of(port);
>  	if (!parent)
>  		return rc;
>  
> @@ -1847,7 +1840,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	 */
>  
>  	/* Iterate from endpoint to root_port refining the position */
> -	for (iter = port; iter; iter = next_port(iter)) {
> +	for (iter = port; iter; iter = parent_port_of(iter)) {
>  		if (is_cxl_root(iter))
>  			break;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..0d7aff8b97b3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -721,6 +721,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
> +struct cxl_port *parent_port_of(struct cxl_port *port);
>  void cxl_port_commit_reap(struct cxl_decoder *cxld);
>  struct pci_bus;
>  int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,

