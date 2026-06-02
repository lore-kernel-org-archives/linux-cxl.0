Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26D3064B5;
	Tue,  2 Jun 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378880; cv=fail; b=IkDV5ueAbCoFd54ovbQgNE1vFcaCCB0+10d6QXV43Bp1T4gHJYbxTpG0jDDekSRcv3XN+eiG7mvvOQY8VUt3hEy3ouz4Xcp1DFwYrTb989Ot50l6DHs0p9KC16Nf8jZkyecvEr7+9eaCfCIUHQkfpdbFbKuPYMpAgpLAecOWUgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378880; c=relaxed/simple;
	bh=AFKU9Mt9ELGltBQ7RmKy3rFa6HM9k44e98jBvind2p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osgG/jGymEI03p6EJnPfnVmcuNn9mqm3pI5+0iW1b4cMVnqxLob5rk8fSuFwtVftar3q4TSfTI49a2S3jop6x/b2j2l3RnKIP3gdFJvhPMzmzgPHS1+cgD3wCiWdzjT96WSAP1vFqmH5LukM5m9ytxu7f+rmLPoYo8zkwKqoxAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c6AQhJkj; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6AQhJkj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHF3SrgTplDK1OskAsUV+aFEZQZJfEjUtpuEB6Lad55TLXSw8PMPcPo/5HEQ85oGMWP58PcI8U7TGEaK3uIshh+Yw1jhm025LY+usI1mRBOVmeQmmAo8C+RoFeCuOnTzxgkGRRKg2z910pjtd25u8/DJFUx+L7rjksexQ2PkPLP3SEVMO49o9SRsI+FRARRH8+DyCWPXCY8xK46vlI6MXSNm5rgSK+LQ4vSxq334VPigQriH2bRfezVods+MB17HfnZi8gQLbf4hQPpHf1gaFgzU65wP0LX68O9+CS0eNX5H1Hm+HZeWe2egjKRnMpAIOuMTQQw/hmRapjz/GoAPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mnSJAol0VP4ebYoB8DaLncgGB0lxVKv856ArFG8sYE=;
 b=bRpax9EDUqfIxH2MfXE0i/MzWB87u0RluiHe7fhjLpVw0eXxaZE0p2373/EPiWokgs8MJIaaZI+sIKDLSumqIM/KbPKW92WumDPw5Gp8stLxbNfvMVWyAJzM3ENEYTk2/tD7wWsPzyWkMLAbXzx5/uGypj1ILz7s+FLr+5U6lwXNGsC8Gr60Rj+xRCgqsidE7ohZExHJMlMr4L48sLDp2np/JEt+ebe/OUz5rPKA6xyVMmrasapUk83cJK1jn6bNkWUqlkRxo/9KfaI8Anp6gMWbrdcIW8DpJ7z8Y4vbzkood+aZL6/kEA+8Zq17gR97CgRXI6Tx6f1PvNlyJG1wlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mnSJAol0VP4ebYoB8DaLncgGB0lxVKv856ArFG8sYE=;
 b=c6AQhJkj25bvzAssn4E31QA6gFDwWIluX6cmYzcAVb0+vkHeg1G8b0Cws5vzrkIg7iv2oJj4EbYn26mZZl7Br8y3p3wb4hW51Es2nywmdkVTh+qp7Y0LbuC5OUgqYBpMrv2rJ9WObRim+1Ag30+QbSKES5MTFjeGFyaFonMmBoq4AO0bUTqRLi/eU/+DZRkZ0AnGQE9BuyZ4X63k46b5XYlCQZo5kYduptzm1Hy+ijLofPr2mU27IP9winrYdrZNCSplf5JsBAvKNvst5n3ewMNM7Coqb7ZkZJmdx+ECXGhhsrPo+I6QtE084gn2lMu1ULMLA81YiepJhyWwUB77jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 05:41:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:41:16 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 2/2] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Tue,  2 Jun 2026 13:40:53 +0800
