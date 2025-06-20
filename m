Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B893218596;
	Fri, 20 Jun 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453213; cv=fail; b=OcnyUZznoxpV7PzGbqNjW6WQHOd4Xr3nLJWPmy8/G3PxnZXR0elUrrQd/5ldWt4xP70WS9WMguaZX8djTUyipSExx3X0KZk+i6gCaIzK5Axw61gjdy8DpeerPf70PsMPkhLbAz+PpWtvhNSaaDQg2nH+FRM9HupV068sUlYmdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453213; c=relaxed/simple;
	bh=RxtMyZr8okO6TlMJyVBY8adRVmPCb2XuqsDdJv4Fng8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NAHFYFggc0xw/VNw6xrOilpjbzoN/HHmpXccHVzO3cvGIh/E0u7ZIOb41VWTxcdGcKzbEzFjN2z37+5673gjImmjQXRlN56UdWTFQ1jIS5qQyO6mmlCZ2JkTOx4y0pApDqZH2EvenonGovQCtkNDDNO6Bxz0u24VZ1mm/EtNyns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDcU4TPs; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDcU4TPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750453211; x=1781989211;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RxtMyZr8okO6TlMJyVBY8adRVmPCb2XuqsDdJv4Fng8=;
  b=dDcU4TPs4LwtGXTV4GA/nh09o+9eZmPJvIDg5a+7pw4n2qKw1yqaVemZ
   wWdwjWzN1N++mXv9LPDp9IjmYrdOieZM6yWzWTNi6dTQYh+3zdn9gEDq3
   SdbrhFVrcyOPxv1zurtiMz//WAmM3QUsxR9RRcAbyZc49jqjpi9ep8UZU
   sOz5Ca/k6tVvLQBrEaZxQ5ENwZUzM6baaCV5dkcoso9ApynHxmBeg4/kI
   PkWVt+bzigs0tO1VOJc01hARdj5q6KyGZZRLXQSsw47Y9J7c9hNqlutkc
   s5BcX5oUvt+fOMJnPasXPXDuEb9h6B4U6rZbOrNohTbq0NRT5MJ3vrzYF
   Q==;
X-CSE-ConnectionGUID: wIq1mEnsSrynbFUE+nvuAg==
X-CSE-MsgGUID: cIrZo5BGRgeIVJUmRJQddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51954727"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="51954727"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:00:10 -0700
X-CSE-ConnectionGUID: CPaPLYfBQu6t6EoDEO+vqQ==
X-CSE-MsgGUID: wgdCN7E9Qxe8KGvTRB5awg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="156819508"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:00:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:00:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 14:00:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.47)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyno2j8rmZ/T28vHyBjgNhnlNJLo66lZzTlxePYT9i+UTuZXLMHC4iX0XDHYAGuE3nktKqLfvpBpSb458KKhYzXiKMPNdkrAgSfjzyMnaXB3q/93O58uPQrj0hFg5p/E8PmE9q2q3iREmyMkStxxf4dPCFRSPOnhmSEd/onCvKWgQZDXE3pKJlUsZIBilKsII+xQKwMHfudX5jT2T2++Ddw15nDtJyKU1RfzV5Ve967g860Os/eAYGR9aUC9KgSxwgj3PlgrVMQKzvjvYljKQRq7nZ3PUFKVt0AIOLAiTeb+Qzz0enRv0gtupNspV1k5xN8nEcN7dBJiYQDfk+4PCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNACGJqytPe8jv8Bcauc1XHKNIrBPMfZTVhcS/Q9u3k=;
 b=Orm1zpQMbAtqSZqmjvtdR36atIFQmjGyU1nqdq9OzVPRVpip7HfdAmOKCN7xK2Cnh+gpaPLfI3erFz39C53DNzZwOGrpz5XHFpc1hpHb/BIi4tXSUjdUGll1HLt11EHW3iJEiSDq4iYrWFF+XPL7iPv/g5RSXbamEsNMVpb0+SIaFlnOWSMT0c6n8y1e0tigN1NoMDCsxVPJsl/+dPomHd0fmF1fJINKv/1goL3bPnFzhP4l6TIMMnWXrGOrS8FlMSpP4QvCBIb/XQEs1WBbE6A9lNZhEIJjXvXXlPQsV7BLHH3jo/8ijSJb5ZyiDTSs1EckYLW0jOR68j6qSJbF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM3PPF4C5964328.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 20 Jun
 2025 21:00:07 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 21:00:06 +0000
Date: Fri, 20 Jun 2025 14:00:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/8] cxl/decoder: Move decoder register programming to
 a helper
