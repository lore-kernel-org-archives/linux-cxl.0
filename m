Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978963D6664;
	Fri,  4 Sep 2026 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499219; cv=fail; b=qV/xtlBbtXYnFS2tDjonHXrggTqBvHQ72sbhdBczSeap/aMz7FTUSSMWon1Lf8E/7/N76vctL7UePVGpws0oRiuZrdCWHH0UAn+MTRaWrLsWQjXbpZc7Ch2sRoVqQ1+0krSEC1RNURhkQW9JIPI9Leb5iCqAjaZsb86qIkNe7LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499219; c=relaxed/simple;
	bh=IFdm/PsDk+iVpt6qkDaL0jjxglTaChAc2ms3KqKMWZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kU64waVSxNKNFXKDeIzR+Fd0d1J5ec0xJwBxaQKQmxdy1HIdVYJJ89WeKyh6tM81HzKxvUTQV0uh05iR+UlWdtJVb4uo5WGO0MkaaHYSScAwVk/gHzh48qxvqT0j80BAlGA9j7la8JaoxZuS7IWVRYDXCbHeGkNpGB4Iy29rnT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyT4NK1j; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyT4NK1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788499217; x=1820035217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IFdm/PsDk+iVpt6qkDaL0jjxglTaChAc2ms3KqKMWZI=;
  b=OyT4NK1jg6eOSZ3oFuTdH3Z/pOzHt91TnhLMv7t1KFrh5Z6SqeMGlFFW
   ecEkRrG+zdzuibW3lOUTvgyCEIhstXALT0rNCllvUMblV59Co+egozuWv
   VxM7cjSrD+WCE56yzhntrvB6rzcLICu+H6ZkhA+lqOfJF2AEZOe0JaJFY
   AF7Z9We+QX5YtB8S+60LGmSCBxHSxWTY4X17PE9GO11saR8QL3BU2StP7
   vxmCxVSkRcrQUVkh8yKJY1ojKgdDfmy8Ep9p91qibbJEEzK8rGd7DydXh
   6hiuMjPugjUGjnqB38PSUz/UdhqZrjTkh9/f3yo9Cl4NMf2brPdR1eAZL
   A==;
X-CSE-ConnectionGUID: 64fXRIlySUiIpnCVvN21SQ==
X-CSE-MsgGUID: FuKh4Zo7TWWikzwfw6f4+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87934028"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="87934028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:20:15 -0700
X-CSE-ConnectionGUID: HQtj0HpqSmm5vxKTmzRHiw==
X-CSE-MsgGUID: wJKJgY//QFaYrJvFlp60tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273723333"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:20:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:20:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:20:14 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrYLu2BfJDGF0vrbDe7zkzsCZDG/spgFyE9wY9MFbIPLxaGecAdPtngy9ZffBK7uJbv7DYGiPKSzfActQGKf34zg7DfYK/9+aWqvsA8p+d1LZ6x1vwUchQAVTjr7E95Bm9vjxZNg+NHKm8eZuW3ID+/phMPhavhUGV6kNfydnP8Ra3FvqTRhgxLepmYzJoivLjLl1+X8V2Pp8+KSCt31KsGWCrRE8hZ9S9Nm4cV3qrS1RZF+hxbZ+c8nhPxpUoYFHSLswvaYMr0RDqI8fjJqWyv3BIU9QHypnx4FE1ELKobKS1EbuY2jJxIyTbpP33KalObXamg08aOOkowr6Ww4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaSVsFH5EFuAim4op3LOLHpI6Bug0rTbQzBTdMGPa0Q=;
 b=dsdGUNkDc1SOlJDaKOhueoDAPmimCkAYv9zH4lS4IoCzWkX8fT17KlF2FK2x/LGBYK6dwJEkjkzGZzRrVdsgxGSTwMcjGyO0D5rC0PGRGNtF3NL4C+KwF0rdh3rCslDwRREl638vqdZ8FAtVPz63Lz5weBlVdGzWhhNLCQRnhtzBmtlRssvxPk1PhGZZDj1dP5m2ZomthgJ81kCw/Znhq3r6qCDgoQU1kB0dDIL6b7IC4tQPx4bd+Fl0gNUw+rhFMt/EKvvvHYOHiHMjGEwnCxKxHHS2b8c0YJh5eEogDKmiV05lipDCg4CeOJmL0zDZFsMEPQCJVkw2JSWCBEAd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:20:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:20:11 +0000
