Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792598346;
	b=NxzkeXjihAl+VJ+pePMX9xHDojfEtW2EOx1JoMpYUQxe0JiEpQK4sklz3MTGrNdn1CJH
	 lwpqdaOUip3dgvU5iclfI83rJA/EqoDkN38U69hd/nVFxcVeNBzdWHbdhO0Jdf2VNZu+u
	 3lb6eH6hcOj/uh69lgxqfk4IvZEbBG51INjAkMTLGMu2GPphQ5EsS0rTLYdp65cJ30TKn
	 2rvNNnk/iROG7Jttitfd/FrAtd6F1RUeomI+oivkcWqEMR2uLeCTyXPfpnEstCsE2uAtz
	 EY2YbZ+qAdRqpxYfjBV95SPo1VsL/pYSSAJA1F39SwxY10NCvhIoP7KUb2IUhU3KAIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=YCN6koUvd7q4EG4JmLHOcoHiHJehXecRg22R+BC1KYk=;
	b=s3SORkbumYZGL8m96ocAHmMF5L2Oe4iqhZnJi4QHJMjLWa+CHn2BRXFXxYPTGASjTuqz
	 9tRvqCzzKO/h+DkQIWpOWU+jl9zJI7+WOv+zZbti2ItCMQWuf9LN2sjL3oKcCaKkIA+A2
	 7BATOcVfp7Q9BmEBnqtjxpgwb1DlfcfonihKDVRA9DzdwFsZf6w9ij/8HACe3biPCzHey
	 GK8KCmQh/45/YnsBN0yBe749WMK5FFoTek5jyIBeaHAR8WLZ1Sj7hTp6gr3UrvhjDhEzL
	 agVgPhpa76oHYkl4k1sLuk95p+ywU5wanD5f4MCdc5Bp8USc1GNn8J54T5VhB2XsCwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=alOdfHDH;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC913606A31A;
	Wed, 21 Oct 2026 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC913606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=alOdfHDH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598346; x=1824134346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o4MXPTjaXWRVCh3nvLKj01wtuOxwbwHqa8C0hEBCuZM=;
  b=alOdfHDHmj5QxkjRyE7dXDIeP510entovNurmCcD0V4UyifQv1aSAf7v
   WalG60bNNFu7M1bo4fhNixLN1OB2KFLbXbIf3BFOPhdjiWhIFqMS2Sowi
   faPMq48J1Fpf6avLL3OniKTdO7bK01Tu0qpGmSO+HF1DUPjZzwsIXitRg
   66jj8Nh3zER9P8o6DMIOZNJ11jnNhiVNYFKgBNTu9X9Ftye0AQvuHsJ2U
   74RohPzzJgD3Cq4751H/OWCPp2pRuP9amenqf4oAX3Wnsu82WGUhGjeNz
   eq/Y9Sumn8D8ZmB8n622fjQ058R1WhoCmpC4RWyJwfgQl3Kq7j9uowE3H
   A==;
X-CSE-ConnectionGUID: xVsSkZueSzGXkV+VMQV8gw==
X-CSE-MsgGUID: 2z567XQSSbObY2SAtSZ43g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1229717"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1229717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:59:05 -0700
X-CSE-ConnectionGUID: E3bQGCWZTV+pg7x0SFbxTA==
X-CSE-MsgGUID: bPg11uQ6Tq+tdYu6E1X38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3112278"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:59:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 08:59:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 08:59:04 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 08:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzYqc5KYnyqiRL+rCTYoNRhk1scMvjzpOrmap/whsNRh/7L6Tl0Ah3CHhdNzOzfjWydnXBu/7CmBK1iBgQB4sWTlR17wcWI/NUsl99G87RG3rA73pJG7QawDVj9GeGIYc9/icurE+0ynbv+sA+rVmjzclVNekgZmejfvt10FrfoUEPqEOPlob/qKuddjB3VqkXlXrA0bZUY7GkjePXqpOjRmK3xgceSZWrvRv6xF9agCnrPFX+zXrIQ/sza2zT/N+HZcOPej9zaCCFobiC+Gzp5nuk20H82FeIKE6z/jAfUVSwSpJ+OYy9ISRylPgJuegJ+lZVgCDO91wFeusHC35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCN6koUvd7q4EG4JmLHOcoHiHJehXecRg22R+BC1KYk=;
 b=V0axrbtv+1oqrDBKam7wVsZa6q15wyWgc6U2eP4lHmaLvtU/+JtqLebYiJj81jlCnYZ0qIAZM68QTpYvAgW6m/Q1YiL9gHkJ7e3vTBbpdfsp3kyE5o4k3X1vgWMR0fEf0Ryi4kdArh7WQzVpdw38T3P1X89Z71ERxn+9pyKN0AaVPA3i/3cUn2j/3ACIypSGjJkZqgK/4XwnPYmsQ90YGsYphcQ6omDaYyXR9XEsVXP7eI78UcB8ESRvqeXAmVmucKFOOJO5/BPAZ9LVQOihNFFLn7jRWFgEOn3LAh3l/wRj3JihaVQTcF5aGO1yqfHVWOfh+mN+7O2RgYnc5uTQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:59:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:59:00 +0000
