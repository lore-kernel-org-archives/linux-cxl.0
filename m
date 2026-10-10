Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25E23BD06
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791592604; cv=fail; b=kVpxGUHLWMa8W/RT9Yy6Z7KzX2M9dFmtPhzoL3WBPSznxd0U/mocxtmWYYwF978mogEmwd31ZwF/QuSzm4UwY7yBv8YFvWUA1Yl795u6qTdbnntVEnke33s8/xGorINnH+1DrEdD+GYVJ1QYi5dSWJHBxi2mTibPJBsG0+RC3x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791592604; c=relaxed/simple;
	bh=8bqZ7gcQG2Z5a2gPTrE6Wbgm6zfspV1Yq3oxcVjGA+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AcS8toC1lkY/Rig9P5N0yzxcuSfzDb3cfZZRJzljEKmt8OJoRb22sPe34GjXmkVjvbWqw57VFSW+qDQTTd47yMzUnN2zHAXkqPBeZsWVoE7LDUPZxcbzoUlXuT+m7aeFJfn8gzBO2Vd96CYo1qAcUaOSnjS/vYu95ueJAHJc5ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHYykaIE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHYykaIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791592603; x=1823128603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8bqZ7gcQG2Z5a2gPTrE6Wbgm6zfspV1Yq3oxcVjGA+U=;
  b=fHYykaIEgkSG5cng3pujsjBhj2n5YF+ZvzYuZPD61RCHo9iJeaB5WtnL
   siudbux+ETpUMMM42ZbCQ0jugSgy9I4XDpLI/qSJgeYbSuODzZuMj+HNM
   taNHI5vlR4Z07yFbdeWlW0FlQP4FV7bVRjCrVEkwK80LRDXSWwiqaR8Bs
   S9EUT7tzpJjhgMTbN0u7vLUVYiI0mBEOFejk2FJ4qHdjIB7WEl9PUZgHT
   nf+evLaVJKqlshvciHDbqB3RYs7B4Rppt2Dd1fDKWJ0JHUgL0WMJTYJqw
   QBFKzBeWpeqcO3wFID3FpVp39TeJsyj2myuGD2Or8yGSKYf0Qh3K88dZk
   g==;
X-CSE-ConnectionGUID: QNkmEbHXRESpHmJsnTa8zw==
X-CSE-MsgGUID: x8lmA/KbTGuPv/mmjpfpbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="297117"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="297117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:36:42 -0700
X-CSE-ConnectionGUID: +m77Xeu0T46uNPXL3WlNIQ==
X-CSE-MsgGUID: hsFQpimHSVe5leEU3k2bIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="516312"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:36:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 17:36:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 17:36:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 17:36:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK8u+wWAa5GumINYgpVqgWCyu0Cuy3bWqf7+V6j7QvLlg22bgmzvsmwKBu+BVAPmLNYzPiAOLTPuu5VTu+n3x4cdK0Rtmt2mFKOQP2PWQz1Vo4i18O45kzt68sNOJPnmx6LugAgpR+O8xNp+8LDVktoEZuhVpWA1EWnUe473MfyFPpizNe3ihRbX2IK/KBNcaZKTzvDqqjlp9s/UHTf4z7jJIdWM6VI2vz5uXVVKuDkHvlE7wqDbEKRlode+gpQlh7+yUPS+NLnEwMVtAQEvzLDJVmCZ2XP/dbtTidxuLtf2yYuxWP6ZDaxfhbyAl9NEAR7p4eOVc9uwy4Z3u/8AWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRkFQV06BU57w/cHzjSWDe2oZs61ULKAcaJjO4XWoAE=;
 b=o9oOtnL71LEiEx2OqDtBRv9alHXar/jmhChVKYnEt4scWQplUNof4Hxp/oG2UDoz6oq5SwfG0sG2O3idMODmVWpNUy7DFIaaRZWiN2vlFytuAFUXFFF/BKFeLEVSXkZRrGKlAZEUnfWs+5SumccPIQ/wMRapp3x0WO26c7GHe0qKwVyMOyt7+vBjQrjPvgIWrGsbwLfJ15cSg2r9+fu2BrDPoO7GIXG4pTNo/4aVNIEJc519W/W6OBCFBJU5/kgcimHVT50JmVCn+cwwV/yGsf2FTcBcyyWcRkCzcmgKne/7s0eFA0QTcd1rJ7zmMi4VDDHYHxN4iWf1yRVKxawyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB8891.namprd11.prod.outlook.com (2603:10b6:208:56d::20)
 by IA3PR11MB763247.namprd11.prod.outlook.com (2603:10b6:208:620::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 00:36:22 +0000
Received: from IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1]) by IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 00:36:22 +0000
Date: Fri, 9 Oct 2026 17:36:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 7/7] cxl/region: Factor out cxl_port_add_target()
Message-ID: <asmIbv-X0Ny6jxpa@aschofie-mobl2.lan>
References: <cover.1791575481.git.alison.schofield@intel.com>
 <a9855ed2663c8f93ac4b1c881eefe3c301dfc39c.1791575481.git.alison.schofield@intel.com>
 <9030cf98-ac5d-484e-b124-4278963af304@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9030cf98-ac5d-484e-b124-4278963af304@intel.com>
