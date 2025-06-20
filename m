Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1684263F5B;
	Fri, 20 Jun 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423582; cv=none; b=b8lCid9UK2dOkEzet1yRzzaZ46OhDcJvZgrWj9cS9G14hlQSpfFYDm7pMmRVcLxpZXOjrS89zFDpeYxJsnyLj7CTYvtjfMI7DYsySgDEakcbZaPvTOdwlMMJXiF1DCt6VPvgU4yidBdwW5sucPpKcACiVk7gLR/Sp1qEM0eUZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423582; c=relaxed/simple;
	bh=8D/3rXr7aLfxT+nfdjxwtCzpi7Ojp5qrveWYUl0YqpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbAhbG08KJxYYTsivxcpR98NFECWIW2u/DI96vOVOS1r9jB8zM70whXqMkFmHj+12SCD2ysCfPZ1dwZq6Nk06FOs3cVmYHeQ4YuTYMK4LemxQnwjDX/IEOOE0q4RFzteBM3kSdenwS1T0CeTxNSq5qlkp6Z8ASI7+7E/PGvFGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0QPULLE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0QPULLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750423581; x=1781959581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8D/3rXr7aLfxT+nfdjxwtCzpi7Ojp5qrveWYUl0YqpU=;
  b=d0QPULLE1G8de43pY/zxgo2ixGGNKWG8NPP8q+EcNDHyU39PoAezGsko
   MPKCVsxR4lC12Vxo3Qu0K8UiRk3R5BTpr2f76t5ImTKVXwE4cOBSPaKiQ
   yY0m6YXh/XeszWWkRyO+sX+eqpRBl8C/TmO/5MZBUzDxj2uRcZSoLq1VD
   axx5kMgJIwUdzFXZ4PtQkEeBn11sHeI8aU8HwRUP3g0mRAK0mQDEZJbx0
   kXHVM8mBJmhzHfTpCXcYIWgOwJY8pEJU14Zw7LEugXZ8HNN55IE9M3wSP
   OihsG4MDtCYLT42kGsxrSLkf/MWhHBwU0Ek7U3jIQC33VSyLuQ/4V3uFD
   A==;
X-CSE-ConnectionGUID: 3x1qU5ZuSLOswWQg6bCoog==
X-CSE-MsgGUID: we34CWAeTtSLUWzEmBgSxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63737729"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63737729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:46:19 -0700
X-CSE-ConnectionGUID: sQr8BNk7QaetJSqb1QezEg==
X-CSE-MsgGUID: dHFA4dGhRsa9rCmOwD5ELQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150402846"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.215])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:46:15 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Fri, 20 Jun 2025 14:46:11 +0200
Message-ID: <4295321.aCxCBeP46V@fdefranc-mobl3>
In-Reply-To: <34fcdfb0-e32c-4eb3-8afe-49c34dcab2c3@infradead.org>
References:
 <20250618151710.1001847-1-fabio.m.de.francesco@linux.intel.com>
 <34fcdfb0-e32c-4eb3-8afe-49c34dcab2c3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Randy,

On Wednesday, June 18, 2025 5:54:35=E2=80=AFPM Central European Summer Time=
 Randy Dunlap wrote:
> Hi,
>=20
> On 6/18/25 8:17 AM, Fabio M. De Francesco wrote:
> > Add documentation on how to resolve conflicts between CXL Fixed Memory
> > Windows, Platform Memory Holes, and Endpoint Decoders.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >=20
> > diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentati=
on/driver-api/cxl/conventions.rst
> > index da347a81a237..acf2523ae799 100644
> > --- a/Documentation/driver-api/cxl/conventions.rst
> > +++ b/Documentation/driver-api/cxl/conventions.rst
> > @@ -45,3 +45,88 @@ Detailed Description of the Change
> >  ----------------------------------
> > =20
> >  <Propose spec language that corrects the conflict.>
> > +
> > +
> > +Resolve conflict between CFMWS, Plaftform Memory Holes, and Endpoint D=
ecoders
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Document
> > +--------
> > +
> > +CXL Revision 3.2, Version 1.0
> > +
> > +License
> > +-------
> > +
> > +SPDX-License Identifier: CC-BY-4.0
> > +
> > +Creator/Contributors
> > +--------------------
> > +
> > +Fabio M. De Francesco, Intel
> > +Dan J. Williams, Intel
> > +Mahesh Natu, Intel
> > +
> > +Summary of the Change
> > +---------------------
> > +
> > +According to the current CXL Specifications (Revision 3.2, Version 1.0)
> > +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more H=
ost
> > +Physical Address (HPA) windows that are associated with each CXL Host
> > +Bridge. Each window represents a contiguous HPA range that may be
> > +interleaved across one or more targets, some of which are CXL Host Bri=
dges.
> > +Associated with each window are a set of restrictions that govern its
>=20
>                                is
>=20
Okay.
>
> > +usage. It is the OSPM=E2=80=99s responsibility to utilize each window =
for the
> > +specified use.
> > +
> > +Table 9-22 states the Window Size field contains that the total number=
 of
>=20
>                                            contains the total number of
>
Ok.
>=20
> > +consecutive bytes of HPA this window represents and this value shall b=
e a
> > +multiple of Number of Interleave Ways * 256 MB.
> > +
> > +Platform Firmware (BIOS) might reserve part of physical addresses below
> > +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for M=
MIO
> > +or a requirement for the greater than 8 way interleave CXL regions sta=
rting
> > +at address 0). In that case the Window Size value cannot be anymore
> > +constrained to the NIW * 256 MB above-mentioned rule.
> > +
> > +On those systems, BIOS publishes CFMWS which communicate the active Sy=
stem
> > +Physical Address (SPA) ranges that map to a subset of the Host Physical
> > +Address (HPA) ranges. The SPA range trims out the hole, and capacity i=
n the
> > +endpoint is lost with no SPA to map to CXL HPA in that hole.
> > +
> > +The description of the Window Size field in table 9-22 needs to take t=
hat
> > +special case into account.
> > +
> > +Note that the Endpoint Decoders HPA range sizes have to comply with the
> > +alignment constraints and so a part of their memory capacity might not=
 be
> > +accessible if their size exceeds the matching CFMWS range's.
> > +
> > +Benefits of the Change
> > +----------------------
> > +
> > +Without this change, the OSPM wouldn't match Endpoint Decoders with CF=
MWS
> > +whose Window Size don't comply with the alignment rules and so all the=
ir
> > +capacity would be lost. This change allows the OSPM to match Endpoint
> > +Decoders whose HPA range size exceeds the matching CFMWS and create
> > +regions that at least utilize part of the decoders total memory capaci=
ty.
> > +
> > +References
> > +----------
> > +
> > +Compute Express Link Specification Revision 3.2, Version 1.0
> > +<https://www.computeexpresslink.org/>
> > +
> > +Detailed Description of the Change
> > +----------------------------------
> > +
> > +The current description of a CFMWS Window Size (table 9-22) is replaced
> > +with:
> > +
> > +"The total number of consecutive bytes of HPA this window represents. =
This
> > +value shall be a multiple of NIW*256 MB. On platforms that reserve phy=
sical
> > +addresses below 4 GB for special use (e.g., the Low Memory Hole for PC=
Ie
> > +MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a wi=
ndow
> > +size that doesn't align with the NIW*256 MB constraint; note that the
> > +matching Endpoint Decoders HPA range size must still align to the
> > +above-mentioned rule and so the memory capacity that might exceeds the
>=20
>                                                               exceed
>
Again.
>=20
> > +CFMWS window size will not be accessible.".
> >=20
> > base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa
>=20
Thanks,

=46abio




