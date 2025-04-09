Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6B1CF8B;
	Wed,  9 Apr 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221490; cv=fail; b=q55M+kQQkBqxiS7ugRBAFPdrWHYD1WJQoM2rTFMcfKPT8NJFoM0nccHEwm2m3TQwGrQMbMS1kcK5cpZrGNJJHsZskFkW5hiBAG6Lz1l7qJl7i9IwzO7bc2Oeh7Q29PPOW3ezq4uE1B/i12ojw//pGhTOq6kU+OyDRkPLnblUKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221490; c=relaxed/simple;
	bh=bB4zJhZFHf3CuVZICbTj7BjL+5jiTgNIf2L0Sw8Pqp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fit+HqE7vXtnNkAu8yPD8eg4IzwNG1QeMAiebM6jMF9pDefxFsNU4L2EUEkm4nqQvq+UhcWjkIVBgoAKYF3kSI/iumSzSDfZMytoGMqq0AVZd9LB559hiLRMaoc5Aez2CrQSeFnxmYLUEnoPPFzaLOwwnNX3DL995oAynjU4naE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsYvw3uq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsYvw3uq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744221488; x=1775757488;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bB4zJhZFHf3CuVZICbTj7BjL+5jiTgNIf2L0Sw8Pqp0=;
  b=YsYvw3uq6atzxVI6ynfXfD+nnZlgEkKMpGkyEovoB4kQQX9HvLoMFWHH
   h9IdXu8k2tWRFoB/N+v3V5ql2jYrmgCSf7bHf85QcG6zMfJMqTZu/Z20n
   2l5lH64sNlR0ouJUEDEwnXYNLvy4vZZqXMRRhyGsI87ZBEZxTZ+tFVwgu
   xhuuh/pMaKJ1hkLXQXBzMLn1w7x/OGbZrBhUeqDW6xPZ56zrpuQ1DZ4Jt
   hx6Kn4WfmADuhUK3Kzusm+ah2KVpyQ+FMw/QGF9fzviuM6SIUJ1zRjR8/
   dKTEjZDZq3zA4WIDUM90XNgLW33cmCJmjcta63zzhGFsu7DS/xbM/2kSw
   Q==;
X-CSE-ConnectionGUID: zXiWh/s5R1iYffm4MqpM0Q==
X-CSE-MsgGUID: EhErM5dNSMeArfyKeheSrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68196947"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="68196947"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:58:07 -0700
X-CSE-ConnectionGUID: My2MMgARR8eSxqLFIrsA/w==
X-CSE-MsgGUID: SGhChE2+S+iVrk9kRw2+Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129008155"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:58:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 10:58:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 10:58:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 10:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyL42yz4ZZgoJk+Pe4MKWinacGGcSFtMkRH67F0ehDD8vOEIH4qPuQRyeu7SJglA1A+ZfldTL9FOtlouVy9EE2CeJoosGKJHcR8nfeyJzwm3Aj02eFk99buK5xJBqgIHJyfffkzQr8sswNsaoMaMDoL2XR0Pfq//bZxak2VC6MKHHlCZnPTIkFGrU5vtx8c2whbx/rKfeDVhoGfMPpeQBQY6L4UuWInQe/30mocqCHpQ9fEmS5krgIP9A6jXuOUKv+BXM2ajAKgczR8QjgQTjH4RGuDhjn6rM/6V4WCAYK0I320m2SiCocTf2/SIT1/mRvNOwhKoXiGBBRoqF2sOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD1Bq0xDZtRKumjG7twRFd5uBOzkGkwUyMfDTuD/yrk=;
 b=tk4JrSvuqT5rr9TJz7i5iM+7kJGU1pIG9CUs/PO56M6+wbbXPyMkBtMjnzkVG0ojxWEgAaWgkRMSJuYQsZrrb1nlDA3GoNPd80YOY7JfDpQeY3/bU+/IUZJUUZhFpjfCz+d5Qyfw+U/WhymhBiphGkpQ65nF0RoMbSOXn6l+9iEM1awkflic39XqPJTWuWF+aZNTksiLtSlyeBaF6lLnig0e+Nd94vyI69N7kN/DRf3MPoecyuvGt7fusdpEjN8JbO3AtwMJyJ0t9OvnmslqTplIWHB1s+sjWkgWppxnjLj3uGzZzBZ0lJPALx40FKdkEVWql+JPjPEDXRYrXjMgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 17:58:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 17:58:01 +0000
Date: Wed, 9 Apr 2025 12:58:29 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 1/1] cxl/feature: Update out_len in set feature
 failure case
