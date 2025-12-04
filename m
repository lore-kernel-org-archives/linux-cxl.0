Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EA34A791
	for <linux-cxl@vger.kernel.org>; Thu,  4 Dec 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870142; cv=fail; b=ALIvHVrdx64ICo4isLnHr6MKVMuOTUj7eyrbgfuQ8LYwIHn2t1OevtYYsIZV1fsWpjOZPXcQKCKF2jZtnQDeRUDQB4glWWRB2eVH8TQ/lK0nKzCq/3RNRfe5wthWIrpZeAKIZHEx9CGQyHZhevZDkd/Fwj2m4C8kTK6BXcZuREY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870142; c=relaxed/simple;
	bh=5iLJ/y1EGY/hu0PdBXkfg1TrysUemr/tOslwq0RRcbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SFf7ySAfXzjbGaw5KpianhQXOA+7+WeyKrjiKBghtmXYRX5TBwXK2Z21jQcrCldrvhbdgOY3L/j8k6AnDaAW97b1CcjzRYlZMHZ2NMqDbMlKNzt4890P8gdHZOAkdIHDvCe3ONVBl4qP5SjMIowdTbLcEzkgyiuRnrs9s3r0S8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNbFkqx/; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNbFkqx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764870141; x=1796406141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5iLJ/y1EGY/hu0PdBXkfg1TrysUemr/tOslwq0RRcbM=;
  b=cNbFkqx/d65zxs7lrXXncVK+GJro3EgV+MRPmuG+nmQxybHKCJ4fUfJS
   xDR5F58aeq+vQRTWVHe5D+gjRIoVvXzV4IHliOJkOp1r8aU/eO5yLo3uf
   vy/RP7W2XFs3dWa+gv6aan05g9dEggYObiOovnO+3e7bzURYm5j/ojcxG
   QzLe/xZfjoMlCyhUQ4J50K42tbGF+gjDv98z5AItzPaqaFoSvZLEYuC0F
   JsgWtR4KRgjswxzxhUJ/XJgH/HSZBnDYXpKk8wR7JqvDoDtrEIDuYCHOM
   y0foM2aiIBxylDkchM0+SvzlgG0WGelIW10Suplwmn17e377Ex40Y2I3l
   Q==;
X-CSE-ConnectionGUID: znBK+EvjSCSewpiSft1Keg==
X-CSE-MsgGUID: xDs7pq/SQI6pitJnColCYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66623292"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66623292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:42:20 -0800
X-CSE-ConnectionGUID: C4IRMR/BT6mgoi0NpAK/KA==
X-CSE-MsgGUID: d4iMrn/rTLWLucw6wkUT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="232384824"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:42:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:42:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:42:18 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:42:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4KU9hZbGjn6n2bcJ8dqPXcm77x0xiENaSaVA3HkEycbKdbcL+Ax4T4UukJLVKoG+o98TEXaAi0C8YDPZM/PJGBo2cnllNW7RH6zGHr8h7AIwsup35RZ5zt4fkCKNBzlGClnlQf0RfAwfGMfnIGktKPs6dhctHwCn2qCZxOIshX3Lm0aapbxMF/ltst7xDWE85dVS1sUoKiQ5HGch65+w7YN68/4wNOI2Ixn1hfBXAk9ogGcG7r+ugHzMCo24gyyIQQXPWW84Wj/9S1cVps1bO3sXqrtHF5j1SO/WF7W/f+xbqv/Sa/D/yP/KgF3BVkmNXAbsnJyj+572A0z57bc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHLBXyb1JWe5UYDI/Z3v9sx5yax4WILgy7y/hwJV6Es=;
 b=oL9f47RoMPSVam9KuLHxeLrvSuqai8dl21BGMPKbPDP/V0ouC2iwYJSyFWey/JR6Y0E8yCI3kP1eIX+XCuCL+sHblQXDh6sAVTfUzhCRMQXrKx16hf9pdXQlWsKJELMnUEiveNSg/NL5P6edZoRSNoD+cR15p/W2XUBcRtdrpc52t2wNHb/o8dEBX5hf86T6gBI6r6VBlarvs/34ilai0OVX5F8c285z3FLvPWDSqNvTpl3I9OrGt1QfsKIkRLhtp5Cc5UU+oQ2REm/fads+FtHRd5ALBI6FN07U0myVPKwRVaiXlLYlIR9JzVTTWPtqyWIo8mCiwGOnX696rp1w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 17:42:16 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:42:16 +0000
