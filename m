Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5B434407
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535536; cv=none; b=eTIjIVZHrXCXKhw9RSZ4Pa780HDSLpeyf23ty4zcC4lqClF5lHrvO8LwNHtokdzzaPUG/nC0mvvHhxKUh3TKmwSerWTiEbd2ECfD0bXB7mysjBt+HUm7WvR/i/5UHs7Y+xN5yae/M6PKNo81tAPn/BRXcJd0/by8MN3B7RM1FDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535536; c=relaxed/simple;
	bh=CMCx9JGbn512rSCXyn+0Cn5fAIpLjBWoF+SL7RCB0Cc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E0MeapPZPsEQ2g6Tz/eZm+tISKYuTIYX6X6a8LNFlcRdNZl7bov2SoWg9zd5p6SyrPtPcI93rB36SD+t1rtWSbMoWu+3H5mN+2yZ/WOf2+dNby/ZU/ymJKp7XCH4oOy2luQ6gdzxXdn83xMzT1Lc4RlDQXnPaU4ksWtFpQnPAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/kVUPJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/kVUPJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE5A1F000E9;
	Wed, 12 Aug 2026 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535533;
	bh=LYWSuCHz3LVfdIV5hAmlaAHu4HI1XSWM9WdFnXDI3ZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/kVUPJh6gyB57T73EMvbTAT4A9+FjH7AtJyNO6JxMOQ8Nz/gRVJjuXeznvMy7OeE
	 tSn7T7FPjsHpj3JpwGP3FxAVICKh+4xEBRhhF0ExjU8bmybMfYa3woS8r7mY/J7ON6
	 ncKyO/j2VSO7sPWDj3/dLV37P9zSvncwYu/RgFKoM+fsj6uZS2zFb5hU3oimM9KZ32
	 obQuJn5vl4B3PTRx6BeiCJ4OT8ulsL+07j0wEiovYSuuskJruknHqOhg7Qxpum791f
	 zmM3Mm/v7zzCUgKocj88SsVgHMjqxQ9JE5L9m6VScd8a/AQJRgS5n6PAno0I92M4QQ
	 7FHHKdyg2HWqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] cxl/features: Reject feature offset that
 overflows 16-bit field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812112107.56181-2-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
 <20260812112107.56181-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:52:13 +0000
Message-Id: <20260812115213.7CE5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] fwctl ioctls falsely report SUCCESS to userspace when CXL mailbox =
transport encounters an internal error.
--

--- Patch [1]: [PATCH v4 1/6] cxl/features: Reject feature offset that over=
flows 16-bit field ---
commit 758deff635a1582bb94f5fac18c817ddd4966bdb
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject feature offset that overflows 16-bit field

This patch validates that the transfer size does not exceed the remaining 1=
6-bit
feature range to prevent truncation when building mailbox command offsets. =
It
also changes cxl_get_feature() to return ssize_t so invalid input and mailb=
ox
failures are reported as negative errno. Finally, it updates the EDAC calle=
rs
to handle negative results.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ba6d2a5acb74a..8d44ce8294978 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
[ ... ]
> @@ -259,7 +262,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  		if (rc < 0 || !mbox_cmd.size_out) {
>  			if (return_code)
>  				*return_code =3D mbox_cmd.return_code;
> -			return 0;
> +			return rc < 0 ? rc : -EIO;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but if cxl_internal_send_cmd()
fails with an OS-level error (rc < 0), it won't populate
mbox_cmd.return_code. Since mbox_cmd was initialized as a compound literal,
doesn't this set *return_code to 0 (CXL_MBOX_CMD_RC_SUCCESS)?

When this happens, cxlctl_get_feature() will absorb the negative error code
and pass the zeroed return_code back to fwctl:

drivers/cxl/core/features.c:cxlctl_get_feature() {
	...
	data_size =3D cxl_get_feature(..., &return_code);
	*out_len =3D sizeof(struct fwctl_rpc_cxl_out);
	if (data_size <=3D 0) {
		rpc_out->size =3D 0;
		rpc_out->retval =3D return_code;
		return no_free_ptr(rpc_out);
	}
	...
}

Does this result in fwctl ioctls falsely reporting SUCCESS to userspace when
the CXL mailbox transport encounters an internal error? This same pattern
appears to be present in cxl_set_feature() and cxlctl_set_feature() as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812112107.5618=
1-1-icheng@nvidia.com?part=3D1
