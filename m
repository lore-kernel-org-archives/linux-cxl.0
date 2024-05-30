Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBB26AF3
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041338; cv=fail; b=juc+iFdN8BFIMvpprHAzfgut6/jWimbFo9ZZ+bJt8Ycqr5H0Av55ax+2kgqe8DMTBSmit1j2DLRcJubRjvJce0frgOr1oTyHytwrD713RamOs88obsKQ3AtPzps/ofen3BxHVTE+K9ZwhcBMH5yZxNQkIzG9K+SPiQsrMufokec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041338; c=relaxed/simple;
	bh=t+kvFztfQPP5SxCd9RHGQWtAXxugl2aSr75KpsEcg+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fB4D0GQwVOjAvMVYQ1fajhMrkRU8S2WrCTOe6j7FytqLRiqh2Y5I12Azx4C8l+ZI1LhLq8LS7cBI5MJIuFlGsg2+shfy4xpv1jdAiX06RXSij/CO9+3/+xBnNCuAmfhLXWjU74yYk3g9lOIIRgqvckZY47i/Gd5mCFCHHsFHXbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwrDWpbG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwrDWpbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717041337; x=1748577337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t+kvFztfQPP5SxCd9RHGQWtAXxugl2aSr75KpsEcg+k=;
  b=CwrDWpbGejFYOFbhmbeuUPu3TpcWJavsJBUc36VwSZ+qo0uyci9glc0H
   P3+07z7gbehvC9OhwMHjjuxTTp0HZII50v/t0iGbnsLA0AVd9mUBK1Jeg
   UKETAXYAZ6oC4rJmoTnzXVJG7jjhDeZecYVjXQptaeFxDlzV5inEZ4R98
   mqg1M6fsYr03CbsBD2tW2lB+VPjUgZdS/8l1ap6Wmtt8sJqbb/GXcxZZ1
   gIwSt66AbNhW4ep6dkF2RCp1zb15jtXanyMUUPjmg/l6erS6TBXRxlCZu
   ECamHPfWAijct2pNaKVR5g3ym8TKy+sm3EZvPaST1/wTwE7wqZzPneX93
   g==;
X-CSE-ConnectionGUID: 3BV2o9ALRPmvPlpM4QuRhg==
X-CSE-MsgGUID: QjfNLB1GTxC1SRzgSpnXiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13618540"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13618540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:55:37 -0700
X-CSE-ConnectionGUID: qPpzamJVTMGjcrrRtweq/Q==
X-CSE-MsgGUID: 96bWCvM4T1yWg314WkfxJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66527080"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 20:55:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 20:55:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 20:55:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 20:55:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+5rZNk2RN+xaEd4n8X4gM7eljlcFrLU4YCKsddunqWl43jEl/Xlqs8rJO5K5QB3a+OOBSAWOf6SVxBB7dJ1Px/ipU/K3Qwi0b9xiGxo57ZIYrB/cUJndB4Fvt8ulM4A7tmkDKhXRVuYNkcsASo8Dyrh3MhPVhEGQAwqx+bGp+Q0F3ymxfB0Fr/cAOzjuneV6fFMImAo+6Zl26zmef1m9QCPh5YgTdAAEkKQB3VlTUUNcwphz+uk5w1YtW/IsAwDLP/ciTF66gD03UixH1qCLefu9dCuBRmxhUczICLNVLyxsu0jhwn/yethngbuAE2p0PNxuPqR9FfbE61nU51abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmlwP6Pdh7dzHN0CiyvSmYHQktJVVse7eitbDZ84dF8=;
 b=Vf8jul4xSLbLN7VnBsH4uBzg/4OVG/PD44o5F9mqBCSuFW+3/BFcYIa459j1xlEH9XiMs8QC0of7t7s5PilOnjQVphkU7lmtIMqvs1TBsNEh6w7xWjvt4m/l7nmtQrlPhn/8VZOcQF/XjnYmM2xdAFFPnmUvtJ1Htb8WfaSAAHjlZiJfIuLCLQfmZ4fVqK1JwaefAfzOkF08L3kIvcK/B1aJ9+ZCyXbBjX+ESJkwA27Ty/dQImrz9lW0A/3lOfSp8c7LpRebocDuwa14ciRz8PsRNwIJ5cbr/QxiPketcTaSJuUPRLFDbousOQ/1OztYlnd2Z89jO2WqkmWSSc1cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Thu, 30 May
 2024 03:55:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 03:55:33 +0000
