Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA42820C6
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209205; cv=fail; b=ohLDmT9nO1EcocGeYv30WduCGFd3ocKDJZRhyNzhnRY4YAsnpr+bBISKHdcS0UgXxDFvnbkSAq+CmSBZv4CT1FHyTGVuKtYXTVLwROJGtENfHW/exeVt6hpF3Ru7JbJdDcHQd8+n8DdJkQP1M/HCPYjFH5jDSYtm86NJGjGBwHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209205; c=relaxed/simple;
	bh=A4oAofMK4I4XpaQFP3kNm87a+NYHXOvibbtQwqhXhE0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GO97jgeQ6wSBy9ujNDC1uZgHBqcboq64MWBnJ4taz2vFOL9wDWTZ46fzHXBYPYNcF9V5sO4kmtNooJGDtsWKBAxAfdiYjTpfAWBXbvilIllDbo+hsGFSCvrZ3Ly6o6H3Wq2fuNlictMQTmJYKwcswL2MTSq8GCpthmET1ZLvjfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP4EO+nX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP4EO+nX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753209203; x=1784745203;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=A4oAofMK4I4XpaQFP3kNm87a+NYHXOvibbtQwqhXhE0=;
  b=LP4EO+nXlc6ttQGaZul3e44l/BJvs5c038jcF2JnGAWGBZIrOCECohkZ
   cc7u+sU9UnXd3KEXWbUSXi+OBkLBuHWZ5ysGw+XBCT8PIs7F5pjha1QYK
   ZCyq+sEEhNj577+tslMtzMDNSAiriktvChKhuLzyYdeVqjzt3Y63nQyPz
   7pDhOahkd+m2W7haMfpATXzzUWhqtH3CgHvF+LT67YZ1ISBIxu+kxdWZx
   xnB/FgkBmXUjceIj/+QXZBmGYdfnuy4RIIVVX1vN6X3wPnBKI31yvUi6O
   h9nWAWmVhSLt8BtQOndeZzXF0tgR01FP3Awl45LC2jFuPevmZiKx4UNJx
   g==;
X-CSE-ConnectionGUID: 7a5wKIXETnGqGzXqkDeqMA==
X-CSE-MsgGUID: Gykcof7GQ9aTLE9WBfplbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58090695"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58090695"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:33:22 -0700
X-CSE-ConnectionGUID: oU6lOQ4uQDCwc/2mI/GKrQ==
X-CSE-MsgGUID: R65Kof7EQLC3t6+sN5tiBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158982207"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:33:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:33:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 11:33:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+RsAHPKfGV5uIG8Va78EQHnzo6JqSFbrG1zX4dF+1nCm9aaFvKzzwXmFhCYlnux3aPeN8JxY6eF9eDi6RHQrdEDVQTe6UWOOmMxEpKruebGBMhmjNmWSGDGF6kFke+46xCGFRWc6ax4Fmb8PTTffzRjtKkeX8QjY55IRbJOT/AQ7HGBj+PO8BvtgXRiz70yb6RzQYKOg4fMvd275u+w0bpvyqFPomelCrjqvWB7+wi5Edc/HNslonubfuq7dx+RrMyDGiQBE6AsjKOiv4YOhujPv2Bt+fAEv0Hb4SnGxaxula+/n8ekGuRKQHKgYCsFibrmwbYR796PhpJwXhQlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4oAofMK4I4XpaQFP3kNm87a+NYHXOvibbtQwqhXhE0=;
 b=Dyt8K7WfGYRQT7KGu534pIvG3g2mKMZXYE62b3mRcRmT1DgMkJX+aG9IOSALgJSoDUGNHI1JiqCyaTUIS52n9sBghxIj+7zVKlW+Ju5Yohrp4d4hPK3SUtUYGzAVGfmblnYTMydVXYvEhsFAHRuY6OYWvy+mU9CX+o5+w0yLkxhBGElOjQY0XOjbNWP9K8kBhRp9RmMjUVgRdCG2o7RqXz8uIKmMTPcjOlaUZtOyyjESt2JPQDpP4yOvhlo3JUd1Iy3Juk9XuxgjpjnPJnY85ZLFzGs9CNI6lZT+E8mIsD5xM2HHXprlB57ZUWOPoWzsdYrBoMDyec8H8xfBg+kiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:32:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:32:39 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 11:32:37 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687fd9453c7a2_137e6b1005c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-11-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-11-dave.jiang@intel.com>
