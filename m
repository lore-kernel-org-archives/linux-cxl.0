Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3333EC
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948601; cv=fail; b=r5fpa3Wbj70NlnxSsZ9g0lMKKezwuThxNXrmBhq7dwbgGhuPL4r4uS/O9nE/FyNvPMuHlCOT5bGh1w1UKVEDI5XGqiCGZPR+oHDfy/JudPc+bwtU4QU0Y1Hu34lgLCzPilXkCrvESplxPv7RXFjWHScAS1RiXwUS8lpatA2AT2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948601; c=relaxed/simple;
	bh=zLx3TtG/gSkt7Z6K9nXHY3PVzdseFmNTNH8O4MOnwvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myBNZaIeuyjmF8gg/JeYPU0XgwkTXj29zbkQ6vRTpGmxDTYEd289mTAj7rW3VQPE+KJUAK48R4p0feaQgdzu9mYi90sTwF7Sg1FFhIl7DEwFYmCwXbB620RZsgq8GOxueCyyWFdssAj5lgfYoN/FpCLrnCny8QjTCqGmnOcO1kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSRZJ8E+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSRZJ8E+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738948600; x=1770484600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zLx3TtG/gSkt7Z6K9nXHY3PVzdseFmNTNH8O4MOnwvY=;
  b=NSRZJ8E+NVj4DDFGTa38iyFvXTn0TimayW2CC12AO8HKzjBcIoGPAYB7
   CAdf61kDcMWNEKTUvxsi6SqTorX8G5nFrRbo13vkOUauARs6hivDV3Fro
   fhle1Eh+34kSjsTbPfYWDFN0INejwJUubZbT28IKi5wmVV4WHreXuq5vS
   xfBuKbp0DAeAWAR3YcjMALwoVOsPbaF2RRkQtE8vnml9xURw+bDhAkx3v
   Y5QEVUOu/krEPdwOGadxCNKz8YuSy8iEaup0WadVc6/ZCnxjmNVuZA3RR
   FtkUDLZoMU9snmGFg2G4l2O9cMN1GQLjkBD9lbQFujwg9lj5looVOzRbb
   w==;
