Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B1179A3;
	Fri, 12 Jun 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288178; cv=fail; b=rajxKGNugegMO3Q14aMcJTwQdxmyMaTO6iWG3k4CqMo4iz+aDptodQkd0veL22rY8B0ijne5Q6zj/XqXIQi9uF9iQxSCudPDSGzwTlP6gwIsOIUQuYOPxpV0mU6WXnybl77GQQMSJIOLX5UTAnltOnxoKXL9AFRTpy+tztwXiVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288178; c=relaxed/simple;
	bh=WDxGiMOCTo117oKna5R67Oh5HSJM5MnW/Ik4eMupQY8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGKFYdR5zz+AlEsY6fsFsbian8sj8MUBsgB3ntMbgr3JPO5Y6ZloNyqwvGpUczZ5ImvsQsM8hT8zPE37rBTiqjAocoz5xrXg0UfSA6b39bq8s85ng9Bm1/34PSMbEFKGNAh07tixYmHACJEiTg7L/KFhvxmhYtcT4OQGfNpbk3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OL9ZMQtg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OL9ZMQtg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781288176; x=1812824176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WDxGiMOCTo117oKna5R67Oh5HSJM5MnW/Ik4eMupQY8=;
  b=OL9ZMQtg6bJnsEVmhrGCATnXcYHQxpA9RxJINZaJ3Ru1fPhAiUAQRPHz
   jkg7iHqeNBIzu34M0nqNDLK3DS1egA3salAfc1xG0ZhuMvZxm5MmpaSh+
   l9QOLAiKkPPh5KpEAu5BpeNclPEqAbNPVmXWInFhuNuXXPAaLsF0kjJQG
   XhGMALGwxpkKdpBDcla7DBKvcOq7s8tj9ZD9wLQOfWBr8JXC023S1qSqL
   iI6U9CVXP73M4glOzJJX/hfk303qwcF7bbNWQYkgz9xWuSi/wxT98UsP7
   9ewPSS8duXWqP8t0GPU0sz+zpD0HGrvSh8DQ40Q6ilY1ZLhfhblla/76L
   g==;
X-CSE-ConnectionGUID: 6p1u9oz6Tbq3KNDrzdGwiA==
X-CSE-MsgGUID: RsVKjLNCQzqILyaioNhlyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="92689209"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="92689209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:16:15 -0700
X-CSE-ConnectionGUID: d0rxVRITT8mSapUvbu68MQ==
X-CSE-MsgGUID: XdWMYplCRfGG8dRx2fwQbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="246946937"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:16:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 11:16:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 11:16:08 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 11:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylmrc2LiB7oB0r3K+O3r48kmVJQq1HzG9pPuT1jEu/otUAeDfL+omY+p01k1d/KvxldUuBADODX0gPRtbHKuVazglVHknWx63fkq8jXaCpB2Y8oEqLHx54C4CmrhrQ3KnWhZPghBiAKsM8keImRoBu3JfmqOuKA65Mc7IbNGFnDJjuEVv2TMIzk0KcFkP4wx7ysJ+nhv0X1lSzbg/pZUFLnCYYXdMhT1qDa+LvhiYYvW74M7wG2VlWAzUaWndTyC7SRp0iPMQC6DnYp/UlhJrbPbuK+vsei/aWpEyQZzRA2Zk4QVXRFrSTbvseNXdDhTOLWY09SbXy4wAgE/7MsbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LJOlDfmD/W4i+Gr0CFJJNuid0PMcHtBZla64fw/mwg=;
 b=QT4bOkoNARKr/Iq64NgGY5BmVTsvuE3CVEO6Prv+JZ1y4DBe4/Cx7HTT3OiorgMXDT2A9VEWod5AfVWfO8d12PbQMqKCGMLUy9uMhIJxRByHqZmtcfRvQnuqVN0+OUtrOMBvkjU71XBW34EjynwGt07dBEiqxUROsw25v+t2oeKlFwVOVDWXqz1v+XONkpwqgFFvzBbfLwRyEDvpggu1xw/uiS01nRIUpoQzp2TYcf85uHRAGarSEO5V+D2zCT69Qjinvj6HPucbd/f4oJ/byrXbU7q/ozNDRwv7MjFCcVIAWF1ktXVcPOnXicKdEb0zBaddsQOyxENJ5rJeJm/hMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 18:16:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 18:16:05 +0000
Date: Fri, 12 Jun 2026 11:16:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v4 2/2] tools/testing/cxl: Enable zero sized decoder
 under hb0
