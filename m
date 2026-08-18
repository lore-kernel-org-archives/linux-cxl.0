Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E57175A6C
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012788; cv=fail; b=KtByXQS4rvgytGxVSLjDExwRuxFtILlG9hQXf13ZqvEVLnkzTSWJ1c7zEywY58pD/7eQ/+ezSov02ogjnD6oeixc9or6KWq4j+e50u/JSVxGltM0DDmmXRd2YONvRhDTko4gZNWzQb7f5/lmImYsBY3FCTBq4TRPg8YadDf8Q7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012788; c=relaxed/simple;
	bh=WwU3zwYrSYxNb7hkLm1kbsADCOQ8bd1We0gV7D92Qps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T96D6m+en9K8VagtweCTWkCr42fdI10UXtJum9z6HRWAdvHLEpmYbGaWjJZmBp9fqyw+AZYIwv4kNcSKebEhc4Ra+m5I+w8JNBGT6PeE3sBCIkkq1vGJfQuItvUDH2njEL9hL5pLBbpITL89Sk8/aXBArmFQDuxX3O5axompW/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXj9fQ/l; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXj9fQ/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787012785; x=1818548785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WwU3zwYrSYxNb7hkLm1kbsADCOQ8bd1We0gV7D92Qps=;
  b=ZXj9fQ/lDXG++T8J7ejDG2YPGRzw2k7C0yhN8p+2RGZge1uyPWA584N4
   ku/C0mvQNB5SwNZOWH+jXwHpr/O4fKxX9m2BruiE+lI/SzMAnW3o0u9bZ
   VsXlsidXpqCa94K2RHY0z33q0rPKYyvsQmbSn3A2UVspkSq2DeSGPmhEQ
   aTdPyxYvMbPoJ+kzpL7UCqtklsA8OMqU7sJRMsuG3SKOm7ZhsyDH6TuJ3
   sb7TTVv/dR7LT81U3nvTobaFQV38UFeXs6lNOrw0yUQ/Wbn7UuLzRzjv7
   CJ2a8t5Y3vyB1vKy4z7prDA7C6EDCmxWst7h/WdGeyiB0+rPPkMZ3K7Zo
   w==;
