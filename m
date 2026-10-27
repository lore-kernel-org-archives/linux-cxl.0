Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793096573;
	b=WzYLbhoCGlMo+uH+HGytc7vp4ZZqgM5MCS/gZwPe0NakOGk4MNS1kyv8cv/7Jrp0hwWA
	 reBM/5XOslRgFaDUevOEDHgwNiuOlJ8yRQpK5smxxDWMj8TclMW6VUkDuvMThpME5X8aF
	 DY87V/KuAiTxG/DRSLGFvAhlINvZFquxZCfzRwVUd6fU78Aqd7UuSUtsMpSFMb8NL599d
	 Fl4m9Zc3IfL2VK7zSfWzpOioT9MFEB3mBfU8UvdBmHTaH2iieGenj+O4vEE9Nlg4lmOlU
	 wmsckJVAP/pBKc1GrZzdZIUxf+HEXBj3fEyljilFEcSdDb8pkRjKbaf7B1vjd0GeLIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096573;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D0WLszNaWE47B/kkbMXtoSO+FszyZuIixNeOWQOpUuM=;
	b=Or8hnzSzK+bcbzhX1G+bf+TnUTmEW1gfDY9ZJPyj6xB0tS+sPrfIhtOkbZn8NMceTiEZ
	 mcEDUN+OEvsnOg1yDFYa0WDAA+G9df0pMLK9S7N/M1cKJJtHXNZ34qoQm8xbCdzTNhA8X
	 y8se7XeEYl/cnf0S7qZeUi/91hcCSsZroxSt5wtAkV0jZ+3ShwBJHt/CZj65cLFAHqsp8
	 yQUNkHTKLJFjI8hMDanNc3UoVAokUu9SN/g3OH2sZSgPOMup60PbqWv4h0FmcoFrzDSm8
	 9rlfmILfCBfKjGkUZrzlfhU55wx+yOZZb+KKmFEsWmRd3VQyGHsHajSYCsnepLGvqWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TlHHdwr0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB1606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 10:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05DB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TlHHdwr0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXvzJ8MMjWOEfXur4iM48P2yxuOcylVl4IOMDjYrKdoiyAwGs5mDXr6NKA99SneeEsceX5XroyrkberE5QyGGRetVdXLePBV0mfhyW+cc5lRDMxXGcD1pZnS5L/EekRL47ldKnIR+TNQuYCNZ9c6r6EjlCux55Y5xnrMw9UqkJUJyAr1FMMVRyY+QvlC5haxSVACc+anE4DbDrwMRA+4+UkFy2AeKqv2Fy9HbzzTqZ9kb+Exrus+fS5TaSABwB1E+VIwtSMnj4DJWYSeO3uY37yyA/6jKHtBArY7qZuLyHyLeIleVaJ8OpPwJdSsWbylhM6l3Hjcfg+/vFyOO945WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0WLszNaWE47B/kkbMXtoSO+FszyZuIixNeOWQOpUuM=;
 b=sJKCjwg66SMoBv+EIyfuyCwd2vDkzl/ksBbCeH0LOuh3TRgw9PJHkh5gdBElkF8lnq6dBjEd6m8rq1XZM6ZWe6iyD2qua3LrpEIJ4pb9hRNCBd1dptX2t1c2zF7KtdnSRKg7xlvSfoashpq0Xa7sh3IArwiLZenHXa+jrhb1HY37nVdwMiUiY5MKzprMgff8d2Lat0m475Kqqk2uHF9b0J1MdcaBddx0u1vP/uWyhyGT4On+wKs0Aw9LY6a/JfUS/hFsenAZ1ahH6HOV/k7uYQCBIg36IJ/hpLekCJmD+NHEkkhdhDQ8OnDiIugJD6CzDLd8GAdZfLZ2DffK56y7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WLszNaWE47B/kkbMXtoSO+FszyZuIixNeOWQOpUuM=;
 b=TlHHdwr06A+03/8wAhz/ejFEAP7jE//HwQ91uLQ0DB3p/H12n06I+Mx4WyUB9Y4UqGMnUXNdsKpiB9+fFRJ8YTFWpRKsjaFp5sGDTGIHpNeQFRMjhY0UtEyJ7MnN8wd7a0lMicxWrQv6pgnHz3yQCQ+iCxGm1DNnQ6Gou2J+9MyTGGtZKOrQwF9XhfEbPkDHFuNfhk8TcU9KuGElpaWHIz09SMNrK8Ru/d/c3U7aKrVNeN3lreUizoX0dzpjuuyTITmM59t1z/qq5R+LeQsWv15xepYiY6VxByeoUc3hxFh1njksRoY6iH7DytQhzZZ9kue7339VaumQY+Pfif4cEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA3PR12MB291063.namprd12.prod.outlook.com (2603:10b6:208:711::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:22:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:22:50 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org
