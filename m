Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AD32B10A
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113538; cv=fail; b=lm+RFhOvk5BDNPqYkSf4mnkkeFMF4RJzsWph5/vzbDxeAsvietced+SfYgbirz8P5IJ7KIBrIzxMgJHw57mTDzmrseFBsTeg7ZglW73ZcWoNc1xsdVsTJlccftc49RlFX6MhCV1Sx/1rCSW6ouh8BbRF9a/ECaxdQj8GJymDKuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113538; c=relaxed/simple;
	bh=33PwQOlZqtgPpCDPLihKWf0owQe4knqbhQEC3yMyTrk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0SRUQjCqPOl0cm6TEOlA6wmC+vqvXyRbH4l6QsM4vcT6l2UufGNXUqo54FpMi1kekEbYwuMtuac2psA2+sC+MrR+QKjRRT5L04P/tBrqibNTNZIvU1uKgLflGFQsXIDasq1/B/BAoiN8IFdyWyj11/CVr5NIqf2VllMQzJ/ZbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLigX8T9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLigX8T9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781113537; x=1812649537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=33PwQOlZqtgPpCDPLihKWf0owQe4knqbhQEC3yMyTrk=;
  b=MLigX8T9nvWwfTqLtOC3km4Y7UMWD7O4rTUEw6vqGB+JWwpx3tqoEchl
   ZvnChB8abUao3NWfYpiL84YtLajCSGg35GwntZCzcFssJbwb4LnsAjHKV
   Zwl70987CHCX7nLQMMv5HzyXwyX22PxfIgDlDuODAoT1hh6e8WtHBCa4Y
   lbzHUtllpBD6GeVZrZ/zyzY/NpE6glD0YLYO6btz5FBUMUAzuIyk12GV7
   /8YLPibf2GsTGrtlN9Y+niBep9Bv3wzwnpmtB+dl7Z8VeaNoH2iJpV2m6
   Yl6NL6pM6hb0fw9+w1Pgxc7+eK9j1WVWCftAp0HW90TEfOnQNw5ayAk9g
   A==;
X-CSE-ConnectionGUID: aUmywIfaSgShgyceAIxoGw==
X-CSE-MsgGUID: xfNFXdb/T0iB5C2B0kJIkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92482466"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92482466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:45:36 -0700
X-CSE-ConnectionGUID: XvZGHWrhSeqVvtqICWY3kA==
X-CSE-MsgGUID: DE6QMwDfSS2GaGwj9ntuqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246317624"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:45:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:45:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 10:45:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ9krtRKx9w65a4rzWwanK3yQzdg+F3l1rBqtwf9YFgQs+jzwGm4drzIZSu9t6SsjGAPCs0xj1ue6guY6Ckem2+2b2jf5Q4Y+dS8y2kGHIQe7v/tyWs5ATk632wN7sKveGdBPsRnpYkDqDXoe0PQOLztMyRMy1GxxSAN37TUR2uRXH1UDYqO/iI9pVbQuNZFrbg5UXiSbGi9x9DZHnHQSxV18O/HWSOntogaV3rpEQMoOzd7ZCEr3iy8oZRFE369ogtSl4b+V9EHHXT9zLpqE9hVHPR0ygWLfE1g1cH5V5pH4Bxn0nvRHpwj5xRH0VzkIStu2WSV/lZXv8ZN/6aydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sG3PjoEWp5GdgbldufzyV+lXQcS5q1Vqg9tnoGnJ/Y=;
 b=YhCezj5LD5YODFlbt4H4TnWupv7mpwiDKD3ZoLXuEYQVkHhiI/NrhHdSZjUgSrPZS/EKaQNtfaWeFSOOMGtRgt3aNmxv5pQJRVcHiGxMFQP7pg5HKzV6nNWcoFNY/Oe5TwAo4gZpTCW3zLvzoL7X/GtqOFeqaP+eaa7q8sJRsgvU0BmWMeVvgvU1/ZY8I5FouL2nEoxiiiU82hluboyjO2cRPhe1Jlp9Jx1Rgrqx2uzqTMMnJ8TpqzNvcXsVesTbZEiV9M/Yl/P0Q+5j+WiSas9XhnLbV6itlwlegZayi07gMmhdYZMf6uh99r3DwgCbDlcOVcVMh+hNU8ZWtgAPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 17:45:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:45:32 +0000
