Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE863BE65C
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807282; cv=none; b=YmdWtO3+c3SHA/OF0QEZkLDR7uf1ndxd9mOy3OiD7VKypKbM0/JRy1aU66Gq9af6xiuCD3GST/2+T+V5S1Ij6/KtleJSFvOg62uflV3fW8g19TR43hFlfiCL8eGo0NqHefm3CsOk4OCc//JPAZbhqDS8q0HGx0xu0jTHWoI5axA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807282; c=relaxed/simple;
	bh=nUlZg7UL4Jgz3emgSKnJUl2BN+xDuW3qUDhYEmtZNOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7W+fC3s8IZVb2eLz7Gy5OWIAg/7Tl+T+Npz9MvX6ZZTMC9a3wR+BlwjdxHpgJ7il9g7rIprc0N/mrU3/AJofaIy8KjeUpNNEMF8WGeV5FN3i40Tarv9qI1uGxdEOEOSMuIiCsafwPG1TS8R3udTvHeQZgNA6Vu54XgvQpkoBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Ve+GYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Ve+GYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62231F000E9;
	Tue, 30 Jun 2026 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782807281;
	bh=X5GdBjFYdKouCTb5fUg1ZFalQ+uP7dhHLt+TjkKyih8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9Ve+GYx4ZCH9JLdg3Err7gea3MfMmM3d434TqzPucNORaf/vdg/cRhI7zZaikHfe
	 3MU3w6WSr/7H1u3a3HqWe/3XyPeAYzG1D6aGx9fLG/FITdtabSvty43zdFAJ59eIAY
	 zTz3p1IyFDE8ZPxGcHbNA6H4MLIQAdyriCHrAuI0LkXyAXReB76dHsB7NtYm7+UkcB
	 WHRvW2BdHAY/Pye88XqeYrCNnksx9ak55QmF4zw6KdrXp5DrnmvyQ7duoVbMleC2Gx
	 +5SZopmygn4shCD026C5wAiubeh9BGpZ8GJxEaqMnT75z+h6K2Ek+QvT1+ymtSQ9S9
	 dt37TKOHtT6QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] cxl/features: Reject feature offset that overflows
 16-bit field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630074657.43077-2-icheng@nvidia.com>
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:14:40 +0000
Message-Id: <20260630081440.E62231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The bounds check `offset + feat_data_size > U16_MAX` is vulnerable=
 to a 32-bit integer wrap-around on 32-bit architectures, completely bypass=
ing the validation.

Pre-existing issues:
- [High] The CXL fwctl RPC handlers fail to validate the user-supplied payl=
oad size (`rpc_in->op_size`) and structure boundaries against the actual bu=
ffer length (`in_len`), allowing out-of-bounds kernel memory reads and ZERO=
_SIZE_PTR dereferences.
- [High] `cxlctl_get_feature` lacks validation ensuring the output buffer c=
apacity matches the user-requested read count, leading to out-of-bounds ker=
nel memory writes.
- [Medium] In `cxl_get_feature`, the output buffer capacity parameter `mbox=
_cmd.size_out` is not scaled down for the final iteration, allowing a misbe=
having CXL device to overflow the destination buffer.
--

commit 5ab5a6aebf166b549e1dc9a1b5568aa38e4c661e
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject feature offset that overflows 16-bit field

cxl_get_feature() and cxl_set_feature() build the mailbox command's
offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
check the sum fits in the 16-bit field. Via fwctl, a user-supplied
offset plus count/op_size summing over 65535 silently wraps, steering
the device to the wrong feature offset.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..db5964ea184f1 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  	if (!feat_out || !feat_out_size)
>  		return 0;
> =20
> +	if (offset + feat_out_size > U16_MAX)
> +		return 0;
> +
>  	size_out =3D min(feat_out_size, cxl_mbox->payload_size);

[Severity: Medium]
This is a pre-existing issue, but in the do...while loop below this code,=20
mbox_cmd.size_out is assigned this constant size_out value:

    mbox_cmd =3D (struct cxl_mbox_cmd) {
        .opcode =3D CXL_MBOX_OP_GET_FEATURE,
        .size_in =3D sizeof(pi),
        .payload_in =3D &pi,
        .size_out =3D size_out,
        .payload_out =3D feat_out + data_rcvd_size,
        .min_out =3D data_to_rd_size,
    };

Is it possible for a misbehaving hardware device to return more data than=20
requested in the final iteration? Since the remaining buffer space=20
(data_to_rd_size) can be smaller than size_out, could this overrun the=20
feat_out buffer by up to (size_out - data_to_rd_size) bytes?

[ ... ]
> @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
> +	if (offset + feat_data_size > U16_MAX)
> +		return -EINVAL;
> +

[Severity: High]
On 32-bit architectures, feat_data_size (a size_t) is a 32-bit unsigned
integer. If a caller provides a large value like U32_MAX - 32 alongside
an offset of 65535, couldn't offset + feat_data_size wrap around modulo 2^3=
2?

This wrap-around could bypass the U16_MAX check, potentially allowing an
out-of-bounds kernel memory read in the loop below. Should this check use
check_add_overflow() or otherwise explicitly guard against wrap-around?

>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =3D
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!pi)

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at how fwctl
handles the get feature RPC in cxlctl_get_feature():

drivers/cxl/core/features.c:cxlctl_get_feature() {
	...
	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
		kvzalloc(out_size, GFP_KERNEL);
	if (!rpc_out)
		return ERR_PTR(-ENOMEM);

	out_size =3D cxl_get_feature(cxl_mbox, &feat_in->uuid,
				   feat_in->selection, rpc_out->payload,
				   count, offset, &return_code);
	...
}

The output buffer rpc_out is allocated exactly to the user-controlled length
(out_size/out_len), without verifying it can hold the requested payload cou=
nt.
If a user supplies out_len =3D 8 (just the header) but asks the device to
read 65535 bytes via feat_in->count, doesn't cxl_get_feature() write the
hardware data past the end of the 8-byte allocation?


[Severity: High]
This is a pre-existing issue, but the CXL fwctl RPC handlers appear to use
the user-supplied length fields without validating them against the actual
allocated buffer size:

drivers/cxl/core/features.c:cxlctl_fw_rpc() {
	...
	const struct fwctl_rpc_cxl *rpc_in =3D in;
	u16 opcode =3D rpc_in->opcode;
	...
}

If the incoming buffer in_len is 0, in could be ZERO_SIZE_PTR, which would
cause a panic when dereferencing rpc_in->opcode.

Furthermore, in cxlctl_set_feature():

drivers/cxl/core/features.c:cxlctl_set_feature() {
	...
	data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);
	rc =3D cxl_set_feature(cxl_mbox, &feat_in->uuid,
			     feat_in->version, feat_in->feat_data,
			     data_size, flags, offset, &return_code);
	...
}

If the input buffer is smaller than the structure size, but rpc_in->op_size
is spoofed to a large valid size, this derives data_size from the unvalidat=
ed
op_size rather than the verified in_len. Could this cause cxl_set_feature()
to copy out-of-bounds kernel memory to the hardware mailbox?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630074657.4307=
7-1-icheng@nvidia.com?part=3D1
