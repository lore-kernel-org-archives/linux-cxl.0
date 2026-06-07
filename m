Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB24071CA
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861488; cv=none; b=lpqpODCMTwa3rCh9BxACEUVsIfn7cIrV+zb4jsTEkzxU9yPBIoRWr1IeWT0K8OkOnLEQm6SPqapK4h4jYO4jR4EOtT/PvFPrUWdQa3SUN0UVLxLHXNDcvfGb24YFEk6NTKFjSNcxsrOclnU2k8kpDIl1u4e7I6Hu1mGtBEynVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861488; c=relaxed/simple;
	bh=a6rn8TCAXwYCP0Oec1HtLn8T8oUwVOgURrgNZcNjqZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZrN2oP0hfSdwx4g5t7oK/xiJalKDKEhgYBwK+TsspShtZ9MbdxbdwaIiPj8pc63e+IYdAfU5bN5nJHzykgVFYQHX3NE8GFqARAt6nLbMNbukPRUb3dk5GowAyRs0BTBv2eZthQs2lZBiNKPoFAXd4/5wUqP+Ccm+PFoAJ5iKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAGCyv+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAGCyv+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E41F00893;
	Sun,  7 Jun 2026 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861487;
	bh=1cY08D5M3TMn7sNd1wUrQTJxI4nF8UQlGOR5QLQpYq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAGCyv+qRKjRb+vfp4Otm+t+hph2R9se+Zgem8JA5GJtyvlkW60G4+2xlHFoes+s1
	 TkrkxD0P8EDgP7PsyFqs/N/MkoP1AizlqfmLVo+7O13yoVAYc1rUvQaOFOMl+opKfx
	 cl+AJDYQ6sjuhE1fvJOgGGLV/Xs4qLHnohBRO+ZN2HHYH9xDftBQZfcPIijiNDHbwD
	 AT4YXtswadwd0oMf9DtnnOF/6FnEJoozvVnoFpKXvf6l2WIJyDUrmltZnD+1QUkEo/
	 APEDntSx07Eo+9SdBukv20lWB6Cc9qbNaMXO8vCnYmj/4/UBJr+/wNitWeAU8vzyRV
	 aTyMlPkzvCEhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/9] dax/fsdev: don't leave a dangling dev_dax->pgmap
 on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea3939aab-4a2fe020-b29c-4648-ad01-08b091ef9627-000000@email.amazonses.com>
References: <0100019ea3939aab-4a2fe020-b29c-4648-ad01-08b091ef9627-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:44:46 +0000
Message-Id: <20260607194447.134E41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical dangling pointer bug that causes permanent probe fai=
lure and was fixed in `fsdev.c` still exists in `dev_dax_probe` within `dri=
vers/dax/device.c`.
--

commit 4bfae7ab5cd902255b5838eb3c590fffc93926ef
Author: John Groves <John@Groves.net>

dax/fsdev: don't leave a dangling dev_dax->pgmap on probe failure

This commit fixes a bug in fsdev.c where dev_dax->pgmap was left dangling
if a probe failed after allocation. It defers assigning dev_dax->pgmap
until the probe can no longer fail.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index dbd722ed7ab05..0fd5e1293d725 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
[ ... ]
> @@ -339,7 +354,13 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		return rc;
> =20
>  	run_dax(dax_dev);
> -	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> +	rc =3D devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> +	if (rc)
> +		return rc;
> +
> +	/* Probe can no longer fail; expose the pgmap via dev_dax */
> +	dev_dax->pgmap =3D pgmap;
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does the same dangling pointer bug still
exist in dev_dax_probe() in drivers/dax/device.c?

The identical pattern of assigning dev_dax->pgmap immediately after the
devm_kzalloc() allocation appears to be present there:

drivers/dax/device.c:dev_dax_probe() {
        ...
        pgmap =3D devm_kzalloc(dev, ...);
        if (!pgmap)
                return -ENOMEM;
       =20
        dev_dax->pgmap =3D pgmap;
        ...
}

If a later step in the probe fails (such as devm_request_mem_region() or
devm_memremap_pages()), the devres framework automatically frees the
allocated pgmap. Since the cleanup action is only registered at the end of
a successful probe, the error paths leave the pointer dangling.

Would subsequent attempts to probe the driver then hit the check for
dev_dax->pgmap and erroneously fail with -EINVAL, permanently preventing
successful device binding? Does device.c need a similar fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D4
