Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793989528;
	b=SWB3afj5GaNRfWtVIBevgNc9yD7fzcAv4+QJOC3Sh0vh+WOH8wSQEGbVTMDWpuGRVSd6
	 Br9SROmanzTbl/o4NC+j0x1Uf8vPAGFKnh4HXxOIqqMEe5UwGo4ApY207J7jdtgZV0HMT
	 NbRtgeEJ8y6xgJnTLkVBvrNrVLda+uCaYDEHHlqMkNkNg1efULONZMyQeo/1Oe7a5jsPL
	 9tnX9UOtLOK37dUijmE+qB0f+hvSW4d9CnT9gIcu0z9FsLgRBmc7OfM7SOUtAH77e1lEo
	 IEqiSU9I0AzTZNFJe0I6yYq0sw7PIAj1+/mWB1l9UoamH5rSgP8HNNZAmeuSj8VwMAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989528;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=zHMuWOdQTtr2VAozq2TkZUCJZs7ho1f+KS6L9gjnHh0=;
	b=vddndC3wxNaTlkSXX/rDgnPkNH5nX7LYMqLVZ85Kryfk0J66Syf5rA1n1hTfZdE4M+u1
	 Vqepvr7FyhWap6jbHp7ycNIgV6Q4witb0CL9PWqudCEDItItxhpChPwWkG5u0KlOlm+RK
	 KxWkf0MQhStz4bUHIbaopEt+ePI7N5wrGSIzBUegkennMW9vsf9R2h5Z/+qCt/byvDl1D
	 wVOmFqbb7cHjy4W3Z8lCqrRPHdVCKvbeMMDFs5eqTs3p1K3LCBgaMOnSTeSy7/pCyJsFy
	 oRQZs6Yqrqu+AJAHeowbnStHlPZKs85WGhpBG/HClDYguOA2FbpdDdSW3nAw+Wm2emA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h4Bj5dGv;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06093606A331
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 18:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06093606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h4Bj5dGv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793989526; x=1825525526;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=20XVdTJvLnz7mdjfLYHKQvh14hjl0z8P6Ez+KItC+Rk=;
  b=h4Bj5dGvxhuxaY1taAAktlHQ5JjCZGPPPKfy6nYjiuYRwwgo88rV1YC7
   eQiMl9X62x184wtYh6bLWlgILhVzf1wfVmRt0IOOfuNz+NNMuYXHMwwVm
   rjp2j+iMqvxP78b8jkEU4itQNOnAzujHKtCAFj0S8eDDJH5h+7Lj6vMKM
   8s6xDHnB8XX0+znY3jMODpbvkZSxhy8/YEjAAEGWVoezt4GZGtHsPiLrX
   gOwXtOKEbtaUDjsI/V6gu9Jp64PUST3sOBsrG5vsuMrl9q9zgH3AIDoBW
   F00owuHjkxqME62wyDymVCcqlLoH4Hd57mjBhyHVdu5lyyll4on0V8POx
   A==;
X-CSE-ConnectionGUID: 1pCsIB3oRISFYEceaXkz+g==
X-CSE-MsgGUID: rrzbQYKCR3+SFjv3AqhF6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2797931"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2797931"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 10:25:25 -0800
X-CSE-ConnectionGUID: p6+jxyB1StCOitwx+43JKQ==
X-CSE-MsgGUID: ups5LeaeTXeXB32lRBJbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7774524"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 10:25:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 10:25:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 10:25:24 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 10:25:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJO3EDu79qR0jTzcNqeCqFxfl+ux5EUwKwsSt0UFhdssYEaPuTAxXchrk/uv8J4Y7WpiduaFz698jVyGS3AISL2Q4XaOvgOqIMVOAt+Lkijqb900uVxsoacGCoDeomhRUeY87eHUyB/vcIIrFBYIVLOpYhN8C5u3yZQnuBMFhuHEjUYK1KRtPBezWpd1XSKs+k1/zYtaFLu35gqwY5miTfic5AKukvb3KyGicXKHh0RPS45zuyIspY94B5kj2bjevlavcQd3QDmshAKVtOa+TN0ljjr9FZ6jk5RTn6wvIvk0e8gJs2PTpBFRDzm1vk5t21PZOMk795WNJThqUEnMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHMuWOdQTtr2VAozq2TkZUCJZs7ho1f+KS6L9gjnHh0=;
 b=YNCK9REYIbxkz3O9Ys+K+ywhk4wSHKIdUxL0Ns1Z2x21ttca39WyzolIjSOF79eZkLBfPalQF2jq1ZNoZEEO1Nib/UylVCVeS0AOBkQUogKjyENzF/sOD9opntnBSEAFyuqWu+rVhLxRPTqZWQcHx5dGiG0M+Q6asVuLmiQbuSnZOeOTRueh+KU1eRO3VUAyoFj1RBHP14EFjcMCzY4qDVWSWBCv3iU2HfatcneDW0TZTlSqjUkqofd5Ni5uVLUC3zxij3MWzq5+qYxegPPFFU/XMsL6erfq8Wt6AR5a+vjzeTr9VWE1Vafrhzx2ciGN8ZqpGx0T0NwyPh39JcWB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 18:25:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 18:25:17 +0000
