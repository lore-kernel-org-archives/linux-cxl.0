Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E92139B6;
	Fri, 10 Jan 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533887; cv=fail; b=C1Gmkjo8H3QFHc9ea3QutJEcqr7wmgZaRgEHPF8XLtO93a415Aqq00y9dErtYxuRiFe+dtQbYIWmGuPmOz9z40ijgCoYFahtwz1KXQ7hYL0z7oO7kli8mcfnT0hGZ5TmLidqYVdcOBPn1vmdrWF+DChHZDD/BMKla1hhZx95bUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533887; c=relaxed/simple;
	bh=Qhrv7dDpeSQGdv/sJsFo4jszr1oQZnu18DJkrp+mHrk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RLPr/CU85XUvcmUw3PQQSyIhmqgDTGaLgCbgVxcCX0erQKLHAUfyu90Ysq+TICz4VsduPNGFJHdORY+rY+GGWZZoTDFN/x1FMMm11x4uYsnhXZhlI5nA5yK0QF1ThIWi27LWRruPgtYKVwq5fS4QgCUdFIJV+09pcMvOHPiVn0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoaLIvMw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoaLIvMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736533885; x=1768069885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qhrv7dDpeSQGdv/sJsFo4jszr1oQZnu18DJkrp+mHrk=;
  b=ZoaLIvMwuQ070WplMgSjNlsAWsA9lqmIh1570zD8IrSZ/1tn2fcMLJ6m
   m7PWMRVCGs+SgE143+y4j7c5o6BNya3gcS/FlTTR/1dWSIMqc0aY5wO2v
   jTDx7J4geIi7t5lqiejqf3BOtuy0bDWqVNGceQPEY8TTTwx8GS2qrAEkU
   B1Q1TuPKumTwWYX1J1bXdZS3UkX68CayKbwA44PwY9YJg1sGTOC6W+e9o
   kCNVfeyW+sxQlzCRpUnUNqS2jdZTWq+kUl7vP63wtaJsGvZh6gm09CFTS
   CPFuuVwTpvCLKedhTtU8CdbU1wNMddTX19r3UTzJChW9bUpN9hi3MGhRE
   A==;
X-CSE-ConnectionGUID: NkcJ+3m+QUiJ95G546u17w==
X-CSE-MsgGUID: kHvjXNpoRkye1jsnq5Q55Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="48203483"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="48203483"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 10:31:24 -0800
X-CSE-ConnectionGUID: 9hgrF+Q7RdOeAPfaTPeByA==
X-CSE-MsgGUID: 45wAqe0wQzG26oao1tX+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="134636424"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 10:31:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 10:31:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 10:31:11 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 10:31:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBBzT/6Z/99shmINGVYyggIoEYgSqOVn1hClRNeHt+jGLNzkatWg4c9nKCA+xG2p/cesnPN8+uSAToBGSPSw8Sl9UDMiHsOy0n8j4sI/QUfT3H00Tcxb2km1mceGVLPo99Dm5TSAVAZ3WkcZQMFaHODHIrZl62aHMtuyUvQgH/whasVs9FBo5BS6s6l+jErIEkEu5sf7JX1DNkv16HYKtuutJfShB/DKVP5Rh4WDyLbeLpBe0QyJ6b3JnBFPUC0hTxASSE8xY/hH209v7C0Wh74xYdHlZ0qq/ZZDcPO2/unsIgpucJ8Tpzh2ks/K0P3Ka6yo/tpFd+fH5L6Lg7lMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj7lDYNrEY0n8wcoywxOTQZY/YmMGOSEc5QJKVAM0Pw=;
 b=p61lwHa5aV3QAitsXl19mVgoOk5nhnxM9tV/qbikvMv1M4nXcbbVo+GU+jzaOKE5OxS+cFSX4FT6hLiIhMTUx56ci2/TaEM5G2oztv+oqVPT5iQQGKytw5GQvZqdVtsjakRtLSA0+7qHRODCGS+YiJKmfaRR7wGWeyhtkWZExJXC5iZi2S50JuU46AUQ6O3k2oVJYgNEwsiSZULWJy1ndva6HoEorUz9MSMhDVNVT5dn76edwKRgDvzsLO5C4dNTctPo8ul3OxVZGmpqRFu0/zp1e05AxuI+QdSbVQ7LvIenSFvHXbn92s0ODIJyH6dNTq0COO03JEvPpXQu2gSuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 18:30:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 18:30:38 +0000
