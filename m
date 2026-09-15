Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127F3CCFCC;
	Tue, 15 Sep 2026 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438618; cv=fail; b=Z+ZGXZIANwevCzDjp66dH+kXVyoBGsF3O1avFlAgXrqp+mTRG0neC3FNUTZNj7VLOczWP4IBbcrouaxou5Ec2X/fq3YHBasMaCdCGaf/Mdq7qR9U2jlA1AVvxbjQqhPUt/ofvM6AU2uoLP9UEbik4dSka0JhtywNIQ4UUnYAfgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438618; c=relaxed/simple;
	bh=97ofPzYVDBovlOjMKeRjxvmrCA+QJ/QcRH/k9S/0PsM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EX7ZCVJFiJzvIa50aqet4Z5K3CTdfx/binGuSagAZ4azOrcCJtYuzFQVWjNJNU78m2KBlhmDnefZb2UYAVpWl6YAVdUf7X5ryt70+g86BS8oq8VJdJiozFRgqtExJFaAAipvECi641KGRLLictcwY3/BRd2lL6DLp2wW6rHlv2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAPzg4xz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAPzg4xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789438616; x=1820974616;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=97ofPzYVDBovlOjMKeRjxvmrCA+QJ/QcRH/k9S/0PsM=;
  b=RAPzg4xz07e5N9TjqleQqHHe/vLpvL5xEMFZ02qsxstMQRlaFC+Ugiu3
   LmhzNUz2CjcZxxK+SqEGUM9M8VN6hGrQefunoevQY06Q5X4cWJm+B7IZH
   fBZlREQN5G/lLmvfFNOSRVS21kK7u6+tP9Me319oYvjAsCRTJ7hFqKhuY
   d5YRz+O5BdG3X471KtwW2E6dCLGf900HNh8iZnbppfBrkHUwV7qMt3HaX
   HV2S4toIbX70VqOO+59hOBYdQJ9VMSqCQkkRRW+51xBPnhqVfh0CAwXJZ
   6yory+QVZBI+Itvy9NaNbeaKlRwlCo2FxvGxd3guGzUmZYYQ8/dO6CNVg
   g==;
X-CSE-ConnectionGUID: ul63zoW6Tw+B0DAdWYs3OA==
X-CSE-MsgGUID: vCRB0bzITwKLpWnWHvNNsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100457870"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100457870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 19:16:55 -0700
X-CSE-ConnectionGUID: MyVVrfx/TRa78gyC3gB5Ww==
X-CSE-MsgGUID: bHJHFr+TSSGJf4bwBSL+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271395635"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 19:16:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 19:16:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 19:16:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 19:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C95jl0y+aOj1G5ykMUiyJdnaRFPP/JxD7IMU5ACOju8NxxCM0PItR7MfXM2U64aWFP9zBZuiw3zaOXl3NZ/YYFMGEazOKVXvFR+iFo+9NyYhEgQuZ+9yLlqdRTgDLhev2vRVsExvJbzKri/IkFEP/m3c4X4F+EgpfmRArFWUgnQ3+LlObM4PgpZbh0vkzaNdXcIqsH7PRlkiWog4eqL+vqYnDrRFuJqlnoV4/hU4aT/qb+Veo8c42qZ3eqZ52h7BS7mHqPqaDdZp4nu9QA1gXryFbyTqwuSrtfmgNDzoIDi6vGClE+unduuSJQTuk9PWvUIe0cOtR9kw62ZazufLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9b913qiaifom0MuZvn3oAhhZWHwrmRtW54BRNf8MwQ=;
 b=QULATYdSPA3cbuk17l+pOrsntou0BzbluwiOQQSnZRDl4Lr4D8Rv5DdAfDhzmBz/C3erhLh2N6MPyNPrBiZFJsVDMh89vSBecHcwaGzLdt2lVFtHVFoGylgbhHMqiy+CfEYL4oBkDKRc8fKYXD8Kw1ZSLl2mKnXU+YAWSktY/+VVIw1weC1JLdFRSFRNUV73fRHCqNSwkWyZe6jwWMA2vduygrYKv98YlNScGGE3zXVr/wyDj2O3iXgsAQ15TiuA73dgtfkbX78iotLQ1dy8r8sJVGDXDRgndzGcG3i0Q5VuUZWylZIpgaHtx7o6rK28qFiAuYTXwGcYwEDMXGyzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB9599.namprd11.prod.outlook.com (2603:10b6:408:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:46 +0000
Date: Mon, 14 Sep 2026 19:16:41 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <jic23@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<newtonl@nvidia.com>, <mochs@nvidia.com>, <kristinc@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Williams
	<djbw@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 2/3] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <aqiqied1QPHrDMKA@aschofie-mobl2.lan>
