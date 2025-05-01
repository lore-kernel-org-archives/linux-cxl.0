Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787620C461
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746077364; cv=fail; b=gSZ4hyOz5eD+JgYlV8U08h9Y5npu3oP3U9zxA+2aNSIdo85LRWiJwMJ3n0TJ+emqM4wDmqAudz3bfeXTMRIrwEj/UIyGsjC0m4XeVs7Jsqijd9FFUnQ4qN4dVH1hri8UtBUC8OQt79X4ZyLnsEkvbG4F4vEJITSKwTa7bXOkEeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746077364; c=relaxed/simple;
	bh=8vdHWc1UkF4r3pi32PrVHLayOiXyqPlgUPRuwIA/7lk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=q76EnSnFJvaARrQdy1dSp2Bt9R+EefCPfBKfp9ZNCX89j8gQUxefZgWGA4kZJNR3cO1Tk6fuiYad3TXGtuRHATuJ8lphhgL9P2ofcfB/Qsj3OsocYcPjrDmXoGnfA+05EEKjdl67YKDb+FMTrw6057W9ncY/3kGqEY1L8qI/bZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaPKEQSU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaPKEQSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746077362; x=1777613362;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8vdHWc1UkF4r3pi32PrVHLayOiXyqPlgUPRuwIA/7lk=;
  b=QaPKEQSUkStUO9/Ygm3ccP6othBt2P50MQRsStcPEp++Yeg97/PHAUPv
   9VFCMQcVptPU8Jrw7Mt+crGUPQFW6P0i+d2uRIp+1TQfUUbY5WxSSrMNo
   Vibiv7SEP9g4YkPGPF9rIP331PKiPSavzf5kQFREDsd2FvJrLo7YlnOor
   mMcwtD3QW/4uJ2+FDCzL2usfjnrtWoi1Q1IuuVulg+G6DUIgQPPzEXKql
   OxEe4wLQjfi72izQMBjW/J3uyCBqRv/KE5rmXEiI2dcemmKmVn9AgAcSR
   u88DI2f/OUPcYV1ZuTm8+DQbPhpU8SbTxkUGBj7nLimK1Rwa+DZysVEE1
   w==;
X-CSE-ConnectionGUID: WmFWr1HBSFKovt1LgJ8H8w==
X-CSE-MsgGUID: mWYlGkh5SDWk6HmH8Z6K+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47628345"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="47628345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 22:29:21 -0700
X-CSE-ConnectionGUID: zXUZSAEvQ6qUobQkiz37FQ==
X-CSE-MsgGUID: Xg5dHIztTmmMLcAP692Iiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="139126986"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 22:29:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:29:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:29:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIeqGtg7XYhhK0KZVX5QPHY5/wLl9Hj9yjKYkVOTyEAUm71yR7nVIxS+sIetH/VwI+YEJTuxg+5Pb9Kp28I8aEmEM3mSPK4RYjv0MZ32Uz5yL1C2GvyBsNwpTSfE2D7a+8KF87kNAeQJ1DfJx1JkGip48M0nr6Bni7ArJwR2+4GFHoDatQRkevvUd0Fs4t5Zipubrf/gzuGorfwVJoFUlVT4m7LM29Eo+Fv+lhM3QmEISb6LM3eTpPkNuxqxqgKCvaZPXw702R/rY7RwyYjdM0MVlOrA6vKThKIrb3LhlilrO8j2HRvHnYSsFd/ozeyHED5qnOXMP4B/n95G5kUVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljVIYBC2J9a2qxaAPsJyge2b9Qyd54XChnyi+JUcJug=;
 b=CdS1YrqoGwg0JsKGIdznq85i8JV+wu2whx5sGuxA0P8qwHOYdJzuDoteM6n5ec8+Deq4ifA467YQtu+fvWUmHin6mAZjB6nzsgvdp1mX/+bnsPKyKCfzrNDGnEuYuSDNVsATCqacb8VmgQ7M7bS1+INNLko1Vz4xekOI207+d0AeAfOy5Pzq5C5TuWeqZgO1/S7HOR3G0iniit6kxMkHdXmyLNsEhtEC8IfdjgaUSg55XsZYidwlo6vRu3R3iYAzZfzM7UinI46EsU74LhJKIL4WOEEbgErjGZH/5T5AEWQXR1jD38V2gCbAaMvRke/rPFNH9aVW2Q7p/bR5uYXdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 05:29:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 05:29:17 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 30 Apr 2025 22:29:15 -0700
