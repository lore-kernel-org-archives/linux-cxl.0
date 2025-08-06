Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9DC8EB
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506650; cv=fail; b=eLSSEkfLurqckZmP6FN5nIjSEv2BSUBTyFrYW8YjrGgoYy1Wt47ZMFzSwQ2YS1LohjSjcUcHs9yLHckyAcgfNdNAt5eFzOkktzeh5qywnEFOnn6jYSo/HZO+GKgHTMomf7sSWQe+9dc7Z4ZRiDyqUHxKUI9/PXxD4ejXEcKPZzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506650; c=relaxed/simple;
	bh=gy1lkWsinkb2k+ULfz1SSz3qNesGjtTUJPE2PgKqI1M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cdcTvhRFdo48jEqR79OUY/Z7w8cFtzeE8yH9a1vEw2J24esVc2kWDS44nzWr7XzIH59VkmUD2+6GeyK9rB5EWank5LpaUdEUjmsmy/VdlabPF8PHOq5XnGC1LA8cwaPkALnitWt/hmqn2iEvXxndftYCnCSlzg6zugiTykxSMcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=angCUi25; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="angCUi25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754506649; x=1786042649;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gy1lkWsinkb2k+ULfz1SSz3qNesGjtTUJPE2PgKqI1M=;
  b=angCUi25ZYKunSAogv8YdTvffLQbd0g6LRysa02zsnbq3X1jdrmqvogw
   6FxTA8jMZMT+rSCcovasxg4jeApCZYBTQrNkMig34MI5bW5TNX2IIaRHn
   mtECByUoRaB1VUEKV0bCNQdJMicr3aD5LNxGOIb18qeT/Jna4f/pufbft
   dqwpMEP24Vy5Nrp+f8ItT9NV3c9eYYy2L1X5IZjG0nheHDszL/kJ9rDk6
   vFFVuhUpzbidgA6hUBlTqbDH0kZ99XqaGb8CL1ytZjeXvcVMmu1rvMUPV
   s8B1VfOSP/YrbnHnPYMjy53z2swMn83J1PqE+EiiVvr0ZPnOZ1TvbTDmg
   Q==;
