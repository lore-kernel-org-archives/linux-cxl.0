Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAD368D65
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598843; cv=fail; b=WlUVRtZxhogTgO2+aiCe/cBgDkmZqelpzDyp6ubS3gzblFoc1S55euufl0J4FIwpUL4OOTMyjR4+PKNUKySnF2q77dhU1nQfbuEY0irFg4rNevnkhNrP5Urrv0ooAKvnFz6itrnsFkdUs/Du1sHEyZDTMKoK4jKNVHWDOfic4II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598843; c=relaxed/simple;
	bh=qUD+9wyxWmZQvXsN+xEX34OyubTpH6q1y75QSi9R4XY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qebe52y0uz56xnK7G5Py9jqGV1b0NjUeQFnDzex7eP1rL1hAv+5jyC8YMT4g73tyghnsJu8KXWRTSPFJQU+9FwDjB0CWGmfDTbkm3ysPacjEZ1BBM+1549gTGae/l3T6jqXZBYcAsw0mPRdbx7QOD4z0lOmo2vgJhqv9uPgQJHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyLyZ8WC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyLyZ8WC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784598842; x=1816134842;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qUD+9wyxWmZQvXsN+xEX34OyubTpH6q1y75QSi9R4XY=;
  b=NyLyZ8WCVd9BjVoP5S/yOpAvF0rWY0h4+tp8Y4gk4OWY/cjpd0sV/MC7
   wZEOVSmIzopn4foboc875sXr+X4jTTucDvlMhVw4pvZnF/2d9ENCwWvXd
   NN9NA3d3Wt9pV7Bvd17n3YyJKzfdzYMHnQeklrU/HZKgRrjdtUSlYsmpj
   wY7wS68R2DU9odVdEnaHHLdjqjWJMdDvi2/vsr0cPWetWS2+dSw7Vrjj0
   l332In9xo7lxoePzvfKa6fAjSSjtfXtcyWFp9d9KbuXTYwgrajmNDKemS
   tSOfuxRdFHfcP0J6Y9UIAs36sN0D0uYqpbcAJaUqMsTcI/LMcKIUSg/Cn
   Q==;
X-CSE-ConnectionGUID: gwWNI1UDQVCnU5kmkeL2hg==
X-CSE-MsgGUID: sSjA8D47Ryqa1M1jg5tnzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89084225"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="89084225"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:54:01 -0700
X-CSE-ConnectionGUID: oRPG9aezRWC1XXnLO9q/8Q==
X-CSE-MsgGUID: HTWx1BCySeqJdqMu6vNDvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="253271017"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:54:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 18:54:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 18:54:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 18:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0pSLnVZEtfh6paYtH3vtqq7oBWhLXD5N/Od4eFuP6i0P68fYnhTDBhuhakwOtBpCPWg/NR09j2lSOgs+82LDf4xfJfAv+6MgF3E2i/yd2RVuymGAhQ9L0dcYF7GrzNQnT+y064e7z+pseP7wx9aphD4IysRNvwmzr/6BZ9ODlyo2cX5oT5eS9+8xRc9rZHqzwZI/i+eV5wNEqmSmMt/7grnjLwYwyrPaC9gFBQ3/oM0VAi4r0hvkzCdQAl0/zEXLxOYxsvGYO7gq6JnfjWpkgsNOnDPwZEA61osl5SC6NAOilWCy2sHqMKW3KvHjwLdbjUw0M+44srwtPG/eymROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BJil8GLuWnwUHWMzbgDKgRw4msZDZu6bFIFSVMa538=;
 b=uvjp0qnlD3O9yasAfE8qGDazF+2Vr51bNQ20MtmiuXRo2byGxyPr86GmyZvCDRZTyvxIInbJ74af7/i2DirEDVHiVpUAFJAAYP6CXmMrwMh+IcxHYBJlsym9hkuA3QgF5RwAMOCq5g1nrfuMnt3pxZnQYRA727E2GFY4ZDW9sKgPZLfFZYYLU8QgdY2g0CnlaHSRv3JSMPZkMKyF5hfPRXW8s8Mbwd3ifUxcPK234TRfyEIDGbBIeikuJ0E0wDk6l+lzv9cqS/fcAttJPpAUmVCoCVFA9INJXO8dKvYZN81j7OQqew/ZDRNlGljPovpz/nCb90jHro/+sfkIt3otRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 01:53:57 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 01:53:57 +0000
