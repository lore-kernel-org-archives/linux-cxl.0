Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5782EB5B8;
	Mon, 15 Dec 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797303; cv=none; b=AoqZ0hOFjzzOrNw2VzonSyAaXzbOccGZ38deQUIDHHgTiXyAECj5/3gZfVu29EhXevd4/Wk+Nk5OPJPGD1l/rZyBOg3JU40Lqs1IzT0LaNAOHkBcBnBMpuTY2ARRZRLdbfLnXBIRWoHmN233ZusIoqjS0DQuESOnzTO+YJoMlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797303; c=relaxed/simple;
	bh=f38WDaP1WboTC3N6ET0xMwgwaMI4Qhpvho4znpVo+vU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2AR3Z2y+cc7XPSyj1rqweBQq2MxNgbc2fS57feJku9riuUde7DJY6vU5bqhS6YClH3PiJew4/9gzyf9o0ZGUGilIaLJwGYoyE2UEK3TAGz8RJpNiwaNnMmSSNTdaFsbKqKabZGvLGsC+e9ejmlt8dlOFJtRcf7Xf+I26OuquxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVHWn6rkQzJ46kB;
	Mon, 15 Dec 2025 19:14:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ED56B40086;
	Mon, 15 Dec 2025 19:14:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 11:14:55 +0000
Date: Mon, 15 Dec 2025 11:14:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl, doc: Moving conventions in separate files
Message-ID: <20251215111453.000072a2@huawei.com>
In-Reply-To: <20251209181959.210533-1-rrichter@amd.com>
References: <20251209181959.210533-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 9 Dec 2025 19:19:55 +0100
Robert Richter <rrichter@amd.com> wrote:

> Moving conventions in separate files.
>=20
> Note this patch removes the line to include:: <isonum.txt>. From Jon:
>=20
> "This include has been cargo-culted around the docs...the only real
> use of it is to write |copy| rather than =A9, but these docs don't even
> do that. It can be taken out."

Hi Robert,

Whilst I don't really care that much for docs, this is an unrelated
change so I'd have done that as a precursor patch.

Other than that, looks like sensible path to better scalability of
these docs.  However, questions inline as this is doing a little
more than simply moving stuff around. The intro text on what the whole
thing is about disappears.

>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v2:
>  * Removed include:: <isonum.txt> line (Jon).
> ---
> ---
>  Documentation/driver-api/cxl/conventions.rst  | 183 +-----------------
>  .../driver-api/cxl/conventions/cxl-lmh.rst    | 135 +++++++++++++
>  .../driver-api/cxl/conventions/template.rst   |  38 ++++
>  3 files changed, 179 insertions(+), 177 deletions(-)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
>  create mode 100644 Documentation/driver-api/cxl/conventions/template.rst
>=20
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation=
/driver-api/cxl/conventions.rst
> index e37336d7b116..53f31a229c8d 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -1,182 +1,11 @@
>  .. SPDX-License-Identifier: GPL-2.0
> -.. include:: <isonum.txt>
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Compute Express Link: Linux Conventions
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#######################################
> =20
> -There exists shipping platforms that bend or break CXL specification
> -expectations. Record the details and the rationale for those deviations.
> -Borrow the ACPI Code First template format to capture the assumptions
> -and tradeoffs such that multiple platform implementations can follow the
> -same convention.

This block around the format choice etc to me has some value, so why not ke=
ep
it about the ToC?  I'd rather we didn't end up with conventions that are
about something completely different in here just because the title first
(code style maybe?)



> +.. toctree::
> +   :maxdepth: 1
> +   :caption: Contents

> +   conventions/cxl-lmh.rst
> +   conventions/template.rst

...

> diff --git a/Documentation/driver-api/cxl/conventions/template.rst b/Docu=
mentation/driver-api/cxl/conventions/template.rst
> new file mode 100644
> index 000000000000..39a9ca87cf92
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/template.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. :: Template Title here:
> +
> +Template File
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Document
> +--------
> +CXL Revision <rev>, Version <ver>
> +
> +License
> +-------
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Summary of the Change
> +---------------------
> +
> +<Detail the conflict with the specification and where available the
> +assumptions and tradeoffs taken by the hardware platform.>
> +

Obviously unrelated change but maybe drop a blank line here anyway
just for consistency with the rest where 1 is=20

> +
> +Benefits of the Change
> +----------------------
> +
> +<Detail what happens if platforms and Linux do not adopt this
> +convention.> =20
> +
> +References
> +----------
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +<Propose spec language that corrects the conflict.>
>=20
> base-commit: 9d887fa9036f64331038b48199ae07da89777160

