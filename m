Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776917A31E
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770855791; cv=fail; b=eGrz1o+LWhBZPx3FxrHv1lDWRcJ+khsABylLEZTuMt7D1JZCO3HEL92xpgPu2dlhXrDK0lyCQrw3+f5XujlQp3E0BBviJYiKXfy4FtY5SIQPu0+89tDUUnRJg5nObhZ51VYC1Jyay6pc1xmogwwZKzu7dC0L7AvG7ZeyJIsgKWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770855791; c=relaxed/simple;
	bh=ZSKpZX6EZBf3syXpo3BA8P/JIWPZa2aVD2241YIz9LM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=eNpgdIy9BDlwUqNn+RB5neIbCl46i+SW7pFdXfItzP5ngz3tsXxkpOIAQ0ryLTRFsFsQT/eDWh1r8IZs2fLCaRGprux4u3LC3dx67kZI84ToMTMdL3EUvU/UXQv6RX9EykH7Q7uvtycCxwkIst4N2e6J1jKcSX3eoqgwtUiydwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze+MQZOD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze+MQZOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770855790; x=1802391790;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZSKpZX6EZBf3syXpo3BA8P/JIWPZa2aVD2241YIz9LM=;
  b=Ze+MQZODxXFleNtZpJouz0B0PNjZ/QsdkXZHeOABN1mLT8Ap+XrPzcd0
   3AKkOtbf+CH6satRWwJfRTuWEI7RbYRVfbjLFUxZ2S4EGMZI2qEyfwD6Q
   MOadoiIBM3SdTgC+dVC1+6qXMZrDlTyMM72AcSfDxcovJqxg9o6NTqyFU
   ayD5YULkLJPJUwQWeLwwc0XBkOoENK2cJkwx96TCTXnF02+EbbeWqvLwG
   RA9StDLCL2LDBRDErMUneKN0AAM3UErsLuD7+r5F5Hptr7o1p+5QhQc5v
   SmoslqSqt4ruHeuOike6c/x0eqK+x8XUeJ9N1P2xTWi0WPHDfYwDaaTGu
   Q==;
X-CSE-ConnectionGUID: YgQCeIMCQRWPm24GW2OqbA==
X-CSE-MsgGUID: ohq2zxYqRq+gaIDtJp5U6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89602483"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="89602483"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 16:23:09 -0800
X-CSE-ConnectionGUID: X+6zPYg6SNKMUJZzij3jUg==
X-CSE-MsgGUID: LMo1G4IBSkmTCm3F9QBmdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="217379045"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 16:23:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 16:23:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 16:23:08 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 16:23:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrtXnwWuJkz1aUs+QsiY2x9Kd0BNzVgwy45JG1YZpbg+8z9ovAb59DO5O+3iTQUvWHpoB0MT32WxM1b4CaBahOV+aTtbjvw/Mwqtz28seHnzkcHW+avBjyRFG0q5FwBjixCV7Ur0zZh+BKmJ0zdBlT2R3l8lHCU7jf3cZuTElsPqQYS6HnvQThhndLa8l0TdDp5uo3G96XDn5ec72RYo/BLd+NP8UIsAWQsg3ouQ07L3RQY4ZbwAXRk2g3UNUNx65hI1YIyP6SeXpTw28wl2g0E8o5XCmdNZmenTXIVvRfimJJWfv9JYhZDl8l512YDAk+mba2BB5afGssrsA7upjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGa6iFuaQhbJm1iYssgRJnrx7JxJSAUJiII81ZZAQZo=;
 b=AjE64dnd5RUrp8QFORKyqFZywlYbZC9nSgNjQTvV/e0gSw61geJcte+rlpPNAZ8HMJbMLBHxrvl07xp6ME0ZyBVoljPu08V+/I9X9lSQxEqfOobEOPNlj3SZ6A51fQnDM8VfuHbEtYOkIDl6WoEzI8RDTidPAQ6SkmIGOvu77oYuV+NhkiYafqinwrmF5h+Ph0aSk9gzcr3B8WuF9ozyBYeMoDVX0siXQPPsaNVLEcyv/kTbyvBXNoBz3nZXqYSzNYJBKznRoUiFmXcBSimnYBbnMNufFJlitP3Te0xYSkInlUkmJ9wbviY3GL9bdJuZklERQYc48Nf0gEGxdBHrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 00:23:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 00:23:06 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 16:23:04 -0800
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698d1d68cd683_8c32100f8@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211232630.480509-4-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
 <20260211232630.480509-4-dave.jiang@intel.com>
