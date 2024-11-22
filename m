Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2049.outbound.protection.outlook.com [40.92.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CF1632F8
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260036; cv=fail; b=iUhOILRA/RXee9Vae8MO/51cyeni1WoTm3pm6W1b09ODtc04VN1RHR7H+mm08O6l43YZ0GDR+fh9Z78ZZGHIJk8Mnzvt+oq9jhcIJIIX/i6TT3QUnCRv50RIaU0iW26ncVEKfl5eM8wXpxI3vAaXiWzuij5Zu095gf7W7yFd2sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260036; c=relaxed/simple;
	bh=ynOE6l5ubcwuJlZbRj7QDq7/lOMQFAnYdOvwEG7Bf2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3zXRj1E1uB6ZKE23EJ2I/93cDd2XVQkR2A4CrYfT1c0Ku0EdK67JcMy17iVWq4tHFfaHfacaYBwolMzdL8gcViWQ+mYA/xx+YU8nwB9CU0cbCy2abi8lwGLE0gUypBjRcUWCVj7UAFOJd9YlRYyNmR1nD7ygPakLV8QcLTDSqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nEA1YISf; arc=fail smtp.client-ip=40.92.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nEA1YISf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/UxeqdlKJMm7c0gJ/On35QKY3wRlOPzvxMsB1jLUPQV5yYDv987jqtoYM7BI3n1uX1AFI+6mcY4neOuzMgHszl73wx18vWBN+ynIEYOUToEipKjkjcGyWLHJ4JP5bo41HH9KvGeF3OVApImh8WuTUwp3jEykbPaubjfmgInjyKqwrRrcElg/wcEEsZFKtUnUimrBQCvurHIp9iVpJK8IpyC3jX+4RsbYhNa+4o7hYkFhDHH7iW5Ir/b7HfxdunzpBtLsn/yV7Dc97S9+pa0y+0AvFQmu1UVslyQLziuMSa1gSbhPPRvL9rdDPZvJL5/x4WRFQ9ZYEy/n0XppQZhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r26cUcpx/6swnVUvlOR2CUfzObeQ3MrggcMwuWwEJTM=;
 b=c5QrJxU1GNRJOWQOY4j98Ry31cVGjSfKyC0pbAzYeTWs3zukcrY68hkgi9dpnhi6b7wUcjClmBXSkt2a8WCgQEMHlCUsKKHb3O2HcM7LNPUaV3ENEfvF56fl1iJOTFbrKBfqIKzy2Y3e6dIzkin0TfYLuIrHGOCQH4PpGJYqiEyvL9PDTb95iwGy3DYV5C4d+QUOKplLQZ6pYrHpKoVlkdLkkodpKccqaDzpZQ2By0dlAHC0dTixgWC761oE11IZahpK0NHfIMf3ewglCidaiFohoNK8SLPLmtKvKNuvzsoozMmTtf6FxUPyRtxS7oV0Nk+96Tn/TKhBY5ZgfHpyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r26cUcpx/6swnVUvlOR2CUfzObeQ3MrggcMwuWwEJTM=;
 b=nEA1YISfiHTPSlfRbwqEaxK6rUlKYT4+/thG4u6PmJ0PWDMHHE7uCq6f6RcFwWEbR9Uf6ziFoc7n9VVe1VV8hOVXABy7dkG0SCSVwTnDyeFcL7zPBNOmqXFCxn/U71QdDeHXHhmx3LQxz64IsmPGtKEz8w1xW1sytWjsWxtOzGOhmBZgY3KR5v2UAS0jH44LR5C4MLNqfdXF0Rl5d8bQBRIOemj77pL17laYCWYCJwhRBRM+Nr85DUC9V9ukWBURYPLsyGWMmh9mRv0+cqz6OEuOOVat8SdIk/nmqmN096ZpyRH4P9zm9wtbTIVjKNE9/SmKcqvIiec1SRP/o2WOQw==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by PR3PR10MB4143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 07:20:31 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.013; Fri, 22 Nov 2024
 07:20:31 +0000
From: Li Ming <ming4.li@outlook.com>
To: linux-cxl@vger.kernel.org,
	dave.jiang@intel.com
Cc: Li Ming <ming4.li@outlook.com>
Subject: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
Date: Fri, 22 Nov 2024 15:20:01 +0800
Message-ID:
 <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122072001.94758-1-ming4.li@outlook.com>
References: <20241122072001.94758-1-ming4.li@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID: <20241122072001.94758-2-ming4.li@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|PR3PR10MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 991bd980-06a2-4f7f-a9fb-08dd0ac625a9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|36102599003|15080799006|461199028|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPDTHZtF1leGXt42jCO6BCNIs5QJzzHzG/5u3PYSDqIj5b+KfifVQct2KMTj?=
 =?us-ascii?Q?cDWKDJfLp8yo4sgXLbzlPBU9+EacN7A/4FZIYmBn/CF5DHagmGB2ygbl+Nju?=
 =?us-ascii?Q?Vepk0G235SYhSU+fy5YeehdTtWdbqFsgSjG3PKouf0yMkygp41bIdvofNopS?=
 =?us-ascii?Q?F7zbbNRsq0uWsO7pR/+oAQxRrwN7xD25BKBnuPnFyaQtXYbpuHuIwa9LGCxr?=
 =?us-ascii?Q?vRGi2t3rfu9AoNPGVpScurHdnGVHm1KoaVAzCsDgbcR7SLMLvUK/6X3xYGtD?=
 =?us-ascii?Q?dSkgV8P4fTym2z0Gd7alLSA20QwLJ1PGFUZ2wVTk1LpEXVHQA0COd9eT7Zjk?=
 =?us-ascii?Q?vRdEB1jhP4WmlFdJJGVI3UKDDzsJKe8NSOdw1UTqZhlsUfs+nTWQ0C1vuOVy?=
 =?us-ascii?Q?T00nlgRGn331DZp4q383vh37j8r3z6sUqyBrlY+nK4tU3m/8M1CExkyntmM2?=
 =?us-ascii?Q?9xQbB0cwDF7i8sDZBJFqXy7ajXUBvtLRPRaVukHErR/faC+PR7J+eRZXJ67d?=
 =?us-ascii?Q?F7n1NObvcR59E/ejhjOck4LiLweNhMhAfmaxv/zryl0o0bYnqrk3dxvpANMh?=
 =?us-ascii?Q?skPXXYiCaWmJ9fHUS/byltuxTpnEaVn/7XJjK5S4I2xDsw/rXI77UiBhpZPY?=
 =?us-ascii?Q?rnlaohsxj1tDGRYm1pNejsDYtlSXA9TI7fKNDLAcZekrQfXiygMCwXiGa+wL?=
 =?us-ascii?Q?c7RTzFEYyCkrwxZUrRQXEZF1M6KoNqk7717n8t08p3eNT+a9lnB4acnzoPWZ?=
 =?us-ascii?Q?TalI8KasO4YoUAHucpTybQIsLAe8FjNMpycMYsomwgNr0OrP/EafTH/PcEI7?=
 =?us-ascii?Q?0eQgw1Scg4o0Sh9+DOGXrBibN8226HgUXdUN18sqhq+JTH4RvsPd32fAmUa4?=
 =?us-ascii?Q?em+AWOvpR0WeOmdZru8DSgaGhekneBLFZ0FnwvGy+vlXax7K9x2TyxwQIPWG?=
 =?us-ascii?Q?+ieA+jS2ERq+vYF5yX2AnhPEI60kwkgbVX1pMqMkSf6CYEkft/m34GKlkdWK?=
 =?us-ascii?Q?78KloDnrwEHcF+Z0Unz3HWaLUIzaCqDKTVx0RX2alNMzf4jG8QNRvnWNnqS5?=
 =?us-ascii?Q?ridXeeg0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcsPqdBHhfwGScl9wnSiFiosPo1PGLjTyKaEEXiGSSyK7w7JqRSGV/xhm6xX?=
 =?us-ascii?Q?so10s6qxClOex3uFhpSr6rIPOTHNhbsi1LSZqm1N3vUDTTsKLabMnhKEFMtC?=
 =?us-ascii?Q?myMmPatc3nQSP/g5920DK+LXbh6k6M+BTnL4duI6ThdAJ7RoHwsaKJkzVtgH?=
 =?us-ascii?Q?mBU8QOFPAnNOa0JBi4Tgk+gOgBbq4+dSASa5oHpZCvQOVpdMM6d862IGD7tq?=
 =?us-ascii?Q?qHnn7wDvw0E19a8R9Fmyk/L3/8HCIN0rvHqf5l4cE7ImrOMkYIZWBTxNfMZy?=
 =?us-ascii?Q?DwvlYi4OSBqfggZ/+Iqp0HsExEMgsnErlQnnuFrRi9w+wRuPjMSSXt96QcFL?=
 =?us-ascii?Q?l0qbPloGsOXf4pA4vIg2zTHM7wgxpDOmd+18klDOd4uD0i2rpeeyXZDpTw66?=
 =?us-ascii?Q?9SlQh844Wfp1ZeZ5tO9y0I762PASgeqPzLtK4Cd3R8dB/kOdVNUOEtpB88i7?=
 =?us-ascii?Q?WR/AHfvGjInZTGij3TPsKhuzXXWPP21zXT7LUM9GrKNmA05QEUY1I+dy265H?=
 =?us-ascii?Q?StpS3wOsUDBnvQLNuq/yf6c3nJRs+MoseFC1PFf7wgibr9Sbq3k9f+qia8MP?=
 =?us-ascii?Q?6IN/fiBgWEVnax2vHBQVmQv/cCib9JywkGrN5qC9urG1i/42Ghb2L2LwJYCN?=
 =?us-ascii?Q?utW9dmx+gZVJ0AIzYTcTFRnUvhGTM9uGiVNgSjh/IMX2kHn22BRhqVgx34GO?=
 =?us-ascii?Q?fSfs4o/1wbGYoo1qbfMUWqQRu5TkzNHpCUOjL3dhgHesHpfWyqi2zdfkMRO9?=
 =?us-ascii?Q?H1W5NTcpdTQcQN2Nm6fSb9lT2+TOcCvnL+T3PyYybc1iwOWvgwKQuyR2nru1?=
 =?us-ascii?Q?y/u237NIpYHLz1XV0lBD3fx6RpQ6WUYe8RbmrhMRQiZ7UjrM90+YqWllHy9r?=
 =?us-ascii?Q?StESGphEJJwajCjHB+tY+gMtWiOBp/LZHYOxL6emd00IazVp5/xTr/f/pcUg?=
 =?us-ascii?Q?jb7WGOiJ5+NZf+R/1uuEFGdc+RX5GtuHL0AYL845Vf5A4Rz4HiFwok46du5o?=
 =?us-ascii?Q?/mRaoYnLKaYB8A/hbMYOEPZRVqnch3cW7rph02ClJ8s+SJGAeGN36AOw2kjV?=
 =?us-ascii?Q?0zIC6rU5MyST8tmhMvIqQUAxavyTaOQrFL2Z9KfhAkajN+LBWs1Dvj+C5qS+?=
 =?us-ascii?Q?zq1fgtbikKB9ePd2xLz1t9rNrfN3BeJErMA5kb0lZbq2gOZQz9dzSMNxWh1g?=
 =?us-ascii?Q?wJnsNTqDmryIaAHkiTmUrF0PamsALdXezIrR4eN2ckwkaO6Yz8Fjs1f03rs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991bd980-06a2-4f7f-a9fb-08dd0ac625a9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 07:20:30.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4143

cxl-test environment always hits below call trace with KASAN
enabled

 BUG: KASAN: slab-out-of-bounds in pcie_capability_read_word+0x1df/0x220
 Call Trace:
  <TASK>
  dump_stack_lvl+0x82/0xd0
  print_report+0xcb/0x5d0
  kasan_report+0xbd/0xf0
  pcie_capability_read_word+0x1df/0x220
  pcie_link_speed_mbps+0x6a/0x130
  cxl_pci_get_bandwidth+0x68/0x1c0 [cxl_core]
  cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x780 [cxl_core]
  cxl_region_shared_upstream_bandwidth_update+0x257/0x1640 [cxl_core]
  cxl_region_attach+0x1025/0x1e80 [cxl_core]
  cxl_add_to_region+0x121/0x14c0 [cxl_core]
  discover_region+0xa5/0x150 [cxl_port]

cxl-test environment creates cxl memory devices based on platform devices
rather than PCI devices for testing. but cxl_endpoint_gather_bandwidth()
always assumes the device is a PCI device, it will cause the issue in
cxl_pci_get_bandwidth().

The fixup is that faking a maximun bandwidth in cxl_pci_get_bandwidth()
for a platform device so that the cxl-test environment can be used to
validate the functionality of region bandwidth.

Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Li Ming <ming4.li@outlook.com>
---
 drivers/cxl/core/cdat.c |  5 ++---
 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 24 +++++++++++++++++-------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 438869df241a..c67ef0d1b1a6 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -634,7 +634,6 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct cxl_perf_ctx *perf_ctx;
 	struct cxl_dpa_perf *perf;
 	unsigned long index;
@@ -675,7 +674,7 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	}
 
 	/* Direct upstream link from EP bandwidth */
