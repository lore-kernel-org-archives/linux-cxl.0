Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3502F56
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229759; cv=fail; b=bOsf51IohVNBBBSenI5lpvJBT0T9GwSk/boQQLGTU8/j6cnmuKzTfeoDpOzLWxd0uYW16HPzhEMx6TBDqc8jCkHeH0THR4eXFZRauLxhocT7b5DHYcS6G+ZC4np1ckFwtJdtP/P1d+tqdHtNutQS5Fs0YfPVvLl0OthlevFr5BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229759; c=relaxed/simple;
	bh=wew8f9yqTEFoMQ5zdTJzj/QPzNNj7zu0V+Q/6Fn2AeM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqJGZAvNP/rdpjSf0p5nlRbA516oRnHMhADsibWqAhfh0l4g+Oz5y6H7eMS0DmeOfI+dSGfLitiDc1UmG/CtkWm9XMkUlzehGmrdqS33GJqLvT75Zw8JwIj9BnRJlWHMGW69lXbolQ6hFOuzXFZijZ2hhbUAWKcAcjbqAFIb/GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gfl7V35A; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gfl7V35A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723229757; x=1754765757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wew8f9yqTEFoMQ5zdTJzj/QPzNNj7zu0V+Q/6Fn2AeM=;
  b=Gfl7V35AVHHFTcJkUDqFU4v6JsttuHFjPbHs7SOXWOpLpB7qlwU6NGkt
   BPM7fpvJ+t6MIlbHxcDSVC3qt0Hqzsi3og/uacBT5Np3VUNp2ewnEaZE+
   E3c4MMYuMgE9pvmYNmWIgs3hu3aTdN3lhQuHbnhIjTIhc8P7eRlO/tNAG
   nCCrw61Nh2p74Wy669/Jp7h4cvlidnshzRMEXY1pLugHpCX/yR+90F+JL
   SiHCs6BjLLXQQR6QHYBEueDRUanZvxe8/VjWrbcFK1Elkzk1iu9EBL7Te
   eUs2fOAkhS4oRer1Umr2gyHd24Hatewvdu4a125vd81ol7uZKjBcJRXuH
   Q==;
X-CSE-ConnectionGUID: yfc7CtMDRBmxS1+EP0Jpww==
X-CSE-MsgGUID: j+ZoIxXQTHuftR70f9bOWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21225721"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21225721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 11:55:56 -0700
X-CSE-ConnectionGUID: epO+PAwOSwKMlx79csK+MA==
X-CSE-MsgGUID: 07twIkhjT1mpb04OFmY5YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62596340"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 11:55:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 11:55:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 11:55:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 11:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViQLtqSsQit18U/9Ajp6pxp8l/G+5qqkLtLaAOR43HGb070RlQ9iksdPlr5S2X1cueFPN6cbPr7oJgoI+pbD1tO0N+7/O37X51fX/OVzFsurAtAO8sE4AAuremZBoq4mYsEjflSoNc0IDKLg1n/rGAErVsedTfypvKdK0dxS/JsjekFAVJv0lFpAU4MFqlmB3Iq3X2LNWKURk7qEKOulTXQJbriF5MJArnDTfDx+rjfqw6SazCLUvFrY3IF+1341F2tlEzFBiNmOOoUQT+tewuNjMC6Z8+HkDZt6Y2bEsVq6ciRrg6rLa8+ofQ0G1WkvqGC9GJ0fzmA2eBbvMv0s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wew8f9yqTEFoMQ5zdTJzj/QPzNNj7zu0V+Q/6Fn2AeM=;
 b=bBpSOCl9Tzc2tJ+aBhYOrFrl/6AkBmkYeMix4Jsoln+VirZsxcWOnj2cN/x5qZ0VZwJnr9giiMnKBh4zFbZ5HvkisjpTd9ISK6Hi0dB84wceCJhC8KbvKKClR5SaipJsE1BUMa+dD4QZyd2jJ2gQozvXnqAp/8Y8wFVyVM80Euu5kXfklpJ4rdkCdhQsPpU0ZPQLjEQRYijSf2iwj3+T5e2Xyf/f5qmHct4vry3/3G/O0APrgtbDLBFVj4wCffeGqXPDegM9Kj0xIbPD1fY9idJa18jyakYfCDdgBI9r51kF+NvBkF/wT+1kW1tZoKD4P4K9qjg+SQexZzK48xnJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 18:55:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 18:55:52 +0000
