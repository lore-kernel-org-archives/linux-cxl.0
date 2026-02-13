Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCC8405C;
	Fri, 13 Feb 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952614; cv=fail; b=gy0CbhXRBinwiLOtMXC87ZZbniSG4kVD3/C3/FusH/Gy9TJ21Atca4VJF8mYkT3hwKKghSAW1YKHXA0r/jfkWZrCaLqWKhmB3FmEGZo+c8G/Yaz174eNsTsvFfETwi3J1n90pVdf0F0A8l6MI6Ou9Y18zvcNPX/7cMthuIaI+qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952614; c=relaxed/simple;
	bh=JGi9UivgXhXYaIMXwRPRSJut9vloM5hk4d98lf6AYwc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ZEg2P4zdQYL69o/bCrXEuoUDJH3Syf44oNJT7yRIJe2vG9lRKQmFUW3zaTTeSC6sfLrN00TelrsI1r8radGazxQgFmhYNGg0t3NGiSD7AEpDDCtndFuizBkMnBPw2aA/0uaZfxvGEgEARh/s/rOqtn0BAPc3868It1y3Zx3jto4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8yIk7Uw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8yIk7Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770952612; x=1802488612;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JGi9UivgXhXYaIMXwRPRSJut9vloM5hk4d98lf6AYwc=;
  b=R8yIk7Uw0guMmn95NTmSbkG7w45y147bC0Omo3McUr3WJu2wbAVreET+
   uq11RH6WHOTm6xOTYpAwWYTnuxBFSs5p2aLbb/+KPNAFDdypqnHa3b3by
   VWavqH1vUBPdfJtjK+G80VlcVmOnJlvcLKzR+A/ql7Md77yIeDhsjrGKW
   7F8Bw4nV4bWecMFN64j4Vn7FF4w4znFZbmBc9W5yRj2Kvww5nxBlwtUsn
   xGOS74eorcff/hPnpCXu5cxf6Oq0JdZ3GPf2JvQWPlbrwlYVpI9mgRDKo
   Eb6RvGBxhtr0f4Q0B+Cifapz8CouZSAcV7gZv06Rb0ABVdvbxP4vMMirY
   g==;
X-CSE-ConnectionGUID: 5s2kbJwdRtmAfsrxJF0q0w==
X-CSE-MsgGUID: R/Kn1G6HSUWKOULoTW1BfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82861496"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82861496"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:16:51 -0800
X-CSE-ConnectionGUID: ZHm9HimHSs+Pff0rDknH3w==
X-CSE-MsgGUID: VfKE0043Rne0t9Nw6M4yKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="212829956"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:16:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:16:50 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 19:16:50 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:16:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHJ7T1PH48BhePM32ewUjRASUKiX77DP8nSrRBc/1j/nOJZRinh72ajdsh249Pf3QvjyDGAgB0CYlqAxoMo7o571DRhILsQQkw7S4cXUc0ZU/HzjLEtSqwJM0fLvWl/onfbTo3AqJT78B60JUT5i99O5xXdvRhYerrFT8bWJdkmKEbYqiZHBzYjtisnpMFxNk3f5Y6/84+6bw5EskkiD/EL2IxyVUhAs11GDYE04BR5jkZJ4ZmCSUeVNjdKFLC7SRkeHgCWDQ6haEDuI46E2uvBVvwlxbZJZuMxLf5q/uyJpP9SOLx9d+GV+y+4figpEnidilakMRLAHlWeDYmMNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCRGSi67LSnwTvYETRx7PE46x5MmIxMKwniC2IQIvj8=;
 b=DXZ9m85GXJ3i1kOYHPdk/+0gyA7+K0kr3owJSwHbzRW62pXrybEnQUr2M6XJpgk3nu293O7axwSehUrP/RYQjaYdDE9se0oGF68wYrJFS4/+TC7kWTcea2g3YilCx/NHH4wsJROV0/NLrADhx1mL4al6VqRSYbwEVB84aRi3wk8bdqF6pg0ZnTaW8Zc0JWgS/HsD52ebRsBQZLyv7h2F8NfD221BUvkZVWiBOIOqVTuZgjh3GYKUdaPuGYTZskVsjCjmw+ty9xKv5lrdutvvOdlraxL32H/N1u2gE4QRJIUlylZTdtjP5gDcJRseT25GfIQxqxqv/zgpPSV621CXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 03:16:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 03:16:43 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 12 Feb 2026 19:16:41 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698e97998a33f_1cc5100e5@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211192228.2148713-1-gourry@gourry.net>