Date: Wed, 29 May 2024 20:55:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <6657f8b2d218e_6ec32943d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ba32ed-0cc0-48bf-9e97-08dc805c5b17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ooz1PzfWkGyF/l6akQQcNTPhF90yUSbfKiS/atKHfGL5h/x5ffoTf/WNSCwL?=
 =?us-ascii?Q?k4+N+xMVK/thp5RpRzvepLNXXPyx+f45nPBX0vG2YVR0EBGmYjcwahqpXIbG?=
 =?us-ascii?Q?7IWUo6Mh0Hwe960HaPOVIOJyp0z9YMwEo0xIppmcaZPFcZeGK8rYnPTxVnq/?=
 =?us-ascii?Q?JdbgtY7C32gY+L4SMDFYhKJoQWn21fX4m5V6dn0cPTWsBQton3+Ch7sCcwxL?=
 =?us-ascii?Q?f1tZv8iz1SSPahWIXtlLeNKmmdDJ5tACd8BRw1+efciSO7B/iHT/qs5llIPy?=
 =?us-ascii?Q?yldMZ4ZyaYugB3dndsnGRhaFTUWmhOIbnIOSs927g1ZVCmZANTyeLiwdEHPj?=
 =?us-ascii?Q?2qizHiejUA1qFMzpenKODi/5f28t+x/iKErNUouCDhX0vx0ZV7vXoTA90xZx?=
 =?us-ascii?Q?9p1kDu279xYkBi6O2RUOWcksLmgXOTtgsvr+fHgXTYb+imAc5k478UKCQlM8?=
 =?us-ascii?Q?oqTxF6u4Ay3+NIhEl3WjXWKM2ZpzPECSnaFt6+nBxN9DLyIaYsUWU3pq3FWv?=
 =?us-ascii?Q?sMjCICtohbbAh23QfyFTRbH8drwE/RQG8CA74KGqr+H80MHZqEeeEXXSORVX?=
 =?us-ascii?Q?t0m8wHXLExf/q/4Mn6aj5QZILDy+4ZlPjDw3KQ2FmEeDZGyuGgED6NJfg6BM?=
 =?us-ascii?Q?IUKJXdwJECyU5eXhir4z5X1lg001aFIHLBR7hNWdGciC9uDsuKHHNPjLv3uj?=
 =?us-ascii?Q?N++xuYzqE6o05aPb3YJTzP7yBnNhEX1gbOna1KA9pJBZQ+6dIDKBtQQv0J0q?=
 =?us-ascii?Q?2T8KIUY3sX+Gz74aDUbq6aZYkZYiLge3qspOOy4TInWOJ5OYjfLyfGWonn/P?=
 =?us-ascii?Q?0G91MYosXeSrxsPtCmGjOrSE3nycENHP4VbuvmfjheQ80P8LpVj7FZgZYDzt?=
 =?us-ascii?Q?Pn21sIZ3BfjlDIoAVH8hDSCQo+XbOe7MpEr4FkHgU0Xrla4ZhD5zX5m7zI1A?=
 =?us-ascii?Q?niqvLo0QEhsM6AlwwB9RbYkx/Mm8V/L3HelDWS3hj1XdMk8edxja9aiwR3dd?=
 =?us-ascii?Q?s0mwjrWJxG1ZRYgSz0vAlakgqsUGwoXaBsajqRCcAaGCzaXiRMZUAvLOjSM5?=
 =?us-ascii?Q?IL250Jnyyvg4+q+/oISRkG8cLJHKJY6ylAvn0Pq6VQWR/K0sOZrWE4n/+QRR?=
 =?us-ascii?Q?A4yLcKSh/vxqL4/wNek+lflIPKph4XvWsn/LyEIjeW0sWE8w/Y1Fp0o5ksRC?=
 =?us-ascii?Q?HxqSwJs/mB0bJOjVzvYEPRoc2a6bhJ9r5mPHdV9gpaQrlpwMHHYg9fmUqKnY?=
 =?us-ascii?Q?kiCHsbu/e5alrvki/vF0BtPXnCIgjjR1U71fNCTq2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qIamFxHeY+GzvbWbecJ+yDXj+0O1HjAX557O3jg0JmIbwCjD+T+8p3txttv?=
 =?us-ascii?Q?bUst2fJC4lL7ezLzvu+NeBYnj7tDtCQWe4U+2pZ4SLLCy1syhviAzbRokvT/?=
 =?us-ascii?Q?ZA0kkbUG1AHFwgVEsjJGWJZKHRYGSZz3tWv1I7xKjJiD6yGSwecNE0iIsaS3?=
 =?us-ascii?Q?xJCfpE8urDobp33moNfh0y0/hDO5QJqAc9qCYNWSY0zq/lzAvkkG2L1z+kl8?=
 =?us-ascii?Q?mHYoSyKnV0toUhN/SrlQqTsFt5Y23gXUcJ9BcZcchWyH9wKfTQbhxm1RynKN?=
 =?us-ascii?Q?iEHpC0JLbWZ0aMY/OUnPhK29FRFKPvc3Ol5r2Of0mT0o39/i5Q8HkW7uQN6q?=
 =?us-ascii?Q?gb3/ycJi3rKDPdMPpUICCDeVt3wxwv8j6HhZu/qT8YFNUyRW31ynLIyyzJMP?=
 =?us-ascii?Q?QopSypWWFIvdzgpN0BIbfRgHuXbbWyf6jdiT1Lad7FqcMha/KHQhjk5ED7tO?=
 =?us-ascii?Q?HK9ETWBbesoHXsfHeph0I1uUuwSWDoOsoQy2Y+sRNXSK1kQSw41VQuBkJcCL?=
 =?us-ascii?Q?3FAl8MyiOJdbQXdBwmRoGGejwH/4knE7aa1+GzJEkjA6irQBwFHkFEEazUaw?=
 =?us-ascii?Q?TmHkjX5qWcnk2mVBzG5O6weuwgmMBkm68KBMr0iRJXZ7OnauHEDN/cSOox7F?=
 =?us-ascii?Q?hRMvwvOVZ1dC9E5EHMxPppWmCjg5gcO3vNWXTivTU7kMyNDQsCHEVoC4rNw2?=
 =?us-ascii?Q?FBCIRJ/kAr4gAU7GKAbucCxHVkJk00i+CBlQIkwPTQ/YuwtHYH66Edh3sD+d?=
 =?us-ascii?Q?DBuDimyqMPo5O6jAGVJUzHkovgR84wd0ogY6jV24BncGyZXQiBUxJZ0CAlFg?=
 =?us-ascii?Q?dYiQ32gsN+VxtmSp5mAV0BmcHUco73cAU4seXnX/yvxjAfgT8cd+exF9Pj1V?=
 =?us-ascii?Q?yppRSAAWQ0GBSIFgTxTSlfKqmYER/2FaEVDiL7l5OwadIj0OAxsp5FYNufmj?=
 =?us-ascii?Q?lolzJyUrN/D5/lEDLA1IvwwSYK5hY02Yeq2JD+PrbHdza3lVwRLUB+82dOPu?=
 =?us-ascii?Q?jbduu0V45/AjzuIz2WZ37hqyXVtDBA92JQac24j13p1DdM1O3T9NYRnjk9k5?=
 =?us-ascii?Q?2FGf0clHDKB0vYFQaeupyb4IOvPrWw1AENqD47DgGAL8sZ+SzfuUfkcfqYg1?=
 =?us-ascii?Q?FISzqMT8QV1nIXUtU9npfXktkLVvLO8z/OUzNUBS9kTFWe02uswOyJYdbgmp?=
 =?us-ascii?Q?RL7KVZWDusMur6fOm/JPGNd3KcLRD2CkPVC432VUIDNde1ZD3rF94GntXjBN?=
 =?us-ascii?Q?BP4XbNScKa0btRwFhI9+CHc+kV7hrNxo1M9D4G30D6Ha7zlCzcIQUZS2euFZ?=
 =?us-ascii?Q?PswgQOHVC4n6Mae5/KoqDDXppFxkOBzyeeKes2uobYiscbUGhLFUAEAohjFP?=
 =?us-ascii?Q?UEscRKhAU9iPa41N8TVSpCtNFHd2DT1Jq+yoc1NrYrW4bqtAaC+jN06k8ReN?=
 =?us-ascii?Q?9qrSXdG1I49IT8OJtZvy63sZv0q9rSq0aRQj3v3FdA4yJ7yMC6S7j8+CyNNY?=
 =?us-ascii?Q?hkIg+29YFkkDRMaueg9vcTEUU0T+nlYcqpnrI2aNDU6fZMJw/Nwt+8sG50xH?=
 =?us-ascii?Q?HW7RSo8Wu44X/DS2EAvB3Ma+/Hetnppn+tKAIMvk1XRenXLUr0xyx6v5+Qos?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ba32ed-0cc0-48bf-9e97-08dc805c5b17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:55:33.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3N+KKW29yR//rHFc2ntPQDt4LmllGe9CgjIrUVGne2XkPZDkPr47qRPvKA4dX/Me23rBMUf1ng/C/bn9UCj4U4FrH0iDpZNO496XeIJw8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> interleave arithmetic XOR maps are applied during the HPA->DPA
