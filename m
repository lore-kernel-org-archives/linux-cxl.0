Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F353612E8;
	Thu, 13 Aug 2026 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592773; cv=fail; b=GrBf5fYdrCRVd1AREc8eV7ZdQ6DLqkhg0kp7VNeLcJ3Dorp24fKsJVticLoqtQxklVFwC/2wLmCT8jx9HmBfBfvo8L0bAhNf3Grf49r9seyptz7U/q/iSWrXxQFcxeMOiTGwDJxwpZ7gcfvCF9Y8QMHW0uOfXGuDGR4fvzAJPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592773; c=relaxed/simple;
	bh=N8sO820OP/w/ocMdUW+tso8YAFf/1yY+6ASfXgI4MtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9dxA0zj0e0wEoEkWy4mo5CRVfZItLSE27KTuSbulCqdiT24OA/6Tzvky4DT9EOvJG/gkS7ZB+UIGtS5rmwzTkA6x5ndBR0yaM/jLPQhlPXpRuU2SdDbPrh5J/kEtXX3tYF/rAWvDgs9bDnY73TyT2/Ezey5/z9XVdUwzPttAxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j49g1u2p; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j49g1u2p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHjl6Rth3ZWY1/3Ns/SpDpILjH6uC/itHR71NCvNCWibYgs8WWgHYorNvnjk2FsFbDvlgzBVLPy2YNUsi7nSiARZIPs5MyI4HKPJITORqjTuzGvJKlwyuKyN9nAnb90iq09ankKO7h+I4m9LqNVBcan7pMRKuNOyrtjoWGSJlaj18IEUIYRMN66pjS/0AjzaEZcrm9Ezsc3muQvdKaWhvNTfvJchzTbh9qMFgkQsu7n1Vvz0yuanuw7Na5pfNMv4FN88Vv1OqBWN0ZnlM9sXD1OIBJTqxm4dgUGKZ6yLcFQuLPYY5/c1xwYIhDUnTbp70Dmj2OFZvQErJVVTcEd3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=d11Kbj1JPYTmIb0lnIavRIGrbSNho3z4pv+wChcRPnwYBRt9gD+qQ0YPLw02aRAFjZrmgK/skBs9CdnUYFj08vyHlhbpRLv0u8uZFYlyFK96etw0pXFOKBItY+4t5avhTXU9RS4LhS6jIg97ZiqSDMD36V7KIyahp5LXIKW3HS3ztqIXt4SEr/Cx51alA53eewgf/rq9bofrPZzepMqNzRNRHUaSaQQOWRW7oJJXQkNfczpDf1kZFSK47EFTd/7phj844R8/9xT/9daar3NpcdhNlhkgooRjDGlZPtelPkw7GeKhiGFOD/KzV+7jXdW2Q4MVfhb+jRsbxOZ0U9LJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=j49g1u2pjQuxHXBq0HKBPlDom9M90NCU7kF314ih6z8pQIJ8F25/IbYTznbL6gCWZ60sBQjg3vbsxhn7zuO3zTio0UuYKgpLAA8Zbi7vOHkOX/8ESVtd2bkmkd5Qm8m3iKDPVCfr0K2LaywfGTok+W3NpChJPXTPuRAP8vcpJtLokwMoWkSv+D5w8GfxeazhZCNvMjBVyylcMRvOzTxf2R2TJga3vhbk7BDicXet5d5aAbji57rljRlhbQX+D58zZYX5VYQCTrjZGWqVuGeohxV5IaZD9lVsYJJCfGI+SRLprKXK1z9LVux98VeDVawmUIbrWXieei+fmSoQPOmZBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:07 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 3/7] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Thu, 13 Aug 2026 11:45:34 +0800
