Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3919B3EE
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787697; cv=fail; b=qaK1JlBarBEPjY4PQaTykm+c6Jmn1gWF2g0v2u0ePSIUsXJvDn3ACJd9E90Q7eu8MaPKQKk7uKWr4/QpIWdTnMCpCD8aisMJFyicKbnaJ/Cv+C9bhzRxEBPX2QKx+aH5+NTA2OYAZ5qcZPvduC1FSqxeicgNCsPUmp9U3dD7pOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787697; c=relaxed/simple;
	bh=Fyin40E2AV3EXrg7gKsDlylTkbzCq9SlPtpWvS7aq+c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FwQA5WupOrWZWifkwEvD9g00nVVhI+vNKxioY3usTxJ85qOocnzxDkgOkEQh82FWsios2u+xdikqgetV/vMYXGmrmKtRcW5iJR24OyrtDVH+xrHdGf54FQz1s+ttL3n/Thdqg/dil+0GWe5MyDIxzdrbsGSIUNwbcHUKGWoF/Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D87/67Iz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D87/67Iz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733787696; x=1765323696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fyin40E2AV3EXrg7gKsDlylTkbzCq9SlPtpWvS7aq+c=;
  b=D87/67Izbb6S2R5Wl+mTpF6LavrAYln0FvmhzUwgo9YVMxC/xZgF0ikV
   Y6K9i51NaclbWWrzVkMzM3zmRVVWezrkbLcfawuuAZ59bn3NGAha0V+bE
   NEvCkZfmD8A0RRv21JHZ5+IvRZsYWfthHcr/beilJWSUb7px6X7YGNEn3
   TZ4yhyzz48du3W//rA65Kpwdg7AY3bcEVaz5Opja145K4EXYZuY+hkGgL
   90sn3ORS8nPIsY6+5RL1MqzD3vksFNKFQ0nntPhzS7oYSdkechlSAXrAf
   tFLzSNp5ONY/619Pw/PEsgplMwmOP+3KEjIPOMABwvFyftNU7G1sIF4DO
   A==;
