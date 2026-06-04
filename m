Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E205B21A;
	Thu,  4 Jun 2026 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541085; cv=fail; b=lZPI2eMLqeYdC29/SBBB0bqQt4w5649yNhiZDuY8vuWu586Zj1htFAzqrOOGCCqltPlLNxyaXcvtvQVlBwCyFMDpQfY+EpTslinGJOKAcfOmzoam2GKbWsXQke8NYIKXqCwEp02nDDdB6K2Ci6ac9Zth60mp1pWVkO2D9pVQVaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541085; c=relaxed/simple;
	bh=rkqLE9qqUvoFbU4jESWrlpJp8jmZG7sQEkpZDEt5KIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XeAz2RuQ45jjbzkszq9M1Sl8Ob6+799z5k3swBZWcYBICKfgmqakslHMCL0z9RmOszdWcZfJIfMvsVnQPyCg6vpGzMZi2TB3FLZ6lVf6rdOsnWPtC/rkMLJA1PkLW26HKHAinsDn+8YGbdSBE8gfjNcbBVDG7e2gdOTSDp3rDIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJIOmKFa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJIOmKFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780541084; x=1812077084;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rkqLE9qqUvoFbU4jESWrlpJp8jmZG7sQEkpZDEt5KIE=;
  b=DJIOmKFaDnfkLcNedVZbabIP6Sho70dwUGbVzPJzngwCSXLaKi6+R7SR
   gbeAtdWRcv/T2EBolVupwEFbdcRJcZSLFN9CekLQSVnoItsii+nfIVmIf
   1+eNUHJxN6cv7dxo7SO8NLUX1q9SIoWrrs3jiPblTpChn0GLxkGBxbYkD
   NWLBdhESkcfwKwCEuf6jMvSzqaWRMYdoxVKKMtayk32K8wRLS/dVnQOZn
   YdhbtpQe47r0cKcGn5nbi5OtA8+t9jtbX34rwBQ6nW72Hzu9+8AoZotAY
   KSxNMgQSgEe2j7MPp2kjEHjed3fT9SdZHFwuaaWLMuZPTyzfag6+VyZqh
   Q==;
