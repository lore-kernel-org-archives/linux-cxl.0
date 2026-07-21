Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574923E49CA
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656234; cv=none; b=FnHbY19z78kX/rYGkSXSg49mZ4Z5ZvNrAzfjav3HYENYxoaaWnhz0md+7zT5F4adgXWGdcCNprCZ9qNyRgyfRx2vq8f96gS6cmVaRj6JVJab0CDHv/868xEI6UhNqTlEJQmthFCt3op4iJnS3IZcpL3OtTAS/EYJ73X/MbB4I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656234; c=relaxed/simple;
	bh=QOoK1wZYTz8JED0rzrPCmleCPnx1RvMwkqdDcnpw6Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nk53iE57M/tBQnX/ZzkBD5FP+1f++NEr/6Nj1VxRGeDUrrgA/q0e26jrQAnByhtJSG+eI7yvc8Aw9qCkFNOqwMJ6E4lgwXsa/BLJKtGYT0h7J46PXftgEAzkaYSIzWdy4CXRDc36GWsNP4H2eFZO8dikNprT6A3m0yG2YIHUUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVbH6Gse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVbH6Gse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0D41F000E9;
	Tue, 21 Jul 2026 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656233;
	bh=51oJapiBHkAes9zdE799WmixKmRLTnjKtSw70hLf03c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVbH6Gse01UswgtBk+ORkHc+3RcNIY/okE8R0tmqtNiIe/WUafvk1QR3I/GYwUIHA
	 A+8CQO7XmtDvqAN0rPZMLG2BgJCmiVeRmSelJ2xRfg0ZwBHXSgZSHSgEmOs89NFBtw
	 YOckdgnWDto/QUCuiW9mx98wXdc47LgT29oph9SOIoS312cxR8X3eP5lwpAIw/tBih
	 CO4l2ef+MvQPs8ZZ+3mjPErE2jI8Zjyi9H7tD1WTEdJYhgocUEh6fRaY1Tp2YIashf
	 kENb2yI5mZvcS9cs6qI8wkKBTPyo7k3RjVwgo1xmd5du3W7gBNaq38mWbB/lxlWww+
	 Ud9uegUHc+iqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:50:32 +0000
Message-Id: <20260721175033.0B0D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware-provided interleave ways can exceed switch decoder target=
 count, causing out-of-bounds heap writes.
--

--- Patch [1]: [PATCH v2 1/2] cxl/region: Fix use-after-free in find_pos_an=
d_ways() error path ---
commit bd336b4d1e6d9374287b7dbe87f0953733e4d653
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Fix use-after-free in find_pos_and_ways() error path

The error path releases its reference to a switch decoder before logging an
error that includes the decoder name. If the released reference is the last
one, the decoder can be freed before the error message accesses its name.
Drop the reference after the error is reported.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..c86dd9d55e939 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port,=
 struct range *range,
>  			break;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but I have a question about the loop that
concludes here.

In drivers/cxl/core/region.c:find_pos_and_ways(), the code iterates up to t=
he
interleave_ways read from the switch decoder:

	*ways =3D cxlsd->cxld.interleave_ways;

	for (int i =3D 0; i < *ways; i++) {
		if (cxlsd->target[i] =3D=3D port->parent_dport) {
			*pos =3D i;
			rc =3D 0;
			break;
		}
	}

Is it possible for the hardware-provided interleave_ways to exceed the swit=
ch
decoder's actual target count (cxlsd->nr_targets)?

If the hardware control register specifies an interleave_ways value that is
larger than the capability used to size the flexible array, could this loop
read out-of-bounds from the cxlsd->target[] array?

Similarly, in drivers/cxl/core/port.c:decoder_populate_targets(), could this
mismatch also result in an out-of-bounds write when populating targets from
hardware registers without bounds checking against nr_targets?

> -	put_device(dev);
> -
>  	if (rc)
>  		dev_err(port->uport_dev,
>  			"failed to find %s:%s in target list of %s\n",
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3a36953b5c665cb9544=
ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com?part=3D1
