Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFF27280B;
	Wed,  5 Nov 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366876; cv=none; b=Nc0oB3S34Y8KXhceMsGPS7GVMzQeTfRwlGNZ+pkyc03Z4gEd/CZSLSS6QO+IK+spFUsiv6g56UBIg1g2NaXKmJCKQkMNkEnJYBVHylRJ8FNZgxfbSdi7cv9BAS0r9Nn+P/0ygGUq44Gmq5YABUZi2C93D7yowfVr6eIgHz1prlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366876; c=relaxed/simple;
	bh=tw2fKAiqIfdPJueUqkVDYMhYsacjnqAqVK0mvR2ogh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJdC1dBtT5/wb0KHgCNEUFp9ARxxZJgfijt9J1r0h2EWob+TfXReXqhm0mG+rm+tUP1bLePTkfIweEppsS8KYcmZAcyVUairOgVQlQF5Nbvi1eR4TcZ4HwtMRK16KyxuaG7vD27tnzU+IvzqOP5XkfkMzPF2iFilOOOFIEVR5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e79BTNeZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e79BTNeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762366875; x=1793902875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tw2fKAiqIfdPJueUqkVDYMhYsacjnqAqVK0mvR2ogh0=;
  b=e79BTNeZxp3DZgEgReMWwA6vZ8J6iGHIAp2D9iIoUyOisGviNbKYZWhH
   2Wig8EKtdu4ULENBg4rty/V5lB36J/5OvDwJS0KghcCPg9IxiPfMYMdIs
   Gw5VyTiI72JaKsd+bgUk1lLspqNcjouu4BwYWH0CGkAy7UN3f+of7gmC+
   xe33abxlAvAJjk5WWYhwATkWJwRHiI8rdKHL1ZO9xv51MUESU9aEeT9Uy
   TaFjHcEcWZwbZRkgD+iBxxRh9ojibWNXr15+0QKmk2fc7Nuy89VFm/H1/
   8Mr6/gk60eTiEp+3dnL/9djKqWFacg7QIDUCPtpdKDdLSz3e0zZWC4o5q
   A==;
X-CSE-ConnectionGUID: Ja97D2f1Ssi2pvnip/0wOw==
X-CSE-MsgGUID: o+4ebKXMSaKtxFDUmveoWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75101376"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75101376"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:20:58 -0800
X-CSE-ConnectionGUID: KaunMcuLQYS9CPHKuzhAsQ==
X-CSE-MsgGUID: TftjzIXHTdWy20OURx3Ulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="191814265"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.26])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:20:53 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Davidlohr Bueso <dave@stgolabs.net>,
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
Date: Wed, 05 Nov 2025 19:20:50 +0100
Message-ID: <2093111.UnXabflUDm@fdefranc-mobl3>
In-Reply-To: <202510102229.iFcGqbMH-lkp@intel.com>
References:
 <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
 <202510102229.iFcGqbMH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, October 10, 2025 4:49:01=E2=80=AFPM Central European Standard Ti=
me kernel test robot wrote:
> Hi Fabio,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 46037455cbb748c5e85071c95f2244e81986eb58]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Frances=
co/cxl-core-Change-match_-_by_range-signatures/20251010-111627
> base:   46037455cbb748c5e85071c95f2244e81986eb58
> patch link:    https://lore.kernel.org/r/20251006155836.791418-3-fabio.m.=
de.francesco%40linux.intel.com
> patch subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory =
Holes on x86
> config: i386-randconfig-011-20251010 (https://download.01.org/0day-ci/arc=
hive/20251010/202510102229.iFcGqbMH-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251010/202510102229.iFcGqbMH-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510102229.iFcGqbMH-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/cxl/core/platform_quirks.c:70:36: warning: result of compariso=
n of constant 4294967296 with expression of type 'const resource_size_t' (a=
ka 'const unsigned int') is always true [-Wtautological-constant-out-of-ran=
ge-compare]
>       70 |             res->end < r->end && res->end < (LMH_CFMWS_RANGE_S=
TART + SZ_4G) &&
>          |                                  ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
>    1 warning generated.
>=20
Unavoidable warning wherever res->end is an u32 variable:

/* include/linux/types.h */

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

typedef phys_addr_t resource_size_t;

/* include/linux/ioport.h */

struct resource {
	resource_size_t start;
	resource_size_t end;
};

I think we should ignore this report.

=46abio
>=20
> vim +70 drivers/cxl/core/platform_quirks.c
>=20
>     50=09
>     51	/**
>     52	 * platform_region_matches_cxld() - Platform quirk to match a CXL =
Region and a
>     53	 * Switch or Endpoint Decoder. It allows matching on platforms wit=
h LMH's.
>     54	 * @p: Region Params against which @cxled is matched.
>     55	 * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
>     56	 *
>     57	 * Similar to platform_cxlrd_matches_cxled(), it matches regions a=
nd
>     58	 * decoders on platforms with LMH's.
>     59	 *
>     60	 * Return: true if a Decoder matches a Region, else false.
>     61	 */
>     62	bool platform_region_matches_cxld(const struct cxl_region_params *=
p,
>     63					  const struct cxl_decoder *cxld)
>     64	{
>     65		const struct range *r =3D &cxld->hpa_range;
>     66		const struct resource *res =3D p->res;
>     67		int align =3D cxld->interleave_ways * SZ_256M;
>     68=09
>     69		if (res->start =3D=3D LMH_CFMWS_RANGE_START && res->start =3D=3D =
r->start &&
>   > 70		    res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4=
G) &&
>     71		    IS_ALIGNED(range_len(r), align))
>     72			return true;
>     73=09
>     74		return false;
>     75	}
>     76=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
>=20