X-CSE-ConnectionGUID: q8crOUIjS8a4zXpBkVwLkw==
X-CSE-MsgGUID: SyZfO2viTN2rMJTpn6d7Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56914205"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56914205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:57:28 -0700
X-CSE-ConnectionGUID: fifMxi/sRxOGA1gibuZ0Lw==
X-CSE-MsgGUID: 5hzVVfEVSBCIzp9kmHeFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165644392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:57:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 11:57:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 11:57:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 11:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMOoh1OGYudH+gDpqv6XkmHjfZBqIZaxalSlaU2fD70SFZGvXaqiHPCYHuAurVjEm6xKgkxQSLxMq5D03/0zpWHCL/X5cXvzzHC4Qg2t3v7R7p7vHve/WbllcZ9p7iv5csd9zh2zRfv47KiDOKfRyZ4LVDuvNicKlMBfg6SQofRE1TXOxwsP/k0DjzHzQV1S8lT1Ek873uPqXsxXgb0D3U3voNRpjwUDnh1AJSG3BOuqkx33GgsIy16pgL/dULhFVXFrQqAQxmfJIzCSpYsdC9JTNR5vJqS/k1TV5cFS14ostTS+tkSt/OzX2/SFY50np6/LcLwcCK0wHsjTiA9BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVZ3FUpTczNOgAvAxY/jhi+1XIZCamBbhsLcx4Y+oW0=;
 b=ExC3sLdl4ogM/Cbtf53mt/lvvW0qWBfRqnOd3sGS47dux1uzmppEXcfNR+A7hVKAQy9M84F1wss5jdYnbAqoxlBzxuYcOuPJEVW5rZsmrcWKE1jT579vsl4AN89uq9taWtEDmvgYN6oW+EuELoWypMwzt51L2pvLH50VwIv9N0w5XFyv7DwxC0I3xYVIJ0My0LdpQPmtKR2ui4GmZrUsUhCxXXLNJsWbu30xgFRyFX2MJKfELEcbAbqaBWClgFn36gaDpd8GTvxiKw+frIZ07ztlCGM6mB/xeE5dOzX1UQW77WQne6VOFSy1V9Kh/Ou9/k4C8U4Vb6RnDwWAbHV2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 18:57:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:57:25 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 11:57:23 -0700
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250804082357.2590809-1-alison.schofield@intel.com>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:a03:333::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bc6847-c725-401a-b93e-08ddd51b1565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckh2NVhMWm5DQjc2UzB4R3VoZ3pmSk51Y2ZhVVNLRlE2T3prZnQ2bmlQNVJm?=
 =?utf-8?B?Q0h0QlZxdTV2Y0w5NUZnYXU4eW40OVJZMUw0WHBjTkdldkkxTy9hVWFZMGUx?=
 =?utf-8?B?WWtDY1BVd2JPK1hxZDQ2WkFNMnZ0SDl3eEdOWnBHeDh0cXRRNU1ieTFUTkl1?=
 =?utf-8?B?Z0U3RGhGalp3U29xYXErMGtRelRrZ2hUMGUvNlpuTEp0TnlNeU1aYlVmRm9v?=
 =?utf-8?B?bU5ObFVNdE5Kb3JsS0F5TXFHalRaSWpLL0VaU3Y1enN1K1NYbXBLZ2paaDI1?=
 =?utf-8?B?VGRxWXE2d3d0VUI0Q1ZLSWYxb1QwQnRFWStpYjJjYkNKK0hmRGEzc3RaSi9J?=
 =?utf-8?B?VStWbHExMUI4R2oyYlh3WlBEZXVmVWRHVGZlV0l4T0R3cmFPbDlpNUFOb0ls?=
 =?utf-8?B?N3cwcGNDQzZWVUxxVXJWOUk2MWtHNUg0bnI1RnhCVkJBUzZPZmFBV3lHTXpY?=
 =?utf-8?B?c0dFOEF4L0FUVENqb1lZR3M1cFVremh1dnJiU3ZsTVcrRkVMT3VJUkIwTXIz?=
 =?utf-8?B?UEZkbmtPZy9kdjNMQ3ZqQzlFaXpMaXlIVTgrWHZMWDdRcUQxdWd2ZFJUSm5C?=
 =?utf-8?B?ZDgwZFdqNTR2SThsQUcrOFpVRkxYTXFRTFFGTENXblF0OXlTcTFJeC81MklD?=
 =?utf-8?B?eHMxa2NQQkhXRU0zelZMSzU4NURRT2IxdTNaTFJmQS9KOHpUTk8zOUVsRlpR?=
 =?utf-8?B?bmVoS1FpMVV0MUdZeml1cEVCNlB2SDV2cjZmRUdiSngxTTZsT0VmeG5tUkp1?=
 =?utf-8?B?WnpyV2lwOCsxOGhiaEw1dzVKZGNCZkhBYTE5U0lZclJleXpOckVzd01wUTh3?=
 =?utf-8?B?SlRNNmJTY2J4MUdibHVrQlgxckdSMk9jMzdSenZlUUNPb3U4R1R2cHR4YkFp?=
 =?utf-8?B?SnJyVWJHZnIzdFVGM1J4d2VIdk9NZ3k4QlN0bnJmbTJ4V3VPbmJSMTBEa0kv?=
 =?utf-8?B?N2ZXdktGZUxNMHRhdHZqS3BWcWFxNVFVWUZ3YWVoaEdveU1uK1FVd3RSSnRQ?=
 =?utf-8?B?MWtLdjA5aWNsVFBvUHFDOGZ0RkhrMjR1NUt4emYveFBzTTZCaSsxRURyUVM2?=
 =?utf-8?B?dFNQOFNIRzRDZ24zaE5wUm5aMjFkVmlkcHlkTkZHNHA2ZmRqN3NlMTFtT21J?=
 =?utf-8?B?R1BUaEhFRXpDMVlXaWJuZ1FPaWlIeU9sN1gvMlRvdzhLeDRLZ08rK3pqVzZz?=
 =?utf-8?B?M3hRakZjRFBlNGZBTW1GVWFZMzN3SUkvWkJQM2s1SDJ0emVkUEE4RzFwWHNa?=
 =?utf-8?B?NVppQjlxV3lGckFENnRLV1g2ZGtMVGVRclJvdUd6a3R4RGtUNlBPcWh2RTJF?=
 =?utf-8?B?R0U4dVV3aTRTQUtOcmpnamRKd25HMGJidE5KcndDb2QwWE5zTFpCL1UxNUJr?=
 =?utf-8?B?Z3I2SnVxMzlXYTh2Y2xraU9jM3pkbmJYYnM1cjZGazdYR0kwckh5V3BWSlhN?=
 =?utf-8?B?WXN0YzBsQUJ2WkMrTHVnbWVwMHJMcWdjL0JWbEhtenBmUFM0ZFpwZnVzVzZp?=
 =?utf-8?B?a3VrYmVpdkJqS0xuczdOL0tWYmdRVWlJQUFleXhGUGFpT092cTA1RnV4Smw3?=
 =?utf-8?B?QzZocGxYcE1kOHkvdmRyQUt1ZVhNaVNBK0x6eWNGSllUK2RiZEI3MHhicmt0?=
 =?utf-8?B?bE1uTnNRWVBWODdGcEpPVy9OaktqcHJrRzYvU3dYeU04c3dTNmNxWThxdnRs?=
 =?utf-8?B?SEVMMDBzb3RrcUdwd3ViQ1lJNUJTY1BQMmNtS1N3WnRjV2JIV3pRemxIbVNQ?=
 =?utf-8?B?M3hueUxZM3hZNEVCQjhUWjd0TjE2VDAxTDNESmpCS1B1bUtFenRzY1ZFTkx3?=
 =?utf-8?B?KzFNeXM3eFdMK1V6R2NHbzBZamY2N3J3NGFtK1dhVGc2UE9LUmFybkxhMjJM?=
 =?utf-8?B?WUhCeEhTdnNvNFZxeThVaThVc3pVRlphdFN5ZWtBNWVuUnlRZFVmK0xKRlpF?=
 =?utf-8?Q?NPL6iOIw0Tw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGxNcFpyK3dsOGJndFNkbDkwQTN5WlFTY3lRYlZ3RlVaeG5JUnYzZ1ZBWkht?=
 =?utf-8?B?N3JBRXJQc0k0SzZsYmhrL2VjNG83T1dBcWZFLytURFc0OVkxcmlacU9WUm5S?=
 =?utf-8?B?WWpqSVdLVE9nUUpETUNCODVsUFIrUkdjd09ldHFUeXBjNCs0QTZ1ckU1aDB2?=
 =?utf-8?B?bHpjSDNITkhIWlZ6Z3pTUDlUWUxMbDBTZTJHM08ranFraUYxaThaNUxMRnpW?=
 =?utf-8?B?N0tZbnhTN2YrZExpUk5FMXN1R3lDcmd5ZWFUeTN5NGF5cGdoY0VkbjBJdHRs?=
 =?utf-8?B?NG1PWG1SUEhKeGRianpOK0pHbTErRzlKRHFNVG5aMGhCN0dtTzR4bTVVMHEx?=
 =?utf-8?B?NmRPZ1ZHYWRkdkVaeXJNZ3d3M2VMdGFHUWthOFNtQXhnQWdsRGQ2TXFqQzE2?=
 =?utf-8?B?MGkyamowanEwbkFZUXRnQWtUODh2K0pmR2tZbSt1b0JwaE44NzZBK09wbXcv?=
 =?utf-8?B?MDVHckZPWFBOVUtTOHFQd0xIZGFFTjV0NU41dGw4Q3JPY00rajRYeWZSbFBU?=
 =?utf-8?B?L2txNGp3QXZ6bE9vTTZ3elVDV0tqWmpPRlBlRlE2SEdaNmlNZ0wyQmdTK3B1?=
 =?utf-8?B?aUdCUHBicVI4S3dEdWJoNGpOQnRCWjIrczMwYnJQeDNSdjV2Zk1COFB2OGdV?=
 =?utf-8?B?K3c2N0ZmTEZTU3JaT3dwQWE2cjdmWHprTThTR3Q2N1kxaC8rNW51WW9ZMXhU?=
 =?utf-8?B?alkweGp6SWFUejVCekp3NFp2bnFnNTd0c3UwWGxoZW5KTFAvbitMWis4OUlY?=
 =?utf-8?B?Y3h0Zjh5cmVDcVhSWkxsVjJCdFZ1WXdSQTNqWnBJMXBSRUp4Mjd6VnQxVXZX?=
 =?utf-8?B?WHM3OVVmNW9uOHFhNkdueHJaY3JITGx2SzJ6NjdySTM2TUpaZGNPVVZNY0dJ?=
 =?utf-8?B?UUZxYkZsanFNYklrcVZDYXRMUlFpMG9vNFpNWXZNc1JNS0lNajRhRmlGRkl4?=
 =?utf-8?B?UFcrRllYSGhWelM1WjhkSUl5U1VkY0NMWHlqNEZqWHZyOWZDbEQ3NjArTlY1?=
 =?utf-8?B?S3NtcXgzQ0tHYjVtSkxZQjE1eDFQd0JLSDJwV3p1WWErV2xYbnpvbDErY3g3?=
 =?utf-8?B?NTNTaU41K29RWC94eW84eXhYeXlOUTN2VVh5eDcrNmR4VjdwSFhsVGg4VFhY?=
 =?utf-8?B?WW1HaGs3MHl2Y2tYc2t3WnMvYzgxa0M5QkMxbnpoM1JQNXAzMnhzMkwxSkww?=
 =?utf-8?B?QmM4QTVKL1hGazFPbjlMMVpVbnlkTXhYQ1FxSXQwMXJ6dUtnS2RtbWZCVEFu?=
 =?utf-8?B?ckxwNU5vcXo2blVSc09WSUs1akZkRFhuSTVtWHA5RG81TU9SdnI4TjV0N0NJ?=
 =?utf-8?B?SVZOcVUwelVnc2UyZjFxUXhGbHNPZW9EWENyZDhnQkRMTHduSDlRUGxUQnJI?=
 =?utf-8?B?M0ltRXI5YldkZ0RhbmR3NTBpSUk5UWNEcFQrUW1nMEEwcTVQUkY4TzNsNjdu?=
 =?utf-8?B?VytoZEtJNGpZUWo2a25mbHdtSFB6RklWMll6NWs4WFlPNVJxNStQaE5UUThu?=
 =?utf-8?B?Z2lIR2pHSnZ1akp5OGdJZENqWEpPSnpUMUhRUnVjTjU0ZTFZOXV4cDNFUFZs?=
 =?utf-8?B?akNlYW9ZM2pnQ25RNUNXZjFIM3BvNUNzc3lKRkVuOTJXTUszN2Q2TEZIWnV2?=
 =?utf-8?B?RU8rZGlqNmFTOGdRQ2FGMUxjbkp4aTRSVjFiRCt5ZExsc282QmdHMXpVVmFJ?=
 =?utf-8?B?aURuNWlVYVRKSUd3bEVSOTNEZ3ZFdGk1cVpvckZmWm02eDhEVGl1d3ZuaUV0?=
 =?utf-8?B?Q2dWdk9XSGh5UnlJRlZMUGJNc2NiaUhTUXB0QWE2OEFOZ05lQkwzdXFmQUgz?=
 =?utf-8?B?cy9DcW5WTWlQSjh5Tit3ZmI2TmJ5QytRQm0wdCt6MjFhZHMzWEZhVCtZdzU0?=
 =?utf-8?B?MkVvY3B5ZmRBMlZTb2xML2hDMyttdDU3SWJyM1MrTnp2NC9qckx2VmR4RlhI?=
 =?utf-8?B?UkdSNjFRUjlCcUFlbzk1aDd6bDZYTExmTjF1NExzNzM5d0FramJLYURFNWdi?=
 =?utf-8?B?L1U1K2NIbGt6enZXUWRDeHNnVHJBR01KNCs2QXJ6SGRtQUNDOXdsVml4RUhE?=
 =?utf-8?B?QUVlV3N4eU5tSVpzbmswd09nM2NvaUtGbDFkbjFLTzRURkxCSk14NG5DK04y?=
 =?utf-8?B?WCs0MGREOTlqZmUvajVvUzlSNk5IdEpPVlRlclJIeXpYV1R0eit0ZW5vckxu?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc6847-c725-401a-b93e-08ddd51b1565
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:57:25.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiZVHt6BoYdAD0wsou2ekTaQuDhg8ltNrxAHi50f5Zo2fzfScYbZLY98bWzaWVNl8nIANWbfthGxSpoLhGkzhcVXiEFNU39VXxdU4gm0JC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL specification defines one set of XOR maps per Host Bridge
> Interleave Granularity (HBIG), but the number of maps to apply
> depends on the Host Bridge Interleave Ways (HBIW) for each region.
> 
> Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
> XOR maps regardless of the region's host bridge interleave ways.
> This causes incorrect address translations when multiple CXL regions
> with the same HBIG but different HBIW's coexist.
> 
> Example scenario with 3 XOR maps defined for 256-byte granularity:
> - 4-way interleave region:  should apply 2 maps (was applying 3)
> - 8-way interleave region:  should apply 3 maps (correct)
> - 12-way interleave region: should apply 2 maps (was applying 3)