Date: Thu, 3 Sep 2026 22:20:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 0/7] cxl: Sashiko bug fixes
Message-ID: <appVB-P7pFRdwjAX@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b06981-00ed-4f07-164a-08df0a443155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: 8wEZRyM7IjcS5rf0cBdNxqY4xJHPJQuIG2DcZKO0cjYSbFMh+Hq7z8fiBh6P81zDMJ3jyFWp/Q1DQoaCg7pqeb9Y+Kp7yheilX57gB/QZmGNzSWlx0K3xKsKpTE5VLDoRINzElGvVk+7tkLwFaMgYrefbLSRI485sO0hrgjDuiwhyS0LpEkO150thSa+ozPI5KRz0EQIqzk/gDDfVA3uU1uvhAq7NEXkg978Y0O6v1gUKQu1KENXrjm4C4xwfQS4lUbzdwpvHVb0TjYuvHvKSWIRqSCmzfacVgLru/QnOs2VpSzaOfVwVjgTWGtIMgAZXG+EwOPM8Itw4ToMhSJ11C4FMLfs1YJs51dpJgtJxWKP18Lgd7eGLBc4eaDYLaFKHy8YTJxxwKEr2QNDkYAdEx/BQ/4gQPtzpaDG5oW539uop5S9o7l524jgdKIFswsgpxPNpM/bkgxXVkialK2kx3h9gGZpMdecjWwZ9M3DE9jN7Zbspare6KPRJodPz+c4rMXTryTZwOJydeu99gkEy2npoBQOaiMjFcjlOFlVmkVWeE67uEpVJSNRtvC40wVaAijmLYDJXM4ZnxJii/LfiDFc/DBMjEJ4fsAH1hTL630qgv/yWOtQfDlebnsdTXbRhVFYM0isbth8I7+rDoCYpbsdGAb8Pw/J37UoVtqbPx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cw/hZNojmKXAz0fN509OxOzOUuIE32LjKHsyTzSEJfrdMoyCsFSmhc4bsMH+?=
 =?us-ascii?Q?+8T1nHXe1V7FryzpCbQiYSm9tOEm6DDZ5WSXIR0zAi2n0SPtc4puVNqz8xuw?=
 =?us-ascii?Q?NlXSBsi0DUxTqcpoolLQH46gbuyk+ij684GSl0F72NcxBQUIzqaNuULx9zxd?=
 =?us-ascii?Q?RfczwaAcxxL/ADw7695kBSLZhMO4PhP6Oj3XkeJ256Arv+1y+xeXON6PJDEY?=
 =?us-ascii?Q?TLdvC3VmjggedmVisIk3NUONMluP080t0W6jgdvapMVP+OyEkJXuJXOiUBi5?=
 =?us-ascii?Q?JGDT22iX/26Rs1r0eoHk83eu5+1lJpg2ekL92JzGtmmAyQXE2hJlZUihu/EP?=
 =?us-ascii?Q?0t/nKEqOCzO4GCJ44liXkXQYHE+QYIz+RdLtaoQFfhGaroSeEkmfK/QEcPpv?=
 =?us-ascii?Q?DqRYMiotXZrpwqtCWcWaf6Jkptcqc0f6j1SuMdqO247vm7aZkIGQnqvq0eAq?=
 =?us-ascii?Q?8KfUMLxjhuMvcXREAUTaeuHryZm4dIo8Q30aDH0muGW9/+MM8kV+Sb7bT4JD?=
 =?us-ascii?Q?vovqlZf3TLY86AH78KOBc8aOnLX6CLr0ldjUwnt3C2RrM6gaTv/AoKhspFaM?=
 =?us-ascii?Q?Ls3VxX5QUEBkABH+CVWY7w6QxMJNS+A9slI02BgLRx7JK3yiTmSBYSFYKk9L?=
 =?us-ascii?Q?S2aax+rMUEwKbsJgh6fkoQFNKV/qw+wPfb37zSuGkNd078SCP7tU0D6yjylk?=
 =?us-ascii?Q?fs3ABu6kxFdqO4NESmbuY3ppFidmlOdPCehUWlOfNph/yugyDik/TavKWdZS?=
 =?us-ascii?Q?0aP1QLC9OTUCsw0/haHK5LkpjrzL6aCHncWN8HSVfMZ/CB/Fx27+QuSrjEPW?=
 =?us-ascii?Q?w3xgNWyTqG/SDktvoH4xJaFrphr4iYFIAG12PzhDpXC/IA8BwptMbF3jfKFT?=
 =?us-ascii?Q?aLMVOva8RJ3V5mxIggGFsAZHCFNmdtdWydM7r+Y/rYC6siurvCEhfCXY7jq6?=
 =?us-ascii?Q?F5aIbNH/mG9YemKfLQySnhZSnDLD3ZXQCk4ktHhoy09oTb7NJ/22f1sweqLh?=
 =?us-ascii?Q?IKdw+JU/aPMdvoLjtzef3JRsCy1fD6BX3k3XRH6y2G2IFURlDl0OlU7r3qok?=
 =?us-ascii?Q?hrVFykJXQzA3A2QPSonBfK6dGxKOd2Kl0eUWBu33OloeCLOyHxo9Meyyz+J5?=
 =?us-ascii?Q?69ASIyDJEnElsNvGgPxmZnP67faWab29nZo2hKeCu6fMDVPUiAVWOFGJ1tx2?=
 =?us-ascii?Q?95Pn1+RM9V1CSVyuryaHHS3VGU8PKSERi4zbY+SYTsNWsxQZpBUolOqiaxfI?=
 =?us-ascii?Q?3ny+ycc5QT5JHHd8JKSNPkaayxLewqvWtdQLZdlfEvwBymya8ws2OvtIqkeK?=
 =?us-ascii?Q?Gv/ZF6FsTFvUqJuzErt+e7ing9dvDm1m5GpU6/mYisaNmb3R3fm6DPHkLg4k?=
 =?us-ascii?Q?EecG+C71D3XiqOKVe2Nj354ZbiO63sCIzMJP+tddq4ErDKTPJEiC4NApfjMo?=
 =?us-ascii?Q?ZfceCu1zk+OUQHVdi7/AXYa4Sbb2u35SUkaLnLM6hqBzqa8cRANp+dM5alY7?=
 =?us-ascii?Q?qjIgnpUemwm5pm2OOTlHEG50IA6g7KqLBxRl+xBuBNJ4TiYPTJa9hGaLLcQa?=
 =?us-ascii?Q?UyItoovHPhscIdzYK4of6khNU9lAiV2e/7rQa3GwnjHfWs5UhwzrXz0P5rlT?=
 =?us-ascii?Q?K5+KFKBlvueKKUI9o0BpjWavP7+OyNQ84LyoZ7IVjCAJSSGt4QOY1rJh+T9v?=
 =?us-ascii?Q?8EEw8bTLwbErBzv62VzbAy8GZ9cAps5GBxaLC402CZyd54FTymRScIPrB+tF?=
 =?us-ascii?Q?w/JNt5m8QMlTssqMxMnrWsECEjsJwAM=3D?=
