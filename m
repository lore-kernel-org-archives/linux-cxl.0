Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62688165F09
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929614; cv=fail; b=bDsoZk3If91Oi5F1+JyOpBDtkPGn0Q6yqsy73UVUQ4fUXTRc8hc9ohRApMv2vAeJD7Z6pdhZ3nL2HS326yIcws4x4KbToOzS2Qfovf42cljB2lS3v0p84Q1TDgTHohmhRnuavuckkf17qayhc3p3fImNSQBI7i2dqQ5I0agNCTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929614; c=relaxed/simple;
	bh=+0DwodKmIPAbjmaHVRFCLZBTDelD8tFXEIS79cXI/G4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JQPWMOudzbE0N3d4daMzNmZqeiNolROAZOFAamkAgf6l9ImcC5sCWgZ5XBjRyOoXGYhHlirx/iS0s+fN4l6+3Q0ti3Bbzpy3x+ThavnDnnIuK7+Z/ErKXPet0TaKEhy6E93tMoxqcLUvgThpjn4HDThxb6xznr67ECLqg+zpMfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4r952nY; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4r952nY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929613; x=1754465613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+0DwodKmIPAbjmaHVRFCLZBTDelD8tFXEIS79cXI/G4=;
  b=f4r952nYrSp96az0Syg22iHKF37OAcJt721EfMgGWdLRzaSgBjHB2r5m
   afxZPUDYIDoJ7QRucJamftieRQbB2TkoPnJ3Ae+U42EKRStwnWsmJrTe9
   CUIC2se8q8E5yFbTJx2Mzp29oLgN1JM+/aqUhBismnI69U2k21Mz42DFt
   U2NdXPVCzPqk6Zyzm+IPvH6/ifFmOO90ZVggw1Td7sWi3A0f7IzUebjDu
   bFX6AFf41d9dceUCbaw0GXcxf0XrBEJm3orD4fZMy0XMUFiV0tFpHXmpC
   qUrrzrLPkDUBlYU3A2aL0QXd0WgJd4AX7c17T02Lq625m4rJUCXKuTEjB
   w==;
X-CSE-ConnectionGUID: 3XQ7kxSORYWV1uGeg18YKQ==
X-CSE-MsgGUID: FLH1yYdlQ7y/yGj6XRtX0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="43454697"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="43454697"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:33:32 -0700
X-CSE-ConnectionGUID: qRBaZueNTzGzvVGTQRsEag==
X-CSE-MsgGUID: UD2QlVCgQD+A8lwpBqGVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56358093"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 00:33:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 00:33:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 00:33:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 00:33:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 00:33:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjTtYllM2yskjnofz3vYMlzh0+RjBlGj/9Wvcnf9NMCHq0eXIrwhLNfntoSnEyrnwWd+tZ3RdRNfTQvdzTWhuKwuDxpYT2RnmKvzlk4AnSPPq/LqFxrAEhMFPouoLSe+hl24V0O5Fli4web5cqudOLQjX4zphz1gCt9DNdwuYopiGJeFgSHc7wDuklimwfP2R/JvDQDdm05Fi1VCuoDWZcAN6mT3jWPTAaui6DlZ6U13KGez2kFUYaGBw7X4WIP9K701hqlIF0ffuRrhnHsox1ih6/29FrXNDVpul2lZlxtUpxRDWcvsaoYTKJrm0U63A6mDPYAuy3RL3iwOM+vpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21wyiz3Xx65OrvchIEl4zsgI9wun6yaxMgPFLL1whZ8=;
 b=TNJ9mo6kmV3uzSq33ZHLmv0OzWTCMJQfpFCXHxagWEbyJ38LX2ApPP82rK1MNtXpRsLT7yZvT1ijoml94CjALXgabOBnkvKoH3HUFy2lPdRgjFI4OrYzhqrRWdJfyY5DJk4aLcTvKRV/BrnDpoJYUtRmYw2EOqrlis+9fz09TMffiEsHqu1cnAb0ph2z5rIAY4Vrd6LGXsDohczoClBPdTucLj7526TRp480BaTZ0VjaWm0raSxMmXotNsr0X5X5MDLf5vwHnqhkjkKflbEUY7ILtUzRiq1zemR4havic/U+RZTfbpQ4ICPs6SU0ROY6q+4zHGx2M4blAsgKBvCOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 07:33:28 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:33:28 +0000