Subject: Re: [PATCH v2 3/3] cxl: Clean up cxl_nvdimm devices when removing
 nvdimm_bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: addb0aef-a82d-46ce-ea77-08de69cce46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWQ5dXhpVng5a2pvR2ZzMEQvb0xrTEtPN0pob0FhQVZZL3ArSWIvbUxaemNq?=
 =?utf-8?B?MUNobVdONjNoTG53NG5FOEIwVXM5bHZTK3U0V2tyZUJwNUNlRDZ0S3ZTZ0Nn?=
 =?utf-8?B?Rkdzb2lEcXp2TDljcU4wYk1ySDFKYjFpaExLU1VPWUgzMnNka3JMZWxzYjZY?=
 =?utf-8?B?RmNwdkdnaE5pc3p2MUs0Uk9jMWN6SUlNS2xKYk95VEcyb3hJTVdNekE5SGdT?=
 =?utf-8?B?aUdzOU9vRUgySFVnTkxQb1Y5cDhlM3BHb1pVYUZEenhmc3B0ZUlvRVE2RmpQ?=
 =?utf-8?B?bmFJUlFOZTBZVVNmM3FuYUc0aFVzWFFLa3ZOd245MUZWUHFwOFdhUWtGMXFM?=
 =?utf-8?B?ZGRET01WTktEQmo1VHZ4REZOcXhwbURLUC9VaUpoZDZOUmFuNGZwc2tUK2R4?=
 =?utf-8?B?SjAyTFo1MWJCb1pySEZLWnU0TUdKZ0srcW82ajByRVZDSEhPbzBhcjM2WFQ5?=
 =?utf-8?B?TTRCTmRSSHU3K1Jib1N2eTNQV216Nk9Xcmx0STZQcHBkQmQrTWRXSlNpVGVV?=
 =?utf-8?B?elVBWUpmM1pVU05sa0JvdVdjRlhvbng4d0hGYnpFV3QwZkNIek10bFQ5L292?=
 =?utf-8?B?L1BZRlA5RlNQOTBpUjlRUFI1OXd5RndUMzc4UTdPVk9aUE0xYm1OT1gvUFEz?=
 =?utf-8?B?ZWZaRTh5TitkWDNLMUZtZDdXT0RZTklJL01PYTQvTjlxenZJb0ZSV29jaFFa?=
 =?utf-8?B?U1AyU3U2YTUyQlo5d2ExMHdIWG10RmNvQmhuWmJld0hHekFGUjJRZkwwU25t?=
 =?utf-8?B?dWduUDFYbnhaVVUxNGJ4dDlQSDVmRnhENWlSZ0tvdVZZVkV6TkdwV3VScXdO?=
 =?utf-8?B?RCt6WnlFcjBjYmFzQjdNUnhmQ2IxLzZaV3NIeGh0TGZqVmJHMTdDM0Yrbk9O?=
 =?utf-8?B?cy9peEpXcGRGWVF4dkJiZ3N1dnp5YkR2b05pWkx5T1lJY3EvWnFpbnZKT0hB?=
 =?utf-8?B?aTJLclg1ZTNZRkhrSnoyN2Jveis0TDRPcDY4ZHltTjRDRndCRjJIdjRlQ0k4?=
 =?utf-8?B?ZWdHbmxqK2Z2WWNrWVJLNTVIL2Z2cUFXSGZDVWwzalJ2UWwzUEwyVTUxcUZp?=
 =?utf-8?B?OHo2dm1ld0FVRDYwelFKc0UyYXBPOUxyb1Z2WElreXJYb2dWdWN2VWo2VGJi?=
 =?utf-8?B?ZVI4eGNiNDhUUForODV3d0FnUkxzMWN5K0xPT01QRkY2aDNHUmVaZ0poNHFQ?=
 =?utf-8?B?c0JvVjF6QjQ1Y1dxRUw4S1YvM21aL0NWT2hyRTVOSUtjaDBJS1Q0N0J2NTZ5?=
 =?utf-8?B?NWpxTU96YVcrZlRyc0d5T0pISFUxdG5qenpINHRWTGFpTjNpS3h6WEw2Vk5k?=
 =?utf-8?B?emY3Rm52M3UxWEhyVFY0Y1gxRlNoQnljb1ZwZk5YS3NsZVN2aUZxT2h1NEs0?=
 =?utf-8?B?L1c0OG5pR2NnWjRaU3JubnlIUENKblJtRXlwQUF4UFU5NXMyb2d3L3hpTUdT?=
 =?utf-8?B?T09Ja1Rpajgwd2M0VGRSaWdDWVJ5TXg2NUJmcnhqYWFpYkFDSjg3QmJHMzBV?=
 =?utf-8?B?c24zamJnV2pFeFBYRVkvVlJ2Tk5CaHpsNEdsNzUxTTlKZmt2cUVFdEMvZHV4?=
 =?utf-8?B?MWtPbFpmU0NxcmRtM0h2TXAyTEdJQmdWenZOcHlSak8xTDFvSXN3Ti9hRkt2?=
 =?utf-8?B?RWpHU3I2R1J5Q1IwR0YrZDZ4a1ZoSUxVVG0zOUUvQzJNck16Q1daT3o3UWo1?=
 =?utf-8?B?ZXY5ekNqNkxXZUVMQktYSVMzSkE5bEVGVjgzbG80ZW40anRxcTdUcndCUSt1?=
 =?utf-8?B?aTFYY3NJbUJiRlMxTmhyUEZiYTZLM055NlRNRm4vVDI2b0w2YUdONlVsWUxG?=
 =?utf-8?B?Rk9OMzNscjNHVVQ5QWdKN1B5ckNTZHMrdmFpMmM1cG4zMUZHRCtUaytLNm5m?=
 =?utf-8?B?Q2ZkYVZkWVJEWUovTk82cFhyYm1NMzY2YnhIKzFrSGFqZ0lBTWd4S2E2THZp?=
 =?utf-8?B?WEo0TFBQOGNsUElZa0hRSGt2OG5sbHlwVGNLWHE0eVh4RlZqWkg0RzJLd2Rn?=
 =?utf-8?B?VHYrMExNK1c2eWhUNlJ6d2NBYXlHbkJZblZ6TVIzMFQvQk5ORmt5WkZmYmxB?=
 =?utf-8?B?MVp3UVdwODZaem1uQldOQXdzVkl4M1J5TWwxV1IvMkJyRm4zb0JtU0s3M1h2?=
 =?utf-8?Q?CoQo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hRZEx1UmxjOTVDSHI5bERxWFoyQmdVc3hCcmdaQmVZWmpzY0prVVJsVms2?=
 =?utf-8?B?OVVCRWlPdk15ajh2aHVyT0RXL3BrR2c2dWhzQUw3ZC94UXVNRzF3bUp1S3Zl?=
 =?utf-8?B?SEcweXBpS1o3RXBxTG93dDBCQmlBRlZtMU1ZWFVXNHE0eUY0MXRJMmNIb25X?=
 =?utf-8?B?N2NyYWZxamFjaUJIRTUzSWFGZmYzLzF1NWJuS3c3YnJsNEdIQ0hPaHJXc21V?=
 =?utf-8?B?dWZPRGlDcEN3eDNYRFdJUHd3ZWVZM2U0M3YvOVVkcW4zamk2MU1oaWNaRUNh?=
 =?utf-8?B?WHNPRVVxMUFEMFRscExCMm4va0kybjJjM3J0cDI2Uk1TMDE4V0F0bDZuajdt?=
 =?utf-8?B?eUh0VUYyM3U5WGhsSVJ3b3VaaDJUekVHVlczTng5NjBlaXJtdmR5SXFNNzgy?=
 =?utf-8?B?QjdFSEZRNHcycVNEYkVmd3B4R05DTm5keHZqeTU2aXBRNXB3ZGppYVpvVkht?=
 =?utf-8?B?WHdRQWhCRGdGRmRjYlRsaWtGV0crcTllU013WEVDTlB1NWw3cWx6TDZRWmQv?=
 =?utf-8?B?bkRGZHJMR0JGQ0xReHg5QjZGRXJmUHdCdDdEVVArbmo1dlBSbXRvNTB1aC91?=
 =?utf-8?B?Zkp2WkpTR1dWbklyTkFBOGFCblUvdzhWUWlzZzduNkhHckt4Qk8zVStYM2ZL?=
 =?utf-8?B?anQ1a3Y3Qk5Ba0xaMFpOcUcydFMreVZFbjVqVTIwZ041NkpkQzA4Z1lNck0v?=
 =?utf-8?B?VDFNTGxRN3NKVWwzRHlTSzNvb2VLRTNMeWNGTUN0Tk1yNkMvUjV6c0lQTkNU?=
 =?utf-8?B?eDRsWUF2bTFWVGhKVFdaR1VBa1JwMUxTT0ExMEhIemhXNHJFRWtrRG1DdDNl?=
 =?utf-8?B?OVpEd09GNi9tWDNwV2E2c01qcFpoTGtpMkZhRWhaQU8vRGNjS3BDRXhUdTNV?=
 =?utf-8?B?cnFBZTR4Vk02eEdmN3JjdCtWSHZEN1h5eWxZb2FoMnk5eUhWNm1kOXBpYzlx?=
 =?utf-8?B?KzM4TFQ3MjhEOGdzVmszcHBzQjZpUkhucDRyK2ZIZTNONUt5MFNMR0REYVFa?=
 =?utf-8?B?NHRsb1ZXbnRUd1FKaHZzRS81VjBya2tDT0JsTVh5SnQ4QmROcEdaY1JmTE14?=
 =?utf-8?B?b1NjMllDTmVRYlluQU9NZHBiV29qUks2d3dUVGdQbWZCaXdXcWl4Q3YzcFM5?=
 =?utf-8?B?SFlzNlB3WW02WStFNW5Ea2p2eE1MakdLN1F2M3YzZVNldjNCZDBDOW1jazd5?=
 =?utf-8?B?VHBmc2pnY1M3MzV2SWFjSlNYTldnNCtyNWQ1T3pOQTB0TE5XbEZpbmNSZXFZ?=
 =?utf-8?B?Q2pJSDFwZENjaE5vQjdLRjc1VC9udTllcXBDazYvZTBkK0IwS3d3NDU2Y083?=
 =?utf-8?B?NmVmTHJVWUhoS1gyeHZLV0YwdmxGUy9TZFIxVTQ3TW90STQrS1M0RStENUw0?=
 =?utf-8?B?SnpRbHF2aFRUMy9ReEFNdndrTkZLWi84QXdUU0VJRS85Z2xmZkt4WlNkaEV1?=
 =?utf-8?B?K0ljWEZ0dXBmZEtqUWlDZUhpdGhUeHRIL3FmenN0SERCdTVNS3UxSUdwQ3Yr?=
 =?utf-8?B?MmFnQlJHd2xXRzdxNkM2bi9SOTYxVk5hYkRlVldrWDhOSXlteUV2aEpLVEZN?=
 =?utf-8?B?SW1hK1B1MHZYOGVDbks0dE1iT0lna3pRbjU4b3drekJXYzdPb3hjVFhPdWtL?=
 =?utf-8?B?ZUVIRVhieVlFWmZXaHlzcVRkcFlUWHpDNmdPdHhjeVlxZHpTTll2KytVd0ZP?=
 =?utf-8?B?cXY4cG9DWmp4blJtQldWd2d0bTcvVHlxNVVJVXhPZExXcFFxMC90N2tDKzRJ?=
 =?utf-8?B?aDVwb3FidEh1RXZ0c2JUYTFmUCtPZlJ2ZzZYY3M4bWczUFNBZ1gwd0hUYU8v?=
 =?utf-8?B?ai9oZWxPdnJYdldYcGFObXJYcEp2K0lsWVF1Njg4YUpXSUxWWUE1dERtRDlE?=
 =?utf-8?B?SVQ2SzAzV2ZTN21KbktFd21XcGFYTVFMMEt1TXNWc29DQnpUdGwrMTB5ZThH?=
 =?utf-8?B?UWtKMjBWL2NuWUxrY3NBREFTTXRoMTYzcEdXWUNUU2ZTellXSEdNK1UxTFhI?=
 =?utf-8?B?TlVCcEhmR3ZBYzUycCtyK0t0Qk11djZqakVGVSszYkRzbklFUjROREg2cEpr?=
 =?utf-8?B?MlhZR1VWSTUrWDM1akhqZ1RWUERESWExTUtHaUZxb2tXRVI4eUtxQzRzZGNn?=
 =?utf-8?B?ajN3RElsN05EaDdXN0ZpaCs2QXhhelE1Y2NUMWQyU3ZCYkxWNzRJOGU3NU9s?=
 =?utf-8?B?UWYrcEptVnM2Lzl6QUpOdGRYVzUvVHBRc0NUT0xCNjQrMklsdXpxR0p2SC8v?=
 =?utf-8?B?K3krYXhFb21pczIvWVFVd1NPYkpBQkFFNi9HM0pEQ21Ydkc2V0JzcWhEQWxj?=
 =?utf-8?B?WlBLYjFDNWcrVjY1d1hvQzBCM1FOdGhrcVZHRDlmUmdIRVRWM3p2MGt0Uk93?=
 =?utf-8?Q?mI6V+//8GvPEaacM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: addb0aef-a82d-46ce-ea77-08de69cce46d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 00:23:06.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFS3y/aSBeGTisMylwWBj+3wcNOZ7aKbh8rOz40umnM7PwTtig4IhSKHxK1tG2m3YqWv6VNXE/Mp998l2XWiWSp1RBUxd+3aVFXY4f03MPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In the current implementation, when the nvdimm_bus is removed, the
