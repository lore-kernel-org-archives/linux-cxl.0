Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B3347BAF;
	Sun,  7 Jun 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820041; cv=fail; b=o9e0M68fnGuU6LLww8qMrsiN5ngvTyhQnS5jSVFQG/IQlKLrbbd0esvNw0OuFAQcO89015DMbhDZKOH0nnAPsw5EDgQMTRVq2bGt2wlfgN3+Uj94nDdqTjjloG8ySXHQ/VM3BJbmG8vKLio3rJwrL7i+wZkHwfmSjDUNufQwlaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820041; c=relaxed/simple;
	bh=lcYwnllJcwaXAMgvwZRkbfOKspv5tZ77gIBCcPc16lk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NhUmOlFU2ncQCfgQyDhRv77zTuamGsQgsriq3MxPWhWYvevB/Z1bOUjA6gVsF7sovDvWNkPTQM2VVLWFByBMmgWAYCNuKhzbRZNz4Y/Ip91q0HMsqBZvM9NqsZmQLwzS5kxV04OGD/L+PFr+R2Y7rbLgnjlZtofZJ6CVu1jyiY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWF3utek; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWF3utek"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUiTmyJmPs0M9bnJAw8Gpexq6qPraB78PMno7gldq9+mmjWtH8ezzg8oy+SYAk7sFDr9VQIXI8q1EtwyzIWn0z2O83Nkv5aSxeqstStySTw8pVmkDpcK9dqj2WUonzDd1Y1u/iaWkj5uunthlE3Waw22WZ3XKCycgn7IrlyMyxKKAwE60x3bQvg3Ybe94Fz2gA9b1O3auoA7NwE14lPnPgA5woK1gzTp+taPJhLFYVICypHWwsTnMfjfqKSDd1bHQMA91ipTzXPfK8l7RmaVTXORiov4aAq2DTlGi1i9XoQ4jE49owI2RkPM4EZOf+hPfk78QovUuZv21uW1Rybn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsWo4NOQxneGWGvuQcd9mdoTarOQFOhc6ZwhUL258UE=;
 b=xikn+/9daZws41ITdauC2fSy6tXyG+nl2q1GGAMTwxZKHORUUKwtZCTlpTARiIxWZH3da0t3/ahj8UZGeAjIiHzrUWJQjiXJBhVsn1/oLiwtMuiJFaoSgrWOl3ASt2DELsusiqK2TFOI5IVSQ1+d84AXdRbrV0BhpY+4RmYpFZtc1F67uQ1tbYIipEGu0Enj7kywsjwrMuU14BQwWVeHMwJ8xe0s8kSWkii4ZvItQHTSjfqQwmOEbvjGFG2WH7UyEcO2fz02SCbZTgX8WYMq3VgnCsRHCylJjWmcMsDy69aViMhb2EnFlLjOS3BARmekWBp7TANtWldjayYL5QNEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsWo4NOQxneGWGvuQcd9mdoTarOQFOhc6ZwhUL258UE=;
 b=PWF3utekvUfDNkV+GymYBeARYSYcQoJALBu1cZpWeCWx0DL8vrw/NsVk8ElpwEN9jeXHZ8tFfA1+z5w0J7Mz5fezf3jk1Jcqskq7LjGSkZWSNz9vjHl9A4HMwlA1l8XXxQNgukqpkHbDWP+fQ0/9c8qW91+bFsGw33Q49yQWqsToMolfyOUUcsfcpqFD250xzjjrhX8KWJRMdNN8Ykof7l9p+f4UhQM/fT9lljbUr+aQOOuyG8uJPBkjbfqQhAmqHgRBnRCB69MT2EK0Uqbv006QDoV7EyIrsjzBFIU6LHZg/QFMjJ4envYlvFemvvDiC+EQLc5quVzHv+E8jwREpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 08:13:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 08:13:54 +0000
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
Subject: [PATCH v4 0/2] Support zero-sized HDM decoders
Date: Sun,  7 Jun 2026 16:13:43 +0800
Message-ID: <20260607081345.61954-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: d9004314-b3ae-425c-00db-08dec46cb6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|3023799007|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	B03htVLH2bPlIMxypjBJO+k4XHjeUxmaFqGIPRh+1BsojmNQhl7/A8TuDUmpHhOs88kcPXL57lLs1n7DYgBCY/i0/tWKJFYXD/yxd+en7k+GVLtdrTZ/VtD54akoX5NVr7yjrK4lVl1i1DYTqrcSR1FjU8oB9AwKB2N3bdx1Z8hMRlpYsmvVzer23JaE6w2zXR19TR63apabyEpNWNJgjQ4AtiCiBr6wuejaSpUYOTvOUfTzNbwVVPcwz7sPv2pChMmsDNQ9NZnDw31mEVsZ4iLSBpnu3KcaPJ9tUJKeTC3Ta8zj3/PafIv2n1TDyz8caPy0qxesQo0FKFWOSgZIYvHtQmBjl+tX/oteCzyQYfjGlfPD271LpQs8Izsm2IznP8avbA2lW2FTtTmSKRtlFhHmtY/2a2X1dRED8YXbOSIGPmGZOVZRAIw+o8UniQl7IFd9PzntRYIpS1fwVNgX7QEx2ww3ev+XN4UyYrFCJWh0PEZMrv8SA8m9ndGjVOCD9th3iaV3dS8hf2xfBtAYN/dYt30D/vNnZIj0LXv5T3zaFwfJ7ciLF0ceP6Bl9MZBO6PmcOw60em8DTul9xp74cy2+FZehfErL8Glki81CaEEmgOBW+MS2rPvl0/yLezJcfJHlCuLjMEw1/l71m5GPwC4CdLRYsWnS+UxIeYGoIsusa1e1H2eT5ks9Ti5e/ycRCGddv8hw98U0XysSrxVgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(3023799007)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHY1K21hbHlIQkhVM0p6dEpIWVlYNzRGbkRReFU3WmFEc29DS0M3aXg0YkZE?=
 =?utf-8?B?WU9ZNUtmbzYwRmdmaGc3MG8yUlJOL1VPbHBxT3N0K2JNdEJ3RXUreWw2NEVE?=
 =?utf-8?B?c1U1NzNvQTI3anBuaXROSFU1ZmlKSHlqT3haci8rMlNjd0dCa28zbVBLak9O?=
 =?utf-8?B?YmF0VXZjc1hvT1p0VHJiVXA4bFc4Vk9jQ2NoNHc1UENLenhUTHZ1N1N3RFh1?=
 =?utf-8?B?cnVpNHIvZnVWQXpiakZLendRSXAzckhoeVE4MTFFU2JPb2tyZjNTeXE5V3My?=
 =?utf-8?B?S2toTG9lUmxvT2Z1NWM2UjV6R3NFOUJXZExJVDVSYm9UUitMM3Z1dG82VW9z?=
 =?utf-8?B?OXgzUXdOVktVMUc2ZWYwTU15UUVGUkpDSUh6UUJBZnFFZUFXOTRHK2FUd2RY?=
 =?utf-8?B?QWtDcGptSjJEMWFkSjArWk8zaldzazNFL0swUS9rNlZwMFlLOExFS2JzbGVa?=
 =?utf-8?B?TTA2MXZsQWN6MXhHN2tmN1NjYnlFTGFJWHZxR3hsNWxOZUVxaEtvYnBKaHNl?=
 =?utf-8?B?RjR3U3NNdlpIanNDNnZ2V0VWdGM2L29rNW1EZWc5TGFGUXlwU0hxUk9BMk9k?=
 =?utf-8?B?YzVwaml5MmRqZGM2T09Zb0ovZWo0N3laU0x4L0swZWhvOWxMZGg2N055dEVX?=
 =?utf-8?B?L1BpajVCb0l0cGk3WDJsZUE2TlZ4TG9rOTNISkRQaklvclpNWlNaZTMyb1hv?=
 =?utf-8?B?UUk3Z21rbVZNOWh6eWNPWS8vM1c3aHFoU1ZHcFJOd2c2MUFHd1ozTnlEalB3?=
 =?utf-8?B?Q0lWSUpQdk8yTXAwWkFNbFkxWjBKRWlCNld5dVVYbTBBbHFUZEJtR2FicTZ1?=
 =?utf-8?B?eWVWVkRrUnNZa1VtM1VJRklpbUcydHNEeU8vZ0drOElTamFIVmFxbXIvbmFk?=
 =?utf-8?B?V0k1Uy8vSjRhRi9hT0tWRmJHRExjQ0N3ZnJlT2tyTUVJN3hUWHNLcDJYTmJ0?=
 =?utf-8?B?a2lTZjJQRW5laGZWeTJuUHdkQnJJdTRiK1RianEzL2lBWDc3VHRRNFg4enM3?=
 =?utf-8?B?UHZKOGgxdmIwUHhRdFJnSHhOOWJxWEJjL0Q5SkFoaWJLWUJkOHZFc1l2TTY2?=
 =?utf-8?B?ekRWSTNxb1VmNmdES0RQR0pPYXBEUWs5WGVvdVJKUmRYVDJaWmtNOG1ubUtj?=
 =?utf-8?B?ZHlqeXBQa2dTTHBYNnpjZG5zZzB2RGtsc1EyVmlNRUdrRm1MaURWdnVLRjVv?=
 =?utf-8?B?NmNqWFdxUU1kSUFrQXY5RFMyb3dFVkxGczVrTG1WYk9JWlJNanFaZVl1WHlh?=
 =?utf-8?B?ckZhQUNqdksyRm11S0dPUkJnVUZUeGVPdWhkMHpPenRsZ1ppak0wd0pFazFq?=
 =?utf-8?B?d2JTcDhjQW5vNzdDTTFleGlWNENKNy9SZjVwSWxxZ0VWbVJQem5tV2xWOU9a?=
 =?utf-8?B?N0l1UEtmRG1aSitYOFM1b3VOaDMxM3g3cmpnZEhGSlllYzREbjdsbVlyM3ll?=
 =?utf-8?B?QnJKbkdBN1I4NE93bzJQQ3NIT2FVUVFEV3JKRFZHMTc0UzM2aW5DV2xhcVRR?=
 =?utf-8?B?d3cxRXdGSWJtcjFtUmR4QW9JN01nT2JjOWl2VlhxZDlXdUVxOTRaV2NvNFV3?=
 =?utf-8?B?OFdJQytUdGZtNzR6M0VrL2YyajlDYm90QmFDRUJjUG5UUkJQSXB4SDdOblBa?=
 =?utf-8?B?dzNqTVFRVkdjdVN3N0wyaWxYKytMbU0xZ004aWhrQmE0UVZuNktlN3ZOWHB0?=
 =?utf-8?B?NkpFU05qQW9tZlNLTFVEbE0rdVp5ajlKY3c1L3ZVaWdpdlg5ZlJWMUdTUkhi?=
 =?utf-8?B?bldpalNmOHkzYm1WWW5DT2NCZnRFUm84dnBRNW5iUGZFNnBCR3FjSWR5NUVl?=
 =?utf-8?B?TTI2RGQrWkhFRi9FR29aWlpmTXArOHRPYXBoSmU1alUzTXJ1UzgyYVFlaU02?=
 =?utf-8?B?NHduVysvTXhqaDczQ0M4eUR6NjlOSllpYlJPS2IrSnBvV3h2VlBvcUJSa2po?=
 =?utf-8?B?NUo5QzR6RTY2bmlRYm5lUWduUy84REd0ZlNzaS9rVXRxWXZSR1ljVjlLSHdC?=
 =?utf-8?B?V0NHdHVqVWp1WXp2OE9VK0kvMWo3TUlDSGJaU2lrUTlMSVloaTlvcVN0eVli?=
 =?utf-8?B?WExtMklhNG44Q012cGo1UWlIZ0EraUNtcEJYZEFvSDJjeU5EdE5ONDk5ZmUw?=
 =?utf-8?B?ZTdKN2Nma2F0bFpIMGxJMmpNL01pM0MzeXVKN1VOT0ZNUEJQdXdUQWFZTVVR?=
 =?utf-8?B?NDY2NjkyZHl5WnBSckVkS3R2M0xkYjlnU25BWGtFclFmNWhadThHQ3FoY3RQ?=
 =?utf-8?B?bDJleTVtaGx4ZHppa3J5V1FhcGllME1tdDFSTVl2ejZiSUpmSG5RMUR4eG1o?=
 =?utf-8?B?eVNtdUZNNFFjc0xnUzZhYmNHRnlHTzRKTmtTTG45Z3ZqcFdjTzdaUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9004314-b3ae-425c-00db-08dec46cb6c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 08:13:54.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8sBnHjkXdBuoIXnbHY3bXPp5N6ms07dHXQ6ghcwY5VBw7akQftPieB5U8nclILS512UnekeZB86oawLdFNUZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

