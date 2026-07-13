Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1B78F3A
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976421; cv=none; b=lkvRVvcmW6gEElk9MDrFUp2FVMkh62lXLbYML2wor5dw/ftL2NGhB/bJ8dLXfNq7k2LUsqoa+NCcLyaj8eTH8IvUYphqaQ4cLy/pAiRogMS3qKSzrvuZRmf7LuI72UKajgBk6dCFbRTWk1KpoKSONTnjepRXnMNjWIHe+SBvWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976421; c=relaxed/simple;
	bh=gbhUICRk4x2oJFBgx+xQ0lwPYtqvqk55150GMr0ilN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CgWZnjz4uXMIxhImOVOzcn9QHBudK7QxBRjkOeKGH2cz1B6oFyv9S9VqCMjRDWygjetuPID3Qa5L3VpJNEYGABfpRu7wzF3Fv4Y9YaS/brFGaE+bjwWIXfqWTlSWKBHnSbz5+6zsXKyWMm+3XXlcKHQP4ZiYmjG9nfAPRtvOojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2oc0hBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2oc0hBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F61F000E9;
	Mon, 13 Jul 2026 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976419;
	bh=WNep0vBiedc1hiS3+oAc+2Gzy7tZzu1FW0Vote0FBWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2oc0hBGQT+ahJy9WOs09tjkz2zWhc3ExV5AsQhKN1HIEvW1/MzjmrgP5JX9O09uQ
	 o6vXEKzQoA/Sw0NVXMSd/NaYY8yvcYtYkJo5lCYrQIqhaUC2HHgzISSoCz5DFw71hc
	 ElCQswwq2B+IPe6MfyACVc0pesm7dooYKXlAtar53LTTqjO7p6dohYJNwzE+3VSaAI
	 do10WT19iHUAPXRinHt0ODyC28Dp0sP0/0evuk7UlLLhaBG1Ih3usQ8BWUlqKPJh+o
	 WlRC9ChuO1IacuVHTmc6JlqcJcEd26lgk+kDj0O+bOKVvYE0dp20SlVHXJc6bwYOG6
	 pd3jLjQuY/vKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] cxl/hdm: Reject switch decoder interleave ways that
 overflow targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <dad02aebdc2d82537d779ddff459c8c4b5a614da.1783974681.git.alison.schofield@intel.com>
References: <cover.1783974681.git.alison.schofield@intel.com>
 <dad02aebdc2d82537d779ddff459c8c4b5a614da.1783974681.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 21:00:19 +0000
Message-Id: <20260713210019.A74F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Validation of `interleave_ways` returns a hard error for uncommitt=
ed decoders, causing a fatal probe failure if an inactive decoder contains =
leftover or uninitialized configuration.
- [High] Due to a preexisting off-by-one error in `nr_targets`, the new che=
ck `cxld->interleave_ways > cxlsd->nr_targets` will falsely reject valid ma=
x-width interleaved configurations.

Pre-existing issues:
- [Critical] Target list array accesses are endian-dependent, leading to co=
rrupted target mapping on Big-Endian systems.
--

--- Patch [1]: [PATCH 1/3] cxl/hdm: Reject switch decoder interleave ways t=
hat overflow targets ---
commit 0f855df703f711546a94bba79b4742022fb3bae7
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Reject switch decoder interleave ways that overflow targets

This commit adds validation during CXL switch decoder enumeration to ensure
that the number of interleave ways does not exceed either the hardware
target list capacity or the reported target count. If the ways exceed
these values, enumeration fails with an error to prevent array overflows.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofi=
eld@intel.com?part=3D1

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1084,24 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
> =20
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =3D
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {

[Severity: High]
Will this return a hard error for uncommitted decoders?

If an inactive or uncommitted decoder contains uninitialized or leftover
state (such as from BIOS) in its control register, this bounds check will
fail and return -ENXIO.=20

Because this validation happens before checking if the decoder is actually
committed, does this abort the initialization of subsequent decoders and
prevent the CXL switch port from probing?

devm_cxl_switch_port_decoders_setup()
  -> devm_cxl_enumerate_decoders()
    -> init_hdm_decoder()

> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\=
n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {

[Severity: High]
Is cxlsd->nr_targets a 0-based count?

In parse_hdm_decoder_caps(), the 0-based hardware capability "Target Count"
is assigned to cxlhdm->target_count without adjustment, making
cxlsd->nr_targets 0-based (where 0 means 1 target, 1 means 2 targets, etc.).

Since interleave_ways is a 1-based exact count, won't this check incorrectly
reject valid configurations?=20

For example, a 2-way interleave across 2 targets evaluates as 2 > 1,
incorrectly returning -ENXIO and preventing CXL memory enumeration on valid
hardware topologies.

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

[Severity: Critical]
This isn't a bug introduced by this patch, but does assigning
target_list.value this way cause endian-dependent target mapping on
Big-Endian systems?

By reading the lo and hi registers and combining them into a host-endian
64-bit integer, accessing it as a byte array (e.g., via
target_list.target_id[i]) will read the most significant byte on Big-Endian
architectures instead of the expected byte.

Could this lead to memory traffic being routed to the wrong CXL target on
architectures like PowerPC or s390x?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783974681.gi=
t.alison.schofield@intel.com?part=3D1
