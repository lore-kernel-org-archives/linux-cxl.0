Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962815A8
	for <linux-cxl@vger.kernel.org>; Sat, 30 Mar 2024 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711763618; cv=fail; b=rcYAx35FI3CCxkoCVhahWFLOHLA6Vy3lSIlG0imC28GBPijO3yIRsTiGpSPeJEGiGbaMHL9BVOVaVZfjxd/6nA3Ug6bsZRgnCLWDz2i8a4QLrDfterF1uvijBijc3dl+CN/NSGPKfqO9sMNkeWrSD16FILwiKlZGRVQAFoDGIaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711763618; c=relaxed/simple;
	bh=wNdbC0mo8TWYh6F3oD6M3nZYNZPs+5ayWBfwX6oreEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGsJljLuzBlBaDwsQ/EKGg9N+M6b/g7n9poXZWvql47h7hasbSWi6J7TkilQfy/0T38VjQkCNfnHrGekBT+DmCdE+fQL6xNC8jdhaPYlU2AtSdt1BgGnqXcDaM2keo+OvBcCXosXJjT41TU9+MSU8Dz/wzsDRI6VSH2Epfdn7zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dsafejvo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dsafejvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711763616; x=1743299616;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wNdbC0mo8TWYh6F3oD6M3nZYNZPs+5ayWBfwX6oreEU=;
  b=DsafejvoNFJ9y12sKpwb1djSHT0mLOI7FpI4uUGbLuRPhvGvFlnJNcy8
   8REIsFOZhLcwRYGBKYwQUGtOUBBW6nVKx0bjuFxrAqRQvsvxDAL1E2FFK
   CcTeVTKB0IJU+QDla1N/7/+YQiQ9WxBwcwOx5u7Pilqnsv3Be6yQ/OKM9
   Q3E2PPXr9ldrohyCVmbSx91DrU5iyFqng01IgO1cnZaUw2OkypTHxrv+s
   tMBOHH2td87K9M2pO6dhv7z7WbBGjhBKj5hYXF8nM1rQjTYiZ+5EvZxaJ
   cUI3wJ1ZBkEAbhyZihHBVBnxQ38Zifqf7Sz2A05d1nyoLsLBpBqKu0G7+
   A==;
X-CSE-ConnectionGUID: xZdUSa11R86hiB9SCPiiog==
X-CSE-MsgGUID: ySEwtK5zQWaCZ+1Btl8kUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10745673"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="10745673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 18:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17022821"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 18:53:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:53:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:53:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:53:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUTHzvC59kl1bkOjJCvXK2YBaPUmuPcvMTb1QwfDuI5IsQwYegLPiJrIw2rFNuvYdBWZzQWTeJO8wAEIOXizeVaCpKhEmFQPazx78ilhsik96AnIr7JjedZoKChYw7Ww5dXojGUKpZ6y4uhwglFO9fm9hwqxdeZiyZ29dWnk+MF8P90nTzr7ApiLtLtbFPhbIsZiCMoNk66mj5+mWSZcIH/+dMVvbJii3eli7IQi1lSxi/hVNBVhNXPrs/Rkyf9hiEBfoG+lIoVFsMDsQ5RkDvwxDNjKMwYvWZUWzqqD64DXrHh95iettBtGkdsMnjSyT8Sjtq0ZmGWRMgYAKSGnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAg95+08y7UTaxVIrTBe7HPixpPsTjbqnVszORqbazg=;
 b=SniaavQ3fyHupmbR02WaZX5Hd1eTcQfjGs3zrlDuutO7O9DBVzvt5Hopky96svyJGEONksNZqz22cJInzXr64Vo1JtM5nJD/CEA5k8UQld86cpD3xYA30ngY7Kr2Q2dzixRqn8EHBJANSst+iWWwfOxnh2gVTbld8gt8eJ5G5CQqmqivogXhATswp69TM7/A1+kHk3L+9uH1VJMMCMzhBMrQESTMC2ZRYswaHCyUBwdBC/zUYv13wC3pCplKRlvTlJs2FvJBhH0Qq1RO2GeLOq3T2EhMulb7etVrzwdp8e6QzHkz9JlbzLmx+FYGWqKcsVg8jjR37zDsxgaeSmqhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sat, 30 Mar
 2024 01:53:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:53:25 +0000
