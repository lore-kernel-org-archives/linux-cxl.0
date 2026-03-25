Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408B1A9FAB;
	Wed, 25 Mar 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774399611; cv=fail; b=ICKU2iYQerkPtPRf0xtpIT/tgQXUQzKhkhDhmCccPzNFHNPBiLcI3ENVX8IlzVsBPwambunhPY1l2hucCfsjV6qvunamj+Zhp+pIPtwAimlcf3NsZ6xLTYCMTVouNdpFefBtucN0LGdGYkkzj7hDVXgW/zrvp13osv1EaRELGOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774399611; c=relaxed/simple;
	bh=jU2Zx/CD2nUQ6wtmf8vYdpCsrJxe/7v/Dn3b576T5Cw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VaZQ2IcciEneRdiZ8Cw5Fhn+Hl1DlWS8+Wq2rNT/DlmoEyHIVWrxwWzPoWCwv6E4t5eDWETnaWA79bXb44oUYRaZQi/JPdyVpwlSNNX/q8CiCiwowv0+IuH9dUGk6aitqhCceOtafR7harueXDDtPbYguNZNHthZYgjJpfftDDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLdq75AK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLdq75AK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774399609; x=1805935609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jU2Zx/CD2nUQ6wtmf8vYdpCsrJxe/7v/Dn3b576T5Cw=;
  b=TLdq75AKVqCI5Itd8MgejWGU8prLWC6o+nJvk53aibpajuuh2vlTFn4v
   xseYdSIcz34p/SqUJfzaBDrYndLSkJWLCVWC3lHFGnjTluaiJ8xHLzBdS
   UBq8e+u7jOn1i5sk1uwcYP40qeJCTDESoIHfTxMF1ZgqoACk5tjalANnm
   WLMvI0tTiw9E87lzLWV6JIKbf7khH78homnlfqQh1jLhQP1LGIspfLqaQ
   onWIiACRl4IE/AccrV6/G5mPTCArKbFixjpDcBH4o5/la1ALudBx4WpiC
   DA8RAv3Pbf5t1Z32Hni1WU4bauODGD8bL+AHLcOE8e3iLcsFU9/WTyrl8
   A==;
X-CSE-ConnectionGUID: jGi749EtTWWitlpRCJiMXA==
X-CSE-MsgGUID: h6JUsPvKQvKffDZkGGCdVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75315012"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75315012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 17:46:48 -0700
X-CSE-ConnectionGUID: AJnVS5EtSH2HvlJAAurVHQ==
X-CSE-MsgGUID: btRlExf5SR25w3xRo7yenw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228574442"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 17:46:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 17:46:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 17:46:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 17:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHtd2uC3GGav1INO7qEC0pfED3MYbqMixsm+J3hDjlyp61309rYpdA7pyleoRzuWM34w5jUTxSvp9ZTFdNCi3vV5EMsq4XQpzje1JaWb2p8aORuBFpRVodx1CW9H+B2hlJ7aa0xasz6ANF8ZkdK+1id0UuQY3VNXUlkQQPL9se9MrO8HOnwgNWz+dv1D8jwkco8npWGqz67MVO+pWHhWu0AJaX/BobdXqYm8bjh298yinAHVEypKjczXDSQ9VCNuQIY2tqbD35jxxHu4gy8l/cet/O1dLeFcHpv/wRH8GO0OaitTJX9GC0eymAHlz7I2s6JPaTMW1zceuo+2Me5JQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEoglCxZammKC2X6UyHtlI28UmexwzxJeyUmmmG/aRk=;
 b=oWvbzHI6vmpAi2KEsX58pHeW+8Iwe/JJhmFwxUUCpcOqF0YoyborT+7m4ixhZI2O5E+B+Q7Gt2Tq9r/RLM/ksj14oNDrHMbxGiP4txkfojK8aMd2lqLLoSusGPlUai/ekbmukFXql4hgjpfktXyW2zMOvZidpKQwpanho/tCuw2cx0BbjHP+2nZYLNj1W0RwrxpzqEJliI14HEnDtSqe57dXnCahdeg/k2PAj+DCx1YCYY1ZUcdXHsScJ175OjpRLKXpFzTMEWLmN+U9pBzlWswXXq8+cEwZv7RIe60aDls9EyzHPZNQl74MWON3M5O1mJtQcSCDFdJU61ME6/pIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 00:46:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 00:46:44 +0000
