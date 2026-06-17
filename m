Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B092F7F06;
	Wed, 17 Jun 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705475; cv=none; b=GbX+hB/MwGdbO+9LGKRbcu3SPSJNtJtKfSbmBtclU6zOEzooJH52c8a+lmD8B7k5EWxWlQFMn4Q08bQ3mNA/cq72XwBhP+Z9rxCw+Wjn45VgxRQdX+bl39OVAJRYWjdfaOaMjHtuBH28ilpjYRYI3Zn/X4ZgXucEFfHSsX76s+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705475; c=relaxed/simple;
	bh=LzzrTX2t9epFJoNTrZnelleJBpg6k1OEbbO0SVq0ymQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UbRq9mFkJo8DDtzZnC0vCq3sRR29FLmcG2TAczpPEGBzvU4Zh0UdnbVMYbVkOvyLjlA2r1zbilVKUnCi15WZtdp8DH7zV33tfM4csAz1+CVOI6G6X+EDHSD3+bN9HOOhDz9sPD1jdLf+p4vsCnpz78MTcf3YpoBSe9GYSJHW2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezIZU/bJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezIZU/bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3061B1F000E9;
	Wed, 17 Jun 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705474;
	bh=8f4ZuZ0rIs43EEkLd1lTuZuwmaB5674LWKUNnvha2zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezIZU/bJXwX19k73QKG0Q6K2OmEllvIrSWR2vBKJOTj3pANRd3riefIG4fjO/PHOQ
	 pgGTFJ14c9QkqZZfYKTkx2TOjO40FxTIuqKQPeIo+4Edi6RbtTQbb3W7zt7r2/7yPx
	 2gffJE+y34ZLoGBSTqITZvlhL14fxP2e5+xID6dLQ05eOb05GW6U8erLSZMeDj1iv5
	 yerwSa98MGzbDEtA1b0igueUpljE7tKt1hgdwpvswg8qeaYGD6KCXt4gr9Md7/2rTc
	 o1Uksn21tQcAUxuycjjvcdyVn9y26i9B1EwIcDQXZ3PULxWORzInQumvEsZ3xp/D5z
	 1ZQJIsQE13gUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] ACPI: APEI: share GHES CPER helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: linux-cxl@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-8-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-8-91f725174aa0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:11:13 +0000
Message-Id: <20260617141114.3061B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect size subtraction in `ghes_handle_arm_hw_error()` inf=
lates the remaining payload length, leading to out-of-bounds reads.
- [High] Memory allocated for aer_info is permanently leaked if the aer_rec=
over_ring kfifo overflows.
- [High] The `queued` boolean flag is overwritten on each loop iteration, w=
hich can unnecessarily force a task to be killed with SIGBUS.
- [High] Memory allocated for PCI AER recovery is leaked if the associated =
PCI device is not found.
- [High] Potential deadlock due to missing IRQ disable in CXL work registra=
tion functions.
--

commit 552b224fbe0e1a9a6cbfb11eef23d5902aa40cf8
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: share GHES CPER helpers

