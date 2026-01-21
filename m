Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FD34CFA1;
	Wed, 21 Jan 2026 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021151; cv=fail; b=RQUJFrOZuV9dE2Zw+C/Mjc8KkZphODM/CvTw9ufbJru+U9BpS23Y7wKVltIeik9TBg6vxfqzz3zYh5vLjxpuO2DbBBBnTJGHMONSMqfGvTa8koMCLA5YvCiFYPTSzeHuvcMJreW26Dsu7itlrV6D4lueVHKBkiOGU9mEDqfUDG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021151; c=relaxed/simple;
	bh=N5PSeXCrCB8zSGDdxL/U1nqUnJIIQSyNSqbS1+BLyV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cGVILKQvY6awj4WxEHlcZrK9gnC2ukB6Fu7BpEtLgEMOJb9xgUBVzYDvrdito/zMj3nDSzqjObGaqfsZW1b8u4LonIV0JkqVMkGyEwSQ00xI3lUoRvRe0+NuxqbQAgeFMmUckIbmwv+BiX329BM3JGLqUIzn772T4lOIjHzwuxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpRSzHUt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpRSzHUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769021149; x=1800557149;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N5PSeXCrCB8zSGDdxL/U1nqUnJIIQSyNSqbS1+BLyV4=;
  b=gpRSzHUt1n4K7ZwsVyuFoRLyK7vHM0ssvI3gRVs7BmUiM0Vk4pqfEIvd
   tVRWS+99Klxgh/TrkMF60jx4Jo62Qhk6Prpaaify6pWsi34j/WhJQYWsS
   9FTstmIpEX07Hq8QihZoxi368CstBX8jLSRN7/uWY8IJZ59eoOfaIic8K
   uyYpvcgPysJOgBXt1qyPbDSn0yIHxO7PuGSeLTO16S8YrZHpgvKtfMkDP
   A3f7JRcyc8jEESQ7GB9zlQuCPAL0DBlNSZk7n3xqrEOrto384jpjLTUPB
   17g6FwI/te2Zj8W3X4PRQgFq4IGb3lEcZcrADaOWgivWNVhYO8t4IAQpq
   w==;
X-CSE-ConnectionGUID: CbXBBL+RSry/Fra9nGAnuw==
X-CSE-MsgGUID: 3x/cSmAPSUO96nSsGqxBSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70169115"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70169115"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:45:49 -0800
X-CSE-ConnectionGUID: QGGaAu1/R8OTSowkpFwLTg==
X-CSE-MsgGUID: VWl4u8sSRvWpz9nEPnjbbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="206127986"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:45:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 10:45:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 10:45:47 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 10:45:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwqhTC2Wmx2rCfTSkJlm+gAcV8y3J5DpYsifq5rF1Q09+8VE7F7DT9pS6Lvujlnf4U/75+wMuZr9tuarrK9MIUcHTzjirFYc5Ps1itD9+sAsJQja4Wi1lrWaT7NyEsc+U/uN1xIzm6GDiFQQ0ffOnDq+EjFwqBjnCp3vBTC/3+EPTmjWpXBGQpQjutKyywOi1/EVzN1Y7WEN2yK7z9nwVweT7VsnNIdpj/4HEQMsh417Y5+6AJ9mEGHH7q7ujxxPFfFNFvmlgp0BxJKTZySZPNeXUufCROOTvQc6OhMx4PA+lKtL8gjEMZAG+8Dp4Ux0xqYXnMClBwODTgZ8dy5twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NefA4SD/W/bfgILGPDxKWij0D9a/XW3TXPYlLpURKA4=;
 b=Ziu+943PEgPT2qHXajRGa0FForVKZ4fL3u+Vl/aNeNFe44euTGq+KGMnWz8ichUB5cJ7E+AuDa1xErA4LOdVUWDSE9LKYxA96bDdsEf3Zkt87puSxxwlLpnuL9BDC3LgzzxMDl+g1FZuyvHIDHYg63esKeGnpNiuma1EoaQSOyMOnsf+YfXfUbxxyn/Bkm5XDMNp2T7VcSS14lHosDeOm0MaA+avZtv6ALu+hDg7M+vf0TLqVTuTEY5IpUfdFitmtdgGkGIkGrGFIks91y9xUelECvRbHrIJIf3eNjKhi6JI8+K7wT1QCKPnBPj6uqeTUdVlLgFL4kpBlkSV3KVmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 18:45:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 18:45:44 +0000
