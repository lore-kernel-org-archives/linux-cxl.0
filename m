Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180CB3537DC
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606778; cv=none; b=RUHkvTtIuTdAD2TSLgV0DHIzlSFNiXFjmqJK4IBAs1tdkAV4AyhQkL3V40NzpTVF4nJnigo0MX2q1xya0A6HmmcZzqpPc70hdB/WDM9pEkd/M+EELdBz8WbS/UxA+HfhXOR+1jtS4EsJePiH05pciMROj5hbdJ4vT7wmmAkx/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606778; c=relaxed/simple;
	bh=90PkZYD19lIg3ECOOq8+KKd7Im1dAaENxC3zu6J0m2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiTW4DbF9fpDkwBoZ1emQpGS4lgpH7PEaoytVpoLupDnPGr5gq2Lj1xg7hD4h5fFZ78GTn9EYqpvedn5ihhHZNWvpzQio8ZL2PZY1iwv3Lj3nKE2eE4X+ijmvsgDhYnIPGimLm6AJORFt7wOlaKa35TqfVhwbp7y5qOXEVhXlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=dK6t79vm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="dK6t79vm"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70378ddaafso4294977a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 03 Mar 2026 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772606775; x=1773211575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjM1BsJwmjPeoyTCC5ziuKUW/44MzOrvs53qVh9C1CQ=;
        b=dK6t79vmf90CZiXRVc228XoY4wt1DwXSySBOfVuSFo9xpVvW4UIEwuUi81RouSkGI5
         lPvf01oQlAWLWV5qwbeJCHq+NIInyKgEnpxPa3l66al2X1FUMLhAxTqeeoIJRomwU3Kf
         CS3Z/RAJmk4LsUDjO68lIRUK3zYhPNgsDs7uDyGMfjCU6GeROnFtU1rkuIikzXyLMPLK
         yZWCWJD6JZv7zL9bnkd4VfKgbWC30c0aXNCTuqpW4zgtyw8JVP6eZ9d8JcdDXuAFhx8Z
         HsIkd0NRJSkfEMN2gTYX3iGoUU0xA/TH3ifqOzs2R4XMfRqUhUyNHwXy9h/k3g2JnQOg
         Vh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606775; x=1773211575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjM1BsJwmjPeoyTCC5ziuKUW/44MzOrvs53qVh9C1CQ=;
        b=bUVBvbWB4DSlOBzkJaEW6yKAf4AkuT27ERp7jC8BYlRGlSD5IXNlD4K2vRWxhhrhfS
         /7EXAxpq3wNes++SWATCOxth7qK/jyqbNL4Yo41RU8U9RE4Vd/IDNrj0yUIcxtfg4F3W
         GOSBBPDssRiHFyd87IA4+z4lxPquZKQ8gKZZkW2aGi8++t8XWSZdIJnVaGyw6jJwwUXU
         y5ud1HaOiqYmr6agE79YkE5t7Epb+3z5b01lzeFdS9fEmU7k2BbR4ol/GluuViJ2qbwq
         UoT8sWMMDH1lFeInn9D8jhduS4wPGDQQagyL+vQ+kDWifMhmE21gIee58Z9SaAsmtNeI
         49ag==
X-Forwarded-Encrypted: i=1; AJvYcCXnye3RgxZva44y5RDtDezrmZL0Tn5FFJ7KLtaOygYJAcBtxw6E3ioCPyIlhL82fwI3Xwbti4CH6+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1kwiu5KkYjss/z7pJgj8w3W2ClfDE4ZeecLi8sztuFcEPy9V
	A6JdZnVAoaIcV9HoTCPLlnvmyBRnfDOdWJRQQX8EMd6Us+ZM8q84WPpF/tRxeFIfubU=
