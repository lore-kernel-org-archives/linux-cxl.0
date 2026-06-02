Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C7331A56;
	Tue,  2 Jun 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378867; cv=fail; b=qFkRd3IKFBHGJQEji1Pz9Km4vbUklHS23L0ukBTQ8zAVxfpepxVwiwqlLjM/P8xbA6GkUXf9K2oQItXteO/t/vsGpUN1MSY5XyTg9AiELFojGa9YPPy6+2gQs+8RzFjX1OqpbcyxmPJlYQIbW464O5m7F0i11c/Xl7GkjvlBn6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378867; c=relaxed/simple;
	bh=YDdspa8wz1xHgcV19FVgU+wScOncopYWVBGo8qpmTCk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RoDG1JOsbc+NuA3V/yHNWnHKMY1bvMwZ0yEjtNU7pFLfO0Ie1cPc/EXc0UdT4riG37lmOBQTHlEbzXTHGl+WfMW4kuDG0PcjxM+kaLhvjOpoDHYRQ/SmwHEMqPzxp+Jv0CfexFDtSxwcMMnUEY8SebwRfjwOt8QHvv7no27tleI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvPrHCMB; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvPrHCMB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjNsbETxrsMd6LC98eYLLzui4j0ElsG1mkXCwMT1uPNMGx5Hmfghvf8zwkpNDLGivt+SxrY46frM0IzDGYe/86TFjFXYc0Ku2JqEA26Et5mrUoBqw95dphts4BNqkxBMNTvRtqY44Kta2S15a3MXUkrGC3J5oHAUSgnkM+gsIUEF6Xt2Aa5SGo1Q5/CeJPdaLibV8kMNzaDnFgUeaj7CIjrvjALU83QUvniSZj+/KcLYDEv+TLgn8NGNV1GXJ17WhI/jr1C1rmu9XujjnrP70/i7gFPJ34rheMvuOLdIdtDo03uCY4b6vcB3u3TcOiXIx4Q2lTPgqdvysryFlOtGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eFpqqB8snaIBGBd3dyE8s2qxnq+tdTo8hjkeAWeKxc=;
 b=YX3LZUPrB7c1o0bOyTK3h9LezuSlHHi40H9tN8pB+HgBXPFH7vHBCcVe/ppQ5U4gOGQWyjAcV6qvQFB0F66Dzx3lRHl/lnJLpxWKD7jWfpAk/ZUN0k5qCc4gCUwqqhKbiCOjXK/sEjCuOTIGA9SBqmAG/IoClBwNVJ1goJC1IveYU9DpODW+nRo8Isd/b77TDMzJYmuZx+eM/fx9IIo7RQOhThYG6ooX2nfAJZE+lkf0mLMCFHAEhb11jUTdyFix4uxlQkpih5KTgJs2++srbcO1qCDXbtFeIqrKicAZ3WabNcvMPhU1J+IRIJ7oiu00i6RWMA7FwPBrSRID946/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eFpqqB8snaIBGBd3dyE8s2qxnq+tdTo8hjkeAWeKxc=;
 b=HvPrHCMBS/66HFOAf2NrGJF/cqLSIaY/4gCPZ7WeHM88qi5xTAheW+pZTbblhckJ9KJPW4zEwIEFYeRkIytR0SB+VoPQ6pBbyIoiGSQqYCxFBFl4hq/FCu3W8MIb4tZFpulIYBKsjR69XaMJMk2AEVGH7G1C/Wkho8L07Ki+xnZyc4Jk4Cg670BgosX8YoEKtNY9uuTCokxxSxbvcpg6m6ArZ13aSMRkURFVXS/WO0cDLQVZIbCx1BPkQUpS0BJqR2y42d+mC1UPyjYsAiTCpPjLO4t6YvN9A+DQJcAoJNJyBWLXlqHlEThp6Hur9X/QtLP6RlX15esWSt8URJbjxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 05:41:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:41:01 +0000
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
Subject: [PATCH v2 0/2] Support zero-sized HDM decoders
Date: Tue,  2 Jun 2026 13:40:51 +0800
Message-ID: <cover.1779957270.git.icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0073.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc0818a-e99a-4253-4ece-08dec069875e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|6133799003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	rFewfWSi7nxwpY25xJHPdZLFTI6ZuCwXpBmyNZhjYEpFRuyTARuImfI+eqmnTYeM54PuBGxsjROd+CJxndY46iBa9GX7Rddzbfzn2K/O95fhnTGdFWe2+9t7AukvuMxWOYbKWy8huGHy5WgZMdiOoZ9HJxDkhXcp/LXUJGELXj564eIcIqolWPNUpdcrAWX2Ls0JwtwMm3ib8SQL396oTlm83xNAulhqNbE6F8Q/ScAcz4jsyiEaMf9fi+Gj/1hVsYmI6IHhlf+znPrkSnmGDZcy9ADIZaU/C8E+mOsKuclkKBCO4pKgy2rqDr4doU9gJKGFii+7Us33lBu+j4mZUTgyHKEKYHqb6hp+wYT0gRTLjhFNX4flQe8GYmdbkgyKLwz2qrUTJbr3x9xjGw8BRNADyAG1muG0RCfpVcMH6jh8BVPD8M0NMWZz7ZP+Ryj/0H3nE+hMoZ4ZVQfZALCNRrcOKI99dcV9XwNU6WwHiIVYr+CX9bwAe6Hnv9JpVkwmGie+4oc2XrlJ9JM1DlIVsHaxjz9QxaDihuJTXIypQUZjP4W4mdap/JOfQU/lojAmfTbc7ARGi0fP3I2Mmd5VMm0eDsLKPom013A8FGIZh4KIHMQpSbS/6CwvCDvjyegEfZsamGj4gYAkv60lcTZQV/9TvdFB+xw3ehn2h2rgkd5PmpkJ7XgKpBnFD2ABsDvmKTKM7XkRldUHqgP+joh0LQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FkMGkrNHJtOTllREN3K0dhWVV2bmQ3NjdLQUNRaWlZekluVTY5RXVwUVBY?=
 =?utf-8?B?VnlUV2JzRitiQlFGekxQckJ2TWo5c3hJb3JjcWl5a3NDWGF3dFZZVDJvRW9s?=
 =?utf-8?B?VitUZWRNbEtKWWRPWFpSVDlPU0RKd1ZtNlVjZDhtMkw0NVc4d0JZOUlCNllq?=
 =?utf-8?B?Ny9KN1lZdW9rTFB3b2JHdnpxWWpmd1BZYlZ1RDFlTnl0a0ZXOTErRXJGZ3dP?=
 =?utf-8?B?YjMvZ3puU0ZnY0FabGZLY2RFRWhObGxxOVRSUXhGQk9YQ0V2eXRtMTNjU0x0?=
 =?utf-8?B?RTFZZTV5SjFKZWkzM1FVUDNmaDArTUdzYmlCQ2YwdXIrZXpaYml4Uy9kUSt3?=
 =?utf-8?B?TFRYa2dCM2RmdzZBcmZlenRXK1pwSG9mUzdaNW1jRWQxWXZUdCtVM0JHdVNH?=
 =?utf-8?B?enFLQUFnemJwckM4bCtIS3RWZEhuSnFKTFdVckNDdkpqa2V3NlBEcVBqWXJX?=
 =?utf-8?B?ZFdPWG9CK1BrTjN0Z0VKZ00vc2plZ3dPMllsQ0NjazAvQmVKN3N0UFlVYnl0?=
 =?utf-8?B?b2F0eG9aTjJuelVTL0p5UFB2L2J5cGYwOFBuS3NTbkU3ZUhtL01Ua0xiMFJ0?=
 =?utf-8?B?YWYvYzJRdFhVeDEzcThtMHI3UTk5aGU0SWFJSGNvdnJvNUpVd1NVM1BmQWFt?=
 =?utf-8?B?VjB0Sy9jQ21NbXVNb0NrektaS2dSd05lK2dINU5HQ1FnYXJoc0wxdE1XbWJo?=
 =?utf-8?B?ZkV1MlVlTDJVSDdtOWJrU0twTDRvWE9yR2lqcFBIaCs1bldFbFk1Y05qa1pt?=
 =?utf-8?B?YTVKbU50NjdBcHA5eVdhWElGUlAwY2pGY3BsNy9EM3Z2N0dObUY0SmNiVXZr?=
 =?utf-8?B?M1BoR1BHTDZmRCtacDFOK1hNVU5UVXdSOHlMWUpuRnFYV0h5bDVvcGJpYjlx?=
 =?utf-8?B?VU94Q0duMXV6K2Q1VjhZdVVTZmJqbkhzbEdvQXdmVXA0eHNITjQ1Z3lXaUFX?=
 =?utf-8?B?b0E4bXVJa21zdzhsMkYvblpYNXFWNjdlZEpFdmxKQ2xxWkdBaUNCbVBzdlFL?=
 =?utf-8?B?S25pQ254RlJjdEFxYmRZUFlncjBXbEJaSldCNU5hRzZaQUJOQkJtKzduM2JJ?=
 =?utf-8?B?eTRvWU1GQkJDY1ppelgwaDVXc05yNEl6aFVMWWZha2diV3NwUzVCblRocE1S?=
 =?utf-8?B?QURTNkNaY3FsNXU5KzZBSlgwbDRvc2F4ZHdrSU56S3ZIdU9UNDNkdEtUa1hR?=
 =?utf-8?B?OGZkM3NubjNqb3ZJbzNTRitMcU8za0xVbGxId3k5SWd0V01WNFduVTZhT3pB?=
 =?utf-8?B?Q3A1RzE2T3I5cGVSOS94QXBJR0ttWjJCdjJLRDl1WG9hQlRmZEVrTlN1WWp2?=
 =?utf-8?B?Kzk0S050SzQzM21Lc3RyWHpzZmVvK0xJd2tRVkxxTXZDNVhGMnRlM3hCZUo2?=
 =?utf-8?B?eGMyVG12ZTJFWTNCeno1WW5CQ1BwRXVrK1JNWXRJYUUwTDNybFYydFUxeTdD?=
 =?utf-8?B?aEpOUHdMSDVOcWJsZERIaEFGaHdyUkNqSTdMeVFzNUFvbHZmY0R1ODJVeE10?=
 =?utf-8?B?eS9kYzNJU3h6U0xiVS9yK1FyVHFpQm16Zkp6VjN3VjU2bnQxbFZvMXJjNmlv?=
 =?utf-8?B?NVBXMk5mT2ZBUmNiaGZzOWpNVWQ0WmI0RmxMWkR6Y1JUM25LVXZjY09odXcr?=
 =?utf-8?B?aHhURXozVy9lb3R2ck5UejZaOHVwVkFUbXRWQW9oNS9pb2ZmWDZJcTk5ajRM?=
 =?utf-8?B?YmR0SmVjenVQNmg3VTFDclIwZDdwUUpZYU4xMlRSSm9NVmdYOEhPdlY5eFZi?=
 =?utf-8?B?Yi9VQWl6QWh6U3JZd0FVRGdwWEo4Y3paWXo2OUVjWjhadHFSUlFFbUJBY0cr?=
 =?utf-8?B?dFJGU0ZpMUhXS3M2RHpDKzJYcU91VUYzR1R1OUt4aTR6ZGJJMmpmMU9FclY0?=
 =?utf-8?B?RUpZeERjNDJXU3NXQnROeXh4ZzZ1d2hKRjlUSGZ5enVKOW00ekRWUXo2WjZ2?=
 =?utf-8?B?RkVvQ2hHUHFEU1dBU21yUUxHUXh4WTk4ZDBrUlZ0eTE3S1RpNW9wNXUvUUFV?=
 =?utf-8?B?NWpiaWIvbnJDSFhOek5qWGlnRGJPVUtiekJWWkNrc3RXQTlUYjM0eWtxRzdt?=
 =?utf-8?B?NEdUOEpPRmN6ZitpV0x3NUVoNWhkR2NBWi9VV3V0aGlvakx1ekN5TVdGVlNG?=
 =?utf-8?B?eVBBZ1h6ZSsxcTJibGVuVjZhYUVuNWd2YmZQRlhoWndkUGdIN28ydjA0RDVJ?=
 =?utf-8?B?SDJJOTFBWWtsb2hZNHFjTEMyamQ2YW85WEtpOFBRRVdjVnl5L3RnWHVuZGRE?=
 =?utf-8?B?QXVaUkRiTk1pRVZnWFVBZmsxVTlZa3NsUWtNL2I3WU9QdDFBMVZFSmJGWFBS?=
 =?utf-8?Q?OJfioV2m0h3Z2ne3k9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc0818a-e99a-4253-4ece-08dec069875e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:41:01.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6zDQKKepQ2/9F/yknlF79wYWvLpi3PBg/X72JTHJEKytnECnJ5XCxGp3xcuSWhalqOrFMWW417HJSxZ75OOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840

