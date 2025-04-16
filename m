Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8AB21B9E1;
	Wed, 16 Apr 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844894; cv=fail; b=dWcaj5FKC0HgtLMElAZdvojXOKv4/pyDyyr0J5y+R2xwJiWF/cFQQkXGvH128zaJk9V21+13gBX5BCr2Tk7AT+YTY+ILQAeFid3Ae9F5gt614mvUYgqWVjZGYGK376lYUo1K942ihtOpb+DxUeBiI8x2vS/+URRhCmebHhOp/KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844894; c=relaxed/simple;
	bh=hZZqp7jFsmbmdhLBD6oRUI0meK0ffkouI2NLfV0kMkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DsLq+bI+v4sbbvarLlqMIY9EG5R8Eehyi/pxhelIVzvcSKEfEYu+1aKEtM0O1vISICemmkw3GOB/cZwkr4hxB1+D7GrIDXKS09VVVESfzaAowlKXEQ7YvjmrY+I3Nnh3vmmgMYL6QbF77E6kNu+sDOIOU0lnikZcyXF+uC9k7qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVaOVVvg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVaOVVvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744844892; x=1776380892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hZZqp7jFsmbmdhLBD6oRUI0meK0ffkouI2NLfV0kMkA=;
  b=kVaOVVvgolfpUZ4uo5/7bixSZf/ANeiuzV44oPzZnQrg5/fqkypmIx+X
   NGT1COw4+jNSkugqqt0QhkQQrqdrzbkQrJzkgjYazarFlBgcKshg2E3jV
   CVIzOhWV2oQklst1B3uuviI8Il1PUvsuTGsk0euM4uZkHowe72KVdxyRa
   lO91S9eOE8L5rb/FwXg9KcMGuS1b0TAq4caxEV1CPdUKdQV2NenDbPbkl
   hJEV2ecmJmycWEDD5+MBhS069gJhPAbTZ2b/Od48diQpqLET2A+YRYQlM
   kL0e5vqzM4RQmSJSsCpOCeCVTQt187sPoI781JWEX1Iq+wwg4RdJTJAS/
   Q==;
X-CSE-ConnectionGUID: oS0zI8ilQ32tEg1ncasXZQ==
X-CSE-MsgGUID: 8jZfY+fiSLOHOjiA0c0NmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46546031"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46546031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:08:11 -0700
X-CSE-ConnectionGUID: ASBQNVrHTL+DLksevAFX1Q==
X-CSE-MsgGUID: aBvf35tJS8CruGtomEscqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130485335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 16:08:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 16:08:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 16:08:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 16:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoSylCnp26SSkb4nZCLSRTxaMrLJjiMDcp644ImCaiHnjAQagT/06aCwNz8p/TsxAewIJV7c0NNrzmwNWOoNMBKnaYRhUChcFLHCRh2uHuZeUNsRJGJ5O3BMsLHr81zvBuMfhFK2QX7zuWFiWB5qfEbMTevjaEOiS58V2/u6oDVoKyRNUPfiDYBZv5twx+X4atop7XDjlCXoS9PJ/NgoDqQeQfzJhfsrsqFJeiJvLCjkZQIHolpPjeZm/xMR+mHy4MeXFJuMj+6sgxUOONZd+pI6RRIWJaIR9wBK+IrZZ9Av6j5wMhzxV294jlMAnPJPJ5KqofEAdwBSew8b5lq8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsbGBqHOU95eCmDtkGpNXgkJjJ2r8csOb+OOG+ZfxHk=;
 b=InT3tbdgRgM1tiJXeKrYB2bfYZjLkh23mpMVuRPzUc0hicL3bQQ0ZSSsYirZ6xzjVgzKuGkzfsJzgbJcZ0q72JLa/w3dWP6OW1MeDfAILBaExH4o9+8DQj7anq7D5j47rT2FV0XzvNFc6xgWiqPkMiYfXN+aRQDlr9o3fLV+CZCfEtkFJQomEKv0D9cv2kbVW3n8TgYH9zMG1GLHSopP7LS7iNF4G+Susc/w/b9mYUzQOU+mHjQrgm6yfrAfk5aR7x1lbKm9uCORrrq/yUhCMiCaxP0ZBFMzTJk+Ejgb+kQYM8GJ8wrnoVL8jFVtelldUZx84T+C129HKCPwlHvQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 23:07:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 23:07:23 +0000
