Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A7191
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738368537; cv=fail; b=iupkRxlRfNVwBzjoMGHrmGtM/vsnsGfKMROvIV2ZgPLF6s/rTxKorDHjY9OS1QjERbHo98eUewFC4Wr7ae6QqoDehkMkKvHilWU/+MgFQ1ErNheG5BPPa72RLWKUdN4tJ/AQ4agNSVgrOb73d7MnwUTpLbSWiduMRnaIEw85upU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738368537; c=relaxed/simple;
	bh=Wtcx5XuZxtuy3I2LyH2Y2yhzgqMxeRi8s3LkVfe+FGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fCvQwQJmosiF1aZuRc5NRAm6uKeNhA0m1AXzhVho1NPatqrEXhBxTGanTa2kUzCahyyk/BQcyju5xBa9akypan3c4SAkRNQY7nnJv2qxLu8jVx1Lo29yWir8u9c6NrK07HNokKQqU1ASq0mIMNb5ZI0FI1DwZRIx+M2TbHX1Rb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvzpaElw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvzpaElw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738368536; x=1769904536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wtcx5XuZxtuy3I2LyH2Y2yhzgqMxeRi8s3LkVfe+FGw=;
  b=EvzpaElwnC1VQkSqbKCKoyd58ta6/gErv3O4zJ5ZCvzhUxMynRkTKtum
   7otK3NDZpoLrjCKTPhD1EECTO+z97lKknpbazWTeDSPACe1xzYRIhiyhn
   MNzpHWQ6L4CuR5g13j8AjSc6m2VtHhTiMMWalWe/E2/Xxan9jywob1NVL
   kG9c3SxE3ti8AVa5Hmp23fZZ94yiy4mfGy/F36oEGJQAJZAK40NYRdpq+
   na14e85Gbh70n2EKEmX9Wp43oX/1OyO2CtW8AJ6+18ULrOOltUrtSKpSF
   MNSHain8JD6Q8HurG0TUUqBYWO9GRC5vQ0jnU8kvpuzlOsF2b1NMeu/vn
   w==;
X-CSE-ConnectionGUID: gcJ4Y6elSyuoRCD8KV6iZw==
X-CSE-MsgGUID: AhA7OSqvSGqx5Dwzpc5wUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38835267"
X-IronPort-AV: E=Sophos;i="6.13,250,1732608000"; 
   d="scan'208";a="38835267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 16:08:55 -0800
