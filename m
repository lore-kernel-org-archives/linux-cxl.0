Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDE3C65F2
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984017; cv=none; b=r/O7GsShF/i4NTfUKMNuSWz/JpT3Qhlz9Pd2kMaegg0lF1cXhkn4PSAI5Ulx//ZG3aXp0lp50351mDdNL8erUmX5/bKx9G+BiHKedjoKlenYbv0awnprpXfJM+Nsc9ta9BjlBJBsdqSvk52pNcxsFoHMWPtMIiktWsMDh7TTxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984017; c=relaxed/simple;
	bh=xSmOsGSt7nFso3fYJrWYrneEYyrjXyy1ahqr0OIu8eE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DgclUh4hjfVzfYVCka61HtLLJ1lUNDldNlQeY64n4fc86XviftNVe7F80Ly5iP8URyXBpNwMAlXDLHP3fW64q+IqRWMDht7vuqQdoyTAGniYD298BQTNriWpm+P3YzWvh0OE/fjqL98AYZgV75mJxu2plAxPvTJ6xVZ9SnB76LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRVcAp1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRVcAp1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546A61F000E9;
	Thu,  2 Jul 2026 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984016;
	bh=ukUS7S7m+ydqzWX8dHHwSr3WBsc+wtLcOw5TDTnwagI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRVcAp1/h91sz3kbuIwbjtDwmf1fHrZm25h/FNOmL6TXq663WjQ8wymgmMKDAF8av
	 3O30lGtVcK9mo7ApO/wCc7fHfpRYL9CqmXxGm8VlXA4ukWilIY2cjESkoa4Rm2ZVcg
	 Cw9lZ5qDs1p3qljjSjG0ErWv/LcmmiK15owK3E1RS1bHXn8wahO0XIgFJU7cZ3kKAs
	 WKRFqK7oWdg4ZldomFpQngnRZuxbmpU3MzdHoO4XROdjngGoyqR6/lP48evnng6RYt
	 aB494uvGI5OdMrmHfqsmAH3tiFwaKe8m8ne/d7B3lQU7c2THv7pQsgkOsq8u30vxV/
	 EPeCZ+t9LWl8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260702090849.47501-4-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
 <20260702090849.47501-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:20:15 +0000
Message-Id: <20260702092016.546A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential infinite loop in `cxl_mem_get_poison()` if hardware retu=
rns `count =3D=3D 0` with `_FLAG_MORE`.
--

commit f920ce49af56dd4b8cd88e19b4d4bf7ba33be7da
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. This patch resets rc to 0 when tolerating the fault to prevent
returning a spurious -EFAULT.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index be246fb09c999..52ba8e9e42885 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);

[Severity: High]
This is a pre-existing issue, but can this call result in an infinite loop
if the hardware is misbehaving or malicious?

Looking at cxl_mem_get_poison() in drivers/cxl/core/mbox.c, the loop
termination depends on the hardware providing a non-zero count to
increment nr_records:

	nr_records =3D nr_records + le16_to_cpu(po->count);
	if (nr_records >=3D mds->poison.max_errors) {
		dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
			nr_records);
		break;
	}
} while (po->flags & CXL_POISON_FLAG_MORE);

If the device returns a payload with po->count =3D=3D 0 and leaves the
CXL_POISON_FLAG_MORE flag set, would this bypass the max_errors breakout
condition and loop indefinitely?

> -		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> +		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM) {
> +			rc =3D 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702090849.4750=
1-1-icheng@nvidia.com?part=3D3
