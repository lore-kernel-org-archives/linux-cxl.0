Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFB217F24;
	Thu, 18 Sep 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205394; cv=none; b=qbe6IoMlRy64leffl03UT03pCOQW79d4EDTVcmkvzsRP6D0bL3aLGW8cDIt222ZUw/q6t1bOY86wJOC7SxwNNpyZwAB6tJx/RyzoOsStjyRTItAOEOsRkicQE/lkXnqeCyJKAjo4m8LuaeJqFguNv6SVaSMf8BFexcrOapHzHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205394; c=relaxed/simple;
	bh=JYI27Rz4siEIBkfczGeVSPn8FoTxcTNjfd248IzhWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYqj6km3t0L9Dd8A9qt4XCv1Nv3I3CCEZ93pcRQJR/JmkirNDaganbGJ+bTNt3obi03nmv7uJ+rGUIujCy9+OrbTP5qhq0r93LzmdDI+5DoyvUHTKR3rzP3jfFXv8808Dc9Nmt9DLqwJNuZWnRRMcgTwHuaVKIAusD6GSfS5xEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsVM/Gi5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsVM/Gi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758205393; x=1789741393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYI27Rz4siEIBkfczGeVSPn8FoTxcTNjfd248IzhWDY=;
  b=gsVM/Gi5ZC+DYoEc6cKRx3xbiLUwUy3KWFxRWYb/YSZKa6UBx2qxQMRt
   fIdk1Od0zLe6ZPI626M5i26St/Bmv4s3E6+d7/1fpVkD+X66NzrJd6UCf
   pA3lyzPaWxpEmw2Lnyr1hwRlndYAnOfFbgfMMFBwnWd5O2mf2015D11aK
   WI/axdplGIRE8GhTWuCFnW7hL5kqXzpvp6lIGTNu1+lQx/4Ycf1acx6qs
   1OYHm0/VVeT+pqkeESALJIkKtM9/yU6sCIMcfnab+5B7jWR+SURX+xMBx
   +LFlrB7m7WCrlnCP3MUs6a7JH6lc6VOBHK7k6aqCBMSrCKNa2QVYMHYOf
   g==;
X-CSE-ConnectionGUID: Nqp38s5uRZqcTduOoROoOQ==
X-CSE-MsgGUID: 6zoNVH0ZR8iAgIj1/uzlRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60426318"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60426318"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 07:23:12 -0700
X-CSE-ConnectionGUID: 2mAZMfHARk2djZs3t1J/gQ==
X-CSE-MsgGUID: b7HFBvHCRlKDc/I0sE+pAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="212707393"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 07:23:08 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/4 v4] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Thu, 18 Sep 2025 16:23:03 +0200
Message-ID: <7281194.9J7NaK4W3v@fdefranc-mobl3>
In-Reply-To: <301195cf-dbb3-45cc-927d-ffd58988aa37@amd.com>
References:
 <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
 <301195cf-dbb3-45cc-927d-ffd58988aa37@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Benjamin,

I thought again and decided to do a few more changes that you suggested...=
=20

On Friday, August 1, 2025 10:04:16=E2=80=AFPM Central European Summer Time =
Cheatham, Benjamin wrote:
> On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> > In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
>=20
> s/publishes/publish
>=20
> > SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> > HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> > ranges are always guaranteed to align to the NIW * 256M rule.
>=20
> s/to align to/to align due to/
>=20
> Also a spec reference for the rule would be helpful (same with next patch=
).
>=20
> >=20
> > In order to construct Regions and attach Decoders, the driver needs to
> > match Root Decoders and Regions with Endpoint Decoders, but it fails and
> > the entire process returns errors because it doesn't expect to deal with
> > SPA range lengths smaller than corresponding HPA's.
> >=20
> > Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> > with corresponding HPA's. They will be used in the process of Regions
> > creation and Endpoint attachments to prevent driver failures in a few
> > steps of the above-mentioned process.
> >=20
> > The helpers return true when HPA/SPA misalignments are detected under
> > specific conditions: both the SPA and HPA ranges must start at
> > LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
>=20
> maybe sub "that in x86 with LMH's is 0x0" with "0x0 on x86 with LMH's" al=
so
> s/SPA range sizes/SPA range's size/.
>=20
> > be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> > aligned to the NIW * 256M rule.
>=20
> s/be/is/ in above list.
>=20
> >=20
> > Also introduce a function to adjust the range end of the Regions to be
> > created on x86 with LMH's.
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/Kconfig         |  5 +++
> >  drivers/cxl/core/Makefile   |  1 +
> >  drivers/cxl/core/platform.c | 85 +++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/platform.h | 32 ++++++++++++++
> >  4 files changed, 123 insertions(+)
> >  create mode 100644 drivers/cxl/core/platform.c
> >  create mode 100644 drivers/cxl/core/platform.h
> >=20
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 48b7314afdb8..eca90baeac10 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -211,6 +211,11 @@ config CXL_REGION
> > =20
> >  	  If unsure say 'y'
> > =20
> > +config CXL_PLATFORM_QUIRKS
> > +	def_bool y
> > +	depends on CXL_REGION
> > +	depends on X86
> > +
>=20
> I'm confused on the intention behind this symbol. The naming suggests it'=
s for all platform quirks,
> but the code and dependencies make this x86-specific.
>=20
> I'm going to suggest making this x86-specific for now. I'm not aware of a=
ny other platforms with quirks
> (someone correct me if I'm wrong), so making this x86-specific is fine fo=
r now. I would rename this
> symbol to CXL_X86_QUIRKS, leave dependencies as-is, and rename platform.c=
 to something like platform_x86.c.
> Then, if someone comes along with other platform quirks they can do their=
 own symbol and file (or come
> up with a generic scheme).
>=20
I'll make it x86-specific for now. platform.c will be renamed to platform_x=
86.c
and CXL_PLATFORM_QUIRKS to CXL_X86_QUIRKS.

Thanks,

=46abio


