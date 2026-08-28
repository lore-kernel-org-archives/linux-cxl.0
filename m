Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF303002CF;
	Fri, 28 Aug 2026 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939784; cv=fail; b=CnqnPs3OSgztdG1F9i1h3qKBX5xfd3O+i4NScR7UwgiOcC1DGYMWhP1Ar0rCUei7K4yQ8RewTvLQjNJpAN2+ejvAZh+pMrIkojBVSdfBZBCRY2AfqHKgxrvYiztNE5eJS99jxpp0IQ3FSrlr3dtxFJtbOYzqdiTBDdKElW3p26g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939784; c=relaxed/simple;
	bh=lMTpwlF9FIT6w38EU4K02uXVt4SxIVNPHrkUZgP9wn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i/cuPmbxQXmeziNZGu3+hu8j9iMvnvsFHSmSYaiHWWqPCIo/Nb5SLwm2j21g7Dmugf+LMshmdKJ4BrqiQ04+MbrHxJc0r3ssRN3ruSrxhdIbtRC9HGOqCrHdZfWM23Ds9fFLfKjQMCe9Ze8EGdBFN1Pk+v7tooxvdf1wRJ/+CsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnxgsMFb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnxgsMFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787939781; x=1819475781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lMTpwlF9FIT6w38EU4K02uXVt4SxIVNPHrkUZgP9wn4=;
  b=OnxgsMFbGBC2FU7AsbfTH8Dr1XNcqZlR/DfYfsczfIiraVmplXtpv1Wy
   q8f6iLW+6+BDUQhAh/sWNVDp1SY53pDCJfYVGA7ZD5gw8WTlS8F65WBaY
   z96+UEKMb7h3QBvosoZjEfuaWGMKzOteAON8fK+N5ig+cE3nYaSC9+Bkx
   fVL0foVQCG8LsAd11Dfnsc3s+T9xikvuyicwHYJAv0/8x0Xij5GCXTqQm
   URImhDbDE8G+D1RJM5l5L/CunNE+0CoDxM7MpZtfpQyT7G23qYRtz3hN5
   kF8YZMy7PAVbUe8CD8AL/SA+TEd6rkggwiU47xI1xaQqBVrTbvh0vuZxg
   Q==;
