Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82883368B0
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878558; cv=fail; b=SeyDF0Rqd+rKRu8H8EDQCszWe4hL43zFnbhj1Aavwx5dYR4rhr4UfccdI2aDl3yYIrDk1ZzDtu1P10lLWoNrPoFfkkKl1px8OPHHCdALLv1ytgPPF23Tm+/LB5ncU7TbtJMM9v9ykFJl4B22Vf2LBfcdTQ9AZ9jxEKkhP08097o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878558; c=relaxed/simple;
	bh=Njcq6F89CAMgu7LKW8S7NXYcRUqVaDtWO+m/xs+iWOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2YR/7xT2ughYGAfRqj+zdrVyGiY69ypDZGl1+Mav8Qc5W12mdoi7xkKzbKaFTePSlWfDTl7zt3NJrBtHilzxT3ciqwU2nFc4aMnxs/b6NDOXn/jC/kWbztSxAd+YORIpdmaSuZCGqWnv5e2YmcLA6oSn/BRFS1uH4pGqnPcR9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cb2/fHa3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cb2/fHa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787878556; x=1819414556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Njcq6F89CAMgu7LKW8S7NXYcRUqVaDtWO+m/xs+iWOM=;
  b=cb2/fHa3kGDkG9XCXO+yPR1qIA8KcPZ77Z+0cdRkT0myzKJh3/Tsiimg
   4J8gaDiDFWKJEz3rNxEKeKeief3y0om/cywlVBNlc1wUiOKJR1GCA1syB
   ho87SMZ5wfcWeMtfetJD284dnN6e4dkREQDC4sWmkM+cS9iRivxs4N53G
   zcWyr87QmxLaM8A9b+jXYD1BCNgKvEbeQ+A3L902XFDz0nOYb0LQ8pzuK
   WsFHc+N+1vLmF+6uREEu99pj/hsy5TwEbmEl+UAMqOxQk4EbQoChIuyHK
   XTV88soSC8NtGNQCIgypAjuo+JSzTmbSxu0tfmUhH9TZQSDDOHKKlYI86
   g==;
X-CSE-ConnectionGUID: I9j3q2UtQVuSKWXbhVFWeQ==
X-CSE-MsgGUID: /ti5yivHSvaTXgkLa773Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99548893"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99548893"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:55:56 -0700
X-CSE-ConnectionGUID: M81YZ/5qSFi522MMIf3xPQ==
X-CSE-MsgGUID: 7QOYXAywQA+VZseySJ2Syw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268591372"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:55:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:55:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 17:55:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ3t05xfLz7rKpm+J7RA5A0ZEBBLSBd6khP522xVQw0rRrZr91K2k7/bg7kGOGW+Yjepl+RaNsRTJLhq3sBiRR+75r+slq8otKuARS54BFVyGG/3gwPiy0krKf159TvphhVS6l1yV07f3elBq0dhPiL+iJLxL2E5IJUuQng3OsP8Sk4b2zKvdnal8oT0UwKooyRCUkZzu9irhizLtBNHLtsxMJttWzNgViFAQldlCPp6j5ax7P2i4KS5erVsdyLQRLaVk86GGGDVN8uNyehinshuGZwv5sOJ9EobpFIj5dImcL8iGe2zmZUG4n0su6BzkZbYuuvNwRXQLdy9ZdrbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq70RCNJjAo/KnF9IaKz2YMOQBTXtp0nUj61NvwrybY=;
 b=h675eFvial3ef4hPgHabT0ozds8c7C7fKsXgb9feXGCxSkXtreVKzwDZhY/iVjGSVaR5UWe1jio1f7AAmzU6P5l9oDmXUHYGmX1StO9D6CWw8GLCPAaPdZsz3xaLVW5xJrtzANs0j+x1UriwwO/zzNH1M0wdsFN0sPUTWvGoPENUp0Fr8t1UMS21XwqMwt5CyaqoVGh4vNr7bWCcHsJrFfhK3eb+o/EPMWsbKkyWu2HYQBwlm4YqMsIS6hNGP58gLCBXZy05C8MxaDVd5wWHQZzESPcTE53z2qGEUMmJztFGF4CSckKfm8znCGYjWnGuK1v9iRGYa/bPALqik3JWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 00:55:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:55:52 +0000
