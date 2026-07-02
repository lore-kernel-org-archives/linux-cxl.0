Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05653ECBCF
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991343; cv=none; b=iV16ISPV6oDhO9MjuD1o3goDQqz45ZIrrA/zPQPS4fZov9Sr3QwUOtHnKRJtUBJJpJTOY8gOS79igyLrMIoKyyr28SI3kVUd5LorQ107nEle2rPLHVxROa38B0ASltkllB705XyyZ8wwU7+d+F2aWIhVQ8dz76xHzUkWW9eCs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991343; c=relaxed/simple;
	bh=KSYZjkv9MJwIuDA81SVTULwQ9mZDj420rH/GpCyOpYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6c0w9iFWOMSzUfG2eOBjkQfa3lHWNhBVomHTOMwcV+2fciM4sQlFZno7YtTN3M7jfmHTIhcuOvQjWf4aAIn+H4d+5NbU2nSH3ENTxVZADdSQba5DlqAOd22vujzM+a/cSoTplGskyFfR4aVKzyTegyZK4Lq99qU/K+hfwy3FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXFNQNMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXFNQNMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BE41F000E9;
	Thu,  2 Jul 2026 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782991342;
	bh=DMgbAtof6qPkHr8/QRoZsUOsn78ks4NYfmqoDeLhipg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXFNQNMVfkc31rsgu+4z25VKMDecRu49nKUmZnhQ0mggOZKmGnRzB/9ELjfecCwIT
	 sU9HkzfJZHhyWtM3O93PL8t+jsDUbWLJOe318wDMsynySWyLYVEbaJofUj7c9nedxQ
	 c9BswDUtsWWM9xwiGwUu5JPtfyP7fSJk4P4ulRwvGG/Uny38pmOH9UsPyAmg+bwaQQ
	 v5sHk2OI0CJkS3TCNFyfHUBaIcdHGWqCIeVA7/0SHXCYMfVcwX/epZ4ewckv569e89
	 eeRL2Vv4+3Mz5Rax8Yth16tvIDDOUMFe/GkEcThCwbFQgQFW4uhOS9U5JcJBrab9om
	 MxhGNuF27JHHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] cxl/features: Reject feature offset that
 overflows 16-bit field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260702090849.47501-2-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
 <20260702090849.47501-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 11:22:21 +0000
Message-Id: <20260702112221.D1BE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced boundary checks contain an off-by-one arith=
metic error that wrongly rejects valid CXL mailbox commands, preventing acc=
esses up to the exact 64KB maximum boundary.

Pre-existing issues:
- [High] Heap buffer overflow in `cxl_get_feature` due to re-using a consta=
nt `size_out` for multiple mailbox commands, which can exceed the remaining=
 buffer space if a device returns more data than requested.
- [High] In `cxlctl_get_feature()`, the output buffer `rpc_out` is allocate=
d based on user-provided `*out_len`, but the function copies `count` bytes =
into it without validating that the buffer is large enough.
- [High] `cxlctl_fw_rpc()` and its command handlers blindly read from `inbu=
f` (sized `in_len`) without validating that `in_len` is large enough to con=
tain the structures and payload specified by `rpc_in->op_size`.
- [High] Multi-part CXL mailbox feature transfers lack serialization, leadi=
ng to interleaved commands and hardware state corruption.
--

commit 85b87615c810272287769d45a80ec38b15c23133
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject feature offset that overflows 16-bit field

cxl_get_feature() and cxl_set_feature() build the mailbox command's
offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
check the sum fits in the 16-bit field. Via fwctl, a user-supplied
offset plus count/op_size summing over 65535 silently wraps, steering
the device to the wrong feature offset.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..c3d5f88a4e045 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  	if (!feat_out || !feat_out_size)
>  		return 0;
> =20
> +	if (feat_out_size > U16_MAX - offset)
> +		return 0;
> +

[Severity: Medium]
Will this off-by-one arithmetic error reject valid boundary cases?

If a caller requests a full 64KB transfer (offset=3D0, size=3D65536) or a 1=
-byte
transfer at the highest offset (offset=3D65535, size=3D1), both evaluate as=
=20
greater than 65535 (U16_MAX) and will incorrectly fail this check.

Should this check be feat_out_size > 65536 - offset instead?

[Severity: High]
This is a pre-existing issue, but can this function overflow the heap buffe=
r?

Looking at cxl_get_feature() in drivers/cxl/core/features.c, if
feat_out_size requires multiple iterations and the remaining capacity on the
final iteration is smaller than the statically computed size_out,
mbox_cmd.size_out is incorrectly assigned size_out instead of the dynamical=
ly
bounded data_to_rd_size:

drivers/cxl/core/features.c:cxl_get_feature() {
	...
	do {
		data_to_rd_size =3D min(feat_out_size - data_rcvd_size,
				      cxl_mbox->payload_size);
		...
		mbox_cmd =3D (struct cxl_mbox_cmd) {
			...
			.size_out =3D size_out,
			...
		};
		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
		...
	} while (data_rcvd_size < feat_out_size);
	...
}

If a hardware device responds with more bytes than the final chunk requires,
will the mailbox subsystem write up to mbox_cmd.size_out bytes and overflow
the remaining space in feat_out?

[Severity: High]
Also a pre-existing issue, but does this multi-part transfer lack
serialization?

Since the global mbox_mutex is dropped between loop iterations inside
cxl_internal_send_cmd(), if two threads concurrently initiate feature
transfers, will their mailbox commands unpredictably interleave and corrupt
the CXL device's multi-part transfer state machine?

>  	size_out =3D min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);

[ ... ]

> @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
> +	if (feat_data_size > U16_MAX - offset)
> +		return -EINVAL;
> +

[Severity: Medium]
Does this bounds check also wrongly reject valid boundary limits?

Similar to cxl_get_feature(), if feat_data_size + offset equals 65536,
it evaluates as greater than 65535 (U16_MAX) and fails.

Would changing this to feat_data_size > 65536 - offset permit exact
maximum boundaries?

[Severity: High]
This is a pre-existing issue, but are multi-part transfers lacking
serialization here as well?

If two threads concurrently initiate feature transfers, will their INITIATE,
CONTINUE, and FINISH mailbox commands interleave because a higher-level lock
isn't held across the loop iterations?

>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =3D
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does cxlctl_get_feature() have a heap
buffer overflow when writing to rpc_out?

drivers/cxl/core/features.c:cxlctl_get_feature() {
	...
	out_size =3D cxl_get_feature(cxl_mbox, &feat_in->uuid,
				   feat_in->selection, rpc_out->payload,
				   count, offset, &return_code);
	...
}

If a user issues the fwctl ioctl with a small out_len but a large
get_feat_in.count, cxl_get_feature() is instructed to write count bytes into
the buffer allocated for out_len. Can this lead to memory corruption?

[Severity: High]
This is a pre-existing issue, but does cxlctl_set_feature() perform an
out-of-bounds read?

drivers/cxl/core/features.c:cxlctl_set_feature() {
	...
	data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);
	rc =3D cxl_set_feature(cxl_mbox, &feat_in->uuid,
			     feat_in->version, feat_in->feat_data,
			     data_size, flags, offset, &return_code);
	...
}

If a user provides a valid but small in_len (e.g., just enough for the
header) but sets a large op_size inside the CXL payload header,
cxlctl_fw_rpc() blindly reads data_size bytes past the end of the inbuf
allocation. Could this leak kernel memory to the hardware device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702090849.4750=
1-1-icheng@nvidia.com?part=3D1
