Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC01E542;
	Mon, 17 Jun 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654726; cv=fail; b=V7fvOXUiWxNDLJQB01bWGFWDbAMNOqFwK74a2mM0UJ1IFo2Vgha8nV9k1NVfUQKeLIUY3wLQyN1LcGmV2kYz3tCQwmNrCICzyNkwrvIJ0oan6QndqhLlaspQhz+kfaNVeqgvRbBuMjIwhJTNn7sDc6JdgGAjqews4sfKpaVWhbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654726; c=relaxed/simple;
	bh=CyIysawuifkYpDi6xy6GdfbMN7O++SqYG6o5mN44n6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEa6MlUaznO44ZNLjIWPPwCCjJ/YUwgPn9d2YMM8WHmlhPOTsSi/Hit1MP6fzah0OzhV5xKZbYpEH3gmpAGcAF3UPgPFUjvhRaeqqivf4UqyItmsfBzAt5LyHPyvEChOv5vOFvw6N/44Agw6OS7SHmCokelWG15jnRjMs2OFxO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=klCr5T+Z; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="klCr5T+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqcM6spnx2UOvuKzfvPFeRGrJgxD0imo3ktsyd9FYTd1kQYw7Qz+48hvWKm1S5PCkCSVnMOGi6lsujPb/Wm4t3GcycoYQ2WEN/VTg1MMmDfC1asGuPfkPxl/EoEYD0Fbor5PBQ7PHHqD8veZHNA7rx7m915vt5EnG7JH14SjuuAVHgrZcfh27EWon9lyExFS6JLuV+lvXk75SqyJlE99s1SSJKhhoa2fRRGzfuEEmUDC5jJb5tpQLWeRLhhM2+/1KSI5HbsMqETVXDYJONPIu4QzHwypxzfE0YVAiPREl4l2z45htaxwmlxt/680yVJ1/Qqojnj/CCxyndvztv5u+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBXM8oohfM7lGqcdJlam74a7SPVH+VPxP7kMXhf228I=;
 b=Sl+pYCwOr+o+Qb6PQVb0Ymxl0RB7OBavzorOZ+VJXCMtK601Evwh43HnuD+KVhQ4U/aAWGMrpl7fIUdS3jm5dw0znltCJWmhCqAOSiTlfbsEX+KhzUyP1VNuVbtTfe9/QZoKy2U+4LiBzC7IArGsihtyAtP/LmVEMxxpV5AsxZQ4/QVHe33HKj+BR8B5j9jSobgSMh4roaEzAp1uzFA/tBPT4lJQbDjJvh98J59OLHb6VVv/4mDvoVgFbF+X/hNjAR+a/5QGXqM0aWmWl+/t82VBf3Q63NdJg9PVBITcaXY7Y/AG8CBh5EOydPRZyiiU55X0e3S4KbVkM0Ubq9+SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBXM8oohfM7lGqcdJlam74a7SPVH+VPxP7kMXhf228I=;
 b=klCr5T+ZniXYRXsTCmzKTIjPQSE/beB5FyK6smzCMO4qwqMXVwbni+eXuZpQdnQictszg8h8gRe5oaf1dy+AS/vDXSElCXZgqY8fPi33xJuodBT/XKoftBliV/S51afQAFX5sP9jDsWSGZdencD+gAjJ3g87OUsd+Ug0XNyHiFY=
Received: from BYAPR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:40::43)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:05:21 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::50) by BYAPR04CA0030.outlook.office365.com
 (2603:10b6:a03:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:05:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:05:18 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 5/9] cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
