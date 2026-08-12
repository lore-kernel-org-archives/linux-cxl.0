Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC7310779
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523693; cv=none; b=MTCn21iax7ci/D/+la5BkhVtviW+j5YZ80/zwaZkBpEO0GtU3NGi3W2u3Fl9FX2rIqI7u6hExfqJcSgBzpNsvMX42GFEmSmQ1COXzX9T6Zw5kh9VHqX5IMbEx6uGEh0R+OGKJOXI71RblzartybjIp1cLl8Ki6+lvi/Pm3Pf1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523693; c=relaxed/simple;
	bh=MZ9FwUSn5DylJhcsQVLHAnrrwqyJizeEe/De9sY8Bog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fCip2QIVL6RArU+6C/+DB4070fPdWOVCviKB0UeX/Frm9d5r+d4NX+IMFaRJL6bGRLDQx09BvkJSNzflibEYkwJVUf0AmBkSq9irmX4yKzMh8L3hUv9z9Zrn54bJhXXKg+blmdqKTSzB+ozSDlVcT/tN1oCKV5M4oUOpGX+m+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6BqzbDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6BqzbDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE31F000E9;
	Wed, 12 Aug 2026 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786523692;
	bh=Q5zOXe3pfgkSJGqxZA84LdCYn7kE//iBhbmFNvVi150=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6BqzbDyoDKrje0wUhpVZ7+oELWO9zRwSlQA0FhSepzVp9N0WhRUGAR3gAjOKsyo+
	 YJgGPO+sxdTx+F7jgrLP5Gl0kwIILgIS3VQVIMTC9c/+kn+rKXoxoWkWWsFF41SOCt
	 SHr+h7ZStUjLumINsbTadZsjoGqw2SJO9VGbj6bS0l8ZX4/cZKKt3NOMKfTM4qrdgo
	 L6S15RHIVZyMp/HQ8OKiW/rwEfexaZhmyRduQViyBYGvUPlb+esR+0c7pjZDViFTyh
	 v+sMA7DmwpFKPNnfM167uAdLlC9naEKAzYfJve25t9xqEXx8x8FH9JdbEE9cww5iC6
	 d/9ISsMqVkmlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812082347.354371-1-kanie@linux.alibaba.com>
References: <20260812082347.354371-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:34:51 +0000
Message-Id: <20260812083452.47FE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between PCI error handler and port driver unbind =
can cause a Use-After-Free or NULL pointer dereference on the `cxlhdm` stru=
cture.
- [High] Concurrent non-atomic modifications to `cxld->flags` in `cxl_endpo=
int_decoder_clear_reset_flags()` can lead to lost updates and state corrupt=
ion.
--

--- Patch [1]: [PATCH v3] cxl/pci: Skip reset detection for DVSEC emulated =
decoders ---
commit c5fca0ff917fa2bd1a3438469d23f5762cfe524b
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/pci: Skip reset detection for DVSEC emulated decoders

This commit skips the reset detection check for CXL decoders emulated from
DVSEC ranges. It addresses a crash and false warnings during PCI reset when
HDM decoder registers are unused or non-existent, as these decoders do not
have a commit state to lose.

[ ... ]

> - cxld->flags is updated with a plain read-modify-write in
>   cxl_endpoint_decoder_clear_reset_flags(), while cxl_decoder_commit() and
>   cxl_decoder_reset() update the same word under cxl_rwsem.region, which
>   __commit() and the region reset paths hold across those calls. Having t=
he
>   reset handler take that rwsem too looks like the natural fix, but it
>   already holds the memdev device lock at that point, so the lock ordering
>   wants review first.

[Severity: High]
This isn't a bug introduced by this patch, but since it is discussed here, =
can
the non-atomic modification to cxld->flags in
cxl_endpoint_decoder_clear_reset_flags() lead to lost updates?

drivers/cxl/pci.c:cxl_endpoint_decoder_clear_reset_flags() {
    ...
    cxled =3D to_cxl_endpoint_decoder(dev);
    cxled->cxld.flags &=3D ~CXL_DECODER_F_RESET_MASK;
    ...
}

During a PCI reset, cxl_reset_done() calls this function which performs the
unprotected read-modify-write on cxld->flags. Concurrently, operations like
cxl_decoder_commit() modify the same flags word under the cxl_rwsem.region
lock.

Because the reset handler does not hold this semaphore, can these updates r=
ace
and overwrite each other, potentially dropping the CXL_DECODER_F_ENABLE or
lock flags and leaving the decoder in an inconsistent state?

[ ... ]

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..d8b07f86bab09 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(str=
uct device *dev, void *data)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)
>  		return 0;
> =20
> +	/*
> +	 * Decoders emulated from the DVSEC range registers have no commit
> +	 * callback and no HDM decoder registers to consult.
> +	 */
> +	if (!cxld->commit)
> +		return 0;
> +
>  	cxlhdm =3D dev_get_drvdata(&port->dev);
>  	hdm =3D cxlhdm->regs.hdm_decoder;

[Severity: High]
This isn't a bug introduced by this patch, but does this code risk a
use-after-free or a NULL pointer dereference on the cxlhdm structure?

A PCI reset (like FLR or SBR) triggers cxl_reset_done(), which walks endpoi=
nt
decoders without holding locks that would prevent the cxl_port driver from
unbinding from the endpoint port.

If the port unbinds concurrently, devres frees the cxl_hdm structure.
The device walk here in __cxl_endpoint_decoder_reset_detected() then calls
dev_get_drvdata() on the unbound port device, retrieves a dangling pointer =
to
cxlhdm, and immediately dereferences it at cxlhdm->regs.hdm_decoder.

>  	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> =20
>  	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812082347.3543=
71-1-kanie@linux.alibaba.com?part=3D1
