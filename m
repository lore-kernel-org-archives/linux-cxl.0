Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B33A7843
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190547; cv=none; b=LQ2KtCJ49I6vZjciNmxSuok4TCFmzabHyGHC0Eppy+rxBYl1D9XjZA5xD60FeXnf1i0+mhfuqkmydU7SCpfwwPlE/Sqg59mJqaSqnHNjyMHkJ47gg/1yuWVKAES14zH6vkpM1vpmq4jMg/NmovlE4lDBX5xOJlR9LFN6g6A09sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190547; c=relaxed/simple;
	bh=7r/5MtGZqMvJOdN5HS4ELQ9HFZuPnCEAkmkoU/ngiQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+t1VqreSK4Ba8H6hitnZstd6lpLF7UJjd4NOPOt16vcgOdUYQ7DDQswdCpQEpa6l5kL686LwL8FKMoVn0ukPVV7BFKHaxxYhxZSsFlSMn2pHfiednfoB72hbE7ElPGYT4NHgFZ2WXnVKVyNBtvEt8aWvmMavCp+GSISHY5epvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ith3kdHp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ith3kdHp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c68190ade4so4058945ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190544; x=1782795344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OY5UKLFHiRpWlwxBMqMC5Pg/CeiYBOpGf9uFovdAIM=;
        b=Ith3kdHpjhVIyLKASUyD/S6Uf9gxVlhRxqZtP73c2tPk3scjK51Aybuzbvd4Utmw7f
         Jq/fE14I4qpmIN+JA6j/HaRPlx5oEriHdarZvuzSekAORGfUf2zT4qLKXqGkMTTSg/xV
         pk/d8w3KtpCe9ePWzcnkAwAG4M4YQVbJg8ertSGf3HPx3a0Dg2usA9RsNd1HNhIDkRRY
         Zn7Xr5LwHdn1l+hk0daVuxPH12OHZVGpV+pOhAXnSbMfewPoDBXncnjuN97pXklUVrxk
         buIz5lysa/yrb+VSOOeBaNKVWwKUgIi4e4nxTL5dRQesZ3/mStvSDPQVGwdFUyeUOYE/
         ueiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190544; x=1782795344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OY5UKLFHiRpWlwxBMqMC5Pg/CeiYBOpGf9uFovdAIM=;
        b=fWZqsnWVGHtrVvLK6UuC182fpC3L+nCg0qIIfM0TxDZC+i8XfzPppNx/4rdKiGJVcy
         8tsLZQe2mf/wYUYrzm7QVPp6qfXBCRs2F1ug6aB9BPg5BPS/3VVn3jigpkKLx2W+Hdzj
         JzXSF8wwHjxCIho4HvRsK38QPhuN+plfml9cjfxfdlMZ2ps4Zd+8XGq6PW/fM9aJt4ik
         xOaAKL1X3j+MHll6p8chVVOH3afP0vhmzksTvBNIQGxBH2NmX93tmuC/P49PPZ6pVGd/
         b+5rD/Juz+BfSNeDOKWTXgiwEASGN6+n/duCaVcii15y/uVJ3VoUrB5J32ayq4aR9fmM
         GfWw==
X-Forwarded-Encrypted: i=1; AHgh+RoTYuAaYKS9tF5G0CtyrCpUVOkwlTLPLk5M51fJxljxIppNWRNsEJvAroJoGekS9C+tfDecnQin4qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrz537/U83oZVh7aYoKUbvrIYdWanuTYRgdj3a2RKtooy6lMOG
	9kJtPDR6y7vvL0l8plUiIUZ0fg76OPwrdIyDxPriHU79BT21OW2AW0E1
X-Gm-Gg: AfdE7cmqfJjEhNKeT+RNTiAkyKQR3ySDspZLXZDobozV6zVsXH8Jil+zltkVlguZqBz
	mr7mdci3tIUxucqKRxLg/I1mzLLWlrY7d4iweiQYzFOUGBZPafgpxD5iWd1I6QYlsn1A7LsbwPR
	qJRYf2rPlvxFjmehndPj1mnMcMAO7EQNT/95vfR6+mEsEqeKiuwKzwnGPyqqZkV2fOVZhS8O7Tx
	62ndTivCoqmB13opUfA6ORHljLJ5bEv7DJzNwpI7n1/vEg5nVWioJxZW+3ED9vKTCuDcWJisCNh
	jrfX6PNrj38jJyBCicjPCd6jh9n5NY/H8JsURxrtaO297VVAx+tH4DWoHPsr2qa+lcXNsc90rw1
	s71zXUjC4tHUl34cZ3AnEq30VhDFMqUPNqkF9FUuBsuHCLgolbzc5n9H9d0LOJHMh0sWaLdah6B
	8AhVVdPumMd2Q6OQkR6h+ob5Xp1NMKuA==
