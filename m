Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9263DAAAD;
	Wed,  5 Aug 2026 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909340; cv=fail; b=hRZ1XBa9lUa+Jq1HQgSYSwqrp4VKNkSP0wCoYY9nTcXM2yVQka+Mz3QFfHxayo10oigPNfxx2cygyL/CKYfRVxXLyibw1gmEqn1HkGTlaLBiPWBW3OgajD4BbDaf5VmIGcr4MF5mLH2jGhP5klfTBli7/fCRhfB2qTp0KmqFOFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909340; c=relaxed/simple;
	bh=eRkSsstKmRwKpNBPM8wS/Aowu0VyItL3qa3w3xp5kMM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q14bL6QNVOgRFeh58yLhteHRjro0ch2MZaQgQlbHbdN1c8Q8qVWYIk1vOuHNtEdIvaugcVJpMTEcSDIFlkWWVn8XIJ11jpSiYr0xYKTDXDxr1NvTi3orPFcGngphCKyjrgIFx2rP/LW0+9hawcLrIQ5QkOZt+pyGyAjY0H8kQEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwMMT6i1; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwMMT6i1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxe2Q4CdnODJSwwLpAJ0xWKeY7jJ+e2U7hnNgu8sUka6OeUjkSaMaKcF54hiGmLAhzEzlJjJvrKezva8XaSGEfYYFTQiFiMc0FE3ZnsB87OoKgXPYAE+Ln6ddYhHxlnEh7c3Cx6JKXs160PDlVg7vKYJrr18UpVL7A40fTKGtAgqL/O4+5urZSg1zXMUPc1v7nrMoupgQiF4V9KeGg+FXuzSMdslNdL74YWZvPwlvTaW/fX5EAdid9HYEnlmbEu2K4jUHMeD8ymp1SFECt3Nkq+8w5Y2LaDdhtrRggMXmtK4YxWOLUma74aNFmUdT0wpwEvUq3Abb2Om/orZmm+Wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9AanbhjsvgEXKnq58i96HfXtj15ax3L4cU1uExqYes=;
 b=tSnI/NuKaqCrnyY46dwUPsMUe2GU5KA5aWaktrw7xjem554lMoIA8tqnfCtWMwURpavUa/5WSvneHKXIPXwoaJrLN6CPFloiCKp9CyCkYLgqlokHM2dnrrzK5XgxtaOGghq4Ovtb+WL1Y+ZznwxajFLSDfbozthWmSu4MQmB1bEGfyEa/bd4u0twWVuAUud/COoeEeiMq0lGIg+tvJcwHFMQT2HjyHSNeV0L7IkKqUTimyeA10i2GSOSXWIGky6ZUv43Wvs2PCxgKa3hc/i14fFsLQIeyn1PGqFaTz72cjHbRdjxmAp5GIVpizLC0dillj+g6vRn1UTL/2EvCDkWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9AanbhjsvgEXKnq58i96HfXtj15ax3L4cU1uExqYes=;
 b=mwMMT6i1gN7/UG3xVPUY9OYARkiN4ky/d6u45/gsLDXlMvT9d6xTC87iGZU746NhewHj4WnP3V9E1b+H0ihc9fBLTZ0kOiQiFT0a6OIsyjmyrwaTfIs4Z34obFIg7q2AaFJL3DHIbUZOIljO63MK3dgLCjoJwXhBProJLf9IpcIiCF+1TctsQRFypMsRuJyb4k9i9xUinjvfGGVcepoPe9gBr4DO4SPq9WxP3x7ZkpIQyT9H4BYogDUteSmwCLUX8mnqlWz5IIkOVyuskRGERfsVxTrITYIO1RdhVuVwjl07F90TZ/wwAC/YnwFC4ZkxdsLJvtRc9e6QF+/i+EisyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 05:55:31 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 05:55:31 +0000
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
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v9 0/3] Support zero-sized HDM decoders
Date: Wed,  5 Aug 2026 13:55:21 +0800
Message-ID: <20260805055524.22311-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2601e907-c526-4f18-a877-08def2b62852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|10067099003|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	e/mUYwEKo35yvFAXtqVcNeboqG4KlXqgltQQbqP3r3MwCU9zkFpdjw+P6Dp7Y0jS+3Nfiikz+45QPwe4OuVoiqR6s7jcjsx9s5x4Pm00/WeYcLaNcrL4gOXw+9Gbfy5EFD25IMcneuXW0pIMeW5Z7CzHpNln9qqA+d3n512sGU2LJLHDR/vY8jREzVoZEBvBIGFKS5tW4wj5+QMfLikqwh8KOgNZXF086TwTnI9tLwnG+UE1QjZ5c3xZsTgxz7Mpk4KgVZ2jx/X2/su1KlfcBAY+Rsed54puq96FRrk0ERFbASzdcRaQWhOUuUUhMP4vmIfp5w9eE+2FvhE0JI7JnWHeTH8CVUrhKwux7/xuGsFdztQph7e2Yevl+WdeXJiaVQl7jCbfd/22Fpf9PZ6bhxBw4CNRVQyOjlR9MVCcJCNAfLHJ5raxVRh2yaI72Y4hNsHWaF6bTKcTnnskwciz+eyOXCccK3AMbXxGOPkYQoJapUHSSXk93MWF5mnOuw1LUkp8NsABlytDaJTS2YAvwIvwCI+xwTiMGzLCa6P85H3Ya9iSM9H4Rx9PoXMflFOF0wymyAMcsciV0vVbv3vtNoR4YHwgpMcSUZlRuTWNRYuFLDOC3MY/LIE5uj1Uu3Ps6KoMEuCm6sv6lyiFw0bGUAGDgMpGq/BUS2wSoAU2l3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnZtS2MwbUM3RlhZTjN0bGVVbG1aTWw4TTNwaFJZKzlrRXF3VnpaL3BhckVN?=
 =?utf-8?B?eSsxUkVTNm5xcUcxVnI1UTI1SzNFa042K2FmN1g0aVNjLzltdzBnUENPc0R1?=
 =?utf-8?B?T1VxUmZFRGk5Wjl6VHl5eWJXalpFNW50OXpJTDluSCswTFJJaGdNd3RzNFlJ?=
 =?utf-8?B?VXNYSEFUZ1hxK1pCSlVQeW5yYTI0N0JSY3BzbVFXYUdIZXlFcjgva1VyZDJn?=
 =?utf-8?B?SVp2akllZHI1SnJ5MFIxRkIySE5LUnJCSHgyU2h2VzIxSmg1VDBwcVkvTmJ4?=
 =?utf-8?B?S3FMQ0NzRGVnTWpKL1hORmNtRE5iUW8yK2c3YitWOXlSM1FYRFpKdnkxdk1x?=
 =?utf-8?B?RzlDUTN3TUFaOUsyYUN6ZTFPMlhyNjdNQm5LenRiRTZ4ZGMrbitNV2lrWG9U?=
 =?utf-8?B?NEVOYklLWTQyZFpNL2FQNVlueU5ZWmYxZ09hOVFpeTlxaU1uRzBHOXlWYnVt?=
 =?utf-8?B?d05LN3pKQys3eGlLTnBCNVpsQkZObTRNc1ZtNGh6SmRqZERtQ3o0elFNMFNq?=
 =?utf-8?B?Y1JsOU0xclZpaVJkcTB6blMwYkRMNmZmbjlVV3I1TG80UjVoRkNFelJITGk4?=
 =?utf-8?B?WVJhTWRHb2FKY09MVmZKWlNpNFVxWUlyekpLbHhZZjJDMEVKbXd5dWdYbDU3?=
 =?utf-8?B?YlR2SXFTUWZjVWRES0prbGVZYU9UdlEyMFcwSWVtMlJKZGx0ZEtlWm14VnRs?=
 =?utf-8?B?MEdZY0NsYVUxQUUyaWpNd3kzTzgwNmZDeUVDR290TFJvbTNoRllUWDI5MWZO?=
 =?utf-8?B?NkNDMk01SUxKYmsweHQ2MXV3RGdHOUcrcHl6THgwM2tMQzNEb3NnNXQvUUh2?=
 =?utf-8?B?Qldjbzk2OVZKeStaSkFkMDI0RVljcFdwRXNFTE5ZQkJ2NnZvOEZHOXlxa3VI?=
 =?utf-8?B?elEwWUVoUnNnNHpoNTlKbjJoRVNoejFreWludVpYSzNJbDBSV1JYSVpvL2xh?=
 =?utf-8?B?YlZlU0JjSUdsSmUyNjRSZGtLRXhVN1IyRTRlUWgyZ3FYdEs4azEyWHZiUDNj?=
 =?utf-8?B?ZEFmd0hFcDQ2TVBlWDRKdUsvOGttUGJDbEVOSDBOOGdGREhFdWZVZWg1Qk1T?=
 =?utf-8?B?RW1zVE1RTUJaR1pzdDRVRFAyMmp1OTZBek5BSFRKUXhFQzRpY0VBWFFSWTBz?=
 =?utf-8?B?VjFWUWNlQ2krWEIyalhrVXBxb3BNNCtUNGtzS01hOTFUVWdKV3dQeENFT1Uw?=
 =?utf-8?B?bndFZm9FeWpDRFRBa0VaUUpGRU1Kb3NVdllMcE1lajNBYUxmUjRlbTNFcVpB?=
 =?utf-8?B?MGhhcTdXblZDTlBJaEY1NjNGSHVUMzN1a1hKMnF4OTQxcTFsNTNvL29SakZQ?=
 =?utf-8?B?OEw1eVJ0TTVlUUR0d1VLMGgyZHFvQ3I1dUk2Zm52MlBnYVNUU0FUUHJZd2JX?=
 =?utf-8?B?MFpUSnM0QnBhaWpLRHM5QzV0c09PcmZsTHMwUythYS94WjFoVURleFlzUVRa?=
 =?utf-8?B?ZTNnYTBGL1RPZzRuaDlMaW9HbCs2cldyNWVQTGdGTWVaTGRRWDhyN1lQUTd0?=
 =?utf-8?B?YXI5R1lPc3lKbGVrV0V3SXkzU3gxUU9LRFp3YkNyQ2RMcVBLNkRWLzE5c3Fn?=
 =?utf-8?B?LzgrK3NXUDlqc0ZaRGlvdUx6eFlCVTFuUWFPc29ZNTd0WEpPUDJ4eVlET2Rk?=
 =?utf-8?B?eWtVc2VvOGo5aEV6b05uTGloSnArVENxVFFrNXhUWDdvSHF0NW5OUmlJcDF2?=
 =?utf-8?B?a1RoM3p2TERsVVc0RHFQTzhmc2F5dThyZndnMG5qZFJpZVVPOWt2UjFscXl6?=
 =?utf-8?B?VHhCUHJUMXJvOEVXL0VzT2dobWxpKyt5U3dLVTkwckxDRzdTYWhVMExFUDZF?=
 =?utf-8?B?WmVpMFhzOUtKcXBmSVZ1R2tJRGc5U2JIcDhET2o4TjBOanBFK2NlK092MHJR?=
 =?utf-8?B?eFZYRHN2dmtGY3Btc2Z1LzdDYXFGaXRYUTFjc2pXMk1PdHM0RmFjVDlmSmpi?=
 =?utf-8?B?ZFBaSGRpdGpFc2FKdVd4YTZIZjNCdjZWSDZWV2J0ODhTelNSUWIzTFdRRU43?=
 =?utf-8?B?Yk9YMmJMMVlqenNVa3ZLeDVSVEhZSlVRbU5OYXovOVRoSE4yQW9tbm96eWRU?=
 =?utf-8?B?Y3VWMHljZ3ZjUDJxK1p0d0YxSHQwTm1XVzdHRHNOek1RaUZ4aXBCYTBla2lL?=
 =?utf-8?B?MUpwYTZpWVhRMWNibS9BdTNTUzVWWDRRYzAxcVJjLzZmM1VIdE5sUFZCUkF4?=
 =?utf-8?B?U3JobDg4YlhLNzFlMXFJZUVNMnBGa2R4VHhUdzlsNjZXYTVReno3akRERWh4?=
 =?utf-8?B?RFJ3KzVTL0Y3N0F2ZTRrZzBaQXduNG85WW9vUnIvTEtTRklTZ0hjRWtCRFVU?=
 =?utf-8?B?Y0tJYytBKzVmUTZvNHpVd0g0UnR0M1RvQk9WT3d6UC9QaGRNM2ZIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601e907-c526-4f18-a877-08def2b62852
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:55:31.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuqqzUdAKCUvtr81xa3EqGp0A2gr2yULHsLlF3X4gb5Pov3VzWjZ5gx0EO4xA4gfhpC6PvlnM6akJpr2cyLxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and
§14.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
HDM decoder with size 0. Firmware may commit and lock such decoders so
the OS cannot program regions through them; this is a platform design
choice rather than a specification requirement.