Subject: Re: [PATCH v7 10/10] cxl: Remove devm_cxl_port_enumerate_dports()
 that is no longer used
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 44639683-bdc8-4f9e-5b85-08ddc94e2304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExkUHVDNjgwRWhLQTVnK1VQMThEb2Q5R3UveUljNFM2NVFTVkZIcjhRZTc2?=
 =?utf-8?B?eTQ0ZzJYNkZkUnBjTWozaWhVaXlVWmVyQjFIeXgrRFRWMHEyNWwzSFVoRFR6?=
 =?utf-8?B?aEU2WkJDQWdVdHUrTVhQMEtQU2huMmhCeXZZaFRqaVlhQmo3Q1BsY25mMTZ3?=
 =?utf-8?B?elZEWUxoRE5XQ0k0cmtLQ0NoNmxPTU1jWndLUDE2ZXNkcTh2UWp4dURsNnVD?=
 =?utf-8?B?OTNVUGRCWjFRbHA0ZDFROCtLUHFjQUNuOHRZRDYzd1EzZkRnUmFiUkxLNk9H?=
 =?utf-8?B?MXVKV0Fqdmc4dmtVd2ZkSW1FcXN2RFJqdlRSTGs2TmtIem9jMTM4OW02MTFR?=
 =?utf-8?B?c2xyZkEzT3FCWithMDBGT25naU05eDhaR3RObDVXcnRvNlVWZzNLMWVneUxx?=
 =?utf-8?B?SFJYVzk1RkZJK3hZL2V1ekRuVnN1dE5DREVmYllHTERJTlo5OWNKZE81MXY0?=
 =?utf-8?B?eGJyVW1BTjIyZ3F4ZnJZcDRSZGd0dUlGT3I4bndQam5Gc2ErMEF1a1ordjB3?=
 =?utf-8?B?aVRuRUM4MDh5Z3JtWVJDK21CQ1FzZUc5SXMzcDZ1a25KYUZzamNqK3BSd2hZ?=
 =?utf-8?B?YzR2aWVSd3FlNzhiTVpBUTBnWEUxMGVIZUk2YVZDNzkrTGhyK3g3QlhhMGV1?=
 =?utf-8?B?UFFpcXhmb1VQdERYNEV2WXcvbTE1OGxUVW1RN2NSR1NUN3A1bk9YZkxlWjZz?=
 =?utf-8?B?MDdFTktQeUZBNmZsRWoxdDNkNk8yUFlPWGV5MUNlSGxBVUdEeUlmZDhHU3Q4?=
 =?utf-8?B?VGwvbVhtN2VPa3Z6eDljOEhQWFVOVmd6ZlpQaHAyVnJGS09PTWJUT255L2xr?=
 =?utf-8?B?ajRCTDhlSW5zZnFSeWxxOGo4TWwyQ2tpRHI1WDVLT3dBbjUvZzRtdlh4Y0VK?=
 =?utf-8?B?ZjlKa2Z3QWxMdStFTGJCMkQ1aFgvOWZpSmZ6Mm5WQkVFdVBmMnNGWVpkTUxY?=
 =?utf-8?B?cGNuckR4Z3B1NXlvTWZHNWpFN0JKT2NKZ0RieklCMzc1aERoWVVqN3FKUUY3?=
 =?utf-8?B?VFRzZTdKbkI4L0tjTDFyRERmazQ0N0h1NDlYTTI3QW5MUWcwK3oxVmU2ZmFv?=
 =?utf-8?B?NU1GZFFUckJwNEN1dmlrYVBYRTBGQnVoVnQ1ZmZhZW1XNE4wZnZORFhXSWc1?=
 =?utf-8?B?Rkp5VEt4VWFUZ3pEQ1U3ZUMzRWdpcS9PcUs2SEpqY1J5WHVhc2ROTEpiYVJx?=
 =?utf-8?B?WVJ4Z0JXMktDb3habXRDaDI2eDNYZTJncDVkZUdaMUFia1dyYkRnTSswNld3?=
 =?utf-8?B?MzB4bHkxaGpzbk41Mm5vaVh3NlNsUzVZRmREdUc0UWwrWW9qaXN0MmcrWTRJ?=
 =?utf-8?B?dmU4WnhBbjB2S3hQWk9kUVNsVko1MnJxZG5yVnJ5eXVZbEpnR1ExaEFzNklm?=
 =?utf-8?B?a0pJUjg3ZTlkOGJ0NHdwYjJCdCtSVVhDZ24zeFJQRmJGVGsveWxZMExyM29z?=
 =?utf-8?B?TmxrVG9rMVFnODFObGFzVXlCUDE1RnlNU0kzOVdXdG95ZnpvOFI5OVRWOGZr?=
 =?utf-8?B?WkJvUmJhNXo5QVM4N1U2WFZRcHJreVptQWpGdlJUMHR2M3JlcStHSXA0MVpR?=
 =?utf-8?B?M0RiaW5Ub3U0MTBIL3RZWkxjZWgwWFRIRTVlZlA3SkdXWi9DRW12ZEhiUURu?=
 =?utf-8?B?djFLemJOaTRiYmRxTkt0U28vWk1sTC9GY1VDWjg5dmh1RzNZaEFteWFUdU0r?=
 =?utf-8?B?WVdNZWsvMlVNNHViU2l6TkFiT1Jnck8zMEpaS0paWGJTNEVHK3BTMHZoMGJT?=
 =?utf-8?B?b1Z2OFRGdHd0dHhIUXJLdjlWR2RxMWpZWVV3L1dBN0FDRlQvSEE2Y0VYKzd6?=
 =?utf-8?B?RG9HSWJWaFpJNEJUZmpMMjlmeWdmQm1RTStmSm9XUkUxai8ydkpFVEJSNVV4?=
 =?utf-8?B?dXM5RWlyei8vZEFjenRTYmN4VFFRUHlQZnRaS3gxLy9lNEdBcmU4cFZUbDli?=
 =?utf-8?Q?3sX6/PsVbY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xITUIzRW5xLzBzdkM0NkpDeThpSm5INWFJYUpNVnlZbUt6NDNvb2RyeFA5?=
 =?utf-8?B?U2ZlNGFnR0tpK1A2SlIzQVgzMmk3dDZEdC9LWmZoajdNVFBiVVVHYUJBSTcw?=
 =?utf-8?B?dG1kZXBjK20xL0Qzc2F5SFArM2FlK2hkVTg0M0VZSDB1WGZvVVRLTiswUDNo?=
 =?utf-8?B?OTVRQVlYY3FsYW9KSC9EODZCclQ1V1RzUGtsQWNvK1NnbUdCKzBIZUliMS9k?=
 =?utf-8?B?d3ZGc29XRzR0R1hDRDNuRGZHbFJMaVlWZUxrOVhNVHR5aUQrZUttWlNkRXJh?=
 =?utf-8?B?L1Z4bWpra2JVQXZJVlRxYWdDbXFEVkMrZWRDVDVKTUwyemtveitRL3Fzbml2?=
 =?utf-8?B?ZWY4WW5FWWREUi9ZZVRkRTVtZUdudHpubThOd0xQaFpnUVBZekF2elc3TWZk?=
 =?utf-8?B?eHNDTTZrOG85OEFNN2U1NUhxT2hEVlUwMFh3TmpqeDlyT2VJTmlYelpRR1g5?=
 =?utf-8?B?NFFVYWhlcUYrVm5XWk5mdmdETHZZYXpiVUx4dHBXWmRJTis1WW4zV2pVUmlz?=
 =?utf-8?B?TWFoVVp2cUNtUmhPOTBDVHFnemFjS3B2UnZWUzFpdW9HaE5mTkwyRStwMGhG?=
 =?utf-8?B?ZEROL3I2a0tlZFRNM1hVbkFHYlVRUzlGTWJoV1F3RklKcjEwV2pvdHEvTUJO?=
 =?utf-8?B?bFRmY3dlYkh6VDNVc1Y0Z0hDWHFoalowTTVnZWpmMEtTZ0pDQWsxQ1NnTmkw?=
 =?utf-8?B?K2xsbW5lSjd2clpkTEdFZkw5SVZZY002TzBBNXgwMHdQdnNNbWF5YXpPRjh6?=
 =?utf-8?B?ZlpUUitXOTV4OWNTbWd1VEpzSjVnZkVTN21lcnVvcC9UVVJWS2k3Q2J3dUcw?=
 =?utf-8?B?YTNpdThCTDNjQlBUTXMxbWVMMSs5bEYvNjlVT1hPWG15RTdGU25FVmQ0cmIz?=
 =?utf-8?B?OGdlYWNPSWYvQ2VpU3pPSmdHeXdyZExrMXhVSkFMclRad2FzQUpYZmp0eW9r?=
 =?utf-8?B?cCtyeDFJN2JrUEZQSlhnL2FlZlYyYWhGWVh5dVpCbDRjM0plaGYwZGg1RU5p?=
 =?utf-8?B?b3Z6b1lvZC9jNDdEa0xETUdtR1dBMlJiZ1RsVXErQVFiZUczdURPcjdmRzk5?=
 =?utf-8?B?Nnd1MEh0VmltTit5WXkyR0lMb1JYOGpoa1hJQSsvck5qaFd0eXpjNnowZlNo?=
 =?utf-8?B?MHBKY2J0MmU4ZXRKVFhsMU8xMkdyd1ZvY2cwOE52VmtCWXV3ZG5qY21MMG93?=
 =?utf-8?B?SGZRN3MrVGowWnFGT1RrenFEUkxMbzNiK2p4U0NNMm5ZTHVRQ2tLL0orTzI3?=
 =?utf-8?B?YWd6WTNOTlRrZTN5RUV4MUhFS0RjUUdJREdid3NuYzg0SWdIbS9BU1l2Ym05?=
 =?utf-8?B?UHEyVEdKNS9ndkFiL3UzN21hSStQNTdTZEFPWkh4VW5relFSeUdBM0Y3RGEz?=
 =?utf-8?B?dlZXYXlJT1Y5SnB4Mi94VUM4MmJHWXplMGZ3b0t1YVdicitoZlVEekdsdXdU?=
 =?utf-8?B?QmNDa2pjSmlCOGVkNjR3ZWtlWnlpY2FWem9tTUx6YjRoclVkVmZvcTdVeXdL?=
 =?utf-8?B?Rmh5cFRpS2szSkFCeDhGVWJ1YStoaHI0YXp3cE85Y21zRVFLQkRSeU13YjBV?=
 =?utf-8?B?Sms4UDBDZnl6RDBlL2dwRk9GY2liY25veGYrTkFoVmY4MkdDUVJEU3Vaa0VK?=
 =?utf-8?B?REc4WEtidDZZSEpwT0dNLy9NTyt5WlRwZHpWRXJUa3RpY1A2aWM5a2p2bkQ0?=
 =?utf-8?B?NmIwYXQ0TDAyWDBkSFN0KzBHSTlTWFJBN0RZTm1ZdE5UTVBWdmNFQlRsRXQ0?=
 =?utf-8?B?VHFHK0NOQjQ3NFpxTkdFS1FrOEcvM2dPZXAzZktocHFMdjVrUmx4dS9aVGtq?=
 =?utf-8?B?OXoxaDExK1gyZkVMQmFnZ3VFZ2hCcElneVFKSmZpakZhRUMwRGhkeFJIZXFI?=
 =?utf-8?B?NHk4MFNSWEhUMWNUbWR0cTY0Q0FzODBzLytsTktvbHFCMWlHOFdmMTBqaGJP?=
 =?utf-8?B?b1VDQitaQ0pRV2tJTjJGdmZxZloyaTlaZk1GYzk5SktNbUJaaEhlNjJDbFFQ?=
 =?utf-8?B?UGxSTE4xSWV3Qk45TFlmQ3R0aU9oR3kwazhKMm1remdKWGJoK25kekpKWnFZ?=
 =?utf-8?B?d082SjEvL1dlRjJDZDJKUytpZ1B6K1VPM0JkMWJCNU5iZUZ2L1VHTFlzenFB?=
 =?utf-8?B?QXdESHExVHVIUXdURDNMUHVWS2xSeGo0VGpZQ1BrQjZuMkFiSWVZVFdlNlBr?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44639683-bdc8-4f9e-5b85-08ddc94e2304
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:32:39.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3pXbIFlYGhuY31EhBufy3zkB6Yqtrx7sycjdFiYb95ptJXgsKKBzG0YOxAvLWB6cfWEwjoWlZIm5jH9VwYtu7Wf0d8k3B5UqkzFMPQq7Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Delete function devm_cxl_port_enumerate_dports() which is no longer being
> used anywhere. Also remove cxl_test support.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
