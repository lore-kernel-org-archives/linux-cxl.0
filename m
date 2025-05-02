Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46646347C7;
	Fri,  2 May 2025 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229736; cv=fail; b=gbbfkqg5GEGgz/lBuV+v6A/IyjOjSpjcgLLUsE04CQo0hocV4hQoNoYYXoPaN9EYwtzDV6BrV4Wk4jfx1DK0t3QyAzyAwBdqVoz3oPdBCrM7ptFMvFwiNKE4W0WPVWwBl0wbjFo8Wo3/5kyyEtxWhSU1/d4/n5ZHAvP1HR8kc9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229736; c=relaxed/simple;
	bh=ODohnfDd/9nPKqMwL4ZHUn8FUVYQk7QtoAAsQ8y9Y14=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S95YItb8J2zy5xHiw54G64loT4JaweuNEJ7M0p7dSHOJaVf0hD+pXq0HYoju1Rwh34LvBK6yqWYKxdakUy2/V7w4WAKx+tV0sSDqN+BiPFktjq6/z6MfkQl9eckmOe8tBkPtiDk5DqHpSRFSEuiu9LTxFKLlI3KYrpqj74TczJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSTlF/Ap; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSTlF/Ap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746229735; x=1777765735;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ODohnfDd/9nPKqMwL4ZHUn8FUVYQk7QtoAAsQ8y9Y14=;
  b=MSTlF/ApEMxhTI4vZAFwWxI3R7n8r+rLeSP36KbtpsvyeJ8alpFGos+I
   BSjxX6kAfs1nl9UdVwHQLlVo0MPFXehCqtMkEucuV1NJPI5y28sdGaKZ8
   YirjE0qhpqLU0+N+zV4YosMH0jGLOAnY85kHAAXGw6/dJ+V/8TzH0Q+6K
   Zz/2W0huWGoCU2YKjW8VVog9YMksr2hI7u10e748AnqPGt1OJ1bN4zsDn
   HjD1PP2vykRsst70Wspe1Mf+M3dHMgfFeWGjt2Z0Rdy2hFoGOQKtKUYNV
   IYy89O1YyB+QJDVcR1z/ytdwRfitq9+rY0b2ATwiQjBokr9znqizNgilr
   w==;
X-CSE-ConnectionGUID: kZ0xvxrATVGYLXojklfWzQ==
X-CSE-MsgGUID: wcdPf6SZQMqJRE2YfdFwpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47929176"
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="47929176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 16:48:54 -0700
X-CSE-ConnectionGUID: zNKDcg/dSuGQ6zojPaNfag==
X-CSE-MsgGUID: bNgE5W/9RH25wUuqOom20A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,257,1739865600"; 
   d="scan'208";a="138775083"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 16:48:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 16:48:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 16:48:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 16:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1BAOhjO/yOnNFlhpnvTHbbOLSAxeDcNQjDxJ4tGlo+QeDCgUFAOol5nWPwT71yfShwYhjjt2dEdLdajHPIQSIH+QPkeV7TgHSRtdIHLfK5CYgP/DfzTkpxhJYAXzBYCo9KV6uDNwmpLqUNqqufx6QsBadVKYj95Uq+MXxaXkHHSO6VJzbh0fUqMiTtMDTUjyxikZ8b36sghbN/1kytuy0BNJPxXH6IANWN2M5+TpeCe3y3ujr1ve+Eqno/trtoJzq+l6MbTM3NZYLK8Abo7SNZWsJwg+fQGqwkaK3ZfagSoU8VjLXkf4qLlS8+s4qFOX3OHoFuYPYUmcvvWtrgaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCySu9dPMJmVEKF4ddgogF3tryScuPtKLXzXAk2zNmw=;
 b=xdLqHWXiBN0xYANlQ6gd/LVbwnpOaxZw13inCJqBHYoMcxGqmt6Jx6i5djTcLh0068aq9dXHl+U8562i1VjhsRz/GOTYt7d0S9MKpNwelHc0DdSHsL18F6A2JymDTCMpFrraL3HFeEzOLCSZqUgfjRk5bKbiC2AvNW751IGfClX6vv3xxyGDbAGi7aejWRwKYm0/vBHuKzgZakTXGHMXpM+NDsu0CTw8O/U47qyeQ0hS00pVQwzDRx9irmhwsw5CfTTWdFjLH2S7wqRMU9jWrzy48QTjIWZllGaLeS54fc0wFA8gW/XdSp3UaVyfRIGklyVQk0ivjd4Eqmq5sv8rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 23:48:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 23:48:21 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <torvalds@linux-foundation.org>, <peterz@infradead.org>
