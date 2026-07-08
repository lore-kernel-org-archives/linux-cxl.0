Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE653D1AB3;
	Wed,  8 Jul 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507252; cv=fail; b=EUC5UoXBVCtQ9ffa44+orxlXmKAu7poOG/EK7sR60d3Re3HZomtJLZK9z5yY72H1rGE2GdjlOvjpviQK76GCGMAYXHW1tcda5opZMF18VK6RaHtJYweoN4CEGJ54NAb53daoybrPJKTaJ1sb6Yn/CGVm9WPP3qh3triHtarhDt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507252; c=relaxed/simple;
	bh=KH1os93FaPStgtiEGTEcdcpPIdcsCIOwKhZbC4+eo7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCPMn32XxxwzX1pkb8O3DNMbmon1ujVMdDQdHGka2yl74rU+gFc2mRsHyU1mLTVhC1JZxfY0A1Uyo9FfMrAOVU1w0Kuzn7p3kYLml+ImBAGY/j3haBtpQkQkA2VxrWOkIh6U0ynY2JpEvvWmMKvXyCuQQ0/I/Mu2yvfhFlQKdLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGzn1Na9; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGzn1Na9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xygsMsmAuGKTqwgGYTZHF8E/empkPVK08AEg/iDjZ2S9ZwhPcmMetndX/0Z3mQP8IXPkbqIMeB+2x8HnmCT9G40v+X9B6bEFlz4tKx+D0zHGDnP63hESsWzSkokgPVTEvWhGLB7kTFMlRsXiQP5QYz0LdpeeVhG+oKhN0gwO4cjZDFEfhyiFv2B1BJzVl3WQi7i5Gmdb+mHEoBGmvh1S/MGOPFYMhaCQ1btmVCKEC6bZkyvGW2cgRoHYbIOzvs7v0MVf6zihORVAuqDsOQWQmaM0oCbCzaiOUaezuWTs4Cno0k3EQqOzf4LF4tefga/EMSUhylIVecNKIJXEOpcOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm4DwIxqtUPZEz7tx0D2tqdxR8j6FGJkARhks20i1VQ=;
 b=s6dd0tfJ5tit6mz+djqLl4l57WWA32LIA8YFXLIBJcj8uKGQJ+HXXIDSXzHWa8jwCjhcPEfQ/9EUmpJDBVAQWTYoBQN8hx7CLmD6Z5KoixvGWXrTYJV36AnGm0P56Qyaay7ZLCSjlY6XbmO95dz9/z+3wesgmn4ez6hgjWuDk6CuLlB3uPCLf7A5hP8JrqPyf2ZllQy+iEJNg1ZJn/xZ/4D68v9bLdUhhlsNLcQLgItKomt+M10ImQY3i+u8Xi7VzbeYKFjc0Id7ATNjJpVskCo9H5ghj9tewxpX568LlnVGgfy7fLsh9Dtno+9yk/YkUD+DD0NAs/B2dQoHihgI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm4DwIxqtUPZEz7tx0D2tqdxR8j6FGJkARhks20i1VQ=;
 b=uGzn1Na99YKPX8+aZ+C7EAaude+0fvHzMX+lKZW+owAX97K8evOFIvtfnr+mPSEYFSmTK/cusLX9tvb+S0aXAoaWVdck8kMffulcZNxnS2oz8s/CwULMfDTjBPtHB2GdcjeLu1vUzhV+6zPoHr60D1L5mhiL1yHT7xT2FIjvhlH9yrtyC4UTfl66OE40B1zEOLWZAQ0UNNPup9yMuO7TPx2qtd9jNPIRPHEiVOHVkAbI0haP8ZFv19oUxWqHJUvCm4azNsu7kRSQIHipv4wjqngRzBMpfJeEBzHQlu6Lw2wdUYRvcnXkNigRylBVktafN0rOYC6CW0t6ysP2RGUnuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAWPR12MB999294.namprd12.prod.outlook.com (2603:10b6:806:55b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 10:40:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 10:40:37 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v7 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Wed,  8 Jul 2026 18:40:22 +0800
Message-ID: <20260708104024.68029-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708104024.68029-1-icheng@nvidia.com>
References: <20260708104024.68029-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAWPR12MB999294:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e1ac31-d51c-4298-eed0-08dedcdd58c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|3023799007|11063799006|5023799004|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JSiCnKFMc1/ZaRt3W1UNkxw1s7ZAH3j9jz7ufLxspWMQDo/67ANeHrz515WzCc7il4hTSq8/WM/rXf6xgGXsMthHCYDX1OlcvvyZZUFPv5cdTMi/XTtPnNmg9nYKggcM5qDN5f+I40VC6wVkip+fKO0nZsINATyMbxbJs9rslwtAzS5f3DhNUoYf1hZ5nUZxeB/kdQ9VcI+U10QA0uLL9/z13hfT9Duw1PXmHEJQ1DkdWy/AqU+uX2SDtQVMBpmKA/XM3PhpO/62Ukw/XQkAFpZ/do+eFekcT14zmulul7nRfMbtOgkOQQuI/jYYLA4nqziGQOwJSaTBFXHXdDsXhLYS/MKRnwkznz+H4AEs8DXTcep9qgnsjfZW3WC7NFlomQ2vTI0p9soU+f/uulOBhG29zA8WQDtcpO2oSEa0pLfU8r+ZAmn6cpzJ8P/c/rVdSTWM0AttSJVV15QXIpDiLygrGoUgl4HU4cKkMvloBFe1o9lUrEc1+CQhR9hllCi8wO9MPml8cxpb6iiW3l63/Eeqpfs7RIzuLYZM/nRcxjEu9YsRsoCTvgoqNuYZQz6NwQR8+ltOCbf5ftEKn+IiJcBWYkQkoH8+0NYIKqtD53PDkznN2H94Bne0KRw1/eOhU3Mr2sQySzRdOT2lD2O0Y7XZ3h9Of3SYBUEnJlRe+9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(3023799007)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJoZkp3NHAvT2RnL1V0azFvWlU5TmxXamFKSWo1WHowNUxTalV5S3I4cTVS?=
 =?utf-8?B?U3N1d2MvWmFyM2lBWHFWaWgrWkMzbWNEdlk5U0l3ZU5iQTdJUVhJT3lteUFX?=
 =?utf-8?B?YllKdnAyOFAvL0hnckc5eWFiZkxaTVZxMnJ1WExyOGlyOW1aTjVHUnU1bzBM?=
 =?utf-8?B?djZrNXJCQVJJZzdaUmRaMkVFdXFUWCtEa2oxMFJpWmV5Y05KTU1DVmdPSlB4?=
 =?utf-8?B?Z1hhYzcwdE90eXFGUFRKMDA1c2RMUjRkR3p3aFRQRWxRMmNNWG5pL1JEdkpB?=
 =?utf-8?B?eXpxS2FsWW1tUW13QTltU3l0MGZ3NytROGl6Mk5DUUIvY01OODJjMlJrUmdj?=
 =?utf-8?B?cGhGWmNIOGpyYlU0RXNzdk5LMHRvQW0rNU5oQWJuOVJhNXkzOUFOZm9kNEM5?=
 =?utf-8?B?bk9oUXcxdkRFcm1DUGFrcXcwNFdlanFwME16Q0JqUHBoajA4eHlPWVhUVHRT?=
 =?utf-8?B?UUNwczJBOUNZQVJCR0s1YUFNSU0xU1duUkY0TXJDcG0rOVpVeW45MGVrNUpL?=
 =?utf-8?B?SHR6VXdyYStWYlBCUEV1aXRzTDlwOGJuNDc5V0d5QStodFhJV0RNZUdkcTJs?=
 =?utf-8?B?YjBod2Zhd2l2ZHZ4eVpIcy85QkxtSGJRcWNtYXJIZlBHaUNWWFhxWEFUNEE5?=
 =?utf-8?B?Q1pnTkNXWVZWUEt4ckVRczVQUTlMa25VN1NqaGR1UTdBSWtpbFVuMm5TMHpG?=
 =?utf-8?B?cGdDWFdFZXNCQmc5ZExkQWNrWFYrVWNYNTMrVEwxTHlBSjF2c2VqM3RvdXg1?=
 =?utf-8?B?TXU5ZklIcHpZZ1BieTI2NFlOVWNlejVNczNlSjdocWwrQVdheVdTU2lZaTFk?=
 =?utf-8?B?ekQ4a2QvYWRqdk0xMEVER251YUQxVkFnYk1BdFF6NElxUGhlV1lBck5aTHdr?=
 =?utf-8?B?ekl3bTZXSVJVbWppOU41WklsNUZEOG1GTkg3MzlFc0NHTk1DbG1WSjVVL1h2?=
 =?utf-8?B?cWVuRElMZld0Wmo0QnNDQ013d3hsbXowNGMrcHRNbDhoanNoemdRdDJpb1Bq?=
 =?utf-8?B?Um9EQ0c2UnJ1Tm1keVdCUGREZUZDSDlVZjNPKzRGdXFHQ2NtVHYzcVB1Q3Ay?=
 =?utf-8?B?MVhHVFdaVHNNSU8zUUZ5ZzNDTGplWVJNaWlYUlpnK0FIb1FORnM5cTg4dkhT?=
 =?utf-8?B?YzhBV2laNjJKUE1tMkRZNHAvL1pEM1FQUUJ5cnpQWXNSeGF2TVh2R0dKdEhk?=
 =?utf-8?B?aWZscjU0WUhoaG1rWjlpUFJzRFpTRXhQb2x2ZUQwalREWFZicjhaME9HakpH?=
 =?utf-8?B?NTREbXBRM3JLUEVRMk95S0FDTDRCbFlkUUFzUy8zdEtmdGxjMnlNRG5WWEtI?=
 =?utf-8?B?T0xBKzA3TXo4eDBIY1Z1TW1tWHMxNlo3STRWKzJiQUlkbHZUbW1rb0JmbG9M?=
 =?utf-8?B?bHNVUmgyZHk1U2cyLzEzK2w0cEw4TjRoZDUrdWExNmVFK3JLUWRBVlNxR3pX?=
 =?utf-8?B?SklRRVYxNm9QMnp6UCtmdXlzdlBSZUhjbXNJUG44eHVoak40SU9jVU5MY1k4?=
 =?utf-8?B?V0dCQ3JaOVYrNWNIaTJTTVR3WlJpa1hIQXFNWURFM1BWWlRtOXUwcnAvSWtU?=
 =?utf-8?B?UzA1YnNKMVZwV1gvTWp2d2dmcVVEVDhJT3cvN1krWWNWOGJLQ0VRMGxRUlAw?=
 =?utf-8?B?VlJ6UlY2RVFwQkt2bDB0ZXdIcmYvQTFlWlEyTU4rZ2lmWXY1a21mYXNiTHFl?=
 =?utf-8?B?VWlCeUxlVU95dFVnalh1dGlSWitUWU5ndVV1eVoyVEIwY0JXR2prYmNlU0lH?=
 =?utf-8?B?MEpoMVp5NWR1THdaMnpYZHpkRmZKcW4yRnBTVnZ6dk96WkxmRGZTNGxFOTdy?=
 =?utf-8?B?c000ck0vWXV3NC8yRmNUblFhSkJmcFdaS05lRTViN3lMd1YwT2p3enhyWmtz?=
 =?utf-8?B?dkdSY25PZjRJSkRvbnlhNlhvRXBuajJTUTIxV3k3b0ZnUEtESC91TUNoUG9O?=
 =?utf-8?B?RmIvVHJuZFRWemYrMllUV25BNDZGaG9rRU00Uld1RW42ZEczVTBack50bXRI?=
 =?utf-8?B?a2Z3a3Nuc2JXODdyT0N3K0dKeDMzeDhscFhkY1Fsa3FOVDdSM1hUQ2U5RWdk?=
 =?utf-8?B?SzRwUXNodk5ETTVWUk9CQnZSOTREYmxacHRQUkh2aFU3M0tQeWN5a051Qy9O?=
 =?utf-8?B?NkRuZWtRT052QXQ2U0pxUFhVaUtkV0IxdkdDUVNjU3F2aGExTFBKam1IWUxy?=
 =?utf-8?B?WW9Tb05nMWJqekpzR2ZnQU9oMEVMNU90Wkd0UHk4N2wyRlVGaGZISXRKdHFa?=
 =?utf-8?B?UTA0eXBHMkd1UzdPZkdvTnB5NFQ5Ykt0emhyeEgraGFQTldzQkx1emVldzNz?=
 =?utf-8?B?aDVuSERxVEJuSFJiRVBwclBWY2tGS29VWjQyb1M1cVhobEJaQ0kydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e1ac31-d51c-4298-eed0-08dedcdd58c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:40:37.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07PqryYugZdN4RGGdxh9WK42A17LTuLtbwuZyn6sIJlFO7JN32Zfhd4WV2PW4VwPIO3HOtd1y4yhfww3LFeRIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999294

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
with size 0. BIOS may commit and lock such decoders so the OS cannot
program regions through them, this is a design choice rather than a spec
requirement.
The kernel rejected these with -ENXIO during port enumeration and aborted
the whole port, so affected systems showed nothing under 'cxl list'.

Treat empty decoders as first class instead of special casing them, back
them with a kmalloc'd resource, since the resource tree can't represent
an empty range, and keep the skip and hdm_end accounting intact. Guard
the paths an empty decoder can't serve, e.g. region attach, DPA free, and
poison queries.

Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
---
Changelog:
v6->v7:
	- Rebase onto cxl/for-7.3/cxl-type2-test.

v5->v6:
     - Comment wording fixups, no functional change: reword cxled_empty()
       per Dan Williams' review and tidy the poison-walk comment.
v4->v5:
     - Rework per Dan Williams' suggestion: make zero-size DPA
       reservations first class instead of bypassing reservation.
       cxl_dpa_request_region() returns a kmalloc'd resource for size 0;
       cxl_dpa_release_region() kfrees it on teardown. hdm_end now
       advances and releases for zero-size decoders under cxl_rwsem.dpa,
       and their skip registers are honored.
     - Corrections to the posted sketch: add the missing return after
       kfree() (use-after-free), use IORESOURCE_MEM flags so
       resource_contains() can resolve cxled->part.
     - cxl_mem_get_poison() returns success for zero-length queries
       before issuing a mailbox command.
     - Fully-burned device (all decoders zero-size at DPA 0): cxled->part
       cannot resolve; gate poison_by_decoder() queries on part >= 0
       (the part[-1] OOB read was already reachable for sized decoders
       that fail partition containment) and scan all partitions when the
       walk reaches commit_end with nothing mapped (sashiko report).
     - Drop v4's poison_by_decoder() restructure and the hdm_end
       non-advance approach; superseded by the above.

v3->v4:
     - Drop the port->hdm_end advance for zero-size decoders (sashiko AI
       review). The write was outside cxl_rwsem.dpa, and advancing the
       watermark without a balanced release strands hdm_end and breaks
       LIFO teardown. It is also unnecessary -- zero-size committed slots
       are trailing and locked, so the in-order check in
       __cxl_dpa_reserve() is never reached past them.

v2->v3:
     - Advance port->hdm_end for the committed zero-size decoder so a
       following committed decoder still passes the in-order check in
       __cxl_dpa_reserve() (it was left un-incremented in v2).
     - Fold the poison fix into this patch: commit_end may now reference a
       zero-size decoder with no DPA resource, so poison_by_decoder() falls
       through to run cxl_get_poison_unmapped() and scan the unmapped DPA
       tail.

v1->v2:
    - Add zero-size committed decoders to the topology instead of
      skipping them. Drop v1's -ENOSPC sentinel and the matching
"continue" in devm_cxl_enumerate_decoders(); fall through so
add_hdm_decoder() registers the decoder.
    - Set port->commit_end unconditionally for any committed decoder,
      not only non-zero-size ones, so subsequent decoders satisfy the
out-of-order check.
    - Add an explicit early-return before devm_cxl_dpa_reserve() in the
      endpoint-decoder path. __cxl_dpa reserve() rejects zero-size
decoders
    - Spell out TSP and TCB and cite spec sections in commit message
    - Reorder series, implementation first
---
 drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
 drivers/cxl/core/mbox.c   |  3 +++
 drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         | 10 ++++++++
 drivers/cxl/port.c        |  3 +++
 5 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..ccbab2e21f06 100644
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
@@ -336,6 +348,23 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
+static struct resource *cxl_dpa_request_region(struct resource *parent,
+					       resource_size_t start,
+					       resource_size_t n,
+					       const char *name)
+{
+	if (!n) {
+		struct resource *res = kmalloc_obj(*res);
+
+		if (!res)
+			return NULL;
+		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
+		return res;
+	}
+
+	return __request_region(parent, start, n, name, 0);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -349,12 +378,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
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
@@ -378,8 +401,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		if (rc)
 			return rc;
 	}
-	res = __request_region(&cxlds->dpa_res, base, len,
-			       dev_name(&cxled->cxld.dev), 0);
+	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
+				     dev_name(&cxled->cxld.dev));
 	if (!res) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
@@ -402,7 +425,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				break;
 			}
 
-	if (cxled->part < 0)
+	/* Empty decoders may not be contained by a partition boundary */
+	if (cxled->part < 0 && resource_size(res))
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
 			 port->id, cxled->cxld.id, res);
 
@@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct device *dev = &cxled->cxld.dev;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	if (!cxled->dpa_res)
+	if (cxled_empty(cxled))
 		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
@@ -1031,12 +1055,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
index 97b1e61ad018..ffd24992273d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1384,6 +1384,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!len)
+		return 0;
+
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..6c7d9a52707c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (!cxled->dpa_res) {
+	if (cxled_empty(cxled)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
@@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res)
 		return rc;
 
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
+
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+				rc = 0;
+			if (rc)
+				return rc;
+		}
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
 		if (rc)
 			return rc;
 	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
-		return rc;
-
 	/* Iterate until commit_end is reached */
 	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
@@ -3002,9 +3009,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
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
index c0e5308e4d1b..cef53d9bd5c0 100644
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