Message-ID: <67f6b545d3be9_e8fcb2949a@iweiny-mobl.notmuch>
References: <20250409022521.510146-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409022521.510146-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 939eb01d-4f28-45fa-b50b-08dd779011a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TGjOC5/ZMeK35oHeLups5f94p5SrKqIe4+IvaTxMSP2dbaXi8MG12UFXkr2p?=
 =?us-ascii?Q?dtnibWeihvPXc1iyk5ndQO+YY47NQLIXRLnhYK8iqv2Orxj/XVkadUHNN7HX?=
 =?us-ascii?Q?KfeY49ezz2YjPxV9849FNMVl9OZjHQ+m//79OwiwJXX8c23uCJh48VowHl94?=
 =?us-ascii?Q?C1bn/I3UvkceZP5Wh3VJ+/ZIA5YywvjGJu6siO4nsELTU2gHEMBaZuv8nlPZ?=
 =?us-ascii?Q?5RtDF1oU5kpqsmTJzG/1hU2r1kDUO78rk/Pc3E1kimUmwRj++Ee4ndudNzXX?=
 =?us-ascii?Q?RySnlbA1QtxoVQ7juV41KbzA6odobSryYdDaMlrIM802+D6nl8Mqmmr+Iw9Y?=
 =?us-ascii?Q?RtiBmD3gQVbiN3z+MEv801K0tWy+ZkG/c2UoQqTK2CORIYkwUuEiu0PGUALb?=
 =?us-ascii?Q?k/h/Emphi0GirRB4BZn1fSj8l2TKeQvIQQxhMsv+e85rQn79usH64txyAuf2?=
 =?us-ascii?Q?tMSO5WiOKZjR3kGi+K5gCBztVmiJk4bW75YcWvSr7IX1kCLjPQAHvScxraeI?=
 =?us-ascii?Q?cYmf31BFfr32tqxPAfXWfk1l5VdSlZhrwtyULrxbzKqD9ib7OswTv1vSIh4R?=
 =?us-ascii?Q?0gd5mYtaua53LX/HZwDMINyaKVQy82nJfRm9Dh4FlapoNClQQSWBWUYFCYpr?=
 =?us-ascii?Q?xRfmYCzQlJJ9bNbJdyvd7VWoifcjvBHMitB7i1cRliOAkkdEYUasH/OvQIcq?=
 =?us-ascii?Q?eIVDNTLKydoIYwbjkBYuqrq7tTChzfRvCOn1+L4iArmzADMIBjD2w7RQ7OG/?=
 =?us-ascii?Q?wXCaEnHwOOI8Z6BYjoHnqDws4XBt21gp56JEMutUtuqiPQokIw+d6Fj2NRdX?=
 =?us-ascii?Q?INCfXKkzMVzk4Ln9Niuaee2qX1nG8TIaDFK5ZiOPSHUy8g8gcXR0PDq29Q4T?=
 =?us-ascii?Q?6ThNDQqJk1/xlEDv1v54OCHAmf37Hf+Tcqpd0XgaOg0nskHw06DG8j7A/Vbg?=
 =?us-ascii?Q?lp/b5mJ8wRe+37SKsTJokbxl5DKesgAYY8bu6HXzW8gjlNhoZGtm39LOfCuD?=
 =?us-ascii?Q?GYoc8NSKNcdcIBK7oWFl1TJtfTt0EK0HtKK210b9qXTGaYVgaUxnY34tHeeV?=
 =?us-ascii?Q?56KRDnAqOKDKhvdhesvT6fLwPUKaAdnqj2bC3KwRtespgqEd7BxgjXLHRLbl?=
 =?us-ascii?Q?Eej1oF9CN6YFAd3JhFk4IploXQVV/fIrV6tl0+wnUIp/o/xffpBaJP8usFht?=
 =?us-ascii?Q?aYwf0U/OkisOgS/nxcCeWy/q1pKdgRlQF4tNBc78FbshkTG7y3dbYIRAcMza?=
 =?us-ascii?Q?z+bCLyZXpwegsBl1qc5tkl3rt6eMNki0aRKISscRKd3NN17Dye9km+HTql3g?=
 =?us-ascii?Q?8rE9DS7GM+qH8U6R8Ns4AuoNKURuloyNf88+SZ/JIF80pudhIQNSEF7GvxjW?=
 =?us-ascii?Q?b8bxNxphDEdtX/KBXrtmem3+dNUO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFUvpx+RNdJOoI+v8DP42rfhoD5+Srh0xCreMn6LtijL83+/v8a9/1uUEq7e?=
 =?us-ascii?Q?OqHBEOe7Ks/6apF+Jn6SoRw6Y4Smcayv6XfIdeIzKnuHEEL5ogJlK+xGqMqh?=
 =?us-ascii?Q?Ed4wPP83iXTANOiJUG8QEUhZyPkZgrLgveFhCTTSm1fHSnaqu/WAduNtRtPX?=
 =?us-ascii?Q?k2hIpq4z1LwKha7EaRuWM0+xuvBWhvih6XdqcnnsmOJqEed4exsxh3SLbxyZ?=
 =?us-ascii?Q?bcleXsxZ08kCp0tkJp23cnpbaJpI82nBfwAIpwEZp9UCoBtx2E8rwdoeHKgZ?=
 =?us-ascii?Q?v+iy0hPqLH0TNrp5R0FKOHd4fm0GkW7h7s97GcujAYGytGzV37nOtx5C/1k1?=
 =?us-ascii?Q?avzdMRvLxyh8i7RQr2qMhpmucoQYASuxTmikEriEP5vbpsteP4/bOUYNkIlF?=
 =?us-ascii?Q?sjuw4KgLOHIg54qtLiBT2aFsDIz9y1r7YbL5Fg4n53IPPky4OEFDzNK+FDQJ?=
 =?us-ascii?Q?hpUa60fDIZ9fSplbKCcvwJRh9JALogvXDM+QuOFYmymy73eMfUM9TZHdxCl+?=
 =?us-ascii?Q?FKI9YjMyelrc3+LJjwMbS7KVprClWG+XnXMEM6gVgopMQqE3+FYgE/qgN8C1?=
 =?us-ascii?Q?T3WiE3amEkF1nKWb6gFEE3noIMtkdjGDaAsJQPDdkWy0lIsxsLyLpYPJvViB?=
 =?us-ascii?Q?vSGPOYvGDOFOEww3V5nxE8S3yjlxV59y7aJQR0BeM3QPAwod3H1hLNEGVXAo?=
 =?us-ascii?Q?4rWWtxvih2K796Em+rg+vMj3ZmrCY4sse2bWCofN3uuFucy21tkpNEuXfqFI?=
 =?us-ascii?Q?qUNIEjrOin+yzgAbfV5ZMOud30XbhS8ZlGAgtMGSz1THB7UXl3rvXVsEhtgD?=
 =?us-ascii?Q?9IqrM9xY2DH2sxQcIfpdkYbfdfmkz/9OPUGof+16N91Alj9ht4QgTO7RPtCI?=
 =?us-ascii?Q?NAdrTIpdZ078+q6ZcCjB0s3LK2sSY1yTqXiOpPo2s9ySV9Ay1NEp8W/GaMtm?=
 =?us-ascii?Q?Z26kjOlMMsqMsPpbCWxI/fmT75IqNqXGHfvCNTJrHO8m2YjqmDdEl1eKq/WI?=
 =?us-ascii?Q?Xlqt9jVaA+FqDCIccnlDp5EYT4FZjo7dvzMrLhBSsL+mwaiU51qzAJaLhMcC?=
 =?us-ascii?Q?NYZzr7xmahvqGImVdyxtWLW8lPJgwDGLn0VVlaGzmFM3RruJt8Pcgbvc9UMO?=
 =?us-ascii?Q?A9zWGCqzIv//1lKzqZz2eZfdHt2XXgBFIiBBFeO5gdJp8rOTq20pQrzpXwlN?=
 =?us-ascii?Q?ln8hNvMECUFmrIxIzB7M99kcWJOxSqZt91Q21vrLtZcRmCoD8Bs6+AC6qALX?=
 =?us-ascii?Q?nV3FK79DZus+uXE6+0/1emTTU8LbwYNq1sXHiJ/dZKDqXKtrW9McWbyYYW2u?=
 =?us-ascii?Q?qWshrU1PhqhJ1w/DFYK3JZ2XvfbPSumqrcgothHF7YAh2uaKd1TyKGfQEYf/?=
 =?us-ascii?Q?6NM22YwEVjsIiUjCcuqO4bdrX4GNcQQBC+YlFmq4v3yzBsVzF7guBJp/W09p?=
 =?us-ascii?Q?cafodpw/SIMeMLZgRQXQq99HMZLLLxLBHxqRfSodu2FC1N3D8uTsFoIbYjSS?=
 =?us-ascii?Q?688STApj+zehrs5UFaj2rl0sw23S/JmU/oYIRGC0GZiRpO0oIaYAuYJ2jWj1?=
 =?us-ascii?Q?fg6wEoQtvHXSOqvvMBHvBDExNJOsIYnCYDwZIy7f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 939eb01d-4f28-45fa-b50b-08dd779011a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:58:01.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWouLRKr7RMsuQ/sHHc2pCHYjOPciRsF+2Xcw/LFa6uKtCnMlGg5pQ0OajKihTJW4XhqVc7ypP99yHjBPhmrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
X-OriginatorOrg: intel.com

Li Ming wrote:
> CXL subsystem supports userspace to configure features via fwctl
> interface, it will configure features by using Set Feature command.
> Whatever Set Feature succeeds or fails, CXL driver always needs to
> return a structure fwctl_rpc_cxl_out to caller, and returned size is
> updated in a out_len parameter. The out_len should be updated not only
> when the set feature succeeds, but also when the set feature fails.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
>

With fixes tag Dave found.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
> 
> v2:
> - Adjust changelog
> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..066dfc29a3dd 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -528,13 +528,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;
>  		return no_free_ptr(rpc_out);
>  	}
>  
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> -	*out_len = sizeof(*rpc_out);
>  
>  	return no_free_ptr(rpc_out);
>  }
> -- 
> 2.34.1
> 


