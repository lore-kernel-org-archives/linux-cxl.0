Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209385298;
	Tue,  2 Jul 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947702; cv=none; b=bYbIRCHOFGmY7Cty9pA/4xKNPEMhVFrfeeVPa8DzFREGcAOn1S66RX0wwZzN3qAD2zsrTN9QcwRyVW+Cx8bFlrHetj/tuEqclba/zlKWOblUU99wmBw+Bx4zhns2zBgR+bMrKgPz39/+vK9OPmwSMmw0JU7T+hZA7htkzkCwH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947702; c=relaxed/simple;
	bh=NUPLVBcfgOBwsTD9Q/zm00dKYWdQ/Bn+8/Nh5T+sjos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYpBnH42+EJknWfwMCfSrrgpJuR6PmqspQ+UvMu4zr49lzw6HzCkn6Ib+Spg7/lvO57SnjNuJHnDcKtJt2CrHl1/HJHGDmQsfplPnK5PEoaH6r5tOYBVRq7seEEt+cmBXLrDZ/e01uw0ooZgyxQ1sq00ilXj1Eg3yHECN0cUNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Un3VRd4x; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Un3VRd4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719947700; x=1751483700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NUPLVBcfgOBwsTD9Q/zm00dKYWdQ/Bn+8/Nh5T+sjos=;
  b=Un3VRd4xWf1MxJRJzD+m0i20slIh4y9pt1ueWP7Fndfec5l91p7K6ybV
   oQMdGWJkCpaUh1/T6+aeEgrILIp+pSwfyWmAqQh02MPubdb5GUy0LYQ7i
   2DAwxrCo4T7m5NfWDpjsfx2CP+kasypuikoiCgDxfoZ4nqCgWWbcl2Yyg
   mckcZPwwo0bgrPLaQitWv8gu+4lN+OEL2bqD+aIo+X33NGupHTeI0+ZoW
   HqHh+kVdWnaaiqfOU6aBvdXndNXVheo714pQDtx7yGag0CPSia4y3H41H
   uQtfYBpebmE46/LZl51j6Sy3e5+TR3YB6PANHi4hCvvyU5NIV+7M/HpYh
   A==;
X-CSE-ConnectionGUID: JBNYgYnNTTae9GCpzhdpSA==
X-CSE-MsgGUID: 9huyTeKdTl6xLW3uHN+EPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17021430"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17021430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 12:14:59 -0700
X-CSE-ConnectionGUID: 3i7Jo+PQTE6+nLyR9ri7sg==
X-CSE-MsgGUID: ETCCQT5xSian8O9MatKFRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50854560"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 12:14:56 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
Date: Tue, 02 Jul 2024 21:14:51 +0200
Message-ID: <2436432.YKUYFuaPT4@fdefranc-mobl3>
In-Reply-To: <ZoMq9TQoLTMaEPlJ@aschofie-mobl2>
References:
 <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
 <ZoMq9TQoLTMaEPlJ@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, July 2, 2024 12:17:25=E2=80=AFAM GMT+2 Alison Schofield wrote:
