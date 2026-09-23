Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63F23E325
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 01:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125963; cv=none; b=W2B6CmIOHC6o84fhKuH+EnJsA1At9V3PmFt0UbEev6Gpo9TJuaY7J7pNYONITfo+HFrHhZkie2BLFBT8l8vsFgSEtvCVwavYxo6E/+x+122i3uVlhT7eBhyV34Mhn5AB8/Wb8v3YAvlDAUUrWabuU8Jo32/eZUmcTo7JIFb9/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125963; c=relaxed/simple;
	bh=BbBZuChPCbvIQuc4YSCxfWcTDNZeLV//J5ZgR6NFwpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nD28YkHM5PNhxnm9ZPfoHmkMWn5NM0uK+re8gku540Hkxci+K32fkS0J41aH7sMO+YJoP3tqHKSMzcGhMaeOf1AjIe+SqHxJxTtqu+vD1Z9NmFo3ftfKTt98vWah9HWOXnYhRs0GnPBJ1+YBurrmlRrwtt1jDqbgz3pNWSjoJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azKWGnJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azKWGnJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9451F000FF;
	Wed, 23 Sep 2026 01:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790125961;
	bh=tr8wOtj4vjJM4OMw4zthA3khu3G5YYDshG8/ZMp6InM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azKWGnJmJOjX/NsGfbRe0cRFZwQF7ljMdlSE89Z5nPOadyyPbuzXvatlfoCwR48g6
	 /AIJLyL3W6wdSzhGpSHuK9UMJwvjFf4FRWUFNMjHnItALM61/NOWa/1G9tzf3x+Hua
	 4yAKv2oRTMVcgsqGcEZ15Uu6OiWEsXWmLnt/8mPhhd6bv39+PMXeauvW1RH7PJkG1B
	 GUid5cgw9VY0i+//seY0vqUQiD0bQD3kNCGUJsxaLywJ6gkIfNvdOZdecIXYICF2cV
	 Oca+7l/EhwTDnBwTSjmq8DnMitJ5j+sgNwKlmbV7//dfz+Xx3axttuLBikFsZdByq3
	 z3q8dLkOxNU7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
 <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:12:40 +0000
Message-Id: <20260923011241.4B9451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/pci: TOCTOU race in BI setup against concurrent AER reset
--

commit 1daa4037cbac0ebc16630c3d4f45c358bd7890f9
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/pci: Add BI topology enable/disable

This patch implements setup and teardown of the Back-Invalidate (BI) topolo=
gy
on CXL endpoints and upstream components. It also adds a reset detection
mechanism to verify whether a reset cleared the hardware BI Enable state.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b8676a3d6ec90..f3ca9861a7ba1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
[ ... ]
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enab=
le)
> +{
[ ... ]
> +	FIELD_MODIFY(CXL_BI_DECODER_CTRL_BI_ENABLE, &ctrl, enable);
> +	writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi =3D enable;

[Severity: Medium]
Could this lockless update of cxlds->bi race with a concurrent AER reset
handled by cxl_bi_reset_detected()?

If a user manually binds the cxl_port driver via sysfs concurrently with a
PCI AER reset (SBR), the manual sysfs bind takes the endpoint->dev lock,
while the AER recovery (cxl_reset_done()) takes the cxlmd->dev lock, allowi=
ng
them to execute concurrently.

There is a window between the writel() that sets the hardware bit and the
assignment of cxlds->bi. If the AER SBR wipes the hardware bit in this wind=
ow,
could cxl_bi_reset_detected() check the still-false cxlds->bi and ignore the
reset?

> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n", str_enabled_disabled(enable));
> +
> +	return 0;
> +}
[ ... ]
> +void cxl_bi_reset_detected(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +
> +	if (!cxlds->bi)
> +		return;

If cxl_bi_reset_detected() returns early here because cxlds->bi is false, a=
nd
then __cxl_bi_ctrl_endpoint() resumes and sets cxlds->bi =3D true, the soft=
ware
state becomes permanently desynchronized from the hardware state
(BI_ENABLE =3D 0), breaking the fail-closed coherency recovery model.

> +
> +	if (cxl_bi_decoder_enabled(endpoint))
> +		return;
> +
> +	dev_warn(cxlds->dev, "BI disabled by reset\n");
> +	cxlds->bi =3D false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790103847.gi=
t.dave@stgolabs.net?part=3D2
