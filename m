Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E652F19B7;
	Fri,  4 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623543; cv=none; b=A+gcSG+GVuE4oZp0P3JW2mirB98lu+PqVBW2fTnfTOwPeQHAjIGV5XPAujmcdfZnbmrcrN35zed1lGp1a05Q++z+j3fFtnDytWxYXoRMCm0ZkQGc+d4mR6Aw5moIHLdkUFUh2Q1soya2bBxYI8C/6VNUGh9VJ+v595cNVbxEqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623543; c=relaxed/simple;
	bh=g7GJPLs/of6VjYeOCETvrYExJO2+xYrjDZllY6x90eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAEUwAnzTO+yMfoN6DV1obpzEH4CVSpTkwVjBMXpUSecQ/j6pfPgA8Em7SM7LZEMPsCGqjtDq08kuQvdMCh10f2Z7XjnfAn18UiGqnZKBr0TGxDszFxVxw7zWqvlxbig0yPO17x6zBH4eomfudczTxUMaYulSDGci07Z2l9wJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bX84CldZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bX84CldZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751623542; x=1783159542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7GJPLs/of6VjYeOCETvrYExJO2+xYrjDZllY6x90eY=;
  b=bX84CldZaDD6zIYwF17VzWwDtbdnSax0CLJ76V/11wNFKjsRDQuvYy+Z
   szcEHom1xYXOEDxwIh+BsbQUvbOIT/j7p2+GImtM6iEWz1Rk9D7vIH178
   GBcAEMyV+oq3aCR6uKIo34D+0PTVnAZEAzU4PWDlppY3WIOsdMyA8mRQk
   TVgpJsLQMgJ1VhYdTWn8/gKaiwc8BmEwDlz3kuSc1v7SV9vFQV6cJIkgt
   BEXAbIxpaavhI5m9lGTfaxLRS8CrtiUanAMkA1eTo3dqFC3PLgIOFhDTb
   k3ORBm8sjCDbUPCcbUC+5NC2xlTy5l/gooEQiht09L4TlhlRmNKPaBaw0
   Q==;
X-CSE-ConnectionGUID: QL92RSmZReuRFOSP8YCtPA==
X-CSE-MsgGUID: R3ME3g0rRPGUIgOSDaHEQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64558309"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64558309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 03:05:41 -0700
X-CSE-ConnectionGUID: WGCCX+QgRtqG1GbH5LsZ6Q==
X-CSE-MsgGUID: gYeriFH7TX+zOQYelzpXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154019737"
Received: from monicael-mobl3 (HELO fdefranc-mobl3.localnet) ([10.245.246.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 03:05:36 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Fri, 04 Jul 2025 12:05:33 +0200
Message-ID: <1985851.b9uPGUboIS@fdefranc-mobl3>
In-Reply-To: <aGbcpac1pma1od40@gourry-fedora-PF4VCD3F>
References:
 <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <c32cede0-643c-47bb-bfde-93adbcf16155@intel.com>
 <aGbcpac1pma1od40@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, July 3, 2025 9:40:21=E2=80=AFPM Central European Summer Time G=
regory Price wrote:
> On Tue, Jul 01, 2025 at 08:23:57AM -0700, Dave Jiang wrote:
> >=20
> >=20
> > On 6/23/25 12:19 PM, Gregory Price wrote:
> > > On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco wrote:
> > >> Add documentation on how to resolve conflicts between CXL Fixed Memo=
ry
> > >> Windows, Platform Memory Holes, and Endpoint Decoders.
> > >>
> > >> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.int=
el.com>
> > >=20
> > > I won't block a doc update on a suggestion so
> > >=20
> > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > >=20
> > >> +Platform Firmware (BIOS) might reserve part of physical addresses b=
elow
> > >> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space fo=
r MMIO
> > >> +or a requirement for the greater than 8 way interleave CXL regions =
starting
> > >> +at address 0). In that case the Window Size value cannot be anymore
> > >> +constrained to the NIW * 256 MB above-mentioned rule.
> > >=20
> > > It might be nice to have a diagram that explains this visually, as it=
's
> > > difficult for me to understand the implications through words alone...
> >=20
> > +1 on request for diagram to explain. We should try to document this is=
sue as clearly as possible. Thank you.
> >
>=20
> At the very least, it would be nice to have an explicitly example that
> explains the expected cfmws/decoder configurations that are valid but
> "technically" violate the spec
>=20
> I *think* this basically boils down to "CFMWS size is not aligned, but
> all the decoders it targets are"?  If I understand this correctly?
>=20
Yes, this is the intended meaning.=20

E.g, two windows, 384 GB total memory, LMH at 2 GB:

Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Wa=
ys | Granularity
  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  1=
2  |    256
  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  1=
2  |    256

12 *256MB =3D 3GB, the Top of Low memory below 4GB is set as 2GB in the pla=
tform for MMIO Low Mem Hole (2-4GB). Only 2GB will be potentially available=
 for user, but currently the CXL driver expects a CFMWS range's size to be =
greater or equal to the HDM Decoder's, so it  doesn't match them and we los=
e those 2GB described by CFMWS0. If we allow the matching, we make those 2G=
B available to users.

Is a table like the one above good enough to make this subject clearer?

Thanks,

=46abio
>
> > >=20
> > > which is likely why the conflict exists in the first place :]
> > >=20
> > > ~Gregory
> >=20
>=20




