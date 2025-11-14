Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267821D3E2;
	Fri, 14 Nov 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080036; cv=fail; b=gghiUL5HFsJJSFtOGGtwDy8eLfFGgo5gO/7fC39SJfAivQ4b0athe5FNPyC2TGuKjWfu+Nl4Ebqt8ZtAvNREP7mZKBR6nGqhvEahycp/Be/8/+48/+Tuttobbd6HoWjXuFz/00j2BJ2B+fGutbGkUwpcjyWgR9qa0INSq39FYyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080036; c=relaxed/simple;
	bh=ckXg6ciMIKMNSuzZ6QwXlf0MOR62pL44IbCPR6yOMIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEbiLcqb0U60QTjibHXyrD+fRxmEjvnX2sTV8gxYkVwpHxfXhvYWc0Kw2dkGHdGJ639k53Y+r5SP3tJvz4qMbhNl8k2u4aJZr+BD0snvIaYtT6aMYEQ7vx5pDWwidprD15L/PME5c+1KSIpWwKJg2VWpdzcBWjJolfTVJzipzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SGMo6+TF; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SGMo6+TF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3pEEG/QyChXSy3GTWjXKTPGoVpHzrW8Zmtnx/wBRrDbu5EyLpHLARZ870VJEbF3v4MeOxDztsQ7umtEANSO/YGiqGTbMoAnmuDSsxzL5XnkeGid3Gy7sbX8Bc6poqI/bfSI8ghAmbQjbMXhnbaeBuQiY2L5vrMH8AaZ/dkzPLWQ+aX0PldwntXVGaSYKHwtt6xTCFxLSElJoJ5q0AvPPfvsGkrxFFWeT6NegzO6o1djAmiCy7wlDC8gbeb636b8QQrDFMiGtZ8MinlRzSJoC9YqSr5LrLDWu53uayyxGS1u+toGD7SulIEbX4Y9dYON+Xkq/Jb6oUymczA12kwGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHUM8Cr2aTovnKH/qcEnQmX2YWUtgtlZRHY7Ca3gNDo=;
 b=ODmwDaDsdEfVtOU4EHgqqYXORfZul+lC7mHNv7CeM40k2p2nj1ozsHkERNZnntSOrA7YnVAazrGnTcjj80nnZ/MRZWxGDj2DgaTZupllDRan/lacS6MXCm7UwW6Kmt5nZqju8Tmu1h+I7n8+w6kizjGF/pFwtg/oyZ6P/l3eIDA4wZq5EAE62xmzvrxRJkW5JtPQkKu2gjj0A9zy6WQMsTHmtLVnVAroYJpPOkcYM1xDX6IkZ0gXoyCsmdMdzjUoSsibAXIGgaPJbBLf97JeykF2UrJ8gCVxvubPId+sS9m5nHKmOU07L5Vlg6A/ajRmo+/XFuAVOQu3taHa4DSxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHUM8Cr2aTovnKH/qcEnQmX2YWUtgtlZRHY7Ca3gNDo=;
 b=SGMo6+TFhAzKM5sxx3Do1ww/YIqSMlZlb+Y3tXQBah65UDUIHj7hnxWZuatxX+eVBfonC+Gz8E6EfR67eMZT64XWb3FoS6F3+VZLkeJorRbbCviShQQcQE4cK0z0YZ3wm4dYkCrLtexs9/uyscUu8bTqjdIipzZPH2AN2MtFW8g=
Received: from SN1PR12CA0068.namprd12.prod.outlook.com (2603:10b6:802:20::39)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 00:27:11 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::91) by SN1PR12CA0068.outlook.office365.com
 (2603:10b6:802:20::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:27:10 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:27:04 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 3/3] cxl/region: Remove local variable @inc in cxl_port_setup_targets()
