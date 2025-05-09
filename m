Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780823A9AD;
	Fri,  9 May 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803311; cv=fail; b=K7bip3XpVOkfqU9DgI13uoCfj9lhW9A7kymg6mgWRu9BR15TUjsvLoX1OrARwLHGa/udSk3hMgdI0mpTs45YiZikAEF/JW+ooq1azo5I3Qe3ukBRKqhsv9t2Y0gAnzY98EyBvF9I4IKCftIt+1+AEM5wQlIfyYdQuFzVXqckpZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803311; c=relaxed/simple;
	bh=T5TITUxf2vKPMOL7bhR+4lw9toaywTpay8s0S2xqg9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI9EeS44fcCkP9T+QVVd50eVNaCYXSqprxfnNoxmBmcD5iPcPy//D3eSEil/5Q+VcKNGOMfcTKpfR3N2fT4UmnFMtvX5W48gusvj5EvmyYrCa9y9Wqcdr0vBx7c/yBdPssZj2fxWSQNodnguTzd4g+FMk7O61PTBGt0fWqh50HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EtkdfO/f; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EtkdfO/f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhaO1iG6SdtpopXwEqCJvnuhSz0L5QxKzHg3Qg8V6YkycJiWTbgJnXBse0W3BA8RNAJd/2UelawTdv3NYJAzb6kS7G/52FhPAWUpIdT0m6Co+sN8L9CSXEJtU9Jvl35jzDwslX3IVowl6XdPl1ilnBUIxIeiZbFsD/MLqPYs+DwnKK8p1jxPT58WNoF1M+KKgSIoLHZS8oVtAv70aeGrzQmhqmEgJQmFu6puhh6aARp9nbjulLJRJ8ekIQnSM0vdsDVN501l1B7xP2wwvxTUUnEjlcK1Lb46i3qX4hcHXcMBpRLsRJvnFKb0Y8v72t0IQpuL+iPeG+ImtGa3vUAjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=130sewlDL3gLms9y+hY/4CP5At3SUXlnV9LJ5dJ+THo=;
 b=xWWJH5PH0YG6fnya6LqQ27+7gbIKn2TsYTMcEDxW2oiEDR6U5SywikxiCauANWsUv1Lg1GZN6wVuYVXbSpo/8Q97vr/yZ8rRF1j2ePKMwRbqtmnEj+K3O6ejhZnaXmn9ylRPkYrSUYI+sfTB2Wzy8ti7UBNCE7hlPYbQYgvLuRi9UnhT1sl0eVXvq2/GVkyZwl0bvQzNvcSQbprNVcg8QoKsJQAZ5KkCFvbTR0GgRgm0u3px0PpmhF8mwb2LGvRDaRL5KLH5XvIHIagPc/ki0nBb/gCHIxpzS7R+5ogq9MECzL0hPxmOYgbZBk6MfwFfKyXLMmMIpYNK3N24nzTWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=130sewlDL3gLms9y+hY/4CP5At3SUXlnV9LJ5dJ+THo=;
 b=EtkdfO/f4UirOmP+JGD4HS7KAW5Lgy7YmIhyeohRlp+Rqqz8GAeVdhho1mHqRe2xDSA3wB7/opZ+gHny4c4DR0TmYJ9/nVPyw+UDVSlC9KSlMuG66GNPmkoA7et+QfwlpPTNHzRiHL/EJZ00Xw3tDKfAI1Jp88h1e+uyGzqMq9U=
Received: from BL0PR0102CA0023.prod.exchangelabs.com (2603:10b6:207:18::36) by
 IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 15:08:27 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::1e) by BL0PR0102CA0023.outlook.office365.com
 (2603:10b6:207:18::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 9 May 2025 15:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:26 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:23 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 13/14] cxl/region: Add a dev_err() on missing target list entries