Message-ID: <5c52cc06c27ab3754e4c046a3a9d361af89f0361.1779957270.git.icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779957270.git.icheng@nvidia.com>
References: <cover.1779957270.git.icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:d10:33::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c23999-9f79-4b69-df13-08dec0699060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	74y1XLt1ZByLQzovxT+S+GGBI3n9ADF+FiNu4idb3kKa9wY2YzjNLHLupj4uenymWyQgP0RhzL2NzDFPRc01LWtFIWcN/HvLaS/3fNG0EpmJ5ieXkb8J/FlG7c6yDowrc9yzmFi3Q9cHSWYam8B03iJrTMDjdbjRqtw4zPfKz4ZVuz1T0eVONPMsT7QZeJhVGhcoTaWwlaFbvyXpHaWoPF8K7j70bmpM8qfQvsacmfZEv7Ruu/lj+mcuAp5MUM15AQwIQp4uXPmRRYTfIm/F8EQvb2Z4PkPpHkoxFB+CYzk4gHpauIc25M9hmsGuRMd6/pfq9ysO+EpRoXZoiFLrn0xltMydsQ3ZoftnQTxNalFk8u6Flxz4oiX5UUsiFJCQZ/WQzT5/fBhiQDvdzFcnFL1V9oRqC2/CfUhA9r19jUfMkC0aL4KfEWgd1rdS8hZNMh9wC/WXkJKK1PKB6hQrlDhaSBnXwlvmHPXLBViTAlfXpAxloEBHa8rVdwE0umE/ZxXNnITvA3LfzI79gZ73q02hJIc4I2NTI9QtqCJIvdR37BRq+uh7tqFVoqtl6sKOZ4YmtFbuQp9/Zohf4MSocx5d+Ihmu4mQHtJrpimWm2qmTLad/8bTwZaL/DhRWY2NkMgPa/3Yuxy0e/W8UE09qWeMUBcI2WX0KRvmbCdiQXa0bJmCVssl+qjgWPktMK3T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDl0Q3RuK0lnWjViU0FwNGUwdGdreDBneE9SQXR2bEE1b2htcVVPQjZmRHRr?=
 =?utf-8?B?N1FyTFg4Q3AyM3ZtYnpFT29NZDdNREZWb2d4OVRXaU5TYTgyQXpwTS95Y2ZB?=
 =?utf-8?B?T1NwUUtaUzRtSjhMN3FtTDg1TnRpaldDWDc4MVdDempEZ3NucTZla1NxWEJG?=
 =?utf-8?B?YWV2NU5YUFQ0YitseU92b1UzNDBPS3B5VVhiMHZFY0JUK01ZRG1TTzMzNHN5?=
 =?utf-8?B?RE1nR0pxZHIrS1lkNFBOUTV3UVh2NXdCQys0U3N2cGFBVmlOc2pCckVpNjBZ?=
 =?utf-8?B?bE9PTmM0ZkVaMHkvbTVQMnJ5aTQ0bnJUaEQ1SGJLQjdRdUdKV1NyTm0ycjNN?=
 =?utf-8?B?cWhOMDFaM1VVRStGaFUxVjhTeDhYa0dVRUI3bTRDODg4T3cyMysvajJ2cm1T?=
 =?utf-8?B?bWNGQjdPQ0ZDaGhIWEQySGJ5c3RXSFgyNjgvRytRR1c5VlRvWnE0SGhqQ24x?=
 =?utf-8?B?cHBvRnQwYjZlMUVsUU1DbGo4THFqSDNJS2hYbnhrelpvdlpiSHBFVEdoS0Q5?=
 =?utf-8?B?MGdGL1JvWGJiRmdWQTRDMERwSXdlTkVEc28zVDNNT2dMY0k3dUhPWmtFdGNk?=
 =?utf-8?B?NENtTzk2VmJueENKQWxzRWlDdTFDcGdENDc4Qks2SkgvSzYvb2lpbndGNzNN?=
 =?utf-8?B?U3RrWVY4Z3VxYTVldUZCNnpiL3pKY0I1bjNtb2E4KzZibFVQZTdlVmVKWnY2?=
 =?utf-8?B?MmViSjJ3T2FWQXYrb3o0OGVjeXVCUXllY3lrSWNuMkp5OTR0TW10Y0hDQ2NK?=
 =?utf-8?B?dGVyM2ZpbmsyZG1ma2pYQnM2N3IwdWxROFZDMWFSQzNGbGUvcmFKRFhBREYx?=
 =?utf-8?B?WGxSeVZUbE9HVzJRWnh0YUNIdm5wNzhsRThWUFpoSFVRREhzeXA3NnNUbDkz?=
 =?utf-8?B?blBLWFBGYVFiY2ExaTdNUGxUM2F3Q2htRm9GY3dyTUk3UmJ0dW5ZUzdvb0Yz?=
 =?utf-8?B?Rks1azJaZ2VYMTMyWm5GczJFcFllNnBKY1EwdDFoazJyMmZzSWJ2VVZhdnM3?=
 =?utf-8?B?M2VtdVBaaE9DZmdCeE1DL3E3UDE1YUZzVUN3RStyVVJ3cEdkUHhENWJoLy91?=
 =?utf-8?B?WklXZldCRU82d3lTZitGdGZaR2RZSmo0TG1tU2dnOEYwV3JxNEc2L0l1R0Nh?=
 =?utf-8?B?SW9rZWlrcS9CV2hlSHlLdkdmbmx5UXpNM2xsc0l3TWlRUlJnRExXM0VLcTdJ?=
 =?utf-8?B?TnJTaTFYQXdlRjhMVHVFSVZheWJLTEtsMHFLRjZndUpRQitFWjZtdjB3SzQ2?=
 =?utf-8?B?VXV6NDZmQ29HRG5DVkhScTRNY1RJa05TT3lKbHIwZllQWUNpREJHWXF1NURH?=
 =?utf-8?B?V3RwTDJpZTRSa0l3ZmwycnQ4T2tXSTVYSUg5U3VKNUQxV3h1NkV2T3ZWdmVS?=
 =?utf-8?B?S1VIMnFKd0lKT0dSdUJQNmJNVVFLWkM2T010alBXMkZUWVZ3ZC9SYVZXN1FZ?=
 =?utf-8?B?MjhjZXpyS3FwVkZmczlIdkt5dWsrZ0hDTHFpSEZXK08rNllOZ3pPV003NnhT?=
 =?utf-8?B?RWx0R01lODNEVE01N3Vrb05RcGJ5RFJzRjN3QkdEcUp0VW9DNHBxTFFRa2Zv?=
 =?utf-8?B?djJxY09nOHIwYmJOMVpSdElIeGFEVkl6ZkZ4NEFiUmdjcXdLMncwNzBYWnpO?=
 =?utf-8?B?cjhlcGxvUVRYd0FCTHYzQnBYY3REdlVGRE5VVk54Y1BYNzAyQW1VWGkxWFNa?=
 =?utf-8?B?Ukx5eU8vM3UzS205czVhNWo3Yzl5SEMrT1IzZTZEUGlWMm43RGJrWWhrWEVQ?=
 =?utf-8?B?MEx2cUVNRXhWbFVFeWt0TDR1eUY5OGoyR28xcEZzbXl0RVlyR3RQbDVmTklm?=
 =?utf-8?B?QXlEcWRjYTJqQmYwcm9kVytDdmNWRDNpV09EbFJqV3Y5SlA4U2VwZS9PT2Mw?=
 =?utf-8?B?cGRSUUNoc2tQaXlCMEE5MjFuZk9FQ2FYOTNyWHFkWE5XMTVvM0t0QUNSUWIv?=
 =?utf-8?B?N1JrQzlIekJlZlc4RTFwMmpIbWI4b0JrN0xGQkVLdUFZOUFlU2ZlaVJuUFpv?=
 =?utf-8?B?ZGZsSDMwUzhvaHR5L0FHV3pjT2d5TnUvbERNQldlK0I2T1AzQmUvRUUyZG5s?=
 =?utf-8?B?Rk91bFZTeGNNcmxESlJ2QVZ5clM3NXNsckgzRHE2MHNzWWMwNFk4Q1NRalpo?=
 =?utf-8?B?NlNwRUNwS0s1Y1hTd0tHcVBkdm01M1dqdUZOSktLRHhDSzNvN2FqUkFBcXIz?=
 =?utf-8?B?SUdWcVRyNkR2SlBTS1ljZ1NGaVRkelN2MU1OK29mTTVRb1VFT0FqM0FkRFBB?=
 =?utf-8?B?RlZJZnNEYmEzV1FGT2lXTHp4UEFZWWlNNE1HSjlPUUF4ejcydXdLa3dtTVp4?=
 =?utf-8?Q?fJjBaABTzxvrlN60rv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c23999-9f79-4b69-df13-08dec0699060
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:41:16.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIi6MvWGrpA21F2pyQK1kiKU9/g3N5H/Poao0IKBHMkz8Db7AaDZqcu+jJAd1vgf3av46BmkkBW5PHdaI78Qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840

