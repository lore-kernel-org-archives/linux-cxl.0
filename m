Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C03A0E87
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946822; cv=fail; b=O1sVcOFXp94nKqa1ijY0wiTp0mgrNdXYL0JLsCdtZn51zdaKdaf/tPot+ywuinT86zpsRKUTzN7HHyaknLQ+6boFh5G88LmccequU/HT20uidPv0ctm34Pn9copEPLxZWb9nlo04SAHbFtu9sd1QX0yBEcz9ZIEYyN9QhrsIZls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946822; c=relaxed/simple;
	bh=7IKhLpFeWrwIDctLs7OBXx5WmcW5CI6R8v6D2i254sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9YXfY0VCADStaZawVJj+AjMiWKG5jbk8qaH8G25mV9wIMBuZiuBGAHpsnquB+6i1KphR6zYZg7mLec3CL5erxeCRH+gzlrei5SAOER8qehzD801Wys1uBx2bOejLIIPQYYWS0WwMvyBs/ov3FgKoqR4VT1T9o1+mADoY8xV4PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4mMoXJYD; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4mMoXJYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyE9z9dJj8pCMI47tD90+iFvW/CZiwKffQXB80PASgR8gEaBHxjpNNHYZsptxq4FLIJb8Ip5BOa2KbYQsKcfj3/WKYPMUcv032fta1Yyqc8jfXYpnikKIVmbLMw1wndxQAwRHrKPnY1zNbfKk98x6cce8plud+f+Rku0qHx1pjVNmsTsYinLtNzla8CYlP4L903X/6X3fjoHVqxZ7oKWWBMs0Z033plxTt8YDkCyMhhAlknHoDQxMIO+SDDDKRRp4qEkzBOmp7XEYWPWisna0e+xt2cQbrm/doiS7HkMoNi1JalpVIUOocw3wOxZQ9aKDIZsVYDCp2qHIBCr7upZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuJl9uSBJAofyZe/IQa9skXVGzfZeSYfI0u4tbOlITI=;
 b=fWibr6Cw7Bydr9pI+bnWlPHc+Sx6yE9Agv+6IKKciGoybj0KKB31hwq3Av+J1kWqgoYeBfDvMOeL62TmLiV5VEgdNGLKERyKRwDavCXCdw1zzNHP9oNDJVxPO3C7WSqxbvpPS7Zt8Stw8RW8yNNbl52WpDOfTiHJ4gwLAmRfFeQO7etm94NkcOIJ+MrxS6ip/f0RXeA5bS3i9OOjau0ORWeATxoMTtTkmxgGIjQ9c/Qm7S6fqr8Y5VAkuYJxUyhhJtZtooAvhH55bOgtB5sGEdRS0VQPTygv8bCMhkltkXV+19i/MF81ey09/Fh5uKDSCLR8XXWM7ZcRREB7/gQ/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuJl9uSBJAofyZe/IQa9skXVGzfZeSYfI0u4tbOlITI=;
 b=4mMoXJYD3RodmOYhnivEJEO1Yerwm3KS/E28A2kE7GGoQv0iYStJN8xdljYVSJEBfHRkSriDp6yKLqXfGy/g86yV9w4xO6ZS6k9CsklD8rPVidKRMtvgUnMwa1MymlI+4Wa5wvYfaAekZBxUrbb13nmAqcLZdP+ufFPomN3ooZ4=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:26:56 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::11) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 15:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 15:26:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:55 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 24 Feb 2026 09:26:55 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 2/3] cxl/region: Factor out interleave ways setup
