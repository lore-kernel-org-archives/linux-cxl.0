Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF244065C
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278909; cv=none; b=LexRt+LUHl/Sk9KnATk7RMJ8yNtlPPf89ULoj/bB61OmKTNuuY9BCBI7anExitNyUqiQUepmuaBFV17a8kuseWTjyeKMMv44ZhT5oSDI2ung5y1aos4fqpVBB8aNbRiu8DhQkVFY4SVBcg8bLcNl8j6XqHL4fyFKZAhWxfflwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278909; c=relaxed/simple;
	bh=AIitq0kWKR+YalrX7LGZ1PacK6I4lKOhKHbXWbWkjXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEM/ApCWYuh3KAVc3wWnqITdRPphqZs5UskEMFFHi2KJtuNpncEtFj1khuDBRhTKxj5u36czKMAmbYhXjOqBkhEBKvm/C7oRssFk/5qjpOT3hC0L4GkI0dp5M6bnOuuqQDNxLqbGdd4s2PetJcjzI4Sv16lsVMx4L8iDmoSrv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj0Yp9sI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj0Yp9sI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385031F000E9;
	Fri, 21 Aug 2026 02:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787278908;
	bh=gL4j76iUl0jojhU6cFjVIi9yImdokzCpCRglgZkJ7VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mj0Yp9sImtOKsb06cuzmfOLBm8Y9+6FfW4gTwtr2fEikk41+xq/tvANLJ9VUfZ230
	 TK4hU8PCZvcHOMpewWLUNtHXksYiW4DokTVLTJsyyx+DcZEfiSE0d8XPRGhTZ9yyvv
	 i+H+v3f+HMBnMbWQld0eit5RCUEPGoIXVg/qRCImaAf3cdxMu0d1XWafOwx26nBfGM
	 PV+HC07FQ+XwJdEtUOELL0V4sG/OJnj0Dw3To0IsoztDvZWf6vKnP2oRHYOSP5jwQZ
	 9l5eaanQ5tIWn6Vpr/MK3hx1AwK80JQlaY9ial35f0qISVgOT1AECS/e5ctuAclCZX
	 g6ygkMhH8suNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260821021029.2550584-1-kanie@linux.alibaba.com>
References: <20260821021029.2550584-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:21:47 +0000
Message-Id: <20260821022148.385031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing exclusion against `cxl_port` unbind in `__cxl_endpoint_dec=
oder_reset_detected()` can lead to a Use-After-Free or NULL pointer derefer=
ence of `cxlhdm`.
- [High] Unsynchronized read-modify-write of `cxld->flags` in `cxl_endpoint=
_decoder_clear_reset_flags()` races with concurrent updates.
--

--- Patch [1]: [PATCH v4] cxl/pci: Skip reset detection for DVSEC emulated =
decoders ---
commit b6f7c04ddbcccfb809033bdab75f996fc7c78db7
Author: Guixin Liu <kanie@linux.alibaba.com>
cxl/pci: Skip reset detection for DVSEC emulated decoders

This commit skips the reset detection check for decoders emulated from the
CXL DVSEC range registers, as they lack HDM decoder registers and commit
callbacks. This prevents a kernel oops when checking for a reset on these
emulated decoders.

Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linu=
x.alibaba.com/

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..d8b07f86bab09 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(str=
uct device *dev, void *data)
[ ... ]
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
This is a pre-existing issue, but could this missing exclusion against a
cxl_port unbind lead to a Use-After-Free or NULL pointer dereference of
cxlhdm?

If a concurrent sysfs unbind of the cxl_port driver occurs while a PCI
reset handler iterates over the endpoint's children in cxl_reset_done(),
the devm-allocated memory for cxlhdm could be freed and driver data cleared
before it is accessed here.

>  	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> =20
>  	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
>  }

For the pre-existing read-modify-write synchronization issue in
cxl_endpoint_decoder_clear_reset_flags():

drivers/cxl/pci.c:cxl_endpoint_decoder_clear_reset_flags() {
	...
	cxled =3D to_cxl_endpoint_decoder(dev);
	cxled->cxld.flags &=3D ~CXL_DECODER_F_RESET_MASK;
	...
}

[Severity: High]
This is a pre-existing issue, but does this function have an
unsynchronized read-modify-write of cxld->flags?

If a concurrent region setup or teardown operation occurs simultaneously wi=
th
a PCI reset, the plain bitwise update on cxld->flags in the asynchronous PCI
reset path ignores the cxl_rwsem.region semaphore used by region paths.

Could this race with concurrent updates and lead to state corruption due to
lost flag updates, potentially leaving decoders in an invalid state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821021029.2550=
584-1-kanie@linux.alibaba.com?part=3D1
