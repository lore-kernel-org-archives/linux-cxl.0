Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F330E83F;
	Fri, 20 Jun 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423422; cv=none; b=tXRR1NKsBAPEAeVKMeztQSzlcvFYJa7Mq4nFWtkfhSr2M9q2Hb7zXCYC6HfD/hgjkWMz2sQJKTDnKNJBacU0U1S+Dyy8F7FEROfaw29Q3bUXQF+Cwy2+7RjQ+3o5Jo8GwVrx1nhx7rLZ6lzVMZa8WD1qPMViZgePIRz3eFLi1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423422; c=relaxed/simple;
	bh=GFBJ48BJmbin7OvIjxInCjOTcSdsWlXFtQPkSlOVq4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpyNRxhe760abHASkdHTBWB7o98u9HtTYpJCSejWqrRM0JQd2aJCy5hn3lGFqUtg/52RkCmqu5fI/0VOufDP3wfEkkwndWPfaHDFErpkeoGc+OPUy9P4HB/5ZbaVIQdbUWJMz7N3SBuU5ZeAMHHJYJ/Jl2CDtq/z7xR2sCvMTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwC3y0j9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwC3y0j9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750423421; x=1781959421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFBJ48BJmbin7OvIjxInCjOTcSdsWlXFtQPkSlOVq4I=;
  b=mwC3y0j942kzHo3tCJtpdozNedCW5r67heO3vVlw9PDaP+dkwPjWxxmn
   E3X0kAqOH/N8DeDBX5zoSbCEERgMkKxRymRSjvH2a/SHO52FH5wlRNkTN
   lc453oefFhm0+JVlWa5ZEA1ERjLTWzZ68MXZa5z9XrjsTzrq2kUFvr+dy
   5P4yHWztTueQiYnp5Vzpa4OaRX9oDXSGzSYlyr9ytpcgIvdwyZki/649Z
   ABezKcx6SK87JwghDzmKVd133VYesLm8t0eQIDK7pDWcLRPStI4siVXuf
   UKPSxqdfbIUJogpnmCo+cyp7fbsNAbOSrJ5pAztW/Ahbg0pMSu0NxBend
   g==;
X-CSE-ConnectionGUID: jeLrnc57QmWxwcEmxPOCig==
X-CSE-MsgGUID: 1fK9k+RySYiexRQOsYsQ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70121849"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="70121849"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:43:40 -0700
X-CSE-ConnectionGUID: WFUbhHarSMq6gzeAfullQw==
X-CSE-MsgGUID: ih52RrnCSOO16gArwfrW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151437765"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.215])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:43:35 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Fri, 20 Jun 2025 14:43:32 +0200
Message-ID: <2884280.h6RI2rZIcs@fdefranc-mobl3>
In-Reply-To: <01769786-483d-4142-9b8f-f03f20998fe2@oracle.com>
References:
 <20250618161907.1008564-1-fabio.m.de.francesco@linux.intel.com>
 <01769786-483d-4142-9b8f-f03f20998fe2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, June 18, 2025 7:11:07=E2=80=AFPM Central European Summer Time=
 ALOK TIWARI wrote:
>=20
> On 6/18/2025 9:46 PM, Fabio M. De Francesco wrote:
> > Add documentation on how to resolve conflicts between CXL Fixed Memory
> > Windows, Platform Memory Holes, and Endpoint Decoders.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >=20
> > v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> >=20
> >   Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
> >   1 file changed, 85 insertions(+)
> >=20
> > diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentati=
on/driver-api/cxl/conventions.rst
> > index da347a81a237..acf2523ae799 100644
> > --- a/Documentation/driver-api/cxl/conventions.rst
> > +++ b/Documentation/driver-api/cxl/conventions.rst
> > @@ -45,3 +45,88 @@ Detailed Description of the Change
> >   ----------------------------------
> >  =20
> >   <Propose spec language that corrects the conflict.>
> > +
> > +
> > +Resolve conflict between CFMWS, Plaftform Memory Holes, and Endpoint D=
ecoders
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> typo Plaftform
>=20
Ah yes, "Platform".
>=20
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
> > +usage. It is the OSPM=E2=80=99s responsibility to utilize each window =
for the
> > +specified use.
> > +
> > +Table 9-22 states the Window Size field contains that the total number=
 of
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
>=20
> Size does not comply
>=20
Right!. Maybe "fit the alignment constraints"?
>
> > +capacity would be lost. This change allows the OSPM to match Endpoint
> > +Decoders whose HPA range size exceeds the matching CFMWS and create
> > +regions that at least utilize part of the decoders total memory capaci=
ty.
>=20
> the decoder's total memory ?
>=20
Ah yes, maybe "part of the memory devices capacity"?
>=20
> > +
> > +References
> > +----------
> > +
> > +Compute Express Link Specification Revision 3.2, Version 1.0
> > +<https://urldefense.com/v3/__https://www.computeexpresslink.org/__;!!A=
CWV5N9M2RV99hQ!KMvmUQzFTNqBga7-zQPzxmzSqdYgKZWELM7-GwPfbpk5BeOwvr0WMeZ9UxWW=
235HbZzpgBfnIUryy_eQSHsLGAt9Z7Abgi_UdiU$ >
> > +
> > +Detailed Description of the Change
> > +----------------------------------
> > +
> > +The current description of a CFMWS Window Size (table 9-22) is replaced
>=20
> Table 9-22
>
OK.
>=20
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
> > +CFMWS window size will not be accessible.".
> >=20
> > base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa
>=20
> Thanks,
> Alok
>=20
Thanks,

=46abio=20




