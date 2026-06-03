Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77D1BF33;
	Wed,  3 Jun 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526471; cv=fail; b=NHA+4c/eiT1KgnrpQxpKY7yr3Jfb5RHqpKQQ0JmNSIIW2TfS4TtxHQ8CTQ7wEICu6w3j7gT0JLReRuaKd7210NFc6/PvBhlEc5pToMzI52NLGKoCF5OJls69UVys7q63t0sV0A/tUprwNCOqN7dyRhJrPzsOmCAkDYYMwDOluKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526471; c=relaxed/simple;
	bh=OxBBAj8RozliQ+Wih0VUUDyCRJ0FfGyy1rd9j6iN7mw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5TgtuhehueZWqwk5w36barRRGVuafyb1y7YFnzTUP1lkvMFlrx300dSgSBi8tkxsM8nUHU677gSyARwavduhWDJ3Gm6B6fWKLP8t0+O3j21SAEFLTkpSDPDgGiKD/oMlhE5OuVkCoumTOcNYR/phFiaVZUxyteY8mLPubPtbUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlnecfFy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlnecfFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780526470; x=1812062470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OxBBAj8RozliQ+Wih0VUUDyCRJ0FfGyy1rd9j6iN7mw=;
  b=PlnecfFykScHoM4Axjb/gkvd8/OcQTlZf+THL6IDw6M2Srbf2l00Wlv8
   fv7Boisyzr0N2r3BUfVMFRFZmgS5BoPKPf66EUyMXjbva5sHduCeedvjX
   D7PwTCiwHoQFFr46Wj+SWKXFZ2xjpu0QY5H4O1ce95rpzxClhNizK2uLS
   QY0okjexPU81YYJ1QPB7cKxVsb0f/d1ThszBJ0J3yZjM48Jk9DnB4YTih
   qkeYqoz8Z0nxsl33AKxeMrqePEbz1viOZPfMPYt+gfwTvoVlf4C72kli8
   wc2WzQQ6HDZ5AMfxZBVh6Srjsy3TKFEJPzaXRx7Dl/xtC0abT0hDparlJ
   Q==;
