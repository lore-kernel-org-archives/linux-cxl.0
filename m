Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E783783AE
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765429; cv=none; b=OzqqV2nwIa3isxu3Iqbpbl3MgeGTihfkY1uLLJK2SetqwG7tLJibK++355Qegl/zqKxLKDUTfqj0xN9USq6gHT2C13X+3cJxg5V19RtKpTDWI9aUs6N3csdfCVVcWP7Qe5SQ1FBMVnIl0uxcKj8nW0LakWoRdEMX3Uk95Ymw1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765429; c=relaxed/simple;
	bh=pvLHoVdDPgiIKuGHK5mbqlZ/wUi5orK9mHGumGuw9bY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YyzkTZ7akFUJ06GVSkyH9GCrRRMPD9ksUH/mRT7o/+EsMQB3j98B07xu+QjH+5fWkzHQZJtc7TZ159uvtd6XG2rVoKVAkxZqHJj83P17HE3VXsmeo1xRX31mXzr4XF9D8PcB6rCjjQMH1kj/sWS6OqNUjLZFEIYbGT7I6x1KV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb0XaGnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb0XaGnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421661F000E9;
	Mon, 29 Jun 2026 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765424;
	bh=mvZnk8A39R72YCKJ0bpVDGw41uyHbBFGJXT9XwLh6OQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cb0XaGnRvfw7tPgv2icS3eaGxJzDf0lm/yECuDOlPZyMNyrzhIKpTjH5mN0ieU/An
	 xPYsaeYTe19slaku5pGp/Id8WE8kruWApgqfWemejmCxlCaGJVGKdhWP6CSXiNyZBP
	 jHTTKlpfxZLtShdNlpN/g2UGo6dNS9rsc1J8dY8z+E84WmkV4axbIb+AbhItNmWzbh
	 bv3/DED9m/f7FdzQZwAkhVCGC8vTE+UgKL5vTquDI6DqO0pbbkbI/muasFkKmCiRSL
	 1wduKKuDVS7rZjStsgeYr4B05XPH148ut5X20U4WIgpH7Qlfp5v8pLfwMN3UsjLhjA
	 7pur4Kkyo1ufA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] cxl/test: Add cxl_test accelerator driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629202720.3658117-7-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
 <20260629202720.3658117-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:37:03 +0000
Message-Id: <20260629203704.421661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The module calls an undefined function `cxl_set_capacity()`, result=
ing in a build failure.
--

commit 4857e7bc9c7f23612e9f8b197d31f99d7d824ef0
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add cxl_test accelerator driver

This commit adds a mock driver for a platform device that simulates a CXL=20
type2 accelerator. It exercises the minimal API calls that a real CXL type2=
=20
driver would use.

> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/acce=
l.c
> new file mode 100644
> index 0000000000000..8e6f4687ca02a
> --- /dev/null
> +++ b/tools/testing/cxl/test/accel.c
[ ... ]
> +static int cxl_mock_accel_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	cxlds =3D &cxl_accel->cxlds;
> +	cxlds->media_ready =3D true;
> +	rc =3D cxl_set_capacity(cxlds, SZ_512M);

[Severity: Low]
Does cxl_set_capacity() exist in the kernel tree? I am unable to locate a=20
declaration or definition for this function, which seems like it would=20
trigger a build failure during module compilation.

> +	if (rc)
> +		return rc;
> +
> +	cxlmd =3D devm_cxl_probe_mem(cxlds, &mock_range);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629202720.3658=
117-1-dave.jiang@intel.com?part=3D6
