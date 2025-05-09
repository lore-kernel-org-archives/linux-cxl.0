Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB02356CD;
	Fri,  9 May 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803280; cv=fail; b=eRjo1D8itixu+gcb1S53lFjgy1Wgkwm5f0VbGMiIgDFmxxaCh/85M4NHO3qY+G45hYbqBriHhlhbGIcgxWMamsZxVVO/1KbrUQFvg0v47fdSPukI7pZjo39/IHFB9A65wIqg++wDt9GuXiJhrD7+Iuxn5O23LOKfFvjmmuZKdPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803280; c=relaxed/simple;
	bh=dpdL0+aTCPytGWzsC8NDShZQHemyi5PLdnH7WD7gUsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soTKdvhzutIrqMSfSNaZt5L1bYjKQ6ODDMMUZgvfP2uGBIgFZHKU9cYjz6KhOcsYT11+WOiXX4xoZ9hG/5I/Be//ux/bckcgK3Wk/RXqbIkpSTxFGRo+1mK0EgSL85LtakspCtikc3ZTYWEO63xMQlNSWx3zh7NjvTxxYhF2D+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0crDd8TN; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0crDd8TN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+2Jp70W5hrr0WoCbc8WoqmBotySUWW5r+RJiTDUDkgBQ4ZT/FzGv9MpDKU9Na22S9M7zZG312jcF/4Qc5JreSL3quHShT/hcvg1nlU5QPvVunIeteknO8LATYR25tGFg8Qi3GVRGUXfhgkY5L9V5etli2P7PjymvpmNi7lHpZsItbdxK1chJH3f/p3Bh6SMpyR/+M/hVexrLWbRNQhm3ID5NRltluKSDL5dehTlUjDlsO2tdGxDiniXB6eT+amz/Yne0tB1V/6duOXG9uMopfzP8oatvjd/rN25bcsJGtz5uQ4eubutrOJMZ2jEbinKjWB1Nv50VrWBwLioMeHKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZZ0J8ffQlRyXOlxPhkmTKNBkOf7MWjX0Z9oAOu/Y1s=;
 b=G7xnMogwpJ7KKoju/pv/TDPDkAJETo4Aw1F59oZ0E5m4XewxXsEsiWHxx/Yuwkwt4TdSO+hGL01ouBDbIAuKkLQKAI8R8HO3C86yvPJCYhA3FYQKHcGaMdtt5r6cd6J4DP21tjUgfey6MjPqfBH6o9xh/fEyc2ivXcljV3fStsPB7/MW0QVZhHC/CCm96dKwA3HeXFQD6DNM1V1WYS5ueeBUskWnMb6qW7BLeUJqKX/TD75LUY7ExfMKlgFk8fGSPrs6T9WxHG4OLtghdK1lxdcr++xHea+vJmNLiyeb8WptAo9GJRzRwj6B/vri4mRntjKKG3ITk4pt67uY0H8p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZZ0J8ffQlRyXOlxPhkmTKNBkOf7MWjX0Z9oAOu/Y1s=;
 b=0crDd8TNQ14Fro9EL7tVaKZa3IwD3xQrUQFtTvvvTu8wwnWaSAx2PxLg1nDCRGktYQr14AzzxFe5J076UzVE4wHpShwp1VNyBSxL0asi8yIzcwDdvZJ+gfw7wsDu+UdCArBjiemGYNMJSMNHu3h8k0IthQX2xuRTCNCqeYD73js=
Received: from MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 9 May
 2025 15:07:56 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::aa) by MN2PR07CA0008.outlook.office365.com
 (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 15:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:55 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:52 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 05/14] cxl/region: Rename function to cxl_port_pick_region_decoder()
