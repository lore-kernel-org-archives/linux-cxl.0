Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792450914;
	b=r2XUbz73F6eXt9dpYmI3jpw5Z4JL5gaiGBvyycTnrMpxyXL4bjQr16q/yyCTZD8Nhdv5
	 DmM+Lend+RhA1HHyebQBLCX6vRF1vgAbW0ERZ43In9Rz76n0na0S3f3J+/z3sYF1HmJWI
	 cNK2gWiGwH5zKsO+soNmM16WErglFOv7fkAh93hITRG0j1SSp2tV2bPuqfuzZLNMY90OY
	 U2V1YUlWoMRbiFpo8dwMvb0JUAg5RJhrN9yxSlZYez02jxxdeLXckFjmrl0psONWAib5V
	 UeblB+omV72ebrDLJA41mkgsmHMN/h2+rpu8A5Rowhd0IxdeYhQXrGWzZI3opU5mgGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450914;
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
	bh=J9bAm5a5M1/FvZPULDW5v9iUXNK6VCf9VQeNkGBaFy8=;
	b=gWxsA99Jdg7RHxduSMvEFTtdKxCTJP/JDL19Uy1kELZxv3qFrrqid1Y+OVcR5vk+ipvc
	 oAvtHba9Gscx0RmewuKFBQHMAgOmX4yV+sY4lEn1dF7d7FZ4bgX0wgQsMwszt6rZXFrSc
	 B+MnjAngTC/w4jB4+PcphZ2wmANnv3tQ8BaI/ljXli/k86dc4Vq8n9z4Fx1yyTji8GJZJ
	 Qry/Hp+3/tl/gqUarhcPg5YvjJG6mBNSV59vvUe9KneIfsSqJABCL9wZv8GhCuNXnIpMs
	 KQ7thlaYm7Vz5/9FvaFfk36+C7FNJmLzyiVgz8yaCjzHz5wBzhFXVhrqShkAF5p7lnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bj8g2j6Z;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9D606A322
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 23:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB9D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bj8g2j6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792450913; x=1823986913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tYW/I5EpK/Lf2Pwj+dfVwczGPkTDLYzPKpnO7mqisnc=;
  b=Bj8g2j6ZbGQ6N/xCVmobcGsXClnm+JFPKrKpSb2x11pA7ojwirmba4B7
   ZiyuUEOVPQfPcPZYYmdBg40cHLAeuZGhuOAvKu62mru2ieiJc2wmViogk
   aMlaWBM6kkO9fdLWx+nb1i/p6zayzowStTkCBgiKEKDrefQG04aktLjGP
   qhDF+M5CDGkt9fyKS6uX5oQ4KbW7Z9ZpM1IgbUE0xtaD02+OPVRjeo07k
   xzELnOthzU7wS8jubyZcLuShQJpE0jWdug3uD8X1H+tGHI4HUORtlTh84
   IKCzUr42mWI3azrelPbgKfwIQM7EhW4hdtC4psnTDkRCkj/Q1BwsdIErg
   Q==;
X-CSE-ConnectionGUID: Ld+JfhOPTr2cjxcVC0ilLg==
X-CSE-MsgGUID: hDbkUJKORcO2T0a2nrpDLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1028420"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1028420"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:01:53 -0700
X-CSE-ConnectionGUID: B04/g/XCQRio9EAzA85Q8Q==
X-CSE-MsgGUID: ZZZ5HGFiSkKJ0ig2QD6RLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4414020"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:01:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:01:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:01:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:01:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNhgIhJgXOhgJB+WuEg/R5n/SbMONM0IWiw3tY0u3uZ9LOhc5d+U8s3+ebbWfd45lRSqYt0HTkYa4PKft9zRr22icYuPo5fi+lPDNy8JNNts7oGDmF5vI2fZDIafoVZI5JJsF67GX+Z/fuVR1CMyMfnF/hzzhkSIgqmnmY1UduIfkUBVmGG/JQLyKUmIM55qYPD6blDHWMVgQ9MvoRQP7KSV7RiZHLA1GccP2qAHpvjDvkfrglCpu1V5/c3cO7N0pfNM7glTjbdY3ymL883OkAB9PmnvhDSnyhlX7h626QY3pUUv/F/DUvMGZlayFAp5MwLK5pMaQe3TA9V96nR2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9bAm5a5M1/FvZPULDW5v9iUXNK6VCf9VQeNkGBaFy8=;
 b=okOYva8BqO4wkQo4heDqXRdPadjoS7FglUcR7plZU+XhrH/ZyD8k2gQj5ap+l+8hUDeovosFHzUOJW2MvlIaFNhimwFkKQUkZJaDXzgknSE+RnQAr0PsKliYyiQmv3IvbpsbLIoadEuA1aYt2FwKN1Dvpfg9uMqXyhfgiapU0unH/pDyZJlZr/R4XvtVoMPt2DQQFGDR5mRN3OC2hDEvKdLMVQmgQ2in1nMx4n1vDDDkma5tYv/y6ohFmTwEJO4S92rikFioQffp88VY6QpLvlGig/z/eTCL0vzwggI9EhjqLCYIlIoUCZRnCQiLpZzBHSBGr9YFds2lYOl1ch5+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:01:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:01:45 +0000
