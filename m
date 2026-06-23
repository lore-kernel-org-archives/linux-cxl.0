Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5430C37A;
	Tue, 23 Jun 2026 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205838; cv=fail; b=l6g0cl2pzgnvtyo/PVFHgUEmHgCiXEsxrJ3hu7G1DrGTWu2mlImtWlEcFIvHsAAbCD67xxHs5KVbAQ7xYK1hOODWRgOyjRx90idh8fF2CTXazQuH4AEeSQX+QafYy/ytWpintU/egDCJZer4KqvDoAjUP6qS1qOI4FFt6/0uGrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205838; c=relaxed/simple;
	bh=mPw5DHx9ONvUEiMGWxsmH3NvpCba7gvRRNu6BuJI/mo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fVeOVLkwvHNrytsJvSsb7Wesr9eEysBIhTCBq3aCMTWke8x1cASP8/Vzt2AejOKKgS+9T2bTxgUCY3EYpWq37iGFJlKpW9JJtCMpjZFarI3/XgDDlv2chOG/+TY30sSS6x5hJaZc6mCg1fDPovktfE1WNmeG+LY4oko6MAZZGDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYoOGPvE; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYoOGPvE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGdYSeKUnIIYjcfTgCI/K/1Tp3B1UspFGbd9D0vEd6KKT7Mtuto488WSGUHhovmqB0GH19ptqePQAqEVw8cjbeYUue95Hr1ucjQ3l34nHy4VEEOvBigdXpj84ldU/kuUSGU9YvfhnyqmzLkUwyKZowf/B4BOmNY07lXwrv0wJKp/W/xhbZIvqItztiYh7bqn7GDYfuGUNBwBp4E8cgmUW/Jr7vYPEl7g+HLfHV3ZSlhPq279ujxjbcTzgR0VXYXH3ARXG4SC4isAwCxNhFkRz2ny8Szxt85rFxqmPS5AJY1liZFI91fFpQsaAbDQ5e2I043Byf0T2tmclBUn+t7MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR0WVs01xvC6FmjngP8NUW2O7e7z3xl3HhsrHlDlfSs=;
 b=EOIVcnLh4snefAALxnjSmk3t6y0HXA3+Gm0lIxtRLJNB2FQf5Rof9GgnNuOZYu3oNhgfNsYBbdaI+kl59jjZQmOLqRG6uWowRbmFAdR29/ED/a7cY92UBWSSGLeI+UuA+Pe01kxCBGIscb2+l3qQCuT3T5BFNCsbfs/6fYKSlaUFpDrwm7AhvvXuu/MSOhq+6p6lySv53tFO6DPe9GXq9vDsMCJktCAmeiTN3BEnAo6om+4Mdb2MM0dUMwz26iLH+05Mfpw2Rep3JT3YRHY7/tsqHNXPgRuABkDfh6FsY8WplWxC0jxQNBlQ16IiC6OmLbaSBmyaWSTJQzOvtnhHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR0WVs01xvC6FmjngP8NUW2O7e7z3xl3HhsrHlDlfSs=;
 b=qYoOGPvEkQD+e4OteFNLmLOehgomgRTuVn6rgYRaU7KUFYrWnpaETMYOMjJHGYDT2rqN5ZQbCvhmbM8nohfIs1DSETwsFBfa5PVRKdBw1nxfWfjqzjCevXRtTnf2Bg7tSHO4LkWFrf8Ua7MHseAwsMlW20V4a+ceuLEviDTaQnD2BSM82WvCgJOJpeWmnLo27RKmAiPOofEsILlUHTzGzrhjubEMeFM5BB9eZyDC7lFwuPWtMWjxc/Mo6zCa7bRuvJ7yz2lL3+JAoz+/NGx7EWuKxLfbp/T6tbDyT3zU31jPJqr3EnJ2FkpC59HF6bsfOT/++gMS3FAq71IW/jdbVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 09:10:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 09:10:28 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	danwilliams@nvidia.com
Cc: ming.li@zohomail.com,
	terry.bowman@amd.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 0/2] Support zero-sized HDM decoders
