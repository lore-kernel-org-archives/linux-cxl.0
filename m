Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38B25A62C;
	Tue,  4 Feb 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702832; cv=fail; b=gu2h1kKEbOKzlISQvuyjn7OMLUHyPnk4yKWLkcx+pswPxFl2egU3diZA+YiEShTHi5Xb3m2G9nUGd/M7mPXL5SfGmAODX4N3yaC4RcsGmGUjJ5UBPFBFfRgJV7S0cbE/Ixn2m+JR1mdna3j6UxC7mQnh2NMUg3QppHNSDybbbmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702832; c=relaxed/simple;
	bh=aVxNkPq+oGxOJkp+DvN9DsOI6WnyIyXYR/U/oP5ypXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMd98ySMGU3MkYgYYAyqRvJnVBjP7WHH47utkTRKtCL5WMsAJtuqJoNyKPnyFvGplqEFC4tRG9dFYF10R3Lk4V+Bgz+j4sRBfe9iK4K6G0hMzwzTde0pb8CdnalbkKWsErZYKaG1l0K0IpJJTXb6EGjFDK2dISiaiBuUysxjQfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVdcyTd4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVdcyTd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738702831; x=1770238831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aVxNkPq+oGxOJkp+DvN9DsOI6WnyIyXYR/U/oP5ypXo=;
  b=QVdcyTd4ChIW76wo8WL8QFH0zuqScYHr9zDIlEYVoJFUFO91HAEj6YLs
   uO+2G0ODUkUI1uQjoyzS7mCf3xSTydJVJRsnpWXgKzUBLqSCikuGO0DwJ
   7lZRDsDX+tWDTHFYykzZIn7S5GbxBHEVayuTP/Hoj+JYFbl6HFUaj1mtl
   8btXyk3xLuwLAwoSToRgp3CanHp7f0KM7h+nwPrrBmetJUXu8TTcEvecs
   xMQBYfABkAclJPvhb+vEMvUfvWnaDxzgDMnCe5tGWA2fJGDmFlROQy1H2
   B0HqlqwEfo+9vyQH+zH7Jzj1e3FntyDmxXjLXzlG4IhS52rmQGhSpdSDA
   Q==;
X-CSE-ConnectionGUID: EtNDX6L7SIaqxhwGqnEFfw==
X-CSE-MsgGUID: Pflulx1MTSek13W7zGXrIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50668793"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50668793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 12:59:40 -0800
X-CSE-ConnectionGUID: CcSjz6yJR6+bx5UHRs9mCg==
X-CSE-MsgGUID: J4cKs3FPS/6FeIWhAPEahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115695838"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 12:59:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 12:59:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 12:59:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 12:59:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Dn0EuBdB/x7/XrNGqx7lM4AaxD8SO0AlCFng1JvNoi/XQ4UBduYJoypsxYrQTwa/G5y4YytRp7cxBXlmi1vvwIyeXVug8SMDa3cIT5Q/E/QIgWLHV0cR0bZ34/OMKSmTmuYfJw5QGB8hSnlZxGaO5UGt8hahLhZgpT+P9ifZ2KeNEKq+PFFZTuj7HW3TMgDQ0Oy/KMlzXn+5ZLNYsJITA5ygH5DsuNGlrgW41QnhTrIcQM+WwiXfmddgeYgHSwfIfVAeEParxY1LvAtXKWXAL43I5QWMHj1MNWEF2Kj3v90CbitjPlklMeRzBzPtrl0Fw+i1Fz+kstcIaOSY602A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2PyM1AJOSs6EFG0Uafvcnp/6yK+y/4QvLPW7yUo9V8=;
 b=kEXetMNlYxpwjjaRxEanjA9OW9Rq2uYjTfJtZFCxAD5DjpNTHnmC5qBWwmtInrSk+WtcVwLQiN7k6RTrCE/atMfw97djs1QQ7ARw0ncnwAizwnarizptyIz8sxjr1q/8/bn0p8BNFanaJ6RqkTsJXvjjkbtXY9WHI7RzRZ2fOeS8tmaMkwYG29bOvX+UoHIqmPM5uCEAOuijYecQ0Jp1SxUzrvKm2aFgu4HOnpB+BVzz2ve2bMc5WLAoMUtYnFk3dV8WtdbbdeOpsT1RgX275O6gWgs4WB5I5Nm9Ww2lon1pv41gypGB8sHC360CmqzokIFxCbt9+aQfi+Z8C6WWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 20:59:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 20:59:36 +0000
