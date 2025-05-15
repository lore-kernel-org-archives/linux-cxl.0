Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023DAD51
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329319; cv=fail; b=O8RI6vCVSn4ewJHX9JPGkBIbBXj7AMjcAzF/73kE0HV98DewxV464WJaeovReBHLx6m02OiWKmXiFSMsRsxW+KYrxzV/6NQN5sHIHAbMPzDfTkGiRMQsz7unqay/0rgI/1q+MOETtFUIU7Gz2GZ1x4YLWSFc4uurVJ7MD/aEYXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329319; c=relaxed/simple;
	bh=ywgSyKDtZx5RtkUyKVMCeZPY/RfLiTD+LOjbwyn/nnA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K6bnEfmP5XhosC5p5jlaeA7qG6GFl7Rtf/7y2Mfb7FeQGl6WgooZRH8a11BUQ0HUxJX4UmzOcuCNJBdAi9pq6Xvv6IjQzihDritWOhNv1+safxZWNAzEZBfqAacrCvzhZEbB2Tpj9DFSdwGVWseAdWtzlO2lsDjM1uLXN/Vyhjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRc1ZOAR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRc1ZOAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747329317; x=1778865317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ywgSyKDtZx5RtkUyKVMCeZPY/RfLiTD+LOjbwyn/nnA=;
  b=gRc1ZOARdUymhncZRj2gIFooLxBaEQxzbKik23s8AoXZdEH3GkXPCQze
   T4xaML5kZf1R6k6NXjc0+0DoGAFBqvQnAtLoclBcN3bWAzfM+M1fJKO1J
   LMs/p80gpqXDda3m/726cchoPqGKdoQDDoKkpK23kGA3+KdhqOjY5C/PX
   2M48ar934CDuRoxI7f/j3OUKgX84x80Ki/UEaHSVKdaN4oxJO2CXsolvg
   Sax28vWZ8QtSNQzFIp9FDruffeDTYumKdl+fimvd+G7z41GBdbx+WJZA1
   bgmzdtBiZIuZcdt8PsyzK7o0AMOQ1B1is5D1DkzCidnMIoHXTNOVqRf9X
   Q==;
X-CSE-ConnectionGUID: iktNMVjWS8a2WtM37hRzYw==
X-CSE-MsgGUID: UNxDXJMCS8Ghs9OHrsBvzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49265774"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49265774"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:15:16 -0700
X-CSE-ConnectionGUID: t6ICCDTVTkaahXaAnw+dkw==
X-CSE-MsgGUID: e7fPl8WCTcurr7nlN0UggQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138309021"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:15:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 10:15:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 10:15:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 10:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7G3kX8ZelJAcSeWPE46p6zGrQrOHh+OjBhZOKz0KG0suPHV6mamGraScvdf9t33t6RWGpTd6aAw8nP28iN1C34eTA1tXCfdjBuzreDOkd86rJ5fh/P8WIOdBm93BxjQS6KxjFTo1iD/Mx9f0439MG+/3nBDkbBEurcD2E2P0wJ+g/9lM1HVO5SsiTVHDaiKg8bqlHtM3t7vjIfRrGvJ2/y7ubHQLUU0nuiIczRzKJIamSIVvmTLs3DZPzuFHMJJJ76wLiunRWy/7gswocNGY9SPlCwXFllF9LoUTFHMnA+qpbrOHeeoKeYzW9OVHh9dJ6JHG3O6Aig57UeGG7A7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRsURAnEwG3zAie5bHbFdK+LBa1UTRfM+hhOhhOY6M8=;
 b=fbgeeZbWPyjfF1t8ScqQdxqoYmNRfEiMsO0Ck9AAHgAjUrihrptbt60Wd+Gp6jOt9IeC0IMK6OBO87l4N2/q3y/JK3q65lkpVXpo6X2LkWTVV9ifkSbvmGHDbm0IA5UFjUlIICyM1y/eNaHmKz1FGMHGWGVx/WPprqRpy6TWGBfMQuo3PjTjYynW2lsmyLgQErWaRH6Q/hXgUj5QPwv2CHgSKBwdYp2XVq0W51WMntURN6Cn5SihCaql4Jcff/wOooRA8cL2jKIKHl/jq7fiHha0fvdmYJvU93iAxizCqSfj5V3u2ggmVFrWWRbp7zv5gUcO5ysMRzIYwkDgkMYmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 17:15:13 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 17:15:13 +0000
