Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FC3890FF
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611617; cv=none; b=d0sM9XbHQhYHPeRtPiXWhS36Ig2QDQvDrc92EV/FmdLaCWo/zFI4yfATnrO7vRGlv4cMGtZqsA08D0N6tV/WqnEy8ctMn6szQ4ZqdU1+gJA1BkRWRs7t8MapFzmh9PxH2L/WA0nshJ2Qc45kcGoXDtMuKanFJ0w3SqI3+j661N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611617; c=relaxed/simple;
	bh=gIVQIjL6KWNp/N7IGQCVodqKY+vMRD57PEUjkJG2F/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnJMPHusXr/DVIygMtwDe/kL0WltiaiCR6MCBQBQ/ppNcGGNK/H/G7BFFf8O0L8kYQnu+sNG2/jMJRuQNJYQKaCnmIi6Es4EftwrxaDO0ZvjurnNPn9CfQCVcZVDRAXsrRGcELKuKYhMVaDRgCtJynYS3/IS0/vo+6PcSlf9SoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=hHiJUJWz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="hHiJUJWz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81df6a302b1so7077425b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772611615; x=1773216415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6eoY4SiH0kcADzF/tE6vWrQnAgRLMu3ultuUPQsFDg=;
        b=hHiJUJWz0nENmn7ihAIfl3aKwG9aNu1tRJO/hWK71lZ96W1kuITNoRNpI+sFWHnxQr
         h36TVqi4GielPZbPJLxYJ9FHdn5bpUt0ly80967XZXW/8XMYPDU3pazNUqkbImf1lyDL
         YDBtYIv65LE6INFYnvcVFWEZ7GoSezmZkXcrClVkGy1asZAD+7Ek2R8vmfGw0V1U9aau
         wnI4Lh7cI+eveuSQfuF9Oh3Acmh5jsFIr8CaTz/FF91RQ1258t6/OFvbOP0y8oyMb4Nh
         9zr910FesIfnkZN58D7lXPQyQHkee84uuEZs3wpp7Mg+UaJh+SjkiqahS5GcXVrRgCmP
         pAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611615; x=1773216415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6eoY4SiH0kcADzF/tE6vWrQnAgRLMu3ultuUPQsFDg=;
        b=TJJi4bWOCrJgRq5kj5p3qKI3TcqfqIq7cwloNJ/fgdcF4w7Ojcr811fZ4SP621zHiT
         Pyzv2TsDReN3pszSLuT2t9UJYwYofMr6sml4I00iRAprM+5VrLrSraazps6eubwERVCl
         J5CAafYGQPdy9lWv7338N6j507Nj9q5h2tdufEtHLLiK9DGGPUKeEDjKNIqrswKxw7hF
         TMB6tUjTFN4d1CDFfPkRqoZyshWPGR8E90DN74ZrCPuUb4U5Dz57pkue4fqHxdUgRuxU
         NnZ7Ll2KQK2Lcwc53aYnbE83tNkJhd9JDOEJaz9Bjp4SN5QxJJ2PPoSNr90aH/jtO+e2
         8k1w==
X-Forwarded-Encrypted: i=1; AJvYcCUdB8it22eW46cyJwUY7bio30CmoU06KhM9OKWhpnRXY43B44JsxfCtS1q1Icx//PL/BwByPpXW/R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUE83iiwWkP0Efw/pQBNNWstptzcZT49QLLKT9LtsHfrmPPyvs
	l4sOodi1CvI56R/Jc3t53GB6xsBlun1H8UmUzMS+EJUVvJXVGLxVV3gOM7oddBAAUig=
X-Gm-Gg: ATEYQzxSAlW61++GpzCql/ZU2zp9MDsfRprzEkotWHktcn1p/Tr0GWhs61Ml27h1jtb
	uOGlzMde7auh6iTjc3FLu6m/UWzFpOQNuiK+PkoXEKnDechgKXIjwGy5/hpMwx2VVKLZS6uWifS
	JLqir5PyYEbSJn3otKGMqiPh3JLeth+tnutEbHmTJlnFjG/0hORl+NCk8BarQjdPlI3qNimd8SB
	mnjQ1gmBPUvrWJdMG0ZaRJrEAdILyT0mmd3aEtVMoskFQhqg1RrTOeDuJSxbycFf0jgAxc/o6Dl
	tWz0aOmLHz3FTW5vf1q+VIsT0ChcZTPt65tYoL1xXRf7oV2EO4XnxsMiJAvkZ5hxwDmrEjLx3L8
	h40Yz5GCf8B4LsdYNItmAJVfS/cbB53EIDXyXzuCpjrNa79HkiTL2QI5PLlNgsdUccUiaDRbHdb
	IXSqD3n26JRlNqqnLVSGaKmxqlbGwWrlEkMk/mxl7Ro/KEVUA=
X-Received: by 2002:a05:6a20:3d8b:b0:394:6159:1758 with SMTP id adf61e73a8af0-3982dd69b41mr1132055637.8.1772611615452;
        Wed, 04 Mar 2026 00:06:55 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54136b28sm76817775ad.73.2026.03.04.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:06:55 -0800 (PST)
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
Date: Wed,  4 Mar 2026 16:06:47 +0800
Message-ID: <20260304080647.169434-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
have memory and the rest nodes (2-19) detected by CEDT are memoryless.

The problems is that when creating many pods, the shrinker map size
needs to be expanded for all memory cgroups in expand_shrinker_info().
If the number of possible nodes is too large, the holding time of
shrinker lock grows significantly.

In this case, there is no CXL memory inserted in the machine, those
memoryless nodes are useless for us, so there is no need to set them
in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
time is reduced from over 10 minutes to approximately 150 seconds in
our internal test.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/mm/numa.c       |  2 ++
 drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
 include/acpi/acpi_numa.h |  6 ++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7a97327140df..b127bb65d360 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -37,6 +37,8 @@ static __init int numa_setup(char *opt)
 		disable_srat();
 	if (!strncmp(opt, "nohmat", 6))
 		disable_hmat();
+	if (!strncmp(opt, "nocfmws", 7))
+		disable_cfmws();
 	return 0;
 }
 early_param("numa", numa_setup);
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

