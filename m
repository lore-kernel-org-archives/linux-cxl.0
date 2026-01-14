Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C41274B2B;
	Wed, 14 Jan 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414542; cv=fail; b=ZZ69Bm2j6/eOk+PpRJOKZkVImoMEhnZNSAvjeUfR5JUvE/8ORchNE5bo8rDQrSjzkrB/WtsYpm4ELaIKYpM0tLsgwN1l2UIw5QQDrWmt5/bRG8BakPwyY5Gia4P0KH7oO7mReGFtLHOmaofJ/14SHOKPgAubMRJNR5s8NxYWU9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414542; c=relaxed/simple;
	bh=9+uT1f/3lzxI+Gx2HVH0QBaZwVLyCeRb65+hDTGhDsw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPrCuG2/RjnhEL6X56A197FK69WBNkJhfGGYDdPXaGFLXqydCO9seMiDWt73T/B+ph2BK72/LSceu+llKLSg1tUcDTB2xyN3N+cvISZi85h4hcxyGQaqRVcwXZaTRYD5WEuBAIq/c5mTOXHG8pAvc5rEjkwYZjkfLWLzqwKHbew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcCD1zr+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcCD1zr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768414541; x=1799950541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9+uT1f/3lzxI+Gx2HVH0QBaZwVLyCeRb65+hDTGhDsw=;
  b=CcCD1zr+4h8WP9kSNOp2ygSn+YuNSP48jxjIy6xOziX4OD79hhKW3WKT
   bE5VWStvJV7YrCkkrK8RpjKZIZRSlM99ndbnqbc6mDeJ+ZBqqXGcTPmeu
   xB3mdxjtR2H4m7qAbr6CYwgjf/ccHLxUP0Itlz9emOZZL4IOxjiaGwSFk
   12U81L4jRda2MOaYvOGrRBP9YRPFlP2Ev3rlaBvd0G68gi9adYlF+5q9h
   wuxIubpxgc1lWSNap8z/USgvjBeg2WTVlKD5iLBSpTYp4CxvcOeFtFusQ
   WudeE6yLFuFJCJO3IDM6gWUXtOTRSWake1cMgDP+/JSEDkQWvHEZP/XyI
   g==;
X-CSE-ConnectionGUID: lDIDnbN0TPWT64YWz8TF/A==
X-CSE-MsgGUID: ER8ADhfZSGqllFx+PJVRUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="95200174"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="95200174"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:15:40 -0800
X-CSE-ConnectionGUID: OxDMxM1bTwCqjoNNpsVPHw==
X-CSE-MsgGUID: WcGWgVe8QKiHJuin+qg+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209248133"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:15:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 10:15:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 10:15:39 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 10:15:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT0tHeQUaEry83+DfxxNHYU63UEqj9if8oyDprlaNDc9rmEnSNBtMjeZVhDwKsQp+QJrMsLCnH2Bmr/NKcz8S/o5GWZGz/dv/L+ODQXXRhdoarWu9D7q9ompAg5mR9M05fpHotBPzpIeARxnhs3NmMk/sx7gu9JxoPIjwGTQCFf2iFcM2mGNmDc4XvPlh1jaqhDaUMIWhjuHkQOJP0dYkeK4AYdArxqfrrdrsjoT6IJ5kvFESYWTA2M/dqm/U7PE51KUhjKzOgIRj/vnwLtOn9jHeKEpBIRLrqwxwA9G7savsSbpPHqZQd/V3gNNTl+m6ARU93c8wSkQAg0foe6oEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyj5cJ644bX10sqQZ3r5SeDL9IoFQ4m/2bnn2Al1M0E=;
 b=a8JmQMXKAnsb8NGDW5v9mJyXytiSCuAJSl0fiEEFBnqMMQLvf/4SvxjbkWeLUPwd5Jt/f1j8cD8/um1yeIrbLuo8qzYcxe+P7astWGeQ8IPcBpfXtQ56qPEfjZEpKapfe+MxB2J6vL98rqBnih0kfa1RsfrQWz4N44L9wSRhZFgh5kLtjMbzpc2YtQiQ+WLwun3iaPxdfssdLeYFV6mBDenNLk+mm/29DIsypbKNS5PlnuVb4yHU6nZiYndHurmXeYMsFQSuxdj0qildFyN0C4mku+iiopZyGDmJ7ae6zx8n35gjSr0l66h5/fRMaD5XYFY1g5WtyDr36jaR9NFrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:15:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 18:15:36 +0000
