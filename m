Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE23AEB27
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475037; cv=fail; b=j1HJUSTFOtnZn+I2zd0Ajy6xN0ysnp/4RYEONPEd5+6L2WiTfV46xzGOjEF632dmtvHKBLnXhrHCzWr4FqkyyKOGeIZreuIenPYdNBPzibOkoR+bJ9hBebenKwXwU/JIEcqMRi4vHdeAY5UTS3qzLlosQFHExBIxnaD69eTWX5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475037; c=relaxed/simple;
	bh=ta/abcDrC5hAhPq0EAcKBg/tCZMWlPtaUHOUV4eCA6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0Ly8Mz27ZThufjXsYsVo4/WiWy4Rg8lbZ2S8Ty54S5qV5nKEQST7CHFSHnjtJCwSmKmP9EgnDtgZySyZC2ouuJATSlG4wDgrJPt/kSZbSDMX6TS0p+ndqHPax07R9vPcW2rztXMUA2L4iEI3ls7BZYeqg9Md85IxKiJ5oxyLhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU2R7TiQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU2R7TiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783475035; x=1815011035;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ta/abcDrC5hAhPq0EAcKBg/tCZMWlPtaUHOUV4eCA6U=;
  b=lU2R7TiQjSz9BrV8E3Ufb/0ti5rmfxX/39UDqMkVt33zp2EKj3iVSQE6
   9h7XH7HrUhl+DDEz9uwP8SLr33TaIbt0bUxslZOdbWN67en37h+VHCvyF
   PF/EwAFKHL11OPuW+dUaeII7cRPSJjmXpsF4QLTZpbqi/UNltJ14HVem/
   PLHssNCTd00/I5Esy7XhSdM3r4hyIINv/oQ0qOZVIDd4MSdQy3rbuJFZW
   T05QBDzpkxJvPUTpHPvefignR0+iK74nVOz1ldYDJMSj7gkk58nkBdPcf
   gZ7u5fNHnbboqXlRm56FQ+96U8dyVqtiTi7pB20ptypfEn2ttmGbUm+m8
   w==;
X-CSE-ConnectionGUID: gN5jykSoSnedHetDGyU/TQ==
X-CSE-MsgGUID: DQfAXjSpQj6lfY3uqMesPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="109674817"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109674817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:43:54 -0700
X-CSE-ConnectionGUID: iosKx/mxS9SdZzdq2fmWrQ==
X-CSE-MsgGUID: R+/hIpaFTeyRw7TchbQ/NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257738587"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:43:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 18:43:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 18:43:53 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 18:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLlIK+k2Oyxmfx1itj1TLwlkSicBdAeuB45Ui03XtaxEPtkJ27CjweOnyesWTEuKaDYhV++XcPz1Cd/Gb2vWuDfNgnHxQWUpOrQYDP3NqEln50qkqKP0nOqwPpZga+Cm0Bx+uTtgV+leLO635WrxH7Oo8dCFuw+MWrGIOhzC43aFLhCWKN2C+ev70+C1uBOEtbLsZCulh1j0jNOv5J/Faek2S2VU3bWqGKQO6JfkeheM5kU60peFeB91UTNrU9sPnOfSyqacBYIBsV/pcUhAEB3RczrK/cYFzTr3z4bMEw8EIZ+Q6PqLA7qRW+q1yz+xutLp7cqpizTKq+1PA907VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWqk9vIVA85tRlOZdApUicHI8Jecsgxk7OAT3v9CfIA=;
 b=wU7UgP39SFUxAkvsYDIt9JTnVzR6iuRgHKsskv/8gLNu/UdeC2/L92Blr2V9UhfaQXavbPRUnUQu1Xh8NWr9pjlrmrm+HCdyaSoZRLF4bj/3q91AN8L94iNHvYFqsM46swSNu/fXBJFOqTTAQNlWywvoGZSjAcxWEY0dM9rG07EWuwNwfZoBX0uRbe5EGH3v2yJlTwMGyHM7MWcMk9GxSWPHTH/DCvk8CRkUp+cbyFMIfdbtUftnSI7ME8lsw6zL4Ux5SS4qQ09+le14zqQUVmFOs2eJwrboGWhl2PARW8omxkW0WR+lnWpcoycjuGwUKqq4ZELOqg457TLdCgdAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 01:43:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 01:43:46 +0000
