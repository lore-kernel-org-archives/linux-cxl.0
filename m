Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F937AA78;
	Mon, 24 Aug 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593780; cv=none; b=Bsp7l03zBRS0rYojoN/k82vWCwNzuLbszcvO1KrfhBQj2uVIulo8f0DLHrht21PNoCd40TrITVg0g/BxBjEMfh/JMJRMMlHF28j+JJzOoCujV8rDT3KkwKQZ1Is0kxWv2VtfFgGHaL2c5nyb1I6TwQbYb6WSvUIXBIzaiud8Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593780; c=relaxed/simple;
	bh=CLw/eMF0/YJgPSmPEusffNcYPb5lUMe041XHS9SRf8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxoDu9wAlJBcrvmCuVHIWuoOV/SCpIp20g2zPioLqql3hYifPoAKdYecZ0rgFqn+szGN6BOzAOvrxVJ0Td5cmHRxFr0gD3YaF363LLIFt5eW9oeEaD0CZNchIGzWt9pHWND6Lus6avtD00vvM5H+gwGiWJCAsquSlkHvRiQSa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A411F00A3E;
	Mon, 24 Aug 2026 17:49:38 +0000 (UTC)
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
	benjamin.cheatham@amd.com,
	alison.schofield@intel.com
Subject: [PATCH v4 00/13] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Mon, 24 Aug 2026 10:49:23 -0700
Message-ID: <20260824174936.939059-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for pre-existing issues sashiko-bot found while reviewing patches in the
CPER, extlog and GHES paths. v1 through v3 fixed successive batches as the
review widened; see the links below.

v4 answers Tony Luck's question on v3: is there a common early point where an
oversized gdata->error_data_length gets rejected, rather than each caller
checking only "len < sizeof(*foo)"?

cper_estatus_check() walks every section and runs before any handler
on all three paths - the IRQ path via ghes_read_estatus(), the NMI path via
ghes_in_nmi_queue_one_entry(), and bert_print_all() for BERT. Patch 1 bounds
error_data_length there, so the handlers' own checks are lower bounds only, by
design, and ghes_do_proc() and ghes_handle_aer() need nothing extra.

Patch 1 also stops that bound depending on the signed helpers the question
points at. The wrap goes the wrong way to be caught: against the 72-byte v300
header, an error_data_length of 0xffffffb9 makes acpi_hest_get_record_size()
return 1 rather than something huge, so it passes "record_size > data_len" and
acpi_hest_get_next() advances by that 1. Summing in u64 and rejecting what an
int cannot carry removes the dependency.

A record needs a second, independent bound, since cper_estatus_check() sees
the record alone and never the buffer it was read into. That one belongs to
each caller: bert_print_all() bounds against the remaining BERT region, and
extlog_print() gains an ELOG_ENTRY_LEN bound in patch 3.

GHES is the one caller without it - __ghes_read_estatus() copies buf_len bytes
over the header buf_len came from, and never re-checks. No patch here:
reaching it needs something to rewrite the block while block_status is still
set, which the ACPI read-acknowledge handshake forbids, and I have no instance
of firmware doing that. Better as a separate look than a Fixes: tag and a trip
to stable for a window nobody can show is real.

The series is grouped in three parts, plus a cleanup.

Bound the record before anything walks it:

1/13:  Reject CPER records with an out-of-range error_data_length.
2/13:  Reject an error status block length that wraps a u32.
3/13:  Validate the extlog record length before walking sections.

Fix the extlog error paths, then enable them:

4/13:  Defer CXL protocol error handling to avoid a lock inversion.
5/13:  Avoid populating software AER metadata from the raw hardware buffer.
6/13:  Validate the PCIe error section length before payload access.
7/13:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.

Bound each section payload before its consumers read it:

8/13:  Bound the CXL event record copy to the firmware section length.
9/13:  Validate the CXL protocol error section length before the RAS cap copy.
10/13: Read only validated fields in cper_mem_err_pack().
11/13: Validate the memory error section length before payload access.
12/13: Bound the AER info copy and sanitize software metadata in ghes.c.

Then drop an export patch 4 made redundant:

13/13: Make cxl_cper_handle_prot_err() static.

Patches 1, 2 and 10 touch drivers/firmware/efi/cper.c, closing the holes at
the shared choke point the rest of the series relies on. Patch 2 also fixes an
infinite loop in bert_print_all(), unrelated to this series but the same root
cause.

Known gaps, left for separate patches:

  - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses
    dvsec_len without bounding it against the section length.
  - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AER
    capability from MMIO without clearing header_len/flit, the same class as
    patches 5 and 12.
  - struct pcie_tlp_log grew to 60 bytes for Flit mode, so the 96-byte CPER
    AER info no longer maps 1:1 onto struct aer_capability_regs: Root Error
    Command, Root Error Status and Error Source ID land in
    header_log.prefix[0..2] and print as end-to-end TLP prefixes. Patch 7
    makes this visible in extlog by fixing the guard typo, but the misdecode
    is the same before and after; patches 5 and 12 only stop the
    out-of-bounds reads around it.

v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
v3: https://lore.kernel.org/linux-cxl/20260717161647.1493259-1-dave.jiang@intel.com/

Review tags from the v3 thread are carried over. Patches 2, 10 and 13 are new
in v4 and have none. Patches 1 and 11 were reworked, so their v3 Reviewed-by
tags are dropped. Patches 4, 5, 6, 7 and 9 changed in smaller ways and keep
theirs. Patches 3, 8 and 12 are unchanged.

