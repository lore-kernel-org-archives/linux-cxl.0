Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D025680;
	Mon,  5 May 2025 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469094; cv=none; b=ksGI7tMYleAu63IpbMEDlCoUSkUNbe3HjmWcFebr1iRUQW7zErHbA3Af3b1ZcW4CH0ep5t7wlj5BUZ7iercqW+L6zrITm2uH5S53MSGnSN1muqqWYjG/e/TDqV6+TqiRebmxLVLIUBGYDzNxd2tI9uy65aHGN/HqUp6nQ5g83Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469094; c=relaxed/simple;
	bh=d1oCyEAhdl5k3byt/GQARFiUPsdGUPEYZ9qeb+fuMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdEVvjUTg0pxXKiuoK/THHvx8Is8sASE6Z/hh4X90KEC8kWO0vQFdZE11Xg6vIkcr7X1E0J7UIWhrDjFD9Vn3B1z3dpllRYUcbBaA2NBhESvaNlxv2yjluIfh7mx2UuSIrwgAueS8V49pnVrwnRvh/gfLhITQH//q0eBm4CK0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clDP0RsW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clDP0RsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746469093; x=1778005093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1oCyEAhdl5k3byt/GQARFiUPsdGUPEYZ9qeb+fuMV0=;
  b=clDP0RsWogglFjscS+zYKgo3NSGWJwsAdWPO6KXI2XADlUDRZysmE70a
   huYosKa/a4l8rAnI/K3WMdOMzmASI8P4KH/KvZQSKD6WZzdcLS9NoHPPC
   j6REkP6ER5XEM8FUHk3R37Na5m7Kr1gJ8gwp42XPHA4OdpgcFVBpp5HyX
   kAXyRkNdD7NFIApzMd3Yrz/w30k/eo1OME9WA4qrhwUh3hTBFWxO4wFoy
   zB+6SinmNDsndiWyiyofzOkcnLCQxXOrgJgh5o2UIOnRSZqzpxIaevhTW
   NHGc8eZ/M88X71C87kd24PAdPbYmc2TMkZjD7cq+Gpcr5r3/lmJYraytT
   A==;
X-CSE-ConnectionGUID: 09qI2G0eTRalK1Pv6s9czw==
X-CSE-MsgGUID: JoN/s9UbREmSd3N7+B/PQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58755467"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="58755467"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:18:12 -0700
X-CSE-ConnectionGUID: aLrVDZERTuaBC/6yoI32Gg==
X-CSE-MsgGUID: K/q7KrlITEShfCLGEV+p/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="166389318"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.37])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:18:08 -0700
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
 Re: [PATCH v5 11/14] cxl/region: Add function to find a port's switch decoder
 by range
Date: Mon, 05 May 2025 20:18:05 +0200
Message-ID: <3624777.dWV9SEqChM@fdefranc-mobl3>
In-Reply-To: <20250428214318.1682212-12-rrichter@amd.com>
References:
 <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, April 28, 2025 11:43:14=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a292d5c4c4a9..ef5408301714 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3205,33 +3205,39 @@ static int devm_cxl_add_dax_region(struct cxl_reg=
ion *cxlr)
>  	return rc;
>  }
> =20
> -static int match_root_decoder_by_range(struct device *dev,
> -				       const void *data)
> +static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 =3D data;
> -	struct cxl_root_decoder *cxlrd;
> +	struct cxl_decoder *cxld;
> =20
> -	if (!is_root_decoder(dev))
> +	if (!is_switch_decoder(dev))
>  		return 0;
> =20
> -	cxlrd =3D to_cxl_root_decoder(dev);
> -	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> +	cxld =3D to_cxl_decoder(dev);
> +	r1 =3D &cxld->hpa_range;
>  	return range_contains(r1, r2);
>  }
> =20
> +static struct cxl_decoder *
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +{
> +	struct device *cxld_dev =3D device_find_child(&port->dev, hpa,
> +						    match_decoder_by_range);
> +
> +	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> +}
> +
>  static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>  	struct cxl_port *port =3D cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) =3D find_cxl_root(port);
> -	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	struct cxl_decoder *root, *cxld =3D &cxled->cxld;
>  	struct range *hpa =3D &cxld->hpa_range;
> -	struct device *cxlrd_dev;
> =20
> -	cxlrd_dev =3D device_find_child(&cxl_root->port.dev, hpa,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> +	root =3D cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> +	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> @@ -3239,7 +3245,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *=
cxled)
>  		return NULL;
>  	}
> =20
> -	return to_cxl_root_decoder(cxlrd_dev);
> +	return to_cxl_root_decoder(&root->dev);
>  }
> =20
>  static int match_region_by_range(struct device *dev, const void *data)
>=20




