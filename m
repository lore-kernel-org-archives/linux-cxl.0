Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B102561C7;
	Thu,  6 Mar 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279562; cv=fail; b=bjA7/0L58uZ7Z4lKhpZlrtEFxJ9gaflS1GTRn1XHuxaVlu5P5oWSQHTuGOKZrusXT7Gl2W1WQj859PNqwRVTrqolzXcmEKhcFDvxPoHQ2Rj6+XvlAJmCfGotUmYgh0CMQgk9O33uOjTWXUTQD+EWaireuE8Q42Qp31KEAU6abNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279562; c=relaxed/simple;
	bh=tgWURgByjXeSt6jibaV1V5Vh+LSKxw3+kg6P9/lEEec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfC1YEp/YkQA+v6K6QK6e0aRqOZPa3ShPdpv9yd6O/t0ndHMpOOFu0TDzn3ysy1j5BWt0grh5nMaSE5H5aYiVH8MBRqObWsm4NReuCijqADzL85bVgpMFcB4OVpn+0PoGB0mLYheaBOEsLP06E3Vsw0TcQK1REt5fV/4MqiScWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t992HmW4; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t992HmW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRtT24uLORETMjkY/QkJNpq7wFh3gN2M/Y/TQwT37vb3h+Cwv8HnLTEx4Eu+KpnmRoAqanJItN8SnElTbjcFPXa0/otGFuzF0cdWBRT8rdTLlh/mOpWg10Uv5zKadg8fgXnyH7dZG1RUqSZlC6nfjCf/Gv+/c34skUIg0yqSkgwxUVYP6qysVVQBHUT9YNjFjii023m9PoCIdHaLORxy292NlbX1rlixPt1dv+bG11ztijGwrXRKXvaSfbd5k7MSU3YiaPPS6VoMJ/hU4sNtIftQb+TYk9z2qJoQZkHTjULsh+4d/RsPMbdi7E2R0pEWbj+9eZjTKXcvP4UbaUgoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8KUigE1SOdnleOtu2WXQvc0ggAe0J8ZeO46L7gqTro=;
 b=jsi5ry78dH/7odb1sI1BCLEr9SL6WoPQvCxAom/T/XHiFv6iJ3kDgJykA+bLfF9xPYPNl6V+ePDCgrA+VupKdPCA3SblWcj3/hFmBbj+CxWyh1JRdpm3+SOEL1J4H4Kx/wnQ9ezxrDLZhALO4xOj4MDDiIKIcmnv1k4+OdRJDIECqGp0Hwsd8lHR7JcTfOw2PP30rz1VSDESbcdvJHOLpn78e23n6bg8KxpGoRMgI1FBWn11B1/6T534N3qryulHrWxKg58mDmGL9E1pBUO/FmFeE/BoctuS/BY7iVap82X/S/ve6AEArPOVD+lXkcec5ir8vj1K2gch5ge5kaCI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8KUigE1SOdnleOtu2WXQvc0ggAe0J8ZeO46L7gqTro=;
 b=t992HmW40pzGUOChCmY4ZqgYyve06dQNLl4YF6ShXD/aZpQVaYJ+5KXKy3dT6xcyju2iGKu1tXHk9PaIiIW9Q1GT0uJvjSjWHTEs32o1A2cDZu2zn5Wt7GE0AY9bmKc2P3U9kcFMqNRfVLxccMqA+EvoKWsuX2v7BnTdp8iCUUs=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:55 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::8e) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 16:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:50 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 12/14] cxl/region: Add a dev_err() on missing target list entries
