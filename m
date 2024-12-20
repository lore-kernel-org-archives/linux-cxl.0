Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C161C5CBC
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718958; cv=fail; b=ElXws1nb+uTAMCCj6mXfvL+/W0UlrEAkRxq8nwjNE2MA7rDXQBkxeGZsOz9qO0+ckiCvKMNYW5AXO0rJFHhrNAzzEL9ClN9hA+RxoJnXG2am1V872R14sABqlZhWAvNW3x15SvM6CZ1HwXC3jWcKSMd3ManqN8w+2+rE0avgM0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718958; c=relaxed/simple;
	bh=POEqR21SllP7pP2DfNCofFnKNxXJ0DkqoBepYA1aZpA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEF7zb6RQ8QHWEYenfA06GyKLLNcoGKErZF0sqq7D9+yIhu2TkpTK8fWYVgWIaM6nRuvRbjJywtMJCH2wC6gILJVw/Gwnk4sqXXGImGs5bkYfjXCe8P7ie5hm0e8WO6TwpvLFYJ9xObKwR4cMsjMe2aV/B51q06Rn7G0fhn06S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq68ZGq5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq68ZGq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734718955; x=1766254955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=POEqR21SllP7pP2DfNCofFnKNxXJ0DkqoBepYA1aZpA=;
  b=Bq68ZGq5BNzbCY68PH5MqjFyEVSzDsy81YnNIIm0XtxhB9T8AkZgeTKi
   bGS8N63i61tHixASMDDS/E/w38UD6EssxFg+y9RwfTrEpbctKxdP4R8VK
   j+22vPOiI0tubuITthFo1IxYA38qiqAerLAy36z+K0NHXfNXI0+7IVxgQ
   +oBBiSOA+nAjF0Nkx2N/oZtDS8ChbEj7//ORS2ANeq1vjDp+wBo7juZno
   yKEEv2WklPKVb35MsGZeIKxD8k6rsjIB9OkDoSR0ADmfu0GePuZBlMcNU
   /AK1AROHFxehoZoflwMCyQYkYYHycrOILeG/U0Hn3bF+YfcM/33pFywAb
   w==;
X-CSE-ConnectionGUID: Mjq3rEA3RCiN38T2Ah1YwQ==
X-CSE-MsgGUID: K8j63UvkScOy3vF8aINlpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46695720"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46695720"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 10:22:33 -0800
X-CSE-ConnectionGUID: QkBdjvDyQzi1c1jfUhJhhg==
X-CSE-MsgGUID: iqIAZEeZSdaUFPemVkPkJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="103553346"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 10:22:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 10:22:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 10:22:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 10:22:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd/Fk3NhMb7uyJVyn5FeelC4WSg07bHVdJ5C8Er3u4K1ZzayruaGe2dCsixVXQYTZqzd0CuHUlDVpjnmN2WXJ1scz8TIIb5h9mOU8gTp8/qYLnviHW8TFgjORkPgxw0EdRCAonF9vZAbrQJim0Y+Yu5kj1eQDmduNr1Z1n02IZH8J7Qb07xeDx/tpwvn8Z71zwkG+slDn2F1urxXz8/nZDJRXqUXY7JJ2jZQ0y0MX+Wt7vMjvXdqSGU1k1Qrrj4p1baYGL8izux4u7Edw88k7drp7Y5Kii8CTg6whxkorHNRx1pNUdWncXdnBS30v929thbJkt6RA05r1woUGl9vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B047aFpqX5zk6FW3bDcyig/vU58DW6gxqnxHnN3JFnI=;
 b=T6XuHaYrAklWNIwVgxl20eyEqHwn7r2UB1Vd7d0TXE5aOT1LvLCDRBNtqeQrsm9VEqrC9hlrVhO38ZqblpwvoMdc8B7u5DQ/0RIpnX5GAcTcWkXIrPQkmGqtQI1UyaJN/Yy9j0HDWgMlvNedBMFMDpP8moaoQef65+RyFTGacT76YG1hDElMp2B897+E9BDoQwd8BoAAImqf0fcnRRv+6V/kS9rjbJoWSTiOzroUfIsrX8rZqpm/bdi3p2PEhSXqAwyUnDqCfuRxNiOzQOQ2dVOA9Y6S3+Qd93bEKEh7XTmis+mD88blXbJ6VpDBJ+H1Azz44yBrPP2gfZa+2ekQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 18:22:02 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%7]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 18:22:02 +0000