The kernel now allows committed HDM decoders of zero size so BIOS can
burn slots with LOCK. Without cxl_test coverage the new path goes
unexercised.

For the special endpoints under host-bridge 0, e.g. cxl_mem.0 and
cxl_mem.4, commit decoders 1 and 2 as zero-size + locked alongside the
existing autoregion at decoder[0]. Mirro the same shape on the parent
switch and host bridge via the walk-up that already builds the
autoregion path.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - Replace second_decoder(), third_decoder() with a single
      match_decoder_by_index() helper, so all lookups share one matcher.
    - Use DEFINE_RANGE() for the empty range instread of an open-coded
      struct
    - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than STATE_AUTO
    - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model the
      BIOS-burns-slots case
---
 tools/testing/cxl/test/cxl.c | 79 +++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..1ae0290a9221 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1041,16 +1041,41 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
+static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->interleave_ways = 2;
+	cxld->interleave_granularity = 4096;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxled->state = CXL_DECODER_STATE_MANUAL;
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
 
 /*
@@ -1123,15 +1148,17 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	}
 
 	/*
-	 * The first decoder on the first 2 devices on the first switch
-	 * attached to host-bridge0 mock a fake / static RAM region. All
-	 * other decoders are default disabled. Given the round robin
-	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
+	 * On the first 2 devices on the first switch attached to
+	 * host-bridge0, decoder[0] mocks a fake / static RAM region and
+	 * decoders 1 and 2 mock BIOS-burnt zero-size + locked slots
+	 * (CXL r3.2 §8.2.4.20.12, §14.13.10). All other decoders are
+	 * default disabled. Given the round robin assignment those
+	 * devices are named cxl_mem.0 and cxl_mem.4.
 	 *
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > 2) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1145,6 +1172,18 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * Decoders 1 and 2 of the special endpoints under host-bridge0
+	 * are committed as zero-size + locked to mock BIOS burning
+	 * decoder slots (CXL r3.2 §8.2.4.20.12, §14.13.10).
+	 */
+	if (cxld->id == 1 || cxld->id == 2) {
+		size_zero_mock_decoder_ep(cxld, base);
+		port->commit_end = cxld->id;
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+		return false;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1168,9 +1207,12 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 */
 	iter = port;
 	for (i = 0; i < 2; i++) {
+		int id;
+
 		dport = iter->parent_dport;
 		iter = dport->port;
-		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		id = 0;
+		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
 		/*
 		 * Ancestor ports are guaranteed to be enumerated before
 		 * @port, and all ports have at least one decoder.
@@ -1214,6 +1256,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		/*
+		 * Mirror the endpoint: also commit the next two switch
+		 * decoders as zero-size + locked so the hierarchy looks
+		 * like a BIOS post-lock layout end-to-end.
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
 
 	return false;
-- 
2.43.0