Hello,

This v4 continues Vishal Aslot's "Support zero-sized decoders" series [1]
and addresses the v3 review of patch 1's port->hdm_end handling [2].

CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder with
size 0. BIOS commits and LOCKs such decoders to burn the trailing, unused
slots so the OS cannot program regions through them, e.g. a Type 3 device
in a Trusted Computing Base (TCB) established via the Trusted Security
Protocol (TSP). init_hdm_decoder() rejected these with -ENXIO during port
enumeration and aborted the whole port, so affected systems showed nothing
under 'cxl list'.

Patch 1 enumerates the decoder into the topology with its HW-reported LOCK
state and skips the DPA reservation it does not need.

On port->hdm_end (the v3 review): v3 advanced the watermark for the
zero-size decoder. sashiko correctly noted the write was outside
cxl_rwsem.dpa, and that advancing it without a balanced release strands
hdm_end -- cxl_dpa_free() returns early on !dpa_res, so it can never be
decremented past the zero-size id, breaking LIFO teardown of lower
decoders. v4 therefore does not touch hdm_end at all. The in-order check
in __cxl_dpa_reserve() is its only consumer and is never legitimately
reached past such a decoder: the burned slots are trailing, so enumeration
reserves no committed decoder after one, and the OS must not program a
region through a locked slot. hdm_end stays at the last sized reservation,
which is accurate. IMHO, if a non-trailing zero-size layout ever needs
support, the check should key off commit_end rather than hdm_end,
out of scope here.

