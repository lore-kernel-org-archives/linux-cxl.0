Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4953AC
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192684; cv=fail; b=KiDreHv2tHT2CRlW5ye2WJ0QwOI361dTid7+K9EJ/gdzUUmwQ0u+hmMPYJ6ocOYq05Rsu3b8pqs0oWpcLw2PpfRImAqhXbptMYbifm+FkfpjKvwgD7fOd2ZdVBxKcGkuWsZD+ep7uidOyspzCbKoMCMX9SJ5rYP+FCMK8yhhzx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192684; c=relaxed/simple;
	bh=t8agS6K7bcRkPJa11Iu8LcBhBgjkmWMdeUaWNWaAURM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r29dQZzR+4KPXeWhy7vCm3vnchCuh2Yrx4rDyvbS3D3DhO2V0FubZTcXE9/NXJhEf+EkHIgiAX9LYimVqHMNPw5uGH4Bvd7UsErUuDXobfgFNlDxJmsPnB3YhJVlPUMYrOxwDN3rf+/g7jL0QKS5IW3g1Ts2NH6a2lHBwZSEI38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6cUD3t2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6cUD3t2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722192683; x=1753728683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8agS6K7bcRkPJa11Iu8LcBhBgjkmWMdeUaWNWaAURM=;
  b=j6cUD3t2RLFaU9Dh7O+kJscHjMvyKM0Ozh6v68EhmJwMhB1RQxuwqbPL
   Y3/s69HxyWoqlSEcTyvZASBrQCwnhoAn3+fWa4UNcW5UPh/2saKyy+eMg
   yO8XCdspf5dXxAvSjXbd2JJ7xY5S4sCLOf7W+A1DymAKSznDLNU8gk4dK
   RaPuWMaGKTGBbNyj9Sql8KIMJrrwWhBjRUOPJe0L30nLvpcaHoQ2hGV8m
   f52yB0AMJliiwRZof4+r4W9BrmYLuvfiwfytTxopVuheYG1mJBZpIcu/+
   3xhpO83iqmGk4VvVTKD9OZ3PIzzCFzwoBI8DFk+RSjMxXvXr5L+MLLiU7
   Q==;
X-CSE-ConnectionGUID: 9FLS+isPQPaZ4qtcr26B9w==
X-CSE-MsgGUID: O9/iIeEZQBajmtZNsOQH7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19887877"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="19887877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 11:51:22 -0700
X-CSE-ConnectionGUID: 2XfVMiV7Q4isaHvtq7SmSQ==
X-CSE-MsgGUID: lKMyj+xhShW4d3NyBRVWkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="53420032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 11:51:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 11:51:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 11:51:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 11:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzKeV6Eu6CCacoPr5gUi7BGdamBWd5dzXZYNvvhPGeVXZYJIWrs5qO8bhWZ7m1CnK4HddWYRjGm6CIq92d4ErcCaGHuECFDfioYRrcv4tfRY7w8OV20o1hHrfHVwdxvRo6I9J0LUOi32S3EhnraIEuveVZw7eIEzcMRiiV28RouuSsPhlYR+L3PNJmNczMkL/1iN1dtA/8ojf9gVj8c4GblimQxgZpjofcAfMaXZMPqF8p9Sbp5qAYGvMMZL+i5S7b/+QUqPRH9TP0DZowp94pIIrtoDTU8n/fjFFcNskl8501SfTnn9lURGwsJewh2mi/mCXSx26OxBakSiSRuYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhFTIO+WAm9FMobuMGuPkPAJW/S5EoTmrRpAbgsO7Y4=;
 b=fVlls/+BE8QmBK9gRuTU1E21WrWDRiseHlTC3/hwd6/3WRMD8iWTCLUUabJ1ipiGaLMrwAp3JkOz2RugNpjbtN38ogJlge0zOynAF+wIX6G8Q0ZgW1nFInoJHyOt41duEN6B+xwZEKiNXkRp7e8pPJyYzb1ZJdi2yqbsrVboHxs/CRRkkMhY35HGmxE2580TfLen+vEGBMD2HTLQXXjWg+KfoguuB4nq5LXGzQQAldUqZA9NvU/N0yJT5uRyaoCRV8uoT6bFQEnyA4vhCEHyqsGVK6zwF9sXeXaeTpm6QwjLFIzUy8xw+kI7LC+SQI2+46QkrznQx8Gnq/ECLBo4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 18:51:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 18:51:13 +0000
