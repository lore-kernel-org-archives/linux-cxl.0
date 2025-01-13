Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EB3A8D0;
	Mon, 13 Jan 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787583; cv=none; b=tyCBOpbQRtkh6wk4NzxKnHk43goslCsuzpOfUUdpAvi8DCmnK+B9Ij5NDJW1MHQNDU7ADnoGclqe4nXwVr++Wc+eJIBWFXM1Eitu04rXlUMU9iYamnVZ0ddx1cuYjJSBCcaYZRferFdptRPJr+4A9djqyNX3uaypge3q+8aY61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787583; c=relaxed/simple;
	bh=siZ0rTNFMpozlsPu/dzzumTrAAArwxQ1076GX2N5v5w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4bH2le45AE4TfLR9IBoh99ssOROp9z2IVR30BvE0n6VVf2MfNhxoTIJ3aRWe5ebs4yIqtcne44/u73Fc4eZ89zIe8Q9iBJNjJ6+fWntXHjcklKMGpEUupVlS++37wxbTyK52tInr2eMPq2YPZQVVr4SQ+1VRXobsOzzaXsuzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWz3T4Ywyz67Q1X;
	Tue, 14 Jan 2025 00:58:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EAE33140498;
	Tue, 14 Jan 2025 00:59:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 17:59:37 +0100
Date: Mon, 13 Jan 2025 16:59:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 06/29] cxl/region: Factor out code to find the root
 decoder
Message-ID: <20250113165935.000021fc@huawei.com>
In-Reply-To: <20250107141015.3367194-7-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-7-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 15:09:52 +0100
Robert Richter <rrichter@amd.com> wrote:

> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This also simplifies the function cxl_add_to_region() as
> the change reduces its size and the number of used variables.
> 
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
One trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 752440a5c162..448408918def 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3202,6 +3202,38 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
>  	return range_contains(r1, r2);
>  }
>  
> +static struct cxl_root_decoder *
> +cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_decoder *cxld = &cxled->cxld;

Flip this and the line above and you can have

	struct range *hpa = cxld->hpa_range;

which is both shorter and matches original code save a few moments of
thinking.

> +	struct device *cxlrd_dev;
> +
> +	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
> +				      match_root_decoder_by_range);
> +	if (!cxlrd_dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * device_find_child() created a reference to the root
> +	 * decoder. Since the root decoder exists as long as the root
> +	 * port exists and the endpoint already holds a reference to
> +	 * the root port, this additional reference is not needed.
> +	 * Free it here.
> +	 */
> +	put_device(cxlrd_dev);
> +
> +	return to_cxl_root_decoder(cxlrd_dev);
> +}
> +
>  static int match_region_by_range(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p;
> @@ -3309,29 +3341,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct range *hpa = &cxled->cxld.hpa_range;
> -	struct cxl_decoder *cxld = &cxled->cxld;
> -	struct device *cxlrd_dev, *region_dev;
> +	struct device *region_dev;
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +	cxlrd = cxl_find_root_decoder(cxled);
> +	if (!cxlrd)
>  		return -ENXIO;
> -	}
> -
> -	cxlrd = to_cxl_root_decoder(cxlrd_dev);
>  
>  	/*
>  	 * Ensure that if multiple threads race to construct_region() for @hpa
> @@ -3349,7 +3369,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
>  
> @@ -3370,8 +3390,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	}
>  
>  	put_device(region_dev);
> -out:
> -	put_device(cxlrd_dev);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");