The kernel currently rejects these decoders with -ENXIO during port
enumeration and aborts enumeration of the entire port. On affected
systems, this prevents the CXL topology from appearing in userspace.

This series enumerates empty committed decoders into the topology while
keeping them out of region assembly.

Patch 1 is a preparatory cleanup with no functional change. In
poison_by_decoder(), "rc" carries both an error code and the loop
control signal for device_for_each_child(), so returning it bare is
misleading, the early guards mean "keep walking", not "no error".
Zeroing "rc" to forgive an -EFAULT on a RAM partition adds to that by
discarding what the device actually returned. Return a literal 0 where
the walk should continue, and test the forgiven case directly instead
of rewriting "rc". Patch 2 extends this function, so cleaning it up
first keeps the functional change free of unrelated churn.

Patch 2 makes zero-size DPA reservations first-class. Since the resource
tree cannot represent an empty range, an empty decoder is backed by a
separately allocated resource. This keeps port->hdm_end, skip handling,
and in-order DPA accounting consistent. Operations requiring non-empty
capacity, including region attachment and poison queries, are guarded
appropriately.

Patch 3 adds the mock_zero_size_decoders cxl_test module parameter,
disabled by default. When enabled, it installs committed, locked,
zero-sized endpoint, switch, and host-bridge decoders under
host-bridge0.

