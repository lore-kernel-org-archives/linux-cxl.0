Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F2433032
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073423; cv=none; b=p2g8+o08TCU++wmJiZfv2wFPW4PAt3B2VmKRMBXKDroFf01x9ARiY2DQ6XmxbmnAeLb5h2uLF9nppsctPRFQDr+j2BQBLLETvPf3duA3PKuR4NXgmiS5L+BVY3aepKzCNgw3j/Y4wzv62q6ooONTUpAtfBgXIyV9hoSO3xGs2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073423; c=relaxed/simple;
	bh=z/ww1f5w3YYXikwx5zLXdOUipuujv3SXHH8i4HQlos4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G71c3d89TvX671sxkQg7fB4NNxZr6cPL4b5LKutapvEokfR2/NhWSt7IFUT2xUYS/X8L6s7IIdLjdAsvmXcwj3e9lgEUxXLBrlvUIZjZKVqCRvC/41vo6vzakLgsiCJtiHUPRxHbvYRkdoDe8W2FN5FUZaZm6vgSFGrlKCf79Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW9ApIjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW9ApIjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13971F000E9;
	Tue, 14 Jul 2026 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073421;
	bh=yP010lPpZsk4mXgUOQ6U3KpZyPThMfoqR7GhK0duQ1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SW9ApIjk9zeTCyAhiHFXSOcbji8ToIuW99TcrsNl99aw5T6EXXubLtxuOLge8kGag
	 FM1y74yu5NmOWDqhH7X3f8+KATaHZX91fBNKH40FCDAe+/sc/CpQzmXjWGs+XmTo/U
	 niaPZVuR1pDw3xWjUKELsQSqT6weZ+a7dxhIouHR9g5svU/DiZ7kTIpwJ0wIC+XrpP
	 suu67PS9ZVvhW1cPfu6d/Pc/+DFsttxRzjl6kJLNg5tJ+bchQMa2pyQBp70ak3jMyf
	 bcvw/71LBBBh3vgRSpWKUHTjUvdHVsAMskwWD/hsV6EMmWbtRCcJQhiobt4nzMw226
	 Pl+FACKf+odVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] ACPI: extlog: Defer CXL protocol error handling
 to avoid lock inversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714231835.303081-7-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
 <20260714231835.303081-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:57:00 +0000
Message-Id: <20260714235701.A13971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deadlock: `cxl_cper_register_prot_err_work` and `cxl_cper_unregist=
er_prot_err_work` take `cxl_cper_prot_err_work_lock` without disabling inte=
rrupts, but the lock is also acquired in hardirq context.
- [High] `cxl_cper_prot_err_work_lock` is a `spinlock_t` acquired in hardir=
q context, which violates PREEMPT_RT locking rules.
- [High] Missing bounds check on `estatus->data_length` in `extlog_print` l=
eads to out-of-bounds read of `elog_buf`.
--

--- Patch [6]: [PATCH v2 6/7] ACPI: extlog: Defer CXL protocol error handli=
ng to avoid lock inversion ---
commit 7b79585a4c6060a80ae775e5e2ed8715f3df690b
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion

The commit avoids an AB-BA lock inversion between the device_lock and the
MCE notifier chain rwsem. It does this by deferring CXL protocol error
handling to a workqueue using cxl_cper_post_prot_err(), which posts errors
to a kfifo rather than handling them synchronously.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 3e3e388af47b3..1fbaf134c04e3 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
estatus->data_length to cause an out-of-bounds read of the elog_buf?

Earlier in extlog_print(), estatus is copied into a 4096-byte (ELOG_ENTRY_L=
EN)
buffer:

    memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
    tmp =3D (struct acpi_hest_generic_status *)elog_buf;

Then apei_estatus_for_each_section(tmp, gdata) iterates over this memory
based on tmp->data_length. Since there appears to be no bounds check
verifying that data_length fits within ELOG_ENTRY_LEN, could a
firmware-controlled data_length cause the macro to read past the end of
the allocated buffer?

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 6fa5d3bab1ceb..b36f6d268c9fd 100644
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

[Severity: High]
This is a pre-existing issue, but does cxl_cper_prot_err_work_lock cause
a sleeping in atomic violation on PREEMPT_RT kernels?

cxl_cper_prot_err_work_lock is declared as a standard spinlock_t using
DEFINE_SPINLOCK(), which becomes a sleepable rt_mutex on PREEMPT_RT. Since
cxl_cper_post_prot_err() is called from hardirq context (via
ghes_proc_in_irq), does acquiring this lock violate the rule against
acquiring sleepable locks in hardirq context?

[Severity: High]
This is a pre-existing issue, but is there a risk of a deadlock involving
cxl_cper_prot_err_work_lock?

When cxl_cper_register_prot_err_work() and cxl_cper_unregister_prot_err_wor=
k()
acquire this lock from process context, they use:

    guard(spinlock)(&cxl_cper_prot_err_work_lock);

This leaves interrupts enabled.

If a hardware error triggers an MCE or ghes_proc_in_irq on the same CPU whi=
le
the lock is held, cxl_cper_post_prot_err() will be called from hardirq
context. It will attempt to acquire the already-held lock using
guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock), which could freeze
the CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231835.3030=
81-1-dave.jiang@intel.com?part=3D6
