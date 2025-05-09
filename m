Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360075464E;
	Fri,  9 May 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824460; cv=fail; b=gf0OmT9jzrkDDzt61dTaN90u2DdZOeheeHSRkwm6GUmEDa+Ha0vdiu50KgG2LRIe8eXIJBObbpE/VKbiZ2Z5e+iIY7U0/wxFQdIgcVR2LPKfEIP7n9w8K/V6NBAwDPqmk/VO4zB4Mg5Bigo61KnOfk8THHqcLHn81VwzmyUcvCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824460; c=relaxed/simple;
	bh=Fc3++LKI59izsdVpXSbSIoQFW0SihPyJx7Yu7wWHlmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApOwm2PpAJmASiHx6DLM6oz68vhnASIPLNFHdclcPzLB6XwnzchQdbB5aqxdBLaVO1fI/9mhHNvC2Vt6F+fG/1r4sWI4gQuvOmFe2MNhrdMGqm6C1/cqXbD8NZIRapW7+wi4+68MZCXo4g6twm+nmrap9F5RN9gJM591uKuP+4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfpN8HYh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfpN8HYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746824458; x=1778360458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fc3++LKI59izsdVpXSbSIoQFW0SihPyJx7Yu7wWHlmo=;
  b=mfpN8HYh2QkcwSb4MWveHB9sTEZzXMGk0ZuIT5eLe28T0SgVLhrVN+Nl
   LA4/qUyWYBYCy+Q0xpb1wIPi1aoP9qiD+l/PVXJXa1Am3sYwMVLRKWTsA
   1rGCJNqo6sNqY0gA1CuVuw/8CQu+XqaSm6CH/f96UUJdKEyRKdMsiLGeP
   SNUYZDBr5INNvlX0vKwmrDkqkP57yTVdQMRDLoPpSTEEcZ9cJeUB3I04r
   25yzaer3CY2UBwcDEgf09zKUMn5ie8CohlE6dZ3SHNZ+TXHn1Kbz+Az52
   tHuSqBilOVRhF4V9Fc3J7D5apU7+uKtDPHywd8CP4852857Pgod+xbppm
   g==;
X-CSE-ConnectionGUID: qAZ+JG49QQif5CxNdvjKzg==
X-CSE-MsgGUID: FCECRd1uS+2d+yIPhj/2Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48585517"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="48585517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 14:00:57 -0700
X-CSE-ConnectionGUID: fVhD4YKZRn+uLDJ5DlHCpQ==
X-CSE-MsgGUID: Cs1NVWCiRFyYj9+urJJ3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="141498403"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 14:00:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 14:00:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 14:00:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 14:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBZnfBkW4mdw5b50R1XTE/UHI3hSrpGA1b2IM1shrT/+TwEkxlAH+9Xz1OyBid8AMZDyvOdG6bc2/6Pi8vVufCGYPd+sUSRTRl2UY0AnQDmHlPLTUAHuv1TP9Fwokt89t5M3SzxxgFY7f/66f3rUbP3Zo6tCMNnuw9+9RidWARHQC0gqILZ4kQTFtdYVCzoYl90Ap0BfMpJOcJFI44ou9yl0J39Sl4uV44ovswhH6b7tGzkKZjxEi/KR+MpNWv6JpSZl839iaiUYbtymJMEZlpTibxO5qFtjZPzy/nxAQe1nOF07ud8bEcTo4X/4mHNdnCsR9wq/786pnqsAwAFW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq3spMciAh1SvRd+lgxTF/vo1h7SkZqT6/P043okMVg=;
 b=Kz4Gz7KqpZ0Bqbgwg0xj0Fw98sqodQRLJq1OBIi60/sbVHNWwq2h3uhn35BDzwH1TR84ajYnVPTl7MvtR69EZ+5GFVyHSVtwlFkNlxVHK+4VYZHLSTC44h0IcdViinlgFRbbbvvwf6StU8B8hzYZhkuVnzlQ46Hr45FAZoNBu2Z/ikNHAnZdRv6ZE9HbI94IZBHqtHcGE+lx/73WoE4gak0RNqsjfahU3JoChJzmJaZy0Pji089w4w4oBG5MsNUKbkwZXGircgyjDqsZmquKCjtxFOXSgwlVx/+0rsXYdpOKJmn8dfpjC+tr/5uA9Le5a8TvhzLVrdxKPW7ejan6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 21:00:49 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 21:00:49 +0000
