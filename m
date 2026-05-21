Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB735C1BD;
	Thu, 21 May 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353300; cv=fail; b=YLUOVNbX+9Zk278Pvzg3gD2BUhvVnY3YvKfw4og+XIqsgbdAFY5Hw/1CELDlTh4g+AQh0CpH1FzngC8GYNTpxIis34Sb7z65rgjsC28/TXi3OhBbcSpA6jlunemYIUpNIAfbzUMXE+HjEzDNNZthK4jXWh/v/oWstUDUCZRDKYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353300; c=relaxed/simple;
	bh=Bd5UbG2MistxGqDVLKze4mTsTDlR8AAm55CsZcB9tvY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ewvm1NOq7epQTrcbKKTxroVdlZU2lIYRsTVZ1V5CcfGEYbPSuiJOf7+YISMNseSGvHK7eValCAZaaHadRvJU+mTsArW/S95nZ/I/JTH6UtHjHFbOwxLT4GP7MFPMARiGc0xxpFTg+yfZUZosjRAChW3qAtKgSxjrxcYZoRRcoWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLjGj2GN; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLjGj2GN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfPzD7xWw+c7k0wBIoW3evkm4yjbxHkxx3ftjyYG2U5tND6WymFgCA8wMYgmo/pJiJN3sOWu8cYjRra6BI7N+5GVzx/m/kjRu1vilCZDRF4Z2INbyFByNTDBFb6eaNZtRZTb3gc2JP30V7rjzCHWlBUIHWnMwJnod0L/ChK89MM4cOsM/AjVl1tfuy+quY+Q4kwTgUl7OG1/lqLt1yyl/AGmoUJNEkUx0BFrQbE/AOhGltFQ4W8/ngH7SZiyJzQDBi9xACdKEg6v5fciYTTuhSeIua8+bILSkfDoXajRv6n1TNYDYhmNDb9SuXZz5/t+YNCkxKeYEHtJ0Z7X49lpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0QMmz1YOoP3BgFoa6Md86K4aZmStuhPINXTDUK6xHU=;
 b=U1b5ey48QLSJmdG3Mo8iuDXcMon79hPaKFrfJCaJYBe9Canqx6Pf6IHmoRfNsL7Y1So0OfXJ+1cS2j7NgpEjDJOdXfGZZEDwqdIPe/5yWmVNY/OgixlQ3RfAH2i9xcACBOS0xm3UP7OZIULD3R0O1umjgbTcO/lAJNb1JF2W9zowvTs+xaKMypMsc/0JC1r9okapWJ0h2JSnPtAAVjlIweWiJkLRfympe27SucQu94yQxbsrYWchCrs4PbOJxHLmlRoAZK7gvfgUubtjphuA20N7a68yRtlBFTb4PuVcI9UW7YmiK3Z6WiYRM6thAAF0J2S/QmCqeLDte49aK6L9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0QMmz1YOoP3BgFoa6Md86K4aZmStuhPINXTDUK6xHU=;
 b=eLjGj2GNjfQDBQdhUZbFuMK+N24UxiL34q7MNc7N+7ZFOyqW91x6/hviw7MgUkT3ovEeXVSHDl2sjVoQdZkAeBe+fifstwISAExpqo3FAeUtT8OPN0fr/tJg/tAgztQWMMZ4BqKTyRoxQrUrdVaPfAcPkoOVVq104qPUecUAce/w/teenzLy9kxAefq8YpKiekSqDmgUwwdv6T3cRWtpknMX8uQqObcCIuBvEbS5GzjK5OntUgzVTpe+DCrm/39u3TugdmjtdLlCJGUBlyzW6Zv2p/li2eTjpFPrEXRwNA7+PSywWxI9CeV6+wgi0jEQXv6IzAfyN+rAgoK5xPem0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 08:48:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 08:48:13 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.ne
