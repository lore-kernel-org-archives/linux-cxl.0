Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81D1F8EEC;
	Tue,  7 Jan 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259121; cv=fail; b=hyxshXfsxgobdvipSVuu/GjvJ+CoFs2aU/IcgnVVWkE/SgISz3Fcpr6pLmkay1kZzBpheVBeumte5ak78CV+Tpg/RT2Jy6d8oJFmq9378La8YYpAsGxH4vnuxyblQwOLLXykuIV+hw2xeZUYS7bSVqF2poKjstHEWRD/2C4cIwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259121; c=relaxed/simple;
	bh=fl3QtEP/Retc//l5rbxO4AS6MrOXJbUrXtt0pjfinwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA6fJk+gpF5cECwEpMPJP9SBgpzpwL8D3yO1/d8GDfUiUnpdmeLEdwoG/X9GKxxPC1KUrwKqP48yqfMvWpuRiL9neGssAoJJA6Yg5k/iWzllinarLInXSwUAdK0aQLcC9Au+tqRt4lsKazgOGTP1P9vO1BHzi1B7sKDz6TSuk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=trA5BSyo; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="trA5BSyo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M97SQMlOLcJPCvTFk8S441rYK+F/oecKG0aelq0B+gmM7ed7OA4azF4OP00+Mf38qKnxb8Bee/lSgD5gq9FhItjeRTiagGAQo9X9VA1avMkEbE4EEAmTrCOFuXBop946UXJ1R/YNo4qK7FuHP3voIoViEjNdgCde7kbjDnhRTI9kL8UNThBUGn8ZNOEEO2q3O3GogzkUqaRmgkuhK3QGhdHCuc8FahUUrOqCj/ieEhGySTZCmrn8w1YSm5gvCZuNZmO8rqJ4iEaQaVaB8rZejk0vY3S4lYfrnPS+O2STllOaz5wAXHzZTUu13cVntOHVltV356MI4AHBzNXfmdAZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBVB1bAHqkluVb6WURX7rQqZfuMVHD1m3mwacaTNR1s=;
 b=KxoVWdLUkC7J31j8J/CurQCEp+1jGeLXk35Rh58dCs7Fk+TyFDrI4l0WRh/TeeHBGjqic3osZS/67zKy97S678USFpePMnBryQtuc/cQ44avrvtvq5gC3+e9h6RZdwzxGmgOKlXcwAPj57EKLWyfwN+lXDmwtr9oRAKpEXohzfAOF/QJUjNsrT0bRnrgoTto/atNcNRt7i+G8danJLMTQID4kTUfZrWqSYGoT3k5GcwcqzxDRwWbsFb8I6jHvkeH05mf/Ncog4KbmAn+vvzRG2RW8sOtf0mKSolblHaxpOsUCc48QjECEGQOevDsWMGG164YsCm1bjRq4tX0BY1Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBVB1bAHqkluVb6WURX7rQqZfuMVHD1m3mwacaTNR1s=;
 b=trA5BSyoD1JZK4/Z2wTuyIazj9oDfVkdYClIVBRYvKUCtQ9J4Yfx7XulIzsGeY+1vw2UaOuO4Hp14YqGjkV8F3A/6TcS9Z2l7S2wPJPwmS9KsAnUerk2vp8Vnc99EQIX65ejpZqOZ6/Gt1i2dzbBAMPncENS93di/DC83cBo/7g=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:51 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::78) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Tue,
 7 Jan 2025 14:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:47 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 19/29] cxl/region: Use endpoint's HPA range to find the port's decoder
