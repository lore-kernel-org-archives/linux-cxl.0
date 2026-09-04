Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59839DBD4;
	Fri,  4 Sep 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542627; cv=none; b=JNnhKeRZMCQlBU+Adw6laR3zGJpJ/5Vq5S3WqzBX9/hMYMPDVGMr5U852WpjToGuK4gwYMZEvFf8doio5hH4PtFXDGTzTe03neNwe8gk1PTbDDnXCwbxzAk84B5MDBg//sADaxjsCP/30lW4WHKvbXySLb4SGKecq2ylmhE7TfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542627; c=relaxed/simple;
	bh=qTpKXRXQNdHsgLt3hgTP1P7G/4fNJZaHzt5Pbemstqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0TLhtEobyBz6aZHfgUH50NWMKwbBgD8wk5d6Au0iU0ru4+CShu/br0YFJHDNHRU1gnsYPAn+nwolRbSo4TTJIxKSy3OVtbJsLQ5vWOoBKRblaKy0eCnGRzR779XpHIHwbf0PfNgG3sDZwpVHGJFN253RiBcLeAYth3z2qfPkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4141F00AC4;
	Fri,  4 Sep 2026 17:23:39 +0000 (UTC)
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
	alison.schofield@intel.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 00/13] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Fri,  4 Sep 2026 10:23:24 -0700
Message-ID: <20260904172337.1409775-1-dave.jiang@intel.com>
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
    patches 5 and 12. In the same file, cxl_rch_get_aer_severity() tests
    PCI_ERR_ROOT_FATAL_RCV against uncor_status, where that bit is
    PCI_ERR_UNC_FCP.
  - struct pcie_tlp_log grew to 60 bytes for Flit mode, so the 96-byte CPER
    AER info no longer maps 1:1 onto struct aer_capability_regs past the
    Header Log. Patches 5 and 12 now copy the part that maps and place the TLP
    Prefix Log from its own offset, which covers every field the print path
    reads - but nothing here decodes the Flit-mode header DWORDs, which reuse
    those same prefix registers at payload offset 56 while the struct expects
    dw[4..13] at 44. Doing that properly wants a field-by-field mapping
    shared with cxl_rch_get_aer_info(), plus a clamp: pcie_print_tlp_log()
    trusts header_len against a 14-entry dw[], and PCI_ERR_CAP_TLP_LOG_SIZE
    is five bits wide.

v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
v3: https://lore.kernel.org/linux-cxl/20260717161647.1493259-1-dave.jiang@intel.com/
v4: https://lore.kernel.org/linux-cxl/20260824174936.939059-1-dave.jiang@intel.com/
v5: https://lore.kernel.org/linux-cxl/20260827203726.3027541-1-dave.jiang@intel.com/

Changes since v5
----------------
- Patches 5 and 12: also place the TLP Prefix Log from its own hardware
  offset rather than leaving it zero. Shortening the copy in v5 dropped it,
  and it is the one field the print path still reads (sashiko). Alison's and
  Shuai's Reviewed-by are kept on both, since the intent and location have
  not changed.

Changes since v4
----------------
- Patch 1: use check_add_overflow() instead of a u64 sum plus an INT_MAX
  test, and drop the now-redundant acpi_hest_get_size() bound, since
  record_size is never smaller than the header (Jonathan Cameron).
- Patches 5 and 12: copy only the 44 bytes of aer_info that map onto struct
  aer_capability_regs - the leading registers and the four Header Log DWORDs
  - and leave the rest zero, instead of copying all 96 bytes and then
  clearing header_len and flit (Jonathan Cameron). That also keeps the Root
  Error Command, Root Error Status and Error Source ID out of
  header_log.prefix[], where pcie_print_tlp_log() was printing them as
  end-to-end prefixes.
- Patch 3: kept the length bound ahead of cper_estatus_check() and expanded
  the comment to say why. Swapping them would let cper_estatus_check() walk
  sections over an unbounded data_length, past the end of elog_buf
  (Jonathan Cameron).
- Condensed the commit logs and comments again; prose only.

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
- Patch 1: bound the sum rather than the u32 error_data_length, so the check
  does not depend on the <acpi/ghes.h> helpers behaving. The v3 "< 0" check
  was dead code (Tony Luck, Shuai Xue). Reviewed-by dropped; not the same
  check.
- New patch 2: reject an error status block length that wraps the u32 sum in
  cper_estatus_len(). A data_length of 0xffffffec makes it read back as 0,
  slipping past the extlog bound in patch 3 and leaving bert_print_all()
  advancing by zero forever (sashiko).
- Patch 4: moved the cxl_cper_post_prot_err() declaration inside the
  CONFIG_ACPI_APEI_GHES block in <acpi/ghes.h> (Shuai Xue).
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
  single size gets it wrong both ways (sashiko). Reviewed-by dropped; the
  check gained a helper and is no longer the one Alison and Shuai reviewed.
- New patch 13: make cxl_cper_handle_prot_err() static. Patch 4 removed its
  last external caller.

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

 drivers/acpi/acpi_extlog.c       | 64 +++++++++++++---------
 drivers/acpi/apei/ghes.c         | 92 +++++++++++++++++++++++++++-----
 drivers/acpi/apei/ghes_helpers.c | 18 ++++++-
 drivers/cxl/core/ras.c           |  3 +-
 drivers/firmware/efi/cper.c      | 51 +++++++++++++++---
 include/acpi/ghes.h              |  4 ++
 include/cxl/event.h              |  6 +--
 7 files changed, 186 insertions(+), 52 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.54.0

