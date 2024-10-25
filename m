Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3E13212A
	for <linux-cxl@vger.kernel.org>; Fri, 25 Oct 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873348; cv=fail; b=f1f9EU+FzcOUvDtC8wpoZG5uaAhU+66OkaeiYpbQKyVMuEbuwzGwM9aF2YPiON0TdOBuRh5Nex86j2+4Y+//NLBla8xtjnJR4f9JAtXOid5RirBu2bMiu92x9CF7ig6LacLWuHnYF3mxjCI4JucgylJMTIbC1hKQtpjeY8r7mII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873348; c=relaxed/simple;
	bh=qaN27AW242DAPLcgYVDBZRjKmudsT8Dlo3KZFHkIcVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qsbTOIMcPf8mIxGrk1qGhTx4Fx+13Ezc69T83xCqBctgvYfw1MaR6N/uET6Bp8LUT8ZB1xPZVrwPr7x83E7FopZk7mQsw9d5iSt6usBb7VEuGBT+ifNVhKf07q2h8TVYms5O6yTUKtdwSK8b8tDZKzR3gBkTiD3BOlHwNWe/fKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7qXa322; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7qXa322"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729873346; x=1761409346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qaN27AW242DAPLcgYVDBZRjKmudsT8Dlo3KZFHkIcVA=;
  b=U7qXa322r5ucZwP8u+qG2jOZMRHyJ1FxS88WoCImaomRL2/2MFzvHOTq
   NqbDoLIUi+nDAEXxlS6kZG9/D2wYZlx2mI7mqgp7wqiI0/wh3E5xKVs6H
   24EasnaG5Iekci9Op6ibh99HOPhnQxGyd3FJtVzIA9icZTqYAvzq7YPQb
   6AeXX/Y4OIR53k26zFFTtm34Ka/THdxtiyMnauAV0B9eDpEokq89uUvmI
   DCwaEWg6WKqCrtDrihp/oyLTlk9mA4yhT4dj830Ezvfld8n4jDHtyclwO
   XGxjw72oXP7ojKO+/+uz/BbXYm6okJ/jDKnunN478yRYIvtfzZwjgFddZ
   g==;
