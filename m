Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381F3E8357
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547840; cv=none; b=I9EYHW/lxCQksDs3HtQKoAFAy3UMUW1VoWGw5Mb6o+M6dBFuXERpSNv22UdCeX6HaYcCWZFPdEHSGMMfqbI5D+0W8m3OeJctftOX0RCSsGIUevNeElOr+SS1Hna7nwBKa/ryzI8CWQqE8/y3kYQOgFjeken48hFk9yv69bLBX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547840; c=relaxed/simple;
	bh=u64bNQvdsthCfTByCNxEK7y3zddo9OT/+oPyI7yxbFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MnIoFXBx40gq2LuWgPGmkV5OxqH2g1SXVSCrdF/rEtqsN8Vdxu/ZtdtwiQYCakH5Dpf33TIpd5UQaCGM7wPfLfb8qi5gzmtXA8R2PGCeNxf27qDzpOR/jG1xvktln1td7hSn609SZdMvKrydYYdu3U06by7qvWKFYQnLeLCyEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW6g9NLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW6g9NLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A584A1F000E9;
	Wed,  8 Jul 2026 21:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547838;
	bh=4hDERPoCRSbFE/AHg3FQQB6GslpC4uAPmO+dSXyftt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VW6g9NLH8ox+HCjGANPGR/WpN27ZhZqxba3eqb7TCkyZ5YXe/f+C8hxFi4OrwtUSQ
	 2kchPc0SefWzXh1ykLva+Kcf8n1hUMAhM61a8vlPXpOQSxIlVIK4m6J6EX2uR+pAwF
	 20r4QYJFmhZWY8A4pA4vSC83NfLeI0U0n4uCDLDX3wsvyf+BBuGILewiTT9DWN4vDi
	 5y9MbmJZc9u/SfMosj7pe22sNuPztk7GdvukdnCQHngI7eUwwSvNXhvSKP1WV7ZAx+
	 pm/N55FfoJWpDDSbAjST55rVOk1xm5K595C+yexyG6/6Q4vSPaCBw2ZcilsmMEuSXl
	 Os8+YC4FK/hjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rana" <mayank.rana@oss.qualcomm.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708213047.267024-1-mayank.rana@oss.qualcomm.com>
References: <20260708213047.267024-1-mayank.rana@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:57:18 +0000
Message-Id: <20260708215718.A584A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete CFMWS restriction enforcement allows HDM-H commits on=
 HDM-DB only windows
--

--- Patch [1]: [PATCH] cxl/hdm: Enforce CFMWS HDM-H policy at decoder commi=
t time ---
commit b323fb5684f24e6f22174021a05686b301fd4e31
Author: Mayank Rana <mayank.rana@oss.qualcomm.com>

cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit time

This commit adds a check in cxl_decoder_commit() to enforce platform
CFMWS restrictions, rejecting HDM-DB commits on windows restricted to
HDM-H only.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -834,6 +835,19 @@ static int cxl_decoder_commit(struct cxl_decoder *cx=
ld)
>  		}
>  	}
> =20
> +	/*
> +	 * Enforce HDM-H: reject HDM-DB if CFMWS lacks CXL_DECODER_F_TYPE2.
> +	 */
> +	if (cxld->target_type =3D=3D CXL_DECODER_DEVMEM && cxld->region) {
> +		cxlrd =3D to_cxl_root_decoder(cxld->region->dev.parent);
> +		if (!(cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_TYPE2)) {
> +			dev_err(&port->dev,
> +				"HDM-DB commit rejected on %s, CFMWS restricts to HDM-H only\n",
> +				dev_name(&cxld->dev));
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +

[Severity: Medium]
Should there be a symmetric check enforcing the HDM-DB policy by verifying
CXL_DECODER_HOSTONLYMEM against CXL_DECODER_F_TYPE3?

If the BIOS incorrectly leaves an endpoint programmed as HOSTONLYMEM on an
HDM-DB only window, the kernel will auto-discover it.=20

If a privileged user subsequently uncommits and re-commits the region via
sysfs, cxl_decoder_commit() would run.

Because this check only validates CXL_DECODER_DEVMEM against
CXL_DECODER_F_TYPE2, could it silently allow a CXL_DECODER_HOSTONLYMEM
commit despite the root decoder lacking CXL_DECODER_F_TYPE3, thus violating
the platform ACPI constraints?

>  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>  		setup_hw_decoder(cxld, hdm);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708213047.2670=
24-1-mayank.rana@oss.qualcomm.com?part=3D1
