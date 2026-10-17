Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5995325483
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198671; cv=fail; b=rtr0xcx+rrK8UEvovnC14ZU0stI2SpOMbCmYCXSJ/FzJs9Me7Ok8PPDMeMAsoYON3i7MBQP7ylYJuV6zsVUGLkuPdUOa6bL27oyl1/EhjKW29KAGkaLtMw/QLj2DvvKMSDTX5DctcO645prQ+RYHIxnI19QWqaqSJDuuWKuC9AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198671; c=relaxed/simple;
	bh=cP1AzFwLVGyqn0cPRS6bCU400iAYEujmpLHb+psJp8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GL7NmOjm1G30hJDBwjm1Nqq96rjPorZdefWqxBp/z5zjeHWgw97vtGRSrTnm6mRkI6jHvbtrgCjxMbDHYmYn/cDO5JDn06lgkAuNRF5COXPUF+Mg7HNTi9tQ7O96SQGi9TDxVmPODDKyU5lvxgqtNFxye9ZAjiezM7U2HAqDQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLwtKa2k; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLwtKa2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792198669; x=1823734669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cP1AzFwLVGyqn0cPRS6bCU400iAYEujmpLHb+psJp8I=;
  b=WLwtKa2kN6jz6IoaLyJOjYQZ9k7qMXP8EobFFDsQrDdtTsYV2ke0+kaT
   xJ86ljRVrIUnBZxF3Ttku0VmIvu7/aITWVO4gBs8TM/IYIzrZ40F80Iqw
   PQ0L6eq9Lw2o1Z4njyaT69SkkEECN04vsmWt19+Owltbhib3UPt/Rmygr
   b6aflfZ6RbcrVa7Rt1leub7fGG3jAa/FlkXS80sF40yxsG4fmhfHwCp8i
   jV+4Z7R0V0qKOKpeuCxVzx5vIRya0uY6MncQU/NxtQsW/vVw52Op/jQVX
   WvRWksbhiatDYojySu1ArLG3KpAxWV7U+wC+m8FGE9fPckGmOpshiDvdd
   Q==;