Date: Fri, 10 Jan 2025 12:30:33 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Message-ID: <67816749b9eaa_177894294ad@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-4-shiju.jose@huawei.com>
X-ClientProxiedBy: MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: c599f2da-477a-40ed-f831-08dd31a4e176
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fEbEqY2i3UHQ9X0kipiv5req7WmJz92UfRUl+erS3W4bUoevMEsOYeS7JMS/?=
 =?us-ascii?Q?CMCIwdoW01sBsZDZR0sWYPRbKF1KdpAJ+drr0BvROW/J90l2q1NUs6Wlz3BK?=
 =?us-ascii?Q?UkF33MID3/VauOLKgjvq54PF7fv/8r9RIYloVCDPa2atYRMoPsFjX+oGdFnw?=
 =?us-ascii?Q?syakKR+yavVKtSj0ojHaEjm7mvsxmE/X8SRf37yagIidNXJF7gnXpj3HgBSY?=
 =?us-ascii?Q?B0KUKw9UVWfAa8sP/9SuObZI32OR3I/WP6SpmOOIbeyTHE7RyG+0eVlSLCVU?=
 =?us-ascii?Q?2oHe/upzkgBkwXKS+rn0Jjj27AoqRuamOBC8tvmABcLlo9Jv+E6fU+jVLSSj?=
 =?us-ascii?Q?qvKmk0i9z5ejQfo6lPYHBCHHaw+vDIUqAqt3Z2YYLQW5GPv4fIw5g3zjGRG4?=
 =?us-ascii?Q?9pGirTS1hYlbmcmo1rSrgYmA/SJXLaQdmgIVeiU2Vqsn2tY2aTwmWPkpvyJk?=
 =?us-ascii?Q?APXEvrd4LcgsQEHAfc80ElRM0YaG9x7JtsRevgtIZibtlv8NqOCO6KZRHnhA?=
 =?us-ascii?Q?Sf2ctBWyJMUSQmUZDqCJsMpOagMA/10WYyoLEm4bboJQU5mATXaV0B8p/4ha?=
 =?us-ascii?Q?ksH++MV5/uBXvnNDZuBDHAvsuOp9TVt2squBVeQEDj9ZImaPJaKVARB77sKy?=
 =?us-ascii?Q?e/0e5SxI3etqKFl3V7vJCY4gybJFA5cdQ2gk8hjzZcHDDt6k1okRvV4f628T?=
 =?us-ascii?Q?ZlIh04eWMePEAb13ub+/Y6+eay1EYGpnHa+9ncFWBiOQ9m6GU9WkuBehytbH?=
 =?us-ascii?Q?JHKdo3t3BBHRUpIEVzN58wnv3VXKcOqjX7oi4toF+eJ05ej7WfTtXkqmRlV6?=
 =?us-ascii?Q?MZztiYoVCWVT+LCentXr+vzm02wwI7lrl8GQLOjsGuKQovRxqY1w+iVK50b8?=
 =?us-ascii?Q?QA3hZnXf5853JG6Ku4nZNGbkWoK3xka6LOPCSxY1bNHaxBZrPtzDvoiMYoz2?=
 =?us-ascii?Q?0n18q4ALoja0yFglV2TvIkmP0Nfr1Da+DaEYeZI3kkHYnkVR/Txshn34wkb3?=
 =?us-ascii?Q?3gmv1Ej4HNOCmk7NTs5JDC+qU3+NEpBx47FAnI4mFwC/kRi5Zx/VCams+Bp5?=
 =?us-ascii?Q?UMsc4WCXW1OER9xyjI+sPKedcjFAkb3wDSscOEyeb6E1dH1CsqAQnU34sLTs?=
 =?us-ascii?Q?iB7yMOgFfetmrUKD79Ji1bt3BIaDp6poKcVTFFzAAINikemA/1bUuQyBQec9?=
 =?us-ascii?Q?joj/VhV0A9iAuVU2zcX3lwKRaXKphK8GuLbKBcN9sjwDGCp4FGuZHD+vD5F/?=
 =?us-ascii?Q?VrqXVi6QkzyBNyuCBBDJzPzrkJRdRUYxYFlHC3NHSLUzAfkXN9Pzz9tKkHC9?=
 =?us-ascii?Q?pxjghazY0Vz3j+SKQJpqcT76NWzKhbqb3jkMtn2MBycg3j3xUfE0N60bG9Uy?=
 =?us-ascii?Q?VAkXUjTiDFYsZZ9IdpnwtrrP7V2bNSobN+qbMriCLf8Fr2koV1dJoiq2NZSj?=
 =?us-ascii?Q?Dd4VN3nwmNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ngtcK2/JtAYLK769A6yK7X+yPL2yTnkw+emUWCj59dKgWA7BeGBY835hda9Q?=
 =?us-ascii?Q?LR5qLJ983KFauRXzf01uCPQrpXWhIzKDiaXAQmmK8thePMnLYnGjyqBuuoTb?=
 =?us-ascii?Q?Nuc0c9/Ih5LtXdyPte3odaY05A9dfNvEjd+0fbjwbv2jEAOc0EduNnCAD25T?=
 =?us-ascii?Q?RItfXBikccvA6GpXxghsiuIRPdmrfxYyJhhlpVDADYBEoAjwwUc9faduONyz?=
 =?us-ascii?Q?qbeYpW/EL00K0mhQOFdHDLR+/XFaP/BsT/GKkSzkkABmqNOx843AyUbTDkyc?=
 =?us-ascii?Q?vxaoaD6ub/riwXgAmqApKsNrbmeoqCd6jTzoS+p14/+8YVwXVfYvEKMU6Gt8?=
 =?us-ascii?Q?jvLG2VvbZTKlccbi9Ek4ndOQeVhgjYoa/dpVGDzhBP+w6gLcR/NWNG1NaivE?=
 =?us-ascii?Q?xshtx0QVHdzkchB4FVLG2KzjkMjN6JyUsOpNOebEIq0TVmRufsh8TNfhqvCs?=
 =?us-ascii?Q?/3W+96peqviInx8uBw2HMOnGwoNxjh1mPkcNhzd0AvmzM9zs4JCQoMQIy4XO?=
 =?us-ascii?Q?yDLbIBMExDPYQUxgai9X6dx3ME/+s38sgL5d0k0jbR5sORR5I+Jt/zk1/S9R?=
 =?us-ascii?Q?XB4Z1qVkbN/gfZkr12I4jhWVX5x+8zO/9UBpFYuGdYY8NHv2uyptRzO7OJcZ?=
 =?us-ascii?Q?LSqNgEAqJSOhjsaICctFJon7nXFHU3CPh47omrMVvcsSVROcjiS0WPpE+N10?=
 =?us-ascii?Q?z8OhljT7SrsGXXGIbRzoj27Ggx2OELiosm3SWn0Hnmwh13lxtS+FYd7bqLUY?=
 =?us-ascii?Q?pVf8yLTMqax6XBjpPO7bWrfaj6g7x3rTuzVshSnkMiHBMuGD5q29Mc6Ucn4W?=
 =?us-ascii?Q?9pHg9FKp1uV55AsZZKICqMk/NhMOvs0pUEbujdeSJTH0hJUalHNOB15qVCOF?=
 =?us-ascii?Q?v9/BpOOzpbGepxbG0iXxN4YHOScvhX5GqGUb1B/lGElozALiNP3fH2J5+HAQ?=
 =?us-ascii?Q?0S/GXgDTEjHcHHAGRqhz03TaHJVuDkb3vF7QpEcfgTBLkeZ+L10AVXYqx7WP?=
 =?us-ascii?Q?eN8h4OSEqnaQPKvqd34cymrxstmWnFsIs8dOhV+7ur76+EAk9oI8CUjCvgOQ?=
 =?us-ascii?Q?GTD8ToLJdLxrQ086abQi6mh1g1zJ3mR7wmJB88aH2ARBu9gly1bZ75qaWnY/?=
 =?us-ascii?Q?ERyy8jCVFBOpiiY3KXBYm+r4c4oN33ZNvW/KEidZHSS343eLEop4QsRbVvoo?=
 =?us-ascii?Q?IVYp7gI4BaJYB9Zn1eHMMv1ara7FZ93+witGzQmHAheXI4GsDTA8ux9LeVAA?=
 =?us-ascii?Q?cThk+4JBaoYSuKfYof5LBGKw/ZnndgiQtS9LXcLaXwE4KldETFKyjwA2A30z?=
 =?us-ascii?Q?5QYcjKOUSz2bCDKoffX4c6sf/uJnVuGqkV+GPPhdiiTun3Wl+fa5zcGa6h8n?=
 =?us-ascii?Q?TWM28DrJAbPvzlXBuiSesuHqgpfRylUdW0sqEOqWxnN7Gs5jcyHmYTJEDl9D?=
 =?us-ascii?Q?g+FqdgrOVhGag/eKSNPInvxbBbMue8ZkJDmxxRqCfe2ZtAFFwvz30Rgk/pat?=
 =?us-ascii?Q?Drpsy6e8whLSlBO15NMaWJJ2E+oTjUAKgGC/Zoq/gg7NTRLg6mtq5HF0bJDR?=
 =?us-ascii?Q?9P1O/0BPCu8Uy0UbM19J0zu92MlRogb14k5D+smV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c599f2da-477a-40ed-f831-08dd31a4e176
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:30:38.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d08FFgt7/mVK9KNw5RazChZRp/uC/tBEsJpBVtHlLxLekxXht4iys1gmO6Hmbq1O0TOfSbJ6Xa6oITY22j7djA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 

