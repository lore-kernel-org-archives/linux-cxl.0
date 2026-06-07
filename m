Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34522EEE7E
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821042; cv=none; b=PrtTMdZGc031OVe4Sh9ArUyw2zNdwVh/B3FGoIoK/h0tUXBKmPIM8tQOnwkzgTyWkA7ArdGcqg7UYNLbyOf9Nqeavr6XT5oy6tWjTQlu6wtmQJL0QNlvtPbANk1UeNc1Q3UHmwcyYwi2EPESZO9SqKKX9wOajPn5K0CV/xH+j64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821042; c=relaxed/simple;
	bh=fIrxGLc+kX7FzTqmvwoqPkyInPYfVj4InBqpiGgGMSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BExyNSDJueeQVzJU5hoMVJHwWMvlX4Do9ypIAues+qB477N4x/hIPy5y/hFIDSZe8T0E8/T/CHsVoPffNSPDwr07pIoZF1M0Qnhyj57g87+yW9f4xUcEXIXLZj+WEpf63F8tWL5fY1TEaw1oPDZb1/OW6b1yYjLp8IH9wL0GZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+/pYfEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+/pYfEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A0B1F00893;
	Sun,  7 Jun 2026 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780821040;
	bh=Ly4gp4Km9NraTvxjIxdOTVrkzBv3Z8G85MtOyihUVYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+/pYfEd0NK2CSIJVEJgJvCA5RpKkn8Wp2s45lrl6sDIBciY7jM6O7/EB+Jc9hK/3
	 dBf+6J4kNpoTHOzDHQ51jKxaIt1J5Q/vPegL/lKAwF1Pl8Q2I6q2cBWIhZR0w1HH/Q
	 8PQEjZjbOqe1dJsOfIe+0PvtGSOdSR582p68Op0AO3vHLfNYnGvXKpgdJDJhtk0WxO
	 aBZCp9rVEPgQtYA4adnXOP4FPbrTt32oqMjzWMEUYQqYpthYso96NC1wSgfYVVJsSx
	 idsAVwv1XKAvV2lwQ3+jT/bWN9xE1mEfWOx7n99HNnZXd3eflANV65ANLNG9Cp02p4
	 lnIgbeofM0TRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260607081345.61954-2-icheng@nvidia.com>
References: <20260607081345.61954-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 08:30:39 +0000
Message-Id: <20260607083040.70A0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Logic error in poison_by_decoder silently skips unmapped DPA poiso=
n collection for endpoints with a zero-sized first decoder.

Pre-existing issues:
- [High] Stack buffer over-read in init_hdm_decoder leaks kernel stack memo=
ry to userspace.
--

commit b5ef0cd71d8dea661d93a7fc863b0b6ecc394576
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

CXL r3.2 8.2.4.20.12 and 14.13.10 permit committing an HDM decoder with
size 0. This patch allows init_hdm_decoder() to enumerate these decoders
with their hardware LOCK state instead of aborting the port. It also
modifies poison_by_decoder() to scan the unmapped DPA tail when a
decoder has no DPA resource.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..b61f51134551d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1096,6 +1100,13 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  	if (!committed)
>  		return 0;
> =20
> +	/*
> +	 * A committed zero-size decoder reserves no DPA. Leave port->hdm_end
> +	 * untouched.
> +	 */
> +	if (size =3D=3D 0)
> +		return 0;
> +
>  	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainder);

[Severity: High]
This is a pre-existing issue, but does the interleave ways configuration
here allow reading out of bounds of the target_list union higher up in
init_hdm_decoder()?

drivers/cxl/core/hdm.c:init_hdm_decoder() {
    ...
    union {
        u64 value;
        unsigned char target_id[8];
    } target_list;
    ...
    if (!cxled) {
        ...
        for (i =3D 0; i < cxld->interleave_ways; i++)
            cxld->target_map[i] =3D target_list.target_id[i];
        return 0;
    }
    ...
}

Since CXL 3.0 supports up to 16-way interleaving, if interleave_ways is
greater than 8, will this loop read past the 8-byte target_list.target_id
array and copy uninitialized kernel stack memory into target_map?

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e82..a353d8e7489d3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2907,38 +2907,38 @@ static int poison_by_decoder(struct device *dev, =
void *arg)

[ ... ]

> -	/* Iterate until commit_end is reached */
> -	if (cxled->cxld.id =3D=3D ctx->port->commit_end) {
>  		ctx->offset =3D cxled->dpa_res->end + 1;
>  		ctx->part =3D cxled->part;
> -		return 1;
>  	}
> =20
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id =3D=3D ctx->port->commit_end)
> +		return 1;

[Severity: High]
If this decoder is zero-sized and has no DPA resource, we skip updating
ctx->part and return 1 here.

If this is the first decoder on the device, ctx->part remains -1. Will
this cause cxl_get_poison_unmapped() to immediately return 0 when it
checks for part < 0:

drivers/cxl/core/region.c:cxl_get_poison_unmapped() {
    ...
    if (ctx->part < 0)
        return 0;
    ...
}

Could this result in silently skipping the poison collection for the entire
unmapped DPA space instead of scanning it as intended?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607081345.6195=
4-1-icheng@nvidia.com?part=3D1