CC: Dan Williams <dan.j.williams@intel.com>, David Lechner
	<dlechner@baylibre.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC PATCH] cleanup: Introduce "acquire"/"drop" cleanup helpers for interruptible locks
Date: Fri, 2 May 2025 16:48:18 -0700
Message-ID: <20250502234818.1744432-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d70efb6-c48e-44b5-b9bf-08dd89d3d205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JI8cKAVVsf/Facne4M3X2ePFtbTMSPK0aB+t8WUgMe1S1Bk6xSFn4ZodbUjB?=
 =?us-ascii?Q?DpNyxuzD3CSDFAt8UF/JiPiF+9iLAIxZzbRayu1DxYYJAKGkpPiRLNNliojh?=
 =?us-ascii?Q?iBulvDFivuxeoTnHeLmeR6nBBxtL/Jhbnb2LXMmq+O3N0RR9YbJuDG4HgUrh?=
 =?us-ascii?Q?8zCN+M8wdNJInUYZBnxObF8feIFWGnR5itpIa61L0xkaRPUk1aJ4ESXoTCEo?=
 =?us-ascii?Q?b52VYmRrnsyVi51ihKuGmJsTKdytpgjC+RkNhd6KwEJ35ii9GtYIjdlNSdco?=
 =?us-ascii?Q?xB8U48++3thKB5sH4TXqeTO9N8jUQcpl6CmGZEeI0owQB2WeTa7odoBhgyqj?=
 =?us-ascii?Q?eRRdDfIZ7PLXGs+JJjv/kBXMMSJAs4svuozKLBkIpSVuUt9VI/W18w/GxbCQ?=
 =?us-ascii?Q?opkxrHlxZqmg0SxcuKGktJG2i/ciTVj/3FdceH9DdIwcopBui0aj9uH1Zsm2?=
 =?us-ascii?Q?G3YPqf8GX0WyYZuTTKOSv/bT5TFua/+cUiRXtWfqM+KAqUnWStbCqSn6J0wH?=
 =?us-ascii?Q?qkkJY0AEetXQx1Sz+kHB07dMIHBpHDWAQg18cn8Vt6k0toQv+av6h9Pv2Jnz?=
 =?us-ascii?Q?Hyr4UpIbm6tD7j0EHpqEqxiK4/FNEaxGw0sDyaxTygBvQRrXRmFSvSW0jMNL?=
 =?us-ascii?Q?QzUXBHLn/wMfchzt4X9szCESEp2myzTk5SVrJi5cCDQB4I5jUfLyfzY8sqZK?=
 =?us-ascii?Q?QTks9QIxUf1WAnkWLT+2qNwGe38DYIqpFLzeHhKeDz4/jBnaRlSkb+a6aCxQ?=
 =?us-ascii?Q?ZlV4fR4Mf39qRRkgvwysEGeb16o27FfT1PPh8F8TxtSTtqHr7XcYVldSc5a2?=
 =?us-ascii?Q?En84eH38srVsMoswL4tR/+Mg4vwo4Njkyffq/yggsx4CQlMHXSorRtXcBrcd?=
 =?us-ascii?Q?cOgmYbmrK07tOJ947mGZcVj7ShaiLGJS4vHuNWrEvlBePP4Yw69JRdze0P9p?=
 =?us-ascii?Q?smrgyWh4IUbdptXaiI41DSIqmbtziqfU1wTLoBCeYr0PKnsik6sCBIBBUIOJ?=
 =?us-ascii?Q?wd5IqMMFmkmJddmTNx0UVqXvNQv0+37E38O/QCDDANN5z1SuYeD5DQNhdaUl?=
 =?us-ascii?Q?UPxDnJbIPOenvGlH5S4Iu/jgLhzoJ5nRvzG1CiyKei+oppPUCYCqi6XaLF7l?=
 =?us-ascii?Q?1aEjCGbKhRXExMSIJ53JN/CuVp7vcxUHOq3iwMzUcUtY07eeEIY3GLFLvB4A?=
 =?us-ascii?Q?DdWfYX6dwNoQv0Xs5BD4tosQeDDpt1B3DqmV8QvqkpS7WljAUEyTpRVMybYU?=
 =?us-ascii?Q?AEAk8CVG6BJDvivl5WZKGkeAY+DMByrx4qsHsumGP0JUreGJyug4yh+OjQr1?=
 =?us-ascii?Q?fohfv217TBvrJ2OanR9k3ip9FuJNRnAC8pO6R4CuTVrFkBgwaPvC+LziNyWF?=
 =?us-ascii?Q?CY6RoqiR6OED81CGcJRfk8BYmIgvvlholYQ8ABAvWizeGemG06zhTd8z4Xhc?=
 =?us-ascii?Q?i+f6HCOAdcI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppokiP3sGASQ0WxjwVr4u9Elev7mmGtl29oSLKwstKHyFDQvPGg5dged+6FX?=
 =?us-ascii?Q?n0QV5QrNkP8OR3/K5QaA0l+Y9uNqajCdYwA3SU098TpNx7/YloUVhAx00qXS?=
 =?us-ascii?Q?bpNIrUOC7gBhiwSegfuJ2M+rQhzoGXs6/upi6Su9uEV3oZT0UpkDd9mKKiAL?=
 =?us-ascii?Q?9gGe053f766uOm8UYbYb8o52/cTvmYMrbPsObIH14aWSM1oYXcQSDQHD7iwJ?=
 =?us-ascii?Q?IVD/vitSk+mbZvAbFiTHpYAoietdtDjJQFAcj3KUrFNWU6nGGqpRJH/3Rli4?=
 =?us-ascii?Q?DmNvVDg+5K6WdYk21fiLVpEhJNyS1/io3ckJasg4F2yXEf9nJTVW+E152+tl?=
 =?us-ascii?Q?e9Ng7xcYYQ9eqhMRfFq1tBo9H0AjYcTi1YxWe1PpBlvVmGb2P7D5qoXx8Y4E?=
 =?us-ascii?Q?xZumcw1p3q9f0fVwqcZ7ROisN4zhRcgm8bkvxfQmHNmzJ+BLAPAqTIyK1tJV?=
 =?us-ascii?Q?ZKvZoBDAVM5RZktaKh8xNimZzmkpwSSwJ7GEZiFej3MG3ltBQmiud4ORbnfq?=
 =?us-ascii?Q?wokx5oqoAewOLIWS4YGUQWkdyfCzw198k8UvUfjfm6NSRomycRaoMsLr+9FA?=
 =?us-ascii?Q?iF/qBK+Q8U5flN/3htYsafipgrrA/wnG8Lw/AOrh1+kc59Xecuxsl1OoKgSu?=
 =?us-ascii?Q?GFR7lJbjoOLke6mEkFN9Zro3PXGJUpRDg/BZAgHuxYZM3c9Gl902H1SnIL+F?=
 =?us-ascii?Q?WqtXvv7HYTXi1IQZe56os7UP54ZTLP/IrjnIx7bssGckIVTlS612cnapZUKu?=
 =?us-ascii?Q?CoeM4VHho5XrjnW6jwWLPVegC2Z8lUXClugvyGJdBUOPyTD/ywVnU+dc3lke?=
 =?us-ascii?Q?HrlZzErOims5/cVtmYviWq6Gdu7uA9asDmz6NrhjXgpBek78a2CQrqQo1El1?=
 =?us-ascii?Q?4mpGjE+RlyLN7+u+BcR60hvW/ohlFU6jcSXaZQ5dBMKC8CiLh9bPbmABrPqa?=
 =?us-ascii?Q?LuRZNQqBzMhrooPFFrelfx3TpWy75s1F5wBE9qSBdw1KF359uGSDKxFpmAEP?=
 =?us-ascii?Q?mTczg49gh7arvtshJ0d15nzAPEUzg22Ab/8GPNoI9REO4ESIQ8uOLMFChLBT?=
 =?us-ascii?Q?nAgM+vwTTNzrRXOfyIwviPK/dsB+bvM7FTzW6km0ukf1lbKy3+uonhZCm04z?=
 =?us-ascii?Q?vTcqhmcUcnoGhvkUL61JItpI443ZpzAdCqreZ17oajDNDQ4mhA1jL1zl5K5S?=
 =?us-ascii?Q?S0ydH0Dko2IdgDNEwwH+ndJ7YRpJJ1teyuQV2WUQ5WYz7Tj+/2sBZiqNegtx?=
 =?us-ascii?Q?CHAZxCRwkXGgW3SMGyT1LBUIXUpu5i3kqn//Fco3LdRsPSGgfgsgBDse4ntJ?=
 =?us-ascii?Q?7YO0VV1DZpQKL0CV569FGUW/2v/LRTJIHs3o00VnAwx5nAahDo234uTx9XDP?=
 =?us-ascii?Q?G7siLoO86HTX/lfAt8Xuhs+W1jXLGJs8AVVeYh7QSvtUBWFbU0H0rzOK5bzJ?=
 =?us-ascii?Q?TY8iGiUeodzx4wmQnyAf1TXaUCXEtlsQeU+kOvYMu5NS3L9jzob1j2n47r+b?=
 =?us-ascii?Q?3wFkvfIpBO922EZ+AXJAERJAzCmoD05q/tMcD7qB36swVWe9dWdZj3Xi1fHj?=
 =?us-ascii?Q?HZ3bxcUsNjBD6rM7f1sLcbyuI6TG3UDAlnKCGI860K/frMNsUbaMf7jXFt1S?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d70efb6-c48e-44b5-b9bf-08dd89d3d205
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 23:48:21.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XptucY5FW4XSAcaufYnaGvmkeuqeMpzlCVS9ymxjmdEgs4cPGEsF5Ogl79+8JiVHxyuuC+EkfwQKRF5FNlnt81ijy9brtIENUL1bQxoLw1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com

