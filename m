Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E127257423;
	Wed, 14 Jan 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360642; cv=fail; b=Ll9Uyu0BSJtdjOJLt+hBon+XE707AaG6vaJAlkPH3TYkzHxWNWcCxp+6mFKn8aBfwcNhN32lsN9A5QlKgAA6mzj4fPaI5GDzX+n5FpokIM/PpbGAKS5qCejMxcDLm9CdNS/GQA2VCrzr2m8AY3GzDCWGkAnkSNnyIwA8MBSok2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360642; c=relaxed/simple;
	bh=M5LD/Ld4Q0pOUg0nW5avkENkR0ArwNOTa9cgXKFfZdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k26vjCKBakD2pnzyLOaMn9Xwe4+a94sciHa2FEis/JlszzrQXfVJDnAjZc/9hQtx89gp5Fus2S8oCizW4DTpw9pnvjvGJtdnHDji70qIKLpJG3zTIM1vQ9lWuXvqroX0fKRYFgRB0CvcSWqrRUYB+eMcMptfW9L6mOvaD3JPe3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmJwYonD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmJwYonD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360641; x=1799896641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M5LD/Ld4Q0pOUg0nW5avkENkR0ArwNOTa9cgXKFfZdw=;
  b=LmJwYonDP+G7xBo6MZyjnzUa2TL6Rm/Xm2cgtgEf0euQDIQzHG+dQYWv
   zn+6h8sUVYoUkjRO0NDgiYQLCRavV/arwKk/VZClRjHB/La6NC4XGMyQ2
   W5d3aCZgYXzarBtNf8gS1h3P15BHUpkgQFUp3sQOm0xa5ynIaQWhCxFUS
   n80tBqxn0mXFpiqVJcKdUOKxSoQrimrjZPCQEGYpF2kLNneDM2WZKdvaX
   8SgC6E4YOfl2lBC2XROuZzKPOLTj7CCDP9vQFGH+8O7BD/W+zRhIA4MtM
   N1xy/RaxFZQOwMoPlZSprv9KS4lUqCCnWglUGzvzELl4eOtJQb+mmIl41
   g==;
X-CSE-ConnectionGUID: m4aFFEtLQy+Kd0TxaAxVDg==
X-CSE-MsgGUID: wekGSPOATfS81363uAUD2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="92324885"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="92324885"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:17:20 -0800
X-CSE-ConnectionGUID: Wn53nxmMSD6PtyDL002MTA==
X-CSE-MsgGUID: vGlbIzlIQc6afJCXcriIrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209605294"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:17:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:17:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:17:20 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:17:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipvtnX8GiiNKGacBObJe8hio1PooLKiybKPLYSDhEakrgiHtWgy3A5ApVgrxZ3HCMXUD8rVRz441FKuu7kuDR/YNJKBYhORf/5Zkq/qRfbKmNkO67w0U6OC6FjTa23c77Xq0QRfyTUxZlOS2cFKHUrkcEx1RHwsYdHPylpmeFH03qqNwkWq4wQwjT+eos9esBuDYQime2ZSB+UvOeaDOhymXcaqrI1LMwR8Q3lFHRG70hn7DGI7QsvKzA9Q0bz1XeqqFWp/Sz6DAymi2xZKYlfxDuOzaMABA9H7dutx91laGQ29rUEbg2doVNLzMwNtpfd/AieccS2ugyfMJP2WYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSWNB5T+btqGMP077Sg3Ph4ZhMQxygZIlKsiwcrtTMI=;
 b=nJ9xCL+7u+A0OcI3vRMKhdVn8D7Y3NUb34jD+IJSS0aeMtlGW2rMV0GaVIBPR6Ne2BQZDtNJwqZ5L5plphzcl9rN2MiXnofb5AiMV3VGlEZ6x+AJJl1qcDMFK01Y/3HjenMJDRHoi5l9qZ9iZ4/jjxdYawwpt3NzRQqw/AZVEvLgNNNrjsutfPKKBwPhtWe2ytWvaOBoqg5jtPmZrrTl6DOAAapxo2nGZFMoskPATC6EdLu7IoivP/C77hHg38bqsFY7FFie1VdAjw9l08xAXLa+rErD7ctdvR/YC6Mz997uVbTwHFduDRK+3B8iCKx2wJ+6BTR2anOGljNSCbyk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH0PR11MB7166.namprd11.prod.outlook.com
 (2603:10b6:510:1e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:17:17 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:17:17 +0000
Date: Tue, 13 Jan 2026 19:17:14 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 05/13] cxl/region: Separate region parameter setup and
 region construction
