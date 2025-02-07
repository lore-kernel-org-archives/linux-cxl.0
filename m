Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77D23C8C7
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959530; cv=fail; b=tZk0AU8YbKX0GBiUc3XlKVu2RiFTHkkB8uV3v/Z908Qdobxewc60XLDj+Z/2259E6TrUEcvr3LgGDgwASYzBNPJSwYCMexVvYhxkbcPOEssV7paXhQYfIiPS0wg0uy7J1D0o4A5AfAIf5+vlgkObz0f/YHa9G4k8MikH55Wx56k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959530; c=relaxed/simple;
	bh=MBRe+8ejip5/EWySFcDbwVuF3CWrfUudMrMu1AYreAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTTwf5/QmxSHy++/nCKjnvD9NZr1sGjRQGFD/LFs1S7r5SxPQJ+ckDd/S2Jai0lnBF194nxaoEWE0Qq6oQz9nT+BQrtTZzHcUZecDyq8wN4BrtR0BHYL7SWUM8z73UkWj+EiPlp/9YcMZyUOQa5KlKndQo80+noIwO9cBb4Hq1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcSdOFSi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcSdOFSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738959529; x=1770495529;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MBRe+8ejip5/EWySFcDbwVuF3CWrfUudMrMu1AYreAI=;
  b=ZcSdOFSiPLKH9GkXnvCu+CeWYyzSpN56PRCds4z0QWb3zgqFCJdUkQJI
   K2TSxmljiPLrisrK6xLUKdvdb1yfjoFiKaVSMEw8MQEFp+XUIew9pSqlv
   hFCDlfxHMW6q4s2LW5xKg9vz0YPcuvDaDkS+3ahZkEokyhOrF5MawT2Md
   C80xBAdFIOpgnS4KmGVveV95LJCMUaDx/aanZCCUHr+RD4mF3zsPxCVdh
   5iYhsUZRm4DwEX5PTox+V1YRY7gDV9PBMI77S1757x2vBlm3pJcBxTr3r
   kXwCq70r3ISFXux/u1pjF/MpuoJSFdPZDbKIpt0T0b7y7uEyt6tYyXi0o
   w==;
X-CSE-ConnectionGUID: 5rFfgoHxRGW+/xmVr9VESg==
X-CSE-MsgGUID: Bc6uD8UmR/auISukmc4XVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50251081"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50251081"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 12:18:47 -0800
X-CSE-ConnectionGUID: quIqxxgrTESbgI0rdH2QqQ==
X-CSE-MsgGUID: knRyRTMYT3u6TUjAFvxZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112244546"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 12:18:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 12:18:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 12:18:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 12:18:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4ylpzLXpYUsdDQWnQc4bCbEMtEeFfoYT6vlp8Cg8T5rN8+bmdHxraR+ea6pVqGegl7oBno4cIQZQjsS8fwUU1lF1pMX97Erze9shwYlJ7DJXu986LVBfh8Fh7Jnz7ilcthXhFPBsTsJXKbGJJiNUf7Uv6ah2MNO+uV++wOwVGfO2RKqqvKZdDm9QV44H0pmRmytp8H7ExzBrBTM5V1BveqrUA517sSIeHJoG83a64mOL6VEQfXFLKYmQEHb0mYZURg1BU6+ceLpeoPQspaVUFjqsGHs73m6ssRoCwr4T4xEYDzOfsA2NFmUMbV3V7kvLAdnO6S6NIdKa5v9UqgMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm1bG0dry6Q5cLxr4GlrvbMnrJZNJ5YTSTz19S0BuNA=;
 b=oY7pOgs1WAWZXqQcdHP9NB+OImK/kIDzYYAWiVckhd9auaYm1vQKCxqk7mB1OiKHl1ecGIwCKg1g34s/JeMHs4atAK+Ja0R/pX0cG7JnHY+ePJkD8RMjQiKpaZ4Ow5mb6T2Q/fz+uMCS5/J9OWDZLSSkU2dkjrmA3ZbhkBnFkCc0oOYIXu6tE6S3LMkvLUzDCOIwG/71k1EYqfl/UhcwSLCckGwNqIQStQJaT23y44nmEH7PM1vFnJ4N+1QWol4vLZe7Q7OaQ0zE4OJZSlUegIu8rOBCJeduTTawq9EsAV6kNlYUxy1w3VlA76Zji4+8/QGgkfhLM+kbpQgKOC13tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 20:18:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 20:18:10 +0000
