Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813D38A9DA
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114636; cv=fail; b=EzBV9IyUZjnG0GxB7SZRKD8m2NdI4uzRZUYoKmxX5URTgnu6XwVyjTPfwFtdU+qBtA+0gMDsA9+xDOm2IwEl27x5DNJOGAW1Su1VVp49tWNA8LTb6kz53yIpH9PviZ0Tvjy2S8E0ie0No6JfX5EQe4AHTGq+LeXoKNxyrhmAfMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114636; c=relaxed/simple;
	bh=8lC2BLbWcgM/i74mTiti8VBdqipNymsZLISUOH406DE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=TFRcbY/5pIqgPmA3FCmyjLF6SGvXyQeDIrbq1IlRsxfN7pyBquaVQCiiDNr7MRmAVeZvVrEXa6MKCVsQAhIIKI5+Q4ICiGQI03OgUll+tGgNcfnqN+h5eWZoj/LPt5Wp5plcvo/GTINZk3Uw0rHDfgCuanzTGoYLNBdx1N9oUic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nx3aIr2e; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nx3aIr2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769114630; x=1800650630;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8lC2BLbWcgM/i74mTiti8VBdqipNymsZLISUOH406DE=;
  b=nx3aIr2eLbkvWEnxy/6/Zt1/jQ8r7o7sol1PqDvW8RtCWVaTdY7VNCy+
   QQgPEgMzE4S1Xx8EzYtsiQ414ZECrketo+AAwZYh452NeDVFUQlqkJ/ZG
   DS3AHMC/pT/m+hzNagEhqZhUHCJnyzJsQhJ5+RUUTNA4dWEvGG0Ey0sSL
   oHXelUL2uAy+dUL5kVExMm4aWNgmrVlM3g+mCDqk8SRULz9kVVohY3Zky
   UeyRmOn45+JPNQVOrF26qHzqcBk7lgQBqCPGgi+WWGkcQEJWEhkJtHUHh
   A15avlKpIQVB1NCo+zlqXqlrtX9XY8Qr7UCMiTbDdtlILG7WgLmEhxbE6
   w==;
X-CSE-ConnectionGUID: YNgYvjCvSayHzNFpnd/beA==
X-CSE-MsgGUID: RqGh51QURh6UNKHmyMmiUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74219772"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74219772"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:43:46 -0800
X-CSE-ConnectionGUID: /oPJcyM7S7mRcjVekhClaQ==
X-CSE-MsgGUID: 1cGT0rlYTnWlLSBvMqlZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229799343"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:43:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:43:45 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 12:43:45 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:43:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD4zBYMJhadpzFrh+O06hLJ97a4LGaRMGodxrt2x8iR3G0GJGDE2dMJP0T9ocz9eDIv/htEcpCUnS9GyOWgNLpiBj9mfUhvvG/6lMAsTSbUZcFyk9q+9b3JGEsJDbtkjGkthIvGLNBANMMw7xBEVx9FYmM5WAuvaKr+0H3aFp6CG9hID/24AXW8t1PUsevwIJ5UUuoL1w/eSfHL3bVyK7uPTVsWW+lzSw/gfZFKIK93RNXJv3w9Y32asc9jBWWdHNFq9TZMYKXZETG9E52eAswxMiew49Jt0HfUfhDpv28Azv+2h9TTTBjuu4ie6S3z4ILRNdBjwXpHGLirGJDpm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWg3YIcGOWEjxPEjL6o5MUVIVbAi+gY27+0zubra4SY=;
 b=R9qOCBHOC4kPqUJevWT8PUKpyV1szXG942egNd01Jo1LedhR0R7jp+04v3pLOM2fpKPpzApC8ngHpbL/UWfmD8J+j2k6TGjI45jXezAF9NgjJh53sLRo7hndgR+3pM7leTS3EYKzBYlBBtp8mmAs6pdcI55P+ux1+dvxyUAYK3zSiDYj7QLon4SVg7zYXEnzODvsMn0yKft7fePU8MbTf4SkAzVrJIUGBMJeobHEhACrHV054hSB+ZPG3/CcByrLbwrb5pzKqlIwH2qg/c2CmvRXZ7ygipv8R2iZv3p2kyyFqPSYidk5o5pOG5ejyqoxFkolS+1nQ5q/AxKpgGq4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 20:43:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 20:43:37 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 12:43:36 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <69728bf84936_309510070@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122115945.000062e6@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-4-dan.j.williams@intel.com>
 <20260122115945.000062e6@huawei.com>
