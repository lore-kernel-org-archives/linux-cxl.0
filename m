Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5133D6461;
	Fri,  3 Apr 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244959; cv=fail; b=uMHaclZmCSI83wyTWfpE2xj6gDuJrCXsLQb4QUNZ+MAfnSVK/RAcKwMu0Feyskqz3odnCPgzgP4IqlWM1ct1cNFph45NT42z4ce5ORDz2XmJEqaJ+ih4fwjlZBri33C8OE13jkZiYWKA0XtlTS8XxPEO/clOphIfyPxvVvTGEDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244959; c=relaxed/simple;
	bh=tZi8Px64Fif46ncJQTNS/ceyrK7DVWZwQbYDzhUf21Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fNyDafXZGwiNIPBGlmTTrwbUs1OlIB1slcjR6Ml4WYXV6Lg8I9BTYxYYym0Q5ttflzTrpZitV3u4DUDYjyVFpQwro/tlyTkBCFiVNrr1VhZ3zKmH/hIPcAxW4nB1eeDPRcrP1etsH48++lfUe4wKRGXVUuOW/lrhpB+Cig+RZ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9+p18NY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9+p18NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775244957; x=1806780957;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tZi8Px64Fif46ncJQTNS/ceyrK7DVWZwQbYDzhUf21Y=;
  b=f9+p18NYexY5CGve9omZdufje3Lc8piKhZBhy3EyfApeBVa0NiRBPFLX
   tea2bszfZiGtrvJPXtNBq65/T42csS6cfKMQ6wO8Ur6dzIN7SXgjsCdlE
   4udyNJj+aVGaIoTuC+hu44O6tSvaLpgSOuIh+3py5Q7FV2jxlA2C9oHwC
   FdZEsJo/3Ezl9fHXhVN88rW9362pwsYxdmOg6CKri9jf4qN2DnJzl97aB
   KA2ZMEWzEGww2JJYQX5FilnNwzBnvnjjRGEHKUQiTVIoadiEFL2fnh8jR
   cpiotAmHv+00elc6BbGx1oPuCp4P09FRcfkM7ArL3b7hLJod9gpCme9f9
   A==;