Date: Thu, 15 May 2025 10:15:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <gourry@gourry.net>
Subject: Re: [PATCH v2 0/3] cxl: Update CXL documentation for access
 coordinates calculation
Message-ID: <aCYhFjRzZNNlFfvJ@aschofie-mobl2.lan>
References: <20250515000923.2590820-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515000923.2590820-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::25) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: f0336303-db5a-44f2-7889-08dd93d40da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ckg9tHkXH4G/gNcxZaktvZGRoZHAwFKzQPzayGXbdJ4AVsRAVVXqfjvSrrE?=
 =?us-ascii?Q?tnQebv8IXdlLnIeebdJNVARR5U4S6uVz4nYVOfZzkQpBAJyIFNMi6LV9HiGg?=
 =?us-ascii?Q?chrD1tJxx6hiZHCHlvCM8aCUl5WZSscdQGTNAUoSlN1dk3qCKArK7O67gapx?=
 =?us-ascii?Q?EiafeK77YgwyUjlU8+z6ok51Arv55KAt+VroVdlb2QuLcVSnX/AeZ0mshTlg?=
 =?us-ascii?Q?da/Jp1QnjEvAfiLm0e7K4o7rBfCqOgQpnQ79onXRV1CVtbg2Fp6PjwyLv6d9?=
 =?us-ascii?Q?qkSAfxPUUJA8rqe2jRHp76qBP1uLIer3OwJwgKJg5O7JCkQpxXPfdWrJDkur?=
 =?us-ascii?Q?lSSY0zObmjmyI5pDjaQPLPdH3n6HgOd+tTqNDn1ghnL3/nMdK7zYPRj7G/1q?=
 =?us-ascii?Q?2z9cWZazV2ktnyJT7n2VW4sEN1tTuylD4cUlZRThKd96eU7o6ryxrMPOQH+L?=
 =?us-ascii?Q?s2AC9OAf1PZYGc11Ex5v1C6C615j3/EMFceOge5c/7mHdnxm/u16B6sW8sX5?=
 =?us-ascii?Q?8JuU4Rra/ccsuhj3VWdiSPfjz4LcKeWrnX/F+ABxfGOllIF7mm/Lem8asiV8?=
 =?us-ascii?Q?MK0tJgIXG1MThNJVRLjCU0kJFXencFgzh34mlLF44Jq4wG7A7e6ssgJU53Wm?=
 =?us-ascii?Q?PqO0ZWLmFHhEE6b8i/ysdLDVFnVSM9ja3FA/gjeBSUV3tqaZ7nVamyDOgz8l?=
 =?us-ascii?Q?Akfa3r3Qc0W2Qogz6NqFzbP51DBqRnjQ1BKKD0a6dIbVW6B9dTHdOSvSXx9V?=
 =?us-ascii?Q?SElhrHrc4ofvpUVVaUwqdgqtfaY+5bgmtbhqPb7ew0COmVsm+UDPDYjgKwXh?=
 =?us-ascii?Q?/vXtMAxoLzQeu7FKYsnaHEPiY7RGPKF/dwUvqil9YPgWRS9kv1QjqhnzjOtk?=
 =?us-ascii?Q?zr88zUQ0SAltcAClbbu2CuFrkfpCKkHsVAvWujbpvr7mwfx5UFb+WeIbgAo/?=
 =?us-ascii?Q?sLw1qJ7F6jCtk6ZZXYZ4pYbwTvc4bKeBqURTzqN9XJ932puafsVXY73AvDpp?=
 =?us-ascii?Q?ZR7590Ul0P0lRON4ypvDLAl61hc2nfGiqdsyLbHSxdGzodRm96GYEOJqDmbO?=
 =?us-ascii?Q?iIsrsWo9VLcU1hTbR4XE4M9FxJRSJcAnaIvVwWyPleNxgI15ANaoTaPcuMKM?=
 =?us-ascii?Q?+4NNJ05m+SVdF5+PeNgS5M8WD532p5715RCTza1GKMbZz1BeVn/Ks2qeCgbd?=
 =?us-ascii?Q?+y6f8uOiobynS1czjxiLNOrWMHJyx6YDLUNBsEAr3mfps9xYWcwlMQn+HHvU?=
 =?us-ascii?Q?DAWjATirzqhxzt9LpiGHH+nhkVuQurzTH3UV7F7nHcoCv7gqo9D5tkZIMrxH?=
 =?us-ascii?Q?x2kLbFb9s9AzSPS0htCxikf+Zm+M8VuprHGjRZp/Huu5yvuNgoZcfB9Yw6BI?=
 =?us-ascii?Q?7KGeyjbtlnfuzDnxONZ6enwYwe/4MhDz7320FFQg8lBvDdeoLyNZxTB1bqBf?=
 =?us-ascii?Q?Tpq4mIadGmY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrSZueMuWLj3CPKuDXEPbuuV/8Hdiz6YgW3aAFSVE3zWTcFHQYuBDgFSMiwD?=
 =?us-ascii?Q?39jZvIP9zuNlQWyoYALolnJ6ouAv/LG5QWsbVzvs0gkFOfmc9vmgzS34OCvy?=
 =?us-ascii?Q?2m5p+dlUCtbRN2SrU8YMMZNWIZqH7HbRORlKG4GB3AaVT+5pLsCl/GAJD5kd?=
 =?us-ascii?Q?snTslWUu6NlShQUhrqvP0aA1SlpSuBXeZ1+xVR3ELvnxMFjUyV2IzDPi3omr?=
 =?us-ascii?Q?HCF3h8MhyJMHrp+Mwup04gbP2oVoMYkTevzyLwSrhw5/yFfcWtBQkfe/+ULI?=
 =?us-ascii?Q?c56ApaPvxgYj4n1gnBDYaK4PwiuKkXliD1fUUpPhNWrvtTGSNWdRnbBEJp+Z?=
 =?us-ascii?Q?IUuMzlOvbVpgVWSCz1WS4F+SFafddBaVPxOrA2Yl0KtTUgBdpSNa4Lo7yNKc?=
 =?us-ascii?Q?hjywZVVNXTEniqoUDf7k/Kdut9ezBqr99EY140du0QebaF3q1nTB0YMaQbxX?=
 =?us-ascii?Q?mfm9/Xy/sXWapmr6sj6GRRuwhO0H+/634GahMkNBWotsc/4KT+4GXkpoBhf9?=
 =?us-ascii?Q?xCy5CRAV4la0Bei1IFG9QNjr3sgxgxFveUn4TjyExsby5PSQBDBtiYmHCq0/?=
 =?us-ascii?Q?g2zebvkKrF6Sj5z/ut0Rd5zwOvgDHTe4Xl/qLRIfax3bwa8cmsEF672+1jBg?=
 =?us-ascii?Q?zD66se9xOFGxOl3g/b9Af9inR5RNK34D27PcJz2V+y03Opj30/630P0t/SdG?=
 =?us-ascii?Q?zCanjF6YIrc81Dt2iLE0GSBhl+ipjDXeLtLJdiffQjv7lsq8PpUqXCaPCgR5?=
 =?us-ascii?Q?EV+rzxabeokQKXENGQ5vLYHv/x2CKuubh5SWUZ/4ZJ1X+Sc3OnjhBgzY+IxX?=
 =?us-ascii?Q?8GRLGY+o/Hn8b+5EJUshuWdUtinqGcXz1DLk1a/CPHBBjtQzcbCD5Vpvh2Mw?=
 =?us-ascii?Q?gRLeyrm7qxQ7pB5ojq+GF6h0auGnZ+4hTCYJgTziLDGZuHrjpIfWlT9pkR4l?=
 =?us-ascii?Q?vIKEfTX7fa/eW8lwc/1SdPrhHZjb2rvbxwSqyYGffOGP/KiaqXRsBHy7QPjF?=
 =?us-ascii?Q?0WBYy9K1S7VhOqDKM1MFiVxwlb2BK+OpyOnJfp/4nwwt94ik049QBHDeZwaP?=
 =?us-ascii?Q?bUsgbv19GDpaCeULBONvEDgc3s6I2sUY9VaNW4EN9DizqrveYgl2xFJN+Iol?=
 =?us-ascii?Q?+MpbEpFjX/GYML5hzl7Huvw9dj08DbS5Ie80D8hCPW7qO+U3BU+aCi/Hzzmy?=
 =?us-ascii?Q?WLcvNXonUu/0no/zR/UFsl/MLFr5oBWVYDTe6+koqfnlX+wOdmbUAlaGARTf?=
 =?us-ascii?Q?A4IgntFxDNFmDHzqIM7Jhnk6Fa07fHWBXMlhJNaZvfirKKqUwBGkU5HE1PEU?=
 =?us-ascii?Q?ONxYHviRgvJgIIcTtsYRNgjJIpspJZXsyh0PRSORzaOnCYxQ48V24CCcw2Vv?=
 =?us-ascii?Q?mFYesos/2WANg8dUgGwzqj7PWeuVblQEv7UJqv+XnATXsyGTOnEqBotll9zu?=
 =?us-ascii?Q?ddDgOL8pk4ZJtYAQI37oLQFeQLqnijs3KWb7MEPg8jVEqa3MZ2v05BrhU6K9?=
 =?us-ascii?Q?Z/NjCUma46WV+IPpa3B+2L+RxtZcaUGdFBwUXzldPNR+neLQfe7Px+ywQhPm?=
 =?us-ascii?Q?EcPdTUuWaM8hN5FznwTWYSFbI9DrlkAxy18NwcDf8YFz8kn+MENs2TLhKudt?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0336303-db5a-44f2-7889-08dd93d40da9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:15:13.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD1n5njXRUNeLQ+LJzosAt0HclbGkWlS8ynj3/VF3tmMx7476GU8A6y8OvXnvv0wGt6ZToA58m2uJbBj06+n7GD2I8skem3NmIf0S7F/9tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 05:09:20PM -0700, Dave Jiang wrote:
> v2:
> - Language clarifications (Gregory)
> - Move all CDAT bits into single document. (Gregory)
> - Define CDAT terms. (Gregory)
> 
> Add CXL access coordinates calculation documentation including CDAT details.

I appreciate this documentation and it makes me half-smart on this
stuff which leads to my possibly annoying questions:

Say I have a BIOS defined region. Can I look at the result of these
calcs and see, or judge, whether BIOS set up the most efficient
region?

For a user created region where the topology offers some flexibility,
can a user predict these numbers before creating a region? Can the
user create a region, evaluate its 'perf characteristics', then destroy
it and try another flavor?

I realize this is internal docs on driver behavior and not user
space documentation. I'm looking for info to improve my understanding
not suggesting this info belongs in these docs.

Thanks - and, for the series:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> 
> Dave Jiang (3):
>   cxl: docs/platform/cdat reference documentation
>   cxl: docs/platform/acpi/srat Add generic target documentation
>   cxl: doc/linux/access-coordinates Update access coordinates
>     calculation methods
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/access-coordinates.rst          |  86 +++++++++++++
>  .../driver-api/cxl/platform/acpi/srat.rst     |  27 ++++
>  .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
> 
> 
> base-commit: 7855bc1362518673103bd9357827572207e6f6d9
> -- 
> 2.49.0
> 
