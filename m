Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5F2F32
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054846; cv=fail; b=ZRSfurefC1Rq1p9tEhR0ynEPh4Rmp4QenMPcX5rqKN33y54rZdMhWMxV+nPQxDsPKq8TytHkDTx3gLSV4FSE5vql6b/WLmG4ZHGnnV7L1SYLDNQ1qPblJG7CUHg8mSvZCT4r+GH/plbdgLsrpTKyb+dfkV5nsdf/ZqVYYxdeJI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054846; c=relaxed/simple;
	bh=y+MTFzftvdkA3t/vxZXXHVhOAuSVhDR5tyya/CS7vxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUgksL4yweZ42HU4jNmYKdjf11f8ExYKPEac/X6zGxdSNGPbyOJ4oYZkTsJVUaHkLI1bqb0KcElAoN3Xt2N58i6cJnj4Wr8RqTuTijq6eOPLMWSr8AI0InFkM60e7ITajoPoqHc1TdsPiBkZRFXJUllYO8AwFZnk1oY2c2hPZuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDv8I+gK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDv8I+gK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720054845; x=1751590845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y+MTFzftvdkA3t/vxZXXHVhOAuSVhDR5tyya/CS7vxo=;
  b=GDv8I+gK4O6e+NTJwTWRmATAJPjVAcl0Nx3SBuZLMzxoq93x1jeKV2uk
   F0kXzSI/BmUQUf1jhUUz8p28cq/p5SR/mNLC1kBfP7GgtSBjHuot1qu99
   0o+Ij6UoFv9bdLdCCPtzsORA4Cyt4PSFNrGlrYEwiOKYlouUGhYYVewh6
   T6eSAw9Zww+KnmMC20veceWfdB9Kv+Gs9LEnkPII9Qj5+e0w1qW7ziv2r
   4rIRXblg0YocA1hWN49TJRZ+v3P4CUxaOg7RO+Oyhde29KkCy7qXWJS3i
   hNhKCi5HoyA4YuJ28bIuDebuWmVlQyaL3SX2aBpU0wm8Awm8dcwps+oBy
   Q==;
X-CSE-ConnectionGUID: 05mG/vUMTDqpOznseh+pBw==
X-CSE-MsgGUID: MXR4F+RLRY+1/CW9BvkT7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27915255"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27915255"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:00:45 -0700
X-CSE-ConnectionGUID: L65TWUfYTumnlhhO/w6ibg==
X-CSE-MsgGUID: SjYgElnVRAm0/RM2X+uBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51296140"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 18:00:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 18:00:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 18:00:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 18:00:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 18:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mifQGn2HWzX5HGbXTWvU30DOQQoMokTd37nMq1fh/WtqOcFiLw5X5RuARRyIEqWiU5bnwRgBr7NR3nyze8tQ4t4cQxIdJ9jI45HiOe7xQhEaqO62Uas9S5uqIYqtJ51Vk4jumt8FNh0UpkC8Bp5CH0MOQXcna5HU2TaBPKSetfx1n0+9XOku7XVhBiaxu8y7HmQI/+NXMdNH7Re6zUVJhLROtvsRCfJqGba3SFdXuloBAN6XsqeFQ415/50W2uCDx8+s/FIEBRngcF4nzbDpvvBJpISIVb0tuqkACc2Z05j9sUtCAykirxtAFr8IwBxfTxGCiC2Eup9c/2ykYGnDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlwAVOqQafTBTnUXLT+XI7g1cMXNVg42vT534zFkKIs=;
 b=EgcrvLGJ3C7QKgPMoB4ZKnmDbS6yri1OhYo/EMgaIvVwYIppa9gEwCD1P2sLPE/QU0dTRaBtXaVmcz6rbbfuuz8NIBYO+z862YbbXPHGT9tOXkruOhLB4KPDBrHP2w/LLBpwgguDv+G7ruUHpLOQQ4YEh3SRubvkF1zdkunOjowH3qqGd5tAd/yzr8AM20JdZNoBGqviHhOfVQx0HXo7NdEXRZ00YdvIenu2CsH2A6dRbklZY9Cx4pKKwUEtKzR9XeUFxQSPso2hTJ7SMJdUGGRUdGQimjD4VhBZLMsxAdWg7Kg0XY4ZSwvWOEgppg9fUwjwKSM5jm9HBZ5NJLVsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 01:00:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Thu, 4 Jul 2024
 01:00:41 +0000
