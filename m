Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAED217F2C
	for <linux-cxl@vger.kernel.org>; Fri, 25 Oct 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893679; cv=fail; b=Qy4qbUXs3N8MJGxUt0wIU+pG099FOIM7B+xgGpZf5V04zuLHKdE6gG1GAWUn1zoT82+xtQeKuQ1q23lvcA2WruTEZBqQV9DU25rmphRMspHX7lP07rs3fJv1yU0AVMNO0r5CqWVzEj59JdfuIfKtu8zOoDkaWR4ROL23RkWPuRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893679; c=relaxed/simple;
	bh=0YRseacAAum9oXV4pDSCl6BnBrgpv8JygCDKBVBFtl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OB4mNrmD6Z16dH/5owSW/4GmAaj1/pdXVPPoxeGPgBLJv222b5ZvsmKoMRlIwt8SjGcVya4y0QDbZQkJGBRTlmbY2FLP++zmcVsd6ZshCBaEcTLCXa4fvAnCfj9lh0I8BlSuTSaTCJUS/4l147CdtPaFSulihnrRNMeVl/VT4VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AykpMohG; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AykpMohG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729893678; x=1761429678;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0YRseacAAum9oXV4pDSCl6BnBrgpv8JygCDKBVBFtl8=;
  b=AykpMohGJWUZJX5uz4iI/dKJxrlvTCiuNvvwte/PqpM8s45bJdPIOSo9
   0J1ttyYCvg+I5gkKNl9SId5cZCuUAYujwcp/4Mrj2eza3+RezOr7FE1Fb
   uhvUNK86X2iu3Um8IbRmHoe7wYJkBMENRBwYxTySv+lKoJ8Kq7FKy+0mf
   bhjF3/V90VV7SvPwMsL9Na4w+odANGt5ojlcLYdiS/guLsiv43g6hLZ4d
   Ty2rl0cuECf56IATeqh2P5Jyz4zI0MxFO+sJm+OEsh7jH6qG7SWvKN/RJ
   35EqI9ZHWzIswNpUKIVRf2UmgHB6Y1tyG5FQSHesQFn5H4orqPI3Fl1fU
   A==;
