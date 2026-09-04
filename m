Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5B51A75B
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545533; cv=none; b=CctAiw1ZyL7Xd25LqSuJuxeRYtWlZwiQ7Uq3RIw9qk3hwDZ5bQyRQ3A3BCpI47+hS2aHX2eyKJox3VaY/soTn0W8ZC1Ry1I4Dh7RteIMGfSvV7AnBh8bKksaQn3X0dV9ZIr/UnRiRSy1BHX+tU9nlnZqWip/PRV0RlAYDwoMxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545533; c=relaxed/simple;
	bh=qS5+Rt3MDD06WMHp/81sd+8Y7RRCDME5TmQDLROSh4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O95PpkH+e17Cfq7VJfQUZeXpKg3qitVr+ou0HeZvuZElo2V3yhqMSlHqyJjH8MM7SjBWicpAhBsqWEFpu9+fNuEbIdYfM+nrprO7HLMKJVzVO/Vy/RYFMkR6kTq8Sek8jimIvBT5DJUuDo9Apx0pC0YPBHLvs65D6Pq22w5jLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEBK5LQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEBK5LQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E154F1F00A3D;
	Fri,  4 Sep 2026 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545531;
	bh=acEcccBw8kAaYRAWdVkvBo++xnj44XuForawEb3YFwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEBK5LQHFYxAmS/jqoBtY5/k8+tZpC5tNBR7jwQ6KY23aN/Lh4lvqwWxA2/xoox5W
	 J/ZLrqCxarktpqIZ4WbtJPTV+OSf1GEPidY0QCkr2Mi7sLLjqqdxfNrwV0tWOwz9g7
	 sIcU5fFaCvCsfRmeZNtkUZDaFbSePDZBuo0OlIsbObZd96OEkFHwxb4VEZNLoW339n
	 12j5rNRYFszY7S7FA3SryEmAsVxGj3Mur+UHtg+KtimOxgYgutRTzbXpBsX7+vlqr6
	 r8xWExdRYHqUyAHy9i0L2slGrtRM35wsZLHrfahMSraNPjKC2EFUetNxOubZaai21K
	 ZSHjH/u9AgEEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] ACPI: APEI: GHES: Validate memory error
 section length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-12-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:12:10 +0000
Message-Id: <20260904181210.E154F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes length validation in ghes_do_proc() but leaves an =
identical logic flaw and buffer over-read unfixed in cper_print_mem().
--

commit 8bbaca1beceadb4f3349da69c4f0bedd1d913c54
Author: Dave Jiang <dave.jiang@intel.com>
Subject: ACPI: APEI: GHES: Validate memory error section length before payl=
oad access

This patch adds length validation in ghes_do_proc() before accessing the
CPER_SEC_PLATFORM_MEM payload to prevent reading past the record. It ensures
records are at least 73 bytes and validates the remaining length based on t=
he
claimed fields.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D7

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 111895c57c2f9..2077cc90569a0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -954,6 +976,25 @@ static void ghes_do_proc(struct ghes *ghes,
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>  			struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata);
> =20
> +			/*
> +			 * Check once for all three consumers below. The 73-byte
> +			 * UEFI 2.1/2.2 layout is the floor, matching
> +			 * cper_estatus_print_section() and making
> +			 * validation_bits safe to read.
> +			 */
> +			if (gdata->error_data_length <
> +			    sizeof(struct cper_sec_mem_err_old))
> +				continue;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does leaving cper_print_mem()
unfixed bypass these newly added safety checks?

As noted in the commit message, cper_print_mem() gets the mask checking
wrong. When firmware provides a CPER memory error record with a length
between 74 and 79 bytes, the exact match check in cper_print_mem() fails to
catch the invalid length:

drivers/firmware/efi/cper.c:cper_print_mem() {
    ...
	/* Don't trust UEFI 2.1/2.2 structure with bad validation bits */
	if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
	    (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
		pr_err(FW_WARN "valid bits set for fields beyond structure\n");
		return;
	}
    ...
}

Because ghes_proc() calls ghes_print_estatus() before ghes_do_proc(), this
code executes before the new checks in this patch are reached.

When cper_print_mem() then calls cper_mem_err_pack(), it blindly reads
out-of-bounds fields if the payload is smaller than 80 bytes:

drivers/firmware/efi/cper.c:cper_mem_err_pack() {
    ...
	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
		cmem->mem_dev_handle =3D mem->mem_dev_handle;
    ...
}

Could this result in an out-of-bounds memory read (such as mem_dev_handle
at offset 78) and an information leak to dmesg before ghes_do_proc() has a
chance to reject the malformed record?

> +			/* Then require what the claimed fields actually need. */
> +			if (gdata->error_data_length <
> +			    ghes_mem_err_min_len(mem_err->validation_bits)) {
> +				pr_warn_ratelimited(FW_WARN GHES_PFX
> +						    "memory error section too small (%u) for the fields it claims\=
n",
> +						    gdata->error_data_length);
> +				continue;
> +			}
> +
>  			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
> =20
>  			arch_apei_report_mem_error(sev, mem_err);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D11
