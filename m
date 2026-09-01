Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086423806D6
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224752; cv=none; b=HnYu60q6hecclucPc/sXbPu8xf8VyW16XF3M1pmPEMu/zM60pg9W6NHHmmJiiPmgSzPCmKOKTJF4pcQDYw/85K9AUtUnMh5faXMomF9bSJ9+dOTKdBHNdw7DG+9KiZkdNl5Zez8r4wpS+2m/9hBWsyhJxpJ8WEHM0XcrzIpbpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224752; c=relaxed/simple;
	bh=SuXO6Rw2OD8RENWA3cD1nqy9B4wpX6nA3k4+CdFkYg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8i52+jSng5e4MJLolAwQmeIot2VAjW92YTKmhd/KWGa8j+fC3Of9czNQsVIlTXEJL4FZsKfNg2ctEID1q7zjxVwdgBJH7xuijeII0PXDvGAn4u8FWc/BsULW+VCNCzQu/9h04WzkPpZ5bGk1iJ2yEvvoJ2FQxuB19C2i4q/e3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8nO7uFV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8nO7uFV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d53197d8b5so35073095ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224747; x=1788829547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqWIp2bpYsEXRmOJBqoBVIcXDWfpHGacUwf5CoaucBQ=;
        b=C8nO7uFV2DmitACXWTgPwbWzm6x831cPM+tHB6/7BzxJGLyMaP3CowGGd93Uf5tvi/
         Thxr6lnAjEghva7p91QH8+LT+jAdpDyGEj2kCAKFLZaU1Oy8bPc3nMgUwqqd4b1R0yKf
         wJ5d0fexDj83aPjvJlV/HVl031IWqB2GAgA/4W6cJad/rFCGUCXkXmZaWZ8LeE06wRvn
         5q5DIkwOL1uaYH6mzQwwKIx/+YSwXM2C3oSFI4w432LR2gS8x1Wq7Av/oF4IHr+qC4W4
         Pt9/YMELOZnhVAlVR7bd6kf+PDDW8Ib9ErTKtw1RU6oZ7tvSg0xjG0AzhZbR6D2caiFR
         hRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224747; x=1788829547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqWIp2bpYsEXRmOJBqoBVIcXDWfpHGacUwf5CoaucBQ=;
        b=k1x5RD8aHKdJNgQVkRctvzGYsRWMozyt0EO7RC1oVHfZRiZfoxVNbZRpxodLZGW0qc
         iYYYXFxETEGa4xcljgpyTrGxmGJkgtsfr4w+cbcWBB+QvLqORKnA9xwmD5atyy9AABoB
         Dkg3Ubn7/n/SJYPo8s/nmbqYAw/LA2X3egssw9X82NsK9NO+Z4fxp0S3vofMYhPwg2rG
         vukFf3D5b1CysXyVpe78kK+nHx0yI6Y4pIC3J+YFxVSgh5iLNWtCul0dVJl/Fk6rIa9r
         bHOa3KEXsRRS+pFPUhkQK89ed1gE2q8zM1PEysR28K5TtbmDra7I3tjZ+tSZd33OlAcA
         w2ww==
X-Forwarded-Encrypted: i=1; AKwUvBwt00HlObfNlF4wL/r289kNsnEzgyc82LOQ5zMcyj4bEEa04RXWqnRu6PQJFbzNDkxwcpwpDiTE9Ug=@vger.kernel.org
X-Gm-Message-State: AFuF++mN35bC0Rjj5gBMlR68ji8rHGj0+Uu4WOUg7pg+wZXFUIMXjzZ7
	8HXPwZ5k+L45FtQD3A5gQlWwRJkvE12sGNeZXDvt2o8t6JiDNV185j8B
X-Gm-Gg: AYBFou11cXmhYJD0DYGvFLEkL1WA/YS7ilSgrS8noI21+1mOFo3dYgUEZZsS0YG6J5o
	3Yh8+xQovINsWAF2ZEh6WFCdbqBTs3nbb369z7frsuu1YyfUKpgPi9xrjses1JQEcjOTvivFipc
	AUIkKk9z8M9rX8ABJv8tvolCluHZ3DpXTB66wWu4nqeLwI9ceDvNtXQwD2Vh/tUyOLrI0Z0gOwf
	4KV49a44duP3w6ypNPUqF4BW8WSyluK4IvPA/NHmvlesAL1PCD9ZN1kBGLFgwuBP/W7c/+BvFWw
	j7im2CoyAkWIPYUoDaTBuq0eXQZ2gEa2ubPfzKCVENTJcN2KoazVwvKYbsXadY3dXiPflWUsVFc
	0Pdo/LXVUOP47Yxwls1sQFaixI6Ulro3ZK12gt71DxZqT+L7bQJvh7zNAaqgcwFXpmmCTjMhayU
	JLH95s4QByQMMt+dTq+pTWVndf5tjrS9WGH7BkZuRttJLFnv4gVZbscJpurDEMkei8Fp7RDx4Yw
	XXr2g==
X-Received: by 2002:a17:90b:1811:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-39907df0168mr5725338a91.14.1788224746603;
        Mon, 31 Aug 2026 18:05:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 12/21] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Date: Tue,  1 Sep 2026 11:03:38 +1000
