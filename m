Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078829;
	b=Ven4ZcayJOvuJ/BDxTH5gwW9IFRdjNpjHrTs8cjLQAAbAfOM896I1uOes7L1c0FLprJo
	 6skWBNaYCbplAIYxP9MokD9KSRsHvxV2LmXBtk6Yh0TrH+HkcN2xYwnXoWBKJ5ke61/xq
	 5Gp2Vq+LjdkUlq1IIg6ruW3jTr3reb7mKM4MUx4odIPR2G4LMXOlBjc7gZfGvne0U9n9r
	 NH8naBCCGejOHG/AQkR14ohtXMwypJpmwTqvqtkOOWzfSxhF21Ao8GGuUhN5S/N1cGbvX
	 +O25a9d+qu9WiQcA8BjbBLObV57lR31Y5V0r5K8hJsjI5MfcqK5OizbzhzKSoYlPYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
	b=XvQOUGRH3XDmP2tb4UGcdXJEZCp2sR9N/qE3Ofs2/e+5SP62SOqf7hFButo3KeIpcICd
	 pFraHLTEqxDd3qznGdcVlNxdpWHGKcGGpR59dcuEj47+XpWFYbT0N8Gn97H665hmZd+xZ
	 bDOSPnvOu9Lsv5X9Dfysu2gug5Hc5fBbz/iD8Cflo0HKuynFDmb0eOblH5XzhrKNSRgCu
	 i5nFlWN7HUcn6LVweKRuGlZ/7J7RJDMqBuYl4Zafz/rtnifwHiwT3YsrMaQVKio4Wsgx+
	 Xe9YnQ1G6kZa6Jo7lTVz3O/meK55X1iGjXqvIOSxHBtincOsZW7RxkHfnRXEoD5fVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MAMyseuA;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0751606A31F
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0751606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MAMyseuA
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9e53d011eso25870565ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078828; x=1793683628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
        b=MAMyseuA+Th5zBTXBY0Dqw1j+NIctBMKLsophxTIQ61PXElEkbr2Y7RRJqWiatrWVO
         C9TtAPVa3wE8cfRdlRMzme38r8CNt64SSjMJnah53zc1VoLCBp9EzdpiuYegRAUrNel3
         IPZRPzGy4oECllZl0j91EIm8PxHXxH4iz+dtt9Ve1jTiIm7k0FJdEkqkjELilHVqlAGu
         VjQskAngk7fqMwv+XD8yGdDKhJoZbDja2N+bcQPxTmz2fzVQWMmzgDLxS7uuwdhLO3YL
         kFECLHLNqj2KpeJkLDHsm+phmvsY8qVWaY5ftEPumk5wmwrLPwBOeKOj2XYSmiQKdF4t
         Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078828; x=1793683628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Och6f2ZEGT6g3BOEgcBpc50xNVpdk7rmIE2DR7kHuog=;
        b=0UNOr61OFqjhkxi0MPeKuw6NBemPc4N5Tk/e1Kti0kK3pOQBtEdZVY6dUrl4ewcBvy
         Fa4cbdZUR8PLjCQMaXbPw+LS9APdM/bI4XSahSlw5owLn+tGDZnaGpV6bSPGHiHsLLbf
         GGVZsrIPQ6xuNn+QITlBkDKU2wiWpzjr91IBv4F7sBZsXVVqgSkp4DyQKUhhKxneroBV
         ePtsvgb0BnrcxFotqWBgaJ7EowSdDnM012V9zTfzweRldPhgW4Aa7OhcAKWtSA0R1wk1
         gZz9e9jnUTUKNAC080qPldgUzRrtDcnFCm7PR+CEeiJ4ONOhkMG5W/6PUAnitaIQR6g4
         5AUw==
