Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC127EC80
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854165; cv=fail; b=E43myu2OIAmruolzExWQ6RI3kRO9owrauUraRqj7XRnnII/SgM1u2TOzIMvzH3ZgBztusDKfqvlilogjuGrd9xy+6jhPSsxDkKAaltOu21r0bArLu60tBd3Y42x+RIMabb/lm4j3J5TA0+14edGaem/7358FRRnKvAKL9YaUa0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854165; c=relaxed/simple;
	bh=zhQEJbW/4J3JrOSPWJ2zM5vXQVU+m4nLK868wfhcoks=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=E3Ks6wJR32XF1SUt7PP06YdcaM9Xqna/P7QcreEzYZqgWOtU0vhKfdTlxxHeLrx6UXUgwuTiEYA+ihrZ8PUZq0uVFUfOeo89DMC6FQnU1ywAOdXLC7s3k/S11q1GEQGzPCKMieuV88mBicjOcdibcj3GZ3vEAqcDQ8kgEaIFeTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a023TU9D; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a023TU9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770854163; x=1802390163;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zhQEJbW/4J3JrOSPWJ2zM5vXQVU+m4nLK868wfhcoks=;
  b=a023TU9DAVgorFv5gdZa6rbJ7Aq7VDFJNb3P/egYP7xb5HoH/u1AK1OP
   FmxLew4HOK6S7Vb6zltqgLVA+Aw1bLvhbJAmvZsP4EO8mJaNDhfj4IoBH
   9ZQYFmDnuyTrBbtrLuZohxKD9JRXVhfN9nsUJEPk0qBLc7jzQ2b7hYxfJ
   aHzhby1WLWtjzAqAr2H6XghltYm9UqPrZTIGzQHkeWJIcTQOJJFYd5rUd
   1l8uCAfKXuhG7+NoCKgjMj2lFcn/0p4eJj6TzLLvEgZ58/859Wx/zM8R9
   HeJNCke3RSXo/fm2tehXDC2N1dWIJojc3UWZT2SAi488JUIJSsupiGKqO
   A==;
