Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FE212B3F;
	Fri, 10 Jan 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525215; cv=none; b=DS2yiL84t5CODaGkOVrWRKBx7JVRyIDYgwjpmYldjoCeimZDjv4Z4mud7/w5n5rSOUsmSkcFjKqICPFrt56wCCRDEs41q5U1W7CXssuJfa/GPPLdN86mglAlnesd0fxDg2+FLtweyLv/BUOAkTZKjVAlUE4GMFwCb8sChpbgRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525215; c=relaxed/simple;
	bh=Q7AULa0NQUGcTZHqbQ9TnrdLo3gD+JiwM0t4JAnC7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfXvxl0Hj9KoksPO3kUGvAPEZBFqFqqc6nGt/+ozSaSAb/96YZQrXGm158mv2eO7fswyByVCj0yAPU2wLHDjLj6TG26jcR7Sxf6adIHNxOvuT2bMBwksBjbatljJX5sxJsfUECozyJd1FBZIs8fqWuy2atBAUuCtNdeXJTp/DdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwJMtjhm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwJMtjhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736525214; x=1768061214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7AULa0NQUGcTZHqbQ9TnrdLo3gD+JiwM0t4JAnC7WI=;
  b=CwJMtjhmHYaWNoH3XWdofA13VjzPe6O446y2pMM5LxNREZZSAlW7+3kD
   mYVlQrRMXJgmYHpViLFasqlb9EaCcYJlIjIeJvfYHQqLhT2dHvIuIoQa4
   jhZPDzqxX7bRc5FL0LMlIjaX9KuiCksOCDP3pv3tyzb/An64xrAMxa1US
   66NgeDDXgPQTUTpA/1yigqBIRsbX7cr1wnYvpdLmqmbIsYGfLwCm8l2KY
   hrqni+V8Q0oGPEHSPdHht1+ktRniygZpiVS5R7Dl+U12zv7NUPGNO7+q7
   VmBSLMrxmZTjBQhbLtOLDCDlQafWSCrxS8Y9HN3l3JH/ApzlF73rwMO9E
   g==;
X-CSE-ConnectionGUID: Cmiw5FaDRXCMnQkqAKZQLQ==
X-CSE-MsgGUID: im5hq8wXQT66WA7T64Bw4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36931867"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36931867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:06:53 -0800
X-CSE-ConnectionGUID: oEYg2YruSCuPwvENpfRtrQ==
X-CSE-MsgGUID: kQ7Y8rHWQEW93v5NzuvKFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141072514"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:06:48 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-cxl@vger.kernel.org,
 Li Ming <ming4.li@outlook.com>
Subject:
 Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Fri, 10 Jan 2025 17:06:45 +0100
Message-ID: <9260107.B369e8A3TW@fdefranc-mobl3>
In-Reply-To: <Z3-r3VjDfgtEp_pY@rric.localdomain>
References:
 <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <9930375.eNJFYEL58v@fdefranc-mobl3> <Z3-r3VjDfgtEp_pY@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Robert,

On Thursday, January 9, 2025 11:58:37=E2=80=AFAM GMT+1 Robert Richter wrote:
> Fabio,
>=20
> On 08.01.25 15:48:34, Fabio M. De Francesco wrote:
> > Hi Robert,
> >=20
> > On Monday, December 16, 2024 10:30:11=E2=80=AFPM GMT+1 Robert Richter w=
rote:
> > > Hi Fabio,
> > >=20
> > > On 22.11.24 16:51:53, Fabio M. De Francesco wrote:
> > > > The CXL Fixed Memory Window Structure (CFMWS) describes zero or mor=
e Host
> > > > Physical Address (HPA) windows that are associated with each CXL Ho=
st
> > > > Bridge. Each window represents a contiguous HPA that may be interle=
aved
> > > > with one or more targets (CXL v3.1 - 9.18.1.3).
> > > >=20
> > > > The Low Memory Hole (LMH) of x86 is a range of addresses of physica=
l low
> > > > memory to which systems cannot send transactions. In some cases the=
 size
> > > > of that hole is not compatible with the CXL hardware decoder constr=
aint
> > > > that the size is always aligned to 256M * Interleave Ways.
> > > >=20
> > > > On those systems, BIOS publishes CFMWS which communicate the active=
 System
> > > > Physical Address (SPA) ranges that map to a subset of the Host Phys=
ical
> > > > Address (HPA) ranges. The SPA range trims out the hole, and capacit=
y in
> > > > the endpoint is lost with no SPA to map to CXL HPA in that hole.
> > > >=20
> > > > In the early stages of CXL Regions construction and attach on platf=
orms
> > > > with Low Memory Holes, cxl_add_to_region() fails and returns an err=
or
> > > > because it can't find any CXL Window that matches a given CXL Endpo=
int
> > > > Decoder.
> > > >=20
> > > > Detect Low Memory Holes by comparing Root Decoders and Endpoint Dec=
oders
> > > > ranges: both must start at physical address 0 and end below 4 GB, w=
hile
> > > > the Root Decoder ranges end at lower addresses than the matching En=
dpoint
> > > > Decoders which instead must always respect the above-mentioned CXL =
hardware
> > > > decoders HPA alignment constraint.
> > > >=20
> > > > Match misaligned CFMWS and CXL Regions with corresponding CXL Endpo=
int
> > > > Decoders if driver detects Low Memory Holes.
> > > >=20
> > > > Construct CXL Regions with HPA range's end trimmed by matching SPA.
> > > >=20
> > > > Allow the attach target process to complete by relaxing Decoder con=
straints
> > > > which would lead to failures.
> > >=20
> > >  [...]
> > >

