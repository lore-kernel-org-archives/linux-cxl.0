Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CA3A1D02;
	Tue, 24 Mar 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774324157; cv=fail; b=jYyPVbY3Ady9hkhPfemXnBRqTxGFN8KTeNnhvsRIeWB+OY+eb7cD7v832NNMoHd6ysN9VlJ2Yb3RTO7TJpjzzu9L0VrD/4jK8b+yPb5elME1pRq+aMQZTH9bmPiGCcz8s1wkRsVEnFZXbXPAEmWuDowcWte+gT3wh2gfrfP3Zps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774324157; c=relaxed/simple;
	bh=4r8ZTBJKLXbthde8DEkLbRDAWQmUlXYqlduJ49JmKqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5gz46+WdrtJQiug8WdbqiET0KVLAmW0yRKALLEZqSTWmQ+uax42LYltVtACafaBN4dgGj+nLQvlqL32ryIVWG7DNdQhfiySesdyM4EbSdgzV3zD8GiAfJCMRc03cp5RCJQdLKC2FJvYuuDBcaMKDc0wxlrfB6YepHzJmNo4e2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKG2BqXi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKG2BqXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774324155; x=1805860155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4r8ZTBJKLXbthde8DEkLbRDAWQmUlXYqlduJ49JmKqA=;
  b=BKG2BqXipwm3KfEGtB3WQMA5Ks+MxNVbXqhLHZ94DtNoEI3pXy9FGpVV
   E1TzSbzrsYF1mtUBkK4omyzg3fitVDh6wMMSsrs4P8W14K2fgRnJEeSZW
   wdBGXj1USItRXFfL3458o6Mw6MGdBvx/1WR68d22VoV6b09cIQXDcxhDw
   WH0EJ6ESHb2N4wHUNyyf6J5LlEZ6QeHWKtfR1eZ92twDU4CJVOn+1PZCZ
   aw66Pp44EaftKORMUYdiEVnZMh9lWKXczn6Ge0djE0DVaY6/TuUfyym7J
   vCdrmpGxz+Yg+w4EWL+xGqCFXuehOzMNBRu2JHDMye+C+eAXdgUc6UnXj
   Q==;
X-CSE-ConnectionGUID: VEvPQjfZQI2F1J4ppfjWpg==
X-CSE-MsgGUID: CfCKUBk8SIOUE+j41jGf0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92710845"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="92710845"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:49:13 -0700
X-CSE-ConnectionGUID: sNKj8x4fTAqoFmErCB540w==
X-CSE-MsgGUID: aoOUTg/PTpS4ma9+LdRCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228715779"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:49:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:49:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 20:49:13 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/PQ4dOXpNYo3Tiz+leg0LmpqQE1PVOEEqDK5spW8xHMt29o+q3FD83r2RKG7QXiJdFdcjeFw0ga8Vj1HhntjiRi62xO1Q8NtL0azq1+58ngM8OO9Vw2idkz3FKYR6+RphSrweLZRlCd0FlrcwBw+bSktRYA397dnzufZb4qUnVO1N+LIUVjBvbQAIple2aJdVVQ31lLYnrT5a56w5Cw7+mxhUj9VywNELzFCevK0LMnw+RH7hN/QIuV7R7Gj3vUxfyHkdLvk6EtVTSTIyZCJl0+wyM8jEC51aoS31kfrV6SUHUrv5UK1VDhMgryY22GVNs7a+YA28G64hMlPB0+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Yr6ftAH6S2WLLf237LsHRq5rBW0YFsksHms5PdJag=;
 b=ZbVGoee2KjONrvOUhfM5NXudabVGrG771MJ4X1cjr1RT32QBh5dUjfXFVDfTyctcNmEfCgXPu8SeJAVcozfbvQjzgfv8FQQNlxI8Ax+1KhUX/VgH/ho2MdlK+tktii1pyO30v+fpXxYohE0t9VK5WaKafCI0UUdnah/3PuBwLgFeYvfMtz9UWxF3sLy/5X5Y7z1Pi6J5G+lhokv0Emlu5YAPKYjMJGGpxdSXiFdYCPzfDxY11dwaNfwQCSq38mgm5MLZ0yR8PzJWRXSx44bt0yF0NudU1RjBtr0uA2nA/r1YRJDU2FI9+O3Ub+6VKuNGYWkOLTxIFp7xuL5vAmpX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SA7PR11MB9595.namprd11.prod.outlook.com
 (2603:10b6:806:4d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 03:49:06 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::1879:7c61:49b4:b2b3]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::1879:7c61:49b4:b2b3%3]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 03:49:05 +0000