X-CSE-ConnectionGUID: VjUKeiA0Twujxy/9Jhrqwg==
X-CSE-MsgGUID: THKwxCMmT7akjAVjpKqgMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89422917"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="89422917"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 15:56:02 -0800
X-CSE-ConnectionGUID: 0XVszDrMRF28iQ9AsfXTmQ==
X-CSE-MsgGUID: YIgJgC/QSU6xj0+ia782Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212431000"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 15:56:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 15:56:02 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 15:56:02 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 15:56:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh15UxBtUfKleX4vd5Wtl3IZjdD9JSKK0KXRj75p8vOjywzImWqqHicTfYteeW47ugcqhgNGiBmDddFWT3Grt1c394jYoAR7k29ift7nLsA1jIaHovEUKEgSveMXyLrwuYdyhQVoO9V2wPQkOAPtNivpR+prbFm3/6Q9xyIXTd/KNH6kKqesIiMn+43sqe5ynwl4NmF9R/ILH4VXo7myH2KeoKAduAxyZLeSqwIk+23MZeX61oxnzLmdw8hxUk9F8dgU3v1D3SbnHuHXNCkmelYw4fRGoCW/XPPUy+dGuX0mE+Y52cZZ1tAAyX2Kc0ZZs211W9asDHQp5SolaeQ68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libtnbLulEJIM/IeS3esUaLSbIMjU1ymQuuWg3ZUtv8=;
 b=JchH5QYQf/c9yy0javySMSKxD/+hJOmpjbJHsr2mu+LgcXnjvrniOv+SWqfZ2fXRUCYMZQDMUOSHWkV2Qhp5VK92pTWAmlsuF8VAFg5WbT+tePrrgt0rRIzue+q3vSvG1A9xLdyvocsQDSmZ2CJeV9qd1b0veFCYulqV9rVoRryqDY/TykzQG8FWIbqWHGiQjzWYwfVhIXALC6RZ9BSgi11Hi7ODVD+ceROzbJ/5QHqHXDzoEdKzHNtitON//qfE2WnInQvT0DZ+/x2U+olu7Hz6nOCFrLte/F57el3z5f0avLlh2cdzbcmN3Fb4y7ebcKJfvQgp4G8OGNTXxdq8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 23:55:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 23:55:59 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 15:55:57 -0800
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698d170d45750_8c3210044@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211232630.480509-3-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
 <20260211232630.480509-3-dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/3] cxl: Fix race of nvdimm_bus object when creating
 nvdimm objects
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 479310cb-ba7c-45c2-6b10-08de69c91a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2hlWWFrYkt5Z2xHcjJPMmVFbHo2cmtWZHYrZ0ZpSzQvSmdFRnF1dzZTc2E3?=
 =?utf-8?B?V1R1VU1wV0hvSlZwTHlidzUzc29qbWxtREY4UC9TRjUvdWZ6T3VxWDNSUzMr?=
 =?utf-8?B?UVBGV2dBWE1VN25LZUNnaVJiMWVJaTBiVEV0aDZxMzVIa3dsWGQ0dmRWSmJY?=
 =?utf-8?B?V1gyekgraWtHSkxCV2krRU1qYmN1ZE1lWEhWYTduSjZIRTJudFlMQUZ5aTlq?=
 =?utf-8?B?dTM2ZkorQjNPZzVqd3hJV2thTldNQTdYbkZycFd0NjRZejJVTEVaUHhYM0Ur?=
 =?utf-8?B?d2NSVGhHTkVwL1BkS2lDTEJtYUFmZEh3VjZ5ajVIUXVjRU5SRzdNMStJR1Jh?=
 =?utf-8?B?WG1DOExiZFFuWFh1bDhCTCtVTGJQTHVXMkF3bytQQ2U2UURGQ054cXl2Mnpy?=
 =?utf-8?B?K01XaWIyVm5iM2l0M3JwZWd4YmNTOHJJbGEzZzAxZkViaHlva3JKcVcxLzY5?=
 =?utf-8?B?Y3habUZpZ2w0cGVDNTZmS1JuZW5ybE5wck1leENWcVk3Wk02OVBJM1lrUklk?=
 =?utf-8?B?TkdIekIwLzdKdVNDbWJ0b3dyaEdCM2RhV0lXbGpJQ1kzN0hFVjFiSTVOTkhu?=
 =?utf-8?B?TXFPVmhlNnI0cGdjWW8zQlVraUExYVBpWjlqRUJDWlh3RTZ6N2ZwV2NCcFpx?=
 =?utf-8?B?NUtZSFV3eXhqbFNMeW45UFlPTy9lTUFJZXFtQnVNZ29GeWtrcXQyaFlGK2JE?=
 =?utf-8?B?amdwSVBtWU1kZXczcW5hOUk1RmRxbGpVVFFmK2xjUEtkNUdRUURsY1l4Z2dT?=
 =?utf-8?B?WkdobTFkaUlaLzkwOEZSVjE1V25ZU3VvOWFYQi9XbnBKMm8xdWtQcExnbjQ2?=
 =?utf-8?B?b3dLc2lqRmdOM1daOXNqaFY5ei9iVzVmWWlKRXBFNENVdDdUays2eXAwU3VO?=
 =?utf-8?B?dGhLakFqaVBDdk95Vkt1bERxZ0hxeWJlaGZja2Z1bzlpbmdJSnZSV0xwQU5I?=
 =?utf-8?B?bm5Ea2ttZUM4eGNGUDZ4aTV4MXBVQnVTcUtCMVBlNXp6RzZtM3ZtRk1uM0Ni?=
 =?utf-8?B?RE16bnhWd05rTHhucWttUmgyNEJaQ2ZSYWxSMXRuQ3BNcUZsRW9VN254OVNj?=
 =?utf-8?B?N0RXbVJFSjZUaDhjZE5lN0lMSDR3OTh3VnRkVzB3QUl4VEZnZnp6UFRxNGhz?=
 =?utf-8?B?RG14cEFrQnBrUS9uNytIZjhVcHNleGJ5UGhqU3VMRTlYMTY3RUdnMVpaTXYz?=
 =?utf-8?B?YTZVQ3Q0OFNaRExRck1tV3FnOEdUcUtKUFFJVU1VTExhZFVHdWNDM3JERnBC?=
 =?utf-8?B?b2ExSHJZTmhpZFJETzZheldaTWpkMzBuSEZ6dkxmcHdQdjdXeTQ0MCtvTTlx?=
 =?utf-8?B?a1kxbHNiZE96blRsVThwMGxDa2IySW42ZDJJRUtQQnEvM3pmSllCUnM3ZlVu?=
 =?utf-8?B?TU8rQTFpMjRlUjRUV1Jqa1JPOTZZSkJPd0M4OTM4NnVLTHB0Y1dMODU5a1hh?=
 =?utf-8?B?Q2J4QXFyNUs3M3I4VVdhUkNiKzBUTWo4R21WcWx6RGFtQlRUd2RKeG84bW44?=
 =?utf-8?B?cUdLaDJDMGJVUEV2Z0NiaXc2a2ZEWXoweXZLZWxOdXBCMFZiclA5bzEzQkdM?=
 =?utf-8?B?dkFNcVFTbTNKQlZBWnVUTm1CeTFEOStXckFJYVZrRGxkSXBXbUQ4cGpGZHJ6?=
 =?utf-8?B?L0RoSTVkZEs4a2tHWUVZY3RweEtBZmUzcW90eEdCUE9oRStnOW0xTmw5MmRL?=
 =?utf-8?B?cHlidVU0MU4rOFZwb2N4ZGJYOVl2TUUxYm5pbzBaTURSQjdPSUJ2bGZ5MGVF?=
 =?utf-8?B?R1FjVWhPc2UvRWNMTHZ6ZWZPRHM3UTl4cXlKc0g5Z3MyWkxGRXM0TnZReVdt?=
 =?utf-8?B?aFN4VElzbkVwcmJWMVRwd09ENURPM1ZWenQ0Q0Q1MHJSaXhFUG9mR0ozRUwz?=
 =?utf-8?B?Zkh6OGpHZjFNR0ZjVTNUSWFqL01rbUlILzhDcTlVMzN5NUE5SXZRNnAzR0hN?=
 =?utf-8?B?RGU3cFhzQW5qSTdYa1U2KzhIeFFraXNGQUFvdExkcmM4Q3hEZDFrNUlSOFQw?=
 =?utf-8?B?L3lNN3dJalcyNXAzV3NvVjFpUkFxTFNwWjdjZFMwVVJKNjMwKzBCQ3pZVjd3?=
 =?utf-8?B?b05VSmd5MmFhMnZnc3hvVm05bmxzaVdOLzZEWkh3aE1CdFNzTGIrK2hlWi9X?=
 =?utf-8?Q?TR0E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBCa2gyTFd4NDZxMmJmbFhDL2F1aGtCcXF1bGgzL0wxTVZBVE5wOUhQWWRD?=
 =?utf-8?B?TEtSMVVsdzEyN1JaQWIrUWFoaUpvNnBhRTBYMTBDZm92b1EvVHlxZXRSREth?=
 =?utf-8?B?L05KOU1OREEvbmtyYzUyY2NWK2xQYmdGSnhzSmNlWXF1dHJ1eWxSOTR6MndS?=
 =?utf-8?B?eUdMeUc4a3hmekVNM3JQODhLd3E0MTZ5cG50b2V3S3FuYVBDZnF6UG82YUgr?=
 =?utf-8?B?YnVCRzZrZ0RvTzNFSzh1OEJiMm9lS3RhTXNNK3ZQRXVxeVNYQStaWkMvZm5z?=
 =?utf-8?B?TG1IRlVsV28ydlU4OHdzK1dBOXZpY3lCbE0yQmYyWHBCeFpJck9kRlVpVkJK?=
 =?utf-8?B?bUhPRC9WS3A1ZU5iMnQ4eHZHSiszWkJCVUdoUVRUbUw4QWgxdWg5K0dUbElp?=
 =?utf-8?B?TngvcjBjcG9mSUhNcTFENytWNGhkR2wzcXN4VnhnUmRUMTVnYVVvcGFqaW9o?=
 =?utf-8?B?bmFPRmtnby9OVDAwL0lFeXc2ckhLTXlZNTZYL1grV3hjLy9rc2VFaFlNZTFX?=
 =?utf-8?B?dlNySkNCOTM5TmoxeWovTUhlUnVPVU1XM0FvclNMNjcxS3d5dW9qK1B0TUVH?=
 =?utf-8?B?a092YytJK21IOHFERzNoVkJZWnk1U1RsMEFIL3VXV1hndENDbTZwenFMQXdW?=
 =?utf-8?B?c2Uxd2J4eU5WRGZ1aDgrNHZzSDF1d24zM2dQUDMwOUdRTEtnTHcwWGFwODIr?=
 =?utf-8?B?R1JEczRoQ3Y4amUxVFlaUTVxSzVaMEZJOTBVYmo2VTBxWXpTZ3FYcndyQ3FI?=
 =?utf-8?B?RXcrMWp6QUZFZkNKeU9UNWhYenpsdlhMVXNuZHdCbXhmTm44UEYzYVB0d3p2?=
 =?utf-8?B?NFJDZmRldlFXL1NCTlFPZVB3SXBJekVSSnRaS1VYNUdHZjhPSzJTQVprY0Q0?=
 =?utf-8?B?a0RxNDJGMVVGa2huZmlXSC9xSFlyMXhyd1pFWldWNjJINkRKWENjNHRuM3po?=
 =?utf-8?B?RmRjRTZZeVNNTnhXYnB2MlI2NkNMSUs3c2VHLzB1cUJNdGZGV05rNGU2Vmxp?=
 =?utf-8?B?SWR2THRXODh4NVY5NzNUTTduV1dwK2NuNXJONjVHTUNyQUZ2b3Y5bE01bkpy?=
 =?utf-8?B?RnhtZlhneHhlUDdLVlNWdzR1TVQ0c0pJRlg5bHJrQ01TY0NFR2pvVXkyZUdo?=
 =?utf-8?B?RnVMKzJ2bmxqRXNYdjhieXBpaW1Mb2xzSFhTS3ZpNk8wQi9WQ0dMR0diOTlG?=
 =?utf-8?B?MVRJdVF0aElMTzlGRHljd3FzMlN0YWxMNFg4MndDcmFKUFMwU004UnhjajhT?=
 =?utf-8?B?dmxSK2RGTE8yUEV0NkduUzdKQ1ZhVVUrTmtDQ2J5QW9DbTh0dTFmYzRNQ1Rq?=
 =?utf-8?B?VTJvVDdEL01TT2IyaXNtMkFETzBZU1IzQ1JmenRzZDcxaFZyZ2RCWTJsNndN?=
 =?utf-8?B?RkM3R3dXVkgxOWpSK01aUUVjQ2NTejFkSVFiKzAyczNyUWNkV3hzME16cTd5?=
 =?utf-8?B?ZzBXdHN6TUJJUC85dHlQTWxiL29ENmg2c2VhUlJvVm1WMXl2TlFrWnRPQUZC?=
 =?utf-8?B?bzYyazRBUkJjNVg5RHJuUWM1V1M1Mi9URDhOMlpVU3FvSTBoK1h0VEVaSEZN?=
 =?utf-8?B?amc1NDJHMUlHNm1WVExDblQ5Z292NGh5c053eUR5UU5ZaTRLeDYzNVYzOWx6?=
 =?utf-8?B?cVZxVVlaa21BRkZ6THlnK1N0dktQZFQ4blZST3g1RXdFSmhqZFl4dTVudFlk?=
 =?utf-8?B?UkRCeFBCdVdiNDBCMFdTL1RFTml3TmVVSjNvUHNVcXovWDJQbTE5K25rczBz?=
 =?utf-8?B?UTJLRXpURFBDSEpia3hrZGl4eDRPUkhDaTZESnVYYVJna1BFaDZIU3oyUXFH?=
 =?utf-8?B?WTlYZlp6UXQzaExLWjhMcUwvY1JlOXNoZWRONWhWSGtiMFVjR0FYYU5UVldi?=
 =?utf-8?B?WVlWR3NLbE5DMUhnL1RGUkd3b3BJWUthR3d6T1VTNC9lQ0lWOUZsODgxNEkx?=
 =?utf-8?B?SjBjWDVncjYwdldicWNtTm9qSWM1N3V3MjNLTldmRlZyT3EvanBRbHNTL3cr?=
 =?utf-8?B?ZXhJM3BkQlFmWkZiZmxydkpoajNwdkZCOXBBcUVBckNpVnVTbWprbzBCenJy?=
 =?utf-8?B?UllobG5QZWsyZ1MxOUdmYVlHaFREQkt2cGp2cjZnakJBRVpHc0Fwb2h4MVZz?=
 =?utf-8?B?YWIzUWU5L29HYXNLenByOEN0Wjl3VVFRY0RFaW42UUlXbWFVWjM1eEJHRitp?=
 =?utf-8?B?TnNPckw0N1NYYXMwSVB6Y1lKbHBsbGtLN1hOQyswOHFVV0JnbXpGZDUzMzJH?=
 =?utf-8?B?dkFtbE9TN0JaV2p5YTlkWWM4N0gzT3pXcWNwa2VQZmxmVkw1LzJHeFRDNUdp?=
 =?utf-8?B?THFaTTN6N3J1bVdYRE5qNTdidEYxQjZFSG04OGNpNFJtS3pVeE1XckNHdTg1?=
 =?utf-8?Q?EI25Vs6njxYjdEzY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 479310cb-ba7c-45c2-6b10-08de69c91a66
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:55:59.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkBvR+FfBroQcNacy1X/EZV36ehDWu0kbooo0V55S9zVWl+uK0CIfjVMW7lDPGKmLpdYEssWEEGy8TlvQsBIhtACrQotsLgh8WEtzDRh9Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Found issue during running of cxl-translate.sh unit test. Adding a 3s
> sleep right before the test seems to make the issue reproduce fairly
> consistently. The cxl_translate module has dependency on cxl_acpi and
> causes orphaned nvdimm objects to reprobe after cxl_acpi is removed.
> The nvdimm_bus object is registered by the cxl_nvb object when
> cxl_acpi_probe() is called. With the nvdimm_bus object missing,
> __nd_device_register() will trigger NULL pointer dereference when
> accessing the dev->parent that points to &nvdimm_bus->dev.
> 