Changes since v3
----------------
- Regrouped into three parts: bound the record, fix and enable the extlog
  paths, then bound each section payload. v3 interleaved them, so patch 1
  checked a section before the patch establishing that contract. No code
  changed.
- Moved the extlog lock inversion fix (patch 4) ahead of the CXL protocol
  error length validation (patch 9). The former deletes
  extlog_cxl_cper_handle_prot_err(), which the v3 order plumbed a new len
  argument through three patches before removing it. No functional change.
- Patch 1: sum in u64 and reject a size the int helpers cannot carry, so the
  choke point no longer depends on acpi_hest_get_record_size() not wrapping
  (Tony Luck). The v3 "< 0" check was dead code, and bounding the u32 alone
  would have left the sum unchecked. Reviewed-by dropped; not the same check.
- New patch 2: reject an error status block length that wraps the u32 sum in
  cper_estatus_len(). A data_length of 0xffffffec makes it read back as 0,
  slipping past the extlog bound in patch 3 and leaving bert_print_all()
  advancing by zero forever (sashiko). Its commit message no longer claims
  extlog already reached cper_estatus_check_header() (sashiko).
- Patch 4: moved the cxl_cper_post_prot_err() declaration inside the
  CONFIG_ACPI_APEI_GHES block in <acpi/ghes.h> (Shuai Xue). The GHES=n plus
  EXTLOG=m failure that prompted it is unreachable, since ACPI_EXTLOG selects
  ACPI_APEI_GHES, but the declaration belongs there anyway.
- Patch 5: dropped a pointless aer alias; the local aer_regs goes straight to
  pci_print_aer().
- Patch 6: warn instead of returning silently on a short PCIe section (Shuai
  Xue), and added the Closes: link v3 omitted.
- Patch 7: corrected the Fixes tag to e778ffefa34d, the commit that added the
  "#ifdef ACPI_APEI_PCIEAER" guard, and dropped its Reported-by; sashiko-bot
  reviewed that patch rather than reporting the typo.
- Patch 9: made the two prot-err length messages distinguishable; both printed
  the same text. The second now reports dvsec_len (Shuai Xue).
- New patch 10: read only validated fields in cper_mem_err_pack(). It copied
  extended, rank, mem_array_handle and mem_dev_handle unconditionally from
  offsets 73 to 79, past the end of the 73-byte UEFI 2.1/2.2 layout (sashiko).
- Patch 11: derive the required length from the claimed validation bits. A
  single size gets it wrong both ways: 73 bytes let a 74 to 79 byte record
  through, so patch 10 could read mem_dev_handle at offset 78 off the end, and
  80 bytes rejected a 76-byte record legitimately carrying rank, or one
  claiming only bank at offset 38 (sashiko).
- New patch 13: make cxl_cper_handle_prot_err() static. Patch 4 removed its
  last external caller.
- Condensed the commit logs and comments throughout; prose only.

Changes since v2
----------------
- Dropped the standalone spin_lock_irqsave() change; a separate issue being
  handled by Terry Bowman.
- New patch 2: reject a section whose error_data_length is out of range in
  cper_estatus_check(), closing the signed-int overflow that let a crafted
  section defeat the per-caller size guards (sashiko).
- New patch 9: apply the same AER buffer sanitization to ghes_handle_aer()
  that patch 4 applies to extlog (sashiko).
- New patch 10: bound the extlog record and run cper_estatus_check() before
  walking its sections, which extlog did not do (sashiko).
- Patch 8: move the memory error length check into ghes_do_proc() so the
  report chain and arch reporter are covered too, and bound against the older
  UEFI 2.1/2.2 layout rather than the full struct (sashiko).
- Reordered so the extlog PCIe path is hardened, and CXL protocol error
  handling deferred to the workqueue, before the typo fix that activates it.

Changes since v1
----------------
- See the v2 posting for the full v1 -> v2 changelog.

Dave Jiang (13):
  efi/cper: Reject CPER records with an out-of-range error_data_length
  efi/cper: Reject an error status block length that wraps a u32
  ACPI: extlog: Validate elog record length before walking sections
  ACPI: extlog: Defer CXL protocol error handling to avoid lock
    inversion
  ACPI: extlog: Avoid populating software AER metadata from raw hardware
    buffer
  ACPI: extlog: Validate PCIe error section length before payload access
  ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
  ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
    length
  ACPI: APEI: GHES: Validate CXL protocol error section length before
    RAS cap copy
  efi/cper: Read only validated fields in cper_mem_err_pack()
  ACPI: APEI: GHES: Validate memory error section length before payload
    access
  ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
  cxl/ras: Make cxl_cper_handle_prot_err() static

 drivers/acpi/acpi_extlog.c       | 49 +++++++++---------
 drivers/acpi/apei/ghes.c         | 89 +++++++++++++++++++++++++++-----
 drivers/acpi/apei/ghes_helpers.c | 18 ++++++-
 drivers/cxl/core/ras.c           |  3 +-
 drivers/firmware/efi/cper.c      | 53 ++++++++++++++++---
 include/acpi/ghes.h              |  4 ++
 include/cxl/event.h              |  6 +--
 7 files changed, 170 insertions(+), 52 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.54.0

