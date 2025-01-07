Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFA1EE03B;
	Tue,  7 Jan 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259121; cv=fail; b=AMu6PndbKBV4eMF1kq//0IFCTQyaAnFo3SEclLiXoeZdhONFhf1Lw6cnWb+c52dXEzI6tQoGUZdsPwx7RZv8eGdjXkZc7RhfoK9lz1tHjNlWzL5gqKBCw1yBTq3nTu1SBAjPJcaVI2LM6On7mPBM1wJvjBkqYqOfNSjf80G/irc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259121; c=relaxed/simple;
	bh=kvn5HdO+1ifl2uKsKyfnnESWhPSyxxd1nQWzXur+4Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrV0aLkC8R+HQG5IEKI2hiooSsoZxVWEko4mP1kqWIsvEFV7Tag+qw1ORiYuKF6KXZJf6+lP125tiY+dQa3ELz3BXgbxoN8ABOBNxQmF6BggpZS9XvdWjHqk0UkkgEUwnt/A6nLPqnTzrbNqtWJIXE1W1btFjHgQwyL8Pzm2IRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNqrCupJ; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNqrCupJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9eZ8glmg/2kYRXC8Zm1fceqL+fzKU7Bny7IjPHO8mtX5NdLbyYgQgtXOUjWGE3wGT7cUDZ95fedyhK2Jdtl44+pvk+xOjhethi7HDmxxpk/tbc3gJvMjkC2ruit/MWvtkISbtMGVfoeWTbCL75DOd+dyXm+23aO8IWKzW+3VptYCZ4c5zt/K5nvVeo5JQOyMT3ZHsUst3PtbSRFx2EaAhksOLvlabRQCxw++fIX2R3mjc8V5EVvTT+Cht4qH+n0WaooFpPBUr8foEJJenVK3GX8/eAV8wr92KHq7vMRa+E1eaBSV9XuzXeqoJPIGI37vICGUVPdpe/IVZD3MG7hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4i0k6kxMxODHXgB7k06bZFlS6qOfvRUpHAa/0vTeOE=;
 b=nkEnw0dd6pADqoiG63ybtrGgkU9UzatAOkFJiQGLOS64YzrU5jvW5aCxMFpCQxFMQL/+QbFWxPtai1JJsQX1zaEXwMnH7ynt0kNirpX+RVshgKbc6oxW811Wcq9QLQ9tTCqzn7PDnX5RQYLlUlDdu0IxS57alcyLGhcxuvnBt2I7YNHrxxwxJHOF7ZYktFVtdLZPaMp03Zvt/+uYvfkNhbOxx+u2vKMOMBndDwLT4yojUtmn1miYl1RmUFEEjTQeSSreKdZiHNitlXETIdbj7zihB6YWk/6EnskTyF08sZajnS5wcILyRNhWb2i3KHHbHzeBrBFydPGo0Po3aOmTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4i0k6kxMxODHXgB7k06bZFlS6qOfvRUpHAa/0vTeOE=;
 b=pNqrCupJ5lPTbSL70Qb25isWgG5jh4ZV/EzCIDpJKcT+UHvCkm294mjWbwhW/NxCnWgjXqLtTvNFHNRS1O18cIlU7sfDXWatiQCQnYt4eYeg2Rtee6STlFgAZvN5VQ4JgnNPNhxcdNpPucX6bklN/rjd0IlrlKZb2JZ8AkqpKkI=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:54 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::e2) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:50 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 20/29] cxl/region: Use translated HPA ranges to find the port's decoder