X-CSE-ConnectionGUID: 1iriD+9/R8aygkbvQEnpOg==
X-CSE-MsgGUID: BzsMPSxiRwu3ImNq9s9Vnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45510201"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="45510201"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 15:41:35 -0800
X-CSE-ConnectionGUID: QvQIKL5kRFecI1eC1Y4wCg==
X-CSE-MsgGUID: IODLKYXzTUG0dyTDItwNXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100037656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 15:41:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 15:41:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 15:41:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 15:41:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejcZEm0I3cQsex5AIn/jZsRBqL+JOuAvnNtuZ6bdZkio7ol5hi47a3UCT129/bHt9yqNcw6tZCtGB+CfuKB4tforWCQnwmAHerUCWELLmZ8BFHvLIQcMjkO50mtOCAZ4BURga49DYFp9rgXvdSqvIeNB4E7VS2uudQqIzsz4Ib9EamZdH4Xo+IT4vrn+a5zc7U9mKqzKAHVdgGT2PYUM2AlrcpgeG8BlOy7w2mScD4m47GQwM6jLalQSfarNtV56NWkHSkUtl6fgqL0tLGh0GREBn55ydgdJmJH2e5e35N4vgOYTEL5tEb+m3gaJs0MEMqB5CVx3EwwNA06OOLeltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjuLCCHMHF0twDVRLjAqi0epqtYmbkiMT/PcXAK1JvA=;
 b=lCQsyURYxeobObatfkpDHVHL+q/INGsOup3judETOaL/t3wERLP+TR0yi5lkD/iD5Mzs5bAg2dBYLemJEdymeJIWXXOhktMn+vZL8KJZsDBwYAOCzPxCY6QS5aMyXhHTgCkdUGEYFus+X4CMA46sInwxPsECyQ0Vj2Ch1TcyvQFotrALDnPvSA/+MlE9qHnyP7+yFGsaqIWH/MC90qVx2mBjU/fZjgMW3USmPsiGHLCBj4sC2gQiYuJPY18qxgj1E2uupY/EdFh9wO5gEpvrsy1/eLyb5mDaKRPgXSR4YrKn3idS+vz0LY1+kwUd+jwiI3swP9gJV58tmJQ0StoC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by SA3PR11MB8048.namprd11.prod.outlook.com (2603:10b6:806:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 23:41:32 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:41:32 +0000
Date: Mon, 9 Dec 2024 17:41:29 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@intel.com>, <linux-cxl@vger.kernel.org>
Subject: CXL Deadlock in 6.13
Message-ID: <67578028f3ced_18523729431@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|SA3PR11MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fb0155-5d68-426b-8521-08dd18ab028a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NPQfYI4nJiz7eIQqlNxmOLJKO5GgsB/XULBrNPWOpaweJmeYGvXqzD8jvX56?=
 =?us-ascii?Q?L7qOn4jcz64M2/reVrwifVd+Vl9tgbl+xNPexXjbmnXHKqMT20+kquEVi1gy?=
 =?us-ascii?Q?0TYlWLnYx0y551xQRRbKfY9YabuXitNqPKXqLL25uoz8rjJJnIsT3e7or/ln?=
 =?us-ascii?Q?Vow9j8JhDmQdAeyzCdqMAH7qIKRnFXCzRra0BrQ8+o+/VU+782nEfBj+kdcb?=
 =?us-ascii?Q?7ruYMXgqXOLdxz/mgmYS83aVa717tXIr2/4QFwSqTcEiDozJpqATpfFNDd3K?=
 =?us-ascii?Q?jdQwPhV+zZZt2yHQ0Wi96BkCA09qcosj1UbIZkldU3LUXEJlkBvXgJoKeffC?=
 =?us-ascii?Q?UfWvhnQKD8V77360b/SDErdwTwcEG8cSnhozxQlcQEQKc7bMzwD5u6TF0FkE?=
 =?us-ascii?Q?njh6LFoEMAeYsxnzeqptuCAb4arYpTGSEOWsiHFeRys+BX5K82MnVwJa+ip3?=
 =?us-ascii?Q?q+qS4FpAvtHq1PMXMMJMsNPKds27SzCdH/E5ON+I1u9ctLg6w/IDoL7xcvfv?=
 =?us-ascii?Q?wnC7dZljo+2nV3GWc3M6iKyTac8kL5ct37jU4Z5a9IeTgNJYkEiv4UAg1qJZ?=
 =?us-ascii?Q?eKKC+Gte9ecW7vwU1SHfQkIaP/Who3VRlVDA5HtmGlvsLtr7fCRYMe/KPGCs?=
 =?us-ascii?Q?cphUyC74q6TCWUDzlbCHM97VhF7BKaSBV6rAHUteRdxw7oEg5x37xcLbsnYA?=
 =?us-ascii?Q?91nfSe0ufN13js037ZcFc9foU60Aw36MwXSOOPdQlAc16N4HH/a1k9E8rBx1?=
 =?us-ascii?Q?GlS27K1qycvmVGuPVGi/Kx1lcCN7XfUe6g1c4SZiBAmJt3i+d8mHRrqDVRiU?=
 =?us-ascii?Q?2m7c40uplClF45dtjsARmqbgxsc973JeB7FCr/munMbhuiYB01GBVRm+++Ky?=
 =?us-ascii?Q?bWbEIljJtAUe1D7qxJ0qTXVoOBqR+cI5Sd3LfW4+81fVjdMLvnTuMzcl18S5?=
 =?us-ascii?Q?Ap2ybSAl428oqivOsB2/k7sBGf2wwZ8HebYPXkzo5e+Kyu5NG0e99TgoGByW?=
 =?us-ascii?Q?pDxXp8OFaxMwfcsMRVulX8FZ/EfEU7MrcL8R3QCfY7wqYSnwlbIPPrZxBZS6?=
 =?us-ascii?Q?ZEU5wDb8RgTMVDF7uf2Wi3+Gb3dh/2xTJnmOqVLCNJVYjUjPvcMaDGyD+rk1?=
 =?us-ascii?Q?A2OwDIFBa4u2rLYfdKtazKi9ntOlDl4MhdnMcnlt9IV8ADvD+AAKDGMRPY/8?=
 =?us-ascii?Q?bdvVNUvliieuUcaEQx21UKjAz6z/jbbQ2ts97A1eGS4NW1XAVdgCB87nGeq3?=
 =?us-ascii?Q?w+AzvmC8+HEsOKHMrZBZmkA288Ma/w42ib81tBr/kZ6a5P1d9wmuhLIPgqLl?=
 =?us-ascii?Q?9B9NXmfonmCdhiLPIvoO1nIwxlN+cP5ZLA/6mhmSKOoIAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/boPYFEl/0YQJxn9o5Lt21+SskNCiu7kG8asaARtFCADqVs0l4T0WrAEQOm1?=
 =?us-ascii?Q?tZDC5oWZmIR/SnQi1QyvQzojTqkK1o0wKhnatsExxTw6O6pD6wKccDbL6JB6?=
 =?us-ascii?Q?qqaXNpqxi4zSicJWGaEpIbrRWh4+iUhgX2O7mSfIzrMRepvQ4xUYyk0qkHGK?=
 =?us-ascii?Q?8Wnpoxl6iBcPh9kWd9BMyDukkOdNw57wnDZEZhzL9dHPIMc60pP8amMFNg7r?=
 =?us-ascii?Q?9oMTe3w/BUt9NTloUbllowqTUDG7HUBN/BN7wsXV0CNV4pSLTEaW9+Vmx75x?=
 =?us-ascii?Q?LLBKRjJ9hfaeZe0Uprbu8du29jRu4WENZjU0z9oL27GKsEI1cvrH4o93clmm?=
 =?us-ascii?Q?NgGa+wWDlweeWsNxxUHsef49P2rOjCzskER+WjQnKlahKEkCpJYi4kwqjAaE?=
 =?us-ascii?Q?O+yMAa+Zho9uFvTpK6zHhKj4D/KfUtWeIuSBxWpq/zxJJaLJGauin3V+LWKH?=
 =?us-ascii?Q?nBQp/1Kd5quZIDQqGqef5KMovOJP9IZFUYHa0/CtTgsMuRnmuyqxbG10Icb1?=
 =?us-ascii?Q?ftqPEEOk1kAxj0wm3YRPzpQ1qgz+l1toTR9yNhZa0Z3mjMdX5GhCYvPnF0lX?=
 =?us-ascii?Q?cFBByXdjl/7v4XS11IhjPpiyZtCKJXxdOyw25NSHFgecNbbKwYyu8AXXiEqE?=
 =?us-ascii?Q?Fn2ff0bhz+/zk1pXhqNnzWiQo2Rii4WvlBMUKcUJgCH5ZyOIUF3NZxRsoUa5?=
 =?us-ascii?Q?HJrFdwh7s7K+40clZ5nBn8u2geEUdsfPeVzUGID64ibr5FGTk2pLjbCWQG3B?=
 =?us-ascii?Q?Dd1GiTikwm+Fkb0+yhVzJ1uURiE1jZ0Ty4tgf3c1W7gJdK34lPpsGB+Q/zHW?=
 =?us-ascii?Q?0B26XioydmY0I9S2LBAdvlGnCTkMm4ugh5E5Bo8ecKm/MaPfDebX6aYad4Mg?=
 =?us-ascii?Q?H2YSrjSWYTMY2RsLY4WL5/89BMmd38glSa/M94mOiHjhZ34vamkE+IcYC8TN?=
 =?us-ascii?Q?gD4pL3yP/fHAW4xizfeALttkrKvbBSiaBVo1nVnbO4CuNjhvo88aEWBpGdJd?=
 =?us-ascii?Q?Mk0ULhL2Er8JTla7x3d6pmm4yvKsTVibGOZl99p/BjPCF9U8WPUbnpDG5km8?=
 =?us-ascii?Q?PWRFgke6fjDZEQHPO7ID2oVgHrhPHhh9MUKVlcpKYVjlDAqKMA2yEuLqj/EO?=
 =?us-ascii?Q?hoxo89oH48yhQikvwpLvb4aTRbi1Gg7Ly1etW3cQ8LUAP/N1ibQaRBkugyeE?=
 =?us-ascii?Q?a+k6RmkMS3JwxfN697ayJzT9M9IHkswklVhM5QkM1P2gOk4g7Bx0NBkchnt/?=
 =?us-ascii?Q?OoWwwjRoR9RQQfOWhQ9P6dmMSjoP9pbm+RNRTUPXNsfwneultqkne2RbjCqh?=
 =?us-ascii?Q?FjFpUKBY1EN0aX/fQZG7q76Eg0b1YzLfhXgxNe2JgJYMqRJsTGqBc95G3JYY?=
 =?us-ascii?Q?vJjvV1kSOYuiKaXKJ4vfUfk7L7ZSbCsK0ecJJgZFp+073JIvUW7YJUluGPld?=
 =?us-ascii?Q?r18z0eulBDSX+/hmDTYNE0R++MsZZWK5NOBptcuN3JUbduk1AMkBa7kc7Vio?=
 =?us-ascii?Q?tb973S8WhtPHG30JxypdocNxFahfVFBY9TNgoPk88hPKOqzzNpsfXGCqJyk3?=
 =?us-ascii?Q?Fq/cbIpF1osgJSPzvHbXUJWqq35JN7RA6yygoAiZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fb0155-5d68-426b-8521-08dd18ab028a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:41:31.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLJxsgZrTpog3NLWKwHFe0ktleiMk3fTpWJ+jzUIxENa0Dwb29JJZRSCYUKWNstzb+/dqwe5Hxi41RiuPMocHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8048
X-OriginatorOrg: intel.com

I've been noticing a deadlock with the DCD patch series rebased on 6.13.
I bisected this a couple of times and each time I bisect the issue I land
on a patch which 1) does not appear to have anything to do with locking
and 2) was different from the last bisect result!

