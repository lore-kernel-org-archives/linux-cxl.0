Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93261F4629
	for <linux-cxl@vger.kernel.org>; Tue,  4 Mar 2025 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065305; cv=pass; b=jQ2Wk9n3AXKi03wVoEhgsIA6nk6QJDzwf7WaLBlA48jfH44NUhDUo40BVpRZesoyfymjvGJ2q3hfQhsK0fRjPkievw8v6UjMnSKAdkOxtivVVl3OjWyQYF073Fk2ZtQR3y+l3pEBrZM7Bxo1NKVNvrC0JgpSy0Z2KzH38oFKefc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065305; c=relaxed/simple;
	bh=LtrNu9Yd52lzFzinD0O3LJkKYFyWMwZBVO1OQzj7L44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgXgATRawUEss+NsVKy6kA9o3PPdS4jKWQ1lyzV99MlbszBRwNK23ueZYtIYzKgAoqhqWzfxUDv2mR7nJwmU2XTvqCUSoVzEDGPZ6goLbFGDTxJA4lSIZf4nZ0YOrqRQ7GRuh2cRcAwolwGHp0RV/cB8vb/to1NfbxZBZWkCvWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bN6iLfDP; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bN6iLfDP"
ARC-Seal: i=1; a=rsa-sha256; t=1741065289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h/2cLFMKNrJqpm8WMhMtb1QllylfHpHLqchU70ABc+EhJ4CDOHDLk8QkFt9ic5roAnyuwI4L0ZyEaFLBJG+7kv3CXMvcKnyZNuGPQPnivmEoHJ9YilW6TKnhADXCU5WjlwjOZsrM3TjkIOmmf4Q33QJ1iH9vZ8N2U1g6sG4YGkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741065289; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rx8Vm//UvZEd1HL14rVs2AifwiEOtyM7jf8nUf2KPts=; 
	b=fsjqrxspCocmx1f2yw+mhPvmZfY12fvf6RDZ6ZNhu9dvtvrjXR5CRKo65/oxUR/0rWKApaIxHZ2bBmXl4c9eqQWyL+ouFtzULZfhkiCqlVMax8xDW5LrHRDKNCbt6u2LpUEyBz8pds1yxMaUrGOTyystusdt2+MEoTJXSnEZfmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741065289;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Rx8Vm//UvZEd1HL14rVs2AifwiEOtyM7jf8nUf2KPts=;
	b=bN6iLfDP+y3rq+gFH8OewpzetV0NsX3MJ7ydkYLsLksRGTQreMUSKNaRrgOP7qtb
	+qnncXSiRVODt9iQ3Z4QaziAUmCczrpWaToeZMQ8vprq1jFkzu/xPRoiBwFvPNCu1li
	7MWiHK/kiW03INW1tLR4aBSF8jG48no5KVESv0bw=
Received: by mx.zohomail.com with SMTPS id 174106528693438.0015988179905;
	Mon, 3 Mar 2025 21:14:46 -0800 (PST)
Message-ID: <12e0d842-0ff3-4c8a-9bc2-b5c1436521e1@zohomail.com>
Date: Tue, 4 Mar 2025 13:14:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Quiet some dev_warn()s in extended linear
 cache setup
To: alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250304043315.2502110-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250304043315.2502110-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227dfcebd93137af0a8ede3e761000026ef6a9896466aa73a7e7d0914a26a6e9692b65f8a17b4e0b1:zu08011227311d3aa624e650a17f532fb20000bb642265411a24ccd671ccaf883b6059a4fd223eebc0298bd2:rf0801122d36c0e728352e8a64dce6dbb900009f8404d9dd74a166a819f1d07391e4760e7e4d3de5601153398d4e0a264c8b:ZohoMail
X-ZohoMailClient: External

On 3/4/2025 12:33 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>
> Extended Linear Cache (ELC) setup code emits a dev_warn(), "Extended
> linear cache calculation failed." for issues found while setting up
> the ELC.
>
> For platforms without CONFIG_ACPI_HMAT, every auto region setup will
> emit the warning because the default !ACPI_HMAT return value is
> EOPNOTSUPP. Suppress it by skipping the warn for EOPNOTSUPP. Change
> the EOPNOTSUPP in the actual ELC failure path to ENXIO.
>
> In a much less likely path, the dev_warn() is emitted if the size of
> the region resource is NULL. Move that size check out of the ELC setup
> code since NULL resource size is unrelated to the ELC setup and should
> cause an immediate failure to construct the auto region.
>
> For good measure, add the rc value to the dev_warn(). It will either
> be the -ENOENT returned by HMAT if the mem target is not found, or
> the -ENXIO from the region driver calculation.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8537b6a9ca18..2d2d2f221902 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3235,13 +3235,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	int nid = phys_to_target_node(res->start);
> -	resource_size_t size, cache_size, start;
> +	resource_size_t size = resource_size(res);
> +	resource_size_t cache_size, start;
>  	int rc;
>  
> -	size = resource_size(res);
> -	if (!size)
> -		return -EINVAL;
> -
>  	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>  	if (rc)
>  		return rc;
> @@ -3253,7 +3250,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  		dev_warn(&cxlr->dev,
>  			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
>  			 &cache_size, &size);
> -		return -EOPNOTSUPP;
> +		return -ENXIO;
>  	}
>  
>  	/*
> @@ -3304,15 +3301,18 @@ static int __construct_region(struct cxl_region *cxlr,
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
>  
> +	if (!resource_size(res))
> +		return -EINVAL;
> +

Hi Alison,


There is a 'res = kmalloc(sizeof(*res), GFP_KERNEL);' in __construct_region() before this return, I think that you should release 'res' before returning -EINVAL.

Other looks good to me.

Reviewed-by: Li Ming <ming.li@zohomail.com>


Ming

[snip]