Date: Tue, 6 Aug 2024 15:34:19 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Li Ming <ming4.li@intel.com>
CC: <linux-cxl@vger.kernel.org>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] cxl/pci: Get AER capability address from RCRB only
 for RCH dport
Message-ID: <ZrHR+0w3bwM1Ik8h@xpf.sh.intel.com>
References: <20240806041547.1958787-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806041547.1958787-1-ming4.li@intel.com>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW3PR11MB4619:EE_
X-MS-Office365-Filtering-Correlation-Id: 998b8cc6-1ddc-4964-9448-08dcb5ea1036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLorNIOiqiG4EQZWzgNunIOkcVbwLSRT/qDL34/zfwe7fUA1UWtEKTweQytP?=
 =?us-ascii?Q?nMHK3OS17BY/jm1YbXx7V2f2tpoSQi97rtoGdgThvAXHpSzQ9WYTkBrWgpjo?=
 =?us-ascii?Q?1520s3o4rDvcaSK6OjYROxYsCdFm8OiDl+EqHh1h6cl9HsyqaEgvnqMPWA7v?=
 =?us-ascii?Q?vEFRxZrqIf4Nj2UDC186J5j/bOi/zRdncfTbRGeo0JMRoTo5eyQv8rJpI2at?=
 =?us-ascii?Q?1qUMA1LMvwjIgZE3VSs5Y+o2Uey7YUNMLy5VLe6dojiAyLKkUtAWBgca3Ve5?=
 =?us-ascii?Q?s9eNBXFjvXTRJ7vTnit0Ybb0DGEL3IDSRAp4Psbij/M1GBpBD4eYkLKLvcEf?=
 =?us-ascii?Q?4BfuZ0rErDEqmu0/hWPcnj10KXQCiZGuVvYlJlfpuz2LY/SPqeZmDQw30feA?=
 =?us-ascii?Q?PGeIlOkILmhcrt+NpAPsei9vjYTgzubj9hfQa/GHOAkLSVLJmVwcIScpp/fk?=
 =?us-ascii?Q?Y9kb607HPAmdJnWcBg5QrBYUV/FYeS/zXQpFdIYf2OpnwnFTjxv7Zk/rmVPH?=
 =?us-ascii?Q?UDBDJY/eed4W5u1hvvHBXbzv8K5YiupYdC3dYQHxofG6ieg9A/cR862rxexu?=
 =?us-ascii?Q?Dnxwk+wXopT72zIr6WTWqvcMytJyJtpSXTSZWdju9JcERXPXf0H175UQcdgk?=
 =?us-ascii?Q?cGGRklj/rWMCKLwWO8/qIHIJgm75bj6KR+hwqB+RIZw6UVPr5IpxZ7m/W/Wa?=
 =?us-ascii?Q?gU+UPuofJ8j9rdmjSYEGuAK4YOXEBs8kFgENdD/LMgM6g4f7QyQnDBgHzePp?=
 =?us-ascii?Q?SiQFPjaL4Hs/Z3zt3RsRQP1yU8CKHBAQ/o/Sh9J3CJG7ed7Y67LMP8zzabVJ?=
 =?us-ascii?Q?QW37AWLgc+lqpjTSv8A4LuFMi/bnqa0a9wtq7plpb16MT6txFzA59hK374Y0?=
 =?us-ascii?Q?WjHUBbsSxEpvT8fuz7ur+UQO/Dl0ZwsGinZdC9c5FYiaGri+mJtBXdJPYiM/?=
 =?us-ascii?Q?cQrhIeJaitK6L4pjR5+ykfw6Ps4Jn2uInzQKYDGPWb7k3dJjzIQ7B/FeGxTe?=
 =?us-ascii?Q?yJ91O7sIMOgPRenua4UJCCgGF427Z6T5yxkmCrMDLLrgeQoFA0zNkjfNCOel?=
 =?us-ascii?Q?e59mhob71BOn/4zQ3cciLriD3NJPq6FQRMxsp0VEYLToqukkTfhzWkpZmPZi?=
 =?us-ascii?Q?i4hoA/wqWc1Kqz7T5MU5NC7D8yHi4+a4Ssw8dswkuuDWZayJUm0nAdKQrm+2?=
 =?us-ascii?Q?22tvKTUW50OkLP5RedAoloKFuTXSnKz636HUd/GyxN6ROSnoHiI6drhyQOte?=
 =?us-ascii?Q?Ujh6qiBFlZqtdnLif0sb1bsgKCnxOZviaMK1NiLngFpwDeEWfawygnvfOUcX?=
 =?us-ascii?Q?0u4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oVHMJgdoHJQDMx7gi63jrDwv0QOWTKWHX0fyPx2EUcS6Xc+0sea/JPxfpLE?=
 =?us-ascii?Q?PN79jn+KQv+a95Mixm/4ukb5ioM9dS8TSUirx89aU0CwBBOLwJDjk1tLT1sn?=
 =?us-ascii?Q?5iCFtZCgJ4BBItAte9PfCW9pnA2XwTEGZjf6/ZfOUBRsiGrCVeIyScWyI3KZ?=
 =?us-ascii?Q?/nQXYXzAQx1Z12+oCs5hFq+kLnnBpmV1/juX7B2Xbs1y+hOlqLMDyF4F4Pd3?=
 =?us-ascii?Q?8Iql3aUbzg4Qmo9Igq+RGxSBEd9po7NVabKoG2ASv/WMqytN7nbUqnnYr0QC?=
 =?us-ascii?Q?DakgYH/f4kr07NDXYL+cRFrNOMCQbqU8WVEwXVH43dslQn5+ZDeGKXR0F1Nq?=
 =?us-ascii?Q?hyU+CWlD6ikbAj63urpQktoFRkbcLaPII020BKh+Er+VhBgN5CHYSef4LHHB?=
 =?us-ascii?Q?ST4Cls3YAjHaJ8FMdW4gmfeUtm76NFvUpNV4ZLPobyeWckJQfma/KMut5hsa?=
 =?us-ascii?Q?G1Tdho+ubruMzO/nb9PJcxpuT8acF+LJWW6nzZmOwkCd4cwMcYSOgSm44zkC?=
 =?us-ascii?Q?slscfVsWVKxWw4A1upyPlHSIeKOSIs2fgPks6azCrFp9ucT8NCxps1BEPjzQ?=
 =?us-ascii?Q?baBnM1+mwGLoHt0EXU8zxPUDYRebh0Saf9fDBKmwMKTl7wWXHljALled2oIC?=
 =?us-ascii?Q?XguMCh49K4fwoSslHjADOeGMUGXm1UlfbpAi5iDfaZirnb09BGZ1B1iAYWM8?=
 =?us-ascii?Q?sDaTZQ53kb0rgWSrKGcQ4LXimux7KBNe/RrGEkEv3wj/tAcNZUGZZ+gaYhnS?=
 =?us-ascii?Q?INQNc8pvaiZUt5spmc2Ialjb0gvfJeJox9V5nqVVxGOJLrdtNtFvIT8oBD84?=
 =?us-ascii?Q?YH8UtbBYI41TTOi7PH9iKWBaSbAeuSbpnWNLQBtROEcMc0SOkOzZ8gGCThfs?=
 =?us-ascii?Q?6APdD38NgOYEjK6VwO4fu7wPZiremHANroY2OZXFt3Sg52wG8Xa/nwoSvMqy?=
 =?us-ascii?Q?bxq+O4UxjjgkcxY637ijkBWgmWjVGh80vVb2ykp5JlUsPnpZd75AzhgSTua3?=
 =?us-ascii?Q?jG2kFc7zTRcf4kqRNDRTvGw/aEjavu20tYzwnWscguooy8aBJBz4MwfIy8ZG?=
 =?us-ascii?Q?sSAnM1AiRlvG060lXl5lRNI442ljlXpwGa5OzX2d8nxEOJxTQRqALlr9Slsv?=
 =?us-ascii?Q?njWI9khA0yVKj3RFSo9aZnZZydw/RjNHu7BUrgR+OcgZr0jiQ8GAy1exknEL?=
 =?us-ascii?Q?SUOGqw0cnSEws4uEY9H0myuJEQDTY6jf1Fs+PRkKbty/veQXV4wLldmPRT6r?=
 =?us-ascii?Q?+odkTQDDbbZE3asgwYgvoesR308S1PsKpHL1vrF7UyJA9PDUz+bzEuCtLoV1?=
 =?us-ascii?Q?P71ays8ZSKSJ7n0ZXlQrj0nMd5JACIzeR3NAPzsyzI2t5D5hIZ79lW4fV1ZC?=
 =?us-ascii?Q?eBOEA6mUr8RH7ByCOYf+NArKUYVd6vzj6YepNEjVKUP+L2zIol8ooNjY9aur?=
 =?us-ascii?Q?/5Ynx5Oai2qHT3h+ZzosJ4++/gAa2Z+rEP4JLW1h1/czeYv2sEEoYsS+YRI1?=
 =?us-ascii?Q?0AFxwPRiPwjAEGVjgdfROcw0fK/oTskmAmmJrtZ69TMv9oqea5JeNRx7EvEq?=
 =?us-ascii?Q?4FQqJDvjRI6q5lQrUYBNUTdxUIGhJPJnBekLT1zd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 998b8cc6-1ddc-4964-9448-08dcb5ea1036
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:33:28.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E67XdWLr4HhqRg8ifXDhWxW9RE6FDhkXZJKdEiPmLFn2MBKkSDatZY4JGQDFfDko5iZW9HjqBZ/Qt8pZ/Wn+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com