[snip]

>  
>  TRACE_EVENT(cxl_general_media,
> @@ -353,6 +402,7 @@ TRACE_EVENT(cxl_general_media,
>  		__field(u64, dpa)
>  		__field(u8, descriptor)
>  		__field(u8, type)
> +		__field(u8, sub_type)
>  		__field(u8, transaction_type)
>  		__field(u8, channel)
>  		__field(u32, device)
> @@ -364,6 +414,8 @@ TRACE_EVENT(cxl_general_media,
>  		__field(u8, rank)
>  		__field(u8, dpa_flags)
>  		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
> +		__field(u8, cme_threshold_ev_flags)
> +		__field(u32, cme_count)
>  	),
>  

Reorder these as well to pack the record.

Ira

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 241c10596f4d..39e83b8543f3 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -402,7 +402,6 @@ TRACE_EVENT(cxl_general_media,
                __field(u64, dpa)
                __field(u8, descriptor)
                __field(u8, type)
-               __field(u8, sub_type)
                __field(u8, transaction_type)
                __field(u8, channel)
                __field(u32, device)
@@ -413,9 +412,10 @@ TRACE_EVENT(cxl_general_media,
                __field(u16, validity_flags)
                __field(u8, rank)
                __field(u8, dpa_flags)
-               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
-               __field(u8, cme_threshold_ev_flags)
                __field(u32, cme_count)
+               __field(u8, sub_type)
+               __field(u8, cme_threshold_ev_flags)
+               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
        ),
 
        TP_fast_assign(
