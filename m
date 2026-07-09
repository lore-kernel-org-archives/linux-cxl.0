Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29625387362
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615362; cv=none; b=WcuOueQ3W8UX0Yh71D7AMd4bSYe9J81IVkxnidcPErpf2fW08uYBLnYV3SghljgMx5A8ATF5Ph/aTneKsKIh5En4hj+9JQO92I5X/rVmzBZflc5cHOEBpPEEl642epP0c+hPjNPpfDAYcCgUMrKcN5nsF61J1KhMAmIlkKneom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615362; c=relaxed/simple;
	bh=dwVp2O4IF/afIEklm5Ljuy9P/sP0RsJCjmrDS5qA+qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/Vo4unx+ryXauV3GDObnkUxZGy3fGq8gfDQZDDk7kikbZYxSibvhYcUqc0xb4oAsx5gvEf4BpTlWDC7dlhNWU9Z3+Fw6lOsFGhrFze6bNXWX5x/WtR06I8dmSmmzMPkMfLMqqOFz59+Jok9QysgeHUB2WOxLOlsMytN41GDxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXKkXibM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXKkXibM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6101F000E9;
	Thu,  9 Jul 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783615360;
	bh=9QjHbmFh7KjggHkTqljVlkxhodXycCZYoKcpdQqrmeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXKkXibM4KDN64Qq+e+wUfkuENkmf2u8kFj6AP+c4dHjrjQs2ZA6e8HMsAHUCBJTN
	 6LRcc5d4Ya6xjBgC/vdJylXYnRprBhRTpxJUIQFnrTctkfH/i7masvP0D/ZgzM6ayg
	 D3xHwI0r1ITej176YRfscsscx5FjV14Ho7xNxQ1VnXVT8H4Py60vi5dn9RrJMGHHcf
	 apWZlvQqSnf0lPzkfIGtQLTtVKCtbqp2rb0tHQFdUBxXv9pSmx0J4lR7Y54X4WLq8K
	 PISigvrEFH7YPe4HF9Sw3Qcg1BVHlI2pdC7X2CniF1O1C0UErA9/2j3sq0c2hxWnQO
	 aLbd0Y33Rnw0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] ACPI: APEI: GHES: Bound CXL event record copy to
 the firmware section length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709162807.1957783-3-dave.jiang@intel.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:42:40 +0000
Message-Id: <20260709164240.8E6101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for out-of-bounds read vulnerability when parsing C=
XL Protocol Error and other CPER sections.
--

--- Patch [2]: [PATCH 2/4] ACPI: APEI: GHES: Bound CXL event record copy to=
 the firmware section length ---
commit 4eb9f7aafa36f7ab79ba6d995ac9206e430ee1b0
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length

This commit addresses an issue where cxl_cper_post_event() copies a fixed-s=
ize
record from the firmware-provided CPER section without validating the secti=
on
length. It passes error_data_length to the function and rejects sections th=
at
are too small.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9b6917698ed24..7b465e2afcb04 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

[ ... ]

> @@ -949,15 +960,18 @@ static void ghes_do_proc(struct ghes *ghes,

[Severity: High]
This isn't a bug introduced by this patch, but while bounds checking is bei=
ng
added for CXL media and DRAM events here, the same vulnerability appears to
remain for CXL Protocol Error and other CPER sections nearby.

Does the code pass the payload to cxl_cper_post_prot_err() without
validating if gdata->error_data_length is sufficient for the struct?

This could lead to an out-of-bounds memory read in
cxl_cper_setup_prot_err_work_data() when copying the structs:

drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data() {
    ...
    cap_start =3D dvsec_start + prot_err->dvsec_len;
    memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
    ...
}

If the firmware provides a CPER_SEC_CXL_PROT_ERR section smaller than
expected, could dvsec_len be read from uninitialized memory and used as an
offset, potentially triggering a page fault?

Similar missing length validation also appears to be present when calling
extlog_cxl_cper_handle_prot_err() in drivers/acpi/acpi_extlog.c:extlog_prin=
t(),
and when accessing mem_err payloads in ghes_handle_memory_failure():

drivers/acpi/apei/ghes.c:ghes_handle_memory_failure() {
    ...
    if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
    ...
}

>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);
> =20
> -			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
> +					    gdata->error_data_length);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
>  			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);
> =20
> -			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
> +					    gdata->error_data_length);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709162807.1957=
783-1-dave.jiang@intel.com?part=3D2
