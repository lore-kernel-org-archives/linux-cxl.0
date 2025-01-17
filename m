Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B421A2391
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146882; cv=fail; b=Micmcj6AlFFsGzyVcXtZpUqnmR4B1bRMV7r6NITjcWSIKGEvmlzNuIPAtzFIDy+drHDYyaLT0pPacTuR3UUHP08dRqDQ5RaH6x8VzK7ADaIx+AMKesyKprSoKH/Bgf5j/gwHzbJHl/4P5X+CC0wJLU4m9L5/5D6GUmviIKv9ogQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146882; c=relaxed/simple;
	bh=loJquKGzac3FbpvTGfL+oDGwqfLxuWR+Pslpp10n1d0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dzGk2nIl1qziORAkgWqsngM/bnIxqSssoLR94+bf7By/2qwHAsuyvJ1rjM5Msd2CJIsYwnZi7ymSJxqW4R6Pr0aAGwrM8FKlS8wmsrvNASnTBfz1UgwyyUCRRwU0gVvBw/t0S9jqZj6MWBD8WT+2h6PWE2+cff0cGAYePposbUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBZr++y4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBZr++y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737146881; x=1768682881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=loJquKGzac3FbpvTGfL+oDGwqfLxuWR+Pslpp10n1d0=;
  b=HBZr++y4kY/NckmHJ7lIHDJ9mObhS3yXFfuIqv/PoB+GYluFBx9myZXK
   ucz4VtEq7vcvaMETmN2rySBQ6L4CBMWu125u6gJh7LtuD9Vb7lzqEeIkn
   x0yv0faWmC6MjsR4wxHumGXeKFR+c5u9ioh2WhH6Z3mM6bL426cv+ybLf
   pTGlsnm+mZvdePnO3q1XBoz7mVBKfVrhdbtipBLhSfLUuI0o0Fj5yFYFV
   vcUVGTJUYowqvcSSv9vtp+UJiF7wifrwie9CM4iie7XvrvNAYO+B7BZd1
   Yh1HLzTJAEnyCaSvSwwZDWWaYNk9k5f4FdYbee8yVB/X2W1v7BAfpVA1y
   A==;
X-CSE-ConnectionGUID: tPnhPq6kSnCmYEKhAUM/4Q==
X-CSE-MsgGUID: 3s6euBgaSu2ZtUFQ4KRABQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37751884"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37751884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:47:54 -0800
X-CSE-ConnectionGUID: ArpGel0OQVm3LlQJn2tVnQ==
X-CSE-MsgGUID: zPPkxMpgTwWEiGkrxUbbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109965566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 12:47:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 12:47:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 12:47:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 12:47:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwK+ph3ag3WTVdaSPwBuMR9n8U0XCZneTvEiTsdWnhN1V7qm1g/Mk9qApD3DZTcVzuYG1P/ly9QH76xomH5TBK8JoGYbDkm5syiowsKtX1LHMXzsgDqwtKGypcpYQdLdUU6/CrQof0xCQffKCOmk+YSC/jF+mDXsLJTaD1LkT2kfNb/N76NPAWYYU5bN2djCXxaPH88S8HAgNBY3wEhb+ZeDoNKeqMpjZ5cYE+FgVgind5njWW6M7rKhS0MLBFvVPMNeWXZhQ9+iUHDJyHFzqpaQ9Uc6fn67h+SHDAScEEVtj8YOFi8ztjxoUrhtgIzd374ZhaGI99GGVa+SbvcW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1ibJnmW8w8Nv5L1UCsGvcDnVl++CxKwhPVymCafCqg=;
 b=OYXKxaHUEUaX9mjJ190EJn/+GBGTIe/xbhW9/r+UGX7qfvldJEComHOknBIDVdzlJAFFjGwKuISA4OWVWxsLz+9DsYNz5QiSppqMsNSHmgfLRY/RbebJhNgYmmk0H8WV0uN5/zlBhzCPvCYYVtpw/jtagw9TUWj0GDfz+igdKZU+3Ek6RYXbAexrbeb1+dOhcW34XmXNzy0RCHlJwjfBCuxf/MkW/iFg+weSPMwmXSK80M+5qYKtx9VXbOPJwk0jkXhiR97f160n8M0ZliYSTj+9LXVGQUR9C2GCVQn0hzIRHCxPXjhVrCaKhRuMjup7aEGLmPgZLeXSi/FG70Kavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 20:47:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 20:47:37 +0000
