Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DB3E51F4
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633612; cv=none; b=Ow9316uWvorDX6WpRBiYRwdXS4aDFrAvqlhA5kqWqwP+kUuXgIHbF6ZLJ4uDmlIO2OGnnjqCPcdBB4v2A9RQ8LMSjMiOIe09TxhPLdx7VCrNW496ObqEhVkoVbAQfsolwPCqFy1icEdSsWiot97mae1iZFRlLKvEtQIiwpnlP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633612; c=relaxed/simple;
	bh=VM7uZt4h+ob0QAAXaxc53STfVYYtKFcP12rAjdHK7yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e10kxOUA5fmjebHlqNdv1JQ7JWu2hpWPl1XavXfjSht4OI7JdJPHukwN0r/B88PNjiNOeHJhJ1UhQAd8rGr4lfxccxiHqckjBuKBBUV7OmHu4u0rqjnjCmChpjYIB51+ujedi3gB2d+sTUdp4RLS/eN2cvhtQMpvqfhhsKxnZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuchITk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuchITk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B371F00A3F
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784633602;
	bh=a0wHmtmfVITct5QNAFts0xKDGDbiQtAyxU0Sg3FoZhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oOuchITkqQPF/cbgZd30FfvBACgh8FBDR6XSZlFLKc6Z/bQFeeiH7HinfmleyRKAG
	 SND0Ccbn7W9KoGtohk1a03M+EO93p4Pz4IWY2hOwnC5PbD5Pb3/QFSNJ8pqrwA10Lt
	 rE7RaSCtj2O+WUxfb9BIj8VuqGGVtk6jJI+GY0uBnqliyc5LzQSKd7LEM1PWtcn0Ru
	 2hLIAp9tJDoFyG3N+MaW13/8b611wVcPpqBV16OlK+n6XiU4g68yW538139Vgahk5/
	 xr38rEPEHj+B/p5yBxNcSkORRkuibdG1+VO3UBQjD7GnHojBf2uMOOt9elYQTpMB8Q
	 EDDsy83VHxMnA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39eb257e9fbso28969311fa.0
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 04:33:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpFcYOunaxCLDjAo+gAobjCt5MP21RVRLs0k4bbBlBjp1JH/Oy9ok8C2Epw/mKPMkA7uTquEEuK/2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblWfnnO8jn0RFiCRnNTCZp8hCjKYV51u+xn3I6lcVq/5aOaf1
	/zO9X3HLi+2xVEfN2xAOS2gikAexkhKVdx4KeD79SGhTkwrrVI9A8yE/LcMa/Utdvt8XKU/enMz
	OD7r/Q1pFEhPUdmdX75VTcAsH10qIrPw=
X-Received: by 2002:a05:651c:543:b0:39e:ed52:cfdf with SMTP id
 38308e7fff4ca-39eed52d138mr4118691fa.20.1784633601333; Tue, 21 Jul 2026
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717161647.1493259-1-dave.jiang@intel.com>
In-Reply-To: <20260717161647.1493259-1-dave.jiang@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 13:33:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gLTkGLX_3PLBJYCfFS0_qFjHR+P4agvQQ-Usg4p5nUcA@mail.gmail.com>
X-Gm-Features: AUfX_mxXX0k43KyjGbx2pRTLQhQ1ihnfZOjDDbcRsPM4PjZKQFrZ1rNYTgtxwpA
Message-ID: <CAJZ5v0gLTkGLX_3PLBJYCfFS0_qFjHR+P4agvQQ-Usg4p5nUcA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, rafael@kernel.org, 
	tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, terry.bowman@amd.com, 
	Ben Cheatham <benjamin.cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 6:16=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
