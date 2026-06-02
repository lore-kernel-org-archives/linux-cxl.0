Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1A393DE3
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379856; cv=none; b=rAj9Evbm04I6aSCc9CvrRCIX3DrW7NKgb/QM/2b8uOIZQRBDdTC3Y+CibP1GjTyZA5nHVaRO80zzwmWQGBhoHtQmktdphp86KoA8Twjgell5lw2j+C0kBk7P1IGGdxN6EXsl3Rf0OUkkZZX0FkACprRR9LlxlABkx9GrCFDNWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379856; c=relaxed/simple;
	bh=ToaRmMI6wIBjwzKgDTlir9GRmFzVRDGeb/GiiN2koOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CkNvMfcQJWbWbttZge/Zf5d7M7DLvMPOJTHhjJNwO7PmEvACTGymvyhgU5/ofKqQFsYEOk2aDWs1iiD7eeZgl/Dfb96Aafdb1UqMD+hnByxuqLwQoJCoyJ+LffJq7dklSO5eaMhX4sBYW5SmtpIxmS3LlsRE/2otBhOMekQtyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzD3tk11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzD3tk11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6392E1F00893;
	Tue,  2 Jun 2026 05:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780379855;
	bh=ymXy8yPs+VAw3ZvvBKht4IxKcZdSAzR0KZJr2DNo9hE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WzD3tk11/0GbQ3PaZ9ojEgE9/Z9Y8Lb8qCZ0OmPPLQfaY/cErp4ABtm7gkekNH9yr
	 VbdKFwXkM7Cj96bL/b1E8nM2re7Miog2tzDpKwijLzrhL1zUhTI6TD0Ix73zFsJ505
	 frH4VNG0ZkyzkGD4YZi9Oj2IHxo6JE86qdqRTU46s6E8i6egFN93t6sQYvZj1E3mW9
	 7tFsiyrypyEETS8z22C/oOkOQe1LnIw07A9aRZILeIxoFYKV2embRFqG4x0SGmD4eT
	 nveCZSgKM/RLgXEf+DQlZRRGAA/cmQjoYVTBKk78/9glN2m8ZsH+7WqeKyXumTsVNx
	 jtiJ2SivXE5QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <c743dde11ad652a65b84d206085d09d7e56b9183.1779957270.git.icheng@nvidia.com>
References: <c743dde11ad652a65b84d206085d09d7e56b9183.1779957270.git.icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 05:57:34 +0000
Message-Id: <20260602055735.6392E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping devm_cxl_dpa_reserve() for zero-size decoders leaves port=
->hdm_end un-incremented, causing the out-of-order DPA allocation check to =
fail unconditionally for subsequent decoders.
--

commit 413b72f0366d77ee154e5fec85ab5deab385b5af
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders
   =20
This commit allows committing an HDM decoder with a size of 0 to support BI=
OS
configurations that burn slots for Trusted Computing Base devices. It sets
port->commit_end before checking for a zero size and skips
devm_cxl_dpa_reserve() for these decoders since they have no DPA range to
reserve.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..467ac45bee553 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1096,6 +1095,10 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  	if (!committed)
>  		return 0;
> =20
> +	/* Committed zero-size decoder has nothing to reserve in DPA. */
> +	if (size =3D=3D 0)
> +		return 0;
> +

[Severity: High]
Does skipping devm_cxl_dpa_reserve() here prevent port->hdm_end from being
incremented for the zero-size decoder?

If port->hdm_end is not updated, won't subsequent decoders fail the DPA
reservation path?

drivers/cxl/core/hdm.c:__cxl_dpa_reserve() {
    ...
	if (port->hdm_end + 1 !=3D cxled->cxld.id) {
		/*
		 * Assumes alloc and commit order is always in hardware instance
		 * order...
		 */
		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
			cxled->cxld.id, port->id, port->hdm_end + 1);
		return -EBUSY;
	}
    ...
}

If a zero-size decoder (e.g. ID N) skips the reserve step, port->hdm_end st=
ays
at N-1. When decoder N+1 tries to reserve DPA, port->hdm_end + 1 is N, which
does not match N+1, causing an unconditional -EBUSY.

>  	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainder);
>  	if (remainder) {
>  		dev_err(&port->dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779957270.gi=
t.icheng@nvidia.com?part=3D1
