Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA46233956
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783795707; cv=fail; b=kIK2A0MDxAWSUqeMrvSv/5cTootST3B87DwryDlrSuHnbFCY/E5LApX0xNGgfhvX0ACIShkVi69PUTJJbX/5Pms+aC7xgOGmyySo2G0T6WXM/6W5t9YantS/PGFifdeqPV4oxklg87oGxWk+mLFZhAKWher87e2UV1mSJrZLLLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783795707; c=relaxed/simple;
	bh=MPRhUeSbmYgfa//qRrBMycvRqf64r5unbcE30/BwsuY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XPyH9CqzGZGl7mz1ywfLVJRrt0rUzmopccR4Cm15RsqXZjYQUXYVRhSBvICKZXDzqPsgvPBSfqTXLJOZjkxCTnC8nEPb3fl6FA0VX8RRq+zy+zkynnkU2fJVJlf0gxm+GzfTpL7onyJzg5YgeA1ULrXJ9jRTkEyNyDHVp3VaHfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUd0Xa6x; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUd0Xa6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783795704; x=1815331704;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MPRhUeSbmYgfa//qRrBMycvRqf64r5unbcE30/BwsuY=;
  b=YUd0Xa6xzj2OhMDQxQtqj+s4KfbISQjFDfEGNgeBXvD+50G00X6eIx4L
   PNfVKEJEw3BRxCq/cSK+isyCB0EuHDa9TU5Z36RZiOjBOv5PcBcCn29X3
   jvK87DXThNPOBS/0tiTtyWHb3h9BWvBnwfV3uyQjSk/iIXdNKm1rEto08
   OwmA1GbSeVWDt4NqnhG+NcEG+pU9Ug63/Qajuq6vZl8kWxWEaaoGGRhVK
   dEphmFaC/K4ovx9cxekavavPVvBUqkwby57F3pJ4ZitUEjXnnvXFH3OBK
   ovO6ECRY+oggT4hgACGHd8ZbM+YW8cbsAaIyVC7JIDb3VKRgeU1md7T8I
   A==;
X-CSE-ConnectionGUID: pncarQP0RreIcigIkYizPQ==
X-CSE-MsgGUID: T1HdRgj3SBCyg4W72JaE5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84350526"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84350526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 11:48:23 -0700
X-CSE-ConnectionGUID: 6AegC3neTC6DOvocXMKpJA==
X-CSE-MsgGUID: YA60BXhYSDSTu6akrMgJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254039920"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 11:48:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 11:48:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 11:48:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.10)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 11:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co7Vlo6dFt88TROMxKNniAH5FbJTvHNTNoCXoyrL4kB9KA0LRY9l9iPgqzrqVDFRsH3EdnGk6bVVPcL/wTpNO6LqzGfVAoWLVfOxiAEXRlbKebL2dUTSSOmaE+5t0kEY0Zuk/YEOhik8/VO93Fc2eS5tMfFCykZHNGO85exdoSmeUMdpZS4UfpkuArkNt2ri+XwvPegn656Bq+kBW6DsxlqvoEbKoQe/G7+FedyWphtvO8XibiDG1EYpG7ysA2QbCfVvCRvMkWkbPjPPCPSY94lx9epwqN4MPtg2AjKteqFH5Vci8zCWWS+8NCGxWIFpe02kwqtixXUhya2bI+MnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwiJzDn3SHE6ZYwdVdCXdzZrzepFvPvyC7xDzhlZcOE=;
 b=PjLFaxL1dC/5i0KStiwVq/HH29XDkjXb9/bGJSVxQ3jrBVAx1eexzYTTitpOPhB5DYQRhs0Pt6XJotOb88LjesyiwVIxL5ZuM9tzyUOQ7Q/nL/92sGt5mm+L4FhGriJ8Xb0Dr+ehN1+DdaKkYrUS6M2OFowntHgiifJALy+diKIPOgh/ner5lXWcFSyJAWzFslTcM19qh4ZdcoG2tCY+0tJjJN8x/Sb7Qaj7Me7MpO+nAUyUQPYP8XPamLzTfhGJEdpDkAbtKF0uBfBawr/hyNn+S5G6mdvGVrjYHqJazyTVzzlOiL8O4w+kjLAlvM26vHxxXgnGvD3clmQ3mLDODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Sat, 11 Jul
 2026 18:48:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 18:48:19 +0000