X-Forwarded-Encrypted: i=1; AKwUvBxE0cXZZsCQH1BSxtJL/5CMmyv/rnM2FEaVpMdu4sPQXsJ/RvhUgiB//dPt6DowUqsf1+mibekSnnQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2CHvRD//qSJwCT0i00SftdJGUvcI3ysV2Wd4N3a7EtzW1kPb7
	4T0fnaSLnG2ogL70Yf6HjhvDxZPITViPJaaq7GwAMqNJUuBm8KqgHavgWNHUsA==
X-Gm-Gg: AYBFou0sRxL2z3UbH9lUPWXrbXf1nuNpcAeiC7LfKHm6jN0OFrydj5ifgmcVY5hY4gm
	kj3phJE0dMOAXvcKHvDfSFTx5j6W8EKUsaLgHibYkyS5nNY0IoWrsV0JDIJ2GIdejmdsCssMvfj
	Z0hOtkLAuNCdwunq4WQYA6h1kG4KTGwylGc8Sm4vwCZnwM8tx3ay52xTpJPyqJOO5N8xpW3D3Nc
	wZeUGOraIrdgyof2IaTdlt+D21s5vYC/08Jn/KCrtM9XbAfZn9RoSPHBxQA9Hg6frybQcSSVfjp
	EC7/kiFVAngsxI87B8k7RzuqQg/QaqGr+ZYmLmwxCm/H3+CEwkp3ccrwShEouJcte1m1ecn7HNh
	Q/J3Jo7q2q9kFKZaGEJ9UGVdJMxc2UzAmFMhwPoYj+WE7rVULdMGrS/dFNMLnZO6bArLhXQj8od
	S4/LmLqA0XhldryANvHH402HUo7hOhN+cEn0VIWyHf3yw+fdIfIxRH92O2XtboE4RI4VIichs2l
	3uGxxz560GXIwiWF6ZOTskZyW5VyszRZzaLpAGFy3+kUbVhiGiSEZIdIdQSluPBWp5EykZQWOc=
X-Received: by 2002:a17:903:2c0e:b0:2e6:1c21:158d with SMTP id d9443c01a7336-2ea9c80fc23mr87111855ad.50.1793078828351;
        Mon, 26 Oct 2026 22:27:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 11/23] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue, 27 Oct 2026 15:25:24 +1000
Message-ID: <20261027052536.1722081-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_host() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

To avoid calling pci_find_doe_mailbox() everytime is_pci_tsm_host() is
called we can cache the CMA support in struct pci_dev and just check
against that.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tsm.c |  4 ++--
 drivers/pci/doe.c                |  3 +++
 drivers/pci/tsm.c                | 38 +++++++++++++++++++++++++++-----
 include/linux/pci-tsm.h          | 32 +++++++++++++++++++++++++--
 include/linux/pci.h              |  1 +
 5 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 1d2561628f432..22f2855f397bd 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -226,7 +226,7 @@ static struct pci_tsm *dsm_probe(struct tsm_dev *tsmdev, struct pci_dev *pdev)
 {
 	struct sev_device *sev = tsm_dev_to_sev(tsmdev);
 
-	if (is_pci_tsm_host(pdev))
+	if (is_pci_tsm_dsm(pdev))
 		return tio_host_probe(pdev, sev);
 	return NULL;
 }
@@ -237,7 +237,7 @@ static void dsm_remove(struct pci_tsm *tsm)
 
 	pci_dbg(pdev, "TSM disabled\n");
 
-	if (is_pci_tsm_host(pdev)) {
+	if (is_pci_tsm_dsm(pdev)) {
 		struct tio_dsm *dsm = container_of(tsm, struct tio_dsm, tsm.base_tsm);
 
 		pci_tsm_host_destructor(&dsm->tsm);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6b5d9ba8e9697..365634fb0df7a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -871,6 +871,9 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_doe_destroy_mb(doe_mb);
 		}
 	}
+
+	pdev->doe_cma = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					     PCI_DOE_FEATURE_CMA);
 }
 
 void pci_doe_destroy(struct pci_dev *pdev)
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 10c9c6696624d..03a84630bd69d 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -88,8 +88,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
 		if (!pf)
 			continue;
 