Date: Fri, 20 Dec 2024 12:21:57 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<hch@infradead.org>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <6765b5c5560e5_2e2afc29467@iweiny-mobl.notmuch>
References: <20241220164337.204900-1-dave@stgolabs.net>
 <20241220164337.204900-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241220164337.204900-2-dave@stgolabs.net>
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|SJ0PR11MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 38887f8e-b0db-42ab-8c9d-08dd2123331b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ftMj/rWBJYzEwLtGfgV82EcQYoJiVvk0BPuBRlZqYncn+sFDrHGeQ3ADOO8?=
 =?us-ascii?Q?AMJhmJddrk7G/hhBZyujcKmKo6uLqw1bBZTUdicjLvPni37tMuGIhIgcsAP1?=
 =?us-ascii?Q?XI6zBEx7ZlDmvUKAvfv3WX2Jd/7kQWBFVKeVwpBd4Z/Md2UKmZa+1TbZdDhc?=
 =?us-ascii?Q?O3HxQ7Pg+XJ34voD8LKFXG+a+qH5heqd94i7/5Nn5MXmU8e2NvQl01sgbtB+?=
 =?us-ascii?Q?rx9x6Sv/yPXJNiZP2A5q05+yrjGznGVowftkq7NWBrI546B6SDBykMytxamv?=
 =?us-ascii?Q?Xr+fL56y/fexGQzlHon+a3YuzOwyUcBNE8sWVmR8ZvWiAR8E/Qy7PJDEWiw7?=
 =?us-ascii?Q?tgkwUBGa+L8VrK8fgxZeVm+IMZwy6HU7WkqI1goUwuJ2lZFuLZrrW2FT56+g?=
 =?us-ascii?Q?2ZSpMPrRM5hF5sR6X5WQ8SOeWCjg2OiArQyAe7eHHq0AK2EfsW/q2gh8aqAE?=
 =?us-ascii?Q?oi5q+cWHZCyOXHJypaZjAhwSQpqrdtPezN9rwhqAXtVYVV/OiIw3gcTlMKys?=
 =?us-ascii?Q?WFIhoAzMZpU43fN+sbDDp9YczQXZwF6yhlMtJz9ShdZWl1XKvCW9Vqzx0x6P?=
 =?us-ascii?Q?SiCG4aHjBzGjM9bjPSCo8yWt3SiRzoWZQIQXrWYO3hwCZvzb0Mos2guT++B2?=
 =?us-ascii?Q?C8IvmR1MllMnYA+VftptrjWCS1vsw83eRyvyhJo0/7p3UUFpz4Bpmxfonpdh?=
 =?us-ascii?Q?6k/2EY0osr8zQ+agnlw8Azqrh31YSjIcyiEIkR9G5WO5iueBpHJWbER6Xwwu?=
 =?us-ascii?Q?LW91X/dY5hrcP5GoRujRvpYTCjGA+axunN7GYObye+UhHmkDUEEO1Jz5s14F?=
 =?us-ascii?Q?/1AEvYYeIEh3wn/0bQ9CMGMspsmKX+Zg4jYg9n1AzfDli6ww/+P8MvM+rpiZ?=
 =?us-ascii?Q?cfi48fJCT/8Wrmo189ZZmg01zvpqfCU6+oYfTVxcawYR/CxrcWX9uQteOnCi?=
 =?us-ascii?Q?2QG7sZA0Nca9fEkxXVEVcKaO7eHj2aYTagnZnE5o+z6b6RHRU50IsE1xa9Ry?=
 =?us-ascii?Q?lOatT1QD7oMJH88cJAqDTNLXj2yp/mKaJhSLURqa381UmUDz2yRAlMxgvmg/?=
 =?us-ascii?Q?5eg05yvcJwDmCW7t6ARJ5KL70lydpG0tZYrk4FNHLp++ZLkmmgFGpQqZWl+g?=
 =?us-ascii?Q?lfo3aBbpmdEhcNd34xpMcqN+iQOgz4ddERrS/S9etR4hRZYgix1TLB891AT6?=
 =?us-ascii?Q?UoqLS2a6hQhw36W5Hf1vqqk7cfxWYmktKVl+GiZGpsasrjQh3f3q5MNqUNKG?=
 =?us-ascii?Q?kNEH7zpmnxglzbbzfYHddCQSwulFjmCk0xleVgVMM9cJgxNHJBOvn4oS397V?=
 =?us-ascii?Q?YVhiq6xt5VfoNO5ezGtYW0o7ge3UAlmHruOgsF8gyS3k/6o5KrFhnAYYkrxY?=
 =?us-ascii?Q?ZbnCWcMEZr1FNmVPx8XFKUTSET4S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enyEOM4taVGftNSYLvGqvic+lisi1mFOxBsNS6AGKG6QgBtBj6PxCHSM1Cy0?=
 =?us-ascii?Q?xa55g3dfH0RYsHfFWXdxNENJj5EmGQxxKb6OKvCQbLGrfqnj+D1u1Z6ELAu7?=
 =?us-ascii?Q?l+wQaEmIM3QNffFJLalfZTEUwylYOsskhbAQRG3YbuWQBry+P02lFbAfmDq7?=
 =?us-ascii?Q?Iy9UEYXKk+tGcv/MlpVI69tzKzHbJBuU86mYuR2r/OmZFYNGvSht+G7Me+57?=
 =?us-ascii?Q?dP+GxBnOxp35l2yqoKRPNnYu4Il2HYOlSnLV4ta1iU5qe/ffLmP9KhMmRGL6?=
 =?us-ascii?Q?ItCsH6KBjMrHhV/AqiB1eZGTQi7xT3BRTbe0PGfX04MCmxdm0tlqn13rwk6S?=
 =?us-ascii?Q?ihrTin83TDudIDxJsdkiOxVxz06yO02EHVLQSgjvvX04gzqfmjkQuJF0Oi6I?=
 =?us-ascii?Q?BKfsQU96WkGg5hWO6d6Ay2lr3iQW89dS/sKKgWdko0PHV/DJcxvLkWn4wPou?=
 =?us-ascii?Q?7+bex3X21lMaT0ch/QO6emW38VLfOpuwNhCPCYRfvWVt+uMoQdNxtHaDsogM?=
 =?us-ascii?Q?r+hOxuzDcvkQx+DkJY3IGmdPpcIBfAQn+jvfgq0mOEMLldajvanniLswxW6f?=
 =?us-ascii?Q?sPGnTzW5qEB/aEvc1oeVD6gen+DmjdHbbmy0Gc4c1GzxxX+DuDmcsNU9Sqqy?=
 =?us-ascii?Q?DfiDNWHmrkW9jLgnLeSa6W+iXzXpes7yvAjuBeVB9z899F2Nfxq5B4l1LqjF?=
 =?us-ascii?Q?cMRwI3KvAy7eyJ5JZoxQw+g+uzo5RKS48P6juDNMyIGblZ8m/qGhSnydByq3?=
 =?us-ascii?Q?D0ObxUMRx2KT0M/1zWIgZd51wObx9/m/BpUVsURkR+8DxnRAACQ8IokeXkxf?=
 =?us-ascii?Q?aodyx4FdEvBnb080T/RSKxi9cBExCZMSLNqo3C6v/M5kPCPNtT6NLq+XzFHp?=
 =?us-ascii?Q?t8O2OJOx7wkAo5HLEGdG9g4vOZtysIq+0ltp/Z51A+b/cdIpODN2GzGv1N7G?=
 =?us-ascii?Q?w4QO7tHQh4oWV8vlnfhYwbj8TcwCBqNX2VHcS0qPMWfwCDz8Lgq3wOhOYb7A?=
 =?us-ascii?Q?NqqiggKxBkgOT1hMsHZTMU9r3RL1Q6x5EilA+2Bksix+HxsBDSAPTPKDH7ho?=
 =?us-ascii?Q?FnYuE79R96NGlplxxVuLt2FCFCa6PGttn/WsEw8QyQy2SwUGA8tuMiwir+Mz?=
 =?us-ascii?Q?vnN56w/2M/TpXKIz0rYE7c3fu31WyCrMMTuHNjOvS+Sq5TXn+9fTgZgCrswG?=
 =?us-ascii?Q?kz437bSTwnRfHVfEQLHfIjbWMwBWvT3J20RnHYdmnggPH0P+pksTIXCzycWw?=
 =?us-ascii?Q?eliGp/3DabwYyGP+Z0iw0M3CQDC6QMrutlY+tCPnM5UxSoy3t2oxauSYy1UZ?=
 =?us-ascii?Q?+aE+t00rQ9nS0tals41bxYW6WEGiGFB4gtGUTYkFVzFOQDqkBiUxDuY0k+Bw?=
 =?us-ascii?Q?YeRVIU5RZXMi102Arnmld5JIvPB55Jq7gg99r/RHVtfSFcDyY60epskQ/ORx?=
 =?us-ascii?Q?fpugJQ8Tcmzsllgtu3Zvmp+8JVJBkJ2Qqyg+ljbcXW/CJNRxVJ0yBWDI9B6x?=
 =?us-ascii?Q?+J1s4xHsGVNMpdLDj+EDGDZCHxdkmTZvKTDlCrcUOwgkiPShN7ym4ukUN23Y?=
 =?us-ascii?Q?OqGEgWEvDqEoJdRTSUJ4fy7VWgmHjezfzUPdZv0Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38887f8e-b0db-42ab-8c9d-08dd2123331b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 18:22:02.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYWAk0zjSwQ03nKkk88wooYYYRK8xrBS7s3NdX+ZIWBsiTD3l0NMHK6U4MlV5qs3aikJN7vZx9ahqQxCfyg44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Timeout arming is done throughout the decode hierarchy, upon device