X-Exchange-RoutingPolicyChecked: rsdUG+yvAemiFvkBSGyZ9vXJ5y1Tq7wUh5XyRmLl+nlFrFozSAru25ay+VEF6oIoOwoBjMoHsRg5wygykW0yKZoopbDJDqcR2WMUglTyKvL02VvAuTfqC/7e8N/Yy+kHGPyy7cEyAkjZ/04xTldSKtk5tFhIfp2GjN9/vZYR/A8iVxHbTrOTK80ASteScYQ7ZzZfAOzCpPl/tus+RzpjFFQKpHXsGYZ8TAU6egThr4WT6Gd8bkNTDbJKZUsmOFR2NdrtAqUyILRZidJETuvfg0gwmkhjq/q0a+YGjUz1azSSaprqVVZP4pERTosFynO53maCf29rIEpf5mf+QjAGFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b06981-00ed-4f07-164a-08df0a443155
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:20:11.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj4sB5MmZD4HJhFOqnv1qbOwEBdzvrS293sAwcAr2+bC+tW+KziCNoJ7ehFlV0cBIn/Ayx5jA3Wmmdjyzj+N6w8m93PvkmB8yGirUxWFHrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:32PM +0800, Richard Cheng wrote:
> Seven independent, pre-existing bugs in the CXL core, reported by
> sashiko.

Hi Richard,

I finally got around to looking into all this poisonous code ;)
because I had an inkling that they couldn't be independent nor
coincidence based on that common Fixes Tag. That actually is
the issue, aka the finding.

be5cbd084027 is described as an enum removal. Mostly it did that,
CXL_DECODER_PMEM became CXL_PARTMODE_PMEM and nothing else moves. 
But three functions were not renames, they were rewritten.

  cxl_get_poison_by_memdev()	two if blocks became one loop
  cxl_get_poison_unmapped()	rewritten, no line survives
  poison_by_decoder()		gained an unguarded part[] index

If you line up your patches against the pre-rewrite code you'll see
that each one is putting back a statement the rewrite dropped:

  patch 2   'if (!length) return 0' was correct because pmem was the
            last partition.  It became a mid-loop break.
  patch 3   the RAM branch cleared rc on a tolerated -EFAULT.  The
            rewrite continues without clearing it.
  patch 4   the function consumed ctx->offset.  The rewrite derives
            the resume point from the resource child list instead --
            note poison_by_decoder() still computes ctx->offset and
            nothing reads it.  That dead store is the tell.
  patch 5   'if (rc) return rc' lived inside the pmem if block.  When
            the two blocks were merged into a loop it went with the
            block and was never re-added.
  patch 6   be5cbd084027 added six new cxlds->part[cxled->part]
            dereferences and guarded five of them against part < 0.
            In cxl_region_attach() it reordered the existing checks to
            get the guard ahead of the index.  poison_by_decoder() is
            the one site it missed.