Tested on arm64 with cxl_test and the ndctl unit suite (ndctl
v85), on a kernel built with KASAN and lockdep enabled.

Full cxl suite with mock_zero_size_decoders off:
"""
 1/16 ndctl:cxl / cxl-topology.sh       OK                7.50s
 2/16 ndctl:cxl / cxl-region-sysfs.sh   OK                5.29s
 3/16 ndctl:cxl / cxl-labels.sh         OK                3.44s
 4/16 ndctl:cxl / cxl-create-region.sh  OK                9.97s
 5/16 ndctl:cxl / cxl-xor-region.sh     OK                5.77s
 6/16 ndctl:cxl / cxl-events.sh         OK                2.89s
 7/16 ndctl:cxl / cxl-sanitize.sh       OK                5.74s
 8/16 ndctl:cxl / cxl-destroy-region.sh OK                3.84s
 9/16 ndctl:cxl / cxl-qos-class.sh      OK                3.22s
10/16 ndctl:cxl / cxl-translate.sh      OK                0.95s
11/16 ndctl:cxl / cxl-elc.sh            OK                4.22s
12/16 ndctl:cxl / cxl-dax-hmem.sh       OK                4.60s
13/16 ndctl:cxl / cxl-region-replay.sh  OK                8.74s
14/16 ndctl:cxl / cxl-security.sh       OK                1.83s
15/16 ndctl:cxl / cxl-features.sh       OK                1.45s
16/16 ndctl:cxl / cxl-poison.sh         SKIP             11.66s

Ok:                 15
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            1
Timeout:            0
"""