X-CSE-ConnectionGUID: vhgSNynwQyetMZIzUFb2ag==
X-CSE-MsgGUID: yAVnA6GURrS66uiGJDSleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="999217"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="999217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:57:48 -0700
X-CSE-ConnectionGUID: Iy7ZZF4SRUej4QLi4+S3zw==
X-CSE-MsgGUID: 2GFPVKBOQtS2UDhKP9LrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2542892"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:57:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:57:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:57:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy87F+Uky3y1adpbrQi5jO0BbF9Hu9+Yg3i6LP9vB4cVPtrVMGVWKffExOzCtXzxYG/SeXNIIdAJlneJEoBFv0FFfLYlyA+SKm8rt9Vh4Lf3H/VnIKoHyGr2f8uwwKvFLiM0pH3wrCV1isIT2HVkT0suQc5smXDqiZVVMIioKLcf5oOkDig0vyyAacmcEME/6cLYPdpRV8PqBRZhDwDGTPE69Mlo2MC3wPaVKIpcbk67B4YHTyTjZTol+wE1j+achuRa0HF03qnW7I1BTXVY896nzPqdIuAdrC5khJjWxp8IisZxFHGdTT6RJsAzRJzASoN4OZTDq0ikduGH6vva0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qt74MPSAderEnJ8t6JrXXJlN39P9tkOBwPmPxuVfBA=;
 b=X1/KglxGYEOTm90JR+dgKzLxR+ck513MFnd0UrJSmixBAgak6Qnpby4xt0Pe4HzSNMeLWh+bSGk7rdIeHN9U+WotGu0k+7sTTKp6zn+JYRgStVgcOoi+VFJUz8/13P5rGc0wnLxFslt8CcxZ5pHXrlmpjvKiDthPZnCV3K8vRv2/QCTDWD0x96jY7yJS8q2nYmfY70YdOOPG5X2jNeL97ftemPKDaK3VlowKv3n0T8kK8Qx09/0+N/c0qAYmXq7aHnZcTXxjfBk/rP5UvlJKoliRbBhIP9J73quBsw3s2/lzQv3XSPZn+b7pyu45IaEWsf1gW4PmUmqDe5STG37z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFD83941681.namprd11.prod.outlook.com (2603:10b6:f:fc00::f55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sat, 17 Oct
 2026 00:57:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:57:39 +0000
Date: Fri, 16 Oct 2026 17:57:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] cxl/region: Factor out cxl_port_setup_decoder()
Message-ID: <atLH_zfYMgoleIp8@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
 <20261016195317.00b2c5b5@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016195317.00b2c5b5@jic23-hlaptop>
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFD83941681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2ee523-9a40-4895-e3d2-08df2be9a449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|22082099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: j2SfRmmfLfmlKI4tdQxP9xxB9vnHXGL7xG8HI45FnCu04rKcvUJk04MKoJT0e7yAxPjZnRcybk8ePgBuPjTg5J9VEU3UROpyVZ4YfqGTjSCHx0v2SRnJxGrvGpWP5NXmjTMeTKwQfoNsGME/He4b0ntaCHxdzQ7wQNyvtPnmLpFBgBDPYbyh363N4M6nREflgGjpJU19SXbXWm+BkRv/AZRoRPRk35Dl8omXyt2H/oXcTMghQLdbg4VwWiC2cEhmC0/j+e8g/nPQiL6JZO+cI19juw09hunXjOR8UzfgXtuzRxht0WzrbxsCPXJQCEaziwsO0OxS3ijDJF89EkfWjiyXiZ7RUOcNciYmZvzW2d1mmtRfmL5Lh2Dh3oRp79ndgklTh6wUw0sMa9X9xVT4X3oCHWjY4FrE9Hi8ozkilySA4NPoJgrvhp5Jb2uQW/Rb5qkIeX8exwJ3zmZQ+wV+DbNWBH3uBl9zM0sKG90Ydn8dReSsAD6nrm14gNmHc9hccHo/iYP3/DeB6AxpnXtapvv1AYkkQfItzimIcI7D/y5X3LKlQ8Lh2X611D4xbGIOBW9gdmJC1h3vmJBCRfvOdHsKtEHrB5HdmkHeOsROA8lUTizVbd2SeD2nZcAqf3uVLfuoy985K7y4LF0xk49NxC/R5n3mhDyamZIhQ0QLcLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DG4aDOggIOCfzgowCwiwI6HQ2SwxMXjJFr83XED2E1oIJ8Kz/KSMUeBgstX?=
 =?us-ascii?Q?0mDUyYiqr4Z7POG4zZBdY4pIesHbGD8jmOp87+R66Bf/aiwtXQU9FlJqRhpA?=
 =?us-ascii?Q?CsxJed8ekPUMMiUtNfWEuCY79UzPjy9Zq71aJySQCQHn+yNb7goZNO5vKggY?=
 =?us-ascii?Q?7U/2RpTbW3cz7ZbCcr9lkNBIElN6FV1or1eOY0r+riLnSFr5JfoTDslKid5o?=
 =?us-ascii?Q?5wIavuwFVH+kXl73Kicxu9EKAm7DUhG2aBbqtnmk/K5LEka5maKfitydIyT3?=
 =?us-ascii?Q?bWPzDPTZZGQOOy0vEl0ga/3Cg4vNbJQYSgNRHJkbwheEGOBbdBuW1vPUABMV?=
 =?us-ascii?Q?bQyyjIyZsnwSr+AhzWV3tjfz/KPbrzay4KD49L0NLCGCZqFMgzoQL7XJMfn/?=
 =?us-ascii?Q?JwS+XKHwiUe73LXlhEJM/FnGAasZE5dwIsgxP2t/VwoQ298t6wF+YEEW3WxJ?=
 =?us-ascii?Q?L21N3yPkPDfyQHl1Nc4ixwrfQ8KkN6Fr2wJz+oSCIwMA+YM90kvu1UoYVlL5?=
 =?us-ascii?Q?8TNCzj1PM8qCxKHTNv/a/vDurMCXDgLLW5OeTpMFfcq55NjNjCeRdQGRkiiq?=
 =?us-ascii?Q?kJj/NDMhinPiAJ6XYBV5UPPRTo1AfaOUb6CaT/x+gxFkd5mxfbsmEwN/CFaG?=
 =?us-ascii?Q?/Hjg7RdKH2T2rOxq5ZGGLTCvwOKsnV0jqczDXpW6KCHRuYhCbfoOxVler7Vl?=
 =?us-ascii?Q?k/LfW7aaht/hNyudZT1TiVw6usT2Nz030I9Iz0aSn7mEw5n5Xw8YMUU8WjJX?=
 =?us-ascii?Q?LhgrLmXzgt37j/lZuPNBQla8MdWIh5VsNVugD35iKzt128ZqfIEvVfCm1ZOr?=
 =?us-ascii?Q?U3ik8tyGy161RDVfjRJaIzUlyldm/zYT2OLc330TBCFyJMAguTpDyAFKZQPa?=
 =?us-ascii?Q?/tNTAtEcB11XO7O1SK/JJBqlbze8M+YunqYmIGki4apmdCSu5YwVIOCriGuo?=
 =?us-ascii?Q?mpi6q6K6ftnqCmMriQHcLGHaKO+WJ1I9Jgtv7oaSzvEy/flmQ6QLVLdgpU7T?=
 =?us-ascii?Q?w6npz8YF/39owSKsGRZJxOZoRXAUsqfNhw7HSqyZgkLYHJjWC7OcLYxowOMb?=
 =?us-ascii?Q?NvUNewxBd81UuUHqF+KvwquoljUu88xOtji/WLGrEpfK2ljFIeGITgLzwJ1b?=
 =?us-ascii?Q?FsZwI+uxjorhRJ0ofR7M+Kc62GNJikNhhqNs9CaCNmM7dPh1AcQ5RqZcjXYW?=
 =?us-ascii?Q?xhL1MgtDrj3W5fzFDdCOX43Pqu1BJxJlGDcirEQY6IEHQCH5WjRSxfA6Kza2?=
 =?us-ascii?Q?d2x5OqmGpxl8kS5iFT2eel6F1zwg1wiQS+u3EgDHDuHhiawTAMPknlN2nYQE?=
 =?us-ascii?Q?OjbwhuCEnB36mJt5YVDVPuL0fSj+awCmIw/d725xk0c0cLxM+Urjkt9O3nF9?=
 =?us-ascii?Q?YCt005dJDisLd8/uv+akcK8H9sygGNseiukHp2LbtbnAnQLy9ptReqmAWj8H?=
 =?us-ascii?Q?J0HQx4qpWDiPT3sPqFNXlV4aM5L0tK2IPaqqky2kWggnmUy7zywfgs7SMuTU?=
 =?us-ascii?Q?dOaMVh8ykFFOGyxjEvn5JHJVnYF6jJK0CO3rT7naIosvRCPWa+1wa/ZhxWCJ?=
 =?us-ascii?Q?ZvBhFCcbXrcT3Sog1atMLu5eFHox2ms2cLfa0uzEYiOnCHNCWOI9NB5GZ4aW?=
 =?us-ascii?Q?Q1D1hNhwopTH0iVuep7i0QabIcHXbABeGFMh5W/dd3H8Ik/+SktHLUQAil8c?=
 =?us-ascii?Q?p/rXjIXiHOZ55TgL1EM9PZL28PuYVdd+tQBFUxaeJ00CTusgiGPYCJFKdAuc?=
 =?us-ascii?Q?xPDkcc4zeugoOP41MlPLnxccN2FJJX8=3D?=