X-Received: by 2002:a17:903:1b4c:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c7c41180e4mr15946055ad.28.1782190543604;
        Mon, 22 Jun 2026 21:55:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 10/21] PCI/TSM: Rename pf0 to host
Date: Tue, 23 Jun 2026 14:53:55 +1000
Message-ID: <20260623045406.2589547-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
names from pf0 to host) as part of converting pci_tsm_host
to be any device that knows how to speak any of CMA, IDE, or
TDISP.

This commit just renames the functions and provides no functional
change. That will happen in the next commit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tio.h |  4 +-
 drivers/crypto/ccp/sev-dev-tsm.c | 12 ++---
 drivers/pci/tsm.c                | 84 ++++++++++++++++----------------
 include/linux/pci-tsm.h          | 18 ++++---
 4 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tio.h b/drivers/crypto/ccp/sev-dev-tio.h
index 67512b3dbc53..78d598686487 100644
--- a/drivers/crypto/ccp/sev-dev-tio.h
+++ b/drivers/crypto/ccp/sev-dev-tio.h
@@ -53,9 +53,9 @@ struct tsm_dsm_tio {
 	struct pci_ide *ide[TIO_IDE_MAX_TC];
 };
 
-/* Describes TSM structure for PF0 pointed by pci_dev->tsm */
+/* Describes TSM structure for the link host pointed by pci_dev->tsm */
 struct tio_dsm {
-	struct pci_tsm_pf0 tsm;
+	struct pci_tsm_host tsm;
 	struct tsm_dsm_tio data;
 	struct sev_device *sev;
 };
diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 46f2539d2d5a..a900fd22eac9 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -205,7 +205,7 @@ static int stream_alloc(struct pci_dev *pdev, struct pci_ide **ide,
 	return 0;
 }
 
