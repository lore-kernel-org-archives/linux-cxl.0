Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321C2EC57C
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153075; cv=none; b=mIpgB6kDBieuVgQpegXQOn2uykfbqAR3HJEakO9VA7AypwnxLyYNxXSu6tqRmujyzxwfFA5wFowMajDxHzpOqBOBfDJjawWh7DWh+kJ51M3J29U9kQacjcqbAUsApACp8s81JSIWZlGkz9+UedFfEHCvGUxD8UR+vjR2NU6C9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153075; c=relaxed/simple;
	bh=rJnXvhk9qs12ECMaZNSLHHdgFoUa5r5DIPa6jPDL0sA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljEyVDhD2J7/XrFc0mBB2ZD6sM4jMLxmuRs8cyOEfQrxH0JvzNOo2OJHwlwHw7CJbs9jM9rbE59WYMIJFjBlbMvPdI+boyGRpE4g+973Qu1OrtY2kElkWl+raVhsC11Qm2xJMHabZPDffufTHfjh9orfuHSFZQXio1tvrejNcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1BzaQd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1BzaQd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500451F000E9;
	Wed, 15 Jul 2026 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153074;
	bh=TCQ6yIM8mjuDHCkEM/h1LxZUguovHX0ChlQYGeRVbLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1BzaQd1nnwzk3GgYzb8+osMJcFrSl3KiWekKc5CXBgF25HQ0RGBtUzjQ3ZkcCCRk
	 XaRg5wWw4v+nb32oebivNQmTVGPxCU8ohliXn96vAbXpHvcs0G+W195eb7B2zWlIx5
	 SFXdUnLRX0Vy4VA1Vj2WYWDLMXt2qf9WH3jV18fEQCF/YcnQMl0e17UI/VE0pEL+xA
	 kUMBmfvvixJSkdHuCZlxUXuYjHejTTuzi2tqu07i90Qt/J/8HvYx0vuPYc8z172ql4
	 b65N0UmU0WsGmV16nX6NNKZKcoxXUaijqunjqOIxbB715NU2inl2uO+HucmLVoB1gO
	 /rYF5CuSnuTNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:04:33 +0000
Message-Id: <20260715220434.500451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Extracting target IDs from the target list register assumes little=
-endian byte ordering, causing incorrect target mapping on big-endian archi=
tectures.
- [High] Failure during decoder initialization leaves `port->commit_end` in=
 a dirty state, permanently breaking subsequent device probe attempts.
--

--- Patch [1]: [PATCH v2 1/3] cxl/hdm: Reject switch decoder interleave way=
s that overflow targets ---
commit 4660ad9cd44e7b73b9a24a494a4fb73e7c2f2eaa
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Reject switch decoder interleave ways that overflow targets

Switch decoder enumeration validates that the interleave ways encoding
is legal, but not that the resulting number of ways fits the available
targets. This can overrun the target arrays during enumeration.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofi=
eld@intel.com?part=3D1

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..9f005f3193e2f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1084,6 +1086,30 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
> =20
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =3D
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways =3D 1;
> +			return 0;
> +		}
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\=
n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
               ^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but will this early return leave
port->commit_end permanently modified?

Looking at init_hdm_decoder() earlier in the function, port->commit_end is
updated when the decoder is committed:

	if (committed) {
		...
		port->commit_end =3D cxld->id;
	}

If the initialization fails here due to exceeding hardware capacity, it ret=
urns
-ENXIO and aborts the port probe. However, port->commit_end is never revert=
ed.

If the driver is re-probed, the next initialization attempt will falsely re=
ject
the first decoder as 'Committed out of order'. This happens because
cxl_num_decoders_committed() uses the leaked commit_end state.

Should this error path revert port->commit_end before returning?

> +		}
> +
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does extracting target IDs from the target
list register using a union byte array overlay cause incorrect target mappi=
ng
on big-endian architectures?

When init_hdm_decoder() reads hardware registers TL_LOW and TL_HIGH, it
converts them to native CPU endianness via readl() and stores them in a nat=
ive
64-bit integer.

The function then extracts target IDs using target_list.target_id[i]. On
big-endian systems, byte 0 is the most significant byte of the 64-bit value,
rather than the least significant byte.

This could route CXL transactions to the wrong switch ports.

Does this logic need to be adjusted to avoid endianness issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784150131.gi=
t.alison.schofield@intel.com?part=3D1
