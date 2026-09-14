Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432441BA69;
	Mon, 14 Sep 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376974; cv=fail; b=Eotkwb+8ET3FWWOOQKEYRUlQBujaC9RQ6La+fEW8/3fhFDFs886ag7Rbc2ar2Y1zWHuuD7HxQ0rYQqAvBBxcLKBeQ+j+xBBfDr38SKMU97fWeIaFVXXcF9/ETiXJY0X9tAguHtBshTjYlI1H1piZziVDY41dpJisUrJfzcic3Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376974; c=relaxed/simple;
	bh=YiQfVrBcA3EoCQEcbG/oRGYmlhaVxOWVz1vDAvUTFHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNb7S2Zn4gn7Ys3Qo3PJuPgRJDRvYPMhxWN+YqdLAWqxRrxVdUj9n8/tVT3vlMiRYzauuABHvrP8aytncxYiml05CHIsTn0pfhqRbVOhI7OwMRaNIsDVKPudx3h7jbXNCexLxaT0I4F8yb1cqS915I7y+VIFK51kwk/Em3DWakc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0nr16P8; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0nr16P8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIerDU3CZrzEcUUQYTQ04bu8ApbIS158UI02ZBhenmunb7zcm9tj5ALjkeQUxUnDq1pjVkFiQI/2E35oVUP9q624Y/DhzbJm5iaXyBkPRoxaDPQmTTRrtlFvsxUVFA3V25nqfLjTw3BbQssgOvhm/zMyK3CzFy4J0lrxPsXreM4x6lCXmZTz99Ct4TAMFCrPw33pTojNKzkUjG9W43C9AtNE1pl1CyP89Hrjh98OtxUCCFWOb/nnJdgKE9nrULcKVVLQ78DzrJxcDDZC8ax8ryYxWT0ejFsDiM312aYbcCl45O5Dy0WCQJEsgaMKtpB/gU67TkXdGFycsOsdCX+FjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQk1NGdsSHBpQZweoaJpg5lzZMTygxT/6t1+3GZX5dI=;
 b=e4pBju4qkPJ79YADvjz6GoYSQYTG78Y5l6b+76t8n9BMjv9ObUBiqRE2P6tRszRgKHOaeftw0ZoKGMtRpNvsXUwdAjBpHuD5IB8BHO0oKd2TLldH/8YqNok2PgUjv3y/fVgEQPpKMwTBOpXytZj6FEDjyb4QEqIdcu8IuEN4CaXXm3J6XQd7Aw54PbjiS4waiGVgVwcLmfgfycqksLONSU6o/m/+DISMExJLXTHQL46DN1XsRY8NAtS1WU+4dWqQ1Iy2hdrajlliMjgh1Q+KitpLGo0l0d16M9CtqDMobNvFgfQ5XigukqFaxgHHsfIPV+qms4SgHNg3VkDpMH2EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQk1NGdsSHBpQZweoaJpg5lzZMTygxT/6t1+3GZX5dI=;
 b=j0nr16P8jgZOnP4oVUxIjFsGirEKotJ9aaXc4TMvOHB4h6e2AiVX/o9g1ppsviegdJwzBuzw+4XZ9NavfzsODgyqcR9pwI/ls9N2TTCfeyiEhzwqU8GpB5GZTI84ywhejBpEZQUaz6xf9KcA5YPH1yGny6xvCi8iqCAZUi1HdiIiy/Os9ohIqk3toJAX88mabRSmN8yvqdsQUK86ukmoSVNU9NQp0TAGIdfug30aj5NBsoEnzUHuuIGEX/CUVQ2Qat4pHrGRMN1ozHkDSXcqz5ahR94n76VHb4LUXWVa7g7HlvuWkgp3dx/GUhdkmC40g98lazwJCZC8xzdWCOtBKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:09:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:09:28 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	newtonl@nvidia.com,
	mochs@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 3/3] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Mon, 14 Sep 2026 17:08:58 +0800
