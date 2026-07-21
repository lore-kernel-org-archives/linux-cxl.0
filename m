Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E67261A
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625386; cv=none; b=TZiN8KygNgEypSSnyjafkQsqaeS8c1GSozYuewY6E8X6y+H3TWd+WOh1BGgj+PoZ5yUApPUnH2zTfxpWf+iaOdumqYh9OC2H54AS/501GyAg1+PD+oF7Oi4g+Np8o5pOv18QCL3FHbBjFhlCB+2pDYQoz9PyUG6pYfHoKCLDZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625386; c=relaxed/simple;
	bh=c11pR/s0UdIJ86N3saz9aeYIk2ulhBgUoSiy6nAYKZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4iLlQCCTjuNSSsoaCB0vF0j0kfnsp+WYL5kghN/5049VmxLypBzNu78Bnm+Xv02deqoLUvIUjUl9CMEod9DgAcBF3FHfUkpF1ndspstxSFZPTU5zAWzIDiw0ecyT/XwxyH59lzk6xz4l3aHqKy0/CerP909CeCHMGR9NFebpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2SCf6Q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2SCf6Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDD61F00A3D;
	Tue, 21 Jul 2026 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625384;
	bh=Lj0EERcC6gXIR9nyxdp7pNuuWvwl0rTLT75wSWLE/Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2SCf6Q6ORLvrwO989wdFCOzfO9hDubZylWPJnn5MUUe7g93fdLIRQkgo8uy2az1u
	 M3liRxNz24Y/taEAKnqMNCUKW2ZRfF1rmrMNyKfiacdpxvfUjpr7CfNLd0JfcyAU+i
	 ysnsr1xRBOTk1hT4iXqLuvdvF0u2o/kN70v8qHK0Qw36nngH/M8KktPfLmEquF5rVO
	 +EVeFWmTgwYeJGi+SaH3gkjjfrCKLgklzIQjD5Uosoyo8/OigZTh4XrPnNAMHPDjkw
	 HD4Y5Xwm5iCP4Pvre99DK/Lf/ueETpezKhBm1+52ZG0kxj4XA141DNJdDN8RwJl6er
	 FWB74htUBDHnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260721085715.39322-2-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:16:24 +0000
Message-Id: <20260721091624.9CDD61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_dpa_free() returns early for zero-sized decoders, bypassing re=
source release, leaking the DPA reservation, and permanently breaking port =
LIFO teardown.
--

--- Patch [1]: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders=
 ---
commit 69f9a310ab608be9b469a96819d45389f215c346
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

This commit allows the CXL subsystem to accept zero-sized HDM decoders
instead of rejecting them during port enumeration. It treats empty decoders
as first-class by backing them with a kmalloc'd resource and keeping the
skip and hdm_end accounting intact.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))

[Severity: High]
Does this early return skip the necessary cleanup for zero-sized decoders?

When cxled_empty(cxled) evaluates to true for a zero-sized decoder that
has a valid dpa_res, returning 0 here skips devm_cxl_dpa_release().
Since the reservation is backed by a kmalloc'd resource from
cxl_dpa_request_region(), does this leak the dpa_res memory?

Additionally, skipping devm_cxl_dpa_release() means port->hdm_end is not
decremented. Because CXL DPA management strictly enforces LIFO teardown,
will this strand the hdm_end watermark and permanently break the ability
to free or reconfigure prior decoders on the same port?

>  		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721085715.3932=
2-1-icheng@nvidia.com?part=3D1
