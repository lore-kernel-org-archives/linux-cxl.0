Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8134D397
	for <linux-cxl@vger.kernel.org>; Fri,  3 Apr 2026 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239139; cv=fail; b=ZBFbhK82HZryLunYqlnrf5yCAwuEwfIPuDjnrkoDcMvvrwitGy/Ff2XiLS3MsT/7w9qFEtdngAvMYKxCm1SQBb407NA01mR79dht9ta/IwIQaCESNStVXJVqCCAQqCC6gJVicw+OnLxjLH4N3J+kaIJ+CviVmdm84PR14VX8/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239139; c=relaxed/simple;
	bh=ftCCs04Uara6+VoPmjvMLqYohpivFcWlY2srRvZyGDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xe3U1Ea8BhRjBdYam9MutYWzTzLSrRrCJT9jfsLa9d2jBNB+SuI2fu1YGzl0EZHtW0Mt1XOsaO0QK7t6CwyT5XQYyysmG3VZ5lYkw7prJUvwUi5L0SOiPSKY0ytLUatcZ0cg5FMHg/Ps4UesHtf0w+5iFAHW9zvqK63+GSGLTTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmDE8d/d; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmDE8d/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775239138; x=1806775138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ftCCs04Uara6+VoPmjvMLqYohpivFcWlY2srRvZyGDw=;
  b=SmDE8d/dfkNyjeoByqmoVvmtxDRsjKQjwSfuWGe1MGm5GLuHLuZt9HN2
   3+fSEaIzrog4AFMtYC1XGBgjU6cpRw+NkaOnw7uOvobgP/ZmUipxxqQ2i
   1jM5KkwSJkk6zvGuhnGoIBnRJ76fKHQF+Cg2/NCyyvXC9rjCXWDezxZin
   dYwXnWjCDgBqs9Ksnew4x66toReLfgTiGLWAEQLdwsI898SAHe4vN1vfg
   wGciXCe9HMQeIC/4czPLh+/+Qjg1uF6aOD2n6TS6qYIYMJPi2hS1XHbol
   K9TK8ccW/e4n85rUQwdlpS1VsonJ59zJFzD53RwyFB4vRwnoOtpnlA4mo
   Q==;
X-CSE-ConnectionGUID: hoYMN9ytRam9pbgO8W56Sw==
X-CSE-MsgGUID: Wr9K4LT+SAS+Hf2q7ueVDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76422778"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76422778"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:58:58 -0700
X-CSE-ConnectionGUID: 9KN8wifmQgubrdMszgreCA==
X-CSE-MsgGUID: HkmjOXDeRhee2TqllJgMZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="220674467"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:58:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 10:58:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 10:58:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 10:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRzAAvw2p0Ky0luf56px6e+ADmm235iRWxqgMIO9zH0bu1Wvm4CYy/0rSTY35pNeELN6p2lViJ3qWy+5dpQA9YRVemeWRiGeKBAGWCnmwSzUeLx9VQWU22q8buZu4DR+UYHughkrtgpBlWLh6aw10VcYyj0hPMsARKW9feAx5UR10U//GIVUdcEj91du9zsG9eD57cRu4OAr5DKiIsq/ImiY0MqFCfCZ6H7kTI5abF9kbaGmQTmPvLITIKoFhOEUVBGYbROKVDJeA5LfZF2QeMv8ikGk5kqBfFvfrIykraa2yhrdb73UMmU+FGoIiPioQB04bHiP7Ha2whPCM8S5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0dNlOaVUXzwjWnGwUg59ByUKR+1gUo1m13usRMiiyY=;
 b=jFD6TKujaKjmdhxj52lmx4hURqt5uGuoPMNv9BVhhst/jwvRrtj7t3gWRPwwgQMDqE83rXnbjcq/RxhQ1SrONCfLPL614MWVP+HjjRSOmYh0kXNW3SbCf1R2+qBGP3YbVFdczdo8FM4Vo12Vmg73qO4wF5Kt/VsB7kfZKCEhf9EkIlAWStGMMFOWQ+0ylFU0+r8BnZTymZfVOFizCFXNHErvmrb5GJl6i8Gg183+/3J+PZpPWSsF3CLgJHoJx5Y9Nr5ZB2K28a5oOnINDLInF0BkuvKcrQRRRJcXMm+vBma2LB+EUhxPjl0S6yoAWbuVZr6r6f1oQMl4FYflRyl/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 17:58:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 17:58:51 +0000