> probing and hot-remove. These timeouts can be over-specified,
> particularly T1. Set the max timeout to 20 seconds for T1, which is
> the NMI watchdog default for lockup detection. For T2, the policy
> is to use the largest device T2 available in the hierarchy.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

[snip]

>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d58ab9d33c5..9b1e110817f2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,107 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
> +			    struct cxl_memdev *cxlmd, bool remove)
> +{
> +	u16 ctrl;
> +	int port_t1_base, port_t1_scale;
> +	int port_t2_base, port_t2_scale;
> +	unsigned long device_tmo, port_tmo;
> +	int rc, dvsec;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	dvsec = pci_find_dvsec_capability(
> +		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PORT_GPF);
> +	if (!dvsec) {
> +		dev_warn(&pdev->dev,
> +			 "GPF Port DVSEC not present\n");
> +		return -EINVAL;
> +	}
> +
> +	/* check for t1 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t1_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				 ctrl);
> +	port_t1_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				  ctrl);
> +	if (port_t1_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 1 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Set max timeout such that vendors will optimize GPF flow to
> +	 * avoid the implied worst-case scenario delays.
> +	 */
> +	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);

What is '7' here?  Seems like another define would be good.

> +	port_tmo = gpf_timeout_us(port_t1_base, port_t1_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 1 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				   7);

