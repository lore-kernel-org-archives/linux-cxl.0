Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A12BE026
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063635; cv=fail; b=RmWVUnKuswlEcPgZMY/+MiGRLd4uR5GDCbYjytWlQ1BHYrzPW2hbnNHNMCx6RKodQDSQ2irQ82760plzrQc9xz+DHT0UkxUEvDOsrivGDobxTsdxX/0eLQzWpeNUUsVGQCCZQTEbpQYjyya4WSUM6psC0f5mPBFI0XCUHxpAzag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063635; c=relaxed/simple;
	bh=pgd11nfChmEgULh72RmsUOoyajxzNxtOejYL1SfLAD8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Kl+vMlze2GAWEBZLJecb46STtyF4Dck60XsGhy9qKBOwvGTODuSXYiTvnznj+tiHVKJ0DURkLc4+vVs8Sa1G/KtT8Ztlo0xsTN8R6mm1FG/hcBKX/lbtIO7OKi5von7o4ZRPwfceodhjibAOCObk1Du+Bem9i0Wq9vw3IvDKisQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1K9A1zs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1K9A1zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770063632; x=1801599632;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pgd11nfChmEgULh72RmsUOoyajxzNxtOejYL1SfLAD8=;
  b=a1K9A1zsVlb1X123ccXaN41GZ5KA4LAfVILgnzxzHeM/6rXqV+lVZAP8
   eQaqTAY9DiE1rDj15xc9KV5J4Sj6z0ir7HzqoOoS0dfE6iUaSSFBXB+UF
   rLXyycitC+SwdOrQfFKizbACcnL7jqPmVZcMgawepyX8VvLU1PguAn6em
   1lfqvOjg85gfsD9y7h0Ed9nsvfjxGRyvMcdo2csao/7uxU7TzOVtuJUUB
   C4mJiXTzPwZN5IvDC+nWCC/lRJD4BkBJv+00b76RzBInBB0Z7/VCBe5Eu
   vo+ZToaOzCdlD35BoZHt/00dtG3JWlATG/FutamEWV5OEsXVnNS1+8iI+
   g==;