Date: Wed, 21 Oct 2026 08:58:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yili Zhang <zhangyili01@baidu.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<shiju.jose@huawei.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] cxl/edac: Fail ECS threshold read for reserved
 encodings
Message-ID: <atjhQTk4k6On7Fcm@aschofie-mobl2.lan>
References: <20260928073553.85669-1-zhangyili01@baidu.com>
 <20260930095627.32616-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930095627.32616-1-zhangyili01@baidu.com>
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f2720e-3511-4632-89a3-08df2f8c38c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|22082099003|18002099003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Tf3vh7Kks+Gb4/Si/1unykA1AAYPqxldXV/ISEUkF5VCGb+RkUtypUB8D5LVgYz8LEka32Sb+YQHbmnNz1bPaUcSuPt625UjTUJ3jRWhaxoAZa0+M0ZTiwxzD6moJQXuc43xVcpmjx3HzJbR/Nj981Fom+fbLF3GcJeB9ukBgDhW9MtF+0dFzqDwTMTvJTLQUAopkE0Q21wdtnxic+WHOPih/PwX/huk0AqRjMPRLrP0u2dNaU1s1mmicPbWdHUHiVY3pKymO6qhmwAjNIea+pnsIhrJMD0cuL/ExamAsspgUBeSH28Xf5XhKy3a9BBBgYx7Su5mAoVpdRGo0HlNXJuOeJJ4eSez5JaMVZK93OM4oMW6qjmYY1r6TlnO/AE318YWeEZk6RxXTsksXPo/clMzp2pNyMAWNt8IcMHmTWt727MESdwW3ARhsihIGbzKEGC7fzOKEDH98pNkvZpy5BG6GLjnRNH1qQPX7UGP4RuvoQYfhrLhvNc51HdUrOjqTNc5BksN3pBbY5MhudCaC/rK1lR/s8zAmvhgiFi406OUNkwyU+QCuvX0UnX8N19X7UL1ap014n9LB2awctSgIhNAPh7Z2OoNyTD1WU6fJjB2fGIPtAl4dVnoo1EtxbEElERyanWNJYNh8uH5yX0hWyHZHrdCxyLeJoH1oLaEAng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jf0w8BOUm4vDsQlFhwztir//KDhyifTSaO1ljq9PJ7JeSNGQFcDAXPXrCVNR?=
 =?us-ascii?Q?MKtkZaeQvZup4gKdNlQ9wfQK3DHnmvMuQeRRj1UMnNMoGWORsCf3tR943f9S?=
 =?us-ascii?Q?JJrH/gp7IQ8S5dNWexTIOtnJjD/hoSf0LbV4MMj2NQWVuG24zUcNBooj/lHR?=
 =?us-ascii?Q?O0u7cQrZd2m3vlMgmQX0SGsDYIhAZ2Wf4UmExn/piJTZBKWPocQD+xkEP9bm?=
 =?us-ascii?Q?DhUMkxB4qBMZTVi3v0bCUSErLYGakt2/1LlYqPqmLqUbcbKYg4XY0q0DyAsn?=
 =?us-ascii?Q?4z4Cy9CJbAB9ombo9IYnKC79DdwLqDvajTxizZ0SasTS8GA3+bhIwtp/jlEy?=
 =?us-ascii?Q?u1C4L14iM/dwvJjbKRna0qazAQFVjtEASwAry8bnkypJ304/ukS+El6/Dn6K?=
 =?us-ascii?Q?7W8epil6Mcs6TqDw9sNuDTZGO1isDjuKudVr82CMIrcd+ZoSDREF/kre98EB?=
 =?us-ascii?Q?XZH8D4d9mO7Og+xaz5c9PNwIeMcLWFESOwWDvOJw/4yFzqmDgKKrt8xN/Jgb?=
 =?us-ascii?Q?GR2fo7Bdt7B8xCx/UFELqJLw5IsWM5KlHydCJA4WeBdMBI0/ET+ZVZFOVBzt?=
 =?us-ascii?Q?6myCVV0RTReyisbDRWbxrYET+vH5VnvEf6t7ZOQBqTJo5S7VvRuprdssLxFO?=
 =?us-ascii?Q?T52vlyqVgF+Zg14pMJQs9sUF8dkczzZQxs7n9+2dUpaVCCW3dZyeWvWhMMnz?=
 =?us-ascii?Q?3Pupokzgunn0hyOwGQ19C82Atp443cinMX2W1Zxw333bxAp5S8Av8+W7lBqf?=
 =?us-ascii?Q?lZAORR3bumlSdgPuz4Y9vzNU0I67djeOSL3B3mMBvdTpU65UNRqgvCAkqjF+?=
 =?us-ascii?Q?5yYICRepGGNgqZTF7f9B+zL7Yd6pi13bB+dL6NQQVBKizWYCgByFyVDMHtOm?=
 =?us-ascii?Q?vn81QL48zqH/K5eLV9nbfxUGSgW5bsqVihqdRnST0Zi9yUWwEKP479IMdthA?=
 =?us-ascii?Q?hN2c09n+2U9sDmxiEWcfY2I0hL1dAz9gdxVBSeswDecsDVM6DtQwT/CBhAJ2?=
 =?us-ascii?Q?ycidjpbUPijjLMOmVeBYrBhuE0UCcde5iZzsq8DYm/Q+wNV5rC0UiV7MLlJh?=
 =?us-ascii?Q?WKXVN0sfSa2qBeO7RWaxq1ZYeTWxyzR1Z4uecWqBKwa3/JUwnzIwglMknjBE?=
 =?us-ascii?Q?xHNSwF3IPXSVr5zf8pO7vMLDwlElWuFn/dwDWUUHxPSZfngd1yKW8LqrYg+o?=
 =?us-ascii?Q?6xa74YCrP+IqrwpVpRqGiLPlYMQnENxVMEL7s1mYHb8sLb02Z/JOJ01+STRp?=
 =?us-ascii?Q?YcgZRir4zi3h5hNR/4r2qDOL5pWCO4wVg7zBqOoR8MxrPbMOJqt9f78soHgv?=
 =?us-ascii?Q?RsPMUV0KrI8lmYaYXkNaF86xxvriX8VW+JMQXGivZcAKLM9KO7pvKUDpUlH0?=
 =?us-ascii?Q?BlocA+pxAULpUVvRogLaU0gCAXc/CGoYPkUzpeKt4OGnVSDPEblafRPMRdZ1?=
 =?us-ascii?Q?s80nPJb32lAY7P93xatt6Qk58fTmQTXsEMyAk88AAU79dZ6Y7RXOcsGydhr6?=
 =?us-ascii?Q?X43uKuF/NIDSbzPjwmmmexA5Wdp4teEbuhBw2iJBCDFkPeDKmXmCECPO4nuG?=
 =?us-ascii?Q?R5dE2aXRfPSdAmrVhLSz4tqIq1VbgmP6hUARi4LqQzfS0i/Ia0T8fD8yQYM8?=
 =?us-ascii?Q?Pv441Wapiz28Tj9fLb1yPXdWf7uFsNcamdn65fyYggwQgt6jN7gdVF3H76r6?=
 =?us-ascii?Q?wKXFoM18cZueZZErxH3+r+P8zmEba8RUXLnufoVme7euEBMZQsayTwEFNe1d?=
 =?us-ascii?Q?F1LeObHaqUVc733ltKcQCqkWzdgRMHY=3D?=
