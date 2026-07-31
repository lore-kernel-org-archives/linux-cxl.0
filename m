Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A23368A4;
	Fri, 31 Jul 2026 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480565; cv=fail; b=sd0YuKzG+30EkXLMUzuTXnAeCUglre6qE98WJVQlj9cmqzOeDKwoTzdvG3twfnx/bPRZHRrn0TZDtlBBE55GCrvCOS/YPj5RuWw7zEdzG5iweHPWKKRkLSNWyErmfKbCPE5HUFgwESxfOoVMRDJKAmT0mA8jeUB5R23CUYFFlfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480565; c=relaxed/simple;
	bh=nR+cX353abccCWHRS5W4YHjufsdbycMVxuF0gqrTV4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuLkfKYYr5cqairL+a+B/9xy8sgxR9kGvaEAMSeIh5S45LSVKszIYyzXlvj0hhlh7T2usLXT4LEgvyLrKdMqTI0ulyKzXVSUllMT4fBfL+L3DUBK4+S0hQ62TxoTG6XKJ4Fx1kBn9luMCVHprTAsEGXB3UAiASajmmA2CIKwb1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LdmHJIVN; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LdmHJIVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbgGjsvjbTYm+/h2BtUQxujs/pUfhR7APcEzDMTgrcFBx/apy8qtQiEQQzbINsZgVQh7A1R3PtHp+LKq8efL8w9eL0ZM+x6P/7r89bz1nN3RXYxqECaoyVWkTHqFoUIQ0gLMW5E59Ce0ZluI7KbeTUVKf6ERe3v8F77o8h3Z1Qy0mO6EGlJn2l6oCBYKfontoib2R/xlW8n4fPaJEWwpWoXwIYU8m82Qylce1nw3FEGSDSdB4ZGvXIUgp68gvRcWDX8bJ8jdqaW5pvYMkk/pIH2OlqqCrcPmvyVBWJqpa4TMfgD+wL9HdN+ofo+IHPfg/d7Ny3FMGw7lxeTUUWzd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y+QIdOwUcbyF7mY8+FJeJ0poeIkyBwfkFwitmx4iiw=;
 b=nBZad0ZLHczr62lZb8I3DU38crH24O/Uj6x/1Xkp6r3UH4MGUjYqshyxgBu14EAQgQr/NnjhgWt6Q98fT+oGqiT89dgIyO7UtNREceiY79j025RHSLfaR7hB7nhtQLHoc1iQSVkA/5G8mNO/BXHB1UK7C3Tm98Got6jNC9o43a7pRWc4jcSDyeGTCrFSrvl0O68IhSqgTuQJHvhycAxFFH6m9IOPYKGf/6YJ6qc6LFB/m/doj2RX3g1yx/KXrPkvZ+mxGDRcMWeh6aT0rIbO7W3XrVy59pYBznXo+KwRaok0GgGNIZXfWvhAyI6+Ln2ZgzecptulN3KtwJQmVHmfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y+QIdOwUcbyF7mY8+FJeJ0poeIkyBwfkFwitmx4iiw=;
 b=LdmHJIVNA+6jfAoverNr8eLrftv5j3hM6/7z7i5p8GkOJykj3Fw04RvLY1AeC+I7UqUdzUSJ5HR4MVHnG3/NN0f9fR1emdEnxk1erpFt/9lF+jsdiuX/Ui3aUqYmiHuZl/aAJHZhgTFIIk0vFdIuS6qgJb0mP3LW/Mi5NplnvIdlEkZHxtxaGDz3vjqRIXcyjDnhtV3BTfyydtNqIJQxolhGhVC2ELo7/9Bc7TJRtQmCI2dW9BkberJWm9CdZ8Me23xaW2fJ0JMRJqCH5t0qqT5GreRkhGPL0K6H93+WhzdSzIfCJ81FIkH0vYx4bx4cpgq8PzTItzx7t5hYAKUhdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:49:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:49:20 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 1/3] cxl/region: Simplify poison_by_decoder() error handling