Date: Wed, 10 Jun 2026 10:45:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>, <sam.moelius@trailofbits.com>
Subject: Re: [PATCH v2] cxl/test: Verify cmd->size_in before accessing payload
Message-ID: <aimitQv7znTa7uJa@aschofie-mobl2.lan>
References: <20260605181508.3981107-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605181508.3981107-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN6PR11MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a7ea57-c79d-4a56-8ead-08dec7181177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: GJdQ3XEOlU0hlRHgRFIoimUgnyfNSATwkfxq8Q3t0Tv74EtcfIcmPUV2BVM6xqZ/M/JlqumOQHbcjbOaDOswggNoPM1LqwOOXJ58E5biM6q184+sPmjIqRNm5G42dmwKZcep8FYDV0eD+pxBrocyRAMRSBQQTPH4pTTItT+jHTTrUoRc/8rxoGmgsYLmngN8RJr9ZUfuXazaFeADNZnyJ14tfNuJKS1CFi7zTwa9wIJ3ywBIBE8RELHnt1jfF43hBrYWIbejFbYzNb9iMzD9d+zEIYOwGD5892FvLYbjvKNcFtvcbSMJC1BdTrx+K3t1UKwr8iCzfuk8pV4XPr0lYwzT7hUr0i4VaNMghqNMvfOXbNfWvmFALDj8iflvIN2jBzpM8MCvq36OV6eUXthl+UOPazv0aDnmDPBK2du6KbdaAfS2BJ2fJ4rHZQ2ybydvRw0KCucvy4b9gjD3klPoGvT1kifB2sjlOhnDoKkGanA60FOcPn6LJ/g9az7LFgSNxvFJHCKzFZaRdV7yQmHzuUZ1twTwYQ1NC7OISlgLSY2gLceL8ovPD/h6Uhd0aaYOMHtmC4ucRkL0iFQQYUkCcPHeTjIXsJ/Fp9N5BBYliYeDKYxDumqSaat6LEQWhntr+ngt6lJZqwYsmN1gYFeECmPfR58KXQ8d9wrXetWJOx0dd8TT+uM26dG62dxqu/Qpt8q2oT2sjhTZjy/myxtVcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCYBJND9Kx33K5meQlW2JxLvV0yjajpqeSvcEabzRoxTJ3PcLgtstPGWBVSy?=
 =?us-ascii?Q?gyFyLlVJlPu5iyKSdtP9xdGAr8g+2/5InbbF1iHOPwTOVp7Eb6947arTzmsH?=
 =?us-ascii?Q?czyiNMTwW3hV//FLTgwLZz6ej4ROOlCNxO9abNZ1F9YzOsd2+sQ2OvJjZ5pn?=
 =?us-ascii?Q?Rbc428GEyo69JYub+SmmfTEFoXKpQZZEgBheO/pmpF2cdDFEQZZUXhRdk6JZ?=
 =?us-ascii?Q?6FI/JbZBSRM6bSv27Y+jXbyN8s1QA7I+QMQdsjr3iW974QJgzbsW3VQbyTQB?=
 =?us-ascii?Q?KfdZtDDn4BcPNvf4hJ5qnIAlBjXDuCqxptMr2nvF58yDmHd+Q3hNbil9eAHp?=
 =?us-ascii?Q?15AHDPCNp0HPKRyVJZhVG6B3LzA0xv703V6GgZpdDuTvBJAO/3I605uDf3t/?=
 =?us-ascii?Q?DulWxh/6fzD0p35sl6YfuULvsAofppZ679YH4vKd0Wel/9uFUGz/Zuz5lJkn?=
 =?us-ascii?Q?IEbDtkEp4RyxqESggBX1eEp//yra4uE8WQunzRL9Knr6Ip3yxA2M2Lz6jYRD?=
 =?us-ascii?Q?p79Jj/SpVctyqQwKimXIsKWyVtFn7Hoaw7KXfUMzORrtAjxMTNWx0eYsdpEg?=
 =?us-ascii?Q?zZihAyQolg8BDoEsIcb0VYIn03Anfb4xxqfweakyPvfCmMwtEkOX9LdfC9Pw?=
 =?us-ascii?Q?aelH3fXEExeqbSpKYw/H8hB6iE0lzttVohxUBWQu2nID6+9anE3gy7X3K69B?=
 =?us-ascii?Q?cZzGc/khDmyjHGuSLr7LDdtNvm5MyGcx/LqDBfJ2fdYzgodXIRoMRSRO7rXH?=
 =?us-ascii?Q?wxhdl90a4vN7/kW4brIrW+MUf0vYLaxfi23oYDnvadOVOe4358coWFRgQLdi?=
 =?us-ascii?Q?q8S083T3CwKa17gpTxBlpwXiaGMGRGxfK3XBhEtX05YnBzMf8vJVG+//fXwW?=
 =?us-ascii?Q?OdkosQiXwBfReIsD9ZPIHAm4q7GTiEp4w/FApx8RMKohgPN9bNdOy4UTqSgH?=
 =?us-ascii?Q?tLaHMI8+lpC0T+fC2qJrXuX7OveToA4K/BX8y/z5SkkpFYORBx2bmWktEOp9?=
 =?us-ascii?Q?4BWLBIizhpr9/QCFnYTibqW2xIArFLMjbG5aQLI9FG9w09ameF1YZ/EeadGb?=
 =?us-ascii?Q?rAJK+IvfjaNttv08iur3kCzQax3+6n23drDnOtrBwLq5RdAjkwCFcNygM155?=
 =?us-ascii?Q?EKFThgjGTs2qI+tpPOp3R/JxajEAHUF0Rv6CDVMQzAIfitErO/vVxB3kpx3J?=
 =?us-ascii?Q?74FkyVC5MZG0wNDhdWWVYfNO6N5+MVvYaHHBJJ73WDKN9MNsqk53+rkL6gwX?=
 =?us-ascii?Q?RBpBTn6GaaNW6vbiIrgTcw79lR5SG4ZIr0spTnOz6IvnEPa6mmnF+cNPVdg4?=
 =?us-ascii?Q?u260BleThIqLnB7CLUeMLkaK8NZjeVZFnmoNjOJ018aa2E5Flz+G/vA10NO6?=
 =?us-ascii?Q?xEdeKG0PoI/vKV2hWRHMbEkm6YwngFEZFZPui3wHI0BH8gAid6hArMUsn3pR?=
 =?us-ascii?Q?W0JbyY0hAMxS6pm47vwiYjeKOTE22q9Cw99QSvU2vcRjjELD+tZhVvwrRIsr?=
 =?us-ascii?Q?BNrwxyF6hkUPPOdrJ6foESBQwrk9IxmPOveamLPrpg9xK0BFGAID6+DWQKtK?=
 =?us-ascii?Q?kbXk1Ftw0S+6jTiY9P4YMSHsB/gocPCxQ76KVSxhVIata1KEZvejSw8wuLD9?=
 =?us-ascii?Q?IojiJRkyicgCjzKInDalqqqDRy5l4P0zcXwMID8//N6D+D8nhLkO70w5/hlg?=
 =?us-ascii?Q?G5dwNwOCcXKNUmNK7+/dQfmMUBY6QTVwrqB2guYXLi5DLNH8Ok8AkSghHVIx?=
 =?us-ascii?Q?mRQtqsFdT/cbfrFxD5AcS969YoXfZQw=3D?=