X-CSE-ConnectionGUID: HebPI7lxQ8yC6MdihV1PRg==
X-CSE-MsgGUID: 4O8PGohLTmur8SwNF+na6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50985329"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50985329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 09:16:38 -0800
X-CSE-ConnectionGUID: ksfyn+pNQdi9wAWHxovU7w==
X-CSE-MsgGUID: iscytXyuTpSgkRrX52A5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="112206263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 09:16:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 09:16:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 09:16:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 09:16:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmxrkU3n+Ix8uqwyVqlcRLqPteZsNVMhAfc92R3bP6HL7pjh1hygD/IfrjMOodCm46/PCunlOnFdiC1YBOll+dsAYhy9SioVI/pnvalbjynDCjgK3kmUzc3XUJIAIlGTDWQ2xb2Kwf//QdYRZir5Q+sE6/2xD0gNAXJWmr941PWb9X73uIplqMrJNPSHXc7ZzE2jNu+qnPqnSo8kkGYr/Vuj6Grh1tw+w8+yxW9cqBVfU7B85hu+UsqfJUrywm6ozYl7Rmb7JM1D0w0Nf0poyzJG0b6k2Lyp9yx6LORZEinh1fNQnPPoloGkykCswLGhwQ5oniIq5A47Vt48tjKW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBPsJU/6KpwdG4wkIW1YLfjLNWXfMawsm7MRnxF5/LQ=;
 b=gEMyRd206bMKhQKgwJCzuEq6ZG49m0NrmFgtRwUVLRTfeASSEGyD85d6Fta3Us544A98VG1pGxte1i6QnesxNHMeyl+lpCzwmN8TRxSZwBzJCprYh6/JSq59Rr6RdRdgEgU1EcUQOBj3fpRZWglePWkw0aofNfOudSOReozFzf0kqyxwZWqsxzqmzMI87Ib1e3zelpblloOAIoMcWrSqQ/oaaqFWLi5BLpwabvT1xVnO85LGp6BcXT5bkN96xeiZ3ZjIYYiEheaQVf0eTJ1VJpagptVodn4v6js6Zlx5ILIeuN/glyvjdZw5hVLQi6ywN/lhRqw4d25QwONiB+23Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8578.namprd11.prod.outlook.com (2603:10b6:408:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 17:16:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Fri, 7 Feb 2025
 17:16:04 +0000
Date: Fri, 7 Feb 2025 11:15:55 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
Message-ID: <67a63fcb6350_32b9f22943c@iweiny-mobl.notmuch>
References: <20250207090327.172478-1-smadhavan@nvidia.com>
 <20250207090327.172478-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207090327.172478-2-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c07fb96-4434-46fc-c0d9-08dd479b1a37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H17YJpCT0Wrh7pA79CAk+y/JxzTGOovS/54J16ybMVhi/OHj16ZNVvPPvTQN?=
 =?us-ascii?Q?QK06zI75SXFDvapuH08TYv1iV3ItKeZ2vQJBj/6OTFI1GOmkPoG6gv9F69Ft?=
 =?us-ascii?Q?rfJrlkACTqfkcAnhaydOWyDNfcgw9MtdbKB/9Lhm1h3vwQn5vZ/NFOTIWiDl?=
 =?us-ascii?Q?XIcZR2WkeQcdLTJxoQ7RjVWhpSyFxw5SSttyAY6uJJ3f9QcyAm7QFQNalxgt?=
 =?us-ascii?Q?DZhSIOt4TMAtXlrbBTXtng8BgQmcN3vylqXjKkW71Jq9AAS++XsnWvZDLNmv?=
 =?us-ascii?Q?PwiTT/wBRB8VONiTNicic+k5A0Ru5eIdbWiVQ7+o8IbI0eonXOzkpRF45WIw?=
 =?us-ascii?Q?k16rwLcsfT8x1cl9yGTQ9AFor8CbF9kgF4VMqhicIoOz028hJ3b478dGMPyQ?=
 =?us-ascii?Q?/+2y7l4MzEGu3w4SNsosp6u1Kj2laGpG+WQT00dKaPPNaEs5d/YiTSYYyt+Q?=
 =?us-ascii?Q?dPCOFfOhlQcLveNNNMwmZEGjTqNwzZP44KnXydT64rl977rlSOEqp9UCJ3Yp?=
 =?us-ascii?Q?urdfqcldvpkGEnl+6aczvBa4KRpp403K5WRhxZVSw79AQZ5OROL4gKU5oMFj?=
 =?us-ascii?Q?8+l2CIM55+kCAk0pntjlXb+lp5LDmiS475wLD+MQYqkesLVZcIKfOtFKyMi1?=
 =?us-ascii?Q?NealfM0orUHJV51gpV7aMYJghisiBQ5iSVaEo4qtSMRW6yjaEU2i+W3Xempl?=
 =?us-ascii?Q?nypR2k0DJ7HVs23eU3rZ1fukWUi/2pKDL+KDjH6pKGNARqabYFIa7kkhUhz5?=
 =?us-ascii?Q?huABslNFEUFdRFEzQNngpeKYYFh5vx5qL2DAhsVMDY4VV8JbrxNvWcrea2CQ?=
 =?us-ascii?Q?1nq+NzbgaotRPwVmu52IFjUsZ+2i3raPTtG3tbAhlsVuScM9uTt0f/b/w7D4?=
 =?us-ascii?Q?NGpmGLXqZebezwyhjvhQXZt8sahtZcUP1Yrs4sdXWbLIq6KukKiLRs2BxgPT?=
 =?us-ascii?Q?G3ZH0a17h82akmh6hP1VZV7TRA0ZgpLMCBl+89RKeOiU7RMzkF0Y/Pu2zhfw?=
 =?us-ascii?Q?fT9mLb5XA8hYTcAOQSpmZ5V/lolBJn8IE0CHNv+mgF+WNTDBsvzTNS5Zk6Bs?=
 =?us-ascii?Q?l32IEcaO9ILrIa2zF26AsIp7mFQ2BsbUr5CidqZgSlFMfKM54q6DiNDVGAR6?=
 =?us-ascii?Q?xRdjEImA+djaCp9xuYk1gx457fmVlCAnWQFAuVf4WHK3WwyOPZCaiWXm3YT1?=
 =?us-ascii?Q?n/8HSO+5LEoShgHkWowd61mu0WJ6DGfYujgmNvy9pFP4yuJKMnQM7NRKO8zc?=
 =?us-ascii?Q?DzHbhG+6H6wFqg89UpCLYW1iGpiwKUd/XDAqsisOevsZiViq6+56B74ZnyYU?=
 =?us-ascii?Q?aK3XLgmxpsxkQo3rs5kEv3vjIe9lEc41awdpl5cI1KfENouSo2Tanr8N/Mau?=
 =?us-ascii?Q?mCbCfTlyeQuG2IawspqkrV7lgS27?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQvpfEntnAO173tDzI0meyQxMM6LZCJcX0zeD/0r/GlCV5a8YFPVFVE5gEKN?=
 =?us-ascii?Q?2I83Y5VXLY1wYy5KX8oqC+6xrLxs4a75Ud9heSaLX36q2sR/IVf9gqKxn6Os?=
 =?us-ascii?Q?B2H9qyXoUWOQNFMN58J8X5TTGExRAKC+V4S+bHJIaKPw25IHbd0Zuy8SBrC+?=
 =?us-ascii?Q?ZEpveAFEW74NfVJ5sfLTfeakaRwCTM0ltg2uqJRNroi8jJViWPX1vMeTFSpa?=
 =?us-ascii?Q?My9A5Dhvp8hDuXyMErD47ihr5YXlRJCJuRGhBhRPIZnJZDZdZZmNtVI6vI/e?=
 =?us-ascii?Q?D4eciXBcg3SRaW6C4vZc+ApYQr5vpHWlmhPh+7RU8e11K+BcRg5f56xG7G5a?=
 =?us-ascii?Q?L0jDlNLCInEQZTFPy1BJSamamLMwT9ENMedeKseNCyaHW051rwlc8E1v+msM?=
 =?us-ascii?Q?g/wtFbouQ8d8ZkZHlpQmm8XNCkUPFg4YArTPfjb5P3ijpU48g82ZanGCniIW?=
 =?us-ascii?Q?HwsvMFL3zrInGbHoYaiABONtSm/3WWgmOIwIwiA/ozosqUF+QoDBpMwo6Xcf?=
 =?us-ascii?Q?C1ubZB8sn12vHBpu/dpI4dK+mF5dpeGVQ8RieA7T9anDtszY3AfRCmA8ltbc?=
 =?us-ascii?Q?uDXFZB85ooo3EsRsHpWldw3VEw8uiYMXBr4Muji3eV5y/Nsy5dyxCqkgcekz?=
 =?us-ascii?Q?TtF60ITOyS2/pARjgOiDD2CWYHbmK84LaJedca2qyVDGYbBZVvnDCh/Hvs8C?=
 =?us-ascii?Q?nZPBY+zjd8Y4d449c8TIhX2Nsxcuda4xqs4nuxnKrC3YDGX8+vgWNo1crwSY?=
 =?us-ascii?Q?bkTAyxg8HsuzLDLbtz9vYiVKUkdVeYM+SI6weFb0g1R/SJZaqg3nA1dl9gKF?=
 =?us-ascii?Q?YUEe9RpN+bDPpdK6SY//Di1H+MVm7NuVGJ3raf6N89vhmDYZgoyoCcH0J7Rx?=
 =?us-ascii?Q?1T/MjazjX/nFCOjDNzGyNnpH1Te+yy7tEL9zJV1JEEX5zrpGyHbRnDdO3V9D?=
 =?us-ascii?Q?IMMapxdQOqo5oZvqyZ5hdHHZpU+DAymwfwuvMfRpR2jnyDhb3tiK23vVwHd1?=
 =?us-ascii?Q?yfolgurRTNvevqgnSdaiLqfoQXiHqxGG8yED6CwAxBvq+mjzRfTMXNNowvGk?=
 =?us-ascii?Q?Vd5wGUcb34qQVevIfz1EkRE9od38YWU2L4pcpK6o3d3cTIh9TR1nivIbEoCJ?=
 =?us-ascii?Q?rcnLMs3qr57DQEGFpp2QvK7wyOhAaY3W1nnXvh3dXUx3hi2mXhbfbpfOT6Xi?=
 =?us-ascii?Q?a4cuhvktZSuaoK/a82+RzcUEVZAkbHzGzB9PvvTd6x9ZQhYHJZGkjrM/K72i?=
 =?us-ascii?Q?a0QBzb/OrLOn0VFGMAxtdwCpX6n/RISe1kfP5+MM83Li5kcciZHMaXCn6zkH?=
 =?us-ascii?Q?xppgv2uQOHdSZSksH1oPv6DtUJvzGWhV0nxauy0dD0yq+5xdHohP1/+uVgiS?=
 =?us-ascii?Q?57JgLY1ffTMJBijTVSy9E9Y2tHZPNfFTjXcL9KCXWe/2YTamhrx+npEgfAEs?=
 =?us-ascii?Q?PY/HjShqF6lLoo/jIywkiAgTEQzlZTEnWJ6ZZ2FxcFWItOwvD7OvRIyBN9mO?=
 =?us-ascii?Q?SpZGPjVnHdrk+PdWA2TJzCta/SsIc+Lg9ZuxDUruaD3WO2+hdIUE97uu7kAQ?=
 =?us-ascii?Q?RC2csP0GNNtHWY4VxUlIeXuNrxE46BMFCfv16SJ9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c07fb96-4434-46fc-c0d9-08dd479b1a37
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:16:04.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 291tfPV/SDGgoojmXJKFqgYugendm8PM6VL522qTlWS8Or46HEI5KIiqcIh84wRzLnd/+lKQ/lDFYdr/vevs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8578
X-OriginatorOrg: intel.com

Srirangan Madhavan wrote:

Generally this looks good.  Some minor issues below.

> This change adds the support and implements the CXL reset
> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.
> 
> With support for Type 2 devices being introduced, more devices will
> require finer-grained reset mechanisms beyond bus-wide reset methods.
> 
> This change defines the necessary CXL DVSEC register macros.
> For devices that support CXL Reset, cache lines are disabled, WB+I is
> asserted, wait for cache invalid status, Mem Clr bit is asserted and
> finally reset is initiated.

This commit message should be in the imperative.  For example:

"Type 2 devices are being introduced and will require finer-grained
reset.

Add support for CXL reset per CXL v3.1 Section 9.6/9.7."

The rest of the details are given in the code itself.  BTW why not just
update to 3.2?

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  25 +++++
>  3 files changed, 209 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..cf6009f5bd6c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,12 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static u16 cxl_device_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_DEV);
> +}

