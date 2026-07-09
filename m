Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5325CC74
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615566; cv=none; b=TI/OUsQRpQRgGfG0Js0MTQ29uDHfENFCKXJ82QfaUcJQV9VN7VlWPe5edWjRX0wu0CtmEHuc+loJfyopq6L3ARhghEL/SlosDaFn5ZUBYGFM/g1cuGOjPIRckflg/aQ2KQg2/w1/5+AmrK9WEcTs20Wz2TaKOxoQyVON3078YtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615566; c=relaxed/simple;
	bh=fdO4O47Ho2g1ZMJGd2EKCiMvk5nT7cSK45kUJQCd2nA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hv8y9A3bp0k4xEYKNi2Eo75HNzF3cxulLiXkwg0519UW16XXrJExUKGil9SktujfA365NDtv1uyv35F4/vVt1rQsHfDt1sEqEMEboIiWOikwF65abcsD+cTtvhQaAD+PK585ZtIpl5GgsGtQFDStuKcVtkSxPMQl6Aa+g6nyMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWz3fc1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWz3fc1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0147A1F000E9;
	Thu,  9 Jul 2026 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783615565;
	bh=i4B6E/HCaNJ78zoWXJfw6wA9P1+QlOkKrtPLwJN+nko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWz3fc1LzzXlKSk0ecvd1eAvWzSDN4bE+efY/leL4D9wwT9NAEoId87IqrI4a8RW0
	 oLQ2TfQs0ALr5RFQJPwpkF0hMncxUlDh8fA6GnBQes8naWrFJ0ZLqJUYzhfaskg1Hs
	 b5xlUN8e9q2Hw6tkwbX4cm5pyPivthfOQZyVJpQI6jeEW10a5DBx94Y2HrXf7LhuIA
	 hbAyt0kbSl0Udowl4m1N4I2QF/3TcrJCuAAiA5TkTnGbk/cnjYM5s7G7tNuqKq9Zfj
	 GxfJBk5URjmadCFIZi8o0N5ozkQokw/HNbT3Jnq1MfZyhy4gHxPIkQ45h8uFp6bojs
	 wb8TJbksPKhVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL
 CPER work locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709162807.1957783-2-dave.jiang@intel.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:46:04 +0000
Message-Id: <20260709164605.0147A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on CPER record length and `dvsec_len` allows =
an out-of-bounds memory read that can be leaked to userspace via trace even=
ts.
--

--- Patch [1]: [PATCH 1/4] ACPI: APEI: GHES: Use spin_lock_irqsave() for CX=
L CPER work locks ---
commit 92925c77a9085c947d2733f2a851c54ec53288f8
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL CPER work locks

This patch switches the cxl_cper_work_lock and cxl_cper_prot_err_work_lock
from plain spinlocks to spin_lock_irqsave(). This prevents a potential dead=
lock
when a GHES error interrupt interrupts a thread holding the lock in process
context.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..9b6917698ed24 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -863,7 +863,7 @@ int cxl_cper_unregister_work(struct work_struct *work)
>  	if (cxl_cper_work !=3D work)
>  		return -EINVAL;
> =20
> -	guard(spinlock)(&cxl_cper_work_lock);
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>  	cxl_cper_work =3D NULL;
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but looking at the CXL CPER work queue
handling, is there a potential out-of-bounds read when processing
malformed CPER records?

In drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data(),
the cap_start pointer is computed using an untrusted dvsec_len from the
firmware:

    dvsec_start =3D (u8 *)(prot_err + 1);
    cap_start =3D dvsec_start + prot_err->dvsec_len;

    memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));

Since dvsec_len is provided by firmware, could a maliciously large value
cause cap_start to point outside the mapped CPER record bounds?

Similarly, in drivers/acpi/apei/ghes.c:cxl_cper_post_event(), the code
copies the event record:

    memcpy(&wd.rec, rec, sizeof(wd.rec));

If a hardware device provides a malformed record with a small
error_data_length or an unusually large dvsec_len, could this unconditional
memcpy() read unmapped memory or leak kernel memory contents to userspace
via the kfifo trace events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709162807.1957=
783-1-dave.jiang@intel.com?part=3D1
