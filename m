Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DCD33AD8B;
	Fri, 31 Jul 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480574; cv=fail; b=KW0gn9MSx1a3trQhe0wzsto8FaDUdet3eU6vzqBEM+uChK/3BTrJrOi+FSeNay8gQ/dCc5Rl7cmahTcw1U+I0sZ8I/C+9sslYSy3B5PsFHvh1mppFfvu2C1Ogb4VpvoVwd+vzNIscl1wWiFv8mKLSmwfvI4zZOEjTA38V3p2K4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480574; c=relaxed/simple;
	bh=5x1z4Hsrw9+IgS2PfBFvmQadlgJhsYdOkKBX3iQ75uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=egsIAdE16tR3q8DSjB7n/xze6Auy94D94uCGoVEv1nCvSWfZ2HsyYPSpiIU6sLs0uchgXvDNjp7uJCv+mHo2IHqGPXpjE+Ati3crWUIBWoNbCv5bh+OJIy5SVWp7BD8S/tdzj58Ud23qowk/fQkZVi9kcQDIK5fW7ZWlZdvL+JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEeyY6tV; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEeyY6tV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K80fsfvrSXbDbXpBBKP55egt7KDTnWC77CMuZQSgqEj1iOydejDCxvGq3WTtbOfGv84VUkGXv6IogbgprSTsMa4TZLKThUi8I9ObdIKv6epwHCoc7Ng74ofo65R2tCD7OPjIQk1Y/wrzYlL/RTSV1CbT2r7zYKZpgiPw+fPyI7zwrAqy9FLLbaFsaCOu6zaQvFdJkxKx/HtqlIO476mcGG8iND3TiU/vTe2W4wtkWf5nD2VCa521bB7/IVMi5D03LZFgrwikzhwJxNQVi7vK5rqGoaWVHaPj7WckqpGPHpqzEiifxXv76udFAQUvBpksABVL8JtZovnCN3eJuQIo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dM1BmlFeqo9TA65wSCjYbD1IkpOTSt/CDFKD0o0dSc=;
 b=Qmwg052TxcvNQjHI2eD79PxgfNMZCfoDyqXdtpN//oIwXnDgPBdA/m2bLdVqvMPaaa8ha3nPr7CQyEax8EEEP85dRfocZcWGjD1ZU11lIMitZx6mJEmJMUP/Cj/TAlkNjDAnDVUlICNFD3ZlQZBDuueQoZ2R0kx0mc/D/TqjRPGF9AWmUz8FpKRG8QxHa/iPXw6mX2jdyMvCYfbor4qDlRdQNzR2qobaSqB6yqtDHUI8EOUhDVGz7GbripeYwtaJYmmVy8iv9VVkI9DCwru8GD3elHvrX5cyTSq/f36p0fVIiXmblqOQ9iWvazfNgfFoEIkIYi/MV5xzziEL4PV7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dM1BmlFeqo9TA65wSCjYbD1IkpOTSt/CDFKD0o0dSc=;
 b=DEeyY6tVpsIsmOPtAuDr04HqyF6XBzpHN5Rm3nkrxyktQuvAUoJHBDiIdqx9kXqZvtuHuNlXW8ZazVBshcx7qbts9ky7jDNiB/fWI9R1cJabnSIgDOmfvsCOT68Zqi16BiYbPOBWZFRbQwUR5Zo3rp/rE2oz1yC5p9I8uhnHoW1ryPzxD0Yehi64yalW3DUpJSnA+jqmQs6WKus+HOYAqdv7drnFE97e6DGGeQbl82H5gAshLENKc2HsVNyPfeZ+/qlayZ2ongof3VjQDuo+QPG5dPuIxeDlxCDkCZMDKxbHm3mdQ0vsiX7U7WWhcnVSSN2pDpjiyVON+islNk6HSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:49:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:49:29 +0000
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
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 2/3] cxl/hdm: Allow zero sized HDM decoders
Date: Fri, 31 Jul 2026 14:49:01 +0800
Message-ID: <20260731064902.34127-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731064902.34127-1-icheng@nvidia.com>
References: <20260731064902.34127-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0020.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 7516bd42-c90a-4002-8b82-08deeecfddf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|5023799004|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	NiTfQCdSfiPjEQQhD1HHh1dt+FjcK7jAe9fK9M5xIWL2c2fZ9yBykiCbyq3+DChbY8uAPb7Y3Su9tKXcA/ADzbBDr/m2GOYsbTmqlZM0wcMnHLCor+rlsVu0bnP0PmRQS4Tp+mTLg65vyHf9dyUmlPJ4FehAkTm/0P0qvgJBkegGo3n52jAwygeDZ/0r7owXKARQVT8nJ3AjQUxKbJX65SkLKu/GcPjhS1X569pOlTT3ZnYgOXQBdAQ/n+GeUDu0xauZ4zeSH5s5Krpttn9THQpeP95vlNQerrz2fnNuJ+eqDb3mwVMStjAfoRNbd0jbuvJKeyn0RUhOnzYDOTEBgVKJ1QLLmFzD7bkQag/Mq89m09Ls3v02Le/7fgYVZFhpeTie/cDBi+cGhYr1YqOZ26KsTtBrjASGvMCYloytK5jI+gB0hKAeLKq8iGk4W9LkBuOX5cNfHNu9i2kDnMQVxGikEEj1ik5OrsBwspi/pFBzZXCkr3Rs4i8djE7GTILdT/rVnAYKQ4o08KngSmJAd4m+DLFqlQgPr0v0W2cgEM1nrOopHdCZ6APmlgBnl+Xl9WoVhPTrStLMkCYiPU/Zu+YMz99MDbmVYqlP9bFI9wosvd1hO4QXiEzBD+4hgf2UfSklx8mu/m0KP7mMUb/MDSfI1PThlMr/1hOSGtlzUNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEFPRG0xTCtDNitCekYvY3g5NGdicWN1R2NVYlNIUWl2eGM5ZGY5WHYycjBU?=
 =?utf-8?B?cStic1JkMnJnZ3k3VjRnWkI4czVoblI1ZUZ3MVJzMzRYdjVISTZFYU9hSEI4?=
 =?utf-8?B?Z0NVditYWHgrRjlnK1VxWWtLemVMVXJFQXh0L2pDOWFUT3IyelVQYlZ6SGxr?=
 =?utf-8?B?bWhLeS9rZEtzaThwTXBIVmIvTjFDeHpJcmNWakNlY05acjNTVno2TnR0Z0lI?=
 =?utf-8?B?M2ozb3JEMDErWncvQjN3dkF3ZXhQalk4SlhrK28wUGMvaUpHK2RyTTNLMHdU?=
 =?utf-8?B?TThJdUY5eENNMnFMbXhKeGtzNE5aUnNyYTFVdXVnSndJbXREbVd4VHhZZ2w2?=
 =?utf-8?B?K0N3U1hTeDdJbFVmL3hIZVlTWnNiWHdOSDYyd3hSTTZLVEIxS01rZzNvV2JR?=
 =?utf-8?B?U1U0Y3cvQ2hsZk95ZzhaYjJEVThNVzlna1VHVUJWd3Q3djRuWm83NWpWbW5q?=
 =?utf-8?B?THBlUWNETzZmYXdGN1BycGNYTVVaTkQ1ZllXcWNUVkRselkzNGo2RDJXcUNL?=
 =?utf-8?B?MXBjdFI5Q2tQbnV4NEtLVTBKNDdTWCt5VFMrbHpnMllDdHBTWUtCaWk1NWk3?=
 =?utf-8?B?dkc1dEE5dTdGZjJ0aXpKMXJDNkhJYU01VWkrU1M0OVRWd2g1dnVxcUIxdHpF?=
 =?utf-8?B?ZC9UQSszNVVEZGlVOURtM2ltU2FQT2ZVNzNkUjE4RmxFZmx1YS9aSVBweW1T?=
 =?utf-8?B?UnUzdVd2QmNBZTJWSnRkbWVRd1l2M1RCSW5BcXBnY2dtSEVOcjFnRHAzY09L?=
 =?utf-8?B?NkxNUGw3Q0QwSkYva0FxdDlwOXBxOWNRbnBrc2NRM1JDcFFEbkhYczNZc0dy?=
 =?utf-8?B?OUJPMUJBVWk0YVZnN0UreGF3Y2pXK2tTbExWMWRwVkg5OEdGYmVXaVo1dVBh?=
 =?utf-8?B?aHRuNEhvb21jZm01NmFWV3JNK0VIN0hOOEFLVjMvT2RKOXE1clllK0tJYUd1?=
 =?utf-8?B?cjRKUk5MYWtDdE1nRG9HdVRRd1R1Rk8ydkExTmVEZWRsT1hGMjFxdG9Mc2pq?=
 =?utf-8?B?YzZORFQ5L0RNcExVN0o5eGxmeUtBMU9CLyttaUNiMUEzdFU0Z3ViYjFjZ3R6?=
 =?utf-8?B?eDVxL3NVSFdXUzlhdXRaTEhjVVAwQmFlQjdHNmFxYklzVFhhNXp3RG85RUtj?=
 =?utf-8?B?RDZsdEZtbjZqaTRaUm0zTTJFRE1SaWg5dUNVZVZGL09XNjkrREpCUTd1bzlj?=
 =?utf-8?B?VmI0YlNacW0xYmJwQU1UWXEzS0ZhNlI2SkE1ZEYxU0hyTm9uQlNOWHcyVmFD?=
 =?utf-8?B?TkJaY3hIL2pnVlJxalhLNHpFRXRKT01ZNjVmay9vVzg5bFY5RHZHWmFoSmRh?=
 =?utf-8?B?ODFKd1crMi9MUHZhZE5WL05SaVB1YU5aQk1TeTZjTFFhbDVHZmxjeWU1cGEr?=
 =?utf-8?B?cW1QNkNEQ21qa3RjMmMzcm1IdDhTUUVIUS81WTZkZFVJdWFTeXFHaWoxNnJI?=
 =?utf-8?B?Y1ZQREN0b2wyT0dOckZnZ1ZJSnlCU09BeDJHajdSZ2pnbVc3c1haMzcvUEJx?=
 =?utf-8?B?V1RnVUdnZ09uaHdabng2bzRyZy9oME1ZTDhCRmdSWlllOEY5SGUwblQzOGtj?=
 =?utf-8?B?ZExGcXN5bjQ1TUU4ZmFYelg5TUxFM2hZS0d5bk5mWTUwN285VWJLT0FHYVZR?=
 =?utf-8?B?eVlNN0lnYkFqM0Z5azhnUFBCY25VTG5yZzB1WGp4ejdNdU81OSs4MVlJWkNv?=
 =?utf-8?B?dzdjMFVtRW55T3lzUUY0S0VmQ1Uxd1I2RnZCUlMwbTZxU2I1T29EMERmVDNt?=
 =?utf-8?B?cGtEbkFRMkRjaXdWellldWVEVHlCWFhobnJlM2pQbDJNbmtHdnpuT2Vnc2pl?=
 =?utf-8?B?bmVzSzREelFyR0cvUHNCdm5Tc21FRGVBbmhzUldOTzhBaEpIYnY1NFlUSDRX?=
 =?utf-8?B?bnIvZkhnT0kzaDlOdEcwazB5eTBuWDFCb1l3WHg0WXYwUnd5OXpnQXFUb2tj?=
 =?utf-8?B?UjYzRjFJbnB1TDR6NVZ5djJJdldzSW5Mb3oxWUprdXArVlh2NzRMVzZxMm1D?=
 =?utf-8?B?MHlpb3FFa3RIQlBKZDVOTnFvSklNakhNY29wbmNSVmk3bWcxcVZCaVRva3BL?=
 =?utf-8?B?YVFDdkNTSldFUWFrTkZaeGpwRkd4ZkVyajVWWFV0VGhsTlMvSHBoVVNBWHF4?=
 =?utf-8?B?Z3JtUGh3Q1dCdzNic2dJZVRXc0RvNFdaaFQxM244L05NYWNadS93OWtrazlV?=
 =?utf-8?B?RVdiTkdiamtVeXpKVHUxL2tMTENyaEpLTFdheGlBeXhMcGFKelAwSEt2WE5B?=
 =?utf-8?B?OHc3RGdtTzgzeHloUGJFZ1hlVWNqUW4zR0tSbVlEd0czOTM3TDRrdWdWWnMx?=
 =?utf-8?B?NHN0ekxYRVZ3RUEyTUFJQ21MNVRUNHhSS1hLRHlPNkgzM0lWV254QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7516bd42-c90a-4002-8b82-08deeecfddf2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:49:29.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE0gGUETh9DJZ7UNhJZ6iEiF9CjtUqtNHmt43LfBrzr840Cft3rlTJI6LNu75SuK60nG8xcAwIxspku62w0tZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