Date: Mon, 19 Oct 2026 16:01:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <jic23@kernel.org>
CC: <dave.jiang@intel.com>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<benjamin.cheatham@amd.com>, <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 04/10] cxl: Add HDM-DB region creation
Message-ID: <atahRv-lm9yzq69R@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
 <ar3TU4IM_TtcGgwl@aschofie-mobl2.lan>
 <20261001085728.ko2pi62yweg3klnf@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001085728.ko2pi62yweg3klnf@offworld>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: ed04c208-9fec-468c-2785-08df2e34f22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h3xjDsNHInr8+G0cKcvsS4JI/0uDe4N6s4cFDR+9JWkbRwwWeKuVfC7Y1DJqd/RYa+2qYojoi+4n/7pyZJT0S62TzJV+/wfdtqqLDEXmw7OJe5wLOtvwPmGzn4gMqwid8Dnj/FnZmqJ0pBa7DZiICu4qW/yYwTyHm+SSfdVLzXEudG6kVsMhX24mNpk3NVI/18u7bNO8J/Pi22fbioQZssqHqkA1+SNDKzHK4cN0oo/rg1MNK3ItZ6FlnXwgir9MIx/0ub3OiKr20isWOTrfgsVVD7JoPZoMqCRO8+zFrV9vmDbCC180U1ebxaF3KZNJH/z3ygI27vqyGOUDubqmhM9R3dlZ1BnPpW+n2xT/ylRdGITCUiDmbyNnzqqFAiIWcIoUDEk2aebcAx2hUa3L4sfIIglAMvwl9D55CdF7HTGMMA9T5CdtI4VkDguba5RUKJM7F6N1rcivV5eFo1FgFL0+gVHXujmhxjX772zK0BFm8bSIQlOsnLUTt/HuWk4ZE/3kymtV0h3k1LTLUHfBWwZIh61x8i6KAGINzyS2Izys6kRYS+nX0+A/C7hmrPUcpMN0RpN63mHYXqjfRqTrOu6WPXW86tkdJhcRB8LBV3aCv2TEk7APBfndYals7I/zLPk32HbGbmF1iHNaqWZQ4Y7So3MZaP0+uNCJAxsjjaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7y+R5dl0Pu6F9N2mG8FX/U68GsnfHvqz3CkQsbp2nSn2MS/xrgvPuH8sRYI?=
 =?us-ascii?Q?aqc7qA40Yrj/klP8HJUEL0ryroDswFbctutydSKKpa+Q5KxuVJ68X9TAEC6q?=
 =?us-ascii?Q?849+1mKwee0Qw0gJlbE7twTkyySVhILJKJ5hoQTc1gvQRQNgmIKBT0C9G5AB?=
 =?us-ascii?Q?a4ZVxVvice9Lvt02OnhjQPR6UBYq13WgzG87VcUjOjQLGikyKVU4tcw83eiO?=
 =?us-ascii?Q?xRzl1q1Tq0zconYXhTysCSgK7YvC/IKIcATaouvKhHxikHrwqp9WXu8V8JXN?=
 =?us-ascii?Q?HCemS7Q1Ay1v3pZABxpBw9M2Ezs72WHXZfxaxszobYihbwgldxh7jwcT63HU?=
 =?us-ascii?Q?fJ5fSmxNlKc0dYmFW3Hyua45EkOg8HuYBSkrOJHGxvvH3nsbQunnCK2NQt8t?=
 =?us-ascii?Q?78afRwm06kOA13oHHefZ4R0yiTqiBfQTG6d3bCagnlqY9RUARIClzDgms07F?=
 =?us-ascii?Q?Aa2IjiHYbX7aKwCtI7W2eFFY/JyXxKPbe7q7IMTHouwmwf9lcrLoRS4ckkEt?=
 =?us-ascii?Q?84PPCXJjxkdqEDn7LrGDylxabBGa317dHd1m9FwYdUhSuTd1Sq6LwsEULXxw?=
 =?us-ascii?Q?fztvlWXBLZjiB3+8E8LTYcAgKzb2nnRvxYYpkpkmt9rF5UrLSZDjQf9b3DhZ?=
 =?us-ascii?Q?q0tAQgKOfWlNotGe2n9G0SXm4HK0FIfuVavrgsc/m6bs4CbQLxitDV7JcUaM?=
 =?us-ascii?Q?Lv/TiHmNqnQCEhyXH2pkd5dDPGJdciCJNv+AZsSZp342dtpRjT7qlWHzh6S1?=
 =?us-ascii?Q?enYwqS9BgrVD4ud4BMnlAjjTpfsnGkRRlTXrQS9Vq+0a22WO6rn+Ilq2kXE+?=
 =?us-ascii?Q?zOKExMpY1EgX/umqyaYcPOdUakVbgMAISHh7gCB6tX8wshOqu7KQsdN3MW6z?=
 =?us-ascii?Q?wpAHn1WDepKbrxYejEKUj3KEyl7WJzOYXuDztmArXUrMWw3kggmjv67VrDte?=
 =?us-ascii?Q?LEoxVD7MLdcy0Y4ySYQNVKYYSVSaTJbqSs5Lvitk9kwSDlH7CAaolFnvFWNc?=
 =?us-ascii?Q?X1OOYcjRr8uQQIb7x9f0/NNVz7n+FvFCLCJhJIh6Z4vXIa/gh1vnqpGSSPDX?=
 =?us-ascii?Q?tBdarOm9lkkjjkpQiQg+vcDahaQlfQfk2cp6Ux4Ac/D/5zq8Kmc0xzL4ajZG?=
 =?us-ascii?Q?8FxjRkWiNroL2KAanUrm26W4TJBgCpV+nc9On22Q+Lwml8m8478C1C5csAp7?=
 =?us-ascii?Q?/8lukKD9gAdG+Ji1riIc4NKlDl5u+Pr9BXid493HLKm553UlZvtAa2yQYHD3?=
 =?us-ascii?Q?CRP2ZE2HP/BYWzvZkO/sduMx0Ai7xpk9wjOE4lmBOTT7oPWoNa5PSfbh90O0?=
 =?us-ascii?Q?HggWKFAM2nz8SaUdZCGbNcK8onipj2rswHm0tUEOnS+OU0yegEhtTvjz5xQd?=
 =?us-ascii?Q?x3RKXI3vqexCffpwAZfc4iwky++d60IVo54Av1EZGHeVuBXs1VtmVpVAMzls?=
 =?us-ascii?Q?girOATvTyIyX0Ut3WdUEio4zJiyH4Hj2kCfRIBvctK6mmidBcjX2mmkfkCiN?=
 =?us-ascii?Q?Ey4YWp/qBq4XWq7+UR3anJYmHCd//0P5LfLZRUZFTMvswZ1osphvUDi9PVs2?=
 =?us-ascii?Q?huaj9usA/Y7d1vkuMY/nf/QWBWNqdp5MwN1neV06p6C4ksun/5IYiXTU0d56?=
 =?us-ascii?Q?BBvadV48NO2uAJuL3T0ckqIk6aUyuM2VyIcym9rHry7lsEWd1fXRyjUP3rhy?=
 =?us-ascii?Q?4/KFguf4KyvLX//J7jBm+l2kZLjlLBZ+U5AkslxAZUuVvuDY6G5AYMRsj0y4?=
 =?us-ascii?Q?mkB+uJDp6BC8AQDP66FqZuj0gmDiZmk=3D?=