Date: Tue, 7 Jan 2025 15:10:05 +0100
Message-ID: <20250107141015.3367194-20-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7815b3-2b9c-4770-cd74-08dd2f253b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYKBVvFhFJ7lYEFufMsrZCbVnbK+wcP8gADX3uOS4ACJq+IkLwoLLhJ8m6Ny?=
 =?us-ascii?Q?7kFDMtKuD+lg8zcQZHwVXWG+hniZMWC7rVozsA0Z0na4L/Zeo9iDYdl+d43b?=
 =?us-ascii?Q?mXQa0C2tM5cTrY9sxCfFjCCQ9MGi/4ylN0NQyfcJsyYaoG/1NMbvWcig+BOX?=
 =?us-ascii?Q?WDB+2K9cRQ80Q6sO+xvsk/5T0qoNHB3K0Otjo7IX49VMO/lrutU/ejhOwmPJ?=
 =?us-ascii?Q?Hmrbb/6Gl9gQoVyOGzdpCLvZ4Ix39EfAJVFW3tIbmYPIMHVF7pXJ5y/JmNiU?=
 =?us-ascii?Q?1HACsSBeEVm1bNqo79c0lpzxC0OyUrgVk4QJtmVjVAI2icI1nAj+eNZa/xQA?=
 =?us-ascii?Q?np3hpT0dFsxhBumhhTabFg9V6om2SOGmhHHkZKxoXDZnxoG6whOOPl2p5Vhb?=
 =?us-ascii?Q?QLIAml9vLBh2yR3sMTTbU9bLw7qSMqIcvY1VeagapjYlk54+y0iRKiA8kGdT?=
 =?us-ascii?Q?pZeeYSQpbzPTGATnQOg6IQ0KgrDzqMlxvAj+Bs55EAMwy2uWnsTZc0NL235i?=
 =?us-ascii?Q?j+t4Axjm9jzEfE6wxn19aYXqYjjqrPbTE9ZJIh98CIlWQq3DZ+6ix9BvHBbK?=
 =?us-ascii?Q?6PNOPZ2Ctak4TdAVzUq5RdQKjcB4vqxXlaUZ4B0qqaq1wsJ5ez/6NVUsuGpc?=
 =?us-ascii?Q?JJVfUftwVAi+0FNEGHdCnzJg7pWYeVWBxDQTcKCZdox/JrNdGlssy+bbfgEk?=
 =?us-ascii?Q?IFk65IJ1zFJtm3yDAig+0/OVqz+9ovCk/vjDkjFZT7bm6J6uHKcxOfVVfd+s?=
 =?us-ascii?Q?8P7xe4PgHoEofWMQfaMz112R+1yRUs4uKarLGdWzZoUlfN+mp4fdQTL+PhfK?=
 =?us-ascii?Q?GcpPGQwjsDRvplJasYSMjxSMU99b1ECdgyQneond9OaizrgrkhZ9nkA2Q6tf?=
 =?us-ascii?Q?LfH6vMevn+3rWArtbE89IpibhUQdGQc0JIzRwD0f1YjgWTMR9qACZSvoLQhD?=
 =?us-ascii?Q?RnO2DJUW/zncBDOlZY31adjDXUxe7PSkeH7qWfrvJaZomkXzItZy8oj4tFad?=
 =?us-ascii?Q?anbhfIW1X5j/zRCVJUgilhJrOfqMuQUsnp94qbke6VqfRysvl2uktw0eGKtS?=
 =?us-ascii?Q?MfD4bhO54By1RIJDlKAw/pVU/I7yUY90CSArjt62x2UhsmKiY0GR+FnYggro?=
 =?us-ascii?Q?ThJP223ca6B0Smli04hT+/MbPokBM6MRlOK8S4QcMtWNkfLlD17P7rMvv0o8?=
 =?us-ascii?Q?K51inHY1joVJV3vrICbLdXrmz5S7+yTzSerj9pUmKA/j0pcVJOqGYeJ/wmuT?=
 =?us-ascii?Q?t7qM4Mts1GP32tYf2f2hGAw6a+CXtlwYPdp+u/tZN6aWsdMrWip5C52u6rQK?=
 =?us-ascii?Q?Mp3lNI5m3jrYx6CiOGvJJn3o+h1V2CvG+LVSKSYG+48Afr1dcMnTS+26WyL6?=
 =?us-ascii?Q?RclGtR3dyjXH13ZfSTWfEKV0CfgFSPAETXfresi53Mni6gaOaGKzo1uMAIGR?=
 =?us-ascii?Q?AmfqtKUTJmlaa3S14wtdtfo86C/B9m5JwV9iVM/4vlCjjuiA/0ajDc0r+tD0?=
 =?us-ascii?Q?/G3MvkUVbupClag=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:50.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7815b3-2b9c-4770-cd74-08dd2f253b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

For the implementation of address translation it might not be possible
to determine the root decoder in the early enumeration state since the
SPA range is still unknown. Instead, the endpoint's HPA range is known
and from there the topology can be traversed up to the root port while
the memory range is adjusted from one memory domain to the next up to
the root port.

In a first step, use endpoint's HPA range to find the port's decoder.
Without address translation there is HPA == SPA. Then, the HPA range
of the endpoint can be used instead of the root decoder's range as
both are the same.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b7f6d8a83e4e..23b86de3d4e7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -861,9 +861,8 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
 
 static int match_auto_decoder(struct device *dev, void *data)
 {
-	struct cxl_region_params *p = data;
+	struct range *r, *hpa = data;
 	struct cxl_decoder *cxld;
-	struct range *r;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -871,7 +870,7 @@ static int match_auto_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
+	if (hpa && hpa->start == r->start && hpa->end == r->end)
 		return 1;
 
 	return 0;
@@ -888,7 +887,7 @@ cxl_find_decoder_early(struct cxl_port *port,
 		return &cxled->cxld;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-		dev = device_find_child(&port->dev, &cxlr->params,
+		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
 					match_auto_decoder);
 	else
 		dev = device_find_child(&port->dev, NULL, match_free_decoder);
-- 
2.39.5

