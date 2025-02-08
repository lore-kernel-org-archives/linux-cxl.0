Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8E12C499
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978707; cv=fail; b=fniQbuA008M/a9tX7gDg49kO5xcF0F4PWuYla+pCDThHxAs9u52Gndbm3lV/d4XQ9fDJiiE/NdEUE+pan4aKtN6J3YEyob0zu1oFg/UJ4TyUanJFp/GQiB/nIEIzg4ZKzXZmnAgefl2PqxwM4exzYmpKDUkIr+06COvOWNAoYCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978707; c=relaxed/simple;
	bh=eIxwhY+WoAOBU5Hz02i8uRM9r356A1RMtfhG1dAmn/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnoBUtgCRXD0Zv3xZii+vqHLV8aLWh4czcVjvdrTa0pHsd+K2ZjARfHrz86lUKzPsmdDhEz0PBVIzzUBqDqatHd2umwdG0yTnXRXAEgf+PR2mLNexv90mmN720qhiou7HbssjbzjfqaeDMNoIQsSj/SiGBftQUt3KcWw0wd3zEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVb/Ht/D; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVb/Ht/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738978706; x=1770514706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eIxwhY+WoAOBU5Hz02i8uRM9r356A1RMtfhG1dAmn/o=;
  b=RVb/Ht/DTMu5LkE22LiCeqIQhPZlnj5DEXwqvWdsrrN4w0ubKBZuMpJM
   Z+eMFuLkfk5wtm225YMyS7FYYpTVKCRtw06HtnQttBczwfzO7wNSlSbUh
   kO19s6USly2ER+LLWitdEwDsx21fy7CmdKL73P8hFS3RcsLaDCCjy9me5
   0bnGOJa51LlB4XQhrMLvWuvr6trdRyij+CGB5zRxIIbZ5WSiKiGEonVGX
   M19F/gzY92AOFo6S2PSXlK5wZ+bm9kjtLUFlZFNOZnRTIKMS9gDiLZgaB
   RRvNepREuuyWuAnPCwjGCv4c0OuaZg0p0smvj37bdSR8f7WT77cLof3uB
   Q==;
