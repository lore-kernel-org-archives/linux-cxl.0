Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37091CAA66
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586765; cv=fail; b=q5ru6IgoHzwxI1AHPPUr7pm5H1vk3QSBhm+CqV5uZbTXuvtkmiZVEBrR6B4zbwnfjmoMz26h7IdvU61wwqeKhsaXxGUrV0nYfqLgA9DLSK9pPFNReqEOH2evXRhKfTNH15+vbJ4UM+PYLFOCJxXXjc+KTSah6OF83AgG3WRESjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586765; c=relaxed/simple;
	bh=tayAl074Q04RKcR2MU7HaphO8d57IoYTmyQ1g3/pKcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBkH9GDsKQR5CbE+DDz539JcuRi+E5Jx67jXg2xOmKzjfH4VsjLBydAe2qgBU6TgaailZweFQHSHrXF3Pu4l92ZCzvZKo1LMXn/kXDxt7kfyhH5uXqjx42pcVSHtQ+ebF1T5/fIXa0tI9XFOaWq83ZPOunxUWc5k5K6zpmKhb7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeNrciUc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeNrciUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737586763; x=1769122763;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tayAl074Q04RKcR2MU7HaphO8d57IoYTmyQ1g3/pKcI=;
  b=BeNrciUcgaj6J+9sJAXZfuXNKhnqUPE/m0DppuZvrv6M7Y9i8ro2PnLu
   zz9jyaQezOJuXEADoeqeLCb3btgFaN03DNirpUyA8W5xz+rqxtM6211pS
   laj6xyhdZAjV1OupqBzHAOF1scKnY0W8I9WYBb8I/XpfdftevVOl69yuA
   9gnglqKIwO5szmeh8e8u8cmsJUUDArHQj/gkGc7jITpBzknmbOMYPhmJs
   xOYf0p48Tto0HYnidLRYVFEIsHu5HNQgAF0B258TezPU0QXfb+QkrjqCr
   4ct2NYXUgEY4i0JKsZFr57GkQ11K6eC7fguSS5XVLZcyvySbl0P1CahVC
   w==;
X-CSE-ConnectionGUID: GyH9aXsNQJeFeky5OBbHoQ==
X-CSE-MsgGUID: yVM9sj2cT9GzEJapd0mtyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="49057013"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="49057013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 14:59:23 -0800
X-CSE-ConnectionGUID: 0OwNShdsSfqgaZerYapBlQ==
X-CSE-MsgGUID: PacwZlofQqC2aWrqDyxd5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144535404"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 14:59:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 14:59:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 14:59:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 14:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSWm2vDPjh/kqT4zsfbD1Jqb9gjH85WeAwbdRpNJE9gLRWTEdSA2J4JttkNE72H6pX3MxBoYDqPDTswNlYyh1rpzB2mNG1P0aw9DeadqS14OIW1sTXay571xneERIPWou4vCojHPFePw4q+7aNY4dk/pVHRlp8pOM/1oT2YJpsG79kaKrR5ladHzRpTKa7gl82JUbrQIAXAf3+evsG0Z1WZYdDtcN7U3eM6vAtzxhiisbU80R6th4WI4eblhAQosbbFaMugKMLLxKa1RFMtZtLLdUcEBQfOWwsJgsExoRrrxr8vRftrV11XCdMb/BiAP5M4/QaBtKBK87cYfsOWcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0toPKtL7Bih9fwtNl21kM/A9t9JiZgDJ9Vu2sMiU75M=;
 b=tOXEWCv3DmYNL6GpaLjb4627FsLcmDH1ptTKtvcxmIeS4vH0Y/6CLzpgAAijzsoFm4lyGmqtT7Thqsd0ddB9GAdQZ7cK840kyOBZVK7KVYiJKWoDSuoYIpDpx7VQqoLqNvqsuDlX+TW6ra7xCzx1YPUjnmmaqRItW5/JMgMZxVddtASe24wsCelEfnv6FOFPj2gs12N/b5Ci/YjJOKWxPFFWpc+OBIx/Zvgh10Y6ytvbURJShb6MBjjZHqocdUHBPr4qPBbPzwtBOUI7nM+uDaahVXIynqfeusdqCEwffP5armxERqKYyiCNGIUb/gyWvjvCKvUK8r9uS8Svf4EPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 22:58:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:58:38 +0000
