Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9D218AB9;
	Tue, 14 Jul 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057496; cv=fail; b=fabh/NJVN9s20q3cRZXp4uSwhJc/o0viWYISUChnvuw66bu1XFW5c0B7hld33EfWbIAkTw2QB8vxjyiZdQMrOvNekK2siLO+KmHQhpqUvb2z3QN+h28bsjDFSYpq6nt2HDa/5FGuPBR/hekhDAOdqnHwHbVRD7zO5SON93rJ920=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057496; c=relaxed/simple;
	bh=IbAvSEEE+vWw7mw49RtpEf7Zxww4sLCESz7YYWYnyhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDHecLml1RY0mhbYlw7T6ARxIeAEuYjDc91PGqpJ7YiLQK1iF6Hht9RwLTFw0LenWk+/FusUJj9JGqXYJsr11wm1kl2Ghp88XFrNLB91H1ZdF3seilxVCdRxm/TjFx5BsUFl5MeT0MYmcUk6TElYUKWT0OEtkMXECHGXwPAqQxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iW1KuOhX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW1KuOhX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784057494; x=1815593494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IbAvSEEE+vWw7mw49RtpEf7Zxww4sLCESz7YYWYnyhM=;
  b=iW1KuOhXPbo76Zx5RvuXhqGgM7YoXQW3Glw00W+phMG97U7g10iZ1UVh
   eWcvkfk6CijZAKvWkTq/3CMQXn7P7qb1onDkf6jvWgIf/GYUs6liHebEt
   NScEpiS95V/3p3PsllHktxyC0gSYAhPlDgSLsjmetp7v2/MwAmXr7pjvw
   0MfqMYjdTPDh4EvVjyGifAd88J5UfgLXls13Q8SzCrPcuEL55WjBq8Yjz
   rDegtYvEeTDvdBXuXN7t0Bnw83evc46nJz7SofG4spHtXR/QZzjTmkN7t
   Hz46IF5wlJ4BHmqkp2Ue74FWD1p1uYvfnJ9OK+aJMhMX7HrFE47m8iu7Z
   g==;
X-CSE-ConnectionGUID: 1+gWm0v5QYOgUk4/j++3Ng==
X-CSE-MsgGUID: 7fREWAzCTQ64XXMZVFZvbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72213143"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="72213143"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:31:34 -0700
X-CSE-ConnectionGUID: d9Z/W1OvSfqnGewUbjhR8w==
X-CSE-MsgGUID: DsfzI9bQQ8q5fS3wqpgXqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254213649"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:31:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:31:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 12:31:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d++lKC6z+c6V4BS48iQd6TwUZZOO2kVxNba+sR8WU4ZW9yWhcRJmdB6Rh7jfcb3vXxxYOGUPDdFFFy3hMBDaiMNPS7xxYEdrITC2jGVtvI1Z4lJRBspbGby1c+M2GdoSENH9MXtCmm8c7Wjo+QjGYAL8IPf0ZFaBqKcdLmVgmP72qPkUZvQX3NJVdBSd2fwMdN6Vv1Etq2/UtFh43Kz27guIEOvx3hQogj/usLPFc+/3tpkCz0rld3ey75DgPdIRW1GqulRsgiXmpv3OP6WCpnXerj+WwSaPYLwqqZL5LbgWJ2iuj/spdZsrsibbUef0nRVUo/OtX2t7RBsbkdr7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aARcMHk30L4afkC6dzGhySzjFqzp4UNdC2KX2RruGXk=;
 b=JJ3YtJxGxgjApQTvMpAQwfHhIoI52AXAkCW97cALh0kBp4knz7EaYxnAHO2DHVr1rIqLKEfeHjrTuVd9t5I8e/sAZwd7wwopc6WoBVL9wiSt6FGS7J+LnnEIRefLujWvO0L4fU6N77dKWoHE+DH/hs4XNDZfiJlzCvQFSj6OGnctXnVc5vt28ua8D96krY/bKLDBFyPlkGk10B96wSN2fadvWbu+JzZVw2QbpYUrGkAR7L0L+AbBI3RmGtW0twPP1nGf4Y+P5B02WcyVcoh6ilJf3WkuM7qYVDA+AgsdrkB58gr92+BKGoGVa+g0BbG+BpB37kV9iEGheiF2NNUDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8395.namprd11.prod.outlook.com (2603:10b6:806:38c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 19:31:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 19:31:17 +0000
Date: Tue, 14 Jul 2026 12:31:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] cxl/features: Clamp Get Feature output size to
 the remaining buffer
