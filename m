Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971912E3AEE;
	Tue, 15 Jul 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606790; cv=fail; b=lG1IAVCEh08LDRtfihCIP/HFyBEre5s3X0OazcDSCT2ZK/QGSrJoFFzi42KBt+qFiZuci7mw/vf1UGCE9/MCQreB0nrtyvTPnUgPIZuFlqelbBIkIhyPOwYMavZS6v/DmVLjzn0C50zeNWLbK50/waVZxm18ANc+bYHJpQA8WKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606790; c=relaxed/simple;
	bh=VJlAn/M0tH8MCKLqStYcD55P1XWIFtP7ArAMCyOYr2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPDt/9HHCg0tcoSeurexC57uy2G0j3B2GWWzY2SdfLXn6EyvA2amMil/Anwc55Yd3cL05R6aH8r663oBRhSNDr6fewbuSwPV6PJhTjGUbxtnO7UZaRgN0Awu2U9cVh6RpQsURi3LzeR6mFa+rEG+AkKGjiY3l9yvoevqdR8YOD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eULrF5qM; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eULrF5qM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3x4wjp2D9XNXvYzS/Y/PIRZTCz/Htapti2GwqS+WHEK1b9cc5qKc45Fi7GO+JKG3m5FFXY4vnvqhoOmBjdJSqn9UJmtjegysGulpT1l6uIk08SslAiRY7XzNNKCxmIlRnKPdyJeHPWTB5GDcMfjyEOHn4nEL7dpgWs99GlEL5B554i8P7w7xbjUjAeilBhnRfq2rxYzQZZNhNeV7Hql8qL2AA0/HgwFJNAXgpwy5zH25+WuERog9fuoV3LOPNmVzR1SV6kEhfZS7aZNTlxXJ2bznEevo78zVqTyOB6n4gKqJvUqTcloXGjn+Q9oQk1Nhy9yej2mk62wXVN6y/m48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTV7Lw/hIWnVAOLtWx6xTLCi3IRVg50whF3OfUC9F4g=;
 b=FTpnjm9l7dMKEJAHL7XN6O+DBg0w95C/RXEMUX3ZYcmHclhbIO6zula+W1ihcoqnJonXAQ1kPgeGihg1SXztoy/FjKH/EcX7CNe2Tm+RFwXViS//IOJzAWkKk+0x6L/eY11x6xVFZ5wEal1XVs4PcCGhhMw1ALpoSsdYYNp3CxIUnGAUWZJqEpuOWlo0rbG5iR6hkm7etE7kiLSWsGLKVjUkOrDOp6xVTfI4qvGeNq866xec2EWNIQc99t1ChiY6LguuWRgmnPQe84V8OZg5aQwiI/ZEtGb+yu0Q4iGRysydRxKlo5vRnSLev5nYLFVBVtsTJh/asuRWNxyc+sSwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTV7Lw/hIWnVAOLtWx6xTLCi3IRVg50whF3OfUC9F4g=;
 b=eULrF5qMlHBQeOMFezJpuYMzJzGquPFc+YjpueCEGWoLClcyB+H0RZQWWuUVS9Hlr6LqUB38iYPu/hdXpPB2ngv9HtlvMiqyb3R/7BXGPkoiJ1lHoKCUGPx5Z54X8vmU1RG8rNTZCnZpO+iX8Ydc7rzjnJnkmXgmEMHc+mdhHcc=
Received: from BN8PR15CA0061.namprd15.prod.outlook.com (2603:10b6:408:80::38)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 15 Jul
 2025 19:13:05 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::ab) by BN8PR15CA0061.outlook.office365.com
 (2603:10b6:408:80::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:01 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 14/20] cxl/region: Prepare removal of @cxlrd argument from create_region()
