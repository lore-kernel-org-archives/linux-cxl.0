Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABD3F99F4
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497541; cv=none; b=IEwPAgazOANCd0RO18Fng41/l1zpnVsc+nEXYytIw3uU64rpnbSI3SBDg0BwKz+2ja4BhV2aEGIK7v616nUAmDdtdUGVwl/icKGOw28iSdV/9yXUF8Q8H2qOfaBMkAvpZtCUMs9k1s529SEig54A6BbXayoOwA2QKjKVx+osMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497541; c=relaxed/simple;
	bh=R6oiChabr3pQD9gCSPVgSgAGsYYPtdtTxpBtt17aBQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPmhJSYg44BSNLa61YtdO7mNktOXnogmcJyQPbG8uCKMTOxjcMOZbTZYbL4xYkvoCiVyypi+X9UHYhtSzq0se7Y4vPfDB+3/vrVEpQ3rtJQdttp7909LbVn8XjrixkeKsb0hWzm6du1LR3nGfQgrf4YVCHDugL4XJgNvXOE1Kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgHAJjL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgHAJjL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEAD1F00A3A;
	Wed,  8 Jul 2026 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497531;
	bh=oeD8p2nODoFTiR6DjjWjh5RqcwkjqrOl2p84B5aM/eY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TgHAJjL8tBlPXBNq8NJU2/pyADgNmMmry/oNvzFpsJzrSnD9sj89erA4wglC8d91O
	 K0VhnD9vr9y3ObJUVG1LmGhI+q0YufPoH5kFkjGGNwMvrbXRAZ408SY7EJhQMXGrFL
	 EtSL+x71Akakcb9e9o0GZKw0mp/V4OYzC1FeyCXJj3gj36wu47NSqJRN0cKVLzaaXT
	 AqBMx3+jGb0oQ0jyzqHlLyEvNCdt70REGulqRnW5qLssyWLBiX9i8BTv4wLW5sW718
	 jVW/NE/GJsPmpoVCgyceQ+lVVKVx5GrPz5vjESIAP7t5RwQGX3JRI76k4TbupFR60x
	 xp4Mvqb2f367Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] cxl/features: Reject feature offset that
 overflows 16-bit field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708074228.43654-2-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
 <20260708074228.43654-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:58:50 +0000
Message-Id: <20260708075850.EAEAD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced feature transfer size validation incorrectl=
y rejects valid reads/writes, causing an off-by-one bounds check error.

Pre-existing issues:
- [High] Missing bounds check on user-provided `out_len` and `count` leads =
to arbitrary heap buffer overflow and potential `ZERO_SIZE_PTR` dereference=
 in `cxlctl_get_feature` and `cxlctl_set_feature`.
- [High] Missing bounds check on user-supplied `in_len` and `op_size` leads=
 to out-of-bounds heap reads and potential kernel crashes in `cxlctl_set_fe=
ature`.
- [High] Hardware-induced heap buffer overflow in `cxl_get_feature()` loop =
due to incorrect static `size_out` tracking.
- [Medium] Internal mailbox command failures mask their error codes and ret=
urn SUCCESS to the `fwctl` user.
--

--- Patch [1]: [PATCH v3 1/5] cxl/features: Reject feature offset that over=
flows 16-bit field ---
commit c16baccf7c99ea7335aa40b18d19b96e88ef46aa
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject feature offset that overflows 16-bit field

cxl_get_feature() and cxl_set_feature() build each mailbox command's
offset from the starting offset plus the amount of data already
transferred, then store it in a 16-bit field. An user-controlled fwctl
offset and transfer size can exceed the feature extent, allowing a later
offset to be truncated by cpu_to_le16() and target the wrong feature
data.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..aaa408445fd40 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,=
 const uuid_t *feat_uuid,
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
>  	if (!feat_out || !feat_out_size)
> -		return 0;
> +		return -EINVAL;
> +
> +	if (feat_out_size > U16_MAX - offset)
> +		return -EINVAL;

[Severity: Medium]
Does this logic contain an off-by-one error?

If a user requests exactly 65536 bytes at offset 0, feat_out_size would be
65536. Since U16_MAX is 65535, 65536 > 65535 - 0 evaluates to true, which
incorrectly rejects a valid read.

[ ... ]

> @@ -258,7 +261,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  		if (rc < 0 || !mbox_cmd.size_out) {
>  			if (return_code)
>  				*return_code =3D mbox_cmd.return_code;

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
hardware-induced heap buffer overflow?

Looking at the loop just before this check:

    mbox_cmd =3D (struct cxl_mbox_cmd) {
        ...
        .size_out =3D size_out,
        .payload_out =3D feat_out + data_rcvd_size,
        .min_out =3D data_to_rd_size,
    };
    rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);

The command struct tells the mailbox transport that it has size_out bytes of
space remaining in payload_out, even though the actual remaining space requ=
ested
for this iteration is data_to_rd_size. If a buggy or malicious hardware dev=
ice
ignores min_out and returns up to size_out bytes, could the transport blind=
ly
overwrite memory past the end of feat_out?

[Severity: Medium]
This is also a pre-existing issue, but does this mask internal mailbox comm=
and
failures?

When cxl_internal_send_cmd() fails before getting a response (e.g., due to a
timeout or busy state), mbox_cmd.return_code retains its 0-initialized valu=
e.
Does setting *return_code to 0 end up propagating a SUCCESS response to the
fwctl user, even though the command failed?

> -			return 0;
> +			return rc < 0 ? rc : -EIO;
>  		}
>  		data_rcvd_size +=3D mbox_cmd.size_out;
>  	} while (data_rcvd_size < feat_out_size);

[ ... ]

> @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
> +	if (feat_data_size > U16_MAX - offset)
> +		return -EINVAL;

[Severity: Medium]
Does this have the same off-by-one bounds check error as cxl_get_feature() =
when
writing a full 64KB extent?

[ ... ]

> @@ -476,16 +483,17 @@ static void *cxlctl_get_feature(struct cxl_features=
_state *cxlfs,
>  	if (!rpc_out)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	out_size =3D cxl_get_feature(cxl_mbox, &feat_in->uuid,
> -				   feat_in->selection, rpc_out->payload,
> -				   count, offset, &return_code);

[Severity: High]
This isn't a bug introduced by this patch, but does this lack a bounds check
against count?

The rpc_out buffer is allocated just above using the user-provided out_size:

    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
        kvzalloc(out_size, GFP_KERNEL);

However, cxl_get_feature() will write up to count bytes into rpc_out->paylo=
ad.
If a user calls the FWCTL_RPC ioctl with a small out_len but a large count,
could this lead to an arbitrary heap buffer overflow?

Additionally, if out_size is 0, kvzalloc() returns ZERO_SIZE_PTR. Would the
later assignment of rpc_out->size =3D 0 or data_size trigger a kernel panic?

Similar missing bounds checks on user-supplied in_len and op_size appear to
exist in cxlctl_set_feature() and cxlctl_fw_rpc(), which could lead to
out-of-bounds heap reads or ZERO_SIZE_PTR dereferences.

> +	data_size =3D cxl_get_feature(cxl_mbox, &feat_in->uuid,
> +				    feat_in->selection, rpc_out->payload,
> +				    count, offset, &return_code);
>  	*out_len =3D sizeof(struct fwctl_rpc_cxl_out);
> -	if (!out_size) {
> +	if (data_size <=3D 0) {
>  		rpc_out->size =3D 0;
>  		rpc_out->retval =3D return_code;
>  		return no_free_ptr(rpc_out);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708074228.4365=
4-1-icheng@nvidia.com?part=3D1