Date: Thu, 4 Dec 2025 11:44:53 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <nifan.cxl@gmail.com>, <dongjoo.seo1@samsung.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [RFC PATCH 3/3] dcd: Add support for multiple DC regions
Message-ID: <6931c895dcecd_43010100bb@iweiny-mobl.notmuch>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <20251203203540.1091827-4-anisa.su887@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203203540.1091827-4-anisa.su887@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH3PR11MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9463aeda-1507-4665-b27a-08de335c7705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?URrgezvlkcBo+RkegNTTV/e7wt+6DrQ4NtK9uteL3lhVPB42GXbNhaGBWUQs?=
 =?us-ascii?Q?LkGI6jurqS1koOZSbogUMjr6J7zB7IB2pFaExcci2nvetCRIGJSD5Cj6nFKf?=
 =?us-ascii?Q?g09lFg2atqPcJ56YaEHYjUAr3qbP2eP0qbu1QsaeX/8d1WhPlslHDuMLZDzW?=
 =?us-ascii?Q?R7twD9YOpzo/+poUrp/1xTvfSE/XxZhLHUMLKun18hI9mCnvOnmyr+M/n9/2?=
 =?us-ascii?Q?+k0XZO5SUySTmL9yH0Pb9M/HEHCiVvVIt8xF9XtZYECvL+PTxXDq1smTZFjY?=
 =?us-ascii?Q?EDVrMJvyOkPpQ+w0K3VRIEd1+Fzf3k0MurP4YMlDfonypUUm8AVoDV8MTMeO?=
 =?us-ascii?Q?/wA72bQUr6Mh4uqd0H3/bRct+lfP9+Kzbw/ULIxUhGGpspGgH+qREiTy/dHT?=
 =?us-ascii?Q?hutSxJUtwl9pAQyHY2ReNOBnE+eI91EbTC8Efk7I6dJiq4+p5b7SvQrd0QVn?=
 =?us-ascii?Q?rMG71m9kcGYvrBLPlkpUK+OT6WYAxuEYB6vPiet3OjIVXcdPrjjdt++NN2Kf?=
 =?us-ascii?Q?intxBt7VisvtHF2uyymPFJyxbmD34/OHlurqArFGW7ZUTx2FYXLHokPMmWN+?=
 =?us-ascii?Q?7NZBjOYklQO/lzIrNyOXaMjOeau5xdUuntGAN3IE3xiNO7xl0KSuYUCb6JSc?=
 =?us-ascii?Q?ZGM2hfdxNsLgwBTyduZjTzYfZpKrl2I8iKYtmlPV1dHmwbfMooCjrar5hipr?=
 =?us-ascii?Q?A2yvMAasV3Mcu241EdNyCgWQsEKFBCRk4wbcbNq3KcOmwyD66jpyYPPGXD7S?=
 =?us-ascii?Q?9jjrjd7ItUIEGVR1ugQ5RBqNE9FfI8JBg4aG2N0nFYsuswU5K++VcxpXGSjL?=
 =?us-ascii?Q?Bon/c5cqsDlwc++Oyxru7ri/VYZ4eyIAQtxReXPJ8qkmapA15VCGKgO84hrm?=
 =?us-ascii?Q?B86H8ugdNl/ZF1v448NEqDT98g2Ty3dajk5osaRBpkN/KLvGSmLzeh1go0Fg?=
 =?us-ascii?Q?xXG2qH4ueDPnLCzoRPz+4lB2sHD6trjG8Alv5ihwbwkjU9L9/ZiG8wDH1CS9?=
 =?us-ascii?Q?f5GvDtlreZKJa9pDBRcNdqM6lENO13d1RjnTqB5JDkD05f0+fU0QTUPigslf?=
 =?us-ascii?Q?/PvgWoFQ17G7eKPhN1P6Pes1G+Dx906+A1BY1Xvl/cnQGnvubIvI14wkr3vz?=
 =?us-ascii?Q?sd/P7vNqnShCLx3En1ai8AQpVKeMOeiTl17ewFM5lE2cBy3ebt3jk8Y9OIMv?=
 =?us-ascii?Q?tib+JqlNi49P/kMMBHRYSIpoN/Oqc63UIQsqCHQQ41Qj1m8NhuOwxacQxhiH?=
 =?us-ascii?Q?oDqh9RNfEeRt8BFwgI6uipNKR5BMEy2bKtvryHXo4wCpAFG/MLpXOFoCbF9O?=
 =?us-ascii?Q?SGZTpZVvMYt4eGZ2AFjKumZRQOkJ5IcLajjMotfbNEfgXDFUzX3/SGC9ebXj?=
 =?us-ascii?Q?MacuTMBiGPKoCS99HdPKdy6A9nV/Yv2Be9pc6ihPUIGbtqy5EJMcKFn6b0MV?=
 =?us-ascii?Q?eYPE9oHO1AjViuaenlDv56igBab7sxNGwi5luDIj5899EAf+s8KJ9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tQ+tMM9H+Em77cjsjjoydAqqTvc82aH9QDiXj9POM3a+yo/LF6HStuGAaiA?=
 =?us-ascii?Q?yaLjlTzKUSjqSHzqNj5OFKUCaMdtibdIfeKXNTVKPpIr3ctH5a78J+6rbNw9?=
 =?us-ascii?Q?1pbwbRFpPyhDYyS7t3mhgzDCFKdILQDxyezEJee+rmHPFYEeCXsxun51MN1C?=
 =?us-ascii?Q?RiYaA6MBsRMYzbqO3tsNxPJC9Ic4wOPvB3Zel3MnOwwURywEe5h45O6KNtUy?=
 =?us-ascii?Q?iopzmZaAu9dDfBXcEpgdsyfOD0/uozA7BbBtz85HzAPuHGMA9YXa5B3llSa9?=
 =?us-ascii?Q?rVxBMlfol35ZO7DeVRy9GeaNrNzZokPustB4Laff/QQLEP/ROIXi2zq81Gse?=
 =?us-ascii?Q?64qxedpYSGuECYlS7m+ZVUdOo7UvGM2lhTEPtlcQcDU/iywGO2XfsO8/TQb+?=
 =?us-ascii?Q?OF5FrMAmGoYdlJKbXhiQp1eCpwHK0WEESJmaLijVfGPdW3w/P2Jq6dfEU+pi?=
 =?us-ascii?Q?lneAMPTxeJRnAvEKF80trhkXFMB0WFpsaEYhj56vRx3Z5QaJ/dliNPPdDVpK?=
 =?us-ascii?Q?7wozua8meREssMQYJXuynhbolftoGFgP/k6vX8t5ryzUbfkvfS89qQBEQgtk?=
 =?us-ascii?Q?rVPy9SbshFPaJS12SCrhWRAXvyG2RT4HPsFz46m3Ybl7NIdiDAdWaNAM0lsn?=
 =?us-ascii?Q?gwtqp7FKv+EsjjrzvDM6eUGD0tlYNmrFFb/nD7GVr+Zpdf0YtRV5bJGDKkva?=
 =?us-ascii?Q?uZn9rmzwkcx0WeO8IG7YfD1BRWJHCC0DisMb4otW+Q/w+VZV6Sjt5RX2irui?=
 =?us-ascii?Q?QsC1l0njKRZQh1h7fHjh/mvNO8+PH1SzgBi0AbYohNBbF0DDpab4RxgPsm2u?=
 =?us-ascii?Q?4fZ9bKSmdZb0OhvU1HJBah5hcVm9cFQtw42UDOKAyo64d9eUmS9IMToltWft?=
 =?us-ascii?Q?e8OnFyJ/iqj472hUnS/6bsJUZElStQssgCmHo0sIZWcM9X9P1q0u8UBo87j2?=
 =?us-ascii?Q?m0FAjXPq1MVKP9CPlJ/yrtn3YZ+ChO6hv6ifAE+802hEFnElBI2bzTml6VTN?=
 =?us-ascii?Q?UbHWbU5tYMJPScsEPmqejPgYV4rWWYH0WnJj7/K7luA4vWB4vcDhpfF4HuGS?=
 =?us-ascii?Q?UQOPjH4Tmi+sd7CsJSRrreRh3IdTAnbUrqzTdnu8MrSGJKxc3gdACbmNgXM4?=
 =?us-ascii?Q?lnzdXtN5Hh+tSBz0D0cUJLIEIwxwqhuFwVWMvO8Sz5Y0e7SqhP1EtaMfMu5a?=
 =?us-ascii?Q?LdMueQFOelyJIZg0pwGjzvYJ4gP4/40MaVFZxHfuCw/xTZk0IEJt/z3dCVIg?=
 =?us-ascii?Q?8stPoGHhCdXl8uO/Xm9CgqU/5w6O6a7xgkStUyZTDRTsnRF/veslcDiSjjmm?=
 =?us-ascii?Q?doqfzKNQAcZys9J5vhpccQF4A9c/PL/FmbFEZwKYgGKgQBa2YrU7PshrnojI?=
 =?us-ascii?Q?Ul220cSPQx/zOFysFh/n43qhqwq53sc+Z4YYS/NtfgFFVGBn3JTGKqg6ZA81?=
 =?us-ascii?Q?HeudrBmTUXupAo5c5z/Y8D2CMMEzCXI9z9wA0WCkSOen5tXNreEJkjHWK7Bw?=
 =?us-ascii?Q?WEGLfQ/aELoSrkdGCPFXrTH86YYk6N4QQldL44yr2T8oMWq/K0MU5m9x22wO?=
 =?us-ascii?Q?q72oznpPNkyjkBlFefPFhVVMpan3Ywu6IVWTB4xh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463aeda-1507-4665-b27a-08de335c7705
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:42:16.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozc/BlP0GcB4F2BEG5GXCudvzgJsS9JYu8+9O4BP9YGUDd67RT8gNcBxFNIoKyWUWc7KM5WOK6fgGNpq8fJZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7895
X-OriginatorOrg: intel.com