X-Exchange-RoutingPolicyChecked: Zpp7XkEIZf/XvpvYXavoiyrs6sUE/i8XaDsdG6fyIrZ4gpZr1n03QO734VwnGIVrHjHGG5GPqAdVVYRCsyuWxxVeRpDh1TKiak+8L26FHRnWwxOtMmFJasWrMJgiEr45BVKfuJ6Q7n77LRlu6x+pgZeE7mzHYa8QvsBAxH+zsimxqC3GLGtDVVg35d2dna5TgGPVN+Rgulc7KQlD944rMGrWDxXq/UXraWLfJJn5N+XqM+2p6qI/cHOrzIDJLP2mXPtm6MClHmP/6aGBGu+gBOydmFNgIWgNVV4O0mVwJMqbOwKSjm1DbEMvIX6gmxTqiE0bj+BaYcX/f37ENo8YVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f2720e-3511-4632-89a3-08df2f8c38c6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:59:00.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XdhV5ULHh0LbSDLgO7IPfnU/dr2A9+QnEI2BCqDx3ywN1xcMAEqip3+6bS+vpHraK1iNLh5zH+qd4hc8qcRgQ+tWoVdHJtglQmpOqQ2dUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 05:56:27PM +0800, Yili Zhang wrote:
> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied ECS config word and uses it to index
> ecs_supp_threshold[], which only has 6 elements. A device reporting
> index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> value is then returned to userspace via the EDAC 'threshold' sysfs
> attribute (small info leak and wrong reported threshold).
> 
> The threshold count field also has reserved encodings 0-2, which
> currently read as 0 from the sparse lookup table. That behavior is
> not intentional; it is just an artifact of the array's implicit
> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> supported values, so rather than documenting 0 as well, make the
> read fail for all reserved encodings and only ever report the
> documented values.
> 
> Convert the cxl_get_ecs_*() helpers to return an int and write the
> attribute value through an output parameter (u32 * to match the
> macro), so that errors propagate through the shared
> CXL_ECS_GET_ATTR() macro to the sysfs read.
> 
> Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>

