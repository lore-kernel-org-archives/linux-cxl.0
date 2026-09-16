Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3282931F1
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522110; cv=fail; b=lz5STbbHyYSp3+fNP/obEWKdOOCi5klLAPIU1UgLRAq6c4e+bLXiCyIN95i2r3IlTS5FuxxNyeuONnQ+RTqfX8zH9Yiyec4/woov1Xn4J1NmNSg9XB0Vf/04eYF53PrBXOpU64EvObu4sxGCmIy7pGGKYLAd5QdudBQOA8eaofc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522110; c=relaxed/simple;
	bh=nGJlBDfIbZGg3wYMBuhnJualrXofnvGdpiBBUvIjg48=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2wgWO2ChoDAguyLAxsb+GVNDhX/eZ5CLOXNyPfEYzpRebA/k7Bab6utzP7yEpLdV7K1RjMDw0pqtgmyVYSXdULX/iiChyBiWHZvhC9Dnp+JkGQaUnlLlqLjlBDfKnwRQ15mDyq2LmkOwbtNijTTkgZmvNCwYlVne/lQzHK1LLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWcGrM9A; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWcGrM9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522108; x=1821058108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nGJlBDfIbZGg3wYMBuhnJualrXofnvGdpiBBUvIjg48=;
  b=YWcGrM9AZnCB4I+jMjeBr848tbNRko6SkTTqz0cY/n/c7jNAUMrD2N1e
   wakeugA5Hc01XW0TB3LsJbch1msfb45iscBAMZzc/PecKwEQ+cz0kDRYc
   lI1CDs3qPq5daSRHSc+6FFsFSU6ElQtwMZt473tEW80WQJwaW2l879n1r
   pHrSaCXf/vEoiwafnEXz2neIB4MVTR1syFIJC3Y1Dzfy11dBLoxDGtUj4
   ChDbLXJRDHPct6nrh53xI+2kj+/41hiOWFbwdZEjV2MU+Y78MP0DechGd
   xYcO/VasmMfSC7VdiTqjnFxZptR/Pzre4hRaZm1JOUOGCWmazWIwHL3BH
   w==;
X-CSE-ConnectionGUID: o92zs48sSLCUPkU0X+H9Kw==
X-CSE-MsgGUID: HpRjTPUBT9mBA/Rth8Wtiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100493946"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100493946"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:28:27 -0700
X-CSE-ConnectionGUID: OHA0D3GUSQ2USOiM0dgEnw==
X-CSE-MsgGUID: WVFpNfNmSlqvlMpxV6TOKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296685846"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:28:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:28:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:28:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:28:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/NSmaaOB0O/K/u80MvuCs1zXfydXqqCdHmR4F1wM3KTZiTianOSSeTsOrPTB/aMqPj9d3c9K3CaQnVCyhfDB/f+wyz1Qa0U3dyCW6WpufzrLHoQ6la30QATxwuf7CjnIEbw7IGerLwFpWpU+5bkSAKhEtHxHC6qFG6446UqZ8WXRw/ToCLBQ/q5AluMzebLYtjrS4asX1kE3uF6a743PA2x1+y5U8kktzDgKQdjpCsboKlPLL9aVpjCVC49zzUH4LMaBGryf8CoTEB3hHQ4evMWm5g+Ya4ADX8L637CVd5gXuMwwEqPfShiJccHVurW1xqRaebpZZJxoC7Gkf7R6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r69Ru838ptU3Iby0HjcmhvdPWD48EUE6PUcb36E/vHg=;
 b=uAiGTBhVDY+u6Nz8532JeY1etk9xUX3hIbADZxxIiOsHWMTa2e5jrqBwIN00dljlhXD6UZq0k3WoSxaSLAg2rkNcidmIfANGcY0gfM+qaVD8AdwKU0vikWB3LpVZ7fU6v6kJRjMJk/u5xQwja5uEW0+gTwX0UlzdHhj2MF46DNYssGfUSJYlMGfHbIF25txxtrngaMucdRD/Uql1M+LySd2PtY525aU5xdgh7LdsiY/NPeE9ShewJV34YddUt2AMPdCuNGWvc4uSXL331QtPhDk1OYJCLYBF4Ya1SHdQzwaqb3ejx19K5InSlx8SNWa3pihcNgTfMnd3nXR4Xpuz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 01:28:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:28:15 +0000