X-Exchange-RoutingPolicyChecked: fn5/Tvw5hDMN8uV7yhHYJ7TjhrcxIJIINBky/exRT+xYUTp6GuEAS8aq3CHMCrrRJ5IQc1/BuWtfdpDStFel74SRtC2nL2l1jn0H7vHVpRpRLTT0v5IuKIX9G2LNp33er/GsSkCiCEpOCTiwbhzPwxIOwyFPfDFuZWvzatzSWvnfQuWQuCy5p86mx8wjp2WzhbH5x4ddZQZZsVcvkwvS6kvd0x56dhK5wJ5hY1l+HWcdtShcWhgutjHXtepKefpeNd4fe17c82C2hMcOZBfkk43SddI54PNngxK/CXeEywczLm7aZtyDJVaxt7cwpOVr/iIzhJNVUM25LT9THH/7xA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed04c208-9fec-468c-2785-08df2e34f22b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:01:44.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRzVUqYr7SaqEGKvh6qZgw/goknm7uk5ZEO85GE8V2+XplPq7sUE3bJyVJAeoZKi8NmFwALw9iF5ZKe1mEmgztvL53pefTBlE+t/JJzPM38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 01:57:28AM -0700, Davidlohr Bueso wrote:
> On Wed, 30 Sep 2026, Alison Schofield wrote:
> 

