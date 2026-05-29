Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC113B6376;
	Fri, 29 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048276; cv=none; b=PH+PIqYrIKiYqI7axVC2GBvqE1t1JQ3F2ug7ox+GS5OIzn8aLVUJuqRKnUnOPoTEF4/Ve7Zrtg9T+XlBAYEPhA9HfH4o7YeZKz0S/QuuI1Ry+g/hxyOleUlujmW3rWoyymZzX3JUjzbVr/GSOTUo7S8MHwFrEtxUqj4A8Sxy+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048276; c=relaxed/simple;
	bh=PhsoWnNzKoot9QOeJqx67Uz0y4ZbixYdSGzdVAqeDi0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=owl/4LQ0pmM5Ym6vyUtBAKBcc5tWziVdLRKk/GrDZC3MRJdsMotlpO8ZdoIt4YHUEuV/DMrGaTvT0m+Nt5H/LrZde4bBF3UmjQLi0fKR3+jRVlhlbSgOelL8wZxI98YsczLj613csOPVnlHoV9adiBuWPMhwE/DMpJNx5JK0PnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gUOu0QnP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gUOu0QnP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3470B22D7;
	Fri, 29 May 2026 02:51:09 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3A863F905;
	Fri, 29 May 2026 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780048274; bh=PhsoWnNzKoot9QOeJqx67Uz0y4ZbixYdSGzdVAqeDi0=;
	h=From:Subject:Date:To:Cc:From;
	b=gUOu0QnPcKnD3bkA1MrT7ZF46sBfdAYOyiqCLYtu9YKupH+gOKBV+WOikGfSD9NcQ
	 EPyArBAnrs+zw4i2tVQ4C1KCeaoa/ywBKG7Mi7aECBgI1J9G4MC+3NCyl8dGpwyuCV
	 QSmJIfizE8sI4oShP3gADl3ZjiMbrYnnl/Ctoo6E=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Subject: [PATCH v5 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Date: Fri, 29 May 2026 10:50:40 +0100
Message-Id: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBhGWoC/5XOzYrCMBSG4VuRrE3JOSZNdTX3MUjJ7/SAbSUpd
 QbpvZsIIrN0+R3I8+bOckgUMjvt7iyFlTLNUxlqv2NuMNNP4OTLZiiwFYiCL/OVXOZmGBeyAng
 yuY9x6E0ae5qWkCZz6asUbtxG752OTjtjWRGvKUT6fda+z2UPlJc5/T3jK9Rr7ShA0ADYSdVAB
 xLgyKEGg29K03yVVOPmkVVixdezz7+3Ihf8IHU06PVBgf0vy7esoPtMlkWW2B67VitrWnjL27Y
 9ACF2UCN1AQAA
To: will@kernel.org, jic23@kernel.org, xueshuai@linux.alibaba.com, 
 saket.dumbre@intel.com, mchehab@kernel.org, dave@stgolabs.net, 
 djbw@kernel.org, bp@alien8.de, tony.luck@intel.com, guohanjun@huawei.com, 
 lenb@kernel.org, skhan@linuxfoundation.org, vishal.l.verma@intel.com, 
 rafael@kernel.org, corbet@lwn.net, ira.weiny@intel.com, 
 dave.jiang@intel.com, krzk+dt@kernel.org, robh@kernel.org, 
 catalin.marinas@arm.com, alison.schofield@intel.com, conor+dt@kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Michael.Zhao2@arm.com, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Dmitry.Lamerov@arm.com, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
 acpica-devel@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780048269; l=4273;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=PhsoWnNzKoot9QOeJqx67Uz0y4ZbixYdSGzdVAqeDi0=;
 b=4LZk0RIa3vVsPfok70Bkk0nn/tFW90OcgFipoA9qmlu1DTjOsn7/XsxWtMrCF3t0hdeWKsRDG
 qK1VHPix0lxCheY5fBK53z7Wxo4MMrJ6qkbFDhJk0TCcZZ+6/6wcgg7
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

This is v5 of the GHES refactor series. Compared to v4, it only updates
the DT binding to address the latest review comments.

Changes in v5:
- Dropped the `oneOf` from `memory-region` and described it as a plain
  list with `minItems: 1`.
- Simplified the DT example to keep only the `arm,ras-cper` device node.
- Link to v4: https://lore.kernel.org/r/20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com

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
 .../devicetree/bindings/firmware/arm,ras-cper.yaml |   54 +
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
 15 files changed, 1542 insertions(+), 1036 deletions(-)
---
base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab

Best regards,
-- 
Ahmed Tiba <ahmed.tiba@arm.com>

