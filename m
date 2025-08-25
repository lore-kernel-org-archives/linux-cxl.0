Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E891A08AF
	for <linux-cxl@vger.kernel.org>; Mon, 25 Aug 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150287; cv=fail; b=Qqpa/cQWY+cRTJawDWeD5eF+4GiXEKOKVZDkHhoa1k5J/YL3z0QXuLu81FI53F54rlkJJrardJMKEvFfqNpold5SwiqHiTuMM0ehA7nLuw9pKDF019ammklguz9RmmYMMLLKt5FkBPNDdB0RF+/F+ivVnr/verUuRIim0bFSpXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150287; c=relaxed/simple;
	bh=gCnFMIwPVsYyNnzHz2A2Ver4Lr+Ti2xbzdRrpzUsDY8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=i7chHq05i7lMZ6HJi1mAMmeXUD7y9rHzDniNkpKo9NHuuqLOTKn8sbnKAyW57v9CAEnhTrJGJJnMczqneDYUeVTTXZJ2UyCs/AqEz03yNRdPnaOtdotvFSre7/4M8vWdDeoKFvIv5gLfEAkayncVQj6oHO7NKuPGK7go77/8KU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmyiaJZQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmyiaJZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756150285; x=1787686285;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gCnFMIwPVsYyNnzHz2A2Ver4Lr+Ti2xbzdRrpzUsDY8=;
  b=LmyiaJZQGWzisOhUUOtpFyZPtXJQOHyOUInALQPhKDwfP8R9parHioBs
   yT8gHhgU4tim6J8SYJnmw+se4FbIhNiXdBVkDL32BP0YxLPaI82V/5kZM
   fW+9OKLBoGmakuUy1oXj2OCm+5tc7V2grZIZvEhu8hgl1XZrklFGnqf1S
   GPk3WJhfpBLzq7gsei2fuyhKemRGjVoLLPAWtlQXeZ01nXS3xG35VFGXp
   GS4/Ct0dqDmO3x6CycmqQTgyDPZit8mNWnRLr6pMprvRfQziPMMYnlnxL
   2mr+Ahd6y8EFDmLM8nIWaS85ZgEROEuG/g0R+RuiNKBLqpqDEzEIcGiSu
   g==;
X-CSE-ConnectionGUID: M8cjPd2VRaCQF/m4apXL0w==
X-CSE-MsgGUID: /24wVuq7Th+3e2Bwwa6Rqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="45950117"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="45950117"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 12:31:24 -0700
X-CSE-ConnectionGUID: RpSi5n2AQAap3vOOp4NLdA==
X-CSE-MsgGUID: B8XWE1fPRXqaxmwNsNzyRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169552788"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 12:31:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 12:31:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 12:31:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 12:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud/oPRCyYA7PmX79xTbe+ieYfF/O2n0XWXlQXf9pIkdpqvEWBvm+bhE7+J5YGSUjj75MJ98ne3n53/3y0ikJoEtawcoL/WJr1dIg7TDT16iDbMpixbHbHhiZ3nOVVqnitxVygzLjiNcY3XTQSbF25uP/dhmUktSFGNXh78UOoRb1u4j8ZCXmeiVsyP/17Af27U/sFaipP/Hr96Vkkj1uv9pqtDDIb0wlpCyexibYNuUuwNBZyBvs6mVavzaFnl+2h3rhDje8voNv9XCW5f90COUQi9a2cLf0qnNkve5ehifVys0Qg+516wnx8VaBUcdRPhnx3TqC0tE2H9vYUe0mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQii1yboBGbMcAE9qh56zwwzS0S3A1kzAtZXuL1Fm28=;
 b=h5Qjbx/7k3d28CB7H9iXExiRwF7Z7f8K4VnsT3G38J0IQ7NC6aQ8ONcrhHDRd6Qqjy77Wg3SBMeaLVGrPVp/MC6LajV98YV7KAhwAd6VQHERuTR2+D82eghvTRPvOpiTouoWxoY0Xz5bJ1XKz1HDR5W7/pHbAdews1JrKBDj7wMeeC6HVQARNqN4JagpxfR5HhV1SupGKhKFDaCi9KrKtv+6Bb8Lq8Iu1nd4ziX7PT2R0HIkGoBGzba3WDwd3Pp96TRuh0yi65Yfg03W9Gi9QcyjSpppxkN7cfc/By/9KlYVTsbGuv5HG67bKOHXUil2ylWiYgrrgoMOXi3nYllkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 19:31:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 19:31:20 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 25 Aug 2025 12:31:18 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <68acba06c773d_75e31009@dwillia2-mobl4.notmuch>
