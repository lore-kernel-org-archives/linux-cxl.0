Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC91B947
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040752; cv=fail; b=E2Ls76llAsbkwgpj50DIdwYrgiozfMZaZ1jwQGRBrSi8vrSmgPN/NfwLjlbzGZRo8ThjqM+dVZUCEsKF2Y/KQ30cPY0DBH+DGkHD/mSo5dD6HKdU9TFzkvP4NhpaQEewvoHsY+zbYaSN6AQ9fZB7rpZ/MkgVqfMJ+onnJE9u6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040752; c=relaxed/simple;
	bh=wHXaSeei97521aQmmAmNa/N0GNOGAvAECtQeJ/1ZvTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GByBz1g0LxHHDBbKx0ZrhGZSp86VwYUDoPQ83S8tn63V8kKyLriYb2Fbnto89Y+iyBPhh6+/MvBTUEBJlekE8H1UviPjyGfgmE71kBmSxY48KDIEGI/z3rRqNKAoUiG7FOO+bOWGRWurDMTLEvq5VaCHg6mSokefeIJHvTKjPSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On1KcbnJ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On1KcbnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717040751; x=1748576751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wHXaSeei97521aQmmAmNa/N0GNOGAvAECtQeJ/1ZvTU=;
  b=On1KcbnJyjnQrt9xsZUAXyAn+/DG7D6+qfGeEb2sNE6glCZWOf9aEQhE
   cr0OFwrYBcgYWlLNSoH4j9TO5S2xVd76gaxcmP0eqpz7RWjwLWkuA2/ik
   n37xVkXxM1iWgQMfZxcoaTPXKlPX+Ty7QBgj3LAZ4BlCCeUm3mCgpqO7G
   N8TYwR/ggcHUHWpgCX2KJscQUM/tV9FnDX7h5N93pGWt96oTHlOy0b5bO
   Ju8yUTXYYSqxUs+MwIXVlKwdHMGdSOnBo3l73ON9Pbm3ajKkVoRBrYhfm
   H2uXpOQZoWyh9tzNQioUXW7qP5f2U41qjoSTLAAtX5dBa4glzTudvlf2+
   g==;
X-CSE-ConnectionGUID: ugNKXe8kQryy/nmy8yZ+Kg==
X-CSE-MsgGUID: MezfKldbSFiZ3BfKbwNVkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13682455"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13682455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:45:47 -0700
X-CSE-ConnectionGUID: sNzPCQPVT7STYXCqwJCJ5Q==
X-CSE-MsgGUID: Wqseswm2Sx2U6NoZMfGq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66523634"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 20:45:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 20:45:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 20:45:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 20:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXOtuORB6KpuKj13zekq5McfGB2Fodl7ATzNI50ZaBVjswgq1HRDW4c/Vo9iBkXE4Q5zAW9vihpxYi8UaLwyf/Ou6P7W37LC+t7BdV59o5k9YkBAdH64GPd6QG8Ib2vm9Jff/u6L0u6ZRiAOOuGpyPvK942kJuDdhTgH4uCWgsLR+3XKnTC/6LYMy4cVZy11wCtVKKdYvYwRAuy81Adr85BASUpyJHyzXomY2sEuNP8SJz506O0zHBiG2Bl1GfItdgB0b2U3hsxpN9raMM8lRlwOOxdf9qq1wXpZ6NPA+A1FF7F/1YbUAC6glgMbBm9NC63WrLgI0TumnLNcMdiUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3oM+wpFnRgrmqdSA3NeK8T6IjId+DSLhPugX6AB2cc=;
 b=hMUKto4fJVrydkJRlXEtP738Vih9tJVMWU/C/ijJX+ykohq/8uBvDF7Mj0rEUqgXUvmpXzz+OE+fP/CNAiziW2kH9d7/7AVUVxzrKO45G62Y0gh2cLJh0ElQ1ZPg0zJIsZbATM7vRLLUo8Nu3ZHnwbooqS8YSyim62kd4/UPrglJY7pgDYRIvEABb4yc6xu/4yo/OHeFYUMDeNaCXMgF1aYJWAJTmFQMbQrkAkdcAt1jXSdSKzsyTunKma4HJyY0JaSJv3TLLl+WpNpDmxNivN1V9EhZ6MY71hLgeInl5WwM2G/pJYa4qT0gXl2rCoRLtYkSgQNF75R6Jwo1+WJiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 03:45:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 03:45:41 +0000
Date: Wed, 29 May 2024 20:45:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] cxl/core: Rename cxl_trace_hpa() to
 cxl_translate()
