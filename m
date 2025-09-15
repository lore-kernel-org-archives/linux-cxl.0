Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF161C8630
	for <linux-cxl@vger.kernel.org>; Mon, 15 Sep 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978366; cv=none; b=ohr6zUaXRJ+hcyHO39OWveGVN0z4zriUytgg6Isj4EoJ2h9tzAhbGhH30Ajx1sgRf7oGkaNv2nZi/nq7lG2Uqm+sdUefZJxKC2U96tATXzi8H05VWX5OAlf6j1U9l9xvtX4mdq1DdWzIrA5sYvLXMIRaV0u2fXx3WR9AFzoOxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978366; c=relaxed/simple;
	bh=7Wjc99W3NLUfRTyDEP4Hem6iVkB4fRMTE4lwOp/Og/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZKwll4sLH5GVVbuG7mOWzYJkxQj13Hi17ZqJIi+gBHtt5U0Rb9WF1W7tGDsKHhNjh7DCdRkLfL68tyDXV29VcRk9XQHvSMFXJDy+Yv7XywLuMWujMMYg2YYhpxs7k+NpIVCW2QFKhDrZJ1a8ofidvE0hoxvWcuHnHDaX7E2zhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X65+GmY0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X65+GmY0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso3089701a12.2
        for <linux-cxl@vger.kernel.org>; Mon, 15 Sep 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757978363; x=1758583163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCsmv9Ju7v7klfvgYsrq2lr0zsNh+zDgxdjn6Hp3g5I=;
        b=X65+GmY0wglqHn0DFcqZ7YFqbdEYaJZkNHQ1Sufg/cGXADlKPdjp6oMviUPoL6BWQ6
         sedUcKgNHwBOcDZ5bDhR0bPcW4KQfloCY7EksbP+9DNWNitXMhZyfO2qmbwCXHIwoypM
         UWr2Gt5zlCyQLY9QGSCa78gc4DdFUf0CGHd+KHqf/Acn1XaUTSnU4QdwLa9PU9JXaeOq
         DbFQaEjDBlv93XKAB6gOFX1hR9QE07LmSuQx0IP0mgvmBS1q6Ql3l47Ts0aSk0sdED64
         +CkIFYt2ZNms281K69ZZyvCdwlAHB6zjKYNE3LbhZMmiKdpziIl0aYf0bcGjj/pgmGfo
         IMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757978363; x=1758583163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCsmv9Ju7v7klfvgYsrq2lr0zsNh+zDgxdjn6Hp3g5I=;
        b=p5jU91O/BbSQjeVipumqLy1HhlqZ1LeoWj5JdLw2F8WJcfauX+j979k/rUD3saE26k
         +ap6s6xVhdzB0YyIKiSlESJj/1rHVsiRZudaL9lCeHz3o+eKtlSYTYzsVh0ld4Gv+w0+
         WcgWytfbhLuOHd+UHF91IlZTtNLQ6U0oNBIt/vquoa4bwaeyFTGu0DwcJ0MbDVNc8zJd
         mKci+lKKJsg3CAeGSxwAuB/hO2MnW3ILeSZE7mtKpmfb5PgXQwLD9LVxbIoj3GIqkuGJ
         /iEtDA9723PhqcT5Rcqf/7av0Eeoty2Z1YabJXNuwmoKOgOrdBsWPGgxUOMuWCYQkOLe
         uHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV4DoOCwjVeftOi1W7jJCFZXIPynpJSRt9pNmQM7+BbyMIwBcPIOUBN0pejMkREI6bt6ZHT73X5kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPcmf/Arr6Hs8ZHyXdKprgZDMfDdRQMojyneWrReEJJZv/yV+
	ZxaEekKjfb3ss1/v0p6FKNUsRY6+F7NuXXVFdCDdADWUn99VZgZrxdLX
X-Gm-Gg: ASbGncvTxSZnViLBlS3kXs4kABUQvkLLNdB+99dNDC7SUgxtZgkmof4fHRA5bFf8DGD
	n19C7kyNsG1BUX/ZF0vtfJa+PfdgKUcX2S91JQH9V9+fP0g7ufmG0HZafy2UhefIFwhDTk51E2N
	mc7g20CZdv8+Xqyvvkf/ewM9UVP9wD5V2QpAsjduvs+1uADYIGAiLQz5r/n9HCEgSDDa4b/5LK2
	m5FWRSp4B6Ad8EVTjagehIkX9U2oaS34amqN6rfFFVPXqyIa3LSdILmle/59WKEX1/NIjdb7xOm
	3SGvRsuBLz7+ZRgQ7LWgHAuPYkvrbeu6xK2AUuaqWptKMVhWewznkF9Mhd3JhUVbz8XK3LVjtKx
	YJNtIOY/RFyyPNeBM8NCZOwo3iQoTjAW/zBDC
X-Google-Smtp-Source: AGHT+IE5YJ8MN5ScIcUChT1bZd0Hud5a/TzVlzam3JreiTLsv0IECLjtSBnjYNCi9aLpKux4FkFDPw==
X-Received: by 2002:a17:903:248:b0:249:2360:6af2 with SMTP id d9443c01a7336-25d24baff8emr187682985ad.16.1757978362982;
        Mon, 15 Sep 2025 16:19:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47acasm14325237b3a.38.2025.09.15.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:19:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D7DDF420A809; Tue, 16 Sep 2025 06:19:14 +0700 (WIB)
Date: Tue, 16 Sep 2025 06:19:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v6] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, Low memory Holes, Decoders
Message-ID: <aMie8YrZJw-qmPDk@archie.me>
References: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3thlJ7Uhf4hkMntH"
Content-Disposition: inline
In-Reply-To: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>


