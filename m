Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60450312814
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253593; cv=none; b=Zwwkt/GiVI2Iq2Q9Ts4XuWhFrQvnnypZMNYkOWERuqaYHWtE+A+wEY4EGze3kIDs9vNxRPAEQoo1EcU7/xBbBokwY7RqhhdBrE/JxPZuxs+gTPtbprRK1o6Soh73SYNNna6tgDmGUDd9TZmNuGA/wSO+wEQ3B7EbLvuVzR3elFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253593; c=relaxed/simple;
	bh=bUqjIDD/nT3AGi7NqCBOVSddcmy2g8MxUBahjeQS9rI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIdUcKW/oEExIF98gbrpA8eJEFD6fbJGZ12trrbI4a0WJCR1phMv1tCCaUY8WqMoSyuQ8ROLqCxw16Qe6EKXxo/Jiw+kmgH4WmAKVGYHDxoU2rwXiaTdj066ABQ3+7PRMeBRFAdAeGgvGoWyW441Ko8WcLinsbpYcD6j20SGebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7TGR5O4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7TGR5O4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B135A1F000E9;
	Tue, 28 Jul 2026 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253588;
	bh=MmWpplmC5Cqj0COicXU11zijUvniCuksSm0Yel3cozk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7TGR5O46Kmc4jC3ooGOHC3RMuNld76KZdRUZk0RKTADPmRIslRvnLhQm/1FViXRn
	 PqYFUBtHHEQF6Ghzx6/vLDztcGE1Hl7WRV369xnEgmKJ+xLPIQmF6+u7Vm9p9Vt0yo
	 DAuU1aATPoHAHYaqk2clvPTjyt9bRTx8mms20RMD/Rz9l6kbzytjutLfnikDHyP97X
	 /w26MVBaqDHe1yFmNyt2cq6Z3mcbX/3Phu9rR9wRmI4mG1Ucxe7c2owBe2F1Q4bnWa
	 CQvzYcQg39oKAkZSc4AnIRmPF5N8ATj8AQhMBf4SnadPMgoLSdwu55s5t4qho0TcKy
	 tHfVfo3+ILQig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260728144136.709882-9-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:46:28 +0000
Message-Id: <20260728154628.B135A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Auto-committed BI decoders can be improperly assembled into region=
s even if BI path setup fails, leading to fatal hardware routing errors or =
cache incoherence.
--

--- Patch [8]: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders ---
commit 5bfa0978968677982ba4863deb2a8257dcfab9b1
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Allow auto-committed BI hdm decoders

This commit allows auto-committed BI HDM decoders on capable platforms.
It ensures that committed BI decoders are not assembled into regions
with mismatched coherency models or non-BI windows.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1839,6 +1854,16 @@ static int cxl_region_attach_auto(struct cxl_regio=
n *cxlr,
>  		return -EINVAL;
>  	}
> =20
> +	/* A committed decoder may only join a region of its own flavor */
> +	if (cxled_committed_bi(cxled) !=3D
> +	    (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
> +	     cxl_root_decoder_is_bi(cxlr->cxlrd))) {
> +		dev_err(&cxlr->dev, "%s:%s coherency model mismatch\n",
> +			dev_name(&cxled_to_memdev(cxled)->dev),
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +

[ ... ]

> @@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct =
cxl_root_decoder *cxlrd,
>  	if (part < 0)
>  		return ERR_PTR(-EBUSY);
> =20
> +	/* avoid UB */
> +	if (cxled_committed_bi(cxled) && !cxl_root_decoder_is_bi(cxlrd)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s BI decoder in a non-BI window\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +

[ ... ]

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -181,6 +181,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *=
port)
>  	if (rc)
>  		return rc;
> =20
> +	/*
> +	 * Must precede region discovery so that any firmware-committed BI
> +	 * decoder is adopted before its region is assembled.
> +	 */
>  	rc =3D cxl_bi_setup(port);
>  	if (rc)
>  		dev_dbg(&port->dev, "BI setup failed rc=3D%d\n", rc);

[Severity: High]
If cxl_bi_setup() fails in cxl_endpoint_port_probe() (for example, due to
register read/write failures on intermediate switches), the error is only
logged and probe continues.

Since cxl_region_attach_auto() and construct_region() authorize the decoder
to join a BI region based on cxled_committed_bi() checking the hardware sta=
te
instead of checking the software state (cxlds->bi), could an auto-committed
BI decoder be improperly assembled into a region even if its path setup fai=
led?

Does this risk fatal hardware routing errors or silent cache incoherence if
the OS failed to properly configure or adopt the BI path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144136.7098=
82-1-dave@stgolabs.net?part=3D8