Hi Ming and all,

I met "BUG: slab-out-of-bounds in cxl_setup_parent_dport" problem in v6.10
kernel in cxl-test qemu environment:
https://lore.kernel.org/linux-cxl/ZrGFWYKwxa1ld9Iz@xpf.sh.intel.com/T/#u

And this patch could fix this problem.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Best Regards,
Thanks!

On 2024-08-06 at 04:15:47 +0000, Li Ming wrote:
> cxl_setup_parent_dport() needs to get RCH dport AER capability address
> from RCRB to disable AER interrupt. The function does not check if dport
> is RCH dport, it will get a wrong pci_host_bridge structure by dport_dev
> in VH case because dport_dev points to a pci device(RP or switch DSP)
> rather than a pci host bridge device.
> 
> Besides, cxl_setup_parent_dport() can exit simply if a RCH dport in the
> RCH topology created by cxl-test, in the case, the RCH dport's dport_dev
> is a platform device, and RCH dport with an available RCRB and AER
> Capability is not supported yet.
> 
> Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pci.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a663e7566c48..f8a3188f5b17 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,6 +4,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/platform_device.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> @@ -834,11 +835,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> -	struct pci_host_bridge *host_bridge;
>  
> -	host_bridge = to_pci_host_bridge(dport_dev);
> -	if (host_bridge->native_aer)
> -		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +	if (dev_is_platform(dport_dev))
> +		return;
> +
> +	if (dport->rch) {
> +		struct pci_host_bridge *host_bridge  = to_pci_host_bridge(dport_dev);
> +
> +		if (host_bridge->native_aer)
> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +	}
>  
>  	dport->reg_map.host = host;
>  	cxl_dport_map_regs(dport);
> -- 
> 2.40.1
> 
