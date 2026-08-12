Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A03EC83C
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524306; cv=none; b=j4gwEjkgG5zctKTj+8J2mHWJeAL9XssBVMsf9SF24mAmuBqKpLH/UcsFv98F6KyK0+WTsekOJGmowM4dmsP5l8lvh2u7BLN8Z6DDlBVgwpyzvd3VHFuh0ivl6AlfJC5KC1RktWdB6HfnX0oVEgDxt62fupzRsKJIi8G28oRzUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524306; c=relaxed/simple;
	bh=DH6CBipstQlVvloe3AjfSzcfupCaXLjVLFqp/b5QC30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWlnewuxnv5tm1bo3yHK+gCHgUt+YXqU/GgD+7Ab4nmZ64MqAXQZbnYt7ZMY2M05linZWV78cTsOM3ILWIpt7aRKC0Su6ShQPsKe2pllvG8ZhHXYgiWpdU08VB2abSmst29zAg4eo0L/MhsLazn+nyF1vmLsqPz6uWW+z62qBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2PHpLPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2PHpLPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B941F000E9;
	Wed, 12 Aug 2026 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786524299;
	bh=CAAxYrPoD2VR9r19ZCuqsvm+DK/Eo8D8VW3ovnFT3RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2PHpLPvijNyzztC6aDBBm0O8dA34JHKKyU8AcNQOxJ6VeLaC0k4IVu2AH2vQalS5
	 IS9ltBIbBWLarDeGGBzeUujAqIFquXevRr/JyhxLfV0gBCJsEot0lXxqNJqaREjrzB
	 tFAnrVLX3RQS53JQEtMZ3vkHyrcwjOkZGXUIEbX+IfNJpT0luE+FtC8msetG0nfH0g
	 He9g39Xf+RhM2FnI8QcBB8xdYSdUny1C1vpGosronrj5878GTDr1PFdbdlauypAVsE
	 JQLe3Z7v/LqsxgXJvy0RfZpnMMCpsKQ9YbBEGNuyKztklRLSsDftyoOHI6gAyTV2eB
	 Cvt4vvu0od2jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in
 bandwidth gathering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812083035.372308-2-kanie@linux.alibaba.com>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
 <20260812083035.372308-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:44:58 +0000
Message-Id: <20260812084459.07B941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Zero-initializing `ep_coord` codifies a logic error where valid PC=
I bandwidth is discarded if CDAT bandwidth is unreported (0), contradicting=
 subsystem conventions.
- [High] The cxl_port_perf_data_calculate() function declares an uninitiali=
zed access_coordinate array on the stack, which is leaked to userspace via =
sysfs for Restricted CXL Devices (RCDs).
--

--- Patch [1]: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in band=
width gathering ---
commit ecbce27f92f7e67349081889c3ca38eb48761104
Author: Guixin Liu <kanie@linux.alibaba.com>
Subject: cxl/cdat: Fix uninitialized stack use in bandwidth gathering

This commit fixes uninitialized stack usage in cxl_endpoint_gather_bandwidt=
h()
and cxl_switch_gather_bandwidth() by zero-initializing the access_coordinate
arrays. It prevents uninitialized kernel stack data from being exposed as
bandwidth and latency figures.

> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f072625135..df9261ba84e5a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_r=
egion *cxlr,
>  	struct cxl_port *endpoint =3D to_cxl_port(cxled->cxld.dev.parent);
>  	struct cxl_port *parent_port =3D to_cxl_port(endpoint->dev.parent);
>  	struct cxl_port *gp_port =3D to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] =3D { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] =3D { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] =3D { };

[Severity: High]
This isn't a bug introduced by this patch, but does zero-initializing
ep_coord codify a logic error where valid PCI bandwidth is discarded?

If an endpoint CDAT does not report bandwidth, the bandwidth fields in
perf->cdat_coord will be 0. When cxl_coordinates_combine() is called later
in cxl_endpoint_gather_bandwidth():

	rc =3D cxl_pci_get_bandwidth(pdev, pci_coord);
	if (rc < 0)
		return rc;

	/*
	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
	 * DSLBIS.
	 */
	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);

The __cxl_coordinates_combine() helper requires both inputs to be non-zero
to assign the output:

	if (c1->write_bandwidth && c2->write_bandwidth)
		out->write_bandwidth =3D min(c1->write_bandwidth,
					   c2->write_bandwidth);

Because the bandwidth in perf->cdat_coord is 0, ep_coord remains untouched
(which is now 0). This completely discards the valid upstream link
bandwidth in pci_coord, resulting in an erroneous region aggregate
bandwidth of 0.

[Severity: High]
This is a pre-existing issue, but while fixing uninitialized stack
variables, did you notice a similar leak in cxl_port_perf_data_calculate()
in drivers/cxl/core/cdat.c?

It declares an uninitialized array:

	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
	...
	rc =3D cxl_endpoint_get_perf_coordinates(port, ep_c);

If the device is a Restricted CXL Device (RCD),
cxl_endpoint_get_perf_coordinates() in drivers/cxl/core/port.c returns 0
early without initializing the array:

	/*
	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
	 * since RCH does not support hotplug.
	 */
	if (cxlmd->cxlds->rcd)
		return 0;

cxl_port_perf_data_calculate() then passes this uninitialized array to
cxl_coordinates_combine(), which can leak kernel stack memory to userspace
via world-readable sysfs region attributes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812083035.3723=
08-1-kanie@linux.alibaba.com?part=3D1
