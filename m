Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0E20D4FC;
	Wed, 16 Sep 2026 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518446; cv=fail; b=uPWE4E5D8hrd2raQJEAn5dBmuKlgrxPNOg7L7pt84dLGUbwBJRzczvkqIwoe/sF8OEGmN+swgo+LxxoYCvMOMSM7sjrj0L1pVXgA5OQBNbDz4GB7hctoCPsvpalENQcj2gQ/+DK6m0p5Ql00+9GPE3zRteg+JvLeBUlCOz88vvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518446; c=relaxed/simple;
	bh=tvnzNs35yE0MqmsufGiJUujJJaeIyneFjyWNcWtnfQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpUKQVT1V+WmVgFaGDWVtcIpjUv3picBqNSEJkZYJzve0U58YW8QtYbbxwhOrTacuPg0x+dArdOMF7ytrm2kIu8z2WXH8yR3z88cgvzVOl/inGbxSkGZdfeTd0wHAkNfBGUFe3EmMbLevrFwEgHuyvg2wJSs+iVZr6RfCVtugi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt78Bk7E; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt78Bk7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789518444; x=1821054444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tvnzNs35yE0MqmsufGiJUujJJaeIyneFjyWNcWtnfQA=;
  b=kt78Bk7E5DFkKjcN8DgWT3SBP5kd4u1hfFQlukWW3gyylVYWJYFZ2X6j
   eXoYLyYqcNYHnmcKAxRMBPKx8CquGLHzYVUN4JeSFSG3hmpJ7pukHgtLa
   6LThVkbmjTd8qmCKHMAvK7xSlNxYc/2r5d6+PICw+KocZ0aaJTKfhCr3G
   tpdfXEK1HC9Ha2ddUMB6UNV7Bopf6wHJvxYbm49A88DzchzCLsmfSlQ1a
   96j216uuATbens6EQurP5pxgaQ/jZ1SonL+TsQKzKZFU9TKFl0VwFUypj
   2EEy71yGX80vl0AKa8SK0nvZYymaPWzJWib55blm7G7C89eOVoprxcvQQ
   g==;
