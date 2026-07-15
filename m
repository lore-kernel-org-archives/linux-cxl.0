Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDC438474
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118244; cv=fail; b=QTGhorDvJ45ncVLN7rLH2NHH41/bn7KYaHXB9o6rXWJLv5eYfEiRlU7zAnA3yEBSyAgTMwwVFX0K3P1HDLifKt7GZ8eoKSVwd5frxYCSq2BT517j94Gjq31rAgb5egb0Sy1MMfGez0x1/vCsgpOCLOOWReUESdCT/ERPP6vzdnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118244; c=relaxed/simple;
	bh=ABH51ypdAPPdoip9BH0RRfEih9kgF84hcmudJTnh1Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gdk6SFuD6MML2EW4B49WhwtmHUoc9WSLY7oG6nWQEEImmZGxfVunV9DF0JJ8ReXU5+hqNggBTMQB0di5nl8zqyIvByBCsJydpwy4aLrXJy99XBpEyykQMxeNxCEQev3S+xFGrCTdySnkDG+743Q1S3Vi5ZD6cRnFOzmb8IPVBFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MD3bGzTS; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MD3bGzTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huIdiB+hRaOK5YtGYKigEHDmGln8XZFEYJF+rflz3u96Ziu9QtgnHmTX9afN7Of6eJMSZEfWxu2GOWJGu5Aka+Paw7oOcxeLXM18uRR+DQWUsvUAxfz4sy7Z5XU+11GpPr3iMUUVdRLQ6x3vHs4Coj5nGAFiklhNFLcn3PWgf9zf0RQdzcZV8Ctml1Fo1QqbLqDlNTdkeDqSeLDGz0tOx9+fJ5xvGjQ/+LjtAAdmn5UyVn3Yo5JCIRGet7H8KFyBlwxBsuMNw/A2PGUS27DsyirtUWXlhM78XS2GSTSojJ5p+F6B59Kjdj0+7rcrf0KjNHLFPdXfbPqcUDn8RgeYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl/h0cZ9aSQNFcafpx9Cgjv07c8yYNJ2RRkh+BRh6+Y=;
 b=w+jC9c9uCfBf9gMdRzR6PuStFMTA96wiZ3nRwVPKeF81WoOm6WPzLiTbvVUeenTJbmWizyuDWlSpQBQiCOpba0FIsUOzhIGsncnb5ocsj2eKkFOUVApeTgxo+aFIf/qWk2xE8fxoDhXEeBg28FU+d2kXcOBIofO6Age4RtgkX73PbvU/zC+UQyh8koVJdYWClfrmVRWO4GAUisFzldZyWOUj0LVFSE7cdsWsC/kHS8WAR38w3kC6wX/7foF68xDt4vzzDwuzPhS7SdPNoMEaa5nr8DeL0nkFnefVYk2SMAGJPjK0cNjdLKqQETnH6VQCcb80mCKz3dyhwI2ZSGmdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl/h0cZ9aSQNFcafpx9Cgjv07c8yYNJ2RRkh+BRh6+Y=;
 b=MD3bGzTSb0V9cGyhJwhglbHogEUuIQ/XTAflNJXyfHcIGnP7v4d/9N5mCTNHlYpztDpGR5ZWQlYhAwx975mEhWaL+4u4FvlH3VHZ2UyNoUwtER1A1XvruXLLBFU36nnnKm28flR018z+jBVIRfyVhZVDJQ0kiQXK+a33N4okThY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Wed, 15 Jul 2026 12:23:57 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 12:23:57 +0000
