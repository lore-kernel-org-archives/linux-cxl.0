Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878981DDEA;
	Tue, 21 May 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307179; cv=fail; b=GNDKehe30ulurF/9rkdzJNJcSjgXfCtcqyi/30hj63VMYibtCrLBJe6mnyYW8XFvOtsnU+riKObgZ8zISvcDA/YrtNUGxVHb/GflKWPNoQ7upVWvfBIbXQgjrkzMQPZvisqVMQsq14YlO/g9UiFv54AuuDBjby/5+NdxPCE52s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307179; c=relaxed/simple;
	bh=9Hg7wiZ9+tuWa755FoFU/ncSFAkmxFhutUX3AGQ1Dyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmaeugGQFa/GJAQtmxCYtm+upUMAddIDpLOFT9lZJ8w0teknxST6X6BAS7KfNwdeOUw/1UulPC3mQ1tXe9Kw1fTFdp8YuQ+meApDOUHOLEzqCezW0dRz+Yr/PTbEFI9x2FaLpzlaHIhLSNJ/VqRoYFqpJ6nW35m/9f5IyYW4TM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wtcycgg+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wtcycgg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716307178; x=1747843178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Hg7wiZ9+tuWa755FoFU/ncSFAkmxFhutUX3AGQ1Dyo=;
  b=Wtcycgg+wHlMEp7ja4mczdTknSLbN79yrzPR5XRXCwnwarsGKGvQkKgM
   Jb50MsapeTjPw0nNF/mPZ22Icnm1UAdKYFJRvRMMyitpDmFJAkka+g4H8
   Clg8Lx+mO5d4SoL3097ls12ILOXAHLDhF6idutRAfE/9lrANlqwXziakW
   Zck38Mm5eDkFzDu88UiwHOVISkk2ZgHR8DYZ99C3xW3oYrD08xgnotvcL
   OT2ZCNo8+WNMPMuIRYgAMCn6jUfN9vWyQCK4UvKSnSOpzug2PXH8p0W4Y
   6ChPi2mwye1P4KS7larHNsoPodV7X8KNOKwxIhQXPa/Wtqvh8sy06mf2p
   g==;
X-CSE-ConnectionGUID: utTVnYdXSy6K0LmoFYcQ5Q==
X-CSE-MsgGUID: nP1p+WM2RIe0ka3Tsnmg1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="11633609"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="11633609"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:59:37 -0700
X-CSE-ConnectionGUID: CUHPvws6TM2skE1dGfVsjg==
X-CSE-MsgGUID: zzJtAiVwRi+AaNqU0G2Iuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32828517"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 08:59:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:59:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:59:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 08:59:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 08:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elfb0COrUPaOCDMT96bxNFpkcIIOZLHL8LjJj9md5IfZH9S+34UokQWSsoKs/pGhMFUzXvkxVJeybsli1GGc9wOuly6EffLexxTDNLgT6VioktXDT0+h/AFsYC+jkqSfC2JdbeiNYHMjKfryP8kIeUnwn4uDsgWHNBZxqKRoRVK9fguPe9wiN+4iuMrb/9mLQX3fuZWSar9ZpmenZ1mga2eIN8lJjzabDw0uDTGtC+I9Q6JFIMmILXhJKcSn7ZLHHNN0w8yy9LbQYBfj/81PzAH0FpN32ZO49iydF4QYFyE+fxWOhtXg3rYRRTHxj/l8xQ1Ni6YMFi3NcpuY3U1WPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY20Pj1nrRzSml6eVobCEnlI99PAMz/vCLukrPMtVfM=;
 b=htVpU5jUNb7uFSCFK8RULlVccPC1N9X/clRu5kQaWrbKOQUtdunyNTlr9fBzCSqFcFhBatsEcr2ckNnkycAtEdMPJ2R8GrbTEQQSU/l1z3htjIhTV31TYlKMQ30GykAzBbedx14XUvaxAf6LOji2lvLY9q8+U0SNgfDbaFTMNiA7eQkWjM4RhTIF44bJU7Ky8lO0XrPy9DScOb8Y0pJTozw8nFuxBHIO2mbwLDlcEq/qFT0Y5ZbKdEe++DgpLr1tP9g60RlNFiQyEgtfQ500aPbVxe7U5gM1C0Cd37WSC3svnLYNGu9b2g9Njk92vnnMdyhYR6MTDE7+dOUT2KWqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 15:59:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:59:30 +0000