X-CSE-ConnectionGUID: r05E27F5RzSTCURCM4kIJg==
X-CSE-MsgGUID: sx3ys3PPSxa3jJvy9vN+zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100555893"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100555893"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:27:23 -0700
X-CSE-ConnectionGUID: td3lcdXcR8a4Kgpw/2XxVA==
X-CSE-MsgGUID: N9INs4vgSo2l0l/GE/DfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296673488"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:27:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:27:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:27:22 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhzQKpKSnLe7iLKPzOUn03T9KveENZHNuBd43QqkBF0xtsnPRz49Qj83XErn4LOvCF7FRSRIq8VkyODfOau4yz9/Hxwmwwlmij8pv5ozWbweBW+A9adAVlfdknt6+gko0om+OIZcw9QZEZalxMd/QYKEn7bvF6u9RHlDJflJv++bs9ZsYWcdejWaPQja4fs9rWQ8aQo7pg+Z5aDPE8T6vuGY4rLu1HZVbVBF4qc307hVeCOtYIwU7WWD/jS9WHhiJ8Cp7Vtl5OnMS+ni86SzRFsrlIvjJRJvBLRQvjq0yIISYP8TeFBCj01Lc64GUXzXuOHyGiuIwQ0EqwVWflBHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHBRT3mOR4wwwAEcKY8pSDIPludxb9dUk0MTZ3NdrM0=;
 b=sLi5ZBPahNTpZLy9K6VDx5O5iGw4VMHv6Sng4G9IKlUOtF4bODnSrHzsX+JXuMguXSAoSJNacuQciw9py7mp7y65muIIGf6UlJuL8xu829B3POHUkzQabwRi6/pVxflC9ICJ1aOvu9V4nJ9eDWIuWyqubph7bSlBc7u86cWLcqYio0W/kKeQcNctDGxOceKV3voYHAOL9IUtXFYhjwOIlzFZOFR5FVp5hbXDyGMyzZS4dJH8IY9OShTB5iYsrJhCQ2L9prurv76uMus84KBUGJ/IffeimDMM6q3Qaj51eXUJRWPYx+oC1aZhiq3vKn22mmF8WLmum4tRthcyfYGbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB9420.namprd11.prod.outlook.com (2603:10b6:208:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 00:27:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 00:27:17 +0000
Date: Tue, 15 Sep 2026 17:27:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 0/7] cxl: Sashiko bug fixes
Message-ID: <aqniWWV_f82A0jhJ@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <appVB-P7pFRdwjAX@aschofie-mobl2.lan>
 <aqj7mRx4EcO6K6oz@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqj7mRx4EcO6K6oz@MWDK4CY14F>
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db7bc03-d007-4ef4-446b-08df13894355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|5023799004|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 8BXYV2enDLVkJL7ynWhLFsGxmlYVuJrqwF++VIArhESn3hW4YMS4uZCU19e6XrunBNlesinWQpru+IGY+NVatOXBR0arYWUGJnQSFQ0B5c4OfkYZXBP296re1gZVSiSORGNy5uAaBTkQqtB+G4o0Mt0fZJIT8yWbeBxK98A+MVdT6GvlDtJWNRQAH/dDIRZBcaIBJGZB7mqL2cNCSwj+XtuyvrVwVVh/vMHYgC2NSZsgYH2HwVqqp+JDi9q44LTs4l+KgFFrDt9nwLR6xPHsUQfZLJQJg8vlYO7dSjM3mIxphPeJZTg5xUtKSBD4xkuMOSEvkt1lqvUO0+PVoQc4+SrcvTfXh8Hb9PkN043w8R8WRaWsZ+fCg9UCtdrhNg03TiWRLwhXFX4ctjJXUC6bRHzF2gNMxF8wYUJl6ps46W7e5Vv9o3Mmzo/2xYR/BCRnueUZPBlfCslUriP1YkP0JRubmKT07vdqkl1FwRdEBIVKoeQ4vgCCLseHHMZ6tBSlwPq/aGZPhBbgJeJav2eM+gJB6vq84ERmAo08Kdznk+5e4s4/3qZSPANOs6HG2Xl//y5RTkMX8tZay+qXEu0IaUXlMd7FfryKPs55cxhKA1JIOhhTt0PECiv8NRMa8t2vG5yjFT5E00/vUbwWLa1Y4SVxmiRGeMyo/KWMlZMTJXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(5023799004)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiPJG/0IrRM1m4VQt60sVNNal4PcsyWGypoBd+AdONdXe4ok35+vg8FcUqOJ?=
 =?us-ascii?Q?KpVejb6dtxvS1vj3QrdeVoqbSTCtbq4CXyQFVEN1ETeczD/84b+c26MSyB6e?=
 =?us-ascii?Q?cE0zY2tBS3Mey5gmBd6XtN4RDZNYAhHeQbArp47+8XWmsv1iXVul1wbeTVf+?=
 =?us-ascii?Q?lLEXSO6oEfalbKtzHG+WoNBgm/N9tLA/JYAO4BQ2eALebrkksgdFLIdNirrk?=
 =?us-ascii?Q?rzCEUSRaaBgfGxr/439j5lDlsajFq0ekDzL7WtlgwjEWdZ21mDeIKjYp8YcF?=
 =?us-ascii?Q?VsnhS1vmBZvDa1pET1QUE6kUsgwjZajTt2fQryyGvFLt1V2twRM9doSi6GVa?=
 =?us-ascii?Q?3KCx1x9JKeZqcRW6ZdOic3ff2WsPcY1gOUmHIE8T6Sz8NwkJTaaGdqYzLlko?=
 =?us-ascii?Q?vKmOAb/Ze9OZ4TcIPBjp00GxCAynS2r6AxCeh9IH8UzCEiMZK90W68khllaz?=
 =?us-ascii?Q?C4ux5KXdOcN4sq+LpPJIiUdZ6Pa8G1BPDYCinnTi1JJS+Wr2dEaTQ2Bb05mx?=
 =?us-ascii?Q?VurLzkBsYBtlIQBqIq+WcVWk+abpl/u+4y46GGj8EkHrovH8GHwy0VuEtpQu?=
 =?us-ascii?Q?syET+MAiC6gC8ivEGoZVmWlN63j+xuqCQGRe2SjjZTzVOSDsQbTRCiHB5Qec?=
 =?us-ascii?Q?d9kkxBTtZNrCBDtvzh9zm3o+wf5Mh6L4XVu7RIzWYB7vuOcxwqtE75M1jPc9?=
 =?us-ascii?Q?hW7dmJn5rBQGK9Yrpn8gLa9p0MUofsC/KEBf99gV4Xt3If8Z2RZb0iiep6np?=
 =?us-ascii?Q?2l+N9hkdAZ1+W5TGkFESqKDkl5BuvMMJuvaswWDIEYGKaSsm1Npv693SZxvJ?=
 =?us-ascii?Q?PtXy9hIn8HNAnO7uxwnAbfMEuBvnIspZLxxxaAk1UipEX033wBMQLeNCzviH?=
 =?us-ascii?Q?GdRNLLzCi9WPrVTF9uA4aZOVoXzxT3krl6h1qE6Qsd4CfpyV/4H08jGRPDI8?=
 =?us-ascii?Q?R4zpDNo90RXYJhSqQbL6Zm1wOe+UecTrUlSexs4OoR8CJuIAeUWB9w0/nsUg?=
 =?us-ascii?Q?FaJS1ClZMYqui0QeS4vN5SKpc9HFt4twDxHFuJLV3XBKinGI0fRvnEOBZIcX?=
 =?us-ascii?Q?ZiNk94H7j1jC9CWtoxOwI3wcaxW7jansKd9j/FOxnPDuzRiCyduA6djiaslZ?=
 =?us-ascii?Q?w0vZhGo0ZCOsc96koxRbwXyYuAFaIFfWz10/L/2Pstdz1ZzXBgN9224NHQKw?=
 =?us-ascii?Q?SIoX17vxHWBGBrta41LN26zuYC4D90ZbXLeWq6ENg0xD5Y8JLmN7jkNCP6uL?=
 =?us-ascii?Q?WDCi0No6aL2UhxlVVOj6EyPymmJAMCCFzQCql19NAxeYBcowUcUQ79ZSQWyn?=
 =?us-ascii?Q?iSOATK5fyBXRColGmWm9YsLvWomjoiQR1Z2JIkr2JSx5gi4AMsep47fJ6cbA?=
 =?us-ascii?Q?zaZMvH7e1jmCGm6vvfvqcVladI/pH3IdqRcW6Y9tQvH5DF02Mtbak4NScegO?=
 =?us-ascii?Q?xR3OO1qrRXEr16StKn9j7Bj4G1lEJa0BdHzS8JEA8R0/exFbA8RUZqbsSCkY?=
 =?us-ascii?Q?XYNIT6hF3Qes2Z9TgAJhKdn9XjrNXBTvVk9HBBF40yRaBnOE5yhnjFjHACTZ?=
 =?us-ascii?Q?CkyKqs8/+/KLS+5/rPLtRS64HrhSH5ABmanL26C/UtXUWEgH4+HiFDj9g0G+?=
 =?us-ascii?Q?rbM1IyWJ+6zui1B3FbegAcnpAp4CrNIMo4H/oKHC13dkzvosnXCLwHJlH7o6?=
 =?us-ascii?Q?FkA+4Y/vXZx42FFBmP+dgbfwKgOU8KFhHiJn3jwysUtOCDF+nF1iyPon3UaP?=
 =?us-ascii?Q?Npysr8fTbOcRu5C0UT//rEBGgzwncLs=3D?=
