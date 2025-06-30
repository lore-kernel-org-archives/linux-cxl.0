Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747443AA8
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315569; cv=fail; b=i23P6fgvrw1HCLMHEshMvug6ycAJaRbwplcrQaWqZsFYf+rJO2Tkl71cxjjQI+MAlUNYC/mTCJ5sfJ8MRjgsVOtokbU+vZcsicGG+4r7zd6RcoWoURLPT1LUTEVVdS8f6w0LG1BEVFU8kmtH5AZ8V3k88B4y9F4heG/6kiqDLzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315569; c=relaxed/simple;
	bh=AjDG8uXiXpiYjSV624iZDtZvZVKAq9u+pWUoJAsE98c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BSEiKx5hsCgdpoQQOo2eMvpXLlllFYq6RAgMxg4LO7lCpPfojr/FwnnRcw1gswtI/dfqeacT0PBiKhIhW0bQZIrf0izCw4y3EOCxzE5EOjgA4/H//KtvqCDLawschGWNQCUenzC5MrGBpo6LSPDvmMMh+UHqNc0TIGajl0mbTtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW3Ks4iN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW3Ks4iN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751315567; x=1782851567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AjDG8uXiXpiYjSV624iZDtZvZVKAq9u+pWUoJAsE98c=;
  b=aW3Ks4iN3WVED+Xq8CiHVCQaYjteJ40unqYy8ejXQY0w1yXPiTRorERt
   3SMW74pw3AeWn8B2YoNe50C1kfxf/xaHzu/HPKLa4Je0YBWPSHSQSQ1vq
   Uvaou52Mm/8E186xugdsha8DHFYJoVsFD4yQMP7+/e6c4nPTyiOgsuz4a
   M2P99PRwUfsPZRoOOkfGVOYSNdJig+bpom5gGc/Mf+51InEs1qNaBZ1Yi
   C6SaBY4aPereKPl13lUbthbsk+R9ft3OYC+mcYYxeQqFv1Anv03h3bt1R
   eFVEgwdrHO3LCc00NUWxWMCZ351zPMxjjKjti8uJEvwp30JI4sNgMLj+z
   A==;
X-CSE-ConnectionGUID: OhDtupncSLGy+WNNJ1nmHA==
X-CSE-MsgGUID: pzT8yVWoT7OJBmn5KFcm0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64156997"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="64156997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:32:47 -0700
X-CSE-ConnectionGUID: luuNbt4gQOKi2m21fmP2aQ==
X-CSE-MsgGUID: /FonQw9XTKakAbsn1c1Wqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="190733364"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:32:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:32:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 13:32:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljTHBSh9HHS+Po0mD/aTYkEe6vUXeS8tkhk/gPMkGlO7XdrdMjAoc3krzLICXthOB3d164AkUxCKQ58hCGiZ+l9IKztKlzKYBAiGmFPme3GxJtVizPhhkFYchcPZixc+1qCh5aC1S90JGa+UdMLj2Zr3HhZAZnspGNN4fLVhfVQ2zdXpYQfjzHplIoDVkZI8INiHTWhSTiCzkriSXTS1OrauJablo+M5NJV7xzgcSKPO863brCXiuUcy0QFShOz4UF5zQ8BF9E+G8Ab7yhC57tHz+bX7NFpM0z5f7aq1fVt0RVVD20ual3beK6nA8oKmh0PH4ZPcjm5srzP7+V1I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViUheAbjYLM48reDrkhJHEwl+8RqFsv5m2mLTJwvyxE=;
 b=sfjJR4k5EKytVj6GLsn1ZitJkSN5Ks5zIgwzAsU4Q6mbLm8lIwedL/tjQ5C6l9SI4k3scpy9fxiR/ZNYqAAfUc8C5pw1LaaodXQ/A3spi3z8yHPvnqQzfPmcuIBlq/x9avo1aTB0685jt49gWBJfLuEVjMYleEWSjP2HzFa+DPQrhCbXNTDDTza7ksQjaGSt3puR8JUU9V00hFtSKAreZNJFCSTqtEwx6EkZDaW+CjVdiTsvBQ/gr21OwAecJjH+zYvTwhXLrNv1CdxIlKcJMdGpcwlFoib4mYjDWBJBGV6IbaTSLUw3E4HTnGD1zgdmMXXiqXfrNGTu0V/bBFWdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFE441933A2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 30 Jun
 2025 20:32:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 20:32:42 +0000