> cxl_nvdimm devices only have the driver unbound which leaves orphaned
> cxl_nvdimm devices around. Add removal of cxl_nvdimm devices when the
> nvdimm_bus object is removed on cxl_nvb driver removal.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pmem.c | 6 +++++-
>  drivers/cxl/cxl.h       | 1 +
>  drivers/cxl/pmem.c      | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index f7f784047450..4edc87ceb993 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -142,18 +142,22 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>  	return cxl_nvd;
>  }
>  
> -static void cxlmd_release_nvdimm(void *_cxlmd)
> +void cxlmd_release_nvdimm(void *_cxlmd)
>  {
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
>  	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
>  
> +	dev_info(&cxlmd->dev, "XXX release nvdimm %s\n",
> +		 cxl_nvd ? dev_name(&cxl_nvd->dev) : "none");
> +

Stale debug?

>  	cxl_nvd->cxlmd = NULL;
>  	cxlmd->cxl_nvd = NULL;
>  	cxlmd->cxl_nvb = NULL;
>  	device_unregister(&cxl_nvd->dev);
>  	put_device(&cxl_nvb->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxlmd_release_nvdimm, "CXL");
>  
>  /**
>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3b79d5c4765a..3f0d927e5772 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -926,6 +926,7 @@ bool is_cxl_nvdimm(struct device *dev);
>  int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>  			struct cxl_memdev *cxlmd);
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
> +void cxlmd_release_nvdimm(void *cxlmd);
>  
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 0b200be1fd36..edce5269a682 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -397,6 +397,7 @@ static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
>  static int detach_nvdimm(struct device *dev, void *data)
>  {
>  	struct cxl_nvdimm *cxl_nvd;
> +	struct cxl_memdev *cxlmd;
>  	bool release = false;
>  
>  	if (!is_cxl_nvdimm(dev))
> @@ -411,6 +412,10 @@ static int detach_nvdimm(struct device *dev, void *data)
>  	}
>  	if (release)
>  		device_release_driver(dev);
> +
> +	cxlmd = cxl_nvd->cxlmd;
> +	devm_release_action(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);

You need to hold the cxlmd device lock and check against dev.driver
before invoking its release actions. I worry that lockdep will not like
that, but worth a shot.

It might be sufficient to just set an INVALIDATED flag in the cxl_nvdimm
object that cxl_nvdimm_probe() can check to give up early on trying to
re-enable the device.

This would be similar to this check in cxl_mem_probe():

        if (work_pending(&cxlmd->detach_work))
                return -EBUSY;

...which prevents reattach while detach cleanup is pending.
