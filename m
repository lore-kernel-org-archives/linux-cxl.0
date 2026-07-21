Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40B3FF8AC
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600081; cv=none; b=G4nTItuHLwTmmS55I4zvS6fm/F+b7zD5NLE/SOTURvPwfnJmDjO+HoxFUwb4CW56PKiv7nmu2zcss6/QVeEp7pwujWpIThX5a+ykH1LVWiKtUxJm3xwq/AMJjPGCwmv/bZ7PLvqv6VSo8BN6GXDuHMZ80UGDCgE/dQEEvzm68Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600081; c=relaxed/simple;
	bh=Kf0zhPHRGAgcqWledFN2SNELL2zxqYabNee0BsG+jmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vE9oLxlcJ5jC2Zedm17VhGOXXzEjHv5bzkx00HCZ+yR9qKfwyUTBfzPXtt0pv7gi4u/szF4mR2qU3M224csvfs5eQwL7Hs0ml3DZxs9wbd+J2kL/NAxtvZmaeLV7HgRfUOlXGgKQ1d5w98htqOwYErjbP7oyT09mO9uLZM9zfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+S+10o8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+S+10o8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A171F000E9;
	Tue, 21 Jul 2026 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784600080;
	bh=AAMTD197SpGwmeYOZt6XrN7S8p/gnbdk0LHzxXmHHB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+S+10o833HW/bTmS7xr78GOGjv2VDFmXLDv7jsdP6u6ok+b0oVCnBak5JPfzCrPh
	 w9Ph5HgmhdNgAmdEVa7HVZspejs50av+sm59JE69KoATzk7HbhLQwGwjjrHE5od5Pf
	 sad47Roahefa6++xAzEdox/bMGDrw98C1mfbp5Tosnq4jfyixd1NfK8AithQxVj9CK
	 N7Rbn1k77keGKHeLTIG4eSJAYo0E/spYE8TIjbEiuF6P2blLeI/tgdiK5/uuD/iDjY
	 YZAQQVP+W4voV2sqhpeAuFuSZpSK48Y+WHRUWJLNLQ9t0NndX1s6Bdrke602MxAIvH
	 334MQKp2tyLsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:14:39 +0000
Message-Id: <20260721021439.E3A171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch fails to reset `interleave_ways` for uncommitted endpo=
int decoders, contradicting its stated intent.

Pre-existing issues:
- [High] Reading the switch decoder target list via a union results in inco=
rrect target IDs on big-endian architectures.
- [High] Unconditional parsing of interleave properties aborts initializati=
on for uncommitted decoders with uninitialized registers.
--

--- Patch [1]: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave way=
s that overflow targets ---
commit 6b69d832bd669e734938484bbf51cd067e822152
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Reject switch decoder interleave ways that overflow targets

This commit validates that a switch decoder's interleave ways fit
within available targets and the hardware capacity. Uncommitted
decoders have their interleave ways ignored and reset to one,
and decoders reporting zero targets are rejected.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofi=
eld@intel.com?part=3D1

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..d81df45d8005d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);

[Severity: High]
This is a pre-existing issue, but does unconditional parsing of interleave
properties abort initialization for uncommitted decoders?

If the control register of an uncommitted decoder contains an invalid
interleave value, eiw_to_ways() or eig_to_granularity() returns -EINVAL.
This fails init_hdm_decoder() and aborts port enumeration before we can
check if the decoder is committed.

>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =3D
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (cxlsd->nr_targets < 1) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: reports zero targets\n",
> +				port->id, cxld->id);
> +			return -ENXIO;
> +		}
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways =3D 1;
> +			return 0;
> +		}

[Severity: Medium]
Since this reset logic is inside the if (!cxled) block, does it incorrectly
skip endpoint decoders?

For endpoint decoders, cxled is non-NULL, so the execution bypasses the
if (!cxled) block and won't reset the value. This seems to contradict the
commit message's intent to reset interleave ways for uncommitted decoders.

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
> +		}
> +
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;

[Severity: High]
This is a pre-existing issue, but does reading the switch decoder target
list via a union result in incorrect target IDs on big-endian architectures?

The logic combines 32-bit CPU-endian integers into a 64-bit CPU-endian valu=
e:

    target_list.value =3D (hi << 32) + lo;

On big-endian systems, the highest byte of this integer is stored at index =
0.
A subsequent loop reading target_id[0] and assigning it to target_map[0]
would entirely reverse the CXL target map.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784595445.gi=
t.alison.schofield@intel.com?part=3D1
