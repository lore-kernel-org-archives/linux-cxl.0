Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1F2E64A
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722191627; cv=fail; b=czYLEBjdHFHoNgfLwL1JonVYZ/QLWYDyMEncdGltSGq1DP1VnNeHR1Jo7LrnnMng42UVKvc6fXzTkCnQtlkCoW7DK2Dt9NXlDmaNbN7XfJAVg/y59ybgCThDENLqiN5lNg4R8DqWxYbChQqUvPgUq7qwJoQI6xvxzicskcOkYNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722191627; c=relaxed/simple;
	bh=HAOSNC8cO8mtV6CrvipjpRAm9KLEVa/6BlrfqPmehog=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQh0LwLDZVMeaGS+Q9RmrhNEiaQ26cd2L17RTB6DtXu5nSN4M4cxUH6lwyltWWg7BHSkoHGNKC7pcJz3Spm1cymNzWgDqz9uAnfswq3h4Wq/VoRfPUdzevZ5Qh1LXQumLPw6jW9WUyExWDadegeT8nt7zXW+DScIzM9UHrb0b70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxUvF+hh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxUvF+hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722191624; x=1753727624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HAOSNC8cO8mtV6CrvipjpRAm9KLEVa/6BlrfqPmehog=;
  b=YxUvF+hhGCuAH/Vx01EepyJ5xKG5kH4zYpFS8af6fQa0ZdIy1XpHiHu7
   jUxJ2yP5QXyFCGS8gE6n8E+4iSDWMJhvNXA1Fmnj7fFutQTQfkWQPSrax
   WKjRBtmPIsQoIImtpQuwNRCoGW9Fn3SX5HMaLRb0EFa6E872BwpvvDdLF
   NHTaOx1rrTy+QiWR2I+Hp8tZJ1oEczEGX4wsHTxPVTTeo9M/qX4LuwJ/F
   KfzCAzSyZdzVAFumdRiEwAEDTD6OozsxEemcNOo/IYjMphdwWneSEZdL9
   GBbZEFNqt80Hl/OlXFHsNKntCBP/heIU7sVVLoB8Z1iaPOTk7UgXxVrLZ
   w==;
X-CSE-ConnectionGUID: CpgNBVCcQGqShbr6mAH2bg==
X-CSE-MsgGUID: iSPt+pErS/KjoINvnXWMzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19887213"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="19887213"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 11:33:44 -0700
X-CSE-ConnectionGUID: 8i4qxk6XRnyAZhNpsDIAvg==
X-CSE-MsgGUID: qVPDiOShRpGv+23fwCr4bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="54559565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 11:33:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 11:33:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 11:33:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 11:33:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 11:33:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heSn0KVd3YWuNrOOOHR+/o4eZufaaSuAEEp77/9dSeN1XUuHsNttwlfyEHsRBcxf0VUGvU83Llcy2aDNiU+oxcuDr0uiJjCkYM94McxQVeLBB7rDAuYZCczjcrJn8mfc5BEHkPOOoufpeCOY2gVvAF1jVxVWjEIfAikjOv7tjDkp3349mrltx4xhBxSF9Vrcf+1EVrkRxt+zGpszdL1m7ZoOP7Ea3f/6a/X4K6PwVc4XFM4m+hqxJyF2Tun4MtdKKrW+Ik3UEygg+HSzSnQIwRB7zd5qWjTqmOh5XAHFYlUxgLh9uzouls+gbYikhF6wo2DI9bacLwybHSZhyDcQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQxrDCoZ5oMspdbJByOwm5/RzmqmjpdOKFfKi3bgsWY=;
 b=QV46wPPRh9qGfMbYKFHJ11H3E0EbGeMsIE3s5I0/uHNHD4Yfvfv7AJS1ureVaPa85iO08o/qbLFYqnRCkks/29wbsVfnYOZkCBtPMXn/LIHDdcpmtJrWbIO5NCyKY3LEnp3a5f8tjROyi/5g3uMPGzlzWzRVCe5jYbxFFlEBfjRJbR5Uw+ey5DfizvV5DqIRoDL6BnXNkJKfwq8BjU4dStSUch36XqnA9i7nArcKYG9wVGVUXfEGmGNz0OUUHtdtTUCHiJ0DBXbNbRt7d8lfpQkm4j6soB9tySOofNjxAiMaqBp2cIur6/2tZ1ZbgLVwahBPxBRVd7hv+rsp0W2vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.24; Sun, 28 Jul
 2024 18:33:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 18:33:34 +0000