X-Exchange-RoutingPolicyChecked: nmW8QmBSWtWl33EmIp5yC25w8qUj+LV43Aj8NgNRpqoNsOtQmmLJCeg+B9oQ2nguxDTmKtLqjCtNAi9HnY1J0z6e720+nRWuxj41BrgjghZCueSRkMVoSAQdXNNtxe+AbwJPvjP0HkQyXEGnIVk/H5IGTd/wadM987YeclMfqAhopd2Y7yDNyBef6W40xJzFWKcw6t7y3zvjvDmiCxtDI181+nvOZT76w8CB0T9yTAbpfPymZ7vlU23qfpYK7CoL1FKqkydryeX5yz557Um9uDluNgGVP32IB32FKOlaHxOm5MpHYbUBdVS3B0mOg/6WngmHxYvMU90by0cDr+W72A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a7ea57-c79d-4a56-8ead-08dec7181177
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:45:32.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk8pzp7/MgP0A8s4dX1mrzRXk09jzJWmRErSPoLujWhEEdd6ykt02wwS2eV4urURJ1Hp6WUibKaqKSATYGhzRQGyYdL6rnOax7WqKPNdqiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 11:15:08AM -0700, Dave Jiang wrote:
> Pre-existing issue discovered by sashiko-bot.
> 
> Add a check for cmd->size_in before accessing the payload. This prevents
> potential dereferencing of a null pointer if size_in is zero.