NIT: probably not worth having a whole function but...

> +
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> @@ -5116,6 +5122,182 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return rc;
>  }
>  
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val, cap;
> +	int rc;
> +	u32 timeout_us = 100, timeout_tot_us = 10000;
> +
> +	/*
> +	 * Wait for any pending transactions.
> +	 * Assuming this does cxl.io stuff.
> +	 */

The comment here is generally not needed.  In particular the first
sentence is the same as the function name being called.

> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
> +
> +	/*
> +	 * Disable caching and then write back and invalidate lines.
> +	 */

I think this comment is wrong...

> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
> +		return 0;

Isn't this checking for a cache capable device?

> +
> +	/*
> +	 * Disable cache.
> +	 * WB and invalidate cahce if capability is advertised.
> +	 */

Then disabling and invalidating the cache here.

> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
> +
> +	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 * From Section 9.6: "Software may leverage the cache size reported in
> +	 * the DVSEC CXL Capability2 register to compute a suitable timeout
> +	 * value".
> +	 * Given there is no conversion factor for cache size -> timeout,
> +	 * setting timer for default 10ms.
> +	 */
> +	do {
> +		if (timeout_tot_us < 0)
> +			return -ETIMEDOUT;
> +		usleep_range(timeout_us, timeout_us+1);
> +		timeout_tot_us -= timeout_us;
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +	} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset_init - initiate a cxl reset
> + * @dev: device to reset

