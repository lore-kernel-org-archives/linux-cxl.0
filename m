Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5537D11E
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471088; cv=none; b=pn0jYa7FOEX89n0/754qb3Tz2zug0OzrzWeYpFJ3HyDJftxBQbKZ6+1BnmL6xvqK5R+mry9XzBfm9tDv4lU5LGuou0Ma+CUcloooyWEO+Gb3g2qQLBWSviXI67IMq8h3CRClbS3GeocIO022xSe8SH7aL679qxMwl+qs1SC2JYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471088; c=relaxed/simple;
	bh=FQZN8bKo46bAv5JC3qvcmsTZ5kJ+2INlPY4MPewL8dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsYFTIDEOvQ6Dekne7pbFy2BTy7doyv0jAibiTDvUGZY4ybhxmMOTYmjJf9fLPS3HpO10D73FfCWfZlJfJunITj+Tj+z0YFUxKVsyyZuyUp7ICQ2S94UAcOcgCg+H/vkuxFT/g87fQm7SFp3SSReNfB3LJiLQ9PFwoLpoKxbIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpTdbgX1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpTdbgX1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ad135063so115606535e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471084; x=1778075884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPS8B/0ftELxPYBJPOi/Jw2N6PyAu4qwVtoZHd48FII=;
        b=KpTdbgX1+cRV/qgQ2gMHa/wuu5iUcqUstWvTYXj3JzXyP6QAAirVDngPrjIHuWf1TE
         71Ft4ckL2Lfm8lE769hdReMsvQhm3eHgaoOrSvnjnaYhxrDmliWPlVnIc3MquD/8FA2e
         doxNlX+BIsDKao4skprINaCWY8NWSnFZG0DArNEhxu72qzN1CQJoe6ZO9/XkhVhTF+pW
         8b7IVRUqe5vJMv4jw5kiUGighbK0EreYvK2tMlfDg/Az8gZ5QQKq64aI6XYFfRCAxgbh
         Yv7Z8zSSVI04vBe0+FVTLCo+Y2bJPS1uwdNcYdGz9NhjaG9j+avGUr7T1bb1Cm2A17gX
         5hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471084; x=1778075884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPS8B/0ftELxPYBJPOi/Jw2N6PyAu4qwVtoZHd48FII=;
        b=cScOnRUgoeZsAz2UV3jv82V1MasvBEFJZWBPNQ/LdkQ0J43uSE4k2zw9it29txok48
         LiPol1RaU8T4Xppqt+Z72VDOoAOuQMbk6IFExOJunwYkP182Yi53hXQqVWxO3AdbCT/O
         cPPGzNUrv9ZLXghZcDa3BOGhd/ccypoE+F5/lq5PVMnz8eKNeuUkK1TtYmT/fXw1HpEU
         4nQzueNpZO2V/aBNmOHPFdJs6p7k1vnYnU3OMQiRYbLY0rAWTI0h7mh9YAhYTP02+jCh
         19JbZUHPhzABrnFe66x32O9i1wVntnxZAHFrDaJgL0/9gdHViAP6ajM2gZeeCb/N9M3j
         ZRwg==
X-Gm-Message-State: AOJu0YzXOFZl5Z/dKwp1ZVYwsCBFSpMbPnIFSW49B0ZXLHUevXQjq8LQ
	FVrX/HrYBhOtOLcK9HTxDnf/MEc/HoppZZhWFAbMnFJJGg0n8amIPx+inX/XShj3
X-Gm-Gg: AeBDieuM2VTn9TBKjzDuTY3vEDuu2MDU0SkiDar/SU9Vm5HDqPl70F3slLNHT8D7Gk2
	kMSX8+GjwXAVgh6oie6s9SYoLla70g6U+pPIINrfOj5YGmgowgp4aIes6RoFr0bhFwOuztgagmj
	3aq9JTPXNSW0Cwf+VOmvE9kj4NBEERRMe6J4UG1pg5bqgy8hFOhVH6gWo/bKLm7So2at6QFrSjl
	mVP6M6Kp6hEg7BGl+7IiP5vCKEaEsK0tCcJX58Pprs5rlQX8F7Nh7w4oi1P3uQEDaYjAzMr7Nhq
	80tpwOUFe+KPRu1L0FsZftH9roZ+uYlY5j1CNhx2tvtSZ5hu+VhK/qcQQFfFCp4j38JCb3hIpj+
	fEab/0c/cHVz7lKEf1SuIY8eAE+b2jWUZHVRwXgtE3Gf6sPGclBJEv1avlY0ui0rVCgaz8eotAX
	xPjrKxE7v1NoL5ZXg46pzPJyO1DXC9UgpG0EnJaetExQjO8mF57WV5kVJ3YhYhilMHm/wa6iZI
X-Received: by 2002:a05:600c:c4a3:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48a7b54eb83mr71355305e9.29.1777471084202;
        Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:03 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 07/10] cxl-downstream-port: Add support for VCS switching
Date: Wed, 29 Apr 2026 14:48:41 +0100
Message-ID: <20260429135717.3048713-8-joshualant@gmail.com>
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

When a downstream port is connnected to an upstream port which is
defined as a VCS within a cxl-vcs-switch, the port will automatically be
instantiated as a VPPB within that VCS. This downstream port will then
appear normally to the guest, but can be connected to a real downstream
PPB at runtime when the switch is issued a bind command by the Fabric
Manager.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_downstream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 5322c46900..5e7ce6410d 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -14,11 +14,14 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/cxl_downstream_port.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_port.h"
 #include "qapi/error.h"
+#include "hw/cxl/cxl_vcs_switch.h"
+
 
 typedef struct CXLDownstreamPort {
     /*< private >*/
@@ -199,6 +202,14 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      component_bar);
 
+    PCIDevice *parent = pci_bridge_get_device(pci_get_bus(PCI_DEVICE(d)));
+    if (parent && object_dynamic_cast(OBJECT(parent), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(parent);
+        if (usp->vcs_name) {
+            cxl_vcs_register_vppb(usp->swcci.vcs, usp, dsp, errp);
+        }
+    }
+
     return;
 
  err_chassis:
-- 
2.47.3

