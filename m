Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86437153BC5
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620274; cv=fail; b=IS9SaX3rXYbg4lyQQ+cDFZfvZPCY1kDu3IjT9AlY/+DcbFFl8OoPRXjFJJnou2XMDh94KDW/VNFv0dDHmVoqm6hnoao1YwYBEILVv3fsUZiePwSxWC38s+vSWt6FdOCNdqdQQJkhlbILZ/hmchdxekkWgdTpuGV2Mnfs1vZ/hcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620274; c=relaxed/simple;
	bh=dgVOso9WSg8R1dOwDjzyynSAnDyCUXPMooVOXgYtyJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SCfvtXBX8K/w5GQ1RO2XK6b0x0+SXc3vF8iW81v1x0lCDGPD+nv9ovyDTVO8WqorEu0luzSNtBQHjUJGMejjPioyQik0ERAE++vqRGPQoV3/HQNSci8lCgsCKiYfxVojy9XPs/8uCAhlgNVgOqSSiJK9zv+8/EpkJiNYgFDTyUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=F79klxUo; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=ejDOcE4D; arc=fail smtp.client-ip=216.71.153.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="F79klxUo";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="ejDOcE4D"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1708620271; x=1740156271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dgVOso9WSg8R1dOwDjzyynSAnDyCUXPMooVOXgYtyJM=;
  b=F79klxUopvhZ/K2iqf3KWAptl6C4DHdTjUjNznuQthfSfslpHrPezb7I
   n6iCjP8ZJz4WviBgSMyyOceYMdyk14Jm8INLsSTZQPqp6Gz51K2sQ6TvV
   0FATvkU5aHig9xVmybJQC+BvQTm62LeRz703NJoDpPSbCcO6tes4Z4tO7
   Q=;
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:44:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyK/v0gFq0I+DDY7N2LcZ+iNiS4Xv1ZFrWDqjhAQWpJZHKj4li0kP8aZgjhXY5iCLyBgK3zNcNcyuVTF7h0SW+1D2n7A2bnMN1sL06gt+fw+Eh26dWs9s3jpzxRqZk0dLfIEoSuvShPHvYcWAu1BmmBFj0zx/9SWsY3C4aZ8txLycOw/VNVSd9icy1UcqRYXSP3RJztibabof16+4ZLoO9mbBgAC/Rw45JOmdiEqF7TFdlKPaxHMtfP31APINCFh9kNMVvCvpqkMa3awKfnxpPWUqmAachzVVLQXBrgxwC1dkpkHDlCB1pvtipb4K+UiRxkoISj7Z7axGptzWJJVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHAr7CMzH+lNWmC/P0rPWXND74oy0SNj+YOd+lyBkyA=;
 b=nabLZD3DSixOoMW4LoUZZ8teuvujes/Oa1vYi9RCfFp8cYC2Jlvl61WbtGloGD2TUPTqEJ8ikw4FWRh3caKdgKxYbNvBFj20/zQcvUtPPJuctAqO+j0uqIUqbOT6RgyPo79hMb9iAPPu8UZp1NPb9+58yoxlVCEKIwgABmkiu91x5JH4bCVa7XaOD9ci2hwgmsUFP3EAo0IFHDtMVEE9Fj+p861gScN2rjr38luProY4QzHcWwInuugDqPx8Almd+6gz2lBX1a5KZvwMEEl9XRwD4xxEYBDNQggkY/S/o0ws2v1VW5w/qfs1qhiF08qI7mIzePJ1As/drFXtgUbaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHAr7CMzH+lNWmC/P0rPWXND74oy0SNj+YOd+lyBkyA=;
 b=ejDOcE4D2ZQo0n0XKXGljugkLymvxYnPZq7zGxThGmbdl+puU54qruhtWRYtBcLQi4sSBfhPGPUgAi4Ps9oy3FDGbolZTsg2OmP9Tj2dnOk6geMC+8q80Io1gwLiKJedkp7Ufb30qvyxA5g46Uus+hLtJItOAjJOxCdVb8q0IxA=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by LV8PR20MB7259.namprd20.prod.outlook.com (2603:10b6:408:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 16:44:29 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::f) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 16:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 16:44:28 +0000
Received: from lcopiesaa002.seagate.com ([10.230.120.53])
  by lcopzesaa001.seagate.com with ESMTP; 22 Feb 2024 08:49:10 -0800
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="98159405"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO ArcherCity-EMR-2.shk.minn.seagate.com) ([10.4.50.11])
  by lcopiesaa002.seagate.com with ESMTP; 22 Feb 2024 08:42:46 -0800