Date: Wed, 21 Jan 2026 10:45:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 0/1] cxl/cli: HPA-ordered destroy-region teardown
Message-ID: <aXEe1XPDZ8eGPOU6@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20260120143212.3006273-1-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120143212.3006273-1-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 553e7120-b1ff-4630-0629-08de591d48e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGFuQ0Y3YzJGR3dzQ1pGenpueUJiRk92SFdYWFhHbUtmcDZGZndtTGI3K2lI?=
 =?utf-8?B?WWdaU3FXNW16OGNtWGNadnhvdmFkUDMvMjJQcFh1TEwxWXN6MStKYUFUeU5a?=
 =?utf-8?B?OG1rSDBsK1J1anhiQWx4TnZobit5VC9DbEo4ZkR4V28vQ0pXejY1S2ZHaUdQ?=
 =?utf-8?B?UzlxWHhrbkdNaXdMYS9rOGNtNzVLL0FNNStGUnBadWZDb0twYUZRYXpjcW9v?=
 =?utf-8?B?cy9RQVQwSmJESnJxWW5hcWh6eFZJV3pZWDNLWW5pWVN5dlh1d1R4Uzljc2Qy?=
 =?utf-8?B?T0V1TEY2dEdGV094SkgySmdrWGh4c3hwT1FES1FlVGRBN1l2NWJqUUJ3NklI?=
 =?utf-8?B?Zm5WQmpUZWU5bzB1MStYdElRK1cwZlNwOTVhbURQbUczWkk2aXJSSmpDYkZa?=
 =?utf-8?B?K0VWMFlSSWpIQzJPcXhzYnF4ZzZHbEZwVmJacVRJNmpxWUFOOWlYMFZtWko3?=
 =?utf-8?B?SjJQOGpOTjBaRkxGbVJWQ3NuUzBpYkNqSDhWSnErWmhaWG5lNlJqWW5sdTlu?=
 =?utf-8?B?OE5RWlJWS2YwWG5TTW9pbFlXZG5oZjlpOU01WTMwRXZTQ2hybkoycnJ1NHYy?=
 =?utf-8?B?OGNraGlOemtGcmhXUVI2UEEyWnVvTlRzcjVJSnQ0bVpoUVdQbDIvZVNPRzBV?=
 =?utf-8?B?eWRhcmEzMElzMEUwdk5HMzhzZzIyUURDclBpSnVqdFVYMzBUZzVnYTVjWXJR?=
 =?utf-8?B?Nm02WGFOYlhpRXYzdGdmaE5SajZsVWljSDlGRklEOFNMV1dvRkUxZXlrTzZC?=
 =?utf-8?B?S1NQL2pWRjljQ2IySFc4VlNRUXhzbis4NEllbGsxQjhIQWFaV3VVc0ViVU1o?=
 =?utf-8?B?YXQ0L2g2MFgvRkF3MlBJVnBjRnRZdWVYMHc0Sk45em56b0Y2YUxja0R4dkRi?=
 =?utf-8?B?NHF0Ky9lNEdDQTJiOERYNW4zL0xFcWcyTE9IRURFZ29paFBubzFibUJ5THA5?=
 =?utf-8?B?bTNqTW5IMzI3b2lNOEtDcjdidjM2aGpMemZCYnRXWkJYZStKVzh5VnJCd0NW?=
 =?utf-8?B?MW1rVVdjVG5zL0tYY21VeDhZZkZrQ1RnOUc0UFFxeTNLZWtUazdHeFF0RTly?=
 =?utf-8?B?WWZIbkJnK3dYT3QydFVBd3NoMnYrK08ydzBuNzRTRmRBMDIydk52blBPSUpv?=
 =?utf-8?B?cExUMFk1ZGxIYm1vT1dWbVNiZ1g0RmRvT2RhR2k3Smc5V3FpbUhNTUxOcTlN?=
 =?utf-8?B?b204VG9IZ3JnMmxRcXNQdmJiN0grdnB5b1JUaDZTV2FFRW9zUTlRWjAyT1Vi?=
 =?utf-8?B?QnVkOWppSzRPNGVyMUl6R3dnOG5EZ0EvNE52ZjB0NjFZSVpoOGJ5R01UVXUx?=
 =?utf-8?B?c3J4UC9GVDZSR0k1MmdrR3QvbVhPK1JCb2M1MDNjeExzcllMSC8wczlYcXFu?=
 =?utf-8?B?Njcvc29NenVNU0hPUGlwR2hrdW1iTXB2V3R4ZTVlL01VN2orbVlmYWE3N2RR?=
 =?utf-8?B?NUo1QlpzVEp2VUpvb3pGUzZ3dWNtOUdMWm05V3F2NlI1MUhHS1NTd2ExQSsz?=
 =?utf-8?B?SzhDdE5HbWpSWlZmcDcwdVgzZlhNM3M5N2Q2Z2dyeGlzNk9CaXBOcWJUMXFm?=
 =?utf-8?B?V0lwc2NuODlFN1ZWT3ZxZEt2eHBKWkRjVGFTQmlPVGxtN0hKWXNpMGlWZEh5?=
 =?utf-8?B?RGRXYm9rWTBkT3Arc3pFYkdTV1AzM1pQZHRnYjBVeWNVT3YxYzNJQnRWdkFD?=
 =?utf-8?B?bDNBMXQxeXNQZHU3R3d6ZjdrR2piNk13QnM3eVRLS2RCcUhnR2RiZENiUmNv?=
 =?utf-8?B?NTZ4ZUQvWVNtVVptRjlFVzRncm5UQ241WnhiTS9NVGROMC9FRko3UFJrTVRs?=
 =?utf-8?B?bE9oWUVhbHlDMkRLazNYeEwxZlpzbkpkb24xTXFNSFBSVXNyZ2NSN2U1VHZG?=
 =?utf-8?B?QTd5NXl1ekhtc1MzRzJ5eUdPa1k5d3VsU0pMQUNoc1VLV243ZThra0xKZThT?=
 =?utf-8?B?cFh6cDZWRFNJOGFpMmZCdk9UcVQvK1h4YmdGNHNJNGJvSzNJSXBqNUpWTGgw?=
 =?utf-8?B?THZwSjNXYVdyUGduVG00OGlySGVQSHdyZjcrM293MGRBdHdxemw5ZmU3U2lV?=
 =?utf-8?B?ZG5PUW0vclJPOWZicW4vNEJ1VWwxcTlMTWVCSzk2NW1maHlWS0hodE9lRFdk?=
 =?utf-8?Q?HU+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05zVTZHOTl6Rld3c25TbGdlRVlsbzlzQ3A1bmV5SFFtYXlwSnlRdmpXUldU?=
 =?utf-8?B?SGcyYUgzclltYm9RdVRLSVFYSFhqZ2M5N0J6b0dDbDdMODd2VVdrK2pZR3A0?=
 =?utf-8?B?QXRRMGRoWFNzSDliWXZNSHA3MWoycnJ1YTVkdXErOWZPUDVxZkMybnR0NXVi?=
 =?utf-8?B?ZklFa0J3T3N4NlZ4N0dtMWNGeUVXOGc4TnNaVllpeVFLY1RIbUNFR1pBbmdH?=
 =?utf-8?B?YW1JM0dYZ0gyQkEyRkQrWmRzWlgzTXRPMWtCTHFCWnNvSzV2WWZ0cU15T2Yr?=
 =?utf-8?B?WFowWWoxbXZhMzFDN1pnNXpCU2xVN1FzZmlPa0Z4MTBNdW5oWG9DVDQ0R3NE?=
 =?utf-8?B?T1NaTUc5NVp3ZE44VTNsQlk4dGFRYXVsYTBGeHI4U2czTXNCcGp4L1EvVzBY?=
 =?utf-8?B?STdlMm1jRTRYUFVCT1RibVhLUlJtRDlDWWZwQlAvdVVHb1V3R25TcjFVMURF?=
 =?utf-8?B?S3o2eDAvQllsS21vdVBWVE8waTBpUCt4VVZkRlVXUWdDd3AwYllHR1lKY3dI?=
 =?utf-8?B?Z3lQejRabVNMNlBMcy9BdjhlS01iSmFsZnRTcUprVGtlV2lZU3lLa3ozNElz?=
 =?utf-8?B?TmxDQW1LN2FhbzdZSGo1SG5POXovZ3Z2TGFIZ3BCN3ordDZDaUxBR2xDaWVY?=
 =?utf-8?B?ZGluZUNtYk5xR3JuRjZKOHB2R042RjNrT05kNWhMMUgreHRtTnpFeEtoQTN4?=
 =?utf-8?B?cWp5Q0VBWklUMi9JMmtqY0VwVGFyZXhOcVpqWkpzOS94SzJRempnOXA3ZWph?=
 =?utf-8?B?aEhrcmV2WFl3OUw4Q09DSy9LTU1oV3E0NUpURExJUHJDMGcyMWdMSDVkRWZ5?=
 =?utf-8?B?OTFuSzZMc0pVOFc0eTVYTmIxbDUvQUgrY1VsaldMeHVDaVRiR2dFUW8rM2F6?=
 =?utf-8?B?Z1NIbDRFclBGN3BGbTV0ZDhRY0NCdkl4Nk13dHR4bG5mT2E2bDVBVi9KdUEv?=
 =?utf-8?B?UzhQZkxBbi8zRGZBamt1THJ3RVlDdkZjZHFQM1NPMHBVU0x3UHVWZkc1VXNt?=
 =?utf-8?B?dDcvNk1WMHA0QlEwcXdlM1ViMEM2ZDczWmticFViS3JIazFac1pod25DQUVn?=
 =?utf-8?B?NGtEckNyL3MrbUp2MTVlOG56VXFLOXBHTzJFRnIwYlp0dUJLSnc4SzJsbG9I?=
 =?utf-8?B?Qm52ajVsNmN4MWVObmRkQ09NSGQrbTZvQk5nVXhpSVh5VnpVT2NReVRVUVdk?=
 =?utf-8?B?RDJYYXVTUDJUMVovWDdmWFgyaHFWQkZyQlVwMGFqdVg1Ym5QSzlRY0xOUlE4?=
 =?utf-8?B?ckh2WWhBbENmU2lncTQwZDRWRDNSTHVqNHNuUXZZbTJCQVdMOThnL1JlK2Mv?=
 =?utf-8?B?TEM2TC9mNHZobTBHVTdpWVU4Z1dGM3hvc2Q5RVBIeTFjYVZqeER3VTAyN2NZ?=
 =?utf-8?B?VnNmSklWNTNzRWltNHBJZXVSRklVa0U1L2h0cG5tYTJLZDZBNnFjOE5TMXhH?=
 =?utf-8?B?WXNYdHpRWm14OUNwRG96dm5ZWFpnQURuaWhlNFBaTG5PemFYUDhDcWdhYTRN?=
 =?utf-8?B?RDBnUUpGODNjdEZGdHNKK2FTSlErb210WDZwdklxaVlVV25hbFZwZUpWSHFC?=
 =?utf-8?B?bzBsVy96eUNIN2NoN255SmZvOXBZbzU0U0NQKzdabDJFL2lINTk1VVRIK2Nr?=
 =?utf-8?B?QVA0VHVvOTMvZi93UUcreHdZVnVlZ0tYdEJqKytwWHpmNjdiNzV6NGlsL3Nz?=
 =?utf-8?B?aVBaVklNMVl3a2MrM290VXdvNW5leG1rcHNsNTE3RXhRdVJYVVpOWHhKVjVk?=
 =?utf-8?B?a2RENGlCc0Z4dGQyMzU2WEQ5Vm90OFg3dlhtWmhBSVptODdxKzFEOUVuZS9t?=
 =?utf-8?B?VkFURi9PSEZIM2pKZjlLSjJ1YVJXS1diMGtjbXFnUFZSUDBZdGpjQlBuMDN6?=
 =?utf-8?B?c1lFRWV1Z2xUVGY2cTNZSW5tQVpBRDJTNVR4YUxHbkV5MXJKMk5pS2dRQW9H?=
 =?utf-8?B?Z1p5WnlEbG5wTGRYNXdEUjZJT21LVU9lWkRhcHBieDczZWZKWlYrYS8wM0Iv?=
 =?utf-8?B?ZDUxRFh4cWl1eGorQ041VXJZeDRRNHZyZWNzMGlaYUxHMVM3UEN4ZU05ejJI?=
 =?utf-8?B?TXhJaEZLVU5SbFZ3NXArTHExdmZRRjVQdTd3Nk5tN0JCaGJXSS9ZM0pHeU5U?=
 =?utf-8?B?aHhtU2ppenVTV0wwbFpIeCtScU9FWDB5NlViRFB4c2ZtNis5b0oyYVpUTzJJ?=
 =?utf-8?B?YWo5MlFuczU1c1MyREM2c1JHMyt4TWFKbWJQeVlGNE52R0ZqVmVJa3hsVTZz?=
 =?utf-8?B?bFA1WlB5TnQxRnRFVHh1eFpqTGpuT1RUUkUvZC9vMVowVkNpWWJFV2FKK2FF?=
 =?utf-8?B?TjlCazJQMkRwUnVqSHdvVmpOQ05WYkozYnVEWlVKR2ZBVG45UzdWQ3hpKzU4?=
 =?utf-8?Q?MbM/DJSMp/c2MuD4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e7120-b1ff-4630-0629-08de591d48e4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:45:44.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icitkwfn7lEkGnXPHCQ13U/EM06k2OmUFigUz9X/uS52lkiVutdf7OlpKnzeG9IvcxKlPogIdRFsGNXoVTAV0YaI51dQlixY7zeV4XZBkbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com

