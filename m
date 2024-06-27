Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E891A2FD3;
	Thu, 27 Jun 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528426; cv=fail; b=ZpzIogrZq9tvq+9oF8DMXCsDdOPaWV5ef22nE/DStn8nczZd7VYKqyuhdSlGELqRhFYWUhC+N8yq11wA9Fbvnc5MILOJe7CAEFrYS/Zil0phA1ekZYTgZJx5RBOiy1x2OBd6J91nPHy5omVM+QjlcHxG8k0TO9WsO64p+FPqxqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528426; c=relaxed/simple;
	bh=i1Isd+rAPjpLFj73cHX5Iy78ewxgsubyerpMCUB8Exg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNqo//UP/FPOiTFU1rIEsXSZ+vC2FKiTWvjjXlbk6P2IBcBq1r5hEck5i8uaic16Xue4442kQTB980Mo5jcbzHnVRXhXNe+46irWW2PrW7KIPkSB/gKCI+OYUWGYiFyM+xY9eaGIh+8FcJ8VziaaPrMi0P+L+0ZA6IhpkAvaL2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezSCwgum; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezSCwgum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfyaHs/jkmgOeSeXMQWUKP0I4pPmGKpwcfT7aY7Xnw0TnWMNJ38O3wpgJQb2svJcJ8zk/b8an+RzJKKszkoPBtGDarz4AXVoB8b36qpZ02fuT9O5eTOjxhaZD8QbT7h79KWlGD4GRpXVHW5TBt2yU3GkJxbFukw0PzIr9xDN507iIST3awxBlgR5XUwwjnz8mq4MuquCam5tvg+3OROMbpbm71IrxSdIYRuz2Q/Ced3N2ZTHIbzMcJBs2GOj4DXvLZgQ/nVGxfmWqGEsLHTFi3OQmHRzyt4WXXQ/PB8IEUj/HP0feC8mGzXp9z6M/MwFNMsuXnRw3Go4i/A+pw3huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgrn84JS7zg+8EfybpCUjXN8siRMFlFrd5niEZIv09s=;
 b=Q/BSEUecu0Y0LGA3Q99ZgiZm1FGEbFSFv3cZV9EhlbiUucyFLqrBlxPNqwqKPp7kNZLvuq85C8J2gSlxWlN264HVlxH0yqM02dAH9nQBa7seXimWZvHQXrQK3BKMDH9OGQhQ9iqWlZz+Ug98Ia46fBE91vwPVzrBlX0KAhnG3gwKdNtRVipv4ZBKBT/X1eGQUoIpG5LdPgok5BGSorSV5+lUN+J5e5e/IE8iuKk2zNiMY0aJH8oBRggSy7GvQJranJZCxgZhPtNf9LY6D96E9OYX3oYdi6USwP1W69wCcVw5Cm2OnY7i/43tQIxTar63dR4Q75bWt42NnC9tiaCIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgrn84JS7zg+8EfybpCUjXN8siRMFlFrd5niEZIv09s=;
 b=ezSCwgumanMiabPa/jc6+mnkp/zuN2/s4cK7Q6FXiAjWwAW2kwyoNoct47KWa+b5GS/278cggXr9KbJ+lq3gEjqdz+MJEEzXRvnnYIqhc3S09rIA4LW9WQ2m2nXUX0xo70+Mx+/tzCydb24twxZhvzuLSr0RwRWtxc1X7S/SNrg=
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.25; Thu, 27 Jun 2024 22:47:01 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::56) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 22:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:47:01 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:46:58 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH 4/5] cxl/hdm: Setup HPA base for address translation using the HPA window in CFMWS
Date: Fri, 28 Jun 2024 00:46:13 +0200
Message-ID: <20240627224615.854162-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627224615.854162-1-rrichter@amd.com>
References: <20240627224615.854162-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: cd70183d-29b8-4c37-daba-08dc96fb0f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxHaHLsBLiTidAXOtXEnukSnW0trQCa7753p+fAr0wVMzzKjdXB4hJscvAHP?=
 =?us-ascii?Q?LYYz2iWJYCeq/j2Ei0Vd9SYjNILOpHO427gq8Lf8d6BbocHojxDN2kOzyn7X?=
 =?us-ascii?Q?5XmeaOnE/UjSCdX2zU3hRu2XsJgLCmea9VWcK0oAa2NlqKrP2m932yaeqdJB?=
 =?us-ascii?Q?SxirihlcLr8znpjqNpGTRi+HBv1tnonKqIvRG+/OfzAGi7BpSyHVzTTQbCIK?=
 =?us-ascii?Q?qDWQxn4M7QsEzvo/FjylCWCzWywKoatoBDB69SsoHovKRJEyv1JmFM7p/0uF?=
 =?us-ascii?Q?CTvQMQSjSw4EbdQzOsPvYv4VkQX4SYYKQ9x5Srevl+jxiGh386RABU9akqTs?=
 =?us-ascii?Q?qmx1RLkwq77R4FTaOVlcs2n+y8abOi0lz60J+VgnjJyyGuUCVbPnvUWmTypF?=
 =?us-ascii?Q?lW86VhegzQDFOTZbXrG0o0JStAH+DJ3HDWsjuxS9QJjZgVoYMKpqvnMKBGvh?=
 =?us-ascii?Q?VIRjUzmF+8eNw72KYEdghFpicDUlC8aTHtImF3TfgrDb+sIZlf43vRVfX2Gw?=
 =?us-ascii?Q?rVI+YlXoH0n7bZc4kIsMcuEakorOIFsAm7piocxoWj9Uc6/Z7mapdyIxeJ8Q?=
 =?us-ascii?Q?694m7EzP+nQGLUF9n3Uu4WVPtDvyf6LgeqX+xPAQn9gnDeqcREKVapXaIN5x?=
 =?us-ascii?Q?F5sPV2M4zHFwEE02Z70x7CDp73ZHnv2nF4u9/VFwo4SZpZUiC0vJM6hVje9a?=
 =?us-ascii?Q?ZS4m1jrmi9uqc0VjDdsf2XmjmB7ZN6zo+O9rvd0kq2YAA8IbFgorYcpywhNP?=
 =?us-ascii?Q?VuI2XkiH1jJk6HRUJGjfz+N+Y9VcuuK631dSSYzVsa/dZYF05QqTVEamUrqK?=
 =?us-ascii?Q?+991UU1pwAut8ML0xKrC742fOn9+bmSlquvEgBQEd0Z/7XlfyvJr87+FfFJr?=
 =?us-ascii?Q?1JARsx8sjqEr3Fxlk65gnu1XzJJlOSnGywFZGYIyxU1FBRDykf1Ns3Q+pT/b?=
 =?us-ascii?Q?ib7VzSqLlc48CIVlddaSIYG67cPhrB9pmhnh5rCgJEOZiwRwC/d6r6SwSBX8?=
 =?us-ascii?Q?mi08cy80L2y/zLi9M3ROrCJnHYuo3oPvqyD7aLeSz/hz518FvEAYuwr5xXws?=
 =?us-ascii?Q?yAPscTOw8vysR2H4pdX7qzfOj+5gDsBxsNHWtIXdQ6XLdn0hwApIItmX+A+r?=
 =?us-ascii?Q?pTc+LhsI1f9P5M5l8x+P5BJW84rHmTsuYGpbUS+zmw8zuy+PkqXnIAAN4hpg?=
 =?us-ascii?Q?x+oM0PpcNsTfEE7fwDyFW84CiJMwFBqaUl7Mnef3tmWW0pi6j2mce0U3068J?=
 =?us-ascii?Q?v6EbuS4eBix43aoOcj79QxJrEWqqJvLufWutaHtCvFwR2vdTlT7ea7D+6rQU?=
 =?us-ascii?Q?hqNJ3cjZdBTWO4U6SZEhyYJOx1uHJuIV67jSeazQ7NOqoBtHss0iWDa4NfNc?=
 =?us-ascii?Q?G6tH2CgwIHKb987nOYOFwsCHjAZIi/pUbGR0lyvbwBfmnppL2baODig38vgA?=
 =?us-ascii?Q?W4ZE89kyxB/X6Pm5unxGlDUWZfSk2/KX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:47:01.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd70183d-29b8-4c37-daba-08dc96fb0f3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

