Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBC36A03A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864002; cv=none; b=o6XA4FxllwEsjM5RhjxuCn6Bgo64APdQC9qFn6Tw91UwQE3n/bXwxEmnuhukafL30PqczNfmUUTLqcudyhQ3qK/BlOkw/oVfnVr7g7U2NYqQKSvLahDBsatx8PIU2afOIJdjtfyNiY0EGaWWogsLLM506UNHnN4yifVUqiOMysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864002; c=relaxed/simple;
	bh=OyauVABQshqHgqHMeet0hUoXCtuuZOb/w8zgR9gRY8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGITWGI6/saT8m4zHm+sJPy+e18rJUw3uNEJHFO4rc6wwueQbh5Ngamb4NqfdjUjHpv2gwQZ3CTpLYU2kkcyZ0y7c0D4Gl4jrmxi+xV+Qwq669wJv0zGWilEbqKuiS5RGnRJmALpKLdDzSQiKeqN3Wx4KEclB2aAb0RXKhD2KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYsOlIic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYsOlIic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5974D1F000E9;
	Thu, 27 Aug 2026 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864000;
	bh=nl4ovJ7RDoVmBE+bLGzJ/15eFpkuCIVR4Uj+pQRqLW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYsOlIicqUawVZzavuStWiogBQ/WmrhX9KfG+q1nVsRL4//PkaKlIAIrp7V3QHiym
	 zDL3m2AYcwqNSi4xIXGWykTANZaw2XytHi8/SeBJ5nhYq46nRyjH5E25WoVLjy6cxi
	 ztdd6bLgDyqn8/OWby38HAoouUMvuBWeL3ZE1i7pbcAFtV5F/pGKY2Bn08lPe4H7La
	 QwWmG90I3JudkUxg7wZplXpEAKSN+SD14IiL6s9j/0QsyzhlTB5HcmmdMIux1qEFac
	 WCeHrcjzxdJpJivU5fVqPDJwz2EsrlmqYMg2Uk4uiG9y7LzonXoCTkO+lahLLVhDF0
	 MdeBWdraU7UBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/13] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-10-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:53:19 +0000
Message-Id: <20260827205320.5974D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential deadlock because `cxl_cper_prot_err_work_lock` is acquir=
ed in process context without disabling hardware interrupts.
--

commit 1416c4f9e4b0f4dc84b6e812f70c5f34a5255acc
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap=
 copy

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block using =
an
unvalidated firmware-controlled length, which can point the copy outside the
section. This commit extends cxl_cper_sec_prot_err_valid() to check that the
section can hold the header, DVSEC, and RAS Capability block within the rep=
orted
section length.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

[ ... ]

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e5f8dbd17017e..b8dbd99da47ef 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -753,12 +753,12 @@ static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
> =20
>  void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -			    int severity)
> +			    int severity, u32 len)
>  {
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cxl_cper_prot_err_work_data wd;
> =20
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>  		return;
> =20
>  	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

[Severity: High]
This isn't a bug introduced by this patch, but does acquiring this lock in
hardirq context cause a potential deadlock?

If the module initialization thread executes cxl_cper_register_prot_err_wor=
k()
(or unregister) in process context, it acquires cxl_cper_prot_err_work_lock
with interrupts enabled:

drivers/acpi/apei/ghes.c:cxl_cper_register_prot_err_work() {
    ...
	guard(spinlock)(&cxl_cper_prot_err_work_lock);
    ...
}

If a GHES hardware error interrupt fires on the same CPU, executing
ghes_do_proc() -> cxl_cper_post_prot_err(), it will attempt to acquire the
same lock here using guard(spinlock_irqsave).

Would it spin forever waiting for the interrupted process context to release
the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D9
