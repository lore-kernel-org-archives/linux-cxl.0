Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB143A7F1
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252395; cv=none; b=lGcIUz0REnzh2Bg9bCYd5T4UCl/R7V7kXeI5x3RbpKKLwgjRC5wnuC1Ma1QsCCum8pQfWYBu/kic4nzwLR0U+iFnUUaHwa0auRDvmmQsFs90MQnCTMb0F90n0HeuX2I8NaeuJxi7IqseLS5kxv+PdvVnOXApSdr+t+X9f9BQjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252395; c=relaxed/simple;
	bh=APJnB71NtQLz5/zBZCtmxGmzUfGNReLaXbVrIi1P5JQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcOWQIRXTHJvynJmkL/6HA5biY1ObtmUh4en6FF/DElJR+K2TxLvNM3Yf1dN7EcjW6P9jdcyk11w4jGO4aCGeJ+6yJMGQtUR534n96/RFnQG10YeKU+m6oWRHx547wow5gJeZyOwBfbar3xYpvdZEdkJEKIBWqSDDXXuALkaDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Na8LFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Na8LFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B91F00A3A;
	Tue, 28 Jul 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252394;
	bh=gza1FrI+Jp5q3zrbGlToVkEdvtbzrFN/UxzGIk+vcsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A/Na8LFcUoeXtpt96ubppWVLH3nfupLWVBhBEvROd5umpuTh883hoKT800FkREQX0
	 dqh2JFec7z45uXxVqs8iGPLgjlrEV+91m2OZ/7I6jWaPseKz4pDhfPywVtr8d01y8U
	 uzPWchMcRwmDn9dYuQCR31mozvhE5wDHBQn72bPyj4qgn3zlwTn+qPJHUbM62P9ljD
	 ui72aVdcxd8qt2NVb0eoVr9p2ME2pdtTaCdn0F6AZag+8XidKUjK59si/yw7wzQVxF
	 a+BTCi9QwUDE+2zVVhcIol/78JjDNuslK/lf6DQJYlHr2eI5fZLqBJu7Hm0BoFyjOW
	 qbspdtFG1rPMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] cxl/hdm: Add BI coherency support for endpoint
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260728144136.709882-4-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-4-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:26:33 +0000
Message-Id: <20260728152634.1E1B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack out-of-bounds read when parsing HDM decoder target li=
sts with interleave_ways > 8.
--

--- Patch [3]: [PATCH v7 3/8] cxl/hdm: Add BI coherency support for endpoin=
t decoders ---
commit b9f3e30d3fbbe54161183f25487d1176310fc0eb
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/hdm: Add BI coherency support for endpoint decoders

This commit caches the HDM decoder's supported coherency models on struct
cxl_hdm. It also uses this to default the target_type for uncommitted endpo=
int
decoders and blocks support for pre-committed decoders with the BI bit set.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..9da8aa2116095 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1040,17 +1063,7 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		port->commit_end =3D cxld->id;
>  	} else {
>  		if (cxled) {
> -			struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> -			struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> -
> -			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> -			 */
> -			if (cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM)
> -				cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;
> -			else
> -				cxld->target_type =3D CXL_DECODER_DEVMEM;
> +			cxld->target_type =3D cxled_default_type(cxled);
>  		} else {
>  			/* To be overridden by region type at commit time */
>  			cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;

[Severity: High]
This is a pre-existing issue, but looking further down in init_hdm_decoder(=
),
is there a risk of a kernel stack out-of-bounds read?

When parsing HDM decoder target lists for a switch decoder, the loop uses
cxld->interleave_ways as the upper bound:

	union {
		u64 value;
		unsigned char target_id[8];
	} target_list;
=09
	...
=09
	if (!cxled) {
		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
		target_list.value =3D (hi << 32) + lo;
		for (i =3D 0; i < cxld->interleave_ways; i++)
			cxld->target_map[i] =3D target_list.target_id[i];

		return 0;
	}

Since the target_list union is fixed at 8 bytes, if a CXL switch device
presents an interleave_ways value greater than 8 (such as 12 or 16), could
this loop read up to 8 bytes of adjacent kernel stack memory into
cxld->target_map?

Because this mapped array is subsequently exposed to user-space via the
target_list sysfs attribute, could this allow unprivileged users to leak
stack canaries or kernel addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144136.7098=
82-1-dave@stgolabs.net?part=3D3