After narrowing down what was failing in DCD I got cxl-create-region.sh to
fail.  After looping it on 6.13 master[0] I got the following deadlock.[1]

Also NOTE the WARNING from device_lock_set_class() in cxl/acpi.c.

Any clue what has changed for 6.13?

Ira

[0]
commit 7cb1b466315004af98f6ba6c2546bb713ca3c237 (HEAD -> master, origin/master)
Merge: e4c995f92b21 b4d83c8323b0
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Dec 9 10:34:41 2024 -0800

    Merge tag 'locking_urgent_for_v6.13_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
    
    Pull locking fixes from Borislav Petkov:
    
     - Remove if_not_guard() as it is generating incorrect code
    
     - Fix the initialization of the fake lockdep_map for the first locked
       ww_mutex
    
    * tag 'locking_urgent_for_v6.13_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip:
      headers/cleanup.h: Remove the if_not_guard() facility
      locking/ww_mutex: Fix ww_mutex dummy lockdep map selftest warnings


[1]

[  132.142769] ======================================================
[  132.143344] WARNING: possible circular locking dependency detected
[  132.143895] 6.13.0-rc2ira+ #3 Tainted: G           OE    N
[  132.144420] ------------------------------------------------------
[  132.144965] modprobe/4152 is trying to acquire lock:
[  132.145457] ffff88820efd2378 (kn->active#20){++++}-{0:0}, at: __kernfs_remove+0xde/0x220
[  132.146112] 
               but task is already holding lock:
[  132.146814] ffff88800a3e20f8 (&cxl_root_key){+.+.}-{4:4}, at: device_release_driver_internal+0x39/0x210
[  132.147555] 
               which lock already depends on the new lock.

[  132.148562] 
               the existing dependency chain (in reverse order) is:
[  132.149355] 
               -> #1 (&cxl_root_key){+.+.}-{4:4}:
[  132.150064]        __mutex_lock+0x97/0xce0
[  132.150489]        uevent_show+0xac/0x130
[  132.150907]        dev_attr_show+0x15/0x40
[  132.151351]        sysfs_kf_seq_show+0xa9/0xf0
[  132.151791]        seq_read_iter+0x10a/0x440
[  132.152254]        vfs_read+0x23c/0x310
[  132.152661]        ksys_read+0x58/0xd0
[  132.153094]        do_syscall_64+0x75/0x190
[  132.153524]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  132.154037] 
               -> #0 (kn->active#20){++++}-{0:0}:
[  132.154739]        __lock_acquire+0x1623/0x23e0
[  132.155207]        lock_acquire+0xda/0x310
[  132.155623]        kernfs_drain+0x197/0x1b0
[  132.156045]        __kernfs_remove+0xde/0x220
[  132.156456]        kernfs_remove_by_name_ns+0x5e/0xa0
[  132.156920]        device_del+0x168/0x410
[  132.157364]        device_unregister+0x13/0x60
[  132.157780]        devres_release_all+0xa5/0xf0
[  132.158232]        device_unbind_cleanup+0xe/0x70
[  132.158661]        device_release_driver_internal+0x1c7/0x210
[  132.159174]        bus_remove_device+0xd7/0x150
[  132.159594]        device_del+0x178/0x410
[  132.159983]        platform_device_del+0x21/0x80
[  132.160436]        platform_device_unregister+0xe/0x30
[  132.160886]        cxl_test_exit+0x4e/0xc90 [cxl_test]
[  132.161364]        __do_sys_delete_module.isra.0+0x17e/0x260
[  132.161847]        do_syscall_64+0x75/0x190
[  132.162290]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  132.162773] 
               other info that might help us debug this:

[  132.163729]  Possible unsafe locking scenario:

[  132.164391]        CPU0                    CPU1
[  132.164805]        ----                    ----
[  132.165231]   lock(&cxl_root_key);
[  132.165578]                                lock(kn->active#20);
[  132.166075]                                lock(&cxl_root_key);
[  132.166553]   lock(kn->active#20);
[  132.166896] 
                *** DEADLOCK ***

[  132.167630] 1 lock held by modprobe/4152:
[  132.167998]  #0: ffff88800a3e20f8 (&cxl_root_key){+.+.}-{4:4}, at: device_release_driver_internal+0x39/0x210
[  132.168698] 
               stack backtrace:
[  132.169224] CPU: 2 UID: 0 PID: 4152 Comm: modprobe Tainted: G           OE    N 6.13.0-rc2ira+ #3
[  132.169871] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [N]=TEST
[  132.170373] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-4.fc40 05/24/2024
[  132.171039] Call Trace:
[  132.171327]  <TASK>
[  132.171597]  dump_stack_lvl+0x7e/0xc0
[  132.171965]  print_circular_bug.cold+0x178/0x1be
[  132.172390]  check_noncircular+0x13d/0x150
[  132.172774]  ? __lock_acquire+0x7ba/0x23e0
[  132.173178]  __lock_acquire+0x1623/0x23e0
[  132.173560]  lock_acquire+0xda/0x310
[  132.173917]  ? __kernfs_remove+0xde/0x220
[  132.174327]  ? kernfs_drain+0x58/0x1b0
[  132.174691]  kernfs_drain+0x197/0x1b0
[  132.175062]  ? __kernfs_remove+0xde/0x220
[  132.175440]  __kernfs_remove+0xde/0x220
[  132.175812]  kernfs_remove_by_name_ns+0x5e/0xa0
[  132.176237]  device_del+0x168/0x410
[  132.176590]  device_unregister+0x13/0x60
[  132.176967]  devres_release_all+0xa5/0xf0
[  132.177358]  device_unbind_cleanup+0xe/0x70
[  132.177743]  device_release_driver_internal+0x1c7/0x210
[  132.178211]  bus_remove_device+0xd7/0x150
[  132.178596]  device_del+0x178/0x410
[  132.178949]  platform_device_del+0x21/0x80
[  132.179345]  platform_device_unregister+0xe/0x30
[  132.179762]  cxl_test_exit+0x4e/0xc90 [cxl_test]
[  132.180188]  __do_sys_delete_module.isra.0+0x17e/0x260
[  132.180633]  ? syscall_exit_to_user_mode+0x11/0x250
[  132.181078]  ? do_syscall_64+0x36/0x190
[  132.181448]  do_syscall_64+0x75/0x190
[  132.181828]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  132.182468] RIP: 0033:0x7f9a5ab2b68b
[  132.182892] Code: 73 01 c3 48 8b 0d 8d a7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d a7 0c 00 f7 d8 64 89 01 48
[  132.184385] RSP: 002b:00007ffc69906498 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  132.185013] RAX: ffffffffffffffda RBX: 000055ae0272be50 RCX: 00007f9a5ab2b68b
[  132.185603] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055ae0272beb8
[  132.186218] RBP: 00007ffc699064c0 R08: 1999999999999999 R09: 0000000000000000
[  132.186803] R10: 00007f9a5aba5fe0 R11: 0000000000000206 R12: 0000000000000000
[  132.187422] R13: 00007ffc699064f0 R14: 0000000000000000 R15: 0000000000000000
[  132.188026]  </TASK>
[  133.247555] calling  cxl_port_init+0x0/0xff0 [cxl_port] @ 4209
[  133.248311] initcall cxl_port_init+0x0/0xff0 [cxl_port] returned 0 after 232 usecs
[  133.250254] calling  cxl_acpi_init+0x0/0xff0 [cxl_acpi] @ 4209
[  133.250865] ------------[ cut here ]------------
[  133.251330] cxl_acpi ACPI0017:00: overriding existing custom lock class
[  133.252022] WARNING: CPU: 3 PID: 4209 at ../../../drivers/cxl/acpi.c:826 cxl_acpi_probe+0x34a/0x3d0 [cxl_acpi]
[  133.252901] Modules linked in: cxl_acpi(OE+) cxl_port(OE) kmem device_dax nd_pmem dax_cxl nd_btt dax_pmem cxl_mock_mem(OE) cxl_pci nd_e820 nfit cxl_mock(OE) libnvdimm cxl_core(OE) [last unloaded: cxl_port(OE)]
[  133.254275] CPU: 3 UID: 0 PID: 4209 Comm: modprobe Tainted: G           OE    N 6.13.0-rc2ira+ #3
[  133.254958] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [N]=TEST
[  133.255469] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-4.fc40 05/24/2024
[  133.256139] RIP: 0010:cxl_acpi_probe+0x34a/0x3d0 [cxl_acpi]
[  133.256596] Code: c6 05 a9 82 e3 ff 01 4d 85 e4 75 04 4c 8b 63 10 48 89 ef e8 28 dd 7c e0 4c 89 e2 48 c7 c7 d8 e5 06 a1 48 89 c6 e8 16 db ef df <0f> 0b e9 f8 fc ff ff 41 bc f4 ff ff ff e9 0b ff ff ff 41 bc fa ff
[  133.258208] RSP: 0018:ffffc9000ed4bb78 EFLAGS: 00010296
[  133.258721] RAX: 000000000000003b RBX: ffff8881a6c3d800 RCX: 0000000000000000
[  133.259387] RDX: 0000000000000002 RSI: ffffffff82a785b5 RDI: 00000000ffffffff
[  133.260043] RBP: ffff8881a6c3d810 R08: 00000000ffefffff R09: ffff88827c7fcfa8
[  133.260680] R10: ffff888276ffd000 R11: ffffc900027e8000 R12: ffff8880069049c0
[  133.261322] R13: ffff8882014df800 R14: 0000000000000000 R15: ffff88800a769560
[  133.262002] FS:  00007fd0e8ba1740(0000) GS:ffff88807db80000(0000) knlGS:0000000000000000
[  133.262682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.263249] CR2: 00007fff0f1b0ff8 CR3: 0000000020fa8000 CR4: 0000000000750ef0
[  133.263970] PKRU: 55555554
[  133.264340] Call Trace:
[  133.264668]  <TASK>
[  133.265032]  ? __warn.cold+0xb7/0x152
[  133.265438]  ? cxl_acpi_probe+0x34a/0x3d0 [cxl_acpi]
[  133.266016]  ? report_bug+0xe6/0x170
[  133.266413]  ? tick_nohz_tick_stopped+0x12/0x30
[  133.266948]  ? handle_bug+0x58/0x90
[  133.267372]  ? exc_invalid_op+0x13/0x60
[  133.267803]  ? asm_exc_invalid_op+0x16/0x20
[  133.268247]  ? cxl_acpi_probe+0x34a/0x3d0 [cxl_acpi]
[  133.268721]  ? cxl_acpi_probe+0x34a/0x3d0 [cxl_acpi]
[  133.269237]  platform_probe+0x3d/0xa0
[  133.269641]  really_probe+0xdb/0x340
[  133.270054]  ? __pfx___driver_attach+0x10/0x10
[  133.270517]  __driver_probe_device+0xc0/0x110
[  133.270965]  driver_probe_device+0x1f/0xa0
[  133.271402]  __driver_attach+0xba/0x1c0
[  133.271855]  bus_for_each_dev+0x68/0xb0
[  133.272258]  bus_add_driver+0x111/0x1f0
[  133.272638]  driver_register+0x6e/0xc0
[  133.273062]  ? __pfx_cxl_acpi_init+0x10/0x10 [cxl_acpi]
[  133.273562]  do_one_initcall+0x5b/0x2c0
[  133.273957]  ? __kmalloc_cache_noprof+0x2eb/0x3d0
[  133.274450]  do_init_module+0x60/0x210
[  133.274848]  init_module_from_file+0x75/0xa0
[  133.275265]  idempotent_init_module+0xed/0x2d0
[  133.275661]  __x64_sys_finit_module+0x61/0xc0
[  133.276075]  do_syscall_64+0x75/0x190
[  133.276429]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  133.276916] RIP: 0033:0x7fd0e85283dd
[  133.277279] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0b da 0c 00 f7 d8 64 89 01 48
[  133.278645] RSP: 002b:00007fff0f1b3fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  133.279265] RAX: ffffffffffffffda RBX: 0000557a394b2490 RCX: 00007fd0e85283dd
[  133.279837] RDX: 0000000000000000 RSI: 0000557a394b44a0 RDI: 0000000000000004
[  133.280397] RBP: 00007fff0f1b4090 R08: 00007fd0e85f6b20 R09: 00007fff0f1b4020
[  133.280956] R10: 0000557a394b4940 R11: 0000000000000246 R12: 0000557a394b44a0
[  133.281521] R13: 0000000000040000 R14: 0000557a394b2450 R15: 0000557a394b9430
[  133.282075]  </TASK>
[  133.282325] irq event stamp: 0
[  133.282620] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  133.283118] hardirqs last disabled at (0): [<ffffffff8112e56e>] copy_process+0x9ce/0x1f30
[  133.283704] softirqs last  enabled at (0): [<ffffffff8112e56e>] copy_process+0x9ce/0x1f30
[  133.284433] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  133.285101] ---[ end trace 0000000000000000 ]---