Date: Mon, 30 Jun 2025 13:32:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Message-ID: <aGL0Y-k8k4xaZcrn@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
 <685c80bf237b2_23a2a100bb@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <685c80bf237b2_23a2a100bb@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFE441933A2:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4c7402-4126-44eb-ab92-08ddb8154372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ub+kHk+6jZnJFSMBpH40PR+eUsflyTZF2YtIX6NnTyp2v+PRZ5uCIHr5iomK?=
 =?us-ascii?Q?TA5VJGPqMsxmsaF1wLzZUm6UBMFyMr1P9qWCpL6Z3+PXvxChlSvu9HbDD+lF?=
 =?us-ascii?Q?Gpy+VBaVq2gcsTrXG2z5IPlfCgYd2a2ejcz/ayo6KKxkvuzxvtrGLQNNaTeT?=
 =?us-ascii?Q?sxnNu+De32O4qlUcQtHOUzIS2O3tQCMQW2JTn86IECqrB97cz5jhwTwIAdov?=
 =?us-ascii?Q?txbCt76VGWSZF/LTHvKtUbatFLfykKkfTuILx5Fe1jWQhT3UT49gceMzaGDR?=
 =?us-ascii?Q?KWVv68HnCjuL54OGHJ+n+10Lfys4OT1F0uOvgWV32/9axPqeQPrjnA/X8aBo?=
 =?us-ascii?Q?AtBp7jNLARRIbi4HMcIMnV5z8JujJn8CAQS2993wtLk+VFgUIBUKPHL+nWCe?=
 =?us-ascii?Q?glkgltk8IFBs6etxkstvyb4BIl4ppnJPwKF7cWq/pRjYp1KfV3DG14iacdY2?=
 =?us-ascii?Q?6lDs2l594kh1Ksh3SjUXf5wQRnMYsOC23x1yiMI5Nua8pgEqxQ0S6JIqy/Se?=
 =?us-ascii?Q?m3tsLKYoyZujanTz0w933fDWxoJkloIz2Vd2D1t66bZ1XD06kRrc9ZpFto4A?=
 =?us-ascii?Q?LswmwwJv+SQJc4iG5gqANY4OiKn6FeGnMmT84++Ew0HFW3NZUDyL6DSyo8WJ?=
 =?us-ascii?Q?7bjZZW1vGIPk0STCX+yLsEinOJv4SGIsEu4RdH5KqXmVaP/532uVtt8oXVEq?=
 =?us-ascii?Q?PMWVF1TEkFFxyA7QLU+nhSCOSleAPEcKL5jYhV+QI0GrdvesQ67Ln/8oFR51?=
 =?us-ascii?Q?rRFmRkq6hFSPUrDceA2lt7RMaqvQhwao07TLiiL5kCaJeM60duBAv6H9vj/W?=
 =?us-ascii?Q?h2MhEYO1Z/lP/wwcpuI20siVTOL/aLahFxt6qCkpneNG48kww46fNDUCdZyr?=
 =?us-ascii?Q?431nHoXSDP8x9PybUfTxGHt6NXIHDsWVHfdtncu8nuv154cfLACgMBBZaTku?=
 =?us-ascii?Q?l4rS3j5HFC027z+6+imgjtWpxMTeCGoMsOMSmZV17U4SREP0P5dchOiJs6lq?=
 =?us-ascii?Q?tiC4RxYqlf+tBgNKGfB+Ds+X4XpCby0CDJq1eYL/2iwoCo9xJCPG4OWVh17J?=
 =?us-ascii?Q?Rjy9XxlSb2h/sIpM25dnH9lIfKWuoomqKNyvzQ1Ic1FjfdVZ+hxa1uceO1OG?=
 =?us-ascii?Q?rZxkrMYUWy8rL0xVivM0OuJnEdNVw3FdiGV+L9JvhR2XuufgVJ9TQDgZmwOx?=
 =?us-ascii?Q?b5fwAfB/w6ccx5/sv7GGw5HkGaAWBJkm85eLfSctVEPglJhxSPqUhKvUdyTl?=
 =?us-ascii?Q?MvknEHb8dfOHUQi5g49GsYTevvQ2YB/1pJj9vKTheR9UYjFS31PktQpoI5cA?=
 =?us-ascii?Q?9/FLLJG/fK+ZBayV0HDgtr98MzuThRsOPKRwJ7iR72G+ViWRq/9nijWJJLEv?=
 =?us-ascii?Q?SZUF68fY/HbFxtd96qz2vDKZuhDQi9+wfdtzvUvOYn5shaCFwZpUAYrsVK6w?=
 =?us-ascii?Q?pLno+hQhLKE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFvIessQYlPtVz5hjOaMtGX5eL4UWzcMNGlKBTLksg5gmzL6ZfyY9nIfpYkY?=
 =?us-ascii?Q?unjDHZE5LIFllKmwiS4206CF99WquPJ3W4KuljEvBrsa8s4aSIzf+gtpb9UP?=
 =?us-ascii?Q?2VzoHOf/A1iKZNDWfG8ppjBl7CwsF1cI1ji1yyNR9r0POd9aNaA0wIemxLle?=
 =?us-ascii?Q?XD2tA/i0OJBTlV8de+9KPvhfOjAmJwzcVMyYkW4rGSbpEQb+e6GHDTmvr8+M?=
 =?us-ascii?Q?5Ghm5kzK7lBUTdrUMzOU7pZppMw4/Xtdrvn6x1vLvnTYxJDxSSdX4HA79t/Y?=
 =?us-ascii?Q?9Tpxs3SMfoa4VBAgan5+WwAL6c9mHD/gKiRkNSEZkYR/d6SsAH4uvsmQ0Hgy?=
 =?us-ascii?Q?uZl6bHe4HWjaw3BZL+V3j+aqBUKu9iwt03NHPvmFtos0nvb+eTIlEKgAebTX?=
 =?us-ascii?Q?j/5evZtOyY7JmMr5Tb6gfw7v0XDEo+pAq43+Zq7kYDQYjaPxGNnd6eC+hJpq?=
 =?us-ascii?Q?m3bhaHfrsT/bRHaV1Hs29UaGYMQquL+78p4grjanUEpoYiVQN/tNJ8HUp5z8?=
 =?us-ascii?Q?ok1hqJUURMd1RU7qDfdI83o3ZEgBDqTq5JqzUpgCq4ap8P0K8OQ6ET+UAZY8?=
 =?us-ascii?Q?QQj13Qygsq1SHpY+CDS6/m0Y3vEk3fivzncJyrhEn1VLourfj01eZron6S/R?=
 =?us-ascii?Q?YPczrAK6v3X//PJenf8Wc7KUTLuSopVsHJ0OGP0oMgqy3+3h3kEPs97ZFZdh?=
 =?us-ascii?Q?MTOuQdb8+qHTzcH0bnvyN/6vYnp3K7BMqAs9IIa6vD8JrJ0yrPJWmYGO+z6X?=
 =?us-ascii?Q?kuIb8oPMfgc1thmaLmxCSSJi+RNmHwunOxpuAoL0INnWMBg40sqlCM4SCBmT?=
 =?us-ascii?Q?tH6y+2Saw+/KOU7A09SDtEFHHQvPeUcfmEG9Eai8Em+EgTOUkVoeuQFPWvB9?=
 =?us-ascii?Q?MJ05ioV4JgnWlmdbNwGGfQjO2YF4OHt/kcxlUIR/tWgXAjdDUYtjdHzTy2aZ?=
 =?us-ascii?Q?I8inC71A+qeTSoIbsak3YNERR78r308/VOdIk+7IXAYUVN0J43SNZv3fmTTd?=
 =?us-ascii?Q?p72ubcxfLGzdv6qvZky39uTvu8Z2MKsLmGINGGi44GtbzsxDJXIYRcpp6pZe?=
 =?us-ascii?Q?ywtYbmD7d2ekSnIXNoLSHuWOFf9aJb8qDphoOOLIMXVIj2T8SVei5d9L/1uy?=
 =?us-ascii?Q?UvXeq+1CpQaFPxPKSevnSWn3CKDDf+tMFg0YIWiPEPebKO1XYy+LmsbBg21q?=
 =?us-ascii?Q?9JONWJMGEmF5loYFw3oyuJqJlfhGk/SyMVxo2y7tzZZpv47fUIg8lw858ccV?=
 =?us-ascii?Q?fmxMkmDdoECGP2ikzuNR+kEP7oMBPc6qFjWtD/+qpDb3iVsrUZrpUsXBDHZ+?=
 =?us-ascii?Q?3zhn1GC4YgUj23ErE7uQTeDQ3JVTRwLUv4Cbu0cUQHjmuSyXKJnpiQs7ei7u?=
 =?us-ascii?Q?muQGUgcLiB5tXuZkdQmndChJ23F1S3tOlYwtDrB1YngRxxAe08fXdi/fbWBc?=
 =?us-ascii?Q?9q3jHe0/0qPIPjQonJIKf6n3/R3M4UWl5+ilVn1h3ZAfr6VHuO0nJtx/q5zO?=
 =?us-ascii?Q?SrQ+QAm29uHKV5MEneCc78vsqCYkiZJ14+HLfuy/j+fpBWHiQSwIb5nC23Ny?=
 =?us-ascii?Q?0KtjIl566IN0NplWyIvhd+gutDQXT6ne92iomivxsvE9Vqm6g3izKyFBMKw3?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4c7402-4126-44eb-ab92-08ddb8154372
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:32:42.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw3o87wW/xtt8PrrYuRsU7Fw2oDMXsvForj0p2kjdUK1TxGQ9gEwu1sNi82kIhHnPavV/s8ss4Ff1AzG8PgbK6JniG+1T61RI9yQ9coL3D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE441933A2
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 04:05:35PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add CXL region debugfs attributes to inject and clear poison based
> > on Host Physical Addresses (HPA). These new interfaces allow users
> > to operate on poison at the region level without needing to resolve
> > Device Physical Addresses (DPA) or target individual memdevs.
> > 
> > The implementation leverages an internal HPA-to-DPA helper, which
> > applies decoder interleave logic, including XOR-based address decoding
> > when applicable. Note that XOR decodes rely on driver internal xormaps
> > which are not exposed to userspace. So, this support is not only a
> > simplification of poison operations that could be done using existing
> > per memdev operations, but also it enables the functionality for XOR
> > interleaved regions for the first time.
> > 
> > The new debugfs attributes are added under /sys/kernel/debug/regionX/:
> > inject_poison and clear_poison. These are only exposed if all memdevs
> > participating in the region support both inject and clear commands,
> > ensuring consistent and reliable behavior across multi-device regions.
> > 
> > If tracing is enabled, these operations are logged as cxl_poison
> > events in /sys/kernel/tracing/trace.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/debugfs-cxl |  33 +++++++
> >  drivers/cxl/core/core.h               |   4 +
> >  drivers/cxl/core/memdev.c             |  11 +++
> >  drivers/cxl/core/region.c             | 120 +++++++++++++++++++++++++-
> >  4 files changed, 166 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> > index 12488c14be64..c784885cdf07 100644
> > --- a/Documentation/ABI/testing/debugfs-cxl
> > +++ b/Documentation/ABI/testing/debugfs-cxl
> > @@ -35,6 +35,39 @@ Description:
> >  		The clear_poison attribute is only visible for devices
> >  		supporting the capability.
> >  
> > +
> > +What:		/sys/kernel/debug/regionX/inject_poison
> > +Date:		August, 2025
> > +KernelVersion:	v6.17
> 
> I do not find the KernelVersion line all that useful because git blame
> can get you that and sometimes the merged kernel version changes.