Date: Fri, 9 Aug 2024 11:55:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>, <yanfei.xu@intel.com>
Subject: Re: [v2 1/4] cxl/pci: Fix to record only non-zero ranges
Message-ID: <66b66634acec6_25752945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-2-yanfei.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809093442.646545-2-yanfei.xu@intel.com>
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4842:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c047a2-f82a-4f09-05b3-08dcb8a4e447
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SjF1dcokBLc4mJcyeYUYDFWepN8hn+jnMbNo7NAYeOtaitK7bXLA2EinAtbm?=
 =?us-ascii?Q?bxzl8ByrKGlS9h7DKGjZva02cAocGYYCmJZUm1BqCfTCzQB5QLC6ugoSRFh2?=
 =?us-ascii?Q?wKtOaYSWep2N92Mm1WliiUZqhy8xudJDe/Q/HoBLlc4PAK4BagXRIra9ZNJO?=
 =?us-ascii?Q?DHs405iYS9iZrPQJyqoH0u6NMTGI9oGlvCO7EptdZp+wUUboAXCNTR4/LP+h?=
 =?us-ascii?Q?vMplSkMnvVdkFmDAFw5ti6mr0wDqu2RsyvUYUC9HFutZnvrzYzwi+FRp83Pv?=
 =?us-ascii?Q?//6O7OWEgrnKfbt0Z01uoAttGygk0zVWbaMFvrbrczwNkqxuHa94ciYsjWVi?=
 =?us-ascii?Q?MmNbSAjS334qISb58aXR1g2BmcY5lVIrbvmWz8UG31Z9c+zsNiQlO6haxM6/?=
 =?us-ascii?Q?Er535Ri9qQLnhm1qmA01KS6CRsOXt50787CsppsZHuNLxQ8k+MfYPF7qi0wT?=
 =?us-ascii?Q?J8XKC9byzrkn5Q0Mwx6/af9QKpU72QWQQ6G0NmmaH1Fbc7MPy0uNYiGMl5Vx?=
 =?us-ascii?Q?hWA/FJy+k3dvUYOpsNcKNUJrhEjZPKoXdSVWd3+qecn7fESJmsURpSS+4aYc?=
 =?us-ascii?Q?FrAlWlgW8hFpzAMDKxsTt4IomyOje1kaHfO7yjjZ1YmuxglATae8qrt+Z6Zj?=
 =?us-ascii?Q?ZZgxdSpkT+MNQ9qrduGTvYXUgcvQtA8l+b8hOjNNn2EonlsJsKncduYp90Df?=
 =?us-ascii?Q?MZrsaFW8tS+ZTkaeeOBg3WXYVtRmuuRVUPs8hTsAxysXjxYtpKvQnnPQsVAX?=
 =?us-ascii?Q?ajYE5ocUX+4wTH1AJYy7eLyYid6t8qu3alkDCpgE0o9RuBeze1Y9+jnF/Edm?=
 =?us-ascii?Q?gKwPg+M3obONObi1P60+OakvgifMDmu0BHHp1tSWty6wBgIwQGBw5fb40N+c?=
 =?us-ascii?Q?nO62E4/thxa4KOAmZeFWg7YwSgcA8Bjr0ltGsdWZACXmCLRNdI2ru4CpD5qn?=
 =?us-ascii?Q?zF/uYPHQubJtngCBamEtTctpGXFor6d9qlV2/md08tB2WqzonLTEcxmCuE57?=
 =?us-ascii?Q?RTukBZojr0aBTCyssv0lCH2xXD94KeRkBaRejSZz2W22niPOdfh+708uw4cU?=
 =?us-ascii?Q?M++AsRNczsVTzvKo6sAzlf3VjOgRIGd4Lj08I7GpNvgk+aihJ4Tu5sot5M3G?=
 =?us-ascii?Q?1V5Uv3blJeZTY3GlxVoXQeZALZt/l6/XcDRF+AmaGUeZKlDq6EGoFlUd+N9f?=
 =?us-ascii?Q?64Ybb42oE0B5yKoZqCqOjeTitPXgJG/lHAebW0n0QQUjH03F9FMwiYeMKSp4?=
 =?us-ascii?Q?+ScU+Uzk59+nS76itoL2PVCZfrTsjk9VoucID2l3cv5o9E5q5nZ6pd2mHC71?=
 =?us-ascii?Q?yJPcfdOh9CRgVTUHmz6ZZ737TIgBgxh8eO/dHvC7OLqEPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVectRmss1GHUhxHuVs4fVzfeoHbBnWQLvc1RxIL3rSZMeCy1X8GzfYRGeAX?=
 =?us-ascii?Q?UuQZQHBlBUZZHBlDUp9/uGo8Wxbv5QtEsh+zfwTORWUSapjTyEhcPT73OSsB?=
 =?us-ascii?Q?zWHxFE7fGldDRX6CBfKc4Q+ZsyNe4tchH2/jc3fBM/BCzMyE+vIdALIJkc3z?=
 =?us-ascii?Q?BtI4u0X17LmKxLbukC9pXoLrBeBIeGbGgUY8qlYGKtMEGMoAan/4otOpHGS4?=
 =?us-ascii?Q?Z17HUmfLKi+gbTGyTLuOHZETE1L8SUipNYemf6bBqWW55abqCwmN9pookDNP?=
 =?us-ascii?Q?7kdKLy6maXz3K4Ld316bWvUn8L1c5SHrISusDpEVfwiZgJAAJGGsHbHNKx5s?=
 =?us-ascii?Q?PmCZWRVFUgx7yt0K3AbLLjYQ9qiUU32sAIaPGPtgYo2ByBvuvssgLRJBGIg4?=
 =?us-ascii?Q?fK6WaD39oAUKW/HwKDf3dElE2AoiphYyydyKhxE9/kqsd5EDWAiDGYz8NLm8?=
 =?us-ascii?Q?YdGpJvPFVRvts/xK4gKZvQgzdyxjYW3rKB76dws8y5XNO7nl5MjR14Sv+Afh?=
 =?us-ascii?Q?7wo+r0fgcohXSMIt3zKibLYyy42L7THGxZ8IAJ6JgHcp/uX1RfUPTJOhN6yh?=
 =?us-ascii?Q?pGrekoA05mqvp/RsezCNnR2CshDbt9Ho+HmpTAubwwhYrbslmINDkm72r5ta?=
 =?us-ascii?Q?a3J0d77B2+mJ4zSMknh/Xd+jwBvwHQCamQnY8J6aX3E0Qg1VYcJB5npz94U1?=
 =?us-ascii?Q?hoGGKbkqmqDgsrSDZwhMLds8RFXdVsA+oGbx6548KGKNJoviOfW8XjebshHy?=
 =?us-ascii?Q?lQT04ME6/HHkgGeqSjtcBBFBcXFxF2pwJ8eJxFmPO5DDKcFNoz7DpxaH2eoY?=
 =?us-ascii?Q?21Rdd6lvXVksoqeNMLbjqjpI/TD47n+2zIwxDw0nwJI1EEycFPPBgsdCZGzb?=
 =?us-ascii?Q?0kyEKD4hX6/G7wwbZudDMpFP2ZgS2XnCWqyq9p2+93D0shMagSibjaL8jT8g?=
 =?us-ascii?Q?tjxRtMDSSH7F4+hhYcUk/jC4x2Qw/i3BgU+7SaFlgq1UuHdQQLV5jrQ6llqE?=
 =?us-ascii?Q?wYVeTC5Mru6uFC8LQfVVQQAoIbUPkBRxiALneKo0Ax9ot80YGw1izlB3B42d?=
 =?us-ascii?Q?0cquCPpN6I9fkXmVNxoZlBPh1f8Ayy6+WrKJ+/JaQgOSO/lmgq3toHzmiBDw?=
 =?us-ascii?Q?KP2eoxKxZkNfwFkQqPKLJ25CDoPaET9pCd5GHn4pRoLP6aTY45NE45JPjwBs?=
 =?us-ascii?Q?7bztoT75pDzJ56FgVRGVSkvcTkM14OZ+LvJKcMYDYFd862cEGt6m8qt4hDWq?=
 =?us-ascii?Q?mb9uOJIBocMbwp3kktKOjSIwbGMNU8kgAVC0rFWzWbVNQwxUxiZ1dJnNkwyW?=
 =?us-ascii?Q?9toFsZq/fXJCpYbxX/rVORClwEi9YV94Vj6T/rI8cOrCwotdP37EWOXXTjBB?=
 =?us-ascii?Q?qV18jJufEoKeuFY1b991xiWHLHzqzN3an9hqBIYN1QAUlu+X1qpZ4JGpsfdI?=
 =?us-ascii?Q?rO/wcRsrx6IsZNrDY3P1hbmfn1xu6m00NxVauwNm1QibWeHxCfzItw/Mn7F+?=
 =?us-ascii?Q?glQeTzC25GxkdPniKaXyXAc97G6fInUIKRuoaj7O0WSOu+z/AAfe865ed/aM?=
 =?us-ascii?Q?MdETxXMjtY9KjvQeTEiWqLVFBkTBcAjUA0QBmEpmRzD+Dn8s/2Mj8JikzgdP?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c047a2-f82a-4f09-05b3-08dcb8a4e447
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 18:55:52.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ljAmwMaj9fxgxlBo2WPKwCKLf7II2MtNCwDK8WZgda/rudorrj+cr2rMPAz8R+MujP+Sd5KAfpi91tvKIsZOSmRSR5ldt5fr8YLoXJevFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
X-OriginatorOrg: intel.com

Yanfei Xu wrote:
> The function cxl_dvsec_rr_decode() retrieves and records DVSEC
> ranges into info->dvsec_range[], regardless of whether it is
> non-zero range, and the variable info->ranges indicates the number
> of non-zero ranges. However, in cxl_hdm_decode_init(), the validation
> for info->dvsec_range[] occurs in a for loop that iterates based
> on info->ranges. It may result in zero range to be validated but
> non-zero range not be validated, in turn, the number of allowed
> ranges is to be 0. Address it by only record non-zero ranges.

When applying this should mention the potential impact of the change,
something like:

"This fix is not urgent as it requires a configuration that zeroes out
the first dvsec range while populating the second. This has not been
observed, but it is theoretically possible. If this gets picked up for
-stable, no harm done, but there is no urgency to backport."
