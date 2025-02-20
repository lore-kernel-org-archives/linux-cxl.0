Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAEB28F5;
	Thu, 20 Feb 2025 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013328; cv=fail; b=dUfDQo2LtB7wyNQsFbS4+3mfUUMBk7K9LfMEF8pMmdAGsLroFiOin0SXTBs2mHSeSwagQlHqyOEvDxesq8sujEQXXb3qQOpOhjW17KrH5oB5liH/JKVJbpIBDobKBoXUV1TnJG9kLlPxxxZKetlBRQgMnNhzdxlu0BnJLJpB1As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013328; c=relaxed/simple;
	bh=TkNVeUfcpCz69YDtFK0Z3v+qsnufk/EprPtao9OXwV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kmdnNxOwF+FE34Ko838G4AHh7eFBc+pC/nl/zEy3xPNF/wQo//W3Yt9C69O+liIPBwhqkWKdjkyTShbf2TzspbqORPL66+gAcP8ewRkmso2uFloPnqRad3R40asZaTH877KciDHKwtCsXv4ArCvjbfhytLNVOX6T6odIp8Zg6qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5fcbaKs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5fcbaKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013327; x=1771549327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TkNVeUfcpCz69YDtFK0Z3v+qsnufk/EprPtao9OXwV4=;
  b=k5fcbaKsQimjmNxbrmZ47h0Td1+hUMQnwpcK2iSvKUmb8+AkwkRdLDIF
   cNHr75rSR5xvMyNKIBTsCvhICaD9FWNSsddmDorAZXqRhJltrOIQb4cRe
   HWg7efrnnSwyxkGlfINpkkvMMsgbA4jp1AOO/bEfg7rhVXMN2b4ZHOu1U
   i3KEug1ThfS2Fb8b+P7iCENhQdmF40tGR8mgLMYzMRyAxqlPntYrvDmGq
   Ko5S/KWNlottgSAgvF+pMQV86LqlgWjXU0iAduWwCss9eD72k6ZfI7IjM
   uylBQE+2UBm18LxlmDonmA4E4VEeqTSYTG28PC38rKzLMFtvbk71VqP5Z
   Q==;
X-CSE-ConnectionGUID: Jg97FOLCT5mmxS4dGFhScQ==
X-CSE-MsgGUID: +AYcYxXWSEykdNrjTpO46A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63252666"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63252666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:02:05 -0800
X-CSE-ConnectionGUID: 3be7QSBQRr6GQNY0PJBDpQ==
X-CSE-MsgGUID: 3kK4z6JFQfOSWbOPiQTWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114869796"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:02:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:02:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:02:03 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTZ8b0i3qgEHAhTkRdqAqwGa8ObaN4RBak24JjcKTvvYAKXvrAHauy2kVkuCl1jVEHnKl2VB5kNYoSFPhIoYH6bskahLJOu5D7DvRNBkmbVsdkYHo1Xhv4fQGbQNxwwuBoJCLTAOeQEFAaEutGq/Bbw580cYsiHnaDpNMxAyHl4jxqy+j9ByXlxoKJ6Qvdl0haZORBAhc+yQrrECrXRIcMUah6R9fRAWI81eERf1X8wyYFj7EBDg8InVNu7yZfFUmOMVKcUXwNaKVCwfqzTSg32vilg78pP8ZkuHAWrS4jMoy/ODWRJlHxolq9+g1SpDsXpPCT0b6mPQFTH/iUP6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx6cmRC/rEv49pEhWX7MxSSxltzZej7aHXt3c072JZE=;
 b=xyvH9dJyUB7vCeCCUzjO3QHQrg0pPDjF6xpTsL0cbu9slO0tYTWGVukAtvCYnZGXBwxVPnRUdUTbZuLtcoFUrT1H8gWzwMRFI4PseXDiP6gcZPIpMgropgJXaBknVuVR9zk5JFgP7wGrfuXSJu+BDp/m0ssgQ/rR8iQBqCQhcVvTjGq8jVZ3ibq8qf58kjQMKRTxK/1GHMatRiKsUMn6059nuhq8aDziIm9LpnLQ6puUNuNtTP4b1g2hth+DVnzVgpF34pvk605rcPl7U75GYYeKHDuq4+fHDp9JqJYS35ls11gJv6Egn2gcfHRufd9q/uKP+XL2O3mNH65KgPuIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:02:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 01:02:00 +0000