Date: Mon, 23 Mar 2026 20:49:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acIJrkkPD7dM3pBr@aschofie-mobl2.lan>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
 <acCnaN9MIRByjUPd@aschofie-mobl2.lan>
 <acDRrRchRUSRBUbm@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acDRrRchRUSRBUbm@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SA7PR11MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: b7695538-b72c-43a4-583b-08de89584bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: W5khzwPUGJunvI3StQ6edh4F4j03AvWk65IO97Toi7a3BP5naDkeK4Kf7AQPomC6hui9rsuJfn++ytAUOQH7ERAY4vD9aW0eK3gbeT6PgTckti93gyICOQ5y+DXLY3ditlhhkIkXjTYaII3SwLW+esqz0UXZpq23GrgqFNXB+hZxkJUKQZlsfRY6i4u9JBsnPSyTnY5bskiFRVlHRgq6tm5QJtz9tLHLy/DLam70jlAYRrvZ4pLlSaohNTXZG+2aXLhVVhHQVJoQPELgCa51NDjf3Jv+ozb6E3ha3wItLoLqAv6KU47N4UoYUgbqpzBKaoxccpdHM92hIOClgba0kZwvzOrwHPU7U598CCCNzFTzLyG4IQw+63MppLL+MEE9w13vQRRuBvUj016Gbz/vfWQsGl0CmiEqae0C/a2+pFsGHKWZ7ey4+6orm6t3Qtgu79rsZp7MciXFyPudjaWnVbSATf3/0sRuBLf5OSrlIXk1uA6AUdELIe3vQD3+zGP9DgQfpWEcVzBxsacDT5FXw3uSJ4tYNiEEoW6v+V+ygF81F3t3sTKaYC0JrDfpiVlmde0fvxpV6kXTqLmx1eZW/J1cXvXr9b8Dbse5f/Vj7+dUsZTAa8KOyyzuS3mH0GU2LhShFXeDZgJ4RjoVeWYr6gXZJmRY8cNQ5BN9DQgB4CJcf6q++lSyzHYz7VN3TCiSn/FPUYlzb7N586YRkm+7bNSwAo0SxnomMCuhppo1WYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lraGY0g8FgGzSKrXmX/JkFs7S5q3ePl5x0np/XynTIE1+HL4TR3T9kXfJIg+?=
 =?us-ascii?Q?Up/XcxY9inoWkLQ0lSwxj+Idge00hJgj8fNbSC2+sF1uba6nQwsbr/ykkiN/?=
 =?us-ascii?Q?0Q5YAtV56wduOIv297BZLIP6icZQwWj0b05R1QDwXlKH7esScmZXvY1w0cUY?=
 =?us-ascii?Q?2DKDZRjGllTmDTp5fUrHKM47FYJ45uekqfcRZQ4T2eJK2YZFDmtPtrmZ31Hn?=
 =?us-ascii?Q?NQtXILzjbL/45weWbxEAybxe06MXgdQqZSSLs7cmT+tsTPUfkbGFYv6MnaS6?=
 =?us-ascii?Q?KFqD7RMTLOWSWwVeYQcXBwskUouceVeHYCAiN1Yj71p4h2//t4hzHA19T3f7?=
 =?us-ascii?Q?K0ElxVdLzQxU7stikWf1LLcGlrFa/3R17jhIrtChweSC6Od03W96ENj6LO3J?=
 =?us-ascii?Q?urH3Jm96s0GaxcLu139VV1wriBY3LzT7J2lDFSWXsB3RsHn439AN3u3Bzv/q?=
 =?us-ascii?Q?8rGzdat0U8v9q3AktDTPyVymtkltloQlWsDKSAu0pGkpgjQPCjT9+klGvdyI?=
 =?us-ascii?Q?1htkQuUY43Tu/TqjDKCuMIat5XHCAhdKB7T8cT9/j1H6as3EcRBmN2X0YUyG?=
 =?us-ascii?Q?SQQ5iPoSh0o4ePmJXf/eyTQb+zZHo72VowgFANC+tx/Rgmfc4xWxAtBDrat+?=
 =?us-ascii?Q?ZenALhIZnYQ9smcMgp36KV2vWYf2MwsxYB2bbB+egnFyn+T8NK+0dPdRX8JF?=
 =?us-ascii?Q?juh3ImwLxnqbID39hvq5IUGFrtBoLDgWBLCis67qnjDdxF4upifclRHObMXj?=
 =?us-ascii?Q?hXiTfGnVVGp95/+bWP3lx+nl8xxKKrPREdlFfUADw7TE5r2mMav/0vbqx+m9?=
 =?us-ascii?Q?QiWLxvbOkWuiCHvNUXRXlOIri07B8LbbOA0+NvFpcrj/Gx5o/pe7iu17v8vR?=
 =?us-ascii?Q?UOucuw+fqi+gQ/IUoaM6YsSHcXGZEHjHir0kPn4JQb6upoTx4Olld2goMzbr?=
 =?us-ascii?Q?q8t8sCVxdiHplGMJOkaM4z0cy/9YsbBZZ31bGjH1OqTIuA8Fs9KRfl2QXUtX?=
 =?us-ascii?Q?Y7Idc0evj2E9vp10ourNKBSTIHAW2Z2pDl3tJPJqiXjxBHj8IjstuNbS8kc1?=
 =?us-ascii?Q?ZTJc0wLcFJ0+vQCO5sZnVuT2TvIWXudKF/0aWlYd5lFh7wnxK5guZKa/2i9T?=
 =?us-ascii?Q?MIupTyNV/sX4f3kVRyId9J9OpQcLmxSAuT3MeyWq2YN7E1MCqNHOkELKTzfK?=
 =?us-ascii?Q?b/lmjCJFjE2YPDBUfMCx+yf7jZ8He9s/a+fkM+trqkz55wwaTemSlEk91xMa?=
 =?us-ascii?Q?pXTTzA6hcuAl1FJSv21bi637FcbBUbih3BZtj1X3IAU0ZAVudaF5o9T5o7Ct?=
 =?us-ascii?Q?VsYvRxFsKxGbDeIPx9Nw3ciAf7DZPg47t4fQZEF/XX1IYZ70ORtSvxx0+01F?=
 =?us-ascii?Q?8fZd57nXm83gr60Ak9zylzf57r6tjXncbWVN2Am6Ryjlhc6dygnTw+3oZavN?=
 =?us-ascii?Q?iM6+XyMdWWRQIXzrmFZWC9r8Vw0p99NRhclA5gm3ORr5a9NTlXqFOlWO0XrT?=
 =?us-ascii?Q?6BOl99BYbxcgufACEjGKEVd2z3PxjJn4FowaKGw1SYO0yBAG52qPEEyu8KXH?=
 =?us-ascii?Q?duDyHFeFjRkK629vZYEspTka2Gko2zgceBtXSeYTgk7dySn//dRDVVyWL0oH?=
 =?us-ascii?Q?zJ6K3Q1lXYUBf8pECo3tB4LX8dXHqNjx6+y8f+xe+ctqnj4yoaJpAORmAwib?=
 =?us-ascii?Q?F/PKpr26vaek55u1ElC0XnlxArdnmekarvCPhx/mWVyx8XpN/L8Rr7m1gDG0?=
 =?us-ascii?Q?yffW5UzXenCHuQbzVI2Cy/xLA73hCH0=3D?=
