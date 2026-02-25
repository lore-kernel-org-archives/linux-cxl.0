Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6B338904
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063587; cv=fail; b=Z/BY31vGhRJzJcTpyStwSOa90/BsEFtfYhrxbjw0N4fsiYtBvpB3yVojEFWDWhMmyEAfFRoj3Vdwj9clvflgotoX9gE19D6djoBBcdCzV739mzr2DKQ60uP4hrh9S+CFX2zK2cXxZj6oKJBOp26kfmR9Dr630qUnBuckpB0N+vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063587; c=relaxed/simple;
	bh=hzaeGjpCvA7pm6FiiwLri/foKo3IMjVlPh0Ogq1M86I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOHLRCBvInbtRy7MrgpcVUROYcwMibnJSpH/g9LDEYcPP2EEo3mJJGGeX2A1XYnM929QZtrTJGsVA+91nNvFnMxtQiaE8wyhg0h217qMAdXxhAqwuIpuqSs2PrGTjUcg/irqZ3WUIeif9Hqg1MfwV6W5A6C1SPt51ZOu8UcLIbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPidxrsI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPidxrsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772063586; x=1803599586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hzaeGjpCvA7pm6FiiwLri/foKo3IMjVlPh0Ogq1M86I=;
  b=HPidxrsIw8mahdnhRmavRPHGo3LXQn6mkPaQHJM8JXqLA6JNoRqUnGQ5
   0VOhyFyiIdsVHj6ooI8UiOk7jGhU9kfn7ypwUxKUpP8EvzFn9D1M3u/ZU
   m+ME2C5iXxrXaHzg30NBeQ5cyJojN2X+5w7h84hFWGH7KvnFfwUGTFmX1
   /NiBn8ZbVFBgg+SC8Ck/EjnkpWK0hrGfMkyurT9gXGgL6V0pK3+iM+379
   awaxNiaYEJwBVLQoZMvDeZ7/Pe3myEGCROKtOL/eDi5dLuMdPf69m/KGM
   FcQQSbmefqiVDM/wZ2TcH9h3NS0PzrWde7ASk/dZzG9VfGC80SJzQRx6e
   w==;
X-CSE-ConnectionGUID: TupAFzo4QKOo9Ffce7hDiQ==
X-CSE-MsgGUID: kq7B0mIQQy67GrVInxLROw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84474053"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="84474053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:53:06 -0800
X-CSE-ConnectionGUID: fqMEWje2QGKDm+XFPTl9KQ==
X-CSE-MsgGUID: 3L1lCdk3QFa9aH2mb3jZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="244066053"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:53:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:53:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 15:53:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7kARq3aLQNAIewbhxykzjxLtxiobEB/tLVb+5KY1GUC6gtla9f5lMsGT2clJcLEaMetYFWOlZR5mEc8as+KZ/lpg82yQ392NgQkDdM6eKJRhvBaotUJ7hr15s8RjaSSTx+yWCEhE7vDg6n1N7gCfqwHlppO9gGPjKutR8gkCg2ZDdlkSNMJw47ycYsiLvpuSKo4ldxI5IPm0OegmtA3NBiHX1rb54r26RaOvOIh64wVi7xq4XNyxH3lWrVooEZbC+p5t78rck+6nz6OH/9gBc7AY2fbj2570rzwfSS4zggzUUaXNRoQNg1u+zhVdVSNjFoTfvzrcIm/kszVlmVljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzVmObeOGPuAz6dPZy5feE9O+An5leYz46TmkYRQV0s=;
 b=yVDAHRs+xjGVD3eTd5dLnb4B7aciBqERo4Lq966MOr36bjnHON6qj9/ZnL7rV75IFGUnYH7xcUS9vIhwfwZRqMSJMFaiuy0TJTnnWZrHRWj3jaP1rcK56Ux8yosLqB7oy7Z21whnFdjuXebP4Pa57y/TqFV4IEI2EUzwQhOX16/aSHemsrqUTcwelZpsr3Ra4g99/7R6Dw2vii/PmIVQc30cXH7P/oMwNsSJGoGxQ74tLnv5B61kpLopDfuAWg362gWANng/lFcbHuE9YfQkCD61pxdP6hB8MrS+UpOSsl26ACKTmuzp162dwpzrt9xEiGPaR7Z+UqhXcDkZvaEruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 23:53:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 23:53:03 +0000
