Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D53F0746;
	Wed, 17 Jun 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704573; cv=none; b=T2MHIPwHrzwPBWyHrME2XzDctr7gbxZGTm1gyLf/lUTtGbUkAb0E0caeDTBbDFv/OHz4LiOyWzECqW4CstTigrCGGTVL6w1JdKCHCLJwRVO0HXTbiTo3Qhyi/AHvCQ0ePcRzq4FWMKXPWUGPD0vi2NYrbtlF4wAttCwz3neWRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704573; c=relaxed/simple;
	bh=Zn8XxlqbuTUbu03kyT0mZA2J926gwuoL8gKMplV7ANQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEcAUYQFZYei18b9sY7I4nxgXbMunLudGN6k/9KnbmnSa+1CSybdIV0fQuNp8s1vUbQv949mqxZ6MYAK+31XXHyi+4ECLh4xvpPoEU1pVBYAXgb/Cni6ajKGhg4P3NadAH2r6qvqT3/9fqRyiM4OW6IR8gvyt+uWDfLcper31gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=reBkMx1Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="reBkMx1Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9731C32AB;
	Wed, 17 Jun 2026 06:56:06 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23E93F915;
	Wed, 17 Jun 2026 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781704571; bh=Zn8XxlqbuTUbu03kyT0mZA2J926gwuoL8gKMplV7ANQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=reBkMx1Y4fl32y+wywqx8zGMC1K+dIJUCKh+WdfwbSvB+yX0TcOLDsdoZMvUGrD6C
	 rB6DkXQ4Run9vQ9TUEHVPAF+gz4Ljcpo9jePvbHr/O94T3nge3ISoX7zKFe2Q8edZe
	 uTgM1uJZgElahEJNieAyqChz4I96+jbxcLLkjmBQ=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 17 Jun 2026 14:54:47 +0100
Subject: [PATCH v6 09/10] dt-bindings: firmware: add arm,ras-cper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-9-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781704522; l=2701;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=Zn8XxlqbuTUbu03kyT0mZA2J926gwuoL8gKMplV7ANQ=;
 b=p905tSND28Dww4qnVPMC0hfec+iBv5oncjsJZ59HBev09gegmI6hYBWrKhFwJDKixig30+Py7
 PJNUnMM/CTPC2TyyfLuVHA35Fh7C9+sSDC/VZ4NZO3A8C0FU5c9vP6w
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Describe the DeviceTree node that exposes the Arm firmware-first CPER
provider and hook the file into MAINTAINERS so the binding has an
owner.

The initial user is the upstream zena-css platform, validated so far
on FVP.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 .../devicetree/bindings/firmware/arm,ras-cper.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
new file mode 100644
index 000000000000..23d54008230d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm RAS CPER provider
+
+maintainers:
+  - Ahmed Tiba <ahmed.tiba@arm.com>
+
+description:
+  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
+  a firmware-first CPER error source directly via DeviceTree. Firmware
+  provides the CPER Generic Error Status block and notifies the OS through
+  an interrupt.
+
+properties:
+  compatible:
+    const: arm,ras-cper
+
+  memory-region:
+    items:
+      - description:
+          CPER Generic Error Status block exposed by firmware.
+      - description:
+          Firmware-owned ack buffer. Firmware watches bit 0 and expects the
+          OS to set it once the current status block has been consumed
+          before the CPER buffer is overwritten.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt used to signal that a new status record is ready.
+
+required:
+  - compatible
+  - memory-region
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    error-handler {
+      compatible = "arm,ras-cper";
+      memory-region = <&ras_cper_buffer>, <&ras_cper_ack>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d6db8cb608f..5aa495fdff72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22322,6 +22322,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS ERROR STATUS
+M:	Ahmed Tiba <ahmed.tiba@arm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
+
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>

-- 
2.43.0