Removed it.

> 
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Host Physical Address (HPA) is written to this
> > +		attribute, the region driver translates it to a Device
> > +		Physical Address (DPA) and identifies the corresponding
> > +		memdev. It then sends an inject poison command to that memdev
> > +		at the translated DPA. Refer to the memdev ABI entry at:
> > +		/sys/kernel/debug/cxl/memX/inject_poison for the detailed
> > +		behavior. This attribute is only visible if all memdevs
> > +		participating in the region support both inject and clear
> > +		poison commands.
> > +
> > +
> > +What:		/sys/kernel/debug/regionX/clear_poison
> > +Date:		August, 2025
> > +KernelVersion:	v6.17
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Host Physical Address (HPA) is written to this
> > +		attribute, the region driver translates it to a Device
> > +		Physical Address (DPA) and identifies the corresponding
> > +		memdev. It then sends a clear poison command to that memdev
> > +		at the translated DPA. Refer to the memdev ABI entry at:
> > +		/sys/kernel/debug/cxl/memX/clear_poison for the detailed
> > +		behavior. This attribute is only visible if all memdevs
> > +		participating in the region support both inject and clear
> > +		poison commands.
> 
> A few food for thought comments here:
> 
> In the nvdimm subsystem all of the poison addressing is object relative.
> I.e. instead of absolute HPA it would be a 0-based region offset. That
> might help when we get to platforms that have additional Host Bridge
> translation because HPA != SPA in all cases. The existing DPA interface
> for memX injection just happens to comply because DPA is 0-based
> mem-object relative address. Lets use region-offset values for this new
> capability.

Done.

> 
> This documentation probably needs to be clearer about the data loss
> danger here especially when this error inject can permanently destroy
> data in the case of CXL PMEM, and crash kernels if this is just memory.
> Again, nvdimm was careful to separate "uninject" from "data
> repair/recovery" because they are not equivalent. The documentation can
> note that this interface is test-only not repair

We talked thru much of this when we introduced inject/clear poison by
memdev, because they allow the operations in active regions. This new
method also allows the operation in active regions with the added
benefit of finding the correct DPA in XOR cases. 

The clear, as implemented previously and here, is not an uninject.
The user may clear any address they'd like. We do not restrict the
clear operation to addresses that have poison injected, and the
spec doesn't require that an address have poison at all. It just
quietly does nothing if the clear is sent to an address with no
poison.

I can make this documentation louder, and also be more shouty
in the original by memdev docs that I reference here.

If we wanted to offer 'uninject' then we'd read the poison list
and confirm that there is poison of type 'Injected' before 
sending the clear. That is not this patchset.

Does anyone think it should be?  Which btw would mean we'd
backtrack on existing by memdev offering.