Date: Sun, 28 Jul 2024 13:33:29 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.11
Message-ID: <66a68ef9a3798_2bf8a429499@iweiny-mobl.notmuch>
References: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b34cc30-5399-4012-3046-08dcaf33c971
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rWiwo4p/0N5uGJh/1KXDYg9i11Em5is9nezzLYe1rBc2s1FURXoBae/LCb8D?=
 =?us-ascii?Q?ffVuuXwIukgkXmgq+emZ6sr70mVDAG5jTou5tfxgqXLJSa09WhMzHi5C57yY?=
 =?us-ascii?Q?TPmUtAriIF+J2HiFCZwY8To0CuUXT+NfbCutFLsmWIYDUTLUZI8XxgZCKlkq?=
 =?us-ascii?Q?Kro0BGWK+x4TtVyWD2wpuJmc1k+CYDY2xgLkBRR5bvO08PHfnxu9p8BmNw/o?=
 =?us-ascii?Q?4lA0AG7DNLvehtESPsex8Ekr1IYtxwRVhBtxGuLe5raA6E5gDOCWy4xVdfWN?=
 =?us-ascii?Q?FYrsFQsEyQwhH83cXJzkUGYZeRCPK2mQmlaBU5QzkhTlLMBpp/2Lz/0/V5/Q?=
 =?us-ascii?Q?he/TNEuXYvPZnNJp7+J9q7ds07qwfTz2VAL9fdyCGuKxdsSdyTy26QX2jw25?=
 =?us-ascii?Q?Qn/vUAJ7W3YXIcEfVuqvKYyKw4TrYQSmvDwGYdng1+Sn/Bh5TQU6TTtVe8VN?=
 =?us-ascii?Q?9zLFSvUSzK+OVVT1zPGDaramOaUZOlWK8r33NFAVeOep1p4xuvIPd94tqXcx?=
 =?us-ascii?Q?lDTtuBbU+TvH4/dZY29q9kgEIj6pA10N/+NtJMTO1OTKWsXMZuFCMDkla+vT?=
 =?us-ascii?Q?tk2o5cgB7CXLjcsj2ktWIE68qUOKZFjphtUVp+oSoH/O9yEOoTgUyy1C33jV?=
 =?us-ascii?Q?rKgjg8kowZ2uepj4VTDqPdTaDQAwnp5O4E6VYxf2aY4kCb7i7jnuqzlNFtHz?=
 =?us-ascii?Q?THSHVbJMxcimkIf4kRfF+mlk8qxutEaRV57UHoLisOt6ySA8xmIv/RwIAfYD?=
 =?us-ascii?Q?E0e3Uqqsjjtj03jVcMGqXp2DvAF1IDBxtuKpGxhrrbPhpewuB++YhyNBSh5I?=
 =?us-ascii?Q?riSZJ5z3Kz84bMaRTf9NgsBgEKXePgtrdXbk40neAkpeJ40Jkn/bIW2itFwv?=
 =?us-ascii?Q?IXFNBPD5A5sQqLn+akEKnGYrwAsDl1u8KLPByKWaDxnV4QQoHWuxtXvYrYQT?=
 =?us-ascii?Q?OQ2LRGkNDQgkoW/CZ905xVM6UACs3Wg8pdh19Uz6esI9cBP7v6/tMank0rZC?=
 =?us-ascii?Q?5a0aVfLBPLiX19IDk6YkNTJSpISstgqbPqHryFdv6LT0qad9naPB9R/oJkR0?=
 =?us-ascii?Q?AJn4kFkHBEP29FuEdafDTzx9fv9xc/kH6Nun6ewXVHWLtS5MGaOfanjM2jQh?=
 =?us-ascii?Q?GTa16xv+JZDJ4uhauqMHvekUe7VsmkGULKaypvQWGqErhVd8wrlJUpqO0V3H?=
 =?us-ascii?Q?exZZhWybEnaM6ni7vZtO7wNn/JL+Nt3VwbtvaODmAjP5vSK7g+dWOKDaCvLl?=
 =?us-ascii?Q?luBSbMsqyMDNvJo5v44Z5w4C4L38KOs8ihE05cu9oVAewn9EXDQV8iTQP65R?=
 =?us-ascii?Q?4f5NSkrSlF4NV+TY/CC1cdafLV2fUL1XShuMbGuigL7i8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEpipEh+ODbb+U6fHtq60e2wiQ3xQNQy+H04g5AnjHaXcV9dqmPdoD3w5nSc?=
 =?us-ascii?Q?QuAVzRuQsE/QcIfXfsiMXKnnisgFBvnX0I4yIKpGzAZUpiiLBBFcqdGt75gV?=
 =?us-ascii?Q?7ducPW20h0nvwCuQkYCwYT4jtg/k9rumxx8hRFZZL9OADQwdeu4H0p8tqGWe?=
 =?us-ascii?Q?XVB3i0q5Psf57k5KmUbEkEHkXKVyPFlvWw/W+RsYio23GtjfvH0JHVflud9E?=
 =?us-ascii?Q?JtJaPyaESipC4YvV9WvCFJ/smW3Zy78lkq2ESCM9fp/2w9XeV/vBZkQrn8eg?=
 =?us-ascii?Q?l4Ft6Ic8UzxjWkJiPvII4N7Ab4BUCP2pCGXFvf6l9gKp1wUX2g7nOBWn+rD5?=
 =?us-ascii?Q?6scGSAQRpkR+g7TfpoZoJWOOej4BhAgNsJS1CwzM/cvmPI6qg/ILdMpiMGoq?=
 =?us-ascii?Q?xkAY/kjPkZc7IA06sOMk1oSyKasc7rMEhMeulKIc5qZt3cabfcUiK5+MUnoY?=
 =?us-ascii?Q?b2LhYC8eow2pKnel65JVbV6loT/VR7XQrWRlQEZ25rizg5TEGDcw+Z/TSmJ3?=
 =?us-ascii?Q?fxHx0JzGv9qvLCPuUhurOCXT0L+Rt6xuYebhHiP0HhXsDzXGjG+oeA/w+boE?=
 =?us-ascii?Q?SItITcpb1H8TEte8zcxuM26E0ua57rDuI946EljVQ/nQT56xjCaQv3kCQ4rh?=
 =?us-ascii?Q?BNOGAn/n9eYb/8jm+1Nmp6xbyx5XA8tYT0DoJo1YYF71++46gV5eUc53SwiQ?=
 =?us-ascii?Q?iYiiY3IeeRQHMTpmC/ltV5aISTV5F7ndNmEDgLmMLTmbZije/tywML/bowJW?=
 =?us-ascii?Q?q7lpV+SANZ8oKcRK+q9h4a782Tkx9K/KbuAIx8cXxRc9a8I+om93mrF5LkL+?=
 =?us-ascii?Q?s/9sXLFRP4Ed5pyR5gzXdwkg1RJwZYtbdwvPVPGtZsoOMzezqw2CniS3vnkH?=
 =?us-ascii?Q?25b+udspCWy095irqN+581emJa0jCeloa9eYOOs5VVNfJEO5HpQPD7vHjq2F?=
 =?us-ascii?Q?0B7ZoDzaNzlyvDc3nSe57+XYp5GxiQM4qRoLFxTSWfG7bCjnZ/UmRcwABu7E?=
 =?us-ascii?Q?+3yKSi6EIAJi8zbkiC75D6w9JFwa3doKwyCpK0hTOAT/IQniFouL3NgUaYQn?=
 =?us-ascii?Q?OKj8pnnm7jwfFEIbJLr8EUcTVU5RsDA5p7M18pbv3vhiQAMdwT3CA1Y/CKV5?=
 =?us-ascii?Q?EKnbmaPprqWUBVOvNSgilc5nnT/y7jD+0fbr3xYAz8BbezW7icxN5EoYGoE0?=
 =?us-ascii?Q?jODhuHaxpi32DXlqOHdA0u3Xz504BbphWFgmgre4TBvzqN7y8pYsj11OlwcG?=
 =?us-ascii?Q?gIio/V2TfnefZ4299IkLd4lplqx1IdVCa/3kleee55zcFbw1kecFxzYMScFO?=
 =?us-ascii?Q?QsJiSsWLnK1XldB00MOhfExNfbKYwPrNdAVQvfA/mAF0Y5+fEanjRoX8Q9MZ?=
 =?us-ascii?Q?sfPLFHGQhsHM3RnX8MFEtkI+72XyCQLxYxyojiTbouwpQFa+4U9mJahOgHMd?=
 =?us-ascii?Q?vyumcCiYA6qaMVZZZXwnIK0Bjr4WBt1ZtpBBQdj34TFrttlqFkqGp6IHRE8b?=
 =?us-ascii?Q?9pvroWlUYFEF4PnObh2/F+oCwyDgkgLQFtTgAZBIYWXJoQpm9/kzVZ9C6jvR?=
 =?us-ascii?Q?e1NSy6d4oGOPE/IQE2YoobA31B8f9K2Lf0TKB5lp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34cc30-5399-4012-3046-08dcaf33c971
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 18:33:33.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lN+vWyEqWljJCYXeW3dZCZ5SuJgfJCw8YRgYaTSAfKWcCnJv3oG8sh9Eg63XjO1g8lCS3MXU9wMcmh7nsZVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Hi Linus, please pull from:

Linus,

Dave is on vacation and he asked that I look out for this pull request.

Was there something amiss with this or will it make the 6.11 merge?

Thank you,
Ira

> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11
> 
> ...to receive changes, cleanups, and fixes for CXL.
> 
> The major additions are:
> A CXL maturity map has been added to the documentation to detail the current
> state of CXL enabling. It provides the status of the current state of various
> CXL features to inform current and future contributors of where things are and
> which areas need contribution.
> 
> A notifier handler has been added in order for a newly created CXL memory
> region to trigger the abstract distance metrics calculation. This should
> bring parity for CXL memory to the same level vs hotplugged DRAM for NUMA
> abstract distance calculation. The abstract distance reflects relative
> performance used for memory tiering handling.
> 
> An addition for XOR math has been added to address the CXL DPA to SPA
> translation. CXL address translation did not support address interleave math
> with XOR prior to this change.
> 
> A few fixes contains:
> Fix to address race condition in the CXL memory hotplug notifier.
> 
> Add missing MODULE_DESCRIPTION() for CXL modules.
> 
> Fix incorrect vendor debug UUID define.
> 
> A few minor changes added:
> A warning has been added to inform users of an unsupported configuration when mixing
> CXL VH and RCH/RCD hierarchies.
> 
> The ENXIO error code has been replaced with EBUSY for inject poison limit reached via
> debugfs and cxl-test support.
> 
> Moving the PCI config read in cxl_dvsec_rr_decode() to avoid unnecessary PCI config reads.
> 
> A refactor to a common struct for DRAM and general media CXL events.
> 
> 
> This pull request has appeared in the linux-next for about a week and has build
> success notification from kbuild-robot.
> 
> ---
> 
> The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:
> 
>   Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11
> 
> for you to fetch changes up to a0328b397f3339d8d17a6ec356e94b3c110b010c:
> 
>   cxl/core/pci: Move reading of control register to immediately before usage (2024-07-17 10:35:08 -0700)
> 
> ----------------------------------------------------------------
> CXL for v6.11 merge window
> 
> New Changes:
> - Refactor to a common struct for DRAM and general media CXL events
> - Add abstract distance calculation support for CXL
> - Add CXL maturity map documentation to detail current state of CXL enabling
> - Add warning on mixed CXL VH and RCH/RCD hierachy to inform unsupported config
> - Replace ENXIO with EBUSY for inject poison limit reached via debugfs
> - Replace ENXIO with EBUSY for inject poison cxl-test support
> - XOR math fixup for DPA to SPA translation. Current math works for MODULO arithmetic
>   where HPA==SPA, however not for XOR decode.
> - Move pci config read in cxl_dvsec_rr_decode() to avoid unnecessary acess
> 
> Fixes:
> - Add a fix to address race condition in CXL memory hotplug notifier
> - Add missing MODULE_DESCRIPTION() for CXL modules
> - Fix incorrect vendor debug UUID define
> 
> ----------------------------------------------------------------
> Alison Schofield (6):
>       cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
>       cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
>       cxl/core: Fold cxl_trace_hpa() into cxl_dpa_to_hpa()
>       cxl: Restore XOR'd position bits during address translation
>       cxl/region: Verify target positions using the ordered target list
>       cxl: Remove defunct code calculating host bridge target positions
> 
> Dan Williams (1):
>       Documentation: CXL Maturity Map
> 
> Dave Jiang (1):
>       Merge branch 'for-6.11/xor_fixes' into cxl-for-next
> 
> Fabio M. De Francesco (2):
>       cxl/events: Use a common struct for DRAM and General Media events
>       cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
> 
> Foryun Ma (1):
>       cxl/core/pci: Move reading of control register to immediately before usage
> 
> Huang Ying (3):
>       cxl/region: Fix a race condition in memory hotplug notifier
>       cxl/region: Support to calculate memory tier abstract distance
>       cxl/region: Simplify cxl_region_nid()
> 
> Jeff Johnson (1):
>       cxl: add missing MODULE_DESCRIPTION() macros
> 
> peng guo (1):
>       cxl/core: Fix incorrect vendor debug UUID define
> 
>  Documentation/ABI/testing/debugfs-cxl         |   7 +-
>  Documentation/driver-api/cxl/index.rst        |   2 +
>  Documentation/driver-api/cxl/maturity-map.rst | 202 ++++++++++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  drivers/cxl/acpi.c                            | 125 ++++++++--------
>  drivers/cxl/core/core.h                       |   8 +-
>  drivers/cxl/core/mbox.c                       |   4 +-
>  drivers/cxl/core/pci.c                        |   8 +-
>  drivers/cxl/core/port.c                       |  21 +--
>  drivers/cxl/core/region.c                     | 105 ++++++++-----
>  drivers/cxl/core/trace.h                      |  36 ++---
>  drivers/cxl/cxl.h                             |  13 +-
>  drivers/cxl/cxlmem.h                          |   4 +-
>  drivers/cxl/mem.c                             |   1 +
>  drivers/cxl/pci.c                             |   1 +
>  drivers/cxl/pmem.c                            |   1 +
>  drivers/cxl/port.c                            |   1 +
>  include/linux/cxl-event.h                     |  45 +++---
>  tools/testing/cxl/test/mem.c                  |  69 ++++-----
>  19 files changed, 442 insertions(+), 212 deletions(-)
>  create mode 100644 Documentation/driver-api/cxl/maturity-map.rst