There are platforms where an address translation between decoder's
(HPA) and the system's physical addresses (SPA) is needed. The HPA
window in the CFMWS can be used to determine the address offset for
the translation. Each CXL endpoint or switch is uniquely attached to a
CXL host bridge. The host bridge is assigned a unique HPA window in an
CFMWS entry of the CEDT (host bridge is in target list). The hardware
base addresses of a CFMWS is an SPA. With that, the offset can be
determined using the HDM decoder's base address from the registers and
the HPA window in the CFMWS entry of the corresponding CXL host
bridge.

The CFMWS entries are parsed during host bridge enablement and set up
in the CXL root decoder during CXL decoder enumeration before a CXL
endpoint is enabled. That is, the endpoint's host bridge's root
decoder can be determined. The HPA range of it marks the beginning of
the HDM decoder's base address and the offset between both can be used
for later address translation.

Setup HPA base address (@base_hpa) of a struct cxl_hdm by determining
the offset as described. Use the port's host bridge and CXL root port
to find the corresponding CXL root decoder containing the HPA window
in the bridge's CFMWS entry. Only enable this for platforms with the
@hpa_xlat_enable flag set.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50078013f4e3..5164ff807537 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -125,8 +125,73 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+static int match_root_decoder(struct device *dev, void *dport_dev)
+{
+	struct cxl_switch_decoder *cxlsd;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+
+	for (int i = 0; i < cxlsd->nr_targets; i++) {
+		if (dport_dev == cxlsd->target[i]->dport_dev)
+			return 1;
+	}
+
+	return 0;
+}
+
+static struct cxl_decoder *find_root_decoder(struct cxl_port *port,
+					     struct device *dport_dev)
+{
+	struct device *dev;
+
+	dev = device_find_child(&port->dev, dport_dev, match_root_decoder);
+
+	return dev ? to_cxl_decoder(dev) : NULL;
+}
+
+static void setup_base_hpa_cfmws(struct cxl_hdm *cxlhdm,
+				 struct cxl_root *cxl_root)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_decoder *cxld;
+	u64 base;
+
+	if (!port->host_bridge) {
+		dev_dbg(&port->dev, "No host bridge found for port.\n");
+		return;
+	}
+
+	cxld = find_root_decoder(&cxl_root->port, port->host_bridge);
+	if (!cxld) {
+		dev_dbg(&port->dev,
+			"CFMWS missing for host bridge %s, HPA range not found.\n",
+			dev_name(port->host_bridge));
+		return;
+	}
+
+	base = cxld->hpa_range.start;
+	dev_dbg(&port->dev,
+		"HPA translation for decoders enabled, base 0x%08llx\n",
+		base);
+	put_device(&cxld->dev);
+
+	cxlhdm->base_hpa = base;
+}
+
 static void setup_base_hpa(struct cxl_hdm *cxlhdm)
 {
+	struct cxl_port *port = cxlhdm->port;
+
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
+	if (!cxl_root)
+		return;
+
 	/*
 	 * Address translation is not needed on platforms with HPA ==
 	 * SPA. HDM decoder addresses all base on system addresses,
@@ -134,6 +199,10 @@ static void setup_base_hpa(struct cxl_hdm *cxlhdm)
 	 * == 0). Nothing to do here as it is already pre-initialized
 	 * zero.
 	 */
+	if (!cxl_root->hpa_xlat_enable)
+		return;
+
+	setup_base_hpa_cfmws(cxlhdm, cxl_root);
 }
 
 /**
-- 
2.39.2

