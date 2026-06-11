Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B23D3306
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222290; cv=none; b=cmKhLN2dMDbj+bOrP3tSEsse2rRuqFguTgAK2FBPLvbcNbtCwy8pkuz2mNfZzl4XjnmweqzvO4gi1EiMmmXVE8rumNHOrasI4H4GKGQf7yHc9gI5dadMgZTP7qeukPkdgqWsBrHobmXOtafmIpBnXrQGDa4aEIcNnw5AFTLF7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222290; c=relaxed/simple;
	bh=5KjEslF8hJ04qm3kMrLBWZe88GuBh31adj+jNnL1rRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVLAr9i49/L2QRgXpjn52W6/7622xzvu0UVgMsgnxDXV5KW9Qft6rPndZ0H4kY3/C7mUM66l0onPIFYqAgmxQWZlkIuoi+Qbw1VBddYJRA2ATBD/1I/XDHxmos+zbtNjrpMGMJM5CqfyrCYoQASIUX6Oe7ePAKieQycd1DpuYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLHZnmOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLHZnmOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021F71F000E9;
	Thu, 11 Jun 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781222286;
	bh=ud/04mG1MC0xJ9AEjcqyf3IE6GixxDV+G4JuGslEFdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLHZnmOtaRpp1u/jZrWNpB7AGXuWKVI2Ffwbtyrgx6gH8UEbqRNuqAf4pabqHMJjB
	 Vt7gEqM6AFhSyIV5agqDBpC1DCxgv4fEfak55KPDoROmk6O96xb/TlLB/FVHkOi24I
	 8qpi9AbAj90ulCUqOOBT7tUFPPjHueCAajtLtEn9nNgOfgjMVW5VUJGIZ2qi9NTwff
	 wuZWGQ71BhdvU3wRA2SRR4PgRRKWsAObidbR4XJU1/7qwCrBcgYmGizBLQrFJ6O/EX
	 haJ3X901qlu0mkNunYM7lFZjPllYtYIW+TmeGecTr041mFBcI3/caOBCA105SMi5Rw
	 /ZTtXH5wmiTgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611234409.256765-7-dave.jiang@intel.com>
References: <20260611234409.256765-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:58:05 +0000
Message-Id: <20260611235806.021F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch invokes non-existent functions `cxl_set_capacity()` and `=
devm_cxl_probe_mem()`, resulting in a build failure.
--

commit b886732115c0a94e1bae2a16b1299055ba5c99ea
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add cxl_test accelerator driver

Add a type2 accelerator mock driver for the platform device that
simulates a CXL type2 device.

> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/acce=
l.c
> new file mode 100644
> index 0000000000000..9c8235f9d97b7
> --- /dev/null
> +++ b/tools/testing/cxl/test/accel.c
[ ... ]
> +static int cxl_mock_accel_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	cxlds =3D &cxl_accel->cxlds;
> +	cxlds->media_ready =3D true;
> +	rc =3D cxl_set_capacity(cxlds, SZ_512M);
> +	if (rc)
> +		return rc;
> +
> +	cxlmd =3D devm_cxl_probe_mem(cxlds, &mock_range);

[Severity: Low]
Does this code cause a build failure?=20

It appears that cxl_set_capacity() and devm_cxl_probe_mem() are not defined=
=20
anywhere in the CXL core subsystem, which would lead to unresolved symbol=20
errors during compilation.

> +	if (IS_ERR(cxlmd))
> +		return PTR_ERR(cxlmd);
> +	cxl_accel->cxlmd =3D cxlmd;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611234409.2567=
65-1-dave.jiang@intel.com?part=3D6
