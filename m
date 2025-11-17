Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3024CEEA
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393571; cv=none; b=rbEs9bacptsJ0NeHbV6tKmIilEaYxjwqxSu8Iibb1tg074hdgVRYxilpC+6MbctHmYyGKSA1xiEv2ho0Z9Flqa9PcBvD814sHsFZ/Rw8oJrjOlNmVntVSzDydeAJd8vCDwLwWBRGHG2McOrzIfrSX6nJaQx9vRyDYhUUX03a6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393571; c=relaxed/simple;
	bh=XrgAn6aqkVWqQ7ZPbi/a6T1xGS2Dv9R/RZDwMyLptSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLy7K6uN9TOGYtA8vISeQpq3oT3mpi7f+zXq+B1nMdVWWbvE4PP5rckgaXb25V5c/Ie7Dzd7ylLOMKkcD9cKjROG87IZbFjHslV7DB7AC3MhcBfKXcvTydQb7yaUKcvQeZzLUo+rGZ3oVSs7dM+UyqfHBwNmyxoPheY/Dw4Dsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMWFiSpT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMWFiSpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763393570; x=1794929570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XrgAn6aqkVWqQ7ZPbi/a6T1xGS2Dv9R/RZDwMyLptSs=;
  b=dMWFiSpThOmPkSmusyHj3yBtPrqvzBOHmBaQYfRy1bp0TqM8trzXtZzc
   ROfpHW3rBT3oJw6qTjA81yCBOfHv5x69pbeqQcLHme6vWsFllof4OnDRr
   gEGetq3fCR6JVNS7bg7cfGtcodVA9kl6hoNYF97yQxFCRdY6ZBdxvIsaE
   JeHL4JTFNYy8I/7O26xjgbte/3zzCVbvfDCNlzXCIXAxPfmhXn3jbPHRZ
   Ky1WGhao5VgSK5GRW8rsKCVivy6u4H/jUSRwGHDUyhL53XLGv8eQKJEwQ
   8jSjwIGFiEr6M8+j26fuWDLpCvRwuF98dLchWNEogONMhtlKiAJe/s+NQ
   A==;
X-CSE-ConnectionGUID: tqH4e6nPQk2k3IrxdfA6VA==
X-CSE-MsgGUID: gf27z1XCTrm+X0cgMV6mdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76074022"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76074022"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:32:48 -0800
X-CSE-ConnectionGUID: 0KzML8UwShi5/LaFvam9eA==
X-CSE-MsgGUID: G79wUFv4TB2t264TuH75JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190930485"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:32:46 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] cxl/test: Standardize CXL auto region size
Date: Mon, 17 Nov 2025 16:32:44 +0100
Message-ID: <3401928.fdyTQepKt5@fdefranc-mobl3>
In-Reply-To: <20251117144611.903692-2-dave.jiang@intel.com>
References:
 <20251117144611.903692-1-dave.jiang@intel.com>
 <20251117144611.903692-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 17, 2025 3:46:09=E2=80=AFPM Central European Standard T=
ime Dave Jiang wrote:
> Create a global define for the size of the mock CXL auto region used
> in cxl_test. Remove the declared size in mock_init_hdm_decoder()
> function.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Make auto region size a global that can be changed at init. (Fabio)
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  tools/testing/cxl/test/cxl.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2d135ca533d0..f0e734536081 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -26,6 +26,9 @@ static int interleave_arithmetic;
>  #define NR_CXL_PORT_DECODERS 8
>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RC=
H)
> =20
> +#define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
> +static int mock_auto_region_size =3D MOCK_AUTO_REGION_SIZE_DEFAULT;
> +
>  static struct platform_device *cxl_acpi;
>  static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
>  #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
> @@ -738,7 +741,6 @@ static void mock_init_hdm_decoder(struct cxl_decoder =
*cxld)
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *port, *iter;
> -	const int size =3D SZ_512M;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
>  	struct device *dev;
> @@ -783,7 +785,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder =
*cxld)
>  	base =3D window->base_hpa;
>  	cxld->hpa_range =3D (struct range) {
>  		.start =3D base,
> -		.end =3D base + size - 1,
> +		.end =3D base + mock_auto_region_size - 1,
>  	};
> =20
>  	cxld->interleave_ways =3D 2;
> @@ -792,7 +794,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder =
*cxld)
>  	cxld->flags =3D CXL_DECODER_F_ENABLE;
>  	cxled->state =3D CXL_DECODER_STATE_AUTO;
>  	port->commit_end =3D cxld->id;
> -	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
> +	devm_cxl_dpa_reserve(cxled, 0,
> +			     mock_auto_region_size / cxld->interleave_ways, 0);
>  	cxld->commit =3D mock_decoder_commit;
>  	cxld->reset =3D mock_decoder_reset;
> =20
> @@ -841,7 +844,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder =
*cxld)
>  		cxld->interleave_granularity =3D 4096;
>  		cxld->hpa_range =3D (struct range) {
>  			.start =3D base,
> -			.end =3D base + size - 1,
> +			.end =3D base + mock_auto_region_size - 1,
>  		};
>  		put_device(dev);
>  	}
> --=20
> 2.51.1
>=20
>=20
>=20




