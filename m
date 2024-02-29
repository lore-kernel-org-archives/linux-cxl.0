Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0016FF46
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243579; cv=fail; b=AMQrdrRfdwPlGP3tYeSGXGxkmA2I3ceXJ+5UAcWOZOSP9xMcoXVH5/t4kC0pf5CHWdvFb6ur4pVS6rXGVBUNhjGRUhzym1E3F7zZEaH2O90GjL7XjG0eRZwRla8nM9B7PBM1XZKrx1R9Nn/fafF2jWBRXAUZkoVDX3B/iAxyNgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243579; c=relaxed/simple;
	bh=DLggeWagbr0iDji+Pn49loCihkJhmR9CVEJZBZonlzE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E6br1NPKqBb+z05glkhmxBY9aFZSh+7RfB1ClS/MaaG+CZf8HsffIXhL64CSR8BSZVlOA9UOvnOmGA8fcbS5ZewWHN1gpQRjG8mp4WoDpOf8N/E9Loh4R/wHQGWDHM9OSKZrbmqu6TUVeYibAe+JnaOZjc1VUAGEPPISOnZECyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tu+DbfpV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tu+DbfpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709243574; x=1740779574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DLggeWagbr0iDji+Pn49loCihkJhmR9CVEJZBZonlzE=;
  b=Tu+DbfpVaxJZ8p5A6JTjcU+4QhsuePx1c/jtk06AxHYknj7EhRsdOjyA
   zg6/4Tg6Ix1vgl0xCcQIvCO4Sp2aCCujLoYFGaRkTtjw1XLZTCDHsCAFG
   YTcHHR0Z67cRg/n1bnItwuWYOtcefg9oUeJ2KRo1VTrhuBW8WS9Z8Ve8+
   PLttxsBOu7S2/nF7S9wRagv8LRezpIqU9WMG8HOIlJRxCd+RazzZ5N5dy
   3Zwi03TFcPu9DL00PepRicDIaFIBH8F+VzKsALVxupOxTu2DQuZOeX3jw
   DBHv0Ja+Vzx6y6b16JTDy9cAy1EKAl/uAAaZ/pGJm37XRCsaidxAsOptf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7529306"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7529306"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38812814"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 13:52:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 13:52:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 13:52:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 13:52:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK3bg7wzXyvuRXwe5v5JjgL4II667VFcUo7GsQd//x2bY+p9Jl6seI4tDHC0DzMQDjIZrPJbEzkNX6KHvtoKZ7gPFrsLeeMcJeLZpw36gHXzclY66kLIRIhq+1H0ewbvlkpwdxtdXCDR8kw8t7zPg1lamlVhgPn9VM0OZCtG3oGVOKz9BvcRWsx27pj7D6NT2i+LOTLwNWg35b2baGgK1uYj3Q+nsRGHlmCmD5EFR/tG7M/XVsseKKPRavtHqWUfpOTTWkK8+iHcjOMnY7KCMd5jCfGS9H2OA3dIRpF+gUmO2zjr+ClhjhKRXh9LaD2hrc9h0Ja5Li2Vjoc0ao0HKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7c2jcOZP2Rw1uggthJTPG37yp95M9QycNbQOIx90IY=;
 b=fBqwNYghknZTYIocxuBhJQyXzypGDu1du6EBqa60CZB63YlpT7VOL7DomuRCM/mRFY+4TEd/EgelrzaylsOXJi5c8G2O9/lNtwau4UXHUGk334yrOPv0Wbz1vdN4DmYSghhc9u5taWpt3W53p+/ou/TbcgSTScjlP9NnWm4J2hU/VhvEzXNlzApHQVvh2xHT5Hq3NMcAK/ccODkDI2YAObjpAsl4zuuhEzqEqyim37AO9ACbKGQCqPN7DOzaieH1HZt3CCAlrSHFc2l5ZyJFMuFc3noRr+70g5oAU74iBLwTXlniJuAbgImAPRqJ9tAJvEN8EKsMzAdlYRTRcYcRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Thu, 29 Feb
 2024 21:52:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 21:52:49 +0000
Date: Thu, 29 Feb 2024 13:52:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Nathan Fontenot <ndfont@gmail.com>, Alison Schofield
	<alison.schofield@intel.com>, Hongjian Fan <hongjian.fan@seagate.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question on deferring dax registration to cxl module for
 CXL_REGION