Date: Fri, 3 Apr 2026 10:58:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v3 1/1] ndctl/cxl: Show region locked status to user
Message-ID: <ac__2GCAe7dUNDBI@aschofie-mobl2.lan>
References: <20260403050459.2236-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260403050459.2236-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc145aa-d991-4907-52aa-08de91aaa9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kpcA5JOdthM4KV77GIjcZdEpTNTgtJIae42lu2M0MR3XFHZGB8uV7/Kn+kYwhiH3Ily0MVZ6S3gPbp/HThj3+RVm/tIYE1/HTRl1a2PwOGQNOQWNwKUeBgw14p7eOO++edva1fSXzIg3N+BsYK+Ub5M6k+D7yJJW5gOaSXtTIhNvvTGZBHBHFHs3HDVtwD0k/i20WTjgIgVuAofAPVKMLJjjr5iA8zjza1ngGL+3D5QxLrAcD52dym1thuuKYwGP7ggn0AF2rK+cLdq67a6+H6f7Rv3vQNougEux5HLMDHttGXuQnzI7vavmN0TOKeQnIEI2rTwEQG5P//B+g06oBmJMARZqBWSBL0tcnrV8fRLteCugXKqnnah2JqzGpvNUhgHDn2mOuutIlcfsrLE7J6zyNIVj7h3Bl4xM3sk0fFs7L7gGz+oPWAfhQwq+SH8Myfa3uvrZU9N79qIj49b/WunmXKO6ca5nqyZkwsuE/SrxO02xG/Tx3wUsSva6bVZx7l9HeZPAhk1cAG5wHq73SMdb3OZaO81QMoTQ3XL7iHrbvjTgwRskoDosKeovLYmLEZviSI8rxS0DEPoiSSGJRh8qgw9tqJ6CW0HtS1XAR4kRSspXEEaYvC62m+6crtps1FqGzFwyf0zqt1uPUgaVw/BsG2Ux4gk9ibdNBluX1seqbkcO6e2g3ffpaHuIvGmsgbcW4GZfG7+0oqmljpr8oohUWLKN4+P0eAME61fjNDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ykFq9rVdb4nXOgYBEWqFGFF0g0CCXY59a/xIMDx05gKUvLCFmfD6nkUgGxlL?=
 =?us-ascii?Q?Hy+V/vmwYjHTX+aRRn5nnUPYsfDnHcKKgrWsuKehVTaeRiLzF3UFk76oXnaq?=
 =?us-ascii?Q?InaSRnnYKVmcWH9tU5mS5azAKTuSHI8vvMe10VUWs8YVRPKf2Xqo9I1onmS4?=
 =?us-ascii?Q?E41KVlQ3cLQR/skHQMCBEV+CDpG4tagTrqQb1hUdICeyuEFzdVYyyQ6uy27G?=
 =?us-ascii?Q?M70lYK57aejyaTphTcmJbJBqYnYCd6hZgG20ThIqCHrtp4X6tUfvzayT4bfy?=
 =?us-ascii?Q?iBZKyHxYTuroTonc973Id0hrNGobo738f9q/kNtHu719VdIpDmx/LQ4enbjb?=
 =?us-ascii?Q?07tgBKNgan5/IHEv2gI3f3tMehA4PMLXHNIV1WPHezEztDyJjXkPx9CGZfEg?=
 =?us-ascii?Q?14J7Btf8N0A/ApsDF2SrU4grkgYp/Olrf+kpYJ/F+YU8wu/O3hyCI9ZcdoyC?=
 =?us-ascii?Q?lyy/a35eKF1SBBjnVkz7pZRFRAvF8W9ep/5+/fbNWs2+OTKGpbHqlKc4HWr2?=
 =?us-ascii?Q?cGtTKRcbVIzPVJIBRJRyJ8ztjtbwNqct5xNuL0GFEy5xEOopclm0dDy3CE6e?=
 =?us-ascii?Q?QG7qSlEdRV3xz4NOmsU/ypJwpjQdS4NNnfAMe2bPWWxxMinLIrDaSID4LT0J?=
 =?us-ascii?Q?GdvWKXvbbViCTXWmQkBmqDqmO6TNe+wbK1bdGjo2RQy7xkae79AMKzk2PRBd?=
 =?us-ascii?Q?tVf2F16/rrdZFYrazNgcDLuSApXnPGjIq0kGsQHdR6ploOo2IXQLjHkuFYrh?=
 =?us-ascii?Q?8qGk2Ml0srlVRfuE5BrytV+fL/5kYy/t3an6vJq+niqUicm9s0D4qGu5FmrE?=
 =?us-ascii?Q?2KxeSX4I2b2O83FEalMemWw4UP4V4Bb8jyQi9F4+NO5WN7ibj3lEEgcmLhKz?=
 =?us-ascii?Q?eWc7f023s68DJ/qJ8PI9Mm1Geft2PulGSdHYLV9or4kH9+DorZugvivn38TX?=
 =?us-ascii?Q?/YvC1oF2ZW065hbBE2rQTAvJcUTtdd2jo9oR50UPMhuobKzhZsEExcaluHur?=
 =?us-ascii?Q?ZvkSvKuhAy/bH891f7v+pVupTHfM3xR88VRkqIUsL47CdG7eMkLy2VAQAPTe?=
 =?us-ascii?Q?OjjhgJ2CNo5+pJ/1jiwwCkYw33Bcj5Zo1y0Y1AXix1Jh6KscJU0kerZ/pF8j?=
 =?us-ascii?Q?Bkfo/J898SiNeOnSaIxJoG+bnS+rczTszgj+pWj+vgMe/YG4UKVJuzi3iaKs?=
 =?us-ascii?Q?flcO2V3JqiGYSOfEER5/hXxiO+Y3ffJcwhAmQefg1nydigODO1WvYAeWsXjN?=
 =?us-ascii?Q?chhUYxhFtUH6ROn5LtZuaDTO1KfTE5mInZhoY+zuzUnR5TLwr8LnBbnMQj7J?=
 =?us-ascii?Q?jXnrwRyRbhdlvIusVPv6LqJKWA+Y6fXLfh+7nVIrrX5hqSVKkVcvAHMH7Ysz?=
 =?us-ascii?Q?r1rNnGRwcmHUW2oyDuGUDj2zBVsokhU7s4RXcocfym6Up997H84avIYiyi35?=
 =?us-ascii?Q?AtvfbxEJ/pyBLAsb5HfuUWpO/+UzYmyymu69irXleFpdDGUap+DhJ3Shlkpi?=
 =?us-ascii?Q?27oOkB1zqByBSGJ483WEG/UJFsKW8VUfBzAt4ep/BQzc5jrLjIduh8TMImhu?=
 =?us-ascii?Q?NPXN4OwH0FTDkey9cJlfPDJxr+kyzyuc9ZZJztOkUV92Yv8iOeXdiOyy5gQE?=
 =?us-ascii?Q?FaOGFCtKzm1tvhso0USO+6P2gTmzDVlDoRtOVAo117V6szEcYkGplJKYzU9h?=
 =?us-ascii?Q?TqO2dvk6S9swDpJmMk6WL1dGQ5KRHZydZHyDyISNr6tkKhCORtvsXAfWo7La?=
 =?us-ascii?Q?E0BGZ8Hk8y4E29em3o55RU1P6MRi8H8=3D?=
