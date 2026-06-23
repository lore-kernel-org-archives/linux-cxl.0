Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3272344DAD;
	Tue, 23 Jun 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205843; cv=fail; b=fuWS2H65B+t2njCB99O+4x7QGwXaoHySZe+4KeJO5uHmN2Z+vRtn7CsJyu6PxPXU5tPxghmDxQLNq5EV4hvQjsI5PJ0rezIgzXyubWS9lEr/yCYMfHDHTF6sJ2YZ6RmkOF/aYzmJFSDl4QZ9IQezmeaSBX8N2WjZuu6jSTpW2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205843; c=relaxed/simple;
	bh=GSEc7rQk8IW60/YjqhQevIa/n1GiYST4OtB34TkPEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/ar3zCPDgXs/R1j12fP53DBuBoBWgaITiE1r8QECqZbJW4PgreJQ3+v6hLXF/8qJytlELN8Z0x33fqPz+TWOeC3SIZ9B3dMGMzx7de4Lr2wMt5hIaXkgPK24nxRoodQtCiPQd+xflQgKvRnVBI3hhYK/IW/NPkwKFtnxAgEQpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcYMS8bY; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcYMS8bY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2vsJeFenfFBIVnPBUbFtVKk7YrvAIwUsriqVZ6xO/P+2gZwqMf6ZMbvM08a96iE2Yy78E59riAHLaKIafQ+5kKAZu9Ihy8UmEl+MHTSgEwK/yo9GNr8Mp7nVjYEOUarrge1NGdOIXXj+0ry8UfH1i2Kr18X2276seEvD7B3N3HnZaHhQMaMea9xyEzKPZKoxeuYrQ7T4RO1tU2nHKllxJzioTdd7zJqjaT5J2k78/NbGCa+E/RFp1JC1FtmNoEXpZTAGxzTQx+dwZoXmIdSA9nFup1oLhW6T8q3F6Cg4zqVds/WUEV8/l3EumfMSHEXfqIOdleeYoCg0yDu2P56kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc+8W/LtrdDywqyHtWorF4ToYThOqyDOiXZ5OeQDbFg=;
 b=ibjRsQnfDd4QGFbdNUrUihUFfGyJrptl/TCiOyEUWDksxqj3fhMjpgTDZANXaN/NNbLZlM76UAYnMqm621jtUfwduqo3656OnzxtxYDRMSULXBL1QUohakCTZnIrQnrN13QMKGJcX7BvU8SK/TldQWKqxCgSy7zPlpR3wdFIRCFKksifx+7XtCch+gT3P5h7WJCDWXFnNIUWNbDWM44kSRFcgUCbp2BQYZb103K8nq9xBecnZnIcEpMdQd61K/VP+YcouNA6+BVA7zI3vokL0URV0WUyeg2WUU9HWVb2QgjQfQbKh45sXNGcWCM9Pg+NClV9l3MhWF4lI3AkEozNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc+8W/LtrdDywqyHtWorF4ToYThOqyDOiXZ5OeQDbFg=;
 b=PcYMS8bY6vkcmwAgiGN3AapnQco8eo0qnNTgdqCKd/qYmEoiuRPyKvE61bTD8UVOiCS85u/TuuthJ0cIATqTNMs7xD/xwFoXsqqc8DJLJd6HMvOvpAWzXxPulN9mWXCt4W9my+OEaTKT404QkoOF81FaDH+cX0SsBaI62lRHPqPkYmMwPBm+PorkVqCeGAyh40toQn01vKOFCbIGqbi6EDLgtI+ZpqSeo4bz9hzOC4u1BXoba9QjxCKTnX2QxAS6pdlAo3BIDR5mF07PCgDeSjPd/7IExe+ZTNxtdG2sndclflCq3sodHGgN7iHQlj+6NP7moFk1ZwvkN4QmWQT9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 09:10:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 09:10:36 +0000
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
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Tue, 23 Jun 2026 17:10:18 +0800
Message-ID: <20260623091019.33417-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623091019.33417-1-icheng@nvidia.com>
References: <20260623091019.33417-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0026.apcprd04.prod.outlook.com
 (2603:1096:820:e::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: fad809ce-f028-47a8-730e-08ded107499c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|3023799007|56012099006|22082099003|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	MzJD0rZuyoUT1L/YNWxUZ/tWl51vnspCFdLvDSsRyscASQJQGOGBNciV12UoFRo6rYOw+LZgK2D30jT6pDvi2cLrmuuOsjnwun9pM/WdKPo4H1a6bKChD/HfCsjZR7t10LZSSDbqRTukc2OMfmH9IR1c32MvFLELpMpbjLLxw+zAefTHuT+4UuC5T4ba4SAb1cPJJXSLQICUHn4AEcSwWYUk5mrAiDbOb+TLaIgs/4z0abRiLf5jp5+GfsMF0dUT1fiK9IF4l9h1ZtGn/xclwmVK3ZuOBQfdX4h8cH+21nbSOvlvOvXC8F5X8vZThDuD6/yKFZzk+W4y2ZnFHGcZvarGjMW+ykAE4np/w28wV9MNvebKPhEtlC2aejVH4313Sdnh2TALML/CpIe1y5H6nSwkstF76m5v43EpDL1+F1hhuYZNVp2rf/vT1Jg3eTXhFCUs5+KzsLjqsLJYl9aPWGSeODMdd+glEWl4A4fn0gMYuuGbvuz5X0F49irGJkJR9SJv1K7nSKiw09wpV8uTVvX3ezRac2TiSd4Fl2/7lKWjj0GI07s9ufoW2XiOSUElzqbZT4wfTG/OhLhRnyBgjLDM4P+Bjdb7oMRXnzpSoA96/PLUDSTbcbTc8vVESukwDuYD5UpjuF7wIwY2LGq82GDEESljaayI4LSNOHDKxzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(3023799007)(56012099006)(22082099003)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWZKUldoSGlLSEpHQWFWUVE3RnUzSERaK2diTEhUc0t5aUVsSnY3RjRwZndB?=
 =?utf-8?B?MXYyb0thbXJxZDF3djFtNkpkZ3NrczIrZVdMU2c0SmkxYkRKNTZKNVNORU1k?=
 =?utf-8?B?OXFaNGJIaDY2cUZNbTVwQVlMSll6MVlFQURMMU5EVFQyYVZuYVZVVjV0UDgz?=
 =?utf-8?B?d21LbkU2STBxWnMwaHZhK1F1L016TWJpQjhNdW9MN0lUN0Q1RkYyMjlTS01K?=
 =?utf-8?B?bjV2RmVyc1JhQ3ArN0Z0MndmaXBFMVBVN01GdTFtZ3QwaVdJNjRZdXBTcUhN?=
 =?utf-8?B?bnh3L2t1ekNOaEJQcCttcVJTOXN3Mi9US0VkZ0VmQ09pemFaN3dWMWZKMUJi?=
 =?utf-8?B?WGRnOU5VVmlxbCtPaTdldFArcXpmbW12WUJ0RXV0dGx2VVFiLzdOdDVwdDNn?=
 =?utf-8?B?SytldGowSHYwYnN6aWhoWDVjSDdPcnVlcFdKVERNNHZ3a3VHUzF3Y0FweU1N?=
 =?utf-8?B?TDcwTUlHM3NUVXdZZ3NvQlMxNitpL04vQk5tdks1aXl2Qi8yS2RJNkZTNDBQ?=
 =?utf-8?B?TEN2czhCbmNveU9HSnJUV09NSXlCNE9zS2Z0MXdyUUg1eEdKd2hIUW1tVjB4?=
 =?utf-8?B?d1VpKzBON3Q0YjdtRjA1T3FPMEpHdThVTUkvSjBOUjJZUWhIajk4aHZPR3Ba?=
 =?utf-8?B?S2Rjc3ZaT0k1SE01WUhBN0FQdXFUWUpFcUpQMTlwU1NtUERqTnlodU9zUXd6?=
 =?utf-8?B?UExnemRpWU9hTlBUN0R3c3RZZ0V4a2tmQ1UwWnJFaW4vS1E5SzUydVNtZzNk?=
 =?utf-8?B?NGtSWVJQOGxPY0dkK1VtdW4rZWNCdUp0dkVDWG9tNVBnMGFIdTJBcTVXOVh2?=
 =?utf-8?B?d2s0b0JFVEV4aVhocmZpTENNaGNpS29CUHphUUN5THhtUkNuUUhDUkZJcTJ5?=
 =?utf-8?B?RWxWeHFmb25NSFpaYkJuaDNrN0R5SzdodjBxZGpBejB2NE0rT3ppSTZVUXli?=
 =?utf-8?B?Z1VmNTZQREU4ZE9KSjZEbkRuLy9pa2psS24ySXJoVmVqOU56UUlkYlZoR3Rw?=
 =?utf-8?B?THhSTnRRSHdnemtpZ3BSSXpmczFRWnpacUY0bWoxM05mTUZ0SlhZLzJNYzAv?=
 =?utf-8?B?a2pjMWxoWWthVHJId2J6Y3BlQnF4TFQ5R2dpbWNKOGlkbmxTd3Ruald2a2pH?=
 =?utf-8?B?QzJLMkx5aEFsUnVvT0lyNDVVTDhrUkIvdGxyTVZ2QThsamNyWE1Vc1hIVmhk?=
 =?utf-8?B?QmdJblZDYXI5RmNmcUdLT2ZiRzkyTjNvWUg5REtDUEZMQ0dzaWxaL1hRYWdy?=
 =?utf-8?B?d2tzblMrWGZwd05BWmhsS0dMdTJyaVlIRnhKRE82dDFjMWdIOUtlV013NFMy?=
 =?utf-8?B?Tk1pZy9wbUpFRFZwQ2tYeTM3UU54azRwWDYzQk1EblJDL1V1anBCakhEU2Er?=
 =?utf-8?B?STBCQ1FzOHVkckdwRU1ZdmVCVXNLV21Xc3U0aHJQQnNlSzdQcm1NTUxIdVhh?=
 =?utf-8?B?S29sWXdDOWorbm5lQ3Mrd2F2bGI1Y0UrZndybE1wdm9jU3k4RWN3SFJOazZR?=
 =?utf-8?B?THNjNGxyMUNVQ0xjS2R5TnA2Yndtb3FrYXRvb004OXpPR1Y3a2tPMmx4ZS9s?=
 =?utf-8?B?dDJnSHhlZHo5NnlGMkxhNmxtUkdMdXQ2RzNxbWtGS0xZVTF5S0FaTVpqSHdM?=
 =?utf-8?B?VUdnbitXbk83cnZleGpIdVBaR3FNc0oyWnRYbHd5VmNZMUVtdUFTRnUwUWgx?=
 =?utf-8?B?QmE2aFJMckxYcTR0Vk9ZT3NVUWY1aFhmRVg0VGNHV2pCZWFMV0xpcjQySTRS?=
 =?utf-8?B?TlRaMzJRc2QyWkgwbFZUdThCc21sbHMwZnBvRXpnTTgxSFROaWxIUVJId0Ni?=
 =?utf-8?B?eEVQWjBNdncyVk01VXFJbW9nMjRQdFl4NVhwU21tUm55RlgwRm5nZDdiakhT?=
 =?utf-8?B?QitWc0JQWmR2VzRIWlNLcmdNb2Y4VlFsSGNWRUR5VDBMQzBsU0pYMDlyWnRS?=
 =?utf-8?B?ZGt4elhTQkpiOEZzTnBoWDBZWXNmb0ZqcTdnTjhWSVpDRDFMS1RpSXluMkhv?=
 =?utf-8?B?VjIycmNweXlqdW1RcHFlbTBFeFIrWU8vc3lHbUJ3djRNM3pGeUV1M01rcDIw?=
 =?utf-8?B?OWhGTnI5THgrUHZsQzhtUDFMektJSHdIMTBQM3FaSnI2MEJWUUJrY0ZEeElq?=
 =?utf-8?B?UUdVeFp2ekFvdUFtbXdCQnJxcms2L2Q5eXBSRUlvTDVGN1RrZFdidGM0ejZp?=
 =?utf-8?B?WjhIelFOWWEycVd1QytmZStWQ2xDNXR2V0hpV21BRFNHMkZ3Mm9DNGVOdHZu?=
 =?utf-8?B?SDh5dGhIZkprOUtHREZLZC9iZi9JZDhpbklDTlNseTB3MHVWNndDQTBmc3Ft?=
 =?utf-8?B?VXpXT1RQSWFhUUIrUGVmSmtVWE1sdnVXYi9XU0Z5V05NeEZrcFBYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad809ce-f028-47a8-730e-08ded107499c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:10:36.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHtVSIJS8sVZXy6rJUFu2mlQCwF/UEGU5wW7Foykc03SIHRh7IUvMIbh4l/tW6TN1DmumYkSLVOy7NkfXZ2lyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

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
---
Changelog
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
 drivers/cxl/cxl.h         |  9 +++++++
 drivers/cxl/port.c        |  3 +++
 5 files changed, 82 insertions(+), 34 deletions(-)

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
index e50dc716d4e8..eeecb588821a 100644
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
+	 * Handle the degenerate case of a device with only empty decoders;
+	 * an empty decoder can still map a non-zero skip range, so advance
+	 * the walk to commit_end either way.
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
index 1297594beaec..5231345ff78e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,6 +324,15 @@ struct cxl_endpoint_decoder {
 	int pos;
 };
 
+/*
+ * Some BIOS use locked empty decoders to preclude HDM decode aliasing
+ * for TSP operation. Use cxled_empty() to handle that common case.
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