X-Exchange-RoutingPolicyChecked: ufguQ0QpH9xxElGun0dazvMcM7i2DV6zLd1JpUWCsm7x3iBrOEHSwzUgRWNe4kCayHLeUFihUOEXKZBDjqZSNaAYI2ipduG/9fLaFcMJWTuDF0lexI8wJzWroK+GjoXqsImW9mn3sX1r5q3mJkwdrinKCgktKhhaoaZGBWojO1jfnEz7RQ+I/VzvvAvZ0ENQiaktaaD8GyTKMAVq6oeOOVvxYOjIM22tBt/9hQU6q96tniL2kYWx7FxpfA/SW1ixmty6zQnTShQJoU2gF6e2xXlNk9AnmPhQh0hDQ2/rDoCkI0lDG0Z/fgsh31xYDMhwxLIHJzVBLkHbYjNfDIu29A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db7bc03-d007-4ef4-446b-08df13894355
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:27:17.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POOqUTNaLiEbtqnzIdwhX4c55zmSHGNLFDo04lkczFNOemuJU525XQPD7D6LCrJUmQacs2R8vyB79hQRornFZto5FYycuu4Let0eRJHOdkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9420
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 04:11:27PM +0800, Richard Cheng wrote:
> On Thu, Sep 03, 2026 at 10:20:07PM +0800, Alison Schofield wrote:
> > On Wed, Sep 02, 2026 at 01:38:32PM +0800, Richard Cheng wrote:
> > > Seven independent, pre-existing bugs in the CXL core, reported by
> > > sashiko.
> > 
> > Hi Richard,
> > 
> > I finally got around to looking into all this poisonous code ;)
> > because I had an inkling that they couldn't be independent nor
> > coincidence based on that common Fixes Tag. That actually is
> > the issue, aka the finding.
> > 
> > be5cbd084027 is described as an enum removal. Mostly it did that,
> > CXL_DECODER_PMEM became CXL_PARTMODE_PMEM and nothing else moves. 
> > But three functions were not renames, they were rewritten.
> > 
> >   cxl_get_poison_by_memdev()	two if blocks became one loop
> >   cxl_get_poison_unmapped()	rewritten, no line survives
> >   poison_by_decoder()		gained an unguarded part[] index
> > 
> > If you line up your patches against the pre-rewrite code you'll see
> > that each one is putting back a statement the rewrite dropped:
> > 
> >   patch 2   'if (!length) return 0' was correct because pmem was the
> >             last partition.  It became a mid-loop break.
> >   patch 3   the RAM branch cleared rc on a tolerated -EFAULT.  The
> >             rewrite continues without clearing it.
> >   patch 4   the function consumed ctx->offset.  The rewrite derives
> >             the resume point from the resource child list instead --
> >             note poison_by_decoder() still computes ctx->offset and
> >             nothing reads it.  That dead store is the tell.
> >   patch 5   'if (rc) return rc' lived inside the pmem if block.  When
> >             the two blocks were merged into a loop it went with the
> >             block and was never re-added.
> >   patch 6   be5cbd084027 added six new cxlds->part[cxled->part]
> >             dereferences and guarded five of them against part < 0.
> >             In cxl_region_attach() it reordered the existing checks to
> >             get the guard ahead of the index.  poison_by_decoder() is
> >             the one site it missed.
> > 
> > BTW - I did confirm it was not a merge issue.
> > 
> > Here's what I'm thinking. DaveJ can pluck patch 1 and 7 separately and
> > you can take another pass at this as a 'Poison Repair Set'. 
> > 
> > I walked cxl_get_poison_unmapped() against the pre-be5cbd084027 form, but
> > not the other 2 rewritten functions. It would be good if you can do that.
> > so we can be sure nothing else is missing. Doing that, along with
> > addressing Sashiko citings, will get us to the finish line on this one.
> > 
> > I'm going to reply inline to Patches 5 and 6, but here is the
> > highlights:
> > 
> > - Patches 2, 3 and 4 together restore cxl_get_poison_unmapped()
> >   and improve upon it. It is partition-generic now and no longer issues
> >   a zero-length Get Poison List. 
> > 
> > - Patch 5 fixes the masked error but loses the poison records that the
> >   pre-rewrite code collected before it reported the failure.
> > 
> > - Patch 6 fixes the out-of-bounds read by failing the whole scan for
> >   the memdev, where the pre-rewrite code scanned that decoder and
> >   carried on.
> > 
> > -- Alison
> >
> 
> Hi Alison,
> 
> Thanks a lot for your detailed reviewed.
> 
> I have a few questions to discuss with you before I sent another patch series
> for poison rework.
> 
> So for patch 5's issue, if we get RAM query error and PMEM query error at the same
> time, which return value would you prefer ? I think retained all the record in
> some data structure wouldn't be an issue, just the return error, you would like to see
> the first error or the last ?

