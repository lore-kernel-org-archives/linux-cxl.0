Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE283F58DD;
	Mon, 18 May 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105508; cv=none; b=PUBbal3gDcsZ2idhcAPalKtnEh0XkMTjeU5XXuozAaTXxsJnZ5AR37fsDkre0/wAONB2AuPHUXu3tpc2AK3PYrixmlMTev+Z3YyY8E9Id0Eibetzl7a+hzWxqmQf9DEl4uV3Md4TveTWefkiVjp34Fe5YSSaJ6VLngsVFdW951o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105508; c=relaxed/simple;
	bh=aymnqZ7euEW3E2MePTj/ayCve7TTm2Tlr6/IBaYLSa4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S1CMLgflRRqu4S1oV5ZIY0DkX/8Dt1BUo4LRRU2rNlD2VIyRAYNYMDNlSCPW5IQ9lH2+LmNNtc6HnWdwgEe/qFgXH6ITX3a2F++YP2S14aYvc1fDvhPV3ulQbclZORhlOJhtl7LPwNg3G509pv9ghc5tge/c6ZvmbLt+bZD8dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=brQhBhTU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="brQhBhTU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56251CE0;
	Mon, 18 May 2026 04:58:10 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FDCA3F85F;
	Mon, 18 May 2026 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779105495; bh=aymnqZ7euEW3E2MePTj/ayCve7TTm2Tlr6/IBaYLSa4=;
	h=From:Subject:Date:To:Cc:From;
	b=brQhBhTU+ztJNITcABkSy9j0zzrAfGX/t1DnNaB4/b98X0ccA1I6hFQ8eVEMmcVxX
	 JR2skMATRKrMY1q3n9RKATpYnP8IX5TfltDgH3kQQLC8xvt9GjRZdWbJ+AwkkbPkIE
	 QycypBnDqw1N6A9nMgw1cySuabqE093HBOtx89Ao=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Subject: [PATCH v4 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Date: Mon, 18 May 2026 12:57:43 +0100
Message-Id: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALj+CmoC/5WOywrCMBBFf6VkbUpm2prqyv8QKWkedsA+SEpVS
 v/dpCCuXZ4Lc86sLFhPNrBztjJvFwo0DhHKQ8Z0p4a75WQiMxR4FIiCz+NEOnDV9TO1ArhXoXG
 ua5TvGxpm6wf1aJLJPnnrjNHSaalVy6Jx8tbRa69db5E7CvPo33t8gbSmTgUIEgDrssqhhhLgx
 CEFrcljU11iKtdjz5Jiwe/Z/+8tyAUvSukUGllU0P7M27Z9AByTzM8bAQAA
To: rafael@kernel.org, bp@alien8.de, saket.dumbre@intel.com, 
 will@kernel.org, xueshuai@linux.alibaba.com, mchehab@kernel.org, 
 krzk+dt@kernel.org, dave@stgolabs.net, conor+dt@kernel.org, 
 vishal.l.verma@intel.com, jic23@kernel.org, corbet@lwn.net, 
 guohanjun@huawei.com, dave.jiang@intel.com, catalin.marinas@arm.com, 
 lenb@kernel.org, tony.luck@intel.com, skhan@linuxfoundation.org, 
 djbw@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com, 
 robh@kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry.Lamerov@arm.com, linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com, 
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105490; l=4004;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=aymnqZ7euEW3E2MePTj/ayCve7TTm2Tlr6/IBaYLSa4=;
 b=GMVF92sTzK97dCGcik2tVnTm1BWPBVb6KDHl4Ug42qpuvyPXuXeif5KTVC4ZjmkxfIAtWdPlR
 VLc5UOCDoi4DCRo57gQRCWT0cjiTAWzdIwitufp7g2eFANe2ALXckBf
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

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

 Documentation/admin-guide/RAS/main.rst             |   18 +
 .../devicetree/bindings/firmware/arm,ras-cper.yaml |   71 ++
 MAINTAINERS                                        |    6 +
 drivers/Makefile                                   |    1 +
 drivers/acpi/Kconfig                               |    4 +
 drivers/acpi/apei/Kconfig                          |    1 +
 drivers/acpi/apei/apei-internal.h                  |   10 +-
 drivers/acpi/apei/ghes.c                           | 1025 +------------------
 drivers/acpi/apei/ghes_cper.c                      | 1027 ++++++++++++++++++++
 drivers/ras/Kconfig                                |   11 +
 drivers/ras/Makefile                               |    1 +
 drivers/ras/cper-esource.c                         |  257 +++++
 include/acpi/ghes.h                                |   10 +-
 include/acpi/ghes_cper.h                           |  151 +++
 include/cxl/event.h                                |    2 +-
 15 files changed, 1559 insertions(+), 1036 deletions(-)
---
base-commit: e1914add2799225a87502051415fc5c32aeb02ae
change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab

Best regards,
-- 
Ahmed Tiba <ahmed.tiba@arm.com>

