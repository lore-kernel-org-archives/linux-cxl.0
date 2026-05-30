Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82631F98D
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164540; cv=none; b=RVnLN2xl1v5SIN+vzNWVGkIWdk1Cp8YFj2dG391G//KZQNhOhiwF/ll+8XJWvAT8Y1DJR6ObHSvqJa842/vFYCJOebQtfjOyXuDBrkIWJdn2sGdlHld4LZvalDJFBGmMosN7xc94ZE0Vyo23IArai8RxLc0QrFqwN0UgxlEw6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164540; c=relaxed/simple;
	bh=OPcSptPsGl3rBK9H+QXy4FgmVb/R8tWMYBWUkw5xkA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HOCPoiQ2wkllAVBfp8o4MDtxzalIFLhSz479Q3DqfENf9AilUIQFMR7Oz8J9RxIz0bQ2A1Waab1iwPue2mmVBDt020v0SdGfGvC3JujYZENrQeEXEA3ZlJ2qtLBXRQNoTqdL4P9nbb7coxyktkyjOSKoQyyYdo5qikgjevP6lZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KekNXRN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KekNXRN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420861F00893;
	Sat, 30 May 2026 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780164539;
	bh=fX4zFbsLQ2hD0yM9KUUMH7VcGeFXE/SbpRbZtf+rLrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KekNXRN9H9Pnk2iY+JYHH6ZU8AKrwN5dQmqTg64Q9DgsA0/6JBXcZemMde5VT4zlt
	 IMrS3hhIb7PEpdqoZbOEvNd0nHFB/JyKacpAu0WH29rPwH5ViPztN/5haZZwkYdb6X
	 Uaddiq/askhGFrSBQiBDrYmOBqCJ39Gsn2b1iXN55/9Q/qx9nhxdJoCT6jHsyfnsaD
	 O1+exb7S9K1Bze7Wv22lWiBQ+kd4Z0FJ8Ws2q8nVbPlqFZVUQaTQDUcQz69v8DYTOl
	 Bg6wuXhIPPmKR9uPv1GsFSLHk49gJaCEte5w3ZYTHXnVzX7pQW/hmybhinapVFPzQO
	 0HsaUQj/FxMBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 7/9] dax: fix holder_ops race in fs_put_dax()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cc1d9e-d39ff70d-4f1d-4a02-8b8e-e01c70272c0c-000000@email.amazonses.com>
References: <0100019e79cc1d9e-d39ff70d-4f1d-4a02-8b8e-e01c70272c0c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 18:08:58 +0000
Message-Id: <20260530180859.420861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The `WARN_ON` in `fs_put_dax()` will falsely trigger during normal=
 filesystem unmount if the DAX device was hot-unplugged.
- [High] Unconditional clear of `holder_ops` in `fs_put_dax()` before valid=
ating ownership can corrupt the state of concurrent valid holders.

Pre-existing issues:
- [High] Lockless double-fetch of `dax_dev->holder_ops` in `dax_holder_noti=
fy_failure()` can lead to a NULL pointer dereference.
- [High] Missing SRCU synchronization in `fs_put_dax()` allows use-after-fr=
ee and module use-after-unload during unmount.
- [High] Inode reference leak in `fs_dax_get_by_bdev()` when a concurrent h=
older already owns the DAX device.
--

commit 182e9ccdc90a15375d69ff8ae0ad8f75bda03aed
Author: John Groves <John@Groves.net>

dax: fix holder_ops race in fs_put_dax()

Clear holder_ops before holder_data so that a concurrent fs_dax_get()
cannot have its newly installed holder_ops overwritten.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 25cf99dd9360b..4c56ac2faacdb 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c

[ ... ]

>  void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  {
> -	if (dax_dev && holder &&
> -	    cmpxchg(&dax_dev->holder_data, holder, NULL) =3D=3D holder)
> -		dax_dev->holder_ops =3D NULL;
> +	if (dax_dev && holder) {

[ ... ]

> +		WRITE_ONCE(dax_dev->holder_ops, NULL);
[Severity: High]
Could this unconditional write corrupt the state of concurrent valid holder=
s?

By clearing dax_dev->holder_ops unconditionally before checking ownership
with cmpxchg(), a caller passing the wrong holder could inadvertently
overwrite the holder_ops installed by a legitimate subsystem that just
acquired the DAX device.

> +		WARN_ON(cmpxchg(&dax_dev->holder_data, holder, NULL) !=3D holder);
[Severity: High]
Will this WARN_ON falsely trigger during a normal filesystem unmount if the
DAX device was hot-unplugged?

When a DAX device is hot-unplugged, the driver calls kill_dax(), which sets
dax_dev->holder_data =3D NULL.

If the user subsequently unmounts the filesystem, fs_put_dax() is called, b=
ut
the cmpxchg will see NULL instead of the expected holder. This would cause
the WARN_ON to fire and potentially panic systems configured with
panic_on_warn during normal administrative operations.

> +	}
>  	put_dax(dax_dev);
[Severity: High]
This isn't a bug introduced by this patch, but does fs_put_dax() need SRCU
synchronization before returning?

dax_holder_notify_failure() runs asynchronously under the dax_read_lock()
SRCU critical section. Since fs_put_dax() clears the holder registration but
returns immediately without calling synchronize_srcu(&dax_srcu), could a
filesystem unmount proceed, destroying in-memory structures and unloading
the module while the notify_failure callback is still actively executing?

>  }

[Severity: High]
This isn't a bug introduced by this patch, but does fs_dax_get_by_bdev() le=
ak
an inode reference when a concurrent holder already owns the DAX device?

drivers/dax/super.c:fs_dax_get_by_bdev() {
    ...
	else if (holder) {
		if (!cmpxchg(&dax_dev->holder_data, NULL, holder))
			dax_dev->holder_ops =3D ops;
		else
			dax_dev =3D NULL;
	}
    ...
}

When a dax_dev is found, its inode reference count is incremented via
igrab(&dax_dev->inode). If cmpxchg() fails because the device is already
held, dax_dev is set to NULL, but the function appears to return without
calling iput(&dax_dev->inode) to release the reference.

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential lockless
double-fetch of dax_dev->holder_ops in dax_holder_notify_failure() that cou=
ld
lead to a NULL pointer dereference?

drivers/dax/super.c:dax_holder_notify_failure() {
    ...
	if (!dax_dev->holder_ops) {
		rc =3D -EOPNOTSUPP;
		goto out;
	}

	rc =3D dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
    ...
}

Since dax_dev->holder_ops is checked for NULL and then immediately
dereferenced without READ_ONCE(), the compiler might load the value twice.
If a concurrent fs_put_dax() executes WRITE_ONCE(dax_dev->holder_ops, NULL)
between these two loads, the second load could fetch NULL and cause a crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D7
