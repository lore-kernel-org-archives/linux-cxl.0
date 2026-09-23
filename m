Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915041D124
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185575; cv=none; b=auUXV8FUSRBpoBH8ZXkNuvS2hzvdnhYW8RxEgiFvLIeicWo8TTObVGsL9X24XwSNhDiNCUCsyJ/NuNKgN/BpbGHYPsX7wq77SPVyM6EupkyfjX938iT04AQXr/sz4IKlKFso8RXqEfvuRpqr76SfeT2V7LoM/Zftbfudtpqqreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185575; c=relaxed/simple;
	bh=vSbdYN1Dq9HcU7VauE3EtrXpbSIUtS32v/yOXArq2T0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dt7o+hdH8hxmT7mYXqRWJXrjysqOHRgu7BiIJLlRDoXQAELE4LRrZrvaguIkEuhwNgue/p0lMPqV85L1xM7Zwg1+uDz+VwRARxJqoYbFDb5CjcU5YUC+UsNcvceaobMGLON1oLfWFNNM+wRfVV5Ggccmx0aAjsZ+4W2VWLZxupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkQiVLgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkQiVLgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9401F000FF;
	Wed, 23 Sep 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185571;
	bh=VLZb7snPYEYjV7GcgEpiDi+F7cDCGgwtHk4SbTpDh2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkQiVLgR6I/xCe1KFpTpz/MdhDCxBDYzIvHrI4TrE3BgEj/5FgwDCXV7+3IrNLJfa
	 /WxtudEZ80lq7XUnW3AJOIEuQNbm/4ky0LtlZ+B1XknarDRqI88htgrGilwZjdIPYz
	 e7Mc4dOLp0RjVlGQBq9SOB1812V79xePvVJ+wnOj2d4q+zdK/dSMaKWAX2absiEoFm
	 PTFsNqLUGZX8EoRn2PNHzOEqnTEVXKMz5qoMTFgU54AhmmiuJgCOFSfprVLzU/saSq
	 fRyPYV+mP8Mrp6K0BDmuZkd5aen4Ftwc0PVZnz/A/hOFdkX6lfNdnFPfjG+g0GYpJQ
	 Ifg41cl1Uxt8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] cxl/port: Split endpoint port probe on device
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-6-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-6-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:46:11 +0000
Message-Id: <20260923174611.9D9401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl/port: type mismatch due to implicit pointer cast in schedule_de=
tach()
--

commit 4ffbc8dadee1abe8b3c2deec219a795c0d6ff353
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/port: Split endpoint port probe on device type

This commit splits endpoint port probe on device type and refactors
dport RAS set up into a common routine. CXL.cache devices do not support
or need all of the set up done by endpoint port probe for CXL.mem devices.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index edf0ff759fbf6..7c93fabfb0956 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
[ ... ]
> @@ -26,9 +27,13 @@
>   * PCIe topology.
>   */
> =20
> -static void schedule_detach(void *cxlmd)
> +static void schedule_detach(void *ep_dev)
>  {
> -	schedule_cxl_memdev_detach(cxlmd);
> +	if (is_cxl_memdev(ep_dev))
> +		schedule_cxl_memdev_detach(ep_dev);
> +
> +	if (is_cxl_cachedev(ep_dev))
> +		schedule_cxl_cachedev_detach(ep_dev);
>  }

[Severity: Low]
Does this code inadvertently bypass type safety by passing ep_dev (which ho=
lds
a struct device *) directly to schedule_cxl_memdev_detach() and
schedule_cxl_cachedev_detach()?

These functions expect struct cxl_memdev * and struct cxl_cachedev *
respectively. While this avoids memory corruption right now because the dev
member is located at offset 0 in both container structures, it relies on an
implicit pointer cast.

Would it be better to use to_cxl_memdev() and to_cxl_cachedev() to explicit=
ly
resolve the container structs before passing them?

[ ... ]
> @@ -151,6 +141,27 @@ static int cxl_endpoint_port_probe(struct cxl_port *=
port)
[ ... ]
> +static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
> +{
> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(port->uport_dev);
> +	int rc;
> +
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +	cxl_endpoint_parse_cdat(port);
> +
> +	get_device(&cxlmd->dev);
> +	rc =3D devm_add_action_or_reset(&port->dev, schedule_detach, &cxlmd->de=
v);

[Severity: Low]
Is this where the mismatch originates? The devres data queued for
schedule_detach is explicitly set to a struct device * here, confirming
what is passed when the callback executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D5
