Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF574307BA
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613306; cv=none; b=eyy4thH/jT/vKygvmkTPEPYNTP47VDCIl1YnW7R/PKmbVDPngdIR/umhsuxrSH3rVOcjO5PBxfg4YbA1hmN5Zs5ZhTql8ov9eG6BqWYfqTsPkIu2ah7/ZYec2YfDyXblXM6v4GeVE30BrR4h5Mf/i7aSSYFNI5EWz+C8n6P4jm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613306; c=relaxed/simple;
	bh=ZN8YcdB4c3UDbI6tvsG+F3/WlUAbfqQ5Mx16RfQXG5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZTMB7t1n76jaYM467rJ8fLHeCZvDhCEV+n7loDsxmfz2RGaSC4cY9xV6n4x9vfBB02qMD/9YxUu0JBV5KvD3IKO3lZ1zQOWCZ3afbWf0AuYl1EFbBjW5QoFrEFfEZsUd30N49BvUPBw7nI0eZWzbO9FKIkBr51+3Jo6vRUffvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvQUOdJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvQUOdJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284991F000E9;
	Thu,  9 Jul 2026 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613302;
	bh=hRmdiY+UQO8oLusr390T0fEu70ux/XMaD8I+x3TFlZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvQUOdJOyHgHH+Nnek1gt2mibqsLsmw1nzwNOenQAQaA/nAbBCxHp2i/TWuXjmbVF
	 6DzhXshdhwt7eunXnC6c0aJmjlZVLYEB1eJkihrCK+IaSaK4uDksS47awtzALs7tBm
	 kZ35iOG40ktqNwrMWvVLDbG6KVI8UTCMHEkmkaTU/Z8T9aEvI2gfpFLi9C6SdEkTMK
	 CQVxuM0ECCgmE5z1b6jSzMuu+hNpYTU1FdMtWtAOPRgZIwGwTmmaVt8K7HcCApDWwg
	 gEqQvVVxDyCkHLY7xOwPl2A7/RVckbdyP7zdHMyXJRAFo6nOe5fO1MhgLhvI08EIOM
	 7Zkq118HwmDRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/mbox: Break poison list loop on an empty payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709155714.1893280-1-dave.jiang@intel.com>
References: <20260709155714.1893280-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:08:21 +0000
Message-Id: <20260709160822.284991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read of kernel memory due to unvalidated `po->count`=
 from device payload.
--

--- Patch [1]: [PATCH] cxl/mbox: Break poison list loop on an empty payload=
 ---
commit bae9e2badcecd54aec9a327464ba99a57b005a54
Author: Dave Jiang <dave.jiang@intel.com>
cxl/mbox: Break poison list loop on an empty payload

This commit prevents an infinite loop when a device returns count =3D=3D 0
with CXL_POISON_FLAG_MORE set by breaking the poison list loop on an
empty payload.

Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.c=
om?part=3D3

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
[ ... ]
> @@ -1455,6 +1455,11 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u=
64 offset, u64 len,
>  		if (rc)
>  			break;
> =20
> +		if (!le16_to_cpu(po->count)) {
> +			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
> +			break;
> +		}
> +
>  		for (int i =3D 0; i < le16_to_cpu(po->count); i++)
>  			trace_cxl_poison(cxlmd, cxlr, &po->record[i],

[Severity: High]
This is a pre-existing issue, but does this loop blindly trust the device
provided count without validating it against the actual payload size?

If a malicious or malfunctioning device returns a small payload but
specifies a large po->count, iterating up to le16_to_cpu(po->count) could
read out of bounds of the allocated cxl_mbox->payload_size. The
unvalidated memory is then passed to trace_cxl_poison().

Could we add a bounds check in cxl_mem_get_poison() to ensure the payload
actually contains the expected number of records?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709155714.1893=
280-1-dave.jiang@intel.com?part=3D1