The reason that cxl-poison.sh is skipped is stated in
https://lore.kernel.org/linux-cxl/anKpY6Y1Sqne1f7Y@MWDK4CY14F/

Both run_poison_test() rounds pass, so everything this series touches is
covered, only the unaligned translation section is unreachable, and the
series does not touch translation.

The core patch was also previously validated on a Montage CXL Type 3
device.

The corresponding ndctl test is attached at
https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/


Changelog:

v8->v9:
- Patch 1: add a poison_efault_forgiven() helper and use it in
  cxl_get_poison_unmapped() as well.
- Patch 2: rebased on that helper, no functional change.
- Patch 3: no change.
- Fixed the test environment so cxl-security.sh runs and passes; the
  suite is now 15 OK / 1 SKIP. cxl-poison.sh still skips, see above.

v7->v8:
- Split the poison_by_decoder() readability cleanup out of the core
  patch into a new preparatory patch 1.
- cxl_dpa_request_region(): split the declaration from the allocation
  so the allocation and its error check sit together.
- Add the missing blank line between commit message paragraphs in
  patch 2.
- Patch 3 is unchanged.

v6->v7:
- Rebase onto cxl/for-7.3/cxl-type2-test.
- Patch 1 is unchanged.
- Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
  paths.
- Integrate mock_zero_size_decoders with special-topology parameter
  validation and reject its incompatible use with fail_autoassemble.


Richard Cheng (3):
  cxl/region: Simplify poison_by_decoder() error handling
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       |  55 ++++++++++++------
 drivers/cxl/core/mbox.c      |   3 +
 drivers/cxl/core/region.c    |  69 ++++++++++++++--------
 drivers/cxl/cxl.h            |  10 ++++
 drivers/cxl/port.c           |   3 +
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 6 files changed, 193 insertions(+), 56 deletions(-)


base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
-- 
2.43.0