Hello,

This v2 picks up Vishal Aslot's "Support zero-sized decoders" series [1]
and addresses the review feedback, if any SoB or credits have mistake,
please let me know, I'll correct them.

CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder
with size 0. BIOS uses this together with LOCK to burn decoder slots so
the OS cannot program new regions through them — e.g. for a Type 3
device in a Trusted Computing Base (TCB) established via the Trusted
Security Protocol (TSP).

init_hdm_decoder() today rejects committed zero-size decoders with
-ENXIO during port enumeration, which aborts the whole port — affected
systems show nothing under 'cxl list'. Patch 1 lets these decoders be
enumerated normally so they appear in topology with their HW-reported
LOCK state. Patch 2 extends cxl_test to inject zero-size + locked
decoders under host-bridge 0 so the new code path has in-tree coverage.

A note on Alison's v1 concern about autoregion teardown being blocked
by locked zero-size decoders sitting above the autoregion: this does
not actually fire with v2's "add to topology" approach. The existing
cxl_decoder_reset() already returns early on CXL_DECODER_F_LOCK and
tolerates out-of-order reset of the unlocked autoregion.
port->commit_end staying at its watermark after teardown
maps to physical reality — the slots above are permanently burned by
the locked decoders. No reset-path patch is therefore needed in v2.

Changes since v1:
    - Reorder: implementation patch first, cxl_test patch second
    - Patch 1: drop -ENOSPC sentinel and the matching "continue"
      in devm_cxl_enumerate_decoders(). The decoder is now added
      to the topology so "cxl list" shows it.
      Move port->commit_end assignment before the size check so
      later contiguous decoders pass the out-of-order check. Add
      an early return before devm_cxl_dpa_reserve().
    - Patch 2: replace second_decoder() / third_decoder() with a single
      match_decoder_by_index() helper. Use CXL_DECODER_STATE_MANUAL 
      instead of STATE_AUTO. Set CXL_DECODER_F_LOCK on the mock zero-size
      decoders to model the BIOS-burns-slots case.

[1]:
https://lore.kernel.org/all/20251015024019.1189713-1-vaslot@nvidia.com/T/#u

Richard Cheng (2):
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       | 15 ++++---
 tools/testing/cxl/test/cxl.c | 79 +++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 16 deletions(-)


base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.43.0