X-ClientProxiedBy: SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::19) To IA4PR11MB8891.namprd11.prod.outlook.com
 (2603:10b6:208:56d::20)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB8891:EE_|IA3PR11MB763247:EE_
X-MS-Office365-Filtering-Correlation-Id: 213a4aa4-0e57-46f8-891c-08df2666822d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 7ePvIL0C6X61tSxbJ3dqZ2FuZQE7BkbsI/D2WTKawhlwAHnKOmZR1z5Fir1i1qA2t58gmVTJOo5OTqK267Uq0BCilyuURUX1uw012PqJxYLtOnh7UD3g2SZWlBQqkwSPzVRUxaof4A8WqcnRml6Y7GvZuwnIFsamK2pngWKVQ0VtT0dHkGhVIbS6PsWNIUc0Pl/M3g98XJmO3+9Mtj65KbY0XGRWJNd82Wxde/OgcPSWR9AxjCXcVymBhxCCXig3h9wAfL0BcqDDlY5ftpWSF4WrIsWQddqef4YOiH1nsESw6dsryTvliZmgxm08sjjn4MxcTtzn/VXfFTNekLIdn+HXETj9jJ5RvuHf8CC3PbAR2/WmUNK7aJ5Sew/4SY14QkmoEEZQ2Gfi9EhM+CU2kcYIzPgXmTW7IpN+bvodu/4nonxM8+rLmdMN4e+7x82AxFBoe/iw6OR44KoDR5Ajb5PxX+fVBgqpU5O2AXxd9g0p9anYPKEPkxNpIhesxLB7hPzMI2wBUdkJUNdOKNsTX/c5yR5NofDsatl2QCXHudgV3syg/PCFklKxGB6Bj7ab2HyTgOEtdxkVxPD5bpbBK+E3cSydq6Bhe6lQR6QA9Q6HOFnVO2tCGKLq2grBsbmE7WU8BEadx59OHtk7oXOzq31RBmNoHN3XyK5wW4aTwiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB8891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChXPdEvpEjqJ2BKC9ZC4uZKE9pFeYpcC6W5oioGUSsF3Lh4+bzGsuhk2IsbC?=
 =?us-ascii?Q?R1AUpTqSWavXSb+irbkftv5B389BYXCM99LrYoJ9zX5zW0zamj8k2s4TqkIS?=
 =?us-ascii?Q?/CYeOWX4Eu5sVpYVBQ1ynydz1U6EPuT2GSyu0HYiVymUqVm0YrVjy+b32mks?=
 =?us-ascii?Q?0SfHC4NXs2rseuvRUU6vvrOcLxzxlj+no4IgNCUNT6n9Q/5q5hpmykFqCYpx?=
 =?us-ascii?Q?92kwtv4QHLk2jQbG31YklTn2IUobQ35b9MaNV80e3EaLjZIcUXJTbwMRAsTK?=
 =?us-ascii?Q?50RrPV8bQSLxxzPOGcukzfERslnm+Ob7Yljkxnxwp/l0QdqcjUbTSGdx/Ts0?=
 =?us-ascii?Q?PZ08R1TNkzX+N+ldnH3DiZfWTLdcNR5Hiy9xX5dDd7SMKkRjnIqbvaXJOyIB?=
 =?us-ascii?Q?+p65buyFuPgzOk5/WutsFmmeVN85SvlGguV6HLjLRBA9UtQPWkp2D23Co44Q?=
 =?us-ascii?Q?fk8x8kslC7zqXMsX2MaBWmDkXtuMQC4PulINPujO26wqMNnd3OVPq016OO1x?=
 =?us-ascii?Q?Sd0MosZevUXRTtwEsgPK1em8xHIGel6EkZiA4zhQmOCnDqT6WRrI4HU6f6Sj?=
 =?us-ascii?Q?qnStIsz/cHOUt/rv41NaQw26qFA1d/9RPUo83rNR1alQg0Mgai0QtGCBHlaB?=
 =?us-ascii?Q?gvRAdE/Yg4bAhAgl9csFR/ylbH6PyBwfo9Yrfc1GBLj1sgQTYrZJHe7Yvm02?=
 =?us-ascii?Q?E4CWfVufmSKhEs7EY2bAO8Od3WzXNXhUOAHF5VxxvKDoK/J5/MwZhW5HhYgZ?=
 =?us-ascii?Q?aCqe2aYL/oy2GJst24+ezYWUbnj+b7kgBClUD5fKT9VolL82fQdxVQ0GmA46?=
 =?us-ascii?Q?Dbw+8sdpwEOs5u/jp35Bd6Yt/NI8sSerCBbBC/yNygXZDfE6bNAOsEoCvZ/d?=
 =?us-ascii?Q?fsgnQpYCaBMywBk4EB8sp4T65g9WhRPT81z7zsPV/BvIFcTPJ1R86TjitaYV?=
 =?us-ascii?Q?6WaaD738CO/feOM/pjSxyZ99waPXxHGH6HPjdl+uWj0IP4KydvzvTu0VaI6l?=
 =?us-ascii?Q?7O4+pyOK1QSVE4kP3AkIwHE0TUA13k8YLdpqY0ymgWCS/k87tg2qb0c2MD4u?=
 =?us-ascii?Q?JDbbtEKf/nSO7GejLyW6JCxur5MI0RmFyzSo7ZvOjMPcZchU/qWzl85QLrz5?=
 =?us-ascii?Q?HK62Its2cMFlVuuGNvPX2MjJu4DblKE5DPk0bD4DkUM9QaciHL4nigWZXht3?=
 =?us-ascii?Q?e2BAetNrQHXq0THKZ4FGg7HuurncQcXl5DjJEQSlSXsxrUxkrBkUe7zV7Qt8?=
 =?us-ascii?Q?RR2RTOyCNahSdOW/t4/DulVRwROAKBFhOwNt4cpTc32cWaklY+zzcQXZRFJK?=
 =?us-ascii?Q?7qv8HYbKML1MZtP0Sn8XtXEzAcuBSp5Fb1JDsxOBVLI7DP27eZc3BPf97Kw8?=
 =?us-ascii?Q?HuEYrecFswkTGIRdEUA+TvzOsDhVCz7SvLfpW0mQuZAUy0ll5FNBJx0Sotne?=
 =?us-ascii?Q?RJTNyQhCxFA2UOLiEFGb16YFlmweUq5dJyDl2CT+0d95k5ggJHj9FDDa+bku?=
 =?us-ascii?Q?ito8VAY0YxNAbX/adZ/K/kzOucymaSz8U7jpiynlH7aThafNgrCFpGSTMcnT?=
 =?us-ascii?Q?TBrsL2B2CKj563h/K+xlUFaFqPFGVpLzbvIz6ENrTx0YeliHjehfu4BpRfvm?=
 =?us-ascii?Q?YOWZwGSdGPZ5Ci5EzvxyOVQvNxTSw6Z67uGKqAFWM6lTre2XJonczEBvT3fs?=
 =?us-ascii?Q?nA9lbqcHDxNUGSIWA//NvnYuuK3+yUSbZI8tBxKzal+5y9ZFwC3WSN631uMA?=
 =?us-ascii?Q?0SAG/DuGcLL4Ll1wRAtlvmJl7fu5Shs=3D?=