> > > I am implementing an address translation series and will post the
> > > patches in a couple of days. It solves a similar problem to remap
> > > (zero-based) endpoint address ranges to a different SPA range. I
> > > implemented a generic approach that can easily be reused here. With
> > > only a few changes to your series it could be integrated there (I
> > > could rebase my code onto your's then in a later version of my
> > > series).
> > >=20
> > > The change I suggest to your series will also significantly simplify
> > > your code and the function interface. The general idea is to have a
> > > .spa_range attribute in struct cxl_endpoint_decoder:
> > >=20
> > > @@ -428,6 +428,7 @@ struct cxl_endpoint_decoder {
> > >         struct cxl_decoder cxld;
> > >         struct cxl_root_decoder *cxlrd;
> > >         struct resource *dpa_res;
> > > +       struct range spa_range;
> > >         resource_size_t skip;
> > >         enum cxl_decoder_mode mode;
> > >         enum cxl_decoder_state state;
> > >=20
> > > Now, then an endpoint is detected, the spa_range is assigned,
> > > typically this is cxled->spa_range =3D cxled->cxld.hpa_range (SPA =3D=
=3D
> > > HPA). Whenever a port is added, a function cxl_port_platform_setup()
> > > is called which could also contain a call to
> > > cxl_port_setup_intel_lmh() or so.
> > >=20
> > > @@ -865,6 +870,8 @@ static int cxl_port_add(struct cxl_port *port,
> > >                         return rc;
> > >         }
> > > =20
> > > +       cxl_port_platform_setup(port);
> > > +
> > >         rc =3D device_add(dev);
> > >         if (rc)
> > >                 return rc;
> > >=20
> > > cxl_port_setup_intel_lmh() does all the platform checks and
> > > recalculates the spa_range for the endpoints based on the code you
> > > already have.=20
> > >
> > > The endpoint's SPA address range (instead of hpa_range)
> > > is now used to construct the region by changing
> > > match_region_by_range() accordingly. This avoids the instrumentation
> > > of all the other checks you needed to add in this patch (use of
> > > arch_match_region() and arch_match_spa() etc.).
> > >=20
> > > The only function that needs to be exported is
> > > cxl_port_setup_intel_lmh() then. Everything else is generic code. This
> > > is also a good encapsulation to other archs, vendors, platforms etc. I
> > > think that would really improve your series. Let me know if you have
> > > questions.
> > >
> > Sorry for this late reply. I just come back from vacation :)
> >=20
> > It's too early for asking questions. I'll wait until I read your series.
> > I just saw you posted it yesterday.
>=20
> np, my bad, it took longer than expected to send this out. Take your
> time.
>
No problem. Yesterday, I began to read your series. I'll comment and=20
review there as soon as possible.=20

Thank you for adding me to the list of recipients.
>=20
> >=20
> > I'll rework my series and just export cxl_port_setup_intel_lmh() as you
> > suggested, if it would result into a better solution.
>=20
> In a v2 I am going to reorder and possibly split the patches for you
> to reuse the first part then.
>=20
Thanks for that, but I can't yet have visibility on what is going to happen.
Internally, I've been suggested to post my v2 as is, not re-based on your=20
series for now. A few colleagues want to have the opportunity to read it.
Later we will see which the best course of action will be.
> >=20
> > I can't yet easily figure out how to detect an LMH while still in cxl_p=
ort_add(),
>=20
> I think you need to detect it close before region setup when decoders
> are enumerated. I will revisit your patch again and take look to find
> a solution.
>=20
Thanks, but I think you missed something. More on this below...
>
> > I'll think about it.
> > >  =20
> > > See also inline below, I have some questions and comments.
> > >=20
> > > >=20
> > > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.in=
tel.com>
> > > > ---
> > > >  drivers/cxl/Kconfig       |  5 ++++
> > > >  drivers/cxl/core/Makefile |  1 +
> > > >  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++=
++
> > >=20
> > > Could you name this file intel.c and have necessary Kconfig options?
> > >
> > I named it x86.c, but in internal review Dan asked to rename it lmh.c
>=20
> The LMH detection is unclear yet, just checking for zero is IMO not
> sufficient (looked at your answer below). As long as there is no
> generic check a platform check is needed in addition.
>
Thank you for providing your proposed response. I'll now review it for=20
clarity and fluency, and offer suggestions for improvement:

