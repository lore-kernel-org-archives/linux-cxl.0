Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50717556;
	Tue, 21 May 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309322; cv=fail; b=OBVsPVLzcU7q/X1FywJMspHFC2IhknEwWYO6mplW15iR3/DTS9pDrAVzP6OsKW89GgL84XsJq0hId3W492RDgqogPFz1LvvEmDuu0tk8pNLwkxlzwIXmmttlHHHnOn+yN1HkMZFUIN7QNYoVIljuZFqqLtxEAbaH11xXLgScO1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309322; c=relaxed/simple;
	bh=Aa4XLFroM2ov3hRHWEWreUITFIG+BlfuaPYSkgXNk3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwtAo9OTIy68xVokLZa9Z7vHJ5U3x6aK2Fo/OwomMaRcTsr1CN4xLJfrvsp42ePHZbOmpIs+JhErvwKB12LFA3uS82M+CK6ysuGOdieTFEeo4YzNBLlgJKHJ/ueDM16plvixynlFAwiVuRh0m5l+D2kzSESJahCFAGj/ed6k9wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7v860Ve; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7v860Ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716309320; x=1747845320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Aa4XLFroM2ov3hRHWEWreUITFIG+BlfuaPYSkgXNk3I=;
  b=F7v860VeOh0bw8IXADlZTv5Dnybbw8Epw30eN6dQ8h4JSp/A4hCJAG66
   LYNghly6nUcGK/kSA44/M8eqVQtGbdece3w492rAXWsTbfAA0u8Uqe2Bh
   1P1N5Hdj2+CeBt9aBJUka5jQr/z/8/syDYIj9zk7RX9jTc+wc+p3Li7s6
   rxeIOkE+TN9q1izBwM1aA/P5f4PcYSKv/4J6vmlrwKBaLDmmWPFYogNXB
   fEVwRhpt6Ky1uJyAtwsBsgvCNHf8QzPlvYU/TCPp81NfnmT2vggCmkETI
   /f/baAy3A2fBkm5HH2SwtKuHxSCLiNcQuKD7s7mCchNZbymame+BD0d2E
   w==;
X-CSE-ConnectionGUID: +fuB6RUETYqegH5U8OTw1A==
X-CSE-MsgGUID: tXTRnhBISL6HW6NkOjkQwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12459030"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12459030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:35:20 -0700
X-CSE-ConnectionGUID: ko43eAd5SKumU6nfvqtPGA==
X-CSE-MsgGUID: d4BZMMHyTtml4XAX+FNYlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32840772"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 09:35:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:35:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 09:35:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 09:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJX+EAPpEgWtVelIDgEbNiPyTAHdoXQ6g++nSRrDdC3FcIW5xBw6EJlqCfQhT1Zfy3Y7mQj2HeYAOKqfEp4j85MEsQdmV6AnaEiqPIuYqLNdd9skGMGHT2ND+jqZVj+wA0sONe7v7zhOuOk2xVdVPL7ldIm/LxiVCpIPzrM3QmqTfPrJuFetFdcQt2Zt8kpOEptdjzepG26I+vcY735WQU0fuI+OMetb0fu6Kk4DCjAxLpKBYDeHoxmwkX1jT25slxPcnZipyItgdKpUQ5UCL5ATnbftQMuDzSQj+GTC9KnawzCt2ENkoHSZ/0MlwAyNk5goPWDBEgGtIcMVyH6aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmU+lLz4asDrYsuavqPpPfsb6v2HTjx2tuRhnS/HluE=;
 b=crKNlOe3AP2LwSduTjie3SJdETT25d480zoqcBvL9UCbhXa3rHvoAMaEbVveMg7g8GNiFdsqpEvbNs3gUNq3nR0NAOS0xq8nwfpcvMATxqkcopsdmi6j4gAXYz97UjiYnqYpvQzs3wMaBbyfm+f/PHMZw/z/OwMHGc1lZpf8fXOAA3asyQk580zpXt5luC4l6atOflqT0NphJGsqXRWpqBH2Q6FNmA55tlIVkn74AVwcSJMmrm4YVAeXkX8FdiNcL7qZwoTbNDUWjTviQEca6+L+uwTHrhVQCK1O/rckpZZTbl7AJOpLTXTc7ASUEs0e3LrXX0Al0HLdGHeyAro1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:35:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 16:35:16 +0000
Date: Tue, 21 May 2024 09:35:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, <nifan.cxl@gmail.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
	<dave@stgolabs.net>, <linux-kernel@vger.kernel.org>, <nifan.cxl@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] cxl/region: Add module license declaration to cxl region
 module source code