Message-ID: <65e0fcae989d6_1138c7294c2@dwillia2-xfh.jf.intel.com.notmuch>
References: <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>
 <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
 <c3aadcee-818c-4346-9935-b72df9e4b443@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3aadcee-818c-4346-9935-b72df9e4b443@gmail.com>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f55b88-24e4-4250-490a-08dc3970c583
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEI0gJNguXmghcQd2xhuvHgGUaOXsel7FQHY4IPCSn8ec0aDA6iSkHOnjhhSwmMIK3Ed+Hcoocp+IikaCAqxiI1OO9OJZTsV2bQrK0dCxoglU1+XRhsacQ2JmAV3LPQvXP4Vy4iPFibWk1GzFtfg98El6xdRqseMh3tOTUGCbFIUCZxLrZYX5GTv10bCDX5KpPloauJANtkZ3Xmuz2PY4eZ7duPxoANClSL3CUzmU4eJyBDg+pcxs0pvVhRprkeaEfead9FJx9+MLaXEDL+/qq8E7To/7c6SAqj2TAg6oBoeMQTFhG5oyXYZJeR+RmjuWV8XT2IhAGfg9omG4ZvZZ/lH/cyOVkXdFPA2uCYAZ5Zgicxnl3+m3Qw85LEuu+ZIRzRN1Q8zbjyb45blgGIdGIxp8f9uIV3FBI/PTN3ZXhigbnAlNhWiwxA/IToVc6ARCShQnEEOGJUeXmIZl4nHrsgpnbN4ywT24Sx783uTlUMOgy8ea9cYY3iQU9QgxDq/TYGwP76Nc+gtZjj9UlD78/KY9wttWUUAlNx2zEISBO5qGS+RggZaBWaFyyirY2Tp/keKipDGtkAdnnvxA7UPHI7VD6eqROWkpojlsLsUCegtLAPKYoEFkzLmfpJzpiqwyOmup2ln5DoGCYWcn9+y1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woaYWmEfpQ4JbdNCWQhrt2f7G9/JJNOWnMMolXA3PuLGWKRoOwxg76Y5rt5h?=
 =?us-ascii?Q?1ZI64cN5a+4gQy5nXUGjr3RyKDIO/6miZJLQIy0jJAYwntxpe4yJWFvWmmZv?=
 =?us-ascii?Q?onXqLB92mOcMoKmGoPeiT65OmspH1GyjTi6lGA61TqquZOQQ0NRx1V5aTxFY?=
 =?us-ascii?Q?HEOfRxS8DOghHzdQFhIDtox2KzBBa6DsZx2UU9nvQqYjlc1yPsD/9pF6+uA1?=
 =?us-ascii?Q?nu+oUyU9PUc5lJyF4MTTl+dQ1Q8fAilOUq2HMcoaZAyoWLCkyJUPdNYHjEym?=
 =?us-ascii?Q?04CpqEU69pbHnnplJfsSU6/cRbx0KxslGoe2tX2PNsYChVbfMe5UiZJLVhD6?=
 =?us-ascii?Q?8JugD5fiNtGh9lQxCL020pwAPsOG+XbIH0Yb7/gpqTdRLpNXJFk480CXfEgZ?=
 =?us-ascii?Q?m4tPt9cpwc3zJR3lzRkI+2WtpvQYiTdy0J95F6nkru2MulTyk1bVPBxdlHn0?=
 =?us-ascii?Q?8ltvMqvlcedQJmBdaFqa0Sn/dJo3/nz2xSx3c8ouwLCaXoV6Ian7p32dwpLk?=
 =?us-ascii?Q?1K68PQyr521Y+piBacu1DxR0wm23JPONJRIO93EPY3IXQsXCFOnM4VYC82NJ?=
 =?us-ascii?Q?mtEzyN7iWc/aPaY2EyjY5HENyiVRjo/gTLaeTDQ1hkyc2HOX5VSLt6QfqR1M?=
 =?us-ascii?Q?AZxQyR8aIUW7QEyUxUUT8denwjwhoMPiPZ3DoO0GU8dPsY1EjFRspSu/XF4s?=
 =?us-ascii?Q?tykroK/gdL8YV5C5/wEu7CFxhMz+HqwHVzwAciOQAnAWT7sbVWoPdKmu1v9O?=
 =?us-ascii?Q?M33L6Dx88qDApvKt5sRv2gq6zf4/Ssc8QVYhuvGYhjP49g2mxmL5GOnuOJT6?=
 =?us-ascii?Q?uAaoHD3GJFHtAf5upfnoJSPoSvu8NLQL2ruzJv1RcCoQrAURggSIxrbowMxU?=
 =?us-ascii?Q?vBvH4h/iAmW3FE030AY/EBsKuBIKbvMlmaZVPX/895Sj/WgI3FszT7LEBH+8?=
 =?us-ascii?Q?axTDpjFpLE/+Ny99o/b8uA1hEDqJDl4Vi0QTLcM7+myPMHF4X01I2L8dev9k?=
 =?us-ascii?Q?stQfccbahnuJm9DDx8OIMjjPYKraMACsCYB+YCYtjjfUf2KwEsJGlOmmHLa8?=
 =?us-ascii?Q?Vn1sIBab3JHXAihGq7F5KdWhE+NsrGrH80Yf9GERQeOtiPgxq3q/LY9TVgqw?=
 =?us-ascii?Q?xE44P1mBNVcE0LS0XnT2HBIiDSWHjnUyv1lfFto+UksPYSy4IH22lHN1Foey?=
 =?us-ascii?Q?JLUhqgOdflwUG/BfDyVCL5X96eECuHdw6xlhKN+BH+KKXtc5bfVJXVNSJ5JI?=
 =?us-ascii?Q?xdMBH6dVaeBND+L4J5ju7hqX34tYuKOUD9pez7RpfKyCFgL02G5ZNv//xMM3?=
 =?us-ascii?Q?BD6hqUj3+lBn9K+mQTXKwHvzyCrfdWWKeskhLABObAm2A6iHXuG+lnXV6KnD?=
 =?us-ascii?Q?kQtqumNMyHmDn9oZ41e9xKumMsZ7j7/2oZU+346Wt54jnuT5nCZAMtQMEclV?=
 =?us-ascii?Q?INVmzx3FyP81EkvKHsiJUOF19XSukXGlujRTYJX+AQoERSEqa4C0I6B9S9Hf?=
 =?us-ascii?Q?m9VW/7tCe74LNMRYlTCORR39HCoM0AvzEB51da/VOXBvnqePc5If/dP2eCjQ?=
 =?us-ascii?Q?2thAde1vwA6lVTyWv/mCL3/pGDGWdybrdGpL4ISBxYQeH09FF/UCRqmN4ZCB?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f55b88-24e4-4250-490a-08dc3970c583
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 21:52:49.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd1u0M2dswsLE5GgBaiSuWgokVO+Ccqi9F819/zQ6Hsx6j1v1iotAg60KkrbBonWkLSaNR0Gg2heZtEdWvb2bKZR1G/DkYCVHpnX26oA074=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com

