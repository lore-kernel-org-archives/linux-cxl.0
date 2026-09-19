Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF237D101
	for <linux-cxl@vger.kernel.org>; Sat, 19 Sep 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779542; cv=fail; b=DsyZbKMMceEF0BVRTIi0XuLrXLjfCkQlQK106fZt27f2v1qMy2s4aw9cVKv+oPV0zXRMT7PIFO8LskH/mj7tkxGUfPhzvpaYpTAKiK6E3TNMWCiOjgpOUVkBavqfGaEU9KHHIffC0st62kXgxArrnn7angLyguPRL8ze7dIupwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779542; c=relaxed/simple;
	bh=xUtPE8ReFGlrBaqSUjqkRNEq7O3Li5dBkX5Tz4zLPkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOrmf2RXQFokQDZKKdOASrqGT4g0EJ1G1xHiQincnE7bdD7vi3hSiLZecOz1aP2fZgBPqgGE5q+BSKP0RTLc4RADll95hoQk6ielitSR5zCF7bQlwGJkfCss1hrjjEKU7kt71RAqMKl9H9Lfp2gFgWsu0KbkXW/KTKpT0VH8T30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjazUX/g; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjazUX/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789779524; x=1821315524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUtPE8ReFGlrBaqSUjqkRNEq7O3Li5dBkX5Tz4zLPkc=;
  b=NjazUX/gu2BsUgorIQf67dQ8Os9XqpJ6tD3u8KZYs59vV5jqB/MCdeMR
   cTiryZVLuQQHmODkzONefGtuBJSfp8/CxnIpzk2FC9iCpDfIhfucB9bOp
   d/yL8ln+AFJXEF05DnNAI20XfhvH8zgW8o6ZT/OsqwVm9jp/owby+6CnE
   PEZGGtEyiqeTZ4EoZ45y88JrgCxoJIrtbFcDA1mY0A4Oq782CKAbXEmt+
   N/RkC/3434QELNhFaoDDRIivkyw2bFh7DMVXwpjBUBbikVKGE7kIwoV2x
   HkzHVt6yLdUPkFLQAJAVyr+SH71fS+J51zjxAVY7Cdd7NNyG6CrsDaDP7
   Q==;
X-CSE-ConnectionGUID: My4lnacyTaeJ/iwrZvdABA==
X-CSE-MsgGUID: cnvHuHT1Tu6hIc4kX6cyfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="107821728"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107821728"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:58:41 -0700
X-CSE-ConnectionGUID: BHqsqdtfRYuRbby78TC7Xg==
X-CSE-MsgGUID: hslbVLgsQxehr09cHnMWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="298095158"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:58:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:58:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 17:58:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEBeLMPIFaM93FuM4SEB3myHi1cp1KBHBkckCEYT97xZzVuDFXTSpYYXuM+ys2VRENvzoVR8Zh0kgo0nVgNuaoGiNwVQP88uh+7bKkjZn0bgKaWjzJFgkyhWo5ssbczFHUDXjvBQKoDubaPXPutpNJ3fc71mY9TPDlyeP4uVGm09x4mlSPqcQoE6slICuU9LKpOJWknQkEEjvDVDozZHsuX8Gb/gYnsylt/YkDXHet2MOi5iVAE73gD/dz9yUq+E1i7ZWb0+zQIMgg0S9DCfvrT2TuH3kdIHSxWlxWHrMHI2RW8KxjQvRbiINMImRnx8y8DKRioWpMjrpzt1u981YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvb3BNHCUiBdB/JcuIkVNquj3dQSI7EPrXM24x44C8w=;
 b=Pkf5GUKFPH67oFdORF64p6wlrNTS9nWqaU41HSnlSbRKqCfbujvpCb+lSS2092DjDe7XF31NmyGFDkn1T0NqvoSffd1joW7ETZtGWXfz9dv2w8JofHckiwjou4iS0lQUQ0D+VUbrKyI2z6DuDFsWD2E4ak95Oa1TKr185VaDhPji89/wce1oViCNswKzVmBEbpoCimmGF+yufqEBqmY2WIWQp/UY7Fs6QdCusFChk7BIk/ypzBgEyAPaTSC1sHNwiDOotKkQrucJy0ycHVFHLe824YB3ou0If9CFGWlHzo6UAbqktyxTI01icc1r+un4CrnC47wG1MStKAInDcqXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB8891.namprd11.prod.outlook.com (2603:10b6:208:56d::20)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 00:58:32 +0000
Received: from IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1]) by IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1%5]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:58:31 +0000
Date: Fri, 18 Sep 2026 17:58:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <aq3eLaRsT_WavyZt@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
 <aqqpBBtJ9CWYGQDT@rric.localdomain>
 <aqrVz6Q1fKnnMv2g@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqrVz6Q1fKnnMv2g@rric.localdomain>