Date: Wed, 22 Jan 2025 14:58:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <6791781c4f082_20fa29415@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5684971f-5eaa-41db-67da-08dd3b384ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FAB58nt/soeRQY83ZkasXzBK6LokQgSxzX9Z8Wo6HdiRG++KmEhTVp3TBDAl?=
 =?us-ascii?Q?bB1cfHJ7tcpBimNrg9CxSVCc+16eXOgENETs6rpa54XLCFrWJGw0UJ5G5w5x?=
 =?us-ascii?Q?pHZutnl9+0U7lTleJrP2pGe/OR8/i8WytdoynL2r6Zt8EBP848MIqqvA++m+?=
 =?us-ascii?Q?AdgP1D3ysK0e/0LmAhT3HuJA2WM7goPeMUHtpxRlGNlt2i7Zcbwq6Kn8YBvV?=
 =?us-ascii?Q?ZL9gPU0I4LXIv/RKN1ZU77bvThqfLHm2pMR9N3mUI50yZNkt8985oQKia/8i?=
 =?us-ascii?Q?x5NJ3Yyrx1ba5BKFQdsrisfJiCUWVqTXvOf1so8PPL+NQSCDiCKsaRNbsLg7?=
 =?us-ascii?Q?zoqb23YsvFkFA7Yj/dQ8fb2BKbG2qw+qGQbDIB0pkuaDwdd1w9Jj7p8gzHAE?=
 =?us-ascii?Q?MQb/qhxPfF0A6mFGBkir2m1xbN9IUE2Dc6n2/ru/GjMgox/CnQO+PWqThcS4?=
 =?us-ascii?Q?nFtwKBRE4FjBR8J5StA3drSEvLbOzyPbkKiqZurEtjxVGqkkQekd3/B2lcOR?=
 =?us-ascii?Q?CRD1wqRcMtqVFt7UioFErJ0t6nT/7tPirsABKwC0ISmocIGJ0xS+TOlmg17+?=
 =?us-ascii?Q?6fQ3r+SNR5QICS6SDqKYGyoo28t7Rkf5xo+eDYgHsXYKjH4APsGtEYoo7pWA?=
 =?us-ascii?Q?q6v9CVcoWEFZqdwF9ZZPsLZlzzaURk8aJ0rkHO3lxDzCIhPsz+3u0kFmmjzh?=
 =?us-ascii?Q?8I80cIIGPp90CxaMM/vHfoSD5vEfZaqtOO5Utt/wMMJ2gEN7KokQD0jf38H2?=
 =?us-ascii?Q?NCUchysCVHncwdVNEd+j1Qr3fV79zCgx3DKBx27dxGpPOUhey7NNRC0XlBI4?=
 =?us-ascii?Q?nD5NIdiF/3e7qWwFFVoG2e/w5mKcDW2m26GCXRLWgSCW0YdeSjkRyyX3uLNY?=
 =?us-ascii?Q?jX+g5kyGwda3E6xGZArjIbC0j64L8nC3plLgtMd0B4FFQ5+XOpAZqFWx2t6S?=
 =?us-ascii?Q?nYvnD0J9o6rNu1As0bDmLSmw/HF0WAoyFMnyPemZBX0GhdzGYsBaasZt0fUL?=
 =?us-ascii?Q?9/7kDx02kNP8YuUCPqm3iOiGfg0PzE509CbnUYO2gO0idLryRGzIFeFguY1+?=
 =?us-ascii?Q?6gAXpQiit4/FvjyCnDzqwEyM6e3iaDAoRdUjX71Tj6ZOOohccB3wLs/Aek3H?=
 =?us-ascii?Q?A1XSRhbLXXZ/5iukDyFnzQvTvkRema8zXewQic/N2EjVGNZnI8mopik3RLOr?=
 =?us-ascii?Q?Z/Rntpn9aznfawYwn3qUDsRWNEnMLaj5OK/+tzWen6ubEv0i5WR2d89GXQ7f?=
 =?us-ascii?Q?7jTfi/D19XkU0pNLP5VDn/JSZvSMMcOOCkMipiy3xJ/IuXjBYgylE92+77Xk?=
 =?us-ascii?Q?I1Svh2KYQSNhHxfOTvjALZoDTMitsZXG2aUNNUPe2k4O8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4Wkty7Sx38Qe6mJKSyW64Wb9rKqpWfXJc2iKHZu6oekZ+nMl6hu8ueV0LRr?=
 =?us-ascii?Q?eZNssqzskjkx9vw8Pc07yEWq355Ln4kLhouOf4HQjBQpNMKUNqyEinVKFLpt?=
 =?us-ascii?Q?1xCKSWBtg2RalVRp53iPwhVNX83FYxTI2yvTfr7z2QLnjjgNHZx6vpaAj/yU?=
 =?us-ascii?Q?X6zwgF0JiWdTOwyq8Co0x2IQn0zgwQhUKAg+90rO18tmO//sjGM4oWcldhQr?=
 =?us-ascii?Q?Yi93FtFiL/oHVpQ6nmgd1Q+MOxv2acttgrcXFaf0MuSi6qy6ovXhLQcjfNiJ?=
 =?us-ascii?Q?YwwwybO+rk9l8nZZMWMyOTqL0q33XW47/TCO+pi3wbx/rQT04jFo/quLHR2a?=
 =?us-ascii?Q?5t7H+3nXeMPX5BEb6UMAiobyzumI3oWNGM7L5+g7sAQ84nCBqax4IHMJX2QW?=
 =?us-ascii?Q?rs1KLkwtZuOwmU6mh8bWSRCsFUMvSV9UiD1IdCg+eZlH5wUI1Fh2IY3KdJ+M?=
 =?us-ascii?Q?K0OdqLmhwmpn/Rj37PAWLeqyBmoOwuyN2So3gZLBf4iXC/kn+PVTy2zRdoN8?=
 =?us-ascii?Q?XNF/JDmnY6ePmela5ZDcSnYrA8WtEnI3kSE93/irYLQhqgi2Rm8p0Jj8hFgl?=
 =?us-ascii?Q?xaT6g+jh/9vZ99ksxj+M3S+78w8URSAmMjhr1lPbcUYE58ufqcj3BQEcu8cW?=
 =?us-ascii?Q?0HJp8kfWnfr2fJQGohvFBd99xSuk8lWyHRxJ5OSwUScRlqJi0g6XTTU18pXi?=
 =?us-ascii?Q?lqHAEwdSkBb0hL0EFl1FOz1JF0rZlO2uQ/cll6ilgoV6P7acVOBIPfix5rk6?=
 =?us-ascii?Q?QM1+7itzzoiwXn+DFzLD9PqWgF1X8uuDb0D+gGsVkriLslChm3jHjxuxkXRB?=
 =?us-ascii?Q?FOS8PzwnBTPFMOCRpG/aPmwtbJBzVBvnjRprntC13huEqvibiaKh4RuYFJfQ?=
 =?us-ascii?Q?sg9/DYpmQ/GREwqGnidKe84QhjRvABRsehvjQHKx8IWmB5M1XA+eGWq3m5Vq?=
 =?us-ascii?Q?KTiGX0Wypeno/nz2jGalEaCHuEoSPdH46OzFDnNmz1L+5sl+cMyezLfQHvYP?=
 =?us-ascii?Q?0I9v5vgmL3zEmWTMbxRmjnBoQi4lesf9DbsB+AsjqcgtJzlRyltYJw8luuXF?=
 =?us-ascii?Q?hUUDCQkT53i5qp73al4oBp/JOLdXj6UXiEbopeekk5x+cSRRcnAP4MaD/X5I?=
 =?us-ascii?Q?P6zhcM5q3tBN+51mL6HNXRThZPBa+FAAwCbZZAnpTVqPo58bMe6rJxX4hnSu?=
 =?us-ascii?Q?Ol25aoN7LOAuKiav6qtRtx1QsL9pa0GGElkLIeRk4cWOX2vdGeoSK8TIn1Ll?=
 =?us-ascii?Q?PqseZZOTH3+EOE0tdsd/xubd87a+NCI9cxdN9UYLe+cWhC6up2O1THCx9RqE?=
 =?us-ascii?Q?5krdELi7+51GqQmJxnt4MSjsWo9hTiNmsF1euo7CGVXyhjCgkwbXKqv813cj?=
 =?us-ascii?Q?5fngY07O0P38RtWcjKyQJNWVDmEy+ue+VYXrtJrSeG6fOEDNjC3WeNYP+f86?=
 =?us-ascii?Q?fxZ/SkBctognYxQc+E+GF9cJQjt23TELDKbPh/79uXnbb6hy0EUVOVzTNx5O?=
 =?us-ascii?Q?A0bno6yz44sg4nMdTJttC/emmRjYMcgTHR+GWz55sh1ceG0KxIFIoETNrRbe?=
 =?us-ascii?Q?1PmdYUwB4kNzJ4nLMe4imdKxzyJkn5VnuywgoMrQ4+8T59juAKZBmmKhBZ6p?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5684971f-5eaa-41db-67da-08dd3b384ee8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 22:58:38.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO8tqmOA1jIQEr889Coj7gli1wfl7ydrxhHbl0y/r425Rjcna1tvQzunfrr1gtKExnFDr03zN87MZ6n+dH4OtGs51pMvTWL/rGTYY4leEzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> > tracked in the partition, and no code paths have dependencies on the
> > mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> > can be cleaned up, specifically this ambiguity on whether the operation
> > mode implied anything about the partition order.
> > 
> > Endpoint decoders simply reference their assigned partition where the
> > operational mode can be retrieved as partition mode.
> 
> You really seem to be defining a region mode not a partition mode.

To me it comes down to the hierarchy of building up a region.

The DPA is in a fixed operational mode regardless of whether a region is
mapped to it. "pmem is always pmem", "ram is always ram" (modulo online
re-partition which no device has ever built). So calling it a "partition
mode" reflects that the partition comes first, then the endpoint decoder
is mapped to a partition, then the region is mapped to an endpoint
decoder. Region mode is subordinate to partition mode.

> I did a lot of work to resolve this for DCD interleave in the future.
> This included the introduction of the DC region mode.  I __think__ that
> what you have here will work fine.
> 
> However, from a user ABI standpoint I'm going to have to play games with
> having the DCD partitions in a well defined sub-array such that the user
> can specify which DCD partition they want to use.  So the user concept of
> decoder mode does not really go away.

This is the question, do we need to rip that "give userspace explicit
partition control" ABI band-aid?

As I mentioned over here [1], I admit that someone might build a "ram,
dynamic ram, shared ram" device, I remain skeptical that someone will
build a, for example, "ram, dynamic ram, dynamic ram, shared ram"
device. We can always make the ABI more complicated in the future, but
the common case of "userspace need only care about mode and let the
kernel find the partition", probably carries the implementation for the
foreseeable future.

[1]: http://lore.kernel.org/67915ce296030_20fa29457@dwillia2-xfh.jf.intel.com.notmuch

> In the interest of urgency I'm going to give my tag on this.  But I would
> have preferred this called region mode.  But I can see why partition mode
> makes sense too.

It is a fair comment that deserves to be captured in the Glossary of
Terms entry for "partition".