Date: Tue, 15 Jul 2025 21:11:37 +0200
Message-ID: <20250715191143.1023512-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8640800f-f1f8-4274-0224-08ddc3d3a085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/2GpkNGwDWoMFg66SXYfsv3HM6BBm1b2LRXr0lt1lD1yi/b0kLsZr0D9xFl?=
 =?us-ascii?Q?CrKd/gF6KR1NK1OHqvxKGcaO14Va7A3803Zg/bL7y0ys/WeaqfRYY+mwQUfd?=
 =?us-ascii?Q?hXESjHl9NC2hEuCtIw9zklXjbZQK2WYxske8paCNzn5l2e3DsJcH/31sSPeL?=
 =?us-ascii?Q?4c6/jeCQv1pPBSGxSltw+6TnLdUzUQWOAFbgJFvVtTpLLALj27HWFBEGux+E?=
 =?us-ascii?Q?51BMozmxJvrOi/wejf98EWl5qtRdkGa+NatgTy8JL7cEB3JVeCG2yNRy75JY?=
 =?us-ascii?Q?7bLsfe2rhyb2EuZXnsrFOlhCkzM3gRLh4AicrhzsaszUU69s6HpH/v1uXBfp?=
 =?us-ascii?Q?ZXww18268Fhc2oF5//iyESlaGqk1yBmp6Gl/QpNmzu+H8un4tuZBQMG58SuL?=
 =?us-ascii?Q?9o4hHNsY/Ax+fdw1oDrUMCUiD4LujcZx5yc2BMrXarPUrAOPn1yE4hE6Y5g9?=
 =?us-ascii?Q?trJAEC/WIVpHkOXheqrE2JORFqKk3KWkY/smt62XTbRLkd/Pw/X+QqnCz7FV?=
 =?us-ascii?Q?MZeHV2NDe6AkTQTjyhnG2oStCfqcrbv9kcfFzlZ7fhmU9HWlOuDcnpknqhqB?=
 =?us-ascii?Q?itdPcd+D9KwAEhTSISX3fjBV5W/sbMQ1TSLe6Iz2sj+zi5rVsz8B52E0IhMb?=
 =?us-ascii?Q?ByBnJuxWDnKWaz7sabpf3xYJt70kJzqWT+NhnnujNdOyNRJl7xtpatL7laBd?=
 =?us-ascii?Q?j0Mxaii8vdwhyPbbCOKHhNrngZiiLLanM8QPY63Z1EBfJT5QVV/8uSrKF+sh?=
 =?us-ascii?Q?vLTW5KNgI7V++3b0hEduwz93iinNtW9ZH6JziWGumIvySu784HYoMD1gyWAi?=
 =?us-ascii?Q?sfMmow0yQz2Je9a0jCio78egVAIj/a8oq44VFbkLLz8ios9TArtXHiowwjUx?=
 =?us-ascii?Q?sLJSNslnYflcBHgKPDBWX0QVcu07KyqdXSesHURe3f8eFZk9rFsW5W6ZjoJq?=
 =?us-ascii?Q?iZJcCtdq0+C+B5KVf7hKxRfTZb+pllLjFGLvWI24W+WeHS+wbzYpZYJuDoa8?=
 =?us-ascii?Q?P6e0YGHympKuFu1JYaAHpH3cymPjaQ3JqjtnEFIL40PCWxbmoPjuc8vDCsRu?=
 =?us-ascii?Q?1KKhOrf2noMrYCJb6Z0K0mhD7jsDWDp+FXWEh/CAoMJzTcsjqnTANOjeYfY8?=
 =?us-ascii?Q?01ATh+Od2BYBpOmXD/MyYO8mv4Pd8nhOnRpMzgnxGIrIcsjz29yn09KovZqM?=
 =?us-ascii?Q?jxoyYl6+QIIBZnYj+dvm5ZWtQxjmb+2iQ7mxYE6+Un1D2Y3bXeNeS6tJh1W+?=
 =?us-ascii?Q?GNhHIQJl6yj2XfFp6ZQz7vUVNNW7cTtUcXcJ/tvkP5jiyIDl0f1oXKE16fK8?=
 =?us-ascii?Q?V+VdK7vvvNA+lRFIs48sj8N95Ec36QQ1BoQtd1iooGQJHOQcLxRLs0QJvP2w?=
 =?us-ascii?Q?hycUAKKWdwE269zpWIrqVj0Yse+n0SXkihwoLQJqMO6cmKeSaDpqfwJC+hHb?=
 =?us-ascii?Q?qQdaBq0qlu0dx5u86Fr+rhZPxkQvGYaMtGZFDXE7lm7kppJsdaJ1EXNPlqB7?=
 =?us-ascii?Q?qdFnL+yQ9GPfzHYOTPmNYVK2PwLyq8iGpZQE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:05.4617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8640800f-f1f8-4274-0224-08ddc3d3a085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

The @cxlrd function argument will be removed. Rework the error message
and use the memdev's parent as reference device, which is typically
the associated pci_dev.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e06cc92ad3e2..9adec670432a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3362,7 +3362,10 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	case CXL_PARTMODE_PMEM:
 		break;
 	default:
-		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s unsupported mode %d\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__, mode);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.39.5