Message-ID: <aixM4NA7hX43Bs_y@aschofie-mobl2.lan>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <20260607081345.61954-3-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260607081345.61954-3-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ce51e6-1ced-4064-99be-08dec8aeaaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ogApi93AxMdk/oBvMNwygHgTljBEFmE2nqaJ4UeA3fEUjnsnxF5MZjXavyebBUK/rmsRjsKG51/3MqizUmfQ85E3LqS5XRneBAp+nVZbkIK4vCvyrmesumWF8Y+kZzlIOd9OCTN2h0Ik4bAAtoQXh3D094lL+5X+DA/wqzWVQgfdCafJusqWe8sRC3gPjOzlzKCGhci1xUyQPdvPvb6wrxoE3HksZOyVDeX/2q1styfjYTkM6x7QnsK0aRy83pyypYkd4q3DxfV6knGGuuz9OcQv6469zlrwwOfwvojC8ixcvaKb8QIb90ctJ7JdK/ga9znL+87AyS8wMfhPA9QYaX3g0t+nrPqZ95KJLmF5we7o3s6z9OQL34sxcrX0qZ524GzHQps3f6btj+ailY7G+TAM1UbUrm+s+NUqCiBguoopuL1/WlYSS3vHWZBuYAkWoDSw63HzBCFsyyb8Nf7Am3Ju5VXuIAX8Qa5tjUHX+BtDIvjaHeKn63NwBQyv+wJeckJM8Ey3M1FYYpRk9nX6piedBzAAnLIxU3usAV5QZ2UVgh7cPcUTL+N/msSjwzIOqT6S6jaPegVpyGjpYhGR8JfQbhVlNVz0EoqH0SSXm6YxhzRDvhoeAXceWVQPKR1VdbN2/7tS7hcIe8qmhSaAVSkkX6adBMoB5//sgaL4VtGiL/+bEj7FehjljGzTAmeM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3BdignHJ5XHshGSyLAZJzjiX0uH9X8A0c6vCGNxsljeIAZQjsyPR40iD5CM?=
 =?us-ascii?Q?A2LXzk1w2O0sKcvE83TS45Ami7o/NQBeH22yQkgysTtb0O7T/I0cA1ii8Ot/?=
 =?us-ascii?Q?k/oh+gWPnuBRzZhuMsNfNQHlX4nhY6usbbf1D7l5cB25ql88pw8WTWKl2pE/?=
 =?us-ascii?Q?NnQTP4Zac0BLFq6sVMxt/OqfS1TkEvalz/a22JtnuELMkbZLMQPZ8D2VO0Vh?=
 =?us-ascii?Q?kqTGyJ2lBKsKHJImQ2XdolJQq9942/AeoY56letJDIQz4bzsAUSg/F8opsW/?=
 =?us-ascii?Q?A0ays25TELpT99vhzD0vP1ESeuMux5pCumSF7gRLjR11Epd4LHRviO7V/yHs?=
 =?us-ascii?Q?ldPBeqvSGQL1Vl7zqSwixWkHMGhwEiopDbcJT0PXV2uocPYkq2OmnHRd5epV?=
 =?us-ascii?Q?tdhfKEUBh0ZqJgygnWjUBoE0v1usF1/3wG5NZ4jvrPRQY3vhEP9m+aJPRGXh?=
 =?us-ascii?Q?WFps2Pt3yudxbPuuxUEvI6bWY/GYYrHWc9IbuWJ/kPYeCVlRBWQPs4p9mB2x?=
 =?us-ascii?Q?Oc/u6TZufRzIi9Ev8yQtvBK/v9ysKxlojFaBYuYEFj6c0/JdtWRgh6w8Lf2l?=
 =?us-ascii?Q?Jjnq/EwBZHB7oFnXFhqNcUSTQBJMRxFj8Zjs10CYXFYw+FsGX/nId8TlvJjY?=
 =?us-ascii?Q?QCEjmPnMdgjZqosaYQf6EHjMNClqMWajGTppYHy6l0l0jsnzZMPWHJKIWhfj?=
 =?us-ascii?Q?r9xMDWhRPy082k2iRCg38WinnGSg68jxMifDwVCtp3+QUuQz28pR+HKjf888?=
 =?us-ascii?Q?4R/J9oluc9Zge/CRS2YXn8Pcin6Pd3+un42TuhoL+ItlxU3+Fy1/Bswxy0w8?=
 =?us-ascii?Q?Gxs0Y1J5drq9zucfnXV60Y3EXPej6x6J4H9j5wEzt3zQJqbP8fwLMN5Qh67q?=
 =?us-ascii?Q?55+CwaBqjqtVpHeoqxBlF4C9onyF4tBksh56m+fHLZf0sUPdnVf1/V1VSyre?=
 =?us-ascii?Q?zNAdOyPrbHWrS6zTPcfIEOqrymwtb3CuGX+0sEyWf+GVJpzr8pGT8W17SyzS?=
 =?us-ascii?Q?1EGodrzVWkW+7CJlkXyo5N4YgsViwwMqflsGpyzDXsU93BG5RKRiKBrw4qtW?=
 =?us-ascii?Q?cU0FLcP48aznT1HEqEamnjapH48+QoQAxifRgdmEdZPtB6gj0Nchql8d0gVN?=
 =?us-ascii?Q?1OmWcZkeDOjJbM7vXuNh8gnBzgO9crSGW8I89rsjmpPNbTmKSJzXN3TB8oJR?=
 =?us-ascii?Q?lH4Fc93UWnVtyZRG7ohfU4HVqGXZobKZYR/MPacY23fl8zOKPc3VtUxGMTsq?=
 =?us-ascii?Q?DCEuEK7xOmYLqQ3psNadNnIgqxMVLcpGDqrYpyd6zxOVsnaGErKGxrXrKtwv?=
 =?us-ascii?Q?TstsffE2UNJVi/oASzQu3jW9Mat/o+Et1zkTdOKiAJbqp2uAvRO0nFcc5UPA?=
 =?us-ascii?Q?1ehs3dOpFfi1yXEO/Kqe9B/8mydLthFpkj1220Stra9iBmADdK7s+Qi01KIP?=
 =?us-ascii?Q?YtpfLWBIskd6u+PJRM16wDEA4I2FLQm1qrbWW4v5zhRYGJuwOvLTngoxPI9U?=
 =?us-ascii?Q?ZRlh75F4/j9l8FF/fLBwjT/edSyAPNjUytJUkbwAUsHIbH4FJYYe7/ILxK8a?=
 =?us-ascii?Q?+Fb/wpmbjvq+/u07Bjy0zTkVB3XTIyoj/vLvJPRCiQ+rgfX0PrA72dniyUpH?=
 =?us-ascii?Q?5ehIuL/nbeXjHPJKeHN2lA8aEYle6fqSSkXPRRcTDfHtSIf9KVONU+RzVESR?=
 =?us-ascii?Q?4to+xeKMK6MW4M7tz/FE+ax5tuxcuqLA79kZZAZSy0BUAxDSKemijPNdeH7d?=
 =?us-ascii?Q?0xyH/qPDo+AukqF7pbxxNHUcWMVwXk0=3D?=
