Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC17199385;
	Mon, 27 Apr 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302492; cv=fail; b=SaZXvCojpQv5rgB3SYrpKMHg5djW6Uv1TqgOPCSDcauHZJyQKof2HGMb3K9auITUeXKNGY23GEFGaOgIUMMo1e5FLkM42kt29bokQhL2UaqR3LXc5Q7fJNRlJqnvSuzraun6OVy7GKkQOeCviTu9upxwv9JhQYTVAPiHRruZn8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302492; c=relaxed/simple;
	bh=Ig02joyxJ8IovJ3TgEfblVMDd3TQrarN4rySK/QYsyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjceiBJeNWbRSp/TePId2o8y/FRRs5H8SxKmJUZseKE14A0n2N3M6YqhwBxv69TiorID3QYoZ1iTFYj4g5F9OgCmMM2XBwGYlceiGtvgARMI4HCYfCFq2HjtQBjNoS2ou6Db/bMJbS+xFs9tIj70INuLKrZO1iSW6qW71MzOTUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZg6n4YN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZg6n4YN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777302491; x=1808838491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ig02joyxJ8IovJ3TgEfblVMDd3TQrarN4rySK/QYsyY=;
  b=KZg6n4YNCnXjyr7A9HUDxz7iFANCmy0SUq6uhCw8yunn19Po+MKRKvSX
   ijafNzjaP0d9PHwUTHnKVxckRhXttJX4T1ORT5sCJKO8xdE26fQTo6GMp
   67iZT+d0jUaEp25Hqngo5K2YjtNlhJLNnGhflPEOjhCUmRvM4omN+Mhqv
   ZF9A/wENDPS03pGLXySSEEN2kHwXTmtk6MNKtcyDxk2fCtHdeDR/isFSa
   aQcu+JKYRBadzXimWtC9w0HjHj3PPPDZwKZ36vMdAYKACLFk6Rk1CKU7l
   GkzYvRC3RJpA1/OYPrxq5+RB+DKAQ//R4wAN3qkvbWg5lxsQ7JN5tI/Mw
   w==;
