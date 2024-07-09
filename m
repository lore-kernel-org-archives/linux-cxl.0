Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F91B86D8
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552439; cv=fail; b=hJ44h6mFpWBEu4zoJqLvz9cPrtZB6QexaRL5yJi5+Co0xbDX4fRgbTD+uqT+1SlrPmnOlUCUlBvIoeI2SPRplbujMUS0TsMnnsXdt+PnrshCeKdte5BmgP4gHrIRWKqmyST5we4I9ZiE++F+FZhNU7FD2mK77gHs8AH3ID/LDsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552439; c=relaxed/simple;
	bh=+AZND0nq0UKY6ihijpg9tTQgY/exRNhRkphIJ6dXAAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbfxz2kJ3DY06sIDOZUvoSDu8Rz/jAf4vJKyZsY6sm3Zc6cv51EaTqYPwoxlg+DZA4Mp78xwPQWi2osJsSLcb4om1Vikt7Zj0Uoxp+21hO3B1UriNGc+fPaI+xu8EaHfmVg2OEEqPBrzoMhs173DonzybRZJpLozET2OLo0/oGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h858qsFB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h858qsFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720552437; x=1752088437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+AZND0nq0UKY6ihijpg9tTQgY/exRNhRkphIJ6dXAAs=;
  b=h858qsFBzKTHpwr9L+huRVlh8eUHJzGqw9GQIcNDx2IBwgDyPXFuLpYh
   S+LFSGgWKMGDxHva2H1aRXQ+F3glhiv2iZ++ORxWGlhcT5wcfcfgeV2gs
   cn54vISK4qn036IvHWzMQ+YMgVUqhxBEpyDgWFQ4ZMgwr78h6ul0CkfJT
   dQJ7u8D7XBFu8wLY+309JlDn/MVLwCt4dCii7tgNiffy/GDaTBxbiHvX0
   SJvGPNZ6kdt+VvBw6WjwoqIXrbe8dtS/DHH8TMJ45wkOG9VykDx7/4trv
   bNfOv70oMV8FTmvo29mpJf4KdnUbl0mPxAkBViyiffpVHFMduGOzS+dM+
   w==;
X-CSE-ConnectionGUID: HkasVmurSvyUK3f4TFzTuQ==
X-CSE-MsgGUID: uCwNXowJQ+SiF26D89XAuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17464619"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17464619"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 12:13:56 -0700
X-CSE-ConnectionGUID: teTenjBZTGex54ZUWFBMYw==
X-CSE-MsgGUID: Sltz4GBgSl203qnd3aH/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47943187"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 12:13:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 12:13:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 12:13:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 12:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeTTC0N+xVdzwrQqTabrCqquzPjlL4riW6sGgppVWbbkH/TnXlZX0lIerva8ngwSUALbnjaXjCZUCBDkO89mNhKTyUNoK83gEWVU5lS9nOa1uMjo+Bsvvf2b1N2SpfeKXSUQZgNT8+BS1u64pBS6rdkOpTTM1+DIsDf2SQvl4Eem1vPSL3kuqExv5L3AJXsuOg6yUGKQEkxH0YKknW58UGkjfohG16zfn0Z+wN2vXboSeBUuWhdAv5gTrXfMevlgvANN1OOhudnJ994MpzGCViPZ3TDtYsmsuMp5qWE3NZn0/4nsH6RMJOQALhl9bw/PwLFi0Y/X1a21vU5bCYcqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gmY15QlsFqb/CufrYoT3xbWi1e3k2tEP/30tfERrag=;
 b=KP0QN+flh5/EHu20MdKQfjtDw/rYd2uXCl5oUxH4VyRVQma+JRorEUav47PVNT56Arz2oEevqC5XTtgm6QopJedzy4zloXj7uuiCFCB8DXKXUrqZ0wap04jLMiLnmBiqHMlS60P2RwoF2VySV25IfIFfE7/ETnPJyYwFAafJ9yaTr7vPEPyEUL5ku5tH06N2s2pYe9grfthV6HXnpDUd/XMXKmbOfCWsp2sifZUPvlEWJYkWGcl5NwIC9Hav8HVztZAL9YP4/W4QZURnfxeYD9emlnoiYNBDK6SGk6hnVkPuFfUkznBDCtdZWBUS/e2FYpEA1vGW2p32lHwaJZAZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 19:13:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 19:13:50 +0000
