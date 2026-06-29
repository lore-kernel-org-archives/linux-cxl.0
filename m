Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04239AD2A
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715275; cv=fail; b=gpbKv1b8Be3WpcBCNsDNVOrWjO9y4ScJ3GaTiSReAbg1f8VyXhAiJIbs8J/RyNaNfgIYowNL59gRE3FRNEGE12nj4PJMpUFOFiWU+LnZPPkHr443ylYBLk1GZRVlynSkFaFzAK/UyX3mBrUvRyoAABW82vEnqwchwN8P9y+oQZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715275; c=relaxed/simple;
	bh=M5OiEL18fhqlLQoVzSkQ+jw1scCxQBOQ+MG+KuUZZnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzXE63XaPIKNb6FyCcraTWspuG/Uqe9dMRCIvotka5iP/pfcxdSadwnPtaJ4K92l+4q5vT8eFGmh4+Iy+RmDV5et3dqOSLMinrmqe724Z/mDbIIS5HTgEgBXX+0MurcI2p8g1BilmqMlKPNS66Ze0oeoMSpJxRr/aAj5T93ZPMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VggCgoCG; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VggCgoCG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH7RvsCv73WdyvM5wCWbjWuRdt9uv4I4S5pz6lP7jtbJ/i56gvBR+7tGWv9EhQcqICXKlE9AG4n/1/xSFq9RAqIFPgzAd+7u5PFPrYHVBJa3YROVx37y4uIN31BUK5Kdx55ghs6pFXToUnjEqyCqoww+mG8cX9V8HraO3wZk1lfNf3A/Ec++gvdPxNVLDdw3SR1BXsRy09zjGU9PdcQ2w4SYnZulpAO/citddtelvo5anfhiMt0oA1qegs+ld0LZzUFYmjzWsFjr6nFIYvHTdPbff3n1ZVRq4yoKIelmFrNJ1oNVva6w3VADiCIj82TrDwy7Z5mDFFnDyEBjSu9kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoLSRUm/SpsdF6k6ZU9e45W2mjYoEZH0WFsS5axRfzU=;
 b=yadllI+PrlC9sOZuzquIl6UfhAtsu3FUWnpLiPlThwM8o4HuS7qFTCYJdAfrx5gWYYN+wvKhn0t4VJlrUIYNPUhuI0+qFNXyOhrajmGEvOsdJrSBuCj7ctJcbMvsnFeOtv7pCueOEVdt/siNBkvMA1M85n8soZjeb5oVfATJuMrKLfjGxGijKrivs1tQKh8qM8mAexJjFOZNGSgMFgzq+G2jWWDmq249jJjBJyK7PuGhs5xu+2hDFfeItsRseNQ3O+zPp0KOTusTr/qRk+EA+P/Jgpg7QjJb8Y83twBghYOYdwHuWx7ZEQtoXMuGPx4CgY/XJZS4K/cj9a7SxNN8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoLSRUm/SpsdF6k6ZU9e45W2mjYoEZH0WFsS5axRfzU=;
 b=VggCgoCGEolkEfqmM/StWBQxsqmxGeQp3ZMkl1e9iDEaMYbaCjmkRSQz3DUPn9a3hS96xybrOwD0SAvY/IH5ZvVvushdk0m+DV6fjE0tB8nPXCqluUiQ1gIots7dTuhLa5yXruColIIRHN6aWtvZjXsLvqIWQUbpHCmIiBa5U1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 SAVPR12MB999121.namprd12.prod.outlook.com (2603:10b6:806:4e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 06:41:11 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 06:41:11 +0000
Date: Mon, 29 Jun 2026 08:41:06 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <akITgju_8_6PoKFB@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: CPAP307CA0008.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::16) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|SAVPR12MB999121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9f0367-40fd-47e0-ce91-08ded5a96842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	VCE3hiOnZ5ZQN2uU8DXOT3Nk52xzfY+I8nkZUM9wReLec9VbMosISTqG8MNeQ6GckQ7LVv1au7zw0ZfQeJTOOv4ioI2Xa5CZJCqvpyb0sun8UWgkPkw/05vWHLU2wX+i7yYEH+GdCY5YXl2KynJjd+n1Y/bBPEewKHN4QhzNFfPgIyLkOb67CyRwTmV+IM6fcBETNJEMM5pJ+3frFOdurRPipc6v+3LXOuvnMGoigPlcMmUZjA6L+xfJUfh9G1b0msRxZPzsSUg+Aqgt3vm0JUV7R4ykh+Y+Lv91qLZFhN372qSocUWajkIRxFXTStTczWrbHXAKmxDoTYgFGQU3wARaGDvMIvfoR9jLPYJvJITwkhAlNauam5eUNF1pf/O8a4VGybqvCwtzxPlvwqLrKxmIYAPD61d6DfkoNyMqjsHLOutvwCkPgOPw//jFtgsg6Ey50Bk7rVoEq5w+qZSlhs/5Sybx8DIpXr4VUWf8b6Y2uGpgKV09optmMajW0op0Gy/gpEIEng7ClTCAZNlLdzQVHM5N2ByhMC/LM76bWJL5O9jKgoihJq4XKBtszasGEvG8+MPKMaiHmqP4/6Jbv14oEhXvkuIVNhPe8ErxRlcG/5uubGwWiEZrvgGdxBtCMPH+jY82AehvuYaYSJLgs79dwiewk81bgvi7CAOsuq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8D4OhrhcbRKy6Vutuy04aNjU9oDoFoqTX/9m4MwpA5HUOxDpZ+B5Y+he1yI?=
 =?us-ascii?Q?LGHTIJdJ8R2lADwXo2bPm4pA7qllCliEixThG8ffadQvJ2c0lkKC5QwoWMa8?=
 =?us-ascii?Q?FbcFgP+oE3hvI3TlCwebeS5kMKufmkPSviVTwIxti2q4nIzCtePxtG/fnPJ4?=
 =?us-ascii?Q?6+pfRe/+GZDsKizI+0TSjRzRRNdpSj+RNg6yYTAsetEfzYxZseetXPFLHrfn?=
 =?us-ascii?Q?1ezFxRPdQlPtecMi9hgxSOXe+Tmks9IQNbkJliTy2a5UFOpydOjYlRSU84Rt?=
 =?us-ascii?Q?2AC59jJX7H8hDHUJGkynBLeYyEM4/k0Liy9tWmC6cFjz5mtXokblg/kkUlRz?=
 =?us-ascii?Q?wKnGLiiQA5HWtaa0nVq11m3REOq5bpOnAQbJDYxlxQt2NbMGxaP1YhzmGR3R?=
 =?us-ascii?Q?zgef47XZRaItBptEo84u1GJ/lAG+DEpYFugI9P1x9hDgFGaK9OMYMannRZO2?=
 =?us-ascii?Q?lDARM4w7Cl9z0n47W9KhsPkX6caCaqrgKpWq1JUEVSjdFbtuoacEiyzDoD3m?=
 =?us-ascii?Q?bRA0cuoppGGUhIEYK5PTOYedOe2D+4N2HlW1hpwLvjlRxNIAKYNPwOxCpIud?=
 =?us-ascii?Q?L9wzouu+jqBpZE7yCbLFqTySu9rbzxrm1+iLzLjR4RXezTpa+xcn6Pa/dFzl?=
 =?us-ascii?Q?wXa/+WO6RQG20ttQQ/SF8xVjZg2lkuxBNx21CTXBpRG7Ri15NQMrsUoKsA5i?=
 =?us-ascii?Q?O+tFqbo2yCZ4OOfTSf+EYmFrebAe5jwl/x9Y9uteC/GIsB7Gc435AlJf/+wF?=
 =?us-ascii?Q?mcRBxYR3B+0AnJ74bdlMT7l9QWfetKreXH9U1XQy3pnvq5vb2Nb9EqTa2VCc?=
 =?us-ascii?Q?X2aOBAIdA5CCDL6/fJ5C78keP3qiWbuQdp/oyhdZpH4KlrwR8oH7FUpGs2ev?=
 =?us-ascii?Q?cFX6NUQTNvyOHsL2Xc5bCB2DM1qDNJFIIsU8vbeeW+rZR4ZwlxpXhxUwAtPY?=
 =?us-ascii?Q?NSryft4R3AlsGBuTV6orGWdYjq1UzLvDBUyXxdqH325VuRDwPRQ/wvleo31/?=
 =?us-ascii?Q?Q4kAWFvfLQ0Gh4kb3MHT/xCdQcPppxC1Mal2qVqWBLGNbO6JaueyiHN93yOT?=
 =?us-ascii?Q?v9dJhOPGNO0LUWb00rvvVfbJk0Q9R0HPyIomCkuKorjR6jCMWy3sAbjwUIHg?=
 =?us-ascii?Q?vIodqq4rF+Yrz0QcFoctBd9hlrmvZ/p6S9GXGy04fNxW7m9iVj9feWciWaUU?=
 =?us-ascii?Q?e5LGkCdTECovW3s2y2L7kUG6Cz+pQqAyG9AtVtKKtembFdmgTM/N3Yn1aw36?=
 =?us-ascii?Q?EKCOfhX9ZeoPNHP3PbPuxzXCxTo6ARhr2Dd6IhCqGR7aUuYIQq1EHFyEE9fD?=
 =?us-ascii?Q?y6gYDlHQ5wPogDRXQjAug+MeDiI62szL50h+VDaywdLgch/m9XSpXKz55Tvw?=
 =?us-ascii?Q?LQF5PHTwV02hlzuQd4weChFBfs/rolMY2+ZaQ+n1MB+1bu4nqKXZsjTRBV1j?=
 =?us-ascii?Q?hW6b7ck4cgVestQkY52O3YAVYBKNyQlScpc/Or6OcBlZAkgK6L3ZiMLkwgBQ?=
 =?us-ascii?Q?oxAbZu2aT4Sm7HHwWyLH+imjPSoqmCOhxL5hq0L68vHxvPLUfhGsnVitOxTT?=
 =?us-ascii?Q?9no2fVomo/jcKiBLZYmswrNEFf8B2ZlqbjVw3ekPHeUHY0Ujw4gwOEpehccB?=
 =?us-ascii?Q?QDRX8nljHGyehuYyyoEU62U0dwO8fkkl25Eeo3zOjZo2g36ZlVAIdN88zn7X?=
 =?us-ascii?Q?+2UtA7UlnSFIphVCjVM9y/y+vAGqAmImI4FDZd9tI2oQuLPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f0367-40fd-47e0-ce91-08ded5a96842
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:41:10.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwKk9olYB07+VwGXyAYWGvcETXsxNsD7sNEdU8uhbBvz076XobL98D9u074HiFP3meVjxEINkJJW5DkAJd0EpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999121

Alison,

On 11.06.26 10:47:27, Alison Schofield wrote:
> Mixed-granularity regions place the root decoder at outer HPA bits.
> A root target then owns root_gran / region_gran inner positions
> before the root advances to the next target. That ratio becomes the
> root target stride in region positions.
> 
> Account for that stride in endpoint placement, position calculation,
> and peer-distance checks.

I don't see why root decoders need special handling here (apart from
the 3-way factor, but this is already handled). See my earlier
comments to the other patches, but if root decoders were just included
in the pos calculation, that should give correct results. And, instead
of introducing the "stride" term, why not just continue to work with
the selector mask also for the root decoders?

This "special case" handling unnecessarily introduces complex logic
and code. We should avoid that.

-Robert

> 
> Remove the temporary mixed-granularity attach reject now that position
> arithmetic matches the selector layout.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 21 deletions(-)