Date: Fri, 7 Feb 2025 12:18:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <67a66a8013981_2d1e294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-6-dave.jiang@intel.com>
 <67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <20250205175740.000079ab@huawei.com>
 <67a3f0502e793_2d2c29496@dwillia2-xfh.jf.intel.com.notmuch>
 <20250206110349.00006de1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206110349.00006de1@huawei.com>
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa147f1-f8ab-47df-fcd2-08dd47b48afa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VDHnQIVfijzsh2utVAu0UDGUxznDO1uqIJPAD50L1bR47nn1aCkyFCiw5E4s?=
 =?us-ascii?Q?qoeuFOeSbirbiJ6NKgKWWYr5hQC72vxIEJE6YuR92Euio8/Dvvl+V7zJ9dAs?=
 =?us-ascii?Q?llhW8F1xBAGkbgbVHqElHu0ar/W6PdO+JqeS6JrzzP7sfmoDBSh0Te4BLp9+?=
 =?us-ascii?Q?roG3VEsdmYaMzQSmB507/pQBFxpbbNl0TnT7F8CGyeq3MwRDwH+luvQq5kNt?=
 =?us-ascii?Q?6X4qwXNmiYl0vzYfZjTe4p9f+jgYjMmep0DHvmCuIRxItrEumdUaiA5f4wA7?=
 =?us-ascii?Q?oyeEnUrjckkz/AZCrqr3zqo8hAvIFjrbVfGcili5JXP+ej2d5c7ObGx7qRK3?=
 =?us-ascii?Q?wKV9kvKbIZpaJf9VlLT+TVl6tILjNs7/M6tNb/gjav/xLUrGHRptPk6DOb1S?=
 =?us-ascii?Q?xfG9BpcbxkDUR8oVa/Ex8Oc+l6VNE/3Sb2k5YC570FIt+AFYzcilrggbUo64?=
 =?us-ascii?Q?nDq6kpUgPgLY8a8cob8YCclJF/oVNoNbR5K+j2uS3uo6YyjNXeTy63hauPbw?=
 =?us-ascii?Q?61WpD2JaIA5s68XwhMYNBdgqw+/UVxvEcTJCus0HD8st5i7adu3vBl8/uUK8?=
 =?us-ascii?Q?tLuIgmq/2Rx2ArZle8H7C8HRw4r7dWX4IWH8+p/Amf0VczMJcSfX+r0TEFj/?=
 =?us-ascii?Q?6C3y98GSzc7lkyCYkeoq1Q+PxzS9EKXHoJ5hv+LwPKfmDyTlfMM/jJz8OcuV?=
 =?us-ascii?Q?RonGDbvn7BPWgIFxUyXjzWoe0vo3S9WywE5VsDJXcXex/NeQaqUePunkRMlr?=
 =?us-ascii?Q?HeqckdEOAw8nk3omhRElJAdPmrN5YT51YRuO7BdxIiIlOwnbQ8kY8mZVnNIw?=
 =?us-ascii?Q?8RI6rw9S7oMTCdZqLlG0Wnt4q6XJ1ZBn4bTqcxp2Sa0etNDveGO6fKciIqlT?=
 =?us-ascii?Q?a2WM/yN80u6pAMy0TOgTqygHh/IE8ULtygljiYKvUYk+fEh6s2cXPoM4SZq9?=
 =?us-ascii?Q?v6HqmM/TkG5Xeh3kgV+ZGVwBARVotGJe6tdseHWaUib0/f2B7DOTV1DMYel+?=
 =?us-ascii?Q?RL7rJEnRP4MCRIjR/ihyQC1xd+0UWqD3nhMfvXPK2TxvC4ZxBDjedipmr8gX?=
 =?us-ascii?Q?FBhurPd4kwQ9zJs4K13Wt1Gyhnv81el+V79K+jCAT3s37xjfGOT3F+UNj1Tw?=
 =?us-ascii?Q?0AQZLbBOcIIjtyLy3LWL1+YYAiZs1hD3WLt8svjualy3542g5lfMzc914uIq?=
 =?us-ascii?Q?dRlb5ssypxpdCCrVed/gfAa9FRgV0+VWpuJ8PDtRyXgm7QtLFTo95IkpfiuF?=
 =?us-ascii?Q?H7Doh+rpsK+6lIZzQj+dWJNNOh9jpdH7fny8ROxXUidWmqF9L8hDtr/rfTWy?=
 =?us-ascii?Q?qyHq4Zw5uLTCMZZhD7yjs68uL3YUBPU2QCS9GXxmtcGHY34qA+xzusMge+0U?=
 =?us-ascii?Q?mTsuHQqLwYrvyMk4COJGcXhHj8V8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCF7AcaS2IRahaJyxlnZmuFE0JSD78MT91X+59RDAWoad6Xkc0fg4avNeEZC?=
 =?us-ascii?Q?sW0plsDEEP+ClM3vdpEdBc8FYnLF5lnEzEGjXJ3WVocQ/gz5i9H3LMv2Eflf?=
 =?us-ascii?Q?OmmhLRsuYNYJB88tWksUq9j6HRbPHP43m3Yh2QEyyHnLcgMEwmvD1RE8+tc1?=
 =?us-ascii?Q?3yPgZxRfJ8shFt08OpYkC8/gy/oqMhXq5Kpc/CrEu3JFmJgIojk114HdsFDL?=
 =?us-ascii?Q?HKe8+Hyf83nfltPHgVp8Z+96vsFxzDvB4jrDhmF9hc5imrCFy0U9uy3Om17+?=
 =?us-ascii?Q?lGtOV3dMKVv7qAsb+R1nqCPDQDz0DPrrDe1/5FIoPFK5kGcemsn8IXayJNFG?=
 =?us-ascii?Q?rCL27GM2iv/VAw1A90dPlKstPJiahqtHR6ozwD+sznkG4VBKdpteOjI//mIs?=
 =?us-ascii?Q?O7eU2vqTC+lG9fC+RrKRMmJLNGLpmUMEUMalB8JNq5QsoVWNxKtTi4JVT3cK?=
 =?us-ascii?Q?9eL+8ypYqPyfC9uef0FSY+iLz6ZlGBH3codyp0YFLxlkUd9mrQ7TocmaiVyy?=
 =?us-ascii?Q?dyyu1dDI2KcNcQVAHoIcskLf8CX9rjDLZrwBDEQFZRbKiRdmXONzZu08Kcw4?=
 =?us-ascii?Q?TOFnEE3/OPKmw+Z33QdHENvuHn6eq1LSMqvsf4C3vcSYmI2PC6J/qa0SblSG?=
 =?us-ascii?Q?mdJ+uYfpIYXl8QzjefBUH8wDqbZT4VvrEXSQFzMXd52Xy2pe1J1uf0HDtnUg?=
 =?us-ascii?Q?hOI10hYC5tPNV6g4aH6hKUZxS9KsBykAW9mqaHd/Pdc6y7i6MvHVxqiJHu6k?=
 =?us-ascii?Q?rO/cxiSVB9eWE7PGXXVWZ2SGlh2qMQwBmUb5W4HEzLoHIk5OY/ZlEBJgsgYd?=
 =?us-ascii?Q?BRigu3JJdyGDk+66WLhomjgffofDscLThGbLEM7+nVsaMD6oh/kUVp0/akWq?=
 =?us-ascii?Q?JX1B6bfT110o7BuLF0vKlqnYiNE84a2a2+Of8Yr2ibg3sAI2xFKNmZ0qsoqr?=
 =?us-ascii?Q?v30qFZ00D7jh4DQDsNqb2RotJdB7AToh5MDAVlyF61zr92bgCRPN1whrj5Pu?=
 =?us-ascii?Q?mChe6KIvF1zLj8FaJU7zo8FznCKbMZpuwDfsu+Af8Jh0AyBHo89A0QDOr6tr?=
 =?us-ascii?Q?CaZJ67/zQlYBCNwXaxtoOJJ6pR9Se8rgPLUMt12n2jKci2Snt9sRIRQ6hz0s?=
 =?us-ascii?Q?OW9O0+xqQ3WTv1Bcf1wpjX8HwaGizIONqvc/Ode5Qws6HEzEmxvJqdZIzLiN?=
 =?us-ascii?Q?EiDZBeJK4pDPTxqq+DzMXG5bONr2Xs5fZeqkrwrknQpw/qIQOFf07XG4Ql26?=
 =?us-ascii?Q?QJ7RRDarg9WBgNIuDUrKsIXwEineOf93SJ45HdgzONbVWqzJZWcH9pahJiZ/?=
 =?us-ascii?Q?7t9AZzjDcetRIoXjtqR6oi+L8mkc/dV+KietmeNehXHbq6tm/R5bZk49hxG4?=
 =?us-ascii?Q?9NOvX8GWd2R4uhr/t2GIKZcuT8BaVUfVLt9kU4daseqNxaL703J1Vus/bC6/?=
 =?us-ascii?Q?raMvcV4SCCReMmMwGmYwSHBwSkzJX4o7OIS2f44XGnRqiUTg7CJHqZpXR9Se?=
 =?us-ascii?Q?W0jT7OJ0Tust5MCjTOp18kTjiIpsfO2whFOJ/Rhq2RI6u7YlZzz531XkBD5w?=
 =?us-ascii?Q?jXwKwXKMKmbGmzO4hAEtgOsWtp4yRqBMj0mk4U3+SvTwpPI5509pCFX248X6?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa147f1-f8ab-47df-fcd2-08dd47b48afa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 20:18:10.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQhIt9oPRKM3RdNMRdR6DInDOuxJXSkvPtudGy226fzO4mii4KYzklMN4ND4tYIrsKB9bvWVN62XZP56WMmsdG1h6/emrNn5tVPxqbYOjVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 15:12:16 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > [..]