Message-ID: <20260813034538.13189-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0020.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e7a993-378a-4b90-bfa3-08def8ed67ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NikOem7+VNrRjbANlVENyjUY7lkhe6OUCG1j+BoyriZE/4pYwbdwKYeOqY1x5ePkhB8MkG9+Cr2lpKRHcnp5V4zs6iP8oyysvHn9hi+Hc15l5SK9DczmZUByfPxsnWyu2tXRoLymVUSY0enHQYWcdxcAOMjC99Zz40amp78KDcPS8QnpT0JvTT9XT04AdD5Wbf7Y5AtLBKc121AjQ1Xrqo8w1dvbmg+TgfTNA6kyrOfjy/0IW8QzrfT9uJJ4lqKsVX9cwqiDzFyP7KmIR5N2Iw9NZVGWaM0GgGYvIfdY7KBtR6DNC4OI1nmfsvx291cnSxHpIwqPtjsZX5g7ySoTeQBQUI9mWHYLWtQfGC5g2Tqe3fQcEEaqo1qMvmO+TPk+w1TzmmWFcYKVcvjF3O+oGo7wBZosXvLMpXjW9EmkyU3YctujbmWZxFPRpp11i+ydQeyZZToYSiSzpUNZKFp/KwBImhWKGKkN5nLt0mkPpylVfAuTM+SJ33jrovqOruRIO8XF/T7VkiTWH0Xx9tVap69UVjDWSCB/Ru65DplKe64/mEx7c36i0GRZ4/gw6DDZjGhaSGf9K6TVADY5QHKiYhfvDm1jBbc2bwnBo2LBMDBT7e5MO1vExnPgO8z6rAGgsggO04+d+jY4nADx3uGmw4l1uNBbbUmiEUiKxIJXunc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRyp9V9tfbmTYtzY2qqeig8kQhkwzoD7FqLS8uOt4eRtyolFpuru/m99Eqx0?=
 =?us-ascii?Q?ZgAFLb528LtH/rDROwko+o9EiAj8LvY98TyKEE/e0O/taXN/iP0RIW/J5OMI?=
 =?us-ascii?Q?P1wz6EDCfRLeAI+nHyPUF9S6oOX5IVGcftJjy+5f3x5WFjKxKJMvQy3tCIWX?=
 =?us-ascii?Q?c5yTqK+XreykG4gaDt6ByieNf+CQgyuXZDOROjYckykdqwoOG+FnOOFyXzy+?=
 =?us-ascii?Q?PxaTmDZiPrYgkFscFzKPLMMds3PJhafI5lBCSZCX3JGuEb+OUg3f3HMPPnbH?=
 =?us-ascii?Q?k+NIpYA/sLhRq3koBKAr+ory+r93lCuqdT7oLGqMl06zOx+Fmi339Tb/IBy7?=
 =?us-ascii?Q?aupqoQ+zD2MpOLa0FA3cMLCTWXtLtoWqVQ8jkhbBT35xoILeIbVvTc45k8d3?=
 =?us-ascii?Q?83Ze8j+KurjlgaYKkMEFARJd0E3LT0jn16MNie6QmptYPCX35Cl/mDz2oPko?=
 =?us-ascii?Q?CqgbU3O/TDeklO6IzQILVbWaCd3c0X/+9KHBFJLXst7TcHqTiFrmcMaCvJNb?=
 =?us-ascii?Q?6IbwAIggwOGmdJ67c9l442DkgESi3v0hSvcp4zU1Gp7WEedZQKjtvTFwb/SZ?=
 =?us-ascii?Q?ZkxYtoMvWE0yUm+kfPpbORRl56oKrTOTTJSABw0FpS61ZBRSxiozYgfqN9/u?=
 =?us-ascii?Q?uExIRuZ7jeITETQThNiFWTLn4Ye7Aul07SN9ieRMUXgE3VCryB7k4e4yWH5/?=
 =?us-ascii?Q?jOutbcKJqKPU2s38UbGvBjZtmHKwGCzf15CH18F5RIMpdfyrGw1x4b+1zs2/?=
 =?us-ascii?Q?Dt374qfaeNTmiWB1L3vBs3y/PtEf1DJQPSaVje+/SsPnOfLRd4fASz836JLE?=
 =?us-ascii?Q?JXY6xGj86qTvnD1hgzYBwCD4v9tVb1HXlY5ESs99tA5AFFkPvISjEmVRdrn9?=
 =?us-ascii?Q?0T+7VfiGsku1FVPZv6OTWsj7jOISBYkYAJe1AmJDRiKzeI4KrfHeDlVyN4u5?=
 =?us-ascii?Q?WyqUsvK3E8Wurg2waB9dqok/O5gVldgFYEpKtYYAeIkT5heZuMfG4NIE+G37?=
 =?us-ascii?Q?VHDCGWYVZZgwGdiAughqgON/+FSIpBIOOXtBLhn6pXsvGdfRW+F69PQSt5JI?=
 =?us-ascii?Q?bThiaYrtAV23FOCOD26OnJJotEsoXWG3laZ10ii29eLDABo1cdm49NbggoHA?=
 =?us-ascii?Q?M/5+3TVCf4PUMeg0DZQIzXqt0QQ5mBEZRevyxUJZjPLDdzuM/qIR34B3FZEz?=
 =?us-ascii?Q?dq6LNG50s+F7PhpzdK9hY9XtpiBxkj0B1LDgPv0CWrNzXgiI1OMUwg5jDuZE?=
 =?us-ascii?Q?dIYgGyL77s+Ks3Ce5GQIp1m2XcWNxSoyH2Lm3Oy6Ew+6XzISRjRSAXmtB/aR?=
 =?us-ascii?Q?Py2mHcl7J6+0LvpIi4DsZwqbFlCBKUoSzxoyJgyPMj85bUxnfb+IWxFBo+n7?=
 =?us-ascii?Q?Eje7mfNFjFxBYpWBQT0C5UzG7KpPOF03YwTt368CRpguwB13rGoYkmXHrek3?=
 =?us-ascii?Q?K0Fto0mp0fZp1MkdqWx/e0TG9qGcBck1o7FRX8TzTb3AUlnN3TbCocHTUCYz?=
 =?us-ascii?Q?sZpGJsvFg0HCjIa7muWxw3PYXoY/l8Hqk5wsl0i3c7VLACzMz2DrE7C6nNca?=
 =?us-ascii?Q?U+9HRCRgoNioWvcGMStyhcyLtogOF+zofSfbT8Q8tgH3MEc9r4VsR88gqHi9?=
 =?us-ascii?Q?LHPNB2KOXfLXSWYkI9eJ2QFumExZnBvkah6p/bgfx2KTu4X8X3ePFaoMfJrj?=
 =?us-ascii?Q?v5fPROeCSzkjpkLd4wLFLAXo5mJ7HqgpSu6mHNj7K0NthugkG4FQVbDXJvH4?=
 =?us-ascii?Q?WPPS1/Tctg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e7a993-378a-4b90-bfa3-08def8ed67ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:07.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osp/M56uo5gv39Y0NbZpL70NPKrVbGnwCAEv+BDZSGYv00eCxSkE2RHzgs8MmN3IVD83oO+fZJPfdO1ty5MrYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b03f30c04d35..ddf12075b95c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

