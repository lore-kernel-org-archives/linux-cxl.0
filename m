Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154D37C921
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471087; cv=none; b=QzSY2jgo/palqXm6PkLCQJEorYUKKKAofEqqa0ScpU4PA2QLba3EJHLYttUH9nogqLLzo2lcAH3kIspkjyZ5ZiEx8W4kXm6/p2R9LocBQlAUKk8du4sJePwkDOYOk9xNsFd560eA8V0u/JxQ8QQaCEqUQmNQ9iEK/tk4nTyzC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471087; c=relaxed/simple;
	bh=mWZDJ0bQ09Rbk9HWSIxtQwsYSIa5DJOoIeqfamMVsj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm17dxi4SuVU6n+AFj7ynB4qtRMNKGf7chmxJ8ujrfYPEhrjuChR9i+lJEe1DwLiCqoNBQv37Ow2wMMntHyg9kIJGAF6WuP5DIp4ITxWhnepY3Uz4+zqlj4LqXz8cgpxCbdRkwIiex/vQczz+V9DKonCRuozppCsBqMYMRcyF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJzJK0dH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJzJK0dH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44261378651so624845f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471083; x=1778075883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfj+OEin87giEu8kZpIKXoKArfkMj1N2Z6jKqDhBiuE=;
        b=NJzJK0dHdWAjqsovyre3pNTY6bPI6z2G1y93c0rXU0syFnGmv5M9ZkAdAEnpuM/smR
         mJR035dLPNECRTvDU5chHSjAEWbmhl7gmNM2Dpg//lZzNQzrG4VqqkUSeqtdMtVzMSMk
         XDR7hx/Cp98LDRv9ElrtJA0U2LqgH+dDaBuPE3SSisTyrfmVhJR1ujoERNFypu9QbgwF
         65zV7BV6+xwStAsQ6N90s/J/2Ce+GhpB4Bq/tIcRB6RQpNsjzG0JXP+dLPzLWs5BjgVu
         105obKJOp1FOkjHYet/dX3SDmlBgu5lNpQovM9lO7/P1+m9Bn0QrXkBkoS83jE60Yi3Z
         FSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471083; x=1778075883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfj+OEin87giEu8kZpIKXoKArfkMj1N2Z6jKqDhBiuE=;
        b=a6FXdXHLppPbaTd9KD/crhDi79HwBaZvlOYn3SdDulEbLotGEQAskFEQ3o5miX1DTH
         /wcLQdwplsLC/++0h/gtThj5TWSNFMVGwtLSyx262/fi/GnHf8YB5pudyXMzn8ehWT9O
         uHDLz3KtDlQNP8v7ye9Q5MxCjdU5YB7UmGaGMsnjTAQpSNEvBVmLoEEjQ2PybvKq19nx
         cmbUSWGCKfU1xCTgi8p4jSrg8bRynplZp9RBRffyb5f4cIPe8g3AmGqhjgnp3xJpS2+d
         u+nSbWe37HGbNfoWRXgv+pYalNwuqRaTj/wtAqlsuOjIGHoHkyWuk4T4xhiUSsmLsUhh
         Xptg==
X-Gm-Message-State: AOJu0Yx5qwkF6digSvhJ7dtUBLQgzhCrU6NqZrMXZgAozRX+OdYHw7V6
	HvXDR+qpYR3hEnpHqcXYUElNprZUSuMyvyrhqy8Rn1fMMSt7Dk6ePUH9G82pELF3
X-Gm-Gg: AeBDiet359QQWDpNDyCk+Y0iGCMgSBv9a4Fyl2bEXQdfEqzijy5rbLIsZK/PagpSeBg
	UncBXRrFDsuyK2U5+60/ajrDCWxpEBQg64ggYBwomEL0x4fsUR+VWRns20zaO2RCHoR1icNQrI1
	vDCnpNHPeFj5rD/xk6EnKOXdV4QW+ZjTxa2yUpA9ap91ZOk21mFgVlOYS0p3xoreZV6sNQkumqm
	wPqqDg3VWds2MLYGyxo3wnP2h8D49JC76Yr86lsBQ/rmrTcZp/jlfIkO5eRn+MWwMhJIX6KjgBR
	HprC/uPBPOpaD7OlKxBkojoA8BCh3OlHYWTLFs95uKSNnJncDzoboAk0fJNh+lUZO/T9fqEannQ
	d4KKVN2FwqpuW6clo0rS3w7p5bVryq6S4btNX3eKMEql0RZNdFEZUJ0cYX0MWMgwefMRFhHZVAo
	oMeYlC7bHN/q606dT+3Piwouu6kIotozk6gNFVEJNzYBeE8FiC3v3iwnWtIQEyTdaIADT77mDc
X-Received: by 2002:a05:6000:2102:b0:445:7f70:70d3 with SMTP id ffacd0b85a97d-447a3421972mr4063484f8f.5.1777471083406;
        Wed, 29 Apr 2026 06:58:03 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:02 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 06/10] cxl-upstream-port: Add support for targeting a VCS switch
Date: Wed, 29 Apr 2026 14:48:40 +0100
Message-ID: <20260429135717.3048713-7-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows an upstream port to be registered on the CLI as a VCS within a
cxl-vcs-switch. A VCS is defined as an upstream pci-pci bridge, and a set of
downstream virtual pci-pci bridges VPPBs, which form a single Virtual
Hierarchy within the switch.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_upstream.c              | 20 ++++++++++++++++++++
 include/hw/pci-bridge/cxl_upstream_port.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 3fcfc2cde6..a91f721c9e 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -16,6 +16,8 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
+#include "hw/cxl/cxl_vcs_switch.h"
+
 /*
  * Null value of all Fs suggested by IEEE RA guidelines for use of
  * EU, OUI and CID
@@ -346,6 +348,22 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
         goto err_cap;
     }
 
+    if (usp->vcs_name && usp->ppb != UINT8_MAX) {
+        Object *obj = object_resolve_path_component(
+                          object_get_objects_root(), usp->vcs_name);
+        if (!obj) {
+            error_setg(errp, "vcs '%s' not found", usp->vcs_name);
+            goto err_cap;
+        }
+        if (!object_dynamic_cast(obj, TYPE_CXL_VCS_SWITCH)) {
+            error_setg(errp, "'%s' is not a cxl-vcs-switch", usp->vcs_name);
+            goto err_cap;
+        }
+        cxl_vcs_register_usp(CXL_VCS_SWITCH(obj), usp, errp);
+        if (*errp) 
+            goto err_cap;
+    }
+
     return;
 
 err_cap:
@@ -372,6 +390,8 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_STRING("vcs", CXLUpstreamPort, vcs_name),
+    DEFINE_PROP_UINT8("usppb", CXLUpstreamPort, ppb, UINT8_MAX),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index ce248f3dca..05632286db 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -22,6 +22,8 @@ typedef struct CXLUpstreamPort {
 
     DOECap doe_cdat;
     uint64_t sn;
+    char *vcs_name;
+    uint8_t ppb;
 } CXLUpstreamPort;
 
 #endif /* CXL_SUP_H */
-- 
2.47.3