Date: Sat, 11 Jul 2026 11:48:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <alKP8OP4DNT2nJnu@aschofie-mobl2.lan>
References: <e8cd395fc7cee8d126449db9d7fd8b37ddd43459.1781136281.git.alison.schofield@intel.com>
 <20260611004211.66A091F00893@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611004211.66A091F00893@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7930ea-1ceb-4c73-a07b-08dedf7cf9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|3023799007|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: UHTtASzKMHY8vFkllUNWxM+1AFZ5CwHR1rDGm1nkDECUxQa4e7FbBs01m8DdcmYuqVMM3IVKXSVwYz8WeclWXK0W2WYUl/dPkcOn+E2z+IEGUmibz9uPUHazA/27KmsL+x+I1MgtdTYtXuro+EqvrQvW5NOR1vXj7YDMtswlkOvYyK636ON1OGqkNNBJNNlURpq6ucl4t2em8Gx1mvfJTeiD1NbEPIf4YCpfxarDhLoVoWB2W2as9dgfT+QqTpUf1bl96NNqVCl+XhlYe/SFBybVHbHngylAwrFCvvefl2hPCf1i1GnaKkSyhuYysSeOZImYOjYVnO3Oc7QqOyx3kuOnoghy+GKqQl2CD0lR7sDlZ17MLmmVTfKmbmWgcDqxE4siWqkA6QaJ9ge91W8wegzvwdlAUgGHBMOwgbzyVpFdzb2vTAYVhiYlXcoENjH//vzyj3PueZOfsx3QhqLNFdImpOza7UnQelJ7IGWu0wNUknamShwL//rdmnYC89bDaRs8xg4AYuoa7z4/ITuOSD3wYyOTuuL1UMGp6e1KQbZLZ02jCfFFZjz9DcTUExQOIw7A3VGRwfqvpZOb4g/xIp47OFUbQe72b3GKqARxvMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(3023799007)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZNIh2g/j7BYMKJUnPvoOMwZXzjBzsnWktfoVwV9MOTN3AfW/Woy2WJ91P2?=
 =?iso-8859-1?Q?nVmCrQhDzU9gM5BriJefJ3/Wpb671oLqNYYddf+Ijpt6jg6OZ0nbmtE4oE?=
 =?iso-8859-1?Q?Pd74EwgGyGXQkW2x++/+u9vtT0yllMhe2oW8nrkPa1+AUG0kPWpwKo8thA?=
 =?iso-8859-1?Q?+NaXwoQ4f1/IOm+x8vFJ3p3NVKBlVrLyDRZS9kB8YzGrMnvb7fOYRLqcuJ?=
 =?iso-8859-1?Q?isEmAEOsuetBSMmJ6MT7jCjVbXzBr6GXAYB/iNxetYOMjeR4duL0hdR3ri?=
 =?iso-8859-1?Q?vWEfkbZ0VL7ndyHWcGoHKJPg3MoJKGCv1RjiVDGwjaK/b6aMSRfCzUPvDi?=
 =?iso-8859-1?Q?7IfJ1bjD2Q5xcExXQ7WbtKwN9dO62Vl7nyWe7c+Rx3XuhJiC3ZHCS4/aDl?=
 =?iso-8859-1?Q?SMGHh4fZH4860K3e/vfh70wyoeLGDZqgzU5jtLTDKMyzmf7sZvBRlEiy92?=
 =?iso-8859-1?Q?CTYTrgGpQY94MW5VP7RHbwNXqRvx6tYwitRHrRwzJsPb3d9vx1BWpKIiFT?=
 =?iso-8859-1?Q?gUkXgA0HXFzy0A7AqHfaQmPE1nlkZFRvPYGwWEdOOtmM/9+GV2nrR5BCZp?=
 =?iso-8859-1?Q?0V1qu7p2fHFRcKbot37SkeaFCnkb0XJIqvqmScSVoOJ+e6Rv/dwiFG9IHq?=
 =?iso-8859-1?Q?8lDAJdnzSJQ271b+dhX9WYh4u9q1MpzH+01f8uB5iFNYVq9mtKWNFAhoCu?=
 =?iso-8859-1?Q?2JJhz4y0gKsOjvHobPAZFNcCuejJWNGP34UTuq0QNgSCGn3MepsRvrmWnY?=
 =?iso-8859-1?Q?9ZQNenmU/PFKKCHS1VNYwVMvCDPDcB7KLtxfdWzTfJpaIRfl/62JsOL5K1?=
 =?iso-8859-1?Q?KyzYYzmIWYOk3wWio0sTgxabwxwOlBdYNnue+p2OwL9pi//8hY08sCDO5l?=
 =?iso-8859-1?Q?/lFEWLkC/qDkbjUdsPlt5/lCHrnQUuQWulIF7p78bYomRzWA/IihYKJ+uv?=
 =?iso-8859-1?Q?aluGZaXejmk9aaBD5Bu8BOqCZjaU8l9lZrTim0U0szYbvOjk/zSUCuq/rh?=
 =?iso-8859-1?Q?WV0AN0Uoxop+6QfLBXMsIgDkQTpKPEZI5uJnB4yBQrplObboFGdMeE1sfD?=
 =?iso-8859-1?Q?mR7lqm2VYDUsyMx48Kd7r8JVCNjlOyyXaQk4PJw8REglp3S67ybWd4/Rr1?=
 =?iso-8859-1?Q?q1L/tzw13HOflRCti9kRaz46wydcSpgeYCJYjE4tyabQ2i/YSmW4iedrmE?=
 =?iso-8859-1?Q?TLheuovHC/HemGZT1mPh+hxcpRVW/c7yxOfWhb20r5u0G+yp9HFCzsjxZ9?=
 =?iso-8859-1?Q?+WweQ+lF1nWmfLWqQ/dWgZYqXJm9iLttHrmMwhJ9Dq6Lr7SpqdZYKRE47Y?=
 =?iso-8859-1?Q?2J5CqX0KKSWwed2tzdS2oywLYYdT8D/DVXfbFN67GV3mk8WEvha1kR+NWL?=
 =?iso-8859-1?Q?ZpvaimLvRUNJYqe6QL2LUpXPXtMK9VZcME+0/5WDVcoByfskJi+rL6crzT?=
 =?iso-8859-1?Q?Hv5IkBIb6IvDTyREVncv6d8fJdv/p5lr49vBTQhQVmUSqhMDB+OtFn3f23?=
 =?iso-8859-1?Q?IXVQ/OISpcnYf1Pnsrjxqhdd4Dd3O/RUToc5uwRDOAep2+pWrUHyLxXyn5?=
 =?iso-8859-1?Q?/i4D1YD8D2LbjD6uF/gTFvQmFgHYCVAD8owZcjT6Fjjt2kc4V8io0GMsrR?=
 =?iso-8859-1?Q?k0wypazYXqLQ+eHFg2kH5CPGinSV92WUrqRcoRXhDEXSvXj42AT68LehhS?=
 =?iso-8859-1?Q?qFAOjwxtakUfITJaqY90krTUk+VpBMJctlVOB6W+rSz/PN2nDEXEM2wKgo?=
 =?iso-8859-1?Q?wlDbDZpzUJbn0ulstWu9Qi0/Ing83P0/gbbmOXbpEHP79g9PI+7H+Sfttm?=
 =?iso-8859-1?Q?PwMaIY1gRWzARoLJzCTmW0N9afScpDk=3D?=