--3thlJ7Uhf4hkMntH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 04:57:20PM +0200, Fabio M. De Francesco wrote:
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation=
/driver-api/cxl/conventions.rst
> index da347a81a237..6bce7c614fff 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,138 @@ Detailed Description of the Change
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
> +- Fabio M. De Francesco, Intel
> +- Dan J. Williams, Intel
> +- Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current Compute Express Link (CXL) Specifications (Revi=
sion
> +3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describ=
es zero
> +or more Host Physical Address (HPA) windows associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be interl=
eaved
> +across one or more targets, including CXL Host Bridges.  Each window has=
 a set
> +of restrictions that govern its usage. It is the Operating System-direct=
ed
> +configuration and Power Management (OSPM) responsibility to utilize each=
 window
> +for the specified use.
> +
> +Table 9-22 of the current CXL Specifications states that the Window Size=
 field
> +contains the total number of consecutive bytes of HPA this window descri=
bes.
> +This value must be a multiple of the Number of Interleave Ways (NIW) * 2=
56 MB.
> +
> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB whe=
re a
> +memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such =
cases,
> +the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
> +
> +The HPA represents the actual physical memory address space that the CXL=
 devices
> +can decode and respond to, while the System Physical Address (SPA), a re=
lated
> +but distinct concept, represents the system-visible address space that u=
sers can
> +direct transaction to and so it excludes reserved regions.
> +
> +BIOS publishes CFMWS to communicate the active SPA ranges that, on platf=
orms
> +with LMH's, map to a strict subset of the HPA. The SPA range trims out t=
he hole,
> +resulting in lost capacity in the Endpoints with no SPA to map to that p=
art of
> +the HPA range that intersects the hole.
> +
> +E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
> +
> + +--------+------------+-------------------+------------------+---------=
----------+------+
> + | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Dec=
oder Size | Ways |
> + +=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D+
> + |  =E2=80=810    |   0 GB     |       2 GB        |      0 GB        | =
      3 GB        |  12  |
> + +--------+------------+-------------------+------------------+---------=
----------+------+
> + |  =E2=80=811    |   4 GB     | NIW*256MB Aligned |      4 GB        | =
NIW*256MB Aligned |  12  |
> + +--------+------------+-------------------+------------------+---------=
----------+------+

Nit: You can remove double colon marker so that the table will be parsed
as such.

> +
> +HDM decoder base and HDM decoder size represent all the 12 Endpoint Deco=
ders of
> +a 12 ways region and all the intermediate Switch Decoders.  They are con=
figured
> +by the BIOS according to the NIW * 256MB rule, resulting in a HPA range =
size of
> +3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Ro=
ot
> +Decoder HPA range that results smaller (2GB) than that of the Switch and
> +Endpoint Decoders in the hierarchy (3GB).
> +
> +This creates 2 issues which lead to a failure to construct a region:
> +
> +1) A mismatch in region size between root and any HDM decoder. The root =
decoders
> +   will always be smaller due to the trim.
> +
> +2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
> +
> +This change allows a region with a base address of 0GB to bypass these c=
hecks to
> +allow for region creation with the trimmed root decoder address range.
> +
> +This change does not allow for any other arbitrary region to violate the=
se
> +checks - it is intended exclusively to enable x86 platforms which map CX=
L memory
> +under 4GB.
> +
> +Despite the HDM decoders covering the PCIE hole HPA region, it is expect=
ed that
> +the platform will never route address accesses to the CXL complex becaus=
e the
> +root decoder only covers the trimmed region (which excludes this).  This=
 is
> +outside the ability of Linux to enforce.
> +
> +On the example platform, only the first 2GB will be potentially usable, =
but
> +Linux, aiming to adhere to the current specifications, fails to construct
> +Regions and attach Endpoint and intermediate Switch Decoders to them.
> +
> +There are several points of failure that due to the expectation that the=
 Root
> +Decoder HPA size, that is equal to the CFMWS from which it is configured=
, has
> +to be greater or equal to the matching Switch and Endpoint HDM Decoders.
> +
> +In order to succeed with construction and attachment, Linux must constru=
ct a
> +Region with Root Decoder HPA range size, and then attach to that all the
> +intermediate Switch Decoders and Endpoint Decoders that belong to the hi=
erarchy
> +regardless of their range sizes.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without the change, the OSPM wouldn't match intermediate Switch and Endp=
oint
> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't a=
lign
> +with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
> +
> +This change allows the OSPM to construct Regions and attach intermediate=
 Switch
> +and Endpoint Decoders to them, so that the addressable part of the memory
> +devices total capacity is made available to the users.
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
> +The description of the Window Size field in table 9-22 needs to account =
for
> +platforms with Low Memory Holes, where SPA ranges might be subsets of the
> +endpoints HPA. Therefore, it has to be changed to the following:
> +
> +"The total number of consecutive bytes of HPA this window represents. Th=
is value
> +shall be a multiple of NIW * 256 MB.
> +
> +On platforms that reserve physical addresses below 4 GB, such as the Low=
 Memory
> +Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is =
0 might
> +have a size that doesn't align with the NIW * 256 MB constraint.
> +
> +Note that the matching intermediate Switch Decoders and the Endpoint Dec=
oders
> +HPA range sizes must still align to the above-mentioned rule, but the me=
mory
> +capacity that exceeds the CFMWS window size won't be accessible.".

The rest LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3thlJ7Uhf4hkMntH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMie7AAKCRD2uYlJVVFO
o5UdAQChT9cpIu727LYaQN4Hia5cXDeQEnPK8jW23zEJ5VKiuAEAp0NgBZELdrOY
rATzi4Tu9xu5M1l8NV6cggN35VIUXgI=
=nR49
-----END PGP SIGNATURE-----

--3thlJ7Uhf4hkMntH--
