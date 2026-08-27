Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C53F105E
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864152; cv=none; b=qxcghsbdFgG1XeOksKrmyfhMBRpCdSaiY/6kekCJrrd9t3LZoKhNIvYrqhlkoGhuI8ibecOrXB98KyUFFHc2IIrPNOl1/8egwmK2LSnnh03XH74fr0s5jOZiNkXadjXtcGMdVZzgfY2nrPyWhbjNKGrvTN55RDQFbdQ49u+bSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864152; c=relaxed/simple;
	bh=OS6ZcfxwS5XoxIe1Wll1loUx+TNcS1g9bT5ERGisVI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoW1eP2ltxKhMZWWPL5MdCVNeVpMmvHwEVEKa26oZsNHN1lKJTu5R5kmh3+p3nNNjyUvfEdY2Yim+E1Cm2oZ7qiqBA+8ldnowNbQlorFiLWVMa3++CjsR6N9sQcGKOWuKlQScTMdAyMc2e2ht+0Q0wI6dzKkOiztTzeFtKpv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMyQlfHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMyQlfHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35261F00A3A;
	Thu, 27 Aug 2026 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864151;
	bh=zBYw8RzUa2pgJqOqovZTDCZj60yskZTCPn4ADet/cYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MMyQlfHmBcf46X8W0qjUnOOxZQuv8rc4vQDJzXj1O05EqMUY5lzkomJo2nFgO6uNh
	 g7gvCwhlM1LYAWJa/ulcoF2JoIt0W4/XoqxwXrd4A9Su0bOWPfLV5CsJCNBqg1s3ob
	 PItenAizDcxe/Sw+2Cw0JkNbQrBLZVsogJIqp8na0p93GeQr5nK0EXKLrcUPNKT4I6
	 aUuQmh0FFPe+e9s4r4u54eEiJKeVeodmAS4dGUXDzRUCYLI4oB6UIPd0kS8wxTaztb
	 ei9hv4chFZ6WmVLrDG7FweFI3weUhoACRa2+4zlfDODbF3bRuBF7gO98pIB4HAI3p4
	 F3rsUuN/lTs8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/13] ACPI: extlog: Defer CXL protocol error
 handling to avoid lock inversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-5-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:55:50 +0000
Message-Id: <20260827205550.D35261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IRQ disable in work registration functions causes spinlock=
-in-IRQ deadlock with hardirq context.
--

commit 5baac18b0ad945081ea20f4dc8b72f0c31c675a3
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion

This commit fixes a lock inversion between the MCE notifier chain rwsem
and the PCI device_lock by deferring CXL protocol error handling to a
workqueue. It exports cxl_cper_post_prot_err() from the GHES driver to
be used by the extlog driver.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..a382aabf9835e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

[ ... ]

> @@ -777,6 +777,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_se=
c_prot_err *prot_err,
>  	schedule_work(cxl_cper_prot_err_work);
>  #endif
>  }
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_post_prot_err, "acpi_extlog");
> =20
>  int cxl_cper_register_prot_err_work(struct work_struct *work)
>  {

[Severity: High]
This is a pre-existing issue, but since this patch exports and expands the
usage of cxl_cper_post_prot_err(), could this lock lead to a hardirq
deadlock?

In cxl_cper_register_prot_err_work() and
cxl_cper_unregister_prot_err_work(), the lock is taken without disabling
interrupts:

    guard(spinlock)(&cxl_cper_prot_err_work_lock);

If a GHES interrupt arrives on the same CPU while this lock is held,
ghes_irq_func() will process the event and call cxl_cper_post_prot_err(),
which attempts to acquire the same lock:

    guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

Does this cause the IRQ handler to spin forever waiting for the lock held
by the interrupted process? A similar pattern appears to exist for
cxl_cper_work_lock in cxl_cper_register_work().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D4
