Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD0395ADC
	for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738601; cv=none; b=ZPvB1t+TgUJmeJLKIc5XF/kb+AJpCszSvbmUJa4glhvAljSP7aNgq0H+JugubAOC7P0W5vJXhtkHpLUjswKLdqfr7VAwPSSfL1eEeFCokaO31dMnglTu3dvm+Z3t/zd4yJ/QN/kAUvoYs2IXlkM9ktYjdz1GtcpJMHLXSUYt4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738601; c=relaxed/simple;
	bh=hrNEUujtlwgp55tgVOQ65TaiYBA5wkhkwQF0qukjUv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzCbSl6iZB3EU2FrwjHQubKExCH/pFFsFHeoOFR0t1dbpkH+MRWd2z7IN2G6JM0wtQjIrQtCbVJZ1NdspGsShzzvd8Iy91++IXtynZavbm+Nj05tNhi7sOSRuXatXz5FjiA56q8bwaQXWx97wICDq+A5kcZxAZBFGKla4fYsAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inelM0p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inelM0p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25021F00A3A
	for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738599;
	bh=CFpoGw8i1dQwGv9id0aSNKTDEhoVoO76p9O5fgfRVms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=inelM0p8cGFcxWQeqGhKcx8ukD87N/rxOvFgmSq73aP8uUL9Mn3gzupQ1DnjerMrQ
	 AGxNOOpfmem8kjiVmsJ/sSl8NJM4RNj40EqvDJyMdsZqJapM8vTE7CVOia3Ou5ns24
	 KOjtWuUIvqZwv1dMoSQCIstwVql7meNUziwdVYJIS9QQHWjYAnm+xZ+GQm4NKeLLKQ
	 /eoEwpklfDwaHhf8eM0tOXlCm6gNVcW+ABbAyFhnFJLVG2cX5VNzFjYzho0SewIrL5
	 8otbpExhE8213rYGuNJPhkF1JRiIqa/OyCPG6emqlfeVdvWSo+9TBUfGx+jFvl8XYd
	 ptqcJ754bDTcA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so1082238e87.0
        for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 13:16:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoU6v3vGWXq8Mhv8fxfuvcnTFTezfBSFNUFeA5L9K4UyfRtS1tiIN6PEWH1DPrql1vxKl5V3gTdJsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1i16a0xmG5C5YPj5lTISiHKB26cFILBfvnxkcG8/kep19L6l1
	yEHachZJVw8W6LgN9mk4dvCdqjHug9ZzDFc82Nf30GO2G3gWCh1g3Ck6OtbSw01PH/5O8nLhrTH
	OYXUwec7S5fob0ZpWynTcmE2Gp0+Z8wc=
X-Received: by 2002:a05:6512:6681:20b0:5b2:158e:9918 with SMTP id
 2adb3069b0e04-5b45916e5f6mr843457e87.19.1786738598358; Fri, 14 Aug 2026
 13:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <CAJZ5v0gLTkGLX_3PLBJYCfFS0_qFjHR+P4agvQQ-Usg4p5nUcA@mail.gmail.com> <983e48d0-b281-44dc-9ca6-4e1612319ce3@intel.com>
In-Reply-To: <983e48d0-b281-44dc-9ca6-4e1612319ce3@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 14 Aug 2026 22:16:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSMLe-erYp7v+WiJi4_jgEwoNWowYKZ+i84P-KXvYNyQ@mail.gmail.com>
X-Gm-Features: AUfX_mzN4EZG6yjV0P2n2KXtC_9eXXLZqCYHGC7LJFdeFbF0GreR0H3_0r66KAw
Message-ID: <CAJZ5v0hSMLe-erYp7v+WiJi4_jgEwoNWowYKZ+i84P-KXvYNyQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	terry.bowman@amd.com, Ben Cheatham <benjamin.cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:06=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 7/21/26 4:33 AM, Rafael J. Wysocki (Intel) wrote:
> > On Fri, Jul 17, 2026 at 6:16=E2=80=AFPM Dave Jiang <dave.jiang@intel.co=
m> wrote:
> >>
> >> A collection of fixes for pre-existing issues reported by sashiko-bot =
while
> >> reviewing patches.
> >>
> >> The v1 posting fixed a first batch of these issues, and v2 grew the se=
t as
> >> sashiko-bot's review surfaced more problems in the same CPER/extlog pa=
ths.
> >> sashiko-bot's review of v2 flagged yet more of the same class of bug i=
n
> >> neighbouring code, so v3 adds those as well: an out-of-range section l=
ength
> >> that defeats cper_estatus_check(), the same unvalidated AER buffer han=
dling
> >> in ghes_handle_aer() that was already fixed for extlog, and an unbound=
ed
> >> walk of the extlog record.
> >>
> >> 1/10:  Bound the CXL event record copy to the firmware section length.
> >> 2/10:  Reject CPER records with an out-of-range error_data_length.
> >> 3/10:  Validate the CXL protocol error section length before the RAS c=
ap copy.
> >> 4/10:  Avoid populating software AER metadata from the raw hardware bu=
ffer.
> >> 5/10:  Validate the PCIe error section length before payload access.
> >> 6/10:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
> >> 7/10:  Defer CXL protocol error handling to avoid a lock inversion.
> >> 8/10:  Validate the memory error section length before payload access.
> >> 9/10:  Bound the AER info copy and sanitize software metadata in ghes.=
c.
> >> 10/10: Validate the extlog record length before walking sections.
> >>
> >> Note patch 2 touches drivers/firmware/efi/cper.c; it closes the length
> >> validation hole at the shared choke point that the per-section guards =
in the
> >> rest of the series rely on.
> >>
> >> sashiko-bot's review of v2 also flagged a few related issues that are =
not
> >> addressed here because they live in other subsystems.
> >>
> >>   - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses =
the
> >>     firmware-controlled dvsec_len without bounding it against the sect=
ion
> >>     length.
> >>   - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH=
 AER