Hi Richard,

Neither! Changed my mind after a closer look and seeing that all the query sites
are stopping on first error, so your patch, as is, is inline with other queries.

However, I do think we could do better than that, but that would be beyond the
scope of this fixup patch set. We could change our policy to always query both
partitions and return the first error rather than stopping on it.

So I think you are heading to leaving Patch 5 as is, fixing up Patch 6 and taking
a done on this Sashiko poison 'fixups' set.

-- Alison




> 
> and for patch 6, I see it and will addressed it in the new series.
> 
> Best regards,
> Richard Cheng.
>  
> > > 
> > > Patch 1: Get/Set Feature derive each mailbox command's offset from the
> > > starting offset plus the amount of data already transferred, then store
> > > it in a 16-bit field. A large offset/count supplied through fwctl can
> > > cause a later offset to exceed the representable feature extent and be
> > > truncated by cpu_to_le16(), targeting the wrong feature data. Reject
> > > invalid ranges up front.
> > > 
> > > Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> > > failures are reported as negative errno instead of being conflated with
> > > a zero-byte result. Update all EDAC callers for the signed return
> > > contract while preserving the existing fwctl RPC response behavior.
> > > 
> > > Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
> > > the first fully-mapped partition, silently skipping unmapped poison in
> > > all later partitions. Skip that partition instead.
> > > 
> > > Patch 3: the same function tolerated the -EFAULT a RAM partition returns
> > > for Get Poison List but left it in rc, so a benign fault on the last
> > > scanned partition surfaced as a spurious read failure. Clear rc, as
> > > poison_by_decoder() already does.
> > > 
> > > Patch 4: the same function also ignored the ctx->offset handoff from
> > > poison_by_decoder() and derived its scan start from the highest DPA
> > > allocation, so the DPA of allocated-but-uncommitted decoders was never
> > > scanned by either phase. Resume the sweep at ctx->offset.
> > > 
> > > Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
> > > query, so an earlier partition's failure was masked by a later success
> > > and unscanned poison was reported as a clean list. Stop on any error
> > > not tolerated as a RAM -EFAULT.
> > > 
> > > Patch 6: poison_by_decoder() assumed every decoder with a DPA reservation
> > > was assigned to a partition. Malformed device DPA metadata can leave
> > > dpa_res set while part remains -1, causing a poison scan to access
> > > before the partition array. Reject such decoders before the lookup.
> > > 
> > > Patch 7: the Get and Set Feature fwctl handlers converted all helper
> > > failures into normal RPC responses, sometimes with a SUCCESS device
> > > status. Propagate delivery failures as ioctl errors while continuing to
> > > report actual device errors through rpc_out->retval.
> > > 
> > > A nonzero short Get Feature response is valid when Offset + Count runs
> > > past the end of the feature. Preserve the returned bytes as a successful
> > > partial transfer, reject unexpected zero-length success responses, and
> > > require fixed-format EDAC callers to receive their complete attribute
> > > structures before consuming them.
> > > 
> > > Changes since v6 [1]:
> > > - Patch 7: Remove redundant braces. (Dave Jiang)
> > > 
> > > [1]:
> > > https://lore.kernel.org/linux-cxl/20260826014508.9989-1-icheng@nvidia.com/
> > > 
> > > 
> > > Richard Cheng (7):
> > >   cxl/features: Reject feature offset that overflows 16-bit field
> > >   cxl/region: Scan all partitions for unmapped poison
> > >   cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
> > >   cxl/region: Start unmapped poison scan at the committed decoder
> > >     boundary
> > >   cxl/memdev: Don't overwrite the error from an earlier partition poison
> > >     query
> > >   cxl/region: Reject poison scan for decoder without a partition
> > >   cxl/fwctl: Propagate feature RPC delivery errors
> > > 
> > >  drivers/cxl/core/core.h     |  8 +++---
> > >  drivers/cxl/core/edac.c     | 30 +++++++++++++-------
> > >  drivers/cxl/core/features.c | 56 ++++++++++++++++++++++++-------------
> > >  drivers/cxl/core/memdev.c   |  2 ++
> > >  drivers/cxl/core/region.c   | 15 +++++-----
> > >  5 files changed, 71 insertions(+), 40 deletions(-)
> > > 
> > > 
> > > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > > -- 
> > > 2.53.0
> > > 