Date: Fri, 6 Nov 2026 10:25:14 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/region: Consolidate region performance completion
Message-ID: <au4birbdt2RaGrMo@aschofie-mobl2.lan>
References: <cover.1793847269.git.alison.schofield@intel.com>
 <b8d1edde2129a7338ad6e9863a08ae2309a3d93b.1793847269.git.alison.schofield@intel.com>
 <51d3903c-c822-4bdb-9615-5f8d8b0ae3b3@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51d3903c-c822-4bdb-9615-5f8d8b0ae3b3@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa87831-8974-4c84-acca-08df3c334ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|4143699003|11063799006|261013131602099003|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: XUMQunFDSBvgls1pqKL8qN+jToSxubZRqaToHwAo38RAT8kkcCYvkuu+HhgJlmSlw912llBc2pDcp9D8t9gFMgawRHugqy5+RzDyhBCyS3znTJeYNlNf1Gw5AE0csZRebIiy2j1i0D5mL0c8+bWb0fwBGYZFJNNKaxkWvotSfZDFGxEAJRJhOnktfDfas/dHxC8P5CIATePy0q/IuOhq1SlCT4R+Zsz9t235gVbsFWq5EoVtSm1MzZGSAqExDDt9GD5XidIWEKq8qMpXr8SGQTxUOGt5y0rI7BAEjfIv7xJew1lNpf4mnpW2VCydmAaTxqMH0kc9eFf+W4fo71oaDoFO1RFXCCK8gsVsLFjrey67gHRXk7dM7e8bCslaESHdQvYBsAzDQMIJxJPsyaCVtpcW3nFHVuowgXsLseGQm+Qg9DdzWYhJnM9rydJBp55WH5PgYYLi1N99hCMI1axeREo4iNdQgjiWlSbH/ifXGK/GLZLLEpuO4Ajd19SbkbZq8l9NpT4pgoubS/md1Njw3YJEl3vA7C1P3XheD1+ITW8r0US+quUn0QYsARMFGg0QCgXRvOcs7Fw3Y9o9wdtAPgx1acV2jmkKoPBLDTW681s1yAIsUSIUEX9P5J9PWW8IktWTJsZGVfNA7RnbP5Dz2/FGFzI72TM5fRxxEQUkLK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(4143699003)(11063799006)(261013131602099003)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhCRFlZbDc5N1Y3cW1OdHpjc2pUQ1pkZXcwMUlhajNLd1hoUktzeUpRWnVB?=
 =?utf-8?B?VzFpZ0l2NEpTeVBWM1BlOThUV0hxeWNnRVRudFVJQ3phWlRua0NQc3ovY3hZ?=
 =?utf-8?B?MmhHRE10ZFRjYUpOQmQ2STFUTnhEdXVTcXJkVlFQa3JUYnd5Z0FWVlVWall2?=
 =?utf-8?B?TlBXYlRxZkN5UWtBZjhnWFJpSWo2bnZSaW1VSmRORVYxTVhiVEhuMG92TDlP?=
 =?utf-8?B?VGVLQTROd3VNMUtoVG8xUjB6dldSK1p4MTdpbjFHMVcrZ0FsNjZXaExjZXBO?=
 =?utf-8?B?eXRqdWVMajBjSU1iS2lOQk16T3ljQWZGdFJja1hUY29MbWY3UVpIbFZTUGdz?=
 =?utf-8?B?WHkyT1JOU1doaDg5OUdTQXhjcG1XT1FiOFdVS0hwT1N6Rlh6Ykd0MmZTVWNY?=
 =?utf-8?B?Qm5rTzJGeWRPS1ptWFJMQVJTaTV3WlRuZ2FocTBxZEZmNmV6elZvc2drWHlm?=
 =?utf-8?B?cmFTNDNDQmVPSFBmMlBpRHVhaklPejFLbDUzNkNZSit1K1d1QzRlMXR4UHQy?=
 =?utf-8?B?cDl3V291bXM4WUZsckxEcWNEZzBsUnVRc0EvVUxsT3RGNFYwRFlxSXYwcHRU?=
 =?utf-8?B?OUhZL3JuaEt2OW54RXh1K3UyOUtYQUwxT3VTZmhnWjJWTEpkTkdkWDFER2FW?=
 =?utf-8?B?UkFTTFpsenpKc2NaWjdERWpLZFNEQTFxZTlkT0R6emRkbndnZ29kRlg2bktt?=
 =?utf-8?B?U2ZQbUtUVHJ4dlNocnB2TkozNC9xVm9aSEpWcGN1bmVkK1lUSlYyOHo3M2Ny?=
 =?utf-8?B?aExmNVNJYTB0YWRScGY1MmFZWDZ6cDViaW5UVlNVYVVZc0pBRnVOZzc4cjkv?=
 =?utf-8?B?NHNET3RtYUxiVDU1TFp6TUV6MlJmU1RXTWh4Z3RtVjhvdU5oOXpjNlVYNXQw?=
 =?utf-8?B?SEVXZitFeU9OeUc2U3pVSHMydE5pT0V5VFNoT1R3aWhwVVJjTHcvVXZEZ1Jy?=
 =?utf-8?B?YitLTnNVcGlCQVZBQjhYblVEZEM5YnNmUmJ3MkwydHdWbVBCZnpkWWpab0Qy?=
 =?utf-8?B?MnE5SWRhb2M5OWd3bEZrbDV6K01mSzN1Z3hPeXBLT1FTMVBtbndFVUxBbTEy?=
 =?utf-8?B?SDkrZzczVmNuMVg3NnFMWEVHRDU3QnowRG1rZEc4UDk0UDFNcnpJZ3hvTTIy?=
 =?utf-8?B?aDZCOC9HeVVXZndoWi9vQi95bEJJYy9rRXFKaWx3bGl5dCtheDVWakFjbUxr?=
 =?utf-8?B?NkZ1R1ZxSHRBVzNuaFV0d0g5VWh3M2Z0VkJVakw1Z1Y0QWYrNy9vdVhUeXNC?=
 =?utf-8?B?ak9CUExqUXdvb2hGUEpxMHJWU21kYXl1a25KQ1BNbzVRSGtubFVhT0psaVBk?=
 =?utf-8?B?NldTaUEyUDd0NnlUeCtlTytLSm0zdlUwNzlzVWFEUXlEamQ4dVoyNEZXTWp6?=
 =?utf-8?B?NTVNUlZscGFjY3NXNFZJWDJjcis2TDRMSEhNRVZFbmpoZlBlYmhQZFlpOFFK?=
 =?utf-8?B?L3MwaUxrUlJJeDVacXM5WW5wc2NPYThpSDFIN1lRYXIzMmZ3VHdHVGRlcFI5?=
 =?utf-8?B?YVVEOVVHRGFSYUduR3FMN3JSMXJLWUdOVTNaMElGZFlJckNVT3IrSThoZzJw?=
 =?utf-8?B?b3FMYnBNTmJueWt2OEFtek1mWVArRndrVDlnQVpvUEZZWHYxaWpvWXgrOTVi?=
 =?utf-8?B?d3k1SE1RV1N6Y28rNzBUQTFCamg3TVBIcU1KTFdJZWV4b3VseDl1OUh0TENF?=
 =?utf-8?B?WkxobU9yNW1MQWNZSE4wbHdQSGZ3QTlqVzI2TDFsUE9qcE5nZTZxK21YT2JE?=
 =?utf-8?B?bFdaRjlVM010dEFHd3BiV1NEWjJKdjZaUnNtUGpYNFBmcW5uSE4xUGdaZFZ3?=
 =?utf-8?B?dFNBWWJOcVN2cVI5bGZlOHJVQUpkMXRHV25mYldrVmJqWWlCWWVFaVI3VkdK?=
 =?utf-8?B?WUxMZTA4STVlWnJnWmlINitVbXh5cWNwTnBIM0dnUkZlY1hEa1ZDRFh1bkJJ?=
 =?utf-8?B?QVFzV3VCdmhLMVBtQ3lxcXZ5MUdOYW9RSmorL0E5RnZ0TXF5S3RaRWVCeDZi?=
 =?utf-8?B?SmN3Y2VQMUlLNHp3UHdwa1E0ZHN6YlA5VDdDZ3dyaHdCM1BqZGRRNklQaUZv?=
 =?utf-8?B?Zm10SVkzVERNeTFqRXJyV3AvQkk3elR6WEdtOER5dlVJcThDNmdpcnhKMjEz?=
 =?utf-8?B?dFpJVUdibFBiQXpQODVjT1NmcmtBWmhEV1NVNzhFUVpZUnNEaVYvcWREV0hB?=
 =?utf-8?B?RzBHeXg5NTFUc2I0K0xENS8rK3BMR2FvOXdxZGI0WWgvYzI2clZuQ2JKcGVy?=
 =?utf-8?B?Z3phamhpM2tKUzRnOUREZVJXWjc3cEZOc3lDOStHZWhoMVl1bXZoak4xb2h0?=
 =?utf-8?B?OE5SekNCRjE5T3JJSnNrTHJwZTBvRXJVa0ppdFhSeC9kVW5iTDFPaml5S0hK?=
 =?utf-8?Q?QaopGsHD5ahszUSQ=3D?=