Message-ID: <alaOgUpd1bhlk9HR@aschofie-mobl2.lan>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-4-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260626104102.53892-4-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: b55556ff-37c2-4959-d4ae-08dee1de79c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|4143699003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ooIpEOrKfzOIYp9J6tsFqIHxqOWLyt7T0BVmLv9jSpPe0sou5ne4wTRwO+KL6Dpan/l0L174BChGvKrRjSKDzGzl0XysDQzeDwMtDKnOJ5fH2x7/QtSLkViFyAxmMu9tDYvfbGDNtZL/bzRWavFzjnbMEash2G1FeWk42A3ybJSiEdJKsEYR94lyKYtn5R2ckplH6hmygwD7IP65455xsrhseKeMdEQANxadfFEIHBSnoX+Hr82yF6hk/23oLlmtueEnLGfhllJizSfY30pRLH2NwVrcG0pFkTLLzKDqGXuzz9+G2bucErgIDX9O/7ETrA8ie5rPuO97UIbDcJIYUed0AJrNtBPYNONVADl+4x1jhJ8vI+a0rtPa3+oOvOT+hPrjMhR58uswyGbscJo6eNZgrVTOOQbS4tk8eSPTKFX2KaeTzpYJ2vILkA+9tf1C5LbdyY57dfoy5Jz+mAuqq9CfIl+RhtmkmxHeHclkjAfJ49FUWKCL3e2Np/LrmxoKMWvSU31kCBN7jWTU16z7hCbR05ZuyEQYSKbtt1aLw/LvuLaeCMJNUevpEeCsxj+jn0l1IegvI6+jB2D+iUFO3/4PfTbpaQqL8aU/AFrLH4djbH+p8NZsfd43rGThw99MPNSbqCwzGhBCN6DtzjFwtm/eNFyvd3j5xFIcDtrXY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+jKZTdXO0u7DYc0bEZM9SAAOoUT0klqjJnFpgkeevkop7qRdutGnPvY6OqZ?=
 =?us-ascii?Q?xUrviFys2hyFbbHMeF8uvXJs5nUdXEKLugwwj8qWq3jXFJaYomYWXdNn/WI6?=
 =?us-ascii?Q?gpVTQ6nnASRS6Ce6wKubR3mX7xvDG1xhnTEbJTa1uXztTwBN6XMTccFkRdu1?=
 =?us-ascii?Q?e70Its/oHz97Akk6nmNsA/k0Ejby/dbX4pb1BKTzwM79iq7nSLDM4q+LxUY4?=
 =?us-ascii?Q?kCP33MjbWL+rN3YHQ1QDRzjXVVWx7/duOh5MKrwa2sucMhikU7LPhClw1BUJ?=
 =?us-ascii?Q?AIYM6f9tvkboPLpLANDDJh8fwpj9RBrgYxgCIvR+TJIVtXVSryUlo03Ce0qh?=
 =?us-ascii?Q?ZJYT4oKOQVoX+pzT5Tl4BK5MOF+UAHSrd+ewAfK/+EHtzbNdI9mpfFOXjbCp?=
 =?us-ascii?Q?OdEQe/6u7bt9iOtKJX1CIBw0xBZjUrJGB3HX2UHeXfrOk0aKsJibbcuYipgy?=
 =?us-ascii?Q?cehfnHVbR/IJyzA++UlEAQ9QHad0l0XB0vAdMXIq537fRHDPhXsD8khPCI6G?=
 =?us-ascii?Q?OgOuAHhNl9uE51XD+WJgFiq+M2pGM6xZaDajIVAoBjKFwoJ2hMQhMLL7N4Qp?=
 =?us-ascii?Q?PIsmR8291Nhuz8lz0CpPmITZRs2w3LByKPZ7zyGU2gKv0VS82sGTHNNlZRgr?=
 =?us-ascii?Q?orymtj5fJRc1EDQOb7C4wVi/7liSSChMlg1pKEcZVM/mHNdj1D9NrYyQTswD?=
 =?us-ascii?Q?C/DuS+hUy7erNhjUEA6NKYSCWtUQJc5AGyTBe+rC+CmsodLuayNRAGqljPsK?=
 =?us-ascii?Q?22rMhFCdRxbziKrnQRK6WTbxHmJjSBc3/nOMrXPf0us9x/0+VmmDK7RjWaUt?=
 =?us-ascii?Q?7DgLdn9rGv9UYB9+RU+XsuUGt/l+8rK4haJfVqVKWGKnaqMwfZgYPyxhs/qt?=
 =?us-ascii?Q?e5SpNRfcHea3zpRxvZEnhn7zuZWZ2loyX9+6OQoHH32iNPHgt5tMKxl+uAJr?=
 =?us-ascii?Q?VaAgsF4qpMrd/zwOmt4cs2h/IsC+SzBx4vo1dp1Ejr7mNVGG6Jd9LZwngYol?=
 =?us-ascii?Q?oKf3KwJb7A/S4NFkQ6v/AfPBim7C0COZGTCZ7tmOVbTE5FoD5+EENmjylkOd?=
 =?us-ascii?Q?bUeVtpDA0QHPMfQCWG+qqoCTpHseeiV5/xA92GmTDt4yrcwTjTJSKi12tOWq?=
 =?us-ascii?Q?thzHvNNDeFhoqSIolPC3KLyxbs/Jjs0MaD37bbLuGUieaTbsM7M95U5gJA4w?=
 =?us-ascii?Q?l5bIQviHuNxp4e8rpBByXK7Fp66w3jxi4tSyWni7CTjCBrN1n7cl4/8XcEvi?=
 =?us-ascii?Q?E2pXdpOEro+gkWqLVJ3ro4ZMpjKLHcL822wEQlxQJxSe3Rprn90sKHL2/eRE?=
 =?us-ascii?Q?jcqC+adymfQlwJTL9WsG7BqiXowOxOhtT1vEeNWSl315GyzUD80Lz4Gb4hBj?=
 =?us-ascii?Q?IZW8YbjyV650t/Q0aVUH6Q9BXyYpkCZZyQ28BHQcVbN0FfVVpZs4TwiBLoj6?=
 =?us-ascii?Q?bT2p8wzxy486go8sTCzkHEDO9YhHm054rhb7TZZywaWYIX90LE7ylGO6pMy8?=
 =?us-ascii?Q?w3gkJfZdQTpLpHQSKLi+Jzvn4mYxxLzZgP/5E2pIU2HqZatupcyoVXSKgg4W?=
 =?us-ascii?Q?EWWVqV4zE2xzlUCbCEUL2ZhpXjFXATehcDwIZSJ27NXzULSqztovCe5uFkHG?=
 =?us-ascii?Q?8mDqsxjAABW8f7y/LYBrbwAD7Ek9UOFgA33V5iTm6nkAExySKZqkRqwLIywg?=
 =?us-ascii?Q?rfhPkE08kuIrFnkTdIggHxRpm4gH7Q1KmizQ0AAPkdH+onDfWcacdfAr9asi?=
 =?us-ascii?Q?Qk7QOd55gwa39JQ0gSfjATs1a6Jh2mk=3D?=