> On Fri, Jun 28, 2024 at 07:48:07PM +0200, Fabio M. De Francesco wrote:
> > Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> > (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> > two types (CXL 3.1 Table 9-21): The PCIe Root Complex Register Block
> > (RCRB) and CXL Host Bridge Component Registers (CHBCR).
> >=20
> > If a Host Bridge is attached to a device that is operating in Restricted
> > CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> > registers that describe its capabilities (CXL 3.1 sec. 9.11).
> >=20
> > Instead, the new (CXL 2.0+) Component registers can only be accessed
> > by means of a base address published with a CHBCR (CXL 3.1 sec. 9.12).
> >=20
> > If an eRCD (a device that forces the host-bridge into CXL 1.1 Restricted
> > CXL Host mode) is attached to a CXL 2.0+ Host-Bridge, the current CXL
> > specification does not define a mechanism for finding CXL-2.0-only
> > root-port component registers like HDM decoders and Extended Security
> > capability.
> >=20
> > An algorithm to locate a CHBCR associated with an RCRB, would be too
> > invasive to land without some concrete motivation.
> >=20
> > Therefore, just print a message to inform of unsupported config.
> >=20
> > Count how many different CHBS "Version" types are detected by
> > cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that s=
um
> > is greater than 1.
> >=20
> > Tested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >=20
> > --- Changes for v2 ---
> >=20
> > 	- Rewrite the Subject line (Alison)
> > 	- Address a bug found by Alison while testing (thanks!)
>=20
> 'Address' a bug doesn't descibe what changed from v1 especially for
> folks who reviewed v1.
>=20
> I'm not asking you to rev this patch, just explain the saved_version
> change.
>=20
> Thanks
> -- Alison
>

Alison,

Thanks again for testing, and also for noticing that I didn't give any=20
explanation of the new saved_version variable and the solution I introduced=
 to=20
fix the bug you found. Then...

During tests, Alison noticed that the CHBS iterator was testing chbs-
>cxl_version always against UINT_MAX. =20

ctx->cxl_version must be assigned, along with ctx->base, before returning f=
rom=20
the CHBS iterator, only if all 'if' statement evaluate false.

Therefore, don't test anymore against ctx->cxl_version. Instead save every =
new=20
different chbs->cxl_version in ctx->saved_version and test against this new=
=20
field at every iteration.=20

Add an inline comment that briefly (and indirectly) refers to this logic.=20

=46abio=20
=20
> > 	- Add reference to CXL 3.1 Spec. (Alison)
> > 	- Extend the commit messages by borrowing comments to v1 (Dan)
> > 	- Rename field "count" to "nr_versions" (Alison)
> > 	- Add brackets to oneline 'if' statement in precence of comments
> > 	  (Dan)
> >=20
> > --- Link to v1 ---
> >=20
> > https://lore.kernel.org/linux-cxl/20240619125949.167936-1-fabio.m.de.fr=
ancesco@linux.intel.com/
> >=20
> >  drivers/cxl/acpi.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 571069863c62..f9035dbabb1c 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -482,6 +482,8 @@ struct cxl_chbs_context {
> >  	unsigned long long uid;
> >  	resource_size_t base;
> >  	u32 cxl_version;
> > +	int nr_versions;
> > +	u32 saved_version;
> >  };
> > =20
> >  static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void=
=20
*arg,
> > @@ -490,22 +492,31 @@ static int cxl_get_chbs_iter(union=20
acpi_subtable_headers *header, void *arg,
> >  	struct cxl_chbs_context *ctx =3D arg;
> >  	struct acpi_cedt_chbs *chbs;
> > =20
> > -	if (ctx->base !=3D CXL_RESOURCE_NONE)
> > -		return 0;
> > -
> >  	chbs =3D (struct acpi_cedt_chbs *) header;
> > =20
> > -	if (ctx->uid !=3D chbs->uid)
> > +	if (chbs->cxl_version =3D=3D ACPI_CEDT_CHBS_VERSION_CXL11 &&
> > +	    chbs->length !=3D CXL_RCRB_SIZE)
> >  		return 0;
> > =20
> > -	ctx->cxl_version =3D chbs->cxl_version;
> >  	if (!chbs->base)
> >  		return 0;
> > =20
> > -	if (chbs->cxl_version =3D=3D ACPI_CEDT_CHBS_VERSION_CXL11 &&
> > -	    chbs->length !=3D CXL_RCRB_SIZE)
> > +	if (ctx->saved_version !=3D chbs->cxl_version) {
> > +		/*
> > +		 * cxl_version cannot be overwritten before the next=20
two
> > +		 * checks, then use saved_version
> > +		 */
> > +		ctx->saved_version =3D chbs->cxl_version;
> > +		ctx->nr_versions++;
> > +	}
> > +
> > +	if (ctx->base !=3D CXL_RESOURCE_NONE)
> > +		return 0;
> > +
> > +	if (ctx->uid !=3D chbs->uid)
> >  		return 0;
> > =20
> > +	ctx->cxl_version =3D chbs->cxl_version;
> >  	ctx->base =3D chbs->base;
> > =20
> >  	return 0;
> > @@ -529,10 +540,19 @@ static int cxl_get_chbs(struct device *dev, struc=
t=20
acpi_device *hb,
> >  		.uid =3D uid,
> >  		.base =3D CXL_RESOURCE_NONE,
> >  		.cxl_version =3D UINT_MAX,
> > +		.saved_version =3D UINT_MAX,
> >  	};
> > =20
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter,=20
ctx);
> > =20
> > +	if (ctx->nr_versions > 1) {
> > +		/*
> > +		 * Disclaim eRCD support given some component register=20
may
> > +		 * only be found via CHBCR
> > +		 */
> > +		dev_info(dev, "Unsupported platform config, mixed=20
Virtual Host and Restricted CXL Host hierarchy.");
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
>=20




