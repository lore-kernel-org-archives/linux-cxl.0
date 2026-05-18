Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E723F9282;
	Mon, 18 May 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105553; cv=none; b=FYViVnOn7EQTxrC9B6uLz8RhUrljafUNFns/NeGyuLU+XUOak3mc2LZFE6b/H3iOfL0U/IXHII7VPDpWgXk8Z7NUXnVhDBGL7IuGhNcJXGOQ7VojdJgcBBmLu1fp9NTRnaXYmQvR7RNjaEcsyY+0NaNOIvpmBOMfNmqFOnNCA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105553; c=relaxed/simple;
	bh=t7eff0nNKGqGSzC5Dpn2m5cRP7fPVTRKNbLymISWJn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcQ9EnsAbb67Up7NTeJT4lK0QsJtmGtrcWg/xWl3H+i+duhgsd5Qc73cxu8q2J8eWif3jCRwx8MAvoYDWgAhwRrHhilCgErSFk54OTfPUn1EYelOjFJnqQhTPBZRpHnLktzfKOMXmjaGcxF2jEaz3skwh+rk4+HN/2d0iX+dWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=chAQVYzq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="chAQVYzq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9CA44660;
	Mon, 18 May 2026 04:59:00 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60BA3F85F;
	Mon, 18 May 2026 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779105546; bh=t7eff0nNKGqGSzC5Dpn2m5cRP7fPVTRKNbLymISWJn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chAQVYzqoAtBk1xmJ0LQA/Yk5bciRaNX2fBV1L04I7oVDXeL5rmVGlnNq0qBS8asx
	 AFFXunfWa8soHrVYBApe1lN00BMcr3Anc0/8KsfTfwVSrnNpzAH+nXhwgMXtlSCCLw
	 B7asKW5o9FNMY5ZE+QWdNjyzy1ZW01TPNCMn0wwU=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Mon, 18 May 2026 12:57:52 +0100
Subject: [PATCH v4 09/10] dt-bindings: firmware: add arm,ras-cper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-9-42698675ba61@arm.com>
References: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
In-Reply-To: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105490; l=3188;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=t7eff0nNKGqGSzC5Dpn2m5cRP7fPVTRKNbLymISWJn0=;
 b=SgWeIgcCxMLYKi3Aq/Hv3NVmCarm1O6TQOTIVwu8Q4qifa5LF03fUyU363y8JGnSRuuIld8Wc
 XwAFkNsII5TDIDl37jyzslr6DElygh2yn7o3VZt2kYLoealFofD+Itr
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Describe the DeviceTree node that exposes the Arm firmware-first
CPER provider and hook the file into MAINTAINERS so the
binding has an owner.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 .../devicetree/bindings/firmware/arm,ras-cper.yaml | 71 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
new file mode 100644
index 000000000000..81dc37390af5
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
@@ -0,0 +1,71 @@
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
+    oneOf:
+      - items:
+          - description:
+              CPER Generic Error Status block exposed by firmware
+      - items:
+          - description:
+              CPER Generic Error Status block exposed by firmware.
+          - description:
+              Optional firmware-owned ack buffer used on platforms
+              where firmware needs an explicit "ack" handshake before overwriting
+              the CPER buffer. Firmware watches bit 0 and expects the OS to set it
+              once the current status block has been consumed.
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
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ras_cper_buffer: memory@fe800000 {
+        reg = <0x0 0xfe800000 0x0 0x1000>;
+        no-map;
+      };
+
+      ras_cper_ack: memory@fe801000 {
+        reg = <0x0 0xfe801000 0x0 0x1000>;
+        no-map;
+      };
+    };
+
+    error-handler {
+      compatible = "arm,ras-cper";
+      memory-region = <&ras_cper_buffer>, <&ras_cper_ack>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7492fefa447c..3bbc19589f1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22251,6 +22251,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
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