Date: Fri, 9 May 2025 16:01:33 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Clean up a debug printk
Message-ID: <681e6d2da4fc8_2e76d2294a7@iweiny-mobl.notmuch>
References: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 01343681-95ce-42ed-7dc4-08dd8f3c936a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lhIaw+bGQzkRPYn02e7Uw7WI9+A0tqrhd4Aqk7ddn0rp+TxVX4bE/qqpG01r?=
 =?us-ascii?Q?TLwKV6O5YPvbTZL2gCUz6rK5w+Jw3DPfm5QAsGDIZeiu6vdcOcvRN9ct3XTf?=
 =?us-ascii?Q?iN0bOp9kycXAg73tdWkoAzRdzgajqUip+fVhYQzGcdl2rU0XUj6aa2suqDXx?=
 =?us-ascii?Q?0qxIl4OMRxmpXnmgLFz2P/ZLgs0lLX/M50qn8q1OTyqxfmjX9P7YYMhCHyMn?=
 =?us-ascii?Q?VCK96ZkNEtLGx9ZD4bdtyrI9G5o2UdeIjmlsJTQIF34cUI25GzuDdlT1LwnE?=
 =?us-ascii?Q?TFD27VLX0D9ZrIV7QFT3ObwTMSxrtSEekWwriHAQvcpUnciqZAABT3dwKnCQ?=
 =?us-ascii?Q?pOXf7/3jdxr80Xked8AfseEdbtvgeHtRRH3GgkRuWqwcohSg/ixblHSGPYJS?=
 =?us-ascii?Q?bIPPK7EZMkaJw4/wz908n3wqy6S1/+QY/ouhVQ+6rAdiMfUE0T+FO6rhUzLM?=
 =?us-ascii?Q?GwIZcC7gi5jNzIYGqtGFW3Tn+ZURx6Ue2E/fPKyvi1WuNkyz5L3vtGpxFqSV?=
 =?us-ascii?Q?R3imhiKMN8Zoq9XWhOVxQnqDkN83YAfWjj6VSNAvU+UYWowOCu3CnZATHJCd?=
 =?us-ascii?Q?tdgtyKy9f9XXQMS8Y0qRUzuj71qs39zwBTKvEulIgw7CYl56VjI+vM7+Ab51?=
 =?us-ascii?Q?7lOeCcNU4Eq40BeuiwCVFZRfULqqyGptxVJtVopBeaNhulAFNbJkqkjE2xRb?=
 =?us-ascii?Q?X5jfjX0V7TPvCbrB6lQFWR1+aY9a6hGGXnw1cpuMqxdD/H68SqpKKQZ/V+xt?=
 =?us-ascii?Q?ZgwPtvJegyztkQq83/9NnZ0BGCvXU5dSqdAGHCuUm9m7fU7YomY2wXu+jMyE?=
 =?us-ascii?Q?Sj+9oRjbgYEx6y6TxsnF4XMT8VwsVcpnBYcFtFTg56b2GRaFApysDkUjx3AA?=
 =?us-ascii?Q?wg2fCU4COfiFmBeffsqbGHpCdBT6eBWoR7oLHVCIW2IPeXvruOUCa+oqaKB5?=
 =?us-ascii?Q?5dh13bQ5FweS8TGDE1SukkXgw36dWz8ZSz6T9VUbYIzyv4GjPeu0yqOkkxuY?=
 =?us-ascii?Q?kmaVbAxa2E2Q7cnUmRDckM6bp92S/HXNQzfHuviMyAFpXHy2FMLUWnjGm50e?=
 =?us-ascii?Q?sQefq4u3UvMinvLqWjGnyfnM72X9Fj5XWWdUSrlQC1VD5ye+g23GMAWkpwky?=
 =?us-ascii?Q?YkBcNE9UzuAu9flv+HRd0AoNKq1oNXOKFD4ry35s/DtsfARuG5P4mGJD/WLb?=
 =?us-ascii?Q?FC/c1j9h/Wh6o0MVEa2yuGxdl/h25CnXBTtk0s/4I0XLcJjK0PPdXHMqLg2z?=
 =?us-ascii?Q?ANngHvkayV/iPo0RJNkuDshzo/tbl8McgmcSSWlZMJBwz+bjr0nMFv5SMteI?=
 =?us-ascii?Q?4uopzYVjuUHI7ge8v6gB9F1fXZrE1FwfaZfl/HrZmIMgFLD/F0XE9OzNEghe?=
 =?us-ascii?Q?2QhtQ8xw8Q6BBG5INCiqLI4ev1bcxxOf6pFWSVBLn7cs/CNWCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lujHisLsIZynI4mchCslMbiGS+gk2+I76B5Cxz31yjZpiePxjLz4LXdteeS4?=
 =?us-ascii?Q?6drPmitVsnV41ACWdRXhR3lRUdlde78xjvVJQnUOTM1sSZf06SqRU+eSfdXa?=
 =?us-ascii?Q?DVnrrF9fomPACihQVmkxGnhyosDn8foYbrzQoLHETjLfXkWnqlDp2TM3Ozp3?=
 =?us-ascii?Q?BrCncqsV6bThaw4tqaBuA9lrT9t1V/kvuOa4j5Xd63992SqZJK8V5gBImq/Y?=
 =?us-ascii?Q?F/jpv2AETqqOSiSsQS6OmCbXILp/vbKylemiwONODW2bNDzWXTzzCKdQiNX0?=
 =?us-ascii?Q?yeEA+t1qORlVyFcIVakWxrAYDdIkCFNHUwzc8g6/fDxOZY96YaaKbBq+dijT?=
 =?us-ascii?Q?MPScsFBc9UNaVHZyST0kxzADbWa1ZQa8cXqvxA2DbR6RwA7O7+a1xteHFt2d?=
 =?us-ascii?Q?2bJ4YSbEAs7UVsTGtTyW8dZmGAL+y4wpKGu5gjGMBXx+9NwSr/VU4oyxLrJ7?=
 =?us-ascii?Q?KbIDUWynhX/GcKgFf7vd2zf+fqE34Up/vREB7t9fxmeedBPw1ImnIH74lfmy?=
 =?us-ascii?Q?CMUHuHHMFOfGftZcvqbqvw453xG1cSg0S8ZMtARzk1z7MhBr0U0SrKW1grfh?=
 =?us-ascii?Q?J1tHgbqMqnJsMn7nf+VASbjIJ3KQpQ9gA8KwDlPJaQ/qa5I8tpK2hUMTyL2R?=
 =?us-ascii?Q?49GtLveTsZLuAcpgDWLyVQQMJHg9Q1NnxCm+mc4a2zBpT7B13Hmj+A4czWQR?=
 =?us-ascii?Q?UFI70KhzleB9Ae3q/Iq1msD9/H7W0u2OsBrZXAX1Cli8Ox5gfWKSiD92PoTB?=
 =?us-ascii?Q?xnN0N328IjmK7D2e9hGzMz3dQyfugI0IS0CkECM+wzAHQCFWXsq1ggRP2dLE?=
 =?us-ascii?Q?zEyK1kCrJAsO9KAI5MQXAC64nSmvIqqKCB9tpu/uXjZ2P8DTBiDU/P/nWfXS?=
 =?us-ascii?Q?RKhJz4CSXRkB+035mDWo3ezq9Tg8snZUFUV+wpkQ1Gijikv1y4Z59B8AZ6Nx?=
 =?us-ascii?Q?7WQ+JJFYlTlrRorbzjSI5RY7Ydgul5NeHAi5gtMwocS6IR8ed2b+AmofKewe?=
 =?us-ascii?Q?X7CE6/JCD/E5Ti9jroPSBTaxXlJFa+TZlM3x5HCP9jH7yFlfDuOrXnc9UoYR?=
 =?us-ascii?Q?UQhQFGvGDTO06zenz9fWKx3kwmKMHk2oRv8h6Vf9QJ1VcTtckLG/ZtfvY7bj?=
 =?us-ascii?Q?9wAMKnMER/KyEOdAuohu1z6t9J8UxBCwn72/JDSAh2VMGoEZw2sY0PesDDOL?=
 =?us-ascii?Q?peazK7jg44bWB0ZVztlpqu8dewnEbxG9uXmgzVfH/Agrbyu9ilbNhcjcpd8N?=
 =?us-ascii?Q?Moil8/9qcNM37Ot8RMmoMRZAGDOZLJt3dYT/9LgXodM4JJNASE1QKV+L24fh?=
 =?us-ascii?Q?+CrgbgvmIplyvClMAeIZXjDhvRrJHKvbZMrNv6odxa5kt24K+DzMz6rp3kC+?=
 =?us-ascii?Q?79BOnY9hfr+z45CxKx85zJ0Zgn+W7unCMKOJqWHumhxJh21MoIOQdY+8in5O?=
 =?us-ascii?Q?pNJ5+4HF2myMwtRMVI+ChrDqXy9e1WM0ptb4HzpHAbNVIf9sSp3b8PLX5Kic?=
 =?us-ascii?Q?w6xKfFeEOSlWJE37iRtLsMo0ztUfrB88JhA7o869ygHvs3JHQPcJTIqcunDu?=
 =?us-ascii?Q?UpG/id+Rlc8efPx5LqaAtvEb9apQ3wwCIIt6fxk7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01343681-95ce-42ed-7dc4-08dd8f3c936a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:00:49.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JceLAk51WZoLl1tSP4YjcWcTt4zSZYP5B3RvszFB3DQ/T8v57tp587eKE8IluF8GhUMEIui/jQrq4yxGP9msA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> Smatch complains that %pa is for phys_addr_t types and "size" is a u64.
> 
>     drivers/cxl/core/hdm.c:521 cxl_dpa_alloc() error: '%pa' expects
>     argument of type 'phys_addr_t*', argument 4 has type 'ullong*
> 
> Looking at this, to me it seems more useful to print the sizes as
> decimal instead of hex.  Let's do that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