Date: Fri, 17 Jan 2025 12:47:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <678ac1e76b4b5_20f329484@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
 <3462ff60-b153-36f0-2f49-f2e3fa118be3@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3462ff60-b153-36f0-2f49-f2e3fa118be3@amd.com>
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 02041abf-b278-4b32-1e77-08dd37382d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SRc1Ig7oZJDN9U0DZNcZ2Zy4C9IN+hjZgsByc0vaWlXp0tMXe9InmrjidRym?=
 =?us-ascii?Q?FnqS9tXjWuY98+jw/ubXShghujED0HQkiKthRCwyLvxdnUxEpSXbd4W4Sndz?=
 =?us-ascii?Q?7zUbeOZglYkbq0ioD1R2/AGfi1bxlNpqAvwEgDFdOjVEfErIcyhP0V5c+Xxe?=
 =?us-ascii?Q?EOQbmSNC/TJfVbc7JawFY8NQiIIIp420ChsglgaBi+MSJfu20XEfmhlItCKZ?=
 =?us-ascii?Q?Mknu5xtiZ/jUVJ73R0vGFbviEKy0ZyjyzLFg7WwWmHc1uZNyj5TIPTRLS7DP?=
 =?us-ascii?Q?25JB2YnNiSHIAG92mfHnGH54sI+m/wR5O975lVn3YUzrRWRTgFHBX2BefeI4?=
 =?us-ascii?Q?bL80HWUQ02KcKLLj4yhAOk+K769edgaYfo1vGE+lCwrm/2Cx8rGi7GY2QtX9?=
 =?us-ascii?Q?kIGJHM69K8nTjlu850ZTA4TOxclwXFg9/NRbKXUFQk+ZzjHkLBtadekdVdhU?=
 =?us-ascii?Q?RwgIFz5/ynjZD1OijZOqp+fTFhtiKec5CT7V+IPmXiYaGnPUYrmXkpuUEx4J?=
 =?us-ascii?Q?HWXf4B59fefA8Xose+Vxqtpb3JFtoOnoxnOIJFGB4fPQbvVYqFA4tHqp5JtI?=
 =?us-ascii?Q?dAL6CmXS4cUcjAQVnzGdpEUwkCZE+e8vAPsRCL4NFlZnOVPaVuG8uppNoMA/?=
 =?us-ascii?Q?zROGdGqZYPVlvkKovATrL96lDZwYz+o/0Sm/3RdW+qpLHIHiAKrbl5X7Yxer?=
 =?us-ascii?Q?aiLV67PnLAQXGKTu1qrvFPc+5V+hxzHYTLCORAh04OkFewrKx7U8G4xH9K0A?=
 =?us-ascii?Q?Nb0QRD3OCsqzW29AUnfJSllzXxYllDKSLmt5/QVSWES7YGe3QWSj6fM/vKMq?=
 =?us-ascii?Q?URzO7SHVq+fOOUE82c17iR8PCIOrUewo0hhriGM5lCu2NtPmcHUg/VYDO7vr?=
 =?us-ascii?Q?iDAqZOgz919hh822Q0i3vq+BipUkzEJsd+/LBiipROloGN43l7yvs/Gn/6qc?=
 =?us-ascii?Q?zxYvYEjrzC/5Poexgu8OHN+UTdRqS6+Qyf3MQN2zOK0CWu9gkOYrqfFnLqZI?=
 =?us-ascii?Q?ie1GlAqMsf5blml7ijH5gAjja1l+KgYkTHTAp/tj/Yee4EL/WLPNzUpyzK6X?=
 =?us-ascii?Q?wAfBY3oGtBP+9JKtu0ISzb43ZUMfzaDgtpXQ115cgB9ne6SYsVxl2N4G51AQ?=
 =?us-ascii?Q?dPrazDp8uyfTG6DY7rLAZPgcWKMYq8og8LTQG5nS61O934zOwle3tibqBqgV?=
 =?us-ascii?Q?FMLDTCGJwCJaWUtQ0l4PaRU2sLM/SslRF9ox9VwQdXs3r9o7e2knicWKZNt4?=
 =?us-ascii?Q?cIeXALdCFucqw6PUNP6uVtWWxI24qoltQGoMsOq3l4mXQfrWYhRnNRDIAyPB?=
 =?us-ascii?Q?uFx8CqduWoP3C27hI4qY5mh7Hz+pfj1Z2YL81JmZ+59PNFXQVtkM5KzWs+fF?=
 =?us-ascii?Q?I+ePdcDQ/bg30eg9FYsdcyYkDb8i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79f1RdfPcm+3uB2GSNGukhsHUa5O3QsuXkZduNYCBQ2f7kk0JFGrTV7J2Hx9?=
 =?us-ascii?Q?yyu/ML0f3eORCIObDhKt7IPTs1QYV6KzWRRc2x/3Ej9xXEhneMsyu34y2AnZ?=
 =?us-ascii?Q?5rmPEn3Yadm20UgWb2yFQ+rfeZXoEvARUmFxVYrs12GkNx5Rs8+Lp7ZJLUO2?=
 =?us-ascii?Q?199PBW2MljSlKPP89MZg/oPHnH1REmO/64mOafcABA62+6rTolj7XrvqC+Un?=
 =?us-ascii?Q?FB6Hp08p4CLaUJfa9GaCyn/Z+0RT6XhspOeyFFAFoLPQdNln4CIcQhyssy/i?=
 =?us-ascii?Q?MEj7FC0JzwGCwZ2j0A0+g1RBjLj9Syt1exuV7QurXgaOUTCqnLHwvKT8FaxK?=
 =?us-ascii?Q?TneDd8SyTHPEeEAt4Zg84YkqnTxTTqoxuHjdoae9TAWMXCUA9CR/aZZYh+SC?=
 =?us-ascii?Q?Mfsr2rFfAEA1JLiEKnM4P1k2D/tXxt7Ds6nti/AtFZVDRA8QAuagAP8Ys3Hr?=
 =?us-ascii?Q?I9ZtwRFWQaZeJCCx2yR+x3C7E9lHWuV6wR7kEQVxNnzlVSIIVT3+gPTXdLXP?=
 =?us-ascii?Q?hyTt2AaWcgf7rROARflcoqzhxPNPfUOXtLI2b2u1S4wqjNBcXtJTcuAFErjZ?=
 =?us-ascii?Q?rpHZdXHPiU7CFjM8znStB3KI6yBRhgdsRq1g02NszrASdQHGS7GwPagPEWrP?=
 =?us-ascii?Q?o/oCQErFvzO2WifjqS7ZoZnDUCUvttoI8X9wM5TzDYlJCJsXpbl5tM4Z3kLp?=
 =?us-ascii?Q?Ok0k660FBSvkl7+UIg/RnS6LwSw1m95mBR3lIEyifut4+sBowE2p7yk4pDy8?=
 =?us-ascii?Q?uiVggaB2VGiPmccRdxz6cu39xOWWwLCFisqM8KwRAWqc89MoJD72ySPdLSEm?=
 =?us-ascii?Q?W+6hscR8Kml9jZ94TIlZP5euqT74H74aUTVQMwEi+rDmBLRudYFAWQtBjXvs?=
 =?us-ascii?Q?BMrHo3bubGdRHtQaWjqAl9trWLu8p8yxvBYVXY+DAsQwbVwJa12+uuktwAsT?=
 =?us-ascii?Q?zBijfbvlM+UevkOUUvl4jcQLVAly0LtsQWkxU3qqvrC0fhxJkgxZAiqtZqxo?=
 =?us-ascii?Q?as1GicITTKLG1uq7emH17WwhltN4qFOtMUPX+Jsm1qqxj/e6SmqzZIcsgrc8?=
 =?us-ascii?Q?i910oH0N72L5gIYRPI9ff1Gje0bnt5qkO/OEgK+I9PxhgfmqToXPRjBaVF+6?=
 =?us-ascii?Q?8VJ2dgkoAfAuiT/dyX/N6hutxRUrkggkhbfHpsTEyJG+XrA51ZxidAUnbdTi?=
 =?us-ascii?Q?1G20iqG2qPiX1bqb9XfWIugB1/Jtka7HR8RBLI/cdO/JulWKkAOLVmiJWhn7?=
 =?us-ascii?Q?ufI0iB4J/7EfMhWNhhPpMDBttjz5cOeLt8NsTL0ZsaQYmAOfjrqyREkaReD6?=
 =?us-ascii?Q?9akDh+J1EaEmjNp9vnD1sAIHg9D6SgTw8egVEaS5Yxo3kAvI4rTQ3TeV6jbH?=
 =?us-ascii?Q?x++miQvLlupgrv25MRqwwNGR6W2PxVk8b+CuQ0Hlu/cO2joxg0Gt8H/5KGtX?=
 =?us-ascii?Q?hojilo7PExY3JSg+IKzTtIcc++97h9QX2EzYjfmRTE2YgH6MpLNd6aec//hn?=
 =?us-ascii?Q?9lvLGYawY2usPF7kx3pLCwrTSUscKA95xCH5fjqmncLPQT9NloCR24QgbrYF?=
 =?us-ascii?Q?DDbZ5uQRbPnLbqW8chhFG5Ugatgid1GTOQKXJTo6vPL5MVbmUxyS3UANbNTw?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02041abf-b278-4b32-1e77-08dd37382d5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 20:47:37.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcWeDi2xfneNBoM1oQQDvkmCNl0TAfHGjHx6vpxBnydgnL/tsao7neKzSpr1h7WhGttqRO0BGc9EHt9qhmMMaqnmQXGnnNTsbrwft0iOWLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/17/25 06:10, Dan Williams wrote:
> > In preparation for consolidating all DPA partition information into an
> > array of DPA metadata, introduce helpers that hide the layout of the
> > current data. I.e. make the eventual replacement of ->ram_res,
> > ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> > no-op for code paths that consume that information, and reduce the noise
> > of follow-on patches.
> >
> > The end goal is to consolidate all DPA information in 'struct
> > cxl_dev_state', but for now the helpers just make it appear that all DPA
> > metadata is relative to @cxlds.
> >
> > Note that a follow-on patch also cleans up the temporary placeholders of
> > @ram_res, and @pmem_res in the qos_class manipulation code,
> > cxl_dpa_alloc(), and cxl_mem_create_range_info().
> >
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 2a25d1957ddb..78e92e24d7b5 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
[..]
> > @@ -438,13 +438,41 @@ struct cxl_dev_state {
> >   	bool rcd;
> >   	bool media_ready;
> >   	struct resource dpa_res;
> > -	struct resource pmem_res;
> > -	struct resource ram_res;
> > +	struct resource _pmem_res;
> > +	struct resource _ram_res;
> 
> 
> I think this is unnecessary since it is clear those fields are going 
> away later on, and this change only adds confusion. Moreover, they are 
> not referenced in the code now because the helpers.

That is part of demonstrating a safe conversion. You can read this
change to know that every possible usage of the old name is gone and
that is verified by the compiler.

Otherwise the reviewer needs to spend effort to grep to see if all the
old usages are indeed gone.

> > +static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> > +{
> > +	const struct resource *res = to_ram_res(cxlds);
> > +
> > +	if (!res)
> > +		return 0;
> 
> 
> This check is not needed now, and with the change in next patch, I think 
> it should not be needed either.
> 
> Do we need the distinction between, no ram or no pmem, and ram/pmem with 
> size 0?

This was also Jonathan's feedback. In v2 I am removing the distinction
that PMEM is always index-1 in the cxl_dpa_partition array.
