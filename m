Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771F2556F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239385; cv=fail; b=PxArdwCr8XoDx72RaT2N6Apygjo1gjUte3bGxcGBXL7f+7F7wC80MW2IeKM+q5cO78iIQJEMApyHm2aEzeQRLxlIZLNu8JZ4P+MtgTy4Z+2w7i6aRZHpZ5j0zEi08el7mvIIvcNNx0FR3KMsAm4bi3s3vi/cvOtrDUZoQLpTekU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239385; c=relaxed/simple;
	bh=NrnE9H0pDHFCZ0X8mqq+Ad8yIgqi0NxOXNLBlp9EMLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uPaTzBS+x/Giur8WO0ODWnXCoyJwI3F2FTf7ZNAdjFR4gyJJxaUzo6Nz6w4B6m2uuu0Liycmm90KPSD4zkbKTEEAh9ZMMQtdeiVALXiE4jcIfnxITRHLGO9T5TM/OvbfhPDJZzcJIuC9yseANuINlUZ2JpTwP4mEfnumNolMRSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMQVmuy2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMQVmuy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723239383; x=1754775383;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NrnE9H0pDHFCZ0X8mqq+Ad8yIgqi0NxOXNLBlp9EMLs=;
  b=YMQVmuy2yNzNDsHUKLtXnf2NnaH4l3Hb5hUpHW1QD2+DncSmkk9pDnYA
   XotwGAmQ93y7RkXqi3ckZdRN9dP/CLgGnkSdQqy1qYswdytqr0KACsFGW
   ctpH96Bjw9SanJRifIZonFD2766+XZPEjquoUHW6ouNOBeKvXt94xfiOn
   QBlhBOJRN7pKKxsJP0nVhfoRddKjwXPRIFLAPTyh3mpylgEntDia9XM4L
   ynC+sk5PoibxiVFXT85H3H++Sw5z61DbRVL+H5BbiQX2gGI+USzYNvsVZ
   MFCxqsM3XzcIu2wzYL+rGpMiG97aqb6zAJK662AoudGRPkuwgk6tsMc8H
   Q==;
X-CSE-ConnectionGUID: pJk2OyjwSxmiOO0vk7Icng==
X-CSE-MsgGUID: y2m2a1R8TXiD0966KM+3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="24332755"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="24332755"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 14:36:22 -0700
X-CSE-ConnectionGUID: 1oR9PY9PTKayqgUcudxb6Q==
X-CSE-MsgGUID: avRA9AS3TSays59NSdKMIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62527634"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 14:36:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 14:36:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 14:36:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 14:36:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 14:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjiKVmv5CDNrNh3UH/e7exnrQg4xqcfji6B3E4JXjcsFnoJyEhrrqSp/JZPelT7mQeUMq0Xecgoviaj+0HG/30g531uihRQGLG/L8aJLvXzhGlW7LxmtDsFrB2HtZRXdz/2n3sElnMQ5RbzZtv1nFf+KZRbsHlI8bTO3lRbPxc3q5CE0egEOaW2EorMPBg0qfyzLQJEUoI0wVBmGbDtnHQfYVz1rh+KW8BDZ0DPyABAqbK7NNJl8LLrXUyGMOi21w3F0Wh1XsZN4koCD+nu4e54F9zm251wTnCdGLFUBYFo+lE4y5mjgsYnFPTsYnxxox6UzvDXBUc4YpFC3chHACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxgfqs8Sf7Ddved7+FZMCLuTQOcoy8fK8rXOhDTR+J4=;
 b=mLqq/lFgfZMMANmhnkPOf375+C2+4BcEw5bbfhUeKsAU/23VzKERHxSMqfVrA5H7n2HgKR+xg/9+Wf6Sc8RyIlJYJNGo1sfpuVgv1g70vAY2DLdZaeqBL63snX23Yxa3SrrMIY8hPsyAHfEgxmHNZADdEGY0HEApl+NeHrvM+aMidJUneKBN5mNV1w/1PEYVSPFuUSlNqSrwGsoyO2OZ+Lx1TMuMqDzkZ6xcEaUjFo0N6UDplmWejiwTCRYQdmP0TOGxtQ8qoH22HTiRLF2XZKhV9EpO7x/+NHWu2nzr1qi0z1imTQYMWvk9giqNzRSSOj6BOcFD8vGl8cr+ktj2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 21:36:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 21:36:17 +0000