X-Exchange-RoutingPolicyChecked: fQoufpNZg41m0lPI84+9y+jfIfAY5bUlELlViceC7RRzH80y0mOPW6UClw6Cscd2PuVZMCWySZTzfg5Cpk5dp0smxqSSorS2770FwXAt82LHOgR/Ce22Iw7vek6AwzDIUmj3DK0lp840UBtDMkM5WO+1Yc8fdrNnfGrfrqVcKCvoZhhGG2tn/wi8hrENithm9xDMxry3+h1mOpjHQSecjLo1DaEPLfFT/HdLCqkpDt6BzGTaZG05nULbFQIp94vi8o/ckS0LmfJ6bguiJQ+6oOHzfBoeWT3lByFX0yHX75SxlQKPpP8e7MYjK+lkFR2/mtyxv38jhr32mfr7WvH4eQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b55556ff-37c2-4959-d4ae-08dee1de79c5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:31:17.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c//9bgM+bOWl4P6AnErQmNM6dnG0MuvmXFrsGfHGXlSPip6mofDE8qf+j5jFuQy79cG2WQd9v85CkRcnyX2rgdEP7Neqj/sBrwyXhbk1LY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8395
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 06:41:02PM +0800, Richard Cheng wrote:
> cxl_get_feature() reads a feature in a loop but passes a fixed size_out
> as the output capacity every iteration. On the last partial iteration
> the buffer has less room left, so a device that returns more than asked
> can overflow feat_out.
> 
> Use the per-iter size data_to_rd_size, which already tracks the
> remaining room, as the output capacity.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