X-ClientProxiedBy: SJ2P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::14) To IA4PR11MB8891.namprd11.prod.outlook.com
 (2603:10b6:208:56d::20)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB8891:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ad609e-fd7b-4d1b-7d33-08df15e91c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: wsTzG0SqGYFHyCX0lrdMSmDiz6y45hbFoizgv7MEeGjTLqxcNlshQyJbsKawa7jaBcAqABRQNnxiREijiq7M+pVfBr/YKlB6C6liAscD3xCcMtSWhL3jsn5IVH62NuFmpc7OlSIZS9h37EZsi5xBc35l0Xq5gg4T3FjcJMX5ZyJMH1OfObwbQaJUkNnqdWDHt142E96SdkP0exvVwy+z7VrjPXb5LZfvZqgvjruvbcbvCX2WHzt1SPYzu7148OZInNpVPe6jNf2L5Mwima0A69IgeULOHJCFFCvlwmeZfqzK3YDcHVNo2rTGvXPV5dhO2lkWhNOKQcgK8IO1WnmYrFnjr4goCUzZBiMcgKzWDeKsJ2bmLi8TmEtBfvYCySaWWKYGfdKXZ3hZdkfMMc9HAjxqU5n7lgRmEdysntMBIjWVKwy3lNPZLLI6otfrgsEACvknITVe91/IR5vCxCHHAKVRKhUSJ86IBPv0+aEbfavZ1iwX2ilsC6yxAUHww0OCPWvUlyMWZEjuKdOYD8DViTU5Bc/rCT4OwgPyoVErYho80mIeZkH8diTCkeTHt1ms03HwdzjMBngtMQ/WxvK6ukvunVK1o+zRXOKO7owpJpad/lkev7F7ShmU1VgziGHVyK/W8ckgxxdITi5I8Gbv4/KrXiHNUjJojRWXpamO4m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB8891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SXClFwu8juSEBnhHXU9ZZCaHUFFlnYx6Pdcv2sVhPy5KCV9iyWS/dXFjHFa?=
 =?us-ascii?Q?K4h/s8hXeu8+D+7bRDUrpoepUcip+U7O2X1pn0PJYad02930Swt7V9x75MAJ?=
 =?us-ascii?Q?DpqmMwhGQXW+YdtU4qLC/t/7816WPsosvimSHVma0oVdZEEyyr595zJqxUZ8?=
 =?us-ascii?Q?Z7jSq36ItSrWVN1Y86CXDigIv3rjpAANRkWC8UZNDrdZseW/O50fsJ0n2GCo?=
 =?us-ascii?Q?wDqsNI9YAZ5OsR41xUB28iozKpvCR8ijAWRb0UuxFKOZ87q62+Uz7vZqwUZC?=
 =?us-ascii?Q?ScFVk80M2CzT5elMPgw5FGvkOC0o5+EWJZ+7ULpNIF36BpZXPd5D2O+QPtaz?=
 =?us-ascii?Q?PN7jdch0q33yue0q0Ywebozq26426V+4HF/ihtNXflXMYtwQ7CivMEUAIT2/?=
 =?us-ascii?Q?bYybAoikk3NVzEQo+3PkmLmwnfqhD8babm7NoESG34Z886uJ+eh74/lz3ZUS?=
 =?us-ascii?Q?tISL93vbRx66BeB1/ZEetdh+ciZLxpdcO8ZwqgYtVSZwo428NQ5h/9/SUZRp?=
 =?us-ascii?Q?w2QPenQ2NgbqbxIpvMjOPXvthp7nGZiCQdBRR4n2dmBVjl5AlSKZjQvxPBQz?=
 =?us-ascii?Q?LbJFuwml8d3vz9SRXWdoEw+26K2y55WLoYoKiIN1m7uW3d9XWRM6rQzvIy75?=
 =?us-ascii?Q?16LnMYTKEt5YOb0DRSaidgeV26m1Tg8vdds8XF7QmdlaclTWi3cD+K/zRHgf?=
 =?us-ascii?Q?IsLRyPrJbVHaiR+NJR648NEdjI4eBgES/LOPBqNLJfB+/PGh58extz58Haw6?=
 =?us-ascii?Q?s8dm/IH4yo+xA15oQ3ok6b2G1GJnpucYZQhn74coVnQmUYLx0I5zE/v8Q6wM?=
 =?us-ascii?Q?PTrbLYce3arsrqoLqtO4H78Xbzt8+GoqdRMjMHkZfLzXvauMbds6CLwFp4gg?=
 =?us-ascii?Q?D+wOovfAjfRotN/+6B5V4JbQLcxVmTzLkNart+e14cVgkO7vA3I88Tnt5XXB?=
 =?us-ascii?Q?BIO28qaOfH1FTLO+NjfHGb/OarClmV5JRaDMPCZomoeBJql4hwgJvdanw8FB?=
 =?us-ascii?Q?9fIDs/Bzz2aYZZOdexc9Sk20NOfwCLbRlgb6qx9Qwr+x4ldFSoJDAb0Cl8OY?=
 =?us-ascii?Q?/9Er0hR01xKlIetRUsIDVtgfeT4xomxHL6C2mim81zuPaf+Q4TdRdHlfl4hf?=
 =?us-ascii?Q?b9ugbK12ScjwMwvb3RMygvc1eprCvU+Q9itpYC2yUyTSyzyoGVlapp/I9R1h?=
 =?us-ascii?Q?r9n1+kVxKCKHkoQJ+NgtzybtGhs/gK6v+pGlprEMObQpTKg7UlIohcO5nn9i?=
 =?us-ascii?Q?1+u2Oa1nSiL4vBeVCDD29aM2fYGb7egguT6woVLZ7ehykJ6D1YHdjVK5LNG9?=
 =?us-ascii?Q?Q9+qRL4FXEhiHPeuTtsTI1AXb52LDr3A/8RgN4B+fwH5+EnScF//DLXvTTEQ?=
 =?us-ascii?Q?oYvlDIcxQKT6lm97Xfd984c5v1dypib1++qG9noha4FokJK7zdJQcpDcr2zM?=
 =?us-ascii?Q?pKzLmfasVTF5Y1IQfM+F6snGk9LcjJuIM3DH6XuJhibheknA4hZ4aLn3SsI9?=
 =?us-ascii?Q?82vBeDK9Q88sqJbur74bZvTUOVtZope6hAlaRM1gP6/uUojw4s9MV7K4EQTv?=
 =?us-ascii?Q?tXRPpIUscpkRaRTI0hlXf4d+TnnqZ/BL5MbpRc1Y3ZfRU0ksvXuEIhKesD5F?=
 =?us-ascii?Q?Nd4j0l5Z4TFEOr6Dp/woss4SrGugcl3EwRvnsBpy3ZPbUWp08hn0K9tWbmQE?=
 =?us-ascii?Q?c/Plge07ymulVjcRfPv4LvZ6GAjzS9+W8UwmuzpEhZJpMQ7R+8PdNw5u7deK?=
 =?us-ascii?Q?ny1oLQNlqPR+lVY+ZnIjzSe9MbkPyzU=3D?=