X-Exchange-RoutingPolicyChecked: H4FyQjlNyVrZlV9Xxte+08vwn4kDiK3mUNGdCfTuf3U6PQp6D50dNEacdibKBjJ+jLg/hbpLtgBVlikNlP5Hh46oUoiLPesf5VnuGoKcc9v2ncQw2xNOPx2T+TLBUbAaeyqSlTffdlqhiqTBivox0PoVcW9fd64AsvTihLdYoilhpCCuFk9Fty7eAo4sHLpOZ535ZlKTM3q2M0goUOzlHSRQm/xODqK3TGqQ+/SpBq3wDP5qegc3BlQ6I7Z70Cf4YDEaqqGa7rQy7YyH2jI8MFAyg3JRPZDkyrnbGWnwtG1SCDEhn42ocTT8Q6ZVIBMp9Qf8XuZkGqdQLLL6YGbVEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ce51e6-1ced-4064-99be-08dec8aeaaa6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 18:16:05.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/xulF0VVN6vSTulOxd8nXGYTFVNskJJ9wdYDX7+g50a6zL6WEgYMDB7UKsVhBqwN7JqPR/1jpjt38WAd1fZuljWegEFosQW05awwXbx54M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com

On Sun, Jun 07, 2026 at 04:13:45PM +0800, Richard Cheng wrote:
> The kernel now allows committed HDM decoders of zero size so BIOS can
> burn slots with LOCK; cxl_test needs to exercise that path.
> 
> Add a mock_zero_size_decoders module parameter (default off). When set,
> the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit
> decoders 1 and 2 as zero-size + locked above the decoder[0] auto-region,
> mirrored on the parent switch and host bridge. commit_end then lands on a
> decoder with no DPA resource, exercising the new enumeration and
> poison-by-endpoint paths.
> 
> Gating keeps the default topology, shared by the rest of the cxl suite,
> unchanged.

Can you add a unit test case for this?  I think it makes sense in
cxl-topology.sh. Perhaps before or after the work on the default
cxl-test topology, load this new topo up and validate the zero size
decoders are as expected.