Date: Tue, 7 Jul 2026 18:43:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <ak2rSrmJt8H-0xAn@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
 <akITgju_8_6PoKFB@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akITgju_8_6PoKFB@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fc1a80-5171-46fe-91b6-08dedc925980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: IQecaLJoCZYzglJhnc7juInUjg1j/MPxpZJaiayjYY/nY/4KUFu5XQ5rr6XuQtNZF1pT0KZ0MoEumrP0xzLFaEkkQap41aF388cidqvIBeYrvL86VMG5KUA/drol64B71AkLpbo4PioW55f0Sc0IXMDWw+QPDgxFzbeR7GhTiJduSiU3Kr670Kw/z4vLhNWBj9u7w9cUtq5TuGybwTsusKVpI/+C6ZzSGWHjKo/YuxQvOQvAdSCD2ArevZtW+GYy0r6wjhJbhkOc+rAgzJOTzc616upt3DZlvPFJtJ5/cZyRqqs54yNJ5y214KCvXKr+/bnqhUt2NBlkr2AKdxIjClxWm8g/XEyeK4jVpKKNCXJX7iTkc7JGA9HFm4kkcjeLNy06CWOQeXlTL0PHS+ciDxX/BzEbBr+uoob4LmW0UmFsQP+08AkIHTfCiHionhXugmSuBN9JY5AIQ3CCrQSr+RefFeSi92ny5Hlw4yuiWcmh44finYYqf3jstq0eWkiGkEnM06eZP2q5jKiduGFbsRWWsnhhBPOkVTYbPhqBmNPJN6YRbx7mcE+NtsrrJQzJQOIJL89lWUUSWw2GEipvZGlqu0lpeTI9d/1wSl69aPb0J+QXc8qGuMSUU3JBfQJARsjvbXcNpbBlkUnuzeyfGaBvsJFA2Vhwd1DqCb9ajpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bPr8melGqIaYimFRYqawrQ1DSDTlRxAR5nixT+vGBbFbHY2dhx0D2GYbiw9?=
 =?us-ascii?Q?cYIdqDLgKhHgqG8vj6epgp70uoDw0dGwbwzt9KHIG5LtsNWSLxysGm9HiRpx?=
 =?us-ascii?Q?5qhV0UohnYaT1q/WbwHVxFLzIZzlnithMYgMWAs9bh6zQ+sL6P/Q9kwYm3Yo?=
 =?us-ascii?Q?5eBcgxl0w6qssFzoawxzujcmWtEjZzVn1hgWIBHKq85r8JtzlspvJylulkxn?=
 =?us-ascii?Q?SL0sHr3JSeg/uk2majLZ+f8h4bedyBxo43s18qjvZs3ubwifvjzdOQOB8Nq7?=
 =?us-ascii?Q?c0XqGbIqVqgFL/A2vJomBAaCjpSAvbMhpo8hUeecyQVhqqYgalftc1n3Dz1R?=
 =?us-ascii?Q?pr2KaJJ0bT9MzidH0FVcSwqrdXe6yPU35fQ3ALCLVWwfASmwGD/mOR+jzTlO?=
 =?us-ascii?Q?qADhsSm2KrKX7BPJLl43Jslg4gN2ViW48FgW/MXsoloWeB1BkEB0y0n+GqBR?=
 =?us-ascii?Q?ffmobR30jHtPWQWhLfEXaM8JwK3A2RY2JNiiNe78+No9fLblilcByDAy47z5?=
 =?us-ascii?Q?bKbBhoIg9Vms/fVwdsZZXLYBWuOjXn4AJ2y89Ws3PwHx4MUq4MKEG8qEZTsb?=
 =?us-ascii?Q?5YVGSJhHMoB0QQ6R5ogXwkBDlew8lAaFjZCLd+zkXDCV9DeKZt8ef5842V1V?=
 =?us-ascii?Q?C6LRpj7xmvC/iK0gPSTtBVVpUfRmBFaFU5Hu6VyfA9S0dIRHWKeaQWJCTDps?=
 =?us-ascii?Q?JU6mW9Y0enhFZWCciV4aJeWrCZ8PMYZHMi+xZ3x1v9rlieFLwMA7JAb4Uggh?=
 =?us-ascii?Q?lE7fJzrBIrfAxDSgEHbhktk9KxSIcgPKyMoYMTn2zIsLAv7jUQlEzRcCUgZK?=
 =?us-ascii?Q?5v+kPJwmCMpKzJ9HLc5zU3HCIuz/BhpijZTZRFdi84dPg1CRbux9rFA8zuav?=
 =?us-ascii?Q?2eGOWbAGF8vDqoIgvZorZr4t9wV9Q3uy5WeLVRkgcTrxoXfc9f2p12P2832S?=
 =?us-ascii?Q?+1nLbl3AB4nCuxnjOX87+B0PuUz2Uew5s9LVd8XWA3m90RohTuV/x5TKMGrj?=
 =?us-ascii?Q?/69GxkeNIi1UpJXtn0G3xdlWzK2deyyFHLrNhPETrgL8zG+rBGoOTre+CiIx?=
 =?us-ascii?Q?k7VoY8OcWcEMl/sioxKFjTXOgdLRbxMDo7QEkZ2VNmG5LJcDVHl3cpnhpx94?=
 =?us-ascii?Q?JiMqcItBR8zhrXgS6Rj50CIaAXqxX4xHPv499qTn0raMjsxSFZLNaLdIlfep?=
 =?us-ascii?Q?zHGWzdcFwlYjZfnibvRzE+NsSZ4OeIYh4SXfDH54jzCePIQlCRkiRHCXThnq?=
 =?us-ascii?Q?jkdwQRe124awwfuLLVeBhV5wBYxQLsRZi/zQhelhmE4/tmoIkUW3jnnAW22d?=
 =?us-ascii?Q?qfzxJN64qgmXWz+mUJj0LLwfvPaVjIEndk2AC0tSKgphWMg0tXCeTTw2hwoZ?=
 =?us-ascii?Q?kfZcfxomw3sBvwaLjP2iQ/ySlw1NsKJoxM/WfTuYHQkVlj923y/9v/cMzqrd?=
 =?us-ascii?Q?whip6Brvyr8tVKUnOQrSeRGmnnsvRr4AytDBc3Lt+qui4yZrO6sFUK2AleND?=
 =?us-ascii?Q?mEXyojmZh7ZZcPUP5SZPT4AI4Mhl0uNGgMKJ/kTbzYHPJZec2H5Mm5F5Q4NL?=
 =?us-ascii?Q?KuvJc1goy0fut2tVnnjEMLnwKPsWRWP4cQZ3i40lpPyb+QMIR145GNLeEWyj?=
 =?us-ascii?Q?EbDBL+NhC5tzi2UehO8EcAI9n3syGN9FxxTtcp5joSjgw/Bk87YZi+Dh8SPR?=
 =?us-ascii?Q?h9wllMi8xbmjS8fNQ3HuapFZO3xizx7Lj3H+rnn5Eg2hKqD2BcuFBiAkXKa+?=
 =?us-ascii?Q?esZvb1cVQGX8c2+o2lnIUS/WPNTR6Yg=3D?=
