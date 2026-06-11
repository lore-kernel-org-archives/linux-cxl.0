Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43A48C3FF
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201639; cv=none; b=ZwgdwKXiV3caOMJomHLLyOOXcgHfWauBBDepcBWmGM9JqRAAm/1mFASuMOU2omhLKVVWIJagPprh9CtwU6S2AFD8XEWqwluxXqsbX2TwiNdR4vrDoIt2WsXuiTcoKljLcb3/qBwcqx05wY4p/YIvNc2S/5y0W9vx04I1yIvbgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201639; c=relaxed/simple;
	bh=fAjyx6fRc23OkkwN8pDCQw/0xLQmfWJVosI2eA3k5oI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIKs+aEL2qBF2/SS4DRiEwqRZKAbUKknCsI0HTxUT71vo+xdKZjQ66k+efz+S8OyU/6gB7tl2ALEgXP4QvRL5jSzU4JvZ0IltOGayQTJB+N40DEOIDtLNokQCjuQgdyWGgmofirHvlM5qjWGqpdBAN5jHCStZhHsMB8xaf7RpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlxq8yt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlxq8yt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC131F00A3D;
	Thu, 11 Jun 2026 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201632;
	bh=eF1rd9k55YxLJwXOeit1Lr4nd0gGee3Z6LA33uaNpks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tlxq8yt+Y00MP67G5nIN511F2IrjjWgmyox+l4OKRH9BbuH3FDbT6Nz9RlQrrP9Xw
	 ZVU5WZGcwgoEIfaOQQL8mbpFDSoc893yG5pRxT6wv9eTnc1Y33FH92OXaZ5x5pZnU4
	 c5fy0X6o63NS2MJQSW2bM0lonIorPAHemmK+35dPxbBU8MNfs2iInEx3pbk1KCAOWV
	 TVmAcXgE3zn/pRu7FQOV8MiZQzPgX5jyEuM9XCqTrwnPy3vmqBQytwlfyTUU8M4hhR
	 MTZwhX3odFbBpEXH49EZz8RocPnWGJgvyFNmlGvx5V30Yz12DIEvW2M8l6O2xxz3k4
	 HK/zZzzsru0Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 7/9] dax: read holder_ops once in
 dax_holder_notify_failure()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7be595f-5045353d-86b9-49fd-b1ca-fbb40c22d06c-000000@email.amazonses.com>
References: <0100019eb7be595f-5045353d-86b9-49fd-b1ca-fbb40c22d06c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:13:51 +0000
Message-Id: <20260611181352.2DC131F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a TOCTOU race on `holder_ops` in `dax_holder_notif=
y_failure()` but fails to address a missing SRCU synchronization in `fs_put=
_dax()`. Concurrently, `fs_put_dax()` clears `holder_ops` and `holder_data`=
 but returns immediately without waiting for `dax_srcu` readers (unlike `ki=
ll_dax()`). This enables a filesystem callback to dereference a NULL `holde=
r_data` pointer, or execute unloaded module memory if the module is unloade=
d before the preempted callback resumes.
--

commit fb9deacd32044f5bf6a6a9877ee95b7eb436b68b
Author: John Groves <John@Groves.net>
dax: read holder_ops once in dax_holder_notify_failure()

This commit updates dax_holder_notify_failure() to read dax_dev->holder_ops
once using READ_ONCE(). This prevents a concurrent clear of holder_ops from
causing a NULL pointer dereference during the indirect function call.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c

[ ... ]

> @@ -311,12 +312,18 @@ int dax_holder_notify_failure(struct dax_device *da=
x_dev, u64 off,
>  		goto out;
>  	}
> =20
> -	if (!dax_dev->holder_ops) {
> +	/*
> +	 * Read holder_ops once: a concurrent fs_put_dax() or kill_dax() can
> +	 * clear it. Without the single fetch the compiler could reload
> +	 * between the NULL check and the call and dereference a NULL ops.
> +	 */
> +	ops =3D READ_ONCE(dax_dev->holder_ops);
> +	if (!ops) {
>  		rc =3D -EOPNOTSUPP;
>  		goto out;
>  	}
> =20
> -	rc =3D dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> +	rc =3D ops->notify_failure(dax_dev, off, len, mf_flags);

[Severity: High]
This is a pre-existing issue, but does this fully address the race with
holder_data being cleared?

If fs_put_dax() clears both holder_ops and holder_data concurrently, it
returns without calling synchronize_srcu(&dax_srcu) to wait for dax_srcu
readers.

If a thread is preempted right before calling ops->notify_failure() here,
and fs_put_dax() executes, the callback will proceed with a valid ops point=
er
but a NULL holder_data.

For example, xfs_dax_notify_failure() calls dax_holder() which returns NULL,
and then unconditionally dereferences the mount pointer:

fs/xfs/xfs_notify_failure.c:xfs_dax_notify_failure() {
	struct xfs_mount *mp =3D dax_holder(dax_dev);

	if (!(mp->m_super->s_flags & SB_BORN)) {
	...
}

Could this result in a NULL pointer dereference, or an execution-after-free
if the filesystem module is subsequently unloaded?

>  out:
>  	dax_read_unlock(id);
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D7
