Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760F433E71
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073274; cv=none; b=D29ByakIZB9Y9W9FYTXRKddmaxKmfdkE1VPtMplK/5GzUI/QTLEtZaU07PHB28f+GHOQxWypDYBTHqiCOTdGYr2XD2mZcylo4vseSLrF9rcIi/YADElKxdma9EOVhRkWEzXEylVcxUvZEqsoDKxmc2tvT9GVoWvJC6PSra4hqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073274; c=relaxed/simple;
	bh=G67/h8IT1gIbDR1bx1/juoyHXtYiBzuMCz4Ic0cGQpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifWlgSmfFCDvvsriae9g6w8Uu6yQcYDBaiPlNDv/h4TLDkK2WfB5OljU0OWh4pw1dIxYtqO1GaAlvpBSjGd28ix5+MBldbeXgmny9qbHQQvHKkeAzLoH+iTwyCT1qASUDuiqM6WAcdCqn7WX2ywZRvPtUFGusQTSzruw/uC89sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofzuh5KJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofzuh5KJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97411F000E9;
	Tue, 14 Jul 2026 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073272;
	bh=CQ/AZRavTkZa5uMYB7DmW7PocxrmrPle706Bo+qF0bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofzuh5KJOaJ8AWgdLBB8kXDU8O9VKKA31wOfAa2KYg8RpTfE5NPSOHCyAr2izkova
	 vVDFj1pDhi9gQ4bi+GT0WPLSM7m2qerleI/x7TD2v8DGeq2thPQHENm7ohWCjoY1CC
	 dMfkfAiaaMPisNUfJ76Bbc4y8Puf4Pcn8eKWSb3iK5l5Gj6dQ56coZ90Pz8nI9JdBm
	 l3OPg0Q/RWeWp2cQo+RZ86r2VK+8qfpHMjXUXu1ojoEy+RMU8OF8UG3xqHWZCFDGPj
	 Ja9I/SEmTLVwH181QBb35eIDjYGhcJf7KAJnh6KCdiMfRSxwLlQOlQOXXg7Ro4f888
	 jbZC7Rig0p7LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] ACPI: APEI: GHES: Bound CXL event record copy to
 the firmware section length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714231835.303081-2-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
 <20260714231835.303081-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:54:32 +0000
Message-Id: <20260714235432.B97411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The new length validation ties the minimum firmware section size=
 to the kernel's internal maximum union size, which will break backwards co=
mpatibility with existing firmwares as soon as the CXL event union grows.

Pre-existing issues:
- [High] Deadlock due to acquiring a spinlock in process context without di=
sabling interrupts, while the same lock is acquired in hardware interrupt c=
ontext.
- [High] The newly added length check `len < sizeof(*rec)` can be bypassed =
via an integer overflow, defeating the patch's protection and allowing an o=
ut-of-bounds kernel memory read.
--

--- Patch [1]: [PATCH v2 1/7] ACPI: APEI: GHES: Bound CXL event record copy=
 to the firmware section length ---
commit e26fd5aa15a7b2ef67720b7ee480d05f9c35224c
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length

This commit adds a bounds check to cxl_cper_post_event() to prevent copying
more data than what the firmware provided in the CPER section. It passes
the error data length into the function to reject undersized sections.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..9916271a81513 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -815,10 +815,21 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
>  struct work_struct *cxl_cper_work;
> =20
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
> -				struct cxl_cper_event_rec *rec)
> +				struct cxl_cper_event_rec *rec, u32 len)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but can this lock cause a
deadlock?

Looking at how cxl_cper_work_lock is acquired in process context:

drivers/acpi/apei/ghes.c:cxl_cper_register_work() {
    guard(spinlock)(&cxl_cper_work_lock);
    ...
}

And how it is acquired in hardirq context here in cxl_cper_post_event():

drivers/acpi/apei/ghes.c:cxl_cper_post_event() {
    ...
    guard(spinlock_irqsave)(&cxl_cper_work_lock);
    ...
}

If a process calls cxl_cper_register_work() and acquires the lock without
disabling local interrupts, and a hardware error triggers an interrupt on
the same CPU, cxl_cper_post_event() will attempt to acquire the exact same
lock. Does this violate the locking rule that if a lock is used in hardirq
context, all process-context acquisitions must disable interrupts?

>  	struct cxl_cper_work_data wd;
> =20
> +	/*
> +	 * The record is copied whole below, so the firmware-provided section
> +	 * must be at least as large as the record. cper_estatus_check() only
> +	 * validates the section fits the error block, not that it satisfies a
> +	 * given section type's size, so guard the fixed-size copy here.
> +	 */
> +	if (len < sizeof(*rec)) {

[Severity: High]
This is a pre-existing issue, but does this length check remain vulnerable
to an integer overflow bypass?

If the firmware provides a length like 0xFFFFFFB9, upstream validation
implicitly casts this u32 to a signed int:

include/acpi/ghes.h:acpi_hest_get_error_length() {
    return ((struct acpi_hest_generic_data *)(gdata))->error_data_length;
}

This returns a negative value, which underflows the size calculation and
bypasses the estatus bounds check.

When execution reaches this point, len is evaluated as the unsigned value
0xFFFFFFB9. The check 0xFFFFFFB9 < sizeof(*rec) evaluates to false,
bypassing this new protection and allowing the memcpy to read out of bounds.

[Severity: Medium]
Will this strict size requirement break backwards compatibility with older
firmwares if the kernel's internal event union structure increases in size?

By enforcing that len is at least sizeof(*rec) (which currently contains
union cxl_event), the minimum firmware section size is tied to the kernel's
internal maximum union size.

If a future CXL specification introduces a larger event type and the kernel
expands the union, sizeof(*rec) will increase. When that happens, would the
updated kernel erroneously reject perfectly valid legacy events emitted by
existing older firmwares?

Could we instead verify len >=3D sizeof(rec->hdr), zero-initialize the work
data buffer, and safely copy min_t(size_t, len, sizeof(*rec)) bytes to
decouple firmware section sizes from internal kernel union sizes?

> +		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
> +		return;
> +	}
> +
>  	if (rec->hdr.length <=3D sizeof(rec->hdr) ||
>  	    rec->hdr.length > sizeof(*rec)) {
>  		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231835.3030=
81-1-dave.jiang@intel.com?part=3D1
