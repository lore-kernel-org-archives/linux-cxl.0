Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793823741;
	b=THz8uM3af2jpr3R9DcTZayaV/MX1EttB5qaHv5AwetD5Jce/Wlu3kf8b3rxpnPo/4Qrq
	 bRKMzE9qIVYdRkGG6XMHsCsAwWUTXbnDzZ83iHAQiqhMi7DF1K0NCREWZaeD4F6szeCkf
	 jyiKaJz0cpNzRPlSyIMqPu/QolrIWSWTLI7h3Uy5MMLC8ogrFm/leA3yhPFNAIIL61jRI
	 e4yzn9oT6JBbA4piGTlVJRs4B2jGfwpEEY62It+nNECy+ac8RY4qrco24dCCBpG1m6Jpn
	 nbjXAgWB3qmZugXIzodbMVwUaCM+DSuzJswZl+BEJ/w/2ERzrvRGjP7Mc8n7s4OMdig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823741;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=0yS6m3l3Ly+Wo53GD3vhBb70FO86n+8KnEvnz3cEz9E=;
	b=cjHRPSmoq/P4W1mU2S2RcpUevobdujXquJQl3Mj7fK5LvDXsXcm4rzjxEg/XDLT1AA7s
	 ry8oAaqdSQhADSDC2U3rePi1zAALx7bPRLyBsMCVJCGV5LONmMXtBaCIxYTHMOPxILMSN
	 UYU+DfNDcwt9136GFONzK0QFubGb7LB2Flls+39pPXMhN9EK8gElkD4q3YzX9JIR9UMYl
	 EMty86yNWKRQuZzeHcsrIE/xlEabN0l0JCrKQsVpnH0ZgOEnHF/iQjvUhgStk17Fqa0GW
	 plNxJQ2lCe1zdgjheSgwjZnyP39Gr2WEq+hcY6Gi3+nouaTRsFglpxjVtTqcF3R2TzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SA5kM6tf;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4606070330;
	Wed,  4 Nov 2026 20:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB4606070330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SA5kM6tf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823739; x=1825359739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MY/P2pts76uTvUiFiu+4ljVKxE31A/4lNyJWGSVn3gA=;
  b=SA5kM6tfvImoHy8kpS30LSmqb4IHmphkBDmwiOmGPhIB5ApVAdQu1Q3X
   NFiRg0oggpe27yclV9+5uPTHz+C5ZT9JzztEEQYmBrqTLGYLSVL1Qyuq8
   IfCjHxrtlXa7ELStg1XmQva0KPPJc3uJuKyHj6CgjcPKz4NHrK0gfSRzK
   VO4ajtNFRTa3lZdPu/L9b580c9xUAP+OUE+NisFcqAR9C8SKaxnL86kVc
   vNvjFSxFxzXl2Hx5z4NM5ci4nZuQlBzav6e/B7uHqBQdLDrdd7gXxxFzd
   z6OEc4QSGTQe6uiMxx+b/adYSmZP6MtZCv9BaW6udvJK2fPn1XLqIRaG1
   w==;