The scoped_cond_guard() helper has two problems. First, with "convert to
cleanup" style patches, it results in messy diffs that re-indent large
swaths of code. Second, it swallows return values from interruptible /
killable locks, i.e. the return value of those is not always -EINTR.

The last attempt at improving this situation, if_not_guard() [1], was
reverted with a suggestion:

    "I really think the basic issue is that 'cond_guard' itself is a pretty
     broken concept. It simply doesn't work very well in the C syntax.

     I wish people just gave up on it entirely rather than try to work
     around that fundamental fact."

Take that to heart and abandon a "guard-like" statement. Instead, formalize
an off-the-cuff Linus proposal that was suggested along the way towards
scoped_cond_guard() [2].

    "You should aim for a nice

     struct rw_semaphore *struct rw_semaphore *exec_update_lock
         __cleanup(release_exec_update_lock) = get_exec_update_lock(task);"

Introduce DEFINE_DROP(), to create a cleanup function for releasing locks,
and __drop() to pair with "acquire" helpers. Note, while this could use
DEFINE_FREE()/__free() directly, that leads to confusing a "resource
leak" semantic with "missing unlock". Also, note the name "drop" is a
second option. The first option of calling this semantic "release" collides
with the "__release()" macro already being taken by sparse.

Lastly, just manually define mutex_intr_acquire() and
rwsem_read_intr_acquire() helpers as it was not readily apparent how to
create a new DEFINE_ACQUIRE() macro to automate these definitions. Use the
helpers in at least one location to test out the proposal.