Message-ID: <aFXL0oip7TjyTIrq@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-4-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM3PPF4C5964328:EE_
X-MS-Office365-Filtering-Correlation-Id: 95485a69-47ef-49c1-4ff3-08ddb03d6f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WyE8BMXTuFoLmaR5ij3CQ1wuw70qz+faghdGxq/H2ZxOD7QZXCYdN4k9+kNX?=
 =?us-ascii?Q?p1hD2d63wKT8BsJXiG9+zWdW1iRz/C6CajNP4YAi6DLnygwzHJjT5ShJ3XB2?=
 =?us-ascii?Q?/Cv9BADLkUDmf6Jcfd4z5Z++IH8e+N5BE2BmPQ0YnC8LjXz4kV0gCLXY/m6g?=
 =?us-ascii?Q?UziMAoxar8NayY5jVpOX6IMt95t8VykbJUkznbnNqwpDd5oXsVu9h04GY4tD?=
 =?us-ascii?Q?1jwt/qGqiF1FTGwl7tqU3SNHRbriTWV1YsJUkskp4oAS9GvD2OMqAAxTqFxF?=
 =?us-ascii?Q?zqLD7uFmO0cnKOKGPH8vYqL5P6epzZkYHnvgwggr/5UYSoDwoIduA23c2mSA?=
 =?us-ascii?Q?6vMN4PRjdbJbso21HaFuuS5XSdQXPnvzDej9zVftt8NZUISo9h6PMHbJezX0?=
 =?us-ascii?Q?PwTI7NcjuwsUsmobHEWk4KXXVSR8kp1Bd+FBgqGCMIrG36ZuufO8Q1pmgPJj?=
 =?us-ascii?Q?gO2xWW/gVyNfo5BUDUoYhZxJiUfND2cVs+7rO4xx9Kpg9eToCpqmTkTQ6EnB?=
 =?us-ascii?Q?ZRV0j1UzoVaFNRkDB8pTIpp1HzYJo0QKmX7WdRPYickN01WJcj4kCgjO5O/r?=
 =?us-ascii?Q?Dyhp6dP9xabfeltFvqiVg4/dsDx5epewTjAoBB8oRt5ZJ5G0KyJYCR+g/A5a?=
 =?us-ascii?Q?n2a2/TbneY0k+W5L3KEyKkO+/rke5DvJhH9eMwwn0HnbNvLF3BSNca00iOYs?=
 =?us-ascii?Q?rv22ju3QvGNZ7rjnnPCByCP4sh629LBDjr0SNpad3qYtfu8a7nPDeapLL5hC?=
 =?us-ascii?Q?nnhPfqWQ8g3jMG6K4qgRiN7g9NPDMb9qQ14OOvrxPPUD6dlGQ2mn3LNlFnub?=
 =?us-ascii?Q?naHbc3wBSqOFsaN8ouOT99q9sEUSUPzv+1J+x/3DqWNEd7awXD5bpF5l4h1B?=
 =?us-ascii?Q?PAaLu+g55uBxIx6i5TJqY5OunPRb2zoPJYMV37IT1z/TB4LCI90y+a14z8s4?=
 =?us-ascii?Q?P+X241EQCJSmDfKu7TouE4tWBFVcRjwz1YtUWkUQzh1fkWGkoqUy4NRSzYp2?=
 =?us-ascii?Q?dzUY7JqlIUS7ur9ZdOnH5FivuqM4B0+lB135O+ORBjo+tYeqtIE2cRiI7hB+?=
 =?us-ascii?Q?pk5HPGVxBs7Tu34B5rebLfxOYQy1ZhIaDHZklr383hJVIddtVd5rb0fPW9B+?=
 =?us-ascii?Q?46PqjUVCvJ8QTAYZBMyrbHbkXLxaQhOE+NeM5069m16fmxpPWHAmvwbpNrDV?=
 =?us-ascii?Q?QYv+f8PeVcwOSMxrDV1GNwqEOpmoiGpLf9RT4Gfn2soeTdvPP3ZPX1B69X8a?=
 =?us-ascii?Q?K39QPFz5XRJdMl4NcsuQ6kYh4qiKXxWoBCsAUXlCWUCT7zMYwIqhIvLOI1SA?=
 =?us-ascii?Q?pVbvo1a1+GqdA92BOHjvEcUgZY4NUOCXpWd2cG8ybx4lggp/TMa80KXyGveM?=
 =?us-ascii?Q?nYPh2x+xdww7aKQ/YQ/fwkpqMivO2Qv/2nXMjabSU1MR1pcplfeKI1vZ3FYm?=
 =?us-ascii?Q?xb+wys8sWCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEVBPTo+baO71/JPj+fa1pJqK/zym+US4/Gdw/mns1bAbE5j3CfoNY3EDbrr?=
 =?us-ascii?Q?pgoXWlfOYiKkgp68fxPXjkeDgwsjSm8ulszLbsRcCbCY5opx5f5nRH7lsFoo?=
 =?us-ascii?Q?Jgup3y9q9PTl7rmWkqgHN71CLZAAWedPCaL9tR1ZLpylb0vyS/jfp2/Ig+gF?=
 =?us-ascii?Q?/WN7ZvBTZUFMipv3mp3b9kPQ4Vi6/tOO8x3RAc6OTcvrRSS89kiffYzTJwLg?=
 =?us-ascii?Q?fj2q6Jvd9ZQj8REqpX2LOD1MLZjCe0xxYYo1Ges0Joaej09heVMYF3qix1GB?=
 =?us-ascii?Q?G/nCwe+le7yJKR3x/5ulM6NSCbJCEWHmaRS5I+EuRIgnoXTIOV5NjN45vex8?=
 =?us-ascii?Q?XQltYacneKs3LViScOzUsIQExYjAyJhwqvKm5jVVnZ+43FoePqohhWVOwEoR?=
 =?us-ascii?Q?K43cBJoN2rpdP2yW3nAHTutEonBBMSqGR/5emmqEknHDuzh3fDmLrqJs3XTY?=
 =?us-ascii?Q?9lCDh0ewK68BXMyaJ3UaKLIqzm5AXM+5WBPIKz81s9QManGTZ165/fcdUuNr?=
 =?us-ascii?Q?I14JdrxWvv2x0ht8PGF25na7JvNfZQsR62cA/h59LrzljlBJG4c/S6DqygMC?=
 =?us-ascii?Q?4M00FMke8/IuS3Xh2pwjGCCkedfhHWGLcXIHI9c4op/R/JtYe53R4GZ2reP0?=
 =?us-ascii?Q?1amvMrzeW5/2Ze+ZZeCAs7495sdN3Dy6uwLhdsBHLGR1gsqgVbwxHn7elbX2?=
 =?us-ascii?Q?au5fZ4ZgeXs9d3ZB/yacNPRwJUe1EfW8SQ7207Sz/2QdyBb0YnMqVYQc/jNJ?=
 =?us-ascii?Q?7B/f9/cGyvo05KYyihQSNn2SMTj6FjJX8Lqwl9qcHn3FFfh5DmEPXCwN8XLy?=
 =?us-ascii?Q?TsKSTydal6rIIky5e0gaOobvdWdTlGhZ5o2U5ZpUxyXqcCYyfhxYKxiomHdo?=
 =?us-ascii?Q?wOulrT3Z1t+IrDwiTpVbtkt1Qfa3P6bM7pOGHzxDPDvwYhvk4MKut/rdASHh?=
 =?us-ascii?Q?cxhPlEYuOk/9gxlDO22dyZB9loB+w0E/N2PzqQ4EmpPKNsYvD1y2J2o0yfxW?=
 =?us-ascii?Q?Iss9zTP7mytqZqtCnXyrJaa3U46c1NV7BMBCDLAWvj7S+TTTBXHrAvQDIS+w?=
 =?us-ascii?Q?xWh4LFP3fEAkr/bVQqUcnjo9VgshmuOJ+irAAf7qQeLU38Uqf5OpPSn7vIcx?=
 =?us-ascii?Q?3nE2r1+8ZCxgOuid4wCMVp0u5KhVe09GntNiYjk4p/LNT4Ab9k7169F/muYl?=
 =?us-ascii?Q?mDBRpGI3jklrCfD9o/kObNrdp6anqRGy9/jwAkt+LUpIXEgXHJ5b3aYc+6K5?=
 =?us-ascii?Q?RxxsW0W3lFhO/uSnlEcGGBV11wuKvFJy1QxCDyopbeSIuUhvUwuVg7sqZyff?=
 =?us-ascii?Q?NYVu1ofAD69TC4N/liqZtfZXyJ8Hilbv7RlH5D7zd6t+Xsb0SWXo3BP8Q56z?=
 =?us-ascii?Q?0G34w8LP57ek1YGk+jF5bGa2pLr+iP7Zck7C2kThUkz4NIZuLpqXq2PywLea?=
 =?us-ascii?Q?1AQ/m1/LDf2SvtG04ARrHWDJboWGLglvsv2b3Vk/RZwMhNLlNm8VRmbgB3kV?=
 =?us-ascii?Q?9upIK0+9EvOwsWWYKgXdlvJLWZRblop412OqlrK5492QYqkVAJtMRYC27b8p?=
 =?us-ascii?Q?FM0hFjgMym8gDu9+UKyj9FzqwOt8Ao4c90TT2dTso6auqxkgEPPf7Qjam3Cd?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95485a69-47ef-49c1-4ff3-08ddb03d6f49
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 21:00:06.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubtzb8oOzlv6eFHg98CwsVqhZD2eQuuUVztez2p0Ylx+oAN+UJRitoiq1CXpTzIEKyFpb1UPjgtprWXL1KaD6LHnMwzRk4lIOLUkQuUeQc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C5964328
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 10:04:11PM -0700, Dan Williams wrote:
> In preparation for converting to rw_semaphore_acquire semantics move the
> contents of an open-coded {down,up}_read(&cxl_dpa_rwsem) section to a
> helper function.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