Subject: Re: [PATCH 3/9] cxl/port: Cleanup dport removal with a devres group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 453509c8-3546-44e6-4ea5-08de59f6eb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T014WmxrbGd6VGJJYVh5VFVDMGtwbXhHOGVSRWs3bDZ1aVUxNVVUNFNacExt?=
 =?utf-8?B?Q2o5VEpVc3cyMzRwY3Bnd3RrczJBdFVLSU5kZk05bXpVQVY1UFlKU2pRcGRx?=
 =?utf-8?B?WUxZREI5RndVeU1RZkE1NjI3REU1eVZkY2JSQUFoaSsrR01XR1Fid243bkdr?=
 =?utf-8?B?NGlXdktNcEtMNW9rSUk3bG9sVkhWdGplWjJCc3VUZlNYT2E5NTUvYk5HNDBB?=
 =?utf-8?B?cE1uUGR6UzJyTGd1WlNuUHRQZWFHdHREUG96cE5XaXZDOXNoMVM1bU9hd3Ro?=
 =?utf-8?B?YXZVNTd3dUsvb1RlSHRzaHJBcjRGN0pTYzJLTmFYRlFiV09XbUtUcjBPUUw5?=
 =?utf-8?B?czF6VUtuZFdrY1JHclVPWXBrZm5wNHJmbW5hdlZoQWgwV2ZRbFJzb1czOEt2?=
 =?utf-8?B?c0MyZjZMaW5kd0hLSkRoTTQ4R01ody9Xa2J2cDlhbTJmelQxYmZRc3IyVFFx?=
 =?utf-8?B?OVUzMmpKMVVMeG5QeTlWTVhuR3pSOCtTVkI4U1QwRnpLUVpyZHBjRGtLc3pW?=
 =?utf-8?B?WE9vK0N0V0NJc2Z4ak1tU0I3bXJ0VkFob0pNcXY5Uk9WSW5QSGROek4wd09Z?=
 =?utf-8?B?RGdLRlhjWDdxMkJ2NU9xMllwSGF1Q2FUWXdmRVY4eDV5dHIrK0podXdSYkZM?=
 =?utf-8?B?UHZkRDgrMUNkY3ltcmVGNDRsdG5QSE95T2NGaTBQN2RjbTBQMzlzeUQ0Rzcz?=
 =?utf-8?B?SGhaaUhEb2ZrZjZyRWp5WmlaeWdoUUdIM0Q5U09mWWhCVkprdlk4UklRUy9N?=
 =?utf-8?B?RXgwS0RtcXdhaElhdWU0K3FWNGFTRzZqbFZsMStjbEtvRHNhcmY5Sk50NTZS?=
 =?utf-8?B?NmdNV1M1cWFOc2FjUGd1djEyNmVpQVFPTng4bGw5M3JvM3N3Y3lReHVwakk2?=
 =?utf-8?B?WXVUZVl4ZlpMcHNRQUJjOGxqd2V0N2U5Y0lvSlE3VFJ4NjJ1SDRCRjliQXNh?=
 =?utf-8?B?QmhOKzlGOHlFQWU3blJ4eWQ4bWdJTllsT3ZCUmY1VTNraGVEb0l3THVvM3o5?=
 =?utf-8?B?YnNTYnlrR1djYzZPWGdKNWhkWk9CSkVSREZOMi9xUTEvdlE1ZmZzWFY2SHpR?=
 =?utf-8?B?YVllZTk0NWpNeGlPdkhxWXFZUjNMdmZTMERONG1ETTY4ZHFkaWtPQ09ZRE1i?=
 =?utf-8?B?Smd0SVc2ZGcwOU1YWE80QW9UMk5xUy8xQXo4ck9OWFpvTG1Pck41ZVRLVGpX?=
 =?utf-8?B?T0NqQkN1ZnJKNTl4T3VVSlNpbm9FK0p1U3VEQllMK1IrU1B5eG56S3FpT3Uw?=
 =?utf-8?B?K0ptdjZIUFUzRkxHbEl2YkJrK3k2eXpqRlVZdHZWYWZlVmllRlBnSFFmMzFB?=
 =?utf-8?B?cUFWb3c3K0cxMlFRdVJyNFlKWFAxL282N3NZK2prRE5YQUsxNVU0TkdNM3Y2?=
 =?utf-8?B?QlY2Tkt6Wk4yb0ZJUDhEcmVpU2VaaXhzVm5FS3ZCUktHc1Q4YllHSllaOExk?=
 =?utf-8?B?cVVVYVJ1TjZ6djYyTWVvSTBnSkdsUGdWRzdHMk5zek9WTlkveFF3UkNyN2xk?=
 =?utf-8?B?YUo0cHZlcUVWSzVLZ1JVckNhM1VlazRKY2pjT3N2UmVZNHo2R2F4aWkwMHVh?=
 =?utf-8?B?MkMrNGJZWG43Q0NrYkdCLzBXVXF5UGJKVXBXN0pCWGRaTndVUks2aHVkMnA2?=
 =?utf-8?B?RGNGYm52c2YwWldxMHRaSkhEK0E3dFFEbTk1cEZBYkxYaFZGQnNRVHZYSTU1?=
 =?utf-8?B?N2IyVVY5T0tSRTNwZldKMGxpZVB2bmpubWsybDlzQXp6Q0ttNmZOL3FOcHUz?=
 =?utf-8?B?cWZUVDB1K2kwV0UzWGNkc3Azd2Z6VEs0bEgwUndGREgza0t2NHhiVVNUZDcy?=
 =?utf-8?B?RExma0g1V2xMZndPUmlZUWpEUHp0M0RxZGUvci9BQ3Nwd0RxeHpXWEhITGdx?=
 =?utf-8?B?L0FoNzJ2M0V2MkVPd3JKcHlReTB6VmtVcmFQTlJXS3VyNzZuOHpwbXdPSkFE?=
 =?utf-8?B?SHR5YjdUUFpRQzhsSVhYQVppREo1YVdNRWhnRm55YmVlbkV3VXVuS0VTQUhY?=
 =?utf-8?B?RmNPUE1DSzNnMWVnWEEwN1gxaVVzUStiQVNNMDZhWW1kZEJTSDZ2MjZMbnJ2?=
 =?utf-8?B?dlU2Z0xENXBVTVpBRDFVdnRYZ3MxWERyYnhOQmt4WDg1N3VpRUduTEJDNCsv?=
 =?utf-8?Q?Moqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUphSjZpRU1SRzBsWUdtZjFDVWhLSGhaZkZuMGJzR3NsMi9tcHZCQkRKK04z?=
 =?utf-8?B?UlZkSzljdzIvcWN4ODBxZENIVlBOSllHM2ZiOEMzZ2thRkVEUzJQZnc2WnVJ?=
 =?utf-8?B?NzVGbVhIaVpJODRuZWFrMG55ZE50L2lXUGYwa2tONUFCWC9VSnNhSXpldkx6?=
 =?utf-8?B?ZGhXSk1sa0lGclpTSGw4N09BdnYvZHQyNEdaUExBVXR5Z1hUUm1nVEw0Tlhh?=
 =?utf-8?B?dEhLRUtIcjA1dTRUc1VZMzZmaWdhVEJ4bVJPVE9wVURPaVB1L2FBL3hSOUp4?=
 =?utf-8?B?RHh5bXpyUVJjQ29SSGNxVnljOVJYeEMybEtUYmNOSFExelNOYjlMUlVxMUNE?=
 =?utf-8?B?a05WbkNQUjliWUpkNGMyaE9Pd2U4YyttMFcxMFROQ0Q3M1ZpUjNQeUlQelVP?=
 =?utf-8?B?SmxjeUVGT040WTBwazczYkRvaTI2UUdRYUVXT0s0RERPcWFOd1ZSbWxBakdI?=
 =?utf-8?B?UmpTMTZyMmZIb0RhNHlSYVdlSnZ5Q2tLL2tQTkNKU3NseG9XUUV3UXNlSHd6?=
 =?utf-8?B?dlRaZENGRFo1ZWhMRzdYMU9GcHZYSjdyMmJkbDlUZC9iOHV0MWgzQnNJOHJu?=
 =?utf-8?B?eVBRZkR2QzRLQjRXN0FLTzRnWjJmekh1MU9BKzljU3NhZjdYcHNJeVNWdjEy?=
 =?utf-8?B?Mk1JY2JHNU9MME9kNGFjVDFMdTRhMnFST2E5UjhSeXlXc2owQVNVOGJVR0w2?=
 =?utf-8?B?VWd1TUdINzFNZzdRRFB0dFNPOTZnVDRWNWZzWmFCa2ROdnFoUmlFTHBVZHpR?=
 =?utf-8?B?c0d1QlBHNllTMnZWTW9qa2psdWtjZkQ5eGsxYXlpTkwxOEFaU2pneE5GdHRQ?=
 =?utf-8?B?ODgyVFR5NWphTTNXSFNuVHVRRVZqU0pLM0o4THJhVnRIYVhuRTcwY0RSYldi?=
 =?utf-8?B?QXBMaGt1cWRsNVFtSS9oaTF5cVF2NEFXK0F4dEphTTBLdlUyaGZibmh1Q05B?=
 =?utf-8?B?WWNyMnE2bUtjcUZ6eVdqRWZzdW96bEhWVHBUM3JCV0JzNVlkWU9JQTJtSDFK?=
 =?utf-8?B?VXBObHBkU0QwWW5LdGFkeml2VWhJa3hLUkF6TS9oQ0RaU1MrMVVtUTRsTUZq?=
 =?utf-8?B?Z3hWbGNFWkIra1hkekRFbmR0bWVYKzdPZnJzWWdubmpBdmNCWDVuZ2xOSFNZ?=
 =?utf-8?B?d0NBeGdGNHo0TzJvcnBVbzlJNGhJYVhJdFFONHdZa2JVK0UyajVKbm94anNp?=
 =?utf-8?B?S244MjZGUlF5VTJoQTBqSzZwYU15eUNoSnFneDhBRDhIOUZ5ZW94M1ViYnEx?=
 =?utf-8?B?K1V4d3BZU2JvZUtDa21CaHdWYVRxd3R5TS9LMFNQUDA4OGMyeFBQVDhDZkt6?=
 =?utf-8?B?cUlrdDRwdnZHVGtTdDNabEd5bFpSclJBWlUweXhyQkZHTGZUSkhHcHBWb2Rq?=
 =?utf-8?B?RzBIZDBxa3B1eHRvWVBmRUN2dHFaNGNIU0ZQaktLcnNuNGxiVk9XOGNZTWta?=
 =?utf-8?B?OWxBMFNHVlkrSDkrRHlQV2lsZmdhcUQ2QkgvdUxZT0E4eHFGSFlLamVBYTV5?=
 =?utf-8?B?MklRRUJEMUF2VUFYWER6RlBMdzlHamR1Z2tINWtSdS9CTXc3SnV6OFBJTStU?=
 =?utf-8?B?bkk5V1BwcVlDSTVUblZkWUZyZGF3VWowQm1GUUp3UG96bUVUNXc5M2EvQ0hL?=
 =?utf-8?B?V1c2bEExcU8wZGlmNzBSVnJEaGVtZkFKeHRqcW5VQitycFF0MXhrdEtTczFJ?=
 =?utf-8?B?dy9udmdtcUcvdjlDU1lxeDZiQmVZREdqZFU5YlhVempSbjNCVFEvUjFIWU5J?=
 =?utf-8?B?RXJJSnE0NzAyMnF3dm5lMEVpajZqTC9nNnFGejAydGpJU1NLdUJ0SUNOczRR?=
 =?utf-8?B?Nm85Vk5zeHVXQ2JJMUVZWHYrTStVb0hpMWF3bzdodnh2bGFYMVhJcWhlTzU5?=
 =?utf-8?B?dkpUREUzaW1tWUNkWTY2dGdtZXFya1hrRURnN2thR29acmVMQVlWdHpLOU4z?=
 =?utf-8?B?ekZzbmZHdTlhQVhEQkhCTEU0SWFPa0Y0MXB3S28xZEVCNlFtcmZkTUVsNmsw?=
 =?utf-8?B?WG9MclFwOExLTDZRZFJLOTNOUGh0MG1DYnZldkUvMmIyQkJhdnI0OFNaR280?=
 =?utf-8?B?SVMxYjF5WTNsd0REMjUzdXk4Q25tQjdwSU9QY3I5Q2RkRWdmZjRLR3ZJNDdL?=
 =?utf-8?B?Z1FNYkNieEdkVnY2SzU5VnZ3bm43UTBMdmVlNHUxajJYYTJZZVIyNmVFZmVU?=
 =?utf-8?B?akFndk0zajMyL21PV1RXRUZTY1EwVDJuejNvLzFYNXBtazlacXpONVp4Z3k4?=
 =?utf-8?B?STJaQTVVajgyY0ZZZ21jamFUajRvV2Z3eTdoRmlWckVVVGNmOGlXNThCZS9L?=
 =?utf-8?B?Zy9WelpraFJqT0tmQ2hlOG1MUjJxTkl6cnBTVzJBUE1rN0tOdjRibUdmQm90?=
 =?utf-8?Q?6iBba8IBsqvMuAcI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 453509c8-3546-44e6-4ea5-08de59f6eb41
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:43:37.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU2/MB6AXr4jcB+KXIV7+OocX+pH8f0BrT8xgKo3u6g7E15HETL3VC63YfnEHdagodvvy7tHqxVjwisXWZbd9AbC0n6wx+j0gYRBNLrtyeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:24 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for adding more setup actions like RAS register mapping,
> > introduce a devres group to collect all the dport creation / registration
> > actions. This replaces the maintenance tedium of open coding several
> > devm_release_action() calls in del_dport().
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Whilst nice, there is some logic buried deep enough that it might surprise
> anyone trying to grasp flow in __devm_cxl_add_dport.
> 
> I like the cleanup.h stuff but here I'm wondering if it is appropriate.
> Maybe just use a goto in __devm_cxl_add_dport()
> 

