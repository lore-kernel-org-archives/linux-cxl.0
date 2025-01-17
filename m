Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE019E99C
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136079; cv=fail; b=fYcLaz24cGHF29G7o6fzBRAaahrfbud6lJP0Q3mOTn/tlufQ6sT4ldnQ4DxZaKucqRXUwfOUj2tq0GFsqI34RcLxWIbWxaLJXOUgCfK7cp7ziODyN7vg6RggFJeFgTB2v+a8Kkh7E5t17tehhmGrQUlEbeOhrSytzXMczcbST0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136079; c=relaxed/simple;
	bh=VIyyDske7h3NeEmb6quTjz3b14mSOGhR8HqeHaTNScU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upbwPp/ICoQ27eneAVNBnkaYS1g+zbvKcQVp/AXYpFLb3AXgbWWa3x9mY/d6AyjqH6mT1u0V4sHvpw0nU3h01FUWIRhfqv22kUN9IBpdc4L16ZREHB2NJ6TAFKz+mA9JLVWNWix3Z4kEiVgzdnqX37h1Y9TfalnTwfutqsr1Awg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKImG8wA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKImG8wA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737136078; x=1768672078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VIyyDske7h3NeEmb6quTjz3b14mSOGhR8HqeHaTNScU=;
  b=PKImG8wAZ00itP3LSe4aRqHjP0a3Yj/bOe3odcfvMvO8Akea6RnBPCPH
   ct6RMHWkpg1bKdU52p2z6vU4CBDZjWEyjN0ASb+5AuMoO/O+LAqMyGvkG
   HYFnlpRXZCFEZNE8J872QuBACUjPgniU5OGRwge+T11CMk7659te3dMd7
   jzMchMGCIucuJRszRzogjpKvl3yU3w71CCA7mOwBLwtzuWFoJXFkZMpL5
   Ugq64I6Fe6A5KqJpnVus9Gl9exR82XsGq6s+vYdFlkSM8+7jBP0+pe5uL
   AS0tynBGsyCTqy6YVwy/4IHiRLnla+2Q8cvUtGHPRXu54Lyl1X25HpdXY
   A==;
X-CSE-ConnectionGUID: AWTEf+GLQXG1rDDfv0YDtA==
X-CSE-MsgGUID: zTJMwHmlRdqmpIo6dtwKVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41248837"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41248837"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:47:58 -0800
X-CSE-ConnectionGUID: 5jEK+cLLQaG0Ts42l5AoHQ==
X-CSE-MsgGUID: AFXHgquoQwmFtScx3XAd6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129122672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 09:47:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 09:47:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 09:47:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 09:47:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/7A0dHDNYXNeUXOdilrYAuHqqtZHwvgiCy3m7B1DFmd4TlVtLfkttHKoHbkm8yYpUeTzHAOihBHZRCpYkOWpyuu4MS2wEcKbrnlqoxwJ2YMvJOSXhsb/IENiQyCjsIEVR4jT5lvsDGQ+h2HtpjS9FzmbKQuMm5I8VWqhh5ew7v6LkB02EMhib9X+hdfSsr0ot1FT4XZqNOJy0mOECPmZVqey9T7jIkBe2GRKqDCs7ZKrjJ/aNSJcn20P8xzOC+3O6Cl3nkIALwJo+sIphypqQjU5s97bsdAJruwwSnWeLC9opMHDgVPaeBoNoJVWohGhbfbFtENV7CSy5imGSzCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyNtKS9fNBWd2GQNyFs3jIUDBDUxFjeKXDUrGeqQY4E=;
 b=V1mVFmrgVTIAAudrgtt1wzVma6Kj4SfXfvGBsFudxPVZSy9huycvDgT7/iSTX4QDiuMFfYcDCkgNCBkkOuEyWvgOXkMstK/QjQRo78kqNOfhqUT2x4W2eO89yItkXg9szNcj1qpch84fBTdHzdx7QYnfEYgi9/7UBMXI/E5mIZeVQn7R6TbuOAyTH+mliZv/nDrE8aNpKl89qZJJaxhFXT6eJEa2EUJhGz6UwAxgu+Em3XmpZrJO7p35/DE4N5pp/X6tcRY3XepQn28/mEU3b0W/Y71reOMcMUYCYVlsAUphh89CKR0DvvzHv6FW8bd8TV+F914I0KWD03iSjUGwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 17:47:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 17:47:54 +0000