Nathan Fontenot wrote:
[..] 
> Alison, and others,
> 
> Can you provide some additional details on this new approach. I'm trying to wrap
> my head around management of the the separate cxl resource tree and what resources
> would be put in it.
> 
> I've also wondered if you were looking to use this to manage cxl resources outside
> of the iomem resource tree or is it just for management of 'soft reserve' resources
> under the CFMWS.

Hey Nathan, here is my current thinking. The tl;dr is quite a bit of
spelunking in early init code is needed to get this fixed up properly.
If you have cycles to take this on, here is a roadmap:

The BIOS is responsible for building the CFMWS and optionally deciding
what memory should not be included in the OS general pool by default
(EFI_MEMORY_SP attribute). That attribute allows the OS the *option* to
use it in a dedicated fashion. That could either be because the memory
is too slow and needs to be set aside for applications that can tolerate
the latency, or memory that is too fast, i.e. so precious that only a
specific application should use it.

However, when the OS has no policy for that dedicated memory it should
find its way back into the general pool. So EFI_MEMORY_SP is a mechanism
that prevents immovable allocations landing in dedicated memory early in
boot, but with the understanding that most system-owners likely want to
proceed with all memory in the general pool unless and until it becomes
abundantly clear that a policy to do something different needs to be
deployed.

So, how does this affect CXL? Given there is only one EFI_MEMORY_SP bit
that is not CXL specific, it may be applied across one large address
range that includes CXL, HBM, PMEM, and/or even some DDR. For HBM and
DDR there is no driver subsystem like CXL that can decorate that address
range with a device like a cxl_region device. Those ranges need to go
straight to device-dax so that the dedicated memory-policy can be
deployed.

The problem is what do with the remaining Soft Reserve ranges that
intersect CFMWS that *might* later have a cxl_region established. Right
now a "Soft Reserve" entry in iomem_resource can collide with "CXL
Window" entries and impede the CXL subsystem's ability to manage the
resource tree.

The proposal is to delay the decision about installing a "Soft Reserve"
entry until after the CXL intersections have been determined.

NUMA init should run before e820__reserve_resources_late() which means
that e820__reserve_resources_late() should be able to discover where
a "Soft Reserve" entry intersects a CXL range, and trim that "Soft
Reserve" entry to only reference non-CXL ranges.

Sometime later the cxl_acpi driver loads, re-parses CFMWS and inserts
"CXL Window" resources into iomem resource. You might wonder, "could not
NUMA init do this resource registration?". The problem is that NUMA init
does not know about any of the resources deferred by
e820__reserve_resources() to e820__reserve_resources_late(), so it does
not know how to do the fixups that add_cxl_resource() (in cxl_acpi)
does.

After cxl_acpi is loaded Linux knows where all the CXL windows are, but
it does not know if there are cxl_region instances populated into those
windows. That process involves waiting for PCI probe to complete and the
CXL autoassembly process to run its course.

That could be achieved with something like cxl_acpi kicks off a work
item to do:

	wait_for_device_probe()
	/* trim soft reserve where cxl took over */
	for_each_deferred_cxl_soft_reserve_range()
		for_each_cxl_region()
			if (does_region_intersect_softreserve_range())
				trim_soft_reserve_range()

	/* create standalone Soft Reserve entries for the rest */
	for_each_deferred_cxl_soft_reserve_range()
		insert_soft_reserve_resource()

	/*
	 * CXL soft reserve with no cxl_region likely means something
	 * like Type-2 memory that may be invisible to cxl_pci
	 */
	notify_device_dax_of_late_discover_soft_reserve()

Hope this helps clarify what I think is needed to fix this up, patches
are welcome.