anisa.su887@ wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we add following support:
> 1. Allow creating multiple DC regions (up to 8);
> 2. Allow DC extents to belong to regions other than region 0;
> 3. Modify sysfs entries to enable the above capabilities;
> 4. Shareable attribute is added to dc region (partition);
> 
> This series is tested with proper NDCTL fix, see:
> https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support
> 

[snip]

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6b976da4a70a..faa4656f9542 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -463,8 +463,22 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
>  		return "ram";
>  	case CXL_PARTMODE_PMEM:
>  		return "pmem";
> -	case CXL_PARTMODE_DYNAMIC_RAM_A:
> -		return "dynamic_ram_a";
> +	case CXL_PARTMODE_DYNAMIC_RAM_0:
> +		return "dynamic_ram_0";

If my v9 were to land then this lands this would break users who developed
against 'ram_a'.

Either we need to change ram_a to ram_0 in the base series or use
ram_[b,c,...] etc.

[same comment throughout]

> +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> +		return "dynamic_ram_1";
> +	case CXL_PARTMODE_DYNAMIC_RAM_2:
> +		return "dynamic_ram_2";
> +	case CXL_PARTMODE_DYNAMIC_RAM_3:
> +		return "dynamic_ram_3";
> +	case CXL_PARTMODE_DYNAMIC_RAM_4:
> +		return "dynamic_ram_4";
> +	case CXL_PARTMODE_DYNAMIC_RAM_5:
> +		return "dynamic_ram_5";
> +	case CXL_PARTMODE_DYNAMIC_RAM_6:
> +		return "dynamic_ram_6";
> +	case CXL_PARTMODE_DYNAMIC_RAM_7:
> +		return "dynamic_ram_7";
>  	default:
>  		return "";
>  	};

[snip]

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2bad68f13e21..e28cd6827c7d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -106,7 +106,7 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> -#define CXL_NR_PARTITIONS_MAX 3
> +#define CXL_NR_PARTITIONS_MAX 10
>  
>  struct cxl_dpa_info {
>  	u64 size;
> @@ -456,6 +456,7 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
>  	unsigned int nr_partitions;
> +	unsigned int nr_dc_partitions;

I think nr_partitions needs to include the dc count.  And when it does I
don't think we need a separate dc count.

After looking at this patch I'm thinking that the changes made after
dropping partition support from v8 to v9 the merging of the
volitile/persistant/dc partitions into a single range might have made this
support easier?

Is that why yall did not try to use v8?  I've really not looked into the
detail of if this is really all that is needed to support more partitions.
If this is all it takes I think what we really need is a use case.

Basically keep this patch (with the name change I mention) until such time
as v9 lands with a use case for single partitions.  Then when multiple
partitions come we can land this change.

patch 1/3 is a bug fix and needs to be in v9.  2/3 I don't quite
understand yet but is a bug fix as well.  So if it is an issue it will
need to go in with v9.

Thanks for the work!
Ira

[snip]
