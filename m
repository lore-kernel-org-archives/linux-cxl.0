Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70993DD532
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914139; cv=none; b=kFWMkGl5yh6Ujt85Bro+WDPigh/UDhIJiy1AMwOheECqfRj4/6AyojvL84I047qbItorGBq/9pxO59vvMtSZ05TmepMFw4kbVhpSk/ZWE0AkmM7CmM4jg9rrTbSfy4qWg0dPty4gbtljSXPBLttRFYCKgy1vt4VZ3jISSsUFKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914139; c=relaxed/simple;
	bh=01AZ7jgw3MxZtL8/iwCTcOMzlTdXh9QN1qEZE47UMoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1TikPSF1xP03RuJqEvngPVFsZXl9zhSSOzRSn6gxsugAIL2Q2dL41EBkMio4DkfsXhTNk/80Opb1mstA8xZuS5mW7hJjGVZ+DcgS5T52stimtHc16RK2GzeumLEcjz8WXfohtsu/QjANO6YcuA22wuvsH8BYPDiyYnmCaxGjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx0gwdjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx0gwdjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546561F000E9;
	Wed,  5 Aug 2026 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914138;
	bh=RTgP5WuJGB8A4YApY+rCjPjkHIWkC2CCRV7WLGQGM/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kx0gwdjmpw0kSFEPr1p9eF2UcwxGqLhohrAURQP1zRYgpZKM6PFyXyywc6SP0vhgu
	 XnROIMdNYR9YlgF8/7y+6jVS7k1XdyQcCoXho1Bs/6pu4GO5Vceb2BT/xoYeCJ/FjZ
	 WD4RfDzxJ+IGK/LYNboUZRnEvj1RmTZggVkDik/JJOY5HVKO25Hi/scbBFOQq5LfBu
	 anRoZn4bYkjq4Fk077gKrYKNIBBW9eFtnRvEKYw/B5rvlLx1Fumg8zXBFQjZg/JCEw
	 CqlGN3exF7MfFa9e5GhjsPBxrIMesQvc3ByjbcC5+EkKjYOZ00hY1ZRWiCIkpC2NZV
	 2lDuZ7jI/YCeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/region: Add cxl_decoder_is_passthrough() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805065935.27837-1-icheng@nvidia.com>
References: <20260805065935.27837-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:15:37 +0000
Message-Id: <20260805071538.546561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `cxl_decoder_is_passthrough()` incorrectly identifies single-tar=
get root decoders as passthrough decoders, contradicting the commit message.
--

--- Patch [1]: [PATCH v2] cxl/region: Add cxl_decoder_is_passthrough() help=
er ---
commit 9b921fd6e2f183466d76ed78181b72b15a45105b
Author: Richard Cheng <icheng@nvidia.com>
cxl/region: Add cxl_decoder_is_passthrough() helper

This commit abstracts the passthrough decoder check into a standalone
helper function. The commit message explicitly notes this is necessary
because checking only for a NULL ->commit() would incorrectly identify
root decoders and DVSEC-emulated endpoint decoders as passthrough.

Link: https://lore.kernel.org/linux-cxl/20260727103743.63343-1-icheng@nvidi=
a.com/

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> +/*
> + * A single-dport host-bridge need not publish an HDM decoder capability
> + * when passthrough decode can be assumed. The resulting decoder is a
> + * software-only construct with no registers to program, so it carries no
> + * ->commit() operation, see devm_cxl_add_passthrough_decoder().
> + *
> + * A NULL ->commit() alone does not identify one, it is also NULL for
> + * DVSEC-emulated endpoint decoders. Test the decoder type and target
> + * count as well.
> + */
> +static bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)
> +{
> +	if (cxld->commit)
> +		return false;
> +
> +	if (!is_switch_decoder(&cxld->dev))
> +		return false;
> +
> +	return to_cxl_switch_decoder(&cxld->dev)->nr_targets <=3D 1;

[Severity: Medium]
Does this helper correctly exclude root decoders as intended?

The commit message states that root decoders leave ->commit() NULL and
that a future caller testing ->commit() alone would silently include them.
However, looking at is_switch_decoder() in drivers/cxl/core/port.c, it
returns true for root decoders:

bool is_switch_decoder(struct device *dev)
{
        return is_root_decoder(dev) || dev->type =3D=3D &cxl_decoder_switch=
_type;
}

Since is_switch_decoder() evaluates to true for root decoders, won't this
function incorrectly return true for single-target root decoders? This
appears to create a misleading abstraction that contradicts the commit
message's claim about ruling out root decoders.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805065935.2783=
7-1-icheng@nvidia.com?part=3D1
