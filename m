Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4D1D5CFE
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450980; cv=none; b=RcR/tJbrgxWI58yzwsPd78YDI+pReCgEdeQvKD4n/9s1r/6cChilK3gCmXNItck0VFGV2QIxQR/X/k3FFeI0bGzxK90uTPsR+BvAEYtUTp4YU93oi+3lWCOm7Ymxzz/QuJw7JXLCsBQGspgMJtQnlDNjJTsJBH+Q3UhEBiU3m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450980; c=relaxed/simple;
	bh=oZ6EiqsoxVsnXzwW1sK0COvBMw4qk9ezHfuLkFpQgbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMQv8MAB9mOfe20InvHn+T+t1vdLZo20oipSG05ac9ieQ7Zit/S/m4RQoznTYNQcgQ2oyws8vhiWqmzvmdfxUcD4oLHpdQNITgv2PHF7wYg9jtCp/HzfDQH12mJCK/5kBUTIkk5j1T0UUmtjKX04Js1KXa1j36lTL0bq9wkGC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgfB8UDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgfB8UDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CAD1F000E9;
	Thu, 30 Jul 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450979;
	bh=X/S79tpeM8XOswxypKaNUBpp3sHXiETFlBvFmINbYeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgfB8UDBpo8pdjfZBnyS54CxQ/wqlscdImo0vwpDl+7Ix3Hziz+o3Kb3fLbHgKF0A
	 oNI+hG2GQwx6Zt/4vwMDQpo7lY4wsPJtfjThZGt304i0y9r/2kTXkVYUkKyj1iwFiw
	 7O28vjmIiAF1jzOYcM0Lw/Ax4CM86MFu4C+dvOD39/BqjTL3oUzjz3/Rt+GT9l7LCq
	 of5oE1NgLdiP5ZX72JjaxS30zDaoemk3eY3LQqMuhTcS8gYmcKz1Sf8vzqJ7PZU259
	 9AWCugCRSf+LeZ/sAPYQIJxPyvQmddbq8bb3Iq9giEmz9Yn5fLJ4gk4M82vOUh/VIV
	 h0uTuHyQBSTCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] cxl/region: Factor port target calculations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:36:19 +0000
Message-Id: <20260730223619.93CAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The target count check `iw > 8` incorrectly blocks 16-way interlea=
ving for switch decoders, contradicting its own documentation.
--

--- Patch [1]: [PATCH v3 1/9] cxl/region: Factor port target calculations -=
--
commit a455145f1f8fa170cab75f1f658966ee9cf551ab
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Factor port target calculations

This commit refactors calculations for interleave fan-out, port decoder
granularity, and endpoint distance into dedicated helpers. It also removes
parent decoder validation from this path.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..1082db7b2cca9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {

[ ... ]

>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
>  	 * decoders only support powers of 2 up to x16.
>  	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +	if (!is_power_of_2(iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
>  		return -EINVAL;
>  	}

[ ... ]

> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}

[Severity: High]
This is a pre-existing issue, but does this hardcoded limit incorrectly
prevent 16-way interleaving for switch decoders?

The comment above this validation states that switch level decoders support
powers of 2 up to x16. However, if iw is 16, wouldn't the iw > 8 condition
evaluate to true and unconditionally fail the region setup by returning
-ENXIO?

Could this limit be updated to allow iw up to 16 to match the hardware
capabilities and documentation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785444498.gi=
t.alison.schofield@intel.com?part=3D1