Date: Wed, 16 Apr 2025 16:07:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>
Subject: Re: [PATCH v8 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <68003826cb17d_1302d294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250416113123.629-1-rakie.kim@sk.com>
 <20250416113123.629-3-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416113123.629-3-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: aecd80e1-68eb-4edb-ceae-08dd7d3b7228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3wBJ8+WqWzFuiVEKbXfrlQz8rmVe5gDkEUtPV/CmvMVU8U3kemcUG8n0T1OB?=
 =?us-ascii?Q?f2yJhIwc+oWsxXGvYFXixOjJ5RGp1t39JhWOThaBzSmSGzv//25uZlcUtJhy?=
 =?us-ascii?Q?eE01FHmLeTU6u1zFzybWUDxchcLNbBCKppfN5zcWglezDbnYly3demnthKVS?=
 =?us-ascii?Q?P0/98Jyi11e0F0sR8Q61HB90UfeCgUEpf9alsGqTj7qsoDp7/wmWuTCBETti?=
 =?us-ascii?Q?Mzn9VkmHEBCXlBw5zUJS0+SVqAtXHNweRX0BMAdroOh0N4N14FPJYT1yItc3?=
 =?us-ascii?Q?E8OOlphCpWS5VFl5IVVCE1eYCHHv+D/Wm5OO+DzwOukTMkw8Z2chTIHWzplT?=
 =?us-ascii?Q?bJbyzLjiwCXf1+C6yE18Kq68ABrn77KyPZVPfklnEIqLP86w3zFzwLUdSPBi?=
 =?us-ascii?Q?GcSXFooc7j38H5HbChBnepX2Khp6aTrYowMiInMWBHQvovesMk5H2cQgQWjg?=
 =?us-ascii?Q?NEjBCHVxjBEGves1MWi2BHHzQObUGJRrGuJ/SQi3vY5DWpOTeA4HAZ4WyUji?=
 =?us-ascii?Q?MW3QY7t5dTb3vSeuV4wR4G3NRtK8Qbo6I+HfPR1V/qxU9jTpy9Fmu0V9Mp6e?=
 =?us-ascii?Q?ilWVvw9Yi70ND4aAaOp8n9Etjv2z42iS1A73f/7baL3x3qZmxlExVpOQ3kbz?=
 =?us-ascii?Q?q1C+JNUiGeSv1lQPTRL+KSStEc6BNbqeDegmFH5KAygC/0PSBTl3/9ucxzmm?=
 =?us-ascii?Q?LA4HS9RZnDGvd9QLWOQviykae0F6nu8PXtDlSM+kwM5agpC9hFiXEZSA9ehb?=
 =?us-ascii?Q?duUJxh56UFsCquJnwtCAI897EWRVzdgnI5H7hhd/89EfryHSxyanaiN3tWvo?=
 =?us-ascii?Q?1wzmcrP2CC2UoOOdz5vHHkL3t/T7/01EhhAVGGytbn+lnX0P1TzaXTfdNO2+?=
 =?us-ascii?Q?FwBUYHXhwG5LgO2pvXZEOaEGJnHuJE2tOZ1JDGCxIQj7qF/4bMEoe4HXHbRi?=
 =?us-ascii?Q?uPiBOCtKHzgBrWqoRnFKPA9V1icHmavlzeyihvKgrm6akSKX45IXZPCR83XA?=
 =?us-ascii?Q?C2L7m//LD1tOicXqCKNU4c2uWUZzTSkMNAIbTb4ESyD516vMQck+OC9Jmebi?=
 =?us-ascii?Q?iDNpSUZBsAKSXYsDtf+/a4nJYt5N5zihcsvPw+7CLIeimquCfzGarm5qgGlT?=
 =?us-ascii?Q?nCSXbWLaunhv1kKtYu4sbWAMrcthSXnOFvIDN1/sGjQK+O/L+Es1lCPMtjgI?=
 =?us-ascii?Q?0ijWk9RPZBvJ4H8+Kg9L/4ToFugU2RVqCD63Lv95S548j+q4uQN7TL1puep9?=
 =?us-ascii?Q?XZWmucMOVOhoin0HsgzGCd/uCByfT4qo4iB0p2WTCGi8HQWi+lAwFLb+Zy4h?=
 =?us-ascii?Q?xV6IIhGuw5XZvxjoQPXgiHKO9/nCfD+1rts6aHELynrMSlzR+51NxtPGaJBG?=
 =?us-ascii?Q?h3m7ZXHSnPvZzHbZo9scOxunpDXB4aeN53n2AKZFcMClG7byjXLE2M483+ZU?=
 =?us-ascii?Q?EpNQuH5xrNU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRiaGZ9nwDIS6ZBPOTCgdYcBRjMS+S1J85VLreIWPd1LUokDPv2Ls9wIwJ7c?=
 =?us-ascii?Q?NkJSyhVSkN6DI5epVKmLr981MR3U552cyqg7tdbfRlm4OmHKzxRP7JANeMbh?=
 =?us-ascii?Q?l7p+jPE5zYr7ZJLtJJZ00/pR7PMmKi0aZb4sYiwrzwRTAjc+QRs9SzkL8HDd?=
 =?us-ascii?Q?5/bexlKu0FodcEPVYesP6TLc+YsVJvGwJL0ntITO+6R+3hAs0Sv4NhgTRREY?=
 =?us-ascii?Q?rnq52LZRbebaowZ2aqZTzTcrLbHylIL7g+I1RGwk0wLX4/L+etg5gBcBF7ZC?=
 =?us-ascii?Q?OPB+i3pLRQaxpnTtTrQuhoW0d8TIdA2ODhhrMhRcfhTr1ggsZEtdYemineaz?=
 =?us-ascii?Q?O/OorPVI8UcoCKBN6xBCl9+oqlrZpLug7fJzl6pM/ntf9PiazPMvI48Ab38N?=
 =?us-ascii?Q?vAiUzfPXW0dpr6VtWrOu4kffGscnlAY5HGsxOrEfAGcEwjnLCiCxxNyQ1PK/?=
 =?us-ascii?Q?4wcqn0SLxt2gTPzwVZiLEm7pdlWmvHOPJbdXGE7qAa0hXr7oRySc1y/kViO9?=
 =?us-ascii?Q?MUJUC/jpJQzQTSph+offi+/YkV/Li1XeP54bLokFVDMxYBFiaN019WxXlWfD?=
 =?us-ascii?Q?U4LhQ8HYtkaTdGt6BFFASQmZGmWSL8u1Y8uhmeQrGLvElM/AmGvXQ1uj76Fs?=
 =?us-ascii?Q?TBBiITJQ9pKRSBO9ilAlVPlgkFQzAqGUOgU6v6jKvJvoPHio3qnNtVK/OOxt?=
 =?us-ascii?Q?T7pTzhhSoykEs1o1QHJSJI0lDPSwoNBUQ8JNK3Zg/KtnkxV07vldnXy9Kfdx?=
 =?us-ascii?Q?dqqESyrdeRGL3uuGgelVo3R2omy9sRON4UBo73bDrg2m43GSmWZDImQtiePe?=
 =?us-ascii?Q?XGjh3wkS5Y00anJQYSwSM6z4Altj3mPUFDTxjBHn4B2KMp1BnYXEporrs2kN?=
 =?us-ascii?Q?jCWA74cv4F1SkmA0drGyxQF9w5GuOaQryHmMzZ5qy4+B/NWavhFrjEM3J27c?=
 =?us-ascii?Q?osFaUXI1cExgSOQQGJzZwYrsMKRxhrlJiKsrAKsmpYY0lqshnVezv6NR3Ac/?=
 =?us-ascii?Q?gv9+dEndoJww3tLh3EaDLiGeUcIgH4kIScPThqm1k22xFs/ap/ERi4ocjsou?=
 =?us-ascii?Q?MMfEcVCLap6fQNyLmTZgNsz/2SjREcPCsq6WZRJxKegSqbLihcR6h525L6ou?=
 =?us-ascii?Q?PLpWz9OO08IKxHBb1Dga+ZhAWGR+XzHrwphjHn/ttUpP1iWBdMMeUwswJstn?=
 =?us-ascii?Q?em4R8gel5fVWAa/S3qvCXFPt17wEdPwOubN9/iI/NmeNYMme8OggNIftzuAC?=
 =?us-ascii?Q?9a4M5Wi9DgJV2AJQ8R26j7vkT7CXDHFXjoorw+YWIErPK18grDHOBW5NQ5df?=
 =?us-ascii?Q?u5A1n0KrYz6gj68GlplwdcP+xplNiWNcW/Yf5c3EVJaMuuAzHbq69SJgJHaY?=
 =?us-ascii?Q?M22QNflaMnDa3UYmoArIhOWxmlcq2bcY5Z8U/Z7K+lDWavqudcd9jTbb5z9d?=
 =?us-ascii?Q?X4K1wwBSWP+meyOs6bdPdrg3yqObxX64P/BNs4Dyg5TTnOIFGVu4L8uUs6oM?=
 =?us-ascii?Q?EWvqeDi1DMusRFE8RMtfXuNtS+Fkd5Gono6tUQtMFT/N2L9mCsxoAlEdSNe2?=
 =?us-ascii?Q?4xv6PWwwflZQIEjtWDg19MpImVWo2qyQeOrvZ0yY2vpy5mNZVPheKAkllN0P?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aecd80e1-68eb-4edb-ceae-08dd7d3b7228
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 23:07:23.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMzvjSt3ei0pAL5Tc7NxARgaEV8ia47mvb0DSpTw0QMT4ZEvqITi3Jy78ZVvLCqP8nuKM2DspCXZL/40OvBVeJXjYHPUYCH09kNgsn57eKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> Previously, the weighted interleave sysfs structure was statically
> managed during initialization. This prevented new nodes from being
> recognized when memory hotplug events occurred, limiting the ability
> to update or extend sysfs entries dynamically at runtime.
> 
> To address this, this patch refactors the sysfs infrastructure and
> encapsulates it within a new structure, `sysfs_wi_group`, which holds
> both the kobject and an array of node attribute pointers.
> 
> By allocating this group structure globally, the per-node sysfs
> attributes can be managed beyond initialization time, enabling
> external modules to insert or remove node entries in response to
> events such as memory hotplug or node online/offline transitions.
> 
> Instead of allocating all per-node sysfs attributes at once, the
> initialization path now uses the existing sysfs_wi_node_add() and
> sysfs_wi_node_delete() helpers. This refactoring makes it possible
> to modularly manage per-node sysfs entries and ensures the
> infrastructure is ready for runtime extension.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  mm/mempolicy.c | 60 ++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index dcf03c389b51..998635127e9d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3419,6 +3419,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *wi_group;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3461,24 +3468,23 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
> -				 struct kobject *parent)
> +static void sysfs_wi_node_delete(int nid)
>  {
> -	if (!node_attr)
> +	if (!wi_group->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(&wi_group->wi_kobj,
> +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> +	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +	kfree(wi_group->nattrs[nid]);
>  }
>  
> -static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
> +static void sysfs_wi_node_delete_all(void)
>  {
>  	int nid;
>  
>  	for (nid = 0; nid < nr_node_ids; nid++)
> -		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
> +		sysfs_wi_node_delete(nid);
>  }
>  
>  static void iw_table_free(void)
> @@ -3501,8 +3507,7 @@ static void iw_table_free(void)
>  static void wi_kobj_release(struct kobject *wi_kobj)
>  {
>  	iw_table_free();
> -	kfree(node_attrs);
> -	kfree(wi_kobj);
> +	kfree(wi_group);

Ah, look just one more iw_table_free() deletion to be able to switch to
kobject_create_and_add() flow.

For what this patch is though you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
