Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156E431E51
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548530; cv=none; b=utyKqNwqOerIZXdq0Y2Qwlu+9O27ppBFq6q/AfjsMCiw3df6JLVkVb8oQJO6CoViYHG/fF2itq/vm8oQnsZhgfp92SRcYVcV/PIvEDFhIwAc8WB/UEIHCtETKxLKDh5bV2QVKKpukiK63avVYReI8sWAwTUsHb5n7DwwNYw7e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548530; c=relaxed/simple;
	bh=12ycNHThQeZVSaSKux0LhSKZUfexAy+FogvI8md9ne0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQ3DRxZchhtvPhQqULUp9OcXqkTD0Rsfs3KmP1xJmlJGmC1KscayDWhyeBSoWa2UlZXUYfRjcAOABXkWS0HpHDmjoLLiAUrdZVfhCXUZ20kmJ2dx+RBKzXiybXFKPVdCn2HmUcvOonYIYFjejGvSN7sMqXSwUu7G46sH5AEQIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUtYLlF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUtYLlF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB33D1F000E9;
	Wed, 12 Aug 2026 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786548516;
	bh=zFkSpUBPZw0gJihnuwXRuAIVddqnLIbp4NbmdhCyjTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUtYLlF8SquJbrv2uXi7nc/YlOgh94kOaFfaky3rEcQIAU5aiWgujQrcr53zTr+/k
	 IF4Jn5s/uHHcXm4wyhuSiYSt3yZ7GXNAVzybsYKOJuiu/HcEMdYqCgJXzZecgYMAYl
	 aRlQtwmqARP/mqnRu0FfXBvjMH/KoqAkJ9AjFCPaRgkcg5dFgDTeEwIV6szmZV6jnM
	 b1hlrS7CpgnAO83Fj0j5uFM0yprOkXNq1h0z7xef5EhF4xDB+ox7JwAps2UI+T7I6y
	 uh0ufjjcShdtKSeygFY2PUwTyT3ivcZRvCMYYc2MhXrdmH7nJ35+lGflUHQJeZZYWN
	 62BX1ehRdJmlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/mce: Avoid alias page retirement for corrected
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
References: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:28:35 +0000
Message-Id: <20260812152835.DB33D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing CXL MCE handling for poison consumption errors on AMD ar=
chitectures.
--

--- Patch [1]: [PATCH v2] cxl/mce: Avoid alias page retirement for correcte=
d errors ---
commit efcb1cbc0f2e51e970d17decc010e02b84097870
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

cxl/mce: Avoid alias page retirement for corrected errors

This commit restricts Extended Linear Cache (ELC) MCE handling to uncorrect=
ed
memory errors. It aims to prevent needlessly reducing usable memory on
corrected or non-memory errors.

> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b2217..e3c561489a003 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, u=
nsigned long val,
>  	u64 spa, spa_alias;
>  	unsigned long pfn;
> =20
> -	if (!mce || !mce_usable_address(mce))
> +	if (!mce)
> +		return NOTIFY_DONE;
> +
> +	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> +		return NOTIFY_DONE;

[Severity: High]
Does this new check bypass CXL MCE handling for poison consumption errors
on AMD architectures?

On AMD, mce_is_memory_error() maps to amd_mce_is_memory_error(), which
evaluates to true strictly for SMCA Unified Memory Controller (UMC) banks or
legacy northbridge banks.

When a CXL poison consumption error occurs, it is logged in the consuming c=
ore
unit (e.g., Load/Store or Data Fabric) with the MCI_STATUS_POISON bit set,
which is not a UMC bank. This means mce_is_memory_error() will evaluate to
false, causing this handler to return NOTIFY_DONE and silently skip offlini=
ng
the aliased page.

Previously, relying on mce_usable_address() correctly identified these erro=
rs
since amd_mce_usable_address() checks for the MCI_STATUS_POISON bit on all
non-northbridge banks. Could this lead to data corruption or repeated machi=
ne
checks when the corrupted memory is re-accessed?

> +
> +	if (!mce_usable_address(mce))
>  		return NOTIFY_DONE;
> =20
>  	spa =3D mce->addr & MCI_ADDR_PHYSADDR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812151759.1439=
0-1-shaikhkamal2012@gmail.com?part=3D1