Date: Fri, 17 Jan 2025 09:47:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <678a97c880e3c_20fa294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
 <20250117100306.000077ae@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117100306.000077ae@huawei.com>
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: db7be71a-272f-42f1-82c1-08dd371f1207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lDS7rRg0zDcRPErP3M5bbn1yIn5byGGDfT7rItMc8+TLoFpZdafSi2N3Ma9Z?=
 =?us-ascii?Q?PdGx4NwNC+rYQX4fHWGjtO8CTYLoYMmUg+edO7qXhUX+yvuwKWawLJmlPBj/?=
 =?us-ascii?Q?Cu05sGnIjea2KCTRZoe7up0m1B9i0NkK4nu+xNGKjtS7B4vhAne4NFSjY93G?=
 =?us-ascii?Q?KzbIcYtwGiaW9Y2ou4x64VBqVM+cLkUzSRkL/SORUVL5CsdT14P2T3JRW9zF?=
 =?us-ascii?Q?Ieu4roWndFS99FDDKP6A9CkPz3RhHwsri8IaU4bG5buMHqGRWQSFSWCxkxf6?=
 =?us-ascii?Q?wSC68svXztHz6BcVKoA8n/ZyEIs1qQ8UQctAGY5hA9rRVRBekTKD9Lz1Bfk6?=
 =?us-ascii?Q?Z+HXJ4dVXc3pgMyynOwSN1KoLlSbikau4z93cDC8LSl4hVBVDFhtKAOxnV+z?=
 =?us-ascii?Q?uwCQJFEogh5vYVDkccAtLibw0wIBY7mnDiFuBep9fSduuikk5YPmVbXOiBZc?=
 =?us-ascii?Q?/brnDgnB1kPg8lh4Jjw3/fJDnh9jV8vmT7VKqJ9D8H4645Vb5im/+jVvaugu?=
 =?us-ascii?Q?QPo+KNjAiBAzJcNEAc3XsqdVFqO83eEhGJWTh7apgVde0Wn7x/2hqZFgSGoz?=
 =?us-ascii?Q?HPhrpC6e2DiZPqH2yVXOwaaitBSQUKKc4MgGUnfp2u51KhNnGaAndHu3wxxV?=
 =?us-ascii?Q?ZqeNpKdgURS2sKkv4/I0hAOqYcdiDBt16zA3S24Zhc6H16boAtTbOUuXvkld?=
 =?us-ascii?Q?Si4DKVAdTtnlcSndhCiOUWw1ine5MGCAlUbiHW+sjCMXX3xlOwpTeECGZCI3?=
 =?us-ascii?Q?yEHt4lk/0LlYP8yLJktDEXiX0MVEFkaMYhXCTPPYfXk/u9YIvDWjdyoH3Rcw?=
 =?us-ascii?Q?vinr09elywqRm4c9uCUVS+HjPNyJOG25rxute7CoZ4bA0mfVfRTXMsh9AjFo?=
 =?us-ascii?Q?/aQVqZ3m5zQBTn+efJIhYeeD56YETnzMwKInA3Nke0+PPscpqwHM4dQtPaqj?=
 =?us-ascii?Q?cH29tFlOD4XkfDgbnq8gMTTVzmxOjD2Bl2e/qD6r2SmZmdeYuFBJen3cnT0J?=
 =?us-ascii?Q?D+O2flZxUEIjxMJAsGNTz7LkjkNennNnGNGNT4kYs4J91tMnXNSw2zSoP+wD?=
 =?us-ascii?Q?hnNAWPtMj7R+wsj96xP3RuXWxBZ9e9IVeJF6wUfITdMghUXHnd2tlQKJ0KsT?=
 =?us-ascii?Q?/F8mVtHpXn/O3ief9SO4v+qYC2j3lKgqwq5+bDhPRKkzoF3bv9e1tsX8nEym?=
 =?us-ascii?Q?SLlyiThEFqCmpGlDbaWH14q30coSXz02yf5bnlBZ2alXUp/EArl1ZE4ZOd2Z?=
 =?us-ascii?Q?qQgy0TG5cEWI/FuZRiUU8CfWV3HlWqadywtAguk8yl70mev/vOk0T0LM8nyV?=
 =?us-ascii?Q?Nh6GHQaKIL7cJxNjLXNq0Ofu7ckWEVWmxD5gubuT2xwFufzwTsKwqmLCKZtp?=
 =?us-ascii?Q?+hkEFXzIYLX+FT2IuSF/Qdz+tpXH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmEQIdg9sVOh2HZYgTjUsyGL8ThVfPkJnJJOiHSTVAuj9GMaF8wLiPD7ixZ7?=
 =?us-ascii?Q?EZgZj2fdPedGC/LRhQNrK6/+yswpdOq7hJCqZfTsHYo4VpK2hvx5NJCY1fkB?=
 =?us-ascii?Q?gitWBNnUOHg2pGEBNDOYqovAKD2Koh/gT7UIHlBjhSXbJcI2Mfq9LfQMlG/g?=
 =?us-ascii?Q?F6QBPmOY7mObTYVWRsiMwc0///35phLZ+LZcTwNUwlIaIgoWAskuYYX64srY?=
 =?us-ascii?Q?4YQiE3tyPksc2oXEmBk83cXoIEdqxY3szyX69abyOhMWo+tAqWclqo+dWlx/?=
 =?us-ascii?Q?uxfIWVPeIkOOGHbmqZzSlPuEEkutJlP7EwBNAD4sWkgJ3OIHZgqavpc4nojI?=
 =?us-ascii?Q?Ji5sjB6y/D7OpZ8tNpHFEV2pdHZN7yZ2jq5Ki0k0LKkEgePJF3XCI4gCknpy?=
 =?us-ascii?Q?RtW42H2FSUi5n95T7WqCyoEAfvRTiPD+KA6IFmWr/V4fGI7oPRikriw33TSf?=
 =?us-ascii?Q?NwcQkjkIM8Ea78hSaUiaI4TQazh5N7RHTzKwS3kfQ1tI+dmHfUqmURI6IV6R?=
 =?us-ascii?Q?BA9yWikL6Se3gQ2FOrIWdkmuFLWMyTNcpmGSsloidgdCOoU0f4MZMrICKK4i?=
 =?us-ascii?Q?FSYXdtvyDLY4TQmRCtS4HFI7rX+JhgnD4udBZ2/FUnP7kpgpkWDT3LBP4ntC?=
 =?us-ascii?Q?YWUvVKV29k22G9VTaqQQbdzDWFiU3+ydKsoB81SnJgMv0Fbq5kYKleZNsudG?=
 =?us-ascii?Q?aeOQ1YcWNZF/RPvUsu60KRFHlmUnpuTWhT1SjgEHyn2uxQ0v7RM/GmL6GZPF?=
 =?us-ascii?Q?tH+F+A9j5UNxOIyAP6gFgD/E8D1OxQ4E6OHcc5cMi7zcTUnR/9aTERIz8sye?=
 =?us-ascii?Q?Iqv8OD5vxrTeJ9LnJ0EoBhpQjIHTLmeWnDZp+79jZtJ8um8K7jQCNaUB0QDT?=
 =?us-ascii?Q?9UsHMf3cEcqPGo7CmJ6K7NDhOgNpQ5gRJVHLtnhlezd8r3z+W0od1sMtLO1D?=
 =?us-ascii?Q?QtBctBe3F/YNogQkONhcOFKRijBeYcKsooOOSEGjWi81qmt45kDJ/iKPDIon?=
 =?us-ascii?Q?SRE58CPEBINZAW79IvvHEuObngu/O5xgOUZQwt0i9Rx4lguhT7RrE+27kpjZ?=
 =?us-ascii?Q?oEMiYdRNFjUlMZUmGgRpenW5VIl6jREFlsI1aAgej1tr4mmuub9t61n0JlAA?=
 =?us-ascii?Q?kOZIxclVOSRlD99edqVcjLDwtDtEJRS7RoAeiR9ha6dBZO3koUrfgEiSAgJJ?=
 =?us-ascii?Q?gglZL95Yx+gVSyQ/nawjQctp8SoODG8bix0vaiCApoJ2a2sd0QbieBUcjKOy?=
 =?us-ascii?Q?owQXoSk3glEqcqXbV/BQJ50bW/nxKIcWLekr8UJSSzh62+N4BdQH+YImy/U5?=
 =?us-ascii?Q?jThE6ZeOoZOGDR8kovU/tC+NKqsthz3OOQfFQ2SPokXkbnM4oehnoVE684IK?=
 =?us-ascii?Q?UGHkFCMkLWN7T1hxhxbxJ4JPk5PVC1tVCqbLB9B/PCeFHrDB1Xqu41rgT/b1?=
 =?us-ascii?Q?3Cbe5Sq84/94VWThLkaOtWKMaUCStq+3VdEAvfNh7YBdMXwUrpSQiCO/c4R5?=
 =?us-ascii?Q?4hhSzxHiBldTWpIZRo2uDWMuz1BXRwH8hhNCBpsUsieq4pZRV3JqY52qE6V0?=
 =?us-ascii?Q?uSHcWpFVoshnskQTuH4kDueAzOX4PWwevD9p7XTXb8iCrGNbBZFcBNi2Bici?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db7be71a-272f-42f1-82c1-08dd371f1207
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:47:54.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxheCzngfjkJKgWgb3w4WSOlwUeH5W0xObp3brCP1SSauGwdGnPz5gzPbE3AsfGqMK0L7warGROhX08Jb5TTeeKuXzdNtc9uBUNeTMAG54c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 16 Jan 2025 22:10:32 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> > platform firmware has programmed an endpoint decoder that straddles a
> > DPA partition boundary. While the kernel is careful to only allocate DPA
> > capacity within a single partition there is no guarantee that platform
> > firmware, or anything that touched the device before the current kernel,
> > gets that right.
> > 
> > However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> > designation because of the way it tracks partition boundaries. A
> > request_resource() that spans ->ram_res and ->pmem_res fails with the
> > following signature:
> > 
> >     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> > 
> > CXL_DECODER_MIXED is dead defensive programming after the driver has
> > already given up on the device. It has never offered any protection in
> > practice, just delete it.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c    |    8 ++++----
> >  drivers/cxl/core/region.c |   12 ------------
> >  drivers/cxl/cxl.h         |    4 +---
> >  3 files changed, 5 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 28edd5822486..be8556119d94 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -329,12 +329,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  
> >  	if (resource_contains(&cxlds->pmem_res, res))
> >  		cxled->mode = CXL_DECODER_PMEM;
> > -	else if (resource_contains(&cxlds->ram_res, res))
> > +	if (resource_contains(&cxlds->ram_res, res))
> 
> Logic of removing the else?  I assume there is 0 chance that both conditions
> match, but doesn't this mean if the res is not in ram_res we always hit the next
> else and print the warning?

