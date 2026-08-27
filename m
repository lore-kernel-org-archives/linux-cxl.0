Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348631E832
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864130; cv=none; b=MPzVN1IX8JINAp0D27bMyN8eEXZqGsD0YaIXP3uyG46Ul4R/EH6UWXEfJXP67gDQvq6E3QoJg6TYAiRlqgmuQP/EOFro9ejAHWrFSqEmbmblSYFZ6Zpe+y5uifbgXd0patfaupfyM+OJZ76CVAi9Mmfl/3qK/0H3Btfs/cCGOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864130; c=relaxed/simple;
	bh=kbsXIljuJtWPKpagRtZjubz796+iG82GELXFUMTVIEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G8c2rJ8UKoqVsBzEX6zrTSHLyxtV2ossZLZI503RFKj7Cn7PWvSpW3DNVEdRXI7jJD49OIDLJMRddprzOd2O4q8xe2A5tccujF4NFE7lq0tRc+qmSBcAJE0rfGxKcmTCNdYy2IYeztXRQzrwfKWG2xUzuwBPjwj6U8zcfUslXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtM/ItkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtM/ItkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADA1F000E9;
	Thu, 27 Aug 2026 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864129;
	bh=QJx59hXbSLPW895+u9akbXhhEF2wzqhuhrSefN5hkwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EtM/ItkLJc79Xu4X9UKn+i4nroKSqhM+3ArWX1qhROTCDAWiUQT6uA2JScqmiasaw
	 YbNn/bUT+hK0Y6vjf5oFp/beQlZgEQYZX5NtezYHWsXf1F4p5wK+WpMW22KqurWcWS
	 UADPQPBmUBYRvlmMizJr4L8py89cQADsN5FBHU169MUHk16/yQ3K5uqMkctQDhGpz8
	 M+GFDu5V2WlxoZM4UZIxh9QDhDTnmW4yD6ZArPm0mjQeRXl7SbCaY+dohNtmfr6M/J
	 vkTh0aP/Y2RpzKADm6ZeptrK0l0ZpkJ9DvyJZ+Go8gGj6GyYYHeXw4aF7Z/lIzG0NQ
	 /sFfnQWQS6Dfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/13] ACPI: APEI: GHES: Bound CXL event record copy
 to the firmware section length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-9-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:55:28 +0000
Message-Id: <20260827205528.C4ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential AB-BA deadlock due to missing IRQ disablement when acqui=
ring spinlocks shared with hardirq context.
--

commit 5c5cd12a22557cc71932382234f47a7a0364bb43
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length

cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
out of the firmware CPER section without checking how long the section
actually is. This patch passes the section length in and rejects sections
too small to hold the record before the copy.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a382aabf9835e..e5f8dbd17017e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -816,10 +816,15 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
>  struct work_struct *cxl_cper_work;
> =20
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
> -				struct cxl_cper_event_rec *rec)
> +				struct cxl_cper_event_rec *rec, u32 len)
>  {

[Severity: High]
This is a pre-existing issue, but does the locking strategy here expose the
kernel to a potential deadlock?

cxl_cper_post_event() and cxl_cper_post_prot_err() execute in hardirq conte=
xt
(e.g., via ghes_proc_in_irq() or ghes_irq_func()) and acquire
cxl_cper_work_lock or cxl_cper_prot_err_work_lock.

However, the registration functions in drivers/acpi/apei/ghes.c such as
cxl_cper_register_work(), cxl_cper_unregister_work(),
cxl_cper_register_prot_err_work(), and cxl_cper_unregister_prot_err_work()
execute in process context and acquire these same spinlocks using
guard(spinlock), which expands to spin_lock() and does not disable local
interrupts.

If a CPU executing one of these registration functions is interrupted by a
hardware error IRQ while holding the lock, the interrupt handler will attem=
pt
to acquire the exact same lock in cxl_cper_post_event() or
cxl_cper_post_prot_err(), resulting in an immediate deadlock.

Should the registration functions use guard(spinlock_irqsave) instead of
guard(spinlock) to prevent this?

>  	struct cxl_cper_work_data wd;
> =20
> +	if (len < sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
> +		return;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D8
