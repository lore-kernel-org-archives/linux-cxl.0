Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5418635
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523264; cv=fail; b=FDIEK3KX3jhRqc5U/+odqyJ3/ZiQxUENHAn28oSuOzUJbZM1Xp9Pinj+owAEEttwRIGtufQ5VqQbxbrWKFIG5N1yguk7pBW5lXn6f7FxNnQYqEJn7tnW1MySjU8l9suKKjqQ0VxPBaixfRFmys12wlQdksS2LMesKyUjG8rQQrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523264; c=relaxed/simple;
	bh=TUehG1wKKUGWc1lHvaAp2Xi6EdbOuGK2HlhUgbvGhmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e6xqt6vyIMzok8CkNYjvrgrwDUa/X1RIor6FwHSmLSapTVteVl9jv17a04RK80PDxw5LvZrFTfmUdb2KKcF3uXORuhl6U0S6HrvKpTdIean0DicKwefPYBZyb62RBmtoyA8tdwxamoRwQjCqcr9n2HRHD0IEV9HcDjsXGZqBq/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH4MLwJa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH4MLwJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717523262; x=1749059262;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TUehG1wKKUGWc1lHvaAp2Xi6EdbOuGK2HlhUgbvGhmM=;
  b=oH4MLwJaSTiqxXIIVAZyEb6l6T3B7LdYqbP05weDE6febLf2IhnM+DO8
   mJ7lx935iStcloS96NkzIcYfNykVl+G9uPForysc9kyQQ7K+y6esnVkKT
   GoLKTyAvNq2mp0LBDOa3oIYElALihKo8FhQd4496nLAR9LhY7PZT6ATxK
   Ch4HCAgdTVRf1MwwAT/CtauV2q/ASrTC3AJSm2ypjTH6To2JHFSCdLViX
   R/j+3knoShxHn3TlP9YV2krT6W62GOj+JPkFxitW4Jzk0FAP6JJYtoYEq
   Tl1iaKDBjUqlAvkcSVgVHxhQBlz5xMT2YxtofBxdBGEwvFSbNlPx8shWu
   w==;
X-CSE-ConnectionGUID: /65tQ7kBRYavsSX1G96U9A==
X-CSE-MsgGUID: 3vUQdc+1RNaU8yhvaQbz8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14225655"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14225655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 10:47:42 -0700
X-CSE-ConnectionGUID: sEg8YAXCQ66p2StgAlqlmA==
X-CSE-MsgGUID: e5/3Dz4gQnSx5uHZIH3Heg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37431742"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 10:47:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 10:47:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 10:47:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 10:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dALUPXreasilYEMrtSqLZw8RFgXjyMt9KYZxVQaqTk5XkT3edafyutt+3abGu1CQKsb8kt+Yp8o59byk59jvUZ2cUJEMldY0peEEKrnrJpMyQXQSLTosEPtg/IgHRJ8/zQyKn4e4jVHUhdsBFt2ATLzOg4JZiX0bXRRqzcyo3ktubtFZbww3stdv5BUkM8ZTYsvPM4ZFi837+Zrit5veMCxqY7FKDsltlBPgqgdybw9mWDp/h44a7Ow1ClZw4lpS5PMWZ0TiSp6677Ha860O5cPFN6EACUtXMkfXoZYlHm82Y/LdrPRpkV+RY0tdhr2t/+n7zV+geUaGHmBsxCB06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIQj/DfzXPHD8b5Ocn45ID/Re+d35RYtq45hi02bVTw=;
 b=YmTW1Qca6YYBQlprjU483H1a+ZI5k1MIZXtzSw9Ib7Y2ChlLMO6LQpZGkb0jjHhQKPTcsFu/cwmfSqQP16mefW8xDmlNf9Aqw8/mucvlabGrdMzDXHjnjatWBwvm4tYsPvBKu4s5jlejuKUW5IMl5hoxbg4+ElUZLdmiakyQSE0tSOGcVKQ/WR6dRJ7uWbyxADy/FHVzj4ctIDco2exus91+Eu/inSPLsxo00NMZ3vus3xqcq6BlvHXVCjo/OhU96eYRSc0Y9Tptjxsk7HZyWdYguEo9Db+LEdFuHmjyXVJaqlhe8DDN0uWSjAe6uTMAZGSWQ7TM0HWnhpALWGoO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:47:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 17:47:37 +0000
