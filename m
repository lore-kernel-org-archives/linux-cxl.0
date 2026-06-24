Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69B2745E
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309926; cv=none; b=KaZGrWceMs662tnDPNFaIuFR/uRXFf9Yc45rTdiTJPNo+yOmEQ8sM9KkIHT+6OAWu1h6ipljw3dzzFIXbeCI+4MdIGHRHBQTZP/EYSGOtqLExiFVNCPamSvXtxfpvFyQDUW8J65ARhKC+mYC87UFoeaAN1gkiWatk6YIoAKwQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309926; c=relaxed/simple;
	bh=t6GPcAdseKntWi4Ev1KUVpuowUYib2t6d6+hKWkZiDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BWCZm10FY6uTn898CFs3kvIUlTQXtJPWM55JKvE7qKemNJ2ljCL4bVynKV19U72yX81k2aArzprZK8oQD4XOdheYs7+ntYTmaa/754NGZD5RKk07zl9A7km7xq9FzzGpmRfS72zLqOwXMSV/DbPGDDHWFN7UYqa/bXTKEc21kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOznApt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOznApt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354071F000E9;
	Wed, 24 Jun 2026 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782309912;
	bh=JjdttOfqEe2KMZoy9Gqv/NCXhfoc84VyeysPsvAeZQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OOznApt31lJVPNkUHib7yFTyEsIJUnn43fRnOYRWPy7PuvF7Y6JJ971Eh2y5G2O9X
	 78oHJ1qFdxKJ95T9UJhG1L9FGC0vCXTQ1wmKuxilWTm8OdWayTcA51U143AooDPWGL
	 Wl2IjAEK0pskxETHuaYzbJGPYManpsQYcza4OjxHGwfpA1oinyD9MW80AHXJsooI+k
	 Tuip5mvFFYj/dyDOxfBIDvGriC0M7TAyZdAPVNjUbglQcK6QTlzqTII7G8h8a5R9MG
	 G+KzGXXL0tsdDqRa1i6lyFsoIM/YXDK/BS5fIoP3WWjJb074AInsjts7euibBpzWMJ
	 FWhGoJyINTCiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than
 the output buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260624134737.49166-1-icheng@nvidia.com>
References: <20260624134737.49166-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:05:11 +0000
Message-Id: <20260624140512.354071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `out_len` bounds check in `cxlctl_set_feature()` leads to =
heap out-of-bounds write or `ZERO_SIZE_PTR` dereference panic.
- [High] Missing `in_len` bounds validation across all CXL fwctl handlers a=
llows triggering a kernel panic or reading arbitrary kernel heap memory int=
o CXL devices.
- [High] A malicious or malfunctioning CXL device can trigger a heap buffer=
 overflow in `cxl_get_feature` by returning more data than requested in sub=
sequent iterations.
--

commit 2b1a2543e64d377118a202ab8f46bc2a74fccabb
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject Get Feature count larger than the output buffer

cxlctl_get_feature() sizes its output buffer from the user's
fwctl_rpc.out_len, but the device is told to write
cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
separate user-controlled value. Nothing bounds count against out_len, so
a small out_len with a large count overflows the kvzalloc()'d buffer.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..9c714ee42a411 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_=
state *cxlfs,
>  	if (!count)
>  		return ERR_PTR(-EINVAL);
> =20
> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> +		return ERR_PTR(-EINVAL);
> +
>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
>  		kvzalloc(out_size, GFP_KERNEL);
>  	if (!rpc_out)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like
cxlctl_set_feature() might have a similar missing out_len bounds check.

If a user specifies a very small out_len (e.g., 0) for the fwctl rpc ioctl
with cxlctl_set_feature, could this cause a zero size pointer dereference or
a heap out-of-bounds write?

drivers/cxl/core/features.c:cxlctl_set_feature() {
    ...
    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
        kvzalloc(out_size, GFP_KERNEL);
    ...
    rpc_out->size =3D 0;
    ...
}

[Severity: High]
This is a pre-existing issue, but does cxlctl_fw_rpc() need to validate
in_len before dereferencing the input pointer?

If in_len is 0, would reading the opcode cause a kernel panic?

drivers/cxl/core/features.c:cxlctl_fw_rpc() {
    ...
    const struct fwctl_rpc_cxl *rpc_in =3D in;
    u16 opcode =3D rpc_in->opcode;
    ...
}

Additionally, in cxlctl_set_feature(), data_size is derived from op_size
rather than the actual in_len:

drivers/cxl/core/features.c:cxlctl_set_feature() {
    ...
    data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);
    ...
}

Could this lead to an out-of-bounds read of the kernel heap in
cxl_set_feature() if the user provides a maliciously large op_size?

drivers/cxl/core/features.c:cxl_set_feature() {
    ...
    memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
    ...
}

[Severity: High]
This is a pre-existing issue, but can a malfunctioning CXL device trigger
a heap buffer overflow in cxl_get_feature()?

The size_out capacity is calculated once before the loop:

drivers/cxl/core/features.c:cxl_get_feature() {
    ...
    size_out =3D min(feat_out_size, cxl_mbox->payload_size);
    ...
    while (data_to_rd_size > 0) {
        ...
        mbox_cmd.size_out =3D size_out;
        ...
    }
}

If feat_out_size is larger than the payload size, and the hardware returns
more data than data_to_rd_size in the final iteration, will this overflow t=
he
feat_out allocation since the remaining space at feat_out + data_rcvd_size
might be smaller than size_out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624134737.4916=
6-1-icheng@nvidia.com?part=3D1
