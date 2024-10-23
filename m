Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D41D0BA4;
	Wed, 23 Oct 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707606; cv=fail; b=PxbSFpaBEFdfkjaz5krlVq6yQl76YxlE553XlkTJyEWQuiDxHYfTC9vj6gD44H3FYXm80to1NxaEsNaCTvUzOUCL+6FY/JnOsU98seKiXvZRv5yc8UfCHFAp7AKyhLhdgq8aEPfc7SMwNhYTWaVm+qrDEcZ+k+fMW9BvvBE/7h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707606; c=relaxed/simple;
	bh=YRvEbhG7IzTtOKHYUACbYxLCCm+v1OMyQyiBumvXuuo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2/v9cTgdExlpb+ymWf0Sf0HPT7gMlUR4gLc9omu75qHjVk8knNCjOmW9EkxeOXp3fbzdA5Hr9ZZOZ2sVtaM+CbVi6ZDkWKMplfx5STBtO5ULeNi8YSxAbIFn8JGyVOsNqh9oLmmN8e6Ypn3qoMV1a3jN0mp9+3Bgo614nebvyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/aTRMiR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/aTRMiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729707605; x=1761243605;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YRvEbhG7IzTtOKHYUACbYxLCCm+v1OMyQyiBumvXuuo=;
  b=k/aTRMiROibMmrqZJWCqCTB51nSGZACawNgoCn4Oc/hmF1U3wxQeTo5H
   7jBZWESFMf4fmcWs70LosodtJCciFKdLowlrcw0/HXMCAi3bqEPa4GjFw
   BZ1mXLfmIUdazXUrSGua82524VgncxYSTEYbDXeU4jeG50nu7aNegPPPv
   VV3AkPYr0rjz/+sNHWYG17cTfbdoYhTK6IdwofTTcjhA/c7eXFM+VPqY8
   PEV1tYzRvcK/idDH8F08dgKYrVqlyzvFhsVSijyTzyv8sm6yPtgGznq9w
   3clp0PowNejy+BogEF2LjfKzKVxq/flBgjy++6CFsclgKIbKxUBnQPurj
   Q==;
X-CSE-ConnectionGUID: SN6GYBy6TFqwvBZm20w+JA==
X-CSE-MsgGUID: hRY6zjw4T+uG/lkIlv5P1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28770289"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="28770289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 11:20:04 -0700
X-CSE-ConnectionGUID: dgb7E/clRIaCCURCj9eYTQ==
X-CSE-MsgGUID: rAPNTr8pQSuuaICgo8rrdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="103648938"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 11:20:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 11:20:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 11:20:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 11:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m23zU5EMbcCzhbUmFD/N75N3v3ZQa0LyOJSBoOu4ep7j4IjvsixwP4hg0n+B9qv4/p1BOSJiSre10/M409ZpPtGUv8dTrDrz4+cTT4e4jYpLY/OOQ/87WYSgyPk8G6dvABH9IjXQb2evr5ti0YayHrhx+HeScdskQT4g/uS0vDFeI9W2UVysaaSIz1aDqhtwxX+CXSfOHRRrdLbPx/2JYe0vpBmF3+pWj9EkjGjfOPF2W9i36mNB9Epb/pF4ZwCpBJZ3wl8hwIQuOA412aVLyAQClEMmZNNgBAgACW6en9mTVtTEJAaY1sax3u6hczbDHxQVJdfYbfmFDqzAed0Hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWKW9d6VV56Ae1WH1UXWIELALEEbbwOSJUF47QoWz/Q=;
 b=WUAlq612U59eppeHFKD7Lkll702FcBSQDvjarWHleo3Qtgu9c16a2poiEwwPOV97YsM+Bqx1ClDGZtOfOhYuKtdkekm1yURNbqPj/+V/YtEYIlwRWdTWxiq7h1M/UNUCdSWWOeJNwjMptLxd0ce2Eb3nhcndn2mHl4MhcH1JQx4jk352iNgczLRPcw21l6RJ/h1y8aEDu5I0jUVD4hD+WfBznjrGrSCRvS3JhiPt2fj1uYJB7yUt91F04MCtpREmV8bmV43eJqrGaG011vHpYcV9eNPg6Nm6MPDT6zH5JCteobXviUE+jkb7jsGJ6odz8vZJaEXeo7aJ1K/MVxXmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 18:19:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 18:19:59 +0000