-static struct pci_tsm *tio_pf0_probe(struct pci_dev *pdev, struct sev_device *sev)
+static struct pci_tsm *tio_host_probe(struct pci_dev *pdev, struct sev_device *sev)
 {
 	struct tio_dsm *dsm __free(kfree) = kzalloc_obj(*dsm);
 	int rc;
@@ -213,7 +213,7 @@ static struct pci_tsm *tio_pf0_probe(struct pci_dev *pdev, struct sev_device *se
 	if (!dsm)
 		return NULL;
 
-	rc = pci_tsm_pf0_constructor(pdev, &dsm->tsm, sev->tsmdev);
+	rc = pci_tsm_host_constructor(pdev, &dsm->tsm, sev->tsmdev);
 	if (rc)
 		return NULL;
 
@@ -226,8 +226,8 @@ static struct pci_tsm *dsm_probe(struct tsm_dev *tsmdev, struct pci_dev *pdev)
 {
 	struct sev_device *sev = tsm_dev_to_sev(tsmdev);
 
-	if (is_pci_tsm_pf0(pdev))
-		return tio_pf0_probe(pdev, sev);
+	if (is_pci_tsm_host(pdev))
+		return tio_host_probe(pdev, sev);
 	return NULL;
 }
 
@@ -237,10 +237,10 @@ static void dsm_remove(struct pci_tsm *tsm)
 
 	pci_dbg(pdev, "TSM disabled\n");
 
-	if (is_pci_tsm_pf0(pdev)) {
+	if (is_pci_tsm_host(pdev)) {
 		struct tio_dsm *dsm = container_of(tsm, struct tio_dsm, tsm.base_tsm);
 
-		pci_tsm_pf0_destructor(&dsm->tsm);
+		pci_tsm_host_destructor(&dsm->tsm);
 		kfree(dsm);
 	}
 }
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..10c9c6696624 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -45,22 +45,22 @@ static inline bool has_tee(struct pci_dev *pdev)
 	return pdev->devcap & PCI_EXP_DEVCAP_TEE;
 }
 
-/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
-static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
+/* 'struct pci_tsm_host' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
+static struct pci_tsm_host *to_pci_tsm_host(struct pci_tsm *tsm)
 {
 	/*
 	 * All "link" TSM contexts reference the device that hosts the DSM
 	 * interface for a set of devices. Walk to the DSM device and cast its
-	 * ->tsm context to a 'struct pci_tsm_pf0 *'.
+	 * ->tsm context to a 'struct pci_tsm_host *'.
 	 */
-	struct pci_dev *pf0 = tsm->dsm_dev;
+	struct pci_dev *host = tsm->dsm_dev;
 
-	if (!is_pci_tsm_pf0(pf0) || !is_dsm(pf0)) {
+	if (!is_pci_tsm_host(host) || !is_dsm(host)) {
 		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
 		return NULL;
 	}
 
-	return container_of(pf0->tsm, struct pci_tsm_pf0, base_tsm);
+	return container_of(host->tsm, struct pci_tsm_host, base_tsm);
 }
 
 static void tsm_remove(struct pci_tsm *tsm)
@@ -186,7 +186,7 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
 static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 {
 	int rc;
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
 	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
 
@@ -197,10 +197,10 @@ static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 		return -ENXIO;
 
 	pdev->tsm = pci_tsm;
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
 
 	/* mutex_intr assumes connect() is always sysfs/user driven */
-	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
+	ACQUIRE(mutex_intr, lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
 
@@ -300,15 +300,15 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
 {
 	struct pci_tdi *tdi;
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 
 	lockdep_assert_held(&pci_tsm_rwsem);
 
 	if (!pdev->tsm)
 		return 0;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 
 	tdi = pdev->tsm->tdi;
 	if (!tdi)
@@ -341,7 +341,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_unbind);
  */
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tdi *tdi;
 
 	if (!kvm)
@@ -355,8 +355,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 	if (!is_link_tsm(pdev->tsm->tsm_dev))
 		return -ENXIO;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	guard(mutex)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	guard(mutex)(&tsm_host->lock);
 
 	/* Resolve races to bind a TDI */
 	if (pdev->tsm->tdi) {
@@ -404,7 +404,7 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code)
 {
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tdi *tdi;
 	int rc;
 
@@ -422,8 +422,8 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 	if (!is_link_tsm(pdev->tsm->tsm_dev))
 		return -ENXIO;
 
-	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	tsm_host = to_pci_tsm_host(pdev->tsm);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
 		return rc;
 
@@ -443,7 +443,7 @@ static void pci_tsm_unbind_all(struct pci_dev *pdev)
 
 static void __pci_tsm_disconnect(struct pci_dev *pdev)
 {
-	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	struct pci_tsm_host *tsm_host = to_pci_tsm_host(pdev->tsm);
 	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
 
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
@@ -455,7 +455,7 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
 	 */
-	guard(mutex)(&tsm_pf0->lock);
+	guard(mutex)(&tsm_host->lock);
 	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
 	ops->disconnect(pdev);
 }
@@ -494,7 +494,7 @@ static ssize_t bound_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm_host *tsm_host;
 	struct pci_tsm *tsm;
 	int rc;
 
@@ -505,9 +505,9 @@ static ssize_t bound_show(struct device *dev,
 	tsm = pdev->tsm;
 	if (!tsm)
 		return sysfs_emit(buf, "\n");
-	tsm_pf0 = to_pci_tsm_pf0(tsm);
+	tsm_host = to_pci_tsm_host(tsm);
 
-	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_host->lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
 		return rc;
 
@@ -547,7 +547,7 @@ static bool pci_tsm_link_group_visible(struct kobject *kobj)
 	if (!pci_is_pcie(pdev))
 		return false;
 
-	if (is_pci_tsm_pf0(pdev))
+	if (is_pci_tsm_host(pdev))
 		return true;
 
 	/*
@@ -572,14 +572,14 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 		struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
 		if (attr == &dev_attr_bound.attr) {
-			if (is_pci_tsm_pf0(pdev) && has_tee(pdev))
+			if (is_pci_tsm_host(pdev) && has_tee(pdev))
 				return attr->mode;
 			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
 				return attr->mode;
 		}
 
 		if (attr == &dev_attr_dsm.attr) {
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				return attr->mode;
 			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
 				return attr->mode;
@@ -587,7 +587,7 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 
 		if (attr == &dev_attr_connect.attr ||
 		    attr == &dev_attr_disconnect.attr) {
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				return attr->mode;
 		}
 	}
@@ -662,7 +662,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	struct device *grandparent;
 	struct pci_dev *uport;
 
-	if (is_pci_tsm_pf0(pdev))
+	if (is_pci_tsm_host(pdev))
 		return pdev;
 
 	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
@@ -735,13 +735,13 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
 
 /**
- * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
- * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
+ * pci_tsm_host_constructor() - common 'struct pci_tsm_host' (DSM) initialization
+ * @pdev: TSM host PCI device (as indicated by is_pci_tsm_host())
  * @tsm: context to initialize
  * @tsm_dev: Platform TEE Security Manager, initiator of security operations
  */
-int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
-			    struct tsm_dev *tsm_dev)
+int pci_tsm_host_constructor(struct pci_dev *pdev, struct pci_tsm_host *tsm,
+			     struct tsm_dev *tsm_dev)
 {
 	mutex_init(&tsm->lock);
 	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
@@ -753,13 +753,13 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 
 	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
 }
-EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
+EXPORT_SYMBOL_GPL(pci_tsm_host_constructor);
 
-void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
+void pci_tsm_host_destructor(struct pci_tsm_host *host_tsm)
 {
-	mutex_destroy(&pf0_tsm->lock);
+	mutex_destroy(&host_tsm->lock);
 }
-EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
+EXPORT_SYMBOL_GPL(pci_tsm_host_destructor);
 
 int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -780,7 +780,7 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	/* On first enable, update sysfs groups */
 	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
 		for_each_pci_dev(pdev)
-			if (is_pci_tsm_pf0(pdev))
+			if (is_pci_tsm_host(pdev))
 				link_sysfs_enable(pdev);
 	} else if (is_devsec_tsm(tsm_dev)) {
 		pci_tsm_devsec_count++;
@@ -815,7 +815,7 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	 * skipped if the device itself is being removed since sysfs goes away
 	 * naturally at that point
 	 */
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count)
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev) && !pci_tsm_link_count)
 		link_sysfs_disable(pdev);
 
 	/* Nothing else to do if this device never attached to the departing TSM */
@@ -828,7 +828,7 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	else if (tsm_dev != tsm->tsm_dev)
 		return;
 
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev))
 		pci_tsm_disconnect(pdev);
 	else
 		pci_tsm_fn_exit(pdev);