Patch 1 also carries the poison fix: commit_end may now reference a decoder
with no DPA resource, so poison_by_decoder() falls through to
cxl_get_poison_unmapped() and collects poison from the unmapped DPA tail.

Patch 2 adds cxl_test coverage, gated behind a new mock_zero_size_decoders
module parameter (default off). v2 committed the mock slots unconditionally
on the host-bridge0 auto-region endpoints, which the region tests reuse,
regressing 7 of 17 cxl unit tests; defaulting off leaves the shared
topology untouched, and enabling it reproduces the BIOS layout.

Tested with the ndctl cxl unit suite: param off, no regressions (13 pass,
1 environmental skip); param on, cxl-poison's by-memdev-by-dpa case returns
all 4 records. cxl_test exercises the topology
and poison handling; the init_hdm_decoder enumeration path is validated on
real hardware.

The result is in the following:
"""
$ sudo env "PATH=$PATH" meson test -C build --suite cxl \
> --num-processes 1 -t 6 \
> --print-errorlogs
ninja: Entering directory `/home/nvidia/ndctl/build'
[1/50] Generating version.h with a custom command
 1/14 ndctl:cxl / cxl-topology.sh               OK                3.38s
 2/14 ndctl:cxl / cxl-region-sysfs.sh           OK                2.60s
 3/14 ndctl:cxl / cxl-labels.sh                 OK                2.53s
 4/14 ndctl:cxl / cxl-create-region.sh          OK                3.25s
 5/14 ndctl:cxl / cxl-xor-region.sh             OK                2.61s
 6/14 ndctl:cxl / cxl-events.sh                 OK                2.46s
 7/14 ndctl:cxl / cxl-sanitize.sh               OK                5.42s
 8/14 ndctl:cxl / cxl-destroy-region.sh         OK                2.47s
 9/14 ndctl:cxl / cxl-qos-class.sh              OK                2.54s
10/14 ndctl:cxl / cxl-translate.sh              OK                0.78s
11/14 ndctl:cxl / cxl-elc.sh                    OK                2.45s
12/14 ndctl:cxl / cxl-security.sh               SKIP              0.02s   exit status 77
13/14 ndctl:cxl / cxl-features.sh               OK                1.27s
14/14 ndctl:cxl / cxl-poison.sh                 OK                7.91s

Ok:                 13  
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            1   
Timeout:            0   

Full log written to /home/nvidia/ndctl/build/meson-logs/testlog.txt
"""

