Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494623BF;
	Wed, 26 Jun 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396057; cv=none; b=VLh+bqYcRFNdQkKHvj0DkzuJQgsRjPWXgBGCSSnt8GWebnSLeI9y0f5Zo40lPGORDFexkV4cVPgYUdUDtfFLZXF2U85e5L+ShS7AAmZqMO9qEooi6TmlmU85EBFGJjRmG/AsBxh3M3RqxH9aCd8iZ0Raq7pAR8Kq2onKyOQveA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396057; c=relaxed/simple;
	bh=gvbmy8hayyWc/TfWKMAmB62QKHKxu7hiNhupMcBD3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7lypRlLEn8ofFquUVXkpSLeTkJ1wkU4eQIvNno14+zwOwxROMVmgMKKl7AR8U0zcbDS6PVnzRe+vf9SzwBYJv5r6X/SbOGiJc5Q2dglXe0E+n5GdzWgpR42LAgg0b00cXrU5o4BpDKefm24PPOOZrlJUHN4iH/wf4UobQUswh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecqnS/H/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecqnS/H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719396056; x=1750932056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvbmy8hayyWc/TfWKMAmB62QKHKxu7hiNhupMcBD3hg=;
  b=ecqnS/H/RAnKPtNLFkPsZsjHVbzRDvOOuQXiGw+6d1cOoeXIANC5ALxi
   aEPbfOaF1csov3iXqHf5T5ZC3V9fyiKA90kcQKkyK1O02GOf9a6ZDtyUj
   An2RVZRwVpS+ED1pGyMZeHDDXzaCgZLDxwBy1M/YKUx/q0xtw1MH5BSfg
   Te1JsdlPLZWBsRW/wvrUvJSrK9dR4ws9xhqRYnUKOxv1TYOCWTO0aAx8u
   Cg85aFzVGZb4FmdgQ25NPyvue8ypCQtjdb6I1nQjuXucxrkHhFY3pegAy
   BULBuSO9EwVg+GanVv+WUhXpFjRI0DYhuCLV3WtkCLu3EhFInB1GrYeJa
   A==;
X-CSE-ConnectionGUID: MpRxYhZ9ROaQ7dE/mx51Rg==
X-CSE-MsgGUID: mRV1ULWrRhyjq2Gd1eQbjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16418773"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16418773"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:00:55 -0700
X-CSE-ConnectionGUID: ie82TndETB6BV08gIdU3Ew==
X-CSE-MsgGUID: b465rjCtQOiUML0uN7tMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44664772"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.93])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:00:51 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Date: Wed, 26 Jun 2024 12:00:47 +0200
Message-ID: <3636999.dWV9SEqChM@fdefranc-mobl3>
In-Reply-To: <ZnXpPGV57o7v4xYT@aschofie-mobl2>
References:
 <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <ZnXpPGV57o7v4xYT@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, June 21, 2024 10:57:32=E2=80=AFPM GMT+2 Alison Schofield wrote:
> On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:
>=20
Hi Alison,
>
> Hi Fabio,
> You've written such a detailed commit msg, that it pulls me in,
> and now I want to understand more....
>=20
>
> > Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> > (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> > two types: RCRB and CHBCR.
>=20
> Is there a spec reference for this?
>
I'll add a spec reference with v2.

> While you're spelling things out, please expand RCRB and CHBCR

I'll do it.
>
> >=20
> > If a Host Bridge is attached to a device that is operating in Restricted
> > CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> > registers that describe its capabilities.
> >=20
> > However, the new (CXL 2.0+) Component registers (e.g., Extended Security
> > Capability), can only be accessed by means of a base address published
> > with a CHBCR.
> >=20
> > An algorithm to locate a CHBCR associated with an RCRB would be too
> > invasive to land without some concrete motivation.
> >=20
> > Therefore, just print a message to inform of unsupported config.
> >=20
>=20
> Were users seeing this and confused by this silent failure?
> What did it look like before?
>=20
Please read Dan on this topic.
I think I'll add a few lines to the commit message to summarize Dan's comme=
nt.
>
> > Count how many different CHBS "Version" types are detected by
> > cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that s=
um
> > is greater than 1.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/acpi.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 571069863c62..9e226a65a5ea 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -482,6 +482,7 @@ struct cxl_chbs_context {
> >  	unsigned long long uid;
> >  	resource_size_t base;
> >  	u32 cxl_version;
> > +	int count;
>=20
> Maybe s/count/nr_versions to be more explicit of what it counts.
>
Yes, "nr_versions" is better.

Thank you.

=46abio
>
> -- Alison
> >  };
> > =20
> snip
> >=20
>=20




