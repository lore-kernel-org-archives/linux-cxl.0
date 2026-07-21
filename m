Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28513BBFAA
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624915; cv=none; b=u4DDaweULyjp//ONAgwZbw2/Mp+Tpak5Q4v4rsswQiRMyPojTstNEASl70Qc/2HQuCrvA2FybWHNUH5MeaJfAY0Zg5aHUbCGsynQkW9idOO2yL/jRaokpUqLmQ4GHx9WQqSK6R2daqLfNilAq5wNaBqDlq3f3PMEKW5d0m8Z4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624915; c=relaxed/simple;
	bh=MQpSm73FtDbcXsNiMJARzbKQGuGMtdjrtyO5FwhC5uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idd7IXoUba813ClUAYVUSBgG7gru0czwEaxVCcpu37w3y9a/HabBAjiG5nbmmVSdNdkvobssfjMO1UE1BPkaFs/nHmoq4zdF/kCr/Drg6J5fr2xcuFvUqXl/KpWzBZwwGuKjvHWD5xXzMGC+s/QbAk7+eaM1eUvIlrmX/FhmRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dao6PciS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dao6PciS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA01F000E9;
	Tue, 21 Jul 2026 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624914;
	bh=Pk5Yc4dnNfmAy0Ki/utRijZNd90Jgk782y8Usvv3l78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dao6PciSOJObuR845Ck7dfFd2Qq4kSqYuuhkIGE1A/JdalUnrwLETPWZ+PVBYq/h3
	 gcpJqbZupqecDrn5o8pq/OE9wcabEPr3vrFTfeCVyVYI9BKdD7xcTlGjbtXya+/LCs
	 vZWXaq4V/TxIr65bKLZyDYXagW3HvhsxPeVDQFy4UpFClJWfcMebtzYTG9iG3YWoUQ
	 B3UcMQhsTAnzJ5oCBIcaVjg7Aj5KcnPsH4WYjhzK75+a3sWmS24XnUDenvMn1btWSg
	 FjqvirQybGfR7ECRh4IEuT8nmEX/TmRyP0xT8Y7+/yiW8jlJOXM4jYM8yQ7yHJKrwm
	 RcG7z937j4j0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized
 decoders under hb0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260721085715.39322-3-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:08:34 +0000
Message-Id: <20260721090834.82EA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_dpa_free() fails to release 0-length DPA reservations, renderi=
ng unlocked zero-size decoders permanently unusable by userspace and leakin=
g memory.
--

--- Patch [2]: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized d=
ecoders under hb0 ---
commit 328b24698ee67fa6e936ca1dc4e6a01523de8a20
Author: Richard Cheng <icheng@nvidia.com>

tools/testing/cxl: Enable zero sized decoders under hb0
   =20
The kernel now allows committed zero-size HDM decoders so BIOS can lock
empty decoders; cxl_test needs to exercise that path. Add a module
parameter to mock zero-size decoders under host-bridge0 endpoints.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8ab2ce1262f30..fff2004a08c80 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

> @@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decod=
er *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
> =20
> -static int first_decoder(struct device *dev, const void *data)
> +static int match_decoder_by_index(struct device *dev, const void *data)
>  {
> +	int target_id =3D *(const int *)data;
>  	struct cxl_decoder *cxld;
> =20
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  	cxld =3D to_cxl_decoder(dev);
> -	if (cxld->id =3D=3D 0)
> -		return 1;
> -	return 0;
> +	return cxld->id =3D=3D target_id;
> +}
> +
> +/*
> + * Mock a committed, locked, empty decoder
> + * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
> + * param so the default cxl_test topology, shared by the region test
> + * suite, is left undisturbed.
> + */
> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled =3D to_cxl_endpoint_decoder(&cxld->d=
ev);
> +
> +	cxld->hpa_range =3D DEFINE_RANGE(base, base - 1);
> +	cxld->interleave_ways =3D 2;
> +	cxld->interleave_granularity =3D 4096;
> +	cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags =3D CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxled->state =3D CXL_DECODER_STATE_AUTO;
> +	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermar=
k */
> +	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);

[Severity: High]
Does this 0-length DPA reservation leak when the decoder is torn down?

Looking at the core CXL code, cxl_dpa_free() returns early if cxled_empty()
is true:

drivers/cxl/core/hdm.c:cxl_dpa_free() {
	...
	if (cxled_empty(cxled))
		return 0;
	...
}

And cxled_empty() returns true for 0-length resources:

drivers/cxl/cxl.h:cxled_empty() {
	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
}

Because resource_size(cxled->dpa_res) =3D=3D 0, cxl_dpa_free() returns 0 wi=
thout
calling devm_cxl_dpa_release().

Does this mean the 0-length kmalloc'd resource is leaked and port->hdm_end
is never decremented, rendering unlocked zero-size decoders permanently
unusable by userspace?

> +	cxld->commit =3D mock_decoder_commit;
> +	cxld->reset =3D mock_decoder_reset;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721085715.3932=
2-1-icheng@nvidia.com?part=3D2
