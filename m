Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF1A841B;
	Mon,  5 May 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465609; cv=none; b=lfu5sLoX29WJRsBjMDCNLWW4/ShWNr0mpyFgsuyEKp4XMzmVL8wB041qUjpX2YqvvIXKJZOGL9nVp7TWlL0wdysbOnC6WOTbj63t8s2l05LApxbSzaw2Aj4w9c5vlKQXOBWdyQMq/Yf9ZpI5jbZKpoNhGj/3r30SUedPGcojgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465609; c=relaxed/simple;
	bh=AHunCSRQuVG1PZEJUmTU+rm84pn3ol0aEk3MQT1ijpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpTssR2fim6y5phIz8emd84Wyf4u7vNofwxxc7loWk0jV8Glkfd+ZuvFFH6ImEFGCcLi1VFjGI/O0NBhK9FeIzKSOwbDHnrJBoV8QO+S2T4EKgoB8NE8UuUh74zfZ6vAP9jcwghV+LPY/7U8yJRGMf/YeC21gHkxlsWYfQUr+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWeJg7L3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWeJg7L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746465609; x=1778001609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHunCSRQuVG1PZEJUmTU+rm84pn3ol0aEk3MQT1ijpU=;
  b=ZWeJg7L3wC5Qiw+QV8MhOjz3E2mz8Cj+aN7Z+jhIWcXtz0wdma4dfSt6
   H2XZcKGuT4RTScV984tDxQewGXvWEDAco89BkVtRAhE/bgVRP6n4bQ6Dc
   skjp2ky10V+kLPCAOkCxZIAHa5m5JJUi6vYVRjFomaBd/mi2y+hwXeJJi
   hlKzA/QL8EeVWGpnlFAbRgyVdRTTlzn99c8Qya/7IaN4tiFrog1WEp0Tk
   q2JUaIItTeV6z12/Ngwgz0nutErWuZFtdtQKZ8Zfx+73j2cUbdvBzfxhx
   DaUVNT+i8hGHZd7n2ms5646uQCuul7iQ5u7edJDtSydbmNixUzWnNI/Xk
   w==;
X-CSE-ConnectionGUID: 4lLaCX1iRJKgtTGpu5kRBA==
X-CSE-MsgGUID: 8om/FgAvRxePsGeIlfMEPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58292971"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="58292971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:20:08 -0700
X-CSE-ConnectionGUID: uWqkcgMtQhSdbvILmEI/ug==
X-CSE-MsgGUID: 4op+IXj3QwiYY9LtXCgjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135819587"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.37])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:20:04 -0700
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
 Re: [PATCH v5 05/14] cxl/region: Rename function to
 cxl_port_pick_region_decoder()
Date: Mon, 05 May 2025 19:20:01 +0200
Message-ID: <2178421.9o76ZdvQCi@fdefranc-mobl3>
In-Reply-To: <20250428214318.1682212-6-rrichter@amd.com>
References:
 <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, April 28, 2025 11:43:08=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. In the region creation path the function
> is an allocator to find a free port. In the region assembly path, it
> is recalling the decoder that platform firmware picked for validation
> purposes.
>=20
> Rename function to cxl_port_pick_region_decoder() that better
> describes its use and update the function's description.
>=20
> The result of cxl_port_pick_region_decoder() is recorded in a 'struct
> cxl_region_ref' in @port for later recall when other endpoints might
> also be targets of the picked decoder.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e35209168c9c..e104035e0855 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -865,10 +865,25 @@ static int match_auto_decoder(struct device *dev, c=
onst void *data)
>  	return 0;
>  }
> =20
> +/**
> + * cxl_port_pick_region_decoder() - assign or lookup a decoder for a reg=
ion
> + * @port: a port in the ancestry of the endpoint implied by @cxled
> + * @cxled: endpoint decoder to be, or currently, mapped by @port
> + * @cxlr: region to establish, or validate, decode @port
> + *
> + * In the region creation path cxl_port_pick_region_decoder() is an
> + * allocator to find a free port. In the region assembly path, it is
> + * recalling the decoder that platform firmware picked for validation
> + * purposes.
> + *
> + * The result is recorded in a 'struct cxl_region_ref' in @port for
> + * later recall when other endpoints might also be targets of the picked
> + * decoder.

I wouldn't write here about what the callers do with the value returned by=
=20
this function. Maybe that this last paragraph belongs one layer up to the=20
calling sites?

Other than that...

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> + */
>  static struct cxl_decoder *
> -cxl_region_find_decoder(struct cxl_port *port,
> -			struct cxl_endpoint_decoder *cxled,
> -			struct cxl_region *cxlr)
> +cxl_port_pick_region_decoder(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled,
> +			     struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> =20
> @@ -932,7 +947,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_re=
gion *cxlr,
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  			struct cxl_decoder *cxld;
> =20
> -			cxld =3D cxl_region_find_decoder(port, cxled, cxlr);
> +			cxld =3D cxl_port_pick_region_decoder(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1020,7 +1035,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *po=
rt, struct cxl_region *cxlr,
>  {
>  	struct cxl_decoder *cxld;
> =20
> -	cxld =3D cxl_region_find_decoder(port, cxled, cxlr);
> +	cxld =3D cxl_port_pick_region_decoder(port, cxled, cxlr);
>  	if (!cxld) {
>  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>  			dev_name(&port->dev));
>=20