> >>     capability from MMIO into a struct aer_capability_regs without cle=
aring
> >>     the software-only header_len/flit fields, the same class of issue =
as
> >>     patches 4 and 9.
> >>
> >> v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.ji=
ang@intel.com/
> >> v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jia=
ng@intel.com/
> >>
> >> Changes since v2
> >> ----------------
> >> - Dropped the standalone spin_lock_irqsave() change; it is a separate =
issue
> >>   being handled by Terry Bowman.
> >> - New patch 2: reject a section whose error_data_length is out of rang=
e in
> >>   cper_estatus_check(), closing the signed-int overflow that let a cra=
fted
> >>   section bypass the check and defeat the per-caller size guards (sash=
iko).
> >> - New patch 9: apply the same AER buffer sanitization to ghes_handle_a=
er()
> >>   that patch 4 applies to extlog (sashiko).
> >> - New patch 10: bound the extlog record and run cper_estatus_check() b=
efore
> >>   walking its sections, which extlog did not do (sashiko).
> >> - Patch 8: move the memory error length check into ghes_do_proc() so t=
he
> >>   report chain and arch reporter are covered too, and bound against th=
e
> >>   older UEFI 2.1/2.2 layout rather than the full struct (sashiko).
> >> - Reordered so the extlog PCIe path is hardened, and the CXL protocol =
error
> >>   handling is deferred to the workqueue, before the typo fix that acti=
vates
> >>   that code.
> >>
> >> Changes since v1
> >> ----------------
> >> - See the v2 posting for the full v1 -> v2 changelog.
> >>
> >>
> >> Dave Jiang (10):
> >>   ACPI: APEI: GHES: Bound CXL event record copy to the firmware sectio=
n
> >>     length
> >>   efi/cper: Reject CPER records with an out-of-range error_data_length
> >>   ACPI: APEI: GHES: Validate CXL protocol error section length before
> >>     RAS cap copy
> >>   ACPI: extlog: Avoid populating software AER metadata from raw hardwa=
re
> >>     buffer
> >>   ACPI: extlog: Validate PCIe error section length before payload acce=
ss
> >>   ACPI: extlog: Defer CXL protocol error handling to avoid lock
> >>     inversion
> >>   ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
> >>   ACPI: APEI: GHES: Validate memory error section length before payloa=
d
> >>     access
> >>   ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
> >>   ACPI: extlog: Validate elog record length before walking sections
> >>
> >>  drivers/acpi/acpi_extlog.c       | 47 ++++++++++++-------------
> >>  drivers/acpi/apei/ghes.c         | 59 +++++++++++++++++++++++++------=
-
> >>  drivers/acpi/apei/ghes_helpers.c | 21 +++++++++++-
> >>  drivers/firmware/efi/cper.c      | 10 ++++++
> >>  include/acpi/ghes.h              |  4 +++
> >>  include/cxl/event.h              |  4 +--
> >>  6 files changed, 106 insertions(+), 39 deletions(-)
> >
> > All of this looks reasonable to me, but it really is material for Tony
> > to look at.
>
> Thanks Rafael. I've asked Tony to take a look. Looks like he's on vacatio=
n so hopefully soon.

After Shuai Xue's review this is good to go from my perspective, but
please address the review feedback.