X-CSE-ConnectionGUID: fWDIxpDGRUCBxKx48zPP6g==
X-CSE-MsgGUID: l+X4RBWnTUWhOJDlCv6VnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85215455"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85215455"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:44:43 -0700
X-CSE-ConnectionGUID: x9s3a2qVTuKOaT8Tya+Uxg==
X-CSE-MsgGUID: Bd+dqEI0QvGh0ucvK87h7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249340454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:44:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 19:44:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 19:44:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 19:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz2Ss4/udZ/gagxBblTVaYA+1nKMf9/GscYqMzUjy3aW45Mc2v4v9gHFe2XVVIeEJ5Y7d6IncUkqtipMsbmlZvxiMaQgk7E2thWvtT08zYqHLjhwGrdPnzfuLZwXt88aPOyJ57Qq71vm6ik0EggolpKRSIWLKpdvnRuj8ZS788ncjiu9pJA9GtmiakMzs5Zjwri2I1SFxalmOuxaZKYuJlPUXbu6LYNUCROZqV6thcVM3jZahsS41nSZHQVuY1nP6MQ7guEI2Hf70M6mzeJOoDHYMHGfbQmHRSeZ1E4ODeFVF9gQXqqrynnnoaqFUmJQ1IruXCWL2tgXlo+FL66Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA1QJYAeFqrrT1t8p6OYckNUHj0Cdu2QHoDUcCI4Rxs=;
 b=mtQGRoVOncf+8hbnV6x3tnOcraDdWwOc5LBIHWYUcjmlyoDxSkpG+619nZVY/kmLG5aP/gYPmC02CbfIs7ZB0rgaO+y/iuuNw1qR5sRNYNT3zW3A2viPI/GWCjjoTdS30dxDutYaYii5B5vR3lLLAS/HXDbFa638lewdQUd0g3br8LmZHMSrRYcKvCP+6+xFFxpXfnEWI9YIv8UQlvaBa/P8gapyVBmTuvhU17HhVHMsTumJBPkdpOANSRw+/E052CfbVVdmqOC8f/IpdwPFFBjxv0zjk4vw0e2znuOsVVuulCQ0ktF8LntbPyXCogz3m0NrTei1wEG2yNaS68Z/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA7PR11MB9595.namprd11.prod.outlook.com (2603:10b6:806:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:44:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:44:34 +0000
Date: Wed, 3 Jun 2026 19:44:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v2 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
Message-ID: <aiDmjgdEfBn7fDaO@aschofie-mobl2.lan>
References: <cover.1779957270.git.icheng@nvidia.com>
 <5c52cc06c27ab3754e4c046a3a9d361af89f0361.1779957270.git.icheng@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c52cc06c27ab3754e4c046a3a9d361af89f0361.1779957270.git.icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA7PR11MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 66841bc6-41a8-482f-d1a8-08dec1e33640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: E+adN1jivW808QMdd8JD3pRILlSKnt+SgckWFNIqSRL/Snmh57ZV5hOQpXG3jfhJJ59lu/8BUOsPyhifP3VoqSXO1H9NM/g8WHEM3V6Lx04qA8WioBe2PKcrdUNmrd9qtcGRsttVpyxBAe3agSSjfZihsqVQUyyXGgIpFkjo8ASbS87awd3fwYNYYbpV6d5YfrczezgEHoDQogH/V29ktjh5dw3i+AFmUnYQQV7BUFyLC4MZGTmsMQT9xYxH2VWgkVfH18N7frQ8fwhWo82wH+ZmtadAb+wrjt/4ibLuedQXS1VRgL2r9JJ6XDP5GZdGIiktAHw0eN6okf6CHfLl2jER8GhgA2oH0WvJsKGQN6udXmUAkemTOcTBMvzJvwTPLSoCwSsDW1reXryBcMRVObIhPsaKZ23bU/BzdPptCJXpuPYLs5EbrgCo9ewkVW+XuwgyJZ9Te+099Vum6gFXIFKjZS8/XHPK1ORpkrj/LFrHe9u+2rF69NQ9eZflQhrJgn8VZtuduh6qvV8NJf8UZv4aYhXy/PxUq6SNWm/FL+eKIFhenGLmIWTQWxt6O1w9gU57M/g5qvKuKG+jNkjCLnbLRn2OVM+4Wrde8xJEzCZBMOgdHq4HybfeMuw332SPakiJZhGGBYVE4DtEg5h6gKaar/Q6smc6T1d9go6+6M6fgKzCBn7Q3D2War7PxUL0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KjAhEGCByy7Hk7P7AfbBE60+v9hZkwHHcpP+q2QM5s6bs/v2UieJIA8wbQ?=
 =?iso-8859-1?Q?SCUXffDZERj9oktFUyoMasaHfymaRWlSrChRfkAhzFr/91+qk0N69iwpkC?=
 =?iso-8859-1?Q?WMAFC2Qj+Q9rfqrri2R5hRzz1Dl7hRpHpttTHZOaBGMU/eJPYfrlzsi2EX?=
 =?iso-8859-1?Q?fqlGkay7JnXvoLwNFX7MHsLzz1klvHn0/S2gAW8puPShd2MvtwH78I6d0i?=
 =?iso-8859-1?Q?uVx5eMyIRulTsG8kntzls/C7vJp49UE2WljXge3eMDkJob3mqJz9qU+rfY?=
 =?iso-8859-1?Q?ja+8HmbNooB4Y2ankuX1lhILmza2Fm2f7Z/fVhChdwJKwLLjdRqXKuyDC4?=
 =?iso-8859-1?Q?/PE3TjH6QryRxEBW1miUEwL2jugZxUcr0w7cspr3h2Dk8yk/1a5k3WMayu?=
 =?iso-8859-1?Q?g4NGu6rxa89szXu95lYdRWanMmlOoucgMtHzdcLvybizVrxGz7Dy1Sf2yg?=
 =?iso-8859-1?Q?NCwoqH86x9dCZ06lExeAgh6TB3Vl3U5LYvS3n2iHBqzakL5jJHL3rpm/qs?=
 =?iso-8859-1?Q?4lZUqgGMIUDsEOL80HzHInHw+nb3MrrCjcwEx9XgtmlQYKGZ2jsguOAwV2?=
 =?iso-8859-1?Q?R08pcyHK6qTyOWX8UVmi4TQvp612ZFOo53W3CARtjmWTLaW1z3bgPZ/Ptv?=
 =?iso-8859-1?Q?pqNvIv4oc+5g3ihbiU21FsGJoXdCz8ngapj/NyItQuyP+qU+CyLHFbbI6a?=
 =?iso-8859-1?Q?sTHfjqQCH2gbJ9Pc9uT8UXiRMtICwdcWcTAvxVZXkQ79Bf7qx7DKF3cHLx?=
 =?iso-8859-1?Q?bVXnj4qnumVa/U+rwzO+iPirSG/DKPJeRfCYpfwsPP9bQ9MhRtqRrr3Lsm?=
 =?iso-8859-1?Q?UbnRZD5cQ8AW3GDiXrPLtOkOOzMwoXDmF869nahuVtBQf3vpe+2RRWkn+t?=
 =?iso-8859-1?Q?a09zpU6IrQGbbdpVrqder+cusha899uiUQr0N8BlygezqsCYemiF3hE17Q?=
 =?iso-8859-1?Q?tcYeQHA1nZNPKjZfNHbC73i7KK16TKwfeHiLmqnAmGdoOviPHFmMIm4WRf?=
 =?iso-8859-1?Q?iFYYh2tx3aWpePyaTe8z9jTeDH6bF42pRxizABnD1gTdkm8fxdSpTWVe7Q?=
 =?iso-8859-1?Q?UFILoMMh3asF6YzyQ2MTimhg5A60GZGCDZyiUArx8YvI3J6pJSYwICShDt?=
 =?iso-8859-1?Q?pgw/nJ2yBZwFQ0r/6VqFvikPaWuj0csqZYaDWRBCRCKx0dCDLq5V8sbTwI?=
 =?iso-8859-1?Q?BXihnuPK3ZoEF2Iu7PFx+fw6tV/oy+qGlSw0+dkcUgf/yLSRTeVrYI8w6Q?=
 =?iso-8859-1?Q?KABHbUpX9JQ7ym4Q0gkO4sDcOIOy++3EB37ZjTTFcdy5jicqg1WiFD1F/k?=
 =?iso-8859-1?Q?3wNba0Pu4QWsENB/4j1ToVIXLmGxd0td7dzA8oJZoOgxCHj/jc6ltYqe1C?=
 =?iso-8859-1?Q?qFYuDCntg609XLJFAkJNdHjeyK5i9+epwDxeizILO0GOzhqHtUwvoNbgzN?=
 =?iso-8859-1?Q?idJ1goDpTkHb1Ssqn2I24+vIv4832bV8mkv/mDFGXTz5FlOThrLt9UgHje?=
 =?iso-8859-1?Q?t5QUg3L55+Bp3b8kIyvUZIwh+xT6M4GirI39fr/7bRyYAm7UN3FEk15lSb?=
 =?iso-8859-1?Q?XWLB3c8DT2SzpCtcxt/NMSBlROWWEjP513rUFDIAThfKudYo1gRyhPVfM1?=
 =?iso-8859-1?Q?iINJpKd/FNx6FMnpvjmybs1qM0nGXrXtpFprrz61FuGxUAmD8woiwcNOae?=
 =?iso-8859-1?Q?ng+nHlRJqosO55giEbCx9LYcre5UBbbElgS4DQlYc166S2mvfMhmob8h3T?=
 =?iso-8859-1?Q?Ia7/CpTMBfZsBGNR1/cUAgD5SDlqHEh34qP0swiyig+Xo5ctMCZ9nwjNsg?=
 =?iso-8859-1?Q?zBDFUXOK/eDz18bwNFRfyyHAzk2gNnA=3D?=
X-Exchange-RoutingPolicyChecked: DR3V6Twvmk1gZDssYsGdgIybbV9TPj3fKR+DzG/uSNfM1IszVTAydu9I1sML3BQ9Luo+xnetgk6ICNB7JSyVBbEGqhyHhuPlzx5ZbZ9m1LHN7IcNgjIw/QXoTZ/ChSS3R6hitxmHGjkDWxQVHQobFt/eS1s6FJeepUKYohW/7T9a++QPuoV5nia8aO2q+GS88nn/un/j2SvSJlr4K5EcFXVVVj93gNo6jMe2B+rc8Db+B7zeyDBSuzJrjDGHEr3Cp3PreSw34m/n65+cWcthpPykvZQDx/BFGmjMFV+RHkipFlTGxU0kqzXai8FoFhDjLefbwN6gKrMSRBl/48nO/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66841bc6-41a8-482f-d1a8-08dec1e33640
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:44:34.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0av3U5ClvArQqGoEySfe/iSe1POa8HQWuX96v8VkuqcIzZqdmJUjWCt/n7o4KW/D09ipDkdp07wTBC25o3qDI3Rs0P0lq2cBFp4IjztWRNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9595
X-OriginatorOrg: intel.com

On Tue, Jun 02, 2026 at 01:40:53PM +0800, Richard Cheng wrote:
> The kernel now allows committed HDM decoders of zero size so BIOS can
> burn slots with LOCK. Without cxl_test coverage the new path goes
> unexercised.
> 
> For the special endpoints under host-bridge 0, e.g. cxl_mem.0 and
> cxl_mem.4, commit decoders 1 and 2 as zero-size + locked alongside the
> existing autoregion at decoder[0]. Mirro the same shape on the parent
> switch and host bridge via the walk-up that already builds the
> autoregion path.
> 

With these patches I've got 7 of 17 cxl unit tests failing.
cxl-region-sysfs, cxl-create-region, cxl-xor-region,
cxl-destroy-region, cxl-qos-class, cxl-region-replay,
cxl-poison

I think all of them are failing for the at least one reason, the 'burned'
slots sit on the auto region endpoints that the suite reuses. So how we test
this needs to be reconsidered.

cxl-poison is actually failing for a second reason, and that
is an issue in patch 1. It gets to a point where 4 poison records
are expected and only 2 are found. That is because commit_end
points at a decoder wihtout a dpa_resource so cxl_get_poison_unmapped()
gets skipped, meaning we don't get the tail end of the possible poison.

I'll jump back to patch 1 and point that out next.


> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1->v2:
>     - Replace second_decoder(), third_decoder() with a single
>       match_decoder_by_index() helper, so all lookups share one matcher.
>     - Use DEFINE_RANGE() for the empty range instread of an open-coded
>       struct
>     - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than STATE_AUTO
>     - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model the
>       BIOS-burns-slots case
> ---
>  tools/testing/cxl/test/cxl.c | 79 +++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..1ae0290a9221 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1041,16 +1041,41 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
>  
> -static int first_decoder(struct device *dev, const void *data)
> +static int match_decoder_by_index(struct device *dev, const void *data)
>  {
> +	int target_id = *(const int *)data;
>  	struct cxl_decoder *cxld;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  	cxld = to_cxl_decoder(dev);
> -	if (cxld->id == 0)
> -		return 1;
> -	return 0;
> +	return cxld->id == target_id;
> +}
> +
> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->interleave_ways = 2;
> +	cxld->interleave_granularity = 4096;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxled->state = CXL_DECODER_STATE_MANUAL;
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
> +				      int level)
> +{
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->interleave_ways = level == 0 ? 2 : 1;
> +	cxld->interleave_granularity = 4096;
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
>  }
>  
>  /*
> @@ -1123,15 +1148,17 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	}
>  
>  	/*
> -	 * The first decoder on the first 2 devices on the first switch
> -	 * attached to host-bridge0 mock a fake / static RAM region. All
> -	 * other decoders are default disabled. Given the round robin
> -	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
> +	 * On the first 2 devices on the first switch attached to
> +	 * host-bridge0, decoder[0] mocks a fake / static RAM region and
> +	 * decoders 1 and 2 mock BIOS-burnt zero-size + locked slots
> +	 * (CXL r3.2 §8.2.4.20.12, §14.13.10). All other decoders are
> +	 * default disabled. Given the round robin assignment those
> +	 * devices are named cxl_mem.0 and cxl_mem.4.
>  	 *
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
>  	 */
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0) {
> +	    pdev->id > 4 || cxld->id > 2) {
>  		default_mock_decoder(cxld);
>  		return false;
>  	}
> @@ -1145,6 +1172,18 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	base = window->base_hpa;
>  	if (extended_linear_cache)
>  		base += mock_auto_region_size;
> +
> +	/*
> +	 * Decoders 1 and 2 of the special endpoints under host-bridge0
> +	 * are committed as zero-size + locked to mock BIOS burning
> +	 * decoder slots (CXL r3.2 §8.2.4.20.12, §14.13.10).
> +	 */
> +	if (cxld->id == 1 || cxld->id == 2) {
> +		size_zero_mock_decoder_ep(cxld, base);
> +		port->commit_end = cxld->id;
> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> +		return false;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1168,9 +1207,12 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	 */
>  	iter = port;
>  	for (i = 0; i < 2; i++) {
> +		int id;
> +
>  		dport = iter->parent_dport;
>  		iter = dport->port;
> -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		id = 0;
> +		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
>  		/*
>  		 * Ancestor ports are guaranteed to be enumerated before
>  		 * @port, and all ports have at least one decoder.
> @@ -1214,6 +1256,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  
>  		cxld_registry_update(cxld);
>  		put_device(dev);
> +
> +		/*
> +		 * Mirror the endpoint: also commit the next two switch
> +		 * decoders as zero-size + locked so the hierarchy looks
> +		 * like a BIOS post-lock layout end-to-end.
> +		 */
> +		for (id = 1; id <= 2; id++) {
> +			dev = device_find_child(&iter->dev, &id,
> +						match_decoder_by_index);
> +			if (WARN_ON(!dev))
> +				continue;
> +			cxld = to_cxl_decoder(dev);
> +			size_zero_mock_decoder_sw(cxld, base, i);
> +			iter->commit_end = id;
> +			cxld_registry_update(cxld);
> +			put_device(dev);
> +		}
>  	}
>  
>  	return false;
> -- 
> 2.43.0
> 