> A collection of fixes for pre-existing issues reported by sashiko-bot whi=
le
> reviewing patches.
>
> The v1 posting fixed a first batch of these issues, and v2 grew the set a=
s
> sashiko-bot's review surfaced more problems in the same CPER/extlog paths=
.
> sashiko-bot's review of v2 flagged yet more of the same class of bug in
> neighbouring code, so v3 adds those as well: an out-of-range section leng=
th
> that defeats cper_estatus_check(), the same unvalidated AER buffer handli=
ng
> in ghes_handle_aer() that was already fixed for extlog, and an unbounded
> walk of the extlog record.
>
> 1/10:  Bound the CXL event record copy to the firmware section length.
> 2/10:  Reject CPER records with an out-of-range error_data_length.
> 3/10:  Validate the CXL protocol error section length before the RAS cap =
copy.
> 4/10:  Avoid populating software AER metadata from the raw hardware buffe=
r.
> 5/10:  Validate the PCIe error section length before payload access.
> 6/10:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
> 7/10:  Defer CXL protocol error handling to avoid a lock inversion.
> 8/10:  Validate the memory error section length before payload access.
> 9/10:  Bound the AER info copy and sanitize software metadata in ghes.c.
> 10/10: Validate the extlog record length before walking sections.
>
> Note patch 2 touches drivers/firmware/efi/cper.c; it closes the length
> validation hole at the shared choke point that the per-section guards in =
the
> rest of the series rely on.
>
> sashiko-bot's review of v2 also flagged a few related issues that are not
> addressed here because they live in other subsystems.
>
>   - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses the
>     firmware-controlled dvsec_len without bounding it against the section
>     length.
>   - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AE=
R
>     capability from MMIO into a struct aer_capability_regs without cleari=
ng
>     the software-only header_len/flit fields, the same class of issue as
>     patches 4 and 9.
>
> v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang=
@intel.com/
> v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@=
intel.com/
>
> Changes since v2
> ----------------
> - Dropped the standalone spin_lock_irqsave() change; it is a separate iss=
ue
>   being handled by Terry Bowman.
> - New patch 2: reject a section whose error_data_length is out of range i=
n
>   cper_estatus_check(), closing the signed-int overflow that let a crafte=
d
>   section bypass the check and defeat the per-caller size guards (sashiko=
).
> - New patch 9: apply the same AER buffer sanitization to ghes_handle_aer(=
)
>   that patch 4 applies to extlog (sashiko).
> - New patch 10: bound the extlog record and run cper_estatus_check() befo=
re
>   walking its sections, which extlog did not do (sashiko).
> - Patch 8: move the memory error length check into ghes_do_proc() so the
>   report chain and arch reporter are covered too, and bound against the
>   older UEFI 2.1/2.2 layout rather than the full struct (sashiko).
> - Reordered so the extlog PCIe path is hardened, and the CXL protocol err=
or
>   handling is deferred to the workqueue, before the typo fix that activat=
es
>   that code.
>
> Changes since v1
> ----------------
> - See the v2 posting for the full v1 -> v2 changelog.
>
>
> Dave Jiang (10):
>   ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
>     length
>   efi/cper: Reject CPER records with an out-of-range error_data_length
>   ACPI: APEI: GHES: Validate CXL protocol error section length before
>     RAS cap copy
>   ACPI: extlog: Avoid populating software AER metadata from raw hardware
>     buffer
>   ACPI: extlog: Validate PCIe error section length before payload access
>   ACPI: extlog: Defer CXL protocol error handling to avoid lock
>     inversion
>   ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
>   ACPI: APEI: GHES: Validate memory error section length before payload
>     access
>   ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
>   ACPI: extlog: Validate elog record length before walking sections
>
>  drivers/acpi/acpi_extlog.c       | 47 ++++++++++++-------------
>  drivers/acpi/apei/ghes.c         | 59 +++++++++++++++++++++++++-------
>  drivers/acpi/apei/ghes_helpers.c | 21 +++++++++++-
>  drivers/firmware/efi/cper.c      | 10 ++++++
>  include/acpi/ghes.h              |  4 +++
>  include/cxl/event.h              |  4 +--
>  6 files changed, 106 insertions(+), 39 deletions(-)

All of this looks reasonable to me, but it really is material for Tony
to look at.
