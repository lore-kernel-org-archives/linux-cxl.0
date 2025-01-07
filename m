Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DB1FA8D6;
	Tue,  7 Jan 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259150; cv=fail; b=Uu83nhyjoGlEBsIG/OhaUPVkoZnnNZvC7y84EAG4BzALUh2BXZwLqfcOqafgjCBAeQj3hMCii+6nv5f7+i5w57CDTw+hMDaMeX9whZImyJHwVRrLoGIU0dPrvbq0F9eIFD2XAbOSbKpWLh6s8dJy9+gOd5PFxfs2ATIcsYfTK/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259150; c=relaxed/simple;
	bh=ltVSZYUDqOErKixLI2njqZZBhN7B+3pbLc16BsWMwMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brlB+gkKyOy3uYcYu20ojFektPp+KhTd4y4Au9hZ0awGRuDGCunEhgrWkZ1HmxIqImDUaVWXg6kIM+s9fTwzyM55xrbBGrlYjbhhvc1unofQf+6FnecPGxTAG3PA58ZfRUHGXRGYxvA9XeIZS9a7xp5blHL/Xs3XI/0ymCyvD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=khb37MtL; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khb37MtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8bVXK1HV3yeOurXXy8rDiPRGNS0hr4SXOu5mEp3t+jmoLy22AXpSo1SJl2bN3+MbpTX7AHhY8eSmajV2mnuo3yT+5IVnphhf7DR6KXoRpxZAWBAddKcw1QZg/mhdj8jWgiCvgewNDHYbxFtySpV45kOHrFdX0U5zsvhUVTfp5wUxXSwOPQW5XmuuVXj/ahIK15lPtBQF/l3p70Db2GP4YY2w8wVTbXVCa92SS9sYJEW9UxpO4dMylhzCt+GbTaWl2OM9gJa2Dar6DX9mgFL+wrvzdc+vYvJirR8zwm5S+2D6XW8PHdrXlpQp4niZJUrFSvC3en7pnPLMxhsd557/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HI9n9xk2m2ulDe51PEdczSAoHXXWNMV77nPNnvzblE=;
 b=cC2L2xSltWYj800XXiwYUOKuOl8IgdQzNCOzeAsdAmFGFiqs5kLAaffWhieRQPyWo7j9kKyoq7aJ6/QPNLJomXZOLrImG3FXNi0rPMYF/q9qbXEJgm2sB5DIwsayzbIJ0edMl4+D8vFNnnKcnPFO60Yx+lhmnKjgQe62EA3X6PWN0vtzF6tht68fnuvxjq1jh+/x6NOXAT6HNDfh7i/HkAwEn22hmQhipsRol3l9ppYRqwfVeoPawirG9SIu/W5U8TV9zOvt9mh/L8YdpxvtLrOQ4jw3xUJKiTqQj+9w79zIu3CVDDdOAzklMSgcpkpXYhBNY7/j8Ec0tCHLZs4ezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HI9n9xk2m2ulDe51PEdczSAoHXXWNMV77nPNnvzblE=;
 b=khb37MtL/S6qfU1rEr9epcx7nHu63h7oP3JsLKcqEPohbx5dd4J+VgCRA4QCO3urSJsh3ACqg1tYPJopRIxmnhKtDv3gyc15FaSYfO+VZ/Y69VVsM9+WxiT5LAU40ujz4pcgDTc62GZMVvJyW0U9jzighnINQ/Wcf0PaRBgE/C8=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:12:24 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::3) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:20 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 28/29] cxl/region: Show message on broken target list
