Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF028C2BF
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172328; cv=none; b=bKKXXonea4d9h3fAFZqdiHUThPIt9SRn592FOe2weYBpTPfdUshHL1wMiHxY6HvtKj7HE0eNKDSDD+GF8bHg8tDXzxEz5JBTFcBqkvBm7PYV9MeT4U59J0dy+vMgZYMMSXsDbaUwX1uuoFEvVOMU9YXDKhp9iZk8KgUtenxifTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172328; c=relaxed/simple;
	bh=a9frhMzxPI5jVMOyV/KO75nCkj7UROAodNAAuoFZKH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GIXPaOfQEr1NDPBw0UmBGDmZ6hqUtfXNn/fPzNqws5ahvX2ujoKi6U8SZHH7KkUH+eoJOJ7q95BcM6kjvA21ta/ZbnNQcO/fS20cIw38X3wBUUY2m1nZrVgR1+vAfWILOYV8qVPBFxdId3W3s7ajZ1UHcEere/ctH4e8M/EryzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBrl75R+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBrl75R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB3A1F00898;
	Thu, 11 Jun 2026 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172327;
	bh=ro6A90ugR0tc/tSK+xIhiMrJqGgNeX4niy8LmkWa0hE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBrl75R+lCOj1I8nu8dOHM2gJQeEVxP3G4NdOxF5fuO21PERAw3OKLtISzSr3c2/V
	 mjWdUfPJ3wRgU3gsa/zJrRZVL92rMPt2keDwOLROzNhzXxCq7HNMV8u1a396MMTeKx
	 nD2z33hS8gz+ZyqBqGlleRyhCxjkytVjPNcXNnoiJXaBeo7dsjP4iOQMLaRj3vhMLs
	 LgNHb2fZiyTcilX9Wn8Vi1jvp7Mf4T9hpPAd82WO7gLGeiNah5wII0dOd49Brlp5ZN
	 0at6zXuvyKtkc6TmKSOumDPVHauEnBb2Vy9fKIl3ysf5TFSucnfU8gKUnKbs/EyPS5
	 1v/k3sHbEZibw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/features: Bound Get Feature read count to the
 output buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611094944.31638-1-icheng@nvidia.com>
References: <20260611094944.31638-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 10:05:26 +0000
Message-Id: <20260611100527.1EB3A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of validation for the user-provided `in_len` allows a ZERO_SI=
ZE_PTR dereference and out-of-bounds heap reads.
- [High] Missing `out_size` boundary check in `cxlctl_set_feature()` allows=
 a ZERO_SIZE_PTR dereference or out-of-bounds heap write.
- [High] Stale `mbox_cmd.size_out` in `cxl_get_feature()` loop allows a dev=
ice-to-host heap buffer overflow.
--

commit f6369408ffb978129833c743acee0df13ef51058
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Bound Get Feature read count to the output buffer

This commit adds bounds checking to cxlctl_get_feature to ensure the
requested read count does not exceed the available payload room in the
output buffer. It prevents an out-of-bounds write when allocating the
buffer via kvzalloc.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 3435db9ea6b11..3f949225da6de 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this, I
noticed a pre-existing issue with the validation of the user-provided
in_len.

In drivers/fwctl/main.c:fwctl_cmd_rpc(), inbuf is allocated using the
completely user-controlled in_len:

    void *inbuf __free(kvfree) =3D kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT=
);

If in_len is 0, kvzalloc returns ZERO_SIZE_PTR.

Then in drivers/cxl/core/features.c:cxlctl_fw_rpc(), the code blindly
dereferences rpc_in without checking its size:

    const struct fwctl_rpc_cxl *rpc_in =3D in;
    u16 opcode =3D rpc_in->opcode;

Furthermore, command handlers like cxlctl_set_feature() trust the embedded
rpc_in->op_size field to determine how much data to copy:

    data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);
    rc =3D cxl_set_feature(cxl_mbox, &feat_in->uuid, ... feat_in->feat_data,
                         data_size, flags, offset, &return_code);

Without validating that rpc_in->op_size <=3D in_len, could this allow a sma=
ll
in_len combined with a large op_size to read past the end of the inbuf
allocation and leak kernel heap memory?


[Severity: High]
This is a pre-existing issue, but I noticed another similar missing
boundary check.

While this patch fixes the boundary check for cxlctl_get_feature(),
cxlctl_set_feature() derives out_size directly from the user-controlled
*out_len and passes it to kvzalloc():

    out_size =3D *out_len;
    ...
    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
        kvzalloc(out_size, GFP_KERNEL);
    if (!rpc_out)
        return ERR_PTR(-ENOMEM);
   =20
    rpc_out->size =3D 0;

If out_len is 0, kvzalloc can return ZERO_SIZE_PTR which bypasses the
!rpc_out NULL check. Would the subsequent rpc_out->size =3D 0 dereference
ZERO_SIZE_PTR and cause a panic?

Additionally, if out_size is very small (like 4 bytes), could setting
rpc_out->retval (at offset 4) write past the allocated buffer?


[Severity: High]
This isn't a bug introduced by this patch, but I found a pre-existing
issue in the cxl_get_feature() loop.

In drivers/cxl/core/features.c:cxl_get_feature(), mbox_cmd.size_out is
assigned the loop-invariant size_out instead of the correctly bounded
data_to_rd_size:

    mbox_cmd =3D (struct cxl_mbox_cmd) {
        .opcode =3D CXL_MBOX_OP_GET_FEATURE,
        .size_in =3D sizeof(pi),
        .payload_in =3D &pi,
        .size_out =3D size_out,
        .payload_out =3D feat_out + data_rcvd_size,
        .min_out =3D data_to_rd_size,
    };

In the final iterations of the loop, the remaining space in the host buffer
(data_to_rd_size) may be strictly less than size_out. Because
mbox_cmd.size_out is not updated to data_to_rd_size, the lower-level
mailbox driver permits the device to return up to size_out bytes.

If a CXL device returns more bytes than the requested data_to_rd_size,
could memcpy_fromio() write past the end of the feat_out buffer, causing a
device-to-host heap buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611094944.3163=
8-1-icheng@nvidia.com?part=3D1