X-Exchange-RoutingPolicyChecked: HkPaS+GtV2RFX17zNHSpCX5uEZF28GFIv+FLJGHsBdc+cfZCvakxe0ossd9Xy33NdmOP8XPYllWch1ET+8JrPFyAyha7RgOXSRCPwNG9rUxe9DQTqUvivXw5L1HfzSg4vNx06UYhS54P+YqsmU+DEwpuxuenROHTEHe6+gedl3/sSEPGbGJjlHT8Wck6SJ+f4Msm8DpaO9SbBX14Frrvl5TFLh1/AxOHHSqCoIWlAwBzr82u4IGnYXMX5IL5Um9QKK2U63L5uDnWUcFyR6oCQoN26LJ7g/RGQi8WZ3nTqoJHBu7wub6lqieDvMvbqr/vGW+Y5D6ITq1vbScNyMj0tA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7695538-b72c-43a4-583b-08de89584bb1
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 03:49:05.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X2kQNnfRDsPjgmOpIDEGzhmxP8h0Vz2cLD/mOxcU2nEsAHIkHy1s3I+RJ1dm94Wgo+a0GfgFAhcfUvdFyluTZfWeGC+i/+od4lsoOI9+n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9595
X-OriginatorOrg: intel.com

On Mon, Mar 23, 2026 at 01:37:49AM -0400, Gregory Price wrote:
> On Sun, Mar 22, 2026 at 07:37:28PM -0700, Alison Schofield wrote:
> > On Sun, Mar 22, 2026 at 09:16:36AM -0400, Gregory Price wrote:
> > > core/region.c is overloaded with per-region control logic (pmem, dax,
> > > sysram, etc). Move the pmem region driver logic from region.c into
> > > region_pmem.c make it clear that this code only applies to pmem regions.
> > > 
> > > No functional changes.
> > 
> > This always adds region_pmem.o regardless of CONFIG_CXL_PMEM.
> > Are you heading towards conditionally compiling, where region_pmem.o is
> > omitted if !CONFIG_CXL_PMEM? 
> > 
> > Similar question for region_dax.o
> > 
> 
> I hadn't considered going that far, but it doesn't seem unreasonable?
> 
> It just seemed natural to break out the code this way, but I don't know
> if adding more Kconfig cruft is worth it just to save some .o's and a
> smaller amount of code.
> 
> The recent pmem/nvdimm Kconfig change does kind of show that we might
> have some bloat for some deployments which might not care about pmem -
> for example.

I guess my original thought was, what is your long term intent with
the move?  And I was thinking you are probably heading to conditionally
compiling.  HOWEVER, now the scaredy-cat-me is thinking, shoot, that 
would add test config complexity and test misses. ie. Folks make a
change in region_dax.c, don't test with CONFIG_CXL_PMEM enabled, and
boom.

So, I lean towards keeping them all (working) together, like you have.

-- Alison


> 
> ~Gregory
