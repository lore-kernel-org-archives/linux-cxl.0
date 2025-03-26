Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB51F63D9;
	Wed, 26 Mar 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008338; cv=none; b=ecrcABoNt129D12xJ8IQ+5QZtE8DTQmvc+sCnBwc6WAsa1E8E22jU376oDPHV7ynupucXpvJH5nNSppoznWVCgkqYfkNUgcsTKav/5v7joKle4jQ2UChPDGeBwO7pkPf5pM4TiYDMRSTZFexLOLMFs2xVTH2ISI+RqQqokugO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008338; c=relaxed/simple;
	bh=OuIz4Jg6i7CakVInfPmi7/abG++Kmf7R832y4abxKOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN9XFKhEXfqnurhQOLGHIOHh/wMr2MxMTv9fC0JXPpE+uLWuIK3UY7OvxkSNlSlxMKOaxPpaSJEp1aLFSBXgmyqlfq9GzexjIkGNKSy7s9ouXwmWZuXWvyJqdNueXd/IUNKSSyVZH3/gLha86rxspcbDsLhwZjksbuOdqhaLQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTwCmj+L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTwCmj+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743008337; x=1774544337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OuIz4Jg6i7CakVInfPmi7/abG++Kmf7R832y4abxKOE=;
  b=DTwCmj+LB8EA6rcVlWuw+PxqjfmAdSzl8MWxunZup4glxcKva8Ff4ueK
   sW3RTJV9KbT05QwtVsN7UO7OOSG3AzfGyv+rYKh9EsNXKu+gxMi2Zrgsq
   ALqNYjBSMgZVBI6pgP6ZmHxmc3tAUHel5D3FQEJcCAjLfJJ+sI8SIJNzU
   ncQvJSU5Z/KAWBIxzGF+Ss4zLKb9G+aSH4P85EhZKgxqmo3gYdbM8VO7/
   ydCD6Mc+BCi0aIiydnXeHgG6/kzIzq0Bi1qSVmmOvW9/gilnHAXbBhqen
   lse3jhdUsSJjTVoxk6yvXpyA4tsNRbTbnFNKGsMct9DaGe8ppEBFC07Yg
   g==;
X-CSE-ConnectionGUID: vVA6ewDVSrer+Poiq/Fxsg==
X-CSE-MsgGUID: Jk5dJn73RdWP1Xku5j9cng==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48099223"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="asc'?scan'208";a="48099223"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:58:56 -0700
X-CSE-ConnectionGUID: JOqCaMpBTWehkD2RN5TRww==
X-CSE-MsgGUID: Sq2hGyLTSd6VxBe86QmLIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="asc'?scan'208";a="162041434"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:58:53 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Wed, 26 Mar 2025 17:58:50 +0100
Message-ID: <7393617.eO5KgaWL5Y@fdefranc-mobl3>
In-Reply-To: <Z91CgQjzXzKWNXPX@rric.localdomain>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
 <Z91CgQjzXzKWNXPX@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3115698.kHrqEjB74n";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3115698.kHrqEjB74n
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Date: Wed, 26 Mar 2025 17:58:41 +0100
Message-ID: <7393617.eO5KgaWL5Y@fdefranc-mobl3>
In-Reply-To: <Z91CgQjzXzKWNXPX@rric.localdomain>
MIME-Version: 1.0

On Friday, March 21, 2025 11:42:09=E2=80=AFAM Central European Standard Tim=
e Robert Richter wrote:
> On 14.03.25 12:36:33, Fabio M. De Francesco wrote:
> > Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> > mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range s=
izes
> > to 1GB.
> >=20
> > Since the auto-created region of cxl-test uses mock_cfmws[0], whose ran=
ge
> > base address is typically different from the one published by the BIOS =
on
> > real hardware, the driver would fail to create and attach CXL Regions if
> > it was run on the mock environment created by cxl-tests.
> >=20
> > Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match =
CXL
> > Root Decoders and Regions with Endpoint Decoders when the driver is run=
 on
> > mock devices.
> >=20
> > Since the auto-created region of cxl-test uses mock_cfmws[0], the
> > LMH path in the CXL Driver will be exercised every time the cxl-test
> > module is loaded. Executing unit test: cxl-topology.sh, confirms the
> > region created successfully with a LMH.
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
> >  drivers/cxl/core/lmh.h               |  2 ++
>=20
> Can you take a look to move all those changes to testing/? This
> indicates the interface of your mock functions need improvement.
>=20
> -Robert
>=20
> >  tools/testing/cxl/cxl_core_exports.c |  2 ++
> >  tools/testing/cxl/test/cxl.c         | 10 ++++++++
> >  4 files changed, 45 insertions(+), 4 deletions(-)
>=20
Your comment is not very detailed but I think you are suggesting to=20
override the lmh functions in testing. If that is the case, I don't think=20
that any function which is exported from and also called by cxl-core=20
can be override by testing with the strong/weak mechanism.=20

But I'm not an expert of linker related topics and not even sure that I=20
understood what you suggested.

Would you please elaborate more?

Thanks,

=46abio

--nextPart3115698.kHrqEjB74n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmfkMkEACgkQ50DaXiQp
iWGkNwgAqf+xwby9iyxUYBHsjmCpty4vJGS1+37phCDCKD/0T62qIwGPFyQvysLV
6/W1DOj/hPSXgVpOgQdwOF1b8BdGuHdgh7Z4HyLq7gjd1IpRHhEiuJuxRTE85KfH
dqYw+xZckadPLJByvCiDF04uB4Kl+ETJYpXS6Yds2p1zYi+WNLnqPHyacHCLr04v
fIYEXRU7pArY7xQCoPHN/yQsFxiC5bZbhMRH5VeISIXwsydwI9GsQTugQIHyrhCy
Ti007N5jVb6m5SiU/0I3WVxTtG900Qw9hj4H+4i3IeUPIarCEZ/bIfTiQwshI1At
ozmSD0wc58cyMkNm//OP/PoNa05uNA==
=WH8O
-----END PGP SIGNATURE-----

--nextPart3115698.kHrqEjB74n--