On Tue, Jan 20, 2026 at 11:32:11PM +0900, Pawel Mielimonka wrote:
> This is v2 of the series.
> 
> Changes since v1:
>  - Rework teardown ordering to account endpoint decoders shared across
>    regions under the same bus/port
>  - This addresses scenario described by Alison when a memdev is
>    targeted by regions under multiple root decoders.
> 
> Alison, if you have a chance, could you please retest this version
> against your multi-root-decoder configuration to confim that the
> teardown now behaves correctly in that scenario?

Hi Pawel,

Patch isn't compiling - first error:
../cxl/region.c:854:48: error: ‘decoder’ undeclared (first use in this function); did you mean ‘cxl_decoder’?
  854 |                 cxl_decoder_foreach(root_port, decoder) {
      |                                                ^~~~~~~

For v3, please send the patch as a new thread, not in response to
previous. See here [1] for some ndctl patch sending guidelines, like
labelling as [ndctl PATCH v3] and sending to the nvdimm mailing list.

I think rolling into one patch is fine, and would like to see the
entire previous cover letter info in the commit log of the one
patch. It set this work up very well.

[1] https://github.com/pmem/ndctl?tab=contributing-ov-file#readme

Thanks,
Alison

> 
> Pawel Mielimonka (1):
>   cxl/cli: enforce HPA-descening teardown order for destroy-region
> 
>  cxl/region.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 
> -- 
> 2.45.1.windows.1
> 