And the tests Alison mentioned.
"""
$ sudo env "PATH=$PATH" meson test -C build --num-processes 1 -t 6 --print-errorlogs \
> cxl-region-sysfs.sh cxl-create-region.sh cxl-xor-region.sh \
    cxl-destroy-region.sh cxl-qos-class.sh cxl-poison.sh
ninja: Entering directory `/home/nvidia/ndctl/build'
[1/50] Generating version.h with a custom command
1/6 ndctl:cxl / cxl-region-sysfs.sh          OK                2.62s
2/6 ndctl:cxl / cxl-create-region.sh         OK                3.15s
3/6 ndctl:cxl / cxl-xor-region.sh            OK                2.61s
4/6 ndctl:cxl / cxl-destroy-region.sh        OK                2.39s
5/6 ndctl:cxl / cxl-qos-class.sh             OK                2.47s
6/6 ndctl:cxl / cxl-poison.sh                OK                7.80s

Ok:                 6   
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

Full log written to /home/nvidia/ndctl/build/meson-logs/testlog.txt
"""

[1] https://lore.kernel.org/all/20251015024019.1189713-1-vaslot@nvidia.com/T/#u
[2] https://lore.kernel.org/all/20260607053837.4389-1-icheng@nvidia.com/

Richard Cheng (2):
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoder under hb0

 drivers/cxl/core/hdm.c       | 23 +++++++---
 drivers/cxl/core/region.c    | 42 +++++++++---------
 tools/testing/cxl/test/cxl.c | 83 +++++++++++++++++++++++++++++++++---
 3 files changed, 115 insertions(+), 33 deletions(-)


base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
-- 
2.43.0

