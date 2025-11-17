Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8326E6F6
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393647; cv=none; b=XLp9zbIL4UgRiTYlJIC3na0IIrIApI5LsQsbnrMkUZNZdgerS6HHJFvHDJsw3D9ZdT8sBeIrF1ezGN4gQ5JjNCZdPGXfLgwisNicKGn6w6LhLLRtlSTpQ5LggOXFncSWo02BWiZyE6P3HE13+tYN0RhGefI10X684ELV/foHCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393647; c=relaxed/simple;
	bh=Au9jW2vvTsIauDFDaao4kZLdQ5YNH+81ITvvlm/GRog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igUI/lrSLYzZ560lbpUtp5nF6pUUF4R4ohlSr5AJLSqqYZdNzjZlJ1xvejiX9lQWzgZ2X4jWLxreOYNz6jjEVcZn5geAZD5qkG1PGbzRx+syNDQTHukcVrHfDqtQYxpCIlDl37m/9MGMf9Lg/uPBo6UizlqoyNqLAZFqoUp82NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmQfcbYQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmQfcbYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763393646; x=1794929646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Au9jW2vvTsIauDFDaao4kZLdQ5YNH+81ITvvlm/GRog=;
  b=gmQfcbYQwMDkNslpOvmXcAWfid7LE2HgOwv9p+pc95XfiYUeGwKK5jtN
   zjiMZvwpLPs50Bc0ISLwyUisQ4NUH4UoP12tXsl56Wi6D47B1ZsPMlUyf
   77gXa2xn7L3xWvimXU58ydUnC5DGesjI09jE1GvYyjKisNRwnZyCwL7dt
   +VtmCYih/sdYhh966ogx/XsEVr4x7X4hlpE9hfilt288Pg5e5esAoDpro
   Jq1E1YHJUF296YmvVEITjnibH4IDo1zywfzjpAlJNuCn2+mfXdRwNN0ec
   SnCNKJg4kpobGy7PxGwRePnLNx5LH85lagfdFOPkKfOO+ZQUFmiAMg4m9
   w==;
X-CSE-ConnectionGUID: NV1oRIPkTiSFLDY2HjIXpA==
X-CSE-MsgGUID: XTjIswwSTfa2zLRJtlO28g==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65331017"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65331017"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:34:05 -0800
X-CSE-ConnectionGUID: 3u1XHCJrTR6Y5XKpqCCErg==
X-CSE-MsgGUID: Mqm5ClFvSXG3+tlHygzlqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="194801710"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 07:34:02 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject:
 Re: [PATCH v2 2/3] cxl/test: Add cxl_test CFMWS support for extended linear
 cache
Date: Mon, 17 Nov 2025 16:34:00 +0100
Message-ID: <2049680.vYEEZNnvjD@fdefranc-mobl3>
In-Reply-To: <20251117144611.903692-3-dave.jiang@intel.com>
References:
 <20251117144611.903692-1-dave.jiang@intel.com>
 <20251117144611.903692-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 17, 2025 3:46:10=E2=80=AFPM Central European Standard T=
ime Dave Jiang wrote:
> Add a module parameter to allow activation of extended linear cache
> on the auto region for cxl_test. The current platform implementation
> for extended linear cache is 1:1 of DRAM and CXL memory. A CFMWS is
> created with the size of both memory together where DRAM takes the
> first part of the memory range and CXL covers the second part. The
> current CXL auto region on cxl_test consists of 2 256M devices that
> creates a 512M region. The new extended linear cache setup will have
> 512M DRAM and 512M CXL memory for a total of 1G CFMWS. The hardware
> decoders must have their starting offset moved to after the DRAM region
> to handle the CXL regions.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - change to use mock_auto_region_size
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  tools/testing/cxl/test/cxl.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index f0e734536081..2c3979c0b505 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -15,6 +15,7 @@
>  #include "mock.h"
> =20
>  static int interleave_arithmetic;
> +static bool extended_linear_cache;
> =20
>  #define FAKE_QTG_ID	42
> =20
> @@ -429,6 +430,24 @@ static struct cxl_mock_res *alloc_mock_res(resource_=
size_t size, int align)
>  	return res;
>  }
> =20
> +/*
> + * Only update CFMWS0 as this is used by the auto region.
> + */
> +static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
> +{
> +	if (!extended_linear_cache)
> +		return;
> +
> +	if (index !=3D 0)
> +		return;
> +
> +	/*
> +	 * The window size should be 2x of the CXL region size where half is
> +	 * DRAM and half is CXL
> +	 */
> +	window->window_size =3D mock_auto_region_size * 2;
> +}
> +
>  static int populate_cedt(void)
>  {
>  	struct cxl_mock_res *res;
> @@ -453,6 +472,7 @@ static int populate_cedt(void)
>  	for (i =3D cfmws_start; i <=3D cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window =3D mock_cfmws[i];
> =20
> +		cfmws_elc_update(window, i);
>  		res =3D alloc_mock_res(window->window_size, SZ_256M);
>  		if (!res)
>  			return -ENOMEM;
> @@ -783,6 +803,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder =
*cxld)
>  	}
> =20
>  	base =3D window->base_hpa;
> +	if (extended_linear_cache)
> +		base +=3D mock_auto_region_size;
>  	cxld->hpa_range =3D (struct range) {
>  		.start =3D base,
>  		.end =3D base + mock_auto_region_size - 1,
> @@ -1609,6 +1631,8 @@ static __exit void cxl_test_exit(void)
> =20
>  module_param(interleave_arithmetic, int, 0444);
>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
> +module_param(extended_linear_cache, bool, 0444);
> +MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache su=
pport");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> --=20
> 2.51.1
>=20
>=20
>=20