Please trim backtraces of useless info, something like:

 BUG: kernel NULL pointer dereference, address: 000000000000006c
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-19.fc42 08/12/2025
 Workqueue: cxl_port cxl_bus_rescan_queue [cxl_core]
 RIP: 0010:kobject_get+0xc/0x90
 Call Trace:
  <TASK>
  ? pm_runtime_init+0xb9/0xe0
  __nd_device_register.part.0+0x4d/0xc0 [libnvdimm]
  __nvdimm_create+0x206/0x290 [libnvdimm]
  cxl_nvdimm_probe+0x119/0x1d0 [cxl_pmem]
  cxl_bus_probe+0x1a/0x60 [cxl_core]
  really_probe+0xde/0x380
> 
> 1. Set probe_type of cxl_nvb to PROBE_FORCE_SYNCHRONOUS to ensure the
>    driver is probed synchronously when add_device() is called.
> 2. Add a check after add_device() for cxl_nvb to ensure the driver is
>    bound, which also means the nvdimm_bus object is registered.
> 3. Add a check in __nd_device_register() to avoid NULL pointer
>    dereference when nvdimm_bus is not registered.

This is not done in this patch and not needed.

>    Hold the uport_dev
>    lock of the cxl rootport to sychronize between cxl_acpi_probe() and
>    cxl_devm_cxl_add_nvdimm(). Also hold the cxl_nvb->dev lock to ensure
>    a consistent state of if the driver is bound (or not).
> 4. Add a check for nvdimm_bus in cxl_nvdimm_probe() to avoid accessing
>    without nvdimm_bus for unbound nvdimm object reprobes.

