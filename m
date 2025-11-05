Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B9265630
	for <linux-cxl@vger.kernel.org>; Wed,  5 Nov 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381568; cv=none; b=ioPhjMz9xFS2gDpjDscJ+EXtpSgrDFMDS6s9Me1HOqhj5GA0CiqMNhAiijkk7dePljZyByyXZZDPZAHx4meA5O0C94pHW38jl0et4SYTrgVaUbTzTPTW7epmp8MF3PLrN7oTFhH8p+U5v+ya3KyJzkmcer78uCPE3vGAFwnxEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381568; c=relaxed/simple;
	bh=fb292zlEezfUJ98xZheff1VZ14Z92RUCuFi12mvIEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0cMjo4EWh1Kf1/4nuZcw3rZ530hxVS94Sl2Fe4ShRfshEfnHP5DGJR+F9SGZrCRXBvy0EFBLxeCUPW2a7I/0glD5gAduVrXPLm8/Oi6HYiN6YcmSU8LzKS98tJ06clUyrcmOxlZO8AtLwLYrc9w8VzBME42Vw3f7ZY+fcUiQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=F0y7+4sY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="F0y7+4sY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed72cc09ddso1517391cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 05 Nov 2025 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762381564; x=1762986364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPJXVCzpkSpBdBb83PCDJUzRglYtIsatm0yX8U+Anzo=;
        b=F0y7+4sY7E0va3BoJv99e5X9wOsJxNzUOcI9EEBo0vrXOd+4KSgP1gsoXOCPgJQ1ae
         /zxmT8tkWEX6EOfXKtHMODP0Y1r4yUxwMgnM8A1VZ6/jw4puM2gEAn+ryxXERJlYY4mm
         4KwfIEJTI5OvUBpsI/YuxqpvSrluBpdokhpPsq4hnwMm94uoVdnXSwpXM+RDcra0Yu60
         cUMmFJ+EUKQAl4eV1acxdiFh0K6w4pwQFd3Qhh8tJ8t/z6Ju6Ni1rCDy6HxJ2PFxjDjq
         Tm2m4uSwLEGEZCBWIjnQRjr2o6sOHardn7C+cETrp7rzKOFMsm9vN6z1+JatlTBql+Hp
         qk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381564; x=1762986364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPJXVCzpkSpBdBb83PCDJUzRglYtIsatm0yX8U+Anzo=;
        b=c+w05WDvAutlIWXq3a5EtbzO/pt6cpwKsP8Tcuj7SETWatC0EKrWw8jCzQansr9che
         KFYkXta/UP7m8uLpqrP6xnr0yHabH9BXgbiHgBy35GZz9wkaW4/YZ3ljxAqvtl+/YUTK
         9gMGkglutjI+aw2aPpa5wJzIchc0G04DOyR5NY0xH0zSTfDLNsULHFFMnl4ZbJ6giddZ
         tgsG1xnL40fqHxxV5mIT6yX8fUsgFb8ZHk59gHvrfogaBEzJj8sbe1/yzbf9yD8eRg5O
         7W4P6bXlwXI10+Yw1vG1eJkKESR8jb/iYFkstmQtleWoXOZc7Yp4F7I+kS0QXZd/MInP
         9oTg==
X-Forwarded-Encrypted: i=1; AJvYcCWlm/CEWYroCjw1y6YdRJuxJMh5hhJC9eI4vtRHigDGOGzG9NRJjNjvh5GtODf5qe1jr1ofKD9KjtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZZNmuQtSaXtm7S7W1Ka/u7cmIYTcKEX64km5E/NYf9v6lTGh
	nKGAo4wmdPOyxwRl3fjfMnYgWjPIgkWKVEGowL5Y/TOe+2AuI6k+bS/dOLEQzwcFoZM=
