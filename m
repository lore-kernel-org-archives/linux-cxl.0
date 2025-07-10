Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F923506E;
	Thu, 10 Jul 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182704; cv=fail; b=VsssyLL9lw+/3pK77j5jtNhNt2daZj3EsT2WsLNUh4X34BpLbi0lPUCbXn9E38e/aHr75GWbmbnwavVvlU6ph8JDTen0IftM1cA4umhFZM0vYIhm2UWqRkVVs9zNn92XQ8QKa41Mu16bvf+WlzygMUZ5qkKOUCLUVuWNtqyqW/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182704; c=relaxed/simple;
	bh=iiOIzTAobFTkpJ1l4WcCtyyjf63SORQeL7NfSGae3Ew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EClyZR4H8tmMnjQs1YXtO2iDJnAXzR+cbTrEt+opVAog1mEfZn3J25fVRU3bP/SVHc354x2LuhXPJac6FmkYT6hf+BsbFjHRougF3+a2ND61INICk/XrDTKUIxlTSbJPWS81qKQD+GORuuzy3gRx8PkYF++w7yxnjJ0l3zbl4DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnNX+kY5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnNX+kY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752182703; x=1783718703;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iiOIzTAobFTkpJ1l4WcCtyyjf63SORQeL7NfSGae3Ew=;
  b=SnNX+kY5rlAWKjPNOO5/uiEQtJnZeSDKNpjt0KeNO77J9ePzyDojhwKH
   AAWvUQgeIBGzpbdICkxI+JJZpPWHqwd8hyKhQ/2eo1EU7tmcQJmlzHMJ0
   Ka1rAWk54kdoYyE88OYQt7mTTfInS0SYoCBi3NnY+W+Us3mtJL3gZmWU+
   u0arMGCoFfnnh04eeBPJETss6shXRVH2LYmtY+g+YAhGWSfTXvzSp8mHl
   nqrJsPYB0Z45sa68yHwAiSht0vKn2iFkvyNS7dWrF6ZEN6QTly/HO17Aq
   s2F0OhUK1OZ7lR7859KpbNaCpkV5JFPhunhqZw0a03LtLv+atNqmFEh5M
   g==;
X-CSE-ConnectionGUID: aFS0FiDOSl+9inW1e1hPBA==
X-CSE-MsgGUID: JYNygZV3SCOyAWttrFLL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65537409"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="65537409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:25:02 -0700
X-CSE-ConnectionGUID: uAEUKGO8R1+vZxasI875iA==
X-CSE-MsgGUID: YBoJYHmiQ/S4CpAN9E/11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="187180018"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:25:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 14:25:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 14:25:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 14:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR5AksS9zCKjB8NiE/N5+LchLMCqMP769BgiQ9cIzIzGJYt/jUnH36rpRZrWLHL3CbHNqceInoo7GWYcUMvY9/nI4KUsRKahGZGcmW+mfUeSh4uxl1W2VQCx6KZsTTc4iRdHN4oEtJNbjRUtRCvBkxRe0XjLePm/hHc556Y4RWthbgP5Wk2BQTqT7V0bGa9bM0+Gi3g84hK/zzSYC1MDp/uyLMfwHRmvjqX/ps5GvQjYhsgUJypepHtZ31Dt09x7Li5LRifkRVenAOyse0suVrA3SXyI19xl8nE+iIgP90KuIm9o0L4L05HYn7qyuh3j3lSP1pL5aerAkt+wM2nDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHtI1b1kGGx/R/knW1wNuqEcrZBBYsQP175hVSeRy1E=;
 b=QVosEHMeKX6EOgRcS8qgGxwh5MxNPgz6uVfqZXEw0VubPe4ydzVfwZcpiqexjxFM6X2CTOyb6IHQ3uzYUN88fwoDMIicMSLUB7fbq6j56f113vvoBrgl+/I1epcKItJ7t2pjHDGoRooesAhPxjmmthb19Xgrta/Hs49/D74Ka0sKJddAuPgV9AN30+GtrulSTGEQKnLWVT3n1CpeLooJ01MC5RHDXsMu9xX76gu1aJLu6il0gYqL2qXgZkp/9p7Cy9B0eLYALphTz/EexLilzqZu5zeKubZeSvvFEUyDWSfNeJyi11Lz4wZJFp4qu6kQqoo+3DBspbdoV/PRf9MAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 21:24:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Thu, 10 Jul 2025
 21:24:58 +0000