Message-ID: <20260914090858.19181-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914090858.19181-1-icheng@nvidia.com>
References: <20260914090858.19181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:d10:32::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b290be-ba89-4195-12a3-08df123fe161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0+nwEf633LygwScX5Hnf3ktPBldojK57yC3W3AUTUbS9r/N/Vc0iluflp2r8OtWr6hxu6sByOhDzkTwZbj1Wg7WY7/rtp7W1MdaQNQ+e85nUwrMfIJppZqtCMgzI4wZu9S7s/g+bbYBbx1aLM4PS+6QW2RESBRaPTOHZcIHMyOz1awjcsDt7OpAR45c9KMJ/OwYyYPiWBCYxHSpa6JvsX1CsknTKTAZ8XK9mZI2PBe255Kp/pQtiu7cdkDO2gX1NhsQBJ0xYMRf9utDulvavsbSXzddGHqT2evM5gm0nPWzgFBlSZz4ZMf+bG4KeEZoLTvcaA5w05/teVBEGAf6T5su47pmeoqYF7IH33Yqn/qIJZwxiPDY5laQ9fGphNoZFyWDC3SrAZfjPShJL/9cqOMAUuEIIWPr4PxRH7h4uUkoZKh+RS1YimkghoIL2mqx6ZjCU1cFR6PlQYqYWJlQeU7ykVlLy2ObVDaHJIQb48KTU2g6SHOV2ObR3O81METHeb86plcsjGlYo4tSFFqROVkVR9Ct5p6HL/+WCl6QN03JHPo89P+Ul8YOVm29CcYx5YzQkqsaxYMRvVD1dsalRaZew0Jfc6E6IxT3iX/je9slX4nIG/lRSyZONkxt9Uk8A8Bj7FklU6R1umHOmPyt+6tUqPLQgDTKWm/SkvDVpKKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZLxTAjL9hgrLFaEnstQTuEDMTSYx+WsBB64DiEwKrVRoEOGjcrH1r8eau/d?=
 =?us-ascii?Q?1mXDzBxtAKXipc+Madf8PUa0OiJLQWSskHXppqwmQXNJcJNZH3ySL+OcKUWn?=
 =?us-ascii?Q?P3El9jrCYVddriS2/j/SkyIsC1GkmCcrLaihO7vZEiMRALZlj6MiWlifpXkx?=
 =?us-ascii?Q?HBu3W41JQ3hPZwaTGGXxDAT643wm+jTG94qA4Ko/2XzDh4ZcC7n33d6l/sch?=
 =?us-ascii?Q?vtlsUujGXwPi9zdfIPkJtNEhyUnuqOuV5D46jIJA7YO2CHpzrHKD3bGB9m/l?=
 =?us-ascii?Q?9ubnLQcHHUB9Oz2Sr7zR0lJITi8egyzUo3EyTPLXBnwJ21JNadqRyh7pxwab?=
 =?us-ascii?Q?fJaT2192HW2iVJb7aO+wF8oDC5jmPbucY+RcCgXErftcFy3XHIXNn7/M/mpL?=
 =?us-ascii?Q?ORMPtwTJ0cA3AggdCS6iRFan6YVgx/PyEjZZowMH2CHNy2pWaOwLU+kUcqbi?=
 =?us-ascii?Q?+u3saT861BVr88pmhNeimBxIh5Zsn4QI5EsdNRdwqJDI9JJMBUpMmBWaJm7o?=
 =?us-ascii?Q?MsO4QV7I1V/s9Nr/k817O1SCV60GND45s6VjyWGK61elOHmc6z+vppuSsRen?=
 =?us-ascii?Q?T61XEhWp45JvQ3EMwTcm5wC8Ft9wXfFuMC270I0O2SanuqKfbL9Lvk9gL7Fa?=
 =?us-ascii?Q?OFPSuwQ8/29wf9W2mFaqglYRLf7ifgtEsNeUzTQ01bI083i/YqGeJtOGEu5U?=
 =?us-ascii?Q?ANVZs+5K4V9Izx8zyNimJBFwkp6oRe1vyqJHfg5uPYr7X8lcN6Knkd7FOAAS?=
 =?us-ascii?Q?QhLRS42+an2coK7+XB4gcSp7uL+k9L9FQ/Ji3pIjwAFkrWZMhHvtXP4o+s4Q?=
 =?us-ascii?Q?nuacuICr0OMnP5fhAfgDXqfMwAo3p2yuana6c0hs60YY8E0IAKB7XeY2kwt8?=
 =?us-ascii?Q?SZoAJ8Vu0t2ZF65oJQGllDYCGNDRjuFLi1spgkBPw+sC9q7cQWsEwFzlxGF9?=
 =?us-ascii?Q?4zW20GqRWAVZtbNzbBKWLN1pAuhp54CbEagKb+21A9BcA1buvtpFI0C2rDa6?=
 =?us-ascii?Q?q6VG7Nj53+najt4hQe5cFFYCNCfZIPy9d0goHHZ8RijlwWhAWvbTted4DtdB?=
 =?us-ascii?Q?zzgDwUiz+Q9VtBfTZqwunjzYmnWGYguWLTqwIyJEKPQs83ZSiSp8Mrd8+gT8?=
 =?us-ascii?Q?uIU0Jlhkzp23yyqj1CYIQynGyaaqKszC6vjYkHhbZdw+wI67Lsgq/LrbzeKX?=
 =?us-ascii?Q?U6gfojXHdj5hvsmw7+ML/KnmLYTd3tH2/kG+SDYn7JWRkk1VLNJkSK1Y+E5Q?=
 =?us-ascii?Q?r/3mmDMfaETLhWOff/uP2UnOBF69XL2phH7rv1pIW8C1IhH7/hxX5tdaSK25?=
 =?us-ascii?Q?XRNI3L6J1i/WOxundTdz8Zd+YKxvu+ACqyF7TJtnd0NYxM3WKcSRkld26DuX?=
 =?us-ascii?Q?eGqPLZlS/nvaII902rx/pwtDDLCe8tDoWWRsYQFVZGDpdZnKvZvoA4Zuomx4?=
 =?us-ascii?Q?cQNJj0XaHo+HHvLMVePsramroICe+KD+YbP8ThIOZpdubyxFaeHFyHErUkH6?=
 =?us-ascii?Q?rtY47aamosGrF61AP9uHtwb2NubAOmXZ6aVtV+nwyQpDbZnacftp8quhp+Hn?=
 =?us-ascii?Q?FfuH/hnCag4e0kqQfLfBckT58mJdhLMAt9ClgjP5PQoKSnsPtuqRr860We7O?=
 =?us-ascii?Q?SX7IIkuuKb2LRi4BMYpFJ9uWXNI+o1ktJd8JWz1pkh2fOJJ0dYTVH8Rsk/ic?=
 =?us-ascii?Q?vl/17DNmgmq0IkT3qSJLQiuH1SpPZ+s+db5mwhSVq6qe39axiODTuqtvxXyG?=
 =?us-ascii?Q?1SqQNKNCgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b290be-ba89-4195-12a3-08df123fe161
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:09:28.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKluTTsPo0pXvsZvHwPeVxWdyR0Em6e+qIpbXwgKiQLVyLyKgU/WgO2fBczetERUsYmzU3ZwgTi8AxSj76FrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