Date: Tue, 15 Sep 2026 18:28:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
	<habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aqnwqjkebypsbHAf@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-4-anisa.su@samsung.com>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e0b7b6-b9aa-490f-bd9d-08df1391c78b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|22082099003|3023799007|10067099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2lvcZrmGbYukoOK/VPmt7M0hbjmbla629brHXxvvqmSNkeAGtNqwi8WmJpQ0F9vrcCxM3G7RdId9aurukyU/ZrMc/193PfpYfsJiigRt4a6uFhk1bpWWsOH8ml2737ihsnb4MBJx5gqaB0JdqM1rnOkeZ4H+abHbIcYJrnls81IOa/2zRj2gYPRr7b9uXOFVtiEdUFuPYwqRO9z414c0+H/XKPW5RJFGaoW9Wcv5CLkZXr2mSaJfMBoaCc89SHY1mH1rXzi+lExa31Mf+lGxGwwgWK3tWycuHgYjoaFUXxlCqIshNilU7thTnQ8/hQgxo7583UqOSglndkmgoaoinUL/nA0naEFyDxOqjurdJG0XBgR85JHWtb1k5QQSmi82E++MO8hes8k6/ci5k+VtsbVILarmAnXvJxz5weRq3mRpgAXCZclsVXky6POeNQC5MH+Ye3yUUvB6ZTZ5RLPJrS7XKQsKLD86fzUQZKZjRP2x/9iz2XRqvjwBUGAJxlZ5z+y/uuQkZU/qVSlXONeBjywFszk5uGs9sei8crK4AlhmuJjrdBimM9u8aukY9Lhubu8y87Ua2UqG1+dytBmWNMcDzsDZReXRBNQdGNcNE1DvFYPVkSxYHsvN1DyHBXOXDt4Z9zKu1o2wdvKYMznnJxvcu6z64vB6v016sb1A95Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fg4Ta6YboRvtJLNV6nLo2c+8NxLuSrQNz8yEXasQjlxlFYo1NareFIjeBUw?=
 =?us-ascii?Q?6vQ6n68p5IVCdUOw056uMC5Gx9t7EGX04Hp9tz7BbYl3HVbk9pywXo4Q87XO?=
 =?us-ascii?Q?RCJCYt7LjXcLrdiqH2AsFtfKYju3AN3msVwdf6Y5W3pMK56sKcqW8AHRrV7f?=
 =?us-ascii?Q?NefziCi1V2DGliZveL5N5xtXpFrS8HLBkCRy8TJceZg2bptc7P/j2/1Ciq8x?=
 =?us-ascii?Q?Wyb/0zukbOGdb5yYIiZV1aU1HJlbYkW7CFUBfeLLTDU1Wockt55lu4AA2Xvp?=
 =?us-ascii?Q?OVaEgWp27HsVEjqIOf1DkTj8cqcyHjAz3UjYwGQgn6OC2TBjdoDuZIohdh0a?=
 =?us-ascii?Q?RNHwt6t65fRiA/pJH+y8RANKxdIA0j1tRUmDK003awzlfg7eJ0r1vkOH5AEL?=
 =?us-ascii?Q?aFG5c8jvlqweqqRmQ+ccQiGij9cGz3Q6EFH981vMWgbuIbW8qczMQrfVu8je?=
 =?us-ascii?Q?qCZY8bcVvb3+NvrKf8v9h/Az/k9b0IdJfe/W9AMNB5ecnf8OD2GvbcArrrPm?=
 =?us-ascii?Q?JMbPj8O2V7NtqeOsOuqAL2OhCxLKunUzkU9a6uScT23Yfnaq61dG9Ibi/Eoo?=
 =?us-ascii?Q?PB1CGplNdzl5j+DWVcVDLNvzcje0FyZOysK1vtiYn1HKYxyA8OxLqsGrJor7?=
 =?us-ascii?Q?2tdVSna6cEjJEY0bQ67aZCqo/vOfak7WX/Z4NjORlUTkUG9VHpypEnyIycwM?=
 =?us-ascii?Q?sCCkb12QjTQaA8zHkuNmlTxqANEDv5cmZX01/II4SiVMb6PfZioW9qNqampn?=
 =?us-ascii?Q?erBkr6cHRtwy9ugOxNp/8f0L3a+YT7IFQDzdTbhTdUxAOE4soIKqcMGXZ6yo?=
 =?us-ascii?Q?QrlxeY5N/dEz8jOTObnytQaaRRzwfPhRNee/x3nvq0lb1cEXBFfLBmX+n4YT?=
 =?us-ascii?Q?/etCfBl7A2mzFfiz0lYTmfBxvsovDEq0Dyogbzowgd/GTMJpSDahipjAAzo3?=
 =?us-ascii?Q?vA1IxnZxYU5Pl3RIMBpmd0ljpKvubOwFgSwKKKGp6q/BlP63eunAUuXF33hV?=
 =?us-ascii?Q?6UuiOoLBwSIZ9SYo8ust9p7k2kfk9pp7GwlFpDK50CURlzGHgkLbbv7xnJ5F?=
 =?us-ascii?Q?U4ogcP7pe0pOTaJ6X/76gr4GV3IvNWmBWTeCIjESf2iT9JzbHBitSYbwJ4P3?=
 =?us-ascii?Q?LoXh6uHcikR8HBx31anJB649hzzgB3UTdX7N4z2cv0pazucDDbqjIGl9zFGJ?=
 =?us-ascii?Q?9/0APjBxauKixD/7oXUUCmq7g5CNuWPYpxQ9kGAq8pCCqwCKnp1bdOaXS1Cr?=
 =?us-ascii?Q?nPWA7lMhotKC3e0be6rwlD2ZGIRlJIAPRMCxRy9XIyd23v8D2v2KgNf0jPcL?=
 =?us-ascii?Q?Zvqns5Gk2WwWV8+2lcX51OMQONG0bqIOWlB++yPLBMcqjn9nijjwrsxjBL7h?=
 =?us-ascii?Q?ER2X4uUONmLNfH7QUi1Xqv2r93wrB99FYRk2NKNmV/qMf+OVSbV4r/QE7Kt9?=
 =?us-ascii?Q?xDBcbdtI6uyhiUO9DFqewuKj6iNv4qhpc4WJU/isnrcSNNF0AOCs/n0zSBdk?=
 =?us-ascii?Q?8dljouoxwkDDftiI+krqCnMFIHrKibjM6ilws//N4f3QlFkBW+wwHE1+bYDh?=
 =?us-ascii?Q?OSI2YClOrRpIBgjGWDo9RgmFOxoMKfd0rGeI7RwBTlkQ+FFV6CKIiCAZKZtY?=
 =?us-ascii?Q?uMJYxk7PaBqgKvTy888TrBrcCcGVWVUYdQ2aVbuCCFCslP0f8/RepCHRo3sa?=
 =?us-ascii?Q?fjM3VAAp+nBSkY5tMGsbFAF4eGU7b6y9YxabQENnF7Kfo0sIvWsaEcg5cEDk?=
 =?us-ascii?Q?fNmq0gGtgLdX02qd5itqoiEsYaIzssM=3D?=
