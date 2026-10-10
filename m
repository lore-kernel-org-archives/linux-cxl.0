Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AF23E334
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649994; cv=none; b=ecGZ0AzpORD3wFJEFAOqIUiiITC6v5pplMtaWeiSs4/GZ0bZjVhfppVAWJihshrM29x5W+sR4jv3NaTPTIDRoI5rk5row3LBLElNYMleAtsBhnkjWaMIme6cDxKgQcf8hA08AJERi1ka4kzBFZ46JX2TaBJSvoTFjtkK4Iio05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649994; c=relaxed/simple;
	bh=fz9uJFBCz+8kobkAcK8GSofMrjCGFrAlTLfNLa3dUuI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V95C9s2hL1O2S8jaBjSqhP3GZ3DUO6PTOI5ZeJLb+SMXHAydG8/bURdFFtBC2scTniLfRYNZ8JH1oh7A6hUvVat1AuUvmuKuuZJXDrN41rsRBwYrH7TYmlGYBHmqzzAmF2ukWn4dDWNc9KtYvyJyS95TZ38eF5RA2zCzLZZo7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBRaaZVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBRaaZVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A91F000FF;
	Sat, 10 Oct 2026 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649992;
	bh=6bg6u/N7SLhPtqrXmnL3M2FykTTKJ5v1yR0bAST1b/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBRaaZVPQaI5k9Kz4YtaIe3YdUXVf3YhSJSOCfmpRcOV5am0GieC93zlc2K97RTnO
	 qdcxW10VP+EKKCinyaqDxrtnf9Q2W6fTJdJc6t0ulQ4HOsZXetny/aKwUoPf1Sx9jo
	 fhUK5zAFieROl6TmhWz3kYNz2i81yiNmAgiPUtUzcGk8s6quLNYNHgiBfUQgIdy80p
	 fGUcjFL5I3BJ3GA2j3ukqr579oL5GbJCK1wtMNIil8YMop4SzjDa1lz4qiGCF5289Y
	 lyLT6kATzKYkvvpkR3WtNrbN4vvq7rGGtls5gmeq74kqw8xaxgr7/6fW6I3LPoQNub
	 d+VraMJnqtdNg==
Message-ID: <sashiko-outbox-166742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] cxl/region: Register device poison before
 exposing RAM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261010162017.62506-6-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-6-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:33:12 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] cxl: probe abort due to strict -ERANGE return in cxl_poison_store_=
hpa()
- [High] cxl: infinite loop in cxl_poison_record_to_pfns() due to integer o=
verflow
--

commit 9d79e4bd40f84f47cf37cc9109545f12829756e5
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

cxl/region: Register device poison before exposing RAM

This commit retrieves device-reported poison lists during CXL RAM region pr=
obe
and registers them with the pre-online hwpoison registry to withhold bad
frames from being onlined.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c72524923b380..e3ffa77927df8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> +static int cxl_poison_store_hpa(struct cxl_region *cxlr, struct xarray *=
pfns,
> +				u64 hpa)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	int rc;
> +
> +	/* Outside this region: not ours to withhold. */
> +	if (!cxl_resource_contains_addr(p->res, hpa))
> +		return -ERANGE;

[Severity: High]
Does this error handling cause the entire region probe to abort when a pois=
on
record falls outside the expected range?

The comment notes "not ours to withhold", which suggests this is an expected
condition that should simply be skipped. However, returning -ERANGE here
causes the caller cxl_poison_record_to_pfns() to return the error immediate=
ly,
which bubbles up through cxl_region_collect_decoder_poison() and aborts the
entire region probe.

Should this return 0 instead to avoid failing the region probe when devices
return poison records that span outside the queried DPA range?

> +
> +	rc =3D cxl_poison_store_pfn(pfns, hpa);
> +	if (rc || !p->cache_size)
> +		return rc;
[ ... ]
> +static int cxl_poison_record_to_pfns(struct cxl_region *cxlr,
> +				     struct cxl_memdev *cxlmd,
> +				     const struct cxl_poison_record *record,
> +				     struct xarray *pfns)
> +{
[ ... ]
> +	step =3D clamp_t(u64, p->interleave_granularity, CXL_POISON_LEN_MULT,
> +		       PAGE_SIZE);
> +
> +	for (cur =3D ALIGN_DOWN(dpa, step); cur < end; cur +=3D step) {

[Severity: High]
Can this loop iterate infinitely due to an integer wrap-around?

If an untrusted device provides a dpa near U64_MAX and a small length, the
check_add_overflow() validation at the top of this function will pass. When
cur is initialized to ALIGN_DOWN(dpa, step), the cur +=3D step increment co=
uld
overflow and wrap around to 0. Since 0 is less than end, the loop condition
remains true forever, potentially causing a lockup while holding the cxl_rw=
sem
locks.

> +		u64 hpa =3D cxl_dpa_to_hpa(cxlr, cxlmd, max(cur, dpa));
> +		int rc;
> +
> +		/* Not mapped by this region; nothing here to withhold. */
> +		if (hpa =3D=3D ULLONG_MAX)
> +			continue;
> +
> +		rc =3D cxl_poison_store_hpa(cxlr, pfns, hpa);
> +		if (rc)
> +			return rc;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010162017.6250=
6-1-shaikhkamal2012@gmail.com?part=3D5
