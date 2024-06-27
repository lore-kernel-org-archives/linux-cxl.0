Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6A5223
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453158; cv=fail; b=SP6/JkkvCm2vlY4mHzQSmNGZ0YgDqS/ykdxB1/U6iRFgFs1a/VwRXFmnpcRYv9ruQnFKmlk+U7I9POKaaW+7H+EFjTLuXQtErPzUrxqIMyurOXW88HN1e9Y9QSXSp/6mL8izpw+1u1OA1YKtcao9Yq69rzgtYOhjGUEkACEUmM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453158; c=relaxed/simple;
	bh=gr/55g4TEPxtFeFwCtDyCzCvbLoWCXnEujXgvNltUHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjRkjsvpakKDRZ0IFNwSViFr+iN995WC8d0Qtk1aIYACGVUrk9nulp8ix29RfNHC4K0QAIX0M3Hn0S1x/D6bkFNCnsr3R77H8sZyWIczP99fF29rAZZEjEGY84rzF80CItaLEcs95/gimPkWFVoGdmR6tAWa9Uw3Pvs68r/tG+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRf0ZxNl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRf0ZxNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719453157; x=1750989157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gr/55g4TEPxtFeFwCtDyCzCvbLoWCXnEujXgvNltUHM=;
  b=aRf0ZxNlo3LFdtoWrFa9esugH0AZX2Wjev4w70ROXPshvWdS7cdzaRuJ
   1rtK2jF5trKE7EbozKLKvjcF1bRMeXpQDPBn5wn4blPD8GKuevMo83fk1
   ZpaYbngmxNlP/BkSUcNPMF8o1aij50s3IUPxHcCPQUxOEgx2Psu46TZMY
   G+sKIemsvqYWMNiNqn/AHHIZUDQHhqq7cDsiAChYAlf+2kCFo+9ZO3Lq6
   yT4/pJibo53Rc8R00zF2Ubql8EmtPz1uUdM5KeGh9+6bRrUs7v7De8eGs
   6qgqUu1WAW6FJ6DvbAiidHrSPdjH3nAFt2jpmwvhV+KjRfHTjPZt5ayTw
   Q==;
X-CSE-ConnectionGUID: OQLsMvlQRRqF6DSyI1VbYg==
X-CSE-MsgGUID: SFlNKn07S7a637otee/O8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20327818"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="20327818"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:52:37 -0700
X-CSE-ConnectionGUID: BcJhkRgiQAenqRMnNqrN0g==
X-CSE-MsgGUID: jwj0pllTRc2HVPMUQjr5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44180860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 18:52:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:52:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:52:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 18:52:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYV8nH4nozrbeYM/JEBpLswnLCa9ZMaBRaR0S0tzHuSBYLEQfUUYJNfUBI3OThbjB4v3r+T2FhtFMNGW4cuoHCe+eFxBHD0RSUJYrKUKQ6MueSx4VWPom9SfZj9IHBRWfINPf6agy7pPlWhw1vPqCv7KlF8HSAT+Apg6+BacBR/5NDGi5RyW8MHty0ATlypGety9tYTQmTooEBKvREfRfoALMOpauCACy+LNVXVBN02K7GIa23S+wvDVD7N/AbnEmPmQ1mIjhcSEG3h4Gt4JSGTzWibkRtgKs6y7nMbgGPia5q5tVM1h1Ssva1GfX2l15dKw1WQuzCDM32qoz25DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDGjm4xwPyJlftN3LqECll/KKxwOm8kQGKf24a8nz3Y=;
 b=YHTchfjzhKhAEGRlQ4Ih72NlKpIoz9pARLInKeVCSW4TJV92x2n/rWUiD2vdcvCzc3VouBQVrIUZjRmc/TwqVAGtYDtWXTO3X0NgMdSSCqQC3CAXi35OdgdS8x/AO9ymAvYJw+zSCW8pz8dRQBeUGVT4kw3y0obfGV9oYDGk4oC0FhLmbYkGPyz0qrrZb1ddKEdAPgGhwjnxoKprqQOKHCP2VC9nfhvH5dp6/6raVoG1uuM4091v51hsttVEgPu3gf4aLbrKY2ZqH0nXX2eIKfnCED/TUUyDEiwrUUdQ/B1plXvFCO2CSoSWo0knuGYKEs2WD1q2ra+BbcWBgimJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:52:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 01:52:33 +0000