X-Exchange-RoutingPolicyChecked: XEMr4aOd4TobZHlsx+tlCp37E2WuEU6Rt6Gyh+jzETCzXRYw23dv+zKeefZqOk5NrKgksRkpO5UDSWUDRMxvemwhdi+PB/w6qZkwf2VUGql86wOBJTjirGyNifDaNpOmjt9oy6wEgY3LOkX3Ew5qWUWg7YN2HMMdd6A+Jbwvm7Zt9JGHN8zgj7mlhnR1eeXr2gbdVyhzz+U+waFc19geaGPTGgV0gl8wrlDyvWPN6PTLgezYIJzh1BuIsdU5L89QAJbSqwCp96ntzoRgYMznG4KccCJQP0UTZWz/LMJ4IfcIDG6ewY14MBw2jGv9OEHpeCnl663IfVvaZZfy0WLjzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc1a80-5171-46fe-91b6-08dedc925980
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:43:46.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nz5V7Iuynk2BsfhBX28FG2AX3396TmM/J3p6ALG5y4eavpuaIdUQ+EqE7RA2JY9E0XGip4mT0DS2mVsraIeYZ5i6TnqN/JNABCaiGPhgtWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 08:41:06AM +0200, Robert Richter wrote:
> Alison,
> 
> On 11.06.26 10:47:27, Alison Schofield wrote:
> > Mixed-granularity regions place the root decoder at outer HPA bits.
> > A root target then owns root_gran / region_gran inner positions
> > before the root advances to the next target. That ratio becomes the
> > root target stride in region positions.
> > 
> > Account for that stride in endpoint placement, position calculation,
> > and peer-distance checks.
> 
> I don't see why root decoders need special handling here (apart from
> the 3-way factor, but this is already handled). See my earlier
> comments to the other patches, but if root decoders were just included
> in the pos calculation, that should give correct results. And, instead
> of introducing the "stride" term, why not just continue to work with
> the selector mask also for the root decoders?
> 
> This "special case" handling unnecessarily introduces complex logic
> and code. We should avoid that.

