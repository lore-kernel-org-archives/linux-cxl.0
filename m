Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA114D70E;
	Fri, 28 Mar 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743205254; cv=fail; b=Ub8J+YxSX8hAZM/JGqHeHuRAhpJ2BTCb9JIdQejfpkRBtOpdqT5gOvRRhpWXttIHOgnGtxNgBwS0XpbyIKyblqswjOsTUYWSbC58JISOHBFam5fQvj30UGDR5xpcy5V7gNg0YzuM/5V2EmFdjO0eEwkQSkBARhVGAE2PBmSlWu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743205254; c=relaxed/simple;
	bh=b1B//1NwdJEsPziUAZKgk94a4bZ6SL/VxBAEEhS/oQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWzGHDbMlkn5JdMa3nBOegA6URbHtNrbx+GcrT228Od4YAiDLbsh5lu+LeAWZrEDd0ZSjRyBdOEBJvM9n3m2QPEAlzWKDH4ntpT0JpTKe4jPeEUHtpyi9dSbIul1T7YWXNekEfERz/Sb+9yU7KFtVEwadW/PynG3TkpjJsl+wfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELSNDkij; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELSNDkij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743205253; x=1774741253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b1B//1NwdJEsPziUAZKgk94a4bZ6SL/VxBAEEhS/oQk=;
  b=ELSNDkijDI+z+6l2MeXQFAuhttexEfVS4JTX81qNodnkG6j2X8aep5KK
   V+9E7cL1+ATZ+ytUWb4GpZ1ieydO74msogM04gMO+g5qxBR9HTTyMplMF
   ye9XzqDf657+i/wJuISZfjUCxLzdmqDxfS0DNzGWRetchR0DBZnApVw+d
   gD/MXDcYpwZNwGx4m88VFBxGkaqsqnAZ3DMjAvqwx+aynFlNlquvytU50
   hJeboxRCEEu0BBD6b2xqSDISY4nT8Qy5iZJL4R/kJTHQrj82IeQ9N5WuC
   OX0WI9buISbGP798hBWx95JL2wRE7cZ+N2xQU0ImkYAHLRIKpioRds/Wg
   w==;
X-CSE-ConnectionGUID: 5Lj5lBeUQw61qWAd50WP/w==
X-CSE-MsgGUID: bw2ZO5ZvRlOB2a8K9ygR3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44681154"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="44681154"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 16:40:53 -0700
X-CSE-ConnectionGUID: BNKYFp5aT6mQK4kjECMghQ==
X-CSE-MsgGUID: 70MZKimQQomATpgpD6TbXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="130675950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 16:40:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 16:40:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 16:40:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 16:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTyzGxObFGcw6ncn2Y5CwC8VtjxH7rk+Ldpiqmw9DqUQhn+nhVuE6j3lrW7dMmF3o0mbqm8vaiZnHXWas7WWJJx4wtyaMvyYVsBkBz/GjY042vTyKqjT9FLFtHAydMjRhrKp8pN/k0FZ7FC/oDujKmPxbERkankzd+q+JwZhYAKLvl3dq3nrIFo/1sZDGu13RNaVHTfhlJAw3Dk1eQ50drcilN12pDN2olOXS+6lyKw1IFRVj0F4RMbY1ylhNRQKliiRPzWXAN+g++ldFXJ/0JPOgLneiPtc9yVAnnYrE3XfYBHXY6YyQ5/fSg8kpbtuaeLXPkiNxkXb7DH1HJuQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF2hlGTp/1mlIpxl0TZ+w5SRm7gNFQWpa94LvcHurDE=;
 b=iJ79768ETNRdo1sIZfeFvpnnzhaobMrxuNpXUUvgppbIxyUjmLWUIRTPzNPULM3y8R4sfaBpsUOZpN24FkHooJjOWUh4qsQu3S3cvqXF3jPZMxNgz/cDjmgwHRefDoRuf6g6guvtZzEwJ77DVUzXn/qtdLOjXE0RN/J7mf6/A+XtxWwAIQbCANyv3QsltxW2UVzCS7w4ysMrJAUWVLo4fkDxbHRro+FpVDx5bTW8tl5qht5A2vY8HbYd5OU27zJdcXExoHSxO+322Z2I4msqwMXEaMOYe2j+uSmXrpTH/hBD0cRm4ev8iU3h/Lv2zBGQpl9ogqRpULQpqI9K531MuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 23:40:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 23:40:49 +0000