References: <20260211192228.2148713-1-gourry@gourry.net>
Subject: Re: [PATCH v3] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1771e6b4-0506-4acc-63b7-08de6aae4fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3JDNnpXZWFxNU9rYmw1bjdtb3MxNmR3eEZRZnFlWkY5TDlld3lmaG5KUnMw?=
 =?utf-8?B?c1NIK1lGN2R4SlZ0MVdHYWtWUmEzVGhHV0tERi9mU3hlSm9rUEJyczAwd0sy?=
 =?utf-8?B?K2Zpd2tSZ2x2dGNBWTFTRCtQNWpaU2UwOU9SNFN0MEZQUVBMazd3a0tvVTdk?=
 =?utf-8?B?OGpwQjRhVXNGSUpXSFg5T1ozMFo2QzZiWk93QVhMNCsvMTZUTjNnUkMwbkl6?=
 =?utf-8?B?RFYrVEUyUndoR05WbDVYeWl6ZmJub0RZV2Q0WSthbnZpWGdFZnVNajhBZ1Ay?=
 =?utf-8?B?RWl2YjNOWXp4QWQ3UDZRTkxMYXQ2L0ZKU245clg5NkgxRjgxNmZWZTVSdis1?=
 =?utf-8?B?bHh2QVZsQkkrSWhhakVkWlpWa3R5eDJEVFlGbDFyV0hmVDdLYkFINWZqNi9h?=
 =?utf-8?B?NmdBSVB5YUZuclh4WmpvbHIzK2U4Yk9haHZUK2lzS25JVmNCK3dnaDdoclA2?=
 =?utf-8?B?c0YzOFZBVy9tRVpURjJhNGZLOCtZMjhjL2NINlI2cEI0QmRXS28vaVNIMUdL?=
 =?utf-8?B?WTl1bGhoVWxoTnpYZndxM1RPWFlYcWE0dk85YWlnM0ViZzRYYXJLczkyN0pT?=
 =?utf-8?B?S09LMEFreUgyZDJKaTFBZXYzZXZGVU9hVlRvRFQ0WDdBVEk5TTdxRFVQVkN2?=
 =?utf-8?B?T3FrL1BaNUMzMVlCendDWVZRT3pRWmJzdGtaeUx6MjlLOWxXbzA1UG9KbmFU?=
 =?utf-8?B?VkxYN256L0tBWTdSc1IvZkxaVFpnY3pkclNLTFphbzdlNUNhclJ5dHh4MFZK?=
 =?utf-8?B?NDJIMmZmbUVUV2J0d01Fb2cyTVVlRkFHQURKZkt1NVVPUWtwd3hCYlZrV2dP?=
 =?utf-8?B?RmhRK2M0cU1PbFRWc0tLYy9mMVZxMTJDOG03V1NQa1pmUjVQVCtzanhJNlVm?=
 =?utf-8?B?cjRqa3RJQmpicUUvNWxQbjkvRDRBYjBINEdKemdsMHNnbDdQN045TmhqUkpj?=
 =?utf-8?B?cTVwaU1TZmZmTFY2TFJFcGJMZmdqTFpjdUQ4d0dCMUV1My8zS0Y0ekFDNDFi?=
 =?utf-8?B?YXNvSHhMZEhsKzNxYmNqT2NGMWNQMkJ6eXlXOFVBcXBjVEpVZHhUNDR1Ukk5?=
 =?utf-8?B?U1FudnYzR1ZQMGg4a2ZKdGdyZUJmTXU5eUg5bCtuSFdXWHBwWWF0Q2VBNEVL?=
 =?utf-8?B?SVBXS0lSUmxTTDdKRkswSFNUbHk3aldoQW94R04yMEFZbnR1d1UxWlBobjBz?=
 =?utf-8?B?b2Zrb0h5U1lBSlhtRjQ1dmN1WXJCcndJajFSOXZCejIva0dpWjFwZkVKN1dl?=
 =?utf-8?B?MU0zVkZKa3JERGJoV3o3SU1mZU9SVksvMUo2WnBmdzVITjRqdkVVZTAzRHoy?=
 =?utf-8?B?MmQ0OVRnZWF1STd1Rm1IUE5OQ1RkcUl6eUZ2YXJXc3E3OWdmNVZ3aElsVVhN?=
 =?utf-8?B?YnZjSStlZ2FXaC9ub2NkSDVpeEFyMWJHREdqaWs2eG5kL2RBQ3BBWnFDZElR?=
 =?utf-8?B?ajFpdUYzNzN5dlIwRURwVjVMdnlqbjcvbmFtaksyODRkSDBKNktxRFZQbU1h?=
 =?utf-8?B?c2dwaUdmQUtRUThHbmtQcTRweURaR0hXZlRzS0Z4bUZQVUlQNHdFb2ZLZlBO?=
 =?utf-8?B?QStjc0hkZGowVjJEbFFXKzdrQUF3WmJ0eWMycTZsY3k0RU1pSis4Z1lFK2c4?=
 =?utf-8?B?a3hyV0pramE2ZFQ3M242eXRIUE9yMU9mSlV1cHFRUlRKby9WZmRCME1raGFq?=
 =?utf-8?B?YzBWWUJZZ1p2TFgrdDlMT1FqeDF0cnlQNEdwdkxHT2JoT0p6VmpDK0QvbGw1?=
 =?utf-8?B?Zkd1dDFNaW03T0poLzlKTm5jSVdZV2ZrT1RJZUZ1MjJYaTRtWDIwbDZRTENU?=
 =?utf-8?B?cGYwR2FQdW1vQkN1UU83dFd1N1hmWUVsd21ScURDcXRIV3A3V0VSTGZCQzMv?=
 =?utf-8?B?bWc3WmpQalZTZzVDNXJoSmNHZm5KbHMyWVIxcUx3S3N6a0dsWXl6Tk9DQ3lX?=
 =?utf-8?B?MWxVWThPYWVHazVqdEg1Q2Q2ZGp4blM4cEk2bEJUSmVDZGR1UWJ0V3VXcGoy?=
 =?utf-8?B?Nk4vSi8yVE03TzFvNTBJYlYwTXZBL3N3WGdzVnpzZnllR1pXZzNwaXBJTGly?=
 =?utf-8?B?endhTXZDOXNIUG1HdTlnRFkzYWNOSW9yTHRBUWFPVHRyMlkveTdpT2RYMFRJ?=
 =?utf-8?Q?RjiM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhDOTVocW9NcGRaSXVqMkpReXBCazdFZU9OSjFpR3JuMk9tL2Z3N2tVNmdv?=
 =?utf-8?B?Y2FGZVJVOGxTbGNHK01Wb0xTd3cxN3VuTlNRUlFlejlVTkVndVJBcHJsY3BQ?=
 =?utf-8?B?Z3FPa21lSUwwSjBPeXh3VUhLTHF0RUhKdm9JTkpjQ3dOUkNZTHVxYmN1RVlm?=
 =?utf-8?B?SVFWd1BFbnNGMkxEaVBnRjJDaVM0dzVSak5rU3oxMlN2OGpsb252dmpHakNi?=
 =?utf-8?B?eXJaeXNaaFoxVE5SNjlPaG9lRWNlWHRwTXFxai82SlU5TEhseDlLSlRacVo4?=
 =?utf-8?B?OVQ2dW04S0dPVTVUUTdRck51WUQ0SmkzcFlKZEIyalJzTjAvVUk3R0pka3Zv?=
 =?utf-8?B?TU12SWxnVU8wRVk5VVNwLzYyRkFyYzV4VHBRNHhTQjJMWEtCWkJjOWJRRW9H?=
 =?utf-8?B?b1dqc3Jma2wxWHk5YmRqSkQzWVppbU5pemozK3hTU3hEZ25hcmxzeGs4OEZo?=
 =?utf-8?B?b25uWnZFMFNTeXd3WDRRb3ZwaVQvRjQ2eS84dm1sTkFUSlBaOGRvNng4QllX?=
 =?utf-8?B?elZ0V21FV3FFM24zblgxcDZyL0dOc2lJYTE1QUpQT21qdFRFYTVnS0NXb1N0?=
 =?utf-8?B?c3ZnVFlQOW5lekdFUHIxbkwzNnQ2cW04ODFXS0JOSDJFbmV3bzAxTUFqdUh1?=
 =?utf-8?B?TmVDbVVqaUt4bzYraFkvODBQZjNaYUhLVVdlREpzeDVJdXoveWpwV3RGMWFI?=
 =?utf-8?B?b0UxN3ZIZlFsL3V0NGxUT2UzcHpBMFMvWFc5S0ZLbHVVYUEzNHBQV2VOcHk0?=
 =?utf-8?B?SStiNk5SWjdkYU03ZlBQZXM5QWVtY04xajBZc1JLem1Bb1BtMlNhdHk1T0I1?=
 =?utf-8?B?RVp0VHBnbGVMSWJXN28wY2srYVcrTnJnd0xzdW9PT05yZ0twek5VYnAwSEVz?=
 =?utf-8?B?cm5OSGV4SHZCOHpXWnQ0R3IrUW5MTUJRbXZDVG15RWNXaUxzbXNsVXMwQURB?=
 =?utf-8?B?NHQ5dk5FN056YjR4eUtUZTgrWDV0N3hRSDlJcDFpZDdTQVZqM0duSkl0Mk1X?=
 =?utf-8?B?M08zTUl3eTRvTnRqZTUwWHFjbXhJYncvR2drT1pHV21qMWNxVE5TZmRncGh4?=
 =?utf-8?B?c0RzS0lwd0dmc0lqMXQyb2FCOCtLM0lpdHB0Q2xpRkl6VzhIZWVDbzBCeEdU?=
 =?utf-8?B?OUE2VHdlcTAzTmdqalFPOEROWEhzalVyOEh4d0lvOTFhSmRscnBTems0L1FI?=
 =?utf-8?B?bENpbnZmcFR2bTByTXlScVhpVm1zV0FrdHJjcjNnUTJQSzFGMVRHRCtGVTN3?=
 =?utf-8?B?eVVsZDBRQmFlSkR5M1hKdmgzeEdLbzhHMDJPVFhwaWRBd0RMZ0g2UUR4ZEJS?=
 =?utf-8?B?dTFEQjJkUTF5T0tkT0hiVFRMWERIeG9HWDREOUJ4MDFxQ1plWndGcSsyTFIx?=
 =?utf-8?B?eFo4REhSWmdwTjhPeXFEcjVvMmVSdkJrRGh3Zkc4Mi8zVEp4MUlORWtVMzdN?=
 =?utf-8?B?eVBGNENRdUFGbk9xOHh4ZURnS0FHOWhuV24rNC92ZEUwN3VDMWZUem1kZDI4?=
 =?utf-8?B?ZWZFd0tyaFJ6bWhsNS93VEt1TmVLcHhacnNkR29rZzRUOTlEb3g1UXNjWlFk?=
 =?utf-8?B?Sy9RelZOWjByQ1VBNVJYUy9vRTdqdVRIUTZCSDJiM2g3MG1VSEJWUzBsWW1s?=
 =?utf-8?B?WENqRENGenExQ1ZPYkRwc2k3QmpmSEFVUE9UUEtDejNLa25LaGs5amJ1bVZO?=
 =?utf-8?B?Uy9YeWR0SGFMMlo1QW55T3ZnZGRuYXNzV1pjNG83azVmanZKNnNPRytLUEUy?=
 =?utf-8?B?YkFtL3hkSHJrV0RPRVk1L2VCUVp0WHJWZUVDSkxKcCtUMFZ4ZDlqWEJ4endS?=
 =?utf-8?B?blA1ZGlnSWE5RVVncGh3Z25aRlVCYW9mejBMUFk3TnhSZzIxNURSNUpoTUNz?=
 =?utf-8?B?TElLWU5DZFNPWGhZbzBQMFppUDZoNk11MDRpRjI5dG12MHNtN0k1YXoxV0pK?=
 =?utf-8?B?YktubmJHd2ZnU1VjT25KTHFhdlE1Rm9YS2lLcE9YcndBYTdDOU1MbEhxUlpQ?=
 =?utf-8?B?MjltM3NtTWxhdklwb3dJdEVWbnhpbVpQSDNZcFR3NHdmbjd5UTZQcnl0d3l0?=
 =?utf-8?B?MTRzS2tlQVZtM2hkYUpPTTlJL2F2a0pwL25CVnpLRmlJZUpBRCt3VUhCNHdF?=
 =?utf-8?B?ekdmcGJ2L0lwL2lwN0hWNURCSUxLZTlybm0rMEh5WVd6a0xDdnI1eG56Rmcy?=
 =?utf-8?B?dzFxa3hibENkcUZ5UnZKZzM1bWRnYWVCMW9kaW9RRnNyemx1eWliVWEzZDZG?=
 =?utf-8?B?NE9oUGRyR2s0bkthZnQyT1JoQU01a2JoSEwyMUNSMjY0VmFDNWlJR2NNSjFW?=
 =?utf-8?B?VjFkZlBIQlFxVGNwQnRIYnBhVVJWNjhrNkdTR1U5QnplcUt1QzZVdHBoTlR4?=
 =?utf-8?Q?TGc/IkDVUiQ/xn3M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1771e6b4-0506-4acc-63b7-08de6aae4fb8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 03:16:43.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nwrj6Tw+2vrVtX/8Wzx5m4GZqXC5dix5jkAWTZN6hN6H6JFta4BvqbQMNqDykb/r2rXAksQbtKsOO6walz0gc5eZ0zcCUm/MqMd/e8hstWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com

Gregory Price wrote:
> cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> and then calls cxl_memdev_unregister() when the attach callback was
> provided but cxl_mem_probe() failed to bind.
> 
> cxl_memdev_unregister() calls
>   cdev_device_del()
>     device_del()
>       bus_remove_device()
>         device_release_driver()
> 
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Add cxl_memdev_attach_failed() to set the scope of the check correctly.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

This was a kreview find? Would it make sense to do something like
"Reported-by: kreview-<git sha>"?