Message-ID: <6657f66385fa_6ec329442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <27686c91cf4f8b09991534708f6ad2dfc2443af1.1715192606.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27686c91cf4f8b09991534708f6ad2dfc2443af1.1715192606.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c224a40-9795-4a98-832e-08dc805afa73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y7yH6S7wmgP4bOpGQsMmpZ//Lx+D8zH+2B+GNHE4INIQyAxezT8hufbqcFk1?=
 =?us-ascii?Q?APuH+GAW6fQz/uYgXRVIPyz9yhNrP+MwC02hs0rzCLFze8lKYCNUtZUnxl/U?=
 =?us-ascii?Q?vKIZrRznsdQP1c25U9zPzmP+PM/V7+bAiNzMNfQN/LYef8VJCKunI5ZRQTwv?=
 =?us-ascii?Q?Ua8Pbl6ePIPx8BuN5e+jYgPOKxjL8UvEHsnWyZJEK/D3iEPYOhwk5KQtbPoe?=
 =?us-ascii?Q?t8KxdLI99y5ZW4SvUOzpPTz53iIJ2vSx2/VHinNqJNW64w5OuzfgVjKgphvp?=
 =?us-ascii?Q?+IfOUuaUIfDPktMOC2jcLoUQlNlSewv2r8x8r8/KE1+A0oXgszfOqEgvZqef?=
 =?us-ascii?Q?qvitt3g3lo4Jb7BxRTCVecmdJ150DOvADV66zRg4oz9pa95r40NYQ6bJl7qg?=
 =?us-ascii?Q?7gmhl28lZlX9SBZATOPbIzwb0l2R3LaukhwxixCPN/LL4cgNevrQp1cedV8f?=
 =?us-ascii?Q?fwgWT0P3bOD4HVDZbXRQjcXnhJYZq+K/EDlCLpj9uZWylPP56Qpbc9VX1Nqr?=
 =?us-ascii?Q?yQ3RKPui68Hl+kg1zw9XpXd+sfSxuMO3kHyaYmfLJMqEgSEl5+6kIdCGOS3j?=
 =?us-ascii?Q?GJqKuTGNuRYjnnJ8nav14ZcQnXiZBdWdNITTLzqqgnPR20ujzv+q01I4ZIyJ?=
 =?us-ascii?Q?aHuT8OfmAuf3oK86Z8Vi6+ts3Qg2rAsCpXFHX/yx5LXKy2OPELDGD7IbkNeV?=
 =?us-ascii?Q?i/ywfufv0Gd//dUYY7wl7VWdCp5zCnSCBy/cZFn98xIPzSg/f1ClVOIvDJ0H?=
 =?us-ascii?Q?DX0p46wTeoJxJwJgOd47xB81u0qZKBZqc8ioW7ZmVx4cR8bma+s4pnNADH0j?=
 =?us-ascii?Q?cDvS+DtF6Re8HDj/wpD2Ktfe2sQ7S1qcEtjqWlPgRnPFXbt+/q4Fsf1F9TKJ?=
 =?us-ascii?Q?0gJLNFJN48XVsEyWCAMNVttJqtOzFenw3sl5HAEncnGWzN3+WBtV7Oi4P06f?=
 =?us-ascii?Q?0LJYW2NAhMx43zFW1K++CK86voix/KprQKtmZjDPxgsfuFE/GnegYReskOP7?=
 =?us-ascii?Q?BtMtyRxV5h8PVLynk8DTitKNJx16KfdvimqNmfdWKew5z8WeijfS3RR6EO4S?=
 =?us-ascii?Q?FiWkc/sqYN0ruC1Wffuu1T683Y7NXman1yBj3xvUnYxuW1RrageMWQzMuAVH?=
 =?us-ascii?Q?ZI5q2gq3Yl02SAtoFAIma1smpgr4mF1FF50N74ROlSJHztQ/pQeHZu/ip5EN?=
 =?us-ascii?Q?H4FhxsQ6zmE76DQaz0swgMIDx2j9GHM65A155pHODfxlpS9SWgNlCLjvum10?=
 =?us-ascii?Q?w2SLe3emnizrpU63bdHnfhJrpalQ0m9ga6Ft/8AsJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LMejVS8RUCEvco7yYfUJNLTTASAu0ip/IXcH5Esp5YeuMF6a1wSdpi5Jie6Q?=
 =?us-ascii?Q?R+WAZC8nlUdNnhB7/UuBHlm/Yzg4r0aTIZiRftfWA/JDm8sYYLQ7v6qPnnCt?=
 =?us-ascii?Q?5aQKAAP532n1cPO4/m/j5tf/bVMRTa6aN/oNAhJlF4S+YiYOZLXBFAPmqj1w?=
 =?us-ascii?Q?owegsg+yv9qJzminPyK9e9Pcvc70dAk4sALt2qjiK5FyBm85YSQWsQ/cXRqs?=
 =?us-ascii?Q?wWz8+CD46pevKOWPJsEYGmw0DFKPDIbKhy76LOJnSuBQt9c/1wrDnlvMA7/I?=
 =?us-ascii?Q?Sx8IQ+acRipgee3Zw9d/Wdi+6sH1VBDhNK5sfYQprsDdWAlr1eZAVlVOrNue?=
 =?us-ascii?Q?IFllfqPfei+KH9pYRUzHwO+Q5eVrFCFeocQhghOaKioZoXYk2mN9Whw1TUtq?=
 =?us-ascii?Q?1I+u0LAhqsLoSzD/OoWaJTHBD5qpLR14bTIRV/TYQesd0p7gAOWYzCb6cjbd?=
 =?us-ascii?Q?0/SWRy7R6RpQauixKUT90V5NpMZnR6xLANuea7dwFTMEsMHFlpyhm986oBlu?=
 =?us-ascii?Q?peoNjLlstheTB4hFrClW1DRHf6+BtqDycd6iCyFD4LtpAc1IC0ZIqISTGWtJ?=
 =?us-ascii?Q?eVLbM+8ccJjf3rsXqPc7zdxXjXpgtDRMA6cc4w0VbyR9Txd50NHsAKmKcw/u?=
 =?us-ascii?Q?W8L12eA+Gdp1dWMtTgtbH79lqJwAR2ryScMnFqz8mEO8ZbVXWbL1dW1wTfNC?=
 =?us-ascii?Q?KxbFFWqFtCOuC1q9t8vUj5v5uAj8GCIwcbuH0yxZoLCZ8DvFQDdn1Z3oWbo6?=
 =?us-ascii?Q?gAC2FuSfn93z+MZZfdiB75ECXmQ0yU92K4JvzQZcjZNG0Aplgv9XARiV5MB+?=
 =?us-ascii?Q?6s3M0ZJQDl0MFZShzCm6FTduaYxMOrI/dZjppZ+FP5XfCG1Kd9Y+fwWsh1g8?=
 =?us-ascii?Q?SkHrINWe8yHcq1BeqZi5KFjGL8ESg38UMuTRVuFH0GiM5rylOTWciELeFeUP?=
 =?us-ascii?Q?n4p55CG0lcKOrXc4pKNXD/rahwyjCgE3VBNjH0Ph+HyHuvlsP28xQXMT8SA5?=
 =?us-ascii?Q?vhtC0JMUQdK2x05sCClsvRa0AqFsQvbEGRd8+KomESN6gjZtMrw7RyVrG/Uh?=
 =?us-ascii?Q?xCsaL2lHu6HumhLw1TlnRVP7cVpURkvuClTeJMsDEeSMU4SrglutYA/o9ws3?=
 =?us-ascii?Q?QnlZpEEdvt8y3c1vg5hOc3ObhbKAg52m2v/EVAN8K9skS4aKgq7TmBvaRMNt?=
 =?us-ascii?Q?2gKZhiNvImsUE6maYc3j7FgN5RCBrwPUq+U7+8pCuDXG/UCKr27H/9tI5Nfv?=
 =?us-ascii?Q?2IetDK/CEZAAs52ByX3qCyYnASweQAnmLM1K7YQvZ3/4wylF5CysAoG8KzF/?=
 =?us-ascii?Q?r33t9gNvF3mBFSRc9WGLQ7z1BHjJ6oxKD1BYXR1eEtJT40WIJVn5F0lcUdJ9?=
 =?us-ascii?Q?XLCWBAqEH5GQDJp6QzLUcvlEPik+sZtl99b2ouut4LcnQ9qDD6jIL5BPltw8?=
 =?us-ascii?Q?Natb9eYGEWijqiPAk9rwYAkPZe2dtdT9VZ9cy5HCFqK9dq+t9qUQA/9ygiIn?=
 =?us-ascii?Q?yhELY8pU68E8OxrSxN6gy1rTPRQZMaC2SA1f8GdKfqxyx8lEMZFgF+QbwXP8?=
 =?us-ascii?Q?qE2o3oGVIdLh03W85cZaBOmXZdkSMfuMbvCN6m5UMgk79jyJpJgB/NUBixAG?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c224a40-9795-4a98-832e-08dc805afa73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:45:41.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JVfUlbGx2G7X1ml3sY6mCFZ+w62FyMl6IQqQ+kkuUJv9S5KTIebs7yomRNkq+VjnXKZXPpSNhMMVw4idIUUXYrlK5rqdauESGQFmA/3nbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
> addresses, the work it performs is a translation (dpa->hpa), not a
> trace. Rename it. Since this is the only translate work in CXL,
> drop the _hpa suffix in the rename.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