Date: Thu, 27 Aug 2026 17:55:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in
 bandwidth gathering
Message-ID: <apDcRa9oMqRssskJ@aschofie-mobl2.lan>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
 <20260812083035.372308-2-kanie@linux.alibaba.com>
 <apDbK_xjfHEV69Cp@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apDbK_xjfHEV69Cp@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: f87dff79-31be-4dbb-e1b7-08df049f1bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: p0hvVbqGQymj0uVi7oEyCiVi3UNB0kPzubPi3GiK2sNNgeWly/b3iB5IqhnPntAmDxl75XoepGD/yfI2R317kgU35wIoXB7V4HvXVeuX/KOzS3Wj5T93A+yFxVq3NfdxuVgJvuRy9OyeEZHdxr2n0zQUr8UHsJYU1++/2xXXVK0Emu/K9+htijDuZJH6pifAPfZnnWtRzB7KGDjRzakXo7g5Nb1P52KF5YefsV8eYoRc1QsXaG8G3FuIPlnUxNHk/A5uQVtkfXLe2ruARVQ9iDsvkRCnnIlutn8rIhwDJVLih3N4rstxbN6PIXIdP4k5kYjuQnxAPqTt4kppXQbTtdMV+ILtU6WgcawMYhb9YviFX4wsFmZWG0cmxLf/1MD7tvugzL6TpW0QVhVHAHKPaSKNqrbI//gxvP+nCU5epjllhoi+mKeNqP8Ycsx00XBn88wLcipsUAxH0l6KX8DgaUgqrmvTsLkgLEBDja7dxIjip4AKq2deIxRSuYJfZdiKMxFkTJocbJJ2QugWTOppm6Fu42dzvnycm9JPKG6fzMoK7SgSBy2aJyoI/k++8abtjjmfi/8LRD3B8PbvCKF+QVWc+hO2JITfe8peKisbw+Q+OB+puUu7zxATk/ACRTA6iJcYaazFZ8dLSkkHVDZ9gtsRUfZ5qD3o03T8c6PS9t0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4Pj7YA0ZxkBrEsa1kYLIQzy0ubVr9bSVpZoToo3eosKuWr3E5PR7ufpeSIH?=
 =?us-ascii?Q?Qum4I10uwVZyr/k0zMF8vhcXc80caAXEqwiOO4vHYPeJilz8tJJS4TK2pzgo?=
 =?us-ascii?Q?LhqwtVZRbwVx0vDpkXIeqmUIW5Cfmer8XLqEyU7kOzd4Sxchaq3IuGzTXJ4A?=
 =?us-ascii?Q?wwxUE0iXadQZ2zs/N2DlVgBAmnREU5xNwnKOSSvjyMbg318kSauzLgye6Bze?=
 =?us-ascii?Q?xFu1vhJIWb78i25IyWtDt90qLS5lVxcaPs1ApZWi2PE0bBoYp0Gx3pq4Qyeu?=
 =?us-ascii?Q?5lRYeCTJm1HYHrn+087xfVTKxxn5wrRjNKMhrmSqlJabJQr8825qZzC5svS1?=
 =?us-ascii?Q?hwZ9YX0dJv0D9Y2qniyAb4+NANgZWIttwO+htseeNV3JhOR3d6h5FSJFhL+k?=
 =?us-ascii?Q?vPjtr8ejOqG0PrjFbnxW74Q0WSsVNSNvsHbJ0Sv1E60GQ9V6TV8bEU3DZf8Y?=
 =?us-ascii?Q?mldQBuZvzMuyOHbj9QccO20g//wp0KfD/qJvjQNNLxYJqmKT3x82Xe4qlV7G?=
 =?us-ascii?Q?OC1VAmW84FhfR9pJ3jZzcQpTXB5a8yz9zfp328SmyaM1MUuorAcb5VHmNIO9?=
 =?us-ascii?Q?RSJ+ACZ5bdNhWjfKNVLeu/9iYSS2v2twqGb4oYPyOi1nmXs2Q61e6me/GZVP?=
 =?us-ascii?Q?i+oxgfBIxgW4JMRWIPRfuXGzrQi5JyShINfN1FZjIZFmXxsXHU9NwrSpbT57?=
 =?us-ascii?Q?0cRI9X2KrDAD/pT1SJGXZk8C4FCng9+X5lOFdyHf6L6su+W+RjzqKOMrUuyD?=
 =?us-ascii?Q?RFZ6f4g6ZXsgCWsTpcxgz+PtGiAoXIJFCE4RN8NXJtCgEJwSujXSi9jNBQc2?=
 =?us-ascii?Q?UHgnbM7MyqL8h1V4tyyyoCmRC5iqcKF1I3qi9FArTZW3QvNtPOsfIfIFw+bt?=
 =?us-ascii?Q?2BnDhxxonGGVBJFQyPPfWZXK0eGVY1mtgE+oENoDPBQ/TEa2Tj6W9TQdiVNV?=
 =?us-ascii?Q?EjWXHiYkExrkPQJh19DvGxCZlUJJr0WY+/qnKtMCE5txoSMcnIEDD1IBg7U5?=
 =?us-ascii?Q?PO/eXKJaCnj8DtfwdjfHbUc4iUV6JHbNVJPPpxeIZC1ng8u1jRFUoBuhU7g3?=
 =?us-ascii?Q?gI2J/8QdCn7rFUE75iJtbRZbcMGJIjDOVoPbw06r30rPQhLz4IT050mcIi9m?=
 =?us-ascii?Q?OpTi+vHrfDN7ZG5zGaLvbfL2xlNQoNbayVguLft8JwgRZOmesh236OVZRAbX?=
 =?us-ascii?Q?2yMi5s5y1ExVwUPKFXdLKAIgeywFJHJq3j+P84kOCrFlANTTHmKBuPqy0o+T?=
 =?us-ascii?Q?DkI4zY8xjvY+QewxXm//8zPc0CWr5JAwGlPV5KB53pvFm5ZQCOox4rjH45sp?=
 =?us-ascii?Q?I2kwTXenLRQhpMsKyGmN4akGchLrG6WzCSFLJdsnFi487zHnd9/snPE3hkuW?=
 =?us-ascii?Q?ysiT1XpyZdv1NKdbGtpU2aOEZQQCbWkKVbxbwxHOwIX9CHNBChcpLm5uILuC?=
 =?us-ascii?Q?83l0F/0pzSkpjpykT/E/pk3Ac/bDrq9pJbZ9ZE+ANRZ61Kcbe9pB5gfpafEr?=
 =?us-ascii?Q?j4QlH+55kunT0psZSCu/knfZqcssV7qTvJ/7w2xXjiutWdVlzT6+EbCRyp6x?=
 =?us-ascii?Q?4QL5oC+gFQDofnAaE8u9L3px9YMEJInbMSDugl3R0QnOyLh5FKDzyxYdvya/?=
 =?us-ascii?Q?o1uVmAqEmKBEvs7Jy74uiQpDjzx9gN5bRu7l/to7eP+jtfa8nQxzSjNov8DS?=
 =?us-ascii?Q?dUlV1Im+pc8Ho53pRaivvv8QAhNUX5J1B3hgbeHU6YBuKPL7Q0vWx+PLM7Pw?=
 =?us-ascii?Q?g7ggokC8eWHBfJNhFtgxqyuYbzYc7UQ=3D?=