Ah, makes sense, thanks for including this detail.

Do you have cxl_test bits to backstop this fix, even if only in local
not-yet-upstream-ready form?

> 
> Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
> a lookup table to determine the correct number of XOR maps based
> on host bridge interleave ways.
> 
> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 712624cba2b6..5154effb0cb2 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -16,6 +16,16 @@ struct cxl_cxims_data {
>  	u64 xormaps[] __counted_by(nr_maps);
>  };
>  
> +/*
> + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
> + * the same host bridge granularity share. The number of maps to apply at address
> + * translation is based on the Host Bridge interleave ways of the CXL Window.
> + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
> + */
> +static const int hbiw_to_nr_maps[] = {

I would feel better if this was defined:

static const int hbiw_to_nr_maps[CXL_DECODER_MAX_INTERLEAVE] = {

...just to have this pop up in a grep if someone wondered about the
implications of bumping up CXL_DECODER_MAX_INTERLEAVE.

> +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> +};
> +
>  static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> @@ -23,13 +33,13 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  
>  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
>  {
> +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
>  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> -	int hbiw = cxlrd->cxlsd.nr_targets;
>  	u64 val;
>  	int pos;
>  
>  	/* No xormaps for host bridge interleave ways of 1 or 3 */
> -	if (hbiw == 1 || hbiw == 3)
> +	if (!nr_maps_to_apply)

I wonder if this also should have a...

    static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
    BIT(8) | BIT(6) | GENMASK(4, 1);
    ...
    WARN_ON_ONCE(!test_bit(cxlrd->cxlsd.nr_targets, &nr_targets_valid_mask)));

...because I could not immediately convince myself that all callers will
have been careful to not pass invalid nr_targets?

>  		return hpa;
>  
>  	/*
> @@ -47,7 +57,7 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
>  	 * bits results in val==0, if odd the XOR result is val==1.
>  	 */
>  
> -	for (int i = 0; i < cximsd->nr_maps; i++) {
> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>  		if (!cximsd->xormaps[i])
>  			continue;
>  		pos = __ffs(cximsd->xormaps[i]);
> 
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f

Feel free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...with or without the @nr_targets_valid_mask if you determine it is not
needed.
