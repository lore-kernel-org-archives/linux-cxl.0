Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C227A133
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540333; cv=none; b=hQPimL2MfqAybqjVtkkEpNOI2u3ZxDUpgsFubTn5Jzdw1TYEacgz4vvckCLFoxlPph7yK9n9QHctux3KD/rJhD+IhYxtdaGxOfyIr370F/4NoO0Mw7++Ny0CUbYJTZsuFfATQSs0VbbF0BwkSf9BWeG3Ko3cS7t444U+xN2VsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540333; c=relaxed/simple;
	bh=u1/uqYuiA1pCoZRdBAlvF4smL8rLUo5nYfmbHD2HSK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBS+zD/yKCmsET0x5z5jSJ5dCKf4VsaR3w1vLKVQW6pT966dtWEQQh4IYgPUpcAIBj/Z8Ql6VGAQwCJa/nKttYXNMWsXmkabso1SqLcSC2cmrQsLJGcadYNohdlTP9ni8GRNmX/moTV7s76AnJLNiFASH4kySZWt+L72dTkuW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diGvt9VF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diGvt9VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5BD1F000E9;
	Mon, 15 Jun 2026 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540331;
	bh=coa36LJFAvk0dY2dJKDlj1eRmiRfjXAv+z0s0zc6Q5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diGvt9VFolJx9q6lE74ZrsDuShUcehhv4CzfelusLj2wF4nHtgLpUUuZ1DWwAUYQB
	 M4gF/rn03KMrIKhhDK7SLz7O6rjb5iEuIoZ4OExQrfuPQ690fz9p4vtHAUPtkRVp8M
	 vEFjJ4WKmJ1rl5cB/GRp/zc8Cd8QfqDWthpp9SVtlSdjFRzH4E7SJ+qDtqiJaDaVuF
	 sOXaZDSFwOi6QPK1WRiB7swueo+NqIGzuPr8FUCqJtL64V5tf1lzeg/YGGwuQTBMs6
	 HfxSCqO+P0UdpREIA7LJhYNVUKGm9g8vvUa+BKUjSrrbrEAq8jEqbV6t4VaAmSaZWC
	 sbkQT4YbAVPYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 04/10] dax/fsdev: don't leave a dangling
 dev_dax->pgmap on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc092ca1-ffc7a5fd-1252-4be5-882c-fd5efdc102a9-000000@email.amazonses.com>
References: <0100019ecc092ca1-ffc7a5fd-1252-4be5-882c-fd5efdc102a9-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:18:51 +0000
Message-Id: <20260615161851.BB5BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The dangling pointer vulnerability fixed in `fsdev.c` remains =
unpatched in `drivers/dax/device.c`.
--

commit 52c18cf5434f51d501cdddba7b8f1a7832f05892
Author: John Groves <John@Groves.net>

dax/fsdev: don't leave a dangling dev_dax->pgmap on probe failure

This commit fixes a dangling pointer issue in fsdev_dax_probe() by
deferring the assignment of dev_dax->pgmap until the probe can no longer
fail. The patch factors out the pgmap allocation into fsdev_acquire_pgmap()
to prevent dev_dax->pgmap from pointing to devres-freed memory if a
subsequent probe step fails.

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

[Severity: Critical]
This is a pre-existing issue, but does the same dangling pointer issue
remain unpatched in drivers/dax/device.c?

In drivers/dax/device.c:dev_dax_probe(), pgmap is allocated with
devm_kzalloc() and prematurely assigned:

        pgmap =3D devm_kzalloc(dev,
                       struct_size(pgmap, ranges, dev_dax->nr_range - 1),
                       GFP_KERNEL);
        if (!pgmap)
            return -ENOMEM;

        pgmap->nr_range =3D dev_dax->nr_range;
        dev_dax->pgmap =3D pgmap;

If a subsequent step like devm_request_mem_region() fails, the probe aborts
and returns an error:

        if (!devm_request_mem_region(dev, range->start,
                    range_len(range), dev_name(dev))) {
            ...
            return -EBUSY;
        }

Devres will then free the pgmap allocation, but dev_dax->pgmap retains the
dangling pointer. When the device is later destroyed, dev_dax_release() in
drivers/dax/bus.c blindly calls kfree(dev_dax->pgmap), which could lead to a
double-free.

Should drivers/dax/device.c receive a similar fix to prevent this?

> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D4