> > > > So I see this is exported to a new cxl_fwtcl.ko module, but I think all
> > > > of this can be core built-in functionality similar to memdev ioctl and
> > > > firmware upload support. As long as distributions can opt-out of FWCTL
> > > > and Features at build time then this is no worse than
> > > > CONFIG_CXL_MEM_RAW_COMMANDS from a proprietary use case / security model
> > > > stance. With that software only needs to worry about finding a
> > > > cxl_memdev object and not manually loading a cxl_fwctl module.  
> > > 
> > > It'll get exported shortly anyway as it's used by the EDAC series
> > > and that should be separate modules.    
> > 
> > What additional modules are needed for EDAC support? The registration is
> > done by the cxl_mem and cxl_region drivers. Are you thinking of a pure
> > helper library module to the CXL core?
> > 
> > Does it really matter if it's a separate module if cxl_core.ko is going
> > to demand load it always?
> 
> I've lost track of all the reorganizing.  Might indeed not be needed
> because it is wrapped up other calls that are in the cxl core.
> 
> I'll let Shiju figure that out when rebasing!  Note the two sets may
> well race as I don't want to hold the discussion on remaining 
> controversial bits of that set whilst Dave refactors this one.
> The need to eventually rebase on this doesn't stop the EDAC core bits
> going forwards.

Given the EDAC entanglements and ongoing discussions about FWCTL, I
suggest we merge the common bits to a shared topic branch.

It is not clear to me that either consumer, EDAC / FWCTL, can clearly
claim to be ahead of the other, but I do think we land the common bits
to get that part settled while the rest plays out.
