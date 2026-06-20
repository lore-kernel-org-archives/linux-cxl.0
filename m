Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B240D57C
	for <linux-cxl@vger.kernel.org>; Sat, 20 Jun 2026 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930699; cv=none; b=O/Rt1qJdgdVfDKkNT7/3t7DymUIU0cxVpN4y4zr1ALF7eYn7eDKXvA9gH6Bj4+jyAkegFHKEWsAd4/0R26eUHqO8iXvukj59SxMs2DLBfkl74SmOPPqUdeYaV1MkNSAMTYK9zrDQZNNZfGsSP67rGFyxfYtzeMPTBQuZgXYjk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930699; c=relaxed/simple;
	bh=UI1XRwMB5OkgVMO+NTEh/LcxtHsr25jWkeDBfGNaKaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e7M3x4Xwu28p0wq4451q10755+2V+p7KXTUEQI5wKxREilWh1/bPXSowR828JjWqMrvtBwI5iRpg5ix7u79eFQmDp5eZsuFdtN8pDHch+TmFDAYpyJfCMshsHFmkqj80bV+iyB14dTlLSWWT9GNBnTnVByD/7Gypz5a7iKp6G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+5Y+Qxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+5Y+Qxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA851F000E9;
	Sat, 20 Jun 2026 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781930698;
	bh=h3+kKus/3HCdohCjVsJ9oFrIQQQzU0hv1zVVg21G/1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+5Y+QxedYWYnsJ1qAP7xI8A/I7loR5enLtITwIPWtbCKWsPgqpUHG4Cz2jxs0ofw
	 EZuvkKFEd+r7uI3gv8UjCzSPkEc6HoU7D6boKsHFKld+AOg5+9xpZz73l0a3977IGV
	 5/sG4c4kDUwuoRlbLu26/bTLIKsLITHc6KvQSvXMT/NaGD2WssQN4Fxn0MLbzg6aoM
	 HNlkE0tGgLWUg4+Dm7bUpwS7WfxIbCbYCrY1UA3qkxThaQqEfhYnsRZfqddpPOrrWt
	 /Y4foniGGihkN5S2w3rUMgdolqDHKyTPSxHn7bmfm/YkEgLfRgmtmvWIps7nSfZYDp
	 FGAzXydp+MNYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/features: bound fwctl command payload to the input
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
References: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 04:44:57 +0000
Message-Id: <20260620044457.CEA851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] User-controlled output buffer allocation size `out_len` is use=
d without validation, leading to severe heap out-of-bounds writes or OOPS i=
n `cxlctl_get_feature` and `cxlctl_set_feature`.
--

commit 0b6168cb6d2ecfaa5cb9fc6b814d7c56cade18ef
Author: Zhenhao Wan <whi4ed0g@gmail.com>

cxl/features: bound fwctl command payload to the input buffer

This commit addresses out-of-bounds reads in CXL feature commands by ensuri=
ng
the input buffer size is sufficiently large to hold the fixed header and
payload. It rejects requests that do not fit within the copied-in buffer at=
 a
single dispatch point.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -649,7 +649,13 @@ static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, =
enum fwctl_rpc_scope scope,
>  	struct cxl_memdev *cxlmd =3D fwctl_to_memdev(fwctl_dev);
>  	struct cxl_features_state *cxlfs =3D to_cxlfs(cxlmd->cxlds);
>  	const struct fwctl_rpc_cxl *rpc_in =3D in;
> -	u16 opcode =3D rpc_in->opcode;
> +	u16 opcode;
> +
> +	if (in_len < sizeof(rpc_in->hdr) ||
> +	    rpc_in->op_size > in_len - sizeof(rpc_in->hdr))
> +		return ERR_PTR(-EINVAL);

[Severity: Critical]
This is a pre-existing issue, but since we are validating in_len here,
should we also validate *out_len?

In cxlctl_get_feature(), the user-specified *out_len determines the
allocation size but is used without verifying it can hold the structure
header and payload:

drivers/cxl/core/features.c:cxlctl_get_feature() {
    ...
    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
        kvzalloc(out_size, GFP_KERNEL);
    if (!rpc_out)
        return ERR_PTR(-ENOMEM);

    out_size =3D cxl_get_feature(cxl_mbox, &feat_in->uuid,
                   feat_in->selection, rpc_out->payload,
                   count, offset, &return_code);
    *out_len =3D sizeof(struct fwctl_rpc_cxl_out);
    if (!out_size) {
        rpc_out->size =3D 0;
    ...
}

If *out_len is 0, kvzalloc(0) returns ZERO_SIZE_PTR, which could lead
to an oops when writing to rpc_out->size. If *out_len is smaller than
sizeof(struct fwctl_rpc_cxl_out) + count, could this result in a heap
out-of-bounds write?

A similar pattern exists in cxlctl_set_feature(), where the fixed
header fields are unconditionally written regardless of the allocation
size:

drivers/cxl/core/features.c:cxlctl_set_feature() {
    ...
    out_size =3D *out_len;

    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
        kvzalloc(out_size, GFP_KERNEL);
    if (!rpc_out)
        return ERR_PTR(-ENOMEM);

    rpc_out->size =3D 0;
    ...
}

> +
> +	opcode =3D rpc_in->opcode;
> =20
>  	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
>  		return ERR_PTR(-EINVAL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-cxl-fwctl-=
oob-v1-1-5758e34d784a@gmail.com?part=3D1
