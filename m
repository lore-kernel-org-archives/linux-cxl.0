Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E64331ED7
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131078; cv=none; b=Db24kGMdYXx1N+1aHtZDkCEuKqVAE3H1JYNYiuFm1fLPPJEILTTc0h0p1ObQA5leRSmy+lCHzFRufed7DWV2Wtnu+xYQwP72Wiyo5PWdIx5s5h753gCO+wgKpTT0u0mp9o7tJ1UxbzSHmhdN7TWaMwsmKhq99tCL9dizPtNPJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131078; c=relaxed/simple;
	bh=rpKLlPL8a70Z02C2vxZNvVwbcbEVdgToPuiwd8nH2NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZjGLUx8uI71J0JMZTkYv78YDswo4drSs2YCmI9gneYg92GdvQppbcK7t6EesDRq09hV3zAz+io6cbLR1N3ueZkgm/bcIjKILS/F5OdtA7AnsrulGiuuqwog0eYlCrDHIu7XkMf18W8ykOVVAZcU7cW5tacAgwKUW9dpfoMy0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUb/RFJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUb/RFJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE53F1F00893;
	Wed, 10 Jun 2026 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781131076;
	bh=hFT+kEVVqsS3Y22ivBYE8HEPyENtPsQYLvdt2i7cIvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUb/RFJ+kmDpA/DjroZqW6J62iZrco1XWBIyOn8ge9V7oeq4iBosdI0+LA+G3YWdn
	 u7/trkrjYrHkOh0Jun73auDv+lEOSZhS0mLNrYWJFTjXu0CTeO902iVbkx5n+iFZ9I
	 F8cYDt2n7DZ4jt0Xqr/8WJm8nTRYAU/zcFOZ8oDGlOk+kOnchI6UGEBPqxcFh4Gw0/
	 8MZ61sZqtvvyk3uHo4eZMrFgyWKpqIfQ8CZmfiXGOMp8kYX5tG529siVS6MfCN9/zk
	 LewIayIquVifcM13n5NfAhK4k9MES07I0buL6HQRgmPDJk1jjOOeWDBT8b0RggM390
	 HFnLgzyTjAnzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] cxl/test: Add cxl_test accelerator driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260610222328.2272427-7-dave.jiang@intel.com>
References: <20260610222328.2272427-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 22:37:56 +0000
Message-Id: <20260610223756.AE53F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Logic Error: Incorrect device ID field used for device serial nu=
mber generation
- [Low] Build Failure: Undefined functions `cxl_set_capacity` and `devm_cxl=
_probe_mem`
--

commit 1221192460bb0724f4ff13dd01d1388c60a7fe54
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add cxl_test accelerator driver

This commit adds a type2 accelerator mock driver for the platform device to
simulate a CXL type2 device. It exercises the minimal API calls that a real
CXL type2 driver would utilize.

> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/acce=
l.c
> new file mode 100644
> index 0000000000000..6e1dd6c815102
> --- /dev/null
> +++ b/tools/testing/cxl/test/accel.c
> @@ -0,0 +1,66 @@

[ ... ]

> +static int cxl_mock_accel_probe(struct platform_device *pdev)
> +{
> +	struct mock_cxl_accel *cxl_accel;
> +	struct device *dev =3D &pdev->dev;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct range mock_range;
> +	int rc;
> +
> +	cxl_accel =3D devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
> +					      pdev->dev.id + 1, 0,

[Severity: Medium]
Is pdev->dev.id the correct field to use for the device serial number here?

For dynamically allocated platform devices, pdev->dev.id is usually 0, while
the actual instance identifier is stored in pdev->id. If pdev->dev.id always
evaluates to 0, will all simulated Type 2 accelerator instances end up
sharing the same serial number (1) and conflict during enumeration?

> +					      struct mock_cxl_accel, cxlds,
> +					      false);
> +	if (!cxl_accel)
> +		return -ENOMEM;
> +
> +	cxlds =3D &cxl_accel->cxlds;
> +	cxlds->media_ready =3D true;
> +	rc =3D cxl_set_capacity(cxlds, SZ_512M);

[Severity: Low]
Do cxl_set_capacity() and devm_cxl_probe_mem() below exist in the tree?

It looks like these functions are not defined or declared anywhere, which
might cause the module build to fail with implicit declaration and undefined
symbol errors. Other mock drivers in the tree appear to use
devm_cxl_add_memdev(). Could these function calls be leftovers from an
earlier design?

> +	if (rc)
> +		return rc;
> +
> +	cxlmd =3D devm_cxl_probe_mem(cxlds, &mock_range);
> +	if (IS_ERR(cxlmd))
> +		return PTR_ERR(cxlmd);
> +	cxl_accel->cxlmd =3D cxlmd;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610222328.2272=
427-1-dave.jiang@intel.com?part=3D6
