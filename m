Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C023E334
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650055; cv=none; b=Wew0YqwQYee+H08jmWMguveenf9J4do70vf88VD6IPUetmk9IZFzUuUIOFOZiTazifmEOrvyp+D1SndQkQBxJGIsvJRnT8HafIvB1lSOb74hZ7OHUrMxWxRNM37bM6cyBFeU4jSTA655CIp3Yr4MAmtclsjvpxV9tuO+hVlVQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650055; c=relaxed/simple;
	bh=UsTsfheHJqLHHFDljS2OU6ER2ekh0/QcOTko8+N43L0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=olam9wbMWuV2KE6qXWmDoTv9oNgSKzhSZ1meVqXJL/l7qOiFk/cAihglgEfJKosTpOC7aijgvImihMNDYZxEms9i0Rn57mOcim/IqopeLQBV57VVBt2ycqCy3UigWj5o9Eddk8i+IsXNxTMjalAf/WKuEb+WCBCh/CURxkrbOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4TDmpuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4TDmpuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE71F000FF;
	Sat, 10 Oct 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791650053;
	bh=B6pQmkrvmt2JZmGFrSWJZi/FFIoidIyhp6iLBV/2dY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4TDmpuYtHd+WbYIga7uY/aj6iSgWnk4vTV9m2M9dK2xEXoVXnlWH6xoKRc4rv6GD
	 8IpGuMAKZYpKZW3EfcFWM9kRBC4URkcKkMr8BwJ6i/vvIV1AqOh/cwXjdWyv5z9bAQ
	 cY+Q67kCblqfGZ4sYMrZIUqKQzVJHGYdtnGTchAz5mtGOI6cpMyn8IxNpJtUmCGM8X
	 w/cmEACxCjA1FusVd4wVCiZyug4YwOWxGiYf0YOhVDueVK6Jr2oCUMQgZztkvzz9Gc
	 TJ3qA9SmAV4mSBy6CiWftShx+2Vw9VwgeyxyFwL/IZbr2omBu1lImtU2xHW/x73jQh
	 XpzyEsQGXmfrg==
Message-ID: <sashiko-outbox-166744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] cxl/region: Factor decoder poison-list
 retrieval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261010162017.62506-3-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-3-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:34:12 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/region: Out-of-bounds read on cxlds->part when cxled->part i=
s -1
--

commit 15ab3ed0729f2bd36a81eed918520197e4a18f3a
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

cxl/region: Factor decoder poison-list retrieval

poison_by_decoder() performs two different operations: it queries an
unmapped DPA gap preceding an endpoint decoder, then queries the DPA
resource assigned to that decoder and its region.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75b8092e6dc2f..c72524923b380 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2940,6 +2940,40 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  	return rc;
>  }
> =20
> +enum cxl_poison_query_policy {
> +	CXL_POISON_QUERY_DIAGNOSTIC,
> +	CXL_POISON_QUERY_PREONLINE,
> +};
> +
> +static int cxl_get_poison_by_decoder(struct cxl_endpoint_decoder *cxled,
> +				     struct cxl_poison_snapshot *snapshot,
> +				     enum cxl_poison_query_policy policy)
> +{
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	enum cxl_partition_mode mode;
> +	u64 offset, length;
> +	int rc;
> +
> +	if (!cxled->dpa_res)
> +		return 0;
> +
> +	mode =3D cxlds->part[cxled->part].mode;

[Severity: Medium]
Does this code read out of bounds when cxled->part is -1?

If a CXL device's hardware decoder configuration reserves a DPA range
that does not map to any valid partition, __cxl_dpa_reserve() gracefully
warns but returns success, leaving cxled->part =3D -1:

drivers/cxl/core/hdm.c:__cxl_dpa_reserve() {
	if (cxled->part < 0)
		for (int i =3D 0; i < cxlds->nr_partitions; i++)
			if (resource_contains(&cxlds->part[i].res, res)) {
				cxled->part =3D i;
				break;
			}

	if (cxled->part < 0)
		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
			 port->id, cxled->cxld.id, res);

	port->hdm_end++;
	get_device(&cxled->cxld.dev);
	return 0;
}

Later, when iterating over decoders, it skips the !cxled->dpa_res check and
unconditionally executes mode =3D cxlds->part[cxled->part].mode.

Since part array is embedded inside struct cxl_dev_state right after
dpa_res, part[-1] reads the tail padding or end of dpa_res within the
same memory allocation. This uses garbage data for the mode variable,
which can improperly mask -EFAULT errors if it randomly matches
CXL_PARTMODE_RAM.

Note that the pre-existing caller logic in poison_by_decoder() also retains
this out-of-bounds array access before invoking this new helper.

> +	offset =3D cxled->dpa_res->start;
> +	length =3D resource_size(cxled->dpa_res);
> +	if (snapshot)
> +		rc =3D cxl_mem_get_poison_snapshot(cxlmd, offset, length,
> +						 cxled->cxld.region, snapshot);
> +	else
> +		rc =3D cxl_mem_get_poison(cxlmd, offset, length,
> +					cxled->cxld.region);
> +
> +	if (rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM &&
> +	    policy =3D=3D CXL_POISON_QUERY_DIAGNOSTIC)
> +		rc =3D 0;
> +	return rc;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010162017.6250=
6-1-shaikhkamal2012@gmail.com?part=3D2