X-Gm-Gg: ATEYQzz7TnRZosdsF6kJkHP8TYWRGyOdzQgQHp/rXsXvEoOurni1EGfmglquh2ZB0If
	INfzLWhQ2ZLMMdjP0lBc1oLFgrgPth2kxkFOBXb7t2+aoTx0G05lWo7KuCbhLGD6eOhXMAg0Sxk
	Xisc85yz8Sw9gUZIK4qo/aUV2Ozv3AxTUrNUmIwAUudOZMxjwMy+SFPXgTRQIy/y2SSKKdI4FEf
	vEC6Kd3bg+ylzrBfPfjBlyZfWH+t5Rfvcj0hKk0f1Vmnkde2nto7RBQ8AZKeox2ilkJFYmBZa1t
	H27iwLDJGbHcGrNzEYV3FaA18IKx2eJ2F9Pn+M6M7bcW3rR8Mafqvyij5OsXCk+CZVUXQyIyXN+
	rDEEB/K7jiQCK5Wp9Un32wl9xf6WAGOchvl+VjXUI4R34+0rX6q+RaFMFRHLRJSVF+Wol9HOvxO
	rtws6lmj202URJmd+4sa158m1EnE+fT8MRe3BC
X-Received: by 2002:a17:902:cccf:b0:2ad:4265:bfab with SMTP id d9443c01a7336-2ae6a9ece4amr10630755ad.5.1772606775452;
        Tue, 03 Mar 2026 22:46:15 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4b9ac021sm87248085ad.86.2026.03.03.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:46:15 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com
Cc: dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
Date: Wed,  4 Mar 2026 14:46:09 +0800
Message-ID: <20260304064609.75585-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
the possible node is 20 (0-19). However, only two numa nodes (0-1)
have memory and the rest (2-19) nodes detected by CEDT is memoryless.

The problems is that when creating many pods, the shrinker map size
need to be expanded for all memory cgroups in expand_shrinker_info().
If the number of possibles nodes is too large, the holding time of
shrinker lock grows significantly.

In this case, there is no CXL memory inserted in the machine, those
memoryless nodes are useless for us, so there is no need set them to
'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
time is reduced from over 10 minutes to approximately 150 seconds in
our intertel test.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
 include/acpi/acpi_numa.h |  6 ++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index aa87ee1583a4..8716d70043fe 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -31,6 +31,7 @@ static int node_to_pxm_map[MAX_NUMNODES]
 
 unsigned char acpi_srat_revision __initdata;
 static int acpi_numa __initdata;
+static int cfmws_numa __initdata;
 
 static int last_real_pxm;
 
@@ -39,6 +40,12 @@ void __init disable_srat(void)
 	acpi_numa = -1;
 }
 
+void __init disable_cfmws(void)
+{
+	cfmws_numa = -1;
+}
+
+
 int pxm_to_node(int pxm)
 {
 	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
@@ -313,6 +320,12 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+int __init cfmws_disabled(void)
+{
+	return cfmws_numa < 0;
+}
+
+
 __weak int __init numa_fill_memblks(u64 start, u64 end)
 {
 	return NUMA_NO_MEMBLK;
@@ -648,14 +661,16 @@ int __init acpi_numa_init(void)
 	 */
 
 	/* fake_pxm is the next unused PXM value after SRAT parsing */
-	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
-		if (node_to_pxm_map[i] > fake_pxm)
-			fake_pxm = node_to_pxm_map[i];
+	if (!cfmws_disabled()) {
+		for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
+			if (node_to_pxm_map[i] > fake_pxm)
+				fake_pxm = node_to_pxm_map[i];
+		}
+		last_real_pxm = fake_pxm;
+		fake_pxm++;
+		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
+				      &fake_pxm);
 	}
-	last_real_pxm = fake_pxm;
-	fake_pxm++;
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-			      &fake_pxm);
 
 	if (cnt < 0)
 		return cnt;
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 99b960bd473c..2435f60e56ce 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -21,6 +21,7 @@ extern int fix_pxm_node_maps(int max_nid);
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
+extern void disable_cfmws(void);
 
 #else				/* CONFIG_ACPI_NUMA */
 static inline int fix_pxm_node_maps(int max_nid)
@@ -30,6 +31,11 @@ static inline int fix_pxm_node_maps(int max_nid)
 static inline void disable_srat(void)
 {
 }
+
+static inline void disable_cfmws(void)
+{
+}
+
 static inline int pxm_to_node(int pxm)
 {
 	return 0;
-- 
2.43.0

