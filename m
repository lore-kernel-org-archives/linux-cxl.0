Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B240F8ED
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185897; cv=none; b=cVp9GV6/DwrTJr03w7FLxubNodOJ6IySHW2a2tYGL/TOY6aAcWc9xVUKOxs0W9k7YbIIlpatjXKduVaok00RGpwrc+upsxYtcr8INQiknBI3al4D6PTL0eXht4Mv/T3yMoHC8lT6yMro8bm8MK/Pov2GfaPZ8HLfiJMHrLzmTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185897; c=relaxed/simple;
	bh=LWCz2yYtZYti7GTsqQNJHd2F3+icambUPgW94fiW0lQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMTA2n0Od11bVneHmb3xoNMpcsPl8yDRfuaPtmABccZzGZf/zRUyYz/lvNOHoVE+NaDUfbx/T0LSiSexV55ldZuufHZlonvsj2aNQmJ4ypzW1PtUcVhwBQpS9pMLIlq1xTvmx08MWjytMbUanE55JYc6nepceyiYio5B//VNIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNqmkXMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNqmkXMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837DC1F000FF;
	Wed, 23 Sep 2026 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185895;
	bh=Scvmvq6MMPGgSkdbaYUlM030gRtHUlBp57cOVpQo05w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNqmkXMaugusgK6LnQjOhCuc8PwuxNbrxr9/bSQTbCnROK4xIvQpwXJ53KG4xETLY
	 igXgAEwH+bWtxRG0VguYh7cNqwRyvxVi3GeiRFqb1PwUpNCxZXUlcC54cD+shwEn4a
	 lyqy1EIKF58HPDVf0JUUYHXiA3PpuHsJljOZ1ZEssnygOZzDiF1UClOA8CNZDYfKbC
	 rvh75GJXP5OqfsUQymC0kHQq0Bq1Od4EQKGyV4SPl1EFn8THSO5XmfZpw2bvNq7cZQ
	 Jvcnfi4turs4/hE6EtGFBmt83udxSlS0Ozr+l4qGW64qQUJeHgzLI1meOuyOHTUmqF
	 tQzNX+VYwJdwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] cxl/core: Add support for HDM-D cache id
 programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-12-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-12-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:51:35 +0000
Message-Id: <20260923175135.837DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] cxl/cache: HDM-D capability limit ignored for intermediate switches
- [Medium] cxl/cache: off-by-one error in HDMDMax capability limit check
--

commit bdfe2b9c776e24b9a52c8e7a8594ae19a2e9c210
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/core: Add support for HDM-D cache id programming

This commit adds cache id allocation and programming support to the
pre-existing cache id programming routines for HDM-D devices.

> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c
[ ... ]
> @@ -290,6 +297,16 @@ static int cxl_cid_program_table_entry(struct cxl_po=
rt *port, int cid,
>  		return -EINVAL;
>  	}
> =20
> +	if (is_cxl_root(parent_port_of(port)) && hdmd) {
> +		hdmd_max =3D FIELD_GET(CXL_CACHE_ID_RT_CAP_HDMD_MAX, cap);
> +
> +		if (port->num_hdmd > hdmd_max) {

[Severity: Medium]
Will this strict inequality reject valid configurations when the hardware
capability register is 0-based?

In the CXL capability registers, CXL_CACHE_ID_RT_CAP_HDMD_MAX is only 4 bit=
s.
To support 16 HDM-D devices (the maximum), it is highly likely to be 0-base=
d.
The strict inequality port->num_hdmd > hdmd_max incorrectly evaluates to 1 =
> 0
for the first device, which could erroneously reject valid HDM-D devices du=
ring
initialization.

[Severity: High]
Does this capability limit check silently ignore intermediate switches?

Because cxl_cid_program_table_entry() explicitly restricts the limit valida=
tion
only to the top-level switch (direct child of the root), intermediate casca=
ded
switches completely skip validation. In a nested CXL topology, probing mult=
iple
HDM-D endpoints connected to an intermediate switch that has a lower HDMDMax
capability limit than the top-level switch could silently over-program the
intermediate switch. This could potentially cause incorrect hardware routin=
g,
dropped cache snoops, or fatal errors.

> +			dev_err(&port->dev,
> +				"Maximum number of devices using HDM-D reached\n");
> +			return -EINVAL;
> +		}
> +	}
[ ... ]
> @@ -385,6 +402,22 @@ static struct ida *find_cache_id_ida(struct cxl_port=
 *port)
>  	return NULL;
>  }
> =20
> +static void cxl_port_add_hdmd(struct cxl_port *endpoint, int val)
> +{
> +	struct cxl_port *parent =3D parent_port_of(endpoint);
> +	struct cxl_port *port =3D endpoint;
> +
> +	if (!parent || !is_cxl_cachedev(endpoint->uport_dev))
> +		return;
> +
> +	while (parent && !is_cxl_root(parent)) {
> +		port =3D parent;
> +		parent =3D parent_port_of(port);
> +	}
> +
> +	port->num_hdmd +=3D val;

[Severity: High]
Can this loop fail to track limits for nested topologies by only aggregating
the count on the top-level switch?

By skipping intermediate switches, the HDM-D device is attributed entirely
to the top-level switch. This causes the capability limit checks to be
bypassed for intermediate cascaded switches.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D11
