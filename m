Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF0368272;
	Tue, 10 Mar 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175056; cv=fail; b=PJShE5noLcPM6jWaVRAwaNv7NXFqW1ycX4MsrrqVdnhZvF7bjfreQiQ2e6iBrC7w3MNKh5Xv56KSy+rPxAKcxSC2spwfxNjLzcZm30B8cQpKdq16Vf3r7xzWKV9Pbbv6JiDOwwlUo/BYrSKC5gp2lK+VO8TY28FddRk0tQyikyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175056; c=relaxed/simple;
	bh=i5j/lGh2P9uZHQDNepFfU9L+Y9JLch7uTGZWoJLmKq0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pPG/U4jHMx3dgJuomj5CiVV75Q1WwVq4XzigU3Wo5gnE674xTt6L6NQ/VD3cs0neA68YkJp0exqhmGOm44wQ5UXP8Kel7dSVz1fDvm5tBiqzKs/0be5Lc8zxls20nrmCd4DeiS4Tb3imWpqiHGe1AMSRYf2U6GV4/mPHtaY1i9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+tFq3q7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+tFq3q7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773175055; x=1804711055;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=i5j/lGh2P9uZHQDNepFfU9L+Y9JLch7uTGZWoJLmKq0=;
  b=b+tFq3q7y5zymYXuynYjwGSm93KcLMG36yE7N/iadi8MX8LDziIE3R7g
   H//2OVzlgwHLEMClZm7Xwt8oYVbewyKUPFzD8F3fu9nbHMkEfd3Vee4h1
   9vCTHtU3kcy4oJc5GqMoeyyLDRrpvAhor84xAoeQhvvJtM9dM+3YiXlfQ
   N+Te9Q8j9axttLATCKFSwfXyX7EtQvljHj04SPApZRc1oMvV9odVolcoV
   M81wx0OEYnNnKJrKxYhT4Aw0JrWqnxCIzCZcWCN8TaQvBeAHjcb7uS0z/
   7TMhLKpkLgCXfMB6Lv+6FHLTHbK8YC+i1fs2l8/TLPbWI1tq+pc3xNiL7
   g==;
X-CSE-ConnectionGUID: troTWxX/QViR+ZpnZo6weg==
X-CSE-MsgGUID: aW1giP+ZTGG/N/L3TXRPmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85710415"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85710415"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:37:34 -0700
X-CSE-ConnectionGUID: sG0lryKYTpm3IzBYZRVcLw==
X-CSE-MsgGUID: Ru8jg2XGTcKs8AkvRnMPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219354008"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:37:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 13:37:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 13:37:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 13:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvzhMHbPS4znrGM8VBws3AtqnuMcBOCsCYq//mqxaOzDPX2DvsWEPklSKKf/NdvitaO2UBV7di82ZMEE7HAwk9aQv4nnoGl/gDawDFNeEYjrg4otftrEuuJT6qb8Fqh6D+Px6hrcEXTxspNWZErMrtqPLzp0E4LJJYCOtjrkTAfhLjCy+jNrxmPuYRSCWotPQBjR0So1KOLghteAlAxIh6wgg6mvMCos6p0+lZ+CRyz+R+K3ZMTN+0LAumU9TC7Gq0s87i66wEA982AHNTjVZd1yjtCGeOybtbnYJdtrZpPU937gO4WQ2I0+8hhPRWXP2xD+oa8Vhsi1EXBpEWWu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xard1xWlFpKzcm/ib8aTS7AMB23fMbb/2rkJiOzUsGA=;
 b=lCYkm6WZ9SQj8AQqCaKDOEXAx689tzoxwJSSyrkcEHpl46AvTDq1R/D7Lx/r9nBnoYRJYXnzmfjAQJ98eAQchchVDjygOhZb5JHq1+w4YUK/Vx+9YovfzIUkSwLEjd0TqPzRstimDSmaBGAkhhvzrcLkfhUtj6OkME4LvKpCencc9kGZVMgni5q0izuSFVvcrkr497W874emhU9NFjmVCH4uv4zU701+wD+2CIiAjclsBeh2g4VPVnDO+y8h/qMFxNe1D02ICGOa6jwzJRflcSlON3QOmiA8ozrX2HQjwuOIrym7O9UTUcGtOrEbaxJRALT/IuOnuyKEyg7z6vh0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 20:37:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 20:37:29 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 13:37:28 -0700
