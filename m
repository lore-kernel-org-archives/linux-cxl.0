Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017D3824FE
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300180; cv=fail; b=i0HGjma1cdOlXWZVMFpXa1Cx2W9RpwYLjUSW+b6ODZerSKhAhXzP40W4Xs89giPHX43yWetHQSwoaOgNvrBE1qUKPkCGvkL+mfLpcYlB0N9jFx6DWwl/RpW/SegLgMfZJrsGf74w3DyQ4VxOrE8H19YllZolnxbBau60L50WBKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300180; c=relaxed/simple;
	bh=lDpIl3PF/yWZYwQaKMfzpilCWQl+xXx9HJlzGUJyPAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIKO//LEpyQIj7pdJrQ3ONdPGIOByk1OjAImhvfuf8OXcRYotVK8I+zvo4iY94+Ph+A3DfJdyV5d1rHeHQCL8WuwzsJFBZElGrpZjU23aY60PMyzkax4rhy5utIqz/uJCBj48pG1GQ2qgOuSb4dWDLkHpNH5fIfTDx/uXYVeu5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8wlK02P; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8wlK02P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yksYLwOjYtJOXDOWVLH6KWp0+PRYCvS+fNVhSwuVrbi1nEhl4dUo3/j1NS7zaxvB2A19V+IDO46YPvYm624IGlWOIqXpmyNGe7sMPbBWplLSZ8w48aP4z8ieGWzZ2ahtMx/NJ8rESgzuwhk/Uf/XBlnuqGHpeK15fqxhRSnXtXpZ4GiKupdn+8I++t+5hXbkDA8dVzn5mH8N0aXWrrhN1KqABbHa4jfPCUsC6LFXO0oq/BLrzlW2308JeJtGOsbqo/6VsvhbSfCKRXd0FiT5iVrcv0vtLyxghU4bGu92anMhBNJlmtxMWouiJpdFZyBPHg/A72NIUdFWUg++uY1TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYhFqrRcxfLoXaYtCmr+FvsJ2xj0okhDJ+raHcOJ4Vg=;
 b=i9oyNVFIw1G4sQu2Iulmkzw3e43I117VpqdAHkQgBio5Z9TQTx97DjcKQp2U7djT0j45qamBNEKJX7XjBgbqEVv6IbM7UISb5+CgAiJF+snYQuCnYv810pF0OnmnA+oQENr8aGFr3dfmVGL1rqx7wHRy/q3PT2hraA+yG+GHHtAWApdgNSTyJWC/FRU/d9LE1zh7otCVCnxenF0z7yNu3ymN2Qj/X8F0ZWiw6U5prUyJJOnuvLePfy5YhuTojNkVaSMWXzbWQWiawyKBgYmLQNq45QAdilVeHaP/XMoerWF2itKtXb0zEtv08Sk2KJlndOA6+tuzXwWZ+9k384oypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYhFqrRcxfLoXaYtCmr+FvsJ2xj0okhDJ+raHcOJ4Vg=;
 b=l8wlK02PqkE9l37VR/s4hiaudu9E4R6ZqqsfYn77BJFhnJGVGyBHnGMgvpVI4heO+XR6t3IaNJSy/mOZQcjBQ//ZDaV+exr7ygCMb1woFqJklV6kvCewdcEPdSrYhjKp9syrcGc4ifwIS2RBB0xh3vEke4/e+64LveNNyi74fcs=
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 17:36:14 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f3) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Sat,
 28 Feb 2026 17:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:36:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:36:13 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:36:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>
Subject: [PATCH v3 2/3] cxl/region: Factor out interleave ways setup
Date: Sat, 28 Feb 2026 17:36:02 +0000
Message-ID: <20260228173603.1125109-3-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efb971b-6e87-4beb-b340-08de76efdee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	ezrV31hGPebhlF6BU8uia8VmAyMrUE2fVTx+MSmZO85BmmJSe5HeORJ+4A98ZMD4QoZiPxbYGMMsbDvE/SCDdX7t96JNXs/skNBTwwHCWrpNdDV3Scf8eTEuMiMEOz1Nnr2+HMngZd+WUvWNBDTLRuN8J1DE/Dhaxt/xTHngNypTctFKChZO5kacMgcjKAnv9oLXb0Ium84zEQChttlkxlYSTYGCQjPWvBqP0dgPpLB3Nl9g9MDWBHrS61atKexMssMot1Xi5M7It4XxpcJn34UEfua8zmGc7G1pxASRMPGfiG/+Z9rk1Yi4m2nymmPZZ8J1tWrm1RaNr4gm1gBhiQ3xjvGEg09vn6ST+uZkSsCJypy8NCA3TSMcWKmhXCa3az7yUyrS2Tt7X8kbzf668a/V5H/zHMyThoGWQ1jECY61lgy0gTlUAXJz7lQrKGXkrBmSnyxvvyDZvvqQd6x6mAsowgY/b4rV2pvIQ272UxVdMpuPJgn5lc2XvLKhE/f2WeC658mIutCre8pXdcmYFr8RAJvZl9pYtvKCC64GfklNKxr/kYzD5j9Dx0q/5sZP4KfGeXo2lnrxhaPAEDnHA654dLWD4/+dLUMsybEp12vOboI0bIQ//1BbQfgicYy/ebc/nVbHSKfhF6JQ6E4zO8BkSneKlV+zFwZcXEfYRDNgutOJGKe/4mgf82U788y0VNaIrsv4zzzBi/qQ0YI0GXFnBv/INMKp1HfoW9Au3Vum38Zfox/t0M+3so2YLH4U5iYDz7X6Fx/xWSVmZ60Xekc/kmnFnAlqkHQPp8DDLXiF8jLzDqkYkfYdtp/oSbpvNmMDSPkPO6q0e5W3OQGG9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cyQbJ0IkXVYl4dGxCj7WlqtdxSZM1LHFxMrnWHfa53AISn8Qu8kH78teDQY0AobQNhtRqkjESryMD3a4NevRKQauYRkkVC1wBfvn2n6a+cWSgE/IVyJ3JnhGSg0ys/WARECi0I/BQ2qiXSgdx3OGoe8Lp7FahK/lcuVEJ+oo9A1jSrfCmehvXrYPfPJF4ahpRqwzooswsLTr9c8hQ0/4bHkcCFqdtx1RjpFNTYaZUdwWG0s4kDqGjjO6gR31Yay7XNwG2FeTHU56vR0WplVwSiD3NlgC851WnxKVBgF7S+s887W5p1e6s9JK4Rx636bry/oDFFvDl1gRX7TEMwVRMd6nmbmHDUimT2K1jSqDM1V2oCp26lNBH/Syio9aT2gkDy+JsgZQteJ2Jdhhe2lK6vcuFNwfcgR5yzf0kfKAXj8Q4nJnHJM02RAUIqTKxaZw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:36:14.1251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efb971b-6e87-4beb-b340-08de76efdee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices can be triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cac33c99fe6a..01c358b3795f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int val;
+	int rc;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1

