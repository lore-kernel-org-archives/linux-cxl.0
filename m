Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF3290BB7;
	Tue, 22 Apr 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338170; cv=none; b=dd+vUnNbyhFDvGzt3phZwnMsGBbsF1obFWHZuMhQmhlNwOAESqe0mmez4S6kuTvks+hmbzzxW5ZHMsXXLnB/w52AimS9iB4h/itReefH/5dBHD6Cuggl0swE+abjNHxwconxZF20/yiqs2Vj3Dhh0BfBsF5bpVIzlEnclgwDq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338170; c=relaxed/simple;
	bh=C7P71zkwBaNY9uWlP0+qfCmkJrs2cKd4Jolmem8FPMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyVNgee9V0FmFocIiUhPPTrcZRhDaPbHAVpiVsKU7lCOqTk2Auv66+5G9dPoHFrQPCuKXeBCx1Cp80zw1Z4TzmDg38Yvpry21/TN15OzwJqZOHd+VdwQV+38XP91kvgGkwAi5YJSg+IebgO+SKPT2wgNvse4wWMqfRjSD98gg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMtzI6jS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMtzI6jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745338168; x=1776874168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7P71zkwBaNY9uWlP0+qfCmkJrs2cKd4Jolmem8FPMc=;
  b=IMtzI6jSF5RDKhKviVKrIb2vx0QdfbXv+3dmAB5L9GMjuTzk340R2nXy
   eTWeGbyd59i0HNnOkcmX0wKjdd7pw1ND61MLzwSDv87OoAJd7XWhcTGhX
   W9wrZAaZ9m1xCJ2mh1+BJHC1jzSCTdG38sbZ8PsueWIC4ionBXdZLR0m6
   zQzhf6yKIooxEae9duvj39u5ro1Xm7jnw6Gn+rnok3fed31qnn2uUMBqo
   OJ6LQnHpDGjx9k5uTlUNXTAPiBvPiH7Do9zD2afZp2HT1T3w3I9cqP6/d
   +u95BGl17+3hXP//+oFNgKD4mQZgZ66AG27gdcxS+W6iTRrJLvNf6Cs2H
   w==;
X-CSE-ConnectionGUID: moBUE26QTA2iAwU0tWFPng==
X-CSE-MsgGUID: 4PM0ADaUR2uPRQ+4u9JjBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57889250"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57889250"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:09:28 -0700
X-CSE-ConnectionGUID: 5/P/pHRyRZq4y9ard5ewPQ==
X-CSE-MsgGUID: dAOLPTsTQmipMWxPU6GsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="137039421"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.132])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:09:22 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>
Subject:
 Re: [PATCH v4 08/14] cxl/region: Factor out code to find the root decoder
Date: Tue, 22 Apr 2025 18:09:18 +0200
Message-ID: <18685083.PsWsQAL7t4@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-9-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:42=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This has the benefit of reducing cxl_add_to_region()'s
> function complexity.
>=20
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8244a27d0fd6..7d9d9b8f9eea 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3212,6 +3212,38 @@ static int match_root_decoder_by_range(struct devi=
ce *dev,
>  	return range_contains(r1, r2);
>  }
> =20
> +static struct cxl_root_decoder *
> +cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct cxl_port *port =3D cxled_to_port(cxled);
> +	struct cxl_root *cxl_root __free(put_cxl_root) =3D find_cxl_root(port);
> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	struct range *hpa =3D &cxld->hpa_range;
> +	struct device *cxlrd_dev;
> +
> +	cxlrd_dev =3D device_find_child(&cxl_root->port.dev, hpa,
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
>  static int match_region_by_range(struct device *dev, const void *data)
>  {
>  	struct cxl_region_params *p;
> @@ -3386,29 +3418,17 @@ static struct cxl_region *construct_region(struct=
 cxl_root_decoder *cxlrd,
> =20
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> -	struct cxl_port *port =3D cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) =3D find_cxl_root(port);
>  	struct range *hpa =3D &cxled->cxld.hpa_range;
> -	struct cxl_decoder *cxld =3D &cxled->cxld;
> -	struct device *cxlrd_dev, *region_dev;
> +	struct device *region_dev;
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	bool attach =3D false;
>  	int rc;
> =20
> -	cxlrd_dev =3D device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +	cxlrd =3D cxl_find_root_decoder(cxled);
> +	if (!cxlrd)
>  		return -ENXIO;
> -	}
> -
> -	cxlrd =3D to_cxl_root_decoder(cxlrd_dev);
> =20
>  	/*
>  	 * Ensure that if multiple threads race to construct_region() for @hpa
> @@ -3426,7 +3446,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *=
cxled)
> =20
>  	rc =3D PTR_ERR_OR_ZERO(cxlr);
>  	if (rc)
> -		goto out;
> +		return rc;
> =20
>  	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> =20
> @@ -3447,8 +3467,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *=
cxled)
>  	}
> =20
>  	put_device(region_dev);
> -out:
> -	put_device(cxlrd_dev);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>=20