Message-ID: <aWcKunnSOphuDAyr@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-6-rrichter@amd.com>
X-ClientProxiedBy: BYAPR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:a03:100::32) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8953baaa-289e-42a9-6aca-08de531b6c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6akAPXbtuKbpkwpKhEBWmGoB1kW74ZQ9VB10pplS5lgJ09FFZkPupIBG8qEw?=
 =?us-ascii?Q?I+KUZW4ZCRatcY4FzFONXnWHJIgk30pmkf6BWIWKaTfU582z8CU66QxmcHp0?=
 =?us-ascii?Q?0aha4nUp+TsHDGtB0Em+FmXlRS+sfPfxJG2cPvWwBa97jFbE080q/Lq+pA5Y?=
 =?us-ascii?Q?J5URRQf6PvZ/ruUzljcbbByQfl98ivAUb7PYTKxHLkCTFU+CIS8P6RQ0Jqfr?=
 =?us-ascii?Q?5b2oF+YsoJGbsfTwQFuaD5uTETu7+yd9Q0UmR2351WCXF7O9IvVyCHVV0vSb?=
 =?us-ascii?Q?JxG/AlDSIejCmXP14hDlyhbT7SucTDltC44WddxheulMZ4Yc6Jc0mLZMRHUV?=
 =?us-ascii?Q?GVOuZrE3XDz4ltozVkjSBIWrdjLZGRi/zefV2TDQcmsY+P6wNJqEku1x49yc?=
 =?us-ascii?Q?GNFxs1QYd7iL6OezVnZ0Ssz3IIwtKSA9IloBqyqhfj1uSxmdn10m5KjSbOZS?=
 =?us-ascii?Q?y1rGr13k7RTPqAo8IB1epYddPmNINifNcORUBxyswjnKt8BUJV7HqjP5wiOP?=
 =?us-ascii?Q?5xifAj9uhhNexg5O/PXELJSG0DeGg53iCMg3jyFvjKw4natAUMNY6Ut1miuN?=
 =?us-ascii?Q?JJ8tTFbHej59OaAAkjEcYEM/y686AeogxtCnMBXt71cF6/tLV7nt79jjB1XU?=
 =?us-ascii?Q?yOUtUpIEMhxlfjCLnvoO207MWcxNU4p+MG/ITTVWVUu03rHqQDSMACsjIq67?=
 =?us-ascii?Q?yEFIDXwC4s2t5AyWMiKWLslG+3hZaNGQCdYuPkZ/v+FkoazEzL1TNbp4TVsj?=
 =?us-ascii?Q?GgZ9o2mKCAgeEvgZp2ip9qADP4HMY3SN2fKjDFrT3xtPvSEKkK3iOdg4FDpG?=
 =?us-ascii?Q?qRZ1ikUtbQ7UZLWMhIJ6Q6+h37xgbA/xaXeL5T5VsJs25kgK29aGQ+wIIIvQ?=
 =?us-ascii?Q?FzZL2lS7FMmkczuC9zPXfXwFgEzdvMGnstH+Ra9qQsjJi9jPU8vQH2w0VVzA?=
 =?us-ascii?Q?oWjPtZIVzHDlAuZUMqvzy+sbTjA+iG9bLFlpsW/iYbnKfmKxo7mmyOZNT++Z?=
 =?us-ascii?Q?ObL60s6elvevhLbiKOP3wpMxa0UK15+gi92XpolQ9rJ6RFaQT2OF0kkkkamL?=
 =?us-ascii?Q?D1P51BtbxuyYfmHOphy8rUpQPs4Kia6YUTtRI/pp2y3OFvTWO1roeeNUdHmu?=
 =?us-ascii?Q?pE91urPWxBiAAFKxwn5Zmh2Irmii5hkL40dTUuPGz8nc17BktzraMNDvaPkL?=
 =?us-ascii?Q?8UoUACrqZzpAwlklhzcrLh6hI/GCh/pH2koRvgEsBPLn/fHzqLFixC9kBg0S?=
 =?us-ascii?Q?0VPA6ErcuthUOHB/NRQEZgfBuiYnwr1CWlkuyAwRzGbHNNkclLO1umMO7QFn?=
 =?us-ascii?Q?fqpZksS9IYtTPBslNV9I+kdyEGab8NwsFmfLXbX+8Ucxx6I9HQ2djBJ5eVF+?=
 =?us-ascii?Q?wZ0XpM9qRCZFJQiK6FAD1gtkJyb5FIwwAXklBMxLBwz+DWSMiM2mfAeNNqvW?=
 =?us-ascii?Q?zt1LpvvGuEhOcoompfTqYcq77G0MppCQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPxZtcKxlbV4yg/BMqL8IjF7Q+PXbCm6B920N0zpqQWaXdXv1clS8iEvdPUv?=
 =?us-ascii?Q?YWm07GRvYCDZKFibTtXH07YkOihGfMpkbC9WFo+h7Sf3TE/PhPJWQMWgftpi?=
 =?us-ascii?Q?xKuBCeb3f9GJBUv7dapuaHyPq9ciwvBMm8evSZcfv0qaw57M6KzhdEenvKyP?=
 =?us-ascii?Q?UuXOe5u6t46G/m7b+M8fDKbKtWv1JlCHXIpX1aFR7WXWZ7kDxEY5lAIqHk2s?=
 =?us-ascii?Q?58YJLmLhPwhzVxgr/46MnRNgV0DNUx26f/t8XagTjgEBD6M0CTCKKiTmtvWR?=
 =?us-ascii?Q?7YTGaqiWv6UV+wEi2mQNq98vrBWBpBH/OMGB/V9Be0LHsSuWL73d4gur7mLL?=
 =?us-ascii?Q?ZYZteuXguCZeBfBc80idGZezr02nmr/+kH63PvOcModmx1PJVaUIus6dUuYl?=
 =?us-ascii?Q?wb+9w+WMSm94KsDRqL0AvHnwnICtFydIN2B0lNiL/ltZJwJ0pWH1FgHAoYCV?=
 =?us-ascii?Q?uyk+O9zdAbQZEOfmmTOLfNOgPAGNkGjvNyrokO8pzw/q/I6hhdPRWFL3Zdqq?=
 =?us-ascii?Q?K1bxxZVFGqq5FcXdASkqjWYqGi7lxhqD+0Qj/83ONScJgEoREbtEnK9oQLEo?=
 =?us-ascii?Q?OqV5XXv+Q7iZ/RRlVHkzXifBzKmS7E3YTnKw7nqZGWwTRSxL4iXyKF28kY/t?=
 =?us-ascii?Q?kKkp6TyZwXtl7FSiuoHyZJpqOMKIUV/dJXmWE0xgtviaPn2uWi5jfga37Nzx?=
 =?us-ascii?Q?jDMIki3z8KwEGq7NkevZHuBmLkOvAz/N24xhyhDYd4KE/TZlF67d3SdzBryq?=
 =?us-ascii?Q?jEE/jF7wdcG5KhpbfJiV2jJi8/+rTybzKP4A5aW/ZJLg83QlDa7GTiihxNM/?=
 =?us-ascii?Q?fd4RIogSzQ+OGKcgzk50knSeQ/5gFSbiBZ0lIrTEiTor72TJ5UyGdhOklm0t?=
 =?us-ascii?Q?lNpGKxgzsQ3PKSRzLqmUch7FxCzv6famhXREvR2J2BeNvJFi0EP4onaiiFS6?=
 =?us-ascii?Q?NspmzkeV0PXyemHKLrb7EMODWTUz/jR0W8X+CrcLpe+bpg7WAit8O75oA+cm?=
 =?us-ascii?Q?zQJjA5M5a5SrRTTirHsnW2zNL7yQSJ9ZcqBCgqzMf3v+5V1nupU15STv1w+W?=
 =?us-ascii?Q?MZ6eBd7xFZiTcj+4KFqFmQHonhqxLrE9KrHjYMZ0PbHm+NhaPMtn8gXf+dRd?=
 =?us-ascii?Q?8Om1nejJImf+in35zJc6wdgEILDINSasNizj6uznqTEtW4uWBOh6Kf0b2Eff?=
 =?us-ascii?Q?qZvlX3SYXY1/eqRw3FIroAd3jjiUxeLZ3qV9LkpTg+A3N/S0j1aYJN0jU6IG?=
 =?us-ascii?Q?MM2HHNA498z9kaEE8j4iqNap+sEUhG8ztIgulHfhkVv+6E2M3ebeSncCEHzy?=
 =?us-ascii?Q?vn53wJB4oEyux/r8Yyjn+aG8HYj6VcfMp7k3l6FeNEdPj2lcB1Fa66BWI3lZ?=
 =?us-ascii?Q?CuBXcLrDiG/0IK3k4z4PtARK10J+AXvFf1mkUJMkYTk38SfnmsNPITw+EiDn?=
 =?us-ascii?Q?kaW8jkTtEXcIL+X3qtCIolYydBwRf1Sy+UjKdLuuIXcg+0Wii0t3nCCaJMS2?=
 =?us-ascii?Q?KG/WWQ8B/6S+FiMY4oOUpvSymLanjYQk6EULaTn3p2zkQLGCNfbpicqb+W/h?=
 =?us-ascii?Q?AU2HVvrIzbnyRcBuOifPFSNOxNZEwpvsTynqVe9DOCRiTXveZE8nj9F5QUZ8?=
 =?us-ascii?Q?nMQK1/bHaTpVX90jNnWIIZs4c2eCvzJw2emwHXMcUrwC1kWZOW6CuSoEqoBm?=
 =?us-ascii?Q?Rlhe9JoVNo6Zk/1WQEw4BqvFrBk4i6t3kiyshjvHEyVhpfCY1eRME4FqMl9g?=
 =?us-ascii?Q?bbDEOSwKwdwLmAxVIsn+B827otF02po=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8953baaa-289e-42a9-6aca-08de531b6c19
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:17:17.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7vyURAOsv9n5Y6flISw9vnFMY9kuOplQAFNlymdCqN2/v1HjPhdjqRT0WVJUwhoXUIzSh/teevBSelMw44COUOowP0kBC6GbC2p7oUL24U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:50PM +0100, Robert Richter wrote:
> To construct a region, the region parameters such as address range and
> interleaving config need to be determined. This is done while
> constructing the region by inspecting the endpoint decoder
> configuration. The endpoint decoder is passed as a function argument.
> 
> With address translation the endpoint decoder data is no longer
> sufficient to extract the region parameters as some of the information
> is obtained using other methods such as using firmware calls.
> 
> In a first step, separate code to determine the region parameters from
> the region construction. Temporarily store all the data to create the
> region in the new struct cxl_region_context. Once the region data is
> determined and struct cxl_region_context is filled, construct the
> region.
> 
> Patch is a prerequisite to implement address translation. The code
> separation helps to later extend it to determine region parameters
> using other methods as needed, esp. to support address translation.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

