Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624B29C340
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742756; cv=fail; b=ZKMN8ZYbkxDbcWw0uScecxnjmn9RFnkpD4NcshG6Ize3eI0zlOkvKb4nf2ARpwtWrmDxX8yBWG9SWvbhqNnIA8vFQ3LuaCqKmlyC7RT5fe6vIm/kS8aPJkwHuHUlHrrukdysmUf8cNP9IIpVIwwweCYdSyUXrOe2/Iq/A6j3gVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742756; c=relaxed/simple;
	bh=AlrmrMMRUU465sMZBmQxqF4zEzNBw+XdMP+8xue2DeE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nsvvHAq8BJbKimxMVAF+iTgNDHxq4Jkxu2sY4CjIz7IeFJjWGNNpWes0By/CnSFb9ydMl5uj43+SLLiyGMH7Jf+ZoUg8ObVtz4v4e/BUD9xr2x7TuGUe/cyXtdhwH1WRu9tiQDo3rTjLYLTP9T5drkck55et4PSvb8GJENouqGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBVac7x0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBVac7x0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749742754; x=1781278754;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AlrmrMMRUU465sMZBmQxqF4zEzNBw+XdMP+8xue2DeE=;
  b=VBVac7x0uDyApV/ylv2a2wZjJ+5fzP3OckOfVF00YgN0CiuuGUc/Eevr
   XtHlHUogjeWfLPyD+ONZrTAII8hZrNThCr5kSg3Dl97x66R1FMk7cUpmT
   Xr98w0YqTWs1BaKJrmAQ62PFZ+Gl4KKBXgvVPAANi5GYB/KgWZncO6FFn
   h7tf8BYYDHWcolZXT2zb0lljVv0Df8TXqH4NA0j5Ojqea6BYF+5PlfK0a
   eBOsOqIbYmjhiW4RbyA6qTygiK7zRAiUyl91i4jBRvpnYDOxEyMn+fi+z
   gai6F4F8MB2TLjXjCIJbZ8R+Kg1yO7tuVl8yhpLkMIyCrLFj1KPnY7BOI
   w==;
X-CSE-ConnectionGUID: kMFz6Zh3RMSR8miNr8ohAg==
X-CSE-MsgGUID: 40sF8K9kTJao37sOLrXIzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51159693"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51159693"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:39:13 -0700
X-CSE-ConnectionGUID: jwWvDPvpTuS0V0htFGGcxA==
X-CSE-MsgGUID: FNpEA9H+RLexXurzgjlDBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="147422679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:39:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:39:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 08:39:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1aisMYI6CbN2lxVJZvnWdt9vXbk7viJDbpdPTvY8I37Wue/bf0f414TgcO9UzPgE9VZR9Tazq7wCOTmcV+DfH29DfnmHgVCQvI8SYcaKOWD8/pRNMs5UgYd2hD0moVrfEmJoU6f7aHSXdDrgfVENeLWxUl6sRTrq6SYWHHOGG0rOUzmdgFC+9UDbx78Ic1NWOi8chpt4JELzDax4Hcp5sVfD85/9cn1Q5nuwMWNhv4tGntggrE47/qquBkMM5cRx7Q9xvWAiS6jm3bcdnFOTlDW3sdfpnalp/iMfIPVGuEU8lp/0R8TGHgRb5cNuFXPqlvpI7s6JzSadKxZQJf/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vj57C0/490h/V+ZMUspwvAr24avoXQMVFKpSUcXJqY=;
 b=dqKTGe6I401IIdJn47JMSEpkD4FCVw9B4y3D/tJpRA1Jrs9M9CGtGryqwpJiLR4OEhuIzBl4AmCaDYPJrIF2xjIwP7u+GxQamf+Jl1TV8GSuPoNijd+5/P+dWI/vHF3vha0g4CCCOBqUyHK7hyqq8Md9g9RM8kEAoxD7usfEka2rTjdkhuBaBSbmQAUGVIIJW1ceb9+njFs2N3wdgEfHx1q/JBJ2twD/hHexLqFACCPTlshmUXftcVJh8MNabS26t17v9xjQGOnMk/fnViyAB+5VK/Sl5Pxo7FYBWElPKonuzytuNoZjsKQUlzwrLrD9BCV1CeIVSNOTttEkqE5WFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Thu, 12 Jun
 2025 15:38:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:38:53 +0000