Date: Sun, 28 Jul 2024 13:51:08 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.11
Message-ID: <66a6931c89f99_2bff3c294ca@iweiny-mobl.notmuch>
References: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
 <66a68ef9a3798_2bf8a429499@iweiny-mobl.notmuch>
 <CAHk-=wjxN8QgA05-u9PHpDQJ=4yttOsFUMSfA4yR3F4EUsWbPg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxN8QgA05-u9PHpDQJ=4yttOsFUMSfA4yR3F4EUsWbPg@mail.gmail.com>
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8ac68-e61f-4a08-69cc-08dcaf36410b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDn/yPv1pcc8Zhh7EJfNkLBSAeMPj92LIiIfoU0d0fZiYJpi2Ev4SCv8R+k+?=
 =?us-ascii?Q?yE/Uig1uL+MNZefeiExZo4KJIakoicIchYlpfkpdCms/4CbZL1aBonGxa+xj?=
 =?us-ascii?Q?MOV2kiC1Y1dXYIdbkehKPTopx8d71eqJRD4kHFM4tW+wifsy3lkx79ULzCvZ?=
 =?us-ascii?Q?mJcr8vVjMIT5/9sGyPvP75hqTGGuhzOjUT/8cLyjE0GgM07j7b9KQe/9fDCM?=
 =?us-ascii?Q?U2xU0XuKI0zoeUYQjjr8q6oQUFZN/iykMIETeFLxI4vZB0orPDZ1ZkwN/XUx?=
 =?us-ascii?Q?FHs8gL8NaouwGgU9Ak7UF1DP170WOeY75hsFF1rzdxp9y18aUoTTw54XlGZV?=
 =?us-ascii?Q?Rht3w6MwYD2oK12EGGW+Y7dlOJ6+6UKkEoOcV+eQTWV9hMLj7Al2kCWrgUBQ?=
 =?us-ascii?Q?KyTppZD7e201jdOPqwx4Etgysdqah074eTXbGiXj8y6+uFNKF1xtMzJ7fnhQ?=
 =?us-ascii?Q?p523msMlalMv/uJ6GRmFzpXtA5eoJfb0PzkvDgGwFp1O2Pj6EvGD/aKRKtfA?=
 =?us-ascii?Q?MsnsyuN8KpD/uktDrQnf0zu7UjywHkR/U9xgvy4TyS+o0uCnUuloIupjBSxp?=
 =?us-ascii?Q?+T+yM31mzEpa4xZ0xC/mketjtc58uJ9rrkJ0yUwibj5+mpx17nCU42GcJFH8?=
 =?us-ascii?Q?ieE1WKtEjHHEbqSiCQEi5+bqnCPni9cwMR0mg3O8V0sendLUv0p0enywm7sW?=
 =?us-ascii?Q?HuO7fa28Y2xbZD2k//YYykM7veMfpdDlTO6OF3lAKiRVek6ewTjkG1S0lE7M?=
 =?us-ascii?Q?drvYUAmUAOxYwawUfY3RLQ1wsaIYC5wcR5O2/lkaKrgCmhVpJZxmVsQNsQNc?=
 =?us-ascii?Q?WzAdZUlCOY4jGcZ0wAQRKN9zShGQGn84RQO9j7OllYhWLLTOvTdg8FzAxjDB?=
 =?us-ascii?Q?CF3UFlj8g4kmg0RD/LsI0xCqBr6+zNVifllUHSAZGog4gU7Lq2HrFfyWiLqr?=
 =?us-ascii?Q?ss2p2BtnDmJ9t8StKvhdUK2UUrmTZMRndam9ZlDqEfFKY5s42uY5/oB1Gnc6?=
 =?us-ascii?Q?xbwTS9ekMLjxrLnbLa8BPS5jRK7i4r+/WGcU1w1Dj/cEGhA0ZoRfGEqWJ3oh?=
 =?us-ascii?Q?HWhnCR4/sRRKSaSMZ94yWQ93phNAIZspR5mu748vWL3TNrdYX2k1B2m2arvz?=
 =?us-ascii?Q?3dtua0w7wBiH3cWtwjm2+9oxstf+38WG6CMyFpsmlbiEw42nOC/rUVK3nNfl?=
 =?us-ascii?Q?6Du60vyGrIAMEO2VowooiavKCcIrHx8JYhjO10478imbae/qINnP1n/r+/Jx?=
 =?us-ascii?Q?WT+WRWzlq94JLHPCVCEbRBgCHjcSAa4kwRajBi1NGGius+MJKyn5imZJzHAS?=
 =?us-ascii?Q?eb2JCRk4Z/+3HPL5KRoOvFnOC6WntCqOObJlq0XEobb8TA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHk+knOVqUG287OYsxM4V/BLOWhs7wWfTdF0jvugwOj09s9ZVKCxaNbV8gPj?=
 =?us-ascii?Q?9AhjdnqoJjl1naiOH4IU60YiH0ifxhZsEuwz65HY92g7GHggcRzQvmyOytPO?=
 =?us-ascii?Q?uIezbBH67EuY78EbhKM4SRirPB7qIXvrzM9kT6QTwUCcnEDczyaAkj5ix9qf?=
 =?us-ascii?Q?nTxmxA9F5KnecnOGGRNREjIdD6Gq8X9dsxdtD0iObnnNSwvqJCTKQcEvKkoh?=
 =?us-ascii?Q?nk7lZn2RgFZOqvjGhRsZx85TJ5u/hSDZ6WN4BnItJ+ec8DD0RY99eDoe1Hw9?=
 =?us-ascii?Q?6j9yDTQ1RUFZP7OhEtVqCgAf2ks7l6/bRaF42iQHns0UrqcS4sLtDhuBSi+j?=
 =?us-ascii?Q?kEGIDzHwmDWm3SCYjgn2vJ2mKl+APa0MWuoUTNslz4FQLzv21o32UZo5MFZi?=
 =?us-ascii?Q?F9hxkSW2Y6s2Ryu4xbTWrngGV8iw10aW2S2R7Zd/eCljitXyirxJkm5S2hBL?=
 =?us-ascii?Q?jjZ2QEB0c+2ZVX+JhgLo3lWH9wNiBtqjBbnyk/HplRgFeItdEKdilaAvSbTC?=
 =?us-ascii?Q?efOc4ywLbfpLSI23heFXUBTAxnwDH7wzf6E6caYRnkyxH6qC0u4B5f6QbdBV?=
 =?us-ascii?Q?lQgoOBWJaXHHYCbUfqfJS6s7tMdJdVMofhIuF3oFmFaE1TQQytpgX/DPc1sP?=
 =?us-ascii?Q?ayFljKrVureR2CIp4xBTJxxmgOrABuhSiaweFbgYFkeRa51s9LYQxOubhPLs?=
 =?us-ascii?Q?Emr1Cp5vePTQVFEEvKAEqPeyD8vEPkN5cD7QW2Q0OZkcTC5Ydws6t/xcRLRu?=
 =?us-ascii?Q?1eHdLHLn4YyxUdPdkVfQEJk+Hta3m/xKtBsgG8pA+B+nb67Bwko2p26QPTLV?=
 =?us-ascii?Q?MLv4Po/nLc83EjHktD69uQqgZuJ7BqRw2VYfhFFbEL1MoNFKMJtHREV0znQx?=
 =?us-ascii?Q?zyLeQ14Ax3ddAGwlXQIumQvj1y2g0SFXDPxLcxX/ETdDLyiTDfSSGCHlomPK?=
 =?us-ascii?Q?Uj46UiNaMnzBjC16wBd/040MM+0hZOZCZxNmjt8z5aIevPcriUqhMTZIK75x?=
 =?us-ascii?Q?g0bNbQABveNe1pJF9tvaZ/Pjg1A66iVS4I1htRQZGCVXPpGZFHE2mIlrNPZP?=
 =?us-ascii?Q?FiOrA7Dk7L9Og0sXNZyOqxNYw3HKdsRgLpfZV5hvbMNtnq8AKL+97BDwXnf9?=
 =?us-ascii?Q?sM7NRRQ2N+y4SSPa8plC+K8/0fOKtac8CjmXAGlyEw0DLEhG2aWVrfOhxuux?=
 =?us-ascii?Q?H/LALK0aYhdhU56rDFsO/HO3cogly0X2nKBpMJvOMJb1ja071C9LvyeOzHvv?=
 =?us-ascii?Q?Es94T1Js6daTdDyKW3webolHG017iK0XWmixxLgz3d2oNrhO9payIiThBcEU?=
 =?us-ascii?Q?ThAtIOBciIXXwR2jDowZeA8Lx7V7ESAiM9wv0VP+OL+/APdhhccXxTGbRaPF?=
 =?us-ascii?Q?Jbj5PlhiFxVQ5TnwoAv5qTfH0+4pkGvp/2ec5DmNgEIw3CUKYhewPPmJrSS8?=
 =?us-ascii?Q?e4Ps+9v5gnqCUvjX2END7pyGzwavakwcVptr6lAtfR5BzksUeGq2ltzq9k7F?=
 =?us-ascii?Q?bourd0kZyCWq9MtjDYbq2o/b/+ySE7Hj6g0qBU6hvye6KkaX5HUN7gVC9rZw?=
 =?us-ascii?Q?QYgAQYFoj73ODAoCyEGEKiiZ0AnW7yxraNYadB/r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8ac68-e61f-4a08-69cc-08dcaf36410b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 18:51:13.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXRBgDb7W59bJ+deMoDSc8WgrdZ8eQ9VEMAU5T/tJUlyprGcJ1J5G6EVonKpPYBZP+bL67l7dp47Mi7UCIaHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com

Linus Torvalds wrote:
> On Sun, 28 Jul 2024 at 11:33, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > Dave is on vacation and he asked that I look out for this pull request.
> >
> > Was there something amiss with this or will it make the 6.11 merge?
> 
> Heh. I literally pulled it just two hours ago, I just haven't pushed out yet.

Thanks!
Ira
