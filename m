Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E626AE4
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245955; cv=fail; b=rG1I1UwDyWIowLNw6DrjkiDnIew/AR8GKAHSQr7458pItllPZmMZsALjtF6GT3CKqRF2MypLloCpe5VxFcyoYdhTE0/o9+UG7sJCT5ax//IKJj+5FUT3sdcDAcaEb0x8JhLF+Yq9E8r4owPgq8SZrETctTQM3bvjM/LEmuF2yCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245955; c=relaxed/simple;
	bh=9i0nGqJCvf4NkXRNzxTqwqWstL17pEHBIVp+C5lri8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMRVhXsbLII8s/3bz89l4O75L85PxIJCvJcdXSccNsOZcVMOq/pRwhlOml5USZbENMyd1LqjZgIg1edjRn0Y+xnm5n2UaJXy7hMFqeJz7KH0A+9hhtmbVORZlvrt7wcpfw5XJ04HjcK+zLjhe2FyxOFeEnABaq1Bjp8n5FaMkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThBn35en; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThBn35en"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723245954; x=1754781954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9i0nGqJCvf4NkXRNzxTqwqWstL17pEHBIVp+C5lri8I=;
  b=ThBn35eniSQh5cu/wDI7YqBZ9DMBsrtETKeTUOTw7QPD6qN2qKd7wVhb
   /rfUdsXnW/orDiyTPf89O+9EH6mYjrybTBRS3H+5jNOqScOi64YuojRWs
   OFKgVaTAHonJ+W+vXUmYAuwuIKrsU6vcngHFv6cHAKQ/hOEnvKR/R4V9u
   SWAHk7lGD1BO0U684gXs1bYUuDHsA2Wa2vUns2uKO5tPHGkjluteb/pqK
   N1plapwNyR8NnP2/jl7x3ZRhhpHjalUd6boAK0ukuW/5glJbuqQ8Kh8jV
   igNyciapgIiTHYc0BkdIIw9Uzb4fCsEISrq//tKpuFFuRqvm/9ejFCE/N
   g==;
X-CSE-ConnectionGUID: gBT6dKECRwq9bvtEqZUTOg==
X-CSE-MsgGUID: myAckq8JStSL975maY+XPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25204502"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25204502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:25:53 -0700
X-CSE-ConnectionGUID: 6zKs9eo1S6WgJNpw+Ey0nw==
X-CSE-MsgGUID: iP5uitQ9Rou8YSw/hD6thg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="58267575"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 16:25:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 16:25:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 16:25:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 16:25:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 16:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx42pv/42DQMmanmn8l0QJ83ZX9zlXvIqCmjKJ+Z9oInfECuWYs4qnUBn+bv2QxNENBhdRxSS0Jzxw/YlPdX8PUSfmMgeDQLGYe8ZiuP+ebBTPySWSNQ/6LKeTHslrfZnjzfiIRfwknglO5m7pu9xh39aU1A9N8IFbWqn/6insKfkxS9Q2XW5BXNYhc2Qq9tIuePHsK0YeR25PyY/xo7rRUkKGu5hbty3bE1Bndb46kl5R2aXI7se33j5sNMTfHTi4cI6qr9iipnS+jVjDOpUMtbT0OKuRFxI28MycGdc8QI3LhgYRFSLsxGarlCk9fwN//zA56tQwPhxW1jSiemuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esBembalq++eEVrUD8DZST8s5952w89r2AufkkJWKHk=;
 b=BgUHfh0U2IKRBA8KhB+hv3XNqtNH+KOs0qbRNAf3MVhdCmrM0ToY5kcJ3c6YsG6nq9HVjon+eJNyz49ONPPI6RFwRuDtPruvESDkFN/E3xAvBX572quuw+m6rHWJrdwCMgQcaJtFbXjVUm//y7tJNN7GF6e6EvI9zqQjvzevQ85aOYOTFC7gCH/CxuKK25BF5VYMlLlEscEC7RFp5m99jMFcS4A9aDnrFMBSfB8Jo5WCfOcWQEMOoYVhqc/+QsKeW1dDDxrUbSB9vB+Pi4dZfyoHJg6YPnuW+CkWZnNepYznH1lMtpkqnYi/B2B/zT+lEY0SvuoV3e+Ub/+gHYMdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Fri, 9 Aug
 2024 23:25:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 23:25:43 +0000
