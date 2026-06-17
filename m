Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0A3F4DF8;
	Wed, 17 Jun 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705402; cv=none; b=obGXX1Oky/3/1tapSmUyesRN3joed/TV2PMfoXE5HblBmWCk/y4UH+yofhXj+KZxzlq9WFEUpGvBLWf+3J56ISPghvziS3QApZGpd4U1h4GDQFEV7lGt1v1KHg2I6RmDKk/vTr6MLX3zS8ZdeoEEp8wigiVsDNP6/yf/mgV01zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705402; c=relaxed/simple;
	bh=Td1I54O4Oi0G4HxCNJQDwLqsyV8X6O4XJZGa6A0m/1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E763DR2JAPWSANR8DVQ275zeVZrDlpEq6MZUUsPeLhEFOGyPH/YKRIgb97xFhkuHCRf2F35uQ/JD0z2EbULt35yKV7t22era3JdxrO4P0/AatjAK/iRw30E2sOj8dR0Wob38DQnF+zd7aXeXVZb2IIMLxa50bQA0YGrVnPKD70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOnYHsJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOnYHsJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8392A1F000E9;
	Wed, 17 Jun 2026 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705400;
	bh=4E6KjgoANui6U1nzZkMJS+DKQohQ8atHwtMi2KwHKkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOnYHsJETNL51gXgQLhtgD1B7oqAFJ7av4bOJvvpOQn2TOdYI61tFhXVo6Rjarr2W
	 +/+bh7Hg1q3FIIVeBmu69Ev1f2lRNwUy4KWbJQj2ujxSKEbqbhuorUQMHpXRK3LY8U
	 810Qc/FvR3kHG5L2OsRoMbvJoj7eqnX34H7o76XR+O3qDyo1jzLELLzB1VaO/ftrPf
	 ukECQxuhzNMZZFet/Nhm5C7Gc4XuIcnfDYrX+WH5PdGxWy3wdAK3cMNNsEmyQLXEMO
	 a/wW+9QyDZVN7eH09HbcQJPX4Cn+iL8UnljmRnZnFJbFwm7v1YYtr8SBN84SoZ4c5s
	 pYyRdF4Q3MS4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] ACPI: APEI: GHES: move estatus cache helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-cxl@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-4-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-4-91f725174aa0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:10:00 +0000
Message-Id: <20260617141000.8392A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory Leak / Resource Exhaustion in ghes_estatus_cache_add()
- [High] Time-of-Check to Time-of-Use (TOCTOU) / Double Fetch in ghes_read_=
estatus()
- [High] Missing bounds checks on gdata->error_data_length causing Out-of-B=
ounds Reads
--

commit a78b7d6a2bbf24ad4d5f5d8876b30cdec8135faf
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: move estatus cache helpers

Relocate the estatus cache allocation and lookup helpers from ghes.c into
ghes_cper.c. This code move keeps the logic intact while making the cache
implementation available to forthcoming users.

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index c6e20fdc6964e..5218fc57e5622 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
[ ... ]
> +void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
> +			    struct acpi_hest_generic_status *estatus)
> +{
> +	unsigned long long now, duration, period, max_period =3D 0;
> +	struct ghes_estatus_cache *cache, *new_cache;
> +	struct ghes_estatus_cache __rcu *victim;
> +	int i, slot =3D -1, count;
> +
> +	new_cache =3D ghes_estatus_cache_alloc(generic, estatus);
> +	if (!new_cache)
> +		return;
> +
> +	rcu_read_lock();
> +	now =3D sched_clock();
> +	for (i =3D 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
> +		cache =3D rcu_dereference(ghes_estatus_caches[i]);
> +		if (cache =3D=3D NULL) {
> +			slot =3D i;
> +			break;
> +		}
> +		duration =3D now - cache->time_in;
> +		if (duration >=3D GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
> +			slot =3D i;
> +			break;
> +		}
> +		count =3D atomic_read(&cache->count);
> +		period =3D duration;
> +		do_div(period, (count + 1));
> +		if (period > max_period) {
> +			max_period =3D period;
> +			slot =3D i;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (slot !=3D -1) {

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential memory
leak here.

If all slots are occupied and period <=3D max_period for all entries (e.g.,=
 if
multiple errors occur in the same timer tick causing duration < count + 1,
making period =3D 0), slot remains -1.

In this case, the function skips the insertion block and returns without
freeing new_cache or decrementing the ghes_estatus_cache_alloced counter.
Since GHES_ESTATUS_CACHE_ALLOCED_MAX is only 6, could 6 occurrences of this
condition permanently exhaust the pool and disable the deduplication mechan=
ism?

> +		/*
> +		 * Use release semantics to ensure that ghes_estatus_cached()
[ ... ]


I also wanted to ask about a couple of other pre-existing issues.

[Severity: High]
This is a pre-existing issue, but is there a double-fetch vulnerability in
ghes_read_estatus()?

drivers/acpi/apei/ghes_cper.c:ghes_read_estatus() {
    ...
	rc =3D __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
	if (rc)
		return rc;

	rc =3D __ghes_check_estatus(ghes, estatus);
	if (rc)
		return rc;

	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
				   cper_estatus_len(estatus));
}

The code peeks the error status header from physical memory and validates i=
ts
length via __ghes_check_estatus(). However, __ghes_read_estatus() then
performs a second read from the same physical memory to copy the full block.

If a hardware source modifies the data_length field between these two reads,
could the newly copied header overwrite the validated length with an
unvalidated size, leading to out-of-bounds heap reads during subsequent
parsing?


[Severity: High]
This is a pre-existing issue, but are there missing bounds checks on
gdata->error_data_length in ghes_handle_aer() and ghes_cper_handle_status()?

drivers/acpi/apei/ghes_cper.c:ghes_handle_aer() {
    ...
	struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);

	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
    ...
}

And similarly in ghes_cper_handle_status():

drivers/acpi/apei/ghes_cper.c:ghes_cper_handle_status() {
    ...
		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);

			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
    ...
}

The payload is cast and dereferenced without verifying that
gdata->error_data_length is large enough to contain the expected structure
size. If a valid section UUID is provided with a short error_data_length
near the end of the estatus buffer, could this read past the end of the
allocated kernel buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-topics-ahm=
tib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=3D4