To: Danilo Krummrich <dakr@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Message-ID: <69b081083c1b6_490a10085@dwillia2-mobl4.notmuch>
In-Reply-To: <DGZCEIBES82T.27Z7GZ605OVB@kernel.org>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
 <127f99e8-f673-4cec-a573-be2257134f59@intel.com>
 <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org>
 <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com>
 <69b0654e4ffd1_2132100ce@dwillia2-mobl4.notmuch>
 <DGZCEIBES82T.27Z7GZ605OVB@kernel.org>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 40871e12-b9af-493f-0063-08de7ee4d930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: UEc7+XruPO1lRJFqkrP38V4elE1HTx31QHWlaV6OP3bVKEOgTLe7GYHiPKHSoen/09RLL96boO713k+c425Fo5M1PYlY2zU6NWvwIOPcdZnQfps0H80Xt3+MUN7sEftrd9VfkH/JsafCvRofYBDsXV4XVVPOx/9SaCUMjdYrfY9lZ5BZD9RBorUUDcGtRbhFmz+QoA5kfeiKLNY5SEo8Tkeh6eipSfnbOgn/CRkBZjBPGkPS0a4fVRpnYY7x9F5IKem0ovVfLNjNTPnBoIC2MFYETdUWIrUwXuBtz1Q2UEJTn/QOCDe2fp+ZxGw+LccbgwiEmaFVEc6fNRNVNEcwVJqQxWIl25uQiCzXibFRL3Dl2+0OdbEFZdtuLuChoL9WfQHCpUBs8+eALxrUf4bWjgRvnnhpS64Xd8lfaFD1v+HjhqkcUl38ytq54Sb7J0ux5DRR87aeFSBGYbdwMa7hnSJJXBYDcC1LF8OMAMMrTgrdljtcudzioUOTyC1PgcHdzLMC4hLSCqmbNrcqCXTuGmOkEpX1iAbPbZA1wtzWsdSrgKSR11gElDjKYhxpycduGpARepcsykrl+229zkXBE9eFVSDFTn7MlYYo5bwLOsQop0V/Jd7+oCFjwqVBOYyXpzS/eOJNZiGosDML3wcHcYqf0HflKdY74JaKSVev8QaUjABsdoGC+Jxm9hacHtZ/3YCBN7zfhMi91IcuNaPmEKvVq1HlULgiaAzV7RzK4ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFMMlN2b1BwYkRKTHNZUy9FTjdnaFl2ellSMGVlN3BQV2tFTlU0SzZScUtR?=
 =?utf-8?B?a00wZ21tVlZ6MGREQUNkdCs2Z2RtSmQzVS9yMFhpeWJIL1VPQVhZaFNXODB4?=
 =?utf-8?B?OG12bE9EL0VTY3ZoS1A1QTFYUUtiUFM5Q2xJMGVhOEdQMFZvZU8xK2xqd3A4?=
 =?utf-8?B?VzRVdHVzdXI2YnRRenBucy9jeGU1aXNDKzBwMHhLb3ZBL0tEd2c3V0R0Umdv?=
 =?utf-8?B?UldkM2FkTDJDcEh1TFhTaUtBcy9hT3pTaGlTWlpya2xQOGRuUVdFTXArWm9K?=
 =?utf-8?B?R2VUMWVVd0w0S3BHM1ZjT05SZ2ZqeDUxZU5ZTE0xZHhhbXNCWmJnYUxQcjRu?=
 =?utf-8?B?bnE3ejJxbWtnTldoUDdSOWw2b0NGYlE4ckxZcnFicnJSa0xOa0ExOTFGWkFG?=
 =?utf-8?B?Vk1rYjJKbk9FSzd3TnZib0ttY0MrcGdjLzJYak53U3V2YkFtUXpibHZqSmoy?=
 =?utf-8?B?NEo3NTBpTE1IRGVsc1ZLelhxM0g1Sjc5VFR3M2EwYnNLQlc1YmN3dUlKWVdV?=
 =?utf-8?B?SjhCKzRyNG9FcW14bmJZUmFSL21LelpmSUJ5MjZZNGRMdzZ3RmdMRndvZlJB?=
 =?utf-8?B?RWNhalkyRDFTczc3M01YQWF3T2ExczdUUVd6Q1dDMkVlN2FrRHJLNEJjZzd6?=
 =?utf-8?B?V2RVK3k0d2RkUW5TbnVHUkZLUENranV5d1V1eUtuVTVHYm1LbmV5V0RNdWM1?=
 =?utf-8?B?MGp0MU43Y0FlRGtWYWNEMENyL3ZsekZCVlR4Q2ZOdUVUWU1uaWUzanFhUk9L?=
 =?utf-8?B?YUN0OGZTeHQ1WGpsTURuM1lBVWxlOEk4K2Q3Mk43ck9vMlVGYWRmaGE1ZTBG?=
 =?utf-8?B?TkpzdW5reEZWYTR2SitpVHBSR3BLMFJ3NHgybTlMSTRudVptRU9nSEtMQU81?=
 =?utf-8?B?UDJmdmJLcmlNTXc4Y2lBNjdNRUQreDk0cElXQmNKNmxBbVo0SXBhblBxOE5I?=
 =?utf-8?B?SVd4TGRiMmd6b3J1V2w3WGg0RmtxdzZqR1FZdUsvaHNCUnl3aTNwZlhWQzJV?=
 =?utf-8?B?bHdaT3lKMHVYUTZXSWh0WHNQRUFSQS96NjRKVElzQTNpQW44WXZWUXdiY3hy?=
 =?utf-8?B?dkhJTXlvUTVZS0VLaWFXaEJiQng1emFETklJMXl5RENPaExZTXE4N2c2OTZJ?=
 =?utf-8?B?dUdna0pWSlZ5OEs3alUyazBRNlJ0QW5GVTJFWU1YTTZNM1RORmQ3Q3NyeDJx?=
 =?utf-8?B?QlJrbisrd3BrbnVGTDZGbXFIR3Jja1FjV1dxa09uekhpb252WDh6WlBrc3Fz?=
 =?utf-8?B?R3Fqa2hCSUpObE9GaFN1SnpwNEhPbjlDSVZ3VGdwcDM2NHpIOVdZbkhpNmh3?=
 =?utf-8?B?TmhJL202cFdweVJRTzFBdC9TazBTM2JSWjlHODRPYUhHaFlwTXVHKy9kZXc4?=
 =?utf-8?B?RGs0U1hGeDJjN2FXK1lubDd1V212ZUZuaHZyTzI2cVEvLy92VkhUd1VVcld6?=
 =?utf-8?B?cWc5WlNKQytGdGI3dmV6YU1LQkxrUzE3K1ZHOGpUUVMzUVkwTW9USWVvR1Ry?=
 =?utf-8?B?TFowMW1KMG1nUEF4anJOQXNzRjQwZDl2djBTTFJaRDBtRGpXNUxIN1Rhbk55?=
 =?utf-8?B?SEtwRlFGVms5bm1vSkl4N2ZDTXJ4U3VhYzRaczFwcUxxMmFGT2k3TGJ6T2pI?=
 =?utf-8?B?aHdQNE8wRm51V3VmQ09NZElLZGFvbUNReng2M0J0M1JJQzlPRHhGbXpjN3dr?=
 =?utf-8?B?U2pHY1BRMk9LTkFOUkFGSGozVFU4aythQzRYUGJJb2VQNXVRSlhiMnBTNDh6?=
 =?utf-8?B?Q1FzNnN0NzBCU1dSaXZ6THd5R3JMM2NYNUZwcVFLa1pWQ2hMSUw5VVBpd0s5?=
 =?utf-8?B?QW51Mnp4VWgycWVabjcvS1R3U1U0UE5JM2xQcGNlcmxUdU9FTzMrM2Y2Z0VV?=
 =?utf-8?B?YmFhWVlscFlrUmg2NkMwaGRRd0tYVVRFT3A5ZlpjL0xyY0RqeHg3QURqb3E2?=
 =?utf-8?B?OHdtc1FNYm5kbFpHaTRIRmQwVmhMb2lVRUJwVlE1SDc3MnhRTFNnS1M3Z1pa?=
 =?utf-8?B?bGVUcHJMS0VEaGt3MmthR2wzTmNwdDNBc2JJS0E5WGFYU0dPVk4xN2RLZkhD?=
 =?utf-8?B?K0tJYU90ZDc4WFFBTnE4T3dXVno3TDdCdmVXREpKL3N4c0tLcWZHRDlRM2F3?=
 =?utf-8?B?Z2lrZ0dlVzJBREtCRnIxL2gxWDY1RjRnd2RMWjFUSzlIbCtaV2c0dHdOUTRn?=
 =?utf-8?B?YmxPd1VJdDRpR3ZTV0llYWFJcGMwSUovNjBSbUJtRVlDbUhwTm96aXQxNkkz?=
 =?utf-8?B?TzVVaDdHS3dlTG9ScS9LcjNmV3ZPKzlXcUlSTWtvYjJmVC9FRTZNNDZTRkdh?=
 =?utf-8?B?SXlqWjE1OXpXUjNWdld4SG8vWDFPRThuQTVkcnVvdTVKTzVtbkJiTEl2Y2kv?=
 =?utf-8?Q?afgTK2EYGZFC3/qE=3D?=
