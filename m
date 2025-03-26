Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA11F5827;
	Wed, 26 Mar 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006312; cv=none; b=FljJ6euMdVHHO5sUK8iUEzhGd0Tmqc0r8R/yDe+4H+SDWJXQUHFdsd2AHLnyu46ABVynKeHcCOVUN+hYh0EXYXwJhva96GjwLR7j/4e76p9uYW8q3tTtjCY6pbDVvfyhOAA0ze1VzwwvLx+/GfF2fN78AZ4+XLlGqDzwO66jx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006312; c=relaxed/simple;
	bh=jGR6TH7lmaXbUnYdLB6AEH91R7R56KeOS6Jwnspn2Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhywV8Itw57WxNkFjDZtSG1V2eJzSqSLItW+UKWJjBjMpu7O1KdIpL3aLA6aitqMZ9CZHJRo/zCG2tkBq0sl/lhq3TGk6B8gNBZT92HOj5bjgsDIstTGWolLyvjoI+QAiY/xv0EwNDm5cQk5kP1PHOTyE11XMMmoMJKWQ7mT5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCJj9c2/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCJj9c2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743006312; x=1774542312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jGR6TH7lmaXbUnYdLB6AEH91R7R56KeOS6Jwnspn2Yg=;
  b=VCJj9c2/A21kXHv5NsTiRa6V59UrHQYSBjDLH3P0aN8wKbyRqeQ7NTFc
   UxWBsSh07HSM+5XlV2HVFQxiO6hPcQRqmN9xjKLIm6VgiIrfna+4lhWKL
   DfyFEpZL4YCPYADJsCTBhzPSy9FnVVyiMPDxHvoTu2vN2IHV6oABwBR86
   /MLS6Gbu0KrFn+O600B+Pd+mvS+23IJcdxewEef72r5OfmtM9QYAOq0dR
   C0PJ5RVbWCFwCaX+kZOrRV5XrrcXZQeHoHLFxIhg0C/rwkbNgilDFQV9Z
   oyFU+YL0kIhA26hTWSdhyirkBJMKvWNXhdvbO6lytakxYr8ov6meD1X6o
   w==;
X-CSE-ConnectionGUID: jyCgU7+TSUySbBzU5/oPsw==
X-CSE-MsgGUID: 7ZZWKcOMToWN3x/QLLTD4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44029457"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="asc'?scan'208";a="44029457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:25:07 -0700
X-CSE-ConnectionGUID: lC6LfFX7Q6q6iHVtdrMh+g==
X-CSE-MsgGUID: b9Va13FhSJSrh1sDn2dNnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="asc'?scan'208";a="130016133"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.239])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:25:02 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Wed, 26 Mar 2025 17:24:59 +0100
Message-ID: <3287167.Hq7AAxBmiT@fdefranc-mobl3>
In-Reply-To: <Z9xaBaM8Mzc8rQ90@aschofie-mobl2.lan>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z9xaBaM8Mzc8rQ90@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4709506.aCxCBeP46V";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4709506.aCxCBeP46V
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 26 Mar 2025 17:24:50 +0100
Message-ID: <3287167.Hq7AAxBmiT@fdefranc-mobl3>
In-Reply-To: <Z9xaBaM8Mzc8rQ90@aschofie-mobl2.lan>
MIME-Version: 1.0

On Thursday, March 20, 2025 7:10:13=E2=80=AFPM Central European Standard Ti=
me Alison Schofield wrote:
> On Fri, Mar 14, 2025 at 12:36:29PM +0100, Fabio M. De Francesco wrote:
> > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Ho=
st
> > Physical Address (HPA) windows that are associated with each CXL Host
> > Bridge. Each window represents a contiguous HPA that may be interleaved
> > with one or more targets (CXL v3.1 - 9.18.1.3).
> >=20
> > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > memory to which systems cannot send transactions. On those systems, BIOS
> > publishes CFMWS which communicate the active System Physical Address (S=
PA)
> > ranges that map to a subset of the Host Physical Address (HPA) ranges. =
The
> > SPA range trims out the hole, and capacity in the endpoint is lost with=
 no
> > SPA to map to CXL HPA in that hole.
> >=20
> > In the early stages of CXL Regions construction and attach on platforms
> > with Low Memory Holes, the driver fails and returns an error because it
> > expects that the CXL Endpoint Decoder range is a subset of the Root
> > Decoder's (SPA >=3D HPA). On x86 with LMH's, it happens that SPA < HPA.
> >=20
> > Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> > Decoders or already made CXL Regions and Decoders to allow the
> > construction of new CXL Regions and the attachment of Endpoint Decoders,
> > even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Deco=
der
> > range end to match Root Decoder's.
>=20
> Unless dev_dbg() is on, LMH handling won't be apparent. How about adding
> a dev_info() that informs the user that a region was adjusted to account
> for a LMH. I'm foreseeing looking at logs and divining a LMH, when a
> simple log message would be a nice shortcut.
>=20
> CXL subsystem is quiet with only 8 dev_info()'s, so if this breaks some
> vow of silence, nevermind :)
>=20
Yes, sure. It sounds good.

Thanks,

=46abio

--nextPart4709506.aCxCBeP46V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmfkKlIACgkQ50DaXiQp
iWEG5Af9ECvIutsuqXs34y38zMpXJKO0TYGbJE5mwT47maGrQnjAVBTFKEsGYCx+
Pvi/weuhuCk03RrjaQuX5ztiyF8poLq8EEiFtkdwoVlw9er0j3WF3hTJ99BS5aYB
Y5TfW+cAFrgLvgjEjRffMW3tauNbtofku41v5c0D3WRmBzS/v/zQiDEB4rE/AL4S
WibVPlmwU7xMVnXWJQT1U/tuMjXdrZoLweI3G93dux2U5NpCn1UINoNSjq3Swvuh
Tnvv+z3+DhT6/33QK/7r49mSmMRUGwcexVhx0e/N7d8DDdah+pgbNQGIofdNSnYJ
AL/po9xXiod3IiIou0ZS0aG1VbOVUg==
=ExJA
-----END PGP SIGNATURE-----

--nextPart4709506.aCxCBeP46V--