@@ -885,12 +885,12 @@ void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz)
 {
-	struct pci_tsm_pf0 *tsm;
+	struct pci_tsm_host *tsm;
 
-	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+	if (!pdev->tsm || !is_pci_tsm_host(pdev))
 		return -ENXIO;
 
-	tsm = to_pci_tsm_pf0(pdev->tsm);
+	tsm = to_pci_tsm_host(pdev->tsm);
 	if (!tsm->doe_mb)
 		return -ENXIO;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..950e2c36a4ca 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -40,7 +40,7 @@ struct pci_tsm_ops {
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
-	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 * pci_tsm_host::lock) as well as @probe and @remove of the subfunctions.
 	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
 	 * and the DSM lock.
 	 */
@@ -115,19 +115,23 @@ struct pci_tsm {
 };
 
 /**
- * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
+ * struct pci_tsm_host - TSM host link context (CMA, IDE, or TDISP)
  * @base_tsm: generic core "tsm" context
  * @lock: mutual exclustion for pci_tsm_ops invocation
  * @doe_mb: PCIe Data Object Exchange mailbox
+ *
+ * The host of a TSM link is the device that knows how to speak
+ * CMA, IDE, or TDISP. For TDISP / IDE that is a Physical Function 0.
+ * For CMA-only it is a CMA DOE mailbox.
  */
-struct pci_tsm_pf0 {
+struct pci_tsm_host {
 	struct pci_tsm base_tsm;
 	struct mutex lock;
 	struct pci_doe_mb *doe_mb;
 };
 
 /* physical function0 and capable of 'connect' */
-static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 {
 	if (!pdev)
 		return false;
@@ -204,9 +208,9 @@ int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
 int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
 			     struct tsm_dev *tsm_dev);
-int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
-			    struct tsm_dev *tsm_dev);
-void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+int pci_tsm_host_constructor(struct pci_dev *pdev, struct pci_tsm_host *tsm,
+			     struct tsm_dev *tsm_dev);
+void pci_tsm_host_destructor(struct pci_tsm_host *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
-- 
2.54.0

