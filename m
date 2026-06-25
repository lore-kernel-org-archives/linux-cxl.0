Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846B31F9BA;
	Thu, 25 Jun 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379748; cv=fail; b=Jbt0ZX18ujGMwrjZ7AkTux2v6Lam2KQBiFKtxoDEfQ0Syk4TeZLPbYBoQN6l8I8u4zuP04PgUejSRuTF8nkfYtaxaLvO4yxggpjw8uQPzM8V3b9z1CaNsV4musXBRo8NAwVvrmTmKlL1kj7GwEI5O1TJKD1n48PHP85vRwtAKUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379748; c=relaxed/simple;
	bh=8w/pVCEgKR2gGmdnAYhDBnhU0pNZWpdBS0SiegC6zJc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rbFdeELmB+O0c2VX/iAVxRN2o8xATwZ1dNK4bho9wBRI0prEfnq3q846zKhDKdusg56T2WMWFUVr39hlXxgGqrULY+8h6is5o7t+3Lfxysd9MgNiRCK2jNpEGdtXYbhvkfAJAng+V9Caoe3w7RxfQMG3FLiJjNUiabZXIvh2sLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZfL+Z4uN; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfL+Z4uN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS4BWsCvq1hVMF/lHMgbNQ1o3izcyyoq+N24p8z5Vtw+LO+NYN0df46G4vjbvQhCUwAMTh0PBwVyn3krzpgUADsEzKmb9ctJEwl2o4RXd34la0iz0c7yorNfAtg+ZVh05QuChXWmdtzoTCiQKjD0GTzLVsrnOtPUK9B+RaZ6cKTUisxedgSfIDxIVJ6EqAy4hvJLyQzcMUQYAwJNvzay7y7iXNjL9PtjRFLGbDHZGf4rnFslHxmrr2gZS6xFdjsmMHF4K9hdpVRCCySy28aK2evnUBl38QFDAF38PGpYdXDxrrn6Q8cXSf2cFUk+5vr1e4hI37G5Z2g3WKh0XFB+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nN7eT4bVN7/yWMfD9aI97p7bsTYjaZfZIcGCMXF4ew=;
 b=X4uB6L8d6bDM+4PFRP3Ro6xshaqCxStr1q3CpkaSxd/r8o91FX9tqdfXN7b03kHxM0JU3YEsRN5DxtJ1reJYFhRXBfstcgq047UvQTjhdm9V6bY8nG634Vo7CQ1Ov5Bs7Ogd+7srKzA4CstY7w2rDYR3Ef0vKxlN4O/NFgoRya143XvHtGoqHk+PxRqSnLMM2+VILR9vgpu+K7Vbi5PWhHFMk+77ZFb/y5LoNKSOtVyCVCt6dWtCactA220C1rbC7xIoE6YlFC2FChYga70NM9J+DsngcC9FIxmXrgqAHv6Z4qWnnBB6Lsqh2BN76jjWLaKU4ivDfTcOPBmp8CJHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nN7eT4bVN7/yWMfD9aI97p7bsTYjaZfZIcGCMXF4ew=;
 b=ZfL+Z4uN51ZSykWLQyTHcQsQHpY90aYhfvjeLbvlmTt53rpYuTYFFCdn0LX+FEGzez1o8d5fmXs4c44ttahNHGwzjeXpMxlhGiwpMI4DT3Io5xAWZA6SdZlgL4qNkOHwLzXCUftfMKZC3EKVuFzgiSeqZ/J3Gn6DFlPnJAFtN0sjfGpBptAckrOc5uHDdn/z4OmP/WHiXZvATJzC31b2ie44aEu3ggBC1J1Qkn69UfcD9/FekZYK/kM9o+wy1LxsJTrk2N33yLSSeaP0Eojvp08sSTkThSpdqg45Nolx5D10Ug6jDgNSOYg77d1Ozlou0JtPbmXLZNnfH7JbLFhFHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 09:29:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 09:29:02 +0000
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
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v6 0/2] Support zero-sized HDM decoders
Date: Thu, 25 Jun 2026 17:28:54 +0800
Message-ID: <20260625092857.41139-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: c50ce9cc-6305-409d-dc68-08ded29c317b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|6133799003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sYWqDcsF9xmAs03sd7nWeHN+rmRNLR+hVmPafjF4yw+XrfRD92b8TqfJNLI5wy3+Cxf7qty0d0AiBKy+XQVqvR5eEk60KzPpgAac0ezMwrv4aBD9CpjKZatMY0HLi1rBfTUUJ0b+s59Uqvo04RjRsFVOa9B6UtOMe6yMWk4liZxpPUco3u947ruf67nzu6jPcZMQzEXT/yOmR4cHR6Qdq9BrWiV2iEoaU4PyS6Gn5BeQMFAQr9iRpfL1xzQkK6UUEhrSuyGo0hbOLnjYI8WNqD3g1+ltjYaMpRcEPG5miMCWu8Zwqd/XeIuck6dkcMFH8G/ifSyAEJDdV00NormEOtUzxN86F7VtkH2d2dkiX7D9FqALa4P3y2JH3sWVleSlNyNW3rgpHLCkRZ+8Ui2lK0ck5gnzGpCY207MOEPf+UBCnVKCDpLVcO8Q2AUFR/f7jh2J32az73Pz7ozHPW2KJ5KvJ3Y2jF7Rw8CQ0gSPDCKDNnMhqB//BkL8vo+8nSM7gYU+IjxdvoZyRK1dloL6RUp4HNQMhAb2skK08z6/OBZIEW4E0r8CNkAuS1sZvSZgZaVP/Rdl5QM3lIOa+hnDCVvMbMxcpgTEkUXOBgDcoREabxX+ttTrWU0Mrp3pqDdIPlqPGSaXdULdF/iZdM8mKV3INbkr1eRWJeDB35cu/Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVlHUXl1RWpKVnZmYS8xVHorRUswcmRjeFNpdTJEaGdVQTVXc0VWc08yR1Rt?=
 =?utf-8?B?eTI3OXR4NkVkb0IvZC9scGkxWE8zTi9rRmtId01aRjkwZ2lvVHBFMFlHWGNV?=
 =?utf-8?B?K1V3V1JQMklxUk1jK25hcm1PMTdpQ1hoa1RrMk1jeWZmbzNXV1hnRmxPaHdt?=
 =?utf-8?B?SmN6SWYxUHp5UGs4NHNxaFNOaHhITzUxQ3RTRXJZQ2hvdkp2akFSaFJOaDVY?=
 =?utf-8?B?b3ZwVk5SUlJuMnRXeWtYZjZ1K2h2NXJXK2x3VW5MMHFXdnRVR2RtVndUcytS?=
 =?utf-8?B?MHVZQTlPOGNqY284SWNkVFdzVjdXWHdvdUZ1Z28zRVB5VGpLMFVZUERYTW9r?=
 =?utf-8?B?bHM0eUszaER5Wm8wVjBIWXIweVhLZ01wS2duSWQ5Z0NaNzNwVnpUcDFvekVk?=
 =?utf-8?B?OGtZUUxjYmczeWFLM29jRUZMT2ViOTRmZkZCTGdkc21HQ1p2R2xoVVowd04y?=
 =?utf-8?B?MUNNSXd2aGRnL3JsREIwcTgydEFUNmU0U3ppMlBpbDM1ckVrUU0yZnVZcXdm?=
 =?utf-8?B?V2hsZlZqdjJNU1dhN3VISVFRa21kbEFEaU5sb2liVlBobSs2OHdDdXVxWUZS?=
 =?utf-8?B?SHZTV29XeUN0M2xid2NxTmx2SzdmbnBNUDhoMEYvV0dTakpwY3Q4bXBQc3Fu?=
 =?utf-8?B?ZHUxM3Y4VWV5alkwZXJLa0svVDFVREZjRTRwYjNnV1FmZ1l4TXlxZ0JCN0o5?=
 =?utf-8?B?QmFqOXd2bE1Od2gvZWUyWm1Dd1Zacm50WVhIVnZwRVdhWEZVWTExbGNtRExn?=
 =?utf-8?B?RC9KTWxta3ZodVltZnBuSVJPRHRDdlNWbXZ6eisxc2UvTmE2SWc1a1M5cXdV?=
 =?utf-8?B?cnptTVNTZHlOVFVjWndGc1lxZ29KMGNlWmtWNW9iS1U0YTgxRWpuUFNmOW13?=
 =?utf-8?B?S3BkdlZrd1lHUEprVzlLeWZVYVN1SnJPeFE5ZUEvcjNyRmd6WnNkQllNS1Ny?=
 =?utf-8?B?Y3ErTVRMaS9JMm4rUFhiVjVRajNCVS92WElWMWRsZEthVVpST3BVN2RKN0xk?=
 =?utf-8?B?OEsrclk4ajVNSEVabGFkVkwvK0I2MXZMaXdoY1pSaXpsU0xYT3VyMFZ0NS95?=
 =?utf-8?B?MUdGSTlWSUdyUHBaL1NMMFdzc0FWTHNONmJkSFFWZkwxOGJOUmNVQ1JXNEhP?=
 =?utf-8?B?bkxzQVhrQmhrM2hTODZLbkMxRTVoRTJmcmlRTlUwMDhBcDJyVlA3c012VzBL?=
 =?utf-8?B?NzA5MThtdG41Mzl1dzBQSjR5c24wdFpWU0hBUUFnV21DQy9RWjFRR3FURkdU?=
 =?utf-8?B?YXVYa2tLWWJMQjBsU3hpTWkveWgzelpXYWJGb24wVkJnRTluOWZYS1Y3NklT?=
 =?utf-8?B?R0x1emp3TEFCVWt1cUVHSFNxSHBWaU05ZHc5QVNlWnRRRXhSb3NFa0djNzRQ?=
 =?utf-8?B?ZWNYS3lLSzFicEYvSFpmQ3g5ckgrWkJHdXVwTCt0djIvRjRZTTFEVzRJTkt4?=
 =?utf-8?B?aWVBR0JJb0cyZHhHOUFnakVPZ1NvcURoUUFzVmdTdW5vOVRzLzdwWExqUHRs?=
 =?utf-8?B?M2tTdCtZUXhibktISTBJbmJZZXZiTlRXeTJtVmgyYWQ4N0hDWHFjZFBFOUYx?=
 =?utf-8?B?bmNZd2xGVUtCbDBYTnk1ODhPQnI0aXQ0YkZpTTBObGdCbjJPeUt5d2NHNkU3?=
 =?utf-8?B?TXNVYkV5UmZqcFAxQVZEcmg1Y3cvTkZFTGRGamh6aHZ4aGIyK2tQL1pmZjhV?=
 =?utf-8?B?aVZoUXNxeEpzS01kWVl6M244QmloSFQyMEdXckluZjB5anhnNG9hWnA2UkpO?=
 =?utf-8?B?MS9IeTZGRTkySXdsL1hVNUlvVlh1NXdiaVNnSi81SkM0YkpaNXRxK0RCclVa?=
 =?utf-8?B?VFRUQSs5VHAwUWxpekVMRVhVYSt4cTRKeVZkK1NzeVVPcU9jcDk0Q01KVXNY?=
 =?utf-8?B?NVJzbEdRUllZbjlhdkNUa1huUS9mb3dqSkpmVHhDZFIwTC9Qa05sMU5NZCtk?=
 =?utf-8?B?QW5QZEZsb2wrKyt6T1lmOGxrcmdnaWJ1Nit0ZzgzaEZ4ZWZHazZ4ZnZoMUlw?=
 =?utf-8?B?eFdLb1FPNjFtTW1rRTBQRlA1VHBXRzdZNG95Q2k2Nnl4OVcwMXNhL01YK2s4?=
 =?utf-8?B?Z1NOZXQvQXNYVHgzcEZKUjlLbGxucmRjMzE1cWRiVXJkSHlBMHdEc1RZUVl0?=
 =?utf-8?B?bG5BamNPa3hDcTdOWDdybkFFZVppM2ZxaVZuVERRNmRiWEJ2VXdTcDBvT245?=
 =?utf-8?B?by9XUzl0bkhJa1gwSDdvUTFsYWo4QnlRdzQ4SFRaU2FYbFNVbWRrcS9OUHYr?=
 =?utf-8?B?MlhpVHltaXphWVcvd2JpUHc4MzNuUmJMYkRZbjdnVDlFNktkMEZ6M0xpT3F3?=
 =?utf-8?B?TTMzT1I5QUJscU0yTDMwZ3QyN3RBdjIyMnNPTURDdW8yMXJmSDY2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50ce9cc-6305-409d-dc68-08ded29c317b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:29:02.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5IMRicflCAWk11754ZvsK1rL/uvyiU5+PTsXRbNUzmCBJjqg/FlKC9dALlYuVMADo94fm7E04G0Q9M0br4LSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
with size 0. BIOS may commit and lock such decoders so the OS cannot
program regions through them, this is a design choice rather than a spec
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

v5->v6:
  - Add Dan Williams' Reviewed-by to patch 1 and tidy comment wording (cxled_empty() per his review, plus the poison-walk and a mock comment). No functional change.

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
 drivers/cxl/cxl.h            |  10 ++++
 drivers/cxl/port.c           |   3 ++
 tools/testing/cxl/test/cxl.c | 100 ++++++++++++++++++++++++++++++-----
 6 files changed, 169 insertions(+), 48 deletions(-)


base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.43.0

