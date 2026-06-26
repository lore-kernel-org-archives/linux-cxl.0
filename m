Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1831A3160
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471374; cv=none; b=H5kaTdeq0xacfCy0rlWrJQW1SV1YjiGNq/T8FrNBzvmOHLHGFHTvO1M5SFUuEcawFX0ZgKW5FOveZMeldmGAVM0b8CULQjEW9Drw9JVqVF8T9Kdpf1jrLtcJa/31JzgXTi/HjbIVNxUjlJErsb6oeaAtN7SKJmvL1mo251QNDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471374; c=relaxed/simple;
	bh=j9BjLFkFaYJRCNDikwMBuAXpc+hDC4/W66fj+sZQ7GE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kTIicVi5e+zmVcznxlWxnmtquNrG1VHYjYXVGUZH1eOYyLGvYqBlCaGvCf9qGWAJL4SU22CyPvlyp1GIjjD3Qm8+wDtVe1ejJVOHNo5WRQLscYyUwPhlRbh8KajxI/pukJ8hwoCpS8YjhxqNSI07dnKzYZlnP3ULFZXvgNjCZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGVLaaKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGVLaaKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CB81F000E9;
	Fri, 26 Jun 2026 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471372;
	bh=yGprJ7wpKCLRjJD7E0ZH1Wgop1Jd8GdA7Yvs1hqqrXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGVLaaKyZ5FrWFUzTN397IhQhfwOsWQ5WEZISKdGYrKerdQ6EEuvwXc4Cbcyo5MWV
	 HbRKYSVGNqh6ZnigzPRXWJNeN02Mp9fHh+mOlOc41N4b/4GrlU5cAY8aXO5wXGPTEt
	 x+rePwn1FVdsXRuaIevzPJ6cxAWrTu31Bi7Ho5ctlW1DpO/bDAFKMYENydSAexlf0t
	 UnE8vJAnycywy0rVwaEhF2LieukpjB5li03TiFugfHBrnZyBZkcULBjv8POM9kBB9B
	 PqG2Bcv1eOOKiGw9X//t3+ep1/pRSFPHWzExHkK/Pe6ZLYQ0npn36vsup9mdgCTBIn
	 T7pGoA8klnGbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] cxl/features: Reject Set Features output buffer
 smaller than the header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260626104102.53892-3-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 10:56:11 +0000
Message-Id: <20260626105612.B7CB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing validation of the user-provided `in_len` parameter all=
ows a `ZERO_SIZE_PTR` dereference and severe out-of-bounds reads in the CXL=
 FWCTL driver.
--

commit 149380dfe9472c578ca9fd76d4e5bb0c5ac85c19
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject Set Features output buffer smaller than the header

cxlctl_set_feature() sizes its output buffer from the user's
fwctl_rpc.out_len but never checks it is large enough to hold even the
fwctl_rpc_cxl_out header. With out_len =3D=3D 0 , kvzalloc() returns
ZERO_SIZE_PTR, which passes the !rpc_out check, the subsequent
rpc_out->size =3D 0 then writes through the poison pointer.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 9c714ee42a411..ed18ccb5e236e 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -520,6 +520,9 @@ static void *cxlctl_set_feature(struct cxl_features_s=
tate *cxlfs,
>  	flags =3D le32_to_cpu(feat_in->flags);
>  	out_size =3D *out_len;
> =20
> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload))
> +		return ERR_PTR(-EINVAL);
> +

[Severity: Critical]
This is a pre-existing issue, but missing validation of the user-provided
in_len parameter allows a ZERO_SIZE_PTR dereference and out-of-bounds reads.

If a malicious user passes in_len=3D0 to the FWCTL_RPC ioctl, kvzalloc(0)
returns the ZERO_SIZE_PTR constant (0x10) in
drivers/fwctl/main.c:fwctl_cmd_rpc():

	void *inbuf __free(kvfree) =3D kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT);

The driver unconditionally dereferences this pointer in
drivers/cxl/core/features.c:cxlctl_fw_rpc():

	const struct fwctl_rpc_cxl *rpc_in =3D in;
	u16 opcode =3D rpc_in->opcode;

Also, if a user provides a small in_len but specifies a massive op_size in
the command header, handlers like cxlctl_set_feature() will read out of
bounds of the kvzalloc'd heap buffer and transmit that data to the hardware
mailbox:

	data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);
	rc =3D cxl_set_feature(cxl_mbox, &feat_in->uuid,
			     feat_in->version, feat_in->feat_data,
			     data_size, flags, offset, &return_code);

Should there be validation of in_len before casting and accessing the input
buffer, as well as a check to ensure rpc_in->op_size does not exceed in_len?

>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
>  		kvzalloc(out_size, GFP_KERNEL);
>  	if (!rpc_out)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626104102.5389=
2-1-icheng@nvidia.com?part=3D2
