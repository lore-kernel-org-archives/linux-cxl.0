Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA35C613
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148255; cv=none; b=bp6GsRcRq/rSOkfv0inmzYJdffTVEHF9/skLdiPYOOXetlce8cym3boE8lg38wzOVotnscFIL+VA9p+WC7OmtQPfEosF7rLWeBG0DUCrTr4SrYfWM0dRDYOoE/55KqMQJsriBeBkuUGFpVAYgpbiaVsn4OTctIfxq+59DO04QDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148255; c=relaxed/simple;
	bh=qpp131HbZvIBUgcrRw99Xi6sQXf4akPlHNG3dof7+mY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+5h1DcbNa5+UTAFntRgZnYrHZS755vFZh/hHaavkFlqRcdO5Uso+s2rUkWAKcEKq377R3T1uVv/nczVpYZgl0avn6pVRXsMbXiK7S9k9Ss0BHsYa5mLNRmuOHbio3MVysgOKeCaHK/3np+7LOK0SP6ZdYUl+WJnzTp5mxTSrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3SB0Xvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3SB0Xvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ACD1F000E9;
	Sat,  8 Aug 2026 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786148253;
	bh=63wd9wQP5XEMbfTZovNfKHk5VVz75IHrAXFZFKAUPxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3SB0Xvl933wSQx0um/kWKf4pK3v7ke/DiNILQ1/UweWrKM8XXzL4hMZKqMlrzaWM
	 oK9pq8St4pa6FdRd5FZQyvQLwncXiBEiaI8s42xi8CuEeZOXudHRZIk5T6TQ/ebHyv
	 yfKq7g3RtgRHlnQ+hBehw55c7iVOxkKYrDPEI5jGeZyQV5igbiv5SXd3NANSAZciK8
	 37YwQNu7Zez9yNzXsiHjSStVGbAKJEFj3XGGtINREb/CIjoFmxYY0uvHAwF8cFd7VP
	 HtiLSNiYzLdq7CYa0lLxpoxjShLGfTPHSPIDmS4FX25yusi0pGwCCQLQtrT1DMLfTn
	 c9eDkt3LiKfaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
 <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 00:17:32 +0000
Message-Id: <20260808001733.52ACD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect parsing of the target list register on Big-Endian archit=
ectures.
--

--- Patch [1]: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave way=
s that overflow targets ---
commit f23bc6bdfaf477309897aefc0c8b1cee5f060c37
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Reject switch decoder interleave ways that overflow targets

Switch decoder enumeration validates that the interleave ways encoding
is legal, but not that the resulting number of ways fits the available
targets. This can overrun the target array (target_list.target_id[])
during enumeration of 12 or 16 way interleaves.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofi=
eld@intel.com?part=3D1

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..c394b3d54d362 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1084,6 +1086,16 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
> =20
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> +
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
This isn't a bug introduced by this patch, but does this logic in
init_hdm_decoder() parse the target list register incorrectly on Big-Endian
architectures?

Because hi and lo are in CPU endianness, on a Big-Endian system the shift
operation places the most significant bytes of hi at the lowest addresses of
the target_list.target_id array, effectively reversing the hardware target
IDs.

When the 64-bit target list is read out sequentially as an array of bytes,
could this result in physical memory addresses being routed to the wrong
target ports on Big-Endian systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786143520.gi=
t.alison.schofield@intel.com?part=3D1