X-Exchange-RoutingPolicyChecked: XvxmqO1jYrpYbDvVpn0nQj/S+1BGVgnt2GEQ7TQpuJofzXOp4YIV6XT/f237EMX4bu6bxXApcvln5V/7iZ4/UHDnglIYAKloGhAMb/K0PvXdt/0YMVPdnNTl3N+2tPAKlVB8XOZf49uhvRN72cnd78q6fh0lx5TmbVmMu5aTod/RE9hNg2OZI7k2qSA597ch7CoUuWsvqQFzGX7uIL1KhrA8DlD2W8m+TTiX9Ds6F6geVSX/OzGmEK8C08zoSu1il+X+iHyruwCnO8clkzqkzUMbdT/8cXC6YhXGA9UfeSpv4ws8IMdBmpy2FtFc+iHtUyNP+8Mf89rjspum6zINtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2ee523-9a40-4895-e3d2-08df2be9a449
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:57:39.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cAmDnikyZO8skA/xejPu4l3U1gFYnpShJZU1iaL0jWnOjgwQ3XG6jEjPxLDraGTkS7co3Hh8d8wMvL4LRgwCrCFHfMhcb4iIgvSDNl9RVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD83941681
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 07:53:17PM +0100, Jonathan Cameron wrote:
> On Mon, 12 Oct 2026 21:26:02 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Once cxl_switch_port_setup_targets() has calculated the interleave for a
> > port's decoder, it either checks that interleave against the decoder
> > settings found for an auto region, or checks the decoder's interleave
> > capabilities and programs the decoder for a user created region. Both paths
> > are open coded in cxl_switch_port_setup_targets().
> > 
> > Move both paths to a new helper, cxl_port_setup_decoder().
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Maybe some further opportunities in here to improve readability
> (using Ming and Richard's suggestions)
> 
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  		if (cxld->interleave_ways != iw ||
> > @@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
> >  	}
> >  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
> >  		dev_name(&port->dev), iw, ig);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> > +					 struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int iw, ig, rc, pos = cxled->pos;
> > +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +	struct cxl_switch_decoder *cxlsd;
> > +
> > +	/*
> > +	 * While root level decoders support x3, x6, x12, switch level
> > +	 * decoders only support powers of 2 up to x16.
> > +	 */
> > +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			cxl_rr->nr_targets);
> > +		return -EINVAL;
> > +	}
> > +
> > +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	if (cxl_rr->nr_targets_set) {
> > +		int distance = cxl_port_peer_distance(port, cxlr);
> > +
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> I wonder if it is worth taking opportunity to flip things:
> 
> 		for (int i = 0; i < cxl_rr_nr_targets_set; i++) {
> 			if (ep->dport != cxlsd->target[i])
> 				continue;
> 
> 			distance = cxl_port_peer_distance(port, cxlr);
> 			return check_last_peer(cxled, ep, cxl_rr,
> 					       cxl_port_peer_distance(port, cxlr));
> 			// Ming's comment and Richard's patch rolled in
> 			// The local variable ended up ugly hence inline unlike
> 			// Richard's suggestion.
> 		}
> 		goto add_target;
> 			

Hi Jonathan,

Thanks for the reviews and this suggestion. This change landed in a new v4 patch
'Simplify switch port target setup control flow. 

-- Alison

> > +			if (ep->dport == cxlsd->target[i]) {
> > +				rc = check_last_peer(cxled, ep, cxl_rr,
> > +						     distance);
> > +				if (rc)
> > +					return rc;
> > +				goto out_target_set;
> > +			}
> > +		goto add_target;
> > +	}
> > +
> > +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> > +	if (rc)
> > +		return rc;
> >  add_target:
> >  	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> >  		dev_dbg(&cxlr->dev,
> 