Date: Tue, 9 Jul 2024 12:13:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yee Li <seven.yi.lee@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Is there any plan to support CXL GPF in Linux
Message-ID: <668d8becca6cf_102cc294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozTTpbMjff82vO0@infradead.org>
 <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
 <ZozoWwm2v246szTu@infradead.org>
 <CALX8JfS5kpY4P0r3QUmDxwoST=d3yR8gzmxK6NSyXr6bRiBo7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALX8JfS5kpY4P0r3QUmDxwoST=d3yR8gzmxK6NSyXr6bRiBo7g@mail.gmail.com>
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: da061557-35e6-4007-3981-08dca04b4443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukUjncblFNq3DM/qTU0eqIBuZZOFCtbuTJpZfS9QFK5Wdc10lkQZOOOvyFri?=
 =?us-ascii?Q?mDq8IyhGF1G582CppWMPQYiWIfWUd15BPtg/cBdx3UAlkCp8qOw913DND2HR?=
 =?us-ascii?Q?i4b7dwWScZ/Itl3mMzQBntRgaCycI80/v0uSnHZCxjGI8DWUT58OkEhDTCWR?=
 =?us-ascii?Q?d/2XZk4fQxHNAheDEAdJ0pRtDdWSJsB75d9PC1pmjdAZSpkVg+rKF5ay7Zxn?=
 =?us-ascii?Q?lHZOR6+Pl+TAprN0cVYJsSKqrXLgonttweRwpJcJg/vZNCShRI060wIsqoe5?=
 =?us-ascii?Q?dZotIB+kCyJw3gKuIHh3N+LGcMvnjDrwZLtg9vNAGVBsIgAh6WMp0evqG5k5?=
 =?us-ascii?Q?Y9fYrTEWEfic0cNISOehMb7YvzE4vIZlSy1qiHNZqtAY1bbX7NdGjl31Nxuf?=
 =?us-ascii?Q?EsHfEFejXl/rqyFB2fJVnJoGTdQx6UmujXq6bbIf5oLP0MRTDw5RnUvthjsn?=
 =?us-ascii?Q?nO3yXNyCu6NRIRhlz80Tp/J6xpFmMN6gc6MbkneFfoXCXpuCy+FRa6DU4RLq?=
 =?us-ascii?Q?z+ty9zDaLJtXnkUOM++Df92BELfSxxWznA86nk3Dfx5tpYsHGBfyuEW+mvHg?=
 =?us-ascii?Q?FMm7xT5jYhUHtYXWEzcYhyts2mBSjo2JddElBc37XnrFGwtvlZ/1YVcG3Mf8?=
 =?us-ascii?Q?JU97F91NgJkTe6vT9ROFOJVAAlnWg11JRa0d7b68U82CGGqodtyVV/SEX4rt?=
 =?us-ascii?Q?H4pbkQv2gtbfaVSpHlrdh8nCkWRD4cmEzamP3ri5oH0Yd2kg3QDLVCPhjEF9?=
 =?us-ascii?Q?gUn8YNgTd7Zottbd/n9dnqOHL0NStcZYMGiG5Lh2zgx+jO2cWuhWQOMOwsYP?=
 =?us-ascii?Q?mVcEz6x4PEl3mIlwHit+rbz4o1AbMz6E871y0B+UpiaWXBBF5HxOeZFpGEZA?=
 =?us-ascii?Q?/czM/UXMdEsjxDJEjYTuqdomLJyHAByBARd3sXtbWOtj6EDSenZaHx46fB5x?=
 =?us-ascii?Q?iU6KFFgXDV2QVSDf9iojGQtZ73kP21TfEJFbxZdHC0C8vSwvyUekAiJeq38n?=
 =?us-ascii?Q?saEYErnZ1JNqv/HDGil0Qnw+jqCMtrtdLqRt1C49k1BafkNdsjkTQSI47F8z?=
 =?us-ascii?Q?LApasZyRBXFC0pbO6lq0C+pl/X23vCGXWTNyPt3Nt4A6SfY5jruYH93G0ETP?=
 =?us-ascii?Q?S+FX53Vriu7d4m0iSmRRNLMPkh0P5iHYpzUJyq9HkI2AesksUgo0NPNL9K+w?=
 =?us-ascii?Q?sV89z+0P3X/LGGKaSD1d8rXH0HzMWdTuoGzR9+QA/yNnlzh00ZgErXXYCO62?=
 =?us-ascii?Q?t8eY1d/YZkHm4gOpZajZA1VHtF+8de794Fet1WhpnPdgiDHxU/QXtQPuJHJ0?=
 =?us-ascii?Q?ImA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mF+XCAt/WK3hkKpA8wUcyozG2E+GdekBVLq4JIMlz9kedvK/YgotMBbcBAWN?=
 =?us-ascii?Q?08cca+YVRfxCEXe0pveLQ1AZ7FkevMgGxxNkMpJHbra+B5bkacs6kTNGc3fe?=
 =?us-ascii?Q?e916A794V2Y/p6PLPQtHnDAxQRmAuZKluLC4/sfDcbFCdLKe1IzpVHl0h4KV?=
 =?us-ascii?Q?+0CMMSfTkBSYDbc/S9u21cBBR4tFcsFLLtit9vpA0hS+G/1P/0X1niEJ7dUT?=
 =?us-ascii?Q?QZbXbvx3Z0J5Vg46BvbPrhRdmKaTVKeNVrR2IaksfP9kuMD6XTNCad/xr+Qs?=
 =?us-ascii?Q?xMum1mETcAPuVVxeLy8Kta3waruofkK1CjaNS4jFUD00w4dg+xS5PTWWpw4A?=
 =?us-ascii?Q?3p2gbOBVePjhe6LPpQIqC09Fu7YDmPzvu/p2lGl5+xMz4orVyrY2AQFHOCy5?=
 =?us-ascii?Q?5Ri4IkyrJPcOc25Ub4NXXixWY8H+qXfYrieAYbzDp2B9YclLanaUYo8VQq5e?=
 =?us-ascii?Q?uzaUXoMpB7TNAPyUlce/SMrvbaMEhbZLGRPyWu3sntzTJRfFbDC5lgx3U+OI?=
 =?us-ascii?Q?W9BaFzgIS8msbF9mHTEwc2czKC+6xo5S32M7x0iNwxYreauoef+oJTTPP3Ks?=
 =?us-ascii?Q?cLXic9zu+EEN2cdvc5JnQXVl6e2ubq15f8Oothv2A0skuaJ9mHteuWL5Xh+I?=
 =?us-ascii?Q?Wo4HFYOx6Lgq5BxkE+g+sve+xC5kCiaSWhXEAZZxr4vr2KGBXaKJm7RSB9KY?=
 =?us-ascii?Q?tBizktOzNV2slLoEH3QBUQDZ8VzAvOTS1AUL9YxpqqDeZrjExmUQZgN7eDLf?=
 =?us-ascii?Q?XGDtDUE5vvUSH+EqZ4bHEYCnGVKTiVk1YRq7klWqlpvGT7Fp2b5MzAOWt7ZE?=
 =?us-ascii?Q?uyTaHX3VERYpEm9yCn4M8j+FL7PZs/CIcKKkaBi38u9hwx3VT88Op9HbU0al?=
 =?us-ascii?Q?ncnwjVLKMnRA8JBWx+fLIqLFZzF1zPuMcZFT0TStInREdW0X/RJHQyKy514D?=
 =?us-ascii?Q?GdnY1/RTNAzCHzngHVH7uH78z6u/hZuAGGB3CpVFXu4V+s2FY6LGJqwQcAzL?=
 =?us-ascii?Q?YVWog+48PUn1M/P0+yBd8Ww3LYTzM126FwH02b39QiH5JU5MgybzzgqoNyZC?=
 =?us-ascii?Q?WY51DCIjo2TX0qi/WYjGhwRgj+q4Wj0lGwcIrRlS8vdv+qxdmoDUtAPG2Iuo?=
 =?us-ascii?Q?WdPz9/opzcc8chcxDv3H+JAS/MOyysWZAzHhlqqPWxl3dTdDArfWY/S4R1C4?=
 =?us-ascii?Q?5aL+slSl2xWnrelxSmssOM+PH7Zb4p9Kkga21XIS5IGHxxR9zk1sOQpdIa/r?=
 =?us-ascii?Q?MaQtJFBpjObQ8lmSTJeM9ZLPQ4zMYOMwz70auYBYNHff6CqbIwgpBShGm3Ha?=
 =?us-ascii?Q?O7/Hlq1L32fB1gmW04wZlDrumeFmm9g2fE1FkMv/K0U9S/QLeM+7T1ronpAi?=
 =?us-ascii?Q?Z42PkixkQrA9ze1WrcbjOuYn8Ceo9De56Kbpm2ASo6dIfDJYgOEvdiDkB6N0?=
 =?us-ascii?Q?gxgJpwnpvoZE+SgmbvF0vhOkrW0Rdep3UydCRJZ9VKbIzUi4SSlBJwN+VuJL?=
 =?us-ascii?Q?OkS9LOUCITjPOOen+OkERGUOKXiEJs9sB0w9wP6eLOYgg7nPBo7b3M3rvKkf?=
 =?us-ascii?Q?q4OqbacT7HISrUwJbxpnFXCrNxxRpVv89wD91r5V92oe3IHsYOZDMkjvUOuH?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da061557-35e6-4007-3981-08dca04b4443
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 19:13:50.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FDk5SSXUqV5BdTomLr+U75/1Enerq3wz5sjmi4bV9bMY4Nnd/VJJ+ptn7I84vvJQzPNelytEU7r5xQ3fJu0VtpuzJFYq1G4D9DZujPvLfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

Hi Yee, please refrain from top-posting [1]

[1]: https://subspace.kernel.org/etiquette.html

Yee Li wrote:
> Dear Christoph,
> 
> I agree with you.
> cxl pmem device should process the GPF event well by itself which is sent
> from Host or Switch.
> 
> Dear Dan,
> 
> ACPI.FADT.PERSISTENT_CPU_CACHES flag is not recognized by Linux.
> Does it mean "cxl pmem flush operations reference the NFIT Platform
> Capabilities"? Or, support the flag and cap in the future.

The Persistent CPU Caches flag is a performance optimization to avoid
CPU cache flushing when the platform is trusted to take care of cache
flushing at power-loss.

Software can force "persistent caches" behavior by:

    echo 0 > /sys/block/pmem0/dax/write_cache

From a kernel developer perspective, I feel more comfortable with
userspace making that "go fast at the risk of data-loss" decision. Maybe
after the industry gets more experience with platforms that set that bit
the kernel can default to trusting it, but given the slow roll out of
CXL PMEM devices I think Linux is ok to take a "wait and see" attitude.
At a minimum, if someone wants to draft a patch, it should be a build
time configuration option to trust the FADT.
