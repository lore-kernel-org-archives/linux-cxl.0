Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3933ADA7
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754627; cv=none; b=dsbCQPTgz7qbU+LYCLmqLXfNwr22iReYE2zFm/YW0A6mNzgcfGIo0wgVLxPQ9sfs8cZet2yQRjnafwbiFy9IOsOOkqVkd8rxlNzkqaDgFHNqPJGtEjDVpzwgvkflqboRW5/ftb92Xfdysomh5+8ON1UfhBXoP+PVUeTO1RG9ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754627; c=relaxed/simple;
	bh=RraXz3t5a7KNQICdJloaQwOpxndwlwhGHRykRJ97zeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lB/UHHZMkyGL6jfsNXvRi8dOdJiFrEQO6fp9eXc+DagEI2oUn0x3anpZe86J5flLSaI1aLsKd+psnrDfXinYWNJTZnlEqJuI3nwcDoSdnk8tiDV6xaBJ/8ngEzly+U00n9aijHtJg+ESg/7wbYbUat/igQqVAOudQAWGnsFHtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBW7r3vE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBW7r3vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33CE1F000E9;
	Wed, 22 Jul 2026 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754626;
	bh=NRn/iicgcXsdVfQTA1fGXR83jhPFV7JSPteAU3fOV9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBW7r3vE8dHgxeoiJPQSAa/dELeWkb3I78y3whlVhY6mVGT/cnLK0zvgMo/usfe29
	 nW75kkFn7yqOMhaUUamYH3x3Z/ohRWZ9LV5w+p8AohHkS4o46DNi2wCqw6nUUKQ+lY
	 qBAYS5M1s7RdwNyTLNWLyjqRW9w6zVxCAn/LirFSMCde65M/XSYOpnvNCIDXy9Q3H8
	 DMTNSqA1D/k4fR4SjblRt3ghCZWGM8UBG3Ibec9AUGYBxUaJaf6lUbO+r8KbNc/Av9
	 zOj2JIjKT9ZkUM4qpUr0KiGDDA+ORc+Kq+E25Xs0hJD8A+LtZ+zQ6TswpJUoTT73Lv
	 2OeHSy8dAH3tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] cxl/region: Guard against unset partition in
 poison_by_decoder()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260722205303.3184787-2-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
 <20260722205303.3184787-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:10:25 +0000
Message-Id: <20260722211025.E33CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The early return for decoders with `part < 0` skips the loop ter=
mination condition, causing iteration to silently continue past the last co=
mmitted decoder.
--

--- Patch [1]: [PATCH 1/3] cxl/region: Guard against unset partition in poi=
son_by_decoder() ---
commit 8424c8c335042ef0b39d03b8e79434f7d0ee9eba
Author: Dave Jiang <dave.jiang@intel.com>

cxl/region: Guard against unset partition in poison_by_decoder()

This commit skips decoders with an unset partition (part < 0) in
poison_by_decoder() to prevent an out-of-bounds access when querying
partition modes.

Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia=
.com?part=3D4

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..ec0dc4284c3c5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2959,6 +2959,9 @@ static int poison_by_decoder(struct device *dev, vo=
id *arg)
>  	if (!cxled->dpa_res)
>  		return rc;
> =20
> +	if (cxled->part < 0)
> +		return rc;

[Severity: Medium]
Does this early return bypass the iteration termination logic if the
commit_end decoder itself has an unset partition?

Looking at poison_by_decoder(), returning early here skips the termination
check at the bottom of the function:

	/* Iterate until commit_end is reached */
	if (cxled->cxld.id =3D=3D ctx->port->commit_end) {
		ctx->offset =3D cxled->dpa_res->end + 1;
		ctx->part =3D cxled->part;
		return 1;
	}

This would cause device_for_each_child() to continue iterating into=20
uncommitted decoders instead of returning 1 and stopping. Because the=20
iteration would ultimately return 0 instead of 1, cxl_get_poison_by_endpoin=
t()=20
would then fail to trigger the subsequent cxl_get_poison_unmapped() call.

> +
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;
>  	mode =3D cxlds->part[cxled->part].mode;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722205303.3184=
787-1-dave.jiang@intel.com?part=3D1
