Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EB281376
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209072; cv=fail; b=MYGammvjkdjLFbHirvVPWFU97S5TOVUf8YOhFxybcZ1wF5KHr6OWxFV5GiNWIwkaeeAM8MLJ48UD64RHoiG7QmTqJYx8tWeOY2hrxFPv5Oyxdoq1nq/kVQHCNxV0H3Wr50RIlPhn/kvUqf9z+b1fJC+IzGNfQsKUg6cWQmxPeSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209072; c=relaxed/simple;
	bh=pgO7BE+gMI1QyI5zs8zbLFjMIFqvj35xEr1APO2kzF8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fj5uUDzliK7A3EGqqWNDPFeVHGZ7GXB4GEtUaUZKic9EkMCN3vajxXbPjMTBa8XR3OckP9KCBlMYjq8tlKdwb7gFhBsZyI4CpYb3l8gPRvfSUHTFGdAgkVGHNfSEwzkRYR8W9eXyaozv2FxmjZrMSdYtQkhgmRSfcwx/f1UuA7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYlX4R0R; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYlX4R0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753209070; x=1784745070;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pgO7BE+gMI1QyI5zs8zbLFjMIFqvj35xEr1APO2kzF8=;
  b=NYlX4R0R3Bjm360qWmyY3JurlmSAb5tn3J3BNg4kPrcccKDiuh8qXeIQ
   FNL2mklsXd3xGHoRxW+NMEOQgc0mdxUoc/P+RgZZF+PCy4k6gL+3l4ODV
   sggoZfB6ZpDI1Yo31eOac2HsmG90EELCSyo6Kr9oKmb25iYCKeBFU7KPu
   tbvdkNuoYMlu4iaRH1XWf1UIs29Oq4xwXiZNYIjSUAD9vQK2ivKdyj2aj
   GMUFqA/ggxdpzVA6+oG/Apd8dL91ImWHuWv8Nh8NYy+y1Y752cOaFm14r
   2lwSaASuMxveR+d9ZRJJXJ1dhlISZDDLPYEJ6OVtvGP6Bj8JfMqerqQc3
   Q==;
X-CSE-ConnectionGUID: bIZywL5mRwO6hqRJtXYHsQ==
X-CSE-MsgGUID: txOIxqlvSeeKthotXIY0Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58090479"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58090479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:31:09 -0700
X-CSE-ConnectionGUID: GizJRUyPRky3VZ+sy6h7xw==
X-CSE-MsgGUID: Rvk9eLveSEGbQVYCTIJEeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158981896"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:31:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:31:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 11:31:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 11:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqoGHoMWiRkGroJMmtPjhC1Hkw+BiCnJugxu9jM0PQcG1ZHV8sBEYnBTBvDVm6GxWWvMoEzpP+mqRXCp9zAydBaRGyauEZUmIQHmQsZyXVwQCFYMRE+ZIrfWvk5sODK27+4Xgfsyj+YFz3lf8KaFopOjiDP8xdQxMEvujT4Obq4lFonH1LJ88pyrDI1VLCC5ZG7qgXHeOi7M4czo3uHLlBbIuuWtxkaPe/DlXeyy615DDrOKMCr71Xxcc59qWJHTUeVQh5YtGXDNpNo4u8vvuVcGZCI40nnQ5qGxQyB+LekoC/OaM8PCWeFMG0Q1r31jK6DaYO6GAxUtmgC/3EOFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IrqQRQX4cv56Pdvra4bE2KbPeVl1SsGyNFBdIWA+4U=;
 b=yXH7ymVv8SaEnMnssKcpbd/99MdPjWsjL3t2YLSrnsCDaIzsKfQp7N0vTBBGMaDtQF8fN/32firIysJw4jw12iW+GY9SgSZuxSeTzw+c58zyt3JMaa2mkVO+2gP0EosGaSe1WISavbuepIEjpV17lnhpJ32YkuE/axY3boqZEQGIJwPRDRBUoa3CB7Dcfk36Tdd8/QetCI02CktNGPvmYVIYYYd5w7IWca+T2cW+olV1yLLV8hu3Iw5YmVp2Q1U4PCJEuPqEAXrM6UWOI1UsNr2nN0L8gvJSgBrDdSWxDIBPmc/ylJ42AcOKzeC/oqSTpNIsq3KXJW+4m1cs87Ve/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:31:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:31:06 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 11:31:04 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687fd8e884ccb_137e6b10065@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-10-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-10-dave.jiang@intel.com>