Date: Wed, 19 Feb 2025 17:01:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
Message-ID: <67b67f05f0a58_2d1e294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-6-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-6-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: b898b3e1-9d8f-4240-229c-08dd514a2e5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Cp5MGtY9cd9eBYtBufTzCEZUqTuH455sCDeII0iCG8MEFLQpJppZpGuLMLT?=
 =?us-ascii?Q?fJ3B50aJ9D36PWl/8mSrXy5xhzCUfotH3/RNFErW8KzqFaMjfrobG9gV4XWC?=
 =?us-ascii?Q?coVFkiLIhqTZVN7OsOAcvmGn4q1PJwkMHmhQDdvrNdGrCmolvU8ppxylB9Hw?=
 =?us-ascii?Q?KJh+oAv4dZ9OzUJwWzUdhGNHbB+p8y1xlg6Kh7w4+HK9Fv+HoqVOnivhvCHU?=
 =?us-ascii?Q?NnyDquVQctgFdHDVDLaUeDa55WHAMNzbAnXFCHjYJOZh2MAjB8bjKEPNRw4q?=
 =?us-ascii?Q?CO+NFyPPo5TElO0j/Uin5eTgMZtZ2MdjE3q9DHtvxr7Sep7a/4/Yfl4/vUob?=
 =?us-ascii?Q?cxUgcUzg3VgT2ERpvo0HI0ymEsdg87iT1Op9PbiG412JOhXEbnUZNJTFBHuy?=
 =?us-ascii?Q?4YzdIp7D4c+gSARhOzFS8RXrLBvesmlzRqMs+9zglIjOI4AuDEUjmD/fb7l0?=
 =?us-ascii?Q?2pROReywAKJAluCueeL8TD9WWji0Sd1tsu0rS6p17QlJHnnoHBqB3Tijg3Zb?=
 =?us-ascii?Q?5vEVPLixmSs3KpVE6KYjmfU6hkI8gr2Xcy6fPJ2oR7LtKCCaOEBEy2jCoz5W?=
 =?us-ascii?Q?oMqi/4JtoIEbP2y0bIMIqBMYwce+PkUIMN0lyOAAnC5//lS9PzjOAdV7vd8d?=
 =?us-ascii?Q?/HljF6X0FLqbDFKbZpwMf7u52XRMY4vvvF6QSAUurX4bbxIZViy4ypSdSb0F?=
 =?us-ascii?Q?UpclzNyE2iFf9vLPMMs15E7VmoDtg8cYsgN6l8z7w/MYODzxM2CPKSJnJn4m?=
 =?us-ascii?Q?tEaIklaYKtM0PjBdmVs/B8IRRaoID0ad0q0K0+GZfq1e0heza/uGEPePEicm?=
 =?us-ascii?Q?cTpiuzV4Ms0SoBsBUoQrE/GJ1Z63yyXQvp48JZ6b/r3Pj1h9M2Te0mFwU9cq?=
 =?us-ascii?Q?UFi94FSJ/pC5TEimFkxXxlTlS0/5olzuSBZGKsHxkOzpMIt5X2Ky5TI92Wiw?=
 =?us-ascii?Q?lIvaOR1+PIaE7s0ADVDQMbOIowgTO8Ot2EKEQbwWoK6WLT21CBnnKOfpbw5T?=
 =?us-ascii?Q?fkpvkq2OZBDTmg7haN12D+ul3o25MUJXgXvpWqj+S3aQhHZPoxqw8JgPqfjq?=
 =?us-ascii?Q?kJwQWoSlrAnYj63koKNvobysCJNVkYfAH6ZPZr7PTtWhjggZKsGCdWVK48Kd?=
 =?us-ascii?Q?ogjDZPpo32r1vN5xDBWGbp/OYTDBaIkKcNZsE77svnz09geRBJOmHERMytzE?=
 =?us-ascii?Q?6h6tQuwqqPvpH62FppsknwtU64OT9fDWdBpI2FjC0umScoxRSU+moVq+bNqX?=
 =?us-ascii?Q?hmRKg31FKQpVMN17Q28/pSBQBInu+RcJ66mz3H8k+n1UJ8Rx0UGjhaC4lYE9?=
 =?us-ascii?Q?bBQi3c5LzPGuAfEbm+HrCwlCauiaCzEp0MFqdsyqDONLZIaKkcT/AkM8VvqW?=
 =?us-ascii?Q?7qqbhDsT3iZ41zW1bp+h/G5CKLgg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qr6YFvEGEVgVt4PBHne+65UWcm98Z+ktl8HzOdr7PNYk2veAho43e5ovJ+Y?=
 =?us-ascii?Q?Xvod0F1sm3OMfBHxTndROKMUkKNcH5xetz6VS2p4xLSLHDcIekELSBphveyZ?=
 =?us-ascii?Q?6iLShC7nKtOmagIhNwhpwxlUdcIuxGx/iL/6cHqUqd2Y/Llhc+/v+o5yNfFn?=
 =?us-ascii?Q?I6LbCXXIqWpPx32MgpNoP7Yyn0qFa4FUqvm258CUr5T6R6EeeGuz4Z7NK4gx?=
 =?us-ascii?Q?c3EEVNjWiaHTDiVKj6F96hEYchC6xnbByzYQoXP63jNioiBT8cmSpqS1hEPI?=
 =?us-ascii?Q?FCeOhMg74j6kSFotQpmZW7tfV4p4C1ihc69mM1npO1WnwbrThb//tKNOpe2y?=
 =?us-ascii?Q?VvcHIfMsimc8aup+7uLB2eUgG2lpsSs4FkdphkxlpySCkaMBJXEvdrNbJlba?=
 =?us-ascii?Q?l2I8PKCd0nF+q/X4jjJkHdaqpgLGyPmw4Hi20wXh9U9AYlfTsDAA8fghekf5?=
 =?us-ascii?Q?+qgcZYaXj3S46Qm16T14eQd/GZ35ib9vaR6Ia/MbAxEQIRDiYriciksUhdGj?=
 =?us-ascii?Q?nATD05GRlDtnwWg4DmBmT/o9tNmAmTqNdj2UfzgbOvNvOWrahdugFtaTbC6R?=
 =?us-ascii?Q?p/qr4HkyjlgJOqm9vc5LjOko+ALiXaPL+DulyP3spUZqLTDujTVrUbRME5vZ?=
 =?us-ascii?Q?KTjfdEjYutLhrFjecMRxWWnhtJPrCsO6rlNxM7R+tl/EtmTnQI9CpgcOUMXQ?=
 =?us-ascii?Q?gaRNJMWqPMtHLXYZ0XnRH8sihcsTiAtpfl3AXvc3mME/o7zCQWhVOQ9QlpM4?=
 =?us-ascii?Q?HXHyKESlaITDwZfdg+a1L2m3iHMtbHFkraT87lvDCKQGvFa1RjB3qpAv3FdJ?=
 =?us-ascii?Q?ZQdbZu4hD5UfV5iBZxbSoTA9OFJkgmfTefwIcL5vddKpoHRJ18p99UOCrV2A?=
 =?us-ascii?Q?ZT3lMiZqtV+ZGEu8oFRQooVB/B/1ZtVanNrsiNQa2HJ4NcwlLYFoVh5pr1o4?=
 =?us-ascii?Q?o6udeZGuqNHNLUPIi2cEPy/HKd1HfD5XMrm9Z6fOkD9EjBlanMgogU1tM4jf?=
 =?us-ascii?Q?cCRhnduP8/jdqpFplXInYSU/POFBcjf+u27tp8lAzb2+WIzMFBEC8NIC2+HV?=
 =?us-ascii?Q?EWsri46nJkUe/8PTCXZui/pW5bh1taytA6De3jSN6fDeTM7Saee2+f6F0RC/?=
 =?us-ascii?Q?FfCMbLwv12v1sf04R4iOtmhwSPgBjV5F9WJ/hwKpnMHIizhH3qWc5tBk6UYr?=
 =?us-ascii?Q?GHi10pY+Eq+Sa19YqJh9jovLu2CQpq6BqSmQ2Ki5k1KvCqXbTggp8fIQlUrd?=
 =?us-ascii?Q?m+JQaPbDvX3/BiQ9wq5EJjt/lXi4rUnf4HMuA/mGX/W698TXpP/ad3p/q3Xz?=
 =?us-ascii?Q?ynyp9siTozyfk+GTf0kGeq2OiHrRgAx5pwG0VSMDtmVO8So6tz0STkOWvG9c?=
 =?us-ascii?Q?I7i8PbUyaSlnik0yQMwZXfByo/jiVMUFB8FeZpgxvz41N/fVR8NiNd5GeCtJ?=
 =?us-ascii?Q?aPU0oy8Rj17rxWVXaZ0BNd5J7f0+bCUhkvm5w2rK9lAWSUoIJzwhljD6jQ/h?=
 =?us-ascii?Q?/pbdzlAPVUOHFLCO3yjf4W56ZJ9I/lqzC/ukrhRryzMM55lgd6FGHQF/HuMk?=
 =?us-ascii?Q?M6fJCogECmCSqpoFpJryIcwTuDlbdBmr0EHppsBJeLZKtWDS1fDX1Ru8rZo4?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b898b3e1-9d8f-4240-229c-08dd514a2e5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:02:00.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oShwpaEGfyBDkiUToRuHAnJ55+4N3c0z78WLMS+ADVS2m9a4l4KIt9heDrNGrl5mgQd/7sIsKNRKw5d9SP15wUc1PkJnkTKlL0/lfIYKt4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

Li Ming wrote:
> In cxl_dpa_alloc(), some checking and operations need to be protected by
> a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
> cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
> by using guard() to hold the rwsem.
> 
> Creating a new function called __cxl_dpa_alloc() to include all checking
> and operations needed to be procted by cxl_dpa_rwsem. Using
> guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
> function.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/hdm.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 874a791f8292..1edbf7873471 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[..]
> @@ -504,21 +500,24 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		skip = skip_end - skip_start + 1;
>  	} else {
>  		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>  			cxl_decoder_mode_name(cxled->mode), &avail);
> -		rc = -ENOSPC;
> -		goto out;
> +		return -ENOSPC;
>  	}
>  
> -	rc = __cxl_dpa_reserve(cxled, start, size, skip);
> -out:
> -	up_write(&cxl_dpa_rwsem);
> +	return __cxl_dpa_reserve(cxled, start, size, skip);
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);

Am I missing something? This @port variable is unused?

> +	int rc;
>  
> +	rc = __cxl_dpa_alloc(cxled, size);
>  	if (rc)
>  		return rc;
>  

So I think you can drop this new cxl_dpa_alloc + __cxl_dpa_alloc scheme?

After that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
