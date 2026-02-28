Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F736B600
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300181; cv=fail; b=D4H7D+jFHTKVGM7Gb0zAGust1S9V/7goLSxjU7bflIi0Xj+rked7hnQYfGJwTCqKQW2qnzzmCHTugWv2IOcnLf4/Jj7fRQpNs4pp6x7ECVjyDMKNWPaxKCRFhRgH8U/m5gkpK56e2p4GEeYaoXu6RrKUY+kzD3bUC6/SWzRC3og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300181; c=relaxed/simple;
	bh=ADI80cBBS51NCLKnYFG4ekj2x0blPywSbA8iYoH6Gy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRu6LD1DM7wjzmhuthMvvhgk2o/VqmMDjXmLSVFKtuul6RxsfxBnrfQE8r0WoCKxxBTJPYLmili6O380nT5Eyu/cnvleI7xFSfAIBo8QA1Zpa/x1o9G8EVvYTTHRzQpmLuDQKAfOcof5X0I9LoSlrsj9FF0smz3Sw0sIo2Y0LkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jJLY6A5N; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jJLY6A5N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMZZJBxLCABxNuVkV1xEi8nwVOUw9THqM6dsWu34Y1HkphQFmar2rfcCR/P8i1JOoBC+nnxwiBnMHzmn+jHHwsicvO2PEMgcVrFLm6XjMsz1/PW2uBbLRuyeVxCouDXzTUSvytHgm8yZpsYwzJX8FbG/UJyNBOGOsgdAyB0uVAr/gMFt6JrYZbQqzZ4uW/iru333BUaYklizodiMykLcN2awD+z5Hg0Zdvpz0Kbj8etH9DFeoz6uC+VcXgVe7qW6DYHhFqgvntzb259vvvaoSExPUZVEiw+7/CHE+5RIq1AEpDRIeW5qQrp4qQ5KgG/kr2dhHP/4JUuHHRLwKnW+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyO40IhebN4fBxOxuGIMwMRP9NpBW1HhCt+hO+WSe4A=;
 b=v/28Eg8D+gJYmMcaE5NCYZ7Id1T2o432rOCNqfccn8flwKOglHQ0Xiu2yO4ijp6kfzzYgUhChE3TXlb4z2nugH9y5URpkeZG+sGS0l68RJ6aMY4KwJwu/7RBYfpRZUQ6Y41CNDk9D5qmjFAfOfbrGLaz2lTvtSaXX43K9N/1NwLHJOaRjzWBOoDPUTUjJPwYBEsSnkYruoavGJZKqxjAyYjoOb4X3Vwog8D1MrijuOJrxjNS05MecrXPTosVSuQuYQWS+W0LYW5PAhEltZ8cELJHD1Tq17ZPwQPGDQYdB5I9p7lzPCauvD3e5iEBDTRMUGoOpM0HHNKWo1zNK3NwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyO40IhebN4fBxOxuGIMwMRP9NpBW1HhCt+hO+WSe4A=;
 b=jJLY6A5NDS5XPQIgG1zHKhZyG7xLUi5iHVfwtsekAJVp226Irrm773YFaleD94w4yMppJjcvsQ7O7WFoEcq4r6ygJzghKLTkqd2wvgp/2Zkv/dAjdEChpoMOas0dYgyP3CoRj2qqIGmAwGjJa4NynvuNPV3fTskUiLty0uvK3JI=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Sat, 28 Feb
 2026 17:36:15 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b8) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Sat,
 28 Feb 2026 17:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:36:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:36:14 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:36:13 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: [PATCH v3 3/3] cxl/region: Factor out interleave granularity setup
Date: Sat, 28 Feb 2026 17:36:03 +0000
Message-ID: <20260228173603.1125109-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
References: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: a246df59-1910-4e05-005f-08de76efdf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	J1WZKur2ZRbWlVH9kRBQj49PmMYCdkt7jhiu6I11RlqJJjAz8B/1C7cuSJw/8J91iB0WqL5/fkPc8xyklHfuz/tgD6eFbJUCr75kJHei+NjlOfu2RfjyNtSle5LTJtRLnqdga2beJUCRxN8ubcknGpRrW8+o/ZEMsNYnasGyoIzXHHZjmas1iU1pX2sN2Qhzgelm4aTsa19ayGyEz8b5Xx/odYO0EqKgcroLXMkTu4g3yqTDuiG4rZRwn5nOJIXM0a4fNVGtTZsFnqrdImoYSfrFxHwWLVl40angv1zN2e2yPbVuLrt5SpNVGmzanrQ3EhEsYHfIhR2Db95ofzRc9wdq6jOq2nh2I3CmcV6ZYdNHBqs6SyaLlUnEr7bR16ml5NL6JMc0ag78UxasGJAzEYeeVClG9NM5+mbpb2sG5wPypLm/Rq/ZBW3gkdpFutnm5to1m7iPu0V4Q3KLKEeRnATwF1MWMnBUTXdcvupxpgz0gvHU2w/TOStuVPXvYWuE91V2EN+SavgUTmldFWkaZxgF76ZKXdlqLFCJNrZ/as3uIrXFWpanzaPcka1pHk1ljN/FcQoSEQ+Y9KIqL8dE24gj4BRP1efR+Z86VfhIw73Zi/JbXZpQaL9h0lBQzTX5qW/joLnh1FTEo4WidKeaO1FKf42UNNDCDZECfzo/MWJHTKx0srLafsFhazNl1awH5VWcYzENQAJm5G9mfPF9+/RJyqdPRUQKDCXmpiYQams7FYGca6J9fMn+O56YxlHWFrn5VW2X6K146D8JRD6l1ji1oBwB25pAvKHgUud80wy2tDUCksKbQXxwWvjUogpNKPEJ4RcjRysE6Cv+GLsNiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9DISaH/Nqr9LaISZTSkRs7Q36dzgzrDmsMIUqWkg6n4mpjLVGtEP5B0dPmq9KdA2Q8S7T48+obxM13mBUjyiUDMWdVgdJso+kYvEFsyI92wxj8iJwZ7BMLGGJKotZ/u+URic85yD9aiwwHLqVyZ+f+8SajeZCXg806iOeIc3aOtv/mUnimYe/xDmm33lV82ICmDzO3r3BllvnuVCvp9x5tRrv9u9PyqkTcvG8XTvabOxZpjVDkurdr7Lsor02Tg1+kjVqQ30THX4SsiIJ4yeL31U5nBYu8yKZSRUjkfVuPchI0uTorurA/eOBkDEh5k199NpFBe62MSOYTAHhe6NBQ4LlJRtQUSUvPgej0fq4d8PQ6itZihk7Rz7Az8o6FExZJdOllq2CplzN8fvBJTCYoByUhwF6L3CrJRQTp6UfA9zDYJaSwr2G52Qp7nVc8lp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:36:15.1015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a246df59-1910-4e05-005f-08de76efdf82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices can be triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 01c358b3795f..4d3baa760d9e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,21 +559,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -589,14 +582,33 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1