X-CSE-ConnectionGUID: maynUo/vRsqhmDsI15XSrQ==
X-CSE-MsgGUID: deMtMp9eQ8OD7l6z6QnInQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2628170"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2628170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:22:19 -0800
X-CSE-ConnectionGUID: ZuiO2sYcSNSTGVjTpf/j7g==
X-CSE-MsgGUID: W5Wx83nBRmKgvY8R2f9Xew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7131825"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:22:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 12:22:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 12:22:17 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 12:22:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmx4tyIY/Ky13P7dPCvT33/Z6q5Kht+X4YODAS1iz1yrUvJOhWkun8mBfE5mfLSsKRcFi17kO1MEwbdAnpgM2VYj6CbNbyIReGtH1/mRYFyIuT7lRBNfMff6GGQxSC77c4v+aP37EO5bVPiGtC+z92GhbRqZ5mWBn7pbB7ZQXNe4Rkddg5pX1Zc3K7XE4kbuOdoB5+P8pzYSRYIWU2XAbq4xCmlfrBC29QNgQ3/LLxT4+77PptWmI+tphqdHj71EAU4Mi3EKDzL9KIXSyuLLw/Ff7G4lyM7+6l6nhHRbTeR8QyXKoctBo2g6BEvneYrmySPa4Ppzh6obAIeq7Z59dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yS6m3l3Ly+Wo53GD3vhBb70FO86n+8KnEvnz3cEz9E=;
 b=Zab5qMbBQQdhXHB6fvgU1Wi/0hI4GhNbyOQjK8VXxO36ixQSZjGwBN3IpAGVyWPc4QluER8xaTyW/cu2K6193+GYlY7DKsMZDM51aFTOTfiD9XSj2DQRHzSCb+WS+Zk+M4WUVfqeltZnEB3BzAsO4/uuAONKUdGwawKHzA4lbEe1ChpPiAdc0BBQfm0sIj4JKamNEIYQ4mmyvWXAn7JiqnaFNROqdWf4onHxPmJqsXiUlmDdDqRgmMfr/8A25hYKJMXF7ynkdQRBuHmrM0ow4zpljrupjzGpexHQfw1vjnZYdYVdPmS/Cny4ip31Bu1mIqWJtBWisPaPCBdrxN4tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB8044.namprd11.prod.outlook.com (2603:10b6:806:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:22:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 20:22:15 +0000
Date: Wed, 4 Nov 2026 12:22:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
Message-ID: <auuT9L8UeW_8rjDA@aschofie-mobl2.lan>
References: <20261104175003.297974-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104175003.297974-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4158b5-5f72-4706-c4cd-08df3ab15149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OfHUtvSz1FKQ4xR8WTYFPzzWsi6J/hOEfL1/yEQ4GrEJjUDw96DJDRVMUBYX2fBhDcjLdtxVh9SK2etARl1OQq3oi6sReGKyEG2I6NpNgtZ67jo/jWCjWIlLvIjrQqrCM235TyueNMz1HKPZgdlcH1I++AoIBvkwP2gpSEX5k15EUGR6pxZ31pdIwyfVHGLGdReLszjciaNa2trWV7pa024Q8HGuJFBB5+2kAEbO7vCueAEIu/pK7iPOc34859UkENWJoAhZkyUv/Bl2tap4//naApEAoolsQdkKMxpFgihcxAp8YggAS3Uz/c2AO3o5i383bVFsvXaPD5djBc7SbNgOUhLg5nrNsOe2rbXAPmzgz48vJKebJLBhK0j2XIPCXSLq4QLqe9u/Dfvho4hy2ZpcYA6BxDq/iDWpj7VhZ5exvNKE4vkZioXeo4p5dxPPI6QGWwPCWZv6ppBME9VSHC5IlxGmD5ibc7v/BwuOJ6PlTh4l94pxIslZe1c/9cUDT2OHEtvZCcx+0saluQSqM2CGKmsU+bgYop33tePKAEZs9CZ+WHRLSnbixHLt3BWMK9y1B6Zy/aZXqaO2r8sNQ/5Y4sIW/Qm9RBy5wB7QuKn/qKmCPp/NNskhf8ufeUo4PcvCtvUqJ1w+k+DC38WlSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmJHW5dhTMDlzlt/Q22ylLjQtvG5T1596a6MRQllvlomSTELeZTXLyOIFtgV?=
 =?us-ascii?Q?g0L0oXYCuxza4pK7Pix7Kp0TbbC0x+/xBzSSpF2cOeqALXBK4z2exi5bo3nH?=
 =?us-ascii?Q?/rbktpMmm/3CJVUt9BNh4xeNhR3pLba5+0k77Fcq0wLNlSwhSoshHBfXMb2z?=
 =?us-ascii?Q?PX2ojLW6Sim2+Ey8mgVZ/i+P8USW9OoThiym3FCz81uY8Fp3ArqPPDhbuDdj?=
 =?us-ascii?Q?vrU68RE8MYBNMEDuum9fDX9fWjsgZw64XDzZ1CH606o4nA6tsQIHU5FL9axh?=
 =?us-ascii?Q?9Uak49VJTRbdtP6SdJnzia5BYvD0BiooNubJkPPyVztzsLWNivsW31Nwv0vi?=
 =?us-ascii?Q?zXZ1BKpah+7MDbqgRwGhjf4m9RoaThJApRrh07aX2MBpPco+6RQC8lOZXjmr?=
 =?us-ascii?Q?sRselU4xn3cSuMBRLrq3YVx13/yP250omcZu3IQ4IxLVySxq8iXaIfjVblJj?=
 =?us-ascii?Q?B5f7IblI25weD83tZKJscQgd/wEvsUaBwMCn+O1WXJzqAWdGCTaAs58i+wzV?=
 =?us-ascii?Q?1hgu7gYM7RQmQC/ZCS1xzmpQGziZI/AC6iSTViPBVoMdXiHpZKFFMojYXn1W?=
 =?us-ascii?Q?F3XM10UKwGU3N8dlJRY2FU+bLU8LqXYkj65/eOeRRvRTchxk6/7GaoLFFPhr?=
 =?us-ascii?Q?KVoiPSiWq8qSsfYgl5aXmPiVpqgoEuanfHGw+xH3Fxpnjb+4VJls10Zbv2Ew?=
 =?us-ascii?Q?PdJLV4yRLjv0CpokoFyUJzkggWmhOCHYz2kAzHCdxfZbYnosvjgMCU6MwHTm?=
 =?us-ascii?Q?VK3J5G7tJkn61tvXpw2cm73nb+5QWLaehDgsAma/72JFcKbmJHvjlTyx25Fx?=
 =?us-ascii?Q?Ir2nN+5pKVNX8+LH1PrEkCx76EaKP6nmKTBpiUpM2vnRm4aDmnoxIkOFaRRP?=
 =?us-ascii?Q?TPdZRkyC/NesUUgNPNJS44wEjR0vtzyd0qYOpZEwtDqg3kgYayXOjviO5xMl?=
 =?us-ascii?Q?+B2/As/BHotRIukL2rISLi8bXlRTIAreTcr49EM+m3FQAcu/qCK/xo7dJKzp?=
 =?us-ascii?Q?Sb5XzrnAfRmxoaTIMwCi0kx0W0b1he4rKPZVmRdrsv/ss0biBSSCXSvUd0hG?=
 =?us-ascii?Q?LdkWtRZ0ZgSDENwPMesASyC/fKGD8E/416rRsqC5TNK21yP5nbIinbWvI5ww?=
 =?us-ascii?Q?alAZqhhiDteofMJhoiz3eozGxyiq+PZp4etsB8xqtoHbTal/6czMqCwK1G6w?=
 =?us-ascii?Q?Djs/6DN4L/8PKAmlxqqpahufNF+yXJsATTDfl7Aapd6lHSw1I3R/INyXdhA7?=
 =?us-ascii?Q?+V5Z/PxVpV06bSp0PSwaOyaGWuo627tEq3uhomYuJaYXRUGkfWO39ZuvFSMG?=
 =?us-ascii?Q?izVhT8e/RqcdKoDb5v168Hd9bxA5IO1wz037yOLDMU005+MY1eXvmGIUPvt8?=
 =?us-ascii?Q?mgvmgkbMs0F+Zum5MWh/zYqghwUm5HBHhHxL9dSyHahH8bgybSW6qXjGKIXP?=
 =?us-ascii?Q?iyOgUZOnR0uOTnuOdLgW98RYqYvMkyhZNHt7g2iumuF6lKVF19hN4RqOKCXG?=
 =?us-ascii?Q?4ZONJUYaQp1uYTFjdmGx5pLeJp+Z3DfBYz17X3RUMSSzL1tXp0P7EuctPzaE?=
 =?us-ascii?Q?1jWoBVud8jOwVCzDq/LWuFNE7W/TbvgMvbQIQygJ51hjRNuRs3xhjwV2ixns?=
 =?us-ascii?Q?PZdipbS129ef8XV9QCcq2PU3ev4HW0nBNJ7o7fc0h74VySXHEaJHMiwsplX6?=
 =?us-ascii?Q?E+u6LdSV3OkT8kiipP/udlNd0ibE9yTzleNE8/rh1zORsZ9M8x2wEqv5vZcD?=
 =?us-ascii?Q?syjnLDa8hcW/GaSm8uWBe+Ahv34yQOA=3D?=
X-Exchange-RoutingPolicyChecked: ViFOLIj4Vz0B/S5V94JDWOscqiMpQBpbI0PgnwL9a8wLAQaI0WeGjamPP9yDItLXWaBKuww9uYhmBLujw3XBjzIAxuDe5TzHlFc90THgk5MUhWSPCLOuzgeG/NCf+5d3GavazpAV3kLQa0a7LcSUNNCiLI17bTTPLEI8DGdtEP+IiOXaGEcaMmC1ZofUnh8+zKL7DQm6tBe/kn0inrbRfP8/G4q8BcuM5IiKjkpnCG03PH3vqNkbuJCYcgiU22Ix51dx4liJ1k3NCX5GVMcTysIcw8pgmoRmvO4vNDdsFfMTr71Hj2fRgdLYtX+RRx9hlrUmrSR3Q+eUs/69kYvIFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4158b5-5f72-4706-c4cd-08df3ab15149
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:22:15.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEeeQ8zsLI5ImF3+mGbyl7QikqtoAW3LiJeXkUaSSijzsj67gVAbmZ7YlBMxohv5hhFtAdCrmzati9W81IiAydetzHdI5dat8U/Dv+VZ3BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8044
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 10:50:03AM -0700, Dave Jiang wrote:
> Adding Ben as a reviewer for the CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Alison Schofield <alison.schofield@intel.com>