X-Exchange-RoutingPolicyChecked: MBDBqYaxkfw2bauvwvtQbdrgcT/jkaOJIa43pNO1gYMAErzI2gkAlJdOhfMkE4G8cO5ZfHyocB5+KXVRKZsTDuTLfM6Z77P+LOOPlatAtN7Veg3S82ZstRs8xqyuMJwB3hA10e07q2xLLKONYTxj7R1Yp1IWOukozdCA9HjSYvksDwO/MpoeL7/R3ukw4euvlSCe9yRCbN/ZA/49QUkTpO8H6sc+weW+rNQCN3cacGyxrlPMeflTg2x39Y3gNSa9SmpJVlNzvc23jSIxEFcXpHeFSF1PKrJ+LADEx8xLZ2eaJOtLJzT7QJDWsBS/dxoPzZgV/uMj8DAZgvNnlOmQxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40871e12-b9af-493f-0063-08de7ee4d930
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 20:37:29.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AglfL6F2IC3414Xf0v3Z1iuX7ump9E6TWPyHLlEuTTiGqjdBKI2BFHJIh087DC+IDAGlC/KYHJ8gNeMrbEvP76FE9kLthdXgTEvepPGbKNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com

Danilo Krummrich wrote:
[..] 
> As for sharing the commit throughout multiple trees, I can provide a signed tag
> similar to [1] once Greg and Rafael had a chance to take a look at this patch as
> well.

That would be lovely, thank you. Please take this patch.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> You may also want to sort out authorship / tags with Li.

No worries about authorship for something so tiny.

Also, I misremembered that I sent the base device_lock() guard as a
standalone patch rather than with the first user.

[1]: 134c6eaa6087 driver core: Add a guard() definition for the device_lock()