X-Gm-Gg: ASbGnct8wy6Fxe5f6K3wEGJvYIaV5YdvY8IVncYQd1TJs//i+LIDTcgKCHOnTNFx+z6
	TNxyDyRbVgPi7yy2J+/Z+vgu+BeqUCORPrHEzCactt3zzfO2EA9pQVIoii+vz0LATfXmd6637ih
	ZK0DbNKX5+8greaDYsIl2SSeGsoUO4lhu0AMZeQ9paVdUc6XRN9AR34/HC3iE+zWLsZ0nVRmUPR
	eVAG1w/YY97uksct5inEAuIQgDl1HFmvDClcGAtyukcrwrDHNCFONnySCUjeCPZ0N/okqH7FrkK
	ZrOvtGocMx7akXchRpq+6UfMPox5tWeMpO5t/Ar2Zjhym4pIp+jVTgvESpg6Vyjb+3kgftPlNQC
	4BEy7D+iHjDur/lhj6HxbANUeQcwUBQY+ivGPBJPReitX0qyvrn/rnaSaNQ/ah1hqVqV2UC22Xc
	sfHFA3Hvwq7Z+19XojWiz1D1+cqZwMbbXBaObkWE9mOtxvgNsCDDCw8Z1TFEU=
X-Google-Smtp-Source: AGHT+IGKAyeJ9TLov73WaqTicHNOCiHYLdqb1f+w5zGiAKDCTJ0LO7K9L9cNEmuqoRqNds35jwnbgA==
X-Received: by 2002:a05:622a:d0a:b0:4ed:7f5a:c6d8 with SMTP id d75a77b69052e-4ed7f5ad803mr24070971cf.41.1762381564451;
        Wed, 05 Nov 2025 14:26:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828f5b32sm6116936d6.16.2025.11.05.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:26:03 -0800 (PST)
Date: Wed, 5 Nov 2025 17:26:01 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> > 
> > [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> > [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> > 
> > Probe order issue when CXL drivers are built-in maybe?
> > 
> 

moving it back but leaving the function seemed to work for me, i don't
know what the implication of this is though (i.e. it's unclear to me
why you moved it from point a to point b in the first place).

(only tested this on QEMU)
---

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index ff6add88b6ae..2caa90fa4bf2 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -12,8 +12,10 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o

 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
+cxl_pci-y := pci.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 2937d0ddcce2..fa1d4aed28b9 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -21,4 +21,3 @@ cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
 cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
-cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a7a0838c8f23..7c287b4fa699 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -223,13 +223,4 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif

-#ifdef CONFIG_CXL_PCI
-bool cxl_pci_drv_bound(struct pci_dev *pdev);
-int cxl_pci_driver_init(void);
-void cxl_pci_driver_exit(void);
-#else
-static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
-static inline int cxl_pci_driver_init(void) { return 0; }
-static inline void cxl_pci_driver_exit(void) { }
-#endif
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d19ebf052d76..ca02ad58fc57 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2520,8 +2520,6 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;

-	cxl_pci_driver_init();
-
 	return 0;

 err_ras:
@@ -2537,7 +2535,6 @@ static __init int cxl_core_init(void)

 static void cxl_core_exit(void)
 {
-	cxl_pci_driver_exit();
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 97e6c187e048..a2660d64c6eb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -941,4 +941,10 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
 #endif

+#ifdef CONFIG_CXL_PCI
+bool cxl_pci_drv_bound(struct pci_dev *pdev);
+#else
+static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
+#endif
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/pci.c
similarity index 99%
rename from drivers/cxl/core/pci_drv.c
rename to drivers/cxl/pci.c
index bc3c959f7eb6..e6d741e15ac2 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/pci.c
@@ -1189,7 +1189,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);

-int __init cxl_pci_driver_init(void)
+static int __init cxl_pci_driver_init(void)
 {
 	int rc;

@@ -1204,9 +1204,15 @@ int __init cxl_pci_driver_init(void)
 	return rc;
 }

-void cxl_pci_driver_exit(void)
+static void cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
+MODULE_DESCRIPTION("CXL: PCI manageability");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");