Date: Fri, 9 May 2025 17:06:50 +0200
Message-ID: <20250509150700.2817697-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db6d953-5d9e-4978-e2bf-08dd8f0b46e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ok+ChPVdKYy+EZnRzv+j4zGje8mtF6E8qOUyhnF4Gx5PIA3s+Snt6YYCg3nU?=
 =?us-ascii?Q?G/Lhw6DOJy/cj79BW8+uhgr32RWK35zsxPhHDRqUCLXGlvefubvw6l1PRaYv?=
 =?us-ascii?Q?HxU3fPNfl/yxM98D/LxsULfdyscOO6C6vLijwqxMgNwrhecSWrkCAWrhIhAx?=
 =?us-ascii?Q?FVS42+ADouaMSVTVp39xlAPYHKx8Sxa21saofoirYw5Xfy6Ao1ekfBYu2Y99?=
 =?us-ascii?Q?YJ5sfrNbbgxS6jFzsRvSFPISA3XCsJ2Hp0tMEqab+73hok8Dyk5Gto4N43ct?=
 =?us-ascii?Q?gIv3Pe0w44Zzr9kDIqoZTEStAzRh9Vh+VTMJs02kA5HHtL4+CYtTzS/3xBZK?=
 =?us-ascii?Q?y1gyM4I6W4oownyyln4dBgDWKHr00cvX6FG4S3lw3qZBiIzCK27EYXkrEiN+?=
 =?us-ascii?Q?76bf/nG/B3oxSWP537U7VvI7P2wWOPQZTy+w90K7EeMqPRRjx4uz7nopD1Ch?=
 =?us-ascii?Q?8ZAfBffvT3qt80Jd6EVC3w08LtCM7m01gNaEmgQg1C7R8kvGjQ6fAYto/6nY?=
 =?us-ascii?Q?aLiGJKVBusKmJowK9heh5o+5z+6Api9znZ1V1Pel+bkvlQX0UtUGU+D1HBUE?=
 =?us-ascii?Q?9xx6J0beiOq5WCnOMyvwBGGm22C2pqQXDiQEjpgZrj9DWAnrBVBV58islscY?=
 =?us-ascii?Q?8dA81KDeRKv72OOo2vtY/ALet0Ro6mpDcwcbmMdaWM5AQpEp0EBjAnPZrbOb?=
 =?us-ascii?Q?AwieoodSZWZZRPzIEULquYyXlyUn7w/t9aN73Ll94n9cUh/w+UyTeIzmyIWY?=
 =?us-ascii?Q?3TG12OcohlNO5DBn6cs+MVtSTufPJeg4Efp8ZHoHYEBRNouWEmGtvmJV+ThE?=
 =?us-ascii?Q?IC56lviz4bpsR0NzaP69edO7DwWUdJOO9BaZgPY+8wTWjknQMjFNSZeMKwS8?=
 =?us-ascii?Q?H7mLrE/ssR1qrfXf7E5uwywWJoEl/tN836dUc7NRvk1Xzd2TboCE7Zq9/Rdc?=
 =?us-ascii?Q?gj7ECDtb4sqcXdwqRg/A03elkcobtU+MFpy4Tf82bCbPTNGrkWr/0/GuCFff?=
 =?us-ascii?Q?3HLRgEIMWKjtMUh/ypKdhD+wYv1oSbfBdQqJsDmN9mxfmjUy5WRbEO8bgOaw?=
 =?us-ascii?Q?rNLWjlJv+ngvSkE5W8NoYvN8NR+XCFdOmP4C6lfY1HBOx3mROWPUV7bVXiZz?=
 =?us-ascii?Q?r/U9InVLouumzbfHrod7DnohELIujHJBm3WbHbzpTQ6tMrPJWzMErB+n91pC?=
 =?us-ascii?Q?Yz+hW8rL4FMeCtwPdDLFVofsvvc3kpX/ApXs6LoR8NFWgpPEWItyaWI5GH7p?=
 =?us-ascii?Q?9kYvnV5zip4H1rjgE7naKd1aY5isZbfjXqJe3fG50SZYs2ijRLmziOQp5L4K?=
 =?us-ascii?Q?teyXReJpZ54G/NX6Ph/0Nv9ztELmdkt8buv4VNGXDnNBZGVmCGDSX9swkVMm?=
 =?us-ascii?Q?iKDVCpu0UamqSyJ5C2t0GWMzy6w3lfJQhDYo+6zHIGHi12BBrM1KA6H9cQTH?=
 =?us-ascii?Q?2gVaThNpqA0dNQszRQeSV0icLX4caLo9mp2MjNm15ddtS/eSQ9bxA4FQ+l5E?=
 =?us-ascii?Q?LOdAs0fdVAWbYlSSQVHSj4QwoM3sVcbN3aiu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:55.2804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db6d953-5d9e-4978-e2bf-08dd8f0b46e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. In the region creation path the function
is an allocator to find a free port. In the region assembly path, it
is recalling the decoder that platform firmware picked for validation
purposes.

Rename function to cxl_port_pick_region_decoder() that better
describes its use and update the function's description.

The result of cxl_port_pick_region_decoder() is recorded in a 'struct
cxl_region_ref' in @port for later recall when other endpoints might
also be targets of the picked decoder.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 569a56afd527..ddcf4e54e2cb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -864,10 +864,23 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/**
+ * cxl_port_pick_region_decoder() - assign or lookup a decoder for a region
+ * @port: a port in the ancestry of the endpoint implied by @cxled
+ * @cxled: endpoint decoder to be, or currently, mapped by @port
+ * @cxlr: region to establish, or validate, decode @port
+ *
+ * In the region creation path cxl_port_pick_region_decoder() is an
+ * allocator to find a free port. In the region assembly path, it is
+ * recalling the decoder that platform firmware picked for validation
+ * purposes.
+ *
+ * The result is recorded in a 'struct cxl_region_ref' in @port.
+ */
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_port_pick_region_decoder(struct cxl_port *port,
+			     struct cxl_endpoint_decoder *cxled,
+			     struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -931,7 +944,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1019,7 +1032,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

