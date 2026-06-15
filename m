Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007B40963B
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540641; cv=none; b=bQXWQEo53DFO91gkgJJBNfQwIGQY9n07G3V2P8V9PU7aKj06FKCq/M3h9rvZVkIhc1dhS2xjVciByBjMcpSXg0ogkDKCoVnrRblkooKGVjVttWiqzMdu0DHSB8sPDpVcBzpZpYBenc1z/blPCb5vDHhCrECbxtuxgT3O2T8q1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540641; c=relaxed/simple;
	bh=CEtX8CrY28fIZDUeOe7MoWYaAWVYHYf4cqx/FyNnnqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzG35bARWKevxOeWesrx+nNXVyd3n51xG65Pr+9d51+JsL9ltymelyaIBmeo0lbp2BNvnDqz0mKG5TyhCUYysW+wDOv7wriLoorO52Z/nls6UYWqlJPT/zosAy13/POSqmRnjxWlyCmXHANI5D2kkZx2l+49pKCadsBZdFFccLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSIwU6gk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSIwU6gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA41F000E9;
	Mon, 15 Jun 2026 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540639;
	bh=ccalhYQp8AtTpLEHVVJFDSIBsgvuJ3stiUERmWA3ipA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSIwU6gk1/EZtVwOZjyerDkaYL7YsmpzMaRWp7zxxGHvV/r71Mq/RUdaFKZFLuYnj
	 Qh6UfneR0HFigCYo5j+EI6SKzVEg4mM0gOApIJQpbzTsQl5dbBGPnskYHp5cKKbR3g
	 Kfz6aJ0P1im504LfXfVkbau9wBRK3GTz7CzokIFZ41dsJFOnUAgr1C1o1xIycXAdJS
	 44XBFtidpXpZcdeR58zoYwkczDe+me2BG89XtdxDIDCfPIcOu8fqAjespWupWltgSg
	 J+GyRo0kpGc9iQhR7rLd626RKq4/JbYidEq59nPy8olO9MF8WVAQl0jeT55qlv/vB0
	 mMO0QUFe+fHTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 09/10] dax: fix holder_ops race in fs_put_dax()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc09dcab-2f4aa175-0b84-4b36-9e54-ebff302ebb0a-000000@email.amazonses.com>
References: <0100019ecc09dcab-2f4aa175-0b84-4b36-9e54-ebff302ebb0a-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:23:58 +0000
Message-Id: <20260615162359.8AAA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of synchronization between fs_put_dax() and dax_holder_notify=
_failure() leads to a Use-After-Free or NULL pointer dereference in the fil=
esystem notification callback.
--

commit a0977fb8b9025fac426e421985dcf37f0776980d
Author: John Groves <John@Groves.net>

dax: fix holder_ops race in fs_put_dax()

This commit attempts to fix a race in fs_put_dax() by clearing holder_ops
before releasing holder_data. It also introduces a warning to catch cases
where fs_put_dax() is called by something other than the current holder,
while intentionally tolerating NULL results during device removal.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 433cd431a6c06..45f84b0eb909a 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -116,11 +116,47 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> =20
>  #if IS_ENABLED(CONFIG_FS_DAX)

[ ... ]

>  void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  {
> -	if (dax_dev && holder &&
> -	    cmpxchg(&dax_dev->holder_data, holder, NULL) =3D=3D holder)
> -		dax_dev->holder_ops =3D NULL;
> +	if (dax_dev && holder) {
> +		void *prev;
> +
> +		/*
> +		 * Clear holder_ops before releasing holder_data. A concurrent
> +		 * dax_holder_notify_failure() that sees NULL ops returns
> +		 * -EOPNOTSUPP cleanly. A concurrent fs_dax_get() that acquires
> +		 * holder_data after the cmpxchg below is guaranteed to observe
> +		 * holder_ops=3DNULL first (cmpxchg provides release ordering), so
> +		 * its subsequent store of new ops will not be overwritten.
> +		 */
> +		WRITE_ONCE(dax_dev->holder_ops, NULL);
> +		prev =3D cmpxchg(&dax_dev->holder_data, holder, NULL);

[Severity: High]
This is a pre-existing issue, but does this lack of synchronization lead to=
 a
Use-After-Free or NULL pointer dereference in the filesystem notification
callback?

dax_holder_notify_failure() executes under srcu_read_lock(&dax_srcu) and re=
ads
dax_dev->holder_ops to invoke the filesystem callback. Concurrently, during
unmount, fs_put_dax() clears holder_ops and holder_data but returns without
calling synchronize_srcu(&dax_srcu).

This allows the filesystem tear-down to proceed and free the xfs_mount
structure while the notification callback is still running.

Inside xfs_dax_notify_failure(), dax_holder() is called:

fs/xfs/xfs_notify_failure.c:xfs_dax_notify_failure() {
	struct xfs_mount *mp =3D dax_holder(dax_dev);

	if (!(mp->m_super->s_flags & SB_BORN)) {
	...
}

If it sees the cleared holder_data, it returns NULL, leading to an immediate
NULL pointer dereference on mp->m_super. If it fetches the pointer before it
is cleared, it will access a freed xfs_mount, leading to a Use-After-Free.

Is it necessary to add synchronize_srcu(&dax_srcu) here to wait for in-flig=
ht
SRCU readers before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D9
