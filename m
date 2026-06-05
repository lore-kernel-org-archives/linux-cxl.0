Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564D282F19
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623195; cv=none; b=dvIp7T4lq7d68pK31qZb/J5pewSy1EdFa3c/HbuOsnxPqPdKEdPgDpkRWG/PaxG6+CVCcs8UT4i5Iw1inBf1YELH23bxXsRi09+xh+CC7mBNRzM6CUKfO/AS1fEdGuB9zeiPnkAD3MWWJo+W2tsetcVFWj/2vkh/l8VwQRjTxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623195; c=relaxed/simple;
	bh=M+1LP6Q4PKK2GyYglhyZ3W/fM995ZHP1Ho2hS0Erk/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqHi+Sn7O5CbF/gYRF5tHkwNNJ8gBGB5fwGySNh2wqQejkJJ03ugeGxNRrueFEvRwTRmccyK3n240/zI5k6RJFxtt1X4E3cAaBu9vAyg1S4acFkB8sRU8ZPiRHGNSWAbFrnK5BIZAQ8B5zRi8sRg1Lt2nTTPPssRouJSiwpYc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7JrZpnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7JrZpnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9421F00898;
	Fri,  5 Jun 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623188;
	bh=DMpB/YrFFgMRrOyCNRqq3sp9Kmq+OtrBIjv7Yo0grrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y7JrZpnPfjurbjE543aa2Wvp+fzhI6Mec556sALEqE8ymldMSVjgtlNc9j9b7lOCL
	 DAziUHl4MC1vAA7RKSGxO/2TFiemcx4XNa7TYH6HPvBdRQn1qDhy2XLMeqdRUnOXg3
	 I4ziwHsm4cbmH00KifSf9t/EDv0hixRLAJwYIONcF3U6Oyx4KbcGzT0qsey0Y/Rm9E
	 DtwDcCXIU/+ThQ+k08o7tQrajQfZA5qiOJ4tlyx934kGZMVBlyBjTG+MmHde8XDrJM
	 LH/yC3G4Fgn2HJ0oJwRpEOIcFMo2fkgZbAb7jmW4uPaOwblxAMAtK/wgsEjZws6dCt
	 iABk+lSBcn3kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605003329.2584012-2-dave@stgolabs.net>
References: <20260605003329.2584012-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:33:07 +0000
Message-Id: <20260605013307.DA9421F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent failure to map and configure CXL BI Route Table due to prob=
e sequence mismatch
--

commit 34d3cc24691a25107f1dbbcc8e03fc18ffcae164
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Add BI register probing and port initialization

This commit adds register probing for BI Route Table and BI Decoder capabil=
ity
structures. It introduces helpers to map these structures at dport-creation
time and port probe time.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52fa..2dd712c5d312a 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
[ ... ]
> @@ -58,6 +58,62 @@ static int discover_region(struct device *dev, void *u=
nused)
[ ... ]
> +static void cxl_port_map_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map =3D &port->reg_map;
[ ... ]
> +	/* map this port's own BI capability */
> +	if (is_cxl_endpoint(port)) {
> +		if (!map->component_map.bi_decoder.valid) {
> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> +			return;
> +		}
> +		cap_id =3D CXL_CM_CAP_CAP_ID_BI_DECODER;
> +	} else {
> +		if (!map->component_map.bi_rt.valid) {
> +			dev_dbg(&port->dev, "BI RT registers not found\n");
> +			return;
> +		}

[Severity: High]
Does this silently fail to map the BI Route Table registers for switch
ports?

When called from cxl_switch_port_probe(), the component registers have not
been discovered yet. The registers are actually probed and marked valid when
the first downstream port is added, which triggers cxl_port_add_dport() to =
call
cxl_port_setup_regs().

Because the valid flag is always false here during switch port probe, the m=
ap
function returns early and permanently leaves port->regs.bi_rt unmapped. Wi=
ll
this bypass the required hardware commit protocol for the switch upstream p=
ort
and break Back-Invalidate coherency for downstream endpoints?

> +		cap_id =3D CXL_CM_CAP_CAP_ID_BI_RT;
> +	}
> +
> +	map->host =3D &port->dev;
> +	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
> +		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
> +			cap_id);
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
[ ... ]
> @@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
> =20
> +	cxl_port_map_bi(port);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605003329.2584=
012-1-dave@stgolabs.net?part=3D1