Date: Fri, 14 Nov 2025 01:26:30 +0100
Message-ID: <20251114002632.1309139-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114002632.1309139-1-rrichter@amd.com>
References: <20251114002632.1309139-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8722c3-e5f3-4427-3543-08de23148d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aoAfzm62xqWgNy+9hUtLNmVwnf0g6CSNhBwwHP9WjtXOrnwgFP1lLHjhcOGv?=
 =?us-ascii?Q?FZcf8dHUXFKCxE3ygApDc8meNRMaTcR7sgDZ4SzQ3j+TWJMOhrFUKb093pPU?=
 =?us-ascii?Q?qGysb0MGuO82gS/DTYP5gSce71N+05VYq07+d9Ar6UB7zQ9J2ACxrpLp3Cky?=
 =?us-ascii?Q?Z7g3N/FLKa5etHwsrfWyrVeZXDOKSLGzhdiGviVDIv9Z8KCAq5B0PxLfxSvI?=
 =?us-ascii?Q?UxWfPC2+taQTILFTca+P5BQBquuso8Jzkd03AbbO60qOqWd3u0QN8of9wDoC?=
 =?us-ascii?Q?WLvGay2D2nJVNfuLjhtrR1LEhmOUW+RSslDQR6PVSQRKnx/W5s2WCusjhNvQ?=
 =?us-ascii?Q?M171pB1HzZb2Zm/dT+S6ccEwNnoFeUaW+MGm4CTFF1CFUZk+PNk5JBiK0b4b?=
 =?us-ascii?Q?5iJV9iAlMw5TsRDnZxQpLVSKuB+QtUsEfMPzaeRoU7hL5zT1wbbxUGgU0Elu?=
 =?us-ascii?Q?DJXpGvnojZvlCHcABNJcJehdphta2wAKqrRM0j7ez4lUzYulax6kQ2lqdrei?=
 =?us-ascii?Q?yLwZ09XeyVVJAbM8mjDo928AhpoIbkBPiRrBtixxRECXVCAoWUJ0OO4AS92I?=
 =?us-ascii?Q?iFYiePu6+xeNmOJDHFuhcXg8RQUJTHOvKKZQekPJLuRlJbMCnGGEXEu8pfe7?=
 =?us-ascii?Q?FL3v2cMgHGfVlg0zjjipylW9T9IAFbPDBojLpng0cjK/llrDiDR6O0mxs4Ql?=
 =?us-ascii?Q?ojXIzaBEto45t8R1U7PzGMKR0R/iJoWnRFd72X+akTXheSndXgJrPR3XYhHe?=
 =?us-ascii?Q?1X5URXzaGzLf8daBLxBTI6+6tVj8bGjv5opsrgSHZb0w98KJel/eaerlkVkX?=
 =?us-ascii?Q?5izC47dDJt1TlYMvz5FBWjlpYLnNSc9TNyNE5+OHbwzKrAUbkt+tr/1RnvAD?=
 =?us-ascii?Q?6+BzER3ctUL6Y6pDumw6DrmXxoPz8WqqvVY5fB9WILwBnfvbuMwpUhGxX+T0?=
 =?us-ascii?Q?ELcjo3R28wyP4uq6oB/5rRJdvDZAxLxQwfhy7ZPgDga6NiTxkQgOyT8A86I8?=
 =?us-ascii?Q?d27XrIOfKZQpPy8dXzdXo1zWLthNErVWRxOhg9i9OcTLwqieWijPTEVRpFUn?=
 =?us-ascii?Q?Y0RLZDIU39r0MW1qD0ZeyOHCFlOIH15QT9FVWLR+K/PyLShwtC9iM0BfXtOu?=
 =?us-ascii?Q?VSRPcWaxLF56JGnRFWOPz4IQ4F6m8KxL7y1cnWLdzQBZCQaVmVPI8lQMKXwg?=
 =?us-ascii?Q?tViLb6kc0kVmd1KOZMZJ0XP38MZFme/16uEHOlqK2GoMnPj/3qeY8OXl5Qga?=
 =?us-ascii?Q?fav0dc3i7BNtDyfXS+CrdA+wVw76NDJwM8KrVqcNGF+EOEwW0yX3faoQpKJ3?=
 =?us-ascii?Q?bOpX8pJuG/K2xIpdiWoHdNhKuRhJrXEmaHPQ3Qwe3zCHaby25jScGp57iLOn?=
 =?us-ascii?Q?Rp3NZ9MVGVgG0ucPvCmrtvKvO7xhqk78PqYC6uim6OtsLjHKi0DJm6kFcWli?=
 =?us-ascii?Q?hPEY+Tpq9r8aALjvJPVWiQ0Fclf5coiS30ayWxYPzIhpkvWpEx/+/Bhw77Zu?=
 =?us-ascii?Q?wwNDgo10/kle4mThb5wLWPrrlSd4iJNn1Uexzz5nqIS3nIokACcHAA366XiR?=
 =?us-ascii?Q?BEvQsNxEOvjFjqC9xn8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:27:10.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8722c3-e5f3-4427-3543-08de23148d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

Simplify the code by removing local variable @inc. The variable is not
used elsewhere, remove it and directly increment the target number.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 095af0f4760f..8cdb6a935289 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1328,7 +1328,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1520,9 +1520,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.47.3

