Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A9409632
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544729; cv=none; b=Tx5ORRfoJX+1SvDD2xpYgWJZYjOJO9Jml1rizcnLL1yd3t7FEuPXW2RszOF5xc3CtUDpkYPkmAcACWNkQSHgB/F2DPOt4AfC88t+s1t8jL6xQ6s7bW070xOjoeOvpTlQgLBCYZ8tJvJw6a7I0IfQx81ZG2rAlLE5dvr3CNGCWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544729; c=relaxed/simple;
	bh=eXUM6tVscrMcKyN0NFiwPsxIazsaEzwBDHcEha3HSRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRf09UVWziiIEyHRgcuX2kORSL4wDLqA1KKPJvCTAI4dkvImp81x9na8o1G8IWvXTXs4186ZdX+7mztSR3ryv2VlwBzLgYvmAZKpqVWH1SKHzt2/YgW733WnCe9HYBipqy/Smza1azRCwWG6k4Bc7RxSAygJy/P6HJLzMxGYkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4OUue3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4OUue3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406371F000E9;
	Mon, 15 Jun 2026 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544728;
	bh=ChAE4zGVChZ90sFExyFmqpz8l4pA0vbLO8iiBNn5JXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4OUue3qPxPk869FMpbpctriBzPKMZlEZQ+3Y8+oeTyzk4WxGTooh4kpUEIfbzQuL
	 xEdtTgBc2sCskW4j1V8uua1ZZRlAkVBydeUSvVu51ZRJ0mqTMc+A7Jl9EzSHggs2QF
	 8Q4MzQgF/ueScYCBTmSNlNNd4HptVvSavBrqml5LoE168NWVPAtFsBFFEs05Wpylyh
	 TdgQlxN/ZlRdOslZHmYHSUT0HKc50/A76qnRBjUfOd5ZRjMCJ/m/QPIdceV/wmV+JJ
	 SeTbgDhh7N4IAGGEaWMdb44GQ/5EkSTW3cVeRjBDjQM6c1CxbqSDnqfy6o59BXEp5r
	 ZpRbyLmiYJM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] cxl/hdm: Add BI coherency support for endpoint
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260615145529.13848-4-dave@stgolabs.net>
References: <20260615145529.13848-4-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:32:07 +0000
Message-Id: <20260615173208.406371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds stack read causing information leak when interleave =
ways > 8
--

commit 9868ecd56176bc1d5132787a81a79aa48ca7bada
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/hdm: Add BI coherency support for endpoint decoders

This commit caches the HDM decoder's Supported Coherency Models on struct
cxl_hdm. It consults this during region attach and defaults target_type
appropriately for uncommitted endpoint decoders.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..4a41cde9fdba7 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -1042,12 +1052,20 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +			struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> =20
>  			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> +			 * HDMs that advertise support for both coherency
> +			 * modes (CXL_HDM_DECODER_COHERENCY_BOTH) default to
> +			 * host-only here; the region attach path will switch
> +			 * target_type to device-coherent if the region's
> +			 * root decoder has the CFMWS BI bit set. Only HDMs
> +			 * that strictly support device-coherent mode default
> +			 * to HDM-DB.
>  			 */
> -			if (cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM)
> +			if (cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM &&
> +			    cxlhdm->supported_coherency !=3D
> +			    CXL_HDM_DECODER_COHERENCY_DEV)
>  				cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;
>  			else
>  				cxld->target_type =3D CXL_DECODER_DEVMEM;

[Severity: High]
This is a pre-existing issue, but does the later switch decoder initializat=
ion
in init_hdm_decoder() read out-of-bounds stack memory when interleave_ways
is greater than 8?

If a device advertises up to 16-way interleave, the target mapping loop
reads past the 8-byte target_list union:

drivers/cxl/core/hdm.c:init_hdm_decoder() {
	union {
		u64 value;
		unsigned char target_id[8];
	} target_list;
	...

	if (!cxled) {
		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
		target_list.value =3D (hi << 32) + lo;
		for (i =3D 0; i < cxld->interleave_ways; i++)
			cxld->target_map[i] =3D target_list.target_id[i];

		return 0;
	}
}

Can this loop copy up to 8 bytes of uninitialized stack memory into
cxld->target_map, which might then be exposed to unprivileged userspace
via the world-readable target_list sysfs attribute?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615145529.1384=
8-1-dave@stgolabs.net?part=3D3
