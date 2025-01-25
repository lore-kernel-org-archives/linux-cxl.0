Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6735974
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765082; cv=fail; b=JMbL2wmvnw0GVlhvNIFHZlVLqaZgTRl+JgaiXLwRl9Ugos342HIpGpLfB8tSYpgcM2QVctaC7afqGqSBZ+NlTKRj7i++KlWmI1lB841Xh5BH85qhxO7VO3qQw9DXZ+r09TtoBTaP10YI1O2f5nCJ/u71GjvYBts/4Lb0OgtwpKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765082; c=relaxed/simple;
	bh=tfSdEl89QwGXLH53x1LfyVwy/8XBGhAcgxkm3w412IA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMz20wsTOrqpEJ6L2pxtPdFcj/NU5CVYkjRSJNEkYR7zBMSTMo4LuJGgYg0h4xfoKrKAOdkrhL4W36aXt5h+vlfxldvziDAI1EVHtB6RzTi/scJ3wq0g2hhXjQVM9p4H6Bz7no/ZKpC3lRWhbleXT34HxxlSooInLRKz4VF8Wt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMz9ea4d; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMz9ea4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737765081; x=1769301081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tfSdEl89QwGXLH53x1LfyVwy/8XBGhAcgxkm3w412IA=;
  b=AMz9ea4dewFRDsg/X1mmt1oOy2Tt3sc+75u9KycKVJhX8wEx+JpW2AcB
   x8okSXPVy0TkeRf3c3zPULjVww7aTNGGvetXPfpB3biUVdeeEM6iyLZkB
   ddJMruIYGwSN30DTwxCPQikon6IaH0u1bWBoPDPRXpYauarVBlM3jTjCg
   cYFlzs94/3f89rBh3okYmrVFwZNM08l1D0pBPBt+FHXG8aFrccjZMsSJP
   0yYjvUxSMOkVbylDlKN1Qc1bgSmeSLTPFF/agpghT/AgoFMqzi2q7PiNt
   6QKQU+qvsP02ZZyaQDLOjqtpsm5KvL4GNsDZJgQCPmtzmEJv1xez3hVnZ
   Q==;
X-CSE-ConnectionGUID: 2zouRuleTKKIgDj4zO28Qg==
X-CSE-MsgGUID: kzShesztTWqcGG8HcJy1Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="37569578"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="37569578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 16:31:20 -0800
X-CSE-ConnectionGUID: nRNtJfk4Rs+zfC3zkoX+kg==
X-CSE-MsgGUID: EmYbKnsoSiiz5CZp4G/6xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112538085"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 16:31:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 16:31:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 16:31:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 16:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETnaqEulWdE/bySi1feGw8aIDtNaZxz0M9VdmC3wlm8OiSBKfMXckj+KZKhDXmdVue6fe0ktlaCVsRieiUA04cv30Q+yG16zX17dLde7Ku69Ok3WdgzpDO0NItZToizmD7pPt6IXLyI4/KNL6Dlvua9PF3pB+UBImJW4sXcO1QimCGVJ1yYmvSs6pHc1bx4VYvP9+ns7ALl+DRHIcTk54CdAtpR4+dJQNWzoiSw7PwijCxuMQZXmWX8jM/5KWJz4b6t9bdpT0B0pxc9exfRu2IfOLcGArBXcaqmdvmtOlIPQeJWJDUCkoBLU2PtpAjua/wDd2Md8izFtWkztwlf3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqLB50isepqO6WrbsBlrWehDVQaBlieW8+ARfrha2mg=;
 b=wTz7SnoHIc6oqvbKbvWCwRXxHp4kuf/9Ihpm1H3YbTzEBQnO/5Gnb+gY+ZHCLdQwn7On4IrRCZ0wasIkFt/JwyuC3TpgOIxAlwtBPFe2KCsTyW70C9o/Jp4WiQqoCBWKxZPRVTkn/1amEtS28Ri5ozTKEnbmj80xyu8qNw+X97hmS+/4GvDBIQRIg5uZlbI3Qtho84aA2tPCmRbV08vaSO17bXfBAElhnizOHuNNaFikgFwYNN7BKT0qWEYazTN4uiNF2Pmkh1jKCHn5YCR1/IJkO3VrTImNAFoUk8N+D91utsYpkA8ZBfsDiG+AtYDQQ9h01FWE+JRjRhyfDLvE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 00:30:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 00:30:44 +0000