Date: Wed, 14 Jan 2026 10:15:28 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <aWfdQESLWEKDlBL_@aschofie-mobl2.lan>
References: <20260113202138.3021093-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c717c3-26dc-4480-f4a7-08de5398ea30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z4uetMzMWVecWR6FPw4gwGnYo+EO85IGUgh3RQ0DHjWngwQi3+PdqiQHzFD6?=
 =?us-ascii?Q?P0yxF9JIKUSZxhUvCLo0PC92k8PM45ffa8eF3tl8VG5LHTUh107bXHHZCLhS?=
 =?us-ascii?Q?FMZfsgeRt1PfoZGYtWtWp0sfiXvsUUvrFCUpGMhNBwk90D/jAA5DalXa2ngQ?=
 =?us-ascii?Q?+2Z4RuyKzJGlgm9QHlfI5Q+xV981ijctZWq7pTrR3oagSKvfWkJSKDfRrxlZ?=
 =?us-ascii?Q?yuQTSSr7iv7R4u9gm1jSCpcr97qQaVRxGTi9TJZxZtY0LSEdVPxpg7qdo/AS?=
 =?us-ascii?Q?8R5d9+BztiyPAPoQdi8zERfrFUY7VWGUcS6TqxG3ojzyOudPXBHnqQ6IQltF?=
 =?us-ascii?Q?B1QbcL63RYAkX3+/4Re3nOhHVkk2xezhN5IFucd3lLb1boQJ+H+e5nf+jFpo?=
 =?us-ascii?Q?gs8Vk3ZEnmQp48F3F3HcS4/wQW00evDz3tqG/QA4EYXvT4mmUNNwt1y/0352?=
 =?us-ascii?Q?BYAuxBYNcIdtmyWHeBcIUzcTkuTFgVJiIHL8+Sd0yiYQ/1H8dgSkjm9k5IJu?=
 =?us-ascii?Q?4ff8wlf3TDdHi0peV17OBBJ7LcZVd/2m444YtHtyo31ZoKspagyFMVV2c/DU?=
 =?us-ascii?Q?VQFmA6GS+DOq4YCDoov1D0u/rk3RVhG3wx3XWTv6lw2c7fwVDxWK1tQK9tfx?=
 =?us-ascii?Q?So4oRLp7tSjhH7T4edslTL/lhJh7CzUDk2eOF6JLy1eheMjpNrWzpgTdU1hq?=
 =?us-ascii?Q?Qs7JzHxiQwdL8lNh24PdrM1JiMGvLrbwiAga+U71giMGTp5De4viY87CRqHP?=
 =?us-ascii?Q?qfuZuKlNeSe5215WKdTD8BHp4kX9LQYFytV6qRxQo1tROlewmqPy3Z2ifMSz?=
 =?us-ascii?Q?a3x8Ic+nePTblm6iVW3iRvNJbaHu9TvQiLbnrRrS8VszNOpYWk4lu4IA8Uzp?=
 =?us-ascii?Q?5ARL7wsyMhoBMuHOxO6/T3590CYtqlRHtcMk71P6hUVYgxFFva7z7PQuoeBL?=
 =?us-ascii?Q?BpB02L6vkrkAgVD+dEczE98sVL1sUq3IIRucKfo/AHuATVzRycJdOndfpvf6?=
 =?us-ascii?Q?rXmoGaT+jgq4Nkaxn6uYiA2EEOIF8jeEKTv/iw1SMRiw2cPyVsSiWyxx4qdi?=
 =?us-ascii?Q?kXLbDGeArsZBn13tlpdOafJmecwwmvVu/JFi9hSw/2ae/a0rOVmqFIfLpuer?=
 =?us-ascii?Q?qi/wBqkil8Egru8cKG7JZlVlqF082phs7xCGOtlM6mv6z94N0i0tUCiJ0ENE?=
 =?us-ascii?Q?5HLtj7Vd6xxbQQdWFtUmaDO9HRAMcdaZDnfBhOHHWA8rrGH2OtqTBlkBxHCh?=
 =?us-ascii?Q?sZzjh6KEP/33kMugNpO3bvYou6bSrSzqhtmqIVw1Ouz4+3SEZEbVRR3HtSkW?=
 =?us-ascii?Q?tCmdUzIennTBR+sbh9DpZ+hjG/6CRTy01+ONfhxO3uhIQ42uskaglr3Ba6Gv?=
 =?us-ascii?Q?jafYbDzUCwFaFwNaXHM22BAK2os0n1Nia3QWxslPY995dwjCif2xmsNTv42M?=
 =?us-ascii?Q?bJiXvCZbpZC/E36h1IkYBAHpELfKXtXYcsF9oeDiyss5mVjJgb1N1/dSWLwO?=
 =?us-ascii?Q?+VYGrg8e5sSzcEst6DU9Yka/ygsg895IGEOkpB/w3Ow90Usy7P8Sk6m+/FDh?=
 =?us-ascii?Q?EuC+uUd3ctWbVgtfG1o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDoOsMzP3nJ6Q4SAur61WK+qUV1rRxLsUyNYjAbrIdo4K5ubJZlj0GgOsI8R?=
 =?us-ascii?Q?nWv8WbFqlduorw4nbLPR0rfvWd2PKtGFxBRsQVRCwQoBk0LxVJKia1QG82on?=
 =?us-ascii?Q?SIUu4FL8jU2lDwUOijw8Igu4VJ+SW0pYMVBQGNDq6v2EcQEtun4PmkREr883?=
 =?us-ascii?Q?Bxkq8Ykf3LW81tfjoWHCQaJ2aonoR7ZEmnKBA9Yj+WMjW8ooBGWnfjH5koi6?=
 =?us-ascii?Q?kK5Zir7Kus2fzDelIKTvbtPuhZZHQVfZdtHV/PnXKjilGyguSpReyq0hH9FY?=
 =?us-ascii?Q?Ao7GndtollvCM3360HjmMvclBfe816oSCPDVgcSAQm/ZAot+7F4MpklIEzE2?=
 =?us-ascii?Q?tz1EOaIwCD6Mb/1LJgEX04gK001LKQm63war8rTXNFEZ2oyHsNQVefxj3wlK?=
 =?us-ascii?Q?zU+AhDRhuRXOLMfJ6wKdX9tHE57FdRu33N3LuSpk6uXD5L3lZDyOfnCDaYfG?=
 =?us-ascii?Q?WZwuH/BZR11E5eOuNyEXs36Fb3daPPZyx973sJjUmTzuzgE+pQWBquRK9o1w?=
 =?us-ascii?Q?8B4DJn28dXCx3S0Gm3Y7/oSAV5qwUeT1JUXl2aorrwOTU7VKnf6V969SQ7Fb?=
 =?us-ascii?Q?ZKaZKHsdwyM/mu2T6UtNY0CjdaYdMhQRfaicBfqAM3ZkeDIqbDIe0HwcQE5M?=
 =?us-ascii?Q?QBtV9f8PJ26aA9+7JsmbGOvkZTPSHi8w8ex7AGmVoVJLbI3wh/DBTmp6G72V?=
 =?us-ascii?Q?8NKEoDJnSikCjMdFoYsgp2/oP4MxrEbQegdeyiSecUO1HIK8Fwkple2+rck3?=
 =?us-ascii?Q?7HEiPOiW9DdnVy938QHI1/W8hLutR+LYXpQw7pVvMFXN2g4tdyKyeHWNsy+0?=
 =?us-ascii?Q?5mP4Jeav0HWBSpXdUWH4cdjPV7X8JzYeea7BmLJP6qE0x138ozHO2IoEc6+0?=
 =?us-ascii?Q?4+3TiqSx36Lm9Mite7vfGKw05CLQh/jKEZUi8gDeXTHvkDwm4B8OuH3FZVQE?=
 =?us-ascii?Q?pMhHvfwUqJQ57mL1yAfBKDI0tUhvuH2YfowZUL18ZJ4zpAob3F2zmNLkWR3X?=
 =?us-ascii?Q?z+bKjXl1Wj1fHCDkY5Mg0l3DyV3m5lHbj+zuF17EPdXpPNaUIK3hneb+0ken?=
 =?us-ascii?Q?lVBKnmVDaOprWP2axK/1pq+F4G7pmLJrWr9vouoDR+vWYe8t3VaLWvl5NuVY?=
 =?us-ascii?Q?V2tUMUYd5jxdGCZ+umjwCB4jhC5C+xKCmBkmzMzmpQ5Jw2vwQVjLlBnSDyo+?=
 =?us-ascii?Q?vDITRg1Fosx3oJkL/0Wir5eOxSODyHANheCdzIFj1Rt5nrFDOvdORazMDiko?=
 =?us-ascii?Q?INAjdpmq3pIucSRxXZ0S4tZdCEQPbyOUY14ypUmdJZZCLAZJvZnqevcNLYll?=
 =?us-ascii?Q?S/vEvHDlEcyldD05vRYcTT0SRu/NoG1nCrwSUXPsWsEOn9aI3qTFqOMut+6c?=
 =?us-ascii?Q?ni2HhKRIsSuijpiRLfz814yvQRg5VR2fH3dcTZqDxh/h5o5FfUjUktyvLNjw?=
 =?us-ascii?Q?IUt7OKFW2LgJrjJrdK6k7INB0nK29ECVYcYQox6zwpC3rqubnKkPjGFrALuY?=
 =?us-ascii?Q?8CfYGu6WgWVefNFixZwwHrifkFBs300Mjbxp4NBube8tpzC6jkMKuGRgS+53?=
 =?us-ascii?Q?8gliFhiXKel273gnkrkeVvntA3Sk+UcsXYLTWbBS/yTD2ZXAe1/YggOc4kUs?=
 =?us-ascii?Q?V98XIOy+5QRLNl1TJqU+IMQ02/O1MQd9fy7QH7qvSj4UGDul4BxPUXtBzo+D?=
 =?us-ascii?Q?EQSvmMw9H4eCav7hdM6ZHIA0gPo5HSEvneJImop0kiGCNyGiBoBlm7afIv3u?=
 =?us-ascii?Q?6DmYhQwbqg3qQIVyTf7PKCfrWynz+44=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c717c3-26dc-4480-f4a7-08de5398ea30
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:15:36.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM7shO1fMTl2uJMlZ2Hy9QVG7ZZVmBxFZaQHiHquNkAgsAH/Au9CsZoc5krGJyN6VXAlWWnWBzA9JNDnimUd4EbCS2sFLN8fhb8gcFsuoX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com