X-Exchange-RoutingPolicyChecked: moqhM+c5mIVBu1xaI7A8CSKcJlsAox6RSOQUYwTUIYa2RFWmTBFN1zbNJdt0rI8y6rosVUIGDdGfABro06yJFzgf9Oimxjh7v3yXAIcDQOjTuCSqi1cmW3/mxfbqjf8+lV7q7oFnCm54nMeakP6V78qZGEnMUPlIeblCxxLV2U4P5ePIicCwB3xz3Y+3Qs+KAJ680Zcj+FjzeTyJiEFsHItPrBWlZ8x0swZxXuRdSgFM8lklBSEz0HMaCgxYKA3/r4MgbRRteS1PKIQMd39cQjolQ3Ga2jZCYY+2QY2X7KtTSveblwRCesuxTa78Ha80ssV0muE/fGiwVd9aSZqCpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ad609e-fd7b-4d1b-7d33-08df15e91c33
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB8891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:58:31.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9DURtxoNIgFA979GTWfQDxvhUGGQN2XIlgex/3leM4LOqqIpNJTK02QGfpSFb+pvJbO1xLr2hKyPFznMdjV21D5BmCy7MlMSZy/nftcbmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 07:45:51PM +0200, Robert Richter wrote:
> On 16.09.26 16:34:49, Robert Richter wrote:
> > On 03.09.26 16:23:46, Alison Schofield wrote:
> > > cxl_port_setup_targets() derives the interleave granularity of one decoder
> > > from the granularity and ways of the decoder above it, and takes that
> > > decoder's own ways from the topology below it. The values from the level
> > > above are named parent_iw and parent_ig, but the values being derived are
> > > the bare iw and ig, so the reader has to work out which level each one
> > > describes.
> > > 
> > > Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> > > for the level above.
> > 
> > Aren't my parents my child's grandparents. :-)
> > 
> > I fear that does not improve it. iw_up/_down? Unsure.
> 
> In the code it is finaly used for auto-config checks or else for this:
> 
> 	cxld->interleave_ways = child_iw;       
> 	cxld->interleave_granularity = child_ig;
> 
> That looks odd now as it is not the port's or decoder's child iw. It
> is just the port's decoder config for that particular endpoint.

Agreed. This makes it clearer that child_* is misleading.
I'll keep parent_iw / parent_ig for the values from the decoder above
and use iw / ig for the values being calculated for this cxld.


> 
> > 
> > -Robert
> > 
> > > 
> > > No functional change.