Date: Tue, 7 Jan 2025 15:10:06 +0100
Message-ID: <20250107141015.3367194-21-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: a42f1958-88e1-4851-3d07-08dd2f253d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQi0VA+xewD9tkWN55nhXbZlR9EZaxLMZlGxjetjkScfR17KzKjGUs//mCsu?=
 =?us-ascii?Q?rk1wSboyOt2bA97oRZZE33vrYbiD3b1dveVhv8FuI3LLep1688MZQQiJLlsA?=
 =?us-ascii?Q?zmIU0XE0bCJCTxG0tS2QvJAaITzygtsIyqtSEqyknv0S6nQRPPeYNnvIpgIP?=
 =?us-ascii?Q?ex8BoiRpp/pMhKpEtwdNGc3zn8uox2lZR49HrrwauNT/9bP/MBanbVsrLBw+?=
 =?us-ascii?Q?sM/wazL+onzdP859/fICIZTJSMugQO6EJfLh/N6qbe4kqd8LnKpWjdTGeQVU?=
 =?us-ascii?Q?mDUzyu+BjGEax2yCbAG6MSNMQInbbIRIgNZAVXAcLpLD+ArKm1skdNib31FD?=
 =?us-ascii?Q?OZQETn3MIc7sDHoKY9tdJ21bKepsmUoT6t6NJYxe6hDImQIUUYL5e0vBPaMD?=
 =?us-ascii?Q?wVnI/6h8uZKMeTpJSrdM9fPu8TXMwa5uwZ59fQRVxMF60y381e/cNyeTAtBr?=
 =?us-ascii?Q?yArZNTTp36f8dX7CKbmwGQzz9nSZ15mZUyzYl5NBsgocf8V/5FzN+8hnAchE?=
 =?us-ascii?Q?JV6VeXQ/kspye2ZSd7xxihLGy4IxI4ifr2BelJvKhLXLwjn6qsY0yc/BVjI+?=
 =?us-ascii?Q?MPhAkItS48dm+FrzgQrfmVqiNcPPALGBC598ggALCuXfW7Io68LDn/4Gf2mS?=
 =?us-ascii?Q?vH1u0C5BdkPyRDDBwfed592/du2oHA7+4Tk0C/VLXcIoagHf/qJ2yuFaJzSw?=
 =?us-ascii?Q?CpEWDo2/2rZs3HGRTWahRbwTZAG9ZpFllPXbZp4s1lIhY+UMHZRY8JM1vyud?=
 =?us-ascii?Q?KLAY6iwb+VJxgLYHoeQUc1beRwQ8kmwDla5nuoyBqeZX41r4Y4TalCS/COMa?=
 =?us-ascii?Q?2aGkgiLjYiBvqe326GcC9hqQY0R5o+TBR1v105M9jsfy1VZoCQ0nrxx1A1ym?=
 =?us-ascii?Q?qeqUloTpM8vw91rOfY9p3lJjy5xf/kXEVUkIPQQGmgnvlocGGOULyi3FExmB?=
 =?us-ascii?Q?NcO9SnrYAGHng0ImsWOJV3qDjg8dVhzbI618BRMyP8LbXLnJarDG2ikM1ZNb?=
 =?us-ascii?Q?7LuBEdeO4evbSJfsY6t40uJ31Fml6vVM/KqHeHJC1ZA13/oDc7ECnK2/uuHL?=
 =?us-ascii?Q?XgXaUV3Bn+R2ssmFMjyruv0SGI3rsa+lMDnHGqSxPm7owndnw9JGuqL9441X?=
 =?us-ascii?Q?ekFyfRfVp1BGERaDJMO2oraxf6+nFsAy3LQrpFc8y3gbMMWJrd8rGbkLX7vD?=
 =?us-ascii?Q?btz6FFV4wBhfGwxxzAzI5l04YBLJDiJez76cAoQvTOqWO5Da0Qmc/sOMNvlR?=
 =?us-ascii?Q?9VuiiMwzVN/ryQx6b5x/3lG1ixFqs21aBii4fhcseemKAeXXrFvNj4xgHcFd?=
 =?us-ascii?Q?u+VkQJYYnoJRJoYC2B1PbdUmIeBDA7yJdmZl+m8aVHduw+KjR3fO+SOrCysn?=
 =?us-ascii?Q?Hw3yDII2yMMftBmVDGPY6FtCXN4zMQv/7USsPLInRA14cP5jhQ6elJYf1Q6a?=
 =?us-ascii?Q?4YQmZSwDU5vEEYz0n/28XkqtJMloDQ1PhLBCTm59DuGaVGk730OSSELdlLbU?=
 =?us-ascii?Q?Do0PlpE3k2Ik3Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:54.2110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42f1958-88e1-4851-3d07-08dd2f253d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

This is the second step to find the port's decoder with address
translation enabled. The translated HPA range must be used to find a
decoder. The port's HPA range is determined by applying address
translation when crossing memory domains for the HPA range to each
port while traversing the topology from the endpoint up to the port.

Introduce a function cxl_find_auto_decoder() that calculates the
port's translated address range to determine the corresponding
decoder. Use the existing helper function cxl_port_calc_hpa() for HPA
range calculation.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 23b86de3d4e7..8d7893878362 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -876,6 +876,66 @@ static int match_auto_decoder(struct device *dev, void *data)
 	return 0;
 }
 
+static struct device *
+cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
+		      struct cxl_region *cxlr)
+{
+	struct cxl_port *parent, *iter = cxled_to_port(cxled);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range hpa = cxld->hpa_range;
+	struct cxl_region_ref *rr;
+
+	while (1) {
+		parent = parent_port_of(iter);
+		if (!parent) {
+			dev_warn(&port->dev,
+				"port not a parent of endpoint decoder %s\n",
+				dev_name(&cxled->cxld.dev));
+			return NULL;
+		}
+
+		if (!parent->to_hpa) {
+			iter = parent;
+			continue;
+		}
+
+		/* Lower domain decoders are already attached. */
+		rr = cxl_rr_load(iter, cxlr);
+		cxld = rr ? rr->decoder : NULL;
+		if (!cxld) {
+			dev_warn(&iter->dev,
+				"no decoder found for region %s\n",
+				dev_name(&cxlr->dev));
+			return NULL;
+		}
+
+		/* Check switch decoder range. */
+		if (cxld != &cxled->cxld &&
+		    !match_auto_decoder(&cxld->dev, &hpa)) {
+			dev_warn(&iter->dev,
+				"decoder %s out of range %#llx-%#llx:%#llx-%#llx(%s)\n",
+				dev_name(&cxld->dev), cxld->hpa_range.start,
+				cxld->hpa_range.end, hpa.start, hpa.end,
+				dev_name(&cxled->cxld.dev));
+			return NULL;
+		}
+
+		if (cxl_port_calc_hpa(parent, cxld, &hpa))
+			return NULL;
+
+		if (parent == port)
+			break;
+
+		iter = parent;
+	}
+
+	dev_dbg(cxld->dev.parent, "%s: range: %#llx-%#llx iw: %d ig: %d\n",
+		dev_name(&cxld->dev), hpa.start, hpa.end,
+		cxld->interleave_ways, cxld->interleave_granularity);
+
+	return device_find_child(&port->dev, &hpa, match_auto_decoder);
+}
+
 static struct cxl_decoder *
 cxl_find_decoder_early(struct cxl_port *port,
 		       struct cxl_endpoint_decoder *cxled,
@@ -887,8 +947,7 @@ cxl_find_decoder_early(struct cxl_port *port,
 		return &cxled->cxld;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
-					match_auto_decoder);
+		dev = cxl_find_auto_decoder(port, cxled, cxlr);
 	else
 		dev = device_find_child(&port->dev, NULL, match_free_decoder);
 	if (!dev)
-- 
2.39.5