Link: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com [1]
Link: https://lore.kernel.org/all/CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com [2]
Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c   |  7 ++++---
 drivers/cxl/core/memdev.c | 18 ++++++++----------
 include/linux/cleanup.h   |  7 +++++++
 include/linux/mutex.h     | 10 ++++++++++
 include/linux/rwsem.h     | 11 +++++++++++
 5 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..e3e851813c2a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1394,9 +1394,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
-		return rc;
+	struct mutex *lock __drop(mutex_unlock) =
+		mutex_intr_acquire(&mds->poison.lock);
+	if (IS_ERR(lock))
+		return PTR_ERR(lock);
 
 	po = mds->poison.list_out;
 	pi.offset = cpu_to_le64(offset);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a16a5886d40a..9fbe83f868c6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,15 +231,15 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	struct rw_semaphore *region_rwsem __drop(up_read) =
+		rwsem_read_intr_acquire(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	struct rw_semaphore *dpa_rwsem __drop(up_read) =
+		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
+	if (IS_ERR(dpa_rwsem))
+		return PTR_ERR(dpa_rwsem);
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -248,8 +248,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		/* Regions mapped, collect poison by endpoint */
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7e57047e1564..3e96edb1b373 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -199,6 +199,13 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
+/*
+ * For lock "acquire"/"drop" helpers the lock is not "freed", but the
+ * cleanup mechanics are identical
+ */
+#define DEFINE_DROP(_name, _type, _drop) DEFINE_FREE(_name, _type, _drop)
+#define __drop(_name) __free(_name)
+
 #define __get_and_null(p, nullvalue)   \
 	({                                  \
 		__auto_type __ptr = &(p);   \
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2143d05116be..9fef4077604c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -202,6 +202,16 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
+DEFINE_DROP(mutex_unlock, struct mutex *, if (!IS_ERR_OR_NULL(_T)) mutex_unlock(_T))
+static inline __must_check struct mutex *mutex_intr_acquire(struct mutex *lock)
+{
+	int ret = mutex_lock_interruptible(lock);
+
+	if (ret)
+		return ERR_PTR(ret);
+	return lock;
+}
+
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..d1c992b45625 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -242,6 +242,17 @@ DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
 DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
 
+DEFINE_DROP(up_read, struct rw_semaphore *, if (!IS_ERR_OR_NULL(_T)) up_read(_T))
+static inline __must_check struct rw_semaphore *
+rwsem_read_intr_acquire(struct rw_semaphore *sem)
+{
+	int ret = down_read_interruptible(sem);
+
+	if (ret)
+		return ERR_PTR(ret);
+	return sem;
+}
+
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
 

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.49.0