Date: Tue, 7 Jan 2025 15:10:14 +0100
Message-ID: <20250107141015.3367194-29-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 6887323d-3fe7-4b44-689b-08dd2f254ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D09noa57KkehBh/xdg3BZtmbwsUgocBtQX/EnOJZCJCJFpZV3SfE1tU6oM/c?=
 =?us-ascii?Q?Ulkd8+JFgnsGS/MkazUXYNKtkQGbvvLr9dis5STUyFCNSXcERzDE7mxrdSmP?=
 =?us-ascii?Q?mvMNRXPVB1/e57hejqq1NSgacEbrTrnesYuzL0huDT7x+onaw/1JSn9ILvo6?=
 =?us-ascii?Q?PA0/1ugk4LmVyzQ03HCf/C+mC+38GoHfVHX5SEJqfrtwd98nBacVrX+Cwge7?=
 =?us-ascii?Q?sEJ+E4vgsdy1Ark+lHwklpjcJKh+bJ733ZcYz1Qq9f110ZpmRbQbDc6yTfdA?=
 =?us-ascii?Q?8en5IeRRVN77gcvVbRTvwNGPjkZ9xtK4lQp6/YwwEYkjQie/YRT0BNPqaNwU?=
 =?us-ascii?Q?2iW2mvEUeH6HUKs6ZBcteuTi08ngYcCUFSc2t+hLZDbK+ZuJWLtOoQk7iNLe?=
 =?us-ascii?Q?mfE63ZdgeJR0eJGFEz3zjn9sDI/dPGfJlNWm4GAXVa5m7bjDBmHkxaKC/fGX?=
 =?us-ascii?Q?+Jgw2NKCfuvZtas6v8503Rysdvx7flZ966a8rwqlvLfUyk2vpyXPOZIIhg9Q?=
 =?us-ascii?Q?xmuctQyVQjJXhLuKB0EtMpRN9ymwhc9AuRwZeGvrW2UP5dvqI4JraGfzwsLM?=
 =?us-ascii?Q?FA/aNK9g4TbozQUqPReU2zP9IgreoV1B10iQD0ydtJix1gxdKDl0t4Lv2Seb?=
 =?us-ascii?Q?i1eapxO1fb4ftg0y2Hov+BVW9irLwz42vJzGLbbj58lgZ5706iuWMWANTZ7z?=
 =?us-ascii?Q?eaDDqBNo2d1mK326LtFlQo8co43QohKavHXNKHNI9vJ0+vL96CnX3fdwvJC+?=
 =?us-ascii?Q?bSkjVjvXaBKun7xY5tGlFD5IvbZ37yRZIBgX2VpzcUlNg4G0OHyzeH0aZEf3?=
 =?us-ascii?Q?tUeISRL8ar5E+U+Oc+x4gfbhZ5Ii4F1sYuXViFEliNRDQyOuSMd0tf+McsMv?=
 =?us-ascii?Q?Ac5NsEGU3SEseKSFdL9wHMiuSnQecB9TOJLeujwKVViyhZ66B944DtSBbgRM?=
 =?us-ascii?Q?Joicuijj89nbGXD/0yyBA5DJMP+dfpGJK352FMlMz8rFzSn9Voxp5FA3YJwZ?=
 =?us-ascii?Q?NuRNkp2CiJ1Q0PBwXHgePBbte87jjv0Q2oRhgNJmMcD/8kLrFMA6ZxQGh4LU?=
 =?us-ascii?Q?QfvB3IerOeIz9PZfrO8kfbMdP2UaqQTG1weSSDIGQCjYnpHICIEajhDk5k1D?=
 =?us-ascii?Q?NISSAVRWoNY8yZMXcXQbfe8bHRQI1goyqX9LuRPr8XJaxlAhtXu8W4gK/NIh?=
 =?us-ascii?Q?ItDvX/iSxwMzYSYDxOUKKoAh/fUfk4ocr4TEbx5+RpQrymjlGtVdKaKJFyw7?=
 =?us-ascii?Q?pKquPHSP/CLHOVNMFPhQSGuBl/kIOCNj27hnRyQQU3spWnvrPZdQyHd4PBWs?=
 =?us-ascii?Q?lPtFk/jtWx26lsC5fWHRKCQ4d2tMPGoEEyRzd49rhhGD2Z4Oaix/SyIBTSID?=
 =?us-ascii?Q?PyV/Fx/eC94Y0/13s0xs4cN8iAuzb5SpxbcQy8fqCuAZCRbd9DleimRMvAU6?=
 =?us-ascii?Q?i3dwukHPrSY+piCWGxJCygy6N+ZTktB70VShY+zVEuB0dOL0WupO2qlDhMgr?=
 =?us-ascii?Q?f7G24Fzq+Azc/AA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:23.4477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887323d-3fe7-4b44-689b-08dd2f254ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

Broken target lists are hard to discover as the driver fails at a
later initialization stage. Add an error message for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 775450a1a887..2af3b6c14f46 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	put_device(dev);
 
+	if (rc)
+		dev_err(port->uport_dev,
+			"failed to find %s:%s in target list of %s\n",
+			dev_name(&port->dev),
+			dev_name(port->parent_dport->dport_dev),
+			dev_name(&cxlsd->cxld.dev));
+
 	return rc;
 }
 
-- 
2.39.5

