Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868C1946DA
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571245; cv=none; b=KM1OQNmhrWWpfUmPh/VGMBJzsAmHE2U9WxTq211KPavbHf8ZOfZfJ9a9+2RNWMC2wl5nYQm4L5HlsiQta3A7iNjXTVwi/TFPXij2WfuOy6cehT6YGsE4n2giCKxXxyFVSmaQAmoBm3m4Y6ve/qKrU2QoLbXu0dJNAPzadaHGuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571245; c=relaxed/simple;
	bh=76SYt7O/22bGZM1wSn+RU+51k23t7EiMpLFpskr3TpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICTPNrRRBYI/EWpsyu6vWA3SFn5H3S5GP/KYVUDNP5p32DD+zwKCbE4drxMDRSyCpQUVlxOuAr6WXfptIrkdV6vZa3lvQfAz+PF0yO/6qVXbiOx7ybObb3pc/Th09fMeKwbt1xZQvjEpEfrmhie2hvFxKIDwHEAVJ5y+GRESNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLW4CNoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLW4CNoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4204D1F00A3A;
	Tue, 16 Jun 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571244;
	bh=4+/hbGOUnRjH8JxTJaV41RuKKTtiWM/N/jz5RdKNgFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LLW4CNoLmVpEDb0DYhks/CR+T0mOdSaAtSuL1yLmE6VIXOCFuJxxsUP6ylxJ9Um9b
	 kB5Dv9nLE8JT1n35Iju5v0cdn5lAWgmiNzYLD+kf3edrCyFEgYwg3+/nDCn9bY1+b2
	 J8UlVA//EAv0GXE2C8H8hnqaDjpk8kmyWxbz1eAxDctU6A1sYJ1p4lFKy4xcsIFAf1
	 Tz17eE3BkI0d2GkuK+Y3fZLM/83cWb+rp7G29g7+BoOdhZFUz1Agb39334jG56J78Z
	 hX4YK8oWjaQMbqvBsZy95lFMBlgJBRU+NaBea5i9yUk0kziafr5Op9p/wC5U0as29R
	 3kmzm+UWDv0rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] cxl/mce: Validate memdev and endpoint before
 dereference in cxl_handle_mce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260616004007.4186004-2-dave.jiang@intel.com>
References: <20260616004007.4186004-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 00:54:03 +0000
Message-Id: <20260616005404.4204D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The validation added for `cxlmd` fails to account for device teard=
own, where `cxlds->cxlmd` becomes a dangling pointer, leading to an incompl=
ete fix and Use-After-Free.
--

commit d4d366d587ddef82637af37fbf8cd28754d28024
Author: Dave Jiang <dave.jiang@intel.com>

cxl/mce: Validate memdev and endpoint before dereference in cxl_handle_mce()

cxlmd and endpoint are both used in cxl_handle_mce() without proper
validation, which can lead to NULL pointer dereference or invalid pointer
dereference. The notifier is registered in cxl_memdev_state_create()
when the CXL PCI driver first binds.

> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index ff8d078c6ca1e..47566015eb006 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
[ ... ]
> @@ -21,7 +21,11 @@ static int cxl_handle_mce(struct notifier_block *nb, u=
nsigned long val,
>  	if (!mce || !mce_usable_address(mce))
>  		return NOTIFY_DONE;
> =20
> -	if (!endpoint)
> +	if (!cxlmd)
> +		return NOTIFY_DONE;

[Severity: High]
This isn't a bug introduced by this patch, but does this check adequately
protect against a use-after-free during device teardown?

The MCE notifier is registered via devm_cxl_register_mce_notifier() early in
the PCI probe sequence. Later, cxl_memdev_autoremove() registers the
cxl_memdev_unregister() teardown action via devm_add_action_or_reset().
Because devm actions execute in LIFO order, cxl_memdev_unregister() runs
before the MCE notifier is unregistered.

During cxl_memdev_unregister(), put_device(&cxlmd->dev) is called, which can
free the cxlmd structure. However, neither cxl_memdev_unregister() nor
cxl_memdev_shutdown() clears the cxlds->cxlmd pointer.

This leaves mds->cxlds.cxlmd as a dangling pointer. If an MCE occurs during
this teardown window, cxl_handle_mce() will find a non-NULL cxlmd and pass =
it
to cxlmd_get_endpoint_dev(), which calls guard(device)(&cxlmd->dev), result=
ing
in a use-after-free.

> +
> +	endpoint =3D cxlmd->endpoint;
> +	if (IS_ERR_OR_NULL(endpoint))
>  		return NOTIFY_DONE;
> =20
>  	spa =3D mce->addr & MCI_ADDR_PHYSADDR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004007.4186=
004-1-dave.jiang@intel.com?part=3D1