It's not just checking for zero. In the 'if' statements of=20
arch_match_spa() and arch_match_region(), there's a bit of more complexity=
=20
involved.

These functions essentially test CFMWS and corresponding EP Decoders=20
when both ranges start at zero. In such cases, if SPA is a subset of EP=20
Decoder HPA, and that HPA aligns with the 256M * NIW constraints, we assume
an LMH is truncating the CFMWS range. We then return true to match Root=20
Decoders to Endpoint Decoders, or Regions to EP Decoders, preventing driver=
=20
failures while it constructs Regions and attach EP to them.

I believe I discussed this with Ming Li, who had similar questions. However,
the lack of immediate clarity suggests that I should rework these 'if'=20
statements.=20

A revised approach for v2 might test whether an SPA range that starts at=20
zero is shorter than the corresponding EP Deccoder HPA range AND ends befor=
e=20
4G. Again, if it holds true, assume an LMH is truncating that published CFM=
WS
and so return true and preventing driver failures.

I'll think about it for v2. Anyway I'm going to submit it in one or two day=
s.
>=20
> > >=20
> > > If code should be reused later we still can move it to common.c or
> > > similar. It would be good to guard that having a pci_device_id check
> > > to a root port or a vendor cpu check.

That sounds good. I'll think about it. Sorry for missing it in my previous
reply.

> > >=20
> > > See my comment no enablement above.
> > >=20
> > > >  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++---=
=2D---
> > > >  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
> > > >  5 files changed, 130 insertions(+), 9 deletions(-)
> > > >  create mode 100644 drivers/cxl/core/lmh.c
> > > >=20
> > > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > > index 876469e23f7a..07b87f217e59 100644
> > > > --- a/drivers/cxl/Kconfig
> > > > +++ b/drivers/cxl/Kconfig
> > > > @@ -128,6 +128,11 @@ config CXL_REGION
> > > > =20
> > > >  	  If unsure say 'y'
> > > > =20
> > > > +config CXL_ARCH_LOW_MEMORY_HOLE
> > > > +	def_bool y
> > > > +	depends on CXL_REGION
> > > > +	depends on X86
> > > > +
> > > >  config CXL_REGION_INVALIDATION_TEST
> > > >  	bool "CXL: Region Cache Management Bypass (TEST)"
> > > >  	depends on CXL_REGION
> > > > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > > > index 9259bcc6773c..6e80215e8444 100644
> > > > --- a/drivers/cxl/core/Makefile
> > > > +++ b/drivers/cxl/core/Makefile
> > > > @@ -15,4 +15,5 @@ cxl_core-y +=3D hdm.o
> > > >  cxl_core-y +=3D pmu.o
> > > >  cxl_core-y +=3D cdat.o
> > > >  cxl_core-$(CONFIG_TRACING) +=3D trace.o
> > > > +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) +=3D lmh.o
> > > >  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> > > > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > > > new file mode 100644
> > > > index 000000000000..da76b2a534ec
> > > > --- /dev/null
> > > > +++ b/drivers/cxl/core/lmh.c
> > > > @@ -0,0 +1,53 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +#include <linux/range.h>
> > > > +#include "cxl.h"
> > > > +
> > > > +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> > > > +#define MISALIGNED_CFMWS_RANGE_BASE 0x0
> > >=20
> > > Could you more elaborate on this? Why is the base zero?
> > >=20
> > I know it because I saw it's zero in all configurations showed by and d=
iscussed with=20
> > BIOS engineers.
>=20
> As said above, an additional check is needed here.
>=20
Okay.
>
> [...]
>=20
> > > > +/* Similar to arch_match_spa(), it matches regions and decoders */
> > > > +bool arch_match_region(struct cxl_region_params *p,
> > > > +		       struct cxl_decoder *cxld)
> > > > +{
> > > > +	struct range *r =3D &cxld->hpa_range;
> > > > +	struct resource *res =3D p->res;
> > > > +	int niw =3D cxld->interleave_ways;
> > > > +
> > > > +	if (res->start =3D=3D MISALIGNED_CFMWS_RANGE_BASE &&
> > > > +	    res->start =3D=3D r->start && res->end < r->end &&
> > > > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > > > +		return true;
> > >=20
> > > This basically means that the region base is zero?
> > >
> > Yes, it is.=20
> > >
> > > How do you
> > > determine the actual base address of the range then? The cxl test
> > > patch contains a non-zero address.
> > >
> > Next version of this series is going to use 0x0 for real hardware and=20
> > mock_cfmws[0]->base_hpa for the topology created by cxl tests.
> > >
> > > this trimmed mem hole regions? Could you share a snippet of a CFMWS
> > > entry for this?
> > >
> > Sorry, I don't have it because no real hardware was required to make an=
d test
> > my series.=20
>=20
> Ok, will reorder my patches in v2 for you to reuse and take a look at
> your patch and the base_hpa setup. Will comment there again.
>=20
> Thanks,
>=20
> -Robert
>=20
Thanks,

=46abio