-	rc = cxl_pci_get_bandwidth(pdev, pci_coord);
+	rc = cxl_pci_get_bandwidth(cxlds->dev, pci_coord);
 	if (rc < 0)
 		return rc;
 
@@ -809,7 +808,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
 			return ERR_PTR(-EINVAL);
 
 		/* Retrieve the upstream link bandwidth */
-		rc = cxl_pci_get_bandwidth(to_pci_dev(dev), coords);
+		rc = cxl_pci_get_bandwidth(dev, coords);
 		if (rc)
 			return ERR_PTR(-ENXIO);
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..1c16c06d201e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -108,7 +108,7 @@ enum cxl_poison_trace_type {
 };
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
-int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
+int cxl_pci_get_bandwidth(struct device *dev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..bd0448c3c9a8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/platform_device.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1032,19 +1033,28 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
 
-int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
+int cxl_pci_get_bandwidth(struct device *dev, struct access_coordinate *c)
 {
 	int speed, bw;
 	u16 lnksta;
 	u32 width;
 
-	speed = pcie_link_speed_mbps(pdev);
-	if (speed < 0)
-		return speed;
-	speed /= BITS_PER_BYTE;
+	if (dev_is_platform(dev)) {
+		/* PCIE_SPEED_64_0GT as fake speed for platform device */
+		speed = 64000 / BITS_PER_BYTE;
+		/* PCI_EXP_LNKSTA_NLW_X8 as fake width for platform device */
+		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, PCI_EXP_LNKSTA_NLW_X8);
+	} else {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		speed = pcie_link_speed_mbps(pdev);
+		if (speed < 0)
+			return speed;
+		speed /= BITS_PER_BYTE;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
-	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+	}
 	bw = speed * width;
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-- 
2.34.1

