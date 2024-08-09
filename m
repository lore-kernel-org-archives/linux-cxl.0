Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5F39FD6
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230948; cv=fail; b=rdElVVlc6aoYRRU/k/wKGNdHtA3iPRfz3zxmBCD74gfF8MdDapbZQyCjiGYA+tT0nmSy3UARmZr1DUcyOEWCMchtsegZ/CJVSIXeLpODOLCqhpDGFBDFgIj+tuK4ZTZs8eMwqdPHOUGeAnMLSaDLi2hLMoaBXAwLmcFh03jDO4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230948; c=relaxed/simple;
	bh=S9/NsIWYUyoKv8YZrWzz2jG7/vCOql8/jO2OGNxtbro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X122Rw+eIW0LEB54bxPw9o7jP2JTmw0nrZN3mUXpiDN82ErDhOwLp9TzzsrdN1n6PMscVu93IRnSPptpPhStyG7HEM+rcE+bi754MtzsGm1FJN3ERIDF1RinBYGpG3hiDfqi3gkgOZQXOhr5JP9mmGT5K6H+M2Mdwz8vr18OXXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9J2ezgo; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9J2ezgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723230947; x=1754766947;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S9/NsIWYUyoKv8YZrWzz2jG7/vCOql8/jO2OGNxtbro=;
  b=K9J2ezgoW/0kID3rXnGEP9SvMHDaNVAlxcOjZyETYSc1niZ04zexIozi
   4+l/au9pv/eslpfVZwrYTAjYISJu22HpR6taRVXImvwxxztm3p2omrMYE
   KLjp6pMIkIy5PO3757X11Xmw/JIqMWOBAZy7Oc6bSJTcheQuf9qw/CibI
   1W6Jk5JHyNcFwbwAdoeFF5OM1AsAIlRL8q7MrYh0o5ApcK2MbZmgEifwR
   yco6s6sSCbeQlfNqocbfErYpTMI23q05CaudzDdOUXVHcGR8+aSRjp1Ay
   bn0UD0o/EEWROO8rRgfLzh55UdOptXBqP4ROpA5VdV57opDRHZ+yf1uZa
   g==;
X-CSE-ConnectionGUID: MVVSn7kuQIKUtrn2HYSVdQ==
X-CSE-MsgGUID: rkvPBMXhQeetF25l6FtIzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="46823339"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="46823339"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:15:46 -0700
X-CSE-ConnectionGUID: LXz8AfNqR4mRON/LHkIWZg==
X-CSE-MsgGUID: E2Tv2nlAThm2bP77VQGK1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="80882004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:15:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:15:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:15:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/TpH4MZYe0uAlBQejsfqY8dePX8I7bSNze7bQnCIOwnBYJj1HEuK5wNPrDshJTZrPBKKlLg6eUSs7K4Nb8u5zeF2znHFQeNCjt7MRuaUKQNPSEi4+psS69PMmDuMpN/o5PHzuLbQetpMhhMoULJ9nCqzOvWiAjlzRBlehVDxgcXV+81Sd1UbyE7H2v1lMBSwV6cjo7tev3GNx6rYxV8HrwZeqUp7LcjpC8t70aIW/PczbTqq/L3Ec0CZ+k0oONCJJqB0Lg26A0fvGZJsZT6MG1EYt78dia9W1QFUgEzsWcv+1JZOIvLOSwrQScdRPai6NZpFbq0YeCG7D+9uNfHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9/NsIWYUyoKv8YZrWzz2jG7/vCOql8/jO2OGNxtbro=;
 b=kyovlYuAHo1ZyVX6Kfe/C3vou2EPeYAFtAVyZRiRjiM1IG5lvC0mUyxAXRhpQnX38WACYygIyW2/XDPfC9nUUatlXmvo3mwkb52uj2Fa8SOIZCZ1Ru4bvnwGOQpx2a/MXlZ4kCLKmKumc5rhYa6ZnzI5ZqQLF+pAr1zYxHv0udEMzS5ARJcmcAU5SSwfR2na4EQBRm1It6CwHZmDLyH19KHqU23/FoM6nA76o8R+SlIMVb+9hPwqPwZcgWuHgIFzEixYRAD+v1jByTB2VcmfALbVhgFpHxMMTs/UCJWrAkvkw+bTBEDJgPyJyi5oSXTgBFI7ZYJqhV/c4GvIFTIWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Fri, 9 Aug
 2024 19:15:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 19:15:43 +0000