Cc: jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH] tools/testing/cxl: Support multi-decoder shared-dport topology
Date: Thu, 21 May 2026 16:48:06 +0800
Message-ID: <20260521084806.28232-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe665f1-2707-4287-94de-08deb715b16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|3023799007|6133799003|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IYQzfa4tuv/qe3gyScKCr4yHCtS8IxknwDYAzecWQXizpmtRm9BxxuACNY2d0n/TP/WPu7v2BphNxLEkrvMiXujrp3qZg0VoyqHUJC3BsFzud8WTH24aS7A3DZz0XPb4FC8PEomWZWb9GiO/DOHr1hi+3BfW8SDJy2UzF985flrQtkOpVMf4jGSd/QAOXcjJuzlN0ABhVQCskCTgeKKi69S7CV3aYpYqxoPLDAO9f3akcb3dXwUjUvA7BzTNbV67OQJTnDUBH7LGf/Xkzakg+q9+L6p/beB/JhV/RSXw7TVVLqWpu6/rCm5DOfhqZ7j5uEoxGZq30au9aOdhTczHOxQnWt/tnYy4NNkxMkIuIpKHgUQJRbSLUD1QFJvMZaDHKl7CCoEXOtLGyzOAXAK6v1OvnNkhlK0EI8pem2W/i+TE6QtaL2QdXUfah4F4VgYiNi0pLXUF/BoJiezUjgA9vOMhztGh3VJqkVatjUzibwvXfi9Sz2FFiHx8T6/xWuIRTGPsbUHAiRnJm+1mwWo9OW5XCySvLiWOXfd6M0uIWYR9blLOd5AOUGC8EbKbTVmjc5lQo9lGm+ZtGH6bco3KtNjoE7aQcFP0BgcgMsaekcHs6yhwkX2x6g9VMLkhDJXg9/KPnc4mEMmFbaZF6RHjqfsCAUlClVk9co56qWQGrPhEFDcDDc1jyPgbrZtXJ2dVwujcOHuU4x1vOqHe/ahKfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZwcbhRg4O01Z/FxywHGBDk2YmEXMkK6ISROYxzTd7vPTXuo9NIWfnAWHK65?=
 =?us-ascii?Q?j83QARhTviPPZaMxRMzlJCNxzV5cM3hNdfahXFKPPMpduj31IOx21u7iNZIN?=
 =?us-ascii?Q?VhRVbjaXqHcQy5fCcZAYXJVjhrmnhyKwqENcg2yyeCwo16C2xoC496A47hWH?=
 =?us-ascii?Q?7AWcpOqMgC2jv5hTFOMAhExkeyQ1YoQNJ20sb2rK2MQxyuWlkgCa2he9r56W?=
 =?us-ascii?Q?HViynva+UAPVoWmQTY8HS6DX8SNpQmwNPvbi9CExvBK2E32VT28bz54KbhYQ?=
 =?us-ascii?Q?TWRrVQErJMV+tR37tdMA5yKYRxNenLKqotxz0q+fUQ4fqacKoy3J7BQY0mZY?=
 =?us-ascii?Q?3u0HuGCraogcvnfjfaF4nmq7Vpno4GLn+RiI7hJEHR8h9A3RaNRawvlwMjg/?=
 =?us-ascii?Q?9exUcj1CQ59eE2/7vlUl+ewTGHa16E1MBSp76JeZZ+uVG8aZzJUE9V3pkL56?=
 =?us-ascii?Q?UiEnry2FEYoZquNQtGlKCr+62CgumfJpH7quISB/GuvmNZ6Q8cZ3kpfLyZDY?=
 =?us-ascii?Q?R5NH0aGBD4QwJm5WtprXrBUI0vecH60fYoUBxU0NabXnPn9r2sj/tvyP+jaJ?=
 =?us-ascii?Q?6uxk1nMQ7S9qPl8YZlMi8OehcQXaCAZUsw89gI/fNFVNax/dCd80EATtc9dP?=
 =?us-ascii?Q?qFRQfGK3n9xnE+os+/i67ubG7PIkPz7TlkNRKfur2HipzZxUuiETUu1WX78X?=
 =?us-ascii?Q?5i7aSaPDzD2OKi7jB1AlUZshrhhZ2HQKoT0rqtu/ggv35HhpovVIoBqcCPYn?=
 =?us-ascii?Q?E4g+uUj3ToHk7xd/QAbTMtgITDD4dxGG03jQWq+BG3bw+3tOPMxKd0c1DtfN?=
 =?us-ascii?Q?Oj4nM7VfejHmDWvqz8R/+m8DrAoqMEzrM0h30AoofxpVzCNZo8ZkHZOeqATx?=
 =?us-ascii?Q?TTqCCCZbwaXanzJ6/x181awU8IDq6qrXek/r6aR2k4eadIvk9ZcQ78gtrCKN?=
 =?us-ascii?Q?0ZMzoek7yICNlkz81Xeo18+6uPS/W1MnedB0LhmyfxbIlVzsCHuwYodZVhND?=
 =?us-ascii?Q?luOO3E33fU5mg2y/99NqRt9WjEncaiplFGJdUshUqYjaTmgJMNbqjCmPooJB?=
 =?us-ascii?Q?bD5/KvoVwNcMNbClhIP3J/bePO16R1qTX5d5T4f6UMdy4hbOikh5x097Py0c?=
 =?us-ascii?Q?qu44dOybSoBnRU6jyoaWbJZ1laghvj4ZQD4nFvGgSDQLNdrHWiSuoKMrKkJk?=
 =?us-ascii?Q?1K9L+vAvxnkavkOnF9eT2mZOL3GVH0sy172XRMymckdcsARGGfW8pZq8Pedw?=
 =?us-ascii?Q?TdqbufLxWF+CTcjbUi6WUgDxyByyYVhh+hPNM68jB+ni4OrGl4sJcXrk23Ty?=
 =?us-ascii?Q?jRejwmO8xVR9H+nQlGgte/imqSSCs4EylccfYHlRz9LrjoHkn/ueDhdeTFFn?=
 =?us-ascii?Q?fXxRmk0gycoJQdUSVmDGtr1U0ojA2tFkniDjV6tqIN+SqFoW2BVJlc8IY19/?=
 =?us-ascii?Q?BlGMcKzPB+ZRdZ6LpSibSCGS3mLu7LMK2CFXiQxkn7ezfr7Lq77pJjwvHtGk?=
 =?us-ascii?Q?ynEzcsUVG5UqCrsFcwQXA758jZbW2xYlQBe6L4gT0fMz+VBE16UGf4DXCxrM?=
 =?us-ascii?Q?BqrzDXiIRR2ssGUTwighImVLK7pX98jwEb9FFeBuPs/CufiVDghVg/uO/SoP?=
 =?us-ascii?Q?xmbKmwAofOmMI5V/iZYAQ3bwotljuzzWtzaTsEqI09zjKZfi7b2FA0OWXBRw?=
 =?us-ascii?Q?2z51LSjc4HW323u5Mgl7mBltm/j3sXG98LVzB1qiA27h6QpD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe665f1-2707-4287-94de-08deb715b16e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:48:13.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: momGE93brEdwi0LD+1LZuri6hy+0zEDmXcCCkgS3mWdSyNmhQPv5yts4r5I+9B+Gr8aNkaW0DIaw2/Xs1i/hiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