Subject: Re: [PATCH v7 09/10] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0244e909-30c6-4f9d-682c-08ddc94dec06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzJrcnc2WFZIc0d4MjgxV2pya2lpODZmT0Fyc3hNbXMzdk52TEF3alJUWnZk?=
 =?utf-8?B?ZFBwV3pYK1dLNTl1MW1Ed1hCdGRXK0svS0RSS05EeGQ5NVVka3pnRU9SRFd5?=
 =?utf-8?B?OW5zTUMvMlZNUkxrMEhUQng5S0NmZ005VXR5Q2J2TkFITlQvZFJhRTVjNHkx?=
 =?utf-8?B?ei9FU1JacUtWOHhOQUFHc2JzdEFlOUluSWZkdXRXNDZnbGozcEtNc1Y1cmE1?=
 =?utf-8?B?VWd0amRWaVQzTlNTT1NSMlVkWFFaNlh0Skk2Y3U3TnI3VGowRzJWUzFIbzYy?=
 =?utf-8?B?YlpEdEVZbHhjc1ZnRDZJM3JKK3lXMjltV0h4QnNGQm8wVGpGS2JKc1VCRzBM?=
 =?utf-8?B?MVFRdGFyM0YyY1hMZUV5MmdiVVl3Rnk3cEhaWUJ4YytLRmlJUjRaSUp1YlJH?=
 =?utf-8?B?UHZHVnpBZk1JVzlQN1NuWUdQKy9vNjBPV042SzR1NmFJZW1wNE1ta1cvUmhw?=
 =?utf-8?B?NC9oTzlxOS9Pd1lSZTg5Wk4zVDRzQmhNeXNkZDhpOVd2dmt4MWxVcXZ1OWZn?=
 =?utf-8?B?MXdST3JIUkZhb1htV2cydTYyOEZIbTNIKytDdDlXajhITGtXYzZHeTdLR0J1?=
 =?utf-8?B?dTJMRm5IeE9zdU9GZzVVZ3VQdXRhM2ZGc21LZUpvVFJKRTkwMlFsLzlZREdq?=
 =?utf-8?B?RFBJOHR1cEVtSXBlekxUTm0wT0hwK0pCc24zSVBkZWZTSDZ3MlQ2V0kyYlkz?=
 =?utf-8?B?am9kWEt0R0MrYnVlL051K0QwUjZjNUxLQ09RTjg3SWRWT1V4TFRreUpNTXFq?=
 =?utf-8?B?ZUFDSXRIc0wvMWk5ekNGMmRsbG9jTGpQbERyU0JZZFpGd04vY0xUdmM4UnVF?=
 =?utf-8?B?ZHJWRUxIZGlyQmE3cW5haldBT2huSW9WdkJUbjVkWjMyNDdkWS95QkhieEFW?=
 =?utf-8?B?ZDVNa2F5cWVlVUo1dnlyVXgybFdSY2MrYktUc09aQXZXU3lBczI1R2tXTisr?=
 =?utf-8?B?UXJIQWNVUG95ci8vbmlDSmNpT2JvNExMREY5OEMwZnV1M1I3endYMzlmNkUv?=
 =?utf-8?B?aHNWbktyd0R0MnphNXRlOWYzVzhjUUFlZmZEOVU2SU1aeWc3YlFqL1Q1M0NW?=
 =?utf-8?B?WDhkdUJDOWhCUEZUR0s0MDJONDY4Qld2QmgyenkxdHZLd1RTb0hVTUJBTEE4?=
 =?utf-8?B?QkNUWU9CQlk5WFNmRjZjcGIrY1VwSXVLWjF5ZDNVaXp3dFlqUUtLL3JRUFJT?=
 =?utf-8?B?UUtFNWF1TDh1NHE5WkdUTUNZWmZVdWZsY0pFSU1wWEhmZExaemNNa1pIenZR?=
 =?utf-8?B?SzU3NzVZTzVhdTdkeEdtSFlkM1FpdGhOc1huOXprUngxSzJHYURRVkNNSHpU?=
 =?utf-8?B?OWhwZElPQ1RQRVlmdFNqOGtVREo4eUozUVB5V1VHVmFhQUp1QThkRngrcFdU?=
 =?utf-8?B?QlRvZThGazBqdVJ2bE9obXJYZ0xjYVpTZVNaZmNyM2NJUjRMblRDMlc5a2I1?=
 =?utf-8?B?L2lpR3U2clQ1c1ZJMjUwN1pTVHBvUy9tR3BDdDE1VUVWVEVBaWxmczNtVE1W?=
 =?utf-8?B?VDF5TEpCZ1B4RHcrVjFFMUxyWFVwQkVGOGw1OGJaMFBBVEVmQXY3VzNSL0Vp?=
 =?utf-8?B?MHM4K2pVdU1id1BTYVdnQkVXQkxTQjRmejNwbnVHZmV0S0V2T29RTkRrMTha?=
 =?utf-8?B?TWQ4aWxRaFZzWGRNRW5qbjJXdnp1ZHM3dU9FNVV3ZHhhQTNDSXpUSDhESTUz?=
 =?utf-8?B?WGdqd2VGK2gzTThvOTRZS3R3eHpGSnVLMUVLSy9MRUNkUVdZVUZqaGlWRnor?=
 =?utf-8?B?YXFjRFpnZ1dSbHRVYXN5TEVkT0x6NGEzYkRPb0hxdG5TMUk3TmNreEdiK240?=
 =?utf-8?B?YmtVc3pUN2FMSkVBUG1UU1gwYVhMeDVNN0l1V1FVa1hlTUQxVG1odzR5cEtY?=
 =?utf-8?B?TCtOYStQNm5IMW12VCtFQkthQlM4VmhEd1I3bEVRSGdHMmIzODU0UzY3dTVN?=
 =?utf-8?Q?mqFTgmW0ckQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBEZTdvZjZrOHZMKy9nL1VoZUZCZzloT3BzN0hpYW54aGVST09HOXhTb29r?=
 =?utf-8?B?aVBNQmJBNjBmWGMxOFdQM0J5Qk5qdW5QYjJoOStybXNwN2dGeGFQY0toL2Iy?=
 =?utf-8?B?bUJPSk0xUnFGN1lYV0lqNjlxUFJncmFpbFV0R09rejdPL2dlNHdJMzJGMTlK?=
 =?utf-8?B?WTROWXd2MEpVY1ZGUXgvajhvN2NsdzVsZWE1b3VQOW11c0ltbm1DYnc3YjJ1?=
 =?utf-8?B?Y2ZRb3M5U2RXNzdrUEhZWmt4WDd6UlhCOFk1ZjlDeEhKZ3RjWUhXeGsrNkZ6?=
 =?utf-8?B?dnFzVTNUREF0VmJ2MmZqZ3BUcjM1RDNQb0hvSFM3MUxqUnBTSVpkTnBtSFps?=
 =?utf-8?B?UW16NG9qRHpFelhlTVJqWHFHK3E5RjdaV3drRXpmTzFEZW1xSmIzU2tFdmdO?=
 =?utf-8?B?aWdVRHJhbFNIT2V3T0NwQzVvN2h5cUpTY21FcXVZRjRmaE1PVGkydFNtdkc5?=
 =?utf-8?B?UUM4RXlINlVmRDVUcm9xNmlLYzhaVFQzZFZLb1ArN3hYdHpPMHlBbllyMW9h?=
 =?utf-8?B?YlNKcWVnOEFzeHIyTTZSNTFnS0tIMmRxNURzbVIrREZXcHhXRURXbStDSVU2?=
 =?utf-8?B?Y0doNFAzbkNtdmE3eHQwdWR0UGtxUHYzdFdvN2xic3IyWTRadmNiUU9yUDZ0?=
 =?utf-8?B?MmFrcUlENklESFRlbmp4YW1CajJaUFQ5SGd1V0FwR01SelFPWXBwWC8xbThh?=
 =?utf-8?B?Rjdyc1l1bjFaUytZVlVpMWs5ZlVXL2E4b0dpMHp2a0h4KzIrK05veGE1ZUlF?=
 =?utf-8?B?QnliYjJkcktWQTVkQTZ6QWlIclhKbFEzZlU2c0JyWDRFWnhkaEhXN1E0d3Bv?=
 =?utf-8?B?dVhpRmVlRC9ONVE5djNFaUlvT044V2MzSjE4Qm1hemZ3QlFQWUN0Q2duV0Qx?=
 =?utf-8?B?UUQ0RkZJcjJqOUZvZDdBbjV3UEYwTGRhNW1QQjNCd0lvaUFEelc1OWg5RVFB?=
 =?utf-8?B?UG81WTVqL1dRQmMvUE5GOHFVK0Y0dVFNOU80Q2ZtREpvbWIvWnBGT2V5UWhR?=
 =?utf-8?B?SWhuRnZmeFMzVm9YQkhTdXhKL2t0YittUUY5allGUlNqb0M5dksrVDhwTXE0?=
 =?utf-8?B?TzM2REJKUWIxTnA2YXNnNWlOeWdhQXorQ0htRXhmZjlYVEhsd2RlR2NrUFdi?=
 =?utf-8?B?QkkzbnFhaXpEZmhYWHBjQ1RWN2h0TXdtbHB0SmREa3dGc1NpQWdUYU5yZ1Jp?=
 =?utf-8?B?RnJoaHlxODRnVzBwbExSMVJiNEVjSjV0N0JCenFzZFpwY3ZDR2wzTDNFenZh?=
 =?utf-8?B?alB6bDkrbVd5TjBFdmF2MnpWSmw0Q1pyTWlyK2o2eDVrZEs2Y2VCR3FsRGhz?=
 =?utf-8?B?MEJpNHFzckpjZm1lUzl1Rmxocnk1S0piMUE2YmdYSG5GaXc5MFpCZE9rR0ZB?=
 =?utf-8?B?QWFmWTA2dXhFWlN1dTNZdUgxQ2FmOXdUWjFvS3VnOHNGdC9YSFJiUkFRWGxk?=
 =?utf-8?B?d2pnQ2lkRzRiZ09iWjhJa3lIaHdvdlVidldhRmhKdlc5cVZQNTFwQUtBN1FV?=
 =?utf-8?B?azJ2OENUK0trQWMzOTgyN3VkRXlCVjYvdnFWRHdyaDM1R1MwajErSm1ya29i?=
 =?utf-8?B?b01PcFFCRmpzM1lxYi9rTE1HQTRmdWZ3VjlqeTE4Vjl2SG5oSUlkOVBKY09u?=
 =?utf-8?B?ODREcHFaOWlYNXRYU0JOTGxkVXpxVUxBb2lGZDczbUdzNTlFQzZHaEJpV1RB?=
 =?utf-8?B?ZG0rTDBXNGJJMUJkSWNzTnpwZDhRajE0ZGVjYXVyM1Y2RVBLQ052ZDFvV09Y?=
 =?utf-8?B?VFFyZDFrbWhleDV6WlhXNkR3Mk1nZzV0ZUQ1bm9LYUJ0bzJ3R010Y2RmWHBY?=
 =?utf-8?B?Vlk2VFNmaVc3b09uYWpCS3VVd3VhOU5jTWRqMTRhNE5oQXp1L0lnci95RmNI?=
 =?utf-8?B?TTV6VVVlVDU5bHdNT0Q3bWxmMjFjeWZ5OTZnTFVhN2NRV0U5dFJxRWxvbkFu?=
 =?utf-8?B?ekxvSHBkcCt4ZlhBWUZrZjNaMWV4L3IzblcvNVgvbGcrMFB0Q3hpRUJsa1pp?=
 =?utf-8?B?MUt1STFHTGUzQ0RzbWxJaUZWWCtrZDlDR0VuMWZlWFB3bEgyMElJZ2Z0VXcx?=
 =?utf-8?B?VlNmcjdXQ2crMDVZQzVsaEo3YmZFY28wa3VZa1lFU2ZhUUhaTDBWUGxGWXVl?=
 =?utf-8?B?YXBXYjF4YjVvOVExWmxpcEwxMkU0WjBzcWxBN3BzcVBtQjVYL08rT000c3ND?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0244e909-30c6-4f9d-682c-08ddc94dec06
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:31:06.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H2kufkCXvuXo9W+ecumqT2TLZaLKAdLRivz3Fz4R2TuznzDxlyB6MJSXsXwh+rfptR2BiaTNx/mQ+QBE6ZT79aKEEx1yz3pWGJHEvbxQPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current enuemration scheme in cxl_acpi module creates the ports under the
> root port by enumerating the hostbridges after the dports under the root
> port is created. However error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed when certain
> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
> DVSEC ID 7 blocks which will trigger the error message. This behavior
> is defined by the spec and not a hardware quirk.
> 
> Setup an association in cxl_port to tie the host bridge device to the
> associated cxl_root. The cxl_root provides a callback that's setup
> by the cxl_acpi probe function in order to create a port per host bridge
> that was previously done during cxl_acpi probe. Add the calling of the
> callback in devm_cxl_enumerate_ports(). The observed behavior is that
> ports that are not connected to endpoint device(s) are no longer
> enumerated. This should also remove any excessive noise of port probe
> failing on those inactive ports.

I do not understand the story here. Why is it necessary to hide host
bridge ports that do not have endpoints attached? I think that is
valuable information for hotplug to identify available ports.

Now, if the concern is that host bridge CXL component register
enumeration happens too early then the solution there is delay port
register setup until the first dport arrival.

Otherwise this feels like too large of a change for just that small
ordering constraint and I think this makes some of the hierarchy walking
redundant. I suspect that moving register init lets the
devm_cxl_enumerate_ports() walk handle everything without new callbacks
and new lookup infrastructure (patch8).

I have long wanted to move cxl_port_setup_regs() out of cxl_port_add().
It has always been an awkward fit their because register init is usually
something that belongs in a ->probe() path.