with size 0. BIOS may commit and lock such decoders so the OS cannot
program regions through them, this is a design choice rather than a spec
requirement.

The kernel rejected these with -ENXIO during port enumeration and
aborted the whole port, so affected systems showed nothing under "cxl
list".

Treat empty decoders as first class instead of special casing them, back
them with a kmalloc'd resource, since the resource tree can't represent
an empty range, and keep the skip and hdm_end accounting intact. Guard
the paths an empty decoder can't serve, e.g. region attach, DPA free,
and poison queries.

Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changelog:

v7 -> v8:
    - Rebase onto the new poison_by_decoder() cleanup patch. The poison
      hunk now only wraps the existing code in "if (cxled->part >= 0)";
      the -EFAULT/RAM rework moved to patch 1
    - cxl_dpa_request_region(): split the declaration from the
      allocation
    - Add the missing blank line between commit message paragraphs

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
      endpoint-decoder path. __cxl_dpa_reserve() rejects zero-size
      decoders
    - Spell out TSP and TCB and cite spec sections in commit message
    - Reorder series, implementation first
---
 drivers/cxl/core/hdm.c    | 55 +++++++++++++++++++++++++++------------
 drivers/cxl/core/mbox.c   |  3 +++
 drivers/cxl/core/region.c | 45 +++++++++++++++++++++-----------
 drivers/cxl/cxl.h         | 10 +++++++
 drivers/cxl/port.c        |  3 +++
 5 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..3b3cfa0f2507 100644
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
@@ -336,6 +348,26 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
+static struct resource *cxl_dpa_request_region(struct resource *parent,
+					       resource_size_t start,
+					       resource_size_t n,
+					       const char *name)
+{
+	if (!n) {
+		struct resource *res;
+
+		res = kmalloc_obj(*res);
+		if (!res)
+			return NULL;
+
+		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
+
+		return res;
+	}
+
+	return __request_region(parent, start, n, name, 0);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -349,12 +381,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
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
@@ -378,8 +404,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
@@ -402,7 +428,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				break;
 			}
 
-	if (cxled->part < 0)
+	/* Empty decoders may not be contained by a partition boundary */
+	if (cxled->part < 0 && resource_size(res))
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
 			 port->id, cxled->cxld.id, res);
 
@@ -545,7 +572,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct device *dev = &cxled->cxld.dev;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	if (!cxled->dpa_res)
+	if (cxled_empty(cxled))
 		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
@@ -1031,12 +1058,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
index fabaad3469b1..033063bd0658 100644
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
@@ -2959,24 +2959,31 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res)
 		return 0;
 
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
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
+				return rc;
+		}
+
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
 			return rc;
 	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
-		return rc;
-
 	/* Iterate until commit_end is reached */
 	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
@@ -2998,9 +3005,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
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