X-Exchange-RoutingPolicyChecked: 0DhSYpWtZyVpuodAdWx4PIM39JYMl6gw5ZY1ZRP/tB8opR0JdxBez25QyEAiFmMW4cu6teXp+FJZI4sVFJclGGDSalI1qa3qOagGwGNTsTj/dt+6KTtoFMKQLt1jdZ+EzKMN9EZ7JVnohWy8658+fyc+w9X+3hJU7WJWeSX8cWtipg5ob79j3kasSerT8pp9GeOST6+qcwcz3TdiJMotut2Pq1GOXWWQFKyJC/LkF46FnEoRlHEKNKRcMLx7iZ1a/ZUi2JIfw9GdHG0OCRbHebm6ceL+7f1pRyM9aZsUgxCD3fhwWtAkhzc+3veyvwbK1xTFVEy9tdGB0TNOmCHqIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa87831-8974-4c84-acca-08df3c334ee6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:25:17.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8N1YlXpwtpU07qBDdgK2j/xm/X+0ypvnfjVFM/K69++uZ5FFZsm+1vf/GY+08URBQYXa6y1dK+/D3OBjbHXbhobgpN+HUun4Q36mZPzU0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
X-OriginatorOrg: intel.com

On Fri, Nov 06, 2026 at 02:15:47PM +0800, Li Ming wrote:
> 
> 在 2026/11/5 11:28, Alison Schofield 写道:
> > Both user-created and autodiscovered regions perform the same three
> > operations when all targets are attached: calculate performance data,
> > account for shared upstream bandwidth, and update the visibility of the
> > region access attributes.
> > 
> > Consolidate these operations in cxl_region_perf_data_complete() to keep
> > the completion paths consistent and preserve their ordering.
> > 
> > No functional change.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/region.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 50cd483d710d..f9435e65c695 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -157,6 +157,13 @@ static void cxl_region_update_access_groups(struct cxl_region *cxlr)
> >   		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
> >   }
> > +static void cxl_region_perf_data_complete(struct cxl_region *cxlr)
> > +{
> > +	cxl_region_perf_data_update(cxlr);
> > +	cxl_region_shared_upstream_bandwidth_update(cxlr);
> > +	cxl_region_update_access_groups(cxlr);
> > +}
> > +
> >   static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> >   			 char *buf)
> >   {
> > @@ -2182,9 +2189,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >   		 * then the region is already committed.
> >   		 */
> >   		p->state = CXL_CONFIG_COMMIT;
> > -		cxl_region_perf_data_update(cxlr);
> > -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> > -		cxl_region_update_access_groups(cxlr);
> > +		cxl_region_perf_data_complete(cxlr);
> >   		return 0;
> >   	}
> > @@ -2206,9 +2211,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >   		if (rc)
> >   			return rc;
> >   		p->state = CXL_CONFIG_ACTIVE;
> > -		cxl_region_perf_data_update(cxlr);
> > -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> > -		cxl_region_update_access_groups(cxlr);
> > +		cxl_region_perf_data_complete(cxlr);
> >   	}
> Is it possible to call cxl_region_perf_data_complete() inside
> cxl_region_setup_targets()? So that we don't need to call it separately for
> user-created and autodiscovered regions.

Thanks for the reviews and feedback Ming -

That would work, yet I prefer to keep the two calls explicit. That makes
it clear when the region has reached its completed state and perf data is
finalized.

Note that cxl_region_setup_targets() configures port decoder targets, while
cxl_region_perf_data_complete() handles performance data and sysfs visiblity.
I think those operations are better kept separate.

-- Alison


> >   	cxled->cxld.interleave_ways = p->interleave_ways;