Date: Fri, 29 Mar 2024 18:53:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 5/6] cxl: add definition for transaction types
Message-ID: <6607709266053_19e029471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-6-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-6-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sfQ4geWE2d4D5+hL3I8wlrC2ScSKcxi+tCaUM1q+ahUJAyUqkZH0UzIXu9yZ4sRAf7sxVnt8k90EYWk8O5J55YIDi8ddLpCjQwnT4Ma2xKPanrJmvJgbPGImFp/1SkFodFX9qMjoheyXouc3bDNAKJbCa0A4cC7WWOP/m0jQSE4NWyCzOcyvbh1ACuPZjLsTuzuig6os4xlepkOaKAdLcGoYLz8Py9zhDfyMyuLDMnWnewSbGLlemhspeKV3opU00P5BN9vKV1sAGST4R3RfOpmv9xJ2BrNOGnaFydYcwAf/7niWoiMGoi8V8HkGGRsfsPHGMGWbzQOO90MQx3rIdj9bTQ3BiLWrvCn/syttNArZyjC8dHDh0UkkL553OkkykWegrnzDiJoe5pDAboT82K9TujeERr8cxNJpr0zev6En7wan6YmV7v5iEOqCYoywf0fl8B3gQZehB4i9xHz9zWvvI+2drtkeZy4yOhRcYKJIeTpgfOGZSCL0lXbUvhaQVt4j1FGihvJYPyfAR/ZDm/pWyY4iBwEu/FhYFO9xW3GuMCq8PRkN+HuxNuaxdacgIduuYnCVCiC23e4lWMnenTIjBZ+77S9HS0R5QjBOjxcabIb0KZLBIS9gJzzh3jv5jLIVE2hUZOkx6UZORVUc5YcfqNfGaA8mJR6xvk6etU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqS6qpLyhDGKXOuYEWIvHmWxhM2gibvO+o9HHoAlGawIy1rFnowhf3/4K5kH?=
 =?us-ascii?Q?vXuG3tzvSG8A3trT8jLchv1bvQbIqRXuF5gWD634tdgiGrIdoysQxahAn8WL?=
 =?us-ascii?Q?UMa7DNoGRexYZMf6Q+Tr/Sv9A/6f7ZlYxyFh3dTzesMv2gcEl1Bqkuu47ddx?=
 =?us-ascii?Q?LqA3rb4ppV35JNrcOpoM8UUVX6MhQM9GyKAdIq1xsmUv4rqgy2VrzckC+6Fv?=
 =?us-ascii?Q?z14BxJW8ExgCvTR5qYrnk1GXF0lYj8EQFlGL86MTBeL1GCjGMDuqqrOWI+6e?=
 =?us-ascii?Q?FwTamb1LkqxrkV7LxPct3JHqicmzYdl4d7L3ixSEfFVlta38hRxWYoXYEWFf?=
 =?us-ascii?Q?XbwfMiZxsUtwNGZkh5Y/zJzWKgp+x1x82g9P5TkfKSh7NVTLOgxj4TNpKrah?=
 =?us-ascii?Q?YJpAa2j1Z16pmRORUFsGk/8hFqHEmRKkW/07XxXeKlm/O0L+FRXYnFrQOCRO?=
 =?us-ascii?Q?0XsnFeoXN7cN9YHJGLkdso6148hKNPBKoUBEXw7NV3vzm9pbceegVPsyH2Ao?=
 =?us-ascii?Q?Xdr5b1QBjf1zlF5tVw0MmY8vLztxPLxQ9204c2PPdfzQt9MtJLZdhL+aP6NN?=
 =?us-ascii?Q?llJ58I6vcUJJ0qzlkbNM2pK5vFDaQ1YmEiShGj+6my704BzYVEKfu+Sidcy1?=
 =?us-ascii?Q?DRAi4u4qmHiiunmbrT33B+FJXy9Wh4ODWJFx5E7M5Q7joLQxkcVjooOYOWm7?=
 =?us-ascii?Q?YeX+BmlqeSy4vnbwHvCdfbxZpcOIhYzavURENv818WDLwyD/dNX/XCZsq7lm?=
 =?us-ascii?Q?Y0wKlpnuq9A9sd2i/L87u0/1+DVGKXSe3Hp4boRYzMaISlxjJgOAs5mTWEnk?=
 =?us-ascii?Q?hUFwkFlYthjSHfZSoHmlPN8nuFMl2mUypNOBPwetd/yEU8nHyxc1pWLKw6oF?=
 =?us-ascii?Q?PJkrddX/QLkNfjoid+qFTfzECstgkzd6yPMsSBFnGQl55civAuaie1qz5Rkz?=
 =?us-ascii?Q?jb4XjOhGBd355FU8soMP/MYm4IB2YmJbINKksCCOGXGY783oIgdoD0wmpDmc?=
 =?us-ascii?Q?ngWZYkISiucmuj8Fr7XWHqEeoZE8AWcDcUPkxHU9gq3pfbVA1XTxT40T/lpo?=
 =?us-ascii?Q?4Pu+jOIM9bZCs+O2fwtq9EByRaiTm4gSLgb41E08G4sBg8r2Vh3ERhIGyO90?=
 =?us-ascii?Q?+H+wQMY3BCxw0Fn0liE/yIhIATUC6fS+GH31MED9rMnHzBO6QHK2gF+5TAmz?=
 =?us-ascii?Q?K2okzTbOKgPwAbiIO1OE5G6Lw6CBCl9CyQ2262mRr+PzC/viNrwn9QholVds?=
 =?us-ascii?Q?kJlSxhcNMcYq/TmbuaD4I7xi1EPC74l4F1SYRp4Mv98XpjBcwZAUaihwcbzd?=
 =?us-ascii?Q?T/rX83H0L8uqKtxJ6iFn/gy85R5xFKYKdF9a1D1NKccqyT0gmjerYRuNpf9t?=
 =?us-ascii?Q?ins1TK+2ZEHO7rT9bc4BGQTQjqmVBUGZt2FIfJOh6keSpsiiIoIBB44+ePfs?=
 =?us-ascii?Q?y1lPgoic3G73ViE+m1Kzz9SV0R2KuA49nznyfqO9KwsxS8ORnYtQCXwEvz/V?=
 =?us-ascii?Q?czN+NNnw7+1D/n0yqiz7Kncx8O8uc6tZgP6ExX1BRR21L5FVEVqHmNI4V0Tw?=
 =?us-ascii?Q?ZCEOPoSRyNgEoO0fswrF4VfSUjgE9G/lQkWLa9gsgnoUoBNeB64RYVXZsE3n?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7254f7d9-5223-43a1-1a73-08dc505c2fe1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:53:25.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/opD6q2xhaEZHI3hbJmEwVmYnXYgJld3wsEygG4pGkJzFYIECTSpKWoyvT+HbjaDOKqasJes9AC5y3KJjYZvnqwO1wpH4P17rUWzm1XKo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> The transaction types are defined in General Media Event Record/DRAM Event
> per CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43 and
> Section 8.2.9.2.1.2; Table 8-44.  Add them for Event Record handler use.

Combine this patch with the one that uses them so that the use case can
be reviewed together with the implementation.