...bug that I fixed later in the series and did not fold all the way
back to where it came from when splitting the series.

Good catch.

> 
> >  		cxled->mode = CXL_DECODER_RAM;
> >  	else {
> > -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> > -			 port->id, cxled->cxld.id, cxled->dpa_res);
> > -		cxled->mode = CXL_DECODER_MIXED;
> > +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> > +			 port->id, cxled->cxld.id, res);
> > +		cxled->mode = CXL_DECODER_NONE;
> >  	}
> >  
> >  	port->hdm_end++;
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f6015f24ad38..0fb8d70fa3e5 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -379,7 +379,6 @@ enum cxl_decoder_mode {
> >  	CXL_DECODER_NONE,
> >  	CXL_DECODER_RAM,
> >  	CXL_DECODER_PMEM,
> > -	CXL_DECODER_MIXED,
> >  	CXL_DECODER_DEAD,
> >  };
> >  
> > @@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> >  		[CXL_DECODER_NONE] = "none",
> >  		[CXL_DECODER_RAM] = "ram",
> >  		[CXL_DECODER_PMEM] = "pmem",
> > -		[CXL_DECODER_MIXED] = "mixed",
> >  	};
> >  
> > -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> > +	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_PMEM)
> Maybe just < DEAD is simpler?

I like that.