-		/* on entry function 0 has already run @cb */
-		if (i > 0)
+		/* the caller is responsible for running @cb on the host itself */
+		if (pf != pdev)
 			cb(pf, data);
 
 		/* walk virtual functions of each pf */
@@ -145,8 +145,8 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
 			cb(vf, data);
 		}
 
-		/* on exit, caller will run @cb on function 0 */
-		if (i > 0)
+		/* the caller is responsible for running @cb on the host itself */
+		if (pf != pdev)
 			cb(pf, data);
 	}
 }
@@ -175,6 +175,9 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
 	struct pci_dev *dsm_dev = dsm;
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(dsm_dev->tsm);
 
+	if (pdev->tsm)
+		return 0;
+
 	pdev->tsm = ops->probe(dsm_dev->tsm->tsm_dev, pdev);
 	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
 		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
@@ -287,6 +290,19 @@ static DEVICE_ATTR_RW(connect);
 
 static int remove_fn(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
+	struct pci_tsm_host *tsm_host;
+
+	/*
+	 * Only teardown the security context of functions that belong to the
+	 * DSM being disconnected, leaving any sibling DSM in the same slot
+	 * untouched.
+	 */
+	if (!pdev->tsm || pdev->tsm->dsm_dev != host)
+		return 0;
+
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 	tsm_remove(pdev->tsm);
 	link_sysfs_disable(pdev);
 	return 0;
@@ -299,6 +315,7 @@ static int remove_fn(struct pci_dev *pdev, void *data)
  */
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *host = data;
 	struct pci_tdi *tdi;
 	struct pci_tsm_host *tsm_host;
 
@@ -307,6 +324,14 @@ static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 	if (!pdev->tsm)
 		return 0;
 
+	/*
+	 * When walking a DSM's dependent functions skip any that belong to a
+	 * different DSM in the same slot. A NULL @host is a direct unbind of
+	 * @pdev itself.
+	 */
+	if (host && pdev->tsm->dsm_dev != host)
+		return 0;
+
 	tsm_host = to_pci_tsm_host(pdev->tsm);
 	guard(mutex)(&tsm_host->lock);
 
@@ -437,7 +462,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
 
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
-	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, pdev);
 	__pci_tsm_unbind(pdev, NULL);
 }
 
@@ -451,12 +476,13 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 
 	pci_tsm_unbind_all(pdev);
 
+	pci_tsm_walk_fns_reverse(pdev, remove_fn, pdev);
+
 	/*
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
 	 */
 	guard(mutex)(&tsm_host->lock);
-	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
 }
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 950e2c36a4cae..ddaec2168c7e9 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -130,8 +131,11 @@ struct pci_tsm_host {
 	struct pci_doe_mb *doe_mb;
 };
 
-/* physical function0 and capable of 'connect' */
-static inline bool is_pci_tsm_host(struct pci_dev *pdev)
+
+/* device is a Device Security Manager (DSM), similar to
+ * is_pci_tsm_host() but doesnt' support CMA
+ */
+static inline bool is_pci_tsm_dsm(struct pci_dev *pdev)
 {
 	if (!pdev)
 		return false;
@@ -163,6 +167,30 @@ static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
+/* device is a TSM host and capable of 'connect' */
+static inline bool is_pci_tsm_host(struct pci_dev *pdev)
+{
+	if (!pdev)
+		return false;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	/*
+	 * Report capable if CMA is supported, which can be supported on any PCIe
+	 * device.
+	 */
+#ifdef CONFIG_PCI_DOE
+	if (pdev->doe_cma)
+		return true;
+#endif
+
+	return is_pci_tsm_dsm(pdev);
+}
+
 /**
  * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 97a1096d5a8ac..26eeb43e34a12 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -566,6 +566,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+	bool		doe_cma;	/* A CMA/SPDM DOE mailbox is present */
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
-- 
2.56.0

