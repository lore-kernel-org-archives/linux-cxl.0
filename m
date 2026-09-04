Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2946509EF1
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545146; cv=none; b=ff+pS5UL7aW3ujOa07DUL5PPIu2Pv3u5d0KsjpLlA7okFhLPAu3faUvh0lCYKYbiOEmC26eRCJ0WMnYTw8xTJ/wnCr9565eibAEwNyr55ptpahUNe4xNcg6N9IlZ98jRSLh3nHaYEjB7hn2NtqM1Vj7LmfIYbuWu4AY/niYoF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545146; c=relaxed/simple;
	bh=RYGs3VP0KuupiUun5xT/LpPQHXnJAJRCbh0yxzjVmbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YgC212S7oRZ8tCPd8fBGMb60kvglOL/GjU1Nh66xYRF2rJ3xhAMrL1CMWvmKMuKmBxFn7lMVo+PHlwN0cr/03nUuePZ2tAl0SVbP2N6PT14xeoYrvMF1HQ+DJ1Oda62pVl7JxlkYsL6iiapmurGE1IjaWoKRpiB6KqDJgbpUe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGVCEfys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGVCEfys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308121F00A3D;
	Fri,  4 Sep 2026 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545145;
	bh=glUaxBAUOWgZiT+6zKSBxAgWDr1dXVssj0xbXeYyUys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGVCEfysxfHcuyqqmU15sESo0iZwae8ndyb0oTGE44QDFy6niNcaHWJmFZTJdFV1L
	 zTkQdAHFl/w7S31HnfZBX5joGBZbeuPWmzABI+1+v5WXGif2hHqCHldfH2ZhcJb6lF
	 REbvuM147VNtHXktqh6KyEDKuH4/4A/sosh1Vlt0sCJnBWOqtiQQG2aMmSbDeGyalv
	 lKPDO8U209hnYHs2OCW1xDZFjAAxjSyM+Rnc0NOv0KlGJizLzeHKFtyLm4bQTDdajD
	 7qgvS+DCQ+m/PGHynxGJwr/rUwos1t9cc4bnSGFVz7ghZ6/m99Q+x/cYM0cjvRmwrM
	 3gTgXGgkhj+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-10-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:05:44 +0000
Message-Id: <20260904180545.308121F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-Bounds Read in `cxl_cper_print_prot_err` when dumping firmw=
are-controlled length
- [High] Mismatched validation check in `cxl_cper_sec_prot_err_valid` drops=
 valid errors and accepts uninitialized agent types
- [High] Invalid pointer comparison in `match_memdev_by_parent` entirely br=
eaks CPER log association for memdevs
--

commit 370881a728ea6e57fe2c8f02a8283fec779e22bb
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap=
 copy

This commit extends cxl_cper_sec_prot_err_valid() to check the section leng=
th
before copying the RAS Capability block. It ensures the header, DVSEC, and =
RAS
Capability block fit within the reported length to prevent out-of-bounds ac=
cess.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_he=
lpers.c
> index bc7111b740afb..df41b993f4130 100644
> --- a/drivers/acpi/apei/ghes_helpers.c
> +++ b/drivers/acpi/apei/ghes_helpers.c
> @@ -5,8 +5,15 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
> =20
> -int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, =
u32 len)
>  {
> +	if (len < sizeof(*prot_err)) {
> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err section too small (%u)\n",
> +				   len);
> +		return -EINVAL;
> +	}
> +
>  	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>  		pr_err_ratelimited("CXL CPER invalid agent type\n");
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but does this check use the wrong validation =
bit?

It checks for PROT_ERR_VALID_AGENT_ADDRESS, but the error message states
"invalid agent type", which suggests it should be checking for
PROT_ERR_VALID_AGENT_TYPE.

If the firmware provides a CPER record lacking PROT_ERR_VALID_AGENT_ADDRESS,
valid hardware errors might be silently dropped. If it lacks
PROT_ERR_VALID_AGENT_TYPE, could uninitialized garbage be processed as the
agent type?


While reviewing this patch, I also noticed a pre-existing issue in related
printing code:

drivers/firmware/efi/cper_cxl.c:cxl_cper_print_prot_err() {
    ...
		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
			       prot_err->dvsec_len, 0);
    ...
		size_t size =3D sizeof(*prot_err) + prot_err->dvsec_len;
		struct cxl_ras_capability_regs *cxl_ras;
    ...
		cxl_ras =3D (struct cxl_ras_capability_regs *)((long)prot_err + size);
		pr_info("%s cxl_ras_uncor_status: 0x%08x", pfx,
			cxl_ras->uncor_status);
}

[Severity: High]
This is a pre-existing issue, but could this cause an out-of-bounds read?

The exact same vulnerability fixed by this patch in
cxl_cper_setup_prot_err_work_data() seems to exist here. The callers in
cper.c do not pass the bounding length to cxl_cper_print_prot_err(), so it =
uses
prot_err->dvsec_len unvalidated for print_hex_dump() and to calculate the
pointer to cxl_ras.

If firmware provides an artificially large dvsec_len, could this read
out-of-bounds kernel memory into dmesg or cause a panic?


I also noticed another pre-existing issue in the error handling path:

drivers/cxl/core/ras.c:match_memdev_by_parent() {
	if (is_cxl_memdev(dev) && dev->parent =3D=3D uport)
		return 1;
}

... called from:

drivers/cxl/core/ras.c:cxl_cper_handle_prot_err() {
    ...
	struct device *mem_dev __free(put_device) =3D bus_find_device(
		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
    ...
}

[Severity: High]
This is a pre-existing issue, but will this search always fail?

In cxl_cper_handle_prot_err(), pdev (a struct pci_dev *) is passed as the m=
atch
data (uport). The match_memdev_by_parent() function compares dev->parent (a
struct device *) directly to uport (a struct pci_dev *).

Since struct device is embedded within struct pci_dev at a non-zero offset,
dev->parent will never equal pdev. Could this entirely break CPER log
association for memdevs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D9