See below, I would have expected that deleting stale nvdimm devices
would also be part of this patch.

> 
> This fix also requies the commit that moves devm_cxl_add_nvdimm_bridge()
> from core/pmem.c to pmem.c.
> 
> Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pmem.c | 13 +++++++++++++
>  drivers/cxl/pmem.c      | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 50557d71a45f..f7f784047450 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -175,6 +175,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>  	if (!cxl_nvb)
>  		return -ENODEV;
>  
> +	/*
> +	 * Take the uport_dev lock to guard against race of nvdimm_bus object.
> +	 * cxl_acpi_probe() registers the nvdimm_bus and is done under the
> +	 * root port uport_dev lock.
> +	 *
> +	 * Take the cxl_nvb device lock to ensure that cxl_nvb driver is in a
> +	 * consistent state. And the driver registers nvdimm_bus.
> +	 */
> +	guard(device)(cxl_nvb->port->uport_dev);
> +	guard(device)(&cxl_nvb->dev);
> +	if (!cxl_nvb->nvdimm_bus)
> +		return -ENODEV;
> +
>  	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
>  	if (IS_ERR(cxl_nvd)) {
>  		rc = PTR_ERR(cxl_nvd);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 6f010b3cce44..0b200be1fd36 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -85,6 +85,15 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  	if (rc)
>  		goto err;
>  
> +	/* Ensure that cxl_nvb driver has been bound since it is synchronous. */
> +	device_lock(dev);
> +	if (!dev->driver) {
> +		device_unlock(dev);
> +		unregister_nvb(cxl_nvb);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	device_unlock(dev);

This can be a cxl_nvdimm_bridge_failed_attach() helper what uses
guard().

> +
>  	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
>  	if (rc)
>  		return ERR_PTR(rc);
> @@ -213,6 +222,9 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	struct nvdimm *nvdimm;
>  	int rc;
>  
> +	if (!cxl_nvb->nvdimm_bus)
> +		return -ENODEV;

If I understand the failure scenario correctly, this is racy. What keeps
nvdimm_bus valid for the duration of cxl_nvdimm probe?

This is why I think the cxl_nvdimm_bridge disable path needs to evacuate
all prior cxl_nvdimm objects that saw nvdimm_bus live at their
registration time.
