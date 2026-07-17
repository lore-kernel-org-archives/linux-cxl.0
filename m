Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0137E5FD
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312974; cv=none; b=BdeFfv0yXlO38zx0sNry3j9elCGECLVEqT8eY5ZZca6YYZuN5MWyu2I5vvXK9vBec2RlWjAfODv4OMUo/dpD1A5dER2U3xxzC6E0KUw3vamlRRBrZdM+Niif0Kh6NHdHi8yU8+9WeK5cr7+nl2MA6ymxwjnewIlJ8EBoG1P5j7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312974; c=relaxed/simple;
	bh=g58WQWcqxi5ORBu40ZuyB7hdrWlncVSQojD+P0TN95Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fPxXabnWns8doOC+lsB4q/6x8onvTdDzwKkaVXPfTnoUC0ke9dJy5PCSOjLSuoxYhR38MJAQmiWq6RxXWi5N0eWIvtyGCPJKwbGaJEq5HXUe3vic326Jj8Tba9/D0QCEgg3PuMAVRSqXPgHDiK6QQ9WYiXe4NRi0LbK6Nx/5y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT/FO/eL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT/FO/eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5A01F000E9;
	Fri, 17 Jul 2026 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312973;
	bh=nAO/MOlKopzrq7jlmmpW++O/SDR1KE3IHE1HtcXGcsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PT/FO/eLYmhdedgW/7uHByXjGpu3lVOmhRt0eMct3+oLno+S/DU32Tmz6Whu2FmQN
	 rXjPTckB9KIA7dW72t5xKM3qhJXlhw7vHkA4YPm+VWV+iD+1lS8n3NPIQlzfic93Sz
	 HzRkPCPkdYnpj1z0krSVq/S30cc8mekSb4PMPXilNG7lpyptBE4j6n6XbxLDPl0Vl/
	 FyrKBLLFMoeZ+S9ipfrUx7nzzUE0eYr//TicsqqAhcU8NVzp5Fv1coM8jdwCly9ubl
	 5GG9/s9L7pVYs29dDNRCJVW42ik1qKN/obSCG2XEOQuoepMBy2GowUWsbNkbchana6
	 mh9pl809krYUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] ACPI: extlog: Validate PCIe error section
 length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-6-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 18:29:32 +0000
Message-Id: <20260717182932.BF5A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `extlog_print()` function fails to validate the firmware-provi=
ded `estatus->data_length` before iterating over its sections, leading to a=
 heap out-of-bounds read.
- [High] Missing `CONFIG_` prefix in the preprocessor guard `#ifdef ACPI_AP=
EI_PCIEAER` renders the error parsing functions and the newly added bounds =
check dead code.
- [High] The patch fixes an out-of-bounds read vulnerability for PCIe CPER =
sections in acpi_extlog.c, but leaves identical out-of-bounds reads unpatch=
ed in ghes.c.
--

--- Patch [5]: [PATCH v3 05/10] ACPI: extlog: Validate PCIe error section l=
ength before payload access ---
commit aa3cbf45758b1ffcfa8d2f4818d6c1ce97837a2a
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Validate PCIe error section length before payload access

This commit adds a missing section-length check before extlog_print_pcie()
touches the PCIe payload to prevent accessing stale adjacent bytes if the
section is too small.

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index fbc88c584c067..0c440d75d9a78 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,
>  }
> =20
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> -			      int severity)
> +			      int severity, u32 len)
>  {
>  #ifdef ACPI_APEI_PCIEAER

[Severity: High]
This is a pre-existing issue, but does this preprocessor guard lack the
CONFIG_ prefix?

If this should be CONFIG_ACPI_APEI_PCIEAER, this guard evaluates to false,
and both the newly added bounds check and the existing PCIe error parsing
logic will be stripped out as dead code. The CXL protocol error handler
in this file might also have a similar misspelled guard.

>  	struct aer_capability_regs aer_regs =3D {};
>  	struct aer_capability_regs *aer;
[ ... ]
>  	int aer_severity;
>  	int domain;
> =20
> +	if (len < sizeof(*pcie_err))
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but while this patch adds bounds checking
for PCIe CPER sections in acpi_extlog.c, do identical unpatched
out-of-bounds reads exist in drivers/acpi/apei/ghes.c?

Looking at ghes_handle_aer() and ghes_handle_memory_failure() in ghes.c,
they appear to unconditionally access validation_bits without verifying
if gdata->error_data_length is large enough for the struct:

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
    if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID && ...
    ...
}

Could a short section payload from malicious or corrupted firmware cause
an out-of-bounds read when these GHES handlers are dispatched?

>  	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>  	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D5