From: Hongjian Fan <hongjian.fan@seagate.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Hongjian Fan <hongjian.fan@seagate.com>
Subject: [PATCH] Defer dax when CXL window is the child of the soft reserve region
Date: Thu, 22 Feb 2024 15:06:12 -0600
Message-Id: <20240222210612.15689-1-hongjian.fan@seagate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR20MB7259:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39716248-9b70-4e8a-f9de-08dc33c58984
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7T3ce0M0rbyb7vw7jaO3hqoAR9dJLw02w/aJvLBv5oPVvFvGa+q29d61Jm7DE6C8dpLlevxBL/kMfIY/jRMDnh57L6CQ0lBo/loen4KVAQimrQmG7GLELcrDT2TpZeCndHRdcLDSlvuL3Ur+VZd+I2ZXBm27dpue3LM0jg/cV4l/HRihqRpYgZOsGDUz/1ktp73EwxCsE+CosLlh8T4rNY+VQN3JpFm/DbqOTWsDkNK60lC5X3shdz96eQMHWNQIzyEMjqcGO3Rm73N1RWZij6m4ifRkWPT5CvJ0g5XxRJGbWOWXMlwW9bvOuSnEiP5lC2chT39/82WthiDrZGKuXu2vJkcTGabFp5W2RH+nqaSLA2VFct96lupa0NXqULOUeQA80NE0w8176nFCMsxHFDqyYjq5vToh4rZTj89Wd0zswNxuWcXeumnm2r/03qLcnj+fY8kjlWtsuFWTxUHsHpf8BbvgnF63eBgMekba7wtaoDtBHiBaFnQjuuY6KQv6585jHREc+Pa1CSXZDyVKtd+vS9ZfmLm+TphMLIuNUEQ75qRuldtRw01+7buBFFpROLoCDA0xYKV8QyB20rwMAaIYT0N6OtDQiLpYut33lbIjGpPlbgp9/vVhvj1qZwyyVPHdrlQqWeCOE9/un4L0SOzdYL9KZb/l+D8pEI8cacY=
X-Forefront-Antispam-Report:
	CIP:134.204.222.52;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa001.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4VR8a/HLF824G1kF9xVMg5L+sw+VUcFLHJFU1utMWDGNUl4HQbagTruj1JdxexGWX8NpsJxD1yak3k8g9AAknm2RKX5STCYhR4sGnb3UkgUGq9JCqyuAsnSwI85WOgSXWVe7Mw0HkSO9whc4vMFrBoyGqyuFPCTF1/Xm54Y+JlXzGgT4192IaFeQo2HFqLIPvMGMLQ6tGkRG1B40RpsV8S0HL5GLgZ222w+xwbRnzc7BPDQKkHIGsodNyA+vO1TWm7flnuyAqCgM5S/xgcca+XvRp67eoimLV9n1lP77Vkvs/eUGQjDyzql/+q6zqjjHWzrUgY5lmTFezAtAyfNl4y/jyDqnLVjX4bPYWab6C/6Ne+CS28RQUStYtMfV/KKHAwLywFM8CgKLf2wBFohfJhTQZR0hV98/OakPIotCUDyYezT0iqCQPDG9tVua9Z9SnsSLJU48xbgKHFPDSlGSC7J+zDfjOoUVAEIX6RQUiWH4wBexbIdNSn/rFlZD8DeYIufl55eyjRIIycgiGaney6mr2ob0VQ39vm4m2LxmxTLxrPXoQZiCajF8DOOLAigcwiB0hIPiwR8raEoEaWzGeHXnIejHPAU17s5aKCjQYSNOABgR7JicEO8fSXUPpbUs
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:44:28.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39716248-9b70-4e8a-f9de-08dc33c58984
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.52];Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7259

On some platforms, UEFI would present a single soft reserved entry in BIOS-e820 for multiple CXL deivces. cxl_acpi would add the CXL windows as the children of the soft reserved region.
This change would allow proper deffering dax device creation to cxl region when CXL window is the child of the soft reserved region.


Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
---
 drivers/dax/hmem/hmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5d2ddef0f..a57b6ae09 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -58,6 +58,11 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+static int is_cxl_window(struct resource *res, void *arg)
+{
+	return 1;
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -67,8 +72,8 @@ static int hmem_register_device(struct device *host, int target_nid,
 	int rc;
 
 	if (IS_ENABLED(CONFIG_CXL_REGION) &&
-	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
-			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		walk_iomem_res_desc(IORES_DESC_CXL,IORESOURCE_MEM, res->start,
+		res->end, NULL, is_cxl_window)) {
 		dev_dbg(host, "deferring range to CXL: %pr\n", res);
 		return 0;
 	}
-- 
2.34.1

