Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAA18A92B;
	Wed, 26 Jun 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397707; cv=none; b=rj9j5/UHEeoW/H97kQ1cTGy7IpZrDZDASQc4uH8F/kT/ofIC8d3T7Zb3L3o4JIJDqwI4Wof26TNHDTTLqjHt70IivPsri7OICickYXSMREuxCiiDQ1kq6KzHTO59H5dMI0cV6mnxTBWJlHICppbAgAEIAj4jKCvPOEDiBi2EKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397707; c=relaxed/simple;
	bh=R8koNdIOIs1xSzrQoGWQfGJPVAZmC0McFmOxHDebHL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzZsOLlryCBiSbiMg0JYsUHqjaqqiDqz8IZvs7Eev2fbXN7tTi/iHWbsHEYZb09os5qWIzeUpXfqXF+XEGnBFvYfgjrWBmmckfH89qCFEIAFDGPo7ItAiAmhtLgdyWbVLctzWsz+6evs4GFu7fAfHMtaMXdJqZ2HMCwe0N3C4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmx56Hm8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmx56Hm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719397706; x=1750933706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8koNdIOIs1xSzrQoGWQfGJPVAZmC0McFmOxHDebHL8=;
  b=jmx56Hm8CWLf562Fih0J+If8vsIVIaD8Ej1+2nWww1zpVdnkhttEf2il
   6pc85vpjXA3/MRt1vPUgzyoTXyCWdkzx0UfedZxn5wFSjYNXIj5NTWwzU
   2HkP99wuEfA7NgNsW8pOi+SRFGEf21mCkQJOqxZY/e36ukEba8oKsfhhp
   mnerc/bRPpGi8N3kxBNs9JKPDOhcKbX9S2jJ5OV6IBqOf0GB14Jv9kgJD
   VeKmBXj866yoRjPgGX7xe2xqN1TmoUW9TfwwyuA33mM33JGbwzSXpHfph
   Ouzn1Swn2+9VL0ZAqKQTQ0725bzA52nAT0UH7qgY9REVCCa/zIStLKQvr
   A==;
X-CSE-ConnectionGUID: yRUAwlIqQhCsDHxgZD0nRA==
X-CSE-MsgGUID: TX4BljKTS2+os3mxwG1mTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="19351636"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="19351636"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:28:26 -0700
X-CSE-ConnectionGUID: tJoVEplgSQeDKyi7EUs7qQ==
X-CSE-MsgGUID: nPmW/HKWQ1Gw4O20Z0Xhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44611032"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.93])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:28:22 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Date: Wed, 26 Jun 2024 12:28:19 +0200
Message-ID: <21841700.4csPzL39Zc@fdefranc-mobl3>
In-Reply-To: <667b4f4a46cc6_563929472@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <667b4f4a46cc6_563929472@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, June 26, 2024 1:14:18=E2=80=AFAM GMT+2 Dan Williams wrote:

Hi Dan,

> Fabio M. De Francesco wrote:
> > Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> > (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> > two types: RCRB and CHBCR.
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

snip

> > @@ -533,6 +537,10 @@ static int cxl_get_chbs(struct device *dev, struct=
=20
acpi_device *hb,
> > =20
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter,=20
ctx);
> > =20
> > +	if (ctx->count > 1)
> > +		/* Disclaim eRCD support given some component register=20
may only be found via CHBCR */
> > +		dev_info(dev, "Unsupported platform config, mixed=20
Virtual Host and Restricted CXL Host hierarchy.");
>=20
> I believe this is already queued, but my personal preference is that
> multiline statements include brackets, or move the comment above the "if
> ()", so either:
>=20
> 	/* Disclaim eRCD support given some component register may only be=20
found via CHBCR */
> 	if (ctx->count > 1)
> 		dev_info(dev, "Unsupported platform config, mixed Virtual=20
Host and Restricted CXL Host hierarchy.");
>=20
> ...or:
>=20
> 	if (ctx->count > 1) {
> 		/* Disclaim eRCD support given some component register=20
may only be found via CHBCR */
> 		dev_info(dev, "Unsupported platform config, mixed Virtual=20
Host and Restricted CXL Host hierarchy.");
> 	}
>=20
> ...but don't spin the patch just for that fixup.
>=20
I'll send v2 mainly for Alison's comments and so I will also add brackets h=
ere=20
(the second solution meets my preferences).

Thank you,

=46abio