Date: Wed, 23 Oct 2024 13:19:48 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya
	<bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/cdat: Use %pra for dpa range outputs
Message-ID: <67193e446b625_d944929428@iweiny-mobl.notmuch>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-3-7f49ba58208b@intel.com>
 <ZxcCnbV8fsSbTeGf@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxcCnbV8fsSbTeGf@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 85db9fe0-bd53-4b03-743b-08dcf38f4dee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xpV1ahEf415xnx9/rLxTTqXxp69f+rTYMr8IdgD+EUWTfAJ7SGZwGiSilg7j?=
 =?us-ascii?Q?hM8sK8WqOZIKP1rS2gyfiN/z2IwwMeLlEZJ/mKx3NR721UP0+/cOp7lV3K8E?=
 =?us-ascii?Q?dVkiPMwvoqoAyU5gMH8t08tIR/ZI+6O++cT9xbHsqGX6U4/YOqie6s/d4O3L?=
 =?us-ascii?Q?zD08iizDrR8F7bME4Oq1yGXkZfPn4bG7W//0uFuIdnIJkU/PlJw9owt/c+dw?=
 =?us-ascii?Q?mGKrggApD/98QllXfVYEhd6P2/2aIsbMEsJU9raTgPSUWdcWYkzTWHhciy42?=
 =?us-ascii?Q?agL0unrR2K1E69GWV67ID0Ni8nQy/AyLYzgrkWxr9HsVBggcjYBS1a//y68l?=
 =?us-ascii?Q?8tVDn3fgowwyHunO8FsGXgqZGzTqkgK3ok0RM4xLxydgDUzc5HqSDNQhaoRj?=
 =?us-ascii?Q?SqZsQSiqhHHCSCxcq4uuSR366ivaTm7OG4og7R2lVLpUmG3FQSjxs5alJlhr?=
 =?us-ascii?Q?8zm5bdspiFANdji+XHqE0ANAefwWL5f4i0CCmrIlRXhnE1pHuyyvGXEE6PrV?=
 =?us-ascii?Q?QfDh/tAS1L7JIdc3438JcJYmJhQqGkZvj2oLZpiMXgQIqmYIkSNb1EsfQp/j?=
 =?us-ascii?Q?FRrWhrjAY4aIqXK48OBR3KOCZRyW2pHHA7vHiadb9IZfz92q8JXjGxZn1OJf?=
 =?us-ascii?Q?0jEwMC4omeOKUjFZLL0ohQ+BR1HwDMt5Kq9kPqZ8W1TSlWciwL90C4jHPgIm?=
 =?us-ascii?Q?EzuZJhdIOdsLujHkRc6ukhqWzfEqAXoXWu7N44bE/GRKQC5LH/Bdsk6/SQ3a?=
 =?us-ascii?Q?RVgUD3doNQRIeGDif8/NaH12cCPwNj5sxXZr6UrHrB3prNto/TfDhUwAsxX2?=
 =?us-ascii?Q?NCGPb9XEGmidUxu2s9Dwo1JUxOVu3jCHoDHgXAnjSTEpM0WcqalgjlYfKyem?=
 =?us-ascii?Q?fMHWEXC+K3lMA3HNRTb17KAR+rZUQ1IGgEvejGW0XP+QxS3IoA+l9/zCejGt?=
 =?us-ascii?Q?+jIyHFDS6ENCPJQwHBGqGEnutNnLBtqzNeMPJrtDwEAW1CFMwTCB097z9S5W?=
 =?us-ascii?Q?4jAww1nTBMEDDT4uFTnFWKv+d5fbGuGNR33JbKc95OComjn7Wal/le6nbeww?=
 =?us-ascii?Q?PAFwzaCAWkwhnFkjiPmbJyRN/h03hG/2HUXPTAcKZgOAn1tj3KzuUrmZkaDI?=
 =?us-ascii?Q?uicQAlxfwSeL+Q5WRTrRWpUHPWx525JqsjLc/+gdMOTiKBonYdu6uPDZoc9D?=
 =?us-ascii?Q?DFQEcBu5vs4GF75kd0dEhQvRBV82PxHg5j+aNYPjXL2vWBRaNsKXts/MRBsf?=
 =?us-ascii?Q?wzbbdGTwMvCx6StQVit+/3c1sRVKlwtxhDspYiZUL9rSADbEwGMzMurLD8mp?=
 =?us-ascii?Q?dsMs83MdBNQLJ8NkZJ7SXzaA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QyEp7GWYpniwoSffdXUaan8ARq9/W2rYK9a5bloOG9Sv8uO90RdcURgALge?=
 =?us-ascii?Q?JXNDVXNTZueMxkKa+yD99bl2X3G1drOccc7Hhy9SBxoHv19aC4vVZ/h/fDNb?=
 =?us-ascii?Q?VCoz2SmnYG0JJLziGkRRuLkzIMJTRgEvbrw4uoarsw17rQ2iaWBVP5iYAQzD?=
 =?us-ascii?Q?TljstVEKpbwYsTV2w6Rh3f9iBaupXzCCwX8AEoYtyXneyldzHVat2NJFHv09?=
 =?us-ascii?Q?vWMjrjQU1nPOWIpZ0VF7V76pj3D82gFPvbmX/TsHGDT0xlcEKXc+y+36xR1x?=
 =?us-ascii?Q?zQSRe0HtBeX+jBYpad5BlqQEl4gJ9gBU8m5AdeXuQgzw1xTQ8udgDtFSCyZC?=
 =?us-ascii?Q?wzswHVKivs5KfyyJ+ably0ccGeKqXj6oAMB5m1WncSyqsuQQYtr9OgD0SjMV?=
 =?us-ascii?Q?VYaGe8caTI2GrK3H+98B8249v8SN1eRH/yCal5xRCff3kguJknQAbVNM/Sv4?=
 =?us-ascii?Q?Gyp4Uaz8VWL/8QnsvDNhmJDvT506FcasCncZuFkbuOqu1hLxArcMeRgzbQ+E?=
 =?us-ascii?Q?V21CV99Ddm379JRlLf2J6vyKNbZRMH6ucv2KRlZ5PWjhUYEr/CB7tH+bYNE4?=
 =?us-ascii?Q?C9nqvFeorgjzJ/AcTYIPH6eFH8GDtdWSh5JhEIl1xLljAtqbdt3EkOGN5LWK?=
 =?us-ascii?Q?O0nDhJo8Avz8PaUtvHneIyIITE3XfICY9lJlDFP52Os1andNakAbNbGnwHDf?=
 =?us-ascii?Q?yXHZaSFlluSu+KD3kPCP6LZ1lz3efb1Koof9ntNsoXn0YfVUeDy+bCofRg22?=
 =?us-ascii?Q?NmGT/1Wx9rfa2a04L3mn/YW6W0k9GImkYOc66YbpSJdI4RDfDAwe4sns3Mbj?=
 =?us-ascii?Q?VRZr2M7bjWLx15wX0ymmetyjfVnCRL1gGKN92ly6Sh8d5JBzt52G9QewiEi5?=
 =?us-ascii?Q?6nkYtDkv/MEClnrQgdUWZ98/wlldap7ZnffIW1D8i9EKbdDixICjs9yBAy+5?=
 =?us-ascii?Q?xb2/dOXwE86iTcRAgfmTmNC3FvXsqAB6RVaHwUoYSkwPl8c1gAHDwnUJcbSG?=
 =?us-ascii?Q?aEdiAbJmF2uJb3E6MQGbdyZ8Vz7ZRNITzM3AP0FItxj+sP3FTRoRg4coajtk?=
 =?us-ascii?Q?VM/P2lduyFpFyc3EkLFt/1WZLmFgoUk6U97NDB1bQsCIWRWCUmoUjD1M7hQ1?=
 =?us-ascii?Q?QMEcNZfN3sxFCGRi4Wadc+MgiwoN73uN9bSNgVIy7KEa1vJ4T9L0aMBUK8T3?=
 =?us-ascii?Q?mZSeZ3WBtdRusrD7z9H7o+udxt3awQAi1T+EjVB+rmSwnzBTTuA8T44/Y1Ks?=
 =?us-ascii?Q?noFe4d7huW5z5bVfRlrOXkZ4KRSNUL3UIq7Rb3HXFkiWF50EWTaeBQReZ6hZ?=
 =?us-ascii?Q?NYbisvL8VRTEYhqpzN/3Bl9Wbam3B/dA1WWIpNzE/Cgh3g/gLLJMe0DFR5UR?=
 =?us-ascii?Q?oYQKsMsl1JJKK4L3KEnjx97MQznJWZmzt7zVfkpB34OUKm1kWvKSiJk8nNSV?=
 =?us-ascii?Q?/iTVoYAKt3SSY6CSntLiMwa65CWhJ/umxbJYINeOJF6ViLDkjyFYNnHW9l35?=
 =?us-ascii?Q?roJFagKTep1L0ZF0iPdHhnI4cY7oBzSv3sKeu6kO5uy79UNxqryVyj76zy6G?=
 =?us-ascii?Q?Qp+MxFNVQ/WywJRwbFRzNqeGGG5j+dwUsqxXUpdr+wGuyNx4dgETa5VHTz3M?=
 =?us-ascii?Q?C5WrB4VV43luoHHuOLJR5ML2udQcYfAycVhVQBhMIYen?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85db9fe0-bd53-4b03-743b-08dcf38f4dee
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:19:59.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0kiW5YpJ48RlnpXg3sOPuOPC7NUFMcFWYJp/RX75aPuyAW+M/eV4GVZq3nXeG4Gwugt46AYt7SMsmy2RDGAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Oct 18, 2024 at 02:46:26PM -0500, Ira Weiny wrote:
> > Now that there is a printf specifier for struct range use it to enhance
> > the debug output of CDAT data.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/cdat.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index ef1621d40f05..438869df241a 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >  	dpa_perf->dpa_range = dent->dpa_range;
> >  	dpa_perf->qos_class = dent->qos_class;
> >  	dev_dbg(dev,
> > -		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> > -		dent->dpa_range.start, dpa_perf->qos_class,
> > +		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> > +		&dent->dpa_range, dpa_perf->qos_class,
> >  		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
> >  		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
> >  		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
> > @@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> >  			 range_contains(&pmem_range, &dent->dpa_range))
> >  			update_perf_entry(dev, dent, &mds->pmem_perf);
> >  		else
> > -			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
> > -				dent->dpa_range.start);
> > +			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > +				&dent->dpa_range);
> >  	}
> >  }
> 
> This is a bit different than what I expected to find as the initial use case
> because it wasn't printing a range.