X-CSE-ConnectionGUID: WdDAlkt6QVmDJEBg21mLUg==
X-CSE-MsgGUID: xONpqr0YRaetSXjNbQ3eXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81531070"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81531070"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:41:10 -0700
X-CSE-ConnectionGUID: aJFgf9IfRGqh5gII8mfNtA==
X-CSE-MsgGUID: AVjL+6y1S2O36iZxup/ENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243534498"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:41:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:41:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 15:41:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:41:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRNtLdbd9ZAdxsfPfXiSLX9X2YghLCAA8rbX4sDRJlYaCporsgpPdjfgYsNLZqsd5xIGskJC87imaakEYAQkAt24kgSQSf2BKyaZ9c8iUdXYr4Y6+4fqeYKEwEPr1YQSEU1LNaEF8qh6efsLrTX/MIsntH7EbE/E0KbQexGegeMwm3QMlUGSaFxoCq1iJHu/oGlcgRzyFAqbuWzXAjgQ9eoP9psRsjvxPt8FgE4xblfrEKSFOLHdEDjBSn7JcsWRtWGlDxTAwppOixlw2OcvsgRuuFZs0JNevc+vFUqyZuoY38wbAqQA2TSjHeTtpED9UOoHrPx0hhTC85v7CFzFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4EFgUpshL5t8Gst/IQ9tkc8tqQiojX6BO5T2DY2xzw=;
 b=HRt3oKyJhuUj2F8dF418c7SxU9zihjL5orXFGAlxkTHIzXVXIN3KoVIThT1ZYIGDXUbRC6CoQAQAzFfP6nksZkluS0CwUi/VGrO3fmaLEmKh7T8pdl5KFp7faP1XW5KbhHcDt3RHQEKvgAITTAF+ByQFPdBPCgmtiRRF65NzZR+TrjqUh6Muat7r1GFStdTs8kFv5fBHm1nQMAI4NQq/Xx1BnKxwG6Mp+zduBXa2LXmsBOfp8pTKGlyK3EiREDjyeDaJ/9jDpwWNkNn08SJqfxevw0nOpBLsEVpohXTHnnEMjOgNnE+nu+WzvF+8DLmehDFQVu2ezSHHhMAno7p+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6867.namprd11.prod.outlook.com (2603:10b6:930:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:41:02 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 22:41:02 +0000
Date: Wed, 3 Jun 2026 15:40:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
Message-ID: <aiCtet61qSddQ-Pr@aschofie-mobl2.lan>
References: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bfe1f4-5d89-441f-c10c-08dec1c1309f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ecL1qWNOSP0qubqg3ixtDKhEqyef8Ar2c6tI7s7mpF8He8BeZlENMQU4TDjoPKrd5rRlN225UNj8YYQxGTO33lBJItMhzPY8jvrf+WW2uIYxQmrc3fJzK8ruiUXvi9eLDA4idVwcUGKy2eR8a2EcSqXWFwKghBzb8ftaQcoc/lle5bF8lVueK0iWA7d08hKVKldBDSJbm06nao1norGT36WVOxTgIQFxQLLeTMxrNo6GJWwlXu+QZt+oKt+yRvIzdymQCADujrfZK94XMgD0BvxbM1GrYysY9Su/BWHi9Oc+oQUrgvefmoBcT0FIU9Tx8KyxH84cmtvxazadacThHlgZzq6JDEsA7IwHKrvTZL2HU/DsieRVoYzA0TVZlR8OkQXqcbmQmLGkbRiHsGJGWOFEAi8+Bpvmdv2IvP2+EJ1TM7LYEPgMIB7FLnfzOqDe1VmafkNfGHleHKNx5K4me3u+u/kO5w7S4HV8yCy/HpkxB7e0P9sF6ziBtC3ZybPAkglu84cXsTGnlfPk9DhokSw/idY/GGgRQPJ/c0cqZBrC8FeFBHp0xgpK0TK/q1JkY6feq2mT6ITFdShPHSEuSTypbeFr5T9Z+syZ53uhTj95+aqBFURWYkSatbzI4rhCUTnRx6cAOAJ6gWSSOEfAg46C6wHt+H/kzIGUexeZxS52p5CPJyy5fEjFcaWGX+D0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeXjEH1Ozx/eAyLPoULWs2SoxszM2658sRJjqfm7bcEAmE2bzuH27jPJ+vxp?=
 =?us-ascii?Q?nSUXWTbbVzfmwlzHtigE5SL+r3tc9La9hrEa6V2PE5QZ5RgdwPKmQWEOcL31?=
 =?us-ascii?Q?9TxloZPULEK8+I6HHaDOOSDr+USjgxv8cGyznW2utat6HjtBmrnvMbJq3wht?=
 =?us-ascii?Q?5CttQt8AddbSorvnixinlgXxdnq/iLPI9o/qwFc3RRn17vGjttN82MCF6gLq?=
 =?us-ascii?Q?5IKo/vcgCi/OKt3002KPOBY01a0NPPQiob21/ik+bJsZLPqzZaq7IiUAlBwB?=
 =?us-ascii?Q?PADB/wQtsclke2t5hVFv4TM3aE00hkDD0WaQhsDsyHi284dtZ5RTegm/WtBs?=
 =?us-ascii?Q?Jvr2MqAVSbElvBlazu/zrT6A8FkQhZ4wopRs6qyTM4sGlOtysq3imxwpO3wn?=
 =?us-ascii?Q?nzKbCUfNZ1/crS//tumDBzt+atouWkODXz/2Ymj2vK6/hobWelujOO9jZ/4k?=
 =?us-ascii?Q?6HGiSoZg4XJND9DTcm9OEcalQOP1nqxCa76MHmzw0s55jYYAn2534srdVMfr?=
 =?us-ascii?Q?FePXov5H768RjjqybqfgeF5vTvvLsU//LCyFGmqd4mWdXP91fO7iyYBkIx32?=
 =?us-ascii?Q?pRjaYI2t40wisip/vCSoSReQ2OWChD0b1KkL8pc4uFjZOZ9xEcWkRS5AvOID?=
 =?us-ascii?Q?WfZ1WcOpBvwO9WEr+CFaFZHaTHj8xkX29jdH7JZZgD9xoQilqn/YKIOgsYPI?=
 =?us-ascii?Q?nVWjwk8+3FWIn0urwy/9Ib1LcVZmlI93JQcn7Jf6B+vT6buIacOtEnb3hVbr?=
 =?us-ascii?Q?FsyzM0GOdDCXYgKhKeXZFb+W6n7cuks4TpuG0ziK7s6pCuJuG1W48hVU1KiJ?=
 =?us-ascii?Q?vLGbd/oXYfZtbPZ1fFm/GXUZ4uNBj6grUhJlwVxjsgEx0HfSmCwHfinU5SaD?=
 =?us-ascii?Q?ci8n+ucDdP9x0Y+7RtbYsGtc/TUql2+wsP1nNAsgm+LDQY8scfah84Z4fHEA?=
 =?us-ascii?Q?IpwnhsZfQ408QvD6EK4r+FlAggHgaTWVGFSii8eJNs1iX6oV+EhSyFMJIYJ2?=
 =?us-ascii?Q?mf7Rw1z4hDKTzno8w6ysLSntk+L7vZMH5yB90k9GVe49Qn2gubFRjeUcj5IG?=
 =?us-ascii?Q?Ty6Wn2mYC3L8ZP5THTEtQCdEfUhOoItksY/raTYWXNIaxca5pxeas2GZsCn5?=
 =?us-ascii?Q?n8bKSdXH/e8by/gp7bUoT/KT/oyTWAtI2Bn8Yge+JSL4nD4u6SFdBXQTPAYe?=
 =?us-ascii?Q?elh7TiU25to9hltp1VUb0gLg5pUIzCBkr+n6oLmljYhzPE9tyg06GqOulDnx?=
 =?us-ascii?Q?4rMCIrT3XiRtlorFZN7jZEguxpvZAh0VN7EJuQOmTHJyOcSTsbKUpIZo+2jh?=
 =?us-ascii?Q?kf6+Q+kctEm1/E3Y4helMsfz1EXDY3NVrDQpa5UMUyXQuSatFDCW6olUiGcq?=
 =?us-ascii?Q?Ek3PNwdfCXiiIL+Be0amGzMsYXnGkyaGrvEdD9c5Q3oRWERrA7VSGvBNYsKV?=
 =?us-ascii?Q?jmMpyOFq5F9wVuea3a6SU4NLEHu0IKQFWAPn74aLdGn6m9QEpGc/Saqm9krM?=
 =?us-ascii?Q?4uYVUA5wqYUW8oa23VNQrOi6VybciVSWcO29RFHCsjSZK2VhZ3r3q1PAO0LF?=
 =?us-ascii?Q?YwiCBZiHncsnAeBKpijZcNd1Mnvak1udiilwDNQsJ7kFeentLKa7pDPFCdMQ?=
 =?us-ascii?Q?8zJuK1j1ctI6ju29pbCpp9LkIuPxxcADQyHvyz7xilNKlqPDT9A8VdRKAZ8H?=
 =?us-ascii?Q?oNhUsjlAjdH8XWrM4z0tDe2+u+Um9QCDtltH3v9QOeZ+TpN60cOtKoRwNBCO?=
 =?us-ascii?Q?gcD8NFyfc0m9gCv3uSx2zJmu9ESPFLs=3D?=
X-Exchange-RoutingPolicyChecked: l7bIkNX41Vh4fYF09y1nAeFCheKTGwUpAU//6Yg1FkvQaXU0ueO+iUMVHOxkrA4Xi0bXDiASGIKmpp+hG3326cPtWRG5MERij+n6LaaVjDFiltkz/mp3OYqWzmwfRhhBiZBRA5b9dhW04Z6WWmM1kP8xh6n6MLVpHeQWZYC+xQAk4fqXhYaSUFM+7XVfmfGdhlqXPzKUo/hn30axfkQjHYfqROcZXlwVceaC8XgahGZG0z96BKPtE5t1tD04Zwcdz0cDaauOE94pGD+RMoAMiVhkzE1gbl8g3cSaz2izMyF9UFTKWUZb1OnG71GCUprSu6PoNKN0K3GNnHpiAABB1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bfe1f4-5d89-441f-c10c-08dec1c1309f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:41:02.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ4gqqbBxtEnxVbprljVsRLE5FwBq5BMJGAARMzoH5lbeJuQ+zN0puZVvJkpS7BOTpfWcQHhDNPnUT6wialTtPFDXGBYb0N62rs0VvFUyYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6867
X-OriginatorOrg: intel.com

On Sat, May 30, 2026 at 12:24:40PM +0800, Li Ming wrote:
> cxl_region_remove_target() leaves a NULL pointer in the slot of the
> removable endpoint decoder in p->targets array. However, p->targets
> array replies on p->nr_targets to determine validity, which means when
> p->nr_targets == p->interleave_ways, driver assumes all elements from
> index 0 to (p->nr_targets - 1) are valid. The stale NULL pointer
> violates this assumption and causes the driver to treat a NULL pointer
> as a valid endpoint decoder.
> 
> To fix this issue, when a endpoint decoder is removed by
> cxl_region_remove_target(), always swap the last valid endpoint decoder
> pointer into the slot of removal endpoint decoder to ensure all pointers
> before p->targets[p->nr_targets] are valid.
> 
> Fixes: 809ccef5385f ("cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()")
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e90c024c8036..54018db87a4c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device *dev, void *data)
>  			p->nr_targets--;
>  			cxled->state = CXL_DECODER_STATE_AUTO;
>  			cxled->pos = -1;
> -			p->targets[i] = NULL;
> +
> +			/*
> +			 * Swap the last valid target into the slot to
> +			 * ensure no invalid target in p->nr_targets range.
> +			 * The targets array will be re-sorted during the
> +			 * last endpoint decoder attaching again.
> +			 */
> +			p->targets[i] = p->targets[p->nr_targets];
> +			p->targets[p->nr_targets] = NULL;
>  
>  			return 1;
>  		}