And use it here...

> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				   GPF_TIMEOUT_SCALE_MAX);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 1 timeout: %lu us\n", device_tmo);
> +	}
> +
> +	/* check for t2 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t2_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +			    ctrl);
> +	port_t2_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +			     ctrl);
> +	if (port_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 2 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	device_tmo = gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale);
> +	port_tmo = gpf_timeout_us(port_t2_base, port_t2_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 2 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +				   mds->gpf.t2_base);
> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +				   mds->gpf.t2_scale);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 2 timeout: %lu us\n", device_tmo);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_update_gpf_port, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..0bd09669af68 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1370,6 +1370,73 @@ static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
>  	return port;
>  }
>  
> +static void delete_update_gpf(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_memdev *max_cxlmd = NULL;
> +	struct cxl_memdev_state *mds;
> +	struct cxl_ep *ep;
> +	unsigned long index;
> +
> +	/* first calculate the new max T2 timeout */
> +	xa_for_each(&parent_port->endpoints, index, ep) {
> +		struct cxl_memdev *this_cxlmd;
> +		struct cxl_memdev_state *max_mds;
> +
> +		this_cxlmd = to_cxl_memdev(ep->ep);
> +		if (cxlmd == this_cxlmd) /* ignore self */
> +			continue;
> +		if (!max_cxlmd) {
> +			max_cxlmd = this_cxlmd;
> +			continue;
> +		}
> +
> +		mds = to_cxl_memdev_state(this_cxlmd->cxlds);
> +		max_mds = to_cxl_memdev_state(max_cxlmd->cxlds);
> +
> +		if (gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale) >
> +		    gpf_timeout_us(max_mds->gpf.t2_base, max_mds->gpf.t2_scale))
> +			max_cxlmd = this_cxlmd;
> +	}
> +
> +	if (!max_cxlmd) /* no other devices */
> +		goto clean_shutdown;
> +
> +	while (1) {
> +		struct cxl_dport *dport;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +		xa_for_each(&parent_port->dports, index, dport) {

Does this set the dports for all ports on a switch?  Is that the
intention?

> +			if (!dev_is_pci(dport->dport_dev))
> +				continue;
> +
> +			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
> +						max_cxlmd, true);
> +		}
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		port = parent_port;
> +	}
> +
> +clean_shutdown:
> +	/*
> +	 * Device can still dirty the shutdown upon detecting any
> +	 * failed internal flush.
> +	 */
> +	if (resource_size(&cxlmd->cxlds->pmem_res)) {
> +		mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		if (mds->dirtied_shutdown) {
> +			if (cxl_set_shutdown_state(mds, false))
> +				dev_warn(&cxlmd->dev,
> +					 "could not clean Shutdown state");
> +		}
> +	}
> +}
> +
>  /*
>   * All users of grandparent() are using it to walk PCIe-like switch port
>   * hierarchy. A PCIe switch is comprised of a bridge device representing the
> @@ -1400,6 +1467,7 @@ static void delete_endpoint(void *data)
>  	struct device *host = endpoint_host(endpoint);
>  
>  	scoped_guard(device, host) {
> +		delete_update_gpf(cxlmd);
>  		if (host->driver && !endpoint->dead) {
>  			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
>  			devm_release_action(host, cxl_unlink_uport, endpoint);

[snip]

> @@ -129,4 +140,57 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static inline unsigned long gpf_timeout_us(int base, int scale)
> +{
> +	unsigned long tmo, others;
> +
> +	switch (scale) {
> +	case 0: /* 1 us */
> +		tmo = 1;
> +		break;
> +	case 1: /* 10 us */
> +		tmo = 10UL;
> +		break;
> +	case 2: /* 100 us */
> +		tmo = 100UL;
> +		break;
> +	case 3: /* 1 ms */
> +		tmo = 1000UL;
> +		break;
> +	case 4: /* 10 ms */
> +		tmo = 10000UL;
> +		break;
> +	case 5: /* 100 ms */
> +		tmo = 100000UL;
> +		break;
> +	case 6: /* 1 s */
> +		tmo = 1000000UL;
> +		break;
> +	case GPF_TIMEOUT_SCALE_MAX:
> +		tmo = 10000000UL;
> +		break;
> +	default:
> +		tmo = 0;
> +		break;
> +	}
> +
> +	tmo *= base;
> +	/*
> +	 * The spec is over involved. Do not account for any ad-hoc
> +	 * host delays. Ie: propagation delay, host-side processing
> +	 * delays, and any other  host/system-specific delays.
> +	 */
> +	others = 0;
> +	tmo += others;
> +
> +	/*
> +	 * Limit max timeout to 20 seconds (per phase), which is
> +	 * already the default for the nmi watchdog.
> +	 */
> +	return min(20000000UL, tmo);
> +}
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..37d5616b6fc8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,101 @@ static struct attribute_group cxl_rcd_group = {
>  };
>  __ATTRIBUTE_GROUPS(cxl_rcd);
>  
> +
> +static int cxl_gpf_setup(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *port;
> +	int rc, gpf_dvsec;
> +	u16 duration;
> +	u32 power;
> +	int device_t2_base, device_t2_scale;
> +
> +	/* get the timeouts for phase 2, given by the hardware */
> +	gpf_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					      CXL_DVSEC_DEVICE_GPF);
> +	if (!gpf_dvsec) {
> +		dev_warn(&pdev->dev,
> +			 "GPF Device DVSEC not present\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = pci_read_config_word(
> +		pdev,
> +		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET,
> +		&duration);
> +	if (rc)
> +		return rc;
> +
> +	device_t2_base = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK,
> +			    duration);
> +	device_t2_scale = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK,
> +			     duration);
> +	if (device_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid device timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	/* cache device GPF timeout and power consumption for phase 2 */
> +	mds->gpf.t2_base = device_t2_base;
> +	mds->gpf.t2_scale = device_t2_scale;
> +
> +	rc = pci_read_config_dword(
> +		pdev,
> +		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET,
> +		&power);
> +	if (rc)
> +		return rc;
> +
> +	mds->gpf.power_mwatts = power;
> +
> +	dev_dbg(&pdev->dev, "Device GPF timeout: %lu us (power needed: %dmW)\n",
> +		gpf_timeout_us(device_t2_base, device_t2_scale),
> +		mds->gpf.power_mwatts);
> +
> +	/* iterate up the hierarchy updating max port timeouts where necessary */
> +	port = cxlmd->endpoint;
> +	while (1) {
> +		struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +		struct cxl_dport *dport;
> +		unsigned long index;
> +
> +		device_lock(&parent_port->dev);
> +		xa_for_each(&parent_port->dports, index, dport) {
> +			if (!dev_is_pci(dport->dport_dev))
> +				continue;
> +
> +			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
> +						cxlmd, false);
> +		}
> +		device_unlock(&parent_port->dev);
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		port = parent_port;
> +	}
> +
> +	/*
> +	 * Set dirty shutdown now, with the expectation that the device
> +	 * clear it upon a successful GPF flow. The exception to this
> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
> +	 *
> +	 * XXX: For non-fail scenarios, this is cleared by the driver
> +	 * at hot-unplug. But, what about reboot/shutdown case? Is this
> +	 * done by hw if no data integrity failure is detected?

Does this path execute on reboot/shutdown as part of delete_endpoint()?

Ira

> +	 */
> +	if (resource_size(&cxlds->pmem_res)) {
> +		rc = cxl_set_shutdown_state(mds, true);
> +		if (!rc)
> +			mds->dirtied_shutdown = true;
> +	}
> +
> +	return rc;
> +}
> +

[snip]