> I don't see why root decoders need special handling here (apart
> from the 3-way factor, but this is already handled). See my
> earlier comments to the other patches, but if root decoders were
> just included in the pos calculation, that should give correct
> results. And, instead of introducing the "stride" term, why not
> just continue to work with the selector mask also for the root
> decoders?
>
> This "special case" handling unnecessarily introduces complex
> logic and code. We should avoid that.


Thanks for the review Robert,

It's not added complexity. It is the root decoder's contribution
to the position, the piece you identified as missing from the
walk in your follow-up on 1/6. Root decoders *are* "just included
in the pos calculation" here: stride = root_gran / region_gran is
the place value of the root's selector bits in position space, so
the root step deposits the root's target index at the root's
place value, same as every other level deposits its index at its
own. It is the same information as the root decoder selectors from
your follow-up on 1/6, just written as a multiplier instead of a
bit mask, which matches the multiply/add arithmetic this function
already uses. Without it, the endpoints get wrong positions while
every selector check still passes.

Nor is it a "special case" of the model. It is the general per-level
rule "each level contributes target_idx * level_gran / region_gran,
which same-granularity levels reduce to trivially. The root is simply
the one level whose granularity can differ from the region's in this
series, so it's the one place the general term is visible.

I did check your selector-bit proposal. A selector-derived position
formula gave identical results to the current code on every pow2 config.
That was equivalent but not simpler. Issue is that it cannot express the
factor of 3 of the 3/6/12-way roots, which consumes no HPA bits and is
recovered by divide/modulo above the pow2 selector bits. So switching to
selector-bit position math would actually require two models: selectors
for pow2, plus the value math kept anyway for 3/6/12-way. The value math
we use now handles both in one model, so position calculation stays there.
Happy to post the comparison traces if useful.

For this patch: stride is renamed and commented as the root's position
place value to make its connection to the selector layout explicit.

-- Alison

> 
> -Robert
> 
> > 
> > Remove the temporary mixed-granularity attach reject now that position
> > arithmetic matches the selector layout.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 21 deletions(-)