Hi Ming,

I'm replying to top post here, but I have read the Sashiko response
and your response to that.

I'm offering review on the target list holes, but deferring on the
issue with cxl_rr_free_decoder because I think it's a narrow window
and it would not belong in *this* patch. (and maybe I'm running
out of steam too ;))

For the target list holes. I think there may be a single change
that can fix both the site you've fixed in this patch, and the
decoder detach site that Sashiko calls out.

Rather than add compaction at each removal site, make the AUTO
'appender' insert the decoder in the first free slot instead of
blindly at p->targets[p->nr_targets].

    /* Use first free slot. Do not assume nr_targets is dense */
    for (pos = 0; pos < p->interleave_ways; pos++)
            if (!p->targets[pos])
                    break;
    ...
    p->targets[pos] = cxled;
    cxled->pos = pos;


My reasoning, that you'll need to prove -

- Removal only leaves a hole. The damage happens later in the appender
Fix the appender and the hole becomes harmless no matter who created it.

- It covers the cancel-auto site because a hole left by the staging
cancel is skipped by the next append, so the swap-compaction in this
patch is no longer needed.

- It covers the decoder detach site similarly (per Sashiko). The NULL
left by __cxl_decoder_detach() is filled on re-attach instead of being
appended past. Your reproduce seems like it would verify that.

- It needs no manual-vs-auto special case. An AUTO region has exactly
interleave_ways slots and interleave_ways members, so first-free-slot
keeps the array dense whenever it is full. The manual path is
untouched.

I'd probably rename to something like:
cxl/region: Fill first free targets[] slot during auto-discovery

BTW the fixes tag is not the OOB fix but is the original commit,
the same one you used in the OOB fix. 87805c32e6ad

-- Alison


> 
> ---
> base-commit: 809ccef5385fa1779c7db3de43272f3fc6a87a45
> change-id: 20260530-fix_null_in_targets_array-124303a8ba0f
> 
> Best regards,
> -- 
> Li Ming <ming.li@zohomail.com>
> 
> 