The reason this was chosen was I was adding to this code and found the
range to be advantageous while doing so.  But the patch was stand alone
in the original DCD series so could be included here.

> With this change we go from printing only
> the .start to printing the range.

Yes that is why I mentioned that %pra is used ...  "to enhance
the debug output of CDAT data."

>
> Seems the wording of the dev_ message could
> change too since 'dpa' has been replaced with a 'dpa range'.

Could be but it made sense to me to read:

"... dpa [range 0x...-0x...]"

Because %pra adds 'range'.

> 
> There are a few places that print the range now and can be cleaned up w this
> specifier. Those are the real 'uglies' like this:

True this is ugly and I would like to clean this up.  But the cdat code
was being modified and lead me to this particular call site.  But it was
also stand alone enough to be used here.

> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 223c273c0cd1..85a121b7b2b5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -941,8 +941,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                 return rc;
>         }
> 
> -       dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
> -               port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
> +       dev_dbg(&port->dev, "decoder%d.%d: range: %pra iw: %d ig: %d\n",
> +               port->id, cxld->id, &cxld->hpa_range,
>                 cxld->interleave_ways, cxld->interleave_granularity);
> 
> 
> I guess you could (ducks) pick them all up here, or we can leave it
> for a future cleanup, or we can just say no cleanups and we'll use
> %pra going forward only.
 
I would say we get the specifier in then look at any clean up which works
for us going forward.  Like in this case where I was editing the code
anyway.

Ira