Date: Thu, 10 Jul 2025 14:24:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Message-ID: <aHAvpvUQjyuV_cow@aschofie-mobl2.lan>
References: <20250710065647.98094-1-ming.li@zohomail.com>
 <20250710065647.98094-3-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710065647.98094-3-ming.li@zohomail.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8f02d8-b3c2-4870-617d-08ddbff838eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JDdUK77oJuFsMameVhTpm0zshcEuDa1E/+4dRNnTIrtt7FLSvhPg4dpTgwIH?=
 =?us-ascii?Q?VYh+N/MJ2jbAk4LN7f/7DEOHE0+vOgoIJ4taCILfeYX4Z1OAgWMcEuvnSiFI?=
 =?us-ascii?Q?jK7A4DzYK5KFh8ZC7vSzc1PT9u6IUe/XY6pNrgyU8XtJGcHN/qRsfa3Zfg7+?=
 =?us-ascii?Q?aSN404AW3yhuPQiI4J+f6svc1cvA8WHsvyayufiPNkyrXdpwfGRIJoc3N+cU?=
 =?us-ascii?Q?GZby2atY055dxHsm3I3rn+KR06a4BusYWJf1QdJ2V9R2dgO3kPcIP7/rT8vS?=
 =?us-ascii?Q?jPR0iqULwB0ve79LF8Xyl0ERHnwf2/ZW3LAaJeUcXYf1YmdaQl6gzsx/YINo?=
 =?us-ascii?Q?VUYBZ8+NRl6O6xVgxSlYK75O4UWbs/0IyUtg3D03ObJjCP1CfAOvklGRcG84?=
 =?us-ascii?Q?hkkDLTsNCi7ZnRWk9m1CgJRB+Jv6DQmlJ1d+LBg3gp6/+iT81HiyVs4K8U0l?=
 =?us-ascii?Q?SKlhfA5YNfHsE/Fk7HD4wbaiqdiyGTPZZOy6U7ZVkd/UU2ZulfvphfFPWcb1?=
 =?us-ascii?Q?gcx2mjG0eOVNpRpObi8R3mTlJJWR8rCoFkC8vXPNtQR58TWAPazJJZdT9not?=
 =?us-ascii?Q?4WOi7V0OvOgE3h8S5Xk2hM/tJeKiL+tBkjwgFWTxb5RBbkwRuqYzS9ZZCPZf?=
 =?us-ascii?Q?Aw1X5A2tK0AKUeBHALIr/qSRK7YE7SShhPyNf9VwgFyzjf990YRVC7KwEvxE?=
 =?us-ascii?Q?waVMJxxf4T3U6cJkVSLmKuBREGQrqdw3vmY/wu9WLG56eGt1MMFMzy4MAFf/?=
 =?us-ascii?Q?WL5SmRLOKIAyBYnPUBOj2tNug45Ob2TpYxDdpXOW5Lmu4qd+EQSbhcvIzU/p?=
 =?us-ascii?Q?1rY2DWhx4GK+aOZlv5femXP+jn8FEn+IXChRdGqCNy28GPfFIangPXDU2+Ru?=
 =?us-ascii?Q?Xp8TdmTP8XDxiLoqmsoCtPaPqEFlSFipRUsiRjOqT7d1owcMNl7W9/jXFOvd?=
 =?us-ascii?Q?1fDczk/zKiaDfKr1wxb0etoCg1+t1iTeZPcRk8JhrKAxijLXGPaUmXSJpMEr?=
 =?us-ascii?Q?wh94siRM1b5A10Cs2KJM6sku0Ai5Ml9i8JayGeIGzXoiQVM8C4XC6IDpcfSo?=
 =?us-ascii?Q?p6uyYuhqXUNOJWpMuoFIVuCZpnCAGfYz+UR7d3Q5AN9RULs5Y4JibY18m5AL?=
 =?us-ascii?Q?qeAWoayGrqiKQP+ULSpDuEin+M9Gzam4n8SJ2LpbWDTGTSo5en833Sn3hwdo?=
 =?us-ascii?Q?UwqpK/hFbmMZQy0f7azPk/6YWWwNuUtAKs/2NyHDK5CmKqkWqYAQtbcUsoei?=
 =?us-ascii?Q?Hl8/BFF+IKeA71lZSp1ALBfzb8tilicbuyMECg5sQdCWwHg+SDWscOY8Ov98?=
 =?us-ascii?Q?7aryNIIYLCw7ZWcRaJ9IwEVs7iWgYtnjfT9WC1gM2orSvLPgIObrsv91SNal?=
 =?us-ascii?Q?vvDCw5D+jnjeVohunrHKqMUkQVgH3IXTXOJwUYVYBjdhMXGsL0ezKuBFP6TW?=
 =?us-ascii?Q?0BwfNo+CpHk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOsZK6WJ5v/nx3HWkDY3JPCDlPZwqnjEqkBxrjZs0mQETgvdNnodAA8UMz7T?=
 =?us-ascii?Q?7wBI4y0nOJmw6H+htkbNAMfZ3+fhMixeEgZ6qzaPKdvVttm8QWtz04jC61QO?=
 =?us-ascii?Q?r4coXI3muFgmtNvDVOAy25ziumUcqcNXiHKIhpi41I8WV5R4rCTDERN4P8km?=
 =?us-ascii?Q?03jv8VFNYBU+6P4/e0HyMbxWHBVaPo0GyhJqX5ALkMswco1ImMNXLp7/D8ni?=
 =?us-ascii?Q?MdkUy1vXyYTqfnIpPzpoktxtQ1CVqWSCujCJwMIC9wIObhBo8KcMaLNSdh2h?=
 =?us-ascii?Q?PsrsWrrCe+v5YB/UF9VoaVHdAtTBWUseel3CQy+22J8bNh1m+JDi2SXEZVbb?=
 =?us-ascii?Q?+U7OaV+AdFs1JU0h31iMObCnZq2uXtQHv+pk5GUP8oLzLSVn8A5XaHd5KpAW?=
 =?us-ascii?Q?nC/+5ucPVFTp+p9VywuC309e7VUJ7LkjX75sJ50nU7xHXTO/skcS3OXQni++?=
 =?us-ascii?Q?Gc5I70/ihxkMNIPDQR6W+JoALkY90Pof+Kdw4gmVq1w+aI4aPFcyoN7aK7oy?=
 =?us-ascii?Q?+GI6kXaSlP9pUCdAusxsTk4uBcfuub+D74BZQVHauxViKf3kp0h2cJIUrRFL?=
 =?us-ascii?Q?kArYI9JTe5DN3h3iXYOwxvaOYLiyZMEhqTmdGeCjxgRCIxZJdClfW6w8N87O?=
 =?us-ascii?Q?Th1QwHvbWgm9GIDCSF/sTD4GbgOV/BWiADZ3SQNDyCJJqLR5p2q7hd9lTsyX?=
 =?us-ascii?Q?yANdrnZX4NNTEmJKUuq7gL+uNWK0kEx86IW0OtC3YASQG3ujJ267OmTji0cF?=
 =?us-ascii?Q?TeXYKb/Apf4A3UC9csSMbdErw5g5DdrpWSiMCt5iCJWWiegtumjtjd6AgXQd?=
 =?us-ascii?Q?rsObb77xU1RzVsgA7jkeqrgeOm+l81kZHAHs7dDFlHwJVRhcVybFMy24t1t+?=
 =?us-ascii?Q?/eeqTNBDkv/gQFZ4ZQV5o82//PiaRvINEgPeTuoEqKc3u9ba6jvxKISfMQHy?=
 =?us-ascii?Q?drNkThk1J/y/jYKkhJZ5M+w/Odp3onH6O7eucDReB52zn+U2lnyr8wF61L9+?=
 =?us-ascii?Q?u2fOkILZtzHPm/9SynbZ58oGswP8QVxUQb/37Oa2b9Eu6SKuDmWz1vuOllFB?=
 =?us-ascii?Q?Wv08WGZE5TxivtyCj3hft0BHZL309DyZqJwaWiZrXRZRnnCCkSCL5qakvREy?=
 =?us-ascii?Q?lBt7NiR7vFzr3jFJZM0PwGer3VvNmzFr3KQzZmZ9QSu9+iGUaTk6qR3hxxfX?=
 =?us-ascii?Q?zs3FQvfFiws55eeI2F12Uhk4oGDVjRRuvLbnm8k9SwE4oILRGzmWt6MIK7DC?=
 =?us-ascii?Q?FC5OEWXuNUzj7xrCnCgZXvKSjI5iRoKZqS3xAyny4ewBOpwEr7g9UsUj2QmC?=
 =?us-ascii?Q?vUJRed4+WyJQVvNftfgqMRNekDYOZzu6DJc+FP4LHgplI1kEBbIdMmjqXoER?=
 =?us-ascii?Q?YPINm3e7OY5ZuT+6yffRtP+ndtPCJLLRSPuyHgl4WVhaeFLTi90reSBJwva3?=
 =?us-ascii?Q?jMwEtr9uRf0I27aej4Sol2jqkHdwOqjLVotciqtSZiUkwRQHw5KvSC9AksMM?=
 =?us-ascii?Q?BCIqWEctawwmWDYsvYFxXJBtbiAFLyAJHUhd9bY3Cqje7SjF1UqcNH1vd4QK?=
 =?us-ascii?Q?ciJei7R0o7cDqbARscJd5ZfdLRTl6B2r0u6mNUmYnUlokkbWAKbsdie/XDfW?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f02d8-b3c2-4870-617d-08ddbff838eb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:24:58.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 764qxjSZZhjdW/rH9Eq88stx1G6KcrGcK8yOfFHQEcCfJtV5Zzf5OlIWBAeXF/nlXyle1jGyU1VYWNrrr0M4dko29uybUnl7LqgvY/Sjlk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

On Thu, Jul 10, 2025 at 02:56:46PM +0800, Li Ming wrote:
> Per Table 8-143. "Get Partition Info Output Payload" in CXL r3.2 section
> 8.2.10.9.2.1 "Get Partition Info(Opcode 4100h)", DPA 0 is a valid
> address of a CXL device. However, cxl_do_ppr() considers it as an
> invalid address, so that user will get an -EINVAL when user calls the
> sysfs interface of the edac driver to trigger a Post Package Repair(PPR)
> operation for DPA 0 on a CXL device. The correct implementation should
> be checking if the input DPA is in the DPA range of the CXL device.
> 
> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 623aaa4439c4..90151cc7fe52 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
>  static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
>  {
>  	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
> +	if (!cxl_resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
> +	    val != EDAC_DO_MEM_REPAIR)

Sorry, missed this previously.
Looks like order of above would be better reversed so the resource work
isn't done if !EDAC_DO_MEM_REPAIR.



>  		return -EINVAL;
>  
>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);
> -- 
> 2.34.1
> 