References: <20260914090858.19181-1-icheng@nvidia.com>
 <20260914090858.19181-3-icheng@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914090858.19181-3-icheng@nvidia.com>
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a150a4f-c296-4b7a-ef1c-08df12cf644c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|4143699003|5023799004|11063799006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: JEso1twr2J6Qpb8JHAAhtzBGRj3zGUIhzwVVtlZT/IdrJdVASzFBVleUD3MQ17umWgkfJdXMTTnPMMkb0CpmvHBwQuAbACvqaeENxZTd9KaS2aR02+kTWkJiaIIJ22Xgn9tbXW0pJIuJWBiZKhAiu9hOkq8EG3a1Xh4iCtpI6+aGjqLj5RMNYW/PQuFM0YUNA2Hx1q9fkhI5bQv7nY7oUkd33z/zsp5QyMlZCIfmKKMLVB61NLaDiqAl7zF2khIphtHprK5n3PSJRSawfNylGNXpkxtNEuzp8h35267kae4G1nbwSl3wSPQk6g87JXRXzbY4tRGReKYuYdxBc0q/tTs7e0n5LumIBlPT9/etqRkMjVVdBsqSgJpA6eWfsCurP0hZo1CHfu2hk1FOTY8qt8YcKTKJwtS5z6CMCBPKrtaqDvoz6Dg2mB9jndgWOh0Ygq+cpUhbPHBT8gWTfygA7NJUTdbu6mJsG8ZFP5yc6DdRI0qF+CgWmMwtIpwwqfg7YDjE84AuPO3VCAviVncWLKFppTx63l03hwnpVP1Sc1TR2j9kGgDNyNRhym2OpSA7LDV0Mv8KVNsnQDZviiQEenXL3rnpfhbPApja/F9n3x76SYRmVaxSvQZHozJjN0PJSPBP5Ox/0EQqR3uZ8S5PMoQc0VywCUx8zxPvZYC1/FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iDjoEEl1OK43cur49E/crQNuLb6B9bex9gdj1s3xH7v4+swu1F70gftxzJ?=
 =?iso-8859-1?Q?6x7ux91pfLE7B2PHY3a/WlW+Xc1uE+M4ij8ghm4dK4UT+9YUg0nnfLPyHZ?=
 =?iso-8859-1?Q?ysvQFS5wWMEgmKg7Etx4O7hqp/FMBWj2EuiBWA0A9gxe9c/w6YFC7tBAs+?=
 =?iso-8859-1?Q?9H5HoE3MGECRJKr3A1cdKUmwNXpM/HB/4w97DXgLH0BI5UgI8HsrUFpx5E?=
 =?iso-8859-1?Q?VI0j2QYRkBkFDHAiuNBBSC+Ke1UQ/GgoOFyZN7TrR7sxYgsVBMiRtZBQ2t?=
 =?iso-8859-1?Q?LbqoxNiaPZEHc6YGJoqTQnh+zcObiC7gNT81UVxKAvAEXS8U4LSHbLL7Dw?=
 =?iso-8859-1?Q?J2fMkWU7z05QUOC4NJ0YzGYgycomrWe8KNYHBcc1IGABTmHkJmVaTqOTVG?=
 =?iso-8859-1?Q?yiLVQzdFflSkJ3Ew3k/NnHqnI8c6cI+TsHDSe4rLQFj7q5ejvJAkSnSXrh?=
 =?iso-8859-1?Q?SZlY6atLn+LPaHF7aMZfO2mMpg+e8yMJpMsL5nEkKpDjt8qCEGAZELObo4?=
 =?iso-8859-1?Q?tsj/34Fvo8WeqknD1mxTJpih9N0AHLZl5GrZdDmDVf5AePm/FgfMn0o19C?=
 =?iso-8859-1?Q?fUtgJ+8PCi6IJxy3W+014kOUMohGommMD8+ZzlaqgGcQ6uAcmueHWys+N3?=
 =?iso-8859-1?Q?ugQi/psPP92ppLjnk5aqenhEFuwfm6twC+poobdXoj6j084TYry1K84ghc?=
 =?iso-8859-1?Q?BOwuk+vrLbOnWVXIV1pboEU6mRb6vWa4jzrAGaQCXZoIYcCqDfuPOAi1E7?=
 =?iso-8859-1?Q?wut9Op0azCI7kmCGXQ7wQrsF/FjmSHAbQrHvwxxImqnFSfq82FsXaJNtp1?=
 =?iso-8859-1?Q?0IYWcjzTGJ23qpfHOs9gjyDQGwOzMN1CAkjL/BOmYir0Liseighpj8vXbd?=
 =?iso-8859-1?Q?g46dx1CH63ZI5spv8NUkqsEi24MK2BrY4+S34YnRpP2qrvXAdVF8P1kAmW?=
 =?iso-8859-1?Q?tGxatIKJRAD3FmtUc/DAfKBZa8ikA2uP8L4/lR3EsnxdXHtMIYOofsxpzC?=
 =?iso-8859-1?Q?1OENr0rdGvsBvs4dNIwjMRJSUzInTWW5vmCFUPG0a0HnYLrYyuSmQWjO/Q?=
 =?iso-8859-1?Q?yAl85QX/n4QlCc3vqysXyLYn1/61eJihmNNbIYZWYDY34V7KubfoyF2V/d?=
 =?iso-8859-1?Q?Pm2tU4Bw89NQfNZ1N6JCW6ofQCMaZuPsJkEGBB/ZquaMKyI1dpk8hWyhZ8?=
 =?iso-8859-1?Q?0t21hLh5Xhp0Z4aeNes0Ud7gqP5+ulOVeDZkOsLR4irN/ux5ZTGwUDei/8?=
 =?iso-8859-1?Q?9/9Cbk8mNq+LfTnu1xfwVa2S21+g2LXT6IjCF8vCGQEjkqcZ7o/FIPYDzh?=
 =?iso-8859-1?Q?rYIFE2a7bGNtgWb+t3Tmd+J3br3iaxOkaed8r6UguNwdqcoabjIbsA6Al2?=
 =?iso-8859-1?Q?qvCPpMM0UWnLOKF0qZzHO8hMLyJfrUxIGVAiICNw2lo717ZXS+udz9ANqD?=
 =?iso-8859-1?Q?/2eYLhnVMPBjJoY71xtvvO+gjS77NZmRjlxxs0zqBTZgPHYdkCG5JrgneA?=
 =?iso-8859-1?Q?W35b9sk+piyp7oEGic7pGQynnrA5gmjWr65PZAcKMHUSKHw1KKPYRWqjAK?=
 =?iso-8859-1?Q?7SYgN+TKL2+yKBulivRNDD+vG3gkrAr7P3aev7ERhVqVkXFKzFa+nhhSK6?=
 =?iso-8859-1?Q?0yLvu4aQpCNngatl6QqfmabOWOK6BMDmFxuOvH2ZPNGwWfYxXsvvq9oShj?=
 =?iso-8859-1?Q?nmdAGzMBbJyYXHdXnSDboICIb/2E/h5Mg8hnqZTfvfcl/h4+vmb/GZy2Dh?=
 =?iso-8859-1?Q?dv+zkZLsY6aCak6gblRDMeWJQt7CXYr6OGh8Zo2SSceErz+K/oNlMqJUyo?=
 =?iso-8859-1?Q?zJzTWPuKyAJVOYnCfD8gkrugXkH1aHA=3D?=