X-Exchange-RoutingPolicyChecked: SgObBlm6ab75x9K0+eQ5SDFo67N905fE1vqnHux2nhaMcMIoqTlYS/58riJiFRz3cMcJ9SgqPqZ7Nx0nIxywejaJLsq5rcOp/ik0S6lr3NveESy0Lcjc3jbHVzANMHHxWWk5EAyzdx2KchUpeUcBYJIWI5CpSPKoMY/NTpLhfvzuobbP32UQ3bG+ewIKgCm+fjYb9em+fSjp4uxaOpRoaZ+ip0gnWFRPP1pzPrdUNrGoONVhttazArArAmNbqD2rP8pV5xYdew8smkVkc5VwCyaxL/2etoA7Z/gthNQeL4EhhHeGo5QUfntERkrAwqYGL6l+ITB6mtuebS6Y9y3ylQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7930ea-1ceb-4c73-a07b-08dedf7cf9c8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 18:48:19.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFwKnRnekFwh9iGcQhZnVEcjxmYN/m9di/4AUdTRu1VDOuk3zBEej9H6sBtjp1VCxGr5kltSxaqv9/4lHpx3JGiHkfOh5qChoORYoPZhd6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 12:42:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Passthrough decoders in CXL_REGION_F_AUTO mode do not update their `interleave_granularity` to the logically computed `ig`, breaking auto-discovery for downstream interleaving decoders.
> --
> 
> commit e8de72986281000607b505c71ee58ce7b4899cb6
> Author: Alison Schofield <alison.schofield@intel.com>
> Subject: cxl/region: Allow passthrough decoders with >16K granularity
> 
> This commit relaxes granularity validation for non-interleaving passthrough
> decoders. It ensures the computed granularity is kept to seed descendant
> decoder setups while programming a don't-care encoding when committing
> non-interleaving decoders.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1538,20 +1546,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	 * Interleave granularity is a multiple of @parent_port granularity.
> >  	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > -		return rc;
> > -	}
> > +	ig = parent_ig * parent_iw;
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +	/*
> > +	 * Keep the computed granularity for descendant setup. Only
> > +	 * interleaving decoders require an encodable granularity.
> > +	 */
> > +	if (iw > 1) {
> > +		rc = granularity_to_eig(ig, &eig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: invalid granularity calculation (%d * %d)\n",
> > +				dev_name(&parent_port->dev), parent_ig,
> > +				parent_iw);
> > +			return rc;
> > +		}
> >  	}
> >  
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> [Severity: High]
> This is a pre-existing issue, but since the commit message mentions keeping
> the computed value for passthrough decoders to seed descendant setup, does
> the auto-discovery path also need to be updated to ensure this?
> 
> During region auto-discovery (CXL_REGION_F_AUTO), cxl_port_setup_targets()
> checks the configuration but does not appear to update the decoder's
> interleave_granularity for passthrough decoders:
> 
> 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 		if (cxld->interleave_ways != iw ||
> 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> 			// ... validation fails ...
> 			return -ENXIO;
> 		}
> 		// cxld->interleave_granularity is not updated to ig here
> 	} else {
> 		// ... manual config path updates it:
> 		cxld->interleave_granularity = ig;
> 	}
> 
> Since cxld->interleave_granularity is never updated to the computed ig in
> the auto-discovery block, it retains the hardware don't-care value (such as
> 256 bytes or 0) read from the register.
> 
> When a downstream switch decoder is subsequently evaluated, it loads this
> unencodable hardware value as parent_ig. If the downstream decoder is
> interleaving (iw > 1), it will calculate a logically incorrect ig from the
> garbage parent_ig. This would cause it to fail its own validation and abort
> region assembly with -ENXIO.
> 
> Should cxld->interleave_granularity be explicitly updated to ig in the
> CXL_REGION_F_AUTO path to prevent downstream decoders from inheriting
> unencodable don't-care values?

No. A downstream decoder can't inherit an unecodable value into a failing
check. A >16K granularity only appears below a wide interleave, and
everything below that inherits an equal-or-larger value that an interleaving
decoder couldn't encode. So every descendant is necessarily passthrough and
never validates granularity. There is no path where updating the F_AUTO
value would prevent a failure because the failure cannot happen.


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1781136281.git.alison.schofield@intel.com?part=1