X-CSE-ConnectionGUID: 2+M+3e06SUGIbqgP//XKdA==
X-CSE-MsgGUID: qrc/s/sZQBurBqb1qjTUWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42474467"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42474467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:38:25 -0800
X-CSE-ConnectionGUID: zPxm38hSRMqGCOavoD9ZhA==
X-CSE-MsgGUID: tQpbkFx8SWCzMfT43Ls7ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134916712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:38:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:38:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:38:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:38:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM69QdWbWvASu7CsLJPZzuACHWrNVtx7MOPyzTVaVMHl0lKX/GQv8enu10nDHH/nLhhnxFkEEFnGn5ZjP0qkUoaNLksn/wrrIE2yQ1uZgVPxKsTrwN70lpsbIG2p3P/Olqn+gNpWKX68I/owcrgK2knEDrdbZYWbaMlORk+Qw8F9Lw8eTaJukXAwHSFoiA8nLaHsKqhuWN9K8RTUeydMmWbyQeCC4VizISH2fDyaeJty3bYjVMjzu0erZlrbmR3L0CvTJXZ4GZ5bbDe//vVnuJuVrIuJwNTv+LUjAx+oIn8fW6nEsw/Nm7bwzXAO7755vZCbG6Nnbz48rxw/2RDc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4idho5rpoPGrcfUMehcBWvj+NCJ+O2t95232aTpzX4=;
 b=QFAd37Fr5jbV7P+mdjMBCtXpXbPvcsaZzWpakXDIVjBr+khAwakvdylSIHpEMe8PMkLBjkdbIXgA4ZoUy6mXmPaDKT13e1+MaTBcDNYAV+8o7tHF46S12uWY6KQLfyJuuPA4zXOtxhO83Vpq/fKYQpbhbj0olc6S23mISVqjD0AhfrxhJQM+6oovrYJgHqV5WVKPBbMJZc+uwN6HvCxrAjE/RMzugeVYtKa9fS/KzQc4XyOn0NP9oh/z1ool0QGmiX0g/P8daslCTrs2itv6jgqsOXHPKiLhWTUc+sr5RueguFYdOEDeUciN0pST33JAz4owyxfnb2G/GIGdPMOqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7158.namprd11.prod.outlook.com (2603:10b6:806:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Sat, 8 Feb
 2025 01:38:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:38:07 +0000
Date: Fri, 7 Feb 2025 17:38:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 15/15] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <67a6b57c997c3_2d1e294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-16-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-16-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63625c-e735-4177-aa0b-08dd47e13cf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D8dZrXJPmud+5vG6+a48PJJk65hI9eQd5at/yXfG1xYC2co8O4aMXOy6okj1?=
 =?us-ascii?Q?CtAdOk2pWd0gAztL3uKYCDELfrSoTE1PVtA4U1eiMvHW5FuULXKov7UG2HLB?=
 =?us-ascii?Q?guCiyZB65ab5zZyyz2tdg4iaFdZA2pnjGC8qpQJUAOdnqItdClupirixOchf?=
 =?us-ascii?Q?rDqlc21mq2GdMpocLiO9fNBlgZxHDB/WpQR7w7XjQgrF0g7USrVR5KlqZPZT?=
 =?us-ascii?Q?UJhccto5q+lQDudQA2mkaomYFqV5JlkcsU7TeWLeMo8D+FLnpDVdN4mITHq/?=
 =?us-ascii?Q?5c18JD3C69FeWSBji2/jmy8/FV4dzpxp1aFr+EIBztUJV7qfgQSEJhMpceTz?=
 =?us-ascii?Q?nMRdqNaWD5h5Xurl5YRUJjoxhhU+BTO6PZ2hsc2fiqH6aFSB7GGo7jyUi+Ey?=
 =?us-ascii?Q?tMqQeOtcaSh7u6GFNFlVlOaspzIkVs51R9lYWpYieBwf97/16v8tCPXFSBiW?=
 =?us-ascii?Q?Zk5I1HOBy7DGE8lUFQFLT9tDtIkMdI5kPpngv4/1d8DpOSEHqwUGY+R63E7K?=
 =?us-ascii?Q?rop/b4XWU08kM5+vlALi42bK/IguamWeI2DkkSMA8/RnebjaPy+jR1EZxfSK?=
 =?us-ascii?Q?6oCzG1UssHGPZRQELkg6n9Mh4IGUu/po+yIKTrMFS4xQ4E9Vw/Izvc1xAgbv?=
 =?us-ascii?Q?P175psCwXCkgPoQ/8YXrkjBTVqLKH2FPxLYcgKjFL+scIl6MHKr5tG9Rufnt?=
 =?us-ascii?Q?bOsykk8RzaoKlcwcWy4cLd6uqPbbOeXbhL3U5OTkPKB9qKr9EcEiterv94OI?=
 =?us-ascii?Q?Ht7IwTrlXYaOiKYnLttoX32pvwsGxy7LzkwmJov149vkTeegq3x+lKx53nK0?=
 =?us-ascii?Q?BfJsDYxFDYS2S2DJbcCMOozKJ04DCc/6txy5xp0nRKAJBmyMQXaJLL7Wi5c+?=
 =?us-ascii?Q?OABQG5UlIPoER5KcbDPk5NY4EHn7qOJxmTAJIgAR2kuKeen8Y6hM+T5cVd8c?=
 =?us-ascii?Q?rYkkX7LLy4arRum2YIDQRZJAWuiLzZO60ahYVX78dlAuZti1UmqiAD9YWZBm?=
 =?us-ascii?Q?Z7NBL2gg5WFvFVRAUuj3GSHJVTIGmyYRGxuJ29Up/MIF5Go7oXcMikIfCr0y?=
 =?us-ascii?Q?UXKnrlROsHX3X+MVUQzmX2BIRI3ZaWCL0yh67I4bUVGLFMbhyUSAi4xAhI7R?=
 =?us-ascii?Q?G5jrjT2HiOJXNMpBuA33qWq0XG0IE5YiFZCnAajl4rvDPYRadDwXTP0Wlydp?=
 =?us-ascii?Q?LfUBo3Tz0BTsGB8OjZRCTW/9pjiP8oORjE1K6Cdb0S1u4HgQGF+/amRI0ddh?=
 =?us-ascii?Q?bUPmH22RXqGNOSla72SMFY+oS+a2QIWuBaKEBYoEmf/3bLAaFsXjfIL+hQVh?=
 =?us-ascii?Q?9VDo/KeSOyNHmRgXSXONC531jntthMbThcxBBvQX8PTKQMAYHFnfkiO8CdBC?=
 =?us-ascii?Q?FHvzQcIirpA1CxK8hBzCzExdv1aK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E97F46NQlNFDna1lYsYPFeUSknK/TL+mLCgGrXFhyHFmUKwp1VGZyMH4BwuI?=
 =?us-ascii?Q?2kmXEjihd8QAlvDtYdkprI7sluw92KL5++ARIgew9koYDqRJTj9/eJytLcrL?=
 =?us-ascii?Q?LpBdcovqsqhEK3VzQZNG/p5u1XtyREIqJ83/OMaAj7wMmG70jmdFyY2wRVlI?=
 =?us-ascii?Q?uck7j2XBMHAsjHpcI+qeJ08XPxVIOsTIg8V0VP9iaMZ8IEeofuuCrYIXXaEh?=
 =?us-ascii?Q?f3dF8SMSNJKVYFsOl7AbcHh1adVGR0KloCuvFpQWkrNi21cwj7PX7zTPxTxa?=
 =?us-ascii?Q?06K2hJef45JFB/wRwjh3+scFos61PW5K0CFV8vxVMV9yY6IRigOmJvje9vFB?=
 =?us-ascii?Q?7rhmBImeSxdvl5Td7dYiTuq0b0zrBGcAYso4A9EpOR1EzKDFgNUw1hHgsv44?=
 =?us-ascii?Q?XDXhUfFuMth1k2gSPmnOEhbs2EkfjjAFFsObhHzN5TtNtdQtW21lFt3/Vy2c?=
 =?us-ascii?Q?A6sZkKgAygWQhN2OYcs35LBKeYV6fQfwYk4yemKeORlV7C6wq56fR62Ml0D6?=
 =?us-ascii?Q?UFUnhMTISr1euOnAy7LqXacWQkXDdaNzSy2vefrkN5G1tCT9xQ0Vcil+KVX9?=
 =?us-ascii?Q?WWCSPD/wQxLwrl+bRVmhgHFAmyQBPnor9W1T5qPocU3nwfw8BNJ+v82slJyX?=
 =?us-ascii?Q?kCZ6fxFWXm+bq/f1ugwMnIfK+DrSi89tU3Xkf+f/wPrKkfDcGmJh6gVH/Vct?=
 =?us-ascii?Q?RClvLkcia7RXbECoV9m6/xPwbqlJuTSycIwA/pS2/hSNktOk9fzhUULO65N3?=
 =?us-ascii?Q?jTSO5i2PIeACyV3+/0SSZG4MdmGMXT1cKJ+U0IRlogwLdOaveOstIUolyZNv?=
 =?us-ascii?Q?AtiBe6fhTIskFQPiiYuyP6s+xr3vfJkfCS6J5az/fDGOY9I1hVU4pYUIAvcU?=
 =?us-ascii?Q?zmGwUIH3QcD5zHa0PKCOI++QiSkbForMzj7i5ay9zaXzJoFFE4E8oaOsbrfA?=
 =?us-ascii?Q?ADHvdO34/jDJwXl2UiqqKQZ1AFRUaJ6yWqYCxCwhIFtHjjfKNfrQFrkeMnm5?=
 =?us-ascii?Q?A2L8KP6FwsIwxuiX0u+ZT/3TYz6P4xQlt4HbWnzWYOySmDFomVeNHhmkksdO?=
 =?us-ascii?Q?lpbR2BvV3/CKiVFeUorsc4ACRblcBm+2r7A1AapYxL8l/V+lE7l9kWWfz8tN?=
 =?us-ascii?Q?fL9x0en9yMr75LXOZ9LZVJgSNNFhuUMGsGYcV2QxLnreTqPOc3okTZdOgHv2?=
 =?us-ascii?Q?FVY1x8vXz7xvazGsqaiGGINH/IKGN1FMtfG39Zqa5N4HbqOTsXKyor/goKjF?=
 =?us-ascii?Q?o0TCl7ncRKJ79ruJoUP9QmOp6zhB+QJJc6mBF4mXXdfWxJsvqy/5EjvHRP5O?=
 =?us-ascii?Q?iqK5d+5t2mW53NW8okO9Ocs9v2QGX8QU+oZmMk9lDxQ3TM2f+ABjcB04oksb?=
 =?us-ascii?Q?AY5UsZY6Rtf0pzOWOKBRAZH0SR+bxurxpHIFeWxnxy7fLqCDrDzWZDJxyUzd?=
 =?us-ascii?Q?Gw7E93BNDN/HvRR0sHfMLwVT3Qm6t5o49kIeZReQUParRK5ljkpn2irZHBAS?=
 =?us-ascii?Q?TTWK2ZtGdn4Hq5ddRmASZ9bgXxrnriisP1SsxR9oOy5rV9H46ylBCzNJZXtM?=
 =?us-ascii?Q?fj1GfNQDGHZw4m4+TMhLxcCOpIvDIkiq0sipLrwRaIX30DamB+XliqTkODmP?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63625c-e735-4177-aa0b-08dd47e13cf4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:38:07.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t9OfQRIxvTAJkCd0m/8crORv+eDQY6nndpLxqWbs+CX3Ig+OybneXqA4mgB1wQL0gii7QevGwdnwKb1jeKarCEcL3uIuv8SR938pCxjAn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7158
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add policy and operational documentation for FWCTL CXL.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> +Code example of a Get Feature
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +        static int cxl_fwctl_rpc_get_test_feature(int fd, struct test_feature *feat_ctx,
> +                                                  const uint32_t expected_data)
> +        {
> +                struct cxl_mbox_get_feat_in feat_in __attribute__((aligned(16))) = {0};
> +                struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
> +                struct fwctl_rpc_cxl_out *out;
> +                struct fwctl_rpc rpc = {0};
> +                size_t out_size;
> +                uint32_t val;
> +                void *data;
> +                int rc;
> +
> +                uuid_copy(feat_in.uuid, feat_ctx->uuid);
> +                feat_in.count = feat_ctx->get_size;
> +
> +                out_size = sizeof(*out) + feat_in.count;
> +                out = aligned_alloc(16, out_size);
> +                if (!out)
> +                        return -ENOMEM;
> +
> +                memset(out, 0, out_size);
> +                data = out->payload;
> +
> +                in.opcode = CXL_MBOX_OPCODE_GET_FEATURE;

Oh, this went a bit further than I expected, but I think its fine to not
have fwctl command ids to wrap the Feature opcodes.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and if we ever decide to expand the operations that fwctl supports
just need to be careful about aliasing.