Date: Wed, 26 Jun 2024 18:52:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] XOR Math Fixups: translation & position
Message-ID: <667cc5d8c4d89_56392941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719275633.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1719275633.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: b27c1884-8293-440d-493c-08dc964bcfa5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nzqcGgvQVK+Pub5hbMoG9GOO/g0/trDmo6jk+UbVWBjRoz9YcPt2bo7vdmKN?=
 =?us-ascii?Q?hLxlZSjkSVRSGPtEYHJ3CjftO9Vg85rA8NRsWIVPbtl/fUBdK7lj1EwPEdYJ?=
 =?us-ascii?Q?CK90LlAC1Q93/pL9qWTAK8FRypXENj7B3S5HPjXxpqpmNtvDnvli/Uf2OzbP?=
 =?us-ascii?Q?0cwiLL+HmizMPUtwyDzB/o7n5ZRxzAYhn53foq8wWayvzTyW2kA3BbZo3IQM?=
 =?us-ascii?Q?RVrC5McSQH0MmBdiyVockjOeumIvv6h7Wo9sEVYplnbnt6k0F/YFEVFpOwuV?=
 =?us-ascii?Q?NsiSVqc5GFiKsDdviDil6EGRSbTQKT0XDUQLarolVmnrONjqZaWQSZf+T9J4?=
 =?us-ascii?Q?qNWSCO/0J9cO2fKPQ9qKmoa8xhCExPRie2XYT4C3kZzPBo17Jbav5OuobA9e?=
 =?us-ascii?Q?PdgNe2uWgDyvUC10E+wt4UxWx0I9uVobEin/pZl75kRVtixQ1IgLfmNQ1+LQ?=
 =?us-ascii?Q?ihgbFAxoWTUSQS+OK0hts2Mjwvvu9nN834WmASXNNypQ+ULwywoBloWBMi7w?=
 =?us-ascii?Q?yVSHeoFJ9BQu/613knHBPXZgNdTFuCzsh360tDb2yZphvWe+g/3OoPV5hkd2?=
 =?us-ascii?Q?qMkKTRXhAvIehjsBVxJRvHghMqvMfYuHk8S+upTDM8zlIMKlOozLZvgcH38v?=
 =?us-ascii?Q?kKAYk8agECKvtxSre7PkWY4FrDsYviiIeL9fyrjA0YqlD7h3ROS49vmuSH4b?=
 =?us-ascii?Q?0iy7y/PwKS1RhmK+o8ZNtooqADm+gRVqFVfj7YfP6iGV4LudXmot2J+7Q4W/?=
 =?us-ascii?Q?5AI0ChnhGFqiRK7qZVULD/Z9IMoRWVOtn8cX/F7xrLEJczROz+xduPYIkmrq?=
 =?us-ascii?Q?aOg99D/OBRgVM0uoLWgEmfJk1r6D/EBgwd8GZStjwTj6zxx/oeAgsvhR4mJr?=
 =?us-ascii?Q?1mj9WTIM4F3YUARUKTECW8rnrPUThusOtO/XwdVxpXwL4L6e4l1IcPjS0EQ5?=
 =?us-ascii?Q?gW9m2LhHBGEfUdm6S48SCEFgyAAYrZIDunPPBv98lz5TVK8h0/0V2rbxxx0i?=
 =?us-ascii?Q?mPc73I1F5S/bJyYTOAd+1e+D/XZGy1aeFSN0/zo/gvpvvNxqMedLPe08Z4kV?=
 =?us-ascii?Q?FRtfgtAen9KP1OJX8v559ED5C9X+L7MOhYVmizx4bdPjC7YX3sHxEBSO89PB?=
 =?us-ascii?Q?pSm6kpQzQ+0VzRiL4mcNRJGOg5hruWoXp+1ZGEISeiSEvJEeo5QgVfulptNY?=
 =?us-ascii?Q?7mTYW4AxqwfgDHo4h3jULeoR8EyZxaxdUg8XwRgRSX1JGnTfUUaswWGEO7pD?=
 =?us-ascii?Q?mBReaZaPLgt3MS0urBu5K0REq5lUBJ+808ld+80ULglyBwR1YJyQq9wG/fua?=
 =?us-ascii?Q?F30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lFFgLSIsbgKGl4uIWLq8/KEIUQ2QTLxh76od+WhJLWlFR0VtoYkq91IGyqH?=
 =?us-ascii?Q?D6k2SJhIecKYNixLXCPJ/CxvuN3RoeCnBEXaqFQ2xnbcXATV8mqZP6TSbml2?=
 =?us-ascii?Q?omKyUutQw5HvYEWPJuTP0G2QwL4J+4WMs++MNcLKlETFWXbRm8kryMnb2lid?=
 =?us-ascii?Q?ZwY1Nu1Uve8PW7yLUxW3g7cUX1dxwK5Zv2HrNhm6OwN2RCD+NUU33mY6lFXl?=
 =?us-ascii?Q?mT4I4UwqvyziI98N4dh6G1+1bOrKXBijsTXCb02QoY3F+Azg0MiLByRZLQyH?=
 =?us-ascii?Q?QJJHF+z0sGe3fNB+vzTOPHSeD1+yl+hZfbfBmEWU7MPf9A8gztXNLyJH2e3g?=
 =?us-ascii?Q?/2oidn1A3OT1G+Eu8ljXDqFioJSQ3YZK8kFaLYrCGiOKS6+kx7Y5xx7aX/7g?=
 =?us-ascii?Q?m3kNyN+y3vUfnNB2QKclaXGv7dZBEYQLeh/FcdqoPyUZ2SOSNMHTyqPmsEXp?=
 =?us-ascii?Q?pJc7Nz5Ko+UeXBQgQZd0X/mx7peDrm9QJ6Vpo8q7fQEjZK04lV+NtS/khjkt?=
 =?us-ascii?Q?ydKHv4rCyJEcyULVASj0XkYEorDfIYEcnaTd4JEPtqgk5PYGbMoRGwJRYYIG?=
 =?us-ascii?Q?FVu2MK6xOW+cEv08MBnyLdIYkOWhVQ7Jcx3tEyUKxip80afinZtwAFnwVJ93?=
 =?us-ascii?Q?OpERKBxErteCTNfqMfeEwLTUykMNELon1BFEbyCUdr0YJvpQH8t7tF/mbP90?=
 =?us-ascii?Q?EDV5kZkCP0cNWTf0s00/Tqk6PHX/mMZ8e9PWoi20+efSV9/8Hhxcp7hNX/Ka?=
 =?us-ascii?Q?KTY/22OMmZekNC1x4Jrfu7tzBsJ9dyx5dlpIqozbFcp/ddyUIyNRcwZLidXK?=
 =?us-ascii?Q?uJK8QLb3l0hF5yv5dRJtkSojk3V330EjLNd9BkHEvpZdrZ4uMlYU+HTJQ3Lz?=
 =?us-ascii?Q?jSXXqZmKjHrkBPh6BroVmlImzkx3mDT7pQdlrWa44LkiPEjxomJCrjEwW2Pu?=
 =?us-ascii?Q?Scj7R8PZeyfQza8tg+5G62Y3VHw8IRebEmY+8aoYAmpPahRZAN4Kz1248sSU?=
 =?us-ascii?Q?/rF4qFv2QsLTvJNKBs8hBherI/b3AnzAqtCrJyz4bZjSp01X44i5PZ4R6xII?=
 =?us-ascii?Q?kbo4fgCVP9O+ZUsVsq6Zz5ddxw7GqIVQpYDovy+tlkZGi/u4KqrgbK8g9Cbj?=
 =?us-ascii?Q?Pu+srLK9BqdPdFhmq2Uqjh7Az9T2CnE1FjFqlUVWdJojSAfgEP8C+sU4fMxP?=
 =?us-ascii?Q?Q059nvARKxqV1HcW596KYgSjTbEMzeaxQv5ibdUB3mP0Y7eMi62X/H/7Zy2X?=
 =?us-ascii?Q?i0PpFR8b0zyz8ZCzSHCVXNNy+RNVeBbTVc+4Tpimt6pXd6a9hznocl5G4VI9?=
 =?us-ascii?Q?qrAYvZRPYoJG5uX0I8UpY21I4qX7Y5h1v5dT60aMaBWOtFIquSLTteQiZHfG?=
 =?us-ascii?Q?9Hat7cV3cZKUJCFl4AsFap775eaivawgW2shYvfv/B4rsTVYSJE+Ndrs8u8x?=
 =?us-ascii?Q?aEdWrvbhd2NmWitp8MxppgKGQWxr0SbiV5wCLOhsq4cmg79zJiL+Hmrj4nwo?=
 =?us-ascii?Q?do2mFQBz9V1MN6MSsrXmdKkqf+DsR19JPLnyCV3v8yFcZ67zqB6+tZqaR2VH?=
 =?us-ascii?Q?4UEw7/nzVmttAL6ehXB3pabqmRTigtHJilhKhg837wPKTQOq9QCT9Y789PIf?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b27c1884-8293-440d-493c-08dc964bcfa5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:52:33.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxPH81JknbfGoW+P+sIrustlYkzTvZuSdLqX/dyjPGPqWz10Vll/f7gRRYwZHAF7FhM1bXyiIBZb46OFVeeAYSi2+Km3AgbPT/xH5yLy2oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Changes in v3:
> - Patch 2: Perform the 'chunk' check on Modulo decodes only
> - Patch 1: Fold cxl_translate() into cxl_dpa_to_hpa()	(Jonathan)
>   Jonathan asked for a rename of cxl_translate to cxl_dpa_to_hpa()
>   but the latter already existed and the work of cxl_translate() was
>   minimal. They are now one.
> - Remove the mention of XOR's purpose in Patch 2 commit log (Dan)
> - Reword hamming weight wrt XORALLBITS code comment (Jonathan)
> - Post a unit test upstream[1]  (Dan, Jonathan)
> - Remove Reviewed-by Tags on Patch 1 & 2 due to rework
> - Add Diego's Tested-by tag to Patch 2,3
> 
> Link to v2:
> https://lore.kernel.org/cover.1714159486.git.alison.schofield@intel.com/
> 
> [1] https://lore.kernel.org/20240624210644.495563-1-alison.schofield@intel.com/
> 
> 
> Begin cover letter:
> 
> Rather than repeat the individual patch commit message content,
> let me describe the flow of this set:

For a future cover letter, a lead in like this does not capture
potential new reviewers compared to a boilerplate flow of:

"Kernel fails at X... this is bad because... here is the flow of the
patches to get the kernel back on track..."

> 
> Patch 1: Rename an existing fn - cxl_trace_hpa()-> cxl_dpa_to_hpa()
> A tiny, yet essential cleanup to take first.
> 
> Patch 2: cxl: Restore XOR'd position bits during address translation
> The problem fixed in this patch, bad HPA translations with XOR math,
> came to my attention recently. 
> 
> Patch 3 & Patch 4 are paired. Patch 3 presents the new method for
> verifying a target position in the list and Patch 4 removes the
> old method. These could be squashed.
> 
> FYI - the reason I don't present the code removal first is because
> I think it is easier to read the diff if I leave in the old root
> decoder call back setup for calc_hb, insert the new call back along
> the same path, and then rip out the defunct calc_hb. That's the
> way I created the patchset and it may be an easier way for reviewers
> to follow along with the root decoder callback setup.

If I did not say it before, I appreciate notes like this, and agree this
makes the patches easier to read.
