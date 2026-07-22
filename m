Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF735DA55;
	Wed, 22 Jul 2026 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680710; cv=none; b=YqjP8NP03NWVND+NKdI7ZWTgqigoYmAjz7Y5UKuMQa5oJGUEpUdxH7LXcrVoOWpQDOxjRBKC87iBXG8zmQOlsn2oKWcxxfO6uk8dCKu6h1Iq6FwIMJWQpJ1Ig0CYTW9YHQ7k59u6rhX9oaZp6+uyOh0LBDPn+75AHH6Lm3IlW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680710; c=relaxed/simple;
	bh=7WCpiicdfrbOFG4Smvzzj+Wlq9LskuC9j5EChJV7P+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4vGr/7j9ayLJfWjYxZlh2dzfZrNeGwgEs53de17Bk+DicE6pIK0MBRDs5Yvn+GvWjvldhFZulIQ8AvIJnPfTmmqHXFMxR8YftW838+eGvyrofwuXtBH2p4L9JTLZhCi+ziLmLh6hZcPGa+bp8JWJXpRNka4TJ7DI0oVR4JauBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2EZgVjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2EZgVjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DDE1F000E9;
	Wed, 22 Jul 2026 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784680708;
	bh=2breS4CsG9zVovNRufqEcF1lRjALgGj8Udwl3sIqKaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y2EZgVjx9Y0YGrD7pHXsx7yDPSaKrliMNlWMuQAHVHCYdQRzKhpm+PY7gKuWXZKAX
	 mpJfAs1wLeXq9yVQFsklTU/MIAS2f1yLC063NtJ4q5Uwznw5ufCW+IDqlRQQ1c7+rU
	 01vJbypizOipYRgQt6Ps2xXCxdhJzwK5eD9jPgj375bgTVxwHBI/VL7oPNVWANdWB/
	 G4UTGP7UWgRmwHuzmq/v5BZitnH2zCd1BPT2t/jTwyYqMrvkCC/6UhaXAcs1AGhGdp
	 soj5hjbtU8yXr7DiNu5ycOjb7JmFVJluCaE0Gf9mIMr/zE+vGsgHv5vNZoEZ3bhyMp
	 Ii/HBCIMo1vsA==
Date: Wed, 22 Jul 2026 01:38:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <20260722013822.57335034@jic23-huawei>
In-Reply-To: <20260721085715.39322-2-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
	<20260721085715.39322-2-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 16:57:14 +0800
Richard Cheng <icheng@nvidia.com> wrote:

Hi Richard,

> CXL r4.0 =C2=A78.2.4.20.12 ("Committing Decoder Programming") and =C2=A71=
4.13.10
> ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> with size 0. BIOS may commit and lock such decoders so the OS cannot
> program regions through them, this is a design choice rather than a spec
> requirement.

Trivial but consistency in commit message formatting is good. I'd always us=
e a
blank line between paragraphs.

> The kernel rejected these with -ENXIO during port enumeration and aborted
> the whole port, so affected systems showed nothing under 'cxl list'.
>=20
> Treat empty decoders as first class instead of special casing them, back
> them with a kmalloc'd resource, since the resource tree can't represent
> an empty range, and keep the skip and hdm_end accounting intact. Guard
> the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> poison queries.
>=20
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dan Williams <djbw@kernel.org>

...

Main comment is of the 'whilst you are here' variety. I'm fine
if you want to ignore it.  I just found the existing code a little trickier
to read than the ideal and some of it gets shuffled round in here.

Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
>  drivers/cxl/core/mbox.c   |  3 +++
>  drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
>  drivers/cxl/cxl.h         | 10 ++++++++
>  drivers/cxl/port.c        |  3 +++
>  5 files changed, 83 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..ccbab2e21f06 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

...


> =20
> +static struct resource *cxl_dpa_request_region(struct resource *parent,
> +					       resource_size_t start,
> +					       resource_size_t n,
> +					       const char *name)
> +{
> +	if (!n) {
> +		struct resource *res =3D kmalloc_obj(*res);
> +
> +		if (!res)
> +			return NULL;
I'd format this a tiny bit differently but not that important.
The advantage is to keep the allocation and error check closely coupled.

		struct resource *res;

		res =3D malloc_obj(*res);
		if (!res)
			return NULL;

		*res =3D DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);

		return res;

> +		*res =3D DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> +		return res;
> +	}
> +
> +	return __request_region(parent, start, n, name, 0);
> +}

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..6c7d9a52707c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxl=
r,
>  		return -ENXIO;
>  	}
> =20
> -	if (!cxled->dpa_res) {
> +	if (cxled_empty(cxled)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
> @@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, =
void *arg)
>  	if (!cxled->dpa_res)
>  		return rc;

Whilst touching code can we just return 0 for this and the one above.

The return values from this function are unusual so nice if we can make
them as obvious as possible!

> =20
> -	cxlmd =3D cxled_to_memdev(cxled);
> -	cxlds =3D cxlmd->cxlds;
> -	mode =3D cxlds->part[cxled->part].mode;
> +	/*
> +	 * Handle the degenerate case of a device with only empty decoders. An
> +	 * empty decoder can still map a non-zero skip range, so advance the
> +	 * walk to commit_end either way.
> +	 */
> +	if (cxled->part >=3D 0) {
> +		cxlmd =3D cxled_to_memdev(cxled);
> +		cxlds =3D cxlmd->cxlds;
> +		mode =3D cxlds->part[cxled->part].mode;
> +
> +		if (cxled->skip) {
> +			offset =3D cxled->dpa_res->start - cxled->skip;
> +			length =3D cxled->skip;
> +			rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +			if (rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM)

Maybe similar to below.=20

> +				rc =3D 0;
> +			if (rc)
> +				return rc;
> +		}
> =20
> -	if (cxled->skip) {
> -		offset =3D cxled->dpa_res->start - cxled->skip;
> -		length =3D cxled->skip;
> -		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		offset =3D cxled->dpa_res->start;
> +		length =3D cxled->dpa_res->end - offset + 1;
> +		rc =3D cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
>  		if (rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM)
>  			rc =3D 0;
>  		if (rc)
>  			return rc;

Maybe whilst we are here we can avoid the rc dance?

		if (rc && !(rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM))
			return rc;

>  	}
> =20
> -	offset =3D cxled->dpa_res->start;
> -	length =3D cxled->dpa_res->end - offset + 1;
> -	rc =3D cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM)
> -		rc =3D 0;
> -	if (rc)
> -		return rc;
> -
>  	/* Iterate until commit_end is reached */
>  	if (cxled->cxld.id =3D=3D ctx->port->commit_end) {
>  		ctx->offset =3D cxled->dpa_res->end + 1;
