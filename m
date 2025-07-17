Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0427A448;
	Thu, 17 Jul 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761663; cv=none; b=ecRZwUe3OuuXt8L2uEstChlbwFTRlIkVMgJn/gt5FLr90ubI0S5TccpnYo//d0BjOlXiIQ3Ys86hOpbv55LLzE/CvsDuJBkxfJ+J24HAKG54DT9kbSZ6McYUiKwFCFYjuD6Eu8vcZ4a1bdznYVux3ARMrDJ5WheQsr/e9Gk2EXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761663; c=relaxed/simple;
	bh=3vWAkc4NBBEgL0bm5FI3OoK4PX5l4yfcxpfaZZRvNz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2ePOesmIoyRO5GkK9RGOuYQ4kuoz9QiErpH7dfwid5wOIYsvAHCrncjnF2ZRN2LrycHRwz1fppJiJKFv07z0ZjT9MZd1zNpk3NerC7pDGD4m6vado1rDSvap8S0hryhS7M1rtH6Fb4f3vjR6m1eKsJqVDkQht1lSSHORUHLFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmGGgrYZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmGGgrYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752761663; x=1784297663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vWAkc4NBBEgL0bm5FI3OoK4PX5l4yfcxpfaZZRvNz0=;
  b=hmGGgrYZ+S/W9KzD16sVC0NQEBBzA1XUdwWgDI7M2n1IMYBkZBgYxcS/
   5PVQ/yfVXajYl5N8ZeUaaH2KRdGbUwErIwrTVIic/cSCJ2+FIzqgtVQTM
   61bnO/5i5JBPgB1OrQqLo828Wu2o8+MFoNLNvvYZPj42J8mxIJ0aUm7D8
   iT1BZATSqkuGipEQZhjX6YRZ1TtN0p/QDYrVNC3/GEQEmW++L38npMsTI
   Vom35JeyNYN4CHLD8uK8XsPt4+7/xbY6gHiSyai+EVgPuOIR8BiHxmdPw
   g6lEYv46HkYW//KDTldq5snS2omjZnj51Ge5rVGij1APAHIYJm7K2mphe
   Q==;
X-CSE-ConnectionGUID: Se8mjyDBRiGemKdaXa0uMA==
X-CSE-MsgGUID: xJR3xvi8QpmznvW97CALDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66487073"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66487073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:14:22 -0700
X-CSE-ConnectionGUID: avlw3jjNSrqv2y4GmrK/1A==
X-CSE-MsgGUID: HnjyhLQdQW2jSWjBEuOS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157875215"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.203])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:14:16 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Thu, 17 Jul 2025 16:14:13 +0200
Message-ID: <17128669.tgchFWduMW@fdefranc-mobl3>
In-Reply-To: <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
References:
 <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <1985851.b9uPGUboIS@fdefranc-mobl3> <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, July 7, 2025 9:55:03=E2=80=AFPM Central European Summer Time Gre=