X-CSE-ConnectionGUID: XMRljnSXQtOrvhiQ7EVXcg==
X-CSE-MsgGUID: DGrHgQ8+QtWly82/p5ZSZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88504677"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="88504677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 10:56:20 -0700
X-CSE-ConnectionGUID: Dz24lPwNR96OUAhYFW7Dmg==
X-CSE-MsgGUID: ktlSm+5PSa+aoEZXNJ0wZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="306434178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 10:56:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 10:56:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 10:56:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 10:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9n6rySrd59smCkyONG0b65ompeWmipOnFvihgXVPQvXGb+bec46/hbIcfSgYpEe5iZfXa8FYXi+292acHOl+6c7LF5Dv0n54EKsxXFfBekx11GYBFtfoHBtA6vBtCsVK8LOspVtc4K7fIkwLLPyERYmR/LEnCwRQvxf+p13RkCjv+L7WR1kDObaiBw3qcvaoGQprGJtMLrvISzEb8QUBqN0YY/sloYRaTqIwy0C48TbJ+wx/fVcyLkK1TAJCEk1kqiUWXNJ3LC4Ww7FNe4SW7KImP7tnh/OQOTFRLesTHlz6uQ4lesNICCgK0ERydQqPbvBxmvNBuNUHQod7TS44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g/uuxDpv3/QgTlPmDNmfFS1R3sz3J3rZXKcKrHd/0w=;
 b=gkgBK0pU0iqPjDg75NeQc8EX2N7TTRcGUlGptJ3vBuWeHRKOigw153Cnh4SbB2J9YII4BB4dgYMLRvKB6Vx8MUpBO6SuTZG4DD2TTg+bhtUxaUHtkvl5XOFcbl0qas6RwWs3ip0Ox1iOkyD33MxonfAwCDk9Tv7KcfMTW0IHY1v70hl1NNqzSFoFWdukPqJFyvxO+g1P+l8RVo2iIsexk8RanunNHi8NK5Rb3lTbegXDnIeSYJHUnfoDU3qokF5U+Yj7tz4kazq90fBG5BlnvFHLzuUQd3ePm9XmkN46O7SyIietQ2IFyzPREHhn4jwgMPdlPX65v+ER8ojLqE7oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPF7551E6552.namprd11.prod.outlook.com (2603:10b6:f:fc02::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:56:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:56:13 +0000
Date: Fri, 28 Aug 2026 10:56:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v6 4/7] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Message-ID: <apHLuBhvjRPu46zG@aschofie-mobl2.lan>
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-5-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260826014508.9989-5-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPF7551E6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1a3d04-af51-4beb-4753-08df052da68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 8RKXh4ZyrDl3sG+6elwS4B2a77z4RzY6iCc2CvQduaBiZLbGLMZOh6GEVDFbFChcMvyTsUtRg0x/sgR7RoUuUe8OpVf02IfYKbOTK6ti4WmDWE7v53uksIVYCAH9zYIu2210XSrCctbCp/tIVaMgvYq8ssXd0MOE/y9vx1EecyUMZkiEAID3wujkeV2TEOvDjJt8KD3n+ohqmB8XoNlCc4AGQA8klK7ig89vqy0AE+fZU78+YwinL953kzSRRi4R8ltHdihKq+sRo48k0EKfrRaK0P9Fw1VH4M95oBoTx0og9PVAXIiNedLvooWwrQ5gneKqnz03RQNk/h8m91ruKPJ3jWVFC223oRqLBZyNhliZY+yHe6Zon28j2QJQHFBzNAYt3035iBzkFSIUzaI9LQm7NlFQVNqAimH6/noqw7pmU6cUrnZco+wf2fjNk/ExBTY2qIHDPl71xmgwg2rp1V0wiDX2HDTUS+GlKwGsOC1/wFlRi5+PYMT5T+s6LNPgcJ10jhPpzneIhfbPuJLJMKEXXxiNfuMPJaQDwT4hA91rqA0CJlQCSQe8IBbHwaHee9niRMirVmEd8Z/lqm9wvJ/Q7Y228ndabwOO6noCYYmtl6co/QeYRgtDXIGI9DBP/imv56w/uigtp+n5paG3LXRDsCPKPSg/tLmQyhqS2nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uN1pep618IZeyA3JJ38gVhnd+S4BRqoe9P34CQkwPe8RfJjiZxucn/NVW/0U?=
 =?us-ascii?Q?wX8kZ2pTpg5HwbstptSJXvhp8j31mrfzs2+REsQfaC8uIK4KyYl48kefO7oq?=
 =?us-ascii?Q?jGhrd2s5msgg7wOd7FzovkE+84ou213LhHc56uTMhnpf9ckKGHr0ej5GpuHu?=
 =?us-ascii?Q?usH+rWnCd+4N0NQ1s1o2WiejMRGyn3L5WmzgNikoYIQskFefnW5m4C3Szcmd?=
 =?us-ascii?Q?jhk4IfUHXgf/UyX28qEdWogHw5Epd9gt7BubKOjRXgy0ZIkzc9maM7Opxnij?=
 =?us-ascii?Q?HpHS20ry14Krw1/kXB3D/uH4FznVRQ++9BJqbuYnq5TpbeFfUjTWQMS0+6/F?=
 =?us-ascii?Q?EAd0zzHdSebQUR7sAcQUzB/BIv1vTMrBcxxCCkL3Hn2sfj2+ark1UaSTDqIX?=
 =?us-ascii?Q?rZSAQ5SRpXwn5s6tAG5FwjKsZ/IpdVzHxbZHzWQgCObM5CZAGBIxSFzdys0t?=
 =?us-ascii?Q?kDrP3PcUl7e4RaMHEPGITh1eFJGUbQTD6fqGyUrzC+IKREmWW6u2IlABqUgj?=
 =?us-ascii?Q?La5toM7jcZXqcyAsqLvfjXVnqg7WJ5QI1tvOYSSgVYI7SdQE2X+3scZmRtAS?=
 =?us-ascii?Q?KW0zdc0iq/XXhv0+NaKJlUyh5f+MODUFwD7nSpNPFvHJDBa+jQCrRkIwovn5?=
 =?us-ascii?Q?m0DqZLi8D4qdaKpVw4cBH21+SABGjJ/sak7iAommpHC9QdPgEQMtx2rbsGNF?=
 =?us-ascii?Q?JkpNultiWwt0SgrIpkiD2y9TRarv6LCDNmHLYHep8gEwL5JKcKTiu0aBydCm?=
 =?us-ascii?Q?G65OX4cf7N9Aqrm/dqMibHd5Hy/QAuEwMgMbXKPf5CzybrdcoKLfkrTH9bEw?=
 =?us-ascii?Q?LKNRy7LyJNM0fRvja75+kcgyI9mH/Vnjqz8B2W69ZHmS+SghmGhpbTIo/EkY?=
 =?us-ascii?Q?5rrI1/Zs6z8fZmy6J/O52M1HKQDIOPvzbkhlRZarzpx2gPg1iZMjWftiP+h5?=
 =?us-ascii?Q?gIeAsv9bGz5ZAy5UrQDcZol9obQUHs7y/ysV3Tmaa0olS/pPMRH+57fNGJcm?=
 =?us-ascii?Q?YFMksOz46MymCcR7wC7DDmMH6ujOdxFzzQZc8xR7ldZL8B1e3gkm7gPpmiRT?=
 =?us-ascii?Q?Nr94ZMDF/N/3KaLw+TmbDjZ2P2Y4cCuu9efz75TQi1ZDge83aMCmD42em3Kj?=
 =?us-ascii?Q?G5xLAek/a5PAPW8HdO1ieRvgE+xjgxOPBErfCsB3DVEpntN34OiS+xNprsp8?=
 =?us-ascii?Q?Uu1Za+GAaHI1pmczjTAaa6eGKY0TYRJo8yVgxkJkqDn/zZaqposjgVKYbSYL?=
 =?us-ascii?Q?nqBclnOgADMfI1pcMgKEEh9ScMGz5iV+ucqtqkyUVdcmG+iEd5fO+Cp2VTvQ?=
 =?us-ascii?Q?kRMpOZfaeg9woUTsxS/7uK5GIC4vde9iqJlxbptGJO+VMc0cbOnjUmgA2pdR?=
 =?us-ascii?Q?Pb4582bLrwoPo0kGu8GVHSGhiAnOEWoO+rb6pNIq2ErGRXHJE89c7EpquZ1v?=
 =?us-ascii?Q?jcHPw+5aMhejQRsIvjZMN8NvwW7qKzwoTgoDXp3uininThLVvWayepitrqvD?=
 =?us-ascii?Q?ZyJhwX9yGbrr1x1H3T12lZGGBbYmHpFU30KhbC+nr5jpBxX8RcZd3lFxhS1M?=
 =?us-ascii?Q?Yy8555X+4bRjq95g4bO/yb4ADIM8qtfXKYjQj+diEZQA9bcgZ/hGrdVbJwYL?=
 =?us-ascii?Q?iGQvUMfxoIU/wkMycK3j/TKbJJMezPZj3qe5HdH4gv8/274d/nuTZlycpI//?=
 =?us-ascii?Q?Hs0JP30ypjC4nsQrFd0aiCeihCB9tufGiI0UBbFtCzeQUGaoFulD+04wbY6W?=
 =?us-ascii?Q?wTnoai6O9kIqBoUUMlJVi7EffPsRYyA=3D?=
