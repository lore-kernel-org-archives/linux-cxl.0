Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873B314D35
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313878; cv=none; b=HzqEBd31b4Q5zdlbAqxCgBYfY7y9SfLgDlk1VQU2GxmkFA2ntCx3ZCv4bS7FDmJPYeMjC4zL6QdXQfbJqVShJZ7+zZUeNpfm652xebzhD3MMXtC55gX5uLl66WQASE3QqJI2XwN8XdPYdFWVoRTXqGKUWdmBvT4lI4629imKao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313878; c=relaxed/simple;
	bh=GOV1ezgMbO1uXM8Gou7nJIVdWQIq5yqV2eXceQFoA9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kqMroQFUTs8zjJlIfN8R+G65LGRrhlDDgTaUYT+dcwxPhu3PObZVNeHFjsvdUKAUt45z+DyYEyevS0A1yigDDVPc+cHuLbocfqxF9eS6x6VIAbj71J4B0+IG5Ty7AdbX8n7Hdpprrb4FEbm37MNFOtyPeKN4stOeCYc2JYk5IjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLAGbwee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLAGbwee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D211F000E9;
	Fri, 17 Jul 2026 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784313877;
	bh=zGUMs6nCQ2z1AJ0q//aPA8GlHfy54BsA7Q94Klh5j44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLAGbweeCUIAl/V/z0mrydWyaanFrN7Pu41Znkfj+qf68BqTXFaAFT6QlxPe07eTL
	 VmNm9/tSp2BwJskvpeiHzKGoJfUMAqDmrAiLq1hVlssS1EobePDNPP4lPmpeLZv+vO
	 OwSbdEuhB0hVj4iQATeY/trH8K6hQQuCEZ9HCZrv/tUQWPEgDYfa1F5vzYRaNaZVNJ
	 PHUO3fbEjwfhQdESndOevaHZ4d/69EWCm2L/5Ybr8RX1T15WOpGOn1vw0QjDO0upmf
	 yZehA9IZnCRgN2p+UcsikERT+4ViIAGVG/3HfiM9TAPNqWsSQB5MdsaKIwoabLAKsw
	 M37JL63B4vt0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] ACPI: extlog: Defer CXL protocol error
 handling to avoid lock inversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-7-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 18:44:36 +0000
Message-Id: <20260717184436.D6D211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting lock inversion (AA deadlock) between process context a=
nd IRQ context on CPER work locks.
- [Medium] extlog_print_pcie() is compiled out due to a misspelled preproce=
ssor macro, rendering the function and its newly added bounds check dead co=
de.
--

--- Patch [6]: [PATCH v3 06/10] ACPI: extlog: Defer CXL protocol error hand=
ling to avoid lock inversion ---
commit 004b48e5ad5ad98c6645296077a38ad36a959b26
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion

The commit exports cxl_cper_post_prot_err() from ghes.c and modifies
extlog_print() to use it. This avoids an AB-BA deadlock by deferring CXL
protocol error handling to a workqueue instead of calling it synchronously
while holding the MCE notifier chain rwsem.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 0c440d75d9a78..ae79d090de33b 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
[ ... ]
> @@ -244,9 +227,9 @@ static int extlog_print(struct notifier_block *nb, un=
signed long val,
>  			struct cxl_cper_sec_prot_err *prot_err =3D
>  				acpi_hest_get_payload(gdata);
> =20
> -			extlog_cxl_cper_handle_prot_err(prot_err,
> -							gdata->error_severity,
> -							gdata->error_data_length);
> +			cxl_cper_post_prot_err(prot_err,
> +					       gdata->error_severity,
> +					       gdata->error_data_length);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);
> =20

[Severity: Medium]
This isn't a bug introduced by this patch, but does the extlog_print_pcie()
function called for this section type get entirely compiled out?

Looking at extlog_print_pcie() in drivers/acpi/acpi_extlog.c:

drivers/acpi/acpi_extlog.c:extlog_print_pcie() {
#ifdef ACPI_APEI_PCIEAER
    ...
}

Kernel Kconfig macros must use the CONFIG_ prefix to evaluate to true. Since
it checks for ACPI_APEI_PCIEAER instead of CONFIG_ACPI_APEI_PCIEAER, does t=
his
silently disable PCIe AER error logging via the extlog driver and render the
newly added bounds check dead code?

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 17e4ef5552925..b8dbd99da47ef 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -752,8 +752,8 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cx=
l_cper_prot_err_work_data,
>  static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
> =20
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_er=
r,
> -				   int severity, u32 len)
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity, u32 len)
>  {

[Severity: High]
This is a pre-existing issue, but can this cause an AA deadlock?

Looking at cxl_cper_register_prot_err_work() and
cxl_cper_unregister_prot_err_work() in drivers/acpi/apei/ghes.c, they acqui=
re
the cxl_cper_prot_err_work_lock using guard(spinlock) without disabling
interrupts since they execute in process context:

drivers/acpi/apei/ghes.c:cxl_cper_register_prot_err_work() {
    ...
    guard(spinlock)(&cxl_cper_prot_err_work_lock);
    ...
}

If an asynchronous hardware error interrupt fires on the same CPU while this
lock is held, the interrupt handler calls cxl_cper_post_prot_err() which
attempts to acquire the exact same lock using guard(spinlock_irqsave):

drivers/acpi/apei/ghes.c:cxl_cper_post_prot_err() {
    ...
    guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
    ...
}

Would this cause the interrupt handler to spin forever waiting for the lock
that the interrupted process context currently holds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D6