It is several gotos, I have a hard time ever writing goto again.

Maybe if you can clarify your "inappropriate" feeling. To be clear I
have heard this from other maintainers that are not ready to let go of
goto, but I feel this is rapidly approaching the reverse-xmas-tree level
of local maintainer preferences.

[..]
> > + * Upon return either a group is established with one action (free_dport()), or
> > + * no group established and @dport is freed.
> > + */
> > +static void *cxl_dport_open_group_or_free(struct cxl_dport *dport)
> 
> Can we put something in the name to hint this is devres stuff?
> Group could mean too many things :( Even
> cxl_dport_open_dr_group_or_free() avoids sounding too generic.

I was on the fence with making it more clear it was devres, was just
waiting for a tie breaking shove. Shove received, "dr_group" it is.

> > +{
> > +	int rc;
> > +	struct device *host = dport_to_host(dport);
> > +	void *group = devres_open_group(host, dport, GFP_KERNEL);
> > +
> > +	if (!group) {
> > +		kfree(dport);
> > +		return NULL;
> > +	}
> > +
> > +	rc = devm_add_action_or_reset(host, free_dport, dport);
> > +	if (rc) {
> > +		devres_release_group(host, group);
> > +		return NULL;
> > +	}
> > +
> > +	return group;
> > +}
> > +
> > +static void cxl_dport_close_group(struct cxl_dport *dport, void *group)
> > +{
> > +	devres_close_group(dport_to_host(dport), group);
> > +}
> > +
> > +/* The dport group id is the dport */
> > +DEFINE_FREE(cxl_dport_release_group, void *,
> > +	    if (_T) devres_release_group(dport_to_host(_T), _T))
> 
> Reorder so this can use the typed del_dport()?

Yeah, that is cleaner.
