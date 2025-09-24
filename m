Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83F2E11C8;
	Wed, 24 Sep 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737477; cv=none; b=MjMgSNPPzG6CyekkpR9BYEISHxy5iV9rsvYOrTPClbrXrWE+0DhM2dQhdoURIBtX7OL9dA/eQmY04oeQ+EQsakEURxQtF/NjzvNLgU5RiUzFrQb7rnUM0usk9xoQNRZgLXfG6WkQESuJpSbwCp7AqDDgEocUw+Rl4nwF/ARH0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737477; c=relaxed/simple;
	bh=KgqydHycOTAKEoaHdVLF1AZnKczamvX+35kRKuPRWw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMkfWOCfzzzaPrhpcrvWF1kEhv+RjG3uTgVqH9hdfDSPASN5PzZpiWKhNi/3XFlxU+3tL7fUxJ9rAKLL+Gy1LwLzWiuUYE9aqXSuRkMUfYdGzYEPzap7WCZ63WORSGqEOIAWnS16ZtRfZlqtdfowqblyX8xJ9OvaDDEyXwS5mH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWvxC0KE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWvxC0KE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758737474; x=1790273474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KgqydHycOTAKEoaHdVLF1AZnKczamvX+35kRKuPRWw8=;
  b=KWvxC0KEV6qRdkd2XpG7LP1nYAnTJFjLmhjP4+HDozQe5sa8O1SS2Xbk
   LBXVBs/M+AnND1KMgD6OjmtFrAqF+ksrqgi5LsaZjIL6QAcNGhJ34+vku
   AeijTyE5Wa3OVqOmLaQBsK16Xxy79Q8daKX08Vn03EUM+aPl56ekrOLJI
   opweUUoBPJ8q99F2sOlI4P0EClgr2l+sCERIfgIlcoRcd8SGWT9VvpZ6i
   8uaQswM/NUcjnLUlBgJ/C4+zWwK8leQhTFMJFON7Kp9HRkZXoQ1Tdmiub
   NhPzE3hGZccK1BSeHMTd10YgWRQVdGrZkmGzHVzLcTl6lOm9kf5kzmyfh
   g==;
X-CSE-ConnectionGUID: Xpb/j8IjSauYsbpQPUx0lw==
X-CSE-MsgGUID: Pm+vsTdVQpO5h6ykHLqdcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61096420"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61096420"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:11:14 -0700
X-CSE-ConnectionGUID: jvUa3VO0THexc3SFXzDxJA==
X-CSE-MsgGUID: 2hkBBAw1QOm3+rhPbA3ZuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177531914"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:11:13 -0700
Message-ID: <43772918-1911-46a5-8165-bf612056a8e6@intel.com>
Date: Wed, 24 Sep 2025 11:11:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 15/20] cxl: Add a routine to find cxl root decoder on
 cxl bus using cxl port
To: Neeraj Kumar <s.neeraj@samsung.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
 cpgs@samsung.com
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
 <CGME20250917134202epcas5p23f718742c74c5b519ecbbc1e04840c03@epcas5p2.samsung.com>
 <20250917134116.1623730-16-s.neeraj@samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250917134116.1623730-16-s.neeraj@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 6:41 AM, Neeraj Kumar wrote:
> Add cxl_find_root_decoder_by_port() to find root decoder on cxl bus.
> It is used to find root decoder using cxl port.
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
> ---
>  drivers/cxl/core/port.c | 27 +++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8f36ff413f5d..647d9ce32b64 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -518,6 +518,33 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, "CXL");
>  
> +static int match_root_decoder(struct device *dev, const void *data)
> +{
> +	return is_root_decoder(dev);
> +}
> +
> +/**
> + * cxl_find_root_decoder_by_port() - find a cxl root decoder on cxl bus
> + * @port: any descendant port in CXL port topology
> + */
> +struct cxl_root_decoder *cxl_find_root_decoder_by_port(struct cxl_port *port)
> +{
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct device *dev;
> +
> +	if (!cxl_root)
> +		return NULL;
> +
> +	dev = device_find_child(&cxl_root->port.dev, NULL, match_root_decoder);
> +	if (!dev)
> +		return NULL;
> +
> +	/* Release device ref taken via device_find_child() */
> +	put_device(dev);

Should the caller release the device reference instead?

DJ

> +	return to_cxl_root_decoder(dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_root_decoder_by_port, "CXL");
> +
>  static void cxl_ep_release(struct cxl_ep *ep)
>  {
>  	put_device(ep->ep);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3abadc3dc82e..1eb1aca7c69f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -866,6 +866,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm(struct device *dev);
>  int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
> +struct cxl_root_decoder *cxl_find_root_decoder_by_port(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);

