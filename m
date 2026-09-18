Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385D522695
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764190; cv=none; b=rreX0y0pE+HuShMmmhiFD2I8e4xB6CWl0PIRBFWQlVWkaGB/TyVZNCFZlhravr50+TXDYHieNX+8K987wFAbtM2Pw8RYPGQ0warso4U/VOL27kq+WLebUf+aKVx8smLW57R/KtbLDGPEJbWT5lola6TafePqzEXxpe/s9BewxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764190; c=relaxed/simple;
	bh=gRVHY+DhMfsScb/56/AyXkjcae4tNYFTWULu0BFma+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNa08q8j28oGKWrv6Q+9lxjBDwfmHQHqgy4DxH3V5+gm3zVWC6AKp/VedjFnxsMlrMbbQJvKM2Fn5payCEzBdnXWqkMWkvmvKKRbO7IXPcJ6ryp69vK+rSaFYNND60iDFgOfozHO3ZOy7Z13HcXdKfFkvNaFnAhVRz1vhKUbpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6fxlWDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6fxlWDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17761F000FF;
	Fri, 18 Sep 2026 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789764183;
	bh=301m+uHj6UtTOjwYvH4AKbtQ1LCvTBxPQZraEu1aeAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6fxlWDzVS1UfRM+0DcMQ4R0i0l4CRWGUNgYxUaOZp4GhclJwu3dACGLAbrLz2L4a
	 tQBxWcRohUnTPvZk1FJygb1Xyf4m2CeexUnhNlW+G7beYx6bY9GTqq61Bjz8Iov1ed
	 qrwQMVg1Ek/2UTBD+glmEBhibWPkxjpPhXK75bHXj74BtMlqtmGvK0lpQBC7csG6fS
	 p5x53YHtM6GVZvidgF+SjezGVGEaum5Q4nTuFP89oojmEG1gCNeqhXdJU+E7eNeTvi
	 HOGJXzjUpJVu5HaTm27wCJBbskMF1GOZH4ehAASubN9Ahj1LvKzFgZGUL4mUGfBbNi
	 Mw9AjKkC7K+OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260918203049.7273-7-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:43:02 +0000
Message-Id: <20260918204302.F17761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: probe fails on non-native CXL systems if DCD event config fai=
ls
--

commit 7a8483673c7e3c3849faf44e013fead5e793c1b6
Author: Ira Weiny <iweiny@kernel.org>

cxl/mem: Configure dynamic capacity interrupts

Configure DCD event log interrupts on devices supporting dynamic capacity.
Disable DCD if interrupts are not supported. Care is taken to preserve the
interrupt policy set by the FW if FW first has been selected by the BIOS.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d0..fee3a704b73ba 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

[ ... ]

> @@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_e=
vent_interrupt_policy *policy
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy =3D { 0 };
> +	bool native_cxl =3D host_bridge->native_cxl_error;
> +	size_t policy_size;
> +	u32 mask;
>  	int rc;
> =20
>  	/*
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
> +	 *
> +	 * If BIOS has control of events and DCD is not supported skip event
> +	 * configuration.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!native_cxl && !cxl_dcd_supported(mds))
>  		return 0;
> =20
>  	if (!irq_avail) {
>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processi=
ng.\n");
> +		if (cxl_dcd_supported(mds)) {
> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> +			cxl_disable_dcd(mds);
> +		}
>  		return 0;
>  	}
> =20
> -	rc =3D cxl_event_get_int_policy(mds, &policy);
> +	rc =3D cxl_event_get_int_policy(mds, &policy, &policy_size);
>  	if (rc)
>  		return rc;

[Severity: High]
If native_cxl is false and cxl_dcd_supported(mds) is true, does this early
return abort the entire device probe instead of gracefully degrading?

If the firmware rejects the mailbox command, it looks like this will propag=
ate
the error and fail the probe instead of calling cxl_disable_dcd(mds) and
returning 0 like before.

> =20
> -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> +	/*
> +	 * dcd_settings cannot be sent to a device whose policy is too short
> +	 * to hold it, so the device would never accept the setting
> +	 * cxl_irqsetup() arms the DCD interrupt with.
> +	 */
> +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> +		dev_warn(mds->cxlds.dev,
> +			 "DCD supported but interrupt policy is only %zu bytes\n",
> +			 policy_size);
> +		cxl_disable_dcd(mds);
> +		/* DCD was the only reason to be here */
> +		if (!native_cxl)
> +			return 0;
> +	}
> +
> +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
>  	}
> =20
> -	rc =3D cxl_event_config_msgnums(mds, &policy);
> +	rc =3D cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
>  	if (rc)
>  		return rc;

[Severity: High]
Similarly here, if the SET command fails on a non-native CXL system, does
this propagate the error and abort the probe?

Should it also disable DCD and return 0 in that scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918203049.7273=
-1-anisa.su@samsung.com?part=3D6