X-Exchange-RoutingPolicyChecked: pd/mSNAkY4tcax5BpqYKYQbm7hWR8oPOaXjJBNHzdW9QQITP2lEkbmcYc3DJoBP3bmEApK+TvRBrpnJwWjBk7u4onUHw+KChVqXgOOJ5ncGFSEo8RehcfuQhT+1DOw8byiFaiOTVD501bTPUp9jjfa8nHlWMlC3OLdaVLo3A+xawWys4u/XYz+iUDzA/6NDEOvA7AvS10PGMfMAzT19OCLq/hY/FX8QzRe7SNydPVtyAWDeZu9H9vs1YQ3KEuq8EmYEnf3+YeQ9m7ggETgVumtv3QGn9wj+3qQKEMbxDSvWj238WB4ERokSuh3b/YzYvCufa825b7nZWgQaPLt6t6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a150a4f-c296-4b7a-ef1c-08df12cf644c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:46.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amrwOstR7+vCuA9AjV3Z/DMUa0UDMoCv6zaL9AwN4sxaK4f/nWG52JZsu1h4Svxz882dWsHWQw6SK7t0fBZdj8vlaq50DWhyenuC8V1Ho/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9599
X-OriginatorOrg: intel.com

On Mon, Sep 14, 2026 at 05:08:57PM +0800, Richard Cheng wrote:
> CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> with size 0. BIOS may commit and lock such decoders so the OS cannot
> program regions through them, this is a design choice rather than a spec
> requirement.
> 
> The kernel rejected these with -ENXIO during port enumeration and
> aborted the whole port, so affected systems showed nothing under "cxl
> list".
> 
> Treat empty decoders as first class reservations. Back them with a
> separately allocated resource, since the resource tree cannot represent
> an empty range, and keep the skip and hdm_end accounting intact. Exclude
> empty decoders from region assembly and avoid zero-length poison queries.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dan Williams <djbw@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Changelog:
> 
> v9 -> v10:
> - Preserve -ENOMEM when allocation of the standalone zero-sized resource
>   fails.
> - Retain the !cxled->dpa_res guard in cxl_dpa_free().
> - Reconstruct the commit message
> 
> Best regards,
> Richard Cheng
> ---
>  drivers/cxl/core/hdm.c    | 58 +++++++++++++++++++++++++++------------
>  drivers/cxl/core/mbox.c   |  3 ++
>  drivers/cxl/core/region.c | 45 ++++++++++++++++++++----------
>  drivers/cxl/cxl.h         | 10 +++++++
>  drivers/cxl/port.c        |  3 ++
>  5 files changed, 86 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..39fe283cbc74 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
>  }
>  #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
>  
> +static void cxl_dpa_release_region(struct resource *parent,
> +				   struct resource *res)
> +{
> +	/* zero sized decoders are not tracked in the resource tree */
> +	if (resource_size(res) == 0) {
> +		kfree(res);
> +		return;
> +	}
> +
> +	__release_region(parent, res->start, resource_size(res));
> +}
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  
>  	/* save @skip_start, before @res is released */
>  	skip_start = res->start - cxled->skip;
> -	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> +	cxl_dpa_release_region(&cxlds->dpa_res, res);
>  	if (cxled->skip)
>  		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
> @@ -336,6 +348,27 @@ static int request_skip(struct cxl_dev_state *cxlds,
>  	return -EBUSY;
>  }
>  
> +static struct resource *cxl_dpa_request_region(struct resource *parent,
> +					       resource_size_t start,
> +					       resource_size_t n,
> +					       const char *name)
> +{
> +	struct resource *res;
> +
> +	if (!n) {
> +		res = kmalloc_obj(*res);
> +		if (!res)
> +			return ERR_PTR(-ENOMEM);
> +
> +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> +
> +		return res;
> +	}
> +
> +	res = __request_region(parent, start, n, name, 0);
> +	return res ?: ERR_PTR(-EBUSY);
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -349,12 +382,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  
> -	if (!len) {
> -		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
> -			 port->id, cxled->cxld.id);
> -		return -EINVAL;
> -	}
> -
>  	if (cxled->dpa_res) {
>  		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
>  			port->id, cxled->cxld.id, cxled->dpa_res);
> @@ -378,14 +405,14 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		if (rc)
>  			return rc;
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> -	if (!res) {
> +	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
> +				     dev_name(&cxled->cxld.dev));
> +	if (IS_ERR(res)) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>  			port->id, cxled->cxld.id);
>  		if (skipped)
>  			release_skip(cxlds, base - skipped, skipped);
> -		return -EBUSY;
> +		return PTR_ERR(res);
>  	}
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
> @@ -402,7 +429,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				break;
>  			}
>  
> -	if (cxled->part < 0)
> +	/* Empty decoders may not be contained by a partition boundary */
> +	if (cxled->part < 0 && resource_size(res))
>  		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
>  			 port->id, cxled->cxld.id, res);
>  
> @@ -1031,12 +1059,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			return -ENXIO;
>  		}
>  
> -		if (size == 0) {
> -			dev_warn(&port->dev,
> -				 "decoder%d.%d: Committed with zero size\n",
> -				 port->id, cxld->id);
> -			return -ENXIO;
> -		}
>  		port->commit_end = cxld->id;
>  	} else {
>  		if (cxled) {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..1a2553332801 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1386,6 +1386,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int nr_records = 0;
>  	int rc;
>  
> +	if (!len)
> +		return 0;
> +
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>  		return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 677ebec8f48d..f54acbf68e84 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2113,7 +2113,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (!cxled->dpa_res) {
> +	if (cxled_empty(cxled)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
> @@ -2967,24 +2967,31 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	if (!cxled->dpa_res)
>  		return 0;
>  
> -	cxlmd = cxled_to_memdev(cxled);
> -	cxlds = cxlmd->cxlds;
> -	mode = cxlds->part[cxled->part].mode;
> +	/*
> +	 * Handle the degenerate case of a device with only empty decoders. An
> +	 * empty decoder can still map a non-zero skip range, so advance the
> +	 * walk to commit_end either way.
> +	 */
> +	if (cxled->part >= 0) {
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +		mode = cxlds->part[cxled->part].mode;
>  
> -	if (cxled->skip) {
> -		offset = cxled->dpa_res->start - cxled->skip;
> -		length = cxled->skip;
> -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (cxled->skip) {
> +			offset = cxled->dpa_res->start - cxled->skip;
> +			length = cxled->skip;
> +			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +			if (rc && !poison_efault_forgiven(rc, mode))
> +				return rc;
> +		}
> +
> +		offset = cxled->dpa_res->start;
> +		length = cxled->dpa_res->end - offset + 1;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
>  		if (rc && !poison_efault_forgiven(rc, mode))
>  			return rc;
>  	}
>  
> -	offset = cxled->dpa_res->start;
> -	length = cxled->dpa_res->end - offset + 1;
> -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc && !poison_efault_forgiven(rc, mode))
> -		return rc;
> -
>  	/* Iterate until commit_end is reached */
>  	if (cxled->cxld.id == ctx->port->commit_end) {
>  		ctx->offset = cxled->dpa_res->end + 1;
> @@ -3006,9 +3013,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	};
>  
>  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> -	if (rc == 1)
> +	if (rc == 1) {
> +		/*
> +		 * No decoder with a sized DPA reservation was walked
> +		 * (every committed decoder is zero-size): scan all
> +		 * partitions in full.
> +		 */
> +		if (ctx.part < 0)
> +			ctx.part = 0;
>  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
> +	}
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..3ef0810ab86b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -336,6 +336,16 @@ struct cxl_endpoint_decoder {
>  	int pos;
>  };
>  
> +/*
> + * The common case is decoders with no reservation, but also handle
> + * decoders with a zero-sized reservation that firmware may install for
> + * security lockdown purposes.
> + */
> +static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
> +{
> +	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
> +}
> +
>  /**
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..c12fd0b89883 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -46,6 +46,9 @@ static int discover_region(struct device *dev, void *unused)
>  	if (cxled->state != CXL_DECODER_STATE_AUTO)
>  		return 0;
>  
> +	if (cxled_empty(cxled))
> +		return 0;
> +
>  	/*
>  	 * Region enumeration is opportunistic, if this add-event fails,
>  	 * continue to the next endpoint decoder.
> -- 
> 2.43.0
> 