To: Li Ming <ming.li@zohomail.com>, Dave Jiang <dave.jiang@intel.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <681306aba4219_29cd5100c3@dwillia2-mobl4.notmuch>
In-Reply-To: <9516517f-9d04-423b-bcd0-123a76598c06@zohomail.com>
References: <20250430213653.1904302-1-dave.jiang@intel.com>
 <9516517f-9d04-423b-bcd0-123a76598c06@zohomail.com>
Subject: Re: [PATCH] cxl/region: Add decoder check to check_commit_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:a03:167::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: e24ca637-fd10-42d7-f166-08dd88711dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUdrLzdJb0hPcWsrUCtuMC9QVGh2clZwck84S3hlY1Nvb3EvUkcvWEFrTy9L?=
 =?utf-8?B?L09pRnhET3pBcTVwSUZac3lybGFVeGs4eFNhUXM5alBIWnhpT3RpQzFHVUpz?=
 =?utf-8?B?elpyWkdHaE9jMklmNEtaTzIzWWZYM1h2K3JvdjJIZ3FPdHJhRTM1eWdkSlk0?=
 =?utf-8?B?UVJBOWVOOHp6NXRFdzYwU21mOXRVS0l1bTV0QWhqSklvYVY5cUIxd1NjOC9t?=
 =?utf-8?B?VURtTzVFY0pjd2lkL2JrSjdqTEtOWWU5MmtXRkV4bVp3cmszbWxTaDRPZDJK?=
 =?utf-8?B?UmFXS2FSVE5lTUovSU5vazhsQk9uUndmQnluNnlZU2VwUUQ1ZjFWS1RwRml3?=
 =?utf-8?B?aHJrbTErckpZSUhPbzZudXFPY3JzdHNlVVFBS1BPc3psOFdxWTBkY2U4M3lZ?=
 =?utf-8?B?LzQ4Uzl0c1BZbGNIdUVaVmdnWFRiMXlQUlp2WEhIYU1EeG5WMlR6SXBQa3JY?=
 =?utf-8?B?ZWtLbDJEa091cVhYWERoQVo5UEtTcncybHZLZ29jaWlDL2wzbUVJWFJxMFVl?=
 =?utf-8?B?SkgzS0RScFlxNDM0YTR3N0ZRVUU5YmUwMVRIZ2tobm91NzdqdUh6OHJYcytU?=
 =?utf-8?B?VEQwenNIcHNNUTBDbVdXVHYvSS9NSHpEZ0pPYjJRejFGMUIwQ3o0Z3l1STRZ?=
 =?utf-8?B?enhuZ2dtd2E1UXJxei9wZ05oY0g5Y3dnRmdhZXREV0xoaEhFcHVNQm1kbkg2?=
 =?utf-8?B?U0IzWE5xZDlpQ0hTZTBTYUxVUDB4T0N2SmwxS3dWOFFHbFl6OHdHLzJMYzhW?=
 =?utf-8?B?WXhrQzlMSmdhMVlsandaQmFJRWlaVnBiWFhnVFU5M3FDdzVlTkNwZGdoRldV?=
 =?utf-8?B?Y1gyNXZYUTBhQ2N3c1VKaHJvT1VnYk5PRmpBM0tlOTc4L2xhVUlESjJsRy9Z?=
 =?utf-8?B?ZDVaK1JHL3lmeVNBOEg3T2k1YTJoMmNFaHg3U2NMWUluNXZrS0hjSEc4SkRw?=
 =?utf-8?B?RUh1SWY1K1Q0aFJwb1g0OUs0dytZazVNM1UyMEE0TlIzMCtTcG1ROXlwTlRP?=
 =?utf-8?B?UG9xQzhtTDh2cDYwS1g4VVJNSFE1TnlVeFBSaVMzVWJtZlhnbk9YRU1HREJN?=
 =?utf-8?B?amIvM0dkT2tiVHU2QWtMQUg0WkMxdzRkeXRIbGRQUHFzV3pUSFN3ditNTVJn?=
 =?utf-8?B?SmF6UDdGbmtIaW1tZGh3MExDSm5jV3lPUVR5TGNoK3padVRldENMbU45Mlpy?=
 =?utf-8?B?dFFmT3RnWkR4eEVXZExaTHFQcjB6dXpUdnhBelRadGFFWVhNdzNJaWlYamY1?=
 =?utf-8?B?eVBmQit5c2xjcDY1cjFtRklmS0J0aWw3R3k4V2VNbUpseFJXYXJoTTJ1ak9n?=
 =?utf-8?B?NDhUL3cyNUpja3R5L2lhUVZ6a0dNYlNpRHpjWlFNcXBCZWNXWXNwcUVURVps?=
 =?utf-8?B?RW1uUVp0UzQ0VTQycEJmYzM2a3h3Wm1HaWk0T3pzaVZ1akhndjF0eE03RnhR?=
 =?utf-8?B?dWhGNlpNbU1BQnJkNFBYTzkxcTR4WmlmWU43RXFWZG9nV29nZzRzb2RRdzZk?=
 =?utf-8?B?M0JLTklJYjQvbEhUdXJmWVVmM25UbkRjRm1RczY5bWZyTEg0SGVjd3B2ak5G?=
 =?utf-8?B?WHBFSGUxdlIrRUY2RHBzRTBhREtTeDhHd1FUMkxYU1pDY2JMd1grWWZEcjYx?=
 =?utf-8?B?Y1lVaUVPTFpzMVBLdzVJejJtc1J1Qmc4L2RhcFBSb2NISSs2NFp4dFBCWVdr?=
 =?utf-8?B?M0I4Tm1ENmp4dkViVnkxcHRicjJaTWQ5MWxaKzYvTW9iVXBKU3M3VkJUc2FS?=
 =?utf-8?B?VVJXeXBoeUU4ZmtieG5kUElrQzczZ2Z1MlA2ZDk3UkFaaGtsN2hzZzBFcW9a?=
 =?utf-8?B?Ukg5cXR5WUlZU0RSNlFEaHJid0t2eW5PMUJUM2FONnlNOTFmVHF2a041K0hQ?=
 =?utf-8?B?YmEwS2RpL3NiUnlFakRzM1hNZEI1VDhabitadXdMcFYvMVdCNWQyZ2xuMW5P?=
 =?utf-8?Q?JA47Z/y9vKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGs5bWV0TEpnU2FsRDkyRjFhLzZiM0ovTWNicERZRWRRdHgrZzUxKzhJcC9I?=
 =?utf-8?B?aTRzNngzU2JYbXUranU3SjZRNzZUVTFNQkppeXhwWnJyblVJaGxna29CQW5o?=
 =?utf-8?B?S21jRkZCZ25jb1JNMmJHeDBWdFd1UHQxb1Y4M3lUTDBSMUsxK1IrK1d4Vnls?=
 =?utf-8?B?amkvVkUrdWRqcnZCSFRFV1g1VHk2alVlYmJFZXo4aFV3L2FhdzV1UHZmNVRk?=
 =?utf-8?B?clRIaVg5RXE0ZEtXeHdzK3hIOXZ6T2xrU3VxOWR1MU4vSXBQeGdNWGJ3YS85?=
 =?utf-8?B?T3ZqRThqZ0RIQnJtb242MDRicTloN2FJYVN1aWYzMXhsRFhyMStZVnRtOHp6?=
 =?utf-8?B?N21KbVhBcUF3emhGTlk4azNFWmM2MmVYZVlaak84NzUyMzl6akNZU1VmQlVt?=
 =?utf-8?B?QXVhS290a1NMUjcyWHcxc282emVKSGxZQlZnYVlEMzhCWVpRVXh5MXNHYzAx?=
 =?utf-8?B?cUhrSVB2Y2tKL0RMSHA5L0xabXVpR0tzZlIrbW9iOWZGdXZUZTN3MFpZM0dJ?=
 =?utf-8?B?b1BzRWd5TTlCcUoySWpyaHhRK3FNWEZPaCtkTVYrQWduK0VOQ1NSWXVGVGds?=
 =?utf-8?B?Rm1jazB6dFdiM1pTZEFrL1orV1lOdVl6NFVYcWZ4V2oxcFVBMEtnVkM2aGVN?=
 =?utf-8?B?M0xLeW1QZGo2Q0Zpb1VDL1RSN1ExVXV2WnIzeE82amJiVllBV3Vrb0l6b2g2?=
 =?utf-8?B?c2JnUHUwTW5LL3NpVDBGbENVRGo3ajhYRFAxZjRxVm1iM2gyc0loZzNJcWw3?=
 =?utf-8?B?WjZ3bDdJTTAxRmRiTCszYVlVcUtwaWVDYjdoQkpUNTg5bTlkaVhURkVocHRx?=
 =?utf-8?B?UUtHTzBOKzYzQ09kWWY5RU5ZQlhNNVd0SzlhZG01TXhBclIvR0VacTJwWHRv?=
 =?utf-8?B?SlhuQkNtMnVZMHJUZTVQMHRLNDQyR21PU0hZeFZ2bGplM3RsVHdsckVBQlhz?=
 =?utf-8?B?RHJzMEt2WUJQYkJjYUlydWRQQzJhUVR6SDBJa0Nvdm1VMXdZQ29zbGp3M3pM?=
 =?utf-8?B?cEFJeExoSXI1WEpiL2sxbzcyWkFTbUVTbnBTd2VTUFZncXNGMkxRRmFYbWx6?=
 =?utf-8?B?MjJxZ0E3RDd4UTgxMVdCNHVCVnU4cDNuTzhwMkdTb0FkSGdVbnVOQkNEaFJ1?=
 =?utf-8?B?YWFuWkwyeE5NaXRCZ0RUSlNEK1MvL3A4cWJtQjREU2pqZnhRa2hPd0IvMXBL?=
 =?utf-8?B?d2syTTR6b0hGK1IrNHpqYkR2Tlg5Y1RRSnExM1NBVGVhQVVEdndUK2c5dkhK?=
 =?utf-8?B?OVlHNVFxcUk3Sm0vSE9oaUMzVFcxV25VYXlzVTg3VmRjZWg3VStJRTF3RWdE?=
 =?utf-8?B?SXBKUnRDWHcyTGE1WVVmcHliQjdnMkdLMzlVWmFSRVhxUHNJTVhVa0VSOWpi?=
 =?utf-8?B?Unc1c0R5YVpXKy9hcEg0dFQ4TDF1L1JPZ1J0VVU5MkpjWjZRSWk1NlNZMWtU?=
 =?utf-8?B?RG9ZMjF2cHg4MzlZd045Tlh3Ny9zei9lcTBPTStPRFhQM0xBVWt6U3JGdTdH?=
 =?utf-8?B?aHNUdGpELzAyQldGYzlFa3Njb0VmR2w1dU1oYWpYaUJJcHA1ZE9wS0Z6ZEEv?=
 =?utf-8?B?U1VWWCtsU0w4dEFSYlMxTDROS3hCTkdjRTJsU3dDU2JxdDAxUVBSaCtzTWY2?=
 =?utf-8?B?MjByWEZmQ3ZQUzVnNHQzeTFrMWhmb3IvM1hzRFZOM2FiMkRoblRhWkJmQU1L?=
 =?utf-8?B?MHRpWCsyZ01OYTc3M3c5TGZ3akJBRjI3eU53U3FhTkxxNEh0bXJhdkdpZWNB?=
 =?utf-8?B?WXdOMlhWYUJIa1RFeThqNHVGQlRwZm4yQWh3OEREcmZUc1BtQXRjQzBsMkFl?=
 =?utf-8?B?RWxuSXAyaWhrelBFUHFLT29kbHJiMmpyWjQxWVhHN2g1dTdyNFN6c29jMitS?=
 =?utf-8?B?ZHZNWjlGc2xlL3oxcWtJaGVydGxvNWwyUS85TkJ0OHZ2cTBIQTg4YTVYKzd3?=
 =?utf-8?B?MkNseWc2MWYxUGx5S05DbVZRbXcwTmMrOGJGSS9YUUZUcEJTQXhEbjUxeGF3?=
 =?utf-8?B?ZFFrNmpOVXNjdkY2SlRPaksrM0x2bTRELzJhOVZMaEV5MUx6NFh2T3lLTStY?=
 =?utf-8?B?YmI3M2lOdEtKVGZtamo5aFBZSDJxZVlqYXRveVFUcVB1RDR6RG9jYnQySDdy?=
 =?utf-8?B?SE5RRm5kcjExRFY0MU50N2VKSzZCNVpuTzRkZXRUSFduTHpEOG5LZk1jZ3lG?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e24ca637-fd10-42d7-f166-08dd88711dc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 05:29:17.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2EBNJTaLLWCsmy2Elq5GHdcyCy7JPGiEd8ngWYt3hOD/VuKAogdZ1rBhtgG3MZF7VwUrB7FIa322TbtmHZgWBVGn/msfS3zYGngFWiRrYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com

Li Ming wrote:
> On 5/1/2025 5:36 AM, Dave Jiang wrote:
> > check_commit_order() attempts to convert a device to a decoder without
> > making sure the device is a decoder. So far this has been working due
> > to pure luck. Issue discovered while doing deferred dport probing when
> > child ports are now in the midst of decoders due to ordering change
> > of child port additions. Add a check before attempting to do decoder
> > conversion.
> >
> > Fixes: 105b6235ad0f ("cxl/port: Prevent out-of-order decoder allocation")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> I also have a patch for this issue during I worked on deferred dport probing.
> 
> https://lore.kernel.org/linux-cxl/20250107035708.1134954-4-ming.li@zohomail.com/
> 
> I am not sure if we should define it as a bug, my understanding is
> that it will never happen with current implementation, it only happens
> when we are trying to delay the switch decoders initialization.

Agree. This is not a fix. The current implementation is lucky that ports
are always registered after decoders. So there is zero exposure to this
issue for current kernels.

Dave, please just include this as a prep patch in the same series that
invalidates the port child device ordering assumption.