Date: Wed, 15 Jul 2026 14:23:52 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/6] cxl: Support mixed-granularity region interleaves
Message-ID: <ald72KDU-seE0w6j@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 171a5e76-f049-493c-bfa4-08dee26bf16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Rxcx28VqKBLNML/VcruvbBe1f2qykaFASGkGHGfrgkNCAyepmPCd1shr2L5ng0ZJIm0NAcVU8ob8utjdv0z6wB6BINt4VqiwSpcDEbYvuDGsIIZS2WeBorAd6XUer4pn2HkrieZsOSYVfxv2VKricph1ynsZMWjxRfyphKnmm3gri3H26fsysNfVRQzFeB11XTTU3hnaoMxWPe7wMJiw3WePiCYeBbzK0ptM+Ch6GbLowHlxssh7E0B4ezM0peIo3aixwf5wDBm2jMLYagyaMpQ+OVrxutLrbQ8JIPB4hbAuT5S/FF4xGEZmpuYsAAMoGimvvM2oCTwulJzp5eAe+Rqd1D7hwsBzbaa8bxyb3+cmj8lOTrjv/aRFdj4Sb+nXoYf267w3Ef6hud5I2of00aee4fWsPi6qP+J4cNtn47NoDAF6kuAqFJa74aer/45pfRjEcYhlzLqVTFceS3phoN6RpQOwsa8yX+BHOIh627mo9+UhdOyhbg4FBtg2GSPSj4fSNCBRkaDAvCbbzCqbYhIUOoYPdaaBCPuR2N4pV3ogrDVNwCCrRz5n8yRJ931jVqCBVwevMWpcvcvs+aGciijTzdFUUjQfWAAqpzl7BHd7ylkdfdsdjrgBk2CUVS5obPSo+nluOxvdhnglRe9fMb0qyQKTtn72I1d+DmWR5GA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/sP90L63MiR6YDOffCONly8anHEjsK7vXMjbTUKSocs3s49jXYHFWOX8A7o?=
 =?us-ascii?Q?f8HpqWfUQrM/nbFGoNMVhgvYOahxUF8IGCm9QBvuqxUDyOlT/gmP6MN7+p3M?=
 =?us-ascii?Q?txFA1tnBELBcI8dfUc+wqyUKgtmaOl793fy6zzpB32vaQck7qaOk3d5hn5c1?=
 =?us-ascii?Q?IAB8kXpAtbBuYwn9uBXSoDUoqsQkrJ8xu0JtjY1EruuvSFSC0b+dRP1VHjob?=
 =?us-ascii?Q?ER7AKnd8JM0c1HrwxMN8S9fky385VxG04G7iwLvKEm7yB6Y82jXoVl8LG/13?=
 =?us-ascii?Q?ijUotKTJ3iuasvMaHEOo1CaFnYZPGda8pZCVkZwrR9LkllpP+uKLlg5d5/o+?=
 =?us-ascii?Q?dUFpAC+AsaSX+q4wI/mSmapUZgHIurWb/saQkkmDUSzRYcr7pIL9hC042oHO?=
 =?us-ascii?Q?07s+dkzXhn1MnCK2ZjKhEoqfqElwgYgqy+TkaxlefY+MNaq+xUaajEkC5iG+?=
 =?us-ascii?Q?MI11ZYswqdpIJxxMM6BzDqcLyQ+d3iyKrHboERuqLazXtP4Nj6OJH1PxxgNH?=
 =?us-ascii?Q?upossFDDcHJYK/VGXz+ozZRKTHVZAJJFO67Z/a46xwz03tjs4wvh0tL3EPHt?=
 =?us-ascii?Q?ohjNAg7zXpK4+J0WJ9rLLFwt+3UutZ028LOKLL6iYhTj//eaGsdmaGEwKqjZ?=
 =?us-ascii?Q?9dgIoUPrrKYxwlm+x5SLonkjQvk3IfxB77mnfMQsUHNCueHKPqaKiiBILRJr?=
 =?us-ascii?Q?iIts3FJZobx6NNLKxdo0fUeM5gbu266JkTmL24cKh2agMSzaeJ1IN3RBiytJ?=
 =?us-ascii?Q?ZwYG+iB8H+UFzlgbafTtdRuBtdtLc9UB8Z261iQmGBSVXrYQCFavrpl7Q4w5?=
 =?us-ascii?Q?cpqTy/IdZPeDqJqrJE11OKxkRtiyaNpEz46lktNLB4W/Nd+m3Lz+lyXzXGzU?=
 =?us-ascii?Q?vr85GDQgjCoh83J8X7wd7MLXEqupZDonyvv/5PE4lSzz8HLYQ82fbTvG5hJ4?=
 =?us-ascii?Q?XvM1b59HXZqghevzsgfDX9JaWCzQMdWsn/2YQ+Tt9OoktmhExyiKxKwLQmWD?=
 =?us-ascii?Q?md4DfUHZr8RQyPm0yRaAtaYvUtCTAqc9nhS/dAytYalYXWEsuvpWN44SjS8b?=
 =?us-ascii?Q?K3b5H2JKT3A/g5kAHoEsFOq386dXbOiPwucKFci+AH2EkFsscFBTmQtyAgMD?=
 =?us-ascii?Q?UVsngojKNnkYgbP0Rou7ONvx58bpCCoKiZ+9ZW9dpaMPMm1KQKYwmHKuhgwf?=
 =?us-ascii?Q?6B/gRn2JEu+N9+kbRFqC7z5gfpq9+Z2S2ElZr67QGnMWZWX6yItu+AJdj9oZ?=
 =?us-ascii?Q?ef535gKgfdburbEzoEwS1ZPap9lB9BNypY/2w72cOoPWsxCkJSOMw/8On0mt?=
 =?us-ascii?Q?dSOOteqWjBxVA5mcElzisQ2SYCuWT+DgxopCj0K2TY8K2CGFNnVdhUGn4e15?=
 =?us-ascii?Q?mVTlFzwr4783Ff7ZgyBWWpUTxGTtg9tc2uy7X/PJYzL1m8AY/FNb1PLZlylT?=
 =?us-ascii?Q?96zLJgxr9fdAciEvy9RFspMR5jIk6t5mTNEuVUoYdwHKXNnveNoTWQhYJiAl?=
 =?us-ascii?Q?aKEMNUlfTkvEAwoTXjwoi8iSslF2f0kow1NTbszKmVQ0JSASQw1NGr/RFl1s?=
 =?us-ascii?Q?me0GlW/g6Nr8BY3iSi9jiSWUPYsZZSWUbq2xBqgR0P/HNF0KStr4ssEV2etN?=
 =?us-ascii?Q?7a4nk5wr9u4Z7druOTMZt3nDPhj3wS6E8urWHpgf+VK9AXPuSE3qVn9YftKJ?=
 =?us-ascii?Q?9uy8YUViV96nSogiK/X0+H7aZH7PuAch7+hzaNaZa4dJvx/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a5e76-f049-493c-bfa4-08dee26bf16b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:23:57.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylJubeKDdAC4HPRHYDK7hylmtHfjxW9zDjS6slxzbm3MWjZXurRFhKHUesaiharT7fUcl4JbiHW9ZVjveyjPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

On 11.06.26 10:47:24, Alison Schofield wrote:
> Changes in v2:
> - Patch 1,2: Defer the unused selector var store to keep P1 bisectable (Sashiko)
> - Patch 1: Make divide by 3 in get_selctor() work on 32-bit builds) (lkp)
> - Patch 4: Use local vars in cxl_region_attach() for readability (DaveJ)
> - Patch 5: Add NULL checks on unused mock arrays (Sashiko)
> - Resolved errant err_rch unwind with rc7 merge (DaveJ)
> - Rebase onto 7.1-rc7
> - Update commit logs in 1,2,5 to align w changes in v2 

For the series:

Tested-by: Robert Richter <rrichter@amd.com>