Date: Tue, 4 Jun 2024 10:47:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Avoid null pointer dereference in region
 lookup
Message-ID: <665f5337939f5_2a90e294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240604003609.202682-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604003609.202682-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:907:1::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2567e1fd-99e3-4424-c0f9-08dc84be6c41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PMpIa/0HTKFeNOKpJcI5qtH6LCBq0bkB2a8TNsCIbWfR8pUwX4lsXAt+LToU?=
 =?us-ascii?Q?sRX6SFabXgImJckDvKymOqgkIO+VA7V+LptckFPJlfO8qhDh2adxpMqf3b+a?=
 =?us-ascii?Q?mUaKLwSMz5PNsuDMY8fPXgKMQeuF4tjiMOwHvO219hWB3VZ24wKNrvs9px/h?=
 =?us-ascii?Q?KHSQ52jKD0RFAFHa+a9mV0a3DgATGruIExGYDgv4e1hx5JlMSZT05P/BlMHP?=
 =?us-ascii?Q?lNg1qbQDobAD/+l7xRrM7otBvwvMRq4K2TO+dgOQYB6y1YAsZmKLFnZifl79?=
 =?us-ascii?Q?bZSrfltheWpSJtLHIaPxBZzr6+wucxiaECgjmDOAE/p6vuP0UsvAgl0ni3vM?=
 =?us-ascii?Q?KbmP4/X3egNfTwUrKFOvo9G8Cu4gHG61HheOAh3GLIEwXBe61DTORRIfhhUi?=
 =?us-ascii?Q?/lld0HLnrb6VtHtHl7/oV2fJ5jznXRaCmNAtj7WC/+/h79Bk5PBMgYOo8G6L?=
 =?us-ascii?Q?m6ToV5df8PSoUcLIUgAhz+SXGp2yIyof/3nRvzOTikGi/p1CtyBobeJnzfOF?=
 =?us-ascii?Q?W64durVxCqIZnyCDxA1vtoOcWyftF57dWG4J6x/4D9OmsKLVHwVDpaQGy86a?=
 =?us-ascii?Q?aNPh/hqLzeriA6u/PZ4Hmjy+CXr8P+DwwldIiFg+rCxD7dtM5835TMHfDWID?=
 =?us-ascii?Q?IFZRifPhY4facZZixEOUltRWQmTkc4u8zirI/AK6F2+nVTOqiIMT6QQjX6z/?=
 =?us-ascii?Q?jIUosLuKx35T3hsBvtupACDSV7c4yCJbG5kknqK5uWx553EG7hho3aca6Kq5?=
 =?us-ascii?Q?rVMBb8z4O3atjoLCoLxDH4TeTVlCd0iCDlHxuUrn0lhQKPN8HrP3mSyUYiL6?=
 =?us-ascii?Q?w5ZoC/56xaEKU7xJX35NTW12i2T36h4at0okLLeLC7QhiqtwHjaONU+kHj4N?=
 =?us-ascii?Q?pQ7Kx2U9OeKfq2UsxBk3gZJ32/QT6hfpQF61h1SfpWMro/FefbOCmfdlxZxK?=
 =?us-ascii?Q?r/ZXDPu2b+w2iLdjBYWfPMz8CAKQ8NUQR0CJrdtmjD/TIW00Mn0tdJ/KmWlm?=
 =?us-ascii?Q?oulC8LXL+31KTMbHqmH9c2sPq0WoVEhv7UhLpDCFmV536d2VygtG+ubrdNnP?=
 =?us-ascii?Q?UK7Y7Nd1O2pyqXdAPTPzNJDHd7HZrDRwPMsqPbWHCkwna7OrcxT0zEIG0OYP?=
 =?us-ascii?Q?T2vwmMJWiWIdEXwyKkfu8LjhhKHNSqSdaSibFA2Ljppc0mnTzSjCIlY3YOHZ?=
 =?us-ascii?Q?nPUbKqIQyIff6OmZR4tYB52LCpKbQoxJg/siPVV98wXcta8bu2GgeopNIPau?=
 =?us-ascii?Q?3QHzJnRGyot9yBXVQg7N1xjzE3zJhB/MHxADoMhnTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1gqqeceH8nefBD0UL/wQniSsxnKPq9rzDdaMKi++bhuFZhd7/503Df23x/Ny?=
 =?us-ascii?Q?jIFI1st7LvZHPg4VOzd7md9t2ksDpDCQb1twVQPT4EOBH6Vq6SfMmrvA/DZg?=
 =?us-ascii?Q?UJAh1jkcjU37+Zzoc5TnUkKXP8HQXHJD2HkOt7afagG0KVJZCjBGLxRBwvgf?=
 =?us-ascii?Q?u5ZLiA1YK0PADPSF+EgFEhpthr38tdpuuPo+oKCgHc4H7NTfvIh++CWofFek?=
 =?us-ascii?Q?QEw2sMGtiYphYBiWJ7wNOZd1IEZMo12kqZ2y52En6c3Y9SDnoC/MpVig51Cx?=
 =?us-ascii?Q?xRykw/1T/SUuNYVnz3AovfMFX4I03aleQNmZTn+2vRCCNfFiXY8k9QY684VZ?=
 =?us-ascii?Q?ovDJ4y9CA4H/SBA0+Xev8LeU7PEY4WJFHLAknX+C0HbeX7Ms5DSldnt3MTz6?=
 =?us-ascii?Q?4N2gRouqeBZZhya+fDYIbRDcPGlWKWsuOmoSXvvVsbOUZKRSWu1h8sL9Y8/L?=
 =?us-ascii?Q?BzNMIAPoQ2+ZnYJV/3Ce7Z2FRHKj515GJdwkAvp8BgrmuX08+h37LCsoTEvX?=
 =?us-ascii?Q?MG8er52OZOrGp9ssPtjVUft1po83wMS9E6ngOTHBBaytgNeCCZk6ziw3HXPm?=
 =?us-ascii?Q?vxuOR+0xanHhdWGnG9rQV3RxDOtnLQvfMQgPP5KnH/6euP1zaSk+g3/uRLYb?=
 =?us-ascii?Q?3K16PHnfTKsLBSLlvq/boiTgIf/M4IZ7w80zFiOKnB7x8m/B30iD3y20uF59?=
 =?us-ascii?Q?595fXoDP6lRH5/BeqIXWlY9t/0FGQ0f9iXq78eTXu8lN+/V81BXsOtVYeNfw?=
 =?us-ascii?Q?0ynauCU8xiyYd+GLVqMm6NhpYT/LfmT+cI6SMVPf/qHpexXYxJ8SWqDIsp4Q?=
 =?us-ascii?Q?ggSbBV7AAH0GthjzerEo/NPtOXAxlN/+9WaxN8wxE5G40pbnoWffwlklUJHt?=
 =?us-ascii?Q?z1+qm3zNZhesZvR3DgraFCU8qp3Y7j76cPrEAwzPMPXmMk+U6kYOGTAxjCVS?=
 =?us-ascii?Q?8tKrfxDqGc13kNJYQtJI1hJDmTzjppAmzOcQ0OcsFGhoh1xPqT2YUFceDOTQ?=
 =?us-ascii?Q?Vt9mqgfUSFcnNqtcGgK+FQrHVSyZQxSwJfDXYiCFFHHm2giPRk3IINx3Q0DQ?=
 =?us-ascii?Q?ntlRjCknpFl4uaHVnJD+V5GrUu77fJm0xrovg4sFeGXL6HCwvxOJoATJDA/q?=
 =?us-ascii?Q?EHapkt4Xu8Cu7Z2AxIBrJDcCGOtJiIExie0JsZONo+POV+qDKHtwjv/P69zC?=
 =?us-ascii?Q?VRzbbq8Z0UbqskBRm8xwuobsdmZIhpXMna0CQs7Pmyp7QeB0lBvC/MZVubPk?=
 =?us-ascii?Q?1+uu4zXCP1Lo361VY5SLBTlkin1ez/YXsWOmuHb4GRjAos3iD/aYoDv1yRqR?=
 =?us-ascii?Q?lHnDsHdrnS25rPijhrn9/k1Cf2rx+7FZdJSTdfY2kD3LVUrq/0qbG7CAJ3PQ?=
 =?us-ascii?Q?zhCSpRvGl3tNMwCfypmOWtvTcEcJeNLbl/ovXaj8IK6HPi1DbXJ9xGNsaTuR?=
 =?us-ascii?Q?EjzddKJeahmLiyxF72jAs2SCRP03dRWmSSaAfebdxlszSvZ9e+bQHDqR6qQr?=
 =?us-ascii?Q?xuH2UZV2iAgprcg9YuzSVpHOUTlt/9HlfNc5xYum92AmN5iolTCc9x++TgF8?=
 =?us-ascii?Q?ng+JXasZk3tOLzjv7CtBZSse+QrUj09M7D8DsKQYQ+34114dDqwz6wPzvx8q?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2567e1fd-99e3-4424-c0f9-08dc84be6c41
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:47:37.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+eAl4Y0p4niP/ce0sr/HzLKakbuE+foPs6KV7s1X+Wl4YvotlQ821qTpA5h+7ptvZWG8wt/0K8pzEBeIdOIDevQImnd2is4DwrP3JWNu7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com

