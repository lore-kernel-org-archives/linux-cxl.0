Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87A3DAAC1;
	Wed,  5 Aug 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909354; cv=fail; b=cuOLqptaqY/oVKxvxFJLM+T04gmq0h0qUPXtylH2w+oEg8xY6Bvg8yMlUP9W5fRBFX4T2vXXwUJ2+6N667B+IUFknYmrAEvwjrQboEHSTSi5+DprFP8L77n+D9lcraz7vZqao2jPvfVYxX1jGHXMOn11XldASPcm2zIh1X14YO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909354; c=relaxed/simple;
	bh=mFn44ny4vW3kJnzPquxDE9OLrNQfSlMu4KTD1HSVNM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRzIZR1poBBwIoKQhkOYlpd4HxXScdxKAfWtVCTuKr5Dx643b7LIGhvElVHoMSYYgRqCtjXMD8Evz9zXGG7fvxvS8Z2KGMX97qpGM+YgEyfiEknm1ehHelc9FgiJ784TYHz9pmHl7hNR2k9gYVec9F7CvyHPaZuL15bvuqB3wUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rv+7LFZo; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rv+7LFZo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwg2UhvpiPYSllGgVsaJivvOjmDNL4R59zmed4xoAEyyCtlyD4BPy0lE1KkHqa7Ij1+1i2k5lKVwKFFsQzUXKSNmBENklXIsnPSCbw/GsOeSJWooOUCMIjdfTHo4xVVUvRozxLBjNLfKUk3OFeBcgi4F3x90QeDAd48RVy23/b1iBtGZMPW+Ia7cAPDFXItB1YVYX43t2FniF1JyVAEd0Y2qwrYqo4TMiGq6XEALtgJO6ABFwflXYhm7tVVMlhinl9KeV9ubCwnlaHy8bV3nJv7NWvf3O2y98pEU8V+zsajIHoRg6bzDNjb/Ue0fmgpZhUXpN6l2SvqQpG8RgkMMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKCXte2gAL+9Yxe21Gc9e+a5cI3EAxmuQm20m6Q0kQk=;
 b=ejqhEOpS2VaoYZztfF0JXjcFcGfU0efpda7mbh7HBj2x9ZioaLElvx21SgWP4B2ru1IWxsL1dzT2Tfjo02R/ozg6/T8tT/mokeU42yDB7WpGoAbzbvObP8f8fDcxCSZ5foEbp/dxX9cK0GBZeCscuIEhpn0LJp1xeAQoz+NjXLyjA+EQJPdZbfh42EIWjOOAq+Ve5fdX7w8xwAUR8Vt8IMY3bFrtGtJ6YGARVMCr9WytCsPiScJXC2YtLp9zvkpp3KxkoSKBCpRSeZHsAtKUOdwsx6Mx/H+6ja3JwQ+pkNgQow76OaVKdEE2pEb1sX629UiDf09qLPDTyW3Y4PlrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKCXte2gAL+9Yxe21Gc9e+a5cI3EAxmuQm20m6Q0kQk=;
 b=Rv+7LFZojeOlpT75YONt4Qo4hmK0kIzj6O5N6ylY73fH9UmM2UMM+5zYTpCVDkrRW6LUeR0w4x37LE5PudpD+lhd/2vBLFo5vQpi2mLUqYiB/6dmbp6q1nbJdJUBY80nvvH56rcDGcq9kdLNcH3yZ2wXRU6//ZtonF7m+vQPXdbB9DgicEnYfbNtahvKpBggFP9jfjrHZ8tK6QRv7CfJqg+xDt7SumlZfK81CQzIinHEAyDYyL8AOsRa2TGUjKLG42VUw/wZhq35NhxB5BHs/O7bsgi52j+DopVHNxc5wsuEm66dKjRFrE7kGZF07EtNvlW0NMqCNCNtYCFL/xbE4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 05:55:43 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 05:55:43 +0000
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
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 2/3] cxl/hdm: Allow zero sized HDM decoders
Date: Wed,  5 Aug 2026 13:55:23 +0800
Message-ID: <20260805055524.22311-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805055524.22311-1-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a52917-e35f-4b4d-5846-08def2b62f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|5023799004|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vvhlzT7Gew4dBy3yN7AoiM4TlxOodcP4W3jFhQatyzuCA4Y2V0cEkVZgmUga2WfE6etFTWG2XofnbbHwOyUpjNHIgPlKDzoD56Gy1ZPDc6HY6JoQSWsfA+5wp1BYd8dvCQFcEU+RBggFVDQHKaUTXf/g33mXZWKRcZ/vMPJUhzwCs7GqaqsC6ypsG1NroC4TbLqQwNy93XMx6sU1V3aFM31iM+UQ76xhSosKOaTGC2DOHrC4pO1KXzyCb6BP+xFnyQRUNsB1KmZMmchPjixnvr9FxkbjF3CQpZUYiIF46AHRzr/2XRLaq05mZqDuTRdo2ttaqizuOw+41OrwsIGrKOFtP+Mu+G0SEJGQdvLEOJZ6JvmtDrWE4xZVM6DOu0zQ1qEAim0aRHSD3MRJ4gsj52jFe+JC0soAiqqC8NKg2DEcpSTPpq8Li/ncfjEkYDC/uk9QtDicXm31mOWG+RNYqcGwtSyptk79d2gysedJVo3RFiv5fHrfTEa8CcMbtHjmzhsQ4yhJ6kHDY1pvhU5+7oJRrUFmhj4bfk5B8J0RC4+fJKyY+NJdg+yqM/Q4OwWi4SXyv8nNCsM+k+dr1tQWEYeVpE3DJPSReUycXYXJC4YASJc7DtaVx2wHLEhIgGERPKoZWE/O0lKrkyM4dG41WJKStBeaSGum/CP/nEduMs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(5023799004)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnRzdHRVc1JZeWpRRWk3SGxxc2l4UncrS0lVZlhtVjFjYVRkZk5GMis3VTBz?=
 =?utf-8?B?YitIMEo5WFZyNStmd1k3RDM2ZjhSZC9Xa21ybGpta0RLaVlyeGVWeWh4L3hV?=
 =?utf-8?B?N2NqM28vVGZpNjlHaWs4Z1NXaXh3eWJGS1lXWU80UWhxdFl1RFkrcGNjU0lP?=
 =?utf-8?B?Y1pNSlYyazg5alZNMmtXWFp1U1paalVxRXVJRXljV0hKUU4rMkk4aFk5a1Y2?=
 =?utf-8?B?SzBIMjhEaUVQaDlJL1poYWtGa1JnalVhbEVITEZtYnBsVzdsLzJLSXdreER2?=
 =?utf-8?B?THpxaVhUNmxBK0xsbVpMbXBlcG1BS1hUNXBWaXpWMkw5SHMrRlp4b1l5V3F3?=
 =?utf-8?B?cXV5aHNGNVhzcjN5OEx0MTZGNDFaMHZEdGVJM3Q2OGhrWWVLUFg2QnNOUThj?=
 =?utf-8?B?VkpBeUI0dnAwTDB6S3hXUkxXd1Njc096RGl4ek5aSzVXYTNPNVVjek16L0la?=
 =?utf-8?B?by9SWEZJZ25YRGRXanlpeTdHeU1pSUFWTnduRXQyaFVUdUp5QVdsQ0NZd2l2?=
 =?utf-8?B?SjQySHY4amNGWGRmbStVUVdPblIzdVhqY1piZ3QySGJYTWwxUDEyVjY5ZEI3?=
 =?utf-8?B?eWdpNCtlSDVvZTRzSmZTemJxTml3NVh0VE9lRWdYcDBFUDdHcFBqZGxteW9p?=
 =?utf-8?B?YlJOMEg0cXo0SDl6MUoyRkNZNE5IMHRyVnhkeHJaam00VTExa3hNSzVFUkhn?=
 =?utf-8?B?d2w3alFoaG11RW83N2pBcFNmVnJPZ0RINkhtcXJocEdVa3ZFRERhVTlYeDBT?=
 =?utf-8?B?SHVqSnBnQjFaeG9uT0lRcGw5NnRRVWVHU2UwaDBwaXZZRUlUeTI3V3B2ajNv?=
 =?utf-8?B?c2laL0hFd2Y0Q1RVMU9JeFBCdmRsaTBKa2ZPZUg2NUttOGU0dXRDWlAya28w?=
 =?utf-8?B?QUZiakZ6NGlMMGtRdUV2cWI3Z3JqSWU0Y084ZXFHRVJYd2tJajUxL2MxenNx?=
 =?utf-8?B?K2RGbzAxUHNYZHJJQ3lhL1g3elJlU1NYSjRjbTdxVitDZVo3djFINi8zOWw1?=
 =?utf-8?B?U1hQT05YczlXSVVTQ2Q4eURLaFVzT1pkdm85L3NBWEtneEtTZHEyYTFuQWVU?=
 =?utf-8?B?bTN0UHhjTVIranIrd2NrL09yRC9uZ2luMUNsM3BMVEJpbVlRcTloZnhUSXpP?=
 =?utf-8?B?VmpaTHdRZzVSdkhxUmZkNGt0SEppR3NmYkJrc1VXak9WNlNmenFJRnZsbmQw?=
 =?utf-8?B?NkpkdExhT3p6UHNXQmIzZGFOVGNkTyt0SmVQYTFiRWFuWlFZemNwNEFpeGRi?=
 =?utf-8?B?VUN2SlNGaWl6VHBTQ0g5RHVua2FIMDVZbFlsT1I2OUUyKzhuSzNMY2lLNEp1?=
 =?utf-8?B?RkNsaFhFOGZNaEdpV2U0U0dHOG9IbGZxZUNlU2RnVTlEeDRPRWZPMVV3OEVR?=
 =?utf-8?B?ZHA4Qzg2bFJTeEZ2TmxIbm9waGh4S05SL21ZdnViMlVnMzh5R0UrTUp1MzhN?=
 =?utf-8?B?UUtTME5abG8yeVNtbFRRbkg5UHNadnpPZldpK0pNTy9hWThBUHkvVVZqbnl0?=
 =?utf-8?B?WUFmbG5raGlTUm9lbVNZVVZWVmF5WTRad2MvL0d5czd6Um1waWtnYmpKMm94?=
 =?utf-8?B?aVpLSy9kRjYveDA2MXZ0MitSR0tITjVmMkphakZ2UEhwTkFLakxXWUw5NWQ1?=
 =?utf-8?B?b1dueG9ienUzRWJiQW5rT1ZBeGd1VUY3aklJaUp6VkxNc3ltK3VsekFxZXB5?=
 =?utf-8?B?M1VKcGNtVmd6TGZ1aXgyK3VpSi9ZTXpudUxNTjRybEtWdVd1VU9MWVQ2VFdv?=
 =?utf-8?B?Wkc1U1krU1loQjlSMmpsNlFwNk1zcnZkR1Z3TUN0VjFTRmZpZGRuWEpGSFpF?=
 =?utf-8?B?aGdOVitsVGc1dUlxWTFQSlIvVTRreW9jaGdKN3diVHNvYXpmWVl0SzFmMStw?=
 =?utf-8?B?WW1wTG5seVRCYUVpRGNLUXY1YUdlSUNpNHh5NHNaaU5pNHBXL0dPLzhWMjFE?=
 =?utf-8?B?YlVkQjRDQWFXUmdKbnZtQjdCeWNDTGgyRVdMdy9WYlhZVkFCcW11MCtMYktG?=
 =?utf-8?B?MitES1ZvMG52dDN1dUFqQWhsQXJ1eXpYL2pLc29McEk2THpTcmdVWTdXMHNE?=
 =?utf-8?B?bUhjUzcyZjh6Qmh1b1J0b0dwUWNaUi9iUFhlbzVVQlUwKy9vbFduWlNSeVZO?=
 =?utf-8?B?YXFWekUxYmhGRjBjZ29yRjdPZUdnTitZV09FY1RoL29xaU8wb2J3TDA0b0c4?=
 =?utf-8?B?amlIeXl3QTdSVlZ1QnkwQXhJaU8vNDVzeWJHY2djMHdFbDJwRjVEK0xXbHpw?=
 =?utf-8?B?d2V4cmFFalVSNGV5WGtDbklqTU1iV0h6bWN0d002aklJaHdDdHFuTGtDTU5i?=
 =?utf-8?B?WVVHQzY0T2RQZ1ZpdXVReUxMVVRISWFRV1NLUjZmOWl6KzdoM3lXQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a52917-e35f-4b4d-5846-08def2b62f83
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:55:43.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V8VZxq/JIfmZ88hyF0PQC/zFQrbAdhkjg7fGOURxML86CSuYb/jxbNcGIbpmCu6V5ds21XU9hovi3Ct76Rw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

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

v8 -> v9:
    - Rebase on patch 1's poison_efault_forgiven() helper. The two
      -EFAULT tests in poison_by_decoder() now call it. No functional
      change.

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
index 45536909cc17..e6929feb6378 100644
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
@@ -2969,24 +2969,31 @@ static int poison_by_decoder(struct device *dev, void *arg)
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
+			if (rc && !poison_efault_forgiven(rc, mode))
+				return rc;
+		}
+
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc && !poison_efault_forgiven(rc, mode))
 			return rc;
 	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc && !poison_efault_forgiven(rc, mode))
-		return rc;
-
 	/* Iterate until commit_end is reached */
 	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
@@ -3008,9 +3015,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
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

