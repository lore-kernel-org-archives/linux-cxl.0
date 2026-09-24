Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD051EFFA1
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210972; cv=pass; b=J/3V6RUzzpzTKUHww2CPaYYV6xHInhb5Du3sapfN9w1G7jmBWeWUBfwNQJ8U9DwKn7w38SrcK5Z4PFBFW+YjqhynMukqjEjFEqrnJep+A4WLcQxZpzhMmZia59OepR7rywT+UHE5Vky+/7A94t1TgcwbTywvVV2KVbOFnmdFQK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210972; c=relaxed/simple;
	bh=cik1hc6wL68I9/0fI127m751JrcXcqNxPm8X+eacYaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH3CBpgn54D45FZckjJi1Ccos/m/JPI6FPlPy5vq+AFVVpMaYpr1/5EqnEUWVa0Lm4EGQBIAH6l7Gibs8ErN0Nk8OxFB3iY09j8qxIcBOx69n+Aa/JSYCf2bQuOMS843yZR2/P52HBX/9RA0En0gMCk3r01eC+QMwkD3rzBSNZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=K4bMr9hZ; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="K4bMr9hZ"
ARC-Seal: i=1; a=rsa-sha256; t=1790210963; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C6OxxNirUVo8czPnkvLNUCFrxaKA5MzRblZAnoH/ZLmCMvNhFMPVIFCJkGNkDKvjfhgF7hSYlnjvznzuqgojIJv4BzSDOvS1jtXtCEPQCYYPXLObvhCjmG38Bkr/Zs96azl2iagFPLGus0bSENm9pI8CauIq85CVQVEPUc6AXz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790210963; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uuqc54bkvlukR4BFPWuNxDTJOEzgqWrynHTVhmlGe8I=; 
	b=iAmLiHsbo88Znd2rCjBpZ+2zP2BKC8/L3r0A4VgRwvCAMRgXzpMuBPYYoJIkEhAbiJb6k++SBx2wzwsOcL23BB2BvqKz3zcHtUoy/r0wJgO4Y/g4VwMb4A9olG7HVM+V9m+f17UnE9Is0PjnEnOJYBpl4RS0hAuFKhpUaEZN8o4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790210963;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=uuqc54bkvlukR4BFPWuNxDTJOEzgqWrynHTVhmlGe8I=;
	b=K4bMr9hZfSckDFNhyQF56HDtM/dWCPFeQmeQzUSSbgdHMI+BVBxvf9s0Jw/4fjTB
	G7xvI1Ab4oTZ+Y0K5L8uExgmcDNSPzUQ3nJhzH8tC74nKpc+HChv6NG104ky96IP3EC
	o+GXR4r8qnvPq0HzLqnf8Ns8YgZ6kAQblhA79saY=
Received: by smtp.zohomail.com with SMTPS id 1790210962071157.82966756271844;
	Wed, 23 Sep 2026 17:49:22 -0700 (PDT)
Message-ID: <429dbeec-bb03-45cb-b8e8-2bf4db485cdc@zohomail.com>
Date: Thu, 24 Sep 2026 08:49:17 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/10] cxl/region: Log the coherency model at region
 creation
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1790103847.git.dave@stgolabs.net>
 <6b9283af30fd1347f346f9c7a011d6b1663f2e2e.1790103847.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <6b9283af30fd1347f346f9c7a011d6b1663f2e2e.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227f415d613578603b38ac1e68a000094a6ee96f92899198e87d67e78472c86404950162c8a5d3c01:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/23/2026 7:38 AM, Davidlohr Bueso wrote:
> Region assembly emits plenty of debug information - resources,
> interleave geometry, target placement - but not the coherency model
> the region operates in.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0a204aea64b5..f322a8a4a66d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1861,6 +1861,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> +static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
> +{
> +	if (type == CXL_DECODER_HOSTONLYMEM)
> +		return "HDM-H";
> +	return bi ? "HDM-DB" : "HDM-D";
> +}
> +
>  static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -2823,8 +2830,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(rc);
>  	}
>  
> -	dev_dbg(port->uport_dev, "%s: created %s\n",
> -		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> +	dev_dbg(port->uport_dev, "%s: created %s %s\n",
> +		dev_name(&cxlrd->cxlsd.cxld.dev),
> +		cxl_coherency_name(cxlr->type, cxl_root_decoder_is_bi(cxlrd)),
> +		dev_name(dev));
>  	return cxlr;
>  err:
>  	put_device(dev);