Date: Fri, 28 Mar 2025 16:40:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 9931b674-61bc-4205-6c9c-08dd6e51f881
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wa/j00aSKpSMnmXo/e3a1G+YfqlkXOJXP3hra+YRfApRKchouV5X/ynL32Wa?=
 =?us-ascii?Q?cUUvWev2kA9k9gK5Gk8ZOxvmRUmVSMSXU1FoIvSdVI9FBw6mnOEpg7Pmak/f?=
 =?us-ascii?Q?52y31ycpH1iPGFnuQBoaJRMo1dRmIbS/+hcqfhCch6ZYz8/vVUaC24OtqqnU?=
 =?us-ascii?Q?VhS0+EzJgXpHNWbC7U651XkofdLzGdFj/FRNeyJlVspQhftx9zc1u3TbIf8Q?=
 =?us-ascii?Q?ydia0AX+jq4iEdLUgX1WdZKOZGsAC9WhTESkzs6Y7Aty/zEouPj5gXt4clE9?=
 =?us-ascii?Q?XNkAq4jk7U57Slgc1YGgD41dDyAB1b7D3HFwKbKpoGJJv8vYneHxJrpOWdQb?=
 =?us-ascii?Q?u8f3n3eLtm0fOBamKLMYk0+/w3ZdjuWCwqzsL3pBHiYBYk2v/ABROGOVUuVb?=
 =?us-ascii?Q?XZTrBRkf8s7Q86Nrb1VC7un5eOYxHo3mSHyE1PaoFU3S+zXfCd7PI7JoNyHH?=
 =?us-ascii?Q?XCJDJVDyN+EJfRFkIADvBX2cFxYJDR42w9XezWJ3G18usOcfTjwVqVeQLSAc?=
 =?us-ascii?Q?YeedUpY1lmrrcAFwekRxgnxTFyMFzX+bj4GcEAIyVeVJv3t1fJoboNLpsApa?=
 =?us-ascii?Q?ZSGOWryBpd7+6ejaigf6oEAe0kiJ8L6B339CK0wDLMneDYXXY6ZXBFeZ0A24?=
 =?us-ascii?Q?WyfOo2bfgk4AAC0rgKWZqhWiBWFvNvm9pfu+kYeX/NQKerWEZMtujhWGgv4l?=
 =?us-ascii?Q?30EkoUiIjtf5m+RM2XFST56cJ9zKdtIy4LnHNKGJnvv2wb8JB/Z2jW/dKTYc?=
 =?us-ascii?Q?5Sce7T/t/aJFtIF6G9G39dovgyM+FZgsNEHYLGmsCU9AKQV1BCwoGrIsmnJu?=
 =?us-ascii?Q?GYuS/WLaNgV62xzc6TidmHKeyCDJKqVfrHDRdvlQ0dZC7fj5gheoAtfitbeq?=
 =?us-ascii?Q?v3EOno0wJ56L0pysZX/3zBIxmIjyhmPGT5e4zMmmnMn5yJPMyOZcZ5HfxZti?=
 =?us-ascii?Q?PbVf/LoQ/BHOxhP19OSxwHftQJBnBdVP0ePwBYeZDak5wJownuBFuNbZ8Chz?=
 =?us-ascii?Q?x//AbWrZAsG/XcIS70NopjiK8wruAjpc9wfHjkutBD6ZUNKQWc8PzBMBQDj1?=
 =?us-ascii?Q?4BTVnu40nkdpDfeirb20fTCr5/1xIMT1zkvYgLBGACZ5gQzmHmfRAJS0iV2Z?=
 =?us-ascii?Q?9Lo8fmIh1aJaZQq/nod1EYVWU3hN3HRbKFZvM7oYyGpOzgUj7KLvYTphN01V?=
 =?us-ascii?Q?7bAJZlN2lI3RNeHwF6B9Fw/2mP7SK7tSYmkfPKjTTM5EQ8dujjyQ1J3IvfHw?=
 =?us-ascii?Q?LP9gnwTfKmeeLDI8gf+n4fSc7NwRKqvY+Ar5ethlaLMOu6kY8pRNFF7D0VGz?=
 =?us-ascii?Q?c7E8xy0JaJKdtSHLWFCfiwMR1JHhvZVk+cNquiK0Zs2VogaPi8IMcNg6O4KH?=
 =?us-ascii?Q?LcLQotpaKzX8y396YAu00E+BY+tX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IuAVVgVJMMzl9cojknihwr505gqB3LDTfi25tk0QWqJz2JSRgO8lv680YLd?=
 =?us-ascii?Q?QsM4/TM+4n/OTRwuf9pzkH/qT9WmuYX9Va7HvH2sYEqY18g6fttSkHeZUNO3?=
 =?us-ascii?Q?1Of4gPtl7MP6J34p2IXuzOtZCdstL7vfBZoiT1kjKbIfa9ICv5q/ofUCfgIG?=
 =?us-ascii?Q?bfkmdh4zbieKT4aihjshlAGovsRLspEtgpdsiB3/Rddw6yFl391hQ7xS5DZ4?=
 =?us-ascii?Q?Z/uR8iQ+e99E0leRrPjMuuTDGFvVCa3hu6S2kPP8YDkxxJdbBw1+6Fpw+G/q?=
 =?us-ascii?Q?M22WKgoNrWKvP9xlGUTtighKFKqv3rXoxhovJ8JKDIlbb+HmrsANTQuNhe4U?=
 =?us-ascii?Q?m4dhBDjTJTagGwFr+Zd7rIey/MDEL/WRpwdHHXVXi8Fw+apV8ZZrHvw2UIPw?=
 =?us-ascii?Q?/exALoXY0fhBqroK0M7dDbvRwBV/OnsOnCENHwIdGDEdbM10P0trdlKfv8y9?=
 =?us-ascii?Q?TD7NfdgZA3Fhx7c1ZMxBedkBWIa5Vzc6FTfcpupUfMdalWZ5+Yxr48j0jhSU?=
 =?us-ascii?Q?/5pW/OX2EiRGtCRRNqIYr93C6qlB//BajFbWj6S2m4WMwDSdjlpmkQq9vkJT?=
 =?us-ascii?Q?0zQLtvqDI3NJr6HwfVffHiciORKNOsbqvNzhfmpHLcbEs0xGBpWRHLpk710E?=
 =?us-ascii?Q?+MmI4jOoUMlSSkdxBL5BmVbk3UzeGb51Q5zP99eDS2h/lWRzD1qxpEwTXi7j?=
 =?us-ascii?Q?CF27oy25Ca9DGRXtGYd1bAnMC9d3cNM6K+l201ItrU4jUA2Asx17R4iRhK+n?=
 =?us-ascii?Q?PVoKrb+FV9n+Ad6yQ5s3KCKun8BYCYpGurKAaJPyGbnoCTyQ9HWLt7CpqrH5?=
 =?us-ascii?Q?VGFFBzFX2miaqDMO4ixBz42kjjG013msnWlIrWBfUSGchobZJQGqK4DKXdPm?=
 =?us-ascii?Q?7+Xx30eMLIOyiBtYo9ura76jC5Q9nQOlQb79epVpN4v9U7vnZXCsOX162Dbd?=
 =?us-ascii?Q?llD6cPfDzvHv9hUwoccbwUSyiIKeq7HvQufIrmBlYSskElPK93AF732qbBGo?=
 =?us-ascii?Q?X/+5u7ZOkQHsqhOwY5CKPTNHueuusOKVzvK/avYvtButgKmg+xlzTq5tRBGY?=
 =?us-ascii?Q?yUxfrHnlrdgCMWZAAOWqa6l2HF2p4GKOirtPBnkxNCTkxQY9JvMEZisTN0Vp?=
 =?us-ascii?Q?banGuTP1AZCW+hV0CPII2vCot6mz6JDPUM04pSjxilLCeONF8hANUZoC/kmj?=
 =?us-ascii?Q?9qQ+No1I0cUzZF87HYkNWwozMleGvfCgVDl7bM0cq0UpyZT8iApaccYlHcAl?=
 =?us-ascii?Q?KRdlBzGj5F9JOhHLPuZj4uMzsXdDFPxazU7gvIi5dr6Y+65flsc4uM0aE0V7?=
 =?us-ascii?Q?VLHZHH7G8IMUJH9UTNvuPKzTtap1885qY2BDMrSBvIRehei73jVbKWXbpUpD?=
 =?us-ascii?Q?D4aGEGwbRftcnrpRau/4ygygD0dh6mEn7nJfrl3JTib1mz0cUYJR9ytsQv2w?=
 =?us-ascii?Q?vcVB3GljmzdEZsU/70tPFqZZz9wak3Y4qTKzlJLqz7Rvv6PszhifmDA5skWl?=
 =?us-ascii?Q?xwCqnUxTGBxP6jDszAZrJTJvQZxZtwRgu5aL3lzC9X2LzASveJotGrfQAaOU?=
 =?us-ascii?Q?wr6K9xX7kPiHynBw3v+jbtdyBwcOJw6APZ+HVJFnJSnXK3EF2vTyo+x6Zn0c?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9931b674-61bc-4205-6c9c-08dd6e51f881
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 23:40:49.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53WN3QyKPkP22DWAoWJ0OFto0V5F/WXab+A4XOqqinRIhk1HB8JV/I3ZIEkcy+C2/o/IDMyZScx9q7zOZFJ3EjdOjV1JISurkufJwmAEPHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> to 1GB.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
> base address is typically different from the one published by the BIOS on
> real hardware, the driver would fail to create and attach CXL Regions if
> it was run on the mock environment created by cxl-tests.
> 
> Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> Root Decoders and Regions with Endpoint Decoders when the driver is run on
> mock devices.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], the
> LMH path in the CXL Driver will be exercised every time the cxl-test
> module is loaded. Executing unit test: cxl-topology.sh, confirms the
> region created successfully with a LMH.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
>  drivers/cxl/core/lmh.h               |  2 ++
>  tools/testing/cxl/cxl_core_exports.c |  2 ++
>  tools/testing/cxl/test/cxl.c         | 10 ++++++++
>  4 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> index 2e32f867eb94..9c55670c1c84 100644
> --- a/drivers/cxl/core/lmh.c
> +++ b/drivers/cxl/core/lmh.c
> @@ -1,11 +1,28 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/range.h>
> +#include <linux/pci.h>
> +
>  #include "lmh.h"
>  
>  /* Start of CFMWS range that end before x86 Low Memory Holes */
>  #define LMH_CFMWS_RANGE_START 0x0ULL
>  
> +static u64 mock_cfmws0_range_start = ULLONG_MAX;
> +
> +void set_mock_cfmws0_range_start(const u64 start)
> +{
> +	mock_cfmws0_range_start = start;
> +}
> +
> +static u64 get_cfmws_range_start(const struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return LMH_CFMWS_RANGE_START;
> +
> +	return mock_cfmws0_range_start;
> +}
> +

