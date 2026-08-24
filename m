Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF32C21E8
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594583; cv=none; b=prSkK3fMBV0pvOwhvYNnqpT0mpDGXG4t6OdA8ECWZOBg/kwjvshrbbufHnBvt9SjnH/rBBTy7cFSXvK4lbdLqoC9aZKWDO9ZfC8srmPDTE9AWyGjzISGfGh3ONRr/7NtgCuphwyuuDSOiUvUg6jBGZVXbpYdseZMK8mojUYJC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594583; c=relaxed/simple;
	bh=1lQ1h/BMDwsAPRpJYz6PgzvnouUE9x1Mgl6waOcS8Ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=quwrMeiZvUZRTKv0NfR/Sgps6JeQr3TpqnpuBBUQVLNITWUsjlcid3yTnW91h+R7guH5TmaFeFEshF/sAYCu03gjEUHH6o4CHqOHFowXusHAfnO20axwrc38HYGLLD2HwiwPTj/5RAgx0nWkACcXq9StEAUUly0mYxhzJS/uQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hojx7HGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hojx7HGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786DA1F000E9;
	Mon, 24 Aug 2026 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594581;
	bh=qbYCJZwyZ5YgI8Mw4tGOioN6npuhDmYgSDAHyd6DO3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hojx7HGAT8yqfBnmvOkmoVg7267TXJQF6u841xvWePbw3pfM3aMLx4EoCNJyYyxRv
	 CaYhXajiXo8zazqGmJ+ZM/s80mcs3L73TYQanYMI+Ye+vaN0je+IBZOewfG9D1MuZD
	 n3hqwd35SVQxzsZQ8MMdDxUhxhjpKMTvDRgb6pZ9KSgsA1eDqpYm9S1fu2mQ5KNaVZ
	 AlfQUh2rzOmzOIR9fnE6O17S79LzSGIhe5dbAAlSUYSPMxAk3Dmj9gTeIBuA4C++EZ
	 TRVk93JG7CaNwMRrd39yXaymcuJi3D8FcA8FdLOS41zrMTAGZxZpSxkdNmIDkB9pF9
	 brlSDrC2dVvXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] ACPI: extlog: Defer CXL protocol error
 handling to avoid lock inversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-5-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:03:01 +0000
Message-Id: <20260824180301.786DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inconsistent IRQ protection on `cxl_cper_prot_err_work_lock` and `=
cxl_cper_work_lock` creates a hardirq lock inversion deadlock.
--

--- Patch [4]: [PATCH v4 04/13] ACPI: extlog: Defer CXL protocol error hand=
ling to avoid lock inversion ---
commit 720f77fd10f559d90d89b27d71e19c5f7b332287
Author: Dave Jiang <dave.jiang@intel.com>
ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion

This commit defers CXL protocol error handling to a workqueue to avoid an
AB-BA deadlock during probe and MCE handling. It exports
cxl_cper_post_prot_err() from ghes.c and calls it instead of processing
synchronously in extlog_print().

Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.=
kernel.org/

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..a382aabf9835e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -752,8 +752,8 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cx=
l_cper_prot_err_work_data,
>  static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
> =20
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_er=
r,
> -				   int severity)
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity)
>  {

[Severity: High]
This is a pre-existing issue, but is it possible for a deadlock to occur if
cxl_cper_post_prot_err() interrupts process context?

Looking at drivers/acpi/apei/ghes.c, cxl_cper_register_prot_err_work()
acquires the lock without disabling interrupts:

    guard(spinlock)(&cxl_cper_prot_err_work_lock);

If a CXL protocol error occurs concurrently on the same CPU, the interrupt
or MCE handler will call cxl_cper_post_prot_err(), which tries to acquire
the same lock using:

    guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

Since the lock is already held by the interrupted process, will the interru=
pt
handler spin forever causing a hard lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D4