Date: Tue, 23 Jun 2026 17:10:17 +0800
Message-ID: <20260623091019.33417-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0025.apcprd04.prod.outlook.com
 (2603:1096:820:e::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f818c88-d865-42f6-531b-08ded10744ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|3023799007|56012099006|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	OUyuA9DlFgPU79hu0Z9EtNfssx/6Ljpk+pQu6dd5eYWKiVgFkaRLVBq0iQfgcQYvCdyX9rmrZxJOX7puw+iBCRZrHVAKTGDyq0DbZB5uhiUwl1EevFAyq4Wq4IxM56ss6EBGtWTTAHDpxplUOXDpbRgL0DaB+4NxMEopRGIUy+b1qVXhRl5ezeLTVVuuIbGDde3be0FLJsvtjQg+DdHQaDi9q5iLXpMOlM9Oq9l3cDP8kJ18t0114uq/Glbq8eITtyZdckS/SF8TTBDkoAgLssS4cmApaqwUd6nG/2RyUyXEz7QJUEOn32kDn9NixL/PbszIZx0HvNOf/XHmjizj55hePe/kMvyWmwHv8TG4I8ehINFvb5Fm2nv4d86kLCRYelpkSub7ro2JYqr1dwMuXWNxTl505Wj3cJ7R3elrm/Wzhrct7Q7pZSiAG/eIR6y2O75En31g0kGB9aDeDyyLnpym61zbmqegv5v92+Q8hPcDg2s0ITcIvskZwzXrGYFVYDyE/Dhd6RT8Pfucj6hvWwdVZEeAq4E4tvMmk7/I7rYSK+/HuHPnzaV4u8vN2oETrOyyh84hO7cAs1r/qOy2ZhAx0VL13lKRkYhDyVAlnFsoIR4YzRFW/L/O0py4a37V5BauNwZu+fdZePfNLdDB40827pSR1QQ7kUfoJn0DvH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(3023799007)(56012099006)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUdYVnE1LzF5OHNkcmEzbGhmaFp5MjdWZFRjYTRwd1NtU0hJejM1aHlEdDg3?=
 =?utf-8?B?YXcrckJBclpwTUNxR1JiM0l3aUNGUi9JekJ2bm93VUtBY3dpV1ZHRy9OampY?=
 =?utf-8?B?dWU1eE1hc2tiKzRKdkQ2ZXF5WnVFVS9XUStsNHdmYms1RzdlaUhvYnJiZ3NB?=
 =?utf-8?B?Ti9VOHlMZTJoaVV6VUVYUHQvaDE2NW9ncVRNeW1PQ0hUVFUycHRjaFVWenpj?=
 =?utf-8?B?SnlVK1VTK0VsNlk1OHhyeUtEc1R5S0NkeHF6ZFFCZlJrdVVPYnNNRWtiT2I2?=
 =?utf-8?B?SnJpTkM3OW1yYTQzbEs3Z2pCU0FZVTdSeCs1dEc2RUp6VklkWkptazVpYnNG?=
 =?utf-8?B?MG5TNTI4VDhZVGZ0R0t4b29qZlRlVEVQN2FwM2RKY0tsN0V5WXRSU1lESmpl?=
 =?utf-8?B?NmhLTit6Wll6V3NjRUl3amFKSWNWcHpiUGNZcEwxSUVZeFJsbXptT092dkhj?=
 =?utf-8?B?REd0UWdld1MvaWYzR2pyZzdKcUw0TUFNK0o0Y2E4UzVRNTFQWU11Q095TlRz?=
 =?utf-8?B?N1ZUOXNhZmRHNVExcEpRSTQvQVFSYjZEdHV4L2lyRzJDWW5Tbk45bW1Vam5o?=
 =?utf-8?B?c0FwNnpnMWZQSGhGQzk0TEJFL0tnVmxoK0lsK3ArV3EwWi9wdmM3WmRoYjJV?=
 =?utf-8?B?S0xYL2prTlRnUFdKcmErdmkxTWhhc2lQQ2dHSWlsZXVwMEE5NHdqcWQ4c3FV?=
 =?utf-8?B?dnJVVEhyYVI5U1BoRys0a2pOWVpMQTJwQnZ0QmRoWEZJT3F6bm43WkhyYW9q?=
 =?utf-8?B?bFRGTDZBZ3ZwOGpFNXowbzM1aS8zdmVVL1Rtc1gxTWlSYTlNVUp4MXVVSVBM?=
 =?utf-8?B?ek9LVnhSWE1DL3Y2ekNJS1FYbXVYTzlWTXRhTVl1cTV5VkphcDZWam8welRw?=
 =?utf-8?B?WUFQNDdFRVA3V0luY2ZVRmtBMVpqMkZ5UWpDemNRYmlYelR2Nmg1TjRuUTdY?=
 =?utf-8?B?SG85WDZabFRsWCs0N3prcm9jM3lIbWRkblZOcFBGTDlLcFp5SEtBZ2IvL0tq?=
 =?utf-8?B?ZWZsd1R0QUZxZ25pOG04Q3VhN3BETzdOVkx1cGo0VkFtV3BGOWxVNGoyckZU?=
 =?utf-8?B?ZTRiOFFkbitINWZGcUFxdXVzREZpV01YTFJsTGpnNGpVWGdWZnRxNWdYeTFs?=
 =?utf-8?B?TzBOZ1NOcnZUSGhVQnhxT0tsVjlSSndyb0lYWGVsbzc5aENVT1phc1hQeXFR?=
 =?utf-8?B?UWhBMkExRElWNmQ1L2E3NFo5eDU3V0lDUmQ1NFV4VGhJVjFCa0lvNnBZV1Jo?=
 =?utf-8?B?TVBORGEyQS95TVJwT0VkTGJ4cnYzNkNlSHFiZTQ2SHEwYndibTg1VTZ4Smpi?=
 =?utf-8?B?UXJ3Sy9LS0VkbWdwRUJZQndPc2RWUXNPWG1uV0JpM2g4aVVwcThlNWFWNDJP?=
 =?utf-8?B?Sm9MQ1Q4UHlpbDQrdGZ6RkFvMVRBWDBtandwaEpCeVErUkt3L1krVVZPeW1k?=
 =?utf-8?B?RTM4UXd6ci9GVjM2ZWw5NVNGSzlqRVV2U1BBU1BjOWU5T29iRENXeDA5ZERV?=
 =?utf-8?B?NG5hTUsvTDVnTjlvVFBTUk9nWG5Ka0crZzB5MlRzTkJHMGN1MjQ0QS9BWXNs?=
 =?utf-8?B?VFUzNDdZZGFDSTE3YlNVQk1POGxLOGVWUTVJTEdQYnNmUDBCNHZkeElzTHdo?=
 =?utf-8?B?SjUxU1cwRjB5UWltWis1MzloN2tRajFQVVdVR3RaWHYxNTNnTXo0SGI0NFJK?=
 =?utf-8?B?RjR1MjdTbTVrd2NKMm5FN3RXSWFiZWtSRTk5VEMyOWVUTFdGMmtIWDM1YmJY?=
 =?utf-8?B?azN0d1pxLzVmaW5HRm42MHpwSTRqbWRkYzdvYzk4THYzc3haZ2txc0o3TWpw?=
 =?utf-8?B?RllkbVcxZ0VPc2RwcUducTNySVNoU2h2c0xEWVQrMy90TjhMVGxLUUxPWWR6?=
 =?utf-8?B?VGJsZU8wdE5Sc2grU29Gem45Um1rLzdrNzVVR2w1TFVoS1pEQnFQTEF1cTQ3?=
 =?utf-8?B?WDQ3aEQzUGkvNDA0S1lrTHl3NHhkM1RoTFZHZVFyUDJJQUF6ZUFNcjdNRTUz?=
 =?utf-8?B?SFdhQkpwS3Jzb0Y4QW90QnIvZERmU0UyaGhVNnBVdlRVS051VjRYNDBORU9W?=
 =?utf-8?B?QndFUjlTbC9vdjRvU3d3MUwvL29HeHJUSHo0T3VkREhhYVpwNFdqeWlOS1Jj?=
 =?utf-8?B?ZjFmUzdDVlZqenJ2UnBvMU9ERTlNekxSaWNiOThtYURSbndCL0lYNWJjZ0pl?=
 =?utf-8?B?czkyT2FJamV3bEpTaFRtanpvQmF4ZElkMGlaS2wxNXVyOENwRVgvcWNFcnRk?=
 =?utf-8?B?citNb1lQZVBGdDBGWkVkS2dCRE5Vd3JuLzNKTy84MmYzRGtFanlHRE1zMjVE?=
 =?utf-8?B?QTdQdTRLRkNVQU54ZTc5cS9tN0UxMDREQ2ZaY21PMjRyY0pLcHVlZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f818c88-d865-42f6-531b-08ded10744ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:10:28.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keQqcQ0w7PnAMsCihWTdlTlVNM9kosXuYNkoK1I4v2VWMSIfc9Fsb5am94+jbr6rORztWMlU3oHpKMHiNVrKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

CXL r4.0 8.2.4.20.12 ("Committing Decoder Programming") and 14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder with
size 0. BIOS may commit and lock such decoders so the OS cannot program
regions through them, this is a design choice rather than a spec
requirement.
The kernel rejected these with -ENXIO during port enumeration and aborted
the whole port, so affected systems showed nothing under 'cxl list'.

This series enumerates empty committed decoders into the topology and keeps
them out of region assembly.

Patch 1 stops rejecting empty committed decoders and enumerates them.
Empty decoders are now first-class: they take a real resource instead of
bypassing the reservation path, so port->hdm_end and the in-order DPA
checks stay consistent. discover_region() skips them so autodiscovery does
not build a phantom region for an empty decoder. Poison collection is
fixed for the case where commit_end references a decoder with no DPA
resource.

Patch 2 adds a mock_zero_size_decoders cxl_test module parameter (default
off) that commits empty (zero-size + locked) decoders under host-bridge0,
so the unit tests can exercise the new enumeration and poison paths.

Alison's suggestion about adding tests in ndctl will be sent in a separate
patch.

Tested with the ndctl cxl unit suite (cxl_test) and on real hardware.

Full cxl suite with mock_zero_size_decoders off -- no regressions:
"""
$ sudo env "PATH=$PATH" meson test -C build --suite cxl --num-processes 1 -t 6 --print-errorlogs
 1/14 ndctl:cxl / cxl-topology.sh       OK                2.89s
 2/14 ndctl:cxl / cxl-region-sysfs.sh   OK                2.40s
 3/14 ndctl:cxl / cxl-labels.sh         OK                2.38s
 4/14 ndctl:cxl / cxl-create-region.sh  OK                2.93s
 5/14 ndctl:cxl / cxl-xor-region.sh     OK                2.40s
 6/14 ndctl:cxl / cxl-events.sh         OK                2.20s
 7/14 ndctl:cxl / cxl-sanitize.sh       OK                5.19s
 8/14 ndctl:cxl / cxl-destroy-region.sh OK                2.23s
 9/14 ndctl:cxl / cxl-qos-class.sh      OK                2.28s
10/14 ndctl:cxl / cxl-translate.sh      OK                0.51s
11/14 ndctl:cxl / cxl-elc.sh            OK                2.31s
12/14 ndctl:cxl / cxl-security.sh       SKIP              0.01s   exit status 77
13/14 ndctl:cxl / cxl-features.sh       SKIP              1.04s   exit status 77
14/14 ndctl:cxl / cxl-poison.sh         OK                7.07s

Ok:                 12
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            2
Timeout:            0
"""

The subset Alison asked about:
"""
$ sudo env "PATH=$PATH" meson test -C build --num-processes 1 -t 6 --print-errorlogs cxl-region-sysfs.sh cxl-create-region.sh cxl-xor-region.sh cxl-destroy-region.sh cxl-qos-class.sh cxl-poison.sh
1/6 ndctl:cxl / cxl-region-sysfs.sh   OK                2.39s
2/6 ndctl:cxl / cxl-create-region.sh  OK                2.92s
3/6 ndctl:cxl / cxl-xor-region.sh     OK                2.39s
4/6 ndctl:cxl / cxl-destroy-region.sh OK                2.23s
5/6 ndctl:cxl / cxl-qos-class.sh      OK                2.26s
6/6 ndctl:cxl / cxl-poison.sh         OK                7.02s

Ok:                 6
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0
"""

With mock_zero_size_decoders on, cxl-poison's by-memdev-by-dpa case returns
all 4 records (clean under KASAN).

On a Montage CXL Type 3 device, enumeration is now clean: no -ENXIO, the
existing 128 GiB RAM region stays intact, and the empty decoder appears
with size 0 and locked.

Changelog:

v4 -> v5:
  - Patch 1: rework per Dan Williams -- make the zero-size DPA reservation
    first-class instead of special-casing size 0 and bypassing the
    reservation path; keep port->hdm_end consistent.
  - Patch 1: skip zero-size committed decoders in discover_region() so
    autodiscovery does not fail building a region for an empty decoder (fixes
    a -ENXIO region-attach hit while enumerating a real Type 3 device).
  - Patch 1: poison fixes (sashiko) -- gate per-decoder queries on a valid
    partition and fall back to scanning all partitions when no sized
    decoder was walked; add a len == 0 guard to cxl_mem_get_poison(); add
    the missing return after kfree() in the zero-size release path; tag the
    zero-size marker resource IORESOURCE_MEM so partition resolution
    succeeds.
  - Patch 2: gate the mock behind mock_zero_size_decoders (default off) so
    the shared cxl_test topology stays undisturbed.

Richard Cheng (2):
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       |  52 ++++++++++++------
 drivers/cxl/core/mbox.c      |   3 ++
 drivers/cxl/core/region.c    |  49 +++++++++++------
 drivers/cxl/cxl.h            |   9 ++++
 drivers/cxl/port.c           |   3 ++
 tools/testing/cxl/test/cxl.c | 100 ++++++++++++++++++++++++++++++-----
 6 files changed, 168 insertions(+), 48 deletions(-)


base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.43.0