Date: Mon, 17 Jun 2024 15:04:07 -0500
Message-ID: <20240617200411.1426554-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 01df0e58-23b7-416e-29ce-08dc8f08d144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbKvEtC0pHNxShxFgcp3D//9P+WLxElhL2kqLrbWw45q83PlbOl0cVir48O2?=
 =?us-ascii?Q?YDppasMV1+eNBIv0pQedjL8uCYpZHfcEF491vRMLp3jYWr5c8HgEdJcvipTq?=
 =?us-ascii?Q?BVz+JYVQGV/j1gY6pjuVXKjVUXJzb6xSmkH0SWh10OU3gyWPkmfVKISisZyw?=
 =?us-ascii?Q?cY7z48Ttqm8pOD6azLK0WPHen4mlPURV0Ku+wBZQndROAVOma2rLaDAoBtGk?=
 =?us-ascii?Q?lq0masF6Z/Md6KR0GMEtA5aW6c7EVkuq5zMiDkuAt81jbihmoWeOz9NIgs7Y?=
 =?us-ascii?Q?9X4VB5cr5o2/KQ65SpRIrkVAgASnYs8OILslo/BHiHLv1efo+OK0FCSApE+3?=
 =?us-ascii?Q?fzoMVrUaS7hX1AvQFb5jxXiGI+/LsZeJPwoFbq55VcTQTYToxzEnBMsbpBT0?=
 =?us-ascii?Q?swU/SsMR45QuU2F5xW0a5oIdRy+u6YfPE+7EkacozAKbzg5QZFJks4eRlEzz?=
 =?us-ascii?Q?DO9Q4UVUFvta3JWcfzoIPsHHi5woQhnORFXOfWAt4UEHOUun/cI+K/lrqMDU?=
 =?us-ascii?Q?siriVozfMuC6Nnh4HkGBZ5l8xDdEyjBC+AYyYrZcTjRuYx1RaDlVpiaFWyjW?=
 =?us-ascii?Q?o12T1hMDk0S3x3iOdo9454XxWkWjR8DvH6akhwyzgRFmC9KDdMUnPUqMIMKA?=
 =?us-ascii?Q?H+Ox3Dv32RRz282mZJv9AGb3eBhfyWBbyb6YU5l5beyBiMi5XxEU9L56y8Y2?=
 =?us-ascii?Q?qEysY5GEdR4ealSp4L+DskAkw9XxrMwQm7Ky92d7K43Qisydo2HNcFCK0Bq1?=
 =?us-ascii?Q?XacGupbajm/on16JZ0RyWShVuFBjIc1eyAfNIn31/AWjmEq7jNhf9hYHQQPf?=
 =?us-ascii?Q?cqsDl4NhlWV2DFRE46BRq0egAoQaym9I15G3TUV6dHp4kZ6gwfma1iYVB6BB?=
 =?us-ascii?Q?s/DYjBSw7bZD0QD4lYUYILPX910XOut7+qR/r8Z1o3m0hxF1iAeb0QHXHyNw?=
 =?us-ascii?Q?duxuPqAIZ8rUc5+xgjADXHG6x9LN/fFAS7mFwOJFHL97qf3REknl6vZOhuMf?=
 =?us-ascii?Q?N8O66m34gchF8njP6RjGlTwqkjB57Ex6tFzHMblpC3FRsD9mo5qXRPMPjGgx?=
 =?us-ascii?Q?e2AXgG6DqAPXkSvTMJH84zIMCEX9Sjchpb4Ecgc8hXItK43tGaAlmxpOTk8O?=
 =?us-ascii?Q?csVl/XV43Xo23yYjQBkwM1canS4leKo32Ap3H4IHumqap/M5xYT/dc/c+d0+?=
 =?us-ascii?Q?qsd4+IZr9tSniAxmrWMDLhRWLKQ2KlPZdZrcjoDwDyf/tTsemb4X/WmSwy0O?=
 =?us-ascii?Q?OUynMg2JwHA4B5nZcFMT4NB0dPG95z+5roNemdMwGdONMMwkp+N1GJszFGPA?=
 =?us-ascii?Q?HSce5SSv0tVldIqTpO5fKIoQQ/n6ZxeLkrUmh/pKlbfVdXv6rkkOiPNjsm/x?=
 =?us-ascii?Q?fAP4HAYCeW30imYjP0zT8zFO2D0hv9BJn1WCXxy9ffqWhnnjUkm8U0cyUXVJ?=
 =?us-ascii?Q?D8kYvPkMJlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:05:21.1464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df0e58-23b7-416e-29ce-08dc8f08d144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

CXL RAS error handling includes support for endpoints and RCH downstream
ports. The same support is missing for CXL root ports, CXL downstream
switch ports, and CXL upstream switch ports. This patch is in preparation
for adding CXL ports' RAS handling.

The cxl_pci driver's RAS support functions use the 'struct cxl_dev_state'
type parameter that is not available in CXL port devices. The same CXL
RAS capability structure is required for most CXL components/devices
and should have common handling where possible.[1]

Update __cxl_handle_cor_ras() and __cxl_handle_ras() to use 'struct
device' instead of 'struct cxl_dev_state'. Add function call to translate
device to CXL device state where needed.

[1] CXL3.1 - 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e6c91b3dfccf..59a317ab84bb 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -686,9 +686,10 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	void __iomem *addr;
 	u32 status;
 
@@ -699,13 +700,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(cxlmd, status);
 	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -729,9 +730,10 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev,
+			     void __iomem *ras_base)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
@@ -757,7 +759,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -765,7 +767,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -871,13 +873,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 /*
-- 
2.34.1