Date: Wed, 25 Feb 2026 15:52:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v2 3/3] cxl/region: Factor out interleave granularity
 setup
Message-ID: <aZ-LW54Q32xED1oi@aschofie-mobl2.lan>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
 <20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e04103c-e48c-4052-6ad8-08de74c9037c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: p0ghzonYYlkH0zEoUR9x+KduxqmPC0I7+P9cN1oEeQvtTt/o5xIRNMKGARgTYEcn2tbpZRbEiiO29om60I9aBbRRKQVjgfAZKMyDJ833mmu8gIGjRvnXhFJYhhw7aaQp95cItaBxsL5Xwk0CihcTROiTIDi3BJ0yTuudqjoGgNwrHdFDNSaNw0jfc1AFjsvAvOT0ikzVuVAs08o2iJM60iPhxgwi+zz7TKVHTADncDUQGs5qzr4pstudvX7osf23XuEdSKnpm6+9WVHCrgTp3JegpYtlcdZkFInBpLjhbEyAvbkZck57P8N32r3Vpbt7J05ZBezwLnM4tXWcmaXIzJd0u6XAVc81kd2BMsDi/gDZJVAsu9Q8RbyjSd65/qTczR/IkIHiztIORmvB/SWhuIKoEVG5TccsK+7E4Pa14JdEFHqkb0RqBYX0mKynKtnSjcVz/EyEQd9K1gebszXLvT/zE5yUjERnS1zieAILQpBaUM+otSfOGDlqg8GGAggAcEpjlvxwihFJQzD3ZZ5ay/z2hoIIt7Wu/zVb/KUHZCOVHiwzFiY+c+n8VA6QHs+Itmkq66ijvITZuyaDHu87Ofrlai2loHtAVjcR9/Vi98oGE24sLn8Cg8PBzzTEG9oV0PD1T+DxtpB3dSkJVbt8zxlk+nBXlU9dxNQ/a7v1kNEWgzxBmTd2+tefDbFH8JBCRy8u3bBsu+f121MBP9TEWxiZrJXsqZYoqlNE4A+WmXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CAs5u0EIyfza0v+RIxO8O1/ePdBO2bfr2fuzaSeo+EwgsTxv1zUlZyn1kOFo?=
 =?us-ascii?Q?2NL/kU8+1llgSlOMlQI0vRz39qy8QQoqSN/8LP963XfMkCdm4mRqy9Q26jir?=
 =?us-ascii?Q?9fUXF/b5wOU4DwfitUG4M4V/Gpyw8gmxM8G6EConyOZyWYS8o4+x9xpe3APm?=
 =?us-ascii?Q?Op15ahTDxI50aEyqoxrxCKd6VOo/OBVqf8DTZtUCfwe0CMuRr6s1lzNi5IMF?=
 =?us-ascii?Q?7RA71W59Anx/3lt4rHEPnWAuKm9qXj7HGU055yTjjm+f/80mMHtwUS0MMqN7?=
 =?us-ascii?Q?R8fyth9QbtPXs7Q6b3wpEADxa3MYuRTFvOsEWtRqx/CdPYNl9BEc0B7GZdiZ?=
 =?us-ascii?Q?l9/J1gge6o6Ub7I6hmAf5TcPPt5EnGhR0Tc5dhjUy841LSf5k+Y8tWfVRMNN?=
 =?us-ascii?Q?pGr4/LC6pD+/QwqL7OWJxroaiTC7X9+OhYpBWyYHnfs/zoljtrc+zJxaAFOK?=
 =?us-ascii?Q?VEqlIfwNwkSaksJzo5HY4OMNAnynmS25Foqe3rCdIigrVxrZ3rILRpYjtt7h?=
 =?us-ascii?Q?nlyDsRituXbqco6zYv4WtGmYZKTCjCpCeIw7YwyjQ2KxRNSZzKQHD31o0mwS?=
 =?us-ascii?Q?m+MFiIAZyIm5+wDbssOlSq4YDYjuLpIms2FLUKubQXs4OclvjxpxXcn4z8dl?=
 =?us-ascii?Q?8GlaXEp1ZkrjU4OR42zHyRq1CNQC64CJKVo38m9Nh/i8l0SdaSfMKmnAzi4L?=
 =?us-ascii?Q?cA9VpkfdalVg6HVj2pjTOtrTE1XnUX9XIDRjciBi7Fwz96x/74ibOvgHIDcc?=
 =?us-ascii?Q?5iVmEgWU9SchHxF3VRcKDNbYHH4cbPuzBb4d9LGRsCvXL8MuVEzGghjl65el?=
 =?us-ascii?Q?iRAbfeUvpY4Z8PRr+0z9KSEsgbtQldgrUOeGVSgOJbEv+oJ2/tFOXvI3HoMo?=
 =?us-ascii?Q?f891xj2fQyqzXHJSuH2qWgkvL9zz0UOjU+dOfAXlMKIMTF9zxMB9ZIphvlBy?=
 =?us-ascii?Q?nzqwUDmqh1BKNCrr+iHjsezslk5mmnlRoZTcU7Inh9DbTO12+/nrxwI8sfbp?=
 =?us-ascii?Q?Uv4C7sWWFGyY2ReN6cChQu3+8pkg9sFdK/SfNpcD8ssxjDy9nV/qUBAtwlbS?=
 =?us-ascii?Q?wUhh5wV/PY7IQ538Vf3RHbOL38rxJuMKu2x2poOjTAweIKNFBW3YI9UadPxF?=
 =?us-ascii?Q?jUVcclfoSLfZWjgX9XFTlpPq0cRbyZKzjSC97i/qLZ9XqIKOkccwCRLIlLqV?=
 =?us-ascii?Q?fQaoAWy3imF6X2oksItWkRUrwMQAjMoOKoW3QzodSArBI6M2UYPre3p6SrXS?=
 =?us-ascii?Q?xTA7Gzk4ZaX+TxL5qSQ0Ag0aAE+IhHG+fvjylXeoue9ycJnvsGBB96NpzaIu?=
 =?us-ascii?Q?35g6hv813nFrRWnpdvIT8TziG6KmrOKxXH27manpniCkcO95JGn+JGzeBHdB?=
 =?us-ascii?Q?+e13kfrw15wrQ20AJX+EuS+fxdH5pFB2HMFa1A/Vb16RbaasG4ke6V0FRa5F?=
 =?us-ascii?Q?/ED/CPddMupGQjTSY3awQZn+AykB/SbM2KH91r3IEK0GZ8tad+u4Z1EgC3Cw?=
 =?us-ascii?Q?q+Ls/woV64EOofJIOeP32nGjX7Z8JAw8NI9FxgBTuMsvZ3b/ze5IMygO70a2?=
 =?us-ascii?Q?dOFyUbuX7Wo70lvPiMi3CZEmHRoksXAPnEOMRqesxi0yBdBB7OtL61Co8guZ?=
 =?us-ascii?Q?lWWLjcEy8LdOUXYk8q6b/rAd0K38TJ/lF1oi8iufvQii7C9iaAJIkV7HRvJd?=
 =?us-ascii?Q?MvGbeeNUngFfMtdG61616JnCJBze3Z0/vfko9lrG5/hpjH9d+1tPK6HRUauB?=
 =?us-ascii?Q?r6KEI+kligXOk/Q2j/iziSESJPEku2Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e04103c-e48c-4052-6ad8-08de74c9037c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 23:53:03.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CuQ3t5cAQjGypfa38ncmLu+BdnJM/vf7z7uXUt0ltxK/zJfbzgOuZNjEG4d0HQax5uA8jk5W27dKohLxuePeyY6okypSHgBGy/Z4F6eDPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
X-OriginatorOrg: intel.com

On Wed, Feb 25, 2026 at 12:22:23PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices can be triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave
> granularity.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