X-CSE-ConnectionGUID: 86ragMLoR7esbEUtKpQFPw==
X-CSE-MsgGUID: UiqnIs2hRhynApRPW29Kpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78083667"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78083667"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:08:09 -0700
X-CSE-ConnectionGUID: VGqCT1qwQ6qxXOlTuuFSTA==
X-CSE-MsgGUID: l9cPtYQsRua9Xa8JDSN+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233935704"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:08:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 08:08:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 08:08:07 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 08:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4ngC8xN4RuCDYImTZLXdoM6/3kDi3UuarmXC5G9QLDCGY5yi+LmsIpEbugcmIdd+mzHikBrFxNF1CX78Qbiqp5EFPk6y9EcgXMiEbzutVP+CDn4S9z6wEm73jdjgimgYLgQVk2IIpezCyMUzz6gPNNqZ2cglKb2rllp5Yk18IwzzHhGpYAXF1Lre6FYPxBAosuAp39Y/k5yiaDFZG6N5RWI5E6SCmZqvhEkr5RZPKFLFL2qmME30p3eRy2OeoVBVA6nypCN3oHc2L+OPSwlA7CbF+QJWnTgMISkI5ZnW6Yudtp7nrxAfrl+3b6qvnb63BpjdskwdYXZA50oxtMqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+64th+nf33ffMG+Oekeuyca6K8BzP0Q7ort78noBiM=;
 b=Z1TCA/E7VOa1KIrodA3oYmMnHmfLpHyWqSOlyW0vT0s4ggUlCWiWFU07TdRpI/IkPiaOuHsC8tP5o0VZ6e4GtA73JWfyrQRCeIpmwxf04PiicWC+U5aHnP7cc3y+MTD5IljtmPD3SO++f8qdKGVX1zEK0IXEqwm8KWZliWia3L051U0v7pm6CxTVG1sJXs8rfQwckaQrPxYuWwyGDS0MtiUVHYYox18jBTXn3RluHv/lC963pTwgj2zyAuZsK5QRMjsXHe+1mDZkBv0VhY27E/Smal9L+olO652vX9y4sWcSemn646T7FbX3q1aYMcpI9+8IVVE14ThLjVFd+A9N9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA1PR11MB5897.namprd11.prod.outlook.com
 (2603:10b6:806:228::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:08:00 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Mon, 27 Apr 2026
 15:08:00 +0000
Date: Mon, 27 Apr 2026 10:12:02 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
	John Groves <John@groves.net>, Fan Ni <fan.ni@samsung.com>, Anisa Su
	<anisa.su@samsung.com>, Shiju Jose <shiju.jose@huawei.com>, Robert Richter
	<rrichter@amd.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>, "ajayjoshi@micron.com"
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <69ef7cc2a9b63_101875100a0@iweiny-mobl.notmuch>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <20260423235158.3732476-1-john@jagalactic.com>
 <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
 <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
 <20260427133833.61b9cbca@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427133833.61b9cbca@jic23-huawei>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: d8717ca5-6007-4207-98c2-08dea46ec5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OFwJ8nxtO7WWCHO+B3SOIXtKjq3KslbqORxk1JUynt2xXLmDu02ldU/t7Gm+OKDfVgvC9nU/oT7+H1tv+e89tTdiP5wCxhLM5H6T9YaTL8IhFHz8UEUTfUvlF1ZG484KEYIqfB7L8/Xg5gLGa/VErvaqnh3YYuwlBv+LScRi38YCFVq6QPzKLNvgAJvoJIBAcq4M5N9D43krfw+cXlSHlgXXE2bt94OJ/nE0/RZqQuMsv/0pPMqXsC9bc4Pw43dUjs0tRQNUmVpOnHLMno9tr1AS+VLLhUJJeYeuZ44+R2LREl3zQ1qcTKsRgc/gCOG8VRB9s+cl+/58yvEZW3Gfh75QZnfpJ07q0amO27OkL5X7fer7FPMENWQN11YmgisnttHXxMhAiDaDsnQRAp+tKgjmW35sMeHOFR8cj91n0gO3vTMZzXRlmUrogK22TuMYdgyApZUTrLdqXdDYhqSHSIk4zGCXgJjSbZq6HXvYiyC2oSYMJw3TGhSmKzaeVbOsMMvToJiaCUwZO2xN+pVZirD/5xidFNaDS78DITj5hSa64xlHGLM25VvFflLWUYt5oz2CnWNmv3w52M2Rtdus9bNycu21Pv6yCWKGXp0CYHzV/sqQntPMew0k/3gkrOcpa+8nJWzANIYb39YdjTX8VXtYonwdIQ72zD6gGxzH4Raun+QUjltauMBjHc4dfzr6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSTGLkf3GYLtYU/3uSDkG1toyj/e2CXSYt5A58dcW7kpv5r04S3jQ9VJJnXf?=
 =?us-ascii?Q?r6p/mchSQXD506Lhw5pgXz+UaNNpBLoxY8t7ZigOUgi85b4bvVDfZoQOZxHT?=
 =?us-ascii?Q?+fMrnjosKQgirIr1SFDBrVvIqG/mFOu0WomWlR1NgBafktVIdtv7DP1QoIko?=
 =?us-ascii?Q?UNySR2Y63085BgKLOcyCYR2gTNqr41nlchhO0HXisCKVDlvrG0i94KvLckOf?=
 =?us-ascii?Q?vlwYbWHZCibdRjNymanBwjtuZyoEiJGiEdQ8x8rplRw3lv/RCLGCge9YnRps?=
 =?us-ascii?Q?15An1fc5nvTvdPJjyFuWR02HshszUXZ226dqz4zMf1llt+4g6L550TftRhEr?=
 =?us-ascii?Q?BbBb+SFZudx/rfMBZpPvJP8BECCD4CZr4nJDibU9REE9Zswt/NPSjVPswXzk?=
 =?us-ascii?Q?uG78FdiGVl2K9qkH/ePjnST4uEZbE/FI9zrI8aJKM7WI3uKln7nqoMnssbMn?=
 =?us-ascii?Q?VHBg8+ENTuYa5iQBJebvNF4qr562rwL+go1rlFjATdrPuxWdKcQLkf/+cSim?=
 =?us-ascii?Q?GQJm5GUu0ykjflz8pqzF5SkX3jIkpK2JkYWXlelaCpNLGiTmuOYN+XX372DG?=
 =?us-ascii?Q?dDGTeUOaQWWwLKjhxwGuRRwBrXjEg9i6I7GjztGXpYIeKjZ8QGTwkwj7v3ci?=
 =?us-ascii?Q?WhTwpsgK8Oj6CI8Qwjw6KmwYpa/Xtu+gbfgoRJXh407CpeXdwKlSfySfwloE?=
 =?us-ascii?Q?dSmfCjsrT3gsOWODw3TtpxGIGIgTmOJlNIYIiEZglhmUsrLG9/Fk4v6wHEfv?=
 =?us-ascii?Q?opxk1IgMPxyHhXDQo0NtkLcYAx1vQae0vgg3tYI+ht1cIvUKsJNv2w8cEWRr?=
 =?us-ascii?Q?6VOH0frsjwVDHeWnt6fpujSNuRyI+GLClzjUhgMV6MfW4TzzH63RraPBAia4?=
 =?us-ascii?Q?4P5Kl98BULajtVgWVzNtpodHVkpOqsgWY6waHse3tnW1qTPYSARY9fC46ikd?=
 =?us-ascii?Q?1RAL8ds9hxmgepcISJVH9xIZ/tEr+Gh/f95s8q3WU+0f6WCwNhzUiLEuBnBJ?=
 =?us-ascii?Q?gNypdMm0/qUletrMmmVPA+FqTxj/nlx6reLQxxDlrCAxR0tpPyrOXlXS5ZZS?=
 =?us-ascii?Q?Ksytqvotdlzrj2E8tCwmyiZPr9YxXI4DyfQ3XD38IqY4n6GPBJEaKa65wD5R?=
 =?us-ascii?Q?At81ckLZ0A7HFRDtMCWCChVgw9AFANUsjcxc3eNLMpjldepf59VnpY0DuQck?=
 =?us-ascii?Q?kqwGnquXEHn0HjrVJnTa+n9nua9dWwuCZojQTXL9NRn0Nyon5WtOwIibLeGa?=
 =?us-ascii?Q?dCVyFqdRinMgEZWWq0AUZsT9eg+Hr5Fa8aJcWAajGuHlAf6q8T9LfgU4YuB0?=
 =?us-ascii?Q?9XJcPJQ5XVpFdtAwJWbravukY8gYj3HAOf7B+Tb7sbIFyoZohAx6CadilUzc?=
 =?us-ascii?Q?SzfH/SOKtwnt+TLJ+7G738b75kYD3dmQ6vfnzO1vP3Ek05Ub8SiK46UR3bKN?=
 =?us-ascii?Q?COFvSvVJEVFCE3SzYrv9Gh2T9p/rxRgVH7U3P9m90lH+Jp878YB1X4Fto16n?=
 =?us-ascii?Q?L4DLFTkqLOxoLKC4bXXpNmXMp3hTHjNh81avO1rDpp6TPRZHo45NEvq7EoYN?=
 =?us-ascii?Q?R/AkWm3t3wEYrQ9DoSUVbWQEunV5E2kiK94P/H6ja1sr6XXyHwOXoE0Qytdd?=
 =?us-ascii?Q?mvuXVwuTHHdXtOMMpGabrPY+soVe+/mxcCgm/rdINPHgrsQlxJql99dpVs7d?=
 =?us-ascii?Q?2l8ZXAeeBMaUS24zTR0R8An9tuVSbrjjJ1xeYLkc3RQsh+U8NT1QuMXBzssA?=
 =?us-ascii?Q?rRkU22EACw=3D=3D?=
X-Exchange-RoutingPolicyChecked: dPCBQuebiwFVHNx1nBt203Myr0IgcQkzmmxp1Z2uI8nhoubEtOcTgNzmo9F4P0hFKjf3EsiZDds5a0z4fwpGRX7SBiicpaSu8X3BtUi1nz6+iSUo/0MN2HOn2q1jpZZPl/dQ58JsJkKXbR4uFTBjb/97TPo8TC2kSkeqoux9li20G7nYfGYw2z4+D29w00Y+4xYzsZryh8vKMolzrntCgI3HXQ3qyJVsPcozqTYILIPzH64FT2mBE1Ayq5tWpVweqvIr64I7CCFWpqXVamwtBlzg1PVm1+sSDHTLb3QocEi2IWdgjEsBtoJXgkGT+qyORx3U7LPSa5d0eoVQFKUSbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8717ca5-6007-4207-98c2-08dea46ec5c1
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:08:00.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zK6ZYqh/Eg7leoqpcjDmeBhk8M17rJzynRx8kNmEa+QRiPbLf1EVFRX3kuNfn2Ia6YTH0BwIkTFakZWRhm44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> 
> > Look at the diagrams in this presentation:
> > 
> > https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf
> > 
> > 'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
> > to do is ensure that the region extents which get surfaced are ordered
> > based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
> > order they come into the host does not really matter.  Although yea the
> > spec has a bunch of rules...  so whatever, follow those.  But it is the
> > dax device which groups the extents into a contiguous HPA range and maps
> 
> On this bit, HPA?  Why would extents be contiguous in HPA?  Contiguous
> in the DAX device mapping sure, but not HPA.

I'm not saying the _extents_ are contiguous in HPA.  I said they get
_mapped_ into a contiguous HPA _by_ the DAX device.

IOW the DAX device has some policy(tm) which looks at the extents and
decides which ones are part of the device (the grouping I mention above).
Then it presents a contiguous HPA to the user by mapping those
discontinuous extents.

Ira
