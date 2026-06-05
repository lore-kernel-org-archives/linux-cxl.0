Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2433B810D
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670272; cv=none; b=r/1aMK31TZuBr7YJInKt/1jsDso3MBWCZRp6R8t2Wsaeymr0EGLiu99T0VAtCp6/oOBSPJ+qhRSbkv56KPi4mRm+cn64Efu3+mpndOGdIWj2sLyojypvE6WhX2DYott2O+W0ZqC2/R0+m0rfDuSaXe5dNdq9UebICVF8rV2Yp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670272; c=relaxed/simple;
	bh=n6wSYVjMG0fI1Fmfsmq/poeSHXIqiGfHcOxJPOGaafY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQVDsO6YR/lfY98JlFcAEpOl4CfBpo1cZKD9F/q6sRvcwYXUSI1c9PKuzXWxN8fT1p8/UwgKBH24P9UHcVXqwR8MFoqXr5ntkxIzY//uRSqpRryF+e7eYEZ6aFA3GHQp4RPMGio2vCbNY2rFei1pfAMh4feKQZ7PF9xCvXUYeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWE6webH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWE6webH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235271F00893;
	Fri,  5 Jun 2026 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670268;
	bh=f1brxZwUlfLaJLoJ53OaqlmU8yVFC3McduwmqB+o5h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWE6webHzubn/mRWS4yX1b3ZspOz0srvVqg5efjGdNt9xZHVvuoAg8Cj+cw8nsZPb
	 SbvrIg99xm+LOJa+Gi3L6GcU+F2CIs+3DWImd2gKCcWu9tw5TwqCn8vACpHrR/WdRK
	 JVPxD5GJatLc/RwM88rltuoE0+li+VLX5O7JP2aEloYsMFNuAOvOwLDJJbfYKtjD3m
	 L9rNukHb6FwBv8polrclPn8PG83t4ktPybH5ONf3iesSu9OtzGSpPTeMHMWMALcKTL
	 tIE2ZsDQJJAFpHhC6lyQISEJ1CwdeH/GtQBntRk8kOm9KfTMiP22XWWNbU3Lqq/uhn
	 adERz06SuOQww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Moelius" <sam.moelius@trailofbits.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:37:47 +0000
Message-Id: <20260605143748.235271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow in `mock_transfer_fw()` bypasses bounds chec=
k leading to kernel crash
- [High] Unpatched integer overflows in `mock_get_lsa()` and `mock_set_lsa(=
)` bounds checks
- [High] NULL pointer dereferences in mock CXL mailbox handlers due to unva=
lidated payload sizes
--

commit 5bf785b4ab5b40166bbb1f3af01c1403ead02ea9
Author: Samuel Moelius <sam.moelius@trailofbits.com>

cxl/test: reject wrapped GET_LOG offsets

The CXL mock mailbox GET_LOG handler validates the requested CEL slice
with an offset + length check that is vulnerable to integer wrapping.
This commit fixes the potential wrap by validating the offset first.

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32c..5dc9601a2a7e4 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -584,7 +584,7 @@ static int mock_get_log(struct cxl_memdev_state *mds,=
 struct cxl_mbox_cmd *cmd)
>  		return -EINVAL;
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
> -	if (offset + length > sizeof(mock_cel))
> +	if (offset > sizeof(mock_cel) || length > sizeof(mock_cel) - offset)
>  		return -EINVAL;
>  	if (!uuid_equal(&gl->uuid, &uuid))
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but earlier in mock_get_log(),
are we dereferencing gl->offset before validating cmd->size_in?

static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *=
cmd)
{
	struct cxl_mbox_get_log *gl =3D cmd->payload_in;
	u32 offset =3D le32_to_cpu(gl->offset);
	...
	if (cmd->size_in < sizeof(*gl))
		return -EINVAL;

If cmd->size_in is 0, could cmd->payload_in be NULL, leading to a NULL poin=
ter
dereference here? This same pattern appears to exist in mock_clear_event()
and mock_get_test_feature() as well.

[Severity: High]
This is a pre-existing issue, but since you are fixing an integer overflow
here, should we also fix identical unpatched bounds checks in mock_get_lsa()
and mock_set_lsa()?

Both of those functions appear to use the same vulnerable check:

	if (offset + length > LSA_SIZE)

If a very large offset and a small length are provided, couldn't this wrap
around, bypassing the bounds check and allowing out-of-bounds memory
accesses?

[Severity: Critical]
This isn't a bug introduced by this patch, but does mock_transfer_fw() have
a similar bounds checking regression that could cause a crash?

In mock_transfer_fw(), the length is calculated without first validating
cmd->size_in against sizeof(*transfer):

	length =3D cmd->size_in - sizeof(*transfer);
	if (offset + length > FW_SIZE)

If cmd->size_in is smaller than sizeof(*transfer), wouldn't length underflow
to a massive value? Combined with a specifically chosen offset, could this
wrap around the addition, bypass the bounds check, and result in an
out-of-bounds memcpy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605142036.2062=
347-1-sam.moelius@trailofbits.com?part=3D1