Date: Tue, 21 May 2024 08:59:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: RE: [PATCH v4] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <664cc4e01e02b_2c262944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e1cb61-4a7c-436a-7294-08dc79aeffca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a4ZNWUMUcuRS3EjFZzsTNE+LC6Vh4BGSmhP5MaEsmGs6fnJ5iteGkglajYGc?=
 =?us-ascii?Q?YgIkKoaxzgFs8SdpSPrz655gMRSfevT2G2h+lDr6zq5cRyijf1VaCBXKraiz?=
 =?us-ascii?Q?nu93GC3sctIebfohyAAcSb6N0AvPNAvL7TzvanXXL/8LmEuGBEYXqYcMExRM?=
 =?us-ascii?Q?CWop83UgeMVFS8Owe1fU7HUo5OuH7AN1XrcO05aDZcErVRc/USrPYL+uyMyd?=
 =?us-ascii?Q?fiq1owF7qD2tnIcIsy3z/9BuH7ujD9A9i4clCih5oHS2WiaaFqBHheAEcZtE?=
 =?us-ascii?Q?B3i6fvXRzsNtyjS4oadQrEd3Sx+OlP0FdX1OeEde97WAyG8z3LKtauv/ke6p?=
 =?us-ascii?Q?y+AoV6NXfVovhrcIr7gp27rLsRMG0ympnPymTOSkWMz+8zKoL670mh/ZD2kg?=
 =?us-ascii?Q?zMyYP7HWdHWB2BMfW8PrAz9PrXeP/uOakwzqFr8KF7lyBgGlP5b2I3qDL2lh?=
 =?us-ascii?Q?NGMt4hUJ8D0yA44mUrSfDLdZCyJpzcibEhGsLidVHP+fI60DRuVAaPg39DFg?=
 =?us-ascii?Q?5gwYKSTRFBdTpX7acrR3ZD2C39L+2nkXWwkts7USZxc3FWzk3h410Wc1rw7X?=
 =?us-ascii?Q?CpFxI98rxp6OKxixb3lPG5JEEb5ut6wtzamO3e1ShYcdpxoVtzgNk7tXPdtf?=
 =?us-ascii?Q?irEdVBRcAaBgTtrythr7xDkdqw44K2oNZkvnXQ5FmySXOgAV0JXAK1/Ui+Od?=
 =?us-ascii?Q?7sN21EVbV0why2xib0mglwYLaVsjsSfpFzZ7ToORdn1ELB0bgGDeND2/y/Sz?=
 =?us-ascii?Q?VgHceNARQCg65bbq7rzUa9jdth4YkoyazJmzj1g6+jqKn2jQ8basHlf1u/aa?=
 =?us-ascii?Q?70lwIPwMcWSChU3o46pbAAwUCcMcWyXZ89cZtPHdv/93O4p5n3J0tPLXYWpi?=
 =?us-ascii?Q?YZwp/rdQucAuUgTSxdSX8rdn1Bq0PknLPdVFX5lOphEXlR1fzH4UwdaAN7Yk?=
 =?us-ascii?Q?QRnBPLGYt4EyIxLjlrSyvk7yQezRtxpSngzj2PNgMOUj+BW+4Wl5/k63Bm6g?=
 =?us-ascii?Q?y6oTXj/ur/zfyZHolmb9dsr+R1YbCTFp8Ro23VQEB2Tt5H08BhSlg/7NnH44?=
 =?us-ascii?Q?m8TnUPD9V1kcS32j04hOaEuxvPs+/cTdkQBhEKtvsttIOjHwSU5l5R8DLBcA?=
 =?us-ascii?Q?e/62gikYmqAgVLRkRGmO0TyT5y9A3aQhUOIJtLcOKg2a6JyilCkczezqh8IL?=
 =?us-ascii?Q?R+u1yRqFehaYuYny6uhqorcf+3OFNeMUl5Rfl+p35JbBaj1lcH5aQBIa0JJb?=
 =?us-ascii?Q?er7G4LHS7JVPmGHEVLOpyoRDmBA9VrplZTBp2sdNSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3MqyeqSFscgsq8D5TNHGVaOc1okCNrkL3kM4rNnE3DprgPjt/kn+1d2V65l?=
 =?us-ascii?Q?cI4sSxvljeRyo2LyqbJmDBLlK1uS8B8W+lqPiM6PSseLVduIgJH3ycD20Y9L?=
 =?us-ascii?Q?tQahn2BD+3dJx3irsEH/mDiFgGGH1hBqmjkVqXMOpDL6xtwywxUtYqn8JcUb?=
 =?us-ascii?Q?P02Zrz8KZuGuK9vyD3k+XBS5c+YsA1L7nSgJ0Iz/MveifCl0u84cVekAUKfQ?=
 =?us-ascii?Q?2+muE6JGMnkxmfESLto8XXY3S4oaNcYt5vRYmn6hN9kytlRrvgwpRHatH3li?=
 =?us-ascii?Q?MziwspMNtALEsbqmOhkbMULe8+S9yKz15SKETXajwXpwSRdQonoLHeKjKxEW?=
 =?us-ascii?Q?DCrA3/RCKT59mG+yL0N2oz6/IRU2ByGMT8zq/UCpw3xP9on/AJun4lBDHofS?=
 =?us-ascii?Q?CcoyLLC/q7YvyIAD5kPVHlt1T9YeDlBz/MTLLv9Yt7RstD+BViTo05cpGGOG?=
 =?us-ascii?Q?piqd53iUDPRUdXnsS0uRypLePO/VwIzCYJm/6Lc0uZfn4B3yvX+WpdPXFKo8?=
 =?us-ascii?Q?BP7N1R970QzAzqFNuE7vKg6zkq+TWOGfiw4Qvn2SPakcSRqD8puWIjfKPJEJ?=
 =?us-ascii?Q?k9XmnvpukymCBVjCm+O2fXnewD+8EQ6TNZQ0+MNCXSkPTOprQ2zU7Drbg/s2?=
 =?us-ascii?Q?lgVWRj5/hWzS60apiKgCuqcDBywMV1cuWMfsOURsFIn3bxKPqxhh+f8JpksE?=
 =?us-ascii?Q?hmSNEpzDODFUegqujUOQYhtDD7hkffG9Ejt7zLwZvf4G7ywRZgPxlCKg9K6i?=
 =?us-ascii?Q?5A4i7QgKSJGPELkwU+RXRtM49l3sGLhs+EwRa3dnnPLletTxSGhvZOWUUkUy?=
 =?us-ascii?Q?qGnGpUTzl504xSQc2AiExyzoE4kbDU0YQtwibDTqSxdZ2nvUQbt6bn+2lBk/?=
 =?us-ascii?Q?MyaAk2uExfMwtXasGBahubllRbgAgfixcXwileHQRJ/ClgdTuh3+0axZmC5X?=
 =?us-ascii?Q?0aavY1ma+mXRaATGYcECsNY8fj1I0XtxJ8/u5dR+ExPQA5AKD+dTxxJir1Dn?=
 =?us-ascii?Q?0ioTaH8yLvkPqCi7gqo3KbtwG5yGgp/teuFK2GUEMpboEQV5iF/Nf5LADnZ6?=
 =?us-ascii?Q?OnX8zF1YKb8A2AIE2HiICsFHxpPYuGNgd1li0PpdBCJkH45INTUUpRqpkzhX?=
 =?us-ascii?Q?TCGudboJTM4O1GCiBwpfqeCLszLVnBNzplAXU3pRf44hdZAEJu01BALf+Pov?=
 =?us-ascii?Q?V19ruVjtin2IexX9biiG25LmKzeHopI6L9eyf5HOBFUOGvh11cHzKbf6+s40?=
 =?us-ascii?Q?poxNav+c0LHICyI2d5RBAN1Vdg4yNRVjsIi11h5DwFgW2zZ82G1tOuGtQdaV?=
 =?us-ascii?Q?M5oRFaUUfncatd+rAXsY/tl/a22tIb5O5n3cyKvRulQAZ0HHoj0056l/de8V?=
 =?us-ascii?Q?h2nZXOjN2kLbOTzfvcZ0LDQa6fRhQH9FK3ysk4P4Wdc1tAtgtPNAFWerXIsl?=
 =?us-ascii?Q?9m3cw6Dv4MbISd7fGfEATTcTlDSvre+PdQt4RPkmmR6NDzcnfuXwdlkkuuQn?=
 =?us-ascii?Q?nYeeRzzOo1BGPji/6WmoFOA7BVXNXFSDNMSfFgh8euPt75vaIG+1XXf8tsdS?=
 =?us-ascii?Q?7cKjmReTqdkoIsbOwTa4bkJ0kOnMKsxwy0YMlwCiGfg4bHj9/4H8RNM9fBnq?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e1cb61-4a7c-436a-7294-08dc79aeffca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:59:30.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug15iRNKfu1yBPS/RDeTms5wt5RFne/rpVPf4a/pd1In6vVrTqFMUU1k/AZWy6AzkJl1fTr6isZYxjZ+9LACLSdKg43XRrCgzN4ow43kqxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> cxl_event_common was an unfortunate naming choice and caused confusion with
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
> 
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
> 
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> - Changes for v4 -
> 
> 	- Initialise cxl_test_dram and cxl_test_gen_media without 
> 	  unnecessary extra de-references (Dan)
> 	- Add a comment for media_hdr in union cxl_event (Alison)
> 
> - Changes for v3 -
> 
> 	- Rework the layout of cxl_event_dram and cxl_event_gen_media to
> 	  make a simpler change (Dan)
> 	- Remove a "Fixes" tag (Dan)
> 	- Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
> 	- Rewrite end extend the commit message
> 
> - Link to v3 -
> 
> https://lore.kernel.org/linux-cxl/20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com/
> 
>  drivers/cxl/core/mbox.c      |  2 +-
>  drivers/cxl/core/trace.h     | 32 ++++++++++-----------
>  include/linux/cxl-event.h    | 41 ++++++++++-----------------
>  tools/testing/cxl/test/mem.c | 54 +++++++++++++++++++-----------------
>  4 files changed, 61 insertions(+), 68 deletions(-)

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
