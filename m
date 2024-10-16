Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7B1D363D
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119248; cv=fail; b=rKEOy8OZ3et7c7igeBwf6aBbuG7d8I5znkmWSJRPFseoiX1DgcDt7MGNnRXERjVndy3sL6pJ76ENylSoV1MbWmh79JXjO6Bq6gvmHvS2wSR7Cb4WK9litRZtYKsaQ+7c9LHFzcq5ufk0DlV2G4dhPwzM05nc2lRuWxAl2LHgb2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119248; c=relaxed/simple;
	bh=M6K0SjHw8b2fpxSlBnJp6H71KNufDVuG+QhtBXR+2cI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LhSyuGFzE2kJHfsXYvdW/EUyRioiRpO/AlD7SFb8euKpdZkqRxnB9BJ3NnvSw6tLxuVw/EYVJUfjD/0Hwu2Hg5UkXxmyuvUf1jX3ugVTIHMcuC2k8t1swqSdft3gunsLOvSRKSrJB3/ngKYS+DMfyLJHoarJ2kHD2LZufhiqLyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsgKEAkm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsgKEAkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729119247; x=1760655247;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M6K0SjHw8b2fpxSlBnJp6H71KNufDVuG+QhtBXR+2cI=;
  b=GsgKEAkmgEWIvrDijJxjUAfFfk60oefTSKwOSG/p6LGbjhiOje+0UNd6
   O+JiTaMrMQlHGRCmznSC1F7qnpQgMWy95tTlloA+RYwxksiDYTRQoC/5a
   0f6PXqf0cWoXzD2olJ1c9JqqKG5xQ+k+PP08uXA+sJHw8VOWhtrSJEljl
   SprEQqCI/yMvXmY/XB8lltkyOacW8+Vf5KM6vXqhjsi12yEBw85eP4btl
   oTCprBtfd1YGW1WRt5K3oHKPMze/48pdbq+0kO5KD7goSjQ1tzoXl4ucE
   RshiPW9KzBK1m3VQKyeXDPZx4xQDPPAY2mzlpDxnEKulLcwsn12zqmdaM
   A==;
