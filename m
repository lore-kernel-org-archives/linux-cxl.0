Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18977426EBB
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191969; cv=none; b=BAL6mAt9cb+j9qldIFg5CWSQGMBIpHotK//AS1I2rcN2tUMAsjymPvyrNNAL7BMRo0R3fQIqYa17we4SFmmhbDNQ8/wK4HDp45XLmlXrvhhUm7VPg4LtkwwXjVyvV3YAEpmLm0ZGiEfxZXG/+cc3nuTnS4bTNiMNwnTLXlF447Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191969; c=relaxed/simple;
	bh=rkP8ZR3sU7d/+3qXqGbQRgoSCP0wTlo6HKm/3o1/LpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqMb90XAWm4pTosDVNLkfDBrib7hzLpZS164vzRAQKd/xpVFYged1BPWVMZfnTzBEzgyPMqQawv1erKj5l+U+XX56fGXzaqakT/k1dinhFwBBguiSM9ODlrAp4hJHHYNXknvpl1KbQ/rcEtdUokvwJ5gGAG2bI385KUr8jPhCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFfURhNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFfURhNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B931F00898;
	Thu, 11 Jun 2026 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191961;
	bh=sTt+UTTRz0Wmo+xuNO8OyCKfVbOit1t/DDhEbDNx/ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFfURhNeDZiMRUO9LivtCDxdg3BQa51vPOKFMqGjS+P6x2ocsh95kvZctp6ObMvo5
	 0N81798czWtr9WLtH6t+j5QiNU/X5Qug5uOZy31JZZDQlZDxqKeXiWYu+x3FGeP0J/
	 TSrdJgBxTn1W5ij2n9CqA/earXbAiwckUirdsV9nVN+Hds5G6GpK1M6Os9NNtYzZWp
	 XWSLqR1zVKV9mcSuUL+Lhfuc0f9gU1aX/lzMRYDEJ0kd3y5NjTmyqOoItoempDuRbp
	 lLYyTso1hSQcBL5myB3ebRCdqERWvFBca5wuv4+Zy2dN42zdkHAHtsiEa5adVLqYCE
	 TtBG64r2cjGwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] cxl/test: Add cxl_test accelerator driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611152124.3656434-7-dave.jiang@intel.com>
References: <20260611152124.3656434-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:32:40 +0000
Message-Id: <20260611153241.33B931F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Undeclared API Usage / Build Failure due to missing functions `cxl_=
set_capacity` and `devm_cxl_probe_mem`.
--

commit fd0aec5a2701e0475907c9138fa0ea33cfb68569
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add cxl_test accelerator driver

This commit adds a mock platform driver simulating a CXL type 2 accelerator
device. It is designed to test minimal API calls required by real CXL type 2
drivers.

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
Are the cxl_set_capacity and devm_cxl_probe_mem functions defined anywhere =
in
the kernel source tree?

It appears these functions do not exist, which causes an implicit declarati=
on
error and undefined references during compilation. Will this lead to an
immediate build failure for the test module?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611152124.3656=
434-1-dave.jiang@intel.com?part=3D6