Date: Tue, 4 Feb 2025 12:59:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
Message-ID: <67a27fb6430f8_2d2c2941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b6f828-bb5c-4a7f-6236-08dd455ed560
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V/9n05Z1yeawqciTyNQ2nopyrMq641MpBf+jRjM5zCAanDUsyG4wXcSb12Y5?=
 =?us-ascii?Q?pacNN3ZrBdJOoqJkfbHXbjQZx1z5D53X18LkWncL6NMSEfb66de64E21Pd++?=
 =?us-ascii?Q?GtdPYi/ZhCyvLCFxZRwa2MK+f2Bk0E/7zDKbPpJdsfL0t1g3ewHozazqv0bV?=
 =?us-ascii?Q?5+HhkIP46gmBGCNKyPLVbg5MrbNiKwezBoELDuJgYR47wEEuPEvvv8w04fql?=
 =?us-ascii?Q?9Ryg1j8fyqMugDJALF6+b1W+HgL2AV+ZbfJc4qM8iV0z2T4nupoLRFRJSbKo?=
 =?us-ascii?Q?vnPxz+N/pRCe5/175d/EXmAMW53UYj04bzzDmvv6LtpoiSPmUXAxMpOsDCmI?=
 =?us-ascii?Q?mQydMSw8gyu9v4n71uQdj39N4ME5cBdtt17Es4mzEoaacPNUApIaSKnfUaUG?=
 =?us-ascii?Q?2O71UBEfMum28Ufylbie8RbgnVcFSaX9jg+zVX/pcRP2PWdr+vB6x00yh2Ge?=
 =?us-ascii?Q?afJ51SmJPSFqMICbLlz1YtChkp9Bd7ssLCxVyK8AB/lXWqU4RyAr9piANbTq?=
 =?us-ascii?Q?KAYv0WH10wTM1ad6BCzpf3vCcKx2Lrt5sBj9beOLseDs43UI03ps0QDlML/i?=
 =?us-ascii?Q?dVnSHgqGiRthBTXLPnznIWanR7aNon0Jmw0ODZQ3WFf1Tu9KQh1oYi+zsof1?=
 =?us-ascii?Q?FJuzTmBDG2vkp2pWeWyYIrWxM8ycNAxpLa3Tg6OavzpDyYPc/7Ziuk39mVK+?=
 =?us-ascii?Q?+fj6TC6YtLcUYjK8RCTsLBPeS5zwWuHs7AER4+fh/ffdL88EmxWyJ9/+lYSl?=
 =?us-ascii?Q?nvMIlOpLTFG6qKPEqaYjJyvodfInQ/s0ysf6rJIyILFq4ItU3mUOoPM/PBT4?=
 =?us-ascii?Q?6YDuxFkEvDGSOm6MSM8gUKS/cR8AA5WKdsX/Z4kckhgX2qxW6hsPsHhC7uC6?=
 =?us-ascii?Q?d8yukOr3vgDWvjR7mYljsgaFUk1hLhQZpdF7MYaqLO5UnI6hR3kmwetx6l9O?=
 =?us-ascii?Q?MSA9XnW94Nmja8UjjHGpn1gZWvhaE2XqUn7Al6UKln6ulMbCJqsqQXLiP4Sg?=
 =?us-ascii?Q?jA017f3FpZXAqaEvimzhoojPgtTkWPAVZV1yNQwjzDSVoaWKHPOLmaOOdg0y?=
 =?us-ascii?Q?ek7rxzbEO7/PlbVM24BGCDaTAt9tSCAlEu24PhqHLVvfEiIl78Bd+Va3FaEI?=
 =?us-ascii?Q?UUYEbJZ3ltc61P0zEZ8HtLg1j/Rrq9PbA7HHpSfbQnS1mg7H5CYkQLP8R5Sc?=
 =?us-ascii?Q?v4AmKWtEh5QKROUbnAGjdm4xSssuamBOBGXnJUC0Txxk5jQXmGmTMY4NJ3OU?=
 =?us-ascii?Q?g4D+f896wMaZKs6jzVq+Sxr61Np8EWOg35wyOziVuvjt3sMcrlTIXL5VgsAp?=
 =?us-ascii?Q?iw7VoshVMGq5036q4dBS1QPYQ0PSqd2apofJy8XeNkysY2/8EqNSsKXewwd9?=
 =?us-ascii?Q?wo0vRaGzWKolk1Vl7oM4We3XoyFJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/6XYNdCsUO/8Pp1cHTMlz5Hp9Ud2eSew0kvVpx7+VwwiQVQOWM9maM9TlyR?=
 =?us-ascii?Q?tOPOrhgiNcKv2qwe551l38/ZrJV158d32Rs8g8iTseGQUVyqh1Rx6AmlG5kl?=
 =?us-ascii?Q?UUXnNUbOn1wfcmBzL2aa+6Zdolk9zgckN1mwMxGhNzGbQlOK2Hp9ROHOUNje?=
 =?us-ascii?Q?jtese3lSkEREy6Pi4JkySdsSjXay07/ZtJtm9fkLizV2KILI6Z+J4wPeTx/C?=
 =?us-ascii?Q?x4X2gdpSpw1BUx+lQJIha1cLO90JYNMR5x1fvrsoT+wa4qo7yG1DJo8vmQA/?=
 =?us-ascii?Q?Jbkh/LUyp9qqBC1QxKSuLCPTMGF1Y8W9nyRu5M/anIwf802NU10JoYWAlvJ5?=
 =?us-ascii?Q?MaeOxP+/oPy5TRRyfAEuA/U1bmUHObSRfrUZHVNjrAXq2R6L4JeYsYZ5aYJw?=
 =?us-ascii?Q?mMnQ5thXTrMgdqDv4sKFpMVlyH0bMQbOdQG0yT8+v1HftBhD04w8OzSyf1wB?=
 =?us-ascii?Q?feKi+LlxbBJF3qp3a8pfDeMvVjOQANrttox4oS4HISuHOluYLqMh5qTB1jeO?=
 =?us-ascii?Q?f+tIL5LEi3Np3TBYMssa5rbrmiaN8IhOrTjPs7o/Tk3JK/71b34rKOPmxvbg?=
 =?us-ascii?Q?x0AcITFk/FawDMaQSqTE0eRXVnfMy3jpDGZ3wpLyTM/BQobJZKNUAdB2JSS1?=
 =?us-ascii?Q?c4YFgi4FPXzJD2FopcwL3b3qGQSQwRizOHCTvcBAFn6CuPH8nzIvLTMKSGVN?=
 =?us-ascii?Q?R83H5oUiqb0QAjWTJl2UnPOp+moqwguoaK0ErWD/H0BR0YYMvAx2CfkM6uGM?=
 =?us-ascii?Q?c1wyZxTslT+Qc0aP/ltSIRzCZ7mtJJmFkNZalnjDXO5LJXOyJHE9C1oAzuCR?=
 =?us-ascii?Q?2ORsIYH27XJpCm70cvbTmIJnd8is59qZhqJjZ6hVmp9QmGACAdQINLQRBXC6?=
 =?us-ascii?Q?tQLXNK+jpNp0JWKQwV/jptOivIEmWeNFGGsKFATtVud0dd9CupgXP+gFwP4n?=
 =?us-ascii?Q?K565agF6Z0O1I47shLSDrrMpIUkHAno9SlBaYWzJnKCW8vM4x0u+JWZS+QQT?=
 =?us-ascii?Q?8A+U/wgL48pnRkjx0sL6uHtIGJiswO5GipaUzxSSejpYbrSSKAaDoxUlqi8P?=
 =?us-ascii?Q?IU5SgYKl1W1ATGkZZOyXkXR0/hdpOLYpyO0MA0kYPNcdY1LpspA/WciB4cRv?=
 =?us-ascii?Q?FY4zxamADfCUqlzkp8DZJOlU21XkW8F+cJ+T3iqfxR1g5OUHNP5niu270tR9?=
 =?us-ascii?Q?RpNXdfClqqH4Iateuo8jilhCX0ms9UOkSTiVpsJyeArDeU9ExlgomO7Yn+dv?=
 =?us-ascii?Q?d/yvQTIKIeIR4seCCWFJqV+UA6//1wwy00UhSEU+RC/NCPa+W50ArCpxPS7m?=
 =?us-ascii?Q?K7bLYQYIzBcuQKk3w1KDFuNTfHA4U7pku/26uRww5DuiLP8d7Ltmdonk0uoO?=
 =?us-ascii?Q?6BX/0L/NPU8TEtrUDdMN//xRRq4JQmcFJYJvXuy6XHlwPi2Y7qrGReQvqCLQ?=
 =?us-ascii?Q?4Hmm1b2jXiNIZBiRtQ36C8+14RNXBZnbASYgzweAnAYtaFSX2+D3iVSh0oWh?=
 =?us-ascii?Q?GFrhRnXm8V/x/88pKen8f4EVCJKZAzLqGbWDu5PKyJJHCF55Du9BZT9sEBdz?=
 =?us-ascii?Q?Qj2oieuMW/+DkdmfkG24R7IMHNMKZWeQSGIXYFplhpPwf8833F24A7H8INQR?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b6f828-bb5c-4a7f-6236-08dd455ed560
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 20:59:36.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tffLFrYkByPtmfGdN3B9MQjGTnQjdAd+l245y7rSvZISYCFeEZOPIbDojE5tCcKv/iaJZ8PF767jpVufrorWFpmrfVaSnVzTnhi3989pNg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
> 
> Remove these values.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Ah, good catch. Even if we supported live partition changes these still
would be awkward to track persistently.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