@dvsec?

> + *
> + * Initiate a cxl reset.
> + */

Given this is a static internal call it seems best to leave out the kdoc
altogether rather than add the dvsec parameter to the doc.

> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val;
> +	u32 timeout_ms;
> +	int rc;
> +	u32 reset_timeouts_ms[] = {10, 100, 1000, 10000, 100000};

NIT: Maybe...  give the spec reference for the timeout values.

> +
> +	/*
> +	 * Check if CXL Reset MEM CLR is supported.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				      val);
> +	}
> +
> +	/*
> +	 * Read timeout value
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];
> +
> +	/*
> +	 * Write reset config
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 *  Wait till timeout and then check reset status is complete.
> +	 */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
> +	    ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
> +		return -ETIMEDOUT;
> +
> +	/*
> +	 * Revert cashing disable.

NIT caching

Probably best to remove the comment.

> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = cxl_device_dvsec(dev);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/*
> +	 * Check if CXL Reset is supported.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = cxl_reset_prepare(dev, dvsec);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_reset_init(dev, dvsec);
> +}
> +
>  void pci_dev_lock(struct pci_dev *dev)
>  {
>  	/* block PM suspend, driver probe, etc. */
> @@ -5202,6 +5384,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ cxl_reset, .name = "cxl_reset" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..efcb06598f26 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..52618c5b095d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1209,6 +1209,31 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */

v3.2

Ira

[snip]
