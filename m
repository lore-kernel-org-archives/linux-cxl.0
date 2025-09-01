Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91616257849;
	Mon,  1 Sep 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729472; cv=none; b=GvKlqz5sn9Uly9UueHyA9h7hkm2p6QFWbrJtm1jiYiNdS0w+MA1Tj5+SFdx5zMBa5LpzNMjqUyfVcyvLGCQBwZpuHjiTwSTZMKgf0LfjO6Ya0XFMAPndqyOoQoDv91E9MmUjgOvPjGZLherEW8ExUPBwadaQnkTiEWodsuvr2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729472; c=relaxed/simple;
	bh=Sj2yOlonlk9NytAupWdvQ+nqdCzx3NSCwCAKgCZlFKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohhnvpi28Yt85+syFhEg7Y9tzwcyXfOxNoMqk35fSjTPuQDXHHwP6PkcwyJTl9FotyVURSkW7qpA20LpqtJ3gghX7+jQMkUkAeM240NKBWeRO4qUsbHl3HwhHR7403A5/J8sZHKAbgMTgfUrpAlGpIjDx0PR2zfgETGfBasUyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W65xJbeC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W65xJbeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756729470; x=1788265470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sj2yOlonlk9NytAupWdvQ+nqdCzx3NSCwCAKgCZlFKQ=;
  b=W65xJbeCo2DpAgBGUfNwMdrgjd6aCoZz4HF6/XSKa8yjBv7Rf67AaSxI
   YRQS3SfIQ1XeM4aAwSceKH5iGH696LEZMNScd71SrDnp4P/q4f5nJncCX
   /jDo5px53+fBj/m0cbbwfTbPA/i4MItYQFTnCKz/1IWhXDlobpc0O3xeU
   txUqO07M6TECeVTtN/xooBXEl5gQML/PkypJnsT0FcagBt5rpGrraofN1
   PPk7S34YrcqNjIAohMsNlffRtbL6v08M7bZZp46fYfEC9D+/CR4x4E+Qm
   fnRHOiZCYOZBqwgm+nlFp7tHgIyYeoc0HAGXqqaeH2AmW81D/h0ak+FU7
   Q==;
X-CSE-ConnectionGUID: EEl8Uj58STeh0z5xr+kpXQ==
X-CSE-MsgGUID: 5lQVFJsGTiamh3vFi3TLGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58185766"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58185766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:24:30 -0700
X-CSE-ConnectionGUID: D6eFr4A/Sum/4CRp4vfBsg==
X-CSE-MsgGUID: BzW27I+2SMud4wrJ3B6YGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175149898"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:24:24 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Gregory Price <gourry@gourry.net>
Subject:
 Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts between
 CFMWS, LMH, Decoders
Date: Mon, 01 Sep 2025 14:22:00 +0200
Message-ID: <4179950.vuYhMxLoTh@fdefranc-mobl3>
In-Reply-To: <aK27hvifBdqZK5-v@rric.localdomain>
References:
 <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
 <aK27hvifBdqZK5-v@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Robert,

On Tuesday, August 26, 2025 3:49:58=E2=80=AFPM Central European Summer Time=
 Robert Richter wrote:
> Hi Fabio,
>=20
> questions inline.
>=20
[snip]
>
> > +
> > +On these systems, BIOS publishes CFMWS to communicate the active System
> > +Physical Address (SPA) ranges that map to a subset of the Host Physical
> > +Address (HPA) ranges. The SPA range trims out the hole, resulting in l=
ost
> > +capacity in the endpoint with no SPA to map to the CXL HPA range that
> > +exceeds the matching CFMWS range.
> > +
> > +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> > +starting at 2 GB:
> > +
> > +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size=
 | Ways | Granularity
> > +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB      =
 |  12  |    256
>=20
> Could you explain the zero-base limit and how this is special to LMH
>
Linux follows the CXL specs and so it allows the construction of CXL Regions
and the attachment of HDM Decoders to them only if the Specs are not violat=
ed.

This document addresses only one of many possible violations. The proposed=
=20
solution is not general to every possible Memory Hole on purpose.[1]

The proposed strategy wants to allow exceptions only if the CFMWS HPA range
starts at 0 and ends before 4GB. It only deals with Holes in Low Memory. The
many other combination of circumstances that lead to failures are out of the
scope of this document.
>=20
> or multiple of 3-way configs?
>
It applies to all possible NIW configs.
>
> What if the HPA range is non-cxl already?
>
This solution applies to all CFMWS HPA range that start at zero and end=20
before 4GB, regardless of the motivation behind memory reserve.
>
> E.g. my system shows this:
>=20
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000075b5ffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x0000000075b60000-0x0000000075baafff] ACP=
I NVS
> ...
>=20
> > +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB      =
 |  12  |    256
>=20
> The EP's HDM decoder's HPA ranges overlap now as both start at 0.
> Isn't that a spec violation: "Decoder m must cover an HPA range that
> is below decoder m+1."?
>=20
The HDM Decoder's HPA range in the second line starts at the fourth GB.
I made a copy/paste mistake and I'll fix it with the next version of this
patch. Thanks for spotting it.
>=20
> For the second decoder, shouldn't the upper limit be cut at 378 GB
> (multiple of 3, or 372, multiple of 12)? But since the CFMWS Base is
> non-zero that range is not detected to cut it?
>
Another mistake. Anyway, please notice that all ranges above 4GB are=20
out of the scope of this document. On purpose.=20
> >
[snip]
>
> > +Detailed Description of the Change
> > +----------------------------------
> > +
> > +The description of the Window Size field in table 9-22 needs to account
> > +for platforms with Low Memory Holes, where SPA ranges might be subsets=
 of
> > +the endpoints' HPA. Therefore, it has to be changed to the following:
> > +
> > +"The total number of consecutive bytes of HPA this window represents.
> > +This value shall be a multiple of NIW * 256 MB. On platforms that rese=
rve
> > +physical addresses below 4 GB, such as the Low Memory Hole for PCIe MM=
IO
> > +on x86 or a requirement for greater than 8-way interleave CXL Regions
> > +starting at address 0, an instance of CFMWS whose Base HPA is 0 might =
have
> > +a window size that doesn't align with the NIW * 256 MB constraint. Note
> > +that the matching intermediate Switch and Endpoint Decoders' HPA range
> > +sizes must still align to the above-mentioned rule, but the memory cap=
acity
> > +that exceeds the CFMWS window size will not be accessible."
>=20
> Have you considered to just allow smaller CFMWS ranges that just cut
> the boundaries accordingly? That is, just search for a CFMWS range
> within the EP's HPA ranges (or even multiple CFMWS ranges) and only
> enable that HPA range? That would be more general and removes some
> limitations, such as zero-base and below 4 GB only.
>=20
This solution doesn't want to be a general solution for all kinds of Memory=
=20
Holes. Dan has been very clear about cutting out solutions to general cases.
This solution is limited on purpose.[1]

Thanks,

=46abio

[1] https://lore.kernel.org/linux-cxl/67ec4d61c3fd6_288d2947b@dwillia2-xfh.=
jf.intel.com.notmuch/