The kernel now allows committed zero-size HDM decoders so BIOS can lock
empty decoders; cxl_test needs to exercise that path.

Add a mock_zero_size_decoders module parameter (default off). When set,
the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
commit decoders 1 and 2 as zero-size + locked above the decoder[0]
auto-region, mirrored on the parent switch and host bridge. The mocks
take a real zero-size DPA reservation, like enumeration of real
hardware, so commit_end lands on a zero-size decoder and the
reservation, poison-by-endpoint, and teardown paths all run.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 221be4addb0e..3eb1051b1ee8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -18,6 +18,7 @@ static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
 static bool type2_test;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
 		cxled->skip = td->cxled.skip;
-		if (range_len(&td->dpa_range)) {
-			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
-						  range_len(&td->dpa_range),
-						  td->cxled.skip);
-			if (rc) {
-				init_disabled_mock_decoder(cxld);
-				return rc;
-			}
+		/* enabled endpoint decoders hold a reservation, sized or not */
+		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+					  range_len(&td->dpa_range),
+					  td->cxled.skip);
+		if (rc) {
+			init_disabled_mock_decoder(cxld);
+			return rc;
 		}
 		port->commit_end = cxld->id;
 	}
@@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	WARN_ON_ONCE(!cxld_registry_new(cxld));
 }
 