This patch moves the GHES CPER helper routines from ghes.c to ghes_cper.c to
allow them to be shared with other firmware-first providers. It also
serializes the ghes_estatus_pool initialization to prevent race conditions
and pool reuse issues.

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 66bf1af4db00b..460fe12b6513c 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -36,9 +47,449 @@
[ ... ]
> +bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
> +			      int sev, bool sync)
> +{
> +	struct cper_sec_proc_arm *err =3D acpi_hest_get_payload(gdata);
> +	int flags =3D sync ? MF_ACTION_REQUIRED : 0;
> +	int length =3D gdata->error_data_length;
> +	char error_type[120];
> +	bool queued =3D false;
> +	int sec_sev, i;
> +	char *p;
> +
> +	sec_sev =3D ghes_severity(gdata->error_severity);
> +	if (length >=3D sizeof(*err)) {
> +		log_arm_hw_error(err, sec_sev);
> +	} else {
> +		pr_warn(FW_BUG "arm error length: %d\n", length);
> +		pr_warn(FW_BUG "length is too small\n");
> +		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> +		return false;
> +	}
> +
> +	if (sev !=3D GHES_SEV_RECOVERABLE || sec_sev !=3D GHES_SEV_RECOVERABLE)
> +		return false;
> +
> +	p =3D (char *)(err + 1);
> +	length -=3D sizeof(err);

[Severity: Critical]
This is a pre-existing issue, but does this subtract the size of the pointer
instead of the struct?

In drivers/acpi/apei/ghes_cper.c:ghes_handle_arm_hw_error(), err is a
pointer to struct cper_sec_proc_arm. Subtracting sizeof(err) subtracts
8 bytes instead of the actual structure size (40 bytes).

This artificially inflates the remaining length by 32 bytes. During the
subsequent loop, the boundary check if (length < sizeof(*err_info)) can
evaluate to true even when p has advanced past the end of the gdata
buffer, potentially causing out-of-bounds reads.

Should this use sizeof(*err) instead?

> +
> +	for (i =3D 0; i < err->err_info_num; i++) {
> +		struct cper_arm_err_info *err_info;
> +		bool is_cache, has_pa;
> +
> +		/* Ensure we have enough data for the error info header */
> +		if (length < sizeof(*err_info))
> +			break;
> +
> +		err_info =3D (struct cper_arm_err_info *)p;
> +
> +		/* Validate the claimed length before using it */
> +		length -=3D err_info->length;
> +		if (length < 0)
> +			break;
> +
> +		is_cache =3D err_info->type & CPER_ARM_CACHE_ERROR;
> +		has_pa =3D (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_A=
DDR);
> +
> +		/*
> +		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> +		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
> +		 * firmware won't mix corrected errors in an uncorrected section,
> +		 * and don't filter out 'corrected' error here.
> +		 */
> +		if (is_cache && has_pa) {
> +			queued =3D ghes_do_memory_failure(err_info->physical_fault_addr, flag=
s);

[Severity: High]
This isn't a regression introduced by this patch, but is it possible for
queued to be overwritten if there are multiple error infos?

In drivers/acpi/apei/ghes_cper.c:ghes_handle_arm_hw_error(), if an early er=
ror
info successfully queues memory failure work, but a subsequent one does not,
queued is overwritten to false.

Later in the caller, this might cause if (sync && !queued) to evaluate to t=
rue,
force-killing the task with SIGBUS even though the memory error was
actually queued for recovery.

Should this use queued |=3D ghes_do_memory_failure(...) to accumulate the
results?

> +			p +=3D err_info->length;
> +			continue;
> +		}
[ ... ]
> +void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +	struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		unsigned int devfn;
> +		int aer_severity;
> +		u8 *aer_info;
> +
> +		devfn =3D PCI_DEVFN(pcie_err->device_id.device,
> +				  pcie_err->device_id.function);
> +		aer_severity =3D cper_severity_to_aer(gdata->error_severity);
> +
> +		/*
> +		 * If firmware reset the component to contain
> +		 * the error, we must reinitialize it before
> +		 * use, so treat it as a fatal AER error.
> +		 */
> +		if (gdata->flags & CPER_SEC_RESET)
> +			aer_severity =3D AER_FATAL;
> +
> +		aer_info =3D (void *)gen_pool_alloc(ghes_estatus_pool,
> +						  sizeof(struct aer_capability_regs));
> +		if (!aer_info)
> +			return;
> +		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs=
));
> +
> +		aer_recover_queue(pcie_err->device_id.segment,
> +				  pcie_err->device_id.bus,
> +				  devfn, aer_severity,
> +				  (struct aer_capability_regs *)
> +				  aer_info);

[Severity: High]
This is a pre-existing issue, but does aer_info leak if aer_recover_queue()
fails to add the entry to the kfifo or if the device isn't found?