Cc: junjie.cao@intel.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH] hw/cxl: Align mailbox payload backing storage
Date: Tue, 27 Oct 2026 18:22:27 +0800
Message-ID: <20261027102227.4976-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA3PR12MB291063:EE_
X-MS-Office365-Filtering-Correlation-Id: 412eafb9-4301-446e-7bb3-08df34144097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261026140227099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261021123027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/US0KeHU7mjQoFpPGf0HvLmCWtvt8Zv9NclTe0B+aKl6/t+xAyOw4CE8KTWOGffWj8cTd4K6VVv7j0HcR37oo43zEDQWv0wTkD+sGc/Yv5W3XGVsz4X2Y7icBNrvkwn28Q4IzSVxAvJ1UzcLPsww3OHYJXh2p3oVLh6ChAfzh03B2HrL9+T+cIQJN/unt3mHTKBVdcS42C0vCsMZL0/J+agxU4F3G866s5rtuVIFpJlIod9OYX53+yyGME4/t58OI0TzMc4oeDDdE8DxFmfqLPgGDCbiGRuHSWN6SShKWH11k/RSvtEdI2TIfuHSRc1e5zrP3FQuF7nzsl68fXd0u+nAJDyenmJu8xOh4VujcWFeDGqbWQH43GBztnpGjW0GFppbb3uYe/vXiSvPJG7BOazDfFQvAyERhveCV/Wh4xrXYuUusZhSzyISFPfp3DeexZcJNrA2EyilGt09iLc5T+K5VdLHl7/CoLoba3zL/IYKuOa8mhR4OuONC3Elmw3Ip7OgF6HsNixvr0Z34YJ8oy1lyRWw9Oubs3VlepnQUjmmBKc+iE05xD1+s8z31NENgMIaNo8UTee9j+V5VbZOzVlYp8JYM7dRguNrXuqvHl2eb1T1oXD6RFyJvm33NzhlKU50ZcAmRtG4JToHDSsx450oF+cplsSlGMatXi3ZN7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261021123027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGTv/tpaMJVoGdOLAlT9eK5R9S6+hkw443tjP6PSxf/W/oVSwuSMyz5kCyvR?=
 =?us-ascii?Q?iAWCWuAtI6AfDB3Jy4g5Rq2HYRBXKy8Jk8ai7mksq7mQR4lxSbTbu4K/zart?=
 =?us-ascii?Q?BdhcTh8V4FKLQFvlGr5xtsEDbTiKpa3LYglXtk3U8QKkaLqxHQIk+FMJ0bGO?=
 =?us-ascii?Q?DH4ibxdYv0UGfgSMeXEQpWGRe/adFe/15TClzSFGp28bvPpjqyfd8yHJ5Vng?=
 =?us-ascii?Q?WrRlOH1qY+pFJ7BVQD3oYlU+EaA1O8E1hTGkGNXKszUNxsk+AzINgvO5aQj6?=
 =?us-ascii?Q?7eV0CZqBCCQUwnUtn1AqpBCzNMY/Y2blSOkO8XcjbCPRThx84WbwQIs16NUZ?=
 =?us-ascii?Q?LaeXCt4I0oks7WaOaETYM3gJt0aiVBsK7wxfpQfnnsNaCyBRxqQAVlUOJQ5G?=
 =?us-ascii?Q?tWV9apVDKjT2MIosf4yr6JhaqzoZXH5X0m1X27wVmc2FHikGaQVb9M4tqj59?=
 =?us-ascii?Q?OzWvlfe9P72ujuE1BQMJ1B3w7WKIID7TwTS3dBtzLQ/bp/6uV1RceGrPrRWr?=
 =?us-ascii?Q?GfcmZJRR/u9GA9qhLTyU9rkVZ/QRZhdLssxD3DrL2Iel8m67WKo1PKtS/N8E?=
 =?us-ascii?Q?YeM1MH8K+tEnTZlY7lb/tBX04LimWaGVocXN7DurBKvNe0567Wd/QVgLENEM?=
 =?us-ascii?Q?UvtHArfI/hn+fsIBeCHHMRa6aR7S0jR0s9SYowJSkKrKRRa7kwZ4E3h2csGf?=
 =?us-ascii?Q?9JR60+sYQ5H9LHJGBWOo3F2DoPsp18/FVpr8carVCf00ZjGQMNjjwxOw0gDl?=
 =?us-ascii?Q?kmudEEvxWNQARbRZjFLa+YE4wgAjgqA3Q0wODewsZYwedi5Io9mUnoO0rBxl?=
 =?us-ascii?Q?FX9Zw21B/7X6PCjDwUCQLliwl/BXTe8FB5egj7IuhbJEb0IDER6u+QblBzEq?=
 =?us-ascii?Q?VLhUnOtNPh7YLlRkMB5fi27SX9f3AvoP9kn/t0YhIi+xDr1VQVeH0UzIJbup?=
 =?us-ascii?Q?uQD/5UJatUj/2fmfJWTUEiwT2H+Ksz1CB+GJT17a/KzlJevZkx/5ljYjhvNy?=
 =?us-ascii?Q?ZppFcpM2JDH1HoW/V82R9s8mrL5oomfk/uSjD0fpMUNfMfGuWWNo/vcoIk8o?=
 =?us-ascii?Q?GYXYV4t490ua5LN8sjkWw+QtiYh2UColXbvyJ3Ow/4t8WSt+kw4VJMJqTgMI?=
 =?us-ascii?Q?auGb9mxpiWZfSPvKKq67BsA3FU9ZpxT1i8bkcjbnMWUHS8lrowl9GbOl5IVG?=
 =?us-ascii?Q?PUiUyXehcXHpXgESflGQBb2HDkLPryxc88OhOyHDJCn6W2LoNJWg9lkw2RnH?=
 =?us-ascii?Q?9V5vrEpfIdRdVbq34NrP/PrlEiIUD/cHDYBc23eJVA3Lv88QriVQaqHpFrWY?=
 =?us-ascii?Q?keeqmqzMw+AZpNnb6QhDlTFCRfTqzqf3zx/ChsBaD/1uS5F7+FUWbBf3mJZn?=
 =?us-ascii?Q?LjwrSyqp9vO+5h062Dl0NFaBbuK6oksNYUA75/K9zbmT8xQd+7S6xzVOYGLD?=
 =?us-ascii?Q?uetuKWJqdnYi+t85z5rV/U/CzYpa7xJ1wwNkJ1lMkuQET2Dq2plnOUMTvnoY?=
 =?us-ascii?Q?yexH9PBPM+aDdcHGbYiuXoOzFynpl5AqpMohCFA/2SJa841P+qPlIGHZoM3C?=
 =?us-ascii?Q?6Cgk6mZYBjZqgv8Xi6ZoxwFhP3nRpyjt4Gf4SOa987GIgFJQEqeuDclyE+ry?=
 =?us-ascii?Q?ZzdUn/vwcthVknOTNjjdtcK2ze6xHz4YAYePd98dSWbYu63CAjO8ioTkTOho?=
 =?us-ascii?Q?LyIacyUpB02DuHn4kbaqHp7SxuFQ4Yc5tUxK2Qc7XURBj74nlFwO7i54jHxe?=
 =?us-ascii?Q?v7bE4Isu/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412eafb9-4301-446e-7bb3-08df34144097
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:22:50.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94v9CDnsET3JgSSZCZv2b3oFLYK8U1MuH4SSDU8zGT1ALFhl8yPw6cYywBc0jo/R2xGByA+jqvoBw6Kc42V+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB291063