Date: Mon, 20 Jul 2026 18:53:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <al7RMBPvVb_vatz2@aschofie-mobl2.lan>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
 <171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com>
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e2b245-528c-4fdc-e7cb-08dee6caed73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: wknMMQB9Dbl3kdqAv/KEJbTg8CSRzz2r+BuO536bG925JI4dKD952BDdMTmCH4nNKMaxMlZtpHGIAMr+lp5RJV1FqneXG5BelH/X9BnEXvUcbQHFPDNi1QUYCdrw9a6Bu5IODSTrN1Bay4mdQfuDMJCkUlXhcIliy5FgVh4/v+yRxTv2mi6tkJ5lZqbDRg6agZoex2LhNASeUy9+rDJflG1PeUqvFDXhEBbG2oO9xBp42yhg5q7rXL8hptCn/MfJfRn/B8ueJtm8D8LH8njwK5MNDh0JwNUOoYX+fGEZ+1GW7cyJVYRBE02EhdSO+RnWQ86Uw+5GjAsvo73nhQzHDptbGhp3YBr3XutZcJyZX1B4FHPyvUFj/S4J2+s9K4DTMBbbtfNT8YKskRz7+8Q9rlOKNjyXk9YuAOuDbIr/G9TDP0ho6OrMOnSEvB3fRkxVJe/sRg3Cc5OHGOXzAQxNEZ6FfDX4uszis4NDJTHdbX0ZrCGv5CU3erN+AwvuS5nLLT0hhhAVdPuh5gK7RSalM5HpywNOrQgRL1Z4iFYa2+Eh+XklgRv48V/6cHqdywFCe99V3yVvBTk1dy1pNTTFFRfo6wnvyoSWjiu1wghss54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lOdGFsSURIVUE1VWJta2pxYStiNGwvblBrd2poSGNuRmovUnlPb3NNVmor?=
 =?utf-8?B?allvOVF2TmtxeTZuQlZxRDE2blZzVTlkWHQyM0lraTA5d1JYdzFWTEMrS1VV?=
 =?utf-8?B?M2JIZkQyMm1JNUpnZWpWektmMCtWdTFzT1hOaHJVMDdlS0xmRjE3cmFOdGx0?=
 =?utf-8?B?dngvMDJGeEVWdWtDTVMrS2NtRTMrT1dhMHhGM0VEWi8xQkpoMGF1YWp5MHA4?=
 =?utf-8?B?bmdDUUlBS1dtK2R4VEIrUXhZREdoczJFTm5FL2NDeTZ4YVVsTnpldXdpMCtF?=
 =?utf-8?B?eGVFY3FmemJhZHpJc0NLY0lFU2Ivb1lzRW9DS29CdllhNWUzd3FWUzFOVGlV?=
 =?utf-8?B?WnFkQmYxcGNwMHRYSlVoRGtKWlRkZXlnQUpvUXZFY2Q4Qk5nTHo5SnZXSUI1?=
 =?utf-8?B?WnpUOXJaQ3MxUy9NMkxDbmxIbm9HS1R5T3hzOUxURDRNOTNDSlFPQ05sSUtl?=
 =?utf-8?B?OFlFU2RoOHVib0Jlb2FDK01wUmh1alQxMHR5emxXdDQ3cTdSRWhYM1lRUzVp?=
 =?utf-8?B?VU5CU080UzFNeHFLYlZSWVNyWmVYRE0yR1AvSDhkRkh4MmxXMjNtMityV1Fu?=
 =?utf-8?B?NlBPUlhhNHlITmRrMEtpTGRqNitON2piL3g3RHFXYWZDb1MvVWxRQUNIU3lZ?=
 =?utf-8?B?Z003Qjlxd1dwZmR2bzZJZ2ZqaTZydkRURFY4RnZvRG5aTS9MVHI4RGJ4REM2?=
 =?utf-8?B?OWNZQ0NpT2Jab0gwWFZSUjQweDhsQnBmQmxQcDZUakpEd29adUpsZEsza1RW?=
 =?utf-8?B?NmpMTVFKSXkwWUdxK1lMRXo3NVU0R295SUx2cllWb1B0clZzWEFESzRkUG1z?=
 =?utf-8?B?VTVCTzhQNnBIWGFIb3JvUmJ5UFlybGtIaHhGNjBYL0hrZjRTTW1ObnZaS0ZB?=
 =?utf-8?B?Z3oyMWN2ckJweEh5aUNVeE1FL0EyTFpZS0E2ZVJscVgvZXdpRHBwR1JZQ2ZS?=
 =?utf-8?B?aWZCMGdYU2FwWmE2Z1JwOVFEeXdKM29iaUxvNGRETitiajMzNm1qaFBGMTc1?=
 =?utf-8?B?VnFpdzdLa2xSaE03MkhldTJERGdWdjdMOW05djdOS2M3cUFieXFLZEVGVW0z?=
 =?utf-8?B?a1cxSCtJVkV0cjdxSHBTOHVPMEVnMngzcWExY3MrRFNxWWdBQ3N3NHV0ck1h?=
 =?utf-8?B?bDFLeFJUVE5CVjIydFNMNnBFelg2RUUrVHlxK04wT1pJU05qVDhydFNOYjhu?=
 =?utf-8?B?VjhhM0oxeHBVZ2N4QTVaTU1ETEl0dUJnUVdhMkxtUEhGNXJkVHo0OWtYS2dL?=
 =?utf-8?B?M2trUEMxSlNNKzRyNmlxTWN4d2xqdFo1WVdyT0MrU0ZTVE5PRWdLbWZHZ3gr?=
 =?utf-8?B?ZFJGWWtlZVJDcXhVU2FZTGtzNEdqS21BZEtzeFZxa1hUUUhDRGRJMjRHZzdV?=
 =?utf-8?B?bndnSmlqVVlpZkl5MEI0dWMyOTlsc1ZPQzEwdDB0SERzcjhrc0lIbENRSDBO?=
 =?utf-8?B?bXNubVFmT0Zld1ZXcGZBV0Y3TkNHZzJHUmFxN25DbUl1eFQ4S2JsVHl0Y3F1?=
 =?utf-8?B?ZlpxdTMxUHM4WExacFRmUGZjK2FTZW5xVXpMb1krM1dmV3BjU0FITTYzQkds?=
 =?utf-8?B?ekpPMVRtWXJVblhSblArZVoxaVp6V1NSTjZnQmoyM3lZM0xtNUZzOE1aMEtZ?=
 =?utf-8?B?ekFUWlFueG5UWnNKVTlLb1FtL0xBWHcrV0ZudldpVlRud240dG1LbnBDS1Zi?=
 =?utf-8?B?dGtKcUNXQ0k1VktmNTNJUjVCTU11Um5PQ3JyeVFKZDBSM0pQcjlZbXhuQ2Ev?=
 =?utf-8?B?elgyREgzUEtDT0toNUhJbFhlb014Rk1tRHNGOTROUk5jQ0tjK3k2Z0UzZlZm?=
 =?utf-8?B?NDBvRTgzdnF5NGFIWVhxRFZxSVpRRTNvUmVRQjJyNEV4KzdhclpyWXppL2N2?=
 =?utf-8?B?b0FkWlZqRUNzVW4vT3Y2Rkd2ajB6ajFQaW5UeDdDS1Vhb2g1dVJxYVkzOXhj?=
 =?utf-8?B?YXVkdng2Z2ZjRnVMb01kSWRsZjVXcXYvb3F0bWluYkVEa29MbkRCVGwyTThr?=
 =?utf-8?B?V2ZodW4xdERPUm85Nmt4K3dLTHpKUjkwVmhWZjZNZS9QSkt2VEw2Y2cyNUZB?=
 =?utf-8?B?WTdzK1VmUGxnL0U5RmtlRndlUXN0cnVvK2xtclFxNHZuRHpsam56dkJnNUhw?=
 =?utf-8?B?aWZzSTZZRDRRTFhoRmlmMU1sOWV1U1dRTVY0eXEyVWh3NXprM3I3Y3VuSmha?=
 =?utf-8?B?UDNLTksvUXQ3WTFRVFhncTlMMkFZZDFKNHZFS2J2RVhjWXowc1REdmJsUnh3?=
 =?utf-8?B?bElFblFnL3pqVkJkcU1aTFZBQit0YWxSZUVGMTRpQnBGdnlyanppeDl2YVhz?=
 =?utf-8?B?eEJsc1lRQ0hVWjkveUFGUjg0R29GMmRvQThacGl3YkpxQXJrU0dkT1I0OHBj?=
 =?utf-8?Q?irci6PV0ZE24Lan4=3D?=
