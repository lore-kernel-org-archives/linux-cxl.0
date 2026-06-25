Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDC387363;
	Thu, 25 Jun 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379754; cv=fail; b=MSAOBuPN1l+v8zdvle43yrdo67IsRaWcD7+pxNamG8LU8gNmgJB/EWOCfCBX+ToRU+i3YFPZTbm7xRQcDWA9MGiQnXCkXDtC/qoaY2mTM4efq+deG/KFig14USn30Sy/yNc9FbRoZy/JEoeIMMBPSHCTk6mVhHRjClc/6Wmv0ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379754; c=relaxed/simple;
	bh=hqEWsBFNF8c8n9UwemmnDJtz2j+iSq394GUG5R4q30M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/y5orrs28lhQUSYBYa6UUs4iVYQGseyu3TVCR5vToqqDaGuZ3UUo1ynKhcGJNsfcvLYkO3a3cLSNUiGioVKc65xgwHQXqrykiX0jsaNgQ5pJhhNbLXZGdindVKsXwTug1eidXYTqlPzrRCFRmnKr1LtV2/zkVcz6QdJZVsSeQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i7lCesis; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i7lCesis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tf0eoF/1m54FTmhjLhE4rretGRuvFFxwI/uSg6k6gOTtW4xLwYLLva8+/G3K2c9EtfT0g0B+Xpex7vlbi9XcB3O+IRcs8T5u2WWnC2/MVKcaXE3F9Gw2nVhE/CL0le9umpiFSI580JdADeaDCqt9g5PvkUsGI3Ewjii2RhGU784vYGmHumBlcrGCcvMPoxmtBqdG3kVC+JlAeSqEo0liqIA7ylWfdvS6/wFYjlP6AAQSOLIjaE/JVU08pSU/fLKtW5awTAq/2RjlfPzeWmpqhj1x+toPsSSiJs7jHxxxMca7UkJtCUL0dbnWprXsRdzVggysHOYWL1aOEzUTld4ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzRuPv7XK1qwHzhzLTiVMaLkw1oEVvqiiRG283k/PVQ=;
 b=K2rg6mQwX4lLkd6IYbchAM9O0zk+MXL79JV15UE4J/9462IJLqgvgriphYfI4CyPzB4NbyXTiInYAsVhHgQ4a5WYWsB1NUW7FRufMeC811/O7EvXqAaXp5XLFdh41srhh8qKz0yNT1/c33avb9CrmSmGYHEi/s2x4jNNLaAGv5hpMiGCLBmA8huZCNxybmMh47c80lIbWaax0RXtrRDrgDY8uCABdYPzB1LpZ+IAvjOQ6PJtbJPih0M1rXmx/IiISGrSRRuNGBDufEMat2KaXxzC2R0y1QizzCuBrzxg9F4JWY4wXPfz1nxARrmMdd7maBbrlYt3PJvCkcLMxXky9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzRuPv7XK1qwHzhzLTiVMaLkw1oEVvqiiRG283k/PVQ=;
 b=i7lCesissNYmz67qCo/IFoBrVXXrOKbMTPThAWwo2MchGlu38eKHb7w0ccyND3Rg4qvmq6j+MTcWHlC/9CL0CB4FyAcAlAgt1Rf+DHFgzEZPXikjBxnTnivttxe6R5St+2ndQ2v6W1vUAyFZnCZDUkzZfOhDk4kKz3QerytcMeUD9apLECfSr4DGbjd5UwK1yQ529xkPCf60EtVm3SEDh18QDcP8RAddD29SeilaHZC3TXkdEpR0sNKTKD8RKHp/cu7pslKbqBQXHuxTqUAP+jTA95jlrVeBizphPY72o5zpnWrHm2HWKkYsTVVWEfjMqC7BctGmCwkxrV3ieunU4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 09:29:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 09:29:07 +0000
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
Subject: [PATCH v6 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Thu, 25 Jun 2026 17:28:55 +0800
Message-ID: <20260625092857.41139-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625092857.41139-1-icheng@nvidia.com>
References: <20260625092857.41139-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0024.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: f38087e5-90ed-4715-b975-08ded29c34d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|6133799003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ex4tGt8iMRX1aOUqTdVMPbK7aKNHKZLJ4Mlrbdqgvy/qDAjs4u8xkLo2Zb0//pUfxEONRrZeFnKpD/7LZ502ThhZ2UEC2uBpXi5Ldz+oH+exsR0NQScJBMktf0WMOUsD4Ze18CHyBkmySGBqF2dSBD0GxzGNUxR4H2+3DzZtf8P7Hh9hQOvIM2oSuzcTq5QfTHcj9NWDPs7DjjYpPJqIBYm9w/92hmiKbbRKScBBR0eG8NGh76nGBowfrGHsYvgF5mjeATmsnTFy9Dx4n+W4Y0I88qUaqWAd6RMUP8rwTUVlLm7F7vpkk9u0VZreVCVtyL+lxokDerLKX7xXAq+QsMvHYk7FfAndsztzoRvi67HYZ8lG4iTbCcYriV19MKt026y+smSKA50fttHKudhOUPrVohTo+MVZPqWgk3K3sepP6sRR8F/erX+v55R5wG8pBT6gC5isxySaLYWcrCH02muLSOwGGD0Koa8POFjJOE0xPOG2k6UvStLgMql7Bc7NkA9PuzjekzFuWoIbz7lGzC0JC+N6vLeqxs7lQ07BLwLyQosklV7IYsQFKsxir/RrEC6U84dSvVRdXUAZWKcKUEnu2JPd7z/4a3gavNLJfNTb0drXXdGFGOA+6HxJCC52tBMaetG5s6DQpmexRJoOfAhyYCPWPFyuXmtbPDat+JI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhYQUFDK3F2NWh2UHJ1NnBta0tadVpwbXI0ZVdqUm5QUDkyZDhXMHEwTXRC?=
 =?utf-8?B?QkZqRXZFLzB4WlZIc3QvdDE3azdiOXVJdzF3QXpKdEhqM2dGaHNHL0hkbU5L?=
 =?utf-8?B?aVkwUFdNYlZ1UFEzNjIzU2NKOGFCK3ozVUZEZThyb3dodjVDRldlNDV2cU9X?=
 =?utf-8?B?L0JWdXdiTTVuN1hyT3RISUt3OFV2ZmR3b3V4MitrbmI2RlFLQVlWMDV5eDEz?=
 =?utf-8?B?RnJTUHE1YVduNFVrRDlueUFxVUc2TndBUGxiMUN5K2NRQjYxNlEyQzZWSUU0?=
 =?utf-8?B?TmJoWUZIQ2c5N0s3V0pYeHVTUDA3VTRjV0lHalFBaXFTK0hPdFhUR1dtSDNv?=
 =?utf-8?B?UXVoaXB4YUNESDduY2Z2OCt5OXNVZ2QzbFo5ZnFSNHFYRjkxeGVSK2VISzQv?=
 =?utf-8?B?eFV0WXpCMlQxdW5QZFBMblBuOUR2bUk5NG5WT2p3dWpNSG8vZFhPYnJscjBD?=
 =?utf-8?B?S3JCREczT0RlZXdCRXhOR0xGN29yWWdxODFBLy9Hd1orLzZWbFh1M3dVSWp2?=
 =?utf-8?B?UUJ5dlQyeCtDWjFhUnpSYVFyUTdYVmt6blJBSkg2NmE4SGg1ejhrY3VCVjFJ?=
 =?utf-8?B?bG5hdGFwVlAxQnk2OGdrem5NWU15bWx3Ui9hNmpkVDhsVnhvUTNCTFArNVJ0?=
 =?utf-8?B?NXpGdVRZRjFPTUY1VkNDaXVJY3FNWmFPUEx0OUtZU2dMaFM5QjlOK0xMU29k?=
 =?utf-8?B?VGpSL0ZUV2MzT085R1pqMHVRYTlkQVR5Nnk5djZkMmFGYkhUV2hRakFNUlJK?=
 =?utf-8?B?b0R2OXBoaTlZUlNEdisvRkUya21JUVF3M09xT0g5M1MyWkJseWswREk3aFVy?=
 =?utf-8?B?dWxqR2RKaytQcHg5ZDBuMU1SV0dyZ20zZmdVWHVmTnMrR3dGYi9NOXprd3Rx?=
 =?utf-8?B?aTNQV0F0MnlvTFdkVXluWkpOdFNyc1NuNllzNGpRQ0c5SnFmNkJTOWE1RDRR?=
 =?utf-8?B?TlNhN2ErUzNoejViRVBCRFVUaWFRUEFrNUo5a0g4NmhaYklQWEVxN0VneVJs?=
 =?utf-8?B?NUxkeFhJKzRLVHF5MXBHbytFbUY1TEN6SmhMZ0NYYmd1WVViNTBFNnAzU0Zm?=
 =?utf-8?B?YWNzVTN4dFJ2c0o2SUs4MnRROUppYTg3N0Z6QnNyaW5kU2N5ZFJ1Y1JjYitp?=
 =?utf-8?B?dmpnZUZ4VmR3MUJlTXN0cVBSTHRDWnNUNXQ2L05KT2NvRWZZekgwREJGajBq?=
 =?utf-8?B?VzIvUHM3RjRXMHE2blNrK3FEUHZCbEY5REFQZFBSSUlqaFlEWis5YTErTUwx?=
 =?utf-8?B?dzlTWjc2am9uRWhSTWJNYVpFZnlsb1JBYVBmb1Z0ZUZwVzF6VmRCR0ViZnBa?=
 =?utf-8?B?YkdiREtPMHNCWG8yaFM1K0JQeFdNV1h5TWpoYW43SEJwOE5sbWtSVFJjbHRR?=
 =?utf-8?B?SjBOSFlyMHVVMlROaSthdlA0bFlnZnhibzhURHpLVy8yNi9lN3Jza0NxYnlz?=
 =?utf-8?B?aEo5VnIyMkUzL2hGM09IOG1IOVhpV2N5azdSV3ZWb2hUcW9kbDBHYWd6c1pS?=
 =?utf-8?B?KzBxVGdnbThDRlFoVXMzRmdFSVdqampaQjNtSG5QRk9QSHI0cGpaWkxOcXBj?=
 =?utf-8?B?MzlIZ3JHL2pnMjJOVFJsTUNBZjFVMUVDTFRlelBnWXdKOUNYdDNHN3BqSm1x?=
 =?utf-8?B?Zm44NzlucUdUeEVHYkJlZ0hNT2JyN3Z1NmU3aVlBY0FNcy9QZTFTTFFBUGhT?=
 =?utf-8?B?b0h0SldycGJaLzJaemdVbjJJdTF5TFdlRnBOTVQ2ZVlPcEN0YnFsUFkyZ1ZP?=
 =?utf-8?B?K3dXd1NtY3U3am1hb2JkUU43elgvcm1BYTFFbytlNXBPRmdCT1VKa0lDZ0Rv?=
 =?utf-8?B?K0d4K1RYTXphcXBhQkNVVXFBdGhjZ0UzUG00Y1lSZWowVWhWRnhnWHF1UlJu?=
 =?utf-8?B?a04vWEU0WktTUk5BNWZORHRWOXUyQktJTUo3R1BNUEIyVytmZDlQby8wU0s4?=
 =?utf-8?B?V1doZ1BZb0gyYmRqeDBIUGxyVEFua2Q2K2p2K1UzR1pVL3FqUWZrekl5dWJG?=
 =?utf-8?B?NC91QXFPbzdsY1Fzakl4UFFxM0lXNERQQ0Zwd0h6UW9KUytLOUpGRHlmTnl3?=
 =?utf-8?B?STk1aldLcWtzb3FxaGFzWDdvdGg2Wm5XY1poRTk5STdKcXk2eDZCeGJ3dnVB?=
 =?utf-8?B?OWwxV1pkUFlPRlduR0ZlSi9LeGNSaTUrYVhHdmFoaUdSSmNHajk4QnFoc0ZH?=
 =?utf-8?B?T3dhaTZPK1BTMnR6ajhKN0xBMGpYTHpiUHBMc2RJVkM4ZGo1aVByVytYVGpa?=
 =?utf-8?B?ekVFajIxZ0h3Z29GcXM2Zmw2aDFOckJDZm1hc05Ob01rRFRMeGxRQkx1bXhu?=
 =?utf-8?B?YzRXUkEzOWJFTFRVaDVmdUhZMU9NbEhNRkJRTnY5cng4aEhXNlVHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38087e5-90ed-4715-b975-08ded29c34d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:29:07.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGCu4pwowxMeu4Hia3axAPxZGAYQ1gyHkmA2lQAhk8TZM+hwfQbQguoXC7jEW14+mk2uJlbAP8C3rkZSbbgG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

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
Changelog
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
index 7c6c5b7450a5..6f4d634b2cfb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1433,6 +1433,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!len)
+		return 0;
+
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..ccefc8751a30 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2090,7 +2090,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (!cxled->dpa_res) {
+	if (cxled_empty(cxled)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
@@ -2910,28 +2910,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
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
@@ -2953,9 +2960,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
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
index 1297594beaec..80e35d545085 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,6 +324,16 @@ struct cxl_endpoint_decoder {
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
index ada51948d52f..104c4c090167 100644
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