In-Reply-To: <20250825173521.2788927-1-dave.jiang@intel.com>
References: <20250825173521.2788927-1-dave.jiang@intel.com>
Subject: Re: [PATCH] cxl: Demote extended linear cache missing emissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: abe7f170-749e-4db4-1f34-08dde40df7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2hpa2ZGTzFObWZzS0hDWUhtaDBnVzlOd0I3aWo4Z0hkbkhSbGEzNDNyZ2pL?=
 =?utf-8?B?cEVuWHZQN1d3dVNDUThaYzlaYkN5bVlVMWtrblppSGlQNHNpRTBQWDdrY2h0?=
 =?utf-8?B?K1czQ0RLL3pORHVtRzZsWHEvR1p6RzZBUW1TQ0FsdGxidzZaRUxackt3MVFz?=
 =?utf-8?B?ZlBwOFAvcmVZZnJ3TFVRREZwdzVQOVE1d3IvZ0xvZVJXYWUwWEZjMUU4SFd0?=
 =?utf-8?B?a2tyL2l2bTU0V2FGR1Q4VlVkazZLRnhwY1BTUlV1WVFJSmV1YU53MWprRmZG?=
 =?utf-8?B?R29YcDAxUEMwUnRSc0dRZEZpWU4vUlVvcWRTZFFRYUEzL3ZDdzNiRGJScFRR?=
 =?utf-8?B?Mmk2L3lQRjNnay9NTTlvY0o2VGJKYnJGSmIxNWJYdHNmcTZpeEpWZktwYTJ2?=
 =?utf-8?B?WVhIRHBXbklhdXR4NkowMlVmTUJML2RodEcwVVFoTnNtR1gzam96VHB6bnpR?=
 =?utf-8?B?VlZwYXJlRDIwem53bzNQb1VIbCtFUWxyKzFnQURtSjhyZnVHR3RPc0FVR2JR?=
 =?utf-8?B?dG8vaC94SjV6cUUvYkh4cmtmcEdJSlRwM0VaNXdiMGxVcS9nVEJKbWRMUEt2?=
 =?utf-8?B?d0c5L0lHYmlJNWtHWldmSFdaRkh0TzJsS1oycDRDeHhvbE9HRG5POERYOS9F?=
 =?utf-8?B?emNNWXAxZnNmUWJVZTA4MTVsMG9Ubm9na09tUGtUM1NmdjBaNFdhSS92OW5K?=
 =?utf-8?B?amFvRUJUaW1GSmVNcytHeldKenQ1YzUxTS9FVjAzOFB0V2wzZndXZW5SOUFw?=
 =?utf-8?B?ckhqKyt2YUFMMCtnM2phRXVPVXdvY0NLd3hMeHRmZjgyaWtCLzdGUXR1Z2Zr?=
 =?utf-8?B?SlJua0UxeFAyQ1FzSEdQRU5sMkhJMGl5bGxRWm5NUENyci9kdlloR3lyS2hu?=
 =?utf-8?B?cVY4M2RnM3RkeWpIeWpvSmNWNHBJV0dIK2VHSEJ3bVlMNFVxRE1qKzhBVnVX?=
 =?utf-8?B?WTFHWktINWhmNUJKMFV5ZXlIN0RxZ1hWU2xLYkF0ZDdhbUxFYUQ5SCtNVFR6?=
 =?utf-8?B?emswM2dTMVJXbXdoYTV3VmcvUzhaOUhrNDNWRTZzUFM3UzhzaGtENUQ3bjhE?=
 =?utf-8?B?Mk84QjcxVkM2M29hc0J1WUtKVTJtdHBCbEN2Tlo4L2F5cUVJdEhVYUh2ZnJr?=
 =?utf-8?B?R2JmclkrWjJNT01WL3FFTDN5czhwVHZvL2paUENrZHNQT09FWHFmaGtvdDlR?=
 =?utf-8?B?STVobnRSdDlmQW1ZUVYwSXVsRGZSQ2d0WnYydjRXdUhXTzAwYTBVOEh4TjNn?=
 =?utf-8?B?UnRIbFJrWGJyRXg1VFU1YnBpSHJQL2J5SGlydW0yV2lBdjVMSG9FNnhManh6?=
 =?utf-8?B?Rzkrd2RyY2ZLS2RHdVJHT3VUdVRLU1JBUENaSFJ5WHFyQzN2OUhtV2hDaUhr?=
 =?utf-8?B?c2hvblV1Y1NrMStDdGtjY1Y0TmZsdnR4ZUVHeVFna09jY3Jmdlk0eVUxZHpE?=
 =?utf-8?B?T1VJZ2RidmVtQzRzalFTNnRGdTREVVQzclNRWDMrdFRYUjJlK0NSMUxQeXBs?=
 =?utf-8?B?bjBtTkZsTHducVRVc2MrRjJNWkdpZUR2SUtqTHVuUHVYYnRFc3NSU0JpN2I4?=
 =?utf-8?B?dXVoQjQ4dlNXdi9uNk02YSttaW5oVkdMZEVwbW9nc01IVkNwK0RRR0Z4MHpy?=
 =?utf-8?B?aWcvM1BFNE5iQ1RxNlU1L1VhcVhiVVQ5RUVQaUNtdXlwV2F5QnJSekNQRnRR?=
 =?utf-8?B?VE8rTE4rUWh5ajBnTEZLZEdkNjREcDV2dUw1MTI0M09HSitqUWRFaWxaeEhB?=
 =?utf-8?B?U0IxR2NJY29NdDRLa3AxSllYN3hyZ1lKckJrelRmY2N2UXYvV1RRNkN5Slcz?=
 =?utf-8?B?Z0FmdkdCYlNKdTZYREVVRWZnQVNoTjBhbVkzdkhCeElMb0xQRmU2MXc1RmFV?=
 =?utf-8?B?ZTUzM0ZJL3hsNTJibWVNZWxUSlBXMXV4UGdYZmZDK2RMOGhlaG1pNk5Wdkdw?=
 =?utf-8?Q?FzKCOkD5AUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0E1K0xlSFBJS2haUWY3bmdYUlY0ZTVzSEtKSTUyMmNPV1BRLzRPU0FwTFda?=
 =?utf-8?B?eGVycVFUb3h2Z0JYYXZ0bHNQQlo3ZVVYVzFKdVErWFI4SVhyejJUWWpCank0?=
 =?utf-8?B?RFVmcnJpa3gzK1NtUFBLdGRzTEJ2enlGNnlIaW0wMW9NQWFyWTI3N1RqQjIr?=
 =?utf-8?B?VnVuajhWRGh5eC9UTUdRWHNOenVHeEVXMnRML29PMDc4WWViL2llS250RUow?=
 =?utf-8?B?U1lYSGxzdms1ZGhQdkQ0N1h0VFh0bk1aQjRLSUk0NEQ4U29Lc1haTk9RZERi?=
 =?utf-8?B?bzdxR2R6cGdkSXhRVHJBenhmbkZMM3lWa0s4dUNiTEpBZllCak5EaUZxbHpI?=
 =?utf-8?B?UUFzbUs2TUI2M1pkNFZiUGZEOVFNYmd1RGp1a3lZQzZDL0ZTUTdQaUFpTi9m?=
 =?utf-8?B?TXlQcE04UG5vZ0xVNVpCcHRtVDIzWWFrVnF3V0xOeU5ER0tVdFdHd3N6TWJX?=
 =?utf-8?B?NXc4Nkh3SVhWc0tYd0dUVG1tSGVwelhSdTZBdXBoelk3VEI2UzFvaEsrV290?=
 =?utf-8?B?R2ZYclZIUG1OdDVPMGxMVTY5bGtrZjhTTjRnQVd0RUNsZWRPTTBIWEpTMjg3?=
 =?utf-8?B?Q2lpT3g1QmJEUTQyK3NDNzJkQVA5Mk9MRTd1VjZaWW81V1U1c3ovN0gvWDFM?=
 =?utf-8?B?Skw5TS9UWWxXT1Q1K2lCcUI0dHB4NGErbFRoU0RoZDQxTUM4NFR1MDE2TEJt?=
 =?utf-8?B?VUZUYVVvR2E0TFpkN2Ntc2xsTlo3dkJCV1pBWjZLYXczZE4wbXdNMnM1c21n?=
 =?utf-8?B?OUcwWEVkeHVPU29XWndCYTBlWHlEUFkrcGlvYlJtSEFWS1ltVGZqSWZpRjgy?=
 =?utf-8?B?YWFieWI0cFQvVHV2b0ppUzB3cmMrRjh6ZkhjenA0TlZzREphd3Njd0N6UWJm?=
 =?utf-8?B?M1ZyenFpL0xuUkhyRUUxK0VIKzZGWisyQXVCNkZrYW10eU1tSDRpWW5YQjJH?=
 =?utf-8?B?M0RKYis4eERyVUZTcUN0bzhMTDQ2ZlVkV3YvWEd4RGdOWjBPSnpIaG04ZjZh?=
 =?utf-8?B?bXpPbGsrSUQ1LzNKRE5vamxKS0h3NG52bVJmLzdOQWRnZ3ZUK1JDdEtSK2No?=
 =?utf-8?B?cVdCd01XODFTR2FSSklqd29OWXFxY2NnR1lQSjRCeFdWNnFHUk9oUDZ4TDNL?=
 =?utf-8?B?WWVaaG9tY0I2UWVBSUhOVmV2MDFMa3VyREFIYXBvcHkwK2Z0TTJTUFJUay94?=
 =?utf-8?B?VmtBeHEwaFRWc21KSlZtYTlKaXgwQXFKV1FBZFA2bXJNK1ovVFBPRWRCYUFS?=
 =?utf-8?B?TGlGRE9SbkFEQkRNWE9wUUFhVnFEZ0xUVXNmWElQY3F1M0JkemVwcWJGMnoz?=
 =?utf-8?B?OE1jd1hRUmJ2dlVCS2tER2hPMGVXaEtjUnZWOEhUdGZKTFJFOSt0VnJmMnRm?=
 =?utf-8?B?cDFhNHFsVkM1eDJKRUJPd1IwZTYzbStTMUZkQTNHYzNRTFZJMkE3YnB4OFRJ?=
 =?utf-8?B?cXFpV0w5Y2N6YjFOakFjZWZTL3ZabmN5YmswOWtTMTZLSUZSamFqcG40RVZY?=
 =?utf-8?B?cHFaVVRHMHZZQm0xMENtNHc2TWNXaEU0K0NvSWxZbmZrcWh5L2FzZ3FYRC9Q?=
 =?utf-8?B?eG1CMkJiU0EwQ28zVVVHd0FKTHFGWWVnTS8zei9udmRlZ3JISzBOd3BLR1Vx?=
 =?utf-8?B?cXRlbkJySUNHbDczM0c0RWVPbGNVMm9qYVpDWjNUUk12QlVoa096N0VXbjc1?=
 =?utf-8?B?OFRFTDRxdUl3K29zUXlFSEd5bkRxbUNrQ0hPSUt2Y3hOcStOSGxhK3VseWVF?=
 =?utf-8?B?RWRMbWZ2SDdXRCtkcWJvK1o1QzU5N3pQa2ZuazFxTU1oa3FqRXZYT1Z5bkdh?=
 =?utf-8?B?SDRQOU5vQzY2V2UzanFBbkxucG1mUnNvOXNJZjhQb2lSb3c4aVIvemFoSGhW?=
 =?utf-8?B?TmRGTHhEZzlVV2Q2M1VKdUIyRTNMOGpabFBHdnJSVHQyUDNJd285VldrMmRY?=
 =?utf-8?B?N29NZ1VsNlN2WXpKSWgwUDhFajg4clIzMThIKzhiemt5L1BLNEpKczdWWUZY?=
 =?utf-8?B?UGE3V3Y2VEZ5dERUMWIzaURNTmU1Z2UrVWlPRjVoRzJRTzhYaFQ1dExjN1pO?=
 =?utf-8?B?RjF3eHlERzlVS0NpVHNXYjFCWWdRYlF2clVqNWtBYmJLdm5rb1U2NG5HMk9Q?=
 =?utf-8?B?REtqYUh1ZGlBYTBZVUQ4NUtJcDNaS3pHdVI5cXl3dGU2eFQ1elAyTDNIUEVr?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abe7f170-749e-4db4-1f34-08dde40df7fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:31:20.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npFs5kSA/A3wsaBA6MscIDCzaAjpLhfJFwRJ+TWzTX2KOrCTVeaLpNa/qSBIo5b0dMRaoS83+KQOcPdZ6p9SdfXgWE6bVZ0JkQnLImxLSf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Demote extended linear cache missing emissions to debug level as most
> systems do not have this feature enabled and the complaint about missing
> feature is spammy.
> 
> Suggeted-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c        | 6 +++---
>  drivers/cxl/core/region.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 712624cba2b6..e56b3d96cdef 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -359,9 +359,9 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  	 */
>  	size = size >> 1;
>  	if (cache_size && size != cache_size) {
> -		dev_warn(&cxld->dev,
> -			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
> -			 &cache_size, &size);
> +		dev_dbg(&cxld->dev,
> +			"Extended Linear Cache size %pa != CXL size %pa. No Support!",
> +			&cache_size, &size);

The log spam I was seeing was:

"cxl root0: Extended linear cache calculation failed rc:-2"

The concern is whether this mismatch should be reported or result in a
more violent fallback of disabling CXL regions altogether and fallback
to EFI_MEMORY_SP delineated dax devices. I think at any point where the
driver is confused by firmware the CXL subsystem should probably try to
fail safely into vanilla device-dax mode. This needs Smita's work, but
there is really nothing the user can do about a persistent boot warning
unless there is a chance they can get a fix from their BIOS vendor.