Date: Thu, 12 Jun 2025 08:38:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Li Ming <ming.li@zohomail.com>,
	Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
Message-ID: <684af48a56885_249110035@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
 <90446530-8817-40a3-a1e0-102ece46ddba@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90446530-8817-40a3-a1e0-102ece46ddba@amd.com>
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d55dce6-165b-4621-27c3-08dda9c73c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?44mi51iL+bT3j3QURUHJ30+fKmVsUQ66z8AhrYXevAj9ljSp4F2xGbrNRYEG?=
 =?us-ascii?Q?SbuHfPg4Emj4KyYRe3QlNu7bOhCrGEkeE50bU/nN0T7I/ltDctBDV9KMeHiR?=
 =?us-ascii?Q?2yCs9PJ8iSC4Gq6Vqze0la6BZlZC+Leffw3QjF4YFy6CN0lQsFvyjisWlgam?=
 =?us-ascii?Q?Fab1EXs263C58Tmf5Gqu6fw9C5IpKv+RFHxEV2L5lxa6P/FeskbSWJsUTNQd?=
 =?us-ascii?Q?PO91v2zCQsep6ywkRNuijrmC7RIZ1sItQGv0MdwGjHUz8HpMjkzP0oB7M/W8?=
 =?us-ascii?Q?OGpp6RcD3/8HPxzFofy6o2Y0kXf4j60KI7T/rbp/VA5wiWZZ8ANHQJo+xemw?=
 =?us-ascii?Q?Nak6vUqt8hhtLsq/FfyOoHxghGc3eW7KzRwS1Fd6CxVz7kp623C6qX+le+A/?=
 =?us-ascii?Q?Cg8vJyONaQ70rmbyDTT4XTfUJigOzyUk5zLY+29Ha7DlauEwnYkMowTkUrNO?=
 =?us-ascii?Q?x9yqKykxhGoyVeOpCIHvrvL6f4EoRtKmhwIQDwe9+MWmtRiauS11p6mrDNTj?=
 =?us-ascii?Q?K5oc+xRQ3S4f/uLhWNjuEz2a0Db+hpqWto9NAsJZr+LGtFQdpGmPdcsBAvSP?=
 =?us-ascii?Q?H76euE+6RobIs36bqzrdWRRmo5ywCmeAKog4Hon+cY+KboqKE5b/ouF733PU?=
 =?us-ascii?Q?Cw7Bn/Sji1DBDSCNY4www1B4+s73wRUMUmYYPjXXKrsEMhPwL7Zf7gW9p+vM?=
 =?us-ascii?Q?lcL8O48Axhx/fH2vLi0AXiz4UVH3UTk046vcf86DBPzXTdIbqFCaiz/YaoZ0?=
 =?us-ascii?Q?oOW41LPJqeGVXVwrMAqYwsMr+2nJWG8lc2SFJrFIF+SFruUvxcxNwHc7TOl9?=
 =?us-ascii?Q?5zEP5WCUm9cQ5Vjmga413g8c+VJdH4fvslQSrSpvZBcWmakF2nqxU9DboN/k?=
 =?us-ascii?Q?zhpqBsdjTPg1fKb6j806T1yZxqedGh/YLYCP4Mbbi5xCf1kARsQFuAO8pts+?=
 =?us-ascii?Q?y22QMKdojlbCj9j34PW8REKSwF7Y5/1PRhKuSLc9NuQfTCz3JZ2d5VCwB5hM?=
 =?us-ascii?Q?ZTsP6okCMNjBMmGJPylTV2x7kQkyEBB17IP4M4/APE8PiIREN+zUqC038Hns?=
 =?us-ascii?Q?UmnXDeJ89t9tIp+dxHxCGfKdGJNQX/h1pNqSTn4yz3zh+bE95snq8OinkVmx?=
 =?us-ascii?Q?9ozApctSHEHn6ct3c8F32JN3+hunDKajy3hkmXhie73ZSre7I7Rxn0UnZdq/?=
 =?us-ascii?Q?X/zypK2hy1KGkuNdGO6GhTSl2DpfnF4uD9LDB7fvggSIcmRWpTgj5LSX5wyC?=
 =?us-ascii?Q?38dXbTQc2MZMCP+LFwiyZtPNdGy8xznsl3OW4qEa0PBHI9cLQOMsb1GWR7ho?=
 =?us-ascii?Q?2hye+5YdV3Yxn1ZjFOabZPxuE27dwgW2gD/5a4ab1Dw0SsPDlstoKBrXyqxD?=
 =?us-ascii?Q?zdwAcyBJ0oNB2hpaf6aTpVGMltisuKX+0ccM1FT07rznM6jFgYkObbPHGMXL?=
 =?us-ascii?Q?Nl3lyTC5qoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/oNDumhOhFUfgu8tAySij6Ynij5230nv8vKRCU3NSNO4s6PDkhfnnkqqnGr?=
 =?us-ascii?Q?8wMjTc6BrQcGSVFA57HgpoL1QvBoFQG3DX+vJyDYlFlaIRrkxRYWcgONaS/3?=
 =?us-ascii?Q?73Ss2BgtJhX9JYESxOi7h1ZQ2lTzR26IZBJRKRTndRmztydw4Ti2X6pvi3o7?=
 =?us-ascii?Q?ue5Ef1obEFR1jd/vJV6fHWBi3Q+eM8txgJBjNCL+ikqSAtQDHZVT60np6lQ0?=
 =?us-ascii?Q?yILX9gLAXqq/MG/4Vo2oziIzIGfDdvAuMp1sJi3hGjV40l3dPzfDwuFbjwss?=
 =?us-ascii?Q?XmzvsTABT6eGoeXjoNh5yAwCPFgop3LRX47o7IDOfNmaN0JEmVDFaPCAGFQG?=
 =?us-ascii?Q?l0iq+Smpy7LQNIHGudibUSxDa/+AmvQa9oaEdVZEv3gROeWz7FBGMhoBahkh?=
 =?us-ascii?Q?wk2NOe2HC3bo6DDfl4urXw/EUCuxOqichT9m5VZE02XDO3F0+VozRCX+a9rz?=
 =?us-ascii?Q?WS+XY3ZH+aLfTOCnqVd1JDkDDuGrdgR7pezS9XddYZZN/vyn/b8aDuTGA2Vb?=
 =?us-ascii?Q?SMGWxGtOFYMhd6VbuPTlSbKfa9+qzULLMgYUiHpFTcgNkhmnP3MTdWLQuQGZ?=
 =?us-ascii?Q?ZgVJ8crWvPhrUBlU+Tz8JJ640zW9vHJDcvt9584qV3gu8+ev2DSTsz4RnG+e?=
 =?us-ascii?Q?lYl7nO9oG7q++W7pGa9ZtWbsCqAnAP/NNuwJeJC1hzplcmIOxjPwY3suLIWY?=
 =?us-ascii?Q?8kWGgkS/hKE7T7SZSY//J97gMToAifiLa9DETzkv0CO1fJky0ywRquIhqK1K?=
 =?us-ascii?Q?wIcFrWLd65olNOdwsCKYrHkS9bpY+hxEUMu7qyiYsf7CniKMqzXNhRLyIHyu?=
 =?us-ascii?Q?w4neR6NICKYFLkBdA+Es0M9jDpNSznRN84cF06PeBqnzrfMfHiOzi6dJDXqc?=
 =?us-ascii?Q?6DFXoUs5RcEBmsEXrwyvCmvijPZZ550S1yUOtz1yJBkfpW4eVEoOoFalspHC?=
 =?us-ascii?Q?bFu1UNl0A18j2Upq6yOL2ifNp+cR9gNoRGICCVYCPqrD/zjm2hqBMrimnbO6?=
 =?us-ascii?Q?2GcPZq/LjPgF5Kz4j+C1iw9PGvRnUb6rOk1FXx7hFn9EXuvceaq9v+RF46Mv?=
 =?us-ascii?Q?jE39LU7MgX+omeSxUm5T7zKxArWQQz10cFgyG9vEFHAGPX+x7o2uaqGmAz6A?=
 =?us-ascii?Q?R0jnjzPnKuXLc/1JmziDBesm9ItPhoZ/VoTfBCAI2+rVs9xaa4TL4asfPJYr?=
 =?us-ascii?Q?HwRVgQe+A8baUtLtBlaxJtB2KatLrdEi5wgD5ez3GZpioSJ2xlMQkwRrYuwl?=
 =?us-ascii?Q?iXjTtKb1yJjonxhOgIcNecb6VjBdXinz3ZigRUfsIH0QwUvY6IEJSSkswbDP?=
 =?us-ascii?Q?gcKdftQhQnZH8T24CF0A9r6Jh4h//T+EXaElgT7G5PxJM+C4hFKPs9sPIcw/?=
 =?us-ascii?Q?leZiIfJrDBWpCg8e8qiKxQiZ+FTlw5jIWpz10lFn+IJ1YeB6sbqMpZDjC/5D?=
 =?us-ascii?Q?55nCzJwcdSSFSnKwXgbnL1AivK2oZ+MJGSK4k/VivwnofwZSUNvSTVKmanPu?=
 =?us-ascii?Q?iAyqUa0utqrGMSDyRsiRp3RKlNCkGOQpzNNjQ1sXkquwJK6DeadcErSlCyZ5?=
 =?us-ascii?Q?Y4JL37rLv5885SoYpSjQikqFKXWFUpU29PrDqbOAC5sWxwvkWCi5aHAJPEIx?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d55dce6-165b-4621-27c3-08dda9c73c29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:38:53.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptc4LsTA7i8oznEaqSYqqmetgrwXOGJ0iX0ZfP/kIsNf3WeTfniZLAacX/ToVHdt2syNZ7WdiVnreSztOQiKhGMZSXnTrKPG7qoT21mqODs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 6/11/2025 12:17 PM, Dan Williams wrote:
> > By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> > assumptions that can lead to crashes:
> >
> > 1/ It assumes that endpoints identified in the record are a CXL-type-3
> >    device, nothing guarantees that.
> >
> > 2/ It assumes that the device is bound to the cxl_pci driver, nothing
> >    guarantees that.
> >
> > 3/ Minor, it holds the device lock over the switch-port tracing for no
> >    reason as the trace is 100% generated from data in the record.
> >
> > Correct those by checking that the PCIe endpoint parents a cxl_memdev
> > before assuming the format of the driver data, and move the lock to where
> > it is required. Consequently this also makes the implementation ready for
> > CXL accelerators that are not bound to cxl_pci.
> 
> Hi Dan,
> 
> The AER CE/UCE trace routines access the pdev->dev and pdev->dev->parent.
> Doesn't this require a guard() lock for all callers?

The device_lock() does not protect the liveness dev and dev->parent. The
AER path is able to assume that a reference on @pdev keeps
@pdev->dev.parent valid.

Typically a parent device only has an elevated reference once while a
child is registered unless a subsystem arranges for a parent to be
pinned until the final put of the child. This is what PCI does. See
pci_release_dev() where it unpins the bus, and see release_pcibus_dev()
where it unpins the bridge device (parent of the pci_dev).

So, no device_lock() needed to walk the PCI device hierarchy if you have
an endpoint PCI device with an elevated reference count. If we need to
make the same guarantee for cxl_port objects, we can. To date it has
been sufficient to just follow the typical "unpin parent at
device_del()" expectation.

Code just needs to be careful that just because you have a device object
with an elevated reference count, that does not mean the device is
registered (i.e. it could be deleted, but not freed, at any point).