Date: Tue, 24 Feb 2026 15:26:44 +0000
Message-ID: <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6598d42d-3b34-43c8-59c0-08de73b92523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YeRLdCoNcIxEOitPfDM7wle8iw67qr2SCYEDE7IBJU/7N3yd7Bf2Hl2FAc4?=
 =?us-ascii?Q?qqUhWgsS5upV9wjY+Xz5bzDutSv2RydP1ipxMophuHs0E7LE7SiI5raBRrdC?=
 =?us-ascii?Q?2Gi+20IWgSTc7CRviX629wtGEHbC/TcY0KPaze9BGUHgkXSY0TInXqxlRmeO?=
 =?us-ascii?Q?Vh5/Ap+awH3IBF5RlHSWN/gzTGAZjOy16+VY6LS6ptKNhNdbp0Hysv5265Ny?=
 =?us-ascii?Q?8KkZeFG13Us/gORnP0ZWXk97CRW0oHfnEbImV+p03JTN/Fl+JX5cU1HALqLe?=
 =?us-ascii?Q?hYVngibPQlmDGv3jfZ25IKPKWiiJc2l+GOeC1mkcLzwK5lvNpG/1VyJYm0dh?=
 =?us-ascii?Q?ywZmJmmawBa2SCCaJb/Xg5ipOI4J8eWx7fZxJJNk/PG1q5esk6eu3iQL3BZc?=
 =?us-ascii?Q?/hdlOIRXLJZuLOzlHI8xpf2j+IqZzfSwbrVWmi3rZ9jBMp7FrHUk+X/RM4ZS?=
 =?us-ascii?Q?PX7ZY/WWYu0SllnKl3p3mjMbPc6bZ9hHMYpOLIYDO86/MVTKaTEJl8wWO9h6?=
 =?us-ascii?Q?iKHkTdqoMdjihVpMawyatHGHPz5iTfSvb+vPgwDhdYmQA15CtcbovYNFFcD3?=
 =?us-ascii?Q?L8mgZvW2YiIWc9aVzOymHEaKxsvGZ2KpdKxLDO5cb4rv5lR1BuGMsI8Vqk2l?=
 =?us-ascii?Q?4ud2X2It4iBALPRWHyy/bJJeRe2CX+VEK+5xHhCEyZG/ROerr682/4deYK8y?=
 =?us-ascii?Q?HlfnHYJHXX12PQdikMc2KHBGb2WslEcVDAbtk4btEGthnl2U8TdfTMJ8O+sl?=
 =?us-ascii?Q?VOBNDUcZivuqfw6WzXDy74aoVpak2nsRdKv41pGJk+W8qJy/nLAF/1rw7qOg?=
 =?us-ascii?Q?yKy3tztaMFIi1T/V7VyBzEA/GheN3mK2w1k/uh0pzbH/jOL45qpw7kzdKtY6?=
 =?us-ascii?Q?e/OuucRyU05kk6ct1aR8dREgSfYCkqAmiYKnB9pRZ9If9O9lnhJFnBPw5dao?=
 =?us-ascii?Q?h91BdxpS3tHhN8ns1aQDCOi9DQ8fcUsyXKHvWpo88LBtnke3aJGiP4+jzbVe?=
 =?us-ascii?Q?/tRY1dP+pG3VnZhT8W1ku+RpVdSZKhbyxA/Sje1827V42niPP/Oa7VD7WV5/?=
 =?us-ascii?Q?kSQcydejkJ2X8ErteyeWNwu0CkzEGpJ1V99P9MUtZxgHh7F//mFXfgPouPKR?=
 =?us-ascii?Q?PEHWzcaHopwQepyzdQhMpiNLcPizLVcQMTexUu185Jy2xNCpsRnA51uZ+Nk8?=
 =?us-ascii?Q?jRjn+g8HmthaSQmyrvy+KC5kqSBxO49LE4qFgwKrrKCz550uIQL8MoI9i9KW?=
 =?us-ascii?Q?a6OhFmagj77AwJu9jeOJmFhVf38tiPQzJ9gku/s8VbNkn0XPMTRSf5mlTMuz?=
 =?us-ascii?Q?voGS1Pz0wkBkmpoyjed9ZPxmk8vrcptnaJ3UEbEEMwAU5WlLtipkVgyuRcmi?=
 =?us-ascii?Q?uCLnV/7EnUqCoW96F29L/kU8fSy40lPY41zvTesUHbrb+LPrYKL1jJSCRpCG?=
 =?us-ascii?Q?5bpLe+qbtvoVbSKmyaovX1Eha4t57erdMBsNI0gKe5bgd8h+3KNrg2Jr5+hf?=
 =?us-ascii?Q?nLxpBNnnqPovdHULh4hP3vwYgTaASTyOdHz/p/4qh/BGnJm4R4Ci0slUBHlD?=
 =?us-ascii?Q?soHFMG/kzz0pwhUISv0VdkPbORlTAPZih4bcMPzherVojYILcvJFXmnk090Q?=
 =?us-ascii?Q?kq2QJDAwfKNsyuRMbYtDPmLaxqUj4CxApfrn9Lik+zuegUFxYzGWM9KqtP7X?=
 =?us-ascii?Q?Hn0ouA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nkESLfBgTXDhK55EJybNgoZWZrT0zK160AAYaMy+gT8dHmrFgQ/56YkzXJE3JowGvXHTimZdpriLrDuMOPwrZ+zbMHZ1A7DYQQnoBj2ApPRAac/EKRh0FxXVC1sWlcngqkoqOiSqPUMqoyvnMgw4XrFDvBkooaC8PXbDukUkTmrvfBmzM9YawS7y84V/PreLX/mn1T+OS4mzPvoCFVHDtxlONYPZLFNHCH6tafm3DtY/OLn5PM9utdqhbjJkp9/LlWWNdfVzHC/g6gl12r451C+JEGFdKyddW47DUq0RwIAUw+gNpI1ZyAc/Rw0n80Fzcc3NGyrVgdKYYtrIx563/b9NtYUL+D8epOQ6G5FThCZ1ksLh8FHUIoWII5XnXIIhPYTUUI0Ss6yGmwCn5WmBnyJbtMQ84pTu5QDnBeXUp8XPNriSEQP0dI6UyZLb7TZJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:26:56.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598d42d-3b34-43c8-59c0-08de73b92523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cac33c99fe6a..3ef4ccf1c92b 100644
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
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
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

