Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473333D7D7E;
	Wed,  5 Aug 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915708; cv=fail; b=TkWvvthSVtHu+bOvGM0FBTKKMGxO8gz1GdnIqVBCnypIhISz2Q13NhzzEqN3nDiB3WPlsAhYamcfHng0JAcVU9YyHaO8BhxhTg19YXMz3tEqnOi46+a4MYluBgon2ZHJ9ki6dKjEo03yiss3hes7UoUerz+ZwgbvDC8FLVEfobg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915708; c=relaxed/simple;
	bh=boWybnlfiOAxsZhpqofqR5002rFDOI77kuGr3ASG9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D/LW4Pl7HftA0fNOjDRukn83pfJ07lEn07PEckwqn22YQXJ6su6/Mh2HKZPOei+W05ijMpwB9u271ovTQDxu8URzeY6VNqrPfmPLZoyYqoQlqEL6HB3k8WWp1awu+oVyIwE7uorUoQV5KF8FhcrqOeCySXWoKRDpZfUir5b4RYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awlFV7mx; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awlFV7mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoHXbbNphfTzCkBgE5oO3gZfFx8XTCHZPqeNDrjAqTKyCDP4kDI83q0t7rU0lb9pxTHCMdc1Gry3VQbdEbsm0opFQsz5EZrWksRSeia1je8RjHbGiQkfhQq7jQIHWJFB2Ekw6KZCxGvrbEkL3Z11bx/4JRKRhPi/TU91xGLS23vi3YAcXG+Q7lNqXFiWBAwxFT4k7hv1bjnrYc+pf59W8tJveGeOz5uWiGeqktnYHzFNi1J5N1eC/Z3ip4fVoSk9bO4mCJhj9dQO1LmooZvLReizI+XMy9QD0cAP2kSxz46ELdwNooJ3hd73sdDfiwH4aymqJBRZ8aWbkgfMtPdtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KBtDgiapFJcIKCPe4nPRfsTsnBIssuluOImdXfmYcg=;
 b=tdQCgvVLb+g5EEHkgMJt8aFa7zXdeJ+5fJQjNlh+FgCVLgH0cBbMv5KJo54Vmc17bswdK3+VEtmS50F+aY9g8REc1nevj9+vKoJ9ScAy26RIhsmqMQc7OIoR9sbHFzwFt3D61x5IoDRhPo1fEDVXvvU7Lws0mrNgtSWUV9rHFpJrxlboUWbZzF3rew4snRCH/9QxVGRBRo0+G5l1EHYX6mX4SA76lAx5kZjrDvzyEqDw1ct4ZldQReVh1GGCaYHGnF4cNvk3yF+Qo30uiMp6Cv8m3pdIygdCXQM0R4QOwYnAy2K37tTPMIMC3vST6sHqb38irhR9MVC4EvaZnIuH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KBtDgiapFJcIKCPe4nPRfsTsnBIssuluOImdXfmYcg=;
 b=awlFV7mxkxPsI5kdCHd5UHj+GPI/UkB9ml5j7lkjvK5+ZBm1JrBbuCLoikmlR+meiuZdMyeC1QiwYezyhG0ucNnWRjvCVWUP7GDciTMIxjvgMtyzuiHUl3bRiENvyX6ldF8NQu1/juKTN1yVHfvBkas2xupwdIeDjsSjXuFn+PjoGsC57ps6433148joxEpmpcHzTJ5X+MD8YKiCp77fOK6D52XQ4XgcQluM87QJjP7SjDIqATNecYtab9j4L+iHaYOUO98NoFi5zXhS28W2I/eoG3eB4GbK+vVx8jS6Er26iA91fvG0eETqKZilzDJqnVcarlSfuhCJ19BXmoA/Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 07:41:39 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:41:39 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev attach