On Tue, Jan 13, 2026 at 03:21:36PM -0500, Gregory Price wrote:
> The CXL driver presently has 3 modes of managing a cxl_region:
>   - no specific driver (bios-onlined SystemRAM)
>   - dax_region (all other RAM regions, for now)
>   - pmem_region (all PMEM regions)
> 
> Formalize these into specific "region drivers".
> 
> enum cxl_region_driver {
> 	CXL_REGION_DRIVER_NONE,
> 	CXL_REGION_DRIVER_DAX,
> 	CXL_REGION_DRIVER_PMEM
> };
> 
> $cat regionN/region_driver
> [none,dax,pmem]
> 
> The intent is to clarify how to to add additional drivers (sysram,
> dynamic_capacity, etc) in the future, and to allow switching the
> driver selection via a sysfs entry `regionN/region_driver`.

Needs description in Documentation/ABI/testing/sysfs-bus-cxl
I think that will help me understand the switching we expect
to support.


> All RAM regions will be defaulted to CXL_CONTROL_DAX.

CXL_CONTROL_DAX ?

> 
> Auto-regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.  This will be discovered at probe time.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

snip

> +static ssize_t region_driver_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	if (p->state >= CXL_CONFIG_COMMIT)
> +		return -EBUSY;
> +
> +	/* PMEM drivers cannot be changed */
> +	if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		return -EBUSY;

why isn't above "if (cxlr->driver == CXL_REGION_DRIVER_PMEM)"

> +
> +	/* NONE type is not a valid selection for manually probed regions */
> +	if (sysfs_streq(buf, "dax"))
> +		cxlr->driver = CXL_REGION_DRIVER_DAX;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