Message-ID: <20260901010347.2614656-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
allows for measurement and authentication of PCIe devices.  It is
based on the Security Protocol and Data Model specification (SPDM,
https://www.dmtf.org/dsp/DSP0274).

CMA-SPDM in turn forms the basis for Integrity and Data Encryption
(IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
transmitted over a CMA-SPDM session.

As a first step, add support for authentication via a CMA TSM driver.

This was previously discusd here:
http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch

By utilising a TSM driver we get a lot of the TSM driver probe policies
"for free". Currently there is no mechanism to provide evidence to
userspace, as the TSM system doesn't support that at the moment. That
can be added later when support by TSM.

Credits: Jonathan wrote the original proof-of-concept for a CMA implementation.
Lukas reworked that for upstream. Wilfred contributed fixes for issues
discovered during testing. Alistair reworked it as a TSM driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS             |   1 +
 drivers/pci/Kconfig     |  14 ++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 154 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 -
 include/linux/pci-doe.h |   4 ++
 6 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 36f84a02894b..89cd64f88ebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24762,6 +24762,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..0862ef69aa3f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -124,6 +124,20 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	depends on RSPDM
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select PCI_TSM
+	help
+	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
+	  A PCI DOE mailbox is used as transport for DMTF SPDM based
+	  authentication, measurement and secure channel establishment.
+
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
 	select PCI_IDE
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..16abfd0e17e1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
 
+obj-$(CONFIG_PCI_CMA)		+= cma.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..9f2cc0b2ec8a
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ * Copyright (C) 2022-24 Intel Corporation
+ * Copyright (C) 2026 Western Digital
+ * 	Alistair Francis <alistair.francis@wdc.com>
+ */
+
+#define dev_fmt(fmt) "CMA: " fmt
+
+#include <linux/err.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spdm.h>
+#include <linux/tsm.h>
+
+#include "pci.h"
+
+static int pci_doe_transport(void *priv, struct device *dev,
+			     const void *request, size_t request_sz,
+			     void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+
+	return pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		       request, request_sz, response, response_sz);
+}
+
+struct pci_cma_tsm {
+	struct pci_tsm_host host;
+	struct spdm_state *spdm;
+};
+
+static struct pci_cma_tsm *cma_tsm_from_tsm(struct pci_tsm *tsm)
+{
+	struct pci_tsm_host *host = container_of(tsm, struct pci_tsm_host, base_tsm);
+
+	return container_of(host, struct pci_cma_tsm, host);
+}
+
+static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
+					 struct pci_dev *pdev)
+{
+	struct pci_cma_tsm *cma;
+	int rc;
+
+	cma = kzalloc(sizeof(*cma), GFP_KERNEL);
+	if (!cma)
+		return NULL;
+
+	rc = pci_tsm_host_constructor(pdev, &cma->host, tsm_dev);
+	if (rc) {
+		kfree(cma);
+		return NULL;
+	}
+
+	cma->spdm = spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_mb,
+				PCI_DOE_MAX_PAYLOAD, NULL);
+	if (!cma->spdm) {
+		pci_tsm_host_destructor(&cma->host);
+		kfree(cma);
+		return NULL;
+	}
+
+	return &cma->host.base_tsm;
+}
+
+static void pci_cma_tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(tsm);
+
+	spdm_destroy(cma->spdm);
+	pci_tsm_host_destructor(&cma->host);
+	kfree(cma);
+}
+
+static int pci_cma_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(pdev->tsm);
+	int rc;
+
+	/*
+	 * The DOE mailbox lives in the device's config space, so the
+	 * device must be runtime-resumed for the duration of the SPDM
+	 * exchange.
+	 */
+	rc = pm_runtime_get_sync(&pdev->dev);
+	if (rc < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return rc;
+	}
+
+	rc = spdm_authenticate(cma->spdm);
+
+	pm_runtime_put_sync(&pdev->dev);
+	return rc;
+}
+
+static void pci_cma_tsm_disconnect(struct pci_dev *pdev)
+{
+	/* SPDM state is freed in pci_cma_tsm_remove() */
+}
+
+static struct pci_tdi *pci_cma_tsm_bind(struct pci_dev *pdev,
+					struct kvm *kvm, u32 tdi_id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void pci_cma_tsm_unbind(struct pci_tdi *tdi)
+{
+}
+
+static ssize_t pci_cma_tsm_guest_req(struct pci_tdi *tdi,
+				     enum pci_tsm_req_scope scope,
+				     sockptr_t req_in, size_t in_len,
+				     sockptr_t req_out, size_t out_len,
+				     u64 *tsm_code)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct pci_tsm_ops pci_cma_tsm_ops = {
+	.link_ops = {
+		.probe		= pci_cma_tsm_probe,
+		.remove		= pci_cma_tsm_remove,
+		.connect	= pci_cma_tsm_connect,
+		.disconnect	= pci_cma_tsm_disconnect,
+		.bind		= pci_cma_tsm_bind,
+		.unbind		= pci_cma_tsm_unbind,
+		.guest_req	= pci_cma_tsm_guest_req,
+	},
+};
+
+static struct tsm_dev *pci_cma_tsm_dev;
+
+static int __init pci_cma_tsm_init(void)
+{
+	struct tsm_dev *tsm_dev;
+
+	tsm_dev = tsm_register(NULL, (struct pci_tsm_ops *)&pci_cma_tsm_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	pci_cma_tsm_dev = tsm_dev;
+	return 0;
+}
+late_initcall(pci_cma_tsm_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6a59969bd52f..1b3d6e74fbe8 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -31,9 +31,6 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index bd4346a7c4e7..7540396336de 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -19,6 +19,10 @@ struct pci_doe_mb;
 #define PCI_DOE_FEATURE_CMA 1
 #define PCI_DOE_FEATURE_SSESSION 2
 
+/* Max data object length is 2^18 dwords (including 2 dwords for header) */
+#define PCI_DOE_MAX_LENGTH	(1 << 18)
+#define PCI_DOE_MAX_PAYLOAD	((PCI_DOE_MAX_LENGTH - 2) * sizeof(u32))
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
-- 
2.55.0

