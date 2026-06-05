Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D837DEAF
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623269; cv=none; b=KnFcQ+nhL9NxGsCmlyfNGbBDdOMxBs8nSJJbZKUncVqEb7oopOsJjJBrNKApHwnygxkSPjI189l/YZx6A1DPKkJpXwI6PWfEop1bTdAFBPeOUWxPB3oAp2dcj3v5lbe3iI0lun2YKq2WiSlGIZg7YuLKPep08Q6ToSZ7alNRc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623269; c=relaxed/simple;
	bh=m/kKnpLeNtfrsztMJahNnerBfichYtowOPeUzIG+bTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OVNi2C/DOlg55U5/aLzIXItoFAkSc3KJuUCgb2Kgk3KwVufyEiKT9jojf8xAqWPyogMtd99Lrij+he/z4UQJs0ZVz0kEaVwi4rnqYXUw03I+Qx3ArkMFaXuRoVnfFmh+cYa5KQviD37oSB5tQVNBr/nHDX3+CNL9qGJ0VIifaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adNZDHO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adNZDHO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D01F00898;
	Fri,  5 Jun 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623260;
	bh=2ipGjzUmdwdkJTTgAIRdw0Zot7Gm4lWZq5Kp8xkr+W4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adNZDHO65nsUKDjWc0CTHYkoGrSKiK/PkQyY6Jp6MWRtfuYU88xDzZidsNACxfJyU
	 sn7nsBpf4iaZVvzPdtvfkvkz2bZObTZbL1uWnF1XoLYDI/U6suh2eiLwhZgYmHRDb8
	 E1dEP6xWa2KdKi1PHeWiiUCF8dHJVwAb7nN+EUygjBmTwVJyc3WukbfX0zKhkljdLc
	 9J27KxzW6MwbnqksOtxFj+APXoIY139mePQutXVGEt/SIBx/qDZq0Tu+ZrKv2TbRT2
	 ZSIFYIuZKb5VBjVx/eFE/loBthhujNJmn7YYYmasHD9kEq3ra5x6AyF3Bm5IVBZukM
	 TPXiJMtbFiE9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] cxl: Add HDM-DB region creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605003329.2584012-5-dave@stgolabs.net>
References: <20260605003329.2584012-5-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:34:20 +0000
Message-Id: <20260605013420.771D01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Type-2 (CXL_DEVTYPE_DEVMEM) endpoints lacking Back-Invalidation (B=
I) support are incorrectly allowed to attach to HDM-DB regions, resulting i=
n an invalid HDM-D configuration within a BI-restricted window.
--

commit 17274d5d8a1db5fc909bbe15ef4736f49f5f5bb1
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Add HDM-DB region creation

A region inherits its coherency from the chosen root decoder: HDM-DB if the
root has CXL_DECODER_F_BI, otherwise HDM-H. This commit surfaces the
topology through sysfs and enables HDM-DB capability checking.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e82..3f9ddacfae4ea 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2083,10 +2073,31 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
>  		return -ENXIO;
>  	}
> =20
> -	if (cxled->cxld.target_type !=3D cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
> +	    cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {

[Severity: High]
Does this capability check incorrectly allow Type-2 devices without back
invalidation support to bypass the validation?

Since this check requires cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM (Type-3
devices), Type-2 devices bypass it. If they attach to an HDM-DB region,
cxld_set_type() in drivers/cxl/core/hdm.c will configure the decoder as
HDM-D (BI=3D0) because of this logic:

cxld_set_type()
    bi =3D bi && cxlds->bi;

Will this violate the host bridge's coherency expectations by allowing an
HDM-D configuration within a BI-restricted window?

> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm =3D dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605003329.2584=
012-1-dave@stgolabs.net?part=3D4
