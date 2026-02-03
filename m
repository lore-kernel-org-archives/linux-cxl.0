Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A5267714;
	Tue,  3 Feb 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153285; cv=fail; b=nbbXRbKx7l6dftfiLfoxRvBgJrM7bS8iRrtCbvvZoylTqS2tnVp4q5G88ZFyeKHkAlfRQQoZLhrnpVtbAjgm7ZLuU4CICLsk4DG4JU06KyAMdCrYz66JligZ88YH4NTk+T/iNn2U3f3mzMgBq7/LNi/6m7/wbZAyr3oG1Jxo5EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153285; c=relaxed/simple;
	bh=hm/eOPfHRmUlKc3lIS09WcFXK30KPz02+84gs8hVsxI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=plv17CIhd+HiT4iMg5IntKkzMyjRrxbbcYFH5z9Rxv9EUd2mF/pwuAxlOrkqFkdIALY4HpXvolYhXq4PZljYPGkP5y1FCYPsXK6FMpUO2nvMp9arpxNy/n7MyaTqv1GPQ/ghWp5wU1bLXBaMjNGINe8JIlRNvGcwjI6wevpPd1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzil0XWn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzil0XWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770153285; x=1801689285;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hm/eOPfHRmUlKc3lIS09WcFXK30KPz02+84gs8hVsxI=;
  b=dzil0XWnhVtZHDN1kPE/Ojy/Gw2FeW7mK7qFJU7+mKr9E/+kP4iVo4Wd
   MyZU7dCWv7jUrHalkwhOyoVR4YQnnYiDUX/g6TYkq/4Jm50VyS8mJN1pn
   iFNKMzfmKvyaK/7jS7/SGRfiiqLzahFtVyi3KUiW8UyfoxzKvUbIorPBp
   GIhVFekT7ohFvg9eBkF5IOLBMI20+7d5fmnU0bWmWhiFvVcl3nASEB94V
   +ibrSIo/wYXQd8FOGldMEgrslq5wq/rPot4e5VIBLpiV0p+/5mXHTOD51
   hz0S6MMbxSf/W+BmPUfQliVtMBh8FAjQ6+6wQv7l6mZmJGVIEc2aVZBib
   w==;
X-CSE-ConnectionGUID: grECMLTZQXyzHlOmSq7vPw==
X-CSE-MsgGUID: xGtThmA0SqaEWK8jL9lLWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71234622"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71234622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 13:14:44 -0800
X-CSE-ConnectionGUID: m8dnRb7CSS+B4krmNAr+tw==
X-CSE-MsgGUID: woa47ElYQU+tpwXpTg1ZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210000156"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 13:14:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 13:14:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 13:14:42 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 13:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH8KWFIluiqEwE0dPwdVj/pGp3g+lWHehvX9/Niprhk1lfa0PA/CSohtiaJ4dmfwiNL2H19Sj/MkM8aHHzRZfc9ViBmfL6YPGnGbLdAQKn4Mul11I9lupz2Fv7H4Bgf6B1Ktqyh10llAP1F7HythPZgl0cKWsFpAn6tcF7R8pgJ3oUt3wrDNtnw2fZ3GUT/k530zdlFmLB2TdDCLth5uLtT2wMCXYzSp7L1tcpUAHR7n/S5fBj0w3CyjnmJNMgRov5A1pBvqag+PA8NUUFqr08sFNZVC76+CcR0ZgO4QiBwtD9+P83kXTdpf83GQfefNHzTgRUAvC74KB9Bz66yHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=binre5UebZwneXjwLnT/SqWLifoC+PbX39xvclUVE9g=;
 b=i4GjkJNQTM/EQ6eUzjAoX62yVMcCFyl4mphAvtu2pD8IBlXB3t6bFTdCY/0gw8rL2QdDUqdTqh0Dguz4B3zZnM5nAebdPm311Ar1bWSDEQcBd4SZHt1kMh+vw12W4B6XL2ldkjSuq9NH1KoIAIbchHQhyYNTLwLSajoSPS9GDNzja9bA3vMl3MVW/HEIKdcngES9fKzitF+/NmMX0veCUv7ZcVz2C7KLIReRQu1YJ6p/nAzZrBX20IRDEVhXyIwcDjYxqSLkEJVZFsbokkQY9bWNzl2sDIK+95hSOVabXLHvBBgS7h40ONj7eLLPNEuhFjO1B0U9ty4RUMsju9RtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 21:14:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 21:14:37 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 13:14:35 -0800