X-CSE-ConnectionGUID: A/RcbW6IShGDvG/aQC5SCQ==
X-CSE-MsgGUID: F7NosQM8S363jrgQllFkwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="86928891"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="86928891"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:35:56 -0700
X-CSE-ConnectionGUID: hLtmqcFHQniPfRDHNFL2HA==
X-CSE-MsgGUID: 8bheJWfdShyeI67X/PGHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="220692244"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:35:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:35:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 12:35:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRQdqmTmyhmI2WYgo0WJkhi3UI6CopniI1f3npVQLnQh9lG63XDiHW7WZONQ1ZIVPokt2gl1U9gMtg944DHhLvusHKnjKa1v4FEBr445KkY/CWcOXiDFP3oLfeFdXRP2VXQZ8ZudsT1cipeL9yEF3wEV3eFQgK2XxZl9t32+xM4uFx0uYpu+c++dD8Te10JmU4RkmSXA35Fins3vw69qnsRpajaLgmxJ2pDqJ02VXlWSIcA+iD8NZm6jjGadouMglmlqRUq29BJJQgBRRr067uwKdr0hy57kRpSxoVbLniUz4r/aYP6CdE4+ToLa+R2+EMn8qAoMlQL99AV9FbJPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AS5FAQ+08zw/BcxSiYw16DO+z/NtABXJW2iu58utHU=;
 b=lk3JxUNhLO4eDsUiWeD/8IhGEjXASgCkzwzDq3fKFNybULujrWaTINhsSVP4BEGB582EBb4ZnsM69969lEzZxqNkoN0B85OAxIJYqpj4az9bI24qQNROhSu0WGMyRLSyoDWS0QQZAZHKz3jdanINhFkExi39g42hI5sLMgAC/KcmfvD40ZVoYPbJRw5iEw11LfGtzZo9xCFZjdVWVytJa1BmzpF45VMwGpIka4CHitUw1V9Ti0lF1jFMDvSA8LBdqCPdPdxt7h/H8F3V0H+jF5qVmS3szeGhbQHb8eoiQ2EfDXoPMCrB2g+ER2rIssAHlwi7+8LhfvfeknEsNMxzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7327.namprd11.prod.outlook.com (2603:10b6:8:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 19:35:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 19:35:47 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 Apr 2026 12:35:45 -0700
To: <mhonap@nvidia.com>, <alwilliamson@nvidia.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dmatlack@google.com>,
	<shuah@kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Message-ID: <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <20260401143917.108413-17-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:303:8d::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b917f75-3c1a-4665-ecf0-08de91b83439
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IacKAjaaT200ALIZondovzcqQy9E7nPGdrgj+gBlEbtbHYj9vPpEpyYCZYjqKPA8lg+PL1yntdxoCu46fpPBcuGNiJ0RAGGS5HR6I+9tbBoHjKZsZJJB2PvP1Uqk+wlcg8uddPffMF/RIH2EeGto+zGmXMcL+2P+MAeNyH1Aq5iDgkI8o/H3fTlDccyEQRi0nMZF6mBD4btI8xZZSNXOye2xSCoUDpg1yHcO94VXNk3agn3kihHUFgfcAvkDuO75M27JxWkC3+czix+m7SJKnMcUGSbJuzjPfnmXEFPhk6kVuvR8kdw3FhXWD3LLiuUUxC9ckAZ3TtiSaXe9S3AHj0EzGrNQuKlGSVLrdS0K6q54lZVWsLDyvVJU9z7ZcrKHd1zYn76tbwC+nwAgTbiF8z5RIEGTgRUtzr0lSZ1rzM5mM09MXa2WutatZ32jGDqXpV1ynuHiLYKspBgMwLKAJyJt6sXhGjXabkjarBVSiEOvlOJOskIxJ/sZlhOLWrWBM+irQO3qk7RvmBmw8UCYXJ1jVdfaJml+i08x3vEVljKZjOvtuJStfPE9FvN9VNj7hAztIrVHq0Y7JxjNLi7xXJUwRWQBlc3D83gdQCVUNp925vGzDecd3rLadlGzD+isar8mzMCgYhEaXLptffDWcqumafMBGHH/YOjJhxlKms2q3JFwvnWWVgaxq17t3poA+6DU9HkVBi8THFAIelA6CrvJuwlG9qV+HkGcSfaG76W0vzBKIVoyJYi+8lBSaMkNmakluDONMh6VzyYuphDJDPmBts1dDyLdOhhZWEdo/Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhkU20yN1JvVkpHQVFRVU9wZU0xSExJU2FCcW8wa0ZCY0d0cTBvOWNjU1pQ?=
 =?utf-8?B?d2I0QUtocFM2TGR0M2NFS3ZaV21ZSUNlcmdxOFFFb1pWRkQrVTV5WEl6RU1V?=
 =?utf-8?B?TUhwd1F3c1lLTnFOKzRjZzdrVjZlaG02VDlSZXYwZ2NuVnJYc01OcGR6M2ht?=
 =?utf-8?B?cnkyUFZUS3JOTjRqUUdWZk5WQkErdkVRV081QisyUGJxeDY0NUJIYVFxblBW?=
 =?utf-8?B?ejl4Tzc0cnorUE54RTd5NHhMNGt3clhiY0hOMVAzaWloSHFBdm1IV3dxTUEx?=
 =?utf-8?B?WWU5NmlOajRzVlV1Unc4bElGZzNBZ1V1T2VPTVlFaWg4WjJraCtOUE1NU2cv?=
 =?utf-8?B?Zit4dDVzbnhERk9PT0cxbDUyNlZ6NFFOU3ROUU1uRFU2MmQvM0tjM2dWODhI?=
 =?utf-8?B?a1prdGdqb29BRlloL0NCZ1N5QkhLak40bWE0QzI2Y2VZSkJrMWJ1dk5mK2k5?=
 =?utf-8?B?ZUhmdFgzL3Z1Uk42bW9ON3JQR2Y0YWVxMjZRRldBblovbHlEYnllK1VoNGpt?=
 =?utf-8?B?TlFUazNCWmJ4bWdnQno3bUZOSGh4WjNaWjk1SVRYUGFYeFFtclBla0tFaC92?=
 =?utf-8?B?akFENE10UVBRa1I3aTlhaUVoUGlNWW9uUE9DRVQzRXpTTHRQdTFJY3J5RHds?=
 =?utf-8?B?TUhWbERSaGhmUUo3WXR4akFqam9WU3ByWUduMDJOL29TbU5XT1dKK2tZeVpD?=
 =?utf-8?B?SFlleU81N3lVczdSUzlQd2tobFlnU3pMZmpMRCtQQ3BRSHpRMlptQks5UWNN?=
 =?utf-8?B?UVY0UTB4OURLWFNBbnZoYy9SNkhxdVorZStMV1ZlU2VVZHh4aFlFTVlLbnht?=
 =?utf-8?B?YkgvaGFWbTVIRGticnpRb1ZpVEcvU0N6SUEvamI3OGxkRVJIYnZuRW11UzhE?=
 =?utf-8?B?WjV5TUhIL3JaSXNyM0Y0Tlhkc2tBUXZxNThzV1FHZURlUWpRU3p6M1B6clhx?=
 =?utf-8?B?YUlLVmVtOW1iVGptd01kVjFMYWkvL002MWo3a0c5cFRMODJ6R0RzUkFwOHVU?=
 =?utf-8?B?RHZBSU81ejBQSmcvODkyVzZjMitFalNiKyt0eDZjd1F6TnkzRUFtcVRFZXhw?=
 =?utf-8?B?b1NmcDBXeU9wSkhwaXZqVDdZVGxOWUdpMWJjME5waTN0UG51MmtSU1MvRHdV?=
 =?utf-8?B?MUo4dlFtRzJlLzVCcFhiblgwQlNDakpuaHZWbFZTY2wraEQvUlJ0bldxL0U2?=
 =?utf-8?B?d2kraStEU05OZUhVWi80bFpGL3ozRTA0Unljc3NxUFB2THl1VFFBZ0tCVDM4?=
 =?utf-8?B?aVRIc0VoWkw0ejdDSDdXK2FBd05aZEpDRXJoR1FXVHFKQjdKc3RPa1NUL0Z2?=
 =?utf-8?B?U29QTmVRZ3lqTThGTGx3Ly96RFZoRXM4cytGNk11YlRWM2pWamJnQXJQaENt?=
 =?utf-8?B?cGNMeHJnNCtpZ1pFUExVa1A5YldSTDA1VGc2OHhBNUF1ZERkcFN3UUVxaVFr?=
 =?utf-8?B?RThDM0p0V1k1MUEwWjVpZk5NV1JFTkpEMC92RGV0RlhyeHVwVGdiR0FZQTFz?=
 =?utf-8?B?eGRoaHlJOEg1ejkzRVNxUmFvS3VDVS8rdks5T1pIVHlXN1ZzNE1lZkUvMENR?=
 =?utf-8?B?T2ZDQ01sdjFxNVlOakV3b3dDL0RKb04yQ2t0M0VzSmZTZjZpK29ucGdvMnUw?=
 =?utf-8?B?ak9nVjd5eWRtWm0vc3dGaHFlci82aVVPVFc0ckZRZlBFcnk1cGluZzFLSUN0?=
 =?utf-8?B?MUlSK0FYUEQ2clViWmpRakFJWlN3NFZkNEl1WHpCNGtFWVNjbzM4bW9temlo?=
 =?utf-8?B?T1NwYTNGK3hybzlyYktMekpMUjdmQ1h2N1M1Wmx5MkpWeFJqazZRYVI5UFlm?=
 =?utf-8?B?UWJrc1JtQjVWenk5OWQ3RjRzSk9qeGhhVjhRQnRiRjhrZDZQRGxRQmlmOGNv?=
 =?utf-8?B?Q2VFMjYvZ1luTmszSldhdk9lZ29rUVV3MnRXTFVPNG9yN1NQQmxxbkllWjJl?=
 =?utf-8?B?c0dGaFRWSFpPdCtLQWR4alNoNnh2aWU2STAvVGE1RmYyWGNDVnh4R2lSaFZ5?=
 =?utf-8?B?NHIyMGMxdENsc3lUVTVyMVF3RFBIOFFwWUIyZTNiamVGSERMczhxSlQvODh3?=
 =?utf-8?B?Vjd5NkY1SDJxMSt3eHhoTXNQaGNJRjg0cWJ0YlJvQzRlVi8vYUNSeTdvSGRO?=
 =?utf-8?B?V3l0MkxTRHFPdUNFdHA3UWZGbVJTRWRnVmJSUlVFWS82eHh4c2pLN3hxeE1y?=
 =?utf-8?B?OXFmM3h2dmUxbVBwYnJPQzdrL3V2QkJEcGFVTFRHTzNLVXNrY2Ria3Npd2FI?=
 =?utf-8?B?dkJGbEpWQTNJRmY0NUxzbTVTRkRWRXllQWIvTVlJWE96ZEQvZFBoUjdqSFZk?=
 =?utf-8?B?ZWw1YkxLU2hPTTBKTmpSMnlHS1RKSm9VTy9uME4rVEw5MDQ1ZVc4MnBLOEh4?=
 =?utf-8?Q?XYfeAgVRYvS8ZPKU=3D?=
X-Exchange-RoutingPolicyChecked: gOXlwbcEEsZkAiS4jPdcTMd6OGth1XU9W3EqueUl+3Sr1+mYHLHDaBIbsMD37IE9Q3DhLn7aYiCOKyMbmJflNgEfgbuuv/Ahb4rLrwQTrPR6R6yNpl5nDom/wXSjyNgxqVcSbyjSrKvfkPlCGV/SF82XUwJpkphDeI+sOXCI6xLqJjzr09vXJQSxqOVLZxJC/lSp60VvYn5jxZAKVzqadfvqnKw2Eysv70uOswqVOJWdXYlFikpXpLSG2JitBjrnbJuiHorjtQH1Wox6qdx+yWJBaDV0jJ/Ve5vnpqWBYOeuD8oDK3do1CplQsy0qBBOBnv7LGeYN/W+ckU26BZuuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b917f75-3c1a-4665-ecf0-08de91b83439
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 19:35:47.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/7TxmZmru2Olb8oYskS4XvFf+fcxs7lsBc5fNDouet9NlDPbn5PmhEZiY52wQW+8SyCsLDz7gKB1mBl8DnO81ISNsqpR8my+IiqB3utN3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7327
X-OriginatorOrg: intel.com

mhonap@ wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Register the DPA and component register region with VFIO layer.
> Region indices for both these regions are cached for quick lookup.
> 
> vfio_cxl_register_cxl_region()
> - memremap(WB) the region HPA (treat CXL.mem as RAM, not MMIO)
> - Register VFIO_REGION_SUBTYPE_CXL
> - Records dpa_region_idx.
> 
> vfio_cxl_register_comp_regs_region()
> - Registers VFIO_REGION_SUBTYPE_CXL_COMP_REGS with size
>   hdm_reg_offset + hdm_reg_size
> - Records comp_reg_region_idx.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 98 +++++++++++++++++++++++++++-
>  drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 34 ++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h |  2 +
>  drivers/vfio/pci/vfio_pci.c          | 23 +++++++
>  drivers/vfio/pci/vfio_pci_priv.h     | 11 ++++
>  5 files changed, 167 insertions(+), 1 deletion(-)
[..]
> @@ -622,4 +640,82 @@ static const struct vfio_pci_regops vfio_cxl_regops = {
>  	.release	= vfio_cxl_region_release,
>  };
>  
> +int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u32 flags;
> +	int ret;
> +
> +	if (!cxl)
> +		return -ENODEV;
> +
> +	if (!cxl->region || cxl->region_vaddr)
> +		return -ENODEV;
> +
> +	/*
> +	 * CXL device memory is RAM, not MMIO.  Use memremap() rather than

Right, CXL.mem is RAM, not MMIO, so I question why is this not being
mapped via a RAM mechanism? Can you explain a bit more about why reusing
vfio MMIO mapping mechanisms is suitable here and what happens when we
get to questions like guest_memfd integration, page conversions, and
large page mapping support? I am looking at proposals like Gregory's as
a way to get full MM semantics for CXL.mem but without the memory being
consumed for other purposes [1].

Maybe this is the start of the conversation for something simple, but I
would actually prefer uncached ioremap() if only to avoid all the
coherence management and suitability of MMIO mechanisms questions.
ioremap() being a poor fit for CXL is a "feature" to force the "find the
right, something better" direction.

[1]: https://lore.kernel.org/all/20260222084842.1824063-1-gourry@gourry.net