X-CSE-ConnectionGUID: ULxbO5N4SqisyU51gcGjRw==
X-CSE-MsgGUID: BV0K54fWQd+HLxJ0FG/h7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71212309"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71212309"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 12:20:31 -0800
X-CSE-ConnectionGUID: xNH4CixDTdWHS6RC4eFa0w==
X-CSE-MsgGUID: sLA5nQpmR1uTJ+yNZW1I3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="214416363"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 12:20:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 12:20:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 12:20:29 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 12:20:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uui/6oMoxirbvxgpYl5YgIOFAyyHTRamoOIg91Yvr4R5TDOOCAtlrs4BwxH0DnYd37DnvlziU+4JeOf8Zhb9f3kC/+e0bkdCHrWa9Mgv9YAwzF+iz9CtVlVde0g8xSeR8RlZT0n6HQcb0hhAFe8RPW74vjCPUWyHK+2T+hFYztfT4HRMMY8pHSlUrD64TJwoVEJdp8MRFd0T7nxgr2kZRdd6cNUR64tt3bxCNlHpcgXYT8KyXfYhH2rZL2iZEYQZq2rCpskcOyHjIueTPSSz2yWYGYqKmc/iDaYC/62bsBKGUQ9va55ncKzaCF6rQiOatK+ly1ydviY6+G1dw5Q40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLs2RSjFPiDPOL0URK7iTNpXp0hIHLpxEuRJHY1fS14=;
 b=qDR5Z1I/E0Pw16Cb+HEdNr2p5b5uXPRf/IpLGO1q0g0Eg+eePyjTRGCfQV310C5mzRnS6RMye56XYwoXuOro1GY11dfB2cPbYJxKC+A6ZRwcMmER6hgvUy08Zyi7DvphIv79ygQhMiCegkfc+/CPWaM4V+dixoL3AgEYW5J4NkiwGhG/dz2uSsu+MlEI0J/9dSUDkuuwiN7IUhEPKjkgnPq2Jp83D6Y7qIBDwo/qW5AJhY9EVjksWTxkhWE+hweA5V6E4yQ1EyIV2SRTuHgS44pwqmo9q2Np5uPYHVQx2Dje6SOMcPAmH7aanCvvgUYd6vqNiajic6uRHz77mQyLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 20:20:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 20:20:26 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 2 Feb 2026 12:20:24 -0800
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Message-ID: <69810708cf7df_55fa10055@dwillia2-mobl4.notmuch>
In-Reply-To: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
Subject: Re: RFC: CXL Isolation Support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 278c3e0a-d5af-48e5-2163-08de6298807b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzhnTkw3eDNYTjEyYjJsc2JHd2dSMlZDRXJZU0swdXRrQkZ0Rm8wRXMyVlhi?=
 =?utf-8?B?TEtaVmhEMWJKQTEvSzBWNG8wKzh3TmdTS2pnT0ZlbC9QTTFUcCtoMGptNGp6?=
 =?utf-8?B?cGxsaU1zc1NNYzFMRGVUaDdISGpTdnNDRm1ielo5Q2tsR3k3MW1ZMXI5Q2Za?=
 =?utf-8?B?bXF2WWJCRUU3YkdGeVBaR3NJUW5PeXRBVFpTMWx1MWhWdnlBd29MV0lvR2Q1?=
 =?utf-8?B?WUl5ZXdJcFBzRFFzVldtTE1kckl0UWdWelJSNnpzTUt0ZXVkMEhNYlZvRkc4?=
 =?utf-8?B?MHlYZDBFZS9yaG8zeGhRdm9hSHdWNHFOUlVNU3NHeU55VVBWdGFTYllHY0Rv?=
 =?utf-8?B?ZEhDamJtSkxOeXhieEJ1SmxUZHhsamlYbjRNZUo0ZlBvbDVPM242RnUybFVJ?=
 =?utf-8?B?RHVaM0J0OTR5SmRNd1lSNHBYczNGZDhsSEY2RlAvNkQ1NTlyeWtScE04N0gx?=
 =?utf-8?B?dlFXQW1DeXlYZEtTOEEyY2J1S21wb2luc0pCL0xIUGpPbXNhV2tHdldrYndh?=
 =?utf-8?B?QjBPaU9oMUd0aGJud3dTdFlNQ0ZITlorM2xDQ0c2OHNPWFk5dU1pUHQzTlB4?=
 =?utf-8?B?Y1psZ1VhMytuUm14ZlRtZ1EwZWVpSGNxcEMwcFRaZUlhWVhzbGR2d09wR1ls?=
 =?utf-8?B?Rmg2dkpuS21oVC84aFhoNnRNblI3Y0Urc1ZNVE4xTklUSGFzaWRXbUoyWXJ4?=
 =?utf-8?B?K0taVlFsUWxIYjRQMnVCSUZ0eHZyL0J6aUh6akVMNFRULzV5VDVBNE9mbUt1?=
 =?utf-8?B?MHdWNzhSbWg3WCtCSlpvWXZSLzJtOEJFanNSSk1ld1BtV3FNeW5NaDdtbFB0?=
 =?utf-8?B?RnFLcW9VVWlxcG9XbFRsazdQT3l2djRoQTdKaVRaOFluWktab2lvQU9EZEcr?=
 =?utf-8?B?bi8yMTdnSVRVT0QvTUJsRmpsRFZIZ0R0enVjSUpuei85WjV0UkZaMXozZE42?=
 =?utf-8?B?YUxVTmc3VXhITGVTT0dhU0FidS81VDlWRUlIbnpWN1ErV3VrcXBFTlRxSkZZ?=
 =?utf-8?B?ZWVWMEVVRCtEL3VVc1cyTTl6bnhHWHMrQ2RGU2FBZzluS1BtdURES21YZXlE?=
 =?utf-8?B?UXZOdk9kWEtoVjQ4KzJUOWljUWptRUd5ajV2M1hOY0FldmRTc3Q1UksxT2lu?=
 =?utf-8?B?dS8rT0VYRlRHekRGd0dIb01XY2ZNREJMcTFrOVBwNjNXa1UrQmtBd2pZUEoy?=
 =?utf-8?B?ZFlqSDYvWlNmYzZVOTdHc3Jsek9zRjZDeEJwZllpU29HZWx4Z0xtOUhKYi92?=
 =?utf-8?B?UU85TTlzT2N2SFQrWkN3NHdyaFdXL2R0UTR4Wm9xY2dCaGVvY0U5cmRTeEJo?=
 =?utf-8?B?OXI0YnJVU1d6RElrd20yMzFMUlFOa0JqdUhhMzgxbnpCYjVuaUVEei9kWmZ6?=
 =?utf-8?B?QWpPRGw2ajJqb0ViaFJxYWFVc0V4YnhpZmwyRk1uQWdFS3FQY29aTWZna2Zs?=
 =?utf-8?B?QmhtMUxNaEtWT1JXZ1B4VS9BVlhiY0Zld29PZzI1UU02NWlrOWJkNjBMUW1W?=
 =?utf-8?B?WnRRL0hUa1daTDdib3I2QWd0ZkNJNDY4RWdjT2UwRHdLVEUxZHhWRUgzQXJh?=
 =?utf-8?B?M2lqVnhGQ1dSUkN2d2l4ZmJzZ3RvdGZ5bW9ZaU5RRFY4SjRtT2VEaGNTRzNN?=
 =?utf-8?B?Tjdwb3FIVmJaSnJralRUQ2lsT0FtWmlKMUhxY1BsYU5FWnpNY1oxcWcyZGpw?=
 =?utf-8?B?OVR6RmgxMVdPSUdxQWh4eTdTUnZTNVkrenJOeFFkY1VJejJ0aW9hcDBqMmFH?=
 =?utf-8?B?N081ZHFWOERPWnRlTkZDUTZyQTJmQTROdmNJOW9UWWVLOXJqbFJDRWxENDVS?=
 =?utf-8?B?UVF1cTVxMDNkd2NPeC84SFBCR2dGejRXN3FXcTd3c2VXdGpDTFVmVENYc2VX?=
 =?utf-8?B?YVdxdjVuaDhkYXRHUjhVazl2eklxNGs3bjk4endXeXYvMlh0UGV4RllzUGdn?=
 =?utf-8?B?WmkxSUVYdWk1WlB2UU1pbnZ2c2xBQU1COEtKRG5abmdmeHI1aVpNcEFwRUlO?=
 =?utf-8?B?emh0SjF0YlJLUGY1YmZXR3JQMkplY3V1cU1haHZpWjZpNk9oaTJuTE5MRWJ5?=
 =?utf-8?B?dHFWdnlvZ0xOZXVqWms2YkxMeEJ1V1djVnV4YjhVVkp6cjhuYjRyaUg5YSs4?=
 =?utf-8?Q?SiFONdI3vfGbnaPm+gySpXEj3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHA1UDVoNENRY3RlVm1FTWlZN3d2WWFyTzJ2dEdZSGFhV2xFWTUvdGplN1hr?=
 =?utf-8?B?RDdjSm56cnJsS2ZycllvZFJWN0I5SlIzL1JZK3M1UzMrbnJ1T3Y3cmhnZVJQ?=
 =?utf-8?B?a1ozNXBwR2V4S0U3WWcxNEZ3SDZ3TlY1Y2VwMTFMMDQvVThLaUZvQVc3czFY?=
 =?utf-8?B?YlVzak9lOVE1dm1RdmpsL1o1ZGJ4dk41VVpCaWdQTFlwSjFxeUhoZll0NGJl?=
 =?utf-8?B?WURBSDVnb2szZVE2a2sxY3A2dFFWS1ZleFdjMUc5NXhTZVVVYTkvMlI5U3dW?=
 =?utf-8?B?Ujc5LzZVcmFpdVpVeWRoNlB2di9wRE5xeThtWDJMcVVSeSsyT3lMNWVLS09Y?=
 =?utf-8?B?czgyOGtUOFBpaXV6TjZ6TnNmdXJvNW95QUw5RkcvYlgzWU8xYVFsZVc4eGd5?=
 =?utf-8?B?bGJzK1BRY2hubFM5RGFYbHpDcDZpR2N1dXdWMHIrWWhKeXN1SG5wWU1SY1Fi?=
 =?utf-8?B?cUxsNEsrSzFpaDVEcTRZa3dqcDJUVVh3bjNFY0VXUHJNUkNBclQwVzZjRE9z?=
 =?utf-8?B?b1paSzRnU0MzWHhnZGViVEtYRW9sa2tPaTZGNWhENzE1SnY1cU5LQlh3RVE2?=
 =?utf-8?B?YTNGV2UxN1NjZlBFVzBWcU5BTVdYZi9SelBvcWpvcmlJSjl4cGI5TmczNlho?=
 =?utf-8?B?R2FjeXpsRVhkZUxwcmNjTTF6Z1FlVFE1RGtmZmVkV0tuSFczZm5hUjNoK2RU?=
 =?utf-8?B?WFJpWDVpZ3NWRmtiZ0FWL0pZU2dKT3YxWnVaMHg2UlU4Zy8wbTVuZ0cxc0RQ?=
 =?utf-8?B?b01hbzJvdzdyU21tbjU3YTcwL1JJb2tEWnZmd2RLeGxXOHJ2L0M2YkVoT1pv?=
 =?utf-8?B?QW16czh6aGdnUWsvRVhqT0ZCZVZkY2VkYUNCUlJreThWVVd4OWRQcFRDcllJ?=
 =?utf-8?B?cnBxRDllSFBkOE1tam1hS3NDKzUrak5tNXpzQzNzcnEzdGdoelZvOW04bUUr?=
 =?utf-8?B?d1ZHbnRxSUdXRUVFcHpvL2o5RkFid1pXZ2xJckpsQUoxMzcxeVZocVBjSTFm?=
 =?utf-8?B?Rkh1TjJNbWxPVVJnOEF2aUpXa2QzUlNzbGw3RmVVdEdVZDNqeHpDWE42UXVX?=
 =?utf-8?B?RFNqWTVqTUtrR0JDRFRmeHNzQWtENFo1YmRpWVpmWEJzb2J2Y1ZwdURNUUhX?=
 =?utf-8?B?VWNNZERrZnhmTFVCQUp6eTFROU9ldWtUT1o2NTVCS016N3BpRStHZEVQQ3Rz?=
 =?utf-8?B?VWV3dkVISG1ybFgyWWVWaXRSYTUyM2UwYng0KzJlZzkwN1c4ZGRrOWYwZVE1?=
 =?utf-8?B?OVYxV0RSR3JGdGsvVUJWSkswS1lUY2RYUzY2T3VzQXlmWHNaUFlPMUUxR3A0?=
 =?utf-8?B?VS8zcHJqUFNhLzhnT3RsdFJNM0lCU1lOT2xpaTRoM0F1L1FKbFBhUDRYdjFs?=
 =?utf-8?B?bjloR0luVEZVVzZDZWRiYTViWVZiRlk2eHVEdkU4dWRaandRU1RZMFEzOUNC?=
 =?utf-8?B?RVV0SERFN2lmaVRsWTBra0taYmgyc1N2dUFKMTZTSzdwNnlnS3p3TzZ3c0Zo?=
 =?utf-8?B?QWZxSjgrNTRxMUVRaUlNUmhtMDVVRDJITFVuOUFsSUZqTzBjYmZhVkowais1?=
 =?utf-8?B?MTl5MHRpTjMzSGtYeFJjVFhKaWNSVElWTEVmU2tWMldsZlE2SnJwT3RycGcr?=
 =?utf-8?B?anhiTXV3S0x6dG5mR2t5cUd6ZDNvUVVvRk81ZG9KaFlpYkwreWl6MU51N0gx?=
 =?utf-8?B?MjAwbnZna0xERDk1ckpNRUxXeG9YQTNRcTY4TktyQ0dPYWF5VUVJUzJ2Y1Z6?=
 =?utf-8?B?akdCSXQ4K2xnUnU4VjVRZWlPSllIT241NW4xd1REMmJnbzFZZHdaVmVhSU5V?=
 =?utf-8?B?Z0NBRTFuUHhXWHlxeGQ4UHdHNXJhdnZmcHljUFI3aGRjRkdwL3MzcW8wS09X?=
 =?utf-8?B?N3FiSDlDYmFsd0Y3N3lKRTVjUDFub2syVXVIbTlvMmE1K1c4SkYvTFJqWHRP?=
 =?utf-8?B?dENJQ0dUUGp2MituNmVsZEdtQ01qU1RFNUJHYlBPS3ZjUWl2dzBUbzdlZ0VP?=
 =?utf-8?B?UEd0YXpTaWdYTVA1UlZaWUFEd3NqOU9oTXNZQWltU21aMVdwcm5JMVNqOUVT?=
 =?utf-8?B?NDVPeG5jcGhraVBFaVFSMVUzdUlIT2lqOTV1WTRjYmxPUGJiMUsvQXF5V215?=
 =?utf-8?B?MGFsNVBUT1czbm5TYThIcXBkV21PQlFMeXJyVVZ2cE5vdFAvcUFZeTYzNlgw?=
 =?utf-8?B?Q29UZzUwZ0oyMkNrY2xLRCtxbENKaFRFRlE2b3BjcysyK1lNNVA4bXFIVXc0?=
 =?utf-8?B?QlZVbDE2UHczUkt1R2xQZnRQY2lQdDY2Sm5pWTdMelpmcEltbmtpbXlubEsr?=
 =?utf-8?B?SHcvWDlnQmRrOUhKZ1FWT09sTjU2L1MwbUlOcm5QZnhKamdPcnpSaEM3ajlr?=
 =?utf-8?Q?vEWRSRq62OuAElZs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c3e0a-d5af-48e5-2163-08de6298807b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 20:20:26.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T51EsAJyCJ+hbjKMpXnOopXeIU746Tvb71RSlfwzZjyFX9MNBV9egzegUhk6Geei/ujyEI4p8Dk9cCP1OuIobk9I3MoA7ihy0TcynND3OOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