Date: Tue, 24 Mar 2026 17:46:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Sungwoo Kim <iam@sung-woo.kim>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	"Dave Tian" <daveti@purdue.edu>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
Message-ID: <acMwcFT8ng9Hb45K@aschofie-mobl2.lan>
References: <20260309000810.2632065-2-iam@sung-woo.kim>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309000810.2632065-2-iam@sung-woo.kim>
X-ClientProxiedBy: SJ0PR05CA0148.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BN9PR11MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: d85a1352-5063-4574-a42d-08de8a07fca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Zk5GqnHL2DEchFkUCmEB22CKVgaAMaToboDt5ieM9Bfg4BibqbqL9f10pbhf1LSlN3w1BljMObcDAuVlUmgj7q3ZjL2A86UgFhvv8C3B8/R0x/YDxXzoZ8qjWcNGJ25w4JcZwPerl1LlwooVTOSofjUNx617JG82R4ur9+HzMeTXq1gpCNl/hh4kDBbLkEuhh9WAT/H3VwZ96j8JtBkttxDfc+FShbEWRx7ng/7yxlO7nF++ulie/wwtJjAeMSeoUKByRFR3XZ6beVEXOyUtYyRKPCU1lATv4j0gMGvjudRo+TeIyT6HQSLeGSQCN8fd5JgyInRtF91vyjAQ3otVoj1UpPkYroPN1l5nSUj8ollBUnVUOa+LveikQiZ5DAI23RoTFnptbx4bA2FakZ+4PttcBfr4blVItmTQ9RydL9i3weH545mWzlQMmTeaGDm8rOOe100N5pTgxveOT6rPgFKbqHzw5HU6Tmox6mXrHVfKSWEZyiQzgUSNcIJMzja5tU/SOyendvkVcHrFiVCCNoG/eLMrOV+Lq2POq2JIrMZndrD1xfMpAQMkSeSnzb51jaALtN6FJjUUe5j9cO37+ZGIPmXkbLHto1a6dfOWa5bmeHdQvM+XAUUANubYkYJ8jXcHpXAMDyiASiGWwQlDQEpuJtCo6lcAAzWK9wXRhcIGg88PzWNZbzlNRnqauizMcDiMV5IctSUuq3ycrfc5Z3ANttbUovje3wFUqJVj+5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQ7KvJOSDa/PQUdUQwSq77HoLzM5si4n4O6H1mFqoPyx34QJGduBgdOuGmZj?=
 =?us-ascii?Q?kQYuXPjr/oMJBtr7I5+O7niShHlozHUGwq/CEqTx2i5mBr80doA9Bgbnmm+I?=
 =?us-ascii?Q?YF6dM7tL9EBU8Zrugj5uJdqN5C8kJDxwhcCRYuDR3s0HdpQNlLzqT2oUP7L5?=
 =?us-ascii?Q?WkPfEKkCtWXmNHLXcEVb9a+T6S8DOoJhwv/3FgQQQ6zSn4VMeq4jNaBDr1z1?=
 =?us-ascii?Q?lXs1U/rx/GBivUD+O1cFo5M6TnLDkXv8GDleF02Y28DyBIMEvg33FZgpsww/?=
 =?us-ascii?Q?0od8cGMbghw/fdDSrghbHu4ocJrExrTQOTXIeJJf9vUD3eZt+bxTyc6UyuXf?=
 =?us-ascii?Q?86c44HsBq3hPvNnA7N4a1G7iJxWasr8OwLIbsyWPTP179xuw+b9aBcjtWFEk?=
 =?us-ascii?Q?4wLm4HxsS0D3aKFRLIqlhRkZLQK6lt1BL8qMGzQ+trcAPeT7uE8dFMHaM19Z?=
 =?us-ascii?Q?B8RHCxSJ0x72xvsvHu8FBUFvziUl1DxVww2mrJztBfeR442lfY2C1jJJULJ5?=
 =?us-ascii?Q?MD2654B+vfqyXI5BKl2dMV894Mfg5cN8jp2MngM6OmVQ1RMmWfPITVaxh0Ip?=
 =?us-ascii?Q?q62R2fAtUe3XNoqpnDi5lvHy9BPMEi9rYPdoaBu0CY7cmvSIdqmtjfz/5kRy?=
 =?us-ascii?Q?wKvUyKppMZ+UruKDylI1Zl9hiE7L/7oP4lXk7FYFhrGlo0EW1sCjOYNGQjKM?=
 =?us-ascii?Q?mwhqPkTb3AHAprTsinvIQ/Rx9arxYUEZlwtY8RrVnqrGCgWE5d87HzvhZljJ?=
 =?us-ascii?Q?UOXh6/dSy7oOXgMUocdI7h89MuNKdmRUrpMg95Nm+cqjuXh2Iuz5chhncGxZ?=
 =?us-ascii?Q?yy8MbQfBozfSyu424WB6wkY5213pxuz+FoG9VDwUWIGqhCUzX6HonILc7FSK?=
 =?us-ascii?Q?e+PyJLsFyQt8REFZG2N48bGKWsIcctW7WGXCAlS3stgPMkQ4xBFmxfl60qyj?=
 =?us-ascii?Q?9T/POvdpQaJLnUQtxKHvnpgJGUtPxrV7mdVcdnfAKJ+5NwnLELCktwuZbj1q?=
 =?us-ascii?Q?lNxn9bTL/5EUY2tJaqjBmjdVbSgSDQE8Yd3Oq1LX3gr55m+XAT26IVl8D0Bc?=
 =?us-ascii?Q?5POTuMVGuT8yKeo3gPruTUVJQ2Eb0kfJz8WVRK6I+r519WMc+aZU+2C+bFah?=
 =?us-ascii?Q?QRmSL3kei8v2TAOEIU2tT+GDpw11wNO1jGhtD7x9oG1jYdJQDLPkJ5aXpX/Q?=
 =?us-ascii?Q?FwZ06JCwnmHx3GwhHjSkda0mLWg0YLh2Mi64ePNIn7EqS6z+8ZaN5pRFTST6?=
 =?us-ascii?Q?4IkGUtaVd89tGBXzYVgLN63wvCNK6+cgb/VaWSi/dy/aVAM4HCRRVA2B9WzE?=
 =?us-ascii?Q?8iqjFu1yNbRQkKhtlbqzmjQ7nHEDWTXF0Uf6U+tSyOZBttMNJRNWYuV97Q4v?=
 =?us-ascii?Q?eDl3STLCaCmfUcwWGYIbCbmdTEfyDpS6DF9OVGsBwjnoJFz1q/zl+q7Pr+VN?=
 =?us-ascii?Q?waANHyI7ZGACyJNqphdBGCdCo58XYp4vuJnSLALEUufLBVZQHT+sfC/QQJgf?=
 =?us-ascii?Q?xQ4Cd+AtP82mfyqLhaFcv6DlxMY5hKsPCu3ku1tceO145kERHW6hXO+zn39W?=
 =?us-ascii?Q?81hUAy8i6uCTjTdzOPzo7V0zdvAbViBaPzJSUWIEW7TLUjn7X8efZ3EuQS3I?=
 =?us-ascii?Q?NX1VVTNGNAFD+RFIMejApMX958XrhXrxtnmF6Sl4PMtZfNpTQ8zMBBPjAD+Q?=
 =?us-ascii?Q?m9aCDRbI97F1MYIQAFWu/UDKppEasL0J3VkuntDPp//PYgyccvebuj9ncLAC?=
 =?us-ascii?Q?EB3RBpYbZecDwAws8i3Q/bv2r3XpmXo=3D?=