Date: Wed,  5 Aug 2026 15:40:39 +0800
Message-ID: <20260805074042.30173-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PUVP216CA0019.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16e::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e1605a-9202-4b9e-ab63-08def2c4f0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|5023799004|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fx75ez5JE2sLomCHNrBdFtj6ADiM5353oByg8VzDLEV00rsbZiPf4BDHnLz+JVx8Kc7lK3oKPwdn1l4rC6JlDpGvUXSYDgRlAkPIsExVYd1XOGUTRz4hlhvpdXELgPqYv3JHWTPBNXSX0XWut6DeYyAMG+pIzhu6pnK90KL/hlOKH8FjRvmfe5pgE89Q12sZwBHSSIj6gDLu7tGK8B0KD1n+lS+2s3oC2JznecRdOcNoCmdUPo/Fw4t8GfZstTkQeuQQ2htevMgV8cJhU6qw9pwIR/gCCMgW/hAD4gGA56oK6H7WQYuRdYYgUFmgM1SGNNewFKZfHWLyJo9Em8ODksObVHEFGJwXQBif5PR1JuTq6kGC6z6/mjHQeS850yR5HVi1EAclm3OATWV3AhgpIoU9mTtMNR07rtyvvbAWbYXESAvXHUbLxSTivOB6DQonrOH76xj10ZoKhq+8gtOBJHQYxfGFSAg95Hbm22ohcfpvHKvN5BfjN7MjHvStXMdF2soxiW0Ygc84WKps/uFWWTrCXkr+3B59P9a5yshKOYx+WTg/nGIKmsWXm8pyZDWAe3ryMSGWi1NBxQV/XuLaN113bdZqMgqb7M3uXx1hSBk5EYiA7cl0N5Wy2h4PS/hQImAfzyu3i9ac3o2tWXSQ+G82HCfpmbZglfYNEHlnczc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JdO1xWY4h4lRvrB/9m5xQITKXq00O9Cq7PKa2oUiOYxWIR+VpJqDFIyq6fp7?=
 =?us-ascii?Q?ff7oHl0x5PTxllb8z8Qy5X/nEZ2OIn6YLl5DH1d0FOibyI/l7Cdrc3ZSgt1o?=
 =?us-ascii?Q?UwTH77a70wVI2q2Oea4jolTvebWUv/Pub3p920W06JlKdy0AhgoAaKKEe7rk?=
 =?us-ascii?Q?OEMj5MzEqI5viX8NOK8ZcdjkhmDgT+dSoXAejfI+VtRtm3zeLDNQzK2aA50a?=
 =?us-ascii?Q?Vw1THNG8oWaFWIGFkfpgzM8qC8mqfRW8r10FxujA12GwaTZgdxPksB8Mq79E?=
 =?us-ascii?Q?vx5mfrwhgFTRkPiYujGK+EddqUD1XJAqBocne7uYeajIluR8j6BzybPnH9Pb?=
 =?us-ascii?Q?tDQYXIkhJYN0/9kSIN8frjiUz6ncJMBW9HPZchlC++d3/7ktueA5GdPbo0E5?=
 =?us-ascii?Q?OaBZz6PAKjHyw4dNOS0BiuuS1GDNxuxeNpCZo5eGtrb3W8TJqUqYd99hGLU9?=
 =?us-ascii?Q?GOEEk/LFSa7wwZJU1QVSerqFvt2bVNIlG5SkHMjqVTyrbcFeHCVlP84yEDci?=
 =?us-ascii?Q?1/yW/xhBUIg1Wcwn9zcEcuwsUNpOXrTjUP+MOehl0cnnejvU7elEm5wrW+/c?=
 =?us-ascii?Q?55+WKK6BYvurEhIWFJ78wzwOsbR2ggSwGeBVSLjsW5s7D2igsBJjn52vAx17?=
 =?us-ascii?Q?EtcCqtQbXsRa6k7CyK/Oj3N6wLmOtXxwI1mL9ytreNWLyi1xGFMr1C2ITosv?=
 =?us-ascii?Q?Li+bBAMuTKTwkreHvQInd7/cJYZb+VwzzCCmLHkqlakBxSuh0H9XesWAhBF/?=
 =?us-ascii?Q?dHHNbmefqkCHnHlL6PeS1dNGTIiAjpBbGcH2E9Dw8IGRAuE8y37B0+Jfad97?=
 =?us-ascii?Q?Ubklr2XL/YhMc9LpDpC5lzZRZ1LzRUVCj2xSOSxc2H3cyqgEvJiQKFpZ8HjG?=
 =?us-ascii?Q?M22nrzV9omSFHoh8ZwyFRZ7Hh/6JO/so2+y5V1dfznzaHnKK6z1uoxGLy8ya?=
 =?us-ascii?Q?C4kLguzaYrodMp/jydPEO11XnrPTnJl1fENjrFlmTL8YfKDNrY2IzdYYVoss?=
 =?us-ascii?Q?G6S8Sbcv/rEqJcsdTxcKpDppC9oVne7Jc7aTudIShgL+X7vZdI9ffQM/7qZ2?=
 =?us-ascii?Q?86r1ziHQ4M2Og643MTJHYAsgHzvcJRVHSEpd3SfySBBNk2728NJGdJ9YcBIG?=
 =?us-ascii?Q?pw+Av9S3Nn/SBwcGg84UlYZRns5k6wzsGGr8EFtBZfYpfStzU96FHFgZLzTs?=
 =?us-ascii?Q?wGb/ZR29I1yVpqAbhc/KEVUu+xMRJu/NP225hh3Tu9Cjim5pOzbrGd4Cx1EH?=
 =?us-ascii?Q?mDRn+OAfQnEd8k2XMLHKUwLg+IxvM528m3VOCjUrgXY8fcdEbjI/pcG0rXyU?=
 =?us-ascii?Q?A00lVfASUr9HH2JUasY8T3emmKzSPaG/0VbTDc3yZLEocWTwRM5Vf6ZAusWA?=
 =?us-ascii?Q?JCGwhTTszYLYw7PZHZziMI3UnzqGOjUzbUxvQxiMwc5kZOaU9Y7qz5ZN3eYf?=
 =?us-ascii?Q?I1R7e9ZyV+LkgMZxQb8vUBVEue/56YJrYMZHXeeDiwStpgvI498X23XBQnff?=
 =?us-ascii?Q?S3l3AR/EjjHyK/8cAHhKb/uMZl4qcbRAp1nQUSWcpEjsSdgkbt1sja8NBgQF?=
 =?us-ascii?Q?VSseZipyXuhCaiLxulyRZi4max80mAVkas9eOMUGY5ZCajHmxiWhz3ie1yPc?=
 =?us-ascii?Q?JV0o0KLd6lRh1EgNE3ScKLFLtPjW/Es4BJDKE6VMCJJ2XDP9HMpUvLNOZOwJ?=
 =?us-ascii?Q?nyoaNoB3wE+AsUFIb5TZgpxXYjbAG9Iy+6etD7oB0ULepafoI+AYVkCYfTND?=
 =?us-ascii?Q?jSnHvp8pRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e1605a-9202-4b9e-ab63-08def2c4f0f8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:41:38.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpxcnZlXHipoVpbZj0zqR7KdqjbGkhaE0hQ6ZtAa1FLQsfRdaLKKWEGeynjDgttX8oAvsDtIMhE20Ihw4+FJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