X-CSE-ConnectionGUID: 72K+LVAZSW6JiYV06W+mJA==
X-CSE-MsgGUID: VHEWXb1zRP6ONoI1UofcIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86456378"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="86456378"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 17:26:25 -0700
X-CSE-ConnectionGUID: pljgnwiZTXWqY/Q4hCuYvg==
X-CSE-MsgGUID: vzYUzZYGQKyYgPmEAaJ8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="270283329"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 17:26:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 17:26:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 17:26:24 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 17:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kepXXVdNx1ttWSMYBEIIY6yoeHkTe5d48TzH624w1h52MDLwbM3biMfclUp71hxw+WTnipEJxvfs+eB7DhEqeWLlgwZObqGCwT6F87J5XkZy97+4m9octKZ7GqrG1kQDCvjtP7iNRvxlp3X0TmG+gRiAxS6AlX8vsvLohKTs+wiEsNURdKcvVjCUZQ6PtpqoXmcinnBWTopXSpVECIkDhPXVXWUFyFra4Xu6rdHBoP1GVgwN/9AyttRwXX2VmpSvWW+bRsyf9Tf1tpNoL5hZ6dFHspMry7AW/y2iiYcB2Tzq5OAyDdtMN9m6RZ02AwA1q/hMWKR3AQMWLxcI7i16Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYHg4czYxqnBLmKq+KceDMPFcgGlGGcSAE23u4owaok=;
 b=ESYzD3orZSt66MpFsScFBlhHwg1fZQGt3RqgQ3M9kp38m7fTg/5SpA2tGfe/UEmFOWqPtajH1UPXoVl+Q4Y1xUGO5ZhgZZzykqHs1bFygwoUeqpQO/b44rDqI2Y+81FQfXHf5aGi/OqbGJoZICkozKHdqAj5U744+k7b/HznZ2Q6dN1WSshLFonNHTYAjxEkrKft+nh7QiIDPa1s5eTh+E0bqJKDhupfqav3RN6xsHfi8fCuXqAZ6HCJG0GVzlERmT9T98xWTjP6/B+5PIH0peCX5MkLXFlPs6uP4vcrr19SZr/jNLqQSjIAsGb4ix7KP0LOm1ZoUM1icc9/b0wWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB8919.namprd11.prod.outlook.com (2603:10b6:208:576::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 00:26:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 00:26:19 +0000
Date: Mon, 17 Aug 2026 17:26:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <djbw@kernel.org>, <jic23@kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: Map mock device nodes to an online node
Message-ID: <aoOmo-DZudbSOV3N@aschofie-mobl2.lan>
References: <20260723180630.1302871-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723180630.1302871-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: b1292470-bfba-4726-0459-08defcbf52d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v/tdaNj54d0Hnk7Hnl7pwaF0EsLJGVLYVuk11xSI+BhR71Q9SA6DlAJHMHTboYYDFuo/iOjVFJsKRNxWoxKJ93/l+V2DbNIogcLyNH7UZtL9ijXbNbNYhdfbHEv1eBZvrBtISh4K0ziQNWyhqNVKzrEvEBV4M/SXMcJyJo8T8V1GVFOM0mHB04XPdyb02sJbRxQQujBIXmBqwlSVZwwzi48luU8MzyeZlAkIPPkK+qTz8lvbp2g41jG3DZ6HdgKcbYCnoNPiY051cFAOo1uyniiuJC8ekAczS6UZDnOcsn3iv6gZ0UsVgHEeuAiHRvsULzKYQ3eO2EYOdqOyB21SPW0xy9LVtj1xN3JnodYQ+eELVh8vXqNSJFp2JO4Y80Cp48h75pa+kOxN8YhHn27ZFqHHE3kW19IOypzNjIhwo4hdPeLfSpDjpdxn+uqTaSLeb0vAnKhFuxK2kTjfywpCsA6WbAERQc7lSyutSfmQKzzEK+jI0aeYtHMN/V6qBd8f2O7PGaKBwrTcsSMWmGpViK70AYsUGei5cACZZjutlZljCoL4+SA5MNUdiX18TqvM5VlqwWhTcPM8QjYYBBbDQUsqHrbSchjttqf14LlSKvKrscMamwmtHin08VMr3e/XCRbNUlExZCTee17SODCU3SHRhhrMhJzblT8GzqNlJ2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3v3jk3RTVAb6Qc5UfTOleWO0CyhrqU/e2yqT7yF9n03/s/XC6UFEo4/yVYKB?=
 =?us-ascii?Q?J4SY+hPVTpBagGxzp8n6QIDvSpcGa14aymdefloSnoe85pDZqGEDffsA/evm?=
 =?us-ascii?Q?AyavsmPcuoR/hCT/4Q+bo+V+dvoXNKivb0ZpHOLmBNisFdnNCPTMFn7bAS0+?=
 =?us-ascii?Q?EZ6Ip/gRrnXScr2zylEBs99X4n0wPoRGLkaASc0yMySSZOufYfqmyvwzZe1f?=
 =?us-ascii?Q?0yFo5UxbVQ/K/Lp5MTOvPhDgIroo+8KZwnInt1BreJeC3IXDz1Io+GcfwVTx?=
 =?us-ascii?Q?9Vr3oIZAaDHjD/MI2j/80E4JyPhe+OWSs4nh4f4LUl7Wv7ESEZpgKH3Vpg+X?=
 =?us-ascii?Q?ba9NQYIkNr+6FSPsEOwfv9l37NtES72xKbLVlw3v6znmUtzl6d8kxTZbVUX4?=
 =?us-ascii?Q?HOABYxyGZZDlVaEuaXZHaNNAvIUGdDTGREPUG9FRcmQm68dyL0/gipUUjBFT?=
 =?us-ascii?Q?XSSIG8+1XlI4QipLkri11YrKTzzTIBvonBw8yFeFKcAxYei2zgZWwZAzpQip?=
 =?us-ascii?Q?TBBoM/B0LyGILehc8ztoLEtMkd2r56xJxaM4r/sp0vpiRsKtJh6MDksmCV7+?=
 =?us-ascii?Q?4U6uaTdaNpN0HYQr2YMWdb9wGkT2XhWrFx9WDlhKTJotR0SzZTilXqz6yqzX?=
 =?us-ascii?Q?I3xBnPW7yLp178kSmSh2cY3PpMg5d5lRP+jNmytk4K+I4zMxlIkMV0C3jfP2?=
 =?us-ascii?Q?bzWsRxzpFQufJ2oFBdmBmzuCXYTLGVT5H3BmSvvK74OV0kUvJIpguVPkdM5/?=
 =?us-ascii?Q?iUL5Pyo6idBmIODCWq+95fZtEX4hce5tsNNRe5KRH3f9hMxzDnZ0tZBxIyZd?=
 =?us-ascii?Q?3u9tDTC06ZgqLtPPHkeJc/z+lBvfJlvVvi/2WzEUc766WCsc2G/+cNiAFzlb?=
 =?us-ascii?Q?HxTF+kTzDW7RfMKURd5kDW/YFW8J61IPoSPKRay81wSe0RHtezMhAD0CWxAU?=
 =?us-ascii?Q?I8JdcZ2c0PUJays7K0tIFw5CDsNeUm9pxeazUMfArquFaE8UtES9PNYztJ6Z?=
 =?us-ascii?Q?DA1M2yQc7yelyWqdGADKVfPyTnPF/5ptcBOsXKo3o+eU5MzDJ4Py2h36l9fK?=
 =?us-ascii?Q?Q+CBIHRKIaG82ttuGIOs7Fs3b+huXAKEEbaaaI9u/HbWLvDxeeY7oJJcfWE5?=
 =?us-ascii?Q?b1+pDoTrtcpWExrzOpp8l6j0QIc7TbafvPvH9UaCZUjvk+ki7g/3FPtfyqpI?=
 =?us-ascii?Q?yb6Flm6PeOTMp9DImbENr1Dw6xXo87Epyjzad3A4tWjrWOlj6h9BFv8g3dJx?=
 =?us-ascii?Q?+vs6Z1JgqdoK2FXd7jOCpSlD4b+KjZkC0dk9z/ABBlyi5rgGZS7bfdF4LceL?=
 =?us-ascii?Q?cgOU5I1Xyl0q/H6Wh+CgEsSfCwXPUwwRydeaCj4edXSdliHG9MXU/L//HPIH?=
 =?us-ascii?Q?ldx1G5tvpIHsJByKj/8NbsH2pRtbwPkn9my7U6RgUkTgZHB3BnVa92Od9r9z?=
 =?us-ascii?Q?jHUktkOalSjn9AT0YL4Fnly5K58pUlzZKtqNDOnJ/+Jb/ZVrHQ+WiddFpE4X?=
 =?us-ascii?Q?w+SgAkARqYQpN+cd4cGpvADweJImY25xNEqqTs3SGmbfZ7xlUSZdFXlZ7nLJ?=
 =?us-ascii?Q?+AaZO63ovgCWS3L4agSywukPM2pbUx9dJTThVjAUUTysiXXgJwji39lBWvxM?=
 =?us-ascii?Q?GydJXRZaZGwfXbl4CM6KRL1DvkKsVM7d92IFyYFmwAXXCIFfrEdpD2hjkAZE?=
 =?us-ascii?Q?3xydrVbS8mdRKyMnu1ztla15r9ymSfZ7fR91ivDKirsXLAdoHzILgFJI2+yT?=
 =?us-ascii?Q?lL7AvC5ZsWCWd/g6JfK+hqi+39kszZY=3D?=
X-Exchange-RoutingPolicyChecked: lK8uMovXbYm9wnqA8Xi7Lb5gEz9bvg+QHXdvPD+aHC7p35mqzQcKOrcgkWX4WuBu0o8VyMVIShbymsh42+TbcxFpO8nBK5A2k/OXoPMGW6FDdE9ZYU5cvqvBpLSd+w/fA0QNvtMh2NgmhGLDexA3lm4RX/kqWFwSdTUWnrMibPuj6oZGCP8cwFKarA0FoANLQsPSYkJ3GHL37MdFMBDk16OC5CoD9iVs2NLMqAd/lLAksiRKTU+fX0g8Mx9BWOMpuCx0oS35ZQLIS7kKFyvatlTyOCEaZIAdvKKEochrceTt4saWaluGeAOifCtG3tuhneftMgPIhc96gF39nu4YRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1292470-bfba-4726-0459-08defcbf52d8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 00:26:19.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8tOafHggcjzJaYUVW/IhuPmuyDhSghzoRmele/bEy6DagYd+K9eknlrLlZ6smEmduAbyM2s9eRzYyWPcRBndsvfFGLvxiy582adij9Ui94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8919
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 11:06:30AM -0700, Davidlohr Bueso wrote:
> cxl_mem_init() assigns alternating NUMA nodes to the mock memdevs
> to model multi-node topologies. On a single-node host node 1 has
> no pgdat, and the first node-aware allocation in an odd device's
> probe faults on a NULL zonelist:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc00000006e3
>   KASAN: probably user-memory-access in range [0x0000000000003718-0x000000000000371f]
>   Workqueue: async async_run_entry_fn
>   RIP: __alloc_frozen_pages_noprof+0x288
>    new_slab
>    ___slab_alloc
>    __kmalloc_node_track_caller_noprof
>    devm_kmalloc
>    cxl_mock_mem_probe
> 
> Map the requested node to an online one, as dax_hmem already does
> for its target node.
> 
> Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")
> Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
> Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Found while regression testing unrelated work.

Hi Davidlohr,

Thanks for fixing up cxl-test!
My short response is:
	Reviewed-by: Alison Schofield <alison.schofield@intel.com>
	Tested-by: Alison Schofield <alison.schofield@intel.com>

And the long version is, I tested this and it failed somewhere
else. I have CONFIG_PINCTRL=y so the first node aware allocation 
lands in the device core, not in cxl_mock_mem_probe(). Looks like:

BUG: unable to handle page fault for address: 0000000000002d18
    RIP: 0010:__alloc_frozen_pages_noprof+0x120/0x310
     allocate_slab
     new_slab
     __slab_alloc_node
     __kmalloc_node_track_caller_noprof
     devm_kmalloc
     pinctrl_bind_pins
     really_probe

We (me) had not seen this because our cxl_test guests always have two or more
CPU-and-memory nodes, plus memory-only and nvdimm nodes on top. Node 1 is
online, so numa_map_to_online_node() is a no-op.

It reproduces with a single -numa node holding the CPUs and all memory.
That is one proximity domain, node_possible_map == {0}, no pgdat for node 1.

These settings appear as different presets for folks using run_qemu [1].
The 'tiny' option must be selected to hit this.

I'm thinking about how to work 'tiny' into the regular regression runs.

Good find Davidlohr!


-- Alison

[1] https://github.com/pmem/run_qemu


> 
>  tools/testing/cxl/test/cxl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030..5156516a82d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1748,7 +1748,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_mem;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>  		if (rc)
> @@ -1763,7 +1763,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_single;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
>  		if (rc)
> @@ -1779,7 +1779,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_rcd;
>  		pdev->dev.parent = &rch->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
>  		if (rc)
> -- 
> 2.39.5
> 