X-OriginatorOrg: intel.com

Cheatham, Benjamin wrote:
> Quick Background:
> CXL.mem isolation and timeout is a mechanism that allows the host to
> continue operation in the event a CXL.mem link goes down or a CXL.mem
> transaction times out (semi-analogous to PCIe DPC for CXL)[1]. After CXL.mem
> isolation is triggered all CXL memory below the root port is inaccessible.

...and this is unrecoverable in the generic memory expansion case as
detailed previously [1].

[1]: http://lore.kernel.org/65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch

> At this point writes to the memory are dropped and reads return synchronous
> exceptions (platform specific, but probably poisoned data). The alternative
> to this support (which is the case now) is the host system resets when a
> CXL.mem link goes down or a CXL.mem transaction timeouts out.
> 
> Why I'm Sending This:
> I sent out a patch series a few months back that implemented CXL.mem
> error isolation to this list [2]. It didn't really gain traction due
> to not having a customer requesting it. We (AMD) have heard from some
> customers that they are interested in this support, but aren't willing to
> help out upstream.

Then they get the status quo until that "interest" matures into shared
requirements definition, clarification of assumptions, and consensus of
tradeoffs.

> The main motivation behind using isolation we've heard
> is that customers would like to use CXL but are worried about system
> reliability since it's still a new technology.

That does not appear prohibitive given CXL uptake to date. Isolation
does not improve reliability on its own. It replaces hangs with poison
that is fatal outside of constrained use cases.

Now, all of the push back to date has been with respect to the general
purpose memory expansion use case. The way forward from there is new
evidence that the expected mitigations to make isolation useful still
result in a usable feature. The evidence of *that* is the new use case
that Vikram proposed several months back in the CXL collaboration call,
CXL Accelerator error recovery.

In that case there is a chance that the acclerator error model meets the
requirements to make isolation useful. Guarantees like 1:1 host bridge
to endpoint direct-attach, non-interleaved CXL.mem, and limited risk of
core kernel dependencies on that CXL.mem.

I am interested in the isolation for CXL accelerator discussion. I am
not interested in muddying through isolation for the general memory
expander use case without engagement from deployment use cases.