cxl_test should never result in "mock" infrastructure appearing outside
of tools/testing/cxl/

>  /*
>   * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
>   *
> @@ -19,14 +36,19 @@ bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
>  		    const struct cxl_endpoint_decoder *cxled)
>  {
>  	const struct range *r1, *r2;
> +	u64 cfmws_range_start;
>  	int niw;
>  
> +	cfmws_range_start = get_cfmws_range_start(&cxled->cxld.dev);
> +	if (cfmws_range_start == ULLONG_MAX)
> +		return false;
> +
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  	niw = cxled->cxld.interleave_ways;
>  
> -	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> -	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> +	if (r1->start == cfmws_range_start && r1->start == r2->start &&
> +	    r1->end < (cfmws_range_start + SZ_4G) && r1->end < r2->end &&
>  	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
>  		return true;
>  
> @@ -40,9 +62,14 @@ bool arch_match_region(const struct cxl_region_params *p,
>  	const struct range *r = &cxld->hpa_range;
>  	const struct resource *res = p->res;
>  	int niw = cxld->interleave_ways;
> +	u64 cfmws_range_start;
> +
> +	cfmws_range_start = get_cfmws_range_start(&cxld->dev);
> +	if (cfmws_range_start == ULLONG_MAX)
> +		return false;
>  
> -	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> -	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> +	if (res->start == cfmws_range_start && res->start == r->start &&
> +	    res->end < (cfmws_range_start + SZ_4G) && res->end < r->end &&
>  	    IS_ALIGNED(range_len(r), niw * SZ_256M))
>  		return true;

Someone should be able to read the straight line CXL driver code and
never know that an alternate implementation exists for changing these
details.

So, the mock interface for this stuff should intercept at the
arch_match_spa() and arch_match_region() level.

To me that looks like mark these implementations with the __mock
attribute, similar to to_cxl_host_bridge(). Then define strong versions
in tools/testing/cxl/mock_lmh.c.

The strong versions would apply memory hole semantics to both windows
starting at zero and whatever cxl_test window you choose.