Date: Thu, 6 Mar 2025 17:44:46 +0100
Message-ID: <20250306164448.3354845-13-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: b22d164b-d733-4c63-060a-08dd5cce5c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GmzSob/pkFE2vWgrvj9ymhVr/RuIQxKh9pZjA9ycFNKrQXKiQ8f6h18Nwkk?=
 =?us-ascii?Q?CuDvSJ18qykqPbnNAROyfL4pWF2Bi+2hWQ7BBvtDea5E73G9ixNFdXl/EQ1R?=
 =?us-ascii?Q?4ZV3uudaSkY+U1aSVIyWqwN5cG5dBMT79/kUKEnatcsHwa8hWpgPuNqs0Dvr?=
 =?us-ascii?Q?s3OxHrQl4YcTbbm/Un+d3yu1IW45Th4GHFL71/p1Gz1Bx6ai0zd87+6IoiMV?=
 =?us-ascii?Q?ZLmgZzDnn+CxHOK7rxUw7AuYWP3RDKOITk91WUUmxBBE6Jp8reW44gFhqzNU?=
 =?us-ascii?Q?p3/7/PEC0YF1YJL0anPk244iQ/d9CALPsRodBrxTZjuv7CXzuXR2fn3YhNfx?=
 =?us-ascii?Q?RXOL/g8/rB11ypdv7o6u764t8YWn/LM4ouB9Tp3IdkMYVSReDbVsKGUWnyC0?=
 =?us-ascii?Q?or6D+RbAtnpm/iSGfV3agdfr8m2HHFuWVnchbLhv5OAN+onx5eKARQFW/JxT?=
 =?us-ascii?Q?ZdJZOXUH1HnD8G9BKKpoA9icsdS/OymxB9tDWy72Vrx9xA5yayYx5C1tMAoK?=
 =?us-ascii?Q?FV0Nim9i4ofLEy2PgR6jfl3k8mzyuGgEKFVxIiCIqvGd6xnNlcu2r+TRhknV?=
 =?us-ascii?Q?4rLoviJvYQa6OckCK4fV+o3KlGlmD+C5SlRTJSYWYb+39dQQy9Q0a+NWVngq?=
 =?us-ascii?Q?PVqiEVg4l9ypatgnBAod9fOVuo8uxvhhLdr9xnFAemj8uLGrS/ugw8E1Oyqb?=
 =?us-ascii?Q?oPxgVK7f4R/BC2pcEZNmxAReANlTZUGseFpwNfJkfMJ6b75KrUz0eoQKH/Cs?=
 =?us-ascii?Q?xrU2DAJFfQATfY3tfDK3OWaZsr6JhEun0XIXruV7wq/zL+TkljJYRWUo0MBZ?=
 =?us-ascii?Q?6ZMbp49VnGzIuAUbZKfB7fX6X3lhLhXucIYZ9YRbMdCBIHVD0DDtRcVH+m+T?=
 =?us-ascii?Q?J/EaqlYx7q89wUB7mPLuqvCaAM/sL4zgAP7Ti293FOAsLbIYnCi0VvOd93M0?=
 =?us-ascii?Q?WuUam8sspmzu08RJk8SHrJyRNZ4bXgGNFA3lEdUBf3oyVXUW8cjSMWz3KEXW?=
 =?us-ascii?Q?o4kVF15Q9Kigy3ljUNea9ct23m2E0mYBBomjyObWAhFIRGl01mILIn0oO8Ne?=
 =?us-ascii?Q?4vXwtpO7oB16jdpCM++7VXaH97PhrsXyH00b55jZrDbJfY7iqzgmSHBPhsEP?=
 =?us-ascii?Q?5o+aAqbGpirXoy/AxIcCL8kny+RToCuELW6SExSSo+YrrDmlP93MndH/6yo9?=
 =?us-ascii?Q?FNPYLVL4mk9n6xokZ8LIllGZMumhXPxWlr5o0m9Q/2Rdc9xTtImqyktcLLH4?=
 =?us-ascii?Q?DlBBzCo8BdKjKlYjizYCqabCthsvaLS1rbO0NwJOlJhmeJ0O89W7iJ5UJHbk?=
 =?us-ascii?Q?40zpvUw47+aX0XDwcxzSFAea5e3mE/WUKqt4jD9ASjRaO2MtrImF7r8hMRyu?=
 =?us-ascii?Q?vD9B1BE8+PgnlCOSoLY/DbWyRb+zoOinxUYA7h6mPC5s/QLTUh7BYTfSaMJw?=
 =?us-ascii?Q?GbkclYA6OYZ8LkAqnqGnECUtHeY8yB0r3xBG33bxoUhlOSKMWTFu8yXiGSQ6?=
 =?us-ascii?Q?9T15Ckovb+bLPMA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:54.1728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b22d164b-d733-4c63-060a-08dd5cce5c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

Broken target lists are hard to discover as the driver fails at a
later initialization stage. Add an error message for this.

Example log messages:

  cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
  cxl_port endpoint6: failed to register decoder6.0: -6
  cxl_port endpoint6: probe: 0

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bd1ce9d8bed7..175f5f600c5d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1805,6 +1805,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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