> translation. The XOR function changes the interleave selector
> bit (aka position bit) in the HPA thereby varying which host bridge
> services an HPA. The purpose is to minimize hot spots thereby
> improving performance.

I think it is important to either detail how "interleave hot spots"
arise, or just omit that description since it is ultimately not relevant
to Linux.  I.e. the "why XOR" question is irrelevant compared to "what
happens to a end user with a kernel that does not comprehend XOR
interleave maths".

> When a device reports a DPA in events such as poison, general_media,
> and dram, the driver translates that DPA back to an HPA. Presently,
> the CXL driver translation only considers the modulo position and
> will report the wrong HPA for XOR configured CFMWS's.
> 
> Add a helper function that restores the XOR'd bits during DPA->HPA
> address translation. Plumb a root decoder callback to the new helper
> when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> let the callback be NULL - as in no extra work required.

Perhaps add a handful of sentences about the testing for this patch to
make sure the maths are now correct compared to what was there before?

> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c   |  5 +++-
>  drivers/cxl/core/region.c |  5 ++++
>  drivers/cxl/cxl.h         |  6 ++++-
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..20488e7b09ac 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  	return cxlrd->cxlsd.target[n];
>  }
>  
> +static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	int hbiw = cxlrd->cxlsd.nr_targets;
> +	u64 val;
> +	int pos;
> +
> +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> +	if (hbiw == 1 || hbiw == 3)
> +		return hpa;
> +
> +	/*
> +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> +	 * the position bit to its value before the xormap was applied at
> +	 * HPA->DPA translation.
> +	 *
> +	 * pos is the lowest set bit in an XORMAP
> +	 * val is the XORALLBITS(HPA & XORMAP)
> +	 *
> +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> +	 * as an operation that outputs a single bit by XORing all the
> +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> +	 * hweight64(). If the hamming weight is even the XOR of those
> +	 * bits results in 0, if odd the XOR result is 1.
> +	 */
> +
> +	for (int i = 0; i < cximsd->nr_maps; i++) {
> +		if (!cximsd->xormaps[i])
> +			continue;
> +		pos = __ffs(cximsd->xormaps[i]);
> +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> +	}

This looks correct to me, but so did the original broken implementation.
I would feel better about a self test either integrated into
tools/testing/cxl/, or documented / referenced in the CXL Device Driver
Writer's Guide that gives confidence that "This is the way".
