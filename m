Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490926FA52;
	Tue,  1 Jul 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375875; cv=none; b=sMUek0JSefw4Fe9PyeXoB1vSB1NkykePv7Pt+F53WV62pbCnuwmSDnGzeaLFPyymM74I6r4l///uyKkvHcLrz5x3EFgYG3A1qn6gDf3RaQdyz6nlFc6hGVXprvg5LzBJc9nCy79xFbU6prNbxebvMQG0UyKxz0piMyqbW/s9B7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375875; c=relaxed/simple;
	bh=r/NN+uPVPVDTHVFIhfUSaYzHUAeqofpBGcQ+MIV4XdM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEN3b+k4y4RBn2MxF+RFFf6z0kIIlzEtqYiqP62p0xrCGWBwx39Yfjnke9kQBXnRrQvSvS/rQORVilXaBQEFPQZ3oIzm8oqJnlf26WnexOtv+jD8l4DlKTonKJ+GfvaOcMeFp2+vF3ZCWWRC/AH8SgWRkSxrUNDqMikgZjXf80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWk5v1p8Bz6L57K;
	Tue,  1 Jul 2025 21:14:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A81EA14038F;
	Tue,  1 Jul 2025 21:17:49 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 15:17:49 +0200
Date: Tue, 1 Jul 2025 14:17:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <20250701141747.00003bf7@huawei.com>
In-Reply-To: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 17:29:02 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Memory Holes, and Endpoint Decoders.
>=20
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.co=
m>
> ---
>=20
> v2 -> v3: Rework a few phrases for better clarity.
> 	  Fix grammar and syntactic errors (Randy, Alok).
> 	  Fix semantic errors ("size does not comply", Alok).
> 	  Fix technical errors ("decoder's total memory?", Alok).
> 	 =20
> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
>=20
>  Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>=20
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation=
/driver-api/cxl/conventions.rst
> index da347a81a237..d6c8f4cf2f5b 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,88 @@ Detailed Description of the Change
>  ----------------------------------
> =20
>  <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Deco=
ders
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current CXL Specifications (Revision 3.2, Version 1.0)
> +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> +Physical Address (HPA) windows that are associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be
> +interleaved across one or more targets, some of which are CXL Host Bridg=
es.
> +Associated with each window is a set of restrictions that govern its usa=
ge.
> +It is the OSPM=E2=80=99s responsibility to utilize each window for the s=
pecified
> +use.
> +
> +Table 9-22 states the Window Size field contains the total number of
> +consecutive bytes of HPA this window represents and this value shall be a
> +multiple of Number of Interleave Ways * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve part of physical addresses below
> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> +or a requirement for the greater than 8 way interleave CXL regions start=
ing
> +at address 0). In that case the Window Size value cannot be anymore
> +constrained to the NIW * 256 MB above-mentioned rule.

I'm not following argument for large interleave at address 0 being a problem
(if we ignore the low memory hole and similar as a separate issue).  Even
if it is the interaction with the low memory hole, is 12 way interleave
of 256MiB devices a problem?  Fills up to 3GiB.


> +
> +On those systems, BIOS publishes CFMWS which communicate the active Syst=
em
> +Physical Address (SPA) ranges that map to a subset of the Host Physical
> +Address (HPA) ranges. The SPA range trims out the hole, and capacity in =
the
> +endpoint is lost with no SPA to map to CXL HPA in that hole.
> +
> +The description of the Window Size field in table 9-22 needs to take that
> +special case into account.
> +
> +Note that the Endpoint Decoders HPA range sizes have to comply with the
> +alignment constraints and so a part of their memory capacity might not be
> +accessible if their size exceeds the matching CFMWS range's.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without this change, the OSPM wouldn't match Endpoint Decoders with CFMWS
> +whose Window Size don't fit the alignment constraints and so the memdev
> +capacity would be lost. This change allows the OSPM to match Endpoint
> +Decoders whose HPA range size exceeds the matching CFMWS and create
> +regions that at least utilize a part of the memory devices total capacit=
y.
> +
> +References
> +----------
> +
> +Compute Express Link Specification Revision 3.2, Version 1.0
> +<https://www.computeexpresslink.org/>
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +The current description of a CFMWS Window Size (Table 9-22) is replaced
> +with:
> +
> +"The total number of consecutive bytes of HPA this window represents. Th=
is
> +value shall be a multiple of NIW*256 MB. On platforms that reserve physi=
cal
> +addresses below 4 GB for special use (e.g., the Low Memory Hole for PCIe
> +MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a wind=
ow
> +size that doesn't align with the NIW*256 MB constraint; note that the
> +matching Endpoint Decoders HPA range size must still align to the
> +above-mentioned rule and so the memory capacity that might exceed the CF=
MWS
> +window size will not be accessible.".
>=20
> base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa

