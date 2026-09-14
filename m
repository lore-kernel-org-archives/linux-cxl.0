Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5141B8F1;
	Mon, 14 Sep 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376966; cv=fail; b=IgmGNkpCfYPzdJT/Ea7zKNiJHHH1EUzR8BMgS73Rb7Q372NWywHWH4NTTOBt3r6v+O/o8+ghcriOPeD90Q/vCJM3tBuho2gpJgRLa/6/u6nqesEmqtkwWtSk067fQp1ZMWceik0Rp2RUnTBFMXUAGiVHMr5dz6LZzpZAR2nEp90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376966; c=relaxed/simple;
	bh=f+sIj3s88WwP+kl9mwKeEPUuWVdimx9vFKh2JJ1cy1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4/AeS9SEDq55d97OKnJpiiw/eblxyHkeVI1qlnvM9aHCbN5jb1dfUVWtNZboeotrC0mGCMpAolx9pO+8D2jjXxYxoSTdEpHzSge1u2A70uZK5bks9Y4ZXswGUmgAbr3DQaWzuMpobQYQVWOklnbw4hpZZ/DjmsrF7Ib891msfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GFrZQz3B; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GFrZQz3B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muncdHtbQ6Cfyb8mADxU3EbnlCl4tSSVGekArfqpv3bWvCRmE20UvvnymWWR1e006YdT3Z8D0y/29YR6qDOtvOGrKqIpeKLhgPSBR8QS6vnDoy2UyEO8c6NMrkrKQH/itcIEhf5Ra8KdEmQhfEDrkzY4sm9BtfLK12Sza+ky8Sta5uL6e2UGlaJc9jAcKsjyo3m2ECv731DsuKzS/15NIRPUvEYs/9qt0UQNkx7YRUJI0PKtrhqGhTOjXHezFVVbTBpVPl5d4rG0eifU5FrUPgOvm4LsnpsMOu+dxC1rNShCEsE+/i1F9WVuQXtCR13PCoCGpLxbgisq7F5KAX8ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tLi/sP8V9YQgVN8TBl/2ikTJpBrL3TiEGPUxYSpw6M=;
 b=MjFQ1MrOH3ccVMaGPUeeN/heQan7hNxJJszBtxuRV6m7xuRchf9DdxcVZzMaDmMAHfvYN0FLnqy99dZtXx7BMLNMTEb+ZgygoUbEQscFRHcQMmTlsgUetQTft8TUXLGlLuiYgCFNfGlde/IH8W19Kek9ZsCUjRwJ37wFX6X6o9W5UlgE/Gl1N6oLt2jvu9gW721JZU2jUCiOrX2jd1FkFt2x6gz7nk9NB3tndaPhcWzI25Lj47B1JkYZ02H/Lf8ungo4zzAl1GdPGq++/8ltSf3NyZsOgIogV1YmKl36lqWTpZUqYpDlcMgtqgXnsd3WsAl5ZIkrAGBfRUCl00jYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tLi/sP8V9YQgVN8TBl/2ikTJpBrL3TiEGPUxYSpw6M=;
 b=GFrZQz3BjNxYiadIfHm/mXrdpdGadnX5Xn15OlM1DlEghVqZaIxNCDLO4T4s5+8AEWHZtsv1fR+cZ+8yVw1/rh0Kikco5VjYN+a67kyGsdnpDxMMCxKz45dPBdpgLA6yVsXS8yacjntOYwBVC3r0Q056s2S6jctb+t/vSzhnBKLAGUMf8GW+8V8KY51v+BdYVq7h/uAFC4IcECT2REPBmqi5G42zLP5m05uGdd7Zj1TfiF0OsbUVihSgqMj6KZZfnuo5ZawA3zEAirwnJXWJyiQ7Y6ln4027n4ODnNEecL4Uha/1+keVyYsGq/0/FEAqzT0O9h7o2U97zIxfE0te5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:09:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:09:20 +0000
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
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 2/3] cxl/hdm: Allow zero sized HDM decoders
Date: Mon, 14 Sep 2026 17:08:57 +0800
Message-ID: <20260914090858.19181-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914090858.19181-1-icheng@nvidia.com>
References: <20260914090858.19181-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfcc19a-cda7-42b7-3085-08df123fdc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Uj9TMw3ufA7g3r0QCL1OzbvqnmwSJw3QW6ZbwcqtKddIgkS7MexdnYjPljKRMATRz/Jq1gxnAQpOdngyCWad/ClDKeb5+Hv9hXYcSQAgbYqiy7eXZy3DYzm8xJb/Sxn7+IlJQMtiUwE0LW5fYqLwb7sU2w1olwGSyPDqdWGrsf9AkGmqUg2Y54BqQNHf3Z8PMCWtyMsWzbEDvolVpRz4tEPjPrBzvrA8WBWMr2HaS3f/bY9UJJripkemBLLjAKB+BQkBkQtlRGpM4XURXqgujk49dZiduVPGh+Rl8VSbvvk2ujAgOgAoybZLktnWT76ZC6bvhu4NUXWn/pqCj0spqFcYgK93d4ZrDlIHqgljcbAfyBN211LB1Zjxm+ZI+UB/mEjNAx/6SnCy+GkXnvDppr2jnCz4CU8xx814NQd7gE00U6jvOSWlVXUEJ568U0CiYD/jY/UK7WlcjVaTF2J9DIyqDKIz+CoUW+yqKWLxXQA5RNDUtNGXZnn1DYVoPQJCIWnk98mJHRP1A4TuXaW3rAVMkbq6fyRZJM6kC/YhOaKA1G0VhC9ZH5lvtsJo2GkNm5wSKfJRAAfUMO7rFYDdbuc6jEmHlrp3oXj8b+5IU6H4+ldLEJk+hAb2HUFRuzBqYsVPo8954wy7zvtOvoiBmtjVz9HY12ASpR4cfBeI4hA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blY2OC9TaG5RTXhQWDBlZzhXdUFML2VmNDNuOGIyRWJsWXdzeXZVN1RyVGpu?=
 =?utf-8?B?M0RMZ3ZyVU8rS3FoM3FDRTM4SVorbTFZZkhKdjlMZy9BdkFYTXlTdUZXM2di?=
 =?utf-8?B?ZExIdGVIZlNXblpoQmovSUpmbHI2MlhtT2NUdjliSzZlSkJsZTBZYy8vMDZl?=
 =?utf-8?B?U3dOT0lSaGN3Y0VBclNZcVdDWDNNQmR0STRYS3N5SWlnSURTVHIvaFdMM1R6?=
 =?utf-8?B?R25KTUplWjR3U1l0VUdEbVJMcVhzTStWRzM0Q2Z2UjBEa0dRVFJISDVoR2xp?=
 =?utf-8?B?Y0tBS3p5cy9RejVvaXFma2wwTlFlck1yUWQ5Qk9idHdEQk52Y09rZ1lmd0l5?=
 =?utf-8?B?L3FSaWRjY2luYzBMdzk3QWg0Rkw4bEFoWndVdExmbG42YjNMaThiME9qekhR?=
 =?utf-8?B?TU42M2JKVFdXcG9qSytLcHAxRW5qOHg1emRNS1FTTnU2YVhKV2VBNTYyeHNx?=
 =?utf-8?B?NkFncGFBem1OTkdRTmdCeFNKTEVKM1h5N244NGpoWFFpaHZncFR1NCtaN3Vk?=
 =?utf-8?B?dEhZSDl2bDJ5QWFEeXZuUm9kWFBXK0xjeEQ4U3p6V0FCK0FDWDBIdys4RERP?=
 =?utf-8?B?MDMvZVc5YjVSWGVpZHZwYmMvS2R0TjdIMzcxdUJQeXhtdENnOTdIcVhyR2do?=
 =?utf-8?B?cjJxSWVDMVRQbk5seGZtSTBjaDZtU3N1cUJtSlpQMFVHSEY2T0paOCtZWGlz?=
 =?utf-8?B?VUdOOGFSZ1RtRktLUHNOUTFmaExDVUJLL2VnMi8wTUsrZEd4aENaZElGc08y?=
 =?utf-8?B?TkNJTXU1NjBWbHlOMG9RZnlrMHFqL1RvR1prM2wvNDV5T2RCQ0ErU1ZYb3BW?=
 =?utf-8?B?TkIxQ0hOTnN5MGw1N0NOVk5rQW9rSWFTS000Z3VjczdOUUY0cXhreHNvaW91?=
 =?utf-8?B?R1JUVTJlbnFmcmIzVFFLZ2NEREc4MFlsclBIeTJMczY0TkpOazlEVzhpMG5q?=
 =?utf-8?B?UWpDME5VeDBXOFRMVjlER2MxVk5tUjlSOE9SaUxHTHRyYmIvVVpJUzI3VGtH?=
 =?utf-8?B?dDFmN3d2MUkzWWJGU1hnMk1FZFNwWW5nbDJNc0xTSVgvQTYvRXdoUlBlc3l6?=
 =?utf-8?B?ZVRWZnk3dWUza1laZEtwbjRDMnBpTHdjOEllR1N5ckk5QmpEVlE4djU0QjlJ?=
 =?utf-8?B?ZGMrWGVqejgyTE1XdnN2QjNXUFRoaXYzSkU0ckt0Yk9JNjE2WldvN1JwTzZO?=
 =?utf-8?B?MWo4ZTBJZDlDRXdwUS8vTDNhV3dqbmRQYlBWb01XTFZsa0R4cHJYMC9rMjVo?=
 =?utf-8?B?dVI5WUpYS2N3eE9yL3krdzMwK3JCNU40UzhVbkE3aENlT1lKS0lNMFdRdG5M?=
 =?utf-8?B?N3hRSkRISHlIbDdSYy9SQU1OaWR5b1htWjc0djZ5U0FJdFNDbW5BYXR0NGRJ?=
 =?utf-8?B?TzdjbnVMQUNwMTE1UGwxMDUvd3pJalNjeUlZOEN1azI3L1M2MXErbjRBWlF1?=
 =?utf-8?B?dGlPNHVna0hJbFExVEFIMy9NYlowd3dTUmM0bHZlaDRsVzBHbkJmbEFxdVg5?=
 =?utf-8?B?ZXhnQ0VPcUdOM1lvVnU0cmRoczZ1VHBQSmpFVG9HQzZQR1plZXkrc1dLakVq?=
 =?utf-8?B?OVRMY3FyQWF0WFM2S1hYeUxUendrMzJhQXEwa3pRMFo1WHEvam9yRFFJQUFk?=
 =?utf-8?B?cFNmWmN2UVcxdlBpeVhlc09xbEkxVVMzREZDSHNQVmtPcUl5RGJwZVJLanVl?=
 =?utf-8?B?eGZxYks0SDM0RFhFajhBak9HempmN1B4cTFHRGpEMEh0RnJMTXJoMFpLTFVB?=
 =?utf-8?B?T1Rnb3NaSkgwSlA5d3pzaUdYVlBxbkxyNHhlS1lOTUNxWiszZjdTeEp3N3lt?=
 =?utf-8?B?TmdqY1pyY21vUTNON2pmWm9jMUd1MkJLVTZzRXYvaWZJZWVYLzlGanBPTW45?=
 =?utf-8?B?U1ltcUNMbWdsU3FZRkdFek1DaTVFU09KM1pPek44WGF4WHA2Rm1LeExQUDZD?=
 =?utf-8?B?K00zd1dGOTA5TnNhUjJ5Q0lnaG1ZK21jRGl4S0l5SUxTcGo4MGJZdWVCNFNa?=
 =?utf-8?B?QTRpN2VFTWRSQUdFWHYwMlk4alIvOHkvNVpwMHBhZmVNRXV6bEh4RGpCcDBv?=
 =?utf-8?B?YUl6OWdKRlhnMTBDWTkwamZkZTUyMFhUV0ZxbGJtZ1VvZkplWjJ1NWRJUW1v?=
 =?utf-8?B?MHB3M3BGVU00a2xQN1F3dktZZndBdWptbWpFVFJoMUpjSWFBQnFUdVFjTVZu?=
 =?utf-8?B?QjJmL296bnBEcUlHUStRVnhWb09CYlR6MWRLU0ZzT3FodTJtaVVnK2gxZ3Nh?=
 =?utf-8?B?SWQvYi9Ibk0zLzdzbFIzZkRwT3lkNitOSDlPRHFpWkxEbHoyYjBNaW9OMEt1?=
 =?utf-8?B?eUNaYVQ2M2tYVGY2akREdVUrTVAzdkFIeU43NWwvZ044ZndyNXZnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfcc19a-cda7-42b7-3085-08df123fdc5c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:09:20.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49hceLqEngRZtthpSaqCde2CZY7lVB5UQM1xj6ULqQcmLGT+CqTdnY4m2c8ANmRbo181ZGBtkazDWbGNdNTtIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
with size 0. BIOS may commit and lock such decoders so the OS cannot
program regions through them, this is a design choice rather than a spec
requirement.

The kernel rejected these with -ENXIO during port enumeration and
aborted the whole port, so affected systems showed nothing under "cxl
list".

Treat empty decoders as first class reservations. Back them with a
separately allocated resource, since the resource tree cannot represent
an empty range, and keep the skip and hdm_end accounting intact. Exclude
empty decoders from region assembly and avoid zero-length poison queries.

Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changelog:

v9 -> v10:
- Preserve -ENOMEM when allocation of the standalone zero-sized resource
  fails.
- Retain the !cxled->dpa_res guard in cxl_dpa_free().
- Reconstruct the commit message

Best regards,
Richard Cheng
---
 drivers/cxl/core/hdm.c    | 58 +++++++++++++++++++++++++++------------
 drivers/cxl/core/mbox.c   |  3 ++
 drivers/cxl/core/region.c | 45 ++++++++++++++++++++----------
 drivers/cxl/cxl.h         | 10 +++++++
 drivers/cxl/port.c        |  3 ++
 5 files changed, 86 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..39fe283cbc74 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
 }
 #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
 
+static void cxl_dpa_release_region(struct resource *parent,
+				   struct resource *res)
+{
+	/* zero sized decoders are not tracked in the resource tree */
+	if (resource_size(res) == 0) {
+		kfree(res);
+		return;
+	}
+
+	__release_region(parent, res->start, resource_size(res));
+}
+
 /*
  * Must be called in a context that synchronizes against this decoder's
  * port ->remove() callback (like an endpoint decoder sysfs attribute)
@@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
-	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
+	cxl_dpa_release_region(&cxlds->dpa_res, res);
 	if (cxled->skip)
 		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
@@ -336,6 +348,27 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
+static struct resource *cxl_dpa_request_region(struct resource *parent,
+					       resource_size_t start,
+					       resource_size_t n,
+					       const char *name)
+{
+	struct resource *res;
+
+	if (!n) {
+		res = kmalloc_obj(*res);
+		if (!res)
+			return ERR_PTR(-ENOMEM);
+
+		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
+
+		return res;
+	}
+
+	res = __request_region(parent, start, n, name, 0);
+	return res ?: ERR_PTR(-EBUSY);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -349,12 +382,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
-	if (!len) {
-		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
-			 port->id, cxled->cxld.id);
-		return -EINVAL;
-	}
-
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
 			port->id, cxled->cxld.id, cxled->dpa_res);
@@ -378,14 +405,14 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		if (rc)
 			return rc;
 	}
-	res = __request_region(&cxlds->dpa_res, base, len,
-			       dev_name(&cxled->cxld.dev), 0);
-	if (!res) {
+	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
+				     dev_name(&cxled->cxld.dev));
+	if (IS_ERR(res)) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
 		if (skipped)
 			release_skip(cxlds, base - skipped, skipped);
-		return -EBUSY;
+		return PTR_ERR(res);
 	}
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
@@ -402,7 +429,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				break;
 			}
 
-	if (cxled->part < 0)
+	/* Empty decoders may not be contained by a partition boundary */
+	if (cxled->part < 0 && resource_size(res))
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
 			 port->id, cxled->cxld.id, res);
 
@@ -1031,12 +1059,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		if (size == 0) {
-			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
-				 port->id, cxld->id);
-			return -ENXIO;
-		}
 		port->commit_end = cxld->id;
 	} else {
 		if (cxled) {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..1a2553332801 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1386,6 +1386,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!len)
+		return 0;
+
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 677ebec8f48d..f54acbf68e84 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2113,7 +2113,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (!cxled->dpa_res) {
+	if (cxled_empty(cxled)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
@@ -2967,24 +2967,31 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res)
 		return 0;
 
-	cxlmd = cxled_to_memdev(cxled);
-	cxlds = cxlmd->cxlds;
-	mode = cxlds->part[cxled->part].mode;
+	/*
+	 * Handle the degenerate case of a device with only empty decoders. An
+	 * empty decoder can still map a non-zero skip range, so advance the
+	 * walk to commit_end either way.
+	 */
+	if (cxled->part >= 0) {
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		mode = cxlds->part[cxled->part].mode;
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc && !poison_efault_forgiven(rc, mode))
+				return rc;
+		}
+
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc && !poison_efault_forgiven(rc, mode))
 			return rc;
 	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc && !poison_efault_forgiven(rc, mode))
-		return rc;
-
 	/* Iterate until commit_end is reached */
 	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
@@ -3006,9 +3013,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	};
 
 	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
-	if (rc == 1)
+	if (rc == 1) {
+		/*
+		 * No decoder with a sized DPA reservation was walked
+		 * (every committed decoder is zero-size): scan all
+		 * partitions in full.
+		 */
+		if (ctx.part < 0)
+			ctx.part = 0;
 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
 					     &ctx);
+	}
 
 	return rc;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..3ef0810ab86b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -336,6 +336,16 @@ struct cxl_endpoint_decoder {
 	int pos;
 };
 
+/*
+ * The common case is decoders with no reservation, but also handle
+ * decoders with a zero-sized reservation that firmware may install for
+ * security lockdown purposes.
+ */
+static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
+{
+	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
+}
+
 /**
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..c12fd0b89883 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -46,6 +46,9 @@ static int discover_region(struct device *dev, void *unused)
 	if (cxled->state != CXL_DECODER_STATE_AUTO)
 		return 0;
 
+	if (cxled_empty(cxled))
+		return 0;
+
 	/*
 	 * Region enumeration is opportunistic, if this add-event fails,
 	 * continue to the next endpoint decoder.
-- 
2.43.0