-static int first_decoder(struct device *dev, const void *data)
+static int match_decoder_by_index(struct device *dev, const void *data)
 {
+	int target_id = *(const int *)data;
 	struct cxl_decoder *cxld;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 	cxld = to_cxl_decoder(dev);
-	if (cxld->id == 0)
-		return 1;
-	return 0;
+	return cxld->id == target_id;
+}
+
+/*
+ * Mock a committed, locked, empty decoder
+ * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
+ * param so the default cxl_test topology, shared by the region test
+ * suite, is left undisturbed.
+ */
+static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->interleave_ways = 2;
+	cxld->interleave_granularity = 4096;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
+	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
+static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
+				      int level)
+{
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->interleave_ways = level == 0 ? 2 : 1;
+	cxld->interleave_granularity = 4096;
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
 }
 
 enum cxld_init_type {
@@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0)
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
 		return MOCK_DECODER_INIT_DEFAULT;
 
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
@@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *root_port;
 	struct device *dev;
 	u64 base;
+	int id = 0;
 
 	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
@@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	 */
 	dport = port->parent_dport;
 	root_port = dport->port;
-	dev = device_find_child(&root_port->dev, NULL, first_decoder);
+	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
 	/*
 	 * Ancestor ports are guaranteed to be enumerated before
 	 * @port, and all ports have at least one decoder.
@@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
+	 * endpoints mock committed, locked, empty decoders above the
+	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
+	 * points at a zero-size decoder, exercising the zero-size
+	 * reservation and poison-by-endpoint code paths.
+	 */
+	if (cxld->id == 1 || cxld->id == 2) {
+		size_zero_mock_decoder_ep(cxld, base);
+		port->commit_end = cxld->id;
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+		return;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	 */
 	iter = port;
 	for (i = 0; i < 2; i++) {
+		int id = 0;
+
 		dport = iter->parent_dport;
 		iter = dport->port;
-		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
 		/*
 		 * Ancestor ports are guaranteed to be enumerated before
 		 * @port, and all ports have at least one decoder.
@@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		if (!mock_zero_size_decoders)
+			continue;
+
+		/*
+		 * Mirror the endpoint: commit the next two switch decoders
+		 * as zero-size + locked so the empty-decoder layout extends
+		 * end-to-end through the switch and host bridge.
+		 */
+		for (id = 1; id <= 2; id++) {
+			dev = device_find_child(&iter->dev, &id,
+						match_decoder_by_index);
+			if (WARN_ON(!dev))
+				continue;
+			cxld = to_cxl_decoder(dev);
+			size_zero_mock_decoder_sw(cxld, base, i);
+			iter->commit_end = id;
+			cxld_registry_update(cxld);
+			put_device(dev);
+		}
 	}
 }
 
@@ -2076,6 +2146,12 @@ static bool __init have_multiple_modparms(void)
 		count++;
 	if (type2_test)
 		count++;
+	if (mock_zero_size_decoders)
+		count++;
+
+	/* Zero-size decoders require decoder[0] to preserve commit order. */
+	if (fail_autoassemble && mock_zero_size_decoders)
+		return true;
 
 	return count > 1;
 }
@@ -2484,6 +2560,9 @@ module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
 module_param(type2_test, bool, 0444);
 MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock committed, locked, empty decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

