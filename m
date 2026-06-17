Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CE3D1AB5;
	Wed, 17 Jun 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704530; cv=none; b=Zr0eMvYulwshqfcY2CpgDhwQ/jC9AdrxqSgMS2dXldLG5r7FkSufs0olYC/V4V5kQhRaLHhiOOPLLCm8DRISaTJNAxKJz64ktE+p6Ua1kiGrWUOffHE3nBwX/AXtG1XduaFJ8KawBAZl4pGK9G5Lu8npFzOY2cmS7WxxoHnOY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704530; c=relaxed/simple;
	bh=eyJNxrhJvTkcsEFUdrox4IxWWcdACh9nTiVA9Mt5Avw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvp/jFQd0mZv67Z6toGydWJ4y3ohN0Y9Loshn2qh0b+B8DL8P5+zpdWatLjjEbFnJYH8M8hK4d88VGyXyHCKPChYjfFstERqmMAr6D6yp3mCsgNiWAfX19lLPRbEiJ5JsWDambtaXOHONCRcAAK20w8NfYk5OCxzt+mklbURKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G+P1I/G6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G+P1I/G6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82BF532AB;
	Wed, 17 Jun 2026 06:55:22 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9B6E3F915;
	Wed, 17 Jun 2026 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781704527; bh=eyJNxrhJvTkcsEFUdrox4IxWWcdACh9nTiVA9Mt5Avw=;
	h=From:Subject:Date:To:Cc:From;
	b=G+P1I/G6EEPi3PmWn/6EdpBfyYcvI+GgvHHu4JlS/ryz3f0vw/nhnrwb88jNvL03x
	 RRKVbJeZYa/hUd9Ov4LMre+0lFRJTkk/4efbgyjBbt0Mv80mZ6qHy4bOTV0s16Ip8Q
	 JFkxl0YW78P6zeR5K/kVYWS9FZW+8wwX3RfbUFaQ=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Subject: [PATCH v6 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Date: Wed, 17 Jun 2026 14:54:38 +0100
Message-Id: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+nMmoC/5XOy2rDMBCF4VcJWldGM9HFzirvEYrRtRbUdpCM2
 xL87pECIc3SyzOg79eNZJ+iz+R0uJHk15jjPJUhPw7EDnr68jS6sgkylAyR0WW+RpupHsYlGgY
 06dyHMPQ6jX2cFp8m/d1Xyf9QE5yzKlhltSFFvCYf4u+jdvkse4h5mdPfI75CvdaOAAQFgC0XD
 bTAAToKNehdU5r6XFKNnUdSiRWfz/Z/b0XK6JGroNGpowDzLvOXLKDdJ/Mic5RdK5UwWsK7LP7
 J2O2TRZHRM8GYKwGOL3nbtjv6B0ngzwEAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>, Ahmed Tiba <ahmed.tiba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781704522; l=5997;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=eyJNxrhJvTkcsEFUdrox4IxWWcdACh9nTiVA9Mt5Avw=;
 b=Olh+RDPnhHXnCJM03vX+gbePQsG7mjJkxvowMYdHQYypgyyx7JeR/FOtsDBzUCcsp/KUVJfV+
 jG8raNnP2e4CxreoghTeLYXwTz/fiezjKqrEejIg3BhZx6dG0luA69i
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

This is v6 of the GHES refactor series. Compared to v5, it addresses
the latest review comments and tightens the DT CPER provider and
related helper wiring.

The DT firmware-first CPER provider is intended for the upstream
zena-css platform. Validation so far has been on FVP.

Changes in v6:
- Keep cper_estatus_len() out of the final DT provider patch by restoring it
  to the APEI internal header and keeping the DT-side length helper local.
- Remove the include guard dance around apei-internal.h in ghes_cper.c.
- Drop stray vendor notifier declarations from ghes_cper.h.
- Rework the DT CPER provider to:
  - validate block_status and CPER lengths before parsing
  - remove the unsupported synchronous/SEA path
  - embed struct acpi_hest_generic in the driver state
  - remove the unnecessary copy helper
  - avoid caching DT-provider estatus records
  - reject undersized status buffers
  - bound source_id to u16 and document why 0 is left unused
  - consume the status and ack buffers from the binding-defined
    memory-region entries
  - treat those regions as shared memory rather than MMIO
  - clear block_status after consuming a record before raising the ack bit
- Rewrite and rewrap the admin-guide text to describe the DT firmware-first
  CPER model directly.

Link to v5: https://lore.kernel.org/r/20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com

ACPI: APEI: share GHES CPER helpers and add DT FFH provider

This is v5 of the GHES refactor series. Compared to v4, it only updates
the DT binding to address the latest review comments.

Changes in v5:
- Dropped the `oneOf` from `memory-region` and described it as a plain
  list with `minItems: 1`.
- Simplified the DT example to keep only the `arm,ras-cper` device node.
- Link to v4: https://lore.kernel.org/r/20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com

ACPI: APEI: share GHES CPER helpers and add DT FFH provider

This is v4 of the GHES refactor series. Compared to v3, it mainly
updates the shared header comment and the DT binding/description
for the firmware-owned CPER buffer.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

Changes in v4:
- Reworded the ghes_cper.h header comment and kept the original copyrights.
- Fixed the ghes_cper.h W=1 warnings by limiting the ACPI
  fixmap-based declarations to the ACPI build path.
- Updated the DT binding to describe the CPER buffer
  as firmware-owned shared memory.
- Described the optional ack area as a second memory-region entry.
- Updated the DT example accordingly.
- Link to v3: https://lore.kernel.org/r/20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com

Changes in v3:
- Fixed the new ghes_cper.h header comment and kept the original
  copyrights.
- Added <linux/bitfield.h> to fix the kernel test robot build failure.
- Renamed the binding/compatible and DT-side naming to ras-cper.
- Switched the DT provider to generic firmware property accessors.
- Replaced atomic source IDs with IDA.
- Updated IRQ/error/resource handling as suggested in review
  (platform_get_irq(), dev_err_probe(), devm platform ioremap
  helpers).
- Removed the ARM64 dependency and fixed Kconfig/build coverage.
- Clarified comments and kept the early move patches mechanical.
- Link to v2: https://lore.kernel.org/r/20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com

Changes in v2:
- Dropped the proposed "estatus core" and kept GHES naming/flow intact
  (per Borislav Petkov).
- Re-sliced the series into smaller mechanical steps (per Mauro Carvalho Chehab).
- Minor DT binding fixes based on Krzysztof Kozlowski's feedback.
- Removed fixmap slot usage from the DT FFH driver (per Will Deacon).

Series structure:
- Patches 1-8 are mechanical moves only and do not change behavior.
- Patch 9 wires the shared helpers back into GHES.
- The DT firmware-first CPER buffer provider is added in the final patches.
- "ACPI: APEI: introduce GHES helper" is internal build glue only
  and does not introduce a new user-visible configuration option.

- Link to v1: https://lore.kernel.org/r/20251217112845.1814119-1-ahmed.tiba@arm.com

---
Ahmed Tiba (10):
      ACPI: APEI: GHES: share macros via a private header
      ACPI: APEI: GHES: move CPER read helpers
      ACPI: APEI: GHES: move GHESv2 ack and alloc helpers
      ACPI: APEI: GHES: move estatus cache helpers
      ACPI: APEI: GHES: move vendor record helpers
      ACPI: APEI: GHES: move CXL CPER helpers
      ACPI: APEI: introduce GHES helper
      ACPI: APEI: share GHES CPER helpers
      dt-bindings: firmware: add arm,ras-cper
      RAS: add firmware-first CPER provider

 Documentation/admin-guide/RAS/main.rst             |   15 +
 .../devicetree/bindings/firmware/arm,ras-cper.yaml |   52 +
 MAINTAINERS                                        |    6 +
 drivers/Makefile                                   |    1 +
 drivers/acpi/Kconfig                               |    4 +
 drivers/acpi/apei/Kconfig                          |    1 +
 drivers/acpi/apei/apei-internal.h                  |    3 +-
 drivers/acpi/apei/ghes.c                           | 1043 +------------------
 drivers/acpi/apei/ghes_cper.c                      | 1056 ++++++++++++++++++++
 drivers/ras/Kconfig                                |   11 +
 drivers/ras/Makefile                               |    1 +
 drivers/ras/cper-esource.c                         |  322 ++++++
 include/acpi/ghes.h                                |   10 +-
 include/acpi/ghes_cper.h                           |  141 +++
 include/cxl/event.h                                |    2 +-
 15 files changed, 1621 insertions(+), 1047 deletions(-)
---
base-commit: b1cbabe84ca1381a004fb91ee1791a1a53bce44e
change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab

Best regards,
-- 
Ahmed Tiba <ahmed.tiba@arm.com>

