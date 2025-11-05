Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625533BBDD;
	Wed,  5 Nov 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366297; cv=none; b=S4CnTbvd9+CMvRDpHAsphZKw/uootQnPmGlUfYOI4Q9tqLJujf0bo6KgqMnFE9xnR3z8UoHY2MouPn1+kUkE3/jqJ19IyqlY3REArVoa7zoNEn5lHesIfd1kVIDqxgYDReIZV3UuveJM4htvt6V4uS6BSYrtMcIugzSu5BscmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366297; c=relaxed/simple;
	bh=HJOrasHsdzKL7ziY1rWiO7Xa8XG99NhpujbH+jMlO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1DyzfcLiiD6pFi1VoCv5ppHX+OdKCjfR/fcsEqB1wooOZWe2cvIjmcihz/QBKemVnD+W9skB0TzGTkHmk3MSRUh0Zwd9BOKnK0k60kXIgkoyfYGw+vJuLhrFQyjW50LugOR+RKfCFgsr7XxBIRuhIZtE37gh42pD82/btoYYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR+QvzPa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR+QvzPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762366294; x=1793902294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJOrasHsdzKL7ziY1rWiO7Xa8XG99NhpujbH+jMlO2A=;
  b=DR+QvzPakGHWMVjqD5o9EIXAEHi7qHUkEf6LWefdFJHhqTvWV06NI4U/
   ROccsmJk173WuBiBt0ht1NYGqitQKYSUhnF3rCT8idj1haYcIJmtt62Va
   53XnWzM37Nm8/2dNCPW0O9bfu/xFM16XEUb7aMCVBC8OWP/FTxB389bqN
   zBIXVlomeG1vMuQcl4il9krzb0UpepEoDB5QRGv0I3OD9Pt768pR33rAT
   FxXfObVhydMVpgrA+FHwb+axupcGumpfDxtGCjoVML0pTnMUBQTBokAdk
   4P2Q+iiyw7ST4BQo0WE2Pd1NOcRP6lljKZokg7Edtj3BZ3Co2EcvOhZNp
   A==;
X-CSE-ConnectionGUID: vG8rY7k2RpiZhg2BJD6uxg==
X-CSE-MsgGUID: VF6SMOYlTGSnTU1bEplntQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64528331"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64528331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:11:32 -0800
X-CSE-ConnectionGUID: 3DPG09umSY+ohClMC7vdIA==
X-CSE-MsgGUID: 9ED2FR+aRBiht1pB9uzO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="211000706"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:11:27 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject:
 Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Wed, 05 Nov 2025 19:11:25 +0100
Message-ID: <5072006.vqk35OSZvh@fdefranc-mobl3>
In-Reply-To: <202510101555.zofjGvZF-lkp@intel.com>
References:
 <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
 <202510101555.zofjGvZF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, October 10, 2025 9:38:02=E2=80=AFAM Central European Standard Ti=
me kernel test robot wrote:
> Hi Fabio,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 46037455cbb748c5e85071c95f2244e81986eb58]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Frances=
co/cxl-core-Change-match_-_by_range-signatures/20251010-111627
> base:   46037455cbb748c5e85071c95f2244e81986eb58
> patch link:    https://lore.kernel.org/r/20251006155836.791418-3-fabio.m.=
de.francesco%40linux.intel.com
> patch subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory =
Holes on x86
> config: i386-buildonly-randconfig-005-20251010 (https://download.01.org/0=
day-ci/archive/20251010/202510101555.zofjGvZF-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251010/202510101555.zofjGvZF-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510101555.zofjGvZF-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    ld: drivers/cxl/core/platform_quirks.o: in function `platform_res_adju=
st':
> >> drivers/cxl/core/platform_quirks.c:95:(.text+0x1f1): undefined referen=
ce to `__udivdi3'
>=20
>=20
> vim +95 drivers/cxl/core/platform_quirks.c
>=20
>     76=09
>     77	void platform_res_adjust(struct resource *res,
>     78				 struct cxl_endpoint_decoder *cxled,
>     79				 const struct cxl_root_decoder *cxlrd)
>     80	{
>     81		if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
>     82			return;
>     83=09
>     84		guard(rwsem_write)(&cxl_rwsem.dpa);
>     85		dev_dbg(cxled_to_memdev(cxled)->dev.parent,
>     86			"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
>     87			dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
>     88		if (res) {
>     89			/* Trim region resource overlap with LMH */
>     90			res->end =3D cxlrd->res->end;
>     91		}
>     92		/* Match endpoint decoder's DPA resource to root decoder's */
>     93		cxled->dpa_res->end =3D
>     94			cxled->dpa_res->start +
>   > 95			resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
>=20
I think that the use of udiv_64() (per Alison suggestion) will fix this=20
error.

=46abio
>
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
>=20




