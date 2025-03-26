Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9741F4276;
	Wed, 26 Mar 2025 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006211; cv=none; b=t1aZxXhAX/zCQejrW67eg1EJ79TLtgKkSoZcG32Scfsvq/EV15dCrrQ6+A8mkLwYE61ggCoWqzHoXCoX3pCiwhmHiSFELspxForuM9sNZnE0WWwvfjcF8day9hmteJnsTYfo5XRZaq28pgBCsygiY7AhyHoPJk76w+iWeySlZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006211; c=relaxed/simple;
	bh=nPnx3oYTirJDrOHIV1nZVRXcnxyFBQz9FCV+07VhSgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmk5ny0y/DwDnLqkCKIJdXIA4XNs81y4cWjQLUNXJzxMq5GxiJvdSnBbgoluArPzJObMQhGujw+IIFxTP3krr4X+wghCa8ZjYUQ/j9TxnsLkjSCi3ohrzXzjsaa2Wd3bS/WLrKUblWTYKu3w4DpMF2DAWgaq5vneKP+AuCb34/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Shbe3zOi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Shbe3zOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743006210; x=1774542210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nPnx3oYTirJDrOHIV1nZVRXcnxyFBQz9FCV+07VhSgY=;
  b=Shbe3zOixLWIV82FLHOv31Y2jZnynFbTuFNKMO19kIgqMAZA36mJwRv7
   eJOWxoBcynEKRsyTcwu/JMuTl70X1AS2B7axfxFLkKTTkoPuqZv1RjCUB
   vAcd8aeQfrp7L0vi1pbC+AiuO1oARa70rA0KjM8CIlKOc51tCUKiLd8Xe
   VXTxy6VBnSaTrmKI2iaLkYPA7Fwc7OLlE6sGiW4b7WiQawPIlT+d2VH5Y
   HukWfHTMipeVrbTevQGCw0mOYruYJTySIxSM+4F+zrb705gZ0yOYDMJpi
   nFq8Ypzq1i7KPUJKj2I1+7b5FyZRu6nQy9PNhe4Hd4pmWktz8eOv5rj3E
   A==;
X-CSE-ConnectionGUID: wuOm4dRbT9KJxuaAqiysKw==
X-CSE-MsgGUID: DfLgHkQPQn6N0LMvaR1tKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55304854"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="55304854"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:23:29 -0700
X-CSE-ConnectionGUID: aDgz8b89RN6LcvD7b/+3Vg==
X-CSE-MsgGUID: p7pyJBusSmGGGnMVg6+/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124789951"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:23:23 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Wed, 26 Mar 2025 17:23:21 +0100
Message-ID: <3304445.h6RI2rZIcs@fdefranc-mobl3>
In-Reply-To: <Z9tzZkn1rqd2Uk_6@aschofie-mobl2.lan>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z9tzZkn1rqd2Uk_6@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 20, 2025 2:46:14=E2=80=AFAM Central European Standard Ti=
me Alison Schofield wrote:
> On Fri, Mar 14, 2025 at 12:36:29PM +0100, Fabio M. De Francesco wrote:
> > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Ho=
st
> > Physical Address (HPA) windows that are associated with each CXL Host
> > Bridge. Each window represents a contiguous HPA that may be interleaved
> > with one or more targets (CXL v3.1 - 9.18.1.3).
> >=20
> > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > memory to which systems cannot send transactions. On those systems, BIOS
> > publishes CFMWS which communicate the active System Physical Address (S=
PA)
> > ranges that map to a subset of the Host Physical Address (HPA) ranges. =
The
> > SPA range trims out the hole, and capacity in the endpoint is lost with=
 no
> > SPA to map to CXL HPA in that hole.
> >=20
> > In the early stages of CXL Regions construction and attach on platforms
> > with Low Memory Holes, the driver fails and returns an error because it
> > expects that the CXL Endpoint Decoder range is a subset of the Root
> > Decoder's (SPA >=3D HPA). On x86 with LMH's, it happens that SPA < HPA.
> >=20
> > Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> > Decoders or already made CXL Regions and Decoders to allow the
> > construction of new CXL Regions and the attachment of Endpoint Decoders,
> > even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Deco=
der
> > range end to match Root Decoder's.
>=20
> I think the dpa_res field of the endpoint decoder needs adjusting.
> After the region is setup, the cxled->dpa_res has the unadjusted value
> and that leads to region warning and address translation failure because
> the driver 'thinks' that DPA is within a region, but when it tries
> to translate to an HPA in that region, it fails.
>=20
> Here's where I looked at it: using the cxl-test LMH auto-region (nice!)
> each endpoint decoder is programmed to contribute 512MB to the 1024MB reg=
ion.
> The LMH adjustment shrunk the region to 768MB, so each endpoint is only
> contributing 384MB to the region.=20
>=20
> DPA->HPA address translations of DPA addresses in the 384->512 gap cause
> a problem. The driver will needlessly warn that they are in a region for
> any poison inject or clear, and will fail address translations for any
> poison, general media or dram event.
>=20
> I think this should fail in region.c: __cxl_dpa_to_region()
>         if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>                 return 0;
>=20
> For that to fail, LMH code needs to adjust cxled->dpa_res too.=20
>=20
>=20
> To test is using clear_poison you can:
> # echo 536866816 > /sys/kernel/debug/cxl/mem1/clear_poison
>   (536866816 =3D 512MB - 4096)
>=20
> [ ] cxl_core:__cxl_dpa_to_region:2860: cxl decoder18.0: dpa:0x1ffff000 ma=
pped in region:region0
> [ ] cxl_core:cxl_dpa_to_hpa:2963: cxl_region region0: Addr trans fail: hp=
a 0x3ff04fffe000 not in region
>=20
>=20
> snip
> >=20
>=20
Alison,

I'll adjust cxled->dpa_res too.
Thank you for noticing this issue.

=46abio=20