Date: Fri, 9 May 2025 17:06:58 +0200
Message-ID: <20250509150700.2817697-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: b5299e07-2fc9-4e92-8c21-08dd8f0b59ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44utbvbm9Jyn2VSzjQcklzK85smzDTDGTPMvQgJ3xk+UkGX6d/lIsv2giAAC?=
 =?us-ascii?Q?a9mNub2qn3J7muDWw4VfMogZhzM4A6Q/N3jJI0eiMZmXfXCF2xH1T5OTkoYy?=
 =?us-ascii?Q?BfvzgHOnZ5dScFS0hORKxReW7iF2j79nD1eSHAkZ1Fn4Rtwqde5kawYiuREk?=
 =?us-ascii?Q?52YyiWqNq/GeZpVoYJsd7v+FtNWzcTSGR+BQkQ0abM8IdEvcfWic/hxuWAUB?=
 =?us-ascii?Q?ePxL7bCLiJcY9jmpP6R99Q9Mww3xDkSlQDNwLyTiT4kFS3o1+CLcFcy9mglx?=
 =?us-ascii?Q?DR/vKuZoAh5N1JrwpTjnfuHRSxR0CzwFkGLhjp8BIbWZnHS0JqUvxcL9lsim?=
 =?us-ascii?Q?JwJREntVpMZnX/QgpiuW36aKUdPielrOkA3EAtoN5hfkQ6aYdqlSmBTnWH91?=
 =?us-ascii?Q?eZx9uLj9boxDjFb0Lr3vH1K31KyPsM3aSVnOlkpWv/I0Va3zj2WNK8kCPnW8?=
 =?us-ascii?Q?bBF4rrcIPHVLIpQ+RMbc1zffMlBvvjOzwpDoTHcM9vA0Z78Sd8RyOqk5YS6d?=
 =?us-ascii?Q?TCxP/x7BfxE4/6mUGHNLHztoeArGTaJNoxKp0Fi4/wABssY76psJbU6sT9T2?=
 =?us-ascii?Q?aWoazzBnIbWazuBKVATIHAOelz4V6Q6u639C7H3gQoSYR40RS+XVA8PzI6Xx?=
 =?us-ascii?Q?+bSVFs5f43ZFgGS1vvyC6Zwy+/xUuxa7Iun9r+vy3SAoXvlbnF9wBylKdbdP?=
 =?us-ascii?Q?vW8RWbzQvkTB3ZbxVDIsrXEC2twEbJD0lNS/I0m2OBPwJhF9HDfgbVPiFXFY?=
 =?us-ascii?Q?wBNWsxbAUejWkc57lS811QX8HGQg22dZIH8TIkHSX3o+dD46aHKVVRHpmYn/?=
 =?us-ascii?Q?yykVYOwzobhFnNb6K8oF4753gabiVSsTLf9b4SgEak6aAI5LiC4oCFmMTWrD?=
 =?us-ascii?Q?djPU1I2Sa0zDU0VJkfYf2HETF0GDo7M3T5XM5zQTDaYLVyeJi9WXpyK+WltS?=
 =?us-ascii?Q?aYF9yaMzdQo5zeLJHQiJ+2H/GZPrKPa+up2/J7sQdXquD5R2POGMZWMha5i3?=
 =?us-ascii?Q?u2CXvy9JxYAE4t/BfOahi55ibO2os/vVvSZSNdU0/qesBSHZIrpCYe1DjguG?=
 =?us-ascii?Q?qTPpV2RL4JS4qqoUf5GmhzVdllyulpFDOm9lfAeHKdhVLNj3jVXF9yHs7WPQ?=
 =?us-ascii?Q?nkZVJZy4XI3/frtu6MQV1wDPieAYhkTKj+iiAnUrms5CghblNzmn6EN/WJxb?=
 =?us-ascii?Q?Lb/cTW5ym4fLI++KnkNifvX2pB8mmze6tdOMtyLJ54Y+JYSysCeA+7B247CV?=
 =?us-ascii?Q?8GLhNCcEBvdZmyXDWHnPFp1NmqfaS1d0O/1KUVDQrlmsUe8v6Szp9y15xxUU?=
 =?us-ascii?Q?VySXy2GfZE0w4L/YmyXWzWWIVcCEgO4SUwjb9mREH/8ITd6+RrId8689BRLE?=
 =?us-ascii?Q?rkdDL01h2P80PUDyk8OWzjdC12YQeRkaGqgIRf+ohriNmRl9iPfLoQ/xNLy3?=
 =?us-ascii?Q?kqGnHIZ64XygXtcnToa9QnH0t80BgvANtKW4PYsrulhnOXjhrm5ZMJJ7rTVu?=
 =?us-ascii?Q?xqtk99dLoqTxGp1uRXE6f8J6KyyQ7VtDrnMV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:26.9825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5299e07-2fc9-4e92-8c21-08dd8f0b59ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 861cf74d5c91..bb69f59e27b4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1809,6 +1809,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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

