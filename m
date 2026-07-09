Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2F4307B3
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613300; cv=none; b=MoFzm0uz1ysDExHQiyzKUlmKBjAU4S76dKJqXe+rWGeAVbABLmELmngBAeTi1Anp6Us+PEVP/h0HowakUkIMKeSHuYRdF5TNu3pcBdIV4HcHsZhMKfykZagO+OqwiMmp4kVYbW5AgQgKYDYNNxC+kjPUxD6w8pkhD78TnobwPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613300; c=relaxed/simple;
	bh=U00sLgBf4jPU9VHvYB1GW3GPPaMJfJV2jD+VmhNbizE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XnD1f5TYB2iPXQ6ApT7aNZy9VwXgYeAFBz/UL2+0txnytzYmN9D55wyJ2JRCae5+pd5eTep9c52NDjLY1TS3c8cxtZxI+68KwuAQ3JcUM4EOdDoXZaAeDLUf3NBbL65W6XDKrmJAOXZvwFYgDU/NWT9eTAOGqAZNXQMH5VNfipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4WiIiQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4WiIiQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C25B1F000E9;
	Thu,  9 Jul 2026 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613296;
	bh=MHYGrfD6bz7pzFV7BA6Ziix03BKEs1Qf8jgzmhisZks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4WiIiQ4HwiZ+YnUWcWJELn9KXZZB2YdxGcQGUjvn9B/jjJuecXA+e0QimXRG+0iQ
	 nNmD4uHYHEDalhrm92Sn6m4QFhSGRjr0gGoGn7y+uY1hs6ioyJZwpRG5+JY9VRvCYa
	 pVJCtUIUUmqk5MSVGL67KjYSt+UELBTS6bCxKo+vom/8vBaIuZr/VeXlOVjn+J2WGT
	 V2zZNFEom7GPduMvPw6L6faCGvSqkJO9NhqnmPmiP9BKbWQ7VaF6b4oDd+IEGmLUA+
	 pUxFWBGqcSPtntlnovV8eL8PdvlWD5t4wX1smvgJh6SJw+kMeqtUHwkHGsJGGm6Eni
	 Au9r2Vt3ryfqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/features: Serialize multi-part Get/Set Feature
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709155841.1895915-1-dave.jiang@intel.com>
References: <20260709155841.1895915-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:08:15 +0000
Message-Id: <20260709160816.6C25B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Buffer overflow in `cxl_get_feature()` due to static `size_out=
` usage in multi-part transfers.
--

--- Patch [1]: [PATCH] cxl/features: Serialize multi-part Get/Set Feature t=
ransfers ---
commit a8495b40ab103b124442f90daa5b684383d16566
Author: Dave Jiang <dave.jiang@intel.com>

cxl/features: Serialize multi-part Get/Set Feature transfers

This patch introduces a per-mailbox feat_mutex to serialize multi-part
Get and Set Feature payload transfers. This ensures that concurrent accesses
from fwctl and EDAC paths cannot interleave parts and corrupt the device's
transfer context.

Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.c=
om?part=3D1
Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..85d6bcdc360ef 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  	size_out =3D min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection =3D selection;
> +
> +	guard(mutex)(&cxl_mbox->feat_mutex);
>  	do {
>  		data_to_rd_size =3D min(feat_out_size - data_rcvd_size,
>  				      cxl_mbox->payload_size);

[Severity: Critical]
This is a pre-existing issue, but does this static size_out assignment risk
a buffer overflow on the final iteration?

In cxl_get_feature(), mbox_cmd.size_out is assigned the initial size_out
value on every loop iteration, rather than the dynamically bounded
data_to_rd_size:

		mbox_cmd =3D (struct cxl_mbox_cmd) {
			.opcode =3D CXL_MBOX_OP_GET_FEATURE,
			.size_in =3D sizeof(pi),
			.payload_in =3D &pi,
			.size_out =3D size_out,
			.payload_out =3D feat_out + data_rcvd_size,
			.min_out =3D data_to_rd_size,
		};

If the hardware returns more bytes than requested on the final iteration,
could the transport use this larger size_out bound to copy past the end of
the feat_out buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709155841.1895=
915-1-dave.jiang@intel.com?part=3D1