X-CSE-ConnectionGUID: ytCT5bKhSp+rh9UgN7RwyQ==
X-CSE-MsgGUID: ehJC5ST/QeKYsRuQVPiIYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28540614"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28540614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 15:54:06 -0700
X-CSE-ConnectionGUID: 75Wa9stkQ+GQgaO6QIGAyw==
X-CSE-MsgGUID: zro0McH+SSOkJvE0E6McMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="109163580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 15:54:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 15:54:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 15:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc6Y5i9RnZj5JvJcjfTxQ92QP0M9ljH4PILX0pThZ3tKAiQez6xN+NBvkIsbH0Q6NdLXz8E6W44IkdmYRb1QVjwwEMCQEHa6KMH9Iq+mW+SNmBrfXmZoklwlYrUx+mSne0X1OWrCHY1DWwyaEKGALN4BgQIyHastGVpI0m4NuDGii2p8qwcjE+kkvKhgkGgLiW2Kj7dFCJ5jaZ4AX8rU6d9U9uJbw57MnLNBhNPttrEZte23kCL0DzaF3/ReixuFg3lFNRxjffp8t2rRPwJ8z4DVYQkWKRFlqzgPma0xp5BIZOy5/isQ1mrZBjvMVR4xk5MPtkpq+9WplmP9tuEeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H7edl8C1iQDwTM74SQG3SpW3lCYre3z37P/0qnWPy4=;
 b=t3zASaz6ZB6cw9c5s/kWyenx8hxKigVs3IUXY5gFny2L0aq2sxP0/XtSdyss3uGu7qClBEsQvFtP5kLHH0D4L4snYFbXhB9D6hwJycxptRvL3/Yrwb167QlS4vPUMvn98p51qHwm/F1bqQXgPRbOTkaETgGSfIcIjaGjQd+bgcQuvmQWGej+yiqLh4JRmGG8i98mj4EbjsVp0eB3Ir4/j1Pnz66eggsGSzoP3NgpHl+5ptXWroDp1UCkW6rAUYBZlbTy4OuxdT51Fiey0jxTyOfSq/GFeZzuwQOgKLifOcJtkdq0QiZc3OWNjPgVW0PdIiuo+jyJbK2e0fT1K7/7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8273.namprd11.prod.outlook.com (2603:10b6:510:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:54:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 22:54:02 +0000
Date: Wed, 16 Oct 2024 15:54:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
X-ClientProxiedBy: MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0f9995-57c2-4a64-7803-08dcee356de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9C9RVBVBREvA2THzinkOZg1MYXI+Gr+iT7+AI21UTFYiwFdVdXyyduX3fcLU?=
 =?us-ascii?Q?+eBQXaobFG9eMjFV39yewb/mi0xbWqMQlas8x5cMpReP4qiIL6SeO8hSrIG4?=
 =?us-ascii?Q?WI/E2Ll60soW6SF9hbEzS274Ri8nhQRtRw+eNTyIZ3M8zWKr8qRyD42n3kYr?=
 =?us-ascii?Q?EI/hb4PdPh7QfHhfmk9TZuCfQBBmiKvVtjdhkLZdIrT7HgYEfs25EgUhClck?=
 =?us-ascii?Q?TBdA4eZOlHXcdbl2mChve+ks8S/cVekGu5YV/7+zw5o41yYIxr82iaXtkM8R?=
 =?us-ascii?Q?XusX6upFfITOZXr2K5OHkRqXSVXmPNxQRsYvgsLyivpaVvVUSGy60AVDg+eK?=
 =?us-ascii?Q?g+0x2zriy2Qf0zl9do7t4XVKaV3l0ANbZtF45Yzo2j6CN0GroQy+Xy3R/u61?=
 =?us-ascii?Q?V4RePxXLCkC7Q/OKDbx1yS+6Moa/X/feIYsNPuMi15fmCG/E0QhEVLjSjGtB?=
 =?us-ascii?Q?1IkuXnpiGQ0st2Re7TP9xVSXvNx48VXZ0yfvqeQ2nfekv/Eg5WqYLB8INZtj?=
 =?us-ascii?Q?fDzZWsBldwK3BQJX4gGmb9lOXesQhpXsB8+/QK20G0qZeu0hVVtR07FkvQ+H?=
 =?us-ascii?Q?wOcSjNAS0SDPcaCdsGF9dYnkmcuIpl3BwwVctgQB5AvUU2RaMHJdWRaV1u1e?=
 =?us-ascii?Q?UMtzP5qNXVm19kFP4Fw89/4h2mjgZ8kmZQCQstvSbB2Nj8H/g4O0v27x4TKt?=
 =?us-ascii?Q?/LIxvadGUs1gyHXfm385ANzn3oXlcFAkX0d0JOjd6dVv5B/YZl5FWQ1vAY7Z?=
 =?us-ascii?Q?UHyCho9Acy87l3/BmJMz41hJi/P8C4RLFy4jfroFkWid4M4d27OnigvEu6BN?=
 =?us-ascii?Q?rvEV6oFk53CMplGqAv30abQ1W0j3DOsIuUbjh3rDBRklhsJatjqSZTBYYkOf?=
 =?us-ascii?Q?wxE5Eg28/uo1gGwQ/f8pJsHG1tfr2lN5kwegH/ncSJlnnqCd3ouuQES6WC1w?=
 =?us-ascii?Q?9Yn6l+G2H3AMeGnkHh3CiCd7zyC8/9ybjfPd5MsPzEY/X4yz3YniUA6Z6Y34?=
 =?us-ascii?Q?a5E5pnR8f4CmsQ6mKr11Y/CsfG8c3WBACsUOzWSYxtedmJc/7g0Kc6DmxEiW?=
 =?us-ascii?Q?KE44TtvJFyZu8tOvOLOpasVOibHLpA3oI4qziU5khsvlMxQxYppyKz5P8kpN?=
 =?us-ascii?Q?7Fxpq3dsttrLvNb9N3UunojGw5afLlEHVkksOkKx6maBVV+n7E+ORcRF9YFI?=
 =?us-ascii?Q?EQ92H6gv4yu3t9ciVKLBYGakTFxyZstXCM0u7Cx7NRClvY9mGrkAeOhJLMAH?=
 =?us-ascii?Q?R3zxH8f4FLZPe9vTLbKhtVUi9FNC3eUegTa8rUVxkeEWoGabws2/9AezGVh3?=
 =?us-ascii?Q?E36lAxTSPm4Kh521fmSitxUX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/xSbsERXbChxvwlIFY+OfpxOxRlkBWVXkxFLUm+DMDp7mODMHHm7ouzwDtW?=
 =?us-ascii?Q?GZudDfUJT1z5c5l9otUbxbj4/ErHHXWkqfvymAFZ2IBp2FPu7iL+KxkJT0lg?=
 =?us-ascii?Q?ekQBtpC6U8kfiQlDKoaamjgtL7tEuErzQAAJI2tAGaFhDratMtea+9i5+Abq?=
 =?us-ascii?Q?GQxqdsjl6iZDwbVGmJjSP5WhBRW3gSORJOic/pEwEiLb3XfX/p25Jo/yNdef?=
 =?us-ascii?Q?+/CT6+t37AxCImHOJeuCELosYh8IwaLZGkDBk7m90DA2XAHjQOPvLyNSsTYs?=
 =?us-ascii?Q?UywBWA7TfSAIq+ZE99q9Et53oFbi1I/2lEeTdbQ2rxayHQs8fBYgAC1zkmzl?=
 =?us-ascii?Q?kC1cuZOBIaQ+mEwNzEw7eT9wFD5KdE+OT86F7U/RznSf52henxoS8k0jDFMd?=
 =?us-ascii?Q?cxMO6lM8jPN4R15mGwk/XGXUnGRSqEOskVRwyIacuri7kNaNuDTLr/2ADSuR?=
 =?us-ascii?Q?tko2ifKrGjZih3F5s+BB1R+upcAoojs0YV1fO81SBLgYLkrmE5QJz86xj/0z?=
 =?us-ascii?Q?wFrGQjsKrG/ITM3Y2N3WO73cMuofQ8BpzIe2/wXyW8jBMUFp/amZNFBOL8+j?=
 =?us-ascii?Q?V8MPwJWzCh664qJfbuYQVxZ8kWum9nD7GZs/BbEvyqjkVVBBsbl4+BCvzRz5?=
 =?us-ascii?Q?s+IokjQyG9CAk9H0J/Q3XwblbYqRlC5r7oiqs9p/wjY7uVoQOZfDiVA7DbV5?=
 =?us-ascii?Q?TKs/KepG6ehKOhswoyW78kLnGx9xVaZUBOoLQaLg1/qIPavrS6mzoNjOnR3X?=
 =?us-ascii?Q?FI8giERdPdg3KfSiz83lny+4d0NCLooxWVVjIk8TLLwc1D7ZuUpnUo1DWyJD?=
 =?us-ascii?Q?9gqN1RVLUvGxMNqxW1GOpW4xvSDY7toaHhvwOGg/BoGiEJJo5Qros9YU2wc3?=
 =?us-ascii?Q?+Mm7xhIb9btXnkHq1UTkwGmr6amVwuxCN00V22TQP0f9Q5JNRDMN0yDwnXfB?=
 =?us-ascii?Q?O1yNFR0mE1d98dZBIoXjLr79+G4eN8Kx/TeOQ2o0BkGx0GPk+bWEvZsrvDt/?=
 =?us-ascii?Q?N5leXPC+3r2IfjWyXElW9YUoZGmp4AiKFGKTVV8WJlr0ZfLP568yqh5kqkWf?=
 =?us-ascii?Q?/l1x7pmHyyXUtJIjFneNPeOGE53pSV++747MBPD3XdTBbtAo7CoYoY5fsCRT?=
 =?us-ascii?Q?cUrHLYyBcN+YV0kcz2lYL4Mx5bGJrFUOez1VMwi6jDsfUxpOGg7rLidCS9o9?=
 =?us-ascii?Q?g+3YnZ7T4Nq152yZQK50Tj5VO/k7+eMm1tiup86VWMwjC+3TQ6O17Ib9CJsd?=
 =?us-ascii?Q?Gl0kG6kuh3/sdCQ+ucDRW/7n0K6K8Sgb93M71JpWjEkPaMqgBG8a68HNVjG0?=
 =?us-ascii?Q?v4dJB1OdFS3Q9BnPFaDnEy6h+DYQ0lQIaGOU8WmAUpLUJ3xTWXaiLRkQ80AS?=
 =?us-ascii?Q?XgQ3xvp+5MUwW9DZ45clCrD9Kl+zzl+e0gxUf4ic20HIG/cCBzEZGczyBbBk?=
 =?us-ascii?Q?3mcMDl5eDOjYQVdrxKdds0L/pvUJL+Zu8CI43H8alc3zePhF27AbpDGlt274?=
 =?us-ascii?Q?96A89okALFq7Tv17CRnb4PhoyD/iwe7S4i5x/J3oXkLgs3F/6Fvboptr/WqJ?=
 =?us-ascii?Q?8KDA77/xAR1cfMsDUM3P/CsCuBeKlj7H5KGL6C3MigwlCisVVexaVWnMfGox?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0f9995-57c2-4a64-7803-08dcee356de9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:54:02.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2dB4ne5z3lQnoA9IfK8FiefqhIs/xTKgcQ8uGEEx8Y4cVi+b4XPpaBJwCSR5WXuj4n6z5YOtrYn2iRzwNK69vEKP8t2P4lctLAu7zSvFWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8273
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> Hello Li Ming,
> 
> Commit 7f569e917b78 ("cxl/port: Use scoped_guard()/guard() to drop
> device_lock() for cxl_port") from Aug 30, 2024 (linux-next), leads to
> the following (unpublished) Smatch static checker warning:
> 
> 	drivers/cxl/core/port.c:1591 add_port_attach_ep()
> 	warn: re-assigning __cleanup__ ptr 'port'
> 
> drivers/cxl/core/port.c
>     1542 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>     1543                               struct device *uport_dev,
>     1544                               struct device *dport_dev)
>     1545 {
>     1546         struct device *dparent = grandparent(dport_dev);
>     1547         struct cxl_dport *dport, *parent_dport;
>     1548         resource_size_t component_reg_phys;
>     1549         int rc;
>     1550 
>     1551         if (!dparent) {
>     1552                 /*
>     1553                  * The iteration reached the topology root without finding the
>     1554                  * CXL-root 'cxl_port' on a previous iteration, fail for now to
>     1555                  * be re-probed after platform driver attaches.
>     1556                  */
>     1557                 dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>     1558                         dev_name(dport_dev));
>     1559                 return -ENXIO;
>     1560         }
>     1561 
>     1562         struct cxl_port *parent_port __free(put_cxl_port) =
>     1563                 find_cxl_port(dparent, &parent_dport);
>     1564         if (!parent_port) {
>     1565                 /* iterate to create this parent_port */
>     1566                 return -EAGAIN;
>     1567         }
>     1568 
>     1569         /*
>     1570          * Definition with __free() here to keep the sequence of
>     1571          * dereferencing the device of the port before the parent_port releasing.
>     1572          */
>     1573         struct cxl_port *port __free(put_cxl_port) = NULL;
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^
> We free port when we exit the function, fine.
> 
>     1574         scoped_guard(device, &parent_port->dev) {
>     1575                 if (!parent_port->dev.driver) {
>     1576                         dev_warn(&cxlmd->dev,
>     1577                                  "port %s:%s disabled, failed to enumerate CXL.mem\n",
>     1578                                  dev_name(&parent_port->dev), dev_name(uport_dev));
>     1579                         return -ENXIO;
>     1580                 }
>     1581 
>     1582                 port = find_cxl_port_at(parent_port, dport_dev, &dport);
>     1583                 if (!port) {
>     1584                         component_reg_phys = find_component_registers(uport_dev);
>     1585                         port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>     1586                                                  component_reg_phys, parent_dport);
> 
> This port from devm_cxl_add_port() needs to be undone.

I also think the bug originates in:

dd2617ebd2a6 cxl/port: Use __free() to drop put_device() for cxl_port

...where the wrong port is cleaned up, but I want to revert the
scoped_guard() conversion first to make that cleanup easier.

In general for CXL I want to say that no function should be converted to
use cleanup helpers unless all gotos are removed at once, and if the
conversion needs to reach for scoped_guard() reconsider even attempting
the conversion. I.e. scoped_guard() is a leading indicator for needing
code refactoring.
