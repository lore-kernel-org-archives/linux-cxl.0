Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FE47AF6B
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099777; cv=none; b=QRpjuGbRJr+RYJGZ4rLu/SFK9uzdalkyRROsagXSQemcUDtejx5t+Q3ij2gI1QQLAcFVVp/xPv3SNr73bIh6U2H//2THCg5530UE5mH5xAn3D2+ifxkYoafV0pbPclEP5MHotkH+r8WBjxGQ6kvy5Hk3pS+p+1JnrTYO7OK5IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099777; c=relaxed/simple;
	bh=wQ0u4bh/IEXuVZtAyRvdPad4KqS/pX/JaagtZcXuma0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qA5CMQEAysW8dgFqBvZ/SvrGt7US4ps+QSa/pYlfIBGr7qOON1rn7xFM7OkuZbSQo9K79LdMqu5yY0C2mBPqAEGwSL87IbmOPgiIP5n+DTLR/48lsJDCyvLfvZc7jn9ouJQSFSjCKDwz+RAvOeWn1dNWSoBr8KFpW1mv8WjuUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK1OlYAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK1OlYAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE72D1F00899;
	Tue, 22 Sep 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099774;
	bh=Ur7hbyV6REGMdP1eRKCSBIjJNxeDLb/fk6Op69vZLUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VK1OlYAYKHIFA2RnJdKJQvxpnVZsJRT9LBqUayRCgsSyrHNpFgeCOo195y85U7AXz
	 Xlis3WoCaqv29k37xTbZk9VmEy+U/tvQuhfebfUFmFHrJxTEwLaDi6NXGcFCFxMBpi
	 IAFeVVOJMx40XxJRCYJBCrtlMAb5EwfFvhLO2DCmS7lyXMdwpMaHWVvpxe/VyRMDj8
	 GOsxdRmJ2s7DVB84ngMyZFPFVMT3ipuSjmTG6FqW+5ieq0PhAdXPp1P3j4IVo+3sgz
	 B3QSibqkqVtI4l6Vy+zZeZWBzCkfwdgG8hGq1AGJH46CTZQVQyXng5e9JXEENFuvcb
	 O6MA9CjtqodSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] driver core: Rely on supplier driver binding at
 link creation
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260921191239.4249-2-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-2-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:56:14 +0000
Message-Id: <20260922175614.AE72D1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] driver core: AB-BA deadlock in device_link_add and device_release_=
driver_internal
- [High] driver core: fw_devlink broken by rejecting unbound suppliers in d=
evice_link_add
- [Low] driver core: mixed goto cleanup and scoped_guard violates cleanup g=
uidelines
- [Low] driver core: dead code in PM runtime check due to device_is_bound
--

commit 1f69a7873c55c75da1b5f2ed9898c41c813921cc
Author: Alejandro Lucero <alucerop@amd.com>

driver core: Rely on supplier driver binding at link creation

This commit modifies device link creation to rely on supplier driver bindin=
g.
It evaluates device_is_bound() for the supplier upfront and conditionally
checks PM initialization based on the DL_FLAG_PM_RUNTIME flag.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a19..eb6d87e35d76c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -834,15 +834,26 @@ struct device_link *device_link_add(struct device *=
consumer,
>  	device_pm_lock();
> =20
>  	/*
> -	 * If the supplier has not been fully registered yet or there is a
> -	 * reverse (non-SYNC_STATE_ONLY) dependency between the consumer and
> -	 * the supplier already in the graph, return NULL. If the link is a
> -	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
> -	 * because it only affects sync_state() callbacks.
> +	 * If the supplier has not been fully registered yet with a driver
> +	 * return NULL.
>  	 */
> -	if (!device_pm_initialized(supplier)
> -	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> -		  device_is_dependent(consumer, supplier))) {
> +	scoped_guard(device, supplier) {

[Severity: High]
Can this lead to an AB-BA deadlock between device_links_write_lock() and
the supplier device lock?

The device_link_add() function holds device_links_write_lock() before
acquiring the supplier's device lock via scoped_guard(device, supplier).

However, during device unbinding, device_release_driver_internal() takes the
device lock via __device_driver_lock() first. It then calls
__device_release_driver() which invokes device_links_driver_cleanup(),
attempting to acquire device_links_write_lock().

Could this result in a lock inversion?

> +		if (!device_is_bound(supplier)) {

[Severity: High]
Does rejecting unbound suppliers break fw_devlink's dependency tracking?

The fw_devlink_create_devlink() routine actively tries to create dormant
links to supplier devices before they are probed or bound to a driver. This
ensures proper probe ordering.

Rejecting these links unconditionally because device_is_bound() requires a
driver to be attached appears to break deferred probing guarantees.

Should we permit links when the supplier is not bound yet?

> +			link =3D NULL;
> +			goto out;

[Severity: Low]
Does jumping out of a scope-based cleanup block violate the cleanup
guidelines?

The kernel subsystem cleanup guidelines state that the usage of goto and
cleanup helpers should never be mixed in the same function.

Using a goto to jump out of a scoped_guard() block to a manual cleanup label
mixes the two paradigms.

Could this be converted completely to scope-based cleanup, or would it be
better to avoid using scoped_guard() here?

> +		}
> +	}
> +	/*
> +	 * If consumer asks for PM to use the link and the supplier has not
> +	 * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
> +	 * dependency between the consumer and the supplier already in the
> +	 * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
> +	 * don't check for reverse dependencies because it only affects
> +	 * sync_state() callbacks.
> +	 */
> +	if (((flags & DL_FLAG_PM_RUNTIME) && !device_pm_initialized(supplier)) =
||

[Severity: Low]
Is the !device_pm_initialized(supplier) condition reachable anymore?

The device_is_bound() check earlier in the function fundamentally
guarantees that a driver is attached. This is only possible if the
device has already been registered.

Since device_pm_initialized() directly evaluates to device_is_registered(),
!device_pm_initialized(supplier) will evaluate to false under all possible
code paths passing the new bound check.

Is this check now dead code?

> +	    (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> +	     device_is_dependent(consumer, supplier))) {
>  		link =3D NULL;
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191239.4249=
-1-alucerop@amd.com?part=3D1