X-Exchange-RoutingPolicyChecked: TGUh9d8IQSBTu8SaECdyku+QssObxFJCT78O3wl1CjjdiZ0wfU+CMnwq+Ot0nhRHz9P/lZ1hMQKTfhdQa31V0vhTxKMtuZY8E5B82us+7bxYMmoNBn+jpb2AUF78UiJVAF6ZX0KHEA8YaWUM7Etc8tsK6Gj1CW8YaKSQ2VfL1Hy2isVIAPSewQN7BRBREO2jKeb+TK4ezdGaLdlup15WzA7rX5+/rovu+Dhtk8PeGwaN1dSprapLCEQv6Hj1+tH6h9YSjEKwQzgWAvoo4Ajpr+tbrEkjx0MzlJ3Bej47hJDfzxVrUQS/3Xk+PZtDj45khesxzpzCENth1DsVFxgajA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 213a4aa4-0e57-46f8-891c-08df2666822d
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB8891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 00:36:22.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB/FSomUCUHe6Tt9uE8/3Z2EI/1tMUf54/+dlQ3ELasWSKYmeLy/oo++WZQdfXLfcfkBScrtAEgYMaltxv5mhoIe0aHbBBBmxk1FTss2DCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB763247
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 03:48:31PM -0700, Dave Jiang wrote:
> 
> 
> On 10/9/26 1:24 PM, Alison Schofield wrote:
> > cxl_port_setup_targets() adds an endpoint's downstream port to a port's
> > decoder target list. For an auto region it checks that the decoder already
> > targets that downstream port at the next position. For a user created
> > region it programs the downstream port at that position. That step is open
> > coded behind an add_target label that the target search jumps to.
> > 
> > Move that step to a new helper, cxl_port_add_target(). With the decoder
> > setup and the target add now in helpers, the path for the first endpoint to
> > reach a port becomes an else branch of the target search, so the add_target
> > label is no longer needed.
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 82 ++++++++++++++++++++++++---------------
> >  1 file changed, 51 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4e9b0880663d..abe5fcc62e9d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
> >  	return 0;
> >  }
> >  
> > +static int cxl_port_add_target(struct cxl_port *port, struct cxl_region *cxlr,
> 
> This is only switch port right? Maybe just pass in cxlsd instead of port and name it cxl_switch_port_add_target()?

Yes, and the caller already has cxlsd. I'll pass that in directly and
do the rename. It still needs port for the dev messages, but we can get
that from cxl_rr->port.

Thanks for the review!

> 
> DJ
> 
> > +			       struct cxl_region_ref *cxl_rr,
> > +			       struct cxl_endpoint_decoder *cxled, struct cxl_ep *ep)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_switch_decoder *cxlsd;
> > +	int pos = cxled->pos;
> > +
> > +	cxlsd = to_cxl_switch_decoder(&cxl_rr->decoder->dev);
> > +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: targets full trying to add %s:%s at %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> > +		return -ENXIO;
> > +	}
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> > +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> > +				dev_name(port->uport_dev), dev_name(&port->dev),
> > +				dev_name(&cxlsd->cxld.dev),
> > +				dev_name(ep->dport->dport_dev),
> > +				cxl_rr->nr_targets_set);
> > +			return -ENXIO;
> > +		}
> > +	} else {
> > +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> > +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] =
> > +			ep->dport->port_id;
> > +	}
> > +	cxl_rr->nr_targets_set++;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> >  {
> > -	int child_iw, child_ig, rc, pos = cxled->pos;
> >  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_switch_decoder *cxlsd;
> > +	int rc, pos = cxled->pos;
> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> > @@ -1641,38 +1676,23 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
> >  					return rc;
> >  				goto out_target_set;
> >  			}
> > -		goto add_target;
> > -	}
> > -
> > -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
> > -	if (rc)
> > -		return rc;
> > -
> > -	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
> > -	if (rc)
> > -		return rc;
> > -add_target:
> > -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s:%s: targets full trying to add %s:%s at %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> > -		return -ENXIO;
> > -	}
> > -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> > -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> > -				dev_name(port->uport_dev), dev_name(&port->dev),
> > -				dev_name(&cxlsd->cxld.dev),
> > -				dev_name(ep->dport->dport_dev),
> > -				cxl_rr->nr_targets_set);
> > -			return -ENXIO;
> > -		}
> >  	} else {
> > -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> > -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> > +		int child_iw, child_ig;
> > +
> > +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw,
> > +					      &child_ig);
> > +		if (rc)
> > +			return rc;
> > +
> > +		rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw,
> > +					    child_ig);
> > +		if (rc)
> > +			return rc;
> >  	}
> > -	cxl_rr->nr_targets_set++;
> > +
> > +	rc = cxl_port_add_target(port, cxlr, cxl_rr, cxled, ep);
> > +	if (rc)
> > +		return rc;
> >  out_target_set:
> >  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
> >  		dev_name(port->uport_dev), dev_name(&port->dev),
> 