Hi Yili,

Thanks for the updates from v1.

Just a couple of process things for v3. Drop my Suggested-by tag.
That is usually reserved for folks who suggest the actual patch,
not folks who suggest changes on v1, like I did. And, send v3 as
a new email thread, not in reply to this thread, as you did here.

-- Alison


> ---
> v2: Per review feedback, fail the read with -EINVAL for all reserved
> encodings instead of returning 0, converting the cxl_get_ecs_*()
> getters to an int return with an output parameter so the error
> reaches the sysfs read.
> ---
>  drivers/cxl/core/edac.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..fd6612dde7f1 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -624,21 +624,31 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  			       0, NULL);
>  }
>  
> -static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
> +static int cxl_get_ecs_log_entry_type(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +	*val = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +
> +	return 0;
>  }
>  
> -static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
> +static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u32 *val)
>  {
>  	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
>  
> -	return ecs_supp_threshold[index];
> +	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
> +	    !ecs_supp_threshold[index])
> +		return -EINVAL;
> +
> +	*val = ecs_supp_threshold[index];
> +
> +	return 0;
>  }
>  
> -static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
> +static int cxl_get_ecs_count_mode(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +	*val = FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +
> +	return 0;
>  }
>  
>  #define CXL_ECS_GET_ATTR(attrb)						    \
> @@ -655,9 +665,7 @@ static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
>  		if (ret)						    \
>  			return ret;					    \
>  									    \
> -		*val = cxl_get_ecs_##attrb(log_cap, config);		    \
> -									    \
> -		return 0;						    \
> +		return cxl_get_ecs_##attrb(log_cap, config, val);	    \
>  	}
>  
>  CXL_ECS_GET_ATTR(log_entry_type)
> -- 
> 2.27.0
> 
