Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A925743E;
	Tue, 25 Mar 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919240; cv=none; b=bTbHzXQGOgN5PhXlfFXroceqiGZ2nih4AI5QOsaPtZl8k82YEfhZDS/Xs1R8M5DEE8+2wu7XtK3exVQeejvO05WyBZnMcY2wGiWLa0JYF2443+NzvxJteOKHuGDPMpJJVbtoYo8hJJkK9T1rfKpMd2x3hwePdXSO3J8XNIq8Po4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919240; c=relaxed/simple;
	bh=L38YafdGDToQKYrS5NH2Bol95qw3fc/pF70+LVdbHvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eH9jzSK5Umv0s9MrmADgeY7WnnUJ7C69znWkWnA4H75M37bN6qEvC793WZnX4TlI6biYpV/TCPwFp1gx9QUlB9SKyKu1wiXenMnriUPyCiVmRTUCng4WDN23fK0Wv3hKIkboA+5jRofTgEfmFb3NU+9as1e+WkNLVUXY7HWJ9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbWcFSoH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbWcFSoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742919238; x=1774455238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L38YafdGDToQKYrS5NH2Bol95qw3fc/pF70+LVdbHvg=;
  b=NbWcFSoHLiW8ZfXoeOjssV4DVuzFDjlABemc4+f/UrM/uwkYr9kb7iP2
   KBy1dXnqQ4CrEyAKKxdGeqxXUAELH5a9nd3tqtGPaIfGLEC32ZzVj0s+D
   ZDAQpq3usj5hHhW+eLf6jtp4KGxEpoYFoisiyHVYm0P9QaX1rgkd2pURz
   PkWXt9R4J23KOanx3PBkekLRYP9QYJc93T+FzG2UDLtBlSlLfaLYgU+jt
   CWHQJpJ2QK7gR1oXDEbJzXK5EagOv1ctg4BY5ziDpPZJQ9KypODE6Vb8S
   xzSDEwWA93SyRLTUX3otezqACa/VyI0uqlxPM4PnlHOabfUe2nZqOWMS6
   g==;
X-CSE-ConnectionGUID: 9XEQ4AtpSpq83EirBHHXbQ==
X-CSE-MsgGUID: 2kRAhACNT6+gac1VsQ9EzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="66631400"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="66631400"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:13:58 -0700
X-CSE-ConnectionGUID: EJqbkwASQk6s/dCmkDO/Cw==
X-CSE-MsgGUID: Uf/tgZ+rQzWWEbdPOM5NbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129263578"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.169])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:13:55 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Tue, 25 Mar 2025 17:13:50 +0100
Message-ID: <3301434.hkbZ0PkbqX@fdefranc-mobl3>
In-Reply-To: <Z91Au5en7r6D7IsW@rric.localdomain>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z91Au5en7r6D7IsW@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, March 21, 2025 11:34:35=E2=80=AFAM Central European Standard Tim=
e Robert Richter wrote:
> Fabio,
>=20
> On 14.03.25 12:36:29, Fabio M. De Francesco wrote:
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
> >=20
> > - Patch 1/4 changes the calling conventions of three match_*_by_range()
> >   helpers in preparation of 3/4.
> > - Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
> >   the HPA range end for CXL Regions construction.
> > - Patch 3/4 enables CXL Regions construction and Endpoint Decoders
> >   attachment by matching Root Decoders or Regions with Endpoint
> >   Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
> >   constraints while Endpoints decoders' attachment.
> > - Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.
> >=20
> > Many thanks to Alison, Dan, and Ira for their help and for their reviews
> > of my RFC on Intel's internal ML.
> >=20
> > Commenting on v1, Alison wrote a couple of observations on what users
> > will see. I suggest anyone interested to see how this series affect
> > users to take a look at her observations.[0] Thank you!
> >=20
> > Changes for v3:
> >=20
> >   Re-base the series on cxl/next.
> >=20
> >   1/4 - 2/4:
> > 	Constify local variables.
> >   3/4:
> > 	Call arch_match_region() from region_res_match_cxl_range().
> >   4/4:
> > 	arch_match_region() - Check that region end is under start + 4G;
> > 	arch_match_spa() - Check that SPA range start is cfmws_range_start.
>=20
> I have sent comments for version 1 and suggested a simpler approach
> for this to implement.
>
I replied to your comments for version 1. Please find my message at=20
https://lore.kernel.org/linux-cxl/9930375.eNJFYEL58v@fdefranc-mobl3/.
>
> My comments haven't been addressed yet,
>
I think it's not possible to detect an LMH while still in cxl_port_add().
Therefore, I think that this is the best way to go. It works to prevent
the driver to fail to create Regions and attach Endpoint Decoders on x86
with Low Memory Holes, provided that the lower SPA range starts at 0x0.

On platforms with other kind of holes, the driver will continue to fail
as it currently does.=20
>
> but we
> need better isolation to reduce interference with other platforms and
> archs. Please take a look again.
>
Interference? Do you mean that this series would make the driver fail on=20
other platforms?=20

Of course I don't want anything like that. I'm not clear about it...
Would you please describe how would this series interfere and what
would happen on other platforms?

Thanks,

=46abio
>
> Many thanks,
>=20
> -Robert
>=20