Add "multi_decoder" module param to the cxl_test emulator. When enabled,
mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
and cxl_mem.4 as a second auto-region carved from the next
mock_auto_region_size of HPA in the same CFMWS window.
The result is 2 committed switch decoders that share the same
downstream-port target_map[].

This is inspired by [1] so the emulator can detect and test for scenario
like that.

[1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..929bbee471db 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool multi_decoder;
 
 #define FAKE_QTG_ID	42
 
@@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	WARN_ON_ONCE(!cxld_registry_new(cxld));
 }
 
+static int decoder_by_id(struct device *dev, const void *data)
+{
+	int target_id = (int)(uintptr_t)data;
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+	cxld = to_cxl_decoder(dev);
+	return cxld->id == target_id;
+}
+
 static int first_decoder(struct device *dev, const void *data)
 {
 	struct cxl_decoder *cxld;
@@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
+	int max_decoder_id;
+	int region_decoder_id = 0;
 	bool hb0 = false;
 	u64 base;
 	int i;
@@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
 	 *
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
+	 *
+	 * When multi_decoder is enabled, additionally program decoder
+	 * X.1 of the same endpoints as a second auto-region that shares
+	 * the switch's downstream ports with the first region, so that
+	 * the same dport ends up in target_map[] of two committed switch
+	 * decoders simultaneously.
 	 */
+	max_decoder_id = multi_decoder ? 1 : 0;
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > max_decoder_id) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		return false;
 	}
 
