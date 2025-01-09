Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E523C9;
	Thu,  9 Jan 2025 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736384936; cv=pass; b=Mu/tqqV29NO9NdWnqEJ49nLuq8UY0LZLr+UkeRJRlHfFhZmUn1KkOKdvutVsd5FRORy+A6+pCOetRptpB1z415jVWV0TRHRO+JAK8S+Csd79qABI4xSp99xREI2JEqI2kS0NlG8dvGPZiTKAJWP+EIsKnfktPJpwkggaLWy15tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736384936; c=relaxed/simple;
	bh=1q+oUwMQW3lVjj7h7RGT2+aWbxN7STZasgeKq2f5cwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9Xi9a5r9ULEBwt6HCQcqBS5xlZtn/t1cOvCzYhuYIG4Jycr1aAzDsckFLfmCVGyUzIGS8QaHLhfiQkdC2NYmDyvQPCfLVH1GPXfMAcvCilNiK6Af2TU25zJpIeVAOFqaRoDe1mIhrA0/2icpmxq3qPXu57pADQ/8KSeVNkJAno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AxDQACA8; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AxDQACA8"
ARC-Seal: i=1; a=rsa-sha256; t=1736384918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K7SQz3gC3NLSuJQEuFpEqZIb/Gpy5JPgtWPCKXlaz1s+gXDs78BnxhA9mEaP+2dCDZJCZbgWujxEdGDAHJ1qx+R+RvXoibJFyRFET2eARZpOm6Gs9EW05AcEsKKDGzSAQOGNylrtJajAqm5EdwnPAFQlNLysL6Og+U94709nxKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736384918; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RT0cBqlzWMNLk37LASEda1yPn0WiMVKPdog79YLC88Q=; 
	b=S/kPK7h5HDWH+f4etwZjHVp0OCNwktYZ59v4VLDmn5XjwRuhsiO679bwG1t2r4WVnH929T3H5MXJ7LdwvYgeJ5dhzb23tFcfghKasHqSpgYlAWuZEzZDVCQeQPgYSOT+A/brMtIw+czxN2nvNAqGyRT9iL7ig5bhdOaxVxbKNMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736384918;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=RT0cBqlzWMNLk37LASEda1yPn0WiMVKPdog79YLC88Q=;
	b=AxDQACA8BCpJEjtJOghgLahQMZ1GpEvug4lRTSKtLbjwDUOsSCOLm/2TJen66MzC
	zHk56tLMnpf9pYTaWJkbw5ZpXdGKpBhZc+5nRZle/TJOFUA7QodgdDbUgzsU5UXYKzf
	GAelZA0DwmZ5BbZ4ibooQmYcZbxEppVrA82/P42E=
Received: by mx.zohomail.com with SMTPS id 173638491552856.99746648802477;
	Wed, 8 Jan 2025 17:08:35 -0800 (PST)
Message-ID: <7a1a8340-a393-4781-957b-9da026b03bb5@zohomail.com>
Date: Thu, 9 Jan 2025 09:08:32 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/29] cxl/region: Split region registration into an
 initialization and adding part
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-9-rrichter@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250107141015.3367194-9-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122799652cc81f11738fdc0597a4000035721efb6abefa526a7be21d2b4ab898c75e769fb58f4f7abf:zu080112275f7447232efb12b175dc989a0000f8770d1876c8752afd9cb912a8c7f33d8e7938c534c59bd8ae:rf0801122db4a94bbfc0d6ea353cf7f6140000a6253a749621f1bbcea65e7beedc8bd27f9e9bcff497f81ff016660792a0f7:ZohoMail
X-ZohoMailClient: External

On 1/7/2025 10:09 PM, Robert Richter wrote:
> Before adding an endpoint to a region, the endpoint is initialized
> first. Move that part to a new function cxl_endpoint_initialize().
> The function is in preparation of adding more parameters that need to
> be determined in a setup.
>
> The split also helps better separating the code. After initialization
> the addition of an endpoint may fail with an error code and all the
> data would need to be reverted to not leave the endpoint in an
> undefined state. With separate functions the init part can succeed
> even if the endpoint cannot be added.
>
> Function naming follows the style of device_register() etc. Thus,
> rename function cxl_add_to_region() to cxl_endpoint_register().
>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  5 +++--
>  drivers/cxl/port.c        |  9 +++++----
>  3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d5dcc94df0a5..5132c689b1f2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3340,7 +3340,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		dev_name(&cxlr->dev), p->res, p->interleave_ways,
>  		p->interleave_granularity);
>  
> -	/* ...to match put_device() in cxl_add_to_region() */
> +	/* ...to match put_device() in cxl_endpoint_add() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
>  
> @@ -3352,19 +3352,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> -int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> +static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd;
> -	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
> -	bool attach = false;
> -	int rc;
>  
>  	cxlrd = cxl_find_root_decoder(cxled);
>  	if (!cxlrd)
>  		return -ENXIO;
>  
> +	cxled->cxlrd = cxlrd;
> +
> +	return 0;
> +}
> +
> +static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	bool attach = false;
> +	int rc;
> +
>  	/*
>  	 * Ensure that if multiple threads race to construct_region() for @hpa
>  	 * one does the construction and the others add to that.
> @@ -3401,7 +3410,18 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  
>  	return rc;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
> +
> +int cxl_endpoint_register(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	rc = cxl_endpoint_initialize(cxled);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_endpoint_add(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_register, "CXL");

Hi Robert,


cxl_endpoint_initialize(), cxl_endpoint_add(), cxl_endpoint_register() feels like some functions related to an endpoint, but I think they are for an endpoint decoder enabling, maybe rename them to cxl_endpoint_decoder_initialize()/add()/register()?


Ming