X-CSE-ConnectionGUID: ZY/LGj/WSuW91HdFLc3QFg==
X-CSE-MsgGUID: 70CQMBEGR9uEFv4r9Yau0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47031899"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47031899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:22:25 -0700
X-CSE-ConnectionGUID: q/EmXkTYSsGr1mH3ZAzfVA==
X-CSE-MsgGUID: fD1Cq/VvR++t5dcqZvUeiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80548420"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 09:22:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 09:22:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 09:22:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 09:22:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZaH9b3oEcxTvXwqONqV+vjzHF0/j+MTSY/ss2MtPfQ9gykwKq8Qa0RP0KycH+cWYDnA7zof2DHO9yqgKl3Lp1vDhTZqR9Pd446qwb6cNhCJuGz2bDc4biGnO0ivG5EExlJUe0AuZtfhsYf86Td70mtajuvIIRrXmP4OLK7GC8zQzE1CJo7EL4IcngGPgujQ/xFslDcEhYHbWt61zsf5a9nYfFZdry8xqkIa0zSQYaD2VUSQb/Lk9wZfvoH9txcRWUEpN2TdasI8VDV7eNv/lGL2wJ8+E9ifJpLEjyyYLCTYz1NtO1LUz+lXRYpoGZFR1CJheAkWEOw26OzRn4Qseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0ve7cKjWqcFtiWlW5EhKCqtPlexVupgcErTlzMM/pM=;
 b=bHr74OsehxVVfIPrbIR2FQLGqRjxjxpnoAFFcp51ZE+44TtIpVTnSigLqmdvERD4fLuG2/eZGsW8wQ1280otLIRfHlvcshhO7oHrOp/sK4w7TAo7Id3s94p25G0hUTxbgKYOy9J0mkWye9iZi57H8MOjsAGtHsdts4pgDUr12qv32phi1j+PIv2PKMtAc/+k38QxqY+Y4WwrbxI6JV/cpHGomXoGIDlzpb8Cq15a6Z2r92gGCAacmSjYT5gX8C9MFyfIqbwUlNYat+Mj9KK8EMm/MOewkv/1D657K7jcaKhi8qPl/WmbeZE9otzsf55cUF/7zvMd3q5o5c8pT6+t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB8784.namprd11.prod.outlook.com (2603:10b6:8:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 16:22:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 16:22:17 +0000
Date: Fri, 25 Oct 2024 11:22:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: CXL related lockdep splats with 6.12-rc4
Message-ID: <671bc5b5b6213_1e4bd5294e9@iweiny-mobl.notmuch>
References: <671bb6217b2b1_1b7aea2942f@iweiny-mobl.notmuch>
 <671bc1ea774c7_1bbc6294fb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <671bc1ea774c7_1bbc6294fb@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 666f3450-4dce-4c3e-786c-08dcf511317c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4BedndQN/p1xr+ejC/d35kT4UmNz8RCGHXNXVyg/EeosYhoY36+3ZWcs1sG?=
 =?us-ascii?Q?jA/UrBHQLeUxqxEVA4VdEtDtc1fKrPeFCo0tvEo9hFXaJcgkH+usemkAw8ak?=
 =?us-ascii?Q?VPyJP4aHoToR4iCeYFuGMJKcMMJdnex80bruNJzZc/9Dzvh++cCPGLMZJh2+?=
 =?us-ascii?Q?sZuuyxzUenxkJfOWtUn0bMbYOfUqDhnIVBSYoII6OnzEYswwlYZN4A0HMs6x?=
 =?us-ascii?Q?LzAMNx25cH+Uy5NJEwdHizR+TMlJ1cuYR5gIwDUcfohGGzbsVo9cfGoojGTi?=
 =?us-ascii?Q?HBZqULo5a/QvvRXXQSHDjSz+UowtlGtvx96fPXk8mm7k9C5qrnIC/2EEQHiJ?=
 =?us-ascii?Q?jWvAH1qi/gVzg0/ZdWIRwreeN4X2x3LchPTsTscgFyqMqU8V7xGcl5DZCTnb?=
 =?us-ascii?Q?F49INK/XGJlpXpM1C0r5aLLb0L3czrWPpw2PBS757T2tvFdbwiCSydRnUD3X?=
 =?us-ascii?Q?TtDUsnHQWJ0lEZm6X6fxf59g43CedNAtnpyQwCOan7VLhG7H+H4CH4ZKhZl1?=
 =?us-ascii?Q?icnvWvxgOqj/1W+6FJNzAX3Ax4FAVcrEmRZVRtMLQmrVbTUQ+Lza6bQ1FYE+?=
 =?us-ascii?Q?TMUy+qh4l5yv4B1lzFOjtgg7RxqHlXwuFFKXg0AlSE3pKZFLpF4Rw66bX2jB?=
 =?us-ascii?Q?5tykZ+WnmQw+loFer8/hzDqDXR34hpOc7X7eEmNUTbmtZG78b77fh7dNHMFC?=
 =?us-ascii?Q?0d2bDiKwzy1wyPGBlWK4aAZVXgGZ6+QxX2MmyKL6Kz7qNvT8mf6zJ9Fg8+uC?=
 =?us-ascii?Q?nB0R00ZeNx1xMEjQiIZ8pwtB5MMw7Kl16nA8y6srtR6zYDpp939Z7lUpRlXa?=
 =?us-ascii?Q?CBdia+5qxMivOxhV2J4WbPrZlIpRNkSbrzLon8GFKVtlO5WF46hbVnxDWKyN?=
 =?us-ascii?Q?CniCa9+3nKZk05m6F6TTunAoKIIzL36mp5I7ElUGvilbP3btZkK1kDkgU//v?=
 =?us-ascii?Q?l8QIgiR/Wn+npN/gd/v4olhJkvQlEuzG4I/GRyV0UaqbnucwsWHqcCvlHUJU?=
 =?us-ascii?Q?7fIyE802JLB0CG8Nfs2ghR7eLlF1OGMpAk54iYy4Xrwez5zYTRZOJ5B6UQek?=
 =?us-ascii?Q?PbgtOPxliNCBJmsowiwskHHLJ/mmOqFca+hQzM8vefIqArvBeDTiT89f0nUm?=
 =?us-ascii?Q?2ZjxLGAuBK5CD/wKwMNBL6oyXiQ4Uqm5a8h9fSjuJAKxtklP5UELWl5mChgY?=
 =?us-ascii?Q?EhN+xGMu5AVs6OiLQk1gQMTEl5hoDdA0V2LeaGYLC8/QUOQXn6jui1+WUpSJ?=
 =?us-ascii?Q?cjhqpFXO0S4Q/irG+XIqPJCmviesZ3KKwxSnkbX5OrR/DNgApyXpNlUnSJ0m?=
 =?us-ascii?Q?07KEag23Hc8m9bzKoVq62qb3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YsgLCdvgVBPnToScqIqVkEwSSiG8s9VukrBqAllfs9HUrOxYk9ZjkQa97duR?=
 =?us-ascii?Q?B7RAb1Kvd4+n6aKsTBaBt3BVemn26iK3qy19mneJfMtDZ25tSsbYXjC4w7xa?=
 =?us-ascii?Q?U++vVfyyLKOn+S+rBy1zNjjXOCY8f81JPvA61bmmSe8EgmMR6N06P0O76C2t?=
 =?us-ascii?Q?Wi1RDoQ0MZkLVeZL5HjlGjpVUdCO9H+ihRWfB2tSk1i9cuRvvGrXa2gIZvtz?=
 =?us-ascii?Q?qehbK5nH6LrdWUwU0AubyCWrfOlfJmSnE243OtyB/5Se7mXlbIztXvSX3Hob?=
 =?us-ascii?Q?xaImy4+HsUK9T7xG+aWzzU7CQJ3jvYTQ94xsX9nOcm59QkRB4uXF5f8zKbyR?=
 =?us-ascii?Q?VvPvqeIyDIAFc4H+WJsNCNkNSt2tW/l81RkujMrjbPi3VIdEgH9+LKDHvaFr?=
 =?us-ascii?Q?xLDJ8OuY/4kI2wd7xdL2JWnNWAfOnwF/jv1ufLwRkgiRSUDJRBgSU0/Gz2qF?=
 =?us-ascii?Q?JqRB5I2V9tk8R8f3L0Uf6+akr6Fy9zC1mGrxIIonLVSD2AuZGDTjz/l93219?=
 =?us-ascii?Q?B4ZjJCYX3Gh5VV5BzF/ivV78A6C5aPjrb4CHefzjWz5Vb9pZ1Md2iaXGq508?=
 =?us-ascii?Q?oIS4LaDWgIatnkmbrhtxnoPqqlekJYcw9LfaHahKwbfxTRLaodHDn4/tQEo+?=
 =?us-ascii?Q?H92v8b0n9hqdJ0+N9Vz0+QLBAkLpS/QFTv3qbmenAyuJnw2stNuQFjrwiRIy?=
 =?us-ascii?Q?Zl2IZdYsVzz3fkHy6ih7YBb18EAYbXhellbXviT+jBshe4bfdpp8PASeuXcX?=
 =?us-ascii?Q?1XG5AomwDpTepdV2SUSSGKFUqJHODY0dyRliET6EG0tzgGWIxh6myPjQoDNk?=
 =?us-ascii?Q?rWoN+U5tgfQeMLFxWR5/VA7bwh+VyvOk+EzEN0Ej+GHN0rAEL0/YPe0/wPwD?=
 =?us-ascii?Q?uxFMjYfLaVW7BU7U+q/hLSF+HPtiBjTr+cAkXixaFNJe50Re00qF8xbIB1nC?=
 =?us-ascii?Q?gBL2zLdBQkyybHDwreuAGEa3rEOfgXE8FxyaJ+lk8SzPB0SpVVattIoDz90f?=
 =?us-ascii?Q?f5nOr2vaKNKsnBDDdJ1xp9yw4yiCI9SsxVHE1UGRnC77zQm0mfvW4SU2Yxix?=
 =?us-ascii?Q?KKU8821np4dKxjIy/EdqeHAY6tbHqJujTbEhUVGHCFjRfNVHOUbQG0aA+xZK?=
 =?us-ascii?Q?cE0GXCYcigopFUx+hiaf4Uh+iCzR1w3Re4kX3GXZTMOoO0IA89tTVNjrWSYV?=
 =?us-ascii?Q?Q6ceSewgNC1Anh8b1ETMPV46WFCkbOtVPtBaOofcNlK1nfGDd/ahjDIoC9ST?=
 =?us-ascii?Q?9R544ffWHi7LvwrbJYGZciCkANHF66+VBr9mYBCMa7v7knlyNgBQcWhj9YGu?=
 =?us-ascii?Q?deKBohfZ4bzndsGiat1a6WvimlpxBeFNTsCShX5/axLWvWzP3kha40uG2HYq?=
 =?us-ascii?Q?TjFy6VN5cpl/FnCdwZ7F5K7iMM75lpnfQLh4MbZ6wIFDjoWyFeJDTE98HeZL?=
 =?us-ascii?Q?pNpbphjOos+mzUUyvXrw4Sr4Rh+nvAIzsjxGjmk2FX1D8x+h6HOFftp2eZ7r?=
 =?us-ascii?Q?zWi9PIydPthU6ZAb9SWEwJ/6ppCJZrBNULfgDsYuj/s+RY/zdGXQ+LezggYz?=
 =?us-ascii?Q?N+2oIpnpCv8AbMFWUZcwurZw2bbxGgCZ3tldo7Cp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f3450-4dce-4c3e-786c-08dcf511317c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:22:17.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjZASImkXTX7ibOZQqlYFr3sf6baM0X+fl1Viej8dl5kdkXz3bZEypoeSRztR+kNmNEAiuvBHXlJnt0fbf8GYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8784
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > I was about to get cxl-fixes soaking last night and hit the following
> > lockdep splat.[1]
> > 
> > It is intermittent, occurring about 3 times so far, while running all the
> > cxl-tests (nfit and cxl).
> > 
> > I've been able to hit it with 6.12-rc4 __without__ the cxl fixes patches.
> > 
> > So I'm thinking it is something in the device handling which has changed
> > or missed in rc1 testing.  The intermittent nature (I can't even narrow
> > down which cxl-test test fails.  :-/) is making this hard to track.
> > 
> > It seems to hit during the firmware-update.sh test (which is not even a
> > direct cxl test.)  But not always and may depend on a previous test
> > causing a lock state to trigger.
> > 
> > I don't know if this has appeared because of a config change or what
> > because I have been testing since rc1.  Config is in [2].
> > 
> > I've also been able to hit what looks like a similar splat in [3].  But
> > I've not seen that reproduce.
> > 
> > Any ideas on what might be happening would be appreciated.
> 
> Going forward do look at using gist.github.com to share dumps.

yea.  sorry.

> 
> This is tripping over the online firmware activation unit test in
> nfit_test which is strictly an NVDIMM path. The fact that running that
> against the full CXL unit test finds this multi-stage lockdep splat is
> interesting but also not too surprising.
> 
> This is part of the reason I only run:
> 
>     meson test -C build --suite cxl

Will do.  But I've never had an issue before...  :-/

> 
> ...for CXL work, besides the long running NVDIMM tests that do not add
> much value to CXL regression.
> 
> Online NVDIMM firmware activation handles this difficult side of effect
> of memory going offline in a way that could cause DMA timeouts and other
> problems. So the solution attempts to suspend all devices over the
> activation event. Given the violence of suspend some deployments choose
> to just live with the blip in memory response and hope nothing times
> out. So, I would say we should probably document
> "test/firmware-update.sh" as a low-value test and hope that CXL never
> needs to deal with devices going silent to memory cycles in problematic
> ways over firmware activation events.


Yep I finally got a good reproducer by running firmware-update.sh followed
by 'modprobe -r cxl-test'.

Thanks,
Ira