X-Exchange-RoutingPolicyChecked: p31uNpJbHtx1qpGkdnN65wBpROYTQWDQwhD2Pl7qeuDZSOow1aU80qKp7fUQ2i8daZwkID3QO85pykXZANbCaFxYrPzU+hZMB/7p8Agay7H3hDs9qCkfXAzIGgyp+jnCL33/l5mpOF9WhhCQnchlCJD+9lxALgWBsBq1nYLd+3qMuGjAHV+wJa5LAGbkeb1wEbsimS8v8sjzM5YhqSOlZNu5P2KA7tbUs3qFMjbBaEjccQ5PEaprv9Kz6Bhusj+hUbo+ao/B2sWd1CG9QsB+Jq7KlwAtSODwtajfV5jMCVlOoTIwPQtfkOgkjp/NXhy+/NL15U+36RnesT+nshOdOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d85a1352-5063-4574-a42d-08de8a07fca1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 00:46:44.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OH0ThyoaU7xGn5qs5NSFVfb4vwHV+n8FSGbOepHEG/3DBqQVH0Vsggdmb1ddWNvO5elFkc2pO3MOipnaJaz6MLgZTlOgTv7ilPTpT8mnTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com

On Sun, Mar 08, 2026 at 08:08:10PM -0400, Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, extend a critical section to embrace both
> __cxl_dpa_reserve() and devm_add_action().

The fix LGTM. I suggest tightening up the code comment. Now it
talks through the race in detail and also cross-ref another location.
Limit the comment to describing the ordering requirement we need to
preserve. The commit message already captures the full race and
rationale.

Comment update suggestion below-

snip

> +++ b/drivers/cxl/core/hdm.c
> @@ -509,13 +509,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	int rc;
>  
> -	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> -		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
>  
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	/* See comments in cxl_dpa_alloc()*/

Something like this:
/* Keep reservation and devres registration ordered under dpa lock */


snip

> @@ -613,7 +620,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct resource *p, *last;
>  	int part;
>  
> -	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder attached to %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> @@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	int rc;
>  
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	rc = __cxl_dpa_alloc(cxled, size);
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	/*
> +	 * Add the devres action while still holding cxl_rwsem.dpa to prevent
> +	 * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa_free()
> +	 * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
> +	 * devm_remove_action() before devm_add_action() has been called,
> +	 * triggering a WARN_ON in devm_remove_action().
> +	 * Also, devm_add_action_or_reset() cannot be used here because
> +	 * cxl_dpa_release() tries to hold the dpa lock that is already held,
> +	 * causing a self deadlock.
> +	 */

and like this:

/*
 * Hold cxl_rwsem.dpa across allocation and devres registration
 * so cxl_dpa_free() cannot observe dpa_res without a matching
 * devres action.
 */

snip