+	region_decoder_id = cxld->id;
+
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+	/* Place the second auto-region right after the first. */
+	if (region_decoder_id == 1)
+		base += mock_auto_region_size;
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
-	devm_cxl_dpa_reserve(cxled, 0,
+	devm_cxl_dpa_reserve(cxled,
+			     region_decoder_id *
+				 (mock_auto_region_size / 2),
 			     mock_auto_region_size / cxld->interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
@@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	/*
 	 * Now that endpoint decoder is set up, walk up the hierarchy
 	 * and setup the switch and root port decoders targeting @cxlmd.
+	 *
+	 * For region 0 use switch-decoder slot 0 (selected by
+	 * first_decoder()); for region 1 use slot 1 so that the two
+	 * regions exercise the multi-decoder / shared-dport scenario.
 	 */
 	iter = port;
 	for (i = 0; i < 2; i++) {
 		dport = iter->parent_dport;
 		iter = dport->port;
-		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		if (region_decoder_id == 0) {
+			dev = device_find_child(&iter->dev, NULL,
+						first_decoder);
+		} else {
+			dev = device_find_child(&iter->dev,
+						(void *)(uintptr_t)region_decoder_id,
+						decoder_by_id);
+		}
 		/*
 		 * Ancestor ports are guaranteed to be enumerated before
 		 * @port, and all ports have at least one decoder.
@@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			continue;
 
 		cxlsd = to_cxl_switch_decoder(dev);
+		/*
+		 * Region 0 (decoder.0) keeps the historical shortcut of
+		 * stamping target[] directly so single-region setup is
+		 * unaffected by dport-add ordering quirks of cxl_test.
+		 *
+		 * Region 1 (decoder.1, only programmed when
+		 * multi_decoder=1) intentionally leaves target[]
+		 * to update_decoder_targets() at dport-add time.
+		 */
 		if (i == 0) {
 			/* put cxl_mem.4 second in the decode order */
 			if (pdev->id == 4) {
-				cxlsd->target[1] = dport;
+				if (region_decoder_id == 0)
+					cxlsd->target[1] = dport;
 				cxlsd->cxld.target_map[1] = dport->port_id;
 			} else {
-				cxlsd->target[0] = dport;
+				if (region_decoder_id == 0)
+					cxlsd->target[0] = dport;
 				cxlsd->cxld.target_map[0] = dport->port_id;
 			}
 		} else {
-			cxlsd->target[0] = dport;
+			if (region_decoder_id == 0)
+				cxlsd->target[0] = dport;
 			cxlsd->cxld.target_map[0] = dport->port_id;
 		}
 		cxld = &cxlsd->cxld;
 		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		cxld->flags = CXL_DECODER_F_ENABLE;
-		iter->commit_end = 0;
+		if (iter->commit_end < region_decoder_id)
+			iter->commit_end = region_decoder_id;
 		/*
 		 * Switch targets 2 endpoints, while host bridge targets
 		 * one root port
@@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld->commit = mock_decoder_commit;
 		cxld->reset = mock_decoder_reset;
 
+		/*
+		 * For the second region only target_map[] is set above,
+		 * not cxlsd->target[]. On real hardware target[] gets
+		 * populated when dports are added (BIOS-programmed
+		 * decoders are read first, then dports get enumerated).
+		 * cxl_test's order is reversed: dports were added long
+		 * before this point, so re-fire the update here against
+		 * each existing dport to mimic the real-hardware
+		 * ordering and exercise update_decoder_targets() with
+		 * pre-programmed decoders.
+		 */
+		if (region_decoder_id == 1) {
+			struct cxl_dport *existing;
+			unsigned long index;
+
+			xa_for_each(&iter->dports, index, existing)
+				cxl_port_update_decoder_targets(iter,
+								existing);
+		}
+
 		cxld_registry_update(cxld);
 		put_device(dev);
 	}
@@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(multi_decoder, bool, 0444);
+MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

