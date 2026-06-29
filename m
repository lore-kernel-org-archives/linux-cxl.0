Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DA2C236B
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771833; cv=none; b=m7P8y7WQbnuTOhP4ECzuRmSKPLnQHmJrSpq08jDsLGz7B5+ZURtv4lAUnDJFql0Cab8WeGm5ILlnpP+dtWzoGyEpiH7+43TVyDvGp5O6rchWGg2IEYL0v4tBRAXUX2oQAcFcMnvPSfvZ1IXVaO2Q9+9QtbXLINPdCoSKYqX6Y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771833; c=relaxed/simple;
	bh=KhBspI9FDG9Ux9scR7NDMst6dGb4SCwjQ9gB8ieISH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y47bePGibb8cAaQLezg20fkOa7CXF6DSRX2+D9VVVAxcWl38TSrAf0va2I5iOv8A+uEM6fEVL+dPndIMl/3wrbv0PjRz9O5s8tlROEqUhRx5ovenQBKQ0er8lJccozyoB6a3Ou2zbErbe0MZ26zeZtngC6fZKE1Jx+v9AbAr+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsU0kwV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsU0kwV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D991F000E9;
	Mon, 29 Jun 2026 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771832;
	bh=Nxm5M9gjIbmmp3djFPdg91qs/dnNHU32wQUsRroxG3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsU0kwV0J7YJbW/XeRn1/4VlGD51FsrWvrYNYubLI71CWmxNeGuDRugBL9H/8/5+/
	 03gIna9NT82kZpre6xzeUtjHKQMy4Ya2HRe5y+Vztys3aa72l4/YKtuIiMGmZ+jVGm
	 HG+5GowNA/YGrR2nGvIZdCgV2JC2GsP7bPvKT1LFQgWv4aHtziHDs8BrsAttDwq6Rp
	 kX4/XE2PSkl3dT7mUlfpAfYKSguOTzaDu5FalOpkxY/NGuEumNMPTgMvpeaizwufsV
	 IIVGazlkKu206vJfQa1oRzZ9k8cy6tXU/9Y9tRxE8DsAsESGMu2Ehd9Cz3Qssruro7
	 qd8//yNqNWCdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] cxl/test: Add cxl_test accelerator driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629221104.3891733-8-dave.jiang@intel.com>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:23:51 +0000
Message-Id: <20260629222352.56D991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `cxl_set_capacity` is called but is neither declared n=
or defined anywhere in the kernel source.
--

commit e5897ac16ebf5251d0c169fc17ca2e8cde0dd51b
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add cxl_test accelerator driver

Add a type2 accelerator mock driver for the platform device that simulates
a CXL type2 device. The driver exercises the same minimal API calls that
a real CXL type2 driver would utilize.

> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/acce=
l.c
> new file mode 100644
> index 0000000000000..8e6f4687ca02a
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
> +					      pdev->id + 1, 0,
> +					      struct mock_cxl_accel, cxlds,
> +					      false);
> +	if (!cxl_accel)
> +		return -ENOMEM;
> +
> +	cxlds =3D &cxl_accel->cxlds;
> +	cxlds->media_ready =3D true;
> +	rc =3D cxl_set_capacity(cxlds, SZ_512M);

[Severity: Low]
Is cxl_set_capacity() defined in a different patch in this series?

It appears this function is neither declared nor defined in the tree. Calli=
ng
an undeclared function here causes an implicit declaration error and a link=
er
failure, breaking the build when compiling the CXL mock test module.

> +	if (rc)
> +		return rc;
> +
> +	cxlmd =3D devm_cxl_probe_mem(cxlds, &mock_range);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629221104.3891=
733-1-dave.jiang@intel.com?part=3D7