Date: Fri, 24 Jan 2025 16:30:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <679430b145dc0_20fa2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250121042531.776377-1-dave@stgolabs.net>
 <67901f97e604d_20fa29489@dwillia2-xfh.jf.intel.com.notmuch>
 <20250124231945.77pnqslva7qesxws@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250124231945.77pnqslva7qesxws@offworld>
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: c42d73e7-c32b-47f0-caaf-08dd3cd78111
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pZpkfZ0HWVtMOO5TJ7rfrWO1hicUOJ8ujGEZH2UnaacHAKuH/ol5mLN035xE?=
 =?us-ascii?Q?eu4VvuT3z8mIeC0monqwTPTKRebwGOojdYVrGlcNuCqYmBjjCIgvOUc/unaz?=
 =?us-ascii?Q?EIiQD986YM5YJdPcvnJCNbT1Vd9MQ8d4RMt02iSmc3o1oKqZ0W+N7d7KePKJ?=
 =?us-ascii?Q?IeYQWU4OW5570/m7Z4QRa+fIwhm/gM3WGxP3XmwAyAk1v2JeONCNV3jlrodu?=
 =?us-ascii?Q?hfogO4vtJajFY7pDQmArEyzAV9NyJmpf8pfK1nsQtc3rRm9hNf7JUq6jzJEH?=
 =?us-ascii?Q?Gi1sCklnsB4OMESs04gMF+uRbCWo4h9WivB6X6l3XaVN6qqq6a/HBJ3OHMGz?=
 =?us-ascii?Q?wEK4Uy8x5qYZkQVfVoKfOfKL+PApEO8kG6FeNbg1LvzNAuweY/zwLaZpkIu/?=
 =?us-ascii?Q?hrXaVS8lCFxrvo+3CMCJHF5GQtaaMQAomRMOwO20He2XSzCBeB9kQto98Me0?=
 =?us-ascii?Q?eoL5deeePfALXyHTPK8HXVSkYZsz1OddGyQZ+F98/u5NXO7OHRctcdKheaFm?=
 =?us-ascii?Q?rw5BCzeyXRk6YOopuuqGFndVA0FKDDYJ+fBOx3AAyTuBzPYm8xjquc1WoLcz?=
 =?us-ascii?Q?ERJgxwNCO/nJbjRw/RjOR6IaBsQ/rFvRTWIuQz7HzYeI2UzWsKWcDDPuWmca?=
 =?us-ascii?Q?W56/gkPt9InLzlTaR45TOZs44N2b6aGDiGSEqdNIBoejY43jC8v6/+QxLJwz?=
 =?us-ascii?Q?NKlT1YEn08dPmMXZBhz2J8G7MrqmGFuZP2rsUazmrLO7kMtbHQCjAgYjROAc?=
 =?us-ascii?Q?BMrNw59W5SX6F8EFJpHVClBssy3/7N4W5MGBM5wVc5ps/topXOQ0SkGJfkiM?=
 =?us-ascii?Q?xrEyOsUFbkkkOulhOc+WwGybEP/7ZQv4wIrGSjNfzynruiGE2+NBEUmgJxeg?=
 =?us-ascii?Q?ZvrUMIuIlf13NLKo5ho5EIzoZLGsa21k+wCq2WWi//nkPici3x8PNzILFfYk?=
 =?us-ascii?Q?/VtbGS8MWIXeU2s8M71YVakpJtLrv0MUrps/a1e8MnCtBwNF4UZBxTwF/fTF?=
 =?us-ascii?Q?zwWhGggYELNIGo17bNSbXEJ50FisCjgchSH7dStK/ZZ2cQcmWfrzmoYo3vCq?=
 =?us-ascii?Q?1Km79ltin/e9HitIOTe/FPppae7uHGnUZ2KRtdltetplJUmH5z8eLzvY7vZb?=
 =?us-ascii?Q?a9pPmgi3yYPGQSMD83ppAq883IKI+AKhc1n62wdalCVaB7ZNda8ur2cbUT/K?=
 =?us-ascii?Q?30+3n9XrDk4teY1wscf5Hp137bN8akOisOFtr0u36sHP4NW6TFxs12C2V/Jq?=
 =?us-ascii?Q?9yAlilMXceWZsWATAd9W1r5WIkPas6t0zKujVpTfcILMabEeQpPZalvQcjaS?=
 =?us-ascii?Q?FzIq3ecLOLY2i5R8/oe4QTAK88Xwweoke0wL81zjqXVPu4O8Q76+GQGzZaoM?=
 =?us-ascii?Q?QpY1KOpxrMR8FvvGXlCYiKfwK5Jy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkSuuZttuMA1j9aW148IRi6qsJxhCNyV00isoReZiSwRQShlwAd5wgqsWC0b?=
 =?us-ascii?Q?JZFTLNCx1LUof3nXPsWvX+VVhRKbMNO9mBAjIhGBs+0dzkrvWXxwsIQppYr2?=
 =?us-ascii?Q?/54tIyWMYpu+gk7N5YhcU05DyK1t9hlRjFqwYMVrZdn5tN5oBWKGEetvvhkN?=
 =?us-ascii?Q?KpslKBJDo2HtVe6+ptJ1+7LKjkAA1Vbqdl863vGtnZWxQjGnwKlyPWr7t7lO?=
 =?us-ascii?Q?4aHYADP3eXQt/YcYKHJMBGj/TcMn3Tg1s0xXeuWHiMTD0rwwzy/o2axHj5al?=
 =?us-ascii?Q?VbqbnTdfFFMNCtx40uSVyF7HX4M9rvVl0Lf0izNP8r/tPC3coXi3ioz55+Rw?=
 =?us-ascii?Q?KHa6Eb4RVYmNSA5ZvqLFcZX+i4LKnesfboDMxyrPQUnSUAALPNFWajRGrc//?=
 =?us-ascii?Q?pMMS/ojFmDQ2+6bhhw6MscH9QidiWtNZpVWixtLuZhHz6TkGM0m/n5tPr9fV?=
 =?us-ascii?Q?/exQYZIFtaTQmykfOooKPlOKrLTIA8AXO4MQX+rUQQ0axALyH2CjnMWQ0Oxd?=
 =?us-ascii?Q?Uko6/7yh59HsD96e0b1kmP65BUcTgH/lj9/8ArxvkAumU4w8D0I6ngzMyCf2?=
 =?us-ascii?Q?d0rjuRK86lRD4CAnB1tWfszjKBRghBdYVNDWgAmqsm3BPKJVNHKn60ELTlrL?=
 =?us-ascii?Q?07dQPzLHM2lmX3csdC2aKc71GDiOq+VHi5GUCoSZs5jAqdqZSsDMjdRrdkPR?=
 =?us-ascii?Q?stQU/BViW4hOpVMynoesIZXFfEkpz61Fm3nBfREbB79lwzj8mul+rN9Ujw3V?=
 =?us-ascii?Q?xI8XZD8FU7n7odQ1ylhZI7fGRMNktP5oy32ID6TLwZrkp1FTNbIs+kJ5Z8TO?=
 =?us-ascii?Q?JHVdGlVd00V+ggBR2lzijWBQ0CWaq/RbQR8mf8IMnsBlNFOSwaKnb/yUavaF?=
 =?us-ascii?Q?sWc5IAblMK1S79ZqtJ48UDr/KPK7F8PnP/k3Cl5eZZVNd7h446GJUyIRt1Fh?=
 =?us-ascii?Q?53TtWb7JlFrED+rkxcJMDmi8r4UCg4vDVkCAuTpkqkBWorhMPUD/Fi288pTr?=
 =?us-ascii?Q?3d4hxudlE/oyuttVvaS5pfIRZOwqGgCEn4JxAx9JSlt+bsEtaxjwwgw0FMaB?=
 =?us-ascii?Q?ZIkEEc/bo1GnQfvAXBDPgcrhTD60FS9SFLVoI8ie/UvuSABPAmqOlWkh5a0z?=
 =?us-ascii?Q?IIGvYrqte0sIU3puVWGkkmqBvd5mQuI9xk0kKZZi5PKveb4ZgsfIvieu7ZYx?=
 =?us-ascii?Q?nMXTysu0KDHFXdJl5M2j9/wdG9oMlYgKtOVc47sH4EzHoqLB4nSWwpkxcfXD?=
 =?us-ascii?Q?dalPalAAWCsPmrLTVEh2kllxefXtSbxUmu6ZvYy678Rue9HF6EaMkGsY1//9?=
 =?us-ascii?Q?qB570gCvAvBfuF+2GuFvTeVUl3LbNgpLRe0kntsTJ6u7K+oJByKLGqwAfcpF?=
 =?us-ascii?Q?JSsUsf6g+iEjcoPwfqoLyJJ2sxAwd7mQoK421IaYk/hMUu8sVgRDuQ71/Igk?=
 =?us-ascii?Q?Zj26pWuF/hJs+YkK35AvgvnPu6esL+SLOaG5REyZ4uYeNVn9u1JLKf30wqqw?=
 =?us-ascii?Q?2Wid/H1TAPgOy99cggMN0ke6o+/svV9iGZ8SF8QximxkGVv4YeB/aF7L1Rzz?=
 =?us-ascii?Q?NininL3VJeoEOJLsPFQPZ3Zj6VC7opc0caONfPDG8lwQcawDy94JurawnJUN?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d73e7-c32b-47f0-caaf-08dd3cd78111
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:30:43.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCk8G4KhNCFuchzRFd5O/46460RFa/rJovwjnYgoO6k/D/E33IO21zHEzFw+DH1incUxLy0kzvNjhcFP4uT33VGQ54lRvGNYkFg0MYn3YWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
[..]
> >> +	if (!dvsec) {
> >> +		dev_warn(&pdev->dev, "Port GPF DVSEC not present\n");
> >
> >Could be pci_warn() to use @pdev directly.
> 
> Sure, but afaict the pci_ flavors aren't used throughout the cxl driver.

Fair enough, yes, match local style.

> 
> ...
> 
> >> @@ -1038,6 +1029,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>  	if (cxl_pci_ras_unmask(pdev))
> >>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
> >>
> >> +	/*
> >> +	 * Set dirty shutdown now, with the expectation that the device
> >> +	 * clear it upon a successful GPF flow. The exception to this
> >> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
> >> +	 */
> >> +	if (resource_size(&cxlds->pmem_res)) {
> >> +		rc = cxl_dirty_shutdown_state(mds);
> >> +		if (rc)
> >> +			dev_warn(&pdev->dev,
> >> +				 "GPF: could not dirty shutdown state\n");
> >
> >I think the proper place for this call is in cxl_nvdimm_probe(). That
> >happens after the device has succeeded cxl_mem_probe() and successfully
> >enumerated pmem capacity, but before the kernel commits to using pmem
> >through the nvdimm subsystem.
> >
> >Had shutdown_state been part of cxl_nvdimm_probe() since day one, the
> >policy could have been: "if cxl_dirty_shutdown_state() fails,
> >cxl_nvdimm_probe() fails". However, I know that would regress cxl-test
> >and qemu if not devices in the wild that do not meet that spec mandatory
> >requirement where Linux has been lenient for a long while now.
> 
> So qemu has patches out there and I will also send a patch for the mock device.
> 
> But yes, I agree with your approach to failing the dirty shutdown.
> 
> There is a similar consideration to have with failing to set the port
> dvsec (ie: not there); should we fail the enumeration altogether? So far
> I have been lenient, and considering that you did not mention this, I *think*
> you agree. For users that know they will never need pmem that doesn't matter,
> but overall the platform would be considered to be exposed to data corruption
> (and afaict gpf dvsecs are mandatory). Perhaps another potential sysfs
> file that would alert users of quirky hardware?

gpf dvsecs are mandatory for pmem devices, but given older kernels
happily allow operation to continue it feels late to start breaking
setups on new kernel upgrades. Given that the administrator needs to
decide about their dirty-shutdown count policy anyway I think it is ok
to punt that whole policy problem to userspace.

I recall that the acpi_nfit driver exports an Optane dirty shutdown
count attribue in the nvdimm sysfs hierarchy, and there was never a
kernel policy to fail driver load based on dirty-shutdown. So we both
have precedent to not fail here and can eventually copy the same sysfs
precedent for attaching a $provider/dirty_shutdown attribute via the
cxl_dimm_attribute_group.

The rule I am thinking of is:

---
If you do not see a:

/sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown

...entry for your device it means dirty-shutdown tracking is disabled
due to:

- lack of kernel support
- lack of device gpf dvsec support
- lack of device Set Shutdown State support
- failure of Set Shutdown State to dirty the device
- failure of Get Health Info to retrieve the count
---
