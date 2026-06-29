Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157B327BFC
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765538; cv=none; b=T8jHCfwSDtzTbXr9aTgQRelktONoZbc3xuTnloWD9x/2ECMX1KHye/+WHNaJwO7cWsR076rcpRu8PHW3FUdJG2MlLQDyRQEkCZYokrt8v/C2OIFn5aJWxJJX8tz2XKIatCAillTR3B84urQX7xW6flaLRaLvGPdDxAthibm5XnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765538; c=relaxed/simple;
	bh=p3ZlSYcP1qPqU7luzTtpAnWEv3d3xO9JbgEH34Kryig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VhTp6GnXZ/UzOKb67mmPk11nADme4LtZkh32t3r4NaACyC8Fd3tuWPaKveha8CuzkSj5RhbIeuhPFfQm4EyLAyUc4czoQvd1pH/aughRbZ0niK3wJCZNTIdFvezWtp5idkg+FFo0hF2enIqpz+ukTty4d5+ufobykbARaS+SHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxpij+Hq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxpij+Hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13621F000E9;
	Mon, 29 Jun 2026 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765536;
	bh=fSpK8bSBoJRN/NCF0gTOcGmREp30LW+K3OWX4yPhRv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qxpij+HqvHI++VWX8u6grT3of4pQjWm7PFnpwSC3v6WtFhXzhoG7Xg43v9n7m5H1Y
	 BYpYGBniQb/KFTy7J+5nXpRrq2v5aZiyHiQFSRvg+c7KZMDwDdS6s+3KEkqKNJXE0k
	 I9YNfzP+4tQ5tm/hKEKSxf5ApnBnhCyekwLkgVmoLoIuT8oRRS0DoI1uDObgAXwddi
	 1AJP/5R4SM5xnygTG78QmmvjRLTbZD5r0Xlwe1QMr5+OdP9S3f26iUlQ2M5a6tKofC
	 bMrbWXlOyjV1MMyL0i5vEdDvOI8eMFQY1FDpC/gyHh/h/iBwIxXeWvubI3AWy7eyOm
	 9H0ck/1vE4EWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] cxl/test: Refactor platform device enumerations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629202720.3658117-4-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
 <20260629202720.3658117-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:38:56 +0000
Message-Id: <20260629203856.B13621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to assign an error code to `rc` (e.g., `-ENOMEM`) on devic=
e allocation failures in `cxl_test_init()`, `cxl_single_topo_init()`, and `=
cxl_rch_topo_init()`. This causes the functions to return `0` (success) or =
an uninitialized stack value on failure.
--

commit 49a38c246be39e985c66be86964ee186b899793d
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Refactor platform device enumerations

Split all the host bridges, rootports, upstream and downstream ports
enumerations to separate helper functions. This should make adding
type2 hierarchy easier later on.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 32964420e470a..8abe066080bc8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -1868,62 +1868,34 @@ static bool __init have_multiple_modparms(void)
[ ... ]
> +static int host_bridges_populate(void)
> +{
> +	int rc =3D 0;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
> +	for (int i =3D 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
>  		struct acpi_device *adev =3D &host_bridge[i];
>  		struct platform_device *pdev;
> =20
>  		pdev =3D platform_device_alloc("cxl_host_bridge", i);
> -		if (!pdev)
> +		if (!pdev) {
> +			rc =3D -ENOMEM;
>  			goto err_bridge;
> +		}

[Severity: High]
This is a pre-existing issue, but I see you fixed the missing rc =3D -ENOMEM
assignments during failure paths in this newly refactored function and othe=
rs.

However, does the same missing rc =3D -ENOMEM assignment still exist in
other unrefactored topology initialization functions in
tools/testing/cxl/test/cxl.c?

For example, in cxl_single_topo_init():

	pdev =3D platform_device_alloc("cxl_host_bridge",
				     NR_CXL_HOST_BRIDGES + i);
	if (!pdev)
		goto err_bridge;

And similarly in cxl_rch_topo_init(), and for cxl_acpi in cxl_test_init()?

If platform_device_alloc() fails in these functions, could they return an
uninitialized rc or 0?

If they return 0, the test module is successfully loaded despite having fre=
ed
mock resources, leaving dangling pointers. When the module is subsequently
unloaded, cxl_test_exit() unregisters these platform devices again.

Could this cause a double-free and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629202720.3658=
117-1-dave.jiang@intel.com?part=3D3