Perhaps change the subject with: s/Avoid/Fix/?

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_dpa_to_region() looks up a region based on a memdev and DPA.
> It wrongly assumes an endpoint found mapping the DPA is also of
> a fully assembled region. When not true it leads to a null pointer
> dereference looking up the region name.

Can you place the a snippet of the Call Trace here, that helps support
that the writeup came to the right conclusion, and it helps folks
hitting this error to find this patch in a web search.

> This appears during testing of region lookup after a failure to
> assemble a BIOS defined region or if the lookup raced with the
> assembly of the BIOS defined region.
> 
> Failure to clean up BIOS defined regions that fail assembly is an
> issue in itself and a fix to that problem will alleviate some of
> the impact. It will not alleviate the race condition so let's harden
> this path.
> 
> The behavior change is that the kernel oops due to a null pointer
> dereference is replaced with a dev_dbg() message noting that an
> endpoint was mapped.
> 
> Additional comments are added so that future users of this function
> can more clearly understand what it provides.
> 
> Fixes: 0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..88051bb673bf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2688,22 +2688,33 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  {
>  	struct cxl_dpa_to_region_context *ctx = arg;
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
>  	u64 dpa = ctx->dpa;
>  
>  	if (!is_endpoint_decoder(dev))
>  		return 0;
>  
>  	cxled = to_cxl_endpoint_decoder(dev);
> -	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))

Why add the !cxled check? to_cxl_endpoint_decoder() only returns NULL if
someone messes up and sends a !is_endpoint_decoder(@dev) to this
conversion routine and that check was already performed above.

>  		return 0;
>  
>  	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>  		return 0;
>  
> -	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> -		dev_name(&cxled->cxld.region->dev));
> +	/*
> +	 * Stop the region search (return 1) when an endpoint mapping is
> +	 * found. The region may not be fully constructed so offering
> +	 * the cxlr in the context structure is not guaranteed.
> +	 */

Comment looks good...

> +	cxlr = cxled->cxld.region;
> +	if (cxlr)
> +		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> +			dev_name(&cxlr->dev));
> +	else
> +		dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
> +			dev_name(dev));

...but I am not sure gymanistics to improve a debug message are worth
it, especially because all of the callers either emit the found region
in a tracepoint or print a warning, so I would just be in favor of
deleting the debug message altogether, or at most just trimming to the
"mapped in endpoint" one.
