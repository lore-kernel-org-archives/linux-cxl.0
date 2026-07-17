Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CE374758;
	Fri, 17 Jul 2026 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305011; cv=none; b=EjOjr3B/m7aNG/Rpd9/agUkioUj53QclvEPmAeOWVVBavVh/GaPDChtil4iPQnOtJ9Ul+/rh6m7/OjqdCSju2EWqt1V3NsxdBIQ3XMl+OUDGPWS8ZQU44xgk/GgdpGLMNiUTt4mpHoMxUgH6ZVwM4m++PvPhkl7SnZNtONjJLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305011; c=relaxed/simple;
	bh=+b2145aao+km/PoTmb9fEitW/PZselAMhY+GF+doBc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgC6xpx8ojfXth9qOFg+8RXA0yTb5+4wbg0ZBHZRxMq5qfrTbL+Gilcmug6LxBKcwuil9H7OeK9LEyU0/Z6FRqfdtkJuVUrFs2cHCSYS0dDXQQNelNRU310EtT4kNsvnpAbxNjwlLRJ6n4qewjfsvfFLzU56NIgq85W9CsqLka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2341F000E9;
	Fri, 17 Jul 2026 16:16:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v3 00/10] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Fri, 17 Jul 2026 09:16:37 -0700
Message-ID: <20260717161647.1493259-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collection of fixes for pre-existing issues reported by sashiko-bot while
reviewing patches.

The v1 posting fixed a first batch of these issues, and v2 grew the set as
sashiko-bot's review surfaced more problems in the same CPER/extlog paths.
sashiko-bot's review of v2 flagged yet more of the same class of bug in
neighbouring code, so v3 adds those as well: an out-of-range section length
that defeats cper_estatus_check(), the same unvalidated AER buffer handling
in ghes_handle_aer() that was already fixed for extlog, and an unbounded
walk of the extlog record.

1/10:  Bound the CXL event record copy to the firmware section length.
2/10:  Reject CPER records with an out-of-range error_data_length.
3/10:  Validate the CXL protocol error section length before the RAS cap copy.
4/10:  Avoid populating software AER metadata from the raw hardware buffer.
5/10:  Validate the PCIe error section length before payload access.
6/10:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
7/10:  Defer CXL protocol error handling to avoid a lock inversion.
8/10:  Validate the memory error section length before payload access.
9/10:  Bound the AER info copy and sanitize software metadata in ghes.c.
10/10: Validate the extlog record length before walking sections.

Note patch 2 touches drivers/firmware/efi/cper.c; it closes the length
validation hole at the shared choke point that the per-section guards in the
rest of the series rely on.

sashiko-bot's review of v2 also flagged a few related issues that are not
addressed here because they live in other subsystems.

  - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses the
    firmware-controlled dvsec_len without bounding it against the section
    length.
  - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AER
    capability from MMIO into a struct aer_capability_regs without clearing
    the software-only header_len/flit fields, the same class of issue as
    patches 4 and 9.

v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/

Changes since v2
----------------
- Dropped the standalone spin_lock_irqsave() change; it is a separate issue
  being handled by Terry Bowman.
- New patch 2: reject a section whose error_data_length is out of range in
  cper_estatus_check(), closing the signed-int overflow that let a crafted
  section bypass the check and defeat the per-caller size guards (sashiko).
- New patch 9: apply the same AER buffer sanitization to ghes_handle_aer()
  that patch 4 applies to extlog (sashiko).
- New patch 10: bound the extlog record and run cper_estatus_check() before
  walking its sections, which extlog did not do (sashiko).
- Patch 8: move the memory error length check into ghes_do_proc() so the
  report chain and arch reporter are covered too, and bound against the
  older UEFI 2.1/2.2 layout rather than the full struct (sashiko).
- Reordered so the extlog PCIe path is hardened, and the CXL protocol error
  handling is deferred to the workqueue, before the typo fix that activates
  that code.

Changes since v1
----------------
- See the v2 posting for the full v1 -> v2 changelog.


Dave Jiang (10):
  ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
    length
  efi/cper: Reject CPER records with an out-of-range error_data_length
  ACPI: APEI: GHES: Validate CXL protocol error section length before
    RAS cap copy
  ACPI: extlog: Avoid populating software AER metadata from raw hardware
    buffer
  ACPI: extlog: Validate PCIe error section length before payload access
  ACPI: extlog: Defer CXL protocol error handling to avoid lock
    inversion
  ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
  ACPI: APEI: GHES: Validate memory error section length before payload
    access
  ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
  ACPI: extlog: Validate elog record length before walking sections

 drivers/acpi/acpi_extlog.c       | 47 ++++++++++++-------------
 drivers/acpi/apei/ghes.c         | 59 +++++++++++++++++++++++++-------
 drivers/acpi/apei/ghes_helpers.c | 21 +++++++++++-
 drivers/firmware/efi/cper.c      | 10 ++++++
 include/acpi/ghes.h              |  4 +++
 include/cxl/event.h              |  4 +--
 6 files changed, 106 insertions(+), 39 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.55.0