Date: Fri, 9 Aug 2024 16:25:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v15 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <66b6a574b9182_25752943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
 <20240716042540.89639-2-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716042540.89639-2-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: d55a0411-20e2-4f25-0c62-08dcb8ca96d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ROgfa6G/ONZB8hpiGAJzoKocuRv0t6fETnhBmaIvUdPNAiZr+V/UwRYdQ/VL?=
 =?us-ascii?Q?KiMawtRZbxuynINDsVcRlsl899tUGz7a6dqsIA+xtHhbUqHbG9H7weXUNK00?=
 =?us-ascii?Q?91t+t5hrjojDTzvBaLlUUFsjpYIbOJ1lYYk2iV4+HMdt5eDzguZfgJH4ikmo?=
 =?us-ascii?Q?JwtuN08CZ/XNoGG9RPqUkvc7llcQ2pjDC13ppsYQkz8SVz4hAtQ2Ti3UpLC6?=
 =?us-ascii?Q?uLZg8OTCez0bHXTqzqbZ9LJAfggZi539qx7DCCfPGkmIcOe6IuVmd2NokLtZ?=
 =?us-ascii?Q?rWmjwD+2WUsBBqKP4LT7lDr5TvCglfOsk6n1UzIYovQ+YsFclxQ0TMOoFhsm?=
 =?us-ascii?Q?N3EWrkvtj3LB/wRcbXGYmdQpTsZXT88O+BPY3kcCzkI30mRuXLBwr79LmkX2?=
 =?us-ascii?Q?o+O9mZo6R4kMmeFrdRHjDXs2TVB10EJOAt0fHyFIdzQlpoph0XlboznI4mJC?=
 =?us-ascii?Q?RYHcP5pZnMr5bQQpP3kPW33Wan5fkmsbOf2pUVAbRd6XLoxniKvtp1oGpz5W?=
 =?us-ascii?Q?8d79ZJWe0dZW01/CEq1n8E9cX5NN6jlUuq1vo8Rj6Thj6ojfscQkgkFnRE8S?=
 =?us-ascii?Q?O6HENC05lfntA81bKvl9gqvZrtzqLc30UyAcMKD3Tmz96sBAYOAL05gT9Sz3?=
 =?us-ascii?Q?6oHS5eLn1HadngoZHo+GFcjTp5k2xrwdbT9yjaB35QBjLdwZabEhCU5oI99F?=
 =?us-ascii?Q?X8Jegm7mLMpY/vXfYT1k41neawCCkIRj29SRDEGWNTB5lfRmn4869AA7Y0MP?=
 =?us-ascii?Q?TLtFekvUe5XjtaI976tNqy1wyCSG1KM3EOpx1b5WWMW1JmErqzD0b+vhiFcB?=
 =?us-ascii?Q?4/FYQcTGEl51ZWgxhJTcX71crUdAq/Y2SOg5JSq5VDouzl3YVrx6MC7818dW?=
 =?us-ascii?Q?vp3UyuxZy0bC99gFKYI+ekY2Gx7C4lS7/xbGT7f7ppXtB9CRwvAEvIlY3sUa?=
 =?us-ascii?Q?BiwZDJppfu5YEuiy/T/tasIT+xM0cBDv9p9JXtNroQK7puTF9Rx9b+rNawpx?=
 =?us-ascii?Q?y219Usj5C0EWNDD9jv2IwtGV36NZe0T7mQBR/ExPlvArzH9jM+NAIG0NxhzY?=
 =?us-ascii?Q?kTATwLcMyMfEyIk4Ua9xsObIhYRVs2TziKpWeS0k60lOqXqR6/Q+GBQqzavc?=
 =?us-ascii?Q?ollZ2rg96dzXNF9gRqxmwhXNr2AkAyIfJ8YH/YTuqjOxwdsOpZFukqnGD/mY?=
 =?us-ascii?Q?yIkwaFPVXVTmph2Ht1V0kRNBT9fO5I6zXSnVgbNTxMZWoqwZiF+DT9AdrGP3?=
 =?us-ascii?Q?+TbIO7Vam9TgGLFItVVfAmtf8Pvi3NTJKmaNLXN1OsRTw98JbKRN8mwOe4Ca?=
 =?us-ascii?Q?p9X0YBlTpVuGRkyLhufwKXgKe2KrVDo4rQMC9yzQri1rGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4vMpeABC4ZnpPRZWSTv8IUEty/jNxV5jDdEGmedrxGTAlYmoIemlt6xlGYCb?=
 =?us-ascii?Q?CRRO1pSq8Lnzu5APVeLbIoiwqmeb510rkKrhC/I8FDcSwcEQjBmypoDH9cco?=
 =?us-ascii?Q?h82FFithxD6R6o41+/FJLjy9E/zPS8bb2MK7WnQMNIxKYAXHJ8U/9Z+SnZxV?=
 =?us-ascii?Q?QTpBdiaXMUkhwbTkDbenGTBztWr+gwybtQUF+F76KRShKCqQU1a9G7JuDFi2?=
 =?us-ascii?Q?OZ+JLwSD+XvkcIllN5RXrYS2QFwlX1VwFAD6wR3Ib+RBiSexnNW64iaczFeC?=
 =?us-ascii?Q?c4WbTkxPe+had32VkKyE7sKsel7pwm7HdX0yt+VSMBX5s8GLnL3pJk6o3Qvn?=
 =?us-ascii?Q?A/3neVBZvOoQztYtX7NlBVTCho2GpDc+Uwiu1coRz7eChhi6qP3Ej0lhq7hr?=
 =?us-ascii?Q?NYaIyKqw1umhyv21wmBd4uvdIKbU3OU6DIQXbarogBTvJtV1vKGcyVrBAuqA?=
 =?us-ascii?Q?kkJlKWszBzsf9pK2nJVpROaymg1nIVydVPQXY4c9HpPw+oldnISZtHlijQmU?=
 =?us-ascii?Q?Kq0Kx0JO2K8ON+5WdzrSUih9TQLSl+KDd02jrDuJBQG0Oo78PE6lZ44mQM/M?=
 =?us-ascii?Q?UIaBbpLI3AsCWqTY2gE69mqjoQVCxjKbj4l/kzBvYO+5hUbrG8hv2oav4DqA?=
 =?us-ascii?Q?pcnwF0VzEA4VIT+qG4QoKOyEj+UzQXV0GsDd9fGhnyz+CSVwHoOOydv1Feia?=
 =?us-ascii?Q?cq60pxk+ml53JWal2Dy0Ph0oBJGCRkZ3hiJr4ggQA2suaqHXkJy7fSjsp7Xn?=
 =?us-ascii?Q?v/VKBsbMdKam/DBn53YeztX06VGRylb+WQB17aymTCYV7bfJ9LBah0gIUc4v?=
 =?us-ascii?Q?QLQc2A6S15bHXiBTi3l3v2trwCzH2/Pg7FGD8ZQsilHTxuWG/BVUK4AfnKm5?=
 =?us-ascii?Q?GrJDkHN66KAWdXbegwEhCP+bBacyxj/7jTO+kMH92g6nA0iK6IFj7CfJZfBw?=
 =?us-ascii?Q?KOFIGVUE3FSv0SwfwgDMSgbk0t5hOPa181DKikfLCKMkYI0ef4Xq0WkdRDM+?=
 =?us-ascii?Q?aS6O5RvH4FJWSHKNBNNjIfrxhj4Zrqzoiq7R+loH2H1xste+mGww6snZlp1n?=
 =?us-ascii?Q?Tl+ht4sItjdJ5ZmxoRHhfjq3v2RpnJBX2EZt6jlpG2WomI2v7KY1zOGniqxL?=
 =?us-ascii?Q?pbBVoOInKMRXUEIyqAK9y2gBiOSaeIqVW331W0X4smZUSeiusXaiKt6a4T3M?=
 =?us-ascii?Q?Hx+9ByGTlMLRvnWm5AY6HvIp6ij8b7GNEncwppweIQ5CswqsVOGxNtjBO2YQ?=
 =?us-ascii?Q?+00jdgEaG1ZMe4m3IxwSbJ3Evv4niXYrfzerZhxXUIqafZdLUJzJ9Bnito/s?=
 =?us-ascii?Q?8z8g8az7iV72mrWc5z/pXG51GIxYUYrUBkvQSJT/X+EJ5mTqmQleGquh0ucb?=
 =?us-ascii?Q?XjukNzSm8OMgDBu+ffMrF6643zJuEBHCc4+8vxa/q13LKu6mJpRS1CpCpRuY?=
 =?us-ascii?Q?ERzhGCLl6kPCPFlBe2aJw4F3OiNVp025MCvW2r9CBRGe7ZMCMWjRhKHiSdhw?=
 =?us-ascii?Q?JuoNEkdFiAIn2j/mW9J4Nh7VK5BpaoMQZvgtIyiL+Owaaj9LNzdykqVTPtG7?=
 =?us-ascii?Q?wq0l24Fr06uCGmrL5wooHnLdife/i9heSk4dite4kgQv+vna1kZmk07EXitl?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a0411-20e2-4f25-0c62-08dcb8ca96d1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 23:25:43.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBUhSgzdm0ItuanT4eGvRIYG7tslDhxRAmCO/lQwv3nyMxN+DWlhnaglropTiWYxhUCQ+rSJWRf+NTlOreY7ObpszL5TIa37VjSI/NeBSqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
[..]

Apologies for the delay.

I notice that patch2 has another port leak bug which means lets take the
opportunity to make cxl_pci_find_port() usage safe in this patch.

Fold in this cover letter update and change:

"Given that this solution involves port lookups via cxl_pci_find_port()
and multiple exit paths where that reference needs to be dropped,
introduce a new put_cxl_port() scope-based-free handler."


> @@ -503,6 +496,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			      struct cxl_register_map *map)
>  {
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
>  	int rc;
>  
>  	rc = cxl_find_regblock(pdev, type, map);
> @@ -512,11 +507,25 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	 * is an RCH and try to extract the Component Registers from
>  	 * an RCRB.
>  	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> +		port = cxl_pci_find_port(pdev, &dport);

...then this can become:

	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, &dport);

> +		if (!port)
> +			return -EPROBE_DEFER;
>  
> -	if (rc)
> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> +		if (rc) {
> +			put_device(&port->dev);
> +			return rc;
> +		}
> +
> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> +		if (rc) {
> +			put_device(&port->dev);
> +			return rc;
> +		}

...then these calls to put_device() can be dropped.