Message-ID: <664ccd41d9721_e8be2942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240520193106.994172-1-nifan.cxl@gmail.com>
 <664cbd06b5342_364af29491@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <664cbd06b5342_364af29491@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: e85d8643-e643-4d77-a109-08dc79b3feff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ysoeuZxKjQwjY7+3WR2vstmO/ThIbTHfPJAky8Xh9f1vjWMCyveMtUyCUDyK?=
 =?us-ascii?Q?y1jdDUSuh2morZUjr0EOkNwfDyDcPdGflXC1xNVCSZORIZd4Wj9f9gtNQ51j?=
 =?us-ascii?Q?DR6GgH7JH3AfJ4Te/kKLQTqzOr/YlqsQqAV9kRticg6BVz1OvFn31nteCtee?=
 =?us-ascii?Q?gKX2+QeYpV5FiaVBRXO4PfjT4ZWRFGfKTZZwcz3lzbli65GCGmpuLhU0+mwp?=
 =?us-ascii?Q?br9dUfKj2qoOHAjg7+f7WghsMxK5i3UY1GEIdawjPVGFIwiKcWpV5xLiV6+f?=
 =?us-ascii?Q?kjGPs7yPOKNen9W5gnWSsli3zNqiYResFraYulL46UmNOtfxKzC+v4ERsvcV?=
 =?us-ascii?Q?g7/IpuB+xHp7PO65ul0E+S+JjpNwjFCMHCHBJYN24Jg1vopnEEUWKp5c8BLX?=
 =?us-ascii?Q?34DF8FZI0oOiI9gnM9svB3XijYuV5Asqi5giuF+gVua2Ne9b6B9c/nfZ8OaB?=
 =?us-ascii?Q?1vWmXuRTNIRHc1Tk27gBgZiAv9VjVoEfvanvEGWUyen9U+nMNtak0j7Uousl?=
 =?us-ascii?Q?rX2tAd/HI0JY6OLakfW7jhoRD21wB3yG+RJFjij4BQgEPcIIkQc0Xj647lWF?=
 =?us-ascii?Q?E7OsN+3psA8fiPS13VZFW0wgLKVOYCfrkR384FzXanau6cI3bYLUGwwGgPyx?=
 =?us-ascii?Q?nSGIVD1txM0ZaN4pDtSvo2WrYCgKkBT+chCzXtSYKckgKVQgO+B8bNTl+eGg?=
 =?us-ascii?Q?DWJ5yX/vEB2JZMccdFDpq5565VUYsVZoyroe5MtBqt/F58z/MntQx7hiCznF?=
 =?us-ascii?Q?Ufd+YYpUrAt/BxjnVF2LbUjmWl8vYTdMxN7qjjJ7u4z+BW9mwIwtEQ33eiO6?=
 =?us-ascii?Q?hXFUb5csuwoIozX4J6NOV1fFy1ZKf4QxzBNnsNNoaAXJQJb/qZCFTVCE3WzC?=
 =?us-ascii?Q?7m0zISHvCjHuY1ElcSjDsMDZ3NDtOZcg+D06Uxg0hQZXTcX+8k3JKUClgha5?=
 =?us-ascii?Q?6TNNNqz45AskxDfEEP46i/uQWc/Va/0R9T7qet9hq8MvcE/5V3wuQAuGyUIf?=
 =?us-ascii?Q?/+y7216HlxSQgQU7QsjlfweR6zDoQ5EdmJz+AaBkCbhoZkSzxVNCKDyJdZAq?=
 =?us-ascii?Q?Lj1LM5kNAbGxRtI/S0i1oxnUR2KSbFzlP0SHeOu2tf8cRVeEOzPPPg5Lz6/I?=
 =?us-ascii?Q?+xiuKJfSxXnuHXk/aLSz+8KViNFSYhrCwrlIuPdXC2SXb4ro30WJvJ71zFUE?=
 =?us-ascii?Q?cRmi88wRKSKwKoAF3ZPBKWIgkQ+mSvaKQgCNta5qAEeK3aV9YfC6/sFQS5/v?=
 =?us-ascii?Q?hzpfAkO0eqpCZ/Pb8p1pVdP0M8ZD05sHDd4qxE2IXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rp25o9PkncFwjfZF5hc9DBGmUKcQG3msIRidEBfvVm0txz9YpRWA9vse+PGt?=
 =?us-ascii?Q?SLJL14sET+5uUdQylDrggd3nmUGQz5JlZSjhf7yFhyLPHyY0dxu6T7aLBKUm?=
 =?us-ascii?Q?ohVeWMM4sKQX1O1By5d4HN/tlxXyKy/H3HLHQnq4Yad6QKVsvy/fXeRBBjS5?=
 =?us-ascii?Q?hFdmzk7bATNqxs3nafuetQEiooXvusAwc1lJhMc/9C20y0k5X9GRUEOShJvK?=
 =?us-ascii?Q?JzDMLr2d7xeYSvL0u6NmfvbZHmBaK6uEqsRT96Y34KxRPKbGogT4WLccJL+W?=
 =?us-ascii?Q?j+8HIcPG4C5x7YRNG94XD18ogCu7NgAHUtoUiZBB5g9IIHUfB5oOdxW5t63N?=
 =?us-ascii?Q?L2yW1hudyOeGunXuErddaS4ngBGZGRrW8L+P75zMQpc9Q1qDvDZDL8EgzS7S?=
 =?us-ascii?Q?e860NWCXqqzTSQrmiLXcc9ranwJwISz5nkXUEUJXWTA0aXkGrNfUUjIaKd4w?=
 =?us-ascii?Q?wK8ctLl05JZtk/cMSZBx9XGTZQE/C1vJn94EuTRig3tJ438RABPftyqgrNvR?=
 =?us-ascii?Q?YCXbSA19kbu+SbNIw8TgHi8yG+GWl5tav1ue/OTlKb4bhcDXuKn5F9If03/v?=
 =?us-ascii?Q?v4A/wkxWDaJDvr/T7N+96s3rU6YTR2ih0DcbvKMrbf1GpOmRJk8Uo7vVaDkU?=
 =?us-ascii?Q?4wE/BAcHm17NpM74WmLtV7QewHNOEgwZgw+I3iCRnX9aHNmestbNbtNeeuaU?=
 =?us-ascii?Q?OgFMSfzTpb5g6qwB/Iv6QUcJIKSlakj4yMfu+9aA2W+cwqNh5qzXa+lRTtE7?=
 =?us-ascii?Q?wbPpnrZSr1T/+och9Q/1kRPotVQnF6RB9uUeE6eySqrKqsPaz7ZIJNNb7/gl?=
 =?us-ascii?Q?vK9MTQut92wpH//BvPZdiuVK2ANK09yqfJ5Wt1T/Ydklz7Df+hMlqFAZR7nP?=
 =?us-ascii?Q?+u51T/jWCJS2irmHgO0fP6/jbYbTibwcR7oCg2IxcC6fO43J6zVUW38AdFb0?=
 =?us-ascii?Q?Ku+Kl6+l1wBf8PDUcVM9a1htOmPV/Y3OaBKzAsbNCVKXLSBu0O1MDm2bR0nq?=
 =?us-ascii?Q?+DcvvFngPxz8Y62zi2ZDUFTiVytw00XG9G8hazjUj2cFbdj7s4LCoyp2Mha8?=
 =?us-ascii?Q?zOQO54cZKqUDYy7ScBZF6573XDqQBtQ2D54KZ9X3Z1551sSaNp5LrHCibwhI?=
 =?us-ascii?Q?dt4vrlQNq6yaqEcfZWUydl6uLOKCHxKcwCJHjdEvthc/PtDxvL05Pb9Ee4+p?=
 =?us-ascii?Q?y0uJtOGA4ijKM4//0neGL5rnblCpxYMXULa0Qkh0o4AzY4wLrwxl09GFbUNG?=
 =?us-ascii?Q?TBq1w8ZJ+C6pk6cIq19fZCE653MopQcRMVCmvzvquQ2//QF7eV4IG0N3lRa7?=
 =?us-ascii?Q?EJs+jOao2bB5LhdLNWGhYDZkwhiCKWNfYB+WUXgexjeewrP/YL24IZRbcYTg?=
 =?us-ascii?Q?0TO++JLPeI/+Cy9E28O4PvLEE0ZuzgWT6yQstO3X0xFE3oeYnM2m/ew12BaG?=
 =?us-ascii?Q?7mPMp40sFyNOmDMzwHezVsYH5B9OD85gGRieiZ3u7B/v82t7/FFpPQPHs5tT?=
 =?us-ascii?Q?Er8XpqWXTsIC/yvtaWlaqGp/nDlf79Xtn3dnhj3TIHPld4hwqU/3eKWXIgsv?=
 =?us-ascii?Q?h+LbRHrvj+Xzj/bUSq1oCsRVYDlVaQHhJbcwo2z5OZ5C0loMl0QFD8A1QQwv?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e85d8643-e643-4d77-a109-08dc79b3feff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:35:16.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsJIaHGsCL71IvTY/iZtjTsuPOPUL1grIl0ggPtfhFmAkOPYk4SOHO29gAfaizsmHEZL5NTyVI/TY4Hs9effCDM48Le6jtp+bQK8vMQNJQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> nifan.cxl@ wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > This change explicitly specifies the licensing terms for the CXL region
> > module as GPL v2. This commit does not introduce any functional changes
> > to the behavior or functionality of the CXL region module.
> > It solely adds the MODULE_LICENSE declaration to the module source file.
> 
> Why is this needed?  The region code is added to cxl_core when built and
> that module already reports the correct module license.

Right, and region.c has:

// SPDX-License-Identifier: GPL-2.0-only
