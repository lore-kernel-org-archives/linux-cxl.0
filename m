Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8415AF6;
	Mon,  5 May 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467501; cv=none; b=Ma1ZfHK/kHpDGnyPtrPhrc8U6PA8Eg2FoovyLIIiNWr/YSGakTFAd2L60MfqGjDQhXAzjMoMt7LjwzrkkKXxwPVzivqvlste2bpGlt3XOyKtcyg474lKtZzB/7ciN/Kcbp3KVV3Pg0MIUb0SEABPtF1HVLnoVU02FLDBAVNh3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467501; c=relaxed/simple;
	bh=cFo07fxh1FaN6ySgd/hYQLRLPDK823VZoYb7B5ZHkH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rO4ReCw+x1u1/M/lLECYY/wZFNvOyp+AIysaLyGG4mxazWS9fLKXraU9ooAyvi+WcffZwv/W7ukjjRjE6f4zX4vIXqUsTOSSqVRGMHcksGTuA+4zWFAgIRJwHEt1lmVuFWBSKBgdmwfS54CinceV/RgFo49aGHI5VInkS1Mtwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JE1uIYwG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JE1uIYwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746467500; x=1778003500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFo07fxh1FaN6ySgd/hYQLRLPDK823VZoYb7B5ZHkH8=;
  b=JE1uIYwGvxpUVVMQWUv50Y9VG1GNR58B1UhVp/cPIw5lzwalG/Rm92AN
   WxpQERRRSKEbLjMxhcBBa11AfoJ44SKD/RkMepg5miwwq5Iun/wX5isjl
   kgtzZ5OJFwVaDUJ55tYy/2xPEbxENF7EaVx2PXkNZ7TpJdiu3IlsFjgoE
   zHqYKKOkKKD12MzlR1QY/qweHpfWgz9qkGZAQ2baEwO/APb7ZNyWEXidE
   qUUKSTxH62KYaskP2ScuTQTqn57cqFimXPt1ZoxaMa+m3e7j0KVoXe6vz
   Ac/7Z+TIDfT0lTJJD/VtQW5vwNAYDtuVWTM3A8H+Td8M+o3amSbptkaLW
   Q==;
X-CSE-ConnectionGUID: df+YKA8pSUivqs655wgN0Q==
X-CSE-MsgGUID: t6ruHHxFSAaVYt7d3FoVdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="35714972"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="35714972"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:51:39 -0700
X-CSE-ConnectionGUID: ipNwru0NR3yuCTwR66//Gw==
X-CSE-MsgGUID: 6zTM7JyhQ0+odew5D62jsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140488418"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.37])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:51:37 -0700
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
 Re: [PATCH v5 06/14] cxl/region: Avoid duplicate call of
 cxl_port_pick_region_decoder()
Date: Mon, 05 May 2025 19:51:32 +0200
Message-ID: <4956398.OV4Wx5bFTl@fdefranc-mobl3>
In-Reply-To: <20250428214318.1682212-7-rrichter@amd.com>
References:
 <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-7-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, April 28, 2025 11:43:09=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Function cxl_port_pick_region_decoder() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
> subsequently called from cxl_port_attach_region(). Make the decoder a
> function argument to both which avoids a duplicate call of
> cxl_port_pick_region_decoder().
>=20
> Now, cxl_rr_alloc_decoder() no longer allocates the decoder. Instead,
> the previously picked decoder is assigned to the region reference.
> Hence, rename the function to cxl_rr_assign_decoder().
>=20
> Moving the call out of alloc_region_ref() also moves it out of the
> xa_for_each() loop in there. Now, cxld is determined no longer only
> for each auto-generated region, but now once for all regions
> regardless of auto-generated or not. This is fine as the cxld argument
> is needed for all regions in cxl_rr_assign_decoder() and an error would
> be returned otherwise anyway. So it is better to determine the decoder
> in front of all this and fail early if missing instead of running
> through all that code with multiple calls of
> cxl_port_pick_region_decoder().
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/region.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e104035e0855..fa3d50982d04 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -931,7 +931,8 @@ static bool auto_order_ok(struct cxl_port *port, stru=
ct cxl_region *cxlr_iter,
> =20
>  static struct cxl_region_ref *
>  alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
> -		 struct cxl_endpoint_decoder *cxled)
> +		 struct cxl_endpoint_decoder *cxled,
> +		 struct cxl_decoder *cxld)
>  {
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	struct cxl_region_ref *cxl_rr, *iter;
> @@ -945,9 +946,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_re=
gion *cxlr,
>  			continue;
> =20
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -			struct cxl_decoder *cxld;
> -
> -			cxld =3D cxl_port_pick_region_decoder(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1029,19 +1027,11 @@ static int cxl_rr_ep_add(struct cxl_region_ref *c=
xl_rr,
>  	return 0;
>  }
> =20
> -static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region=
 *cxlr,
> -				struct cxl_endpoint_decoder *cxled,
> -				struct cxl_region_ref *cxl_rr)
> +static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_regio=
n *cxlr,
> +				 struct cxl_endpoint_decoder *cxled,
> +				 struct cxl_region_ref *cxl_rr,
> +				 struct cxl_decoder *cxld)
>  {
> -	struct cxl_decoder *cxld;
> -
> -	cxld =3D cxl_port_pick_region_decoder(port, cxled, cxlr);
> -	if (!cxld) {
> -		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> -			dev_name(&port->dev));
> -		return -EBUSY;
> -	}
> -
>  	if (cxld->region) {
>  		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
>  			dev_name(&port->dev), dev_name(&cxld->dev),
> @@ -1132,7 +1122,16 @@ static int cxl_port_attach_region(struct cxl_port =
*port,
>  			nr_targets_inc =3D true;
>  		}
>  	} else {
> -		cxl_rr =3D alloc_region_ref(port, cxlr, cxled);
> +		struct cxl_decoder *cxld;
> +
> +		cxld =3D cxl_port_pick_region_decoder(port, cxled, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			return -EBUSY;
> +		}
> +
> +		cxl_rr =3D alloc_region_ref(port, cxlr, cxled, cxld);
>  		if (IS_ERR(cxl_rr)) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: failed to allocate region reference\n",
> @@ -1141,7 +1140,7 @@ static int cxl_port_attach_region(struct cxl_port *=
port,
>  		}
>  		nr_targets_inc =3D true;
> =20
> -		rc =3D cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
> +		rc =3D cxl_rr_assign_decoder(port, cxlr, cxled, cxl_rr, cxld);
>  		if (rc)
>  			goto out_erase;
>  	}
>=20