X-CSE-ConnectionGUID: eWwooXz3ThCwHQk+umt/yw==
X-CSE-MsgGUID: krcG5x5rRwOvI1Rtg+NdBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,250,1732608000"; 
   d="scan'208";a="140643242"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 16:08:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 16:08:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 16:08:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 16:08:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO6RBD44LyRmdG9wzTWSLjNmiCnd1fZHNcAJoZoqVuzcvSHy+TZBiZmHempx1bqVc/jZE8f/nMdhXPWrP9xwaP4on1m5amEBsHIRr/QfqvRFkkCS+sJ4SMTydcRB055XPTNxgEuDhDX/p2OXSQm3E+DvlD5Cbi1pfwrArofUjUIE3tnMNbJgjgy9XAFWbE8nEz56AkQwl3UTxy5fjl7b43GQRg317uf9qoXw1a8PmBptFJjuYj/casirE9fDvfn1zUULRIQt1zm69R2QTGhZn7BUw6V3m5eCHlcG9fGnkYQzIz93yObzVWDAKkt/ZlPft4OPzys+4DzSW2303d8iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8gE4RehvoE34MONyMy2JNccplweG7Fh4PsOeHxIrTA=;
 b=bZI29sCNLnD/abDDtYksn3nWMS8nzSPp/mV+bggN4Uq3KrvxcYBrHq/ipQ/RaAJ7ultdoBXB4FhPHigs5dtMEMQEc3+1j489lglCBUD4bewyMdi/n9sTF0ljCIe8veS8cXT/nQc95JjiQPWy/uRAXH3k+Wa/yzn/w7Yh7xyt+ZrvBgmJ3TyLDV/JXC0+/fvorPmcNTuPCM1f6UxQ/zoDhiyNBs6jfYgt0XJ972rDxlFR39YKS4daYhTPmw9m9N2gqlfM5Ga4HgOePn4WI+V0BJzkIddPAOjhVT1KcQvgoK5UidV3duyWmTA1/hDMC4tS7FlYitKGIVeI9bTuymfyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL4PR11MB8822.namprd11.prod.outlook.com (2603:10b6:208:5aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Sat, 1 Feb
 2025 00:08:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.017; Sat, 1 Feb 2025
 00:08:51 +0000
Date: Fri, 31 Jan 2025 16:08:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <679d661190454_2d2c294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
 <53ef6364-4523-05bc-4fa1-8a2110f5fe54@amd.com>
 <678ac4316a7f5_20f329456@dwillia2-xfh.jf.intel.com.notmuch>
 <76174723-c8b0-8937-781c-3e46fcf6c0b4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76174723-c8b0-8937-781c-3e46fcf6c0b4@amd.com>
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL4PR11MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: c75b8d14-ae99-4f8e-98c8-08dd42549be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AW8NmcEjnSqBpNn4kE0vnzUv4r9zW4SWGJSoTdhpclZ1PI0LyB7rqpu7d+Wn?=
 =?us-ascii?Q?7SVmaKUPTnyrkMLsyHEjsUlGJOXw1pnLhpQ8P2XN9doNmDLlHoj3VEuFShaD?=
 =?us-ascii?Q?WOAUJmeQ68qyYiaHsgno4sZGoZA3tbG+akbi7rJeJjE9F6fn2RN4PCT2TYNd?=
 =?us-ascii?Q?yn+BgIt5wVK9dk6Wv/0hHNir/zdlAddoCFN1aBqHr5C9QVIIWHl4CEFGpJl8?=
 =?us-ascii?Q?WlxPqDby0IxM9DDyqQlHxYQRrfZkP5EmdZwjJer62xWQrGee7p8MweQ5BK19?=
 =?us-ascii?Q?5X9OatY8Qwq+e4FWr30yKzw9RXzC4Oao94Aga9EYF6yWBz9CxD3fJBogVFW8?=
 =?us-ascii?Q?rJ/18EG40Ty6y1PdG1vUew6blBti96SxnBa1zF2VuPcbPjHhI2KpKLg0y4SH?=
 =?us-ascii?Q?TvLr6e2XcRihk+d0hE0KGzzDdcXRa9+sGvN3GmraHa98n58thNMzTMfpKai6?=
 =?us-ascii?Q?8JrLduJshD6yPS88/FZC6KWbWTFUFT1dC+RFK3OuY5EWuWIJQjvnaFomup6A?=
 =?us-ascii?Q?XDYquTr4qEwwA7qVDJ8aG4pb0g8IC+cqBayLMNW8gkaphJH/8nE6oq4yVE2D?=
 =?us-ascii?Q?Nhmr2QdxdA61yxRGECTDF6809NjR1XxqiSSZI4SX/CfsEGcjsHiW08IMAsWK?=
 =?us-ascii?Q?8QvTfLOatq7VZM3EP+JOf4cjOo99qBVrM8NTSFXJY1QiW/qQL/D+INmehR3n?=
 =?us-ascii?Q?4rMkKU6ufTGceNnh/rSdPNRhesb3YEkcMO1nDlCZI/PTLLuysA2dmIn8iIDO?=
 =?us-ascii?Q?XMzZSjbV/POrwh49TO6UqDkmssl3Knw4cRbCA5UIHHYwdsMHE6F/VcgbMUVV?=
 =?us-ascii?Q?CBcc6h0AbXOCD8xrmbKkv18ryaMzxV2sJIZDK+61/hx7bRLj8bbXtEKxDhvT?=
 =?us-ascii?Q?xpsRC5adO3srniKNV/wnIehG2w3jnfkU7eWhmUo7OBjLXDt+IUKOf0NxRr7p?=
 =?us-ascii?Q?nC4UX+aXk9f2F0VNlYYJr0oDwDGy4WI7imBYCxyXgGFLYUGSp1iDteTtaFkp?=
 =?us-ascii?Q?SmsYLmhK8yho2DXQuzebWY+WQ9vEBfOND+MhgLf+RZn+HOY++5bfUyO3Ivz1?=
 =?us-ascii?Q?g1aX3/uEc4NU1wwRckijpno+QOsH7+fv7OExPtDaZ3uiWl/ZkG4LQuP5Npy7?=
 =?us-ascii?Q?L8SggUZuSt/3qa8j67kdiS+gVcIlzoZnMj45Laz0QS/CYu3D2HeYZdvGvLrV?=
 =?us-ascii?Q?tJ+4+0j+AaX9hGEvBNuAOqq7Hb1fpUulsxS0W5mjuWIVomvb1qcuf17pXjkM?=
 =?us-ascii?Q?PmQbjBViOsCpMCPOpojfULouyZGIj2fWe6/iFwXWc7XgZkRjNFOlc8FHQqUv?=
 =?us-ascii?Q?wGQbFLBOjBU64UAPSEyqx8AMrNWNlUxBXDUSrieNTRRcSt3j+CuOANFHKHM5?=
 =?us-ascii?Q?NYUhPrju6vDJimk0xGg+F0rE40TS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bjTk7l8BcGk8OuxejkdUVRnOMjoyu0mZwIRn+cqAfA5QG/5H4be/G/uvNeA?=
 =?us-ascii?Q?KdYw9VnndtiwhEDe9oXDD+81Koa6yi8u2YhPFrFEvmXFQ/7RwDF81HpCTGVC?=
 =?us-ascii?Q?G6DkUsDKX1N2o6r5RGx0nLi3KL52hdrnpOqSGOyRnVrig4sdlxwgKIGFz+nH?=
 =?us-ascii?Q?VT4H48aEzfKB4RUIWP7Yf2i0q3dfHbZm7n5PGFysbRG5ziNIlpyHlUBYdvNQ?=
 =?us-ascii?Q?cjGdl1/XpbfJNkBh0Vsg02bz++Y1lLn9UUcO2kDZbUHgtj++XaRDcHHs/w8e?=
 =?us-ascii?Q?zNUiA1S5SEFt5rkISqqQ1CZ1zOwFuEWxtRi3fguP5IUvxhmlTORZofRyuoEm?=
 =?us-ascii?Q?UCrSOsfcUysBB5KAq80TXoHod8tCO3X2zP0QvgrGx3zKvhgvV+lQsfyekqFt?=
 =?us-ascii?Q?/kFI1GEJZOSwOVTIL4Ivnyk/enpOyQkWYubH0tENuQYcR51mc5K5hwFCIu6r?=
 =?us-ascii?Q?U1PJviXyib/CF/MKwu/a2krt7lMh6sq43bwqQ2EQ5/q52U9VAkFO40D405J5?=
 =?us-ascii?Q?4IP/qgH8t26VVF1hG9mCmVBeFWMShMF3e69vzmrbn3wcehs/S2nJA3q6wYNL?=
 =?us-ascii?Q?Ec0Hxk5/7FdKQ5lgwTaN7eX4cmlBG5zDZxUXt0i8g8A1EB5t9sBQZWFefPSD?=
 =?us-ascii?Q?r9j3KY0xA0Sl8RNf81PaLGdHffSf/SskVizc7jtbNtrwNwJjCf7Fu3NcMtiI?=
 =?us-ascii?Q?ClU/At5FqNZ3GUO3hzyW0+gGx6SAIOQiddOxyuazcfA/2tgAmsxJ3eHAmeCb?=
 =?us-ascii?Q?RKn5brOSz5qlAgyrmIjvh0FdicQpV8JnIsDrTAOWr1PTWjD81QyBSFBgguUc?=
 =?us-ascii?Q?39NEbSiu5tl69P6l079Twf2rlK5WvRxDp3NfZhTNOEB0ApL0frAHS8xsy4sV?=
 =?us-ascii?Q?UzVDDSAMaLs5RNK8JINOF+hlfoJo9OOYsv7YMBDN4al4EQ/Wt6vTrcG4OFgu?=
 =?us-ascii?Q?v/5AKUMs2HjTK/DGYC90WshQZfnCHMPEbaSMrimvG/IqIa7NJJK8qpf8PtgR?=
 =?us-ascii?Q?RNlChYwUmRpT5NFpNefyNxko85SDjgLVEOU+DOWlXdxS49Mfdg6LMiXrJHvE?=
 =?us-ascii?Q?4yqVs8VRvoYSIYgflE4cE0sqkBh3dDSuafOvL+4YLk6TgDtPy25qU3eq4WXL?=
 =?us-ascii?Q?G3V+oHklAzujWKsxD1ZiN3czd8sFrMgvsikcZei7W3/jdm5DvaofOeGpzM/P?=
 =?us-ascii?Q?AySYhnV5gX1L7SQmkFM2QTXEeAGzXUXZZGVZW+f85oq3Gu68HPkJs5vjBa0b?=
 =?us-ascii?Q?igDS2pw6wMi1flJOse45ZqtvccMCB78Pg5a7VmuBCC3DbGKR0/i5qlo4ee1u?=
 =?us-ascii?Q?yVaZUmdGDTu7iRb2UcPuAzQaM8WMpVSh6wmmQgln5jvTXC77YCyS5wb6h3/a?=
 =?us-ascii?Q?wnquWdK1qJVi/jJ6utl8YdZ1D1qZWqSQYDxzCoLD+7ooDj49S4Fk0gIhmxLs?=
 =?us-ascii?Q?4bvzasNolpYJ3wEu2lnjHQEyrRKGwDjpVetjKdJB8ydjSka6W3oiu5u3eotD?=
 =?us-ascii?Q?m7eESa432928N+J4C1+/mkV3pzHGDN78FgFfB4zgKDe4JI1esTY6VgACOYCE?=
 =?us-ascii?Q?gwSpzUVFyQsx4GaqhDWeC6556RzzoYHQAMiVO9QSwK4GZ8cLEg7GOKVzLT2I?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c75b8d14-ae99-4f8e-98c8-08dd42549be9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 00:08:51.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOznJZ3zyaKnYAVAxGaDFD6Yt+nz/yV3kWhiOYxfrXlbOnL/ip3/Zwcs/YG3nrQipGBXb/vrWH6JvZgDPtBeB3UdFFxODIW9y8QrGGj+loU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8822
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/17/25 20:57, Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> >> On 1/17/25 06:10, Dan Williams wrote:
> >>> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> >>> allocations being distinct from RAM allocations in specific ways when in
> >>> practice the allocation rules are only relative to DPA partition index.
> >>>
> >>> The rules for cxl_dpa_alloc() are:
> >>>
> >>> - allocations can only come from 1 partition
> >>>
> >>> - if allocating at partition-index-N, all free space in partitions less
> >>>     than partition-index-N must be skipped over
> >>
> >> In my view, you are mixing the current code with the new code in this
> >> explanation. It would be better to say the current code assumption is
> >> just two partitions, ram and pmem, but DCD changes the game.
> > There is no mixture in that description. The rules have not changed from
> > old to new, the implementation is updated to reflect that the algorithm
> > never needed to consider ram and pmem explicitly.
> 
> 
> Well, if I'm not mistaken, until now we did not need to support an 
> arbitrary number N of partitions but just 2.
> 
> In fact, your next sentence just confirms this.

Right, the algorithm can be more generic, and that is immediately needed
for the DCD case where it adds new partition types beyond pmem.

[..]
> > Holes are not allowed. If you want to delete any decoder capacity you
> > need to tear down all higher DPA allocations. That is a constraint of
> > the hardware definition around how software can assume the value of
> > DPABase. Will add some comments to that effect.
> 
> 
> I have to admit I do not master the case of regions created from user 
> space, but I thought the idea was to allow creation of regions from 
> independent devices for facilitating interleaving and just adding 
> flexibility when needing a memory region bigger than what only one 
> device can offer at some specific time.
> 
> 
> If so, I would expect cases like two different regions using different 
> ranges inside a device DPA, and the two regions completely independent. 
> If I understand your answer, this is possible but if you want to release 
> one of those regions, you can not use the released DPA until the first 
> one is also released ... my instinct tells me this can not be the case ...

As it turns out, the CXL specification mandates this counter-intuitive
situation. See the implementation note in the spec titled: "Device
Decode Logic". There you will see that if you have regionA and regionB
on a device using decoderA and decoderB where B is a higher DPA (and by
definition higher decoder id than A) you can not change the size of
decoderA without impacting the base address of decoderB. CXL HDM
Decoders are not PCI BARs.

> If what I'm saying makes no sense, I'll try with a more complex 
> description with a timeline and actions from user space, endpoint 
> decoders, regions and so on, what will definitely helps me to 
> (hopefully) understand the user space case.

See some of the commits that deal with this specification constraint:

105b6235ad0f cxl/port: Prevent out-of-order decoder allocation
101c268bd2f3 cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
cb66b1d60c28 cxl/region: Allow out of order assembly of autodiscovered regions
2ab47045ac96 cxl/region: Flag partially torn down regions as unusable
