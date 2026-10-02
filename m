Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF614949F2
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942535; cv=none; b=YRvCFYxKTffJ5fuTZRBd17+qsBUlBe7b51ejlE1/tYFl9CiH4XV41dG9NBHsNG4j/xd4n22EHUy7n4ocTRgrMT/g3n+lkRBM6/DmabicsuCE0ySoq7Gg8HpdpTpb8LqG4t51lmhK2wTPrA2TYH8x9kstMoWMrVTmflbr7+i6fQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942535; c=relaxed/simple;
	bh=KouSNCFMhkg1GsI5r9mgZHG+LRHTDteEV7QJeqz74cQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKNP+1BSgInZx2HVGrKqoEpP7VLpHTyb9O4c/zQV4oyaKP41K5CnOnaSdjF7QtsiN4dB2OtgJLmi3vcNJxbsSSF8W8iXn+AbcEiOCw3Hd3E+BQRVS6AOQU1BB2ULhnDadodbpJmbsl3oQHU3lE6XG/tsnhTTIUNKb1dh6dKNgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odm8z1Nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odm8z1Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6D41F00893;
	Fri,  2 Oct 2026 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942533;
	bh=77fi6Go1f1uax/v05X+YY3pwifmOuk92TxIsaGlXgBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odm8z1Nh9y4UYT2Qj3MFA+gZ989SxQ4sG7k6znjdsH768hUKti6lFQqnlD/84hiWL
	 D0rUKhHOZBgtk3m/Kbypj0GpOo0vuOAqOPuSaB8NvKOOi4DWUU2vpki9uAx2IKDAMx
	 GZCWCPLWDnNcEw3gAjFuiTQgDf6W2fucSngYb0bg1NOFkknLt+bFSLFlH5C3PJEzZC
	 H5xrNkDWlk1RrU2w/WdFW9uwGfFMtJ5ypIMaZFVadO/SgFd78bF28zoENsU2A86FYz
	 2qwuXQHaFFlB6a3Jy8DW99a4BxzmfbF2wQImWCWgwxJ/gqh5mlbxfXFUPzRVzYJkVV
	 oCFp2JTuDAMoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] driver core: Check for supplier requiring PM at
 link creation
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261001132023.17032-2-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-2-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:02:13 +0000
Message-Id: <20261002120213.BA6D41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] core: missing registration check in device_link_add() for no_pm =
devices
--

commit b2ba746c71946921fa9666578a3ca843070e29f1
Author: Alejandro Lucero <alucerop@amd.com>

driver core: Check for supplier requiring PM at link creation

This commit updates device_link_add() to skip the PM initialization
check for devices that do not require PM, allowing links to be
established for such devices.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a19..bf0513beafad4 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c

[ ... ]

> @@ -840,7 +840,7 @@ struct device_link *device_link_add(struct device *co=
nsumer,
>  	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>  	 * because it only affects sync_state() callbacks.
>  	 */
> -	if (!device_pm_initialized(supplier)
> +	if ((!device_pm_not_required(supplier) && !device_pm_initialized(suppli=
er))

[Severity: Medium]
Does this inadvertently bypass the registration check for devices where
device_pm_not_required() is true?

The comment immediately above states: "If the supplier has not been fully
registered yet ... return NULL". Previously, device_pm_initialized()
implicitly enforced this because it wraps device_is_registered().

If a caller invokes device_link_add() with a supplier device that has
no_pm set to true but has not been successfully registered, bypassing this
check entirely means the unregistered supplier is allowed through. Since an
unregistered device will never go through device_del(), device_links_purge()
will never run to clean up the link. Can this result in a permanent leak
of the struct device_link and device refcounts?

Would it make sense to explicitly add a !device_is_registered(supplier)
fallback check here to ensure the core API contract is maintained?

>  	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>  		  device_is_dependent(consumer, supplier))) {
>  		link =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001132023.1703=
2-1-alucerop@amd.com?part=3D1
