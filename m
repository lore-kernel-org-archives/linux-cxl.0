Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1274E26
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449528; cv=fail; b=YStvcu+6VBb3TX7C/8vXQZx07264sMCFJ521bUmUpYAPS4OFoxRi/kCTit1d7nE31MneIQ0RPDp67iIYTh6jxGXDnMPVlT6cPkyUZHHA/6ZIsEOgKaTRqUnZglQrrhbNRdeLY0cgTMomEWyvrIAdn7/VWbz1QOT/3j46+V+MaUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449528; c=relaxed/simple;
	bh=y7F++b6HQgA0UZTRoLPKqJyehaUfmggc4nCwS/p91LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9bEDwXCSa2DxmTXLKxsRGW8mHd95UFf8jeSJx+qTX1oCtNCL1lX5npVIOkU0JMIyU8CWbfWeIwRncx01G+1tumaEDT+ErdJt6n01+eB9ssqWLLHrCjtmouMd6+L+N+vXskIsgwC8GwY5T/UT2pUdo21heDP17WdKf7e8s9FqZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0WCemGQ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0WCemGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710449526; x=1741985526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y7F++b6HQgA0UZTRoLPKqJyehaUfmggc4nCwS/p91LU=;
  b=K0WCemGQUooPMk7t1CJUeVBY1XGM9JOAqI7AvVqqtA45r8AokIGUyjuO
   j2GeEgWkNnYTSrCghwHFyfUUQlGQ1Uttfu+NJszK94t98ISFV6WhW0Gxq
   8G1ZxBzqg0iZ2+g5+dA2CZiktm3qqV0QjJg6WXg1gUWqxvn07p61Alwrd
   ZZrHl431AlkgHklfQX97qlISrHvT62I+TkPUtE2s6EpMAiQNtqxqcmZHs
   OQqB3Ljt1Te95zvuGXeEs05BMxruVn3QQdnD4nudGIbdEiB8KcpC84i1Z
   wf/0cHs9uWCCwlXv0ZAk/75XHNYOFY52W9XIwd19+N9ONkV42Os7ROJLR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5144004"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5144004"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="43332660"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 13:52:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 13:52:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 13:52:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 13:52:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 13:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7QsORiFRT6AOBs0VW8e/awMEk3+PhbCUAY54brKCEZbiCYUdeHCt+bq7Ki9rsDSo6PGps1kWfh5VHV+pRRT0grwOerUchuLPkVJ0FBqLIs+Ul8zR9kPX5u6sEPyxEVXmJlOS+fccD9IVim0vc27FnKiRvEWszSRfsT3hzmgQ2T8Sy7zTS5uMdC2XlGrNXGTe4Csf8a1PnI/8IKWses0HAhhwysdx7K/7pSx+rX/O0WGaCEkDCh/jEpcsApqEvy3/sFuIPr/js/9dJ1tv90IuESF01I2GaxnhVnWUdeZVfZ+jmRzU+7MD+xZdwZ5MqeS2bDNpZGD6BE24eqOWzXLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVlHbM3NjKG0WY16yEVVcNCSDoqyZR0wwHu51LteBBk=;
 b=WvQzNM1Ovk9d5yXF4PBkXIbtP3+5d+aqqVL8LsTu+nQFjbx5vkY1zWjBczbUpv3RdHciZq8MVCI+SY3YwVCv33JhA+t4L8nDdD4pYa3H0nl92KDMQKAh9fxupa/NNw5kJ1yt7EaUPa2AA+kTPvVvwZOiA7zAgXCzMpn+SV4FDSQ8epaOaBs+6Pq3jNJtL7gSL511yP98yzDf3+uF6rh9mdb/xcQC0y/cHD0KwsSN0HKOgHximkbP/jwhaRHutX1gNPqhHZ3fxC3aWq8K3ELV1UZQhKs1a2T0V2fGgN9V1ClL7Si5jVv4tRgkX5QFDLpHpVdO8aJF1sQSika/VKVzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5149.namprd11.prod.outlook.com (2603:10b6:a03:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Thu, 14 Mar
 2024 20:52:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 20:52:02 +0000
Date: Thu, 14 Mar 2024 13:51:57 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Steve Rostedt
	<rostedt@goodmis.org>
CC: Alison Schofield <alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region name
Message-ID: <65f3636da691e_22141294d7@iweiny-mobl.notmuch>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314201217.2112644-1-alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a94fb2-2443-4011-43f6-08dc44689973
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Brx/h7Vy/Eb+aD95795q04/rWx7I0yiBvzFR0QMJXYo2Ng6G/+g0EFvE+yU301bV8dPqDelsTcPc0YSqHZdwHdAtEH0Gr4J98yLfzQv7Wdbhz40ZvhdAIux8VNp5qZc9PEnKzMwxXm+PVFLtuJzVWtMqbd2tPbuWb7j+jThJQFgRA6URslkhCMk6SWtbVfeZw/EyTsvlIfjICiQ/ucA68eSIl4tqGm3B4v4EKvCHlOJjZwlrVfXBh/PTg4ojOlu1pIHU1SolDcNrAb+K+IdBQfFyFqEmI6WozCxz45S2hSlx5TN/XNk6Ea9rGmrd6nTjhXXMw11J6GOsYDYazmwgZRovsPbUblFiWM6M9Ta/KNBva8Bq1CKI1kLOK6byJRmFcR5SrOSG6F0NognjRTCEPmS68JaKZsIBwSIf2mU1RQCt3HMKU2Yxuyar6u9hQensoLEsI/f23glx8kubkNkMnE4cn63uOuASmxCDv3SRTjS3dcs0Sx9No6v4dDBwRS+XMnqb2rQ/2PvFi3FFjjUqFjFJPYg8gwLlY+5firC8zx39m3r76FuJWqnHg0K7Y2KesJRdiXPFxEbXmLz9ITgrDQBi2gkepY9vwwTSNAmrTEWac0xCRuXi9O/YL1J3cBp7ckhKOtjyASbwAmUwXiXtBLVeZ4pOhFTodSe3KHj2wHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fS5h/WJHQzkJ14iF5eD87cN/kBwFZqm3zviXuBYvyv+IkE1AH21pqyj5fEQV?=
 =?us-ascii?Q?5djMFpWh1PiiNI+UDUdmhLDO7Y/ckKrARdvMKYXnQtyCELr+br/uu8WNA4Gv?=
 =?us-ascii?Q?hX+5T/o7SlKJK8YxMDeIGdOX5xEIW+Pv37WdbCHz1Jm4dUjEFq6KfvnjfX3Q?=
 =?us-ascii?Q?bqciC8UDtfLZZS83OQokvyEUPw03evKkshoacCx8DIEqKz0eOVq9pAnbuXF0?=
 =?us-ascii?Q?CYe3CAP4Nz8PODBxDMoKSm4yFdi791MAhQ9K5GvBtnZ41JS3PMD8ziMoumyw?=
 =?us-ascii?Q?8MBQWJuR/WKBAiYzo4ibumZiTwnpM9AthGShdVcTkU7iGSSMtOc//Ng97dHD?=
 =?us-ascii?Q?Vp+a3MpFS8Nl3ldnEIsdf2rmbPU2DXb5XlMB0ajiGBHqmjBGLwYI1KJOK8Rl?=
 =?us-ascii?Q?ZC5S3WSt0aPiLESj40XvfVToWp/8uv05DYgCLeDFZ8MNZ3ySbwhawEGyHIRB?=
 =?us-ascii?Q?wcr15SKEgISVCs0RnoMK+FsyJb1QK5dTmvqZzyc4jsnYRdrc/lqayUnpigV3?=
 =?us-ascii?Q?02g2fFOFimfGY31zKiUnDmNqA3V/rQBO6qby2z2x097S5TeKC4RQtScq/UUh?=
 =?us-ascii?Q?79FwGNQjkWtQuets/GkhOFpvav1swFe16GgPWBaGQyPeyUT6+G/p3sofSczo?=
 =?us-ascii?Q?56PKQ4VgojdjmvCV0ne6A9BkpK+p3h6GoX4H45ntMFXUWYp/uJiaZ/RKQIVr?=
 =?us-ascii?Q?gWcB4ZvKx8doBFicS2/WA+bNQRVpXZXNG3LadPGl2lQtY8F7UmurEGQmC+r2?=
 =?us-ascii?Q?u6S6MyQa9VAHBJiI5jH3CtpsWsEL+eHnVmGCIRniD3EovCE4NKCPrDQAAfHX?=
 =?us-ascii?Q?iXQARjjXp05U9pyQkHk+C5G4Cw1BF0Gh7h5r8en0JGf+ydBFkY+kVYILkccQ?=
 =?us-ascii?Q?ndhgzEqP7ccoKEtrqEhpy6k9vMvrS99UBZmN5v54y9HCsNmb1/RO+iMxdkso?=
 =?us-ascii?Q?xgptunkbfpbmVpwQ/jbd0XUiiKubkrnllSxQpdM52A9eZ7iRiw6GfmuBikh6?=
 =?us-ascii?Q?51MKJvkJrysoPJcf8hScunJ058JkIopkEfLdP67/I48zDYv4CQSOCGTKi5w9?=
 =?us-ascii?Q?jpGqEeYjG6fZoQDxoLS1PAOXRoQ3wnG1d5ijMKY4gfi6yw9FOyi04SU/uiuR?=
 =?us-ascii?Q?mwvHkEhJ7yNFlUbbcVOU4fpcbmiVhUaH4nm8UKqa+jJ/3Ne9qSXQamtDJgmP?=
 =?us-ascii?Q?176Jwo0vKZg5PHkaMS7c0WKkWa0WXiO0JL9QGjcPEqfWar0AK+t17rOtddVn?=
 =?us-ascii?Q?+hVLy7ZWwu51ecZ1UaNqUgyTjbnkXz0XJloH+EIW1NfUgV0f6J/8te+3WHoI?=
 =?us-ascii?Q?CAabqb9369bTboZJN0ih8ZJUsb01vWo+v5khBOzDveC3GnpY3a2yQTnYdBF+?=
 =?us-ascii?Q?HXUOHITpLyC1w6cVmirT29p1NPsVHCDXVl5dxoqgSvoCs4fflo3y/E5n3/Fw?=
 =?us-ascii?Q?TMcn6UvG95QodzDh1gmrpyqaSRVE7GQPs+CuVz8lrx4wSQhiy/mDL/E4OF2t?=
 =?us-ascii?Q?j4h4hccOmNFLEMNMnUXw8bfz7srKKSHxJeXtZ1PkF/zqOr2B/5HzjRWxw/+t?=
 =?us-ascii?Q?IZNCVXwhYyU6zL4mYd/rZ2KrDhbGQAV2804Ww2tlWB+l5QuuPwFs2rpopw0Y?=
 =?us-ascii?Q?TabKrkeoL47h+vhLGN+X6Y6NQ+WLcS7EhBgku+WncqBN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a94fb2-2443-4011-43f6-08dc44689973
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 20:52:02.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JljcymJpZbiG8Q/w912kL0PmKG7tSVQAuQOsaBlOb5qShMkhYjQ9SGmcop5cR6VJbRxG9SkZ3SHnfF1wwgZHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5149
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The TP_STRUCT__entry that gets assigned the region name, or an
> empty string if no region is present, is erroneously initialized
> to the cxl_region pointer. It needs to be properly initialized
> otherwise it's length is wrong and garbage chars can appear in
> the kernel trace output: /sys/kernel/tracing/trace
> 
> The bad initialization was due in part to a naming conflict with
> the parameter: struct cxl_region *region. The field 'region' is
> already exposed externally as the region name, so changing that
> to something logical, like 'region_name' is not an option. Instead
> rename the internal only struct cxl_region to the commonly used
> 'cxlr'.
> 
> Impact is that tooling depending on that trace data can miss
> picking up a valid event when searching by region name. The
> TP_printk() output, if enabled, does emit the correct region
> names in the dmesg log.
> 
> This was found during testing of the cxl-list option to report
> media-errors for a region.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