To: Li Ming <ming.li@zohomail.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: dave <dave@stgolabs.net>, dave.jiang <dave.jiang@intel.com>,
	alison.schofield <alison.schofield@intel.com>, vishal.l.verma
	<vishal.l.verma@intel.com>, ira.weiny <ira.weiny@intel.com>, dan.j.williams
	<dan.j.williams@intel.com>, linux-cxl <linux-cxl@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <6982653bdfcbc_68d310065@dwillia2-mobl4.notmuch>
In-Reply-To: <19c23e33320.c78951ef7300.3027465952765956716@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com>
 <20260202153924.00002396@huawei.com>
 <19c23e33320.c78951ef7300.3027465952765956716@zohomail.com>
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: dd36b2f5-9373-4884-0f09-08de63693cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHZvL3RNY0g4TGlkek41M0JLd2ZCK2x4OXpyWUFRdi80M0F0SjRwbHh2dHZx?=
 =?utf-8?B?Y25sTTVJaTFtcGs0T2hTOXJrQzcxVmQyZENDWU5VVjZ4N2I2MHJyaHVTZjRi?=
 =?utf-8?B?a3diNUg1T3RvbGpITDlnSi9YbGJKR0wyV3E5WDFjQVYyNnVLS2RSbG1XN3Fx?=
 =?utf-8?B?b2c3T3pWZDcybFpscnFhQzNmYUJPWU1UY29BU241QUE2MFBmZTdWR0gweHBZ?=
 =?utf-8?B?Y29ieDZ6RnBxY2t2NUNENUNSTG81VUFWcFlKUzVXWWgwcStDTllic1N1V3dS?=
 =?utf-8?B?WWc4UkVZOU13R1U5L082MENtS0hxTUZtU2pNYmMyeWVueUExQy8wcnB0bDZW?=
 =?utf-8?B?b2ZuK0I0ZlNRanVHK0JneXJiRHVQRm9VL3NyZWVrYVpNdEdpemFTNGl4WVdX?=
 =?utf-8?B?dXZ3YkFlWHE1ZGJZQWhGNGhyV0hDUUo5aUtRdFN3Smh4L3JaMDFjRFhlV1Zv?=
 =?utf-8?B?cFRjdXdxeG9jMlJUb3huZ3hjRVZ1U2hYQ2N2UXh1YUF6Z1Z1WThpUkVJcjhD?=
 =?utf-8?B?NzFPRWE1SXVBV2VJbG42TUhVSkRSR0trN1dQaktMekNxeFpETk9yaVlIaERt?=
 =?utf-8?B?SkNCa2xpdE56Y1hUa3haTExwK25tSnJyWnVKb0JKYk5ScjdLNU1hejFCOTF0?=
 =?utf-8?B?eFkreVJOdmNocHlxaUR0T0pmeUo4MnhPTEptTTZ5dWpzNXkxc21wd0xpU3VZ?=
 =?utf-8?B?ZnMybjFTVEJkSXFZL1c4eEl1Qk1RL0dveTVXMU9ZcmtkeXJGZ3h3RHlId3la?=
 =?utf-8?B?enZybW9naXloQU5Ub3MyK0FBVnhqV3hZWkYwOUQzMCthd25FdVR4aitsc3pP?=
 =?utf-8?B?YmpuSWE4SmtZbXJVYVBCTlNYZkVmZkNDUXA0M2FNMTUvaGxUVXRJQ3N1VVJK?=
 =?utf-8?B?OEtxS3VGajV0Kzd5ZDlMU0hZcWZzSHFTL2tGLzNyR0dIUzFCT3ZraWMwTGpo?=
 =?utf-8?B?amVqZHp0eTZMaDhuVHpBcjdJNFIveXZyaDZFY3RrUGZ5a1pWT21RVFp0VmdE?=
 =?utf-8?B?UTIxNkR5M3h0dXJYKzhtSWVNOERrYjJwNUhLUjJvdkdFZ2FMNGViVFdZZGtB?=
 =?utf-8?B?RVNEeVVRS2pJV0xsNDgyeDVZS2JuM2FDdytHLzhGaFo3aFNzcmtiaWRlaHIz?=
 =?utf-8?B?N1MxSHMxMWU2N3prcWVEV2hJbWE1dGdqbEtZczBiN3NkeWV4eTJoTFBNUXF0?=
 =?utf-8?B?SnlZVFRsOWVibXRKUjZCWUh1MTQ5WjZyelFEOEF5SWd1WE15dERrbkhoUStZ?=
 =?utf-8?B?YzFPcWhzREFiNVpMbFB2WC90SkFZMVd2N05weFF2SGVNQUZlK3h0MWU2NCt1?=
 =?utf-8?B?djJRK0N2MTRpU3V4bWdtYUpmY2E5dUtyS0NLdDlBM0YyaWhJTTBKSWxaUmZO?=
 =?utf-8?B?MDdWckdBVFFmUzlGalFyenJwbTlDbmNMdUVTYkEyZFBDU04zRDd4Vzh1OEEz?=
 =?utf-8?B?bjh6RWkyWHRwT0lwOWZyNGFIVy9GYjFxdGViV1dPcGoxRU1kRlNBMFdGUUVJ?=
 =?utf-8?B?M0t4czNlSVlvaDRYRisvMFR6UFh5SXRMWS9pakRuT2pxOWVMNzA0ZVNna1NV?=
 =?utf-8?B?dTFRQlFjMThGSjBRYkg2akNYOVpsQzNMREl3ZzhISUEwYStoc3lMMjFzTUto?=
 =?utf-8?B?Smw1aStvMFZpa1U3VDFiS29HUXhpa1J6MkpFUzFRamJOYnM3UEhKRklJc2pv?=
 =?utf-8?B?S0JRd1AyNUs5bmZuUHl2NlV0UGFlQjl3K1JleFpjRmEwTVh2K21vTmdSOVdF?=
 =?utf-8?B?MkdvOTE5NnlyTjJORGkvWjZKc0ZIYzh1MGNqaytVV2tpTllvQlF5ZksxanV2?=
 =?utf-8?B?RjdPM1ZIRVByU01XUWhyZVRGbEwwNURDbWVORGdXMnF4NS84dGJqNlRDU00x?=
 =?utf-8?B?b1RLTHdJL2tYRW16NE9SMms1ZjNtTzVTK0NBWExacWJqN2lwU3ZFUEVsOTNs?=
 =?utf-8?B?Z0g1T3pwMU8yVmRQY2F4UzBRZFRMYzBZV2IvWTJacUd1L1Z0QUE0UkZtM2Fq?=
 =?utf-8?B?MG80M2VPSzJyc1dISVJhelNvbzlVaURsMTlteEZ6WmJPanZzL0NlSUFSUjVu?=
 =?utf-8?B?MW9IaUlNNzhIWUdMdkNVcDROa3lBbmdlc3c1c2VhQW5NRmpFWmZoMkVuV3FR?=
 =?utf-8?Q?OqE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVMWWVONlI0b0EyUW1jdlprbDNwWFZRaU44a21iN1Q4aU5Nc1RQVitOYmxV?=
 =?utf-8?B?SlZsc015OVVTWGlMUHlhbTZkVmxML3RjWkNlS1ZnTlNZRjIxUGUzV283VXRa?=
 =?utf-8?B?bTZwYUhkVm1mVjZ5Ym5nclMxcTNoYjlvR3BIcVFhNjNJZGNjUGhEc2xXcERW?=
 =?utf-8?B?UkMwWHlDWXZFaUFmei9xS25PRXZoMjJLZ2tyZ3ZXT2FRSmVqK2FXVElZUTFP?=
 =?utf-8?B?KzVIUVZFSWl4VW1scXE1cG5TS3YxQ1M2aVFUUVpHOVBSQ3gyKzJwdTFuSjh6?=
 =?utf-8?B?dG5aTDNLdG13bjhmMHE3SW5uTzU0ZWNaaFh3bnB0S2VFcEFOczMweE4yMUtX?=
 =?utf-8?B?SkNERWhxMDZEN215emRBd3RzNkRuQm5oUzczbEpLWnZYM0NKa3lSYzNBNFNx?=
 =?utf-8?B?QTF3REFYcDVST3BjdVJLTHB2WUtTRHg3S29tb2doamFPTXdUdlBDd0Q2bFZH?=
 =?utf-8?B?UTVPN01WOXVBMVlEM0U4a2E3VW5wSGVKN1FFaHM5TFVsTkV0dDJtYkhHeG05?=
 =?utf-8?B?S1dtaE45MzFTNXQwNkRsUU5WOGxxckIzUnFNLzMzZU1rLzJNcmd3N1dEa3Vs?=
 =?utf-8?B?Q2E4NytiT2p0Mktxd0p5NHBJdzJpMUVOU25CTWZDZHZRcnFSN05ZdGNwakpW?=
 =?utf-8?B?V0FXNVdqbktMQU90NG1Ncm5vTS9hSjY4OXg3MUJsVWZESUZKb0dCcS9XL0xw?=
 =?utf-8?B?Q3RHdzZuOW5raWFWY1U4a0Z3ejR6MG5pbkQxbDRwd2dmUER3QzZrVHo1bVhB?=
 =?utf-8?B?d1U4ZHh3YWhyUWxTRHdubzVBVDJVcEZrVXpwa0JHTmNqY3laUmRZWDN5emUx?=
 =?utf-8?B?dkcxZnNIaG9XSWpTdDgxdVUrSVZSR2huWGp4QTNnRzRDZmY4WW16TmNvbDFw?=
 =?utf-8?B?M084WHd2NmRsb0xxM1lHcjA3N1M4QVhUMWNxSmpTU09yZ3B5UjAxdVp1U1ZV?=
 =?utf-8?B?MHp6MGtSMUlwMnNicXhoL0Q4VlIrZnpCSFgrQlN6OFl2UUxkRFExMU5FSWM1?=
 =?utf-8?B?SnZmU0FsVDZzNm9rNzJ0bjRkQk9OUzBoM29walF6aTEyRlNITS9GSGF6SGdH?=
 =?utf-8?B?dWF6Z0lRUlZVbUorN3NpanhnS0hSS2QwazVrbWpVOWprdFQ1RFJzWHRTT0Z3?=
 =?utf-8?B?RjRMQWVYb2g0NndhRlVFRW9KOE4wWnpNNCtMbGQxRlE4Nm9hMUM2NFlYRldH?=
 =?utf-8?B?OEJ3SXFkZHlVQk55UzN4MXBuZ0VSY2hsMDNwRFdEWnBiSEwzSHBPU1hQQVFY?=
 =?utf-8?B?SDVOejY4aWlLMG5Md1NkSW52dndNMG96Q2xtdVd3NTl6WW0xQmxPbDZyMDM1?=
 =?utf-8?B?Rmc0a004bjVoYW1XelprU2hVZVl0cWZzcjFnRnUrYzlMblU2RG5WMnpjRVJq?=
 =?utf-8?B?MjJ6QXJqSmI0K0ZOQ0pJZHZZRlpuYlNPRUxoWkg0VXRTVDh5SythMGE1OVkx?=
 =?utf-8?B?K2dBWmZoL056MEdla1NVWTA4L0tDNTVZV3NEblRsUkoyM2huV3JTNHptNURp?=
 =?utf-8?B?U2VaRVc4a0xFMHpocFh4VmRDTWFxT3ZkaTZRQXdsdktsdDNnOGpJZzFhUlVx?=
 =?utf-8?B?b2J2YmdjbWFXZUswL2docnlhR0o4YmdJeUZqaUtQSmFJVk5xekY3d3dhT2FQ?=
 =?utf-8?B?WjBqYmwzYVFsZitwdC9vcHBEVTNjTUpxWERqOVQyMHB6YzdUUUNnN21DNWpj?=
 =?utf-8?B?dEtPbEJpeSt0TC9CM2ZjTXNtTGViQUUxM2hPTFdGZ0h6MnNNTHdQVVVubDdD?=
 =?utf-8?B?Q1JEVGplYURwdmJrSTZ3cjlZN3JGQUZMZk9pN0N6L0plci9lSWNPTnRISVVJ?=
 =?utf-8?B?ZVoxYXp5U1pBWCtoSHVMVDhET0xWZEp3MUFEbHNVaWNCc0hFaUVsMHNJVGlB?=
 =?utf-8?B?eHZ0TnA5QWRVajVSVk04cHQrUGtkNHVlTzRsbnpkMm5oZGY5MzJBWWRPbWI3?=
 =?utf-8?B?SEpYaFpHU1o0c2VONDVRbE0yTVhMbEJlaTBJR2p5VHBPVDMrUWY3V2o2cWt0?=
 =?utf-8?B?VWc1QUZwQk1jTDhKakNRUXNpRDRaSjN2eGN6TG13M1RERmxSM3dwd1JDVGZJ?=
 =?utf-8?B?Unhha2NoTU9LQWtxWmxxR0tZWG9BUTRRSkNodkdlekI0Qm5USG9GNDhFOVJI?=
 =?utf-8?B?K3BPcG04REQ1aFMzbUdTZG9rRzJSdTdzQ3FhTjRUQ0JKQVhpU2l5QklvN04x?=
 =?utf-8?B?U0VNWUVnZWkvOG9ZcVhieS9zV0RCUjdlYzFmMHVmaWk1bzZVRnpodGo1eklq?=
 =?utf-8?B?NnVHU2k5ZjQzQWFhTGt3bmpnWWpPbHZxUEN3UldaUVZ4MjlOSk9naWwwYUFH?=
 =?utf-8?B?dFhWSW83Slova0I3V2Y5dXZoNXZNRGdGMnkrSncyY21VemRzQWMxV3dhSmdi?=
 =?utf-8?Q?DU/R3m/J8nB6FK9g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd36b2f5-9373-4884-0f09-08de63693cc0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 21:14:37.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzA77HdBYgZrbgOVTGkP008I1wVMh2g46NNhnbGO/GltxlIxOg3cguGTImmzhOVyPX27/QUVPPC0kP7JdHsBzFsMCNPjMVvAQ0qJgtGZwFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com

Li Ming wrote:
[..]
>  > > -            scoped_guard(device, &port->dev) {
>  > > +            scoped_guard(device, &parent_port_of(port)->dev) {
>  > I'm nervous about whether this is the right lock. For unregister_port()
>  > (which is easier to track down that the add path locking) the lock
>  > taken depends on where the port is that is being unregistered.
>  > Specifically root ports are unregistered under parent->uport_dev, not
>  > parent->dev.
> You are right.
> When cxl acpi driver attempts to add a cxl host bridge port, it will hold cxl_root->uport_dev.
> Otherwide, hold parent_port->dev lock for the new port addition.
> So I think it is possible that memdev can observe a cxl host bridge port but it has not been attach yet.
> Maybe I should hold the lock of the new port's host.
> Let's see if other reviewers have more comments on that.

So, I think current code is ok, if cxl_mem_probe() races
cxl_acpi_probe() in the same way that case is already caught by the
cxl_bus_rescan() at the end of cxl_acpi_probe().