X-Exchange-RoutingPolicyChecked: prWm8LS//52fidnpzc+BZxYTfbZnNrKm5QhFYh+/ncDm0jMRfMvpc0m0q3w/mezW+YmBJuHb8PhHYQM198fXcrV8lLr4p5G4PvKTcs3SXTxDaTe6HQfZ5ajL2OgWZvYDZKFJGZvu2CxzHjv1KD4xrNPvcVFKMB5BQ48e7qx6VbQoMcJbtIZMsG8rxdZbaUmo2/Eyf66YZufX3rjRfiJaJ6RJV9TlE4Jmc4Wjf9PNLtjDWtfR78tFihHWki22rkyOrXwt7gdU0efjQvQZQLAMYWQN2ulYiAbnSHVbvUIj8jCyQ9p5U2IIE0209UFxBBwJuf04WbTIqGqyVf5ANEF9xA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a3d04-af51-4beb-4753-08df052da68b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:56:13.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLXEgR5fZaer8dZxGaIeT+vhoV1r3NYzgLLqUMNpTsYE5A0r7CfLC/8EC6KowQ43w0q6dwFMDC9j9M8xhT274pLFzAJJtfrADdpF3ZamUvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7551E6552
X-OriginatorOrg: intel.com

On Wed, Aug 26, 2026 at 09:45:05AM +0800, Richard Cheng wrote:
> poison_by_decoder() stops at the last committed decoder and records the
> handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
> starts after the highest DPA allocation instead. Allocation exist for
> uncommitted decoders too, so their DPA is skipped by both phases and
> poison there is never reported. Resume the scan at ctx->offset, and scan
> later partitions in full, restoring the pre-rewrite behavior.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

FWIW This written but never used offset field popped up while reviewing
the zero size decoder set. (It's all coming together now ;))


> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1->v2:
>     - New added patch ( sashiko's report )
> ---
>  drivers/cxl/core/region.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ddf12075b95c..b7dc5d4988da 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	const struct resource *res;
> -	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc = 0;
>  
> @@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  	 */
>  	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
>  		res = &cxlds->part[i].res;
> -		for (p = res->child, last = NULL; p; p = p->sibling)
> -			last = p;
> -		if (last)
> -			offset = last->end + 1;
> +		if (i == ctx->part)
> +			offset = ctx->offset;
>  		else
>  			offset = res->start;
>  		length = res->end - offset + 1;
> -- 
> 2.43.0
> 