I'm OK w responses on this, with exception of what really is
a new concern about qemu version compatibility - 

snip

> > > @@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
> > >  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
> > >  			cfmws->header.length, expected_len);
> > > 
> > > +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> > > +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> > > +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
> > > +				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
> > > +		dev_err(dev, "CFMWS has no coherency model\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
> > > +	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
> > > +		dev_err(dev, "CFMWS BI requires device-coherent\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > 
> > Can these checks break windows that are accepted and usable today?  A
> > rejected window gets no root decoder, and auto-assembly then fails with
> > "no CXL window for range".
> > 
> > A window that sets neither coherency bit is accepted today and can hold
> > auto regions, since assembly never looks at the restriction flags.
> 
> I could remove the check for no ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM,
> but would rather break bogus firmware.
> 
> > 
> > A window that sets BI together with Host-only, or BI without Device Coherent,
> > is accepted today as a non-BI window, because BI is ignored.
> > Manual HDM-H region creation in it is lost as well.
> 
> We cannot accept UB scenarios, I think these should be rejected regardless.
> 
> > 
> > Even if no shipping firmware does this, is cxl_acpi_cfmws_verify() the right
> > place for these checks? Til now it has only rejected windows that cannot be
> > decoded (arithmetic, alignment, ways, length).  What a window may be used for
> > is decided later, by cfmws_to_decoder_flags() and can_create_ram|pmem().
> > Might it be enough to withhold CXL_DECODER_F_BI for an invalid combination,
> > so that only HDM-DB is refused?
> 
> Yes, I think this is the right place for these checks, aligned with its
> name cxl_acpi_cfmws_verify(). These are minimum sanity checks, just as you
> point out with those that cannot be decoded.
> 
> I will leave these checks as is.


Hi Davidlohr,

This patch makes the currently released QEMU unusable for CXL.
With released QEMU versions from v11.0 onward, the CXL windows are
rejected with:
	cxl_acpi ACPI0017:00: CFMWS cannot have both HDM-H and HDM-DB
That comes from the first of the three new checks added above.

Git history tells me this started w Jonathan's patch, in v11: 
e6742e71c24c "Update CXL Fixed Memory Window ACPI description to include Back
Invalidate support"

And goes away when your commit sitting on qemu/master releases:
cb52f088f221
"hw/cxl: Add configurable CXL Fixed Memory Window restriction flags"

Was there already a thought on how to handle that compatibility issue?
I can certainly test this series against QEMU master or Jonathan's
working branch, but it seems problematic for this patch to make the
currently released QEMU unusable for CXL.

Could we instead avoid failing the entire window for the Host-only + BI
combination?

-- Alison
