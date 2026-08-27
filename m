Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B134F49F;
	Thu, 27 Aug 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863056; cv=none; b=YoqVQoaJ2AHescY/OzBPfS1m8+BQ0QmTe07mhHdxoH+3YiHJOnJ6c8ICqM3l56svJG7tTo8Gdbc/rapu3jbYyL38dncZ25+gFFr5wE4fNEHQVyxROPcCjO86IHG03A2g7RTta5c72H123oS6ck5fN7YWRf+midxzlS6YF7qhdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863056; c=relaxed/simple;
	bh=0rCmtkVUCQi6ZEU6kUtdvkSEPA0GT8PTBtZWOf2v9uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1uLniXwBjNfhhQvObbEyrEKZdfTZeNHsBtTWsj7ap8m/BPYUfFHHUNcaO64UIOivQDJ2ha/lBSoZpnJLFjLqnfX7mT0SnGhysD117Y0rq+OfMngNYgJmWTvGsqXujdrlT/mRDeNbrDumoffAbCimIJ/QlAL/MLt1/+qajUm/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D514E1F000E9;
	Thu, 27 Aug 2026 20:37:28 +0000 (UTC)
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
Subject: [PATCH v5 00/13] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Thu, 27 Aug 2026 13:37:13 -0700
Message-ID: <20260827203726.3027541-1-dave.jiang@intel.com>
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
    patches 5 and 12.
  - struct pcie_tlp_log grew to 60 bytes for Flit mode, so the 96-byte CPER
    AER info no longer maps 1:1 onto struct aer_capability_regs past the
    Header Log. Patches 5 and 12 now copy only the 44 bytes that do map and
    leave the rest zero, which keeps the Root Error registers out of
    header_log.prefix[] - but nothing here decodes the Flit-mode header
    DWORDs, which live at payload offset 56 while the struct expects them at
    44. Doing that properly wants a field-by-field mapping shared with
    cxl_rch_get_aer_info(), plus a clamp: pcie_print_tlp_log() trusts
    header_len against a 14-entry dw[], and PCI_ERR_CAP_TLP_LOG_SIZE is five
    bits wide.

v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
v3: https://lore.kernel.org/linux-cxl/20260717161647.1493259-1-dave.jiang@intel.com/
v4: https://lore.kernel.org/linux-cxl/20260824174936.939059-1-dave.jiang@intel.com/

Review tags from the v3 and v4 threads are carried over, and Jonathan reviewed
patches 2, 4, 6, 7, 8 and 9 on v4. Patches 1, 10, 11 and 13 carry none: 10 and
13 are new since v3, and 1 and 11 were reworked far enough that Alison's and
Shuai's v3 tags no longer applied. Patches 5 and 12 keep theirs, but the copy
length changed in v5 - same intent, different bound - so please re-check if you
disagree.

Changes since v4
----------------
- Patch 1: use check_add_overflow() instead of a u64 sum plus an INT_MAX
  test, and drop the now-redundant acpi_hest_get_size() bound, since
  record_size is never smaller than the header (Jonathan Cameron).
- Patches 5 and 12: copy only the 44 bytes of aer_info that map onto struct
  aer_capability_regs - the leading registers and the four Header Log DWORDs
  - and leave the rest zero, instead of copying all 96 bytes and then
  clearing header_len and flit (Jonathan Cameron). This also keeps the Root
  Error Command, Root Error Status and Error Source ID out of
  header_log.prefix[], where pcie_print_tlp_log() was printing them as
  end-to-end prefixes.
- Patch 3: kept the length bound ahead of cper_estatus_check() and expanded
  the comment to say why. Swapping them would let cper_estatus_check() walk
  sections over an unbounded data_length, past the end of elog_buf
  (Jonathan Cameron).

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

 drivers/acpi/acpi_extlog.c       | 60 +++++++++++++---------
 drivers/acpi/apei/ghes.c         | 88 +++++++++++++++++++++++++++-----
 drivers/acpi/apei/ghes_helpers.c | 18 ++++++-
 drivers/cxl/core/ras.c           |  3 +-
 drivers/firmware/efi/cper.c      | 51 +++++++++++++++---
 include/acpi/ghes.h              |  4 ++
 include/cxl/event.h              |  6 +--
 7 files changed, 178 insertions(+), 52 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.54.0