Date: Wed, 3 Jul 2024 18:00:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/2] Return EBUSY on inject poison limit reached
Message-ID: <6685f4371c47c_4fe7f294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1720052137.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1720052137.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 061ef65f-f755-4cc1-ca03-08dc9bc4b9c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cLwC6XWtS5FyFQH2g6u0HlnqCavd3H0ynihs+GR2BWQXnvf76sk7c67Ew0Er?=
 =?us-ascii?Q?yf+M3CkQEz1cEXEfMvRGg+KYOko7fB+shIa3/9q5V8wIZExXHkebvFqEi5rj?=
 =?us-ascii?Q?3LbTX8xKxq+lEV0547t++Fo8K2UI4qweS1/FhpcVYeJzSvbd5D8mGNnIllbF?=
 =?us-ascii?Q?BDo+ZW90Sp1eEiVCJPDfh1fQ2f9Lo11Nm0tjx8rEZtx2swIlcRhGaMtBOs6J?=
 =?us-ascii?Q?rB0wow+mADge69hCTbXA41gUAjOQW6TD83RhSMSzOUufxSXlrBPxGC8KROeU?=
 =?us-ascii?Q?n0l5n3+ZhohlUabZVs0FJypa+OviyUMz4AIdfSa3lhz02uMspoNBzzBlESEE?=
 =?us-ascii?Q?k+XY4E8QH7N6cCsuskh6kVxTRMggZS1niDfyco9f0W5epI7vyMH2Agm5p90a?=
 =?us-ascii?Q?4Zc7p+FQ4g3mXdd2Xt5PJ4C+Ija6QQnAA4+xTtEZs4R1VQZthwKhZH8ls4Hi?=
 =?us-ascii?Q?ob0Hnm/kl+fhP09Ky0TeikiFZtnJswerz9hF43Rv6JphNy02WSXcInwxYXlY?=
 =?us-ascii?Q?LmksirVGChRu8p252PmhzebJq2C9BZKpzKR3QEFSfX/Z9I9DyWsXX36PfFSf?=
 =?us-ascii?Q?xtKSBRxfT4A2EpHayN9hTFklHddUZCMjSgIModpI+2k/wPDqBUoe3Bn8Btnz?=
 =?us-ascii?Q?X+Bxgw6E35BTvB/1SE1LW9GkrQNcezMzm/I/KmL/IlGz0KxAWFsHRkWK5W00?=
 =?us-ascii?Q?T8dEpkqd4+Rg6LmUWw8aFn4h8TqS5MxXlSUVlNkRyGxGJjbIGSPMnKuz8XxB?=
 =?us-ascii?Q?346GS8ylz/T2rZITUjuSIrE24J+2dbx860jMmQkgBHib7H3ovHXUPfTzaRVN?=
 =?us-ascii?Q?SLdbgAZ+Jp5TyqI8LJznW7G80hanUPjZzRgDod4Qf/NQHHDSoEgS4+nX+twQ?=
 =?us-ascii?Q?xzgNSR8Gg2EfM1iMkjwyKlTtLeX0FSeyRPjRflJ1FGL/MM6l373HF1WYLNHf?=
 =?us-ascii?Q?Ffz51+UU1XYTAg8Oxy61IUrtjWosg9h8IsMuhtMGXyFXRTfSDwFPc/uxHq7U?=
 =?us-ascii?Q?f4TPPf7C4vK8u+szV2OSGCAH4JRaXtHFFZ/yLivQ9A39LOvxK1KCDrFSc0wL?=
 =?us-ascii?Q?wpwXabaSKYGV3JsMPab6FmyibeipU2Kv1BV2c5rHJdC7OqjqMpTEc0nm8ku3?=
 =?us-ascii?Q?4G1JE0N3zde+f3W+nb2KB7dBoeIg9NjAVynyO46ysIFtxAdUGvIRX9zb/6o1?=
 =?us-ascii?Q?vP3WSllwVsHr1UGMjvg65MPw9cBGytgfOM5IjY4ok4QnZTyr9mDnCirsuZ1M?=
 =?us-ascii?Q?LR7GgQ9MvvpkEmX6yLGxyllL5F4DJOQZLfx03ZG2WJ6R35AlW001cTTDupcc?=
 =?us-ascii?Q?a/iHn4AsAcsWPeY/SPrIEKDcbxFOoTZiVWPLFcddh/QEpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sA4CEmvAJ2+k2D8oeKS6/+f4oRXNPAtmlI8cGjuFHXW96/Rf0nS5RIU8mS76?=
 =?us-ascii?Q?gRZnOMUdtb6f/trh9Ycm2mLaGEYeVdTy1tflWaQnvAShWbgrgW/q1mhBZJJj?=
 =?us-ascii?Q?zsEfPxy5Pj3nSwD+ApWdBHzn7V7OPuOBD3+ojfSQOdzkEkGgoWCD2ykZp/df?=
 =?us-ascii?Q?vNAotWaYdcNqqFPqkFGAUNPJcAjzYNmU/h4gP22sVVE2YeH+N20X6AQzlQbs?=
 =?us-ascii?Q?X3ZG/LX3oftTgUXDOv2a9oMWHViwA3G/rbHeqDBSLURlfgoToq9Che0PY29R?=
 =?us-ascii?Q?poPvuMTwnKrwL1oHnXRLi49FaJTYYXZIM+2upNZlO9KRlJl4JgWoAPb+tTzR?=
 =?us-ascii?Q?HLl0HjwhgRWsfx5e0ewxYwSK7hy4DqUYykUgOg26zaJpfSg1lJRjqawna/Ry?=
 =?us-ascii?Q?cJhesI0C6exdB7PjK8LVlaur3JrRxEi1wZh8rqaB2sOy/RHEODRlC2TX8ssA?=
 =?us-ascii?Q?SaNbfV3RtqOTngDrZYKDaYWTYCOM/Qu0X5jqHiVSzGwOPThBqWODgQbJOdRl?=
 =?us-ascii?Q?fG7tn1dqxxoeJXlcPLMIkQnv26Cmf9cU9ObqMcy5PoLgng07KxqilPhGjiey?=
 =?us-ascii?Q?3ZOJNJ1SIyBVrv+YMJtZdYi5dP57B0lZIDR2WjZwLRG6FVo1n51EOpvyR6Wf?=
 =?us-ascii?Q?wmdKKSJhblT3Zd6PBYsaRI8jIpf0DyaxGPmU+4mBOFTlooo4hgFN6PPo+Ql7?=
 =?us-ascii?Q?6d3FOReMmBC2ovy0Ue3oM7XdhB49UNCw6iNptqD0D6J+a1xS2v2wKthCxlFA?=
 =?us-ascii?Q?Adr4xv9/3J//Rcj8iyQR2IN2+XFOQamgp44/BtA7A+Lm5H9jtY5Q2BKPW1o1?=
 =?us-ascii?Q?eEYzglPvOF68jrO0mxzDHk15Yog2gJB5wpoAEuRFdLmUHBKINw48xHJlbrza?=
 =?us-ascii?Q?EPAYmzU55CQGnp0mZd1TUid++xistqUbjWoZ8kXG9KcqN+XPf77fzmdO5pUX?=
 =?us-ascii?Q?u8dh2f3KA3oFoZQGmeXnHWwgej09cR8EjrEpR1qWEMwphidA+tNDrutEAHsD?=
 =?us-ascii?Q?EHntaLkkhpxyvrvDmL4NiXZeBF4bW5s/9A8HBxFjD8CapsYKHKPNsfok+lMW?=
 =?us-ascii?Q?lDEs+jNjqyAKiYaKevoTHT69DTPP+YLj0TGpBX6WAxVXe1dq1MT/SPuzHQfh?=
 =?us-ascii?Q?BujTop4YOHSk/DdBliHp7uMJDdtZH8jyp42nU4CoolNb9XdyptvHRkCIPJS4?=
 =?us-ascii?Q?DOFPw7paKctVBapxfCDsFM7IhUX9CkfcEM8UV/PWyXhlAN+anPRCsiJcA6An?=
 =?us-ascii?Q?Knnv3vm4ykzzJVoa8Y2YWLRRb03HTVayOAnO8uwlxAcc60f1cvL5211Gh/fQ?=
 =?us-ascii?Q?SvTSWCHmFXPEu34AEtNg2YivOs3KPw3NUBxBW2AvJg458/9E0BffmPZPt92V?=
 =?us-ascii?Q?xURXp2mwn37GWe4uGsZyhiF0y8tzN3vSh2AcZ3mSDecyZkiCx+B2A7GtBzSe?=
 =?us-ascii?Q?OV2gJasbC/Pb1jAjcOuxeXWJJDBh1VUz0My0MyW4mQ4hpVwPZgB2xnlqw/uB?=
 =?us-ascii?Q?aNpOsf4cTR/Z+RtM562UwgUiRwElYVk7D8Rhz206+qKa80i04WdCHGUArcNH?=
 =?us-ascii?Q?lxY9h8HpKRY5cDqsM92z4iwPwGTU6eWR0V8y3uJtXMwv3Ki/cY3uc9SnH0NC?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 061ef65f-f755-4cc1-ca03-08dc9bc4b9c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 01:00:41.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYlQdzK7l8dxwFdOnQ12mxCdMQ46W2ZEjOk48ceG/Eo5QeUyTvqoxA2D+TlbmAfAabcF6FbYe5SOJRNEMQ3UDJJ5P5v1CB1MNI8F6CyfN6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Validation users are asking for the ability to recognize when
> their injection testing has hit the limit of the device.
> 
> Change the drivers error code for this failure to EBUSY and do
> the same in the cxl-test mock of inject poison.
> 
> 
> Alison Schofield (2):
>   cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
>   cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
> 
>  Documentation/ABI/testing/debugfs-cxl |  7 ++++---
>  drivers/cxl/cxlmem.h                  |  2 +-
>  tools/testing/cxl/test/mem.c          | 13 ++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