X-Exchange-RoutingPolicyChecked: jhlcmsJ42Y8T3x/FRgFSxkGo06Bq82e3MB5jwDOt4V3mlCqpTPbJMGhIr3DlVWgEehoy+O6Euc684sk5knkMqncnVjd4Qcp7YsH7xVYm4whzawuQ+UtIGzKUBma7jHfQVeK++UKY0Y9SAYTiBk0EX9ILgsAS1TEEDrSKyHmpies6EYm5B+XPMZY2mft/12vF9j95LMxOE7msB8GFz0BWdUzcyXVaNhhFcUIJ+olJf0e5gQCan2sSgWo4tRCD6LsLuEWVnz2sbsZR5C09FY3sFIAnC6eQBxw581o2K3zz2krbMf58EbZPBb1BbgACOLB20MWXqP25snCqlgLAks92jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e0b7b6-b9aa-490f-bd9d-08df1391c78b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:28:15.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMugh5gN/70+2wVlcJyQDJMFadeS+ZSQSckFDmsJkIoEo4qzOuflIcTQUYb7nv0oVL6lJHa7iiy1LxSjY6PZrnwfl/jAHZ7LcsrwvsqsIKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:06AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> the Get DC Configuration command in order to properly configure DCDs.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Linux has no support for more than one dynamic capacity partition. Read
> all the partitions the device reports but validate only the first, and
> configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> first DC partition to begin at the DPA immediately following static
> capacity.
> 
> Based on an original patch by Navneet Singh.

I see my v12 addressed, and with Richard's overflow fixes and Jonathan's
comments addressed, you can add my tag in next rev:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Also, please add your Co-developed-by here. This patch has changed substantially
under your ownership and your development work should be reflected in the tags.

> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. mbox.c: validate only the first DC partition. Other partitions are read
>    to make it easier to add support for additional partitions but not
>    checked. Richard/Alison
> 
> 2. mbox.c: rework the cxl_dc_check() validation. Run the checks in
>    dependency order -- block size, decode length, length, base -- so the
>    block size is validated before IS_ALIGNED() uses it as an alignment,
>    and give each failure its own message naming the field that is wrong.
>    Drop the block size alignment requirement on the region base; CXL
>    r4.0 Table 8-347 requires the base to be 256M aligned and states the
>    block size alignment for extent start DPAs, not for the base.
>    Reported by Alison.
> 
> 3. mbox.c: range check the number of available DC partitions reported by
>    the device. CXL r4.0 Table 8-346 requires a DCD to report between 1
>    and 8 regions, but the count was used unchecked as the read loop
>    bound, so an out of range value failed later as "Invalid num of
>    dynamic capacity partitions". Reported by Alison.
> 
> 4. mbox.c/pci.c: cxl_configure_dcd() returns an error instead of void,
>    and cxl_pci_probe() decides what to do with it. Failure to read the
>    DC configuration is now reported rather than silently swallowed;
>    -EINVAL for a partition overlapping static capacity, -EOPNOTSUPP for
>    the gap Linux does not support, and the mailbox error propagated
>    otherwise. cxl_disable_dcd() moves to the caller so the function
>    reports and the caller sets policy. Probe still continues without
>    DCD rather than failing the memdev, which would cost the device its
>    static capacity too. Reported by Jonathan Cameron.
> 
> 5. mbox.c: check the block size is a power of 2 in 64 bits.
>    is_power_of_2() takes an unsigned long, so on a 32 bit build blk_size
>    was truncated to its low 32 bits and a value such as 0x100000040 --
>    non-zero and a multiple of 40h -- passed validation. CXL_BUS only
>    depends on PCI, so this builds on 32 bit. Reported by Sashiko.
> ---
>  drivers/cxl/core/hdm.c    |   2 +
>  drivers/cxl/core/mbox.c   | 235 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  37 ++++++
>  drivers/cxl/cxlmem.h      |  55 +++++++++
>  drivers/cxl/pci.c         |   6 +
>  include/cxl/cxl.h         |   3 +-
>  6 files changed, 337 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0ef076c08ed2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
>  		return "ram";
>  	case CXL_PARTMODE_PMEM:
>  		return "pmem";
> +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> +		return "dynamic_ram_1";
>  	default:
>  		return "";
>  	};
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 199bb986d674..a484e23b2b3a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +/*
> + * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
> + * length, and block_size.
> + */
> +static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
> +{
> +	return !le64_to_cpu(dev_part->decode_length) &&
> +	       !le64_to_cpu(dev_part->length) &&
> +	       !le64_to_cpu(dev_part->block_size);
> +}
> +
> +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> +			struct cxl_dc_partition *dev_part)
> +{
> +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> +	u64 len = le64_to_cpu(dev_part->length);
> +
> +	/*
> +	 * Not an error; leave the entry empty. A partially zeroed partition
> +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> +	 */
> +	if (cxl_dc_partition_unavailable(dev_part)) {
> +		*part = (struct cxl_dc_partition_info) { };
> +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> +		return 0;
> +	}
> +
> +	*part = (struct cxl_dc_partition_info) {
> +		.start = le64_to_cpu(dev_part->base),
> +		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> +	};
> +
> +	/*
> +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> +	 * takes an unsigned long, which truncates blk_size on 32 bit.
> +	 */
> +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (part->size == 0) {
> +		dev_err(dev, "DC partition 0 zero decode length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len == 0) {
> +		dev_err(dev, "DC partition 0 zero length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len > part->size) {
> +		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
> +			len, part->size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(len, blk_size)) {
> +		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
> +			len, blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(part->start, SZ_256M)) {
> +		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
> +			part->start);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
> +		part->start, part->size, blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of partitions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> +			     u8 partition_count,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.partition_count = partition_count,
> +		.start_partition_index = start_partition,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		/* The device must return at least the fixed header */
> +		.min_out = sizeof(*dc_resp),
> +	};
> +	size_t expected_sz;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* A DCD reports between 1 and 8 partitions */
> +	if (dc_resp->avail_partition_count == 0 ||
> +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {
> +		dev_err(mbox->host,
> +			"Device reported %u available DC partitions, expected 1 to %u\n",
> +			dc_resp->avail_partition_count, CXL_MAX_DC_PARTITIONS);
> +		return -EIO;
> +	}
> +
> +	if (dc_resp->partitions_returned > partition_count) {
> +		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
> +			dc_resp->partitions_returned, partition_count);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * The payload carries trailing extent/tag count fields after the
> +	 * partition array (CXL r4.0 Table 8-346) which the driver ignores, so
> +	 * the response is at least, not exactly, expected_sz.
> +	 */
> +	expected_sz = struct_size(dc_resp, partition,
> +				  dc_resp->partitions_returned);
> +
> +	if (mbox_cmd.size_out < expected_sz) {
> +		dev_err(mbox->host,
> +			"Payload size %zu less than expected %zu for %u partitions\n",
> +			mbox_cmd.size_out,
> +			expected_sz,
> +			dc_resp->partitions_returned);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> +	return dc_resp->partitions_returned;
> +}
> +
> +/**
> + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> + *                         device.
> + * @mbox: Mailbox to query
> + * @dc_info: The dynamic partition information to return
> + *
> + * Read every partition the device reports, but validate only the first:
> + * Linux maps partition 0 and nothing else, so a defect in capacity the
> + * driver never touches is not a reason to refuse the device dynamic
> + * capacity.  The remaining entries of @partitions are left unset.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + *         on error only dc_info is left unchanged.
> + */
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info)
> +{
> +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> +	struct device *dev = mbox->host;
> +	u8 start_partition;
> +	u8 num_partitions;
> +	u8 partition_count;
> +	size_t dc_resp_size;
> +
> +	/*
> +	 * Bound requested number of partitions by mailbox payload size. The
> +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> +	 * the subtraction below from underflowing.
> +	 */
> +	partition_count = min_t(size_t, CXL_MAX_DC_PARTITIONS,
> +				(mbox->payload_size - sizeof(*dc_resp) -
> +				 sizeof(struct cxl_mbox_get_dc_config_tail)) /
> +				sizeof(struct cxl_dc_partition));
> +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> +
> +	dc_resp = kmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_partition = 0;
> +	num_partitions = 0;
> +	do {
> +		int returned, rc;
> +
> +		returned = cxl_get_dc_config(mbox, start_partition,
> +					     partition_count, dc_resp,
> +					     dc_resp_size);
> +		if (returned < 0) {
> +			dev_err(dev, "Failed to get DC config: %d\n", returned);
> +			return returned;
> +		}
> +
> +		if (returned == 0) {
> +			dev_err(dev,
> +				"Device reported %u partitions available but returned none at index %u\n",
> +				dc_resp->avail_partition_count, start_partition);
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * Only partition 0 is mapped, so it is the only one checked.
> +		 * The rest are read to complete the enumeration and dropped.
> +		 */
> +		if (start_partition == 0) {
> +			rc = cxl_dc_check(dev, &partitions[0],
> +					  &dc_resp->partition[0]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		num_partitions += returned;
> +
> +		if (num_partitions > CXL_MAX_DC_PARTITIONS) {
> +			dev_err(dev, "Invalid num of dynamic capacity partitions %d\n",
> +				num_partitions);
> +			return -EINVAL;
> +		}
> +
> +		start_partition = num_partitions;
> +
> +	} while (num_partitions < dc_resp->avail_partition_count);
> +
> +	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
> +	if (partitions[0].size == 0)
> +		return -ENODEV;
> +
> +	*dc_info = partitions[0];
> +	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
> +		dc_info->start, dc_info->size);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> +
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..fdd6b395dcdf 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,43 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	info->size += dc_info.size;
> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c8e23276dc6..4fac65dbb808 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -407,6 +407,8 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +#define CXL_MAX_DC_PARTITIONS 8
> +
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
>  } __packed;
>  
> +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 partition_count;
> +	u8 start_partition_index;
> +} __packed;
> +
> +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_partition_count;
> +	u8 partitions_returned;
> +	u8 rsvd[6];
> +	/* See CXL r4.0 Table 8-347 */
> +	struct cxl_dc_partition {
> +		__le64 base;
> +		__le64 decode_length;
> +		__le64 length;
> +		__le64 block_size;
> +		__le32 dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed partition[] __counted_by(partitions_returned);
> +	/* Trailing extent/tag count fields unused */
> +} __packed;
> +
> +/* Trailing counts; cannot be a member after the flex array above */
> +struct cxl_mbox_get_dc_config_tail {
> +	__le32 num_extents_supported;
> +	__le32 num_extents_available;
> +	__le32 num_tags_supported;
> +	__le32 num_tags_available;
> +} __packed;
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -812,9 +847,18 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_dc_partition_info {
> +	u64 start;
> +	u64 size;
> +};
> +
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return mds->dcd_supported;
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	mds->dcd_supported = false;
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2fe9db4b3d86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_configure_dcd(mds, &range_info);
> +		if (rc)
> +			cxl_disable_dcd(mds);
> +	}
> +
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..4ef9511fbbdd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> +	CXL_PARTMODE_DYNAMIC_RAM_1,
>  };
>  
>  /**
> @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
>  	enum cxl_partition_mode mode;
>  };
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> +#define CXL_NR_PARTITIONS_MAX 3
>  
>  /**
>   * struct cxl_dev_state - The driver device state
> -- 
> 2.43.0
> 
