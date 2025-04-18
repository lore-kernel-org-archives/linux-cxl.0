Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591513FD86;
	Fri, 18 Apr 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993426; cv=none; b=ieKTV4KfwzWlCtzDCExl217mH90Xh8294Imdgf2y1HcdlrLu0zHJyfqvtFa5faKPKIqmhvpfH7v2rL8EZANhxNLoprpZBV/cwsTdbXBTR7BIqsZkFH71F+3BVrsKEVrrJkUYFDrcRrJ6XWTQLBAomSA63MDSkLewBzODg7oqRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993426; c=relaxed/simple;
	bh=AhDfUvE0qHE1XcOdskGBkvm/Oc/TsQRybIzsQt1SJEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koSM/VUKSLmLUKul2K6W+Er/Z5mHfxB4b61xGXu/P0oyx9iFKzp3/zXGvrzK4iTsOOzAiPiKUk1RfyR1aXFHk/J5Wm3zsck4Kh8rBQ+l5vhVgPUtJ9142s9+qnxSyA3qcRlg/yI9lJLwfOtP2hA8wrcQgAA1L1bUtHLM2k1/5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhXHp1wS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhXHp1wS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744993424; x=1776529424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AhDfUvE0qHE1XcOdskGBkvm/Oc/TsQRybIzsQt1SJEw=;
  b=NhXHp1wSVy6gIT5sv2vU8v9+iHg5YikB3PLYFp8VX9+DsQyI/SY/RJCS
   b86+t3CqvuyzOgOsnDZbnSBmoVDunXslVpvPS6StLKGtQ9OU5EBQw6P4c
   fb6N1nMwxpQckwwna4WOYxvLrV/9VM5LQ7QqVLUpbByHbFWuy4TkwdrVn
   iRZ558PG5qokh/tInhH7GoexewxLYgi1LchcpUoA/h5KKphpp7xVXWBxg
   xjdYVgsL0QKPVC6Atjpp04V+ESy/1PJBa5tHke6RmFBGwBfn9VvmSoXOJ
   XvmiC1h/6MteaOEXKI1F1GTB1KRgnm0I6MfIlTz0aOkm5gNefEl9FtFap
   w==;
X-CSE-ConnectionGUID: WGFTJPiQTvW2JC5Czlzz0A==
X-CSE-MsgGUID: NcX1X0WJStWvA37fwCMWdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="57286495"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="57286495"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:23:41 -0700
X-CSE-ConnectionGUID: Tw4LkXDJT0SBuYDsKpd20g==
X-CSE-MsgGUID: ChHE4WOxQU2p90kmnzjILQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132043148"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.252])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:23:38 -0700
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
Subject: Re: [PATCH v4 01/14] cxl: Remove else after return
Date: Fri, 18 Apr 2025 18:23:35 +0200
Message-ID: <4239699.KrmzQ4Hd02@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-2-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:35=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
>=20
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
>
> ---
>  drivers/cxl/core/cdat.c   | 2 +-
>  drivers/cxl/core/pci.c    | 3 ++-
>  drivers/cxl/core/region.c | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index edb4f41eeacc..0ccef2f2a26a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
>  	 */
>  	if (entry =3D=3D 0xffff || !entry)
>  		return 0;
> -	else if (base > (UINT_MAX / (entry)))
> +	if (base > (UINT_MAX / (entry)))
>  		return 0;
> =20
>  	/*
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..33c3bdd35b24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, =
struct cxl_hdm *cxlhdm,
>  	 */
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
> -	else if (!hdm)
> +
> +	if (!hdm)
>  		return -ENODEV;
> =20
>  	root =3D to_cxl_port(port->dev.parent);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8537b6a9ca18..cbe762abf6b3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1940,7 +1940,9 @@ static int cxl_region_attach(struct cxl_region *cxl=
r,
>  	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "region already active\n");
>  		return -EBUSY;
> -	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +	}
> +
> +	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "interleave config missing\n");
>  		return -ENXIO;
>  	}
>=20