Date: Fri, 31 Jul 2026 14:49:00 +0800
Message-ID: <20260731064902.34127-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731064902.34127-1-icheng@nvidia.com>
References: <20260731064902.34127-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0025.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc0ef79-7013-462c-63f8-08deeecfd90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	P9OooShrfyXv7CtiPQVUdEkH49zX1dXNFlwMcy3fwpX3f3zn6qm7nPRSd3lnivC2jl0V3hP91xTaFYl6YE3bMblAusvP9mYi/cANVQNgYzGpVSKOWCSQsF+zrmHtivVlBjGMqN5+rjKAbtirzDFhVotZ7G0qSdYGfFbnrAHGdSkaAEzpcCA+8T0tClQ2v3OXPv8Xesgr/Q2fHALA1DuQNRP8fcGFsJVkwdLrhjkHqzT31Z3tt+O23CMHPI8Jr5JHy4sa2Emny3bLU2kzTyMuLvJLIa5Pdv6VtdnbpsgK7i2lVkxsj3KPvzoIer/euMp5bi33DRpvGtGd4k/eFMDESQXA/un5D7ETy8fR02FxIQdD3XhtOdKzuK5hSG85zd4bg2TgDT+43ifNuy8lB4jLhcrR+ZXCaCPxBu4xjtPYOBzVlP7v9/9DzDVBmN/c3gOGgfMo64CYCMbLKCg4ycd9xiGur8rjHrPjlcCmCBG4CvWkpD8ew64f9EEnvKG9Dv3sJiFlQ+E/9uiz0l7Yd/yfi/CCK5wXSsx94Q6E0hJO0VFdCJURec8uriC6X2hTtgBIzoTnpAgSah7ed7fJXx/qlCypIsNuuqgU4zLrpkZShnTdujuFV61zmmUCG5VNpn5Z6JtLHHAlNzd5QNDz+6NG8YxWA4ZqTQUoIWl2aJNQ6nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7uI0cf52T5hODaIYvn1Zi8p52rHM0L6IZxLaFKAf++3HRVJErotKWpiCQ/Z?=
 =?us-ascii?Q?/mLxxlIshnmoA99GybQsY1V70fsq9nwkNpJugJm/JW5LEDu3V69fQg8y27nC?=
 =?us-ascii?Q?4b39xIkLcuFNsTioyN0HKKNZMrnoxV6Y6qLUlvXpFR5HLsp6VLtKGEBDRgpT?=
 =?us-ascii?Q?I3MQIEbZGAlDE+vdMRuPBDDInUte2oWflFlfKNrlX9PHIUr8Cv1K6QS1t6vX?=
 =?us-ascii?Q?YW9LeQw07Xn3ObmiQBa/0z005QetkSpfSdCMgqFa9UciZTnFl4s0M3gc3OxM?=
 =?us-ascii?Q?cEOdjJv1zWm/rmtgckfHqQ53Va7k5R09rid1/es3OwJAdm3WJgAoytPY6wCb?=
 =?us-ascii?Q?v/SLH+wOZ3jKmF8/BxNs3DhmwwqYrHNXFq9+thySilfhasnLJwV77QAi6p7V?=
 =?us-ascii?Q?zitzczxYqBqUgO93P0nhuFdmCc21jvIhb4+frkNBUBavT6I8M0e7qxu/tbg2?=
 =?us-ascii?Q?EgLN/4kjn9MzNTesHhabsg3fc8mdSYLk2rAM79XGyo6lUurB6gNo9xsJGj99?=
 =?us-ascii?Q?KFJN6M/Hmq5cC+mh0OL+WFGWni/1tEU0k4uUy6ki9kuor7vJyZjIf1I1sa01?=
 =?us-ascii?Q?3v2EmA5D2SVYyv3l+6deZvI5kxKbz80RORUaIXT6sPWBewuX5+bHy04j03Ae?=
 =?us-ascii?Q?HNg0cd0zOxvz2mtxBhl1YDFy+f2RkmLB3/Svi1F8jYm/JTsoeTDPysifBSsY?=
 =?us-ascii?Q?GrM3a5Ba8LVrUnBZLvh4Dd31e+XhM2uA3dMmWsLbYgELbAwoV18j96M2o9Hs?=
 =?us-ascii?Q?4kNvykMESkX1rQ/AIqucBoaAKbpOrGIzwzZQUkG9daNypz0iGmuKIzNpDnAi?=
 =?us-ascii?Q?vwj3kRRaMc1LDCPycVFQ9AybH3BclvYKinQkbiRO/jAuCqfHQRM3al9UV1Nw?=
 =?us-ascii?Q?ddV5kLyT471744ppn13gbFqQ4O+jbHUGgPck+7Niz90s5ijeXShXUhbQsj1W?=
 =?us-ascii?Q?Nw+4hIK8xvYcjG5wibwMcOjgkTzK3Lkw0Wy3sIKdG6MQytp4Z504gfSVCqQP?=
 =?us-ascii?Q?InCRlGf/OJ9sO13LvvTC6vEptdDj1TzIv74C7bqj1SvYtLPjgAXumc2XwEbg?=
 =?us-ascii?Q?SmsZlvt5EN1XyQCSVkx6h1vpbue7/pfYaVuCmqmbNOFsIFRoS0RAdfs9ATjl?=
 =?us-ascii?Q?vWGKW5I23bbOhpFkjJN7RNeb5lVhUe04c5TWr8Bw0m8OEVr0jdPQek3WGijr?=
 =?us-ascii?Q?AJZyz1/zAQFRCh/Cl645e8Ab3kYkZ3J77/w90bz3j+k9HP3Mg1+18uYkm3j2?=
 =?us-ascii?Q?AoCwAGRnz/lRaqYbNSl9fKhhCcFYrw9us7yVUKqJcGIuoM8E3AgR3yEdV1ig?=
 =?us-ascii?Q?b30RG6JkwuzbmSx6ikT/9pN1y9G1FXNZ4ACirsHh9pkfUkX7MuJccbL52hN9?=
 =?us-ascii?Q?hxDzlm2RyjAXw/1aY2kAdx1iaQF9vDtyFYbsVGeK+wZgcCo0HciT+PdQtRqk?=
 =?us-ascii?Q?L1CeFId/VwL/9k8o4o4//0J596avzYgTskX+OA7mIL8PYD5MN+AsleJ76Sqy?=
 =?us-ascii?Q?wj9V8mzWvL7IqDkDweXWi5bv1ipuG1bEXQCArfcBvGutCW+NPBKFFvrIB7Pl?=
 =?us-ascii?Q?wusiwBYAbziCdnTl/kpK/Uf0L6o9BNfrNrG/7NzzDY4tT70b6pf6Z9ql+qey?=
 =?us-ascii?Q?si61Tyht8jPtktNI7w8hYj7mZgHvZomuLMJCYPyuNrz4REKMnhN6hnJ2+nTl?=
 =?us-ascii?Q?WLyYr89xVIT0WJUsZkgT3xs3o8ENoDeuvfWan3uXrsMDDs7mJCzWc2bgpKgQ?=
 =?us-ascii?Q?q9QZU1Kj/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc0ef79-7013-462c-63f8-08deeecfd90e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:49:20.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXJ7XXpBZf7SR5H3Lo3XK8LSe6X2wxkp2dyO0IXqBrZULBT4El1agC0oSlUeite0f2ljwcSXL6Rs2kEEugaZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

"rc" carries both an error code and the loop control
signal for device_for_each_child(), so returning it bare is misleading,
the early guards mean "keep walking", not "no error". Zeroing "rc" to
forgive an -EFAULT on a RAM partition adds to that by discarding what
the device actually returned.

Return a literal 0 where the walk should continue, and test the
forgiven case directly instead of rewriting "rc". No functional change.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..fabaad3469b1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2950,14 +2950,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	struct cxl_dev_state *cxlds;
 	struct cxl_memdev *cxlmd;
 	u64 offset, length;
-	int rc = 0;
+	int rc;
 
 	if (!is_endpoint_decoder(dev))
-		return rc;
+		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
-		return rc;
+		return 0;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
@@ -2967,18 +2967,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-			rc = 0;
-		if (rc)
+		if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
 			return rc;
 	}
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
 	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
+	if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
 		return rc;
 
 	/* Iterate until commit_end is reached */
-- 
2.43.0