BTW - I did confirm it was not a merge issue.

Here's what I'm thinking. DaveJ can pluck patch 1 and 7 separately and
you can take another pass at this as a 'Poison Repair Set'. 

I walked cxl_get_poison_unmapped() against the pre-be5cbd084027 form, but
not the other 2 rewritten functions. It would be good if you can do that.
so we can be sure nothing else is missing. Doing that, along with
addressing Sashiko citings, will get us to the finish line on this one.

I'm going to reply inline to Patches 5 and 6, but here is the
highlights:

- Patches 2, 3 and 4 together restore cxl_get_poison_unmapped()
  and improve upon it. It is partition-generic now and no longer issues
  a zero-length Get Poison List. 

- Patch 5 fixes the masked error but loses the poison records that the
  pre-rewrite code collected before it reported the failure.

- Patch 6 fixes the out-of-bounds read by failing the whole scan for
  the memdev, where the pre-rewrite code scanned that decoder and
  carried on.

-- Alison

> 
> Patch 1: Get/Set Feature derive each mailbox command's offset from the
> starting offset plus the amount of data already transferred, then store
> it in a 16-bit field. A large offset/count supplied through fwctl can
> cause a later offset to exceed the representable feature extent and be
> truncated by cpu_to_le16(), targeting the wrong feature data. Reject
> invalid ranges up front.
> 
> Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> failures are reported as negative errno instead of being conflated with
> a zero-byte result. Update all EDAC callers for the signed return
> contract while preserving the existing fwctl RPC response behavior.
> 
> Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
> the first fully-mapped partition, silently skipping unmapped poison in
> all later partitions. Skip that partition instead.
> 
> Patch 3: the same function tolerated the -EFAULT a RAM partition returns
> for Get Poison List but left it in rc, so a benign fault on the last
> scanned partition surfaced as a spurious read failure. Clear rc, as
> poison_by_decoder() already does.
> 
> Patch 4: the same function also ignored the ctx->offset handoff from
> poison_by_decoder() and derived its scan start from the highest DPA
> allocation, so the DPA of allocated-but-uncommitted decoders was never
> scanned by either phase. Resume the sweep at ctx->offset.
> 
> Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
> query, so an earlier partition's failure was masked by a later success
> and unscanned poison was reported as a clean list. Stop on any error
> not tolerated as a RAM -EFAULT.
> 
> Patch 6: poison_by_decoder() assumed every decoder with a DPA reservation
> was assigned to a partition. Malformed device DPA metadata can leave
> dpa_res set while part remains -1, causing a poison scan to access
> before the partition array. Reject such decoders before the lookup.
> 
> Patch 7: the Get and Set Feature fwctl handlers converted all helper
> failures into normal RPC responses, sometimes with a SUCCESS device
> status. Propagate delivery failures as ioctl errors while continuing to
> report actual device errors through rpc_out->retval.
> 
> A nonzero short Get Feature response is valid when Offset + Count runs
> past the end of the feature. Preserve the returned bytes as a successful
> partial transfer, reject unexpected zero-length success responses, and
> require fixed-format EDAC callers to receive their complete attribute
> structures before consuming them.
> 
> Changes since v6 [1]:
> - Patch 7: Remove redundant braces. (Dave Jiang)
> 
> [1]:
> https://lore.kernel.org/linux-cxl/20260826014508.9989-1-icheng@nvidia.com/
> 
> 
> Richard Cheng (7):
>   cxl/features: Reject feature offset that overflows 16-bit field
>   cxl/region: Scan all partitions for unmapped poison
>   cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
>   cxl/region: Start unmapped poison scan at the committed decoder
>     boundary
>   cxl/memdev: Don't overwrite the error from an earlier partition poison
>     query
>   cxl/region: Reject poison scan for decoder without a partition
>   cxl/fwctl: Propagate feature RPC delivery errors
> 
>  drivers/cxl/core/core.h     |  8 +++---
>  drivers/cxl/core/edac.c     | 30 +++++++++++++-------
>  drivers/cxl/core/features.c | 56 ++++++++++++++++++++++++-------------
>  drivers/cxl/core/memdev.c   |  2 ++
>  drivers/cxl/core/region.c   | 15 +++++-----
>  5 files changed, 71 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.53.0
> 
