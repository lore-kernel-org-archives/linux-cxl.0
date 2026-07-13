Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7823EAB4
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942730; cv=none; b=s4OCzW/ZRanppvLqFae5MO0hfFchOA6QoceHP5u8k/+ALr05DaOAKnyq2H6ClO4gngnb4mZ+n/v01zc3O/U+n6xEJs9YXrv/04FDTFzljjWl2GbAbYrKrd14k7Ks//LO/zVORj1nQwIq6IFcz8Uk3tP/GsWlr8V9Laqbc8HTShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942730; c=relaxed/simple;
	bh=Ue3GoGpdTgHGlkmwon0naiye1q84QAjONviUWCHtUFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=spO2kHadNobwNNeLgqHnE0mu+opOzF6zJMBuJkudnpoV2WFUHqI0IHlaSzQmyhCFEZYdjquNd0vOvKRozmXasEpNdOVtSeZIAg8bN/qUnP/8Z76w5rBnXRdSA/qUazjCd8kikJNh+W9A7iZLskEAbDE/+w3KdBpfMfEgu+JX8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CooHoFT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CooHoFT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A5E1F000E9;
	Mon, 13 Jul 2026 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783942729;
	bh=P+zbIZDIhWZW00i2Hrh3MFT0pEEajIEuNI60iEcqj44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CooHoFT4pJd0m4eoAqyW+m4sxGkOxTGK8n6cyx/u2Buh1jfXAIsYs0U2rk10Lk3Bb
	 HHf8KjIrxaRp1sQLGBTPy6Z2ajovTDJBo/BZElWK1VlZnB9d9iI567jUmOrBgOqqeE
	 Wwn+9VTBVs6AuZAGdru0QligMDnTL6eUYQIIrVaGuNCoPFOlQfWgfrMyIchHic0kGB
	 JuWe7B40NAR3aNcypIhFOKeOyPLfzUIfqBbDB1I9howP6xNLPWcrHsnv03F0WlAQna
	 q54tQUoFGjiu5e7+Y2Olb8nyM078p351Jq1VaF4w1UeEGm+v2LuA1Nevm8kf8lE3Cw
	 kjl7KX9hqKw/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/memdev: Fix firmware upload exact-fit handling
Reply-To: sashiko-reviews@lists.linux.dev
To: guzebing <guzebing1612@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260713112744.2543829-1-guzebing1612@gmail.com>
References: <20260713112744.2543829-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:38:48 +0000
Message-Id: <20260713113849.04A5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated firmware slot count (`num_slots`) from the device lead=
s to a divide-by-zero kernel panic during firmware upload.
- [High] The firmware transfer INITIATE action does not set the target slot=
, leaving it as 0 which is invalid and breaks multi-part uploads.
--

--- Patch [1]: [PATCH] cxl/memdev: Fix firmware upload exact-fit handling -=
--
commit bd3fd9a0f6bb2e86d5487d6d79f980a791c0b33e
Author: Guzebing <Guzebing1612@gmail.com>

cxl/memdev: Fix firmware upload exact-fit handling

cxl_fw_prepare() classifies a firmware image as a one-shot transfer
only when its Transfer FW input payload is smaller than the mailbox
payload size. An image that exactly fills the payload is therefore
treated as a multi-part transfer.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2e457b1ebc7df..b3419df586b9c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -988,7 +988,7 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_up=
load *fwl, const u8 *data,
>  	if (!size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
> =20
> -	mds->fw.oneshot =3D struct_size(transfer, data, size) <
> +	mds->fw.oneshot =3D struct_size(transfer, data, size) <=3D
>  			    cxl_mbox->payload_size;
> =20
>  	if (cxl_mem_get_fw_info(mds))

[Severity: High]
This isn't a bug introduced by this patch, but unvalidated firmware slot co=
unt
from the device can lead to a divide-by-zero kernel panic during firmware
upload.

If a malicious or buggy device returns 0 for info.num_slots here:

drivers/cxl/core/memdev.c:cxl_mem_get_fw_info()
    ...
    mds->fw.num_slots =3D info.num_slots;
    ...

Later, when a user initiates a firmware upload, cxl_fw_write() will trigger=
 an
unhandled divide-by-zero exception:

drivers/cxl/core/memdev.c:cxl_fw_write()
    ...
    mds->fw.next_slot =3D (mds->fw.cur_slot % mds->fw.num_slots) + 1;
    ...

Should we validate that info.num_slots is non-zero before assigning it?


[Severity: High]
This is a pre-existing issue, but the firmware transfer INITIATE action does
not set the target slot, leaving it as 0 which is invalid and breaks
multi-part uploads.

For multi-part uploads, transfer is allocated with kzalloc and transfer->sl=
ot
is explicitly left unset in the INITIATE branch:

drivers/cxl/core/memdev.c:cxl_fw_write()
    ...
    transfer =3D kzalloc(size_in, GFP_KERNEL);
    ...
    if (mds->fw.oneshot) {
        ...
    } else {
        if (offset =3D=3D 0) {
            transfer->action =3D CXL_FW_TRANSFER_ACTION_INITIATE;
        } else if (remaining =3D=3D 0) {
            ...
    ...

Since CXL firmware slots are 1-indexed, and the CXL specification requires a
valid target slot for Initiate actions, the driver sends slot 0 and
permanently fails.

Does transfer->slot need to be set to mds->fw.next_slot in the INITIATE act=
ion
block as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713112744.2543=
829-1-guzebing1612@gmail.com?part=3D1