X-Exchange-RoutingPolicyChecked: IDKTgqUgyKPZfNQJOK6dvlhbRa8oe2iZUfRdpUynI1tJt6ySiDp76BCDvl1UXYvRLtVtqarkr+8KIJpmIYEy2OCbVnsx+wTFR9kqVUD0MRc1eTY9yveicEmdlpXsoBIVncLujtgME2NsFNg2rhr4TbyIeM9t1fMt+lIwWetJFQD8sPEvWsF5N87d/E6Gw9Ys+3S2D+L9lNIoidETtcLJA5ZDbRWM5d5v0uVM2e6SeIvOTnPzkTnisxhAceLw7BCIlXwDoB7iQu3wTrt1p+1tcmoFccWCVR9VNXlUCHdjROHdKX5Y8IcNlXvjZM9KpK0KCaLgkBFgd6Ts9VyupfLptA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e2b245-528c-4fdc-e7cb-08dee6caed73
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 01:53:57.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7ikexDgZ84r58Y+OrGeYWKG7eW1Im8DZ12/s7zFa4nF6qZTYAqwQzU6K8uELVENeUBxZrj/2vPr+3r+dqYbZrYKV9o77tzaQ12HkRBZSjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 02:03:06PM +0800, Li Ming wrote:
> 
> 在 2026/7/18 05:42, Alison Schofield 写道:
> > Switch decoder enumeration validates that the interleave ways encoding
> > is legal, but not that the resulting number of ways fits the available
> > targets. This can overrun the target arrays during enumeration.
> > 
> > Reject committed decoders whose interleave ways exceed either the
> > hardware target list capacity or the reported target count. Reject
> > switch decoders that report zero targets.
> > 
> > For uncommitted decoders, ignore the stale interleave ways value and
> > reset it to one until the decoder is committed.
> > 
> > Add a clarifying comment that target_count is a direct count, not
> > 0-based like decoder_count.
> > 
> > Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> > Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
> >   drivers/cxl/cxl.h      |  2 ++
> >   2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..d81df45d8005 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +
> > +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
> >   	cxlhdm->target_count =
> >   		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> >   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >   		cxld->interleave_ways, cxld->interleave_granularity);
> >   	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +
> > +		if (cxlsd->nr_targets < 1) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: reports zero targets\n",
> > +				port->id, cxld->id);
> > +			return -ENXIO;
> > +		}
> > +
> > +		if (!committed) {
> > +			/* Ignore interleave ways until commit */
> > +			cxld->interleave_ways = 1;
> > +			return 0;
> > +		}
> Current init_hdm_decoder() reads IW and IG from CTRL register whatever a
> decoder is enabled or not, just wondering any reason for that. Because my
> understanding is when CXL driver programs a decoder, IW and IG will be
> rewritten, so is it not needed to read IW and IG from the register if a
> decoder is not enabled?

Hi Ming,

Great catch! It's not only needless but stale bits could cause the
whole enumeration through eiw_to,eig_to....to return -EINVAL.

I added a patch 2 to address this (another pre existing issue).

I do see that you used the word 'read' and I wanted to note that IW and IG
are field of the ctrl register and that has to be read once to find the
committed bit. So there is not separate read to drop.  What the new patch
stops doing is decoding and validating those fields.

Take a look please. Thanks,
-- Alison