gory Price wrote:
> On Fri, Jul 04, 2025 at 12:05:33PM +0200, Fabio M. De Francesco wrote:
> > On Thursday, July 3, 2025 9:40:21=E2=80=AFPM Central European Summer Ti=
me Gregory Price wrote:
> > > On Tue, Jul 01, 2025 at 08:23:57AM -0700, Dave Jiang wrote:
> > > >=20
> > > >=20
> > > > On 6/23/25 12:19 PM, Gregory Price wrote:
> > > > > On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco w=
rote:
> > > > >> Add documentation on how to resolve conflicts between CXL Fixed =
Memory
> > > > >> Windows, Platform Memory Holes, and Endpoint Decoders.
> > > > >>
> > > > >> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux=
=2Eintel.com>
> > > > >=20
> > > > > I won't block a doc update on a suggestion so
> > > > >=20
> > > > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > > >=20
> > > > >> +Platform Firmware (BIOS) might reserve part of physical address=
es below
> > > > >> +4 GB (e.g., the Low Memory Hole that describes PCIe memory spac=
e for MMIO
> > > > >> +or a requirement for the greater than 8 way interleave CXL regi=
ons starting
> > > > >> +at address 0). In that case the Window Size value cannot be any=
more
> > > > >> +constrained to the NIW * 256 MB above-mentioned rule.
> > > > >=20
> > > > > It might be nice to have a diagram that explains this visually, a=
s it's
> > > > > difficult for me to understand the implications through words alo=
ne...
> > > >=20
> > > > +1 on request for diagram to explain. We should try to document thi=
s issue as clearly as possible. Thank you.
> > > >
> > >=20
> > > At the very least, it would be nice to have an explicitly example that
> > > explains the expected cfmws/decoder configurations that are valid but
> > > "technically" violate the spec
> > >=20
> > > I *think* this basically boils down to "CFMWS size is not aligned, but
> > > all the decoders it targets are"?  If I understand this correctly?
> > >=20
> > Yes, this is the intended meaning.=20
> >=20
> > E.g, two windows, 384 GB total memory, LMH at 2 GB:
> >=20
> > Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size =
| Ways | Granularity
> >   0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       =
|  12  |    256
> >   1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       =
|  12  |    256
>=20
>=20
> In this example, does the root decoder have 0/2 and the host bridge
> decoder have 0/3?  Because root decoders objects are created by reading
> the CFMWS Base/Size - while host bridge decoder objects are created by
> reading the host bridge DVSECS.
>
> Or does the linux code read CFMWS Base/Size and create a root decoder
> with 0/3 because "that's what it should have"?  etc
>
No, sorry for any confusion. I also noticed that some unwanted additional
lines slipped in my last reply, probably for a copy/paste mistake.

Let me explain...

The table above shows a real configuration copied from an x86 platform=20
where the Low Memory Hole (LMH) starts at 2GB.=20

The"HDM Decoder Base/Size" refers specifically to the CXL Endpoint=20
Decoders HPA range Base/Size. The first row of the table describes the=20
first window (CFMWS[0]), whose HPA rage base/size is 0/2GB, and the=20
Endpoint Decoder that the CXL driver should match with that CFMWS,=20
whose HPA range base/size is 0/3GB.

The Endpoint Decoder follows the 256MB x 12 interleave ways rule=20
mandated by the CXL specifications. Instead the CFMWS is truncated=20
immediately before the beginning of the LMH, because it needs to publish
only those memory locations that the system can address.  =20

Currently the CXL driver fails during the Region construction and=20
subsequent Endpoint Decoders attachment because it cannot match Root=20
Decoders (that are created with HPA ranges base/size equal to CFMWS)
and Switch Decoders with Endpoint decoders due to this size discrepancy.=20

The driver expects that the Endpoint Decoders HPA ranges to be contained=20
into their corresponding Root Decoders. Furthermore, Linux fails to=20
attach Endpoint decoders to already constructed CXL Regions because of=20
the same size discrepancy issue.=20
>=20
> I think you need to describe what the expected behavior is for what linux
> will produce in terms of the decoder objects given the above.
>
The expected behavior is that Linux should be able to match the Endpoint=20
Decoder with the Root Decoder range even if the CFMWS size is smaller=20
than the Decoder's, as long as the latter adheres to the 256MB * interleave=
=20
ways rule. Furthermore, Linux should be able to match the Endpoint decoders=
=20
with already constructed CXL Regions and allow the attachment process to=20
succeed.=20

This would enable the utilization of the 2GB memory described by CFMWS[0].

I hope this time I explained the LMH interference with CXL Regions=20
construction and Endpoint Decoders attachment with better clarity.

If this explanation suffices, I will incorporate it into the next version
of this patch and also explain that "HDM Decoder" stands for Endpoint Decod=
er=20
and that the CFMWS HPA base/size describes the System Physical Address (SPA=
)=20
which the CXL driver uses to make Root Decoders HPA range base/size.=20

Thanks,

=46abio