The Get Supported Features handler treats payload_out as a 16-byte
aligned structure. However, the mailbox register is aligned to 8 bytes.
Since the payload starts at A_CXL_DEV_CMD_PAYLOAD, a misaligned union
will produce a misaligned payload pointer.

The bug can be triggered when QEMU built with UBSAN:

  hw/cxl/cxl-mailbox-utils.c:1571:39: runtime error:
  member access within misaligned address 0xff7772f3d628 for type
  'struct <unknown>', which requires 16 byte alignment

QEMU aborts while handling GET_SUPPORTED_FEATURES

Didn't see a strong evidence why QEMU would treat it as 16-byte aligned,
so I want to raise the RFC and see what's the actual corrected fix,
rather than dropping the aligned tag directly.

Align the mailbox backing union to 16 bytes. Since the payload offset is
0x20, payload_out now satisfies the handlers' existing alignment
requirement.

Fixes: d80378943a6b ("hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Reproduce with:

    1. Configure QEMU with --enable-ubsan.
    2. Start QEMU with UBSAN_OPTIONS=halt_on_error=1 and a cxl-type3
       device.
    3. Boot a guest with CONFIG_CXL_FEATURES=y, or reprobe the endpoint:

       # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/unbind
       # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/bind

Best regards,
Richard Cheng.
---
 include/hw/cxl/cxl_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa..2191b7c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -248,7 +248,7 @@ typedef struct cxl_device_state {
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
             uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
             uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
-        };
+        } QEMU_ALIGNED(16);
     };
 
     /* Stash the memory device status value */
-- 
2.43.0

