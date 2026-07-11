Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CB2AD35
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793991; cv=none; b=pg9zzgMcm/mBjJ9mRge6osGxVdJyXQe1yWaUcZqRhNnGvyRCMLIPRMfRvJ8YQMCAWwjxZCGOMCFkUpciooOKhtHb3mx+S6sF90LGvqudZhcGcyxLXU+sc1eBsTM9PylKBZ8gx5l7gqguhQQUw0sEGsmwLN/L4B0nH+u1iqfDzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793991; c=relaxed/simple;
	bh=HGc576J1hugV7CvVVJYvUppmhEoHcUWNlgDVYWPNLe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EkZYuBA2Hn/t8Zqo7UOsfujh6SXDY2CcmyLR26PYf1hRisQbCxhsf+hvElrBB0DQf2NwmlALDZMo8ANVReVYTV888HBHzowZlC04E7f2M3yWpCWlwldNbTRndOYvbThMfQg3G6PTfvAHpMi+9YUtEjG4Z3W8G6TIVDk+QyZ/WmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZlnsWO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZlnsWO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B1D1F000E9;
	Sat, 11 Jul 2026 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793989;
	bh=Dt3RtagrU5kL3aFrYqU/qPSJ402/WyBp2aSUq5NwA8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZlnsWO43UQ784ImKecmPy+9CVeNneVheN0rDzwBSeleO1SQAtH/7jq6dG2D0oyp4
	 rmbI+VBIZmEnGidcqyNqmcQ2abcwJaJQhsGTcAsnqrI3/CDkpujp3gzi44psMlJkn+
	 8YyKruAtiI/C2ZXdmNGYBxAlXMjx4of2cSz4f8DVF+9zoJy0Tvyhj28LXa9AJAMhSH
	 RPYh0BnjtBd9Z8wMlqd9YGOStOYQXGBEOmHxkVjZdZr3W26e1RY1WzDVbfA2LfmI2J
	 Sduz8SB9cHEQb7WfFto1la1XMQxQfPG0scC+lhqmALZzhbVEOoEKqJUehONV/8dWou
	 q86W95MdE0uOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways()
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260711180755.1779002-1-alison.schofield@intel.com>
References: <20260711180755.1779002-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 18:19:49 +0000
Message-Id: <20260711181949.A4B1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked `interleave_ways` value from untrusted CXL device leads =
to heap out-of-bounds read and write on the `cxlsd->target[]` flexible arra=
y.
- [High] Out-of-bounds read of stack variable `target_list` when initializi=
ng HDM switch decoder targets.
--

--- Patch [1]: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways(=
) error path ---
commit 1c57e04f0aa13be6ae927836e151c3bc815eda70
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Fix use-after-free in find_pos_and_ways() error path

This commit drops the reference to a switch decoder after logging an
error message that includes the decoder's name. This prevents a potential
use-after-free if it was the last reference.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..c86dd9d55e939 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port,=
 struct range *range,

[Severity: High]
This is a pre-existing issue, but is there a risk of an out-of-bounds array
access in this function and others when handling interleave_ways?

Just above this hunk, find_pos_and_ways() loops up to
cxlsd->cxld.interleave_ways and accesses the cxlsd->target[] flexible array:

	for (int i =3D 0; i < *ways; i++) {
		if (cxlsd->target[i] =3D=3D port->parent_dport) {

The interleave_ways value originates from the HDM Decoder Control register =
in
init_hdm_decoder():

drivers/cxl/core/hdm.c:init_hdm_decoder() {
...
	rc =3D eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl), &cxld->=
interleave_ways);
...
}

If an untrusted CXL device provides a small target_count but a maliciously
inflated interleave_ways, could this result in heap out-of-bounds reads here
in find_pos_and_ways(), as well as out-of-bounds writes in
decoder_populate_targets() and update_decoder_targets() when they iterate
up to the inflated value?

>  			break;
>  		}
>  	}
> -	put_device(dev);
> -
>  	if (rc)
>  		dev_err(port->uport_dev,
>  			"failed to find %s:%s in target list of %s\n",

[Severity: High]
This is also a pre-existing issue, but does this same unchecked
interleave_ways value cause a stack out-of-bounds read in
init_hdm_decoder()?

drivers/cxl/core/hdm.c:init_hdm_decoder() {
...
	for (i =3D 0; i < cxld->interleave_ways; i++)
		cxld->target_map[i] =3D target_list.target_id[i];
...
}

Since target_list.target_id is an 8-byte stack-allocated union, if
interleave_ways is larger than 8 (e.g., 16), could this loop read past
the end of the 8-byte array and leak adjacent stack memory into
cxld->target_map?

> @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port,=
 struct range *range,
>  			dev_name(port->parent_dport->dport_dev),
>  			dev_name(&cxlsd->cxld.dev));
> =20
> +	put_device(dev);
> +
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711180755.1779=
002-1-alison.schofield@intel.com?part=3D1