X-Exchange-RoutingPolicyChecked: SXCOPZYu6H5RNEYCcM24kRRlckNm3AhRh0ITXhZ4G5UApRGjijvk/fS1Zo4wiJvo4dhC8nZqz6/bIyF+N9xAli2m2s+1hHjhICJ/BA5guyhdkiWM7N2osN0YfUSo3HaNqPlZCHqiZZmSdD59ACI6bRDzW34U3L0BSswPfpgJx9VrcCDmE7Rpqedgc79HwQaNfOdRXz9ag5Gx7q4RFsW0v3jCP77XeCCugrraGWJhn7HIc+7Aa2MyaMUtvIcXTMi+pqFhsZT2gCSHiMM71U9e4LwSLTTbbQJRttc9Ko/4QwP+lMXzg926jGeuYWxMDJoSaIicHaG+dzgyY3PCVAbdMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f87dff79-31be-4dbb-e1b7-08df049f1bd8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:55:52.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whKLKXwgt1YCscSfe6riA7kPOtMoN9xwYUcM5v6wgXgVEsvJiz6zOJlDntmd6za+h5jAkEcgBUDK5CiuiOQz96U38yRYRMkDcWyc2echOdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com

On Thu, Aug 27, 2026 at 05:49:47PM -0700, Alison Schofield wrote:
> On Wed, Aug 12, 2026 at 04:30:34PM +0800, Guixin Liu wrote:
> > cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
> > the stack - pci_coord, sw_coord and ep_coord - without initializing them,
> > and relies on its helpers to fill every member. None of them does.
> > cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
> > only read_bandwidth and write_bandwidth, and __cxl_coordinates_combine()
> > assigns an output bandwidth only when both input bandwidths are non-zero.
> > Every member a producer declines to set is read back as whatever was on the
> > stack. cxl_switch_gather_bandwidth() has the same defect in its coords
> > array, which it hands to cxl_pci_get_bandwidth() and then to
> > cxl_coordinates_combine().
> > 
> > Both cases occur on real topologies. The latency members are never written
> > by any of those producers, yet __cxl_coordinates_combine() sums them
> > unconditionally, so the latency reads are undefined on every call. And a
> > device whose CDAT DSLBIS reports no bandwidth for an access class leaves
> > perf->cdat_coord zero for that class, which is exactly the condition that
> > makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
> > the ep_coord entry untouched.
> > 
> > The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
> > into the per-upstream-port aggregate that is published through the region's
> > access coordinate sysfs attributes, so stack contents are reported to
> > userspace as a bandwidth figure. The latency sums are discarded by
> > cxl_bandwidth_add() rather than published, but they are still computed from
> > uninitialized memory.
> > 
> > Zero initialize the four arrays. Zero is already the value this code uses
> > for "not reported" - both the __cxl_coordinates_combine() guard and
> > coordinates_valid() test for it - so a member no producer sets now reads
> > back as unknown rather than as a plausible number.
> 
> 
> Hi Guixin Liu,
> 
> Please see my comments on the einj_inject patch about commit message
> clarity and level of detail. The same issue applies here.
> https://lore.kernel.org/linux-cxl/apDXSzSZVcjQ027J@aschofie-mobl2.lan/
> 
> For this patch, I think the essential story is:

Oops, I just criss-crossed your 2 patches. This goes with Patch 2/2.
Similar feedback on both patches.
Thanks,

-- Alison




> 
> Background:
> cxl_endpoint_get_perf_coordinates() returns success for RCDs without
> calculating coordinates.
> 
> Issue:
> The output array is left uninitialized on that path.
> 
> Impact:
> Callers can consume and expose garbage access-coordinate values.
> 
> Resolution:
> Initialize the coordinates to zero before returning for an RCD.
> 
> That is enough to explain why the patch is needed. I do not need the
> full path through CDAT parsing, __cxl_coordinates_combine(), QoS class
> selection, cxl_dpa_perf, and sysfs to understand the bug.
> 
> Also, as with the other patch, please say how this was found and how it
> was tested.
> 
> -- Alison
> 
> 
> > 
> > Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > ---
> >  drivers/cxl/core/cdat.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f07262513..df9261ba84e5 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
> >  	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
> >  	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
> >  	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> > -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> > -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> > -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> > +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
> > +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
> > +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> > @@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
> >  {
> >  	struct xarray *res_xa __free(free_perf_xa) =
> >  		kzalloc_obj(*res_xa);
> > -	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> > +	struct access_coordinate coords[ACCESS_COORDINATE_MAX] = { };
> >  	struct cxl_perf_ctx *ctx, *us_ctx;
> >  	unsigned long index, us_index;
> >  	int dev_count = 0;
> > -- 
> > 2.43.7
> > 
> 