Date: Fri, 9 Aug 2024 14:36:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <pengfei.xu@intel.com>
CC: Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH v2 0/2] Fix get a wrong pci host bridge in
 cxl_setup_parent_dport()
Message-ID: <66b68bce7fb41_2575294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240809082750.3015641-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809082750.3015641-1-ming4.li@intel.com>
X-ClientProxiedBy: MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2bbb12-d8a1-4661-0780-08dcb8bb4cfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pzYc1DB5GFuaQNaT3R3alddPY1f7AnSK8ETDrDhd6LLi+vE1HkpB0GDs6rYZ?=
 =?us-ascii?Q?+5H9eJCbpx+NL1BPJ9gl6lv5CejGGcBZZRVpyFozeJWSBb5l6JOxG2I3W/jw?=
 =?us-ascii?Q?5KhgMsNMEj9jhvC6bnc2tFB+mJIj1oKpFSgzOW3umjj+sRkkyxWX84AxpFc8?=
 =?us-ascii?Q?D0aPjxAFmtlaQrpED+uA6wnz1IRVvgIDTbQky2bMQNc+8CdM8HgHG9RUQeZ+?=
 =?us-ascii?Q?Htvbfz1gzA6hXK3t/ivNq2f4VBwi41qRVwgQXugSjLXz6OeRxJX4mZQkB7ry?=
 =?us-ascii?Q?vCfPZkPGWnybep0fex6nBhSVYoYIJrWgkD8LEajiWTlOO/g0zIZIkYPaxfJL?=
 =?us-ascii?Q?arXIc47C+ZzKXIzx7e3yY7r1AiKguhc2/EHCbUmoQ26KAF32ZnnJCdIMCIgg?=
 =?us-ascii?Q?wwPBhp+Ja1+5PNFFrvoQriAlrLhH8w90lRRWgRbiIutCZRJzSryCYuQZ8mzf?=
 =?us-ascii?Q?puZkHthf/OYaacaSaG//7GfIxfTL8Xb0vSKzV0BGL5Dv+vElKMZN785yT8si?=
 =?us-ascii?Q?KX5O80bESNVJvRccI8hGMaULxpr5esPNk/1I08kWyZpzMjskztC6t+8R3SrJ?=
 =?us-ascii?Q?OBok2YUTDuPBesumyvQzYDAb2/Zdy1m8TA87y8El9arYFggSxPJQMzngu59m?=
 =?us-ascii?Q?K/48fWsCxiq5M6L7HHbMzl0UroBlv+P6CsqwJuS/UdkENJU4N/3bdyVlnCZd?=
 =?us-ascii?Q?AtXdZm7m9MZtQHB/rxl2Vx8ExSrcUDfTlU4E2SZ9IX/unLjwgMhhPCvHd1tI?=
 =?us-ascii?Q?7T93FVh4A3hpvGjbKpn9Co6lh/UAkcE+IF8gc5qvXwmDsogDDuStp2NMiaMC?=
 =?us-ascii?Q?rMNek7O7nhh5CvkTsalMVG9he+8q2/UQl6KTpva/VGzq9duhSdUQCrLsFV/a?=
 =?us-ascii?Q?nwFLM5CYobjDxLxOy7vMdbTLNxrtsf5Z/wvrfkyumVXJgOqElHl9T6IM0qoO?=
 =?us-ascii?Q?kmiSv9t0o9dXacIFP6AcJOrVgXBmTVbQnfKf/XX1KC9KQNdKtSv7gaa9fGgG?=
 =?us-ascii?Q?N4ychvfP1hLgIfpm3AebMrWXzlKj9zppNIgHxPonNO8LOysPNUdoC626eWNs?=
 =?us-ascii?Q?GkDPEq2dXm7HHeS8tjR0hLQLoZ9/Xk4n+LoXVPSt5qwjDRLxevXY4POlZ7p1?=
 =?us-ascii?Q?9+Xav8HWTMzYhv3OCBBZUTFJWBotvH0s5RWbQLmtG3L8LPti6BbdfaNslnsN?=
 =?us-ascii?Q?0RLfuVPUKxN2H6sI9DKCFi6m2B4WpNyUip+XP06Mbyiy8TXrh0yo1IJwbcuZ?=
 =?us-ascii?Q?LKap9DwxNIlbihZIFvOoHU7Jo7BFj1nhrTvt8p/KbSu4aWxHvQSaK8ZD3i+O?=
 =?us-ascii?Q?04w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcRBJ1z1vKBKC7vED7fYDXeuF11uXBpvPkdMiDgZ+RiSPibd+8Jcd5EtnImD?=
 =?us-ascii?Q?hUGxRyRaQrSnnt4OYHvr4wsG6AOvQB2283/yrFtdprhIKHNwnLducl6c/LPw?=
 =?us-ascii?Q?mgg8Y+2CxagBvcuMduH94yMZgRLqKu3boBq6hsdHiMEzaMzWwWoZmvA068tL?=
 =?us-ascii?Q?p04wXiRvY5nxzKWaP+QezpTENzbgaFrPDxnanoEHi2zMyde9N8UTGEvTdIxS?=
 =?us-ascii?Q?v/WjOj70JJjFgFaIKlx/ZjhfyITURYP6eidblmAcLNYJoVrG9vq5R0NSY5Bw?=
 =?us-ascii?Q?3NjAVtvsmx4PInhPRSoNg13O0SsA6RDPwpvLswjdfy24D1j5r1aWOz+ue5kb?=
 =?us-ascii?Q?8f00doui2iy0QLEKTWS0gQAV61cH1pjQ90EOhEXRUK9XhFCahCUULegm2ifT?=
 =?us-ascii?Q?UYK04JVqOsDJMcSOyuWj6seHdJ//ShMz/kC/8Uj2h7KoqNebZBAivk4+wP5z?=
 =?us-ascii?Q?wLfphTar+LNMuSqIidqAzgKRBmFWJiQYYO+K4+M39O1v1351MnIkxrWIwcMZ?=
 =?us-ascii?Q?NtSxgvG7UAroJ89HUlPHvKfluySpmI/WeNVzdwJnBuAi8HPtfVWR/ZMMhg3r?=
 =?us-ascii?Q?71G4SjHtjlGiWT94UvL+CQmdsQeWmbhC9S/iHtuvr/Xe7HQ/mBh4HlyPQEqj?=
 =?us-ascii?Q?Cz6VJyyoxfkOW5GS+kn6lXHtuxBfmWcnRvJdgBRrTzEFal+twfLY9DsrVg8m?=
 =?us-ascii?Q?x5z0QMnmC83bq98wUEHqs6JkCtayJotTUtSJaf8o//+n+kLL26t4JywBEZfq?=
 =?us-ascii?Q?ydKYJgTQiZQ1YrOQW0SkGZe8vRKuzcoxGcfq7mssdvx5paBjvegDy9SAP3xJ?=
 =?us-ascii?Q?QuHfS4hdYEgeBZkr9YD7DpTVGrTstAKYBHulWiR/VpqiVUSodIp0R9+Mus8A?=
 =?us-ascii?Q?KPvJHfhOMHX+T5FOZ93OGf8DTxuMf/7P6u+Wxyc7FqZyKrAMBq3z+DRL6Z1j?=
 =?us-ascii?Q?1gG0tSfubNbC6F/2uUPEHw8rAWTBXnAZVFGt8JkfNeR3H7SbL99SYbIVfCCd?=
 =?us-ascii?Q?jUIV46yt0Eq8sSzwClBASEY680+jK3/27qyWLSekQ7XZIDFx02j/LvoV6O+N?=
 =?us-ascii?Q?oYhNjQuY0fsTBJZgoF/+uGrza1LU7euOKr+7BF5DvUE6TeSvulBc7pPq37wo?=
 =?us-ascii?Q?Se66vaQxQQgXaPl+Z+EBBJjYCR/AxlA2Zgw2QdZkSYhhe4A3ljMt2o3qFctN?=
 =?us-ascii?Q?tCXz0yxFaLVkVKdvzNIjlTc1dL14Nc/79dAKjctIvtcDO38yR0s/4wwRABY/?=
 =?us-ascii?Q?v3qEubCeCxffdN/3RzTw1JjtAq5TIWgZlkPR6Dao3YBQj2Cz9IescI3TpK85?=
 =?us-ascii?Q?CVLIhyFKTwrCCLhGLF0U71HpHpxoNOxbcLPcR75IqyRaOftKURxGhH5E/zzI?=
 =?us-ascii?Q?JHZuefDJBfML0zKd1uuJl+2+ZAp31BttN1oYrE2onzUe6n5eBPTPat9f0c41?=
 =?us-ascii?Q?IJ5kuqotYVIqB9haKk1tk/pzQjJAKQonzHQ1neLoBte2wbdYRYdgY6uYn6Xv?=
 =?us-ascii?Q?EiTKgw/QZMTjsYaFg+odIPCXrlQValAdKDFvW2Jh5oF/U1g/qoRXROuYaShk?=
 =?us-ascii?Q?bDA2U6YrJ7mKfdZxZ/RDi1NVbDou0QCndueQXZVul7Q5Q4pg0JibjcR2h21i?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2bbb12-d8a1-4661-0780-08dcb8bb4cfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 21:36:17.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNqdzYl0iJqA0eDIgmGl+TjU20yY40BKsSnWRCI+lSfBkF1hwkRiMEm5Xlk/BLwOqpMAbCO8uuKPYaI4BJR6NfFyeUe+LNrAPHwkoPZhysg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