A Type-2 accelerator driver calls devm_cxl_probe_mem() to register its
memdev and get an HPA range, but today only if FW already committed a
region. Real accelerators can have usable memory with no committed decoder,
so get nothing.

If no FW region is mapped, the core picks the device's unused manual
DEVMEM decoder and a compatible x1 Type-2 RAM root, allocates the full
volatile DPA and HPA, commits the decoder, and returns the range. Unbind
resets and removes it. Strict first cut with single decoder, IW=1, minimum
granularity, first-compatible root.

The design intent is that the provider F_LOCKs its region against userspace
but must reset its own software region on detach. A plain flag would also
allow reset on generic kill/delete paths, so we thread a reset context
through teardown and commit rollback. devm_cxl_probe_mem() may now commit
decoders.

Testing result is in the following.
- Built clean with clang/LLVM on arm64
- cxl_test, type2_test=1. accel0 takes the unchanged attach path. accel1
  drives auto_create -> a committed 512 MB RAM region. The test asserts
  the 512 MB HPA range. committed state and 256 byte granularity confirmed
  via sysfs.
- Unbind tears the region down with no orphaned decoder, rebind re-creates
  a fresh committed region.
- Mock test only. Real accelerators whose FW commits a decoder take the
  attach path, and vfio-cxl binds only FW-committed devices, so auto-create
  has no real-HW caller yet.

Best regards,
Richard Cheng.

Richard Cheng (3):
  cxl/region: Reset software-created regions on memdev detach
  cxl/region: Auto-create a region for memdev attach
  cxl/test: Exercise Type-2 automatic region creation

 drivers/cxl/core/region.c      | 422 +++++++++++++++++++++++++++++----
 tools/testing/cxl/test/accel.c |   7 +
 tools/testing/cxl/test/cxl.c   |  61 ++++-
 3 files changed, 439 insertions(+), 51 deletions(-)


base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
-- 
2.43.0