In drivers/pci/pcie/aer.c:aer_recover_queue():

	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
				 &aer_recover_ring_lock))
		schedule_work(&aer_recover_work);
	else
		pr_err(...);

If the kfifo overflows, it drops the entry and returns without freeing the
buffer allocated from the fixed-size ghes_estatus_pool.

Additionally, in drivers/pci/pcie/aer.c:aer_recover_work_func(), if
pci_get_domain_bus_and_slot() returns NULL (e.g. if the device fell off the
bus), the code executes a continue statement which skips the
ghes_estatus_pool_region_free() call, leaking the memory.

Since ghes_estatus_pool is a fixed-size pool, repeated leaks could exhaust =
it
and prevent future RAS errors from being processed. Could these error paths
free the memory?

> +	}
> +#endif
> +}
[ ... ]
> +void ghes_cper_handle_status(struct device *dev,
> +			     const struct acpi_hest_generic *generic,
> +			     const struct acpi_hest_generic_status *estatus,
> +			     bool sync)
> +{
> +	int sev, sec_sev;
> +	struct acpi_hest_generic_data *gdata;
> +	guid_t *sec_type;
> +	const guid_t *fru_id =3D &guid_null;
> +	char *fru_text =3D "";
> +	bool queued =3D false;
> +
> +	sev =3D ghes_severity(estatus->error_severity);
> +	apei_estatus_for_each_section(estatus, gdata) {
> +		sec_type =3D (guid_t *)gdata->section_type;
> +		sec_sev =3D ghes_severity(gdata->error_severity);
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +			fru_id =3D (guid_t *)gdata->fru_id;
> +
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +			fru_text =3D gdata->fru_text;
> +
> +		ghes_log_hwerr(sev, sec_type);
> +		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +			struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata);
> +
> +			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
> +
> +			arch_apei_report_mem_error(sev, mem_err);
> +			queued =3D ghes_handle_memory_failure(gdata, sev, sync);

[Severity: High]
This isn't a regression introduced by this patch, but does queued get
overwritten here as well?

Just like in ghes_handle_arm_hw_error() above, if an early section in
drivers/acpi/apei/ghes_cper.c:ghes_cper_handle_status() succeeds but a
later section does not, queued is overwritten to false.

This can result in the loop completing with queued =3D=3D false despite a p=
revious
successful queueing, which will then incorrectly trigger the sync && !queued
force kill logic below.

> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			ghes_handle_aer(gdata);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> +			queued =3D ghes_handle_arm_hw_error(gdata, sev, sync);

[Severity: High]
This is a pre-existing issue, but this direct assignment of queued has the
same overwriting problem across multiple sections as noted above.

> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
[ ... ]
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index a853a5996cdfa..e09a33d343d79 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
[ ... ]
> @@ -107,6 +110,23 @@ void ghes_estatus_cache_add(struct acpi_hest_generic=
 *generic,
>  			    struct acpi_hest_generic_status *estatus);
>  void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  				   int sev);
[ ... ]
>  void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  			    int severity);
>  int cxl_cper_register_prot_err_work(struct work_struct *work);

[Severity: High]
This is a pre-existing issue, but could the CXL work registration functions
deadlock with the GHES interrupt handler?

In drivers/acpi/apei/ghes_cper.c, the spinlocks cxl_cper_work_lock and
cxl_cper_prot_err_work_lock are acquired in hardirq/NMI-deferred context by
cxl_cper_post_event() and cxl_cper_post_prot_err() using guard(spinlock_irq=
save).

However, the registration functions cxl_cper_register_work() and
cxl_cper_register_prot_err_work() acquire these locks using guard(spinlock),
leaving interrupts enabled.

If a GHES hardware error interrupt fires on the same CPU while the lock is =
held
by a registration function, the interrupt handler will attempt to acquire t=
he
same lock, resulting in a deadlock. Could these registration functions use
guard(spinlock_irqsave)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-topics-ahm=
tib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=3D8