Li Ming wrote:
> The cxl_test unit test environment on qemu always hit below call trace
> with KASAN enabled:
> 
>  BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>  Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xea/0x150
>   print_report+0xce/0x610
>   ? kasan_complete_mode_report_info+0x40/0x200
>   kasan_report+0xcc/0x110
>   __asan_report_load1_noabort+0x18/0x20
>   cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>   cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
> 
> The root cause is that a wrong host bridge was gotten from
> dport->dport_dev in cxl_setup_parent_dport(). In
> cxl_setup_parent_dport(), it always calls
> to_pci_host_bridge(dport->dport_dev) to get a pci_host_bridge structure.
> There are two issues in the implementation:
> 
> * to_pci_host_bridge(dport->dport_dev) should be used only for RCH
>   cases, dport->dport_dev points to a pci device rather than a pci host
>   bridge in VH cases. The solution is checking if dport is in RCH mode
>   then calling to_pci_host_bridge().
>   (Patch 1)
> 
> * In cxl_test unit test environment, cxl_test will create a emulated CXL
>   topology with emulated dports, the dport_dev of a emulated dport
>   points to a platform device. to_pci_host_bridge(dport->dport_dev) also
>   gets a wrong pci host bridge in the case. The solution is implementing
>   a new wrap function called __wrap_cxl_setup_parent_dport() on cxl_test
>   side, the function will filter all emulated dports, make sure only
>   real dports can be handled by cxl_setup_parent_dport().
>   (Patch 2)
> 
> v1 link: https://lore.kernel.org/linux-cxl/ZrHR+0w3bwM1Ik8h@xpf.sh.intel.com/T/#med6200e54ec12f09fdcc04571516adda261c9561
> 
> v2:
> - Add call trace log into changelog
> - Remove 'dev_is_platform(dport->dport_dev)' checking out of cxl driver
>   scope. Check if dport is emulated in cxl_test.

I am suprised we got this far without this being a problem earlier.

For the series you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...can you also follow along with a rename, documentation, and cleanup
patch?  cxl_setup_parent_dport() tells the reader absolutely nothing
about what the function does, and that it is specifically initializing
PCI AER operation.

It should be called something like cxl_dport_init_aer(), and it should
have kernel-doc associated with it. The cleanup opportunity I see is to
consolidate the ->native_aer check for the cxl_rcrb_to_aer() and
cxl_disable_rch_root_ints() into one location. It is a bit silly that
cxl_disable_rch_root_ints() needs to check if dport->regs.dport_aer was
initialized when it was just setup a few lines above. I.e. there are
just too many helper functions and it all could be consolidated in a
bigger cxl_dport_init_aer() function.

> 
> Li Ming (2):
>   cxl/pci: Get AER capability address from RCRB only for RCH dport
>   cxl/test: Skip cxl_setup_parent_dport() for emulated dports

This is the right thing to do whenever possible. The usage of
dev_is_platform() only makes sense for scenarios where a function is
called by the cxl_core that needs to avoid getting confused by cxl_test.

In this case, since cxl_mem is making the call to the exported
cxl_setup_parent_dport() symbol, then mocking it for cxl_test is
appropriate.