X-Exchange-RoutingPolicyChecked: c+zHaqFd12y18H/fYXNR5B+ApumY4TOx9yNBXAdNrtKPn58qCOibn9/JxCdkMDiZAUyqNMZiMIQxxl8bY25Z9RLtzLltRZMdynImWPNC1B8QH+Q2wmDzLbBZnQyAK0SrMzqrN4Txh4qOH1rJL1pZUhzuRqYq1BbIGa5Q+NcreJVv/lGLUcV8OX11vsLFxmhnTV5OMM6B537Jwu/zauWLwzcyJlYrPGUdTZ2p4vkTPMdLcl+qkdMrbOFXi1BRwo2YY4W6/eC7GgiMwl5+VqPoRETs++7swRs1T2XqQq3zxWRW4S4mcBEjUKrMBz9KDwgCTGTdPNpNGVpvGx1VI8Np9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc145aa-d991-4907-52aa-08de91aaa9d7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 17:58:51.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCzy7D6gfv3epulvdIWG/hVulkG4vlMi3Yj3Zulf0QFOgjHkQxl6Rx285Yet/bCUEEXup8ffLU1pw9Q4I8B6BkYWpmL6aqHTsNtr9+cPYbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-OriginatorOrg: intel.com

On Fri, Apr 03, 2026 at 01:04:59PM +0800, Li Ming wrote:
> A region is not allowed to be destroyed if it is in locked status.
> cxl destroy-region command will fail and ask user to try it again as
> root, but it is not the real reason and it will confuse user if user is
> already a root user. This patch will show the region locked status in
> region information and output an explicit log to user that operation is
> not permitted like below.
> 
> Before the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> libcxl: write_attr: failed to write 0
>  to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
> cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> After the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "locked":true,
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> cxl region: destroy_region: region0: Cannot destroy a locked region.
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Tested and applied with changes to use the enum rather than rely on
boolean conversion.
[ as: return enum cxl_region_locked_state from accessor,
      map sysfs values explicitly to enum states,
      replace enum-to-bool conversion with explicit enum comparisons ]
https://github.com/pmem/ndctl/commit/7da4480