Date: Fri, 9 Aug 2024 12:15:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>, <yanfei.xu@intel.com>
Subject: Re: [v2 4/4] cxl/pci: Simplify the code logic of cxl_hdm_decode_init
Message-ID: <66b66adc74114_257529420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-5-yanfei.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809093442.646545-5-yanfei.xu@intel.com>
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: de40dfea-d5ac-46f2-b524-08dcb8a7aa1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JwNDPtgKCYmOE0oJG/diGKCf9wyMBnrn7BFTZE1/y7YakGcenKS42i+moqHw?=
 =?us-ascii?Q?seYa8GAVYXbWkQFetUHD+G73J9OwvmyT6GIdL7RBJrvMw9sg3ClM3mnuDYY9?=
 =?us-ascii?Q?S6Hr3q4SipKLtbqxSPy9y2xdutMXt3Z4cLLjFI0qnCv4cdWIPyJbKl8CiSec?=
 =?us-ascii?Q?YMxA3+PCy+4BW2CODthJ/mgU/6E6ODpmddzu27y80ycOjeIoglTT8+GPdIPA?=
 =?us-ascii?Q?XFnyM+SHlgV6GQyIZSHrtfLmsPg6Ty3hu7Do8nLTHKeDsQvkI7gSDmRj4PKI?=
 =?us-ascii?Q?xIm0q8rld/Yz+N3BxDlFTiLSDIZyE41kNScj60dmoct6n/zD/E3dkt9/nzLA?=
 =?us-ascii?Q?aQ1dTfRsfwisebzVyX/viZLoe40l8q+B2Ctp4BXLRbQZiDrp5ltVXhHSBrvW?=
 =?us-ascii?Q?Sf3fJ5U9zzg4FU+rZZoQw7tTiJfiWtSy/6O7CtpkZRwOHPFxFmN5Dv9ZoM1H?=
 =?us-ascii?Q?VUXVTA+KW8VLPGIUMRNdP2lSXsMca2z2HHTRutGUqo/0ALR0feTYvbhnHp4O?=
 =?us-ascii?Q?kj1wh+VNUnjKMRR7bMYNx+C3JI3foZEWmkFH5BFC6HDGKvWqbR8UX6LKgh13?=
 =?us-ascii?Q?L5HidBG5atwQP3mZsUBrhpd9hruOnCMTJLR/GKVZ5WhIREVNTIVRmDFn7ZWk?=
 =?us-ascii?Q?kJIGKX0EwdRqZbFgA7pUsSD//29dz1DhxXK68ForhgezsUiwvXERWBevIs5q?=
 =?us-ascii?Q?qE8OL4PpbMNmSBEkywiwWVuun4sGZ6lwMm61nizKgxgc23d60B+oXVxMR1aO?=
 =?us-ascii?Q?M+jK8oRLw/jd0D8rDhNNeOw75Pzp77wGeoO2Or21lvX46XKNkQ/8TcQ5rL2d?=
 =?us-ascii?Q?9KKNbznkWCIL+9V9AuFj9RzwGwbtVm8RhMxmyzO1EaMcYSkfS4PLpw1/HROT?=
 =?us-ascii?Q?/1ziz+uXl51ep3a4FDiQgrk92VVNCPXUALcTUo1H3XVvuUU6YzFf5GZ/NBBE?=
 =?us-ascii?Q?blh2TtY2qgn4eYWebkdtuOsU+JLdzH0TG+xvwioFaoKRK4OhuueGZsLm09lh?=
 =?us-ascii?Q?ovYhyzhSluR4l3GZ6gCTo/iHubdlzOWN+djMtt3dIa3k9OHAhsOGYfKZIftp?=
 =?us-ascii?Q?hCpIktondO4MMKlNcDk1+E7Zu47YnWDXrg3QfSgMsPk/cFJgRlWQ0E+pQSPm?=
 =?us-ascii?Q?+64VVradI/GJerVdL67kiYASf+LhiJgSVboH7wZ53KdmMIQKeVqCbVoMxBcL?=
 =?us-ascii?Q?PggJPWo9sxIpBkmTQQjvJ0K0XvFusq2eNXwASUBgUnZ/NZWnX70VQ2VheLFs?=
 =?us-ascii?Q?sOHetIs5Jz6XdV930Y4jgAl9aAJTCuakOFExXndY1JepHQOqiYJwp1C3N6AD?=
 =?us-ascii?Q?seA2hgHblVloe3L0ljYmPXAUAY62FijnSoZJrpqJjh3SCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AksdLlgOZp2xT6/rXMu3lsdPjeg5UuFV8iCZu6ouie8RNUm3YpzPlRlmy3ey?=
 =?us-ascii?Q?EmPECw7fQPP3DxjMCXilujYJkRoURM8RIXyEoHQZ/sU8VUUf9n5Y7v7AWKgW?=
 =?us-ascii?Q?g4L9OhyWb1tvgutZD8Mm7+ZxZrWqpUitbYrNO0WMtEmFk2U3wtAIC0c+eF6a?=
 =?us-ascii?Q?Je+koLsTF22+M1/x65MeNVCQpJfUXpAWjxI/6aR50kkDvvR4cfx6RTe4ktBo?=
 =?us-ascii?Q?dLSplL+XNSG9n+pEZIwYLGEkZosIhnoDqWS297kgXwRpVP0ZkVNufHSucw20?=
 =?us-ascii?Q?M309Djtb3q3rweEJN4Jy/wk1wj7bO8hyYdUqMFO/xJ8eBSoGi0c2uIsqRuPI?=
 =?us-ascii?Q?Aol6pVPNXr6SitonbkU2jSv0unAkCVn+j2pUTENYQ6/eWCS3Wj4WFddlPts8?=
 =?us-ascii?Q?jjCtBARjPGluvvi3FPn+HoJ8tGW6OQhEi3igikPQFtuzzrr1Os6NVE5Y3BrM?=
 =?us-ascii?Q?qdCzxVRvPoqog+buNMvjaAYhkuEpjM6MopPMust89SwsB2D/BLI4z2ruj/8l?=
 =?us-ascii?Q?bEPBhCjdMO0gRcbV1aaYffJfFkEr8nWhUijumo+RYMjHdkEfFwJj9mu4GFKn?=
 =?us-ascii?Q?Q9IiTO+YLx0aJe30eFkS9wvkeuAEPaMxbfOeosJ6jWe16f0pskMpRjlLrMkP?=
 =?us-ascii?Q?F11JxHfef9pehFLO62m9LoLLYEiyBrUNCNhxuGMWw48pisstoZe7vgePWyr8?=
 =?us-ascii?Q?t71bWIH7oZgp9tbZ5tw2l5CgZFXzAX9SGQx/ewIwlVi87xDDCHW+cTHXOD0Q?=
 =?us-ascii?Q?HTm482ANrm1YAzO2dBn4BYFqiltXYwfsEtZvrmqn6V8VCUv3TvgROHbC43YY?=
 =?us-ascii?Q?aZjCEvw/1V9wWwcoKoVqnzOyy3mOkUX+oBj1dsrxL17OjW7DnFu8he8Kt1fO?=
 =?us-ascii?Q?ST1bj1dLSeGx8RF00MxS4mFHo2v4Ru3aE0GAdggyx3KtAHeOYFRffncy1Ypd?=
 =?us-ascii?Q?PpY8jzOxtvCNmxyEbW+pZ9H4As4BV8XTwKGMcAl3Y3bgCltZOi/PYJXvaigv?=
 =?us-ascii?Q?ii3LW5KEbB4YNNtv1MPuQceG1Y+UIvM6hypvDKD1tEvA5b38k4zYxC03Q8T1?=
 =?us-ascii?Q?8yoNCwhgJlRxF2LkE9RtuFisdfAW30QuJkbV+X9sGRkrMd9ajFiRbEG8YDlm?=
 =?us-ascii?Q?cDr9TKsWOajZm6LFbQJDNvdTRyjQt2oK1d4GYb8XTq4MBJkpEJ8zZmAlMB3Y?=
 =?us-ascii?Q?eHKkMgrScUtxhgE0uID44ZUHcdiHGxEAkNzYGwxrkSK6G0fgrVLSEL5qo9pc?=
 =?us-ascii?Q?cTCQUH5OfmzukxY5etDPU+f3EWoQhrIfBZIRH9gixah2h1RLu2H4avcJHmBe?=
 =?us-ascii?Q?5T5TxHFn5LGkAgDYw26ZvQbVx1pCcQPwxXqQHBELbNSed46IRAwBW7cTLES5?=
 =?us-ascii?Q?srJpTLo+x6/8YaosM9DDMBP8HQpfytQV9heGXjvcEnRxHazTygZH3ocZGzrK?=
 =?us-ascii?Q?2PC42pLXfBQt/HMITCgGgS01U8iUqCXGUMbJqLwp9NHDlUyoG0s8RsPae72K?=
 =?us-ascii?Q?pMm5MlesugSQqLIR3Yo1ioHNBIGQKQp3qAYw7RH1VnT0G4RKOjcj0ChjK/W9?=
 =?us-ascii?Q?GIrUMy2hESglqQTW5MQp+GrQJdaWm7tZ1f+Q+ZXJS7PfLnghEruciBO1EygO?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de40dfea-d5ac-46f2-b524-08dcb8a7aa1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:15:43.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkB0Gu/2hjA0orJXvuGCwahRaMaVX+Ft3FtdMq5scVxgBuTUXipLWMiiAHhps7zQJSaUq+ctI1llps1T+yyBigith1Wdtga3hBg1WQgDu2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com

Yanfei Xu wrote:
> When HDM decoders exist but is not enabled, the cases can be divided into
> two categories: DVSEC range enabled and not enabled. Extract the check of
> mem_enabled out to improve code readability. No functional change.

I am not convinced that this is clear win, and that there is no
functional change.