X-CSE-ConnectionGUID: Qb6IT4SxSe282svRJ2Xkug==
X-CSE-MsgGUID: QfrlQMeBSnKx6XixJsKAmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29691474"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29691474"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:01:17 -0700
X-CSE-ConnectionGUID: VJC93996Tb+40jvhFnXfLA==
X-CSE-MsgGUID: LDupfJy4RkSj0vPBK0cEQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="80947765"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 15:01:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:01:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 15:01:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lElscHsbEvRZ8kFG8k6v61QA8dixmOhRR00Yn3dtIXblve+i0+nh14rBecuCc5M6pONaJjXoIv13pKh3q7ks60Ak08xMj5FwEiwiaWvTDiy3AD4NxiLrbpmKS00d5fOtHEJxi0xMKQSTzYypiulHxZhFwSVxDzkMsw2iAXWv+Un9UemEgTbh5+WOOKoXgoQzyKBqAcGus6KSSOOFjnhEtDH/nKV9/QiZZNDvmMjruNFpmzSVu5Vd8FlLstaW38KJlHeYYXL0Jc4i5KQbrkIuA2XDPO6yoL10s10fFNNt64vuz6IDE8uZu+GI2b30jG1tyTBK73ITXn4/dc5/r83F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9NI4RuWKWXUK+o85Z5jozRBmfOdU6J7AsyjT58kc2Y=;
 b=c+j1k2PeuOOxEPSt4gyg8V2cRur0mBwCvktZg9LFOstk6vEX5gRwaT9OAW107v6LaO7eIbRxRuZtvywBf9RJzDBMJfArOACuXS8oPPXAqqmJMbA1iSQVXED90qE8xVdo5iTn7pTDChyQiYg3z2Z6+kjn9dNYhUpLcAbcgft2GcUQXasbCq/HqwqQn5toTpi84zeGgtdAlja4ejrlpunLIQrUOs7b46s5VQn7VZWh8P69hy876NYE8sqC9XcPh+8HlA/J6XXsNza4GpVnQ55xQ3UY6UI0oynvSsh+UQm+/Wu4l+3LxV30V+ahDiNnuiltkrAiCF00gAXfTaGvBgtLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4797.namprd11.prod.outlook.com (2603:10b6:a03:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 22:01:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 22:01:12 +0000
Date: Fri, 25 Oct 2024 17:00:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Coly Li <colyli@suse.de>
CC: <linux-cxl@vger.kernel.org>, Coly Li <colyli@suse.de>, Kelvin Shieh
	<kshieh@lenovo.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: downgrade a warning message to debug level in
 cxl_probe_component_regs()
Message-ID: <671c1503b2702_203f412945a@iweiny-mobl.notmuch>
References: <20241021050443.318712-1-colyli@suse.de>
 <671c129aa250b_10e59294d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <671c129aa250b_10e59294d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c78359-f1f1-46e2-df1b-08dcf54089ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4z+sfZSSOxSbsyyBg2Sm+5nYplrr5FJMJ3wBo5Gr78hBhBHhUdvMTRWOpJyi?=
 =?us-ascii?Q?88f/Ax/K8zyq5foLDW690unIS19fU5wwO6w4UxRWaV7jRVMLVKvu9vgJBI82?=
 =?us-ascii?Q?ZKBZvGDpTrg3j4d8yu7bNImTz2244ldfgZN5A+8tEuAWvq/o7AIBaW+sBBml?=
 =?us-ascii?Q?MZT1udfHJ/iSIkVDzW7HmfUNYeLQ/ymbTmqBNIMr8ym6v6LbUNZ7Il0QHuhW?=
 =?us-ascii?Q?lvRM0cHYid5XYKceMx2MnJmjO5rEf4wCAyrAU/nup/PquEcLJhe4EuLB7wHH?=
 =?us-ascii?Q?jdB2c4gVSErWiDnUkDItRp+Bp5kEnc96wGXd3MWntziTxIocsJV9r9kuCymk?=
 =?us-ascii?Q?GOgzBNUDb/zDaJYLAKM1XCyCi2BdOXCGToUUSfyR3b1ScY9Tj9SD6ZjoN/1d?=
 =?us-ascii?Q?e30SGamuI32bfIpxKYh2FNupyAHzAr+nNvxDMZFQkz5OymNY1xbSB0ZafNCG?=
 =?us-ascii?Q?8RytZxMMCkBmuRxOkWSLmhZ6XhWgsCQ0N9uLut85QkPWgi5YfBWCWp6UFGL+?=
 =?us-ascii?Q?uLhfvkW36oC2rmkwcW2bITGgbpYUOtfzIw8CnzrXRL95Sm5D1fkwmj5c1tKq?=
 =?us-ascii?Q?5WfK+qLvoOFkVr1xMvXhkZUj/QMRK8P41RuzQ/LvOSo+76okoCecAZvYgDL6?=
 =?us-ascii?Q?CeWUehG6xU0Bm1aLNVQlTrPOx9+cacsewM5IORe1/6VGjLKCI3OWZal4J2FJ?=
 =?us-ascii?Q?SJSoFASmQxG44dBf0aDfA0At0mkRpzaMbdtZSRtZG9uhoOu1EMA1Lg69jiq0?=
 =?us-ascii?Q?whWT17ZwMRMNVeJeAqjpTpAaDW0YwT8o4z6ODKkFnayMq0vowA5Nqqk5XiEu?=
 =?us-ascii?Q?UYsP73woHiHP/83vxHvbf4MVyWFYW/sQGNWNF0a3AfLXfEhr/EkrDxsmod2i?=
 =?us-ascii?Q?R5FO193HL/dNnCH1w60mlKKyuU3wkaDerNXcuqZep288vvtzEKdqJk+jyt75?=
 =?us-ascii?Q?sDS7ykrnlhJZtmM+GQb47muKZ/+CUJ2DsFOQfIkefhGg1sg5Zo9XqLQoDq/j?=
 =?us-ascii?Q?OBGqI1zBuWQEJqx7h4GCF/rfUUL4s81bD5ZQ4Qu9eMQnaJ1f++hGd4T7Yli1?=
 =?us-ascii?Q?PQdF45P5C9dwIsPlZK7RndBU9EmrJQcmv+j/dqGE/99tA+gVlmCb7lXEW196?=
 =?us-ascii?Q?9dkfoKmjZ/0dYmicpDSuYzonx/n6T/ZXa55B5iwcukTz6fUbiUWTU72zn4D2?=
 =?us-ascii?Q?+Wanc9my8JTnOYVJlZLxLtTnhJI5JejjW9wxFdZe843rG18YOWf7OT1845Ta?=
 =?us-ascii?Q?ITFymfuLjTuI+YCojyt4e6HocCdtrxD5Dlzlln3cOdMT8CIrzSsL2fE9p9Vk?=
 =?us-ascii?Q?DkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDKRUMDh737StQDS0JahbUYfFDwvQ5cM05zitcSaRWIzptJKpAB7Z0Z39HDU?=
 =?us-ascii?Q?/CI0AEPEoUcNyELoDomekxtNYRjnQ+F0ZAuSgEAC4oRRunqi3QH6ZlvaG7hX?=
 =?us-ascii?Q?lTqhqxfunQvq7lL94+CoyoL02j6CNL05zU09BUJwJmsJGdxVLhqh+01u+4Ay?=
 =?us-ascii?Q?EDXcpFgDs4+DKxM1+AE2uQCYLwu3/eUjS8l6QeQiseCVUGAJwZtj6FzkwqAF?=
 =?us-ascii?Q?cXugPqoE+57xIjZ9/0zomfIDerdN9zXVM9H0AQYz0IZhWU4oWgQbe9rWHD1m?=
 =?us-ascii?Q?ggEqaYwfuwhMC9VhuZV/2FS87gspiPiZ2b3IOWlRWsshrA7tPfgnlpClzWgv?=
 =?us-ascii?Q?5m5TmWsNE2zrklboTsoaP6JpSfGjEOk4fy1WK5dt1XkzLZVUs6cVJjgmMxAC?=
 =?us-ascii?Q?rFg6t/k3oJoPBk1npchgEWuDOGRTXLgh1r7H749L7YKN2yk0RoBSHo6wna7z?=
 =?us-ascii?Q?fY7pj+n+Z+lAFcMnAGEh/scjbg5ChjVDBgUOPsJ+Qr5BSn6U8e5kr3f9jUlr?=
 =?us-ascii?Q?Y5Ods02AuXpqO/+QJfBefgmjUQaVNrqOrIY8usB16ksUo19jBgUoMgVMpaSc?=
 =?us-ascii?Q?hYXBW2lmQFMnFyGTsCx57kVcyFIPUeGFJQYc6NjwkDvDCc/l9qZJOLv+AG7K?=
 =?us-ascii?Q?ctyjfF6rj45mtvnWF2OexzNH69q62ItOe6gbE19NuS50lEs2HZYAd/OVfoyw?=
 =?us-ascii?Q?abi6AawTnlxXzHw0QE6fJbXBTW34/93jSqwjVb3dLfoOJidHGdOWBb9+BdHM?=
 =?us-ascii?Q?6op19TwJcBVaucYNJCgcHMozS/yLhWLUJm4sPbhvwIJNcEITiG7Ss7Roae7S?=
 =?us-ascii?Q?lXoud4ioB1casJEzif7GmGt4KHYYHpNvkwkcJ7zAcZrEa1WF2gin+xXOcRQh?=
 =?us-ascii?Q?qggxC1rCBQaq3hAoM4ZvPn1JMAduOPUVB9jbFWHlFXplT/aMa7/A6vhSwlPu?=
 =?us-ascii?Q?cgesS6TcGOe5MqOtyi2XRWEJPyj7LaCf1i+1baM3Fa0AoDoYbqHRyjFo7GHN?=
 =?us-ascii?Q?BJto6qFFy2EwxJV/ibBbg06pCK3B+ekWW7HOWqA/GGXpn3EwndQokOmrvcrC?=
 =?us-ascii?Q?aaOhlHMtialc0iV9YwxWSgYB1eutyGzqZ2ocYObFM3ix8sQgZwbURV88YqGz?=
 =?us-ascii?Q?+EBnwEvEe8UUo2Kmw4Ex65fPq7vETVkont5bgJqXAtvPoFI9sqVW0gKkUZ6c?=
 =?us-ascii?Q?5Qoo3gHEZ4blqOSjMjMrAVqPjqtHEwqns0WIdpK7LZJ1rvTIURCvrfMCDFJJ?=
 =?us-ascii?Q?1Szv5Hgj7lZRB9KVphqXQu4DAwu4wb3JmNVY5GvNMLBceh6V2OZOW0rEzmr2?=
 =?us-ascii?Q?hk5T2TuuUjBkoNNq30Nzo1O0q6EiAyv2LYjUVtVRnGxpLgUzOOcv4DNb8V0V?=
 =?us-ascii?Q?7NZ51ZpchF+/b36bQQGloEd9kX5nDMx/zrzArNeKhOhFPw0vyuFbU7isE2hi?=
 =?us-ascii?Q?DEhbbJuhFEmf3SOZr9tLvT+oCPpz9vrtW+56TrfHIsD0s12eyehoW9UgIfya?=
 =?us-ascii?Q?X8TSqF/Qk+MQcmz3HQi+SfSiWLdZPrnzeyYQjHvH5+8bMNq+shqpyzZMwZ79?=
 =?us-ascii?Q?lg10RC4YZuBkc9PTaKWY2qPX3MrGpFcL3CwkXV0C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c78359-f1f1-46e2-df1b-08dcf54089ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:01:11.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syLGZFdXFyKHL1MjfjU8z/QcwWyp7/hDoZgnIWMq3Gp3du3ztbsIsx7XogDDRc25qE9Ec5MfnxXlfcw4eVaelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4797
X-OriginatorOrg: intel.com

Dan Williams wrote:
> [ add Dave and Ira ]
> 
> Coly Li wrote:
> > In cxl_probe_component_regs() the error message "Couldn't locate the
> > CXL.cache and CXL.mem capability array header." is not a critical error
> > message indeed.
> 
> Instead of saying "is not a critical error message indeed", lets say "is
> potentially a false positive error condition". Because if the code could
> accurately identify that a CXL device is attached, and the CXL link is
> established, then it defintely would be an error worth reporting.
> 
> > Downgrade the message from error level to debug level
> > by using dev_dbg() to print the message, and the end users won't worry
> > about the message anymore.
> 
> Agree, kernel should not be emitting error messages unless it can
> concretely point to an end user visible loss of functionality.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Dave, or Ira, can you fix up the changelog per above on applying?

Yep.  Queued in cxl-next

Ira