Fix LGTM but the changelog seems a bit stronger and narrower than
what the patch is actually doing.

Some handlers are gaining new size checks, while others already had
checks and this patch moves those checks ahead of the first payload
field access. It would help to describe both aspects.

Also, although the Sashiko report was framed in terms of NULL pointer
deref's (IIUC), the more general issues is consuming payload fields before
verifying that the command supplied enough input data.

Consider something like:

	Several mock mailbox handlers access input payload fields before
	verifying that cmd->size_in is large enough for the corresponding
	structure.

	To ensure invalid commands are rejected before any payload data is
	consumed, add missing size checks and move existing checks ahead of
	the first payload field access.

With a commit log update upon merge, here are my tags

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Fixes: d1dca858f058 ("cxl/test: Add generic mock events")
> Fixes: f6448cb5f2f3 ("tools/testing/cxl: add firmware update emulation to CXL memdevs")
> Fixes: e77e9c107978 ("cxl/test: Add Get Feature support to cxl_test")
> Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.kernel.org/
> Suggested-by: sashiko-bot
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> Change compare to 0 to payload size. (sashiko)
> ---
>  tools/testing/cxl/test/mem.c | 39 +++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32..2e9a5f151e98 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -312,12 +312,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  
>  static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct cxl_mbox_clear_event_payload *pl;
>  	struct mock_event_log *log;
> -	u8 log_type = pl->event_log;
> +	u8 log_type;
>  	u16 handle;
>  	int nr;
>  
> +	if (cmd->size_in < sizeof(*pl))
> +		return -EINVAL;
> +
> +	pl = cmd->payload_in;
> +	log_type = pl->event_log;
>  	if (log_type >= CXL_EVENT_TYPE_MAX)
>  		return -EINVAL;
>  
> @@ -574,14 +579,19 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_get_log *gl = cmd->payload_in;
> -	u32 offset = le32_to_cpu(gl->offset);
> -	u32 length = le32_to_cpu(gl->length);
>  	uuid_t uuid = DEFINE_CXL_CEL_UUID;
> +	struct cxl_mbox_get_log *gl;
>  	void *data = &mock_cel;
> +	u32 offset;
> +	u32 length;
>  
>  	if (cmd->size_in < sizeof(*gl))
>  		return -EINVAL;
> +
> +	gl = cmd->payload_in;
> +	offset = le32_to_cpu(gl->offset);
> +	length = le32_to_cpu(gl->length);
> +
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
>  	if (offset + length > sizeof(mock_cel))
> @@ -1336,10 +1346,14 @@ static int mock_fw_info(struct cxl_mockmem_data *mdata,
>  static int mock_transfer_fw(struct cxl_mockmem_data *mdata,
>  			    struct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
> +	struct cxl_mbox_transfer_fw *transfer;
>  	void *fw = mdata->fw;
>  	size_t offset, length;
>  
> +	if (cmd->size_in < sizeof(*transfer))
> +		return -EINVAL;
> +
> +	transfer = cmd->payload_in;
>  	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
>  	length = cmd->size_in - sizeof(*transfer);
>  	if (offset + length > FW_SIZE)
> @@ -1415,11 +1429,18 @@ static int mock_get_test_feature(struct cxl_mockmem_data *mdata,
>  				 struct cxl_mbox_cmd *cmd)
>  {
>  	struct vendor_test_feat *output = cmd->payload_out;
> -	struct cxl_mbox_get_feat_in *input = cmd->payload_in;
> -	u16 offset = le16_to_cpu(input->offset);
> -	u16 count = le16_to_cpu(input->count);
> +	struct cxl_mbox_get_feat_in *input;
> +	u16 offset;
> +	u16 count;
>  	u8 *ptr;
>  
> +	if (cmd->size_in < sizeof(*input))
> +		return -EINVAL;
> +
> +	input = cmd->payload_in;
> +	offset = le16_to_cpu(input->offset);
> +	count = le16_to_cpu(input->count);
> +
>  	if (offset > sizeof(*output)) {
>  		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
>  		return -EINVAL;
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> -- 
> 2.54.0
> 
