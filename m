Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF02F549C;
	Fri,  4 Jul 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634700; cv=none; b=Natji55Vi8fsvXKMJ3OysYExhQUmZTA9WJB7GDY25S0+/gCpjkwkbou4rY5NuU2kVujLnmFKPFeuugsIayPtwhQyHFIfl2p4wrZdRxtciYSI8zwHwLifDBdNrX4MuxF2TbsCI6RyVDmWw7ziqaVIRk5uLCojNpSyMA5fFvFLAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634700; c=relaxed/simple;
	bh=3vf2eTlWWE4EMI7tNEErMjTbwzmeLu/3hhwvTGVHGnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fePXBOnYF222q1Dt5+M3AfS0P1Nk8ECJBSlUFz1JuL1gCdaN9FPku4PP6ZDJrWnO5Ad4+SsrTDwNIId+nOXXeMV5Ohvn153yQKYeR5p0jWkg9/TbFJp/+8kJQr/O/yTZTRccMfjKV72F2O6SSiVEqD9+7ZF+fz/ik7DvvEPzIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JigtWOV+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JigtWOV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751634699; x=1783170699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vf2eTlWWE4EMI7tNEErMjTbwzmeLu/3hhwvTGVHGnQ=;
  b=JigtWOV+0aTn8CmnS4LZmmFSEwX255Q1cM0PqEdqEVbxql+nbTMD5cBx
   OK63Nk5RZc7l/BkG/G8Akd9rccagd9z4Ttdoqk42Iy5GtTdHQrFsiHX5w
   sr/pB388U7C6v/UBTN3X4Yq4yv/9wnTVomLUf5yFJDIwAAn77+bVIKqWF
   5XnZ8LxxCndNDhUpnCJwWCcKOyC3M+H+HPNIwXdxWtHa+E93DQE+WuRbC
   HN9A2LoTYF/Vgt5iUzQng6d8DPbBMtBoDQzU69BoGKFtk7PRp7vWMDamz
   47Np3EMnUe3phOdKR5Hjpje/dfy4eee42awLutgi6uJPrZ2z1iswzD2Os
   w==;
X-CSE-ConnectionGUID: VIRlCCrHTNGmOItcRnrk/Q==
X-CSE-MsgGUID: 6Gi5yjhDQfGCUtD3gTPGOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53102037"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53102037"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:11:36 -0700
X-CSE-ConnectionGUID: sWa9hdRtR4KlH2tX5jwlpQ==
X-CSE-MsgGUID: /9b2KzexRZW84ifePy7JPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="185595645"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:11:32 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Fri, 04 Jul 2025 15:11:16 +0200
Message-ID: <8767023.EBGB3zze1k@fdefranc-mobl3>
In-Reply-To: <20250701141747.00003bf7@huawei.com>
References:
 <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <20250701141747.00003bf7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, July 1, 2025 3:17:47=E2=80=AFPM Central European Summer Time Jo=
nathan Cameron wrote:
> On Mon, 23 Jun 2025 17:29:02 +0200
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
>=20
> > Add documentation on how to resolve conflicts between CXL Fixed Memory
> > Windows, Platform Memory Holes, and Endpoint Decoders.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >=20
> > v2 -> v3: Rework a few phrases for better clarity.
> > 	  Fix grammar and syntactic errors (Randy, Alok).
> > 	  Fix semantic errors ("size does not comply", Alok).
> > 	  Fix technical errors ("decoder's total memory?", Alok).
> > 	 =20
> > v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> >=20
> >  Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >=20
> > diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentati=
on/driver-api/cxl/conventions.rst
> > index da347a81a237..d6c8f4cf2f5b 100644
> > --- a/Documentation/driver-api/cxl/conventions.rst
> > +++ b/Documentation/driver-api/cxl/conventions.rst
> > @@ -45,3 +45,88 @@ Detailed Description of the Change
> >  ----------------------------------
> > =20
> >  <Propose spec language that corrects the conflict.>
> > +
> > +
> > +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint De=
coders
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
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
> > +Associated with each window is a set of restrictions that govern its u=
sage.
> > +It is the OSPM=E2=80=99s responsibility to utilize each window for the=
 specified
> > +use.
> > +
> > +Table 9-22 states the Window Size field contains the total number of
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
>=20
> I'm not following argument for large interleave at address 0 being a prob=
lem
> (if we ignore the low memory hole and similar as a separate issue).=20
>
> Even
> if it is the interaction with the low memory hole, is 12 way interleave
> of 256MiB devices a problem?  Fills up to 3GiB.=20
>=20
Right, I'll drop that argument for large interleaves. The problem is still =
the=20
MMIO hole that might intersect the 3 GiB requirement for 12 way interleave.

Thanks,

=46abio


