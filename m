Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E30273FD
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051635; cv=fail; b=EGDDFGR8k42Ce+Q3ikWx1Zu3P+aEh+Hri+/Ju4OBSKgeUf8TKG0kVMV0fPGhWrUVNvqnTJN3TNISt6hoiU3RyUue+SSbjxHz9cqFbfzxGSTLMQi4gkmYrNUgrQTo6xCUm0VQ9Dcl2tlxpjDwAq8csOkJF8dONvlmk8j+kmOoUDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051635; c=relaxed/simple;
	bh=jZeeFpl63+td/j3OXB7R3J4V3+wtdnCxadKo2KT3Qk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FgkLwvtILrvCTU6uiK7aSNx0mtdNlZ9Lpcs1KxG+0w0RwG9bT5Pww5IRO6Rq8GWvRv5WgvaAUoxnaoVwXOWd+pX0lW2BEfEoMjWqIMcyoP+wpAGoDIcd5JC2EF3sBlCCSidNmBTck/bZpngcrMYfwGDynH20y0JX/u3M7OMrNEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGbQrDpy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGbQrDpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755051632; x=1786587632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jZeeFpl63+td/j3OXB7R3J4V3+wtdnCxadKo2KT3Qk4=;
  b=OGbQrDpylC/FUCALw7HDM2oHM3GVusiQcWcb8/M306K3H3Gaw+Pr3KiY
   BbfMTdaArAmkJ0V6xrmre3DizmzSKWxc2Nw87C4VynhfON4n2WJ7azHda
   kGuT6q/XpWAMysxNkRWU/FjOrATTrgMtzFjMKnYI/x9chXLulHj58eTGE
   KLIQ3yUjC/+Zlzp8XhLEvmkC2JMiadTFj8UCmWxTbEI65RH86qSEXTTLN
   ALuV86VtXK/JFerfCTZZ0F2P0tTgsuJBKxdlZvHNe6Z90T9nxK+yuTyEJ
   WqFZYkxZavxQev22WgTzGt8clCLUWTqad1Qv8EBOmcprLS3HS2cN71zrM
   Q==;
X-CSE-ConnectionGUID: XHe3lD9STzOcGpVSHptjcQ==
X-CSE-MsgGUID: HVrdjHlgQvqva/s0HsB6gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61138414"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="61138414"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:20:32 -0700
X-CSE-ConnectionGUID: u3oJDpvxQxOmfTftjMpZAw==
X-CSE-MsgGUID: 5EKYMA6cTbSgQ+m5C4Lo2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166719503"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:20:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 19:20:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 19:20:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 Aug 2025 19:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlpVwVKYhtZtLuAw36DOPHueVsyQ7a09vyvQSvOx6G4iszdqihWAqdbIVeaEYH39wtBHKdUEImXxWr894RqivfOQobyyDGW9PhyU71bIl6KzKtNZUsYMsdFtHCQKasWqhnFDhdAVf41RSr9Q+qk5GkipPCWN8b5f/3J+NlRpWYK+I515Ya/ouHndtiHxHEAUacV0s7od2Tah5CorU5gip9Z+Gv/go8MF1Xe1IKKrPShQ/zkSgC/hBAQOCgqP24CmorYH+PLD9GJ8GJVJ3U1ttkhk3cs2G4PN9z2o6nhKZInjN6PfI+an3foMC4bIkc3pAPPaV8f6IWmnYhM5/f/Ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVP7bt4Zbzs0gwcFGaNyzFRc70N+IItiVmgwQyeaD04=;
 b=n2afY1ahHV7UZq3Gwp2H3wgzT7YhtD48Drp9JYQYtoF+77olYpckyaQSLbixV4N75Jt1oDkk/sIsnBLt+KRJXU8v5r70Dw1SEjB00qOyvzFZABDrPjR1CSv36NYr8HARUwtZF+sMm/gDwLQm1sNhhnkv6B7nO1lAEthW9UKB2HzzsNBVVCcyTc7OfGHw6P0OYrf22mIIUOy/UZjMXVWN1Rj4UJ5kDYZPP0uLGLknIZuBPwAYbGg7GwLuZ5HLnMFBSn0H5GezP2kpCBj1yoInHncvHpvQT48qcm+F+3G0fMndWRw+2NcNK96aQRbyj1xVIjvKuTxD9BG5waV6inrF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 02:20:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 02:20:28 +0000
Date: Tue, 12 Aug 2025 19:20:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
Message-ID: <aJv2ZYOOw3EftLGQ@aschofie-mobl2.lan>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
 <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
 <aJO4PiyliQiJpMjO@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJO4PiyliQiJpMjO@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d06fe4-a91f-44f9-e51f-08ddda0ff88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21lh5ETiJA4evwzrHo2js0bTjl5Ycu8+wkc407QnhNBDX+wtA2Ge4p7xnOWz?=
 =?us-ascii?Q?R+bevb9yV+8tdVHVcNXUNwKCiBGqFtHYPFxZKUoEuQZrVctKiVZ2pz5L3tLE?=
 =?us-ascii?Q?wxOI1Lpz+dP/M3UDSNs4siHiO62QkF1+1f2Rs/H+2/gvnsIFaZwIi4qtV56L?=
 =?us-ascii?Q?KnFYsY6bz93xW8H1mMCJcOZnH+/REWt0zKWbunkoOMf8kXVN14cX64/UewEE?=
 =?us-ascii?Q?qJDZdsacGz49DP73XbAENiSqxu72N5Vy1CCHjNqXAq6gLeuu6hveSMVBXtTK?=
 =?us-ascii?Q?qcdo82b5XjntZp+ryBGSTi6GrDHrv7H7RQKSUpD7ctDCG9+SATVC3ta44gFm?=
 =?us-ascii?Q?le6jhkcyGdl21jO6bZcrFC7bWiPJtLurK5AZSQbK6enrKqeT5r3N+slwOkXT?=
 =?us-ascii?Q?n45Nj3HP/a7zUPep2zjmX87hibmIJiQW76TZ1TikWNMVNmGDTUNUqKTDR9RI?=
 =?us-ascii?Q?3rv7bwxIksZl1sy9ojniCJZ1BOURpBqO3ACQG/ZWgA+UoDgpCywrRi3TraeQ?=
 =?us-ascii?Q?1wjbAbr23x78D1FayIQQliPKGbkgP32WmXYf9l7jqEJVx1SqSQaOsNsSEyur?=
 =?us-ascii?Q?D8+mD4Fn+St71HygRHFnWG3KifLK10NxI34yUpeVOUHX2N35jMWFzKtYKE5c?=
 =?us-ascii?Q?V66ldf69WMMKOPX9E89yQzLfQGtL3gXF0h75PoDKzJcs4K1RoeVZEuFH/LnO?=
 =?us-ascii?Q?OJGmkOC5OLhHIihqdVHCi71y8rG6XcoOQcjC+PSRGBo9KquRoTeeqLUjkpSB?=
 =?us-ascii?Q?a1vDbi2/eDSObR1YoDyYTqUyBvqbgzSoCEB+3lQJwtA/RE6j0XHRUADieEsN?=
 =?us-ascii?Q?PPt6Rl1W6Ozm30Emz4TbDWbrXCNB8/23Ga7uqCRbW+pRmxLSk9ixoqIoRZt+?=
 =?us-ascii?Q?QGlLYl0Y0QwPYxh61P33hAC3SL8C2q+39fm+VN6GD8X/ojvikIj75SFXdBzT?=
 =?us-ascii?Q?xIiVYfivzU5MIEo08kZlg3LEo0iEnzdDLTESvaBnSK7jtvDCxjRHisTLxLqQ?=
 =?us-ascii?Q?jENbskHeiFR3hzqm2wN5aDEwfhQfngea6LE5xxDVQo1RLfg+V3h2tqopnXfq?=
 =?us-ascii?Q?y7TMBD1j6iuCzboBHIAXhKGMO7h5wvsrFiI9/aoSgyzlYhDMo832TNhvfD3u?=
 =?us-ascii?Q?jVQzwkgjcuNIZuuDOG6+dy5XmKTjl2MV0H03g1fGXJP06Blz7Q5HZFuS5gtE?=
 =?us-ascii?Q?jVnCTeV/UECVFCCawYtI/ipc7XhUJKEC82LJWQtxEl94rU6e4G3bpLVu53b8?=
 =?us-ascii?Q?8xzXvrR0jP4+sBNJuJoqdycJOkJPeooeGBTWyDC48wE9+oPFl+00Vku7s9Lm?=
 =?us-ascii?Q?5oJBmZ/Uf4Xp4FjHhXo1zc5JgnkYqLDHrtTKSGWxFEC8x4kDsx7xT6M4xx4j?=
 =?us-ascii?Q?Eug6gnLY7tlzswzOXujcStdpNymr7+yAvbiivGm0agiwd5UvbY8BmWqaUMfu?=
 =?us-ascii?Q?PCs4RWQorlo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XL6MEDBZgjzTOY++z0LHxgPSnEJKMLLYG2FkxOMWm87a8U985YXa8Ji+AmIK?=
 =?us-ascii?Q?YpQmxFDv8JaKTYPGpmmhg5o8G4EdD1dbJX3gT1pGmZgTy8tFVpzkCj1+qLBs?=
 =?us-ascii?Q?qRe8wl1YZewr9+iQcqJ3wwNBfb+Dhytvz3UegJrOeCcKcrAaybQF8BiVjuwh?=
 =?us-ascii?Q?+vgwGMZQ5JJn2XX9TnCB6cOeX6oVA27B56fj3Qvv9U7fedPU/F40tT89rvJs?=
 =?us-ascii?Q?oSEPmqB+QaUp23qSyI5wM5/+brsclSBKj1FYA42BS7dnDbbH31X8fnD+gMaZ?=
 =?us-ascii?Q?ENyo2l/43iuU0CAULU2Naw3geEsDMr4c9Wr/LOHkYknUvk5RvUGxKpvt060c?=
 =?us-ascii?Q?4f12jOrzC8MKOZVejysjllxCRmWXqmu0pbp+nFOEd9YILJJtQpeCcRmGMoa3?=
 =?us-ascii?Q?2XtOIo3VzryiOF3Gy2kviTS4SODSz+NNAyAmDfHk8u9w5MuM9CykYoOUWqH2?=
 =?us-ascii?Q?l7AA3kZCdby12bcc2CaMx7OEYxeXNn3rdelVG5zbac+GqzmA1NhtbcQFitaE?=
 =?us-ascii?Q?XUL3MtyARZopYiEZwIRwvS6U7msGTi8aJ+MV1HQ2HL3d762rvD6BRr9l+q/q?=
 =?us-ascii?Q?EEn9nsaLahSxPVIu3uHdvuLyARwv2GRYQWyM1D2R+V1R6RJPcC+IKt8IShoa?=
 =?us-ascii?Q?qndgNhzGkH05wSu+F0Ets8mwv2+7p+YCR6r9vdwzX8HxFOpIjRHjCAHWyfzZ?=
 =?us-ascii?Q?WSFOXHESTfBSfmfR8AVlG1/cCikL2KnGKkTNFmG5o7GdZuC2nhrAH7qe8ynF?=
 =?us-ascii?Q?fRuc/hRQ2enGZwbcczuUWllZ5ovWvskG2Ui7tZ1gxKmuDr+YHtGD5UVXXMne?=
 =?us-ascii?Q?v1CZrCC4d4cp3DzaB8lnKTbogwe1mCBNLkncH1RN7jJJjwkrKZUSr488y2AV?=
 =?us-ascii?Q?2ChcjS09NoaFZEH2Y1paqcsugqNpSCos5x4XCjbKaUbAunxRXw3Zz2JmnKQV?=
 =?us-ascii?Q?H7GpN0CGxNSdcD5iXPWxY9cZC+zdqZ+Wk6te/uCwkIN0dUMxB8cue/mtR3RW?=
 =?us-ascii?Q?53pUOdvXcMP5Yyq7LtVMs909wXQqxHWz1VfeiGHr5fRUa75kCp4s3EiNlMSQ?=
 =?us-ascii?Q?9UzQUiYW+4sbeQE+zOc6yPzIDpBFB4fP2sXrDaS1dXp/lmQ6Qm8lvaBJWfQR?=
 =?us-ascii?Q?WJA/wFHTv1dJvtc1nxrB5hPqdWuFZA3s5WiRhiDuRmYDbQX6yqN/7ftJzRra?=
 =?us-ascii?Q?MJbqt7Nrp0d1+CDesgEqaB4SgYNJ87ZThJ2dqFy438Js+TOu+aM+ygiDOYS2?=
 =?us-ascii?Q?gLSqGwtM+oGLrYm0lIV1WWQEhvLknwFRfBL3U7KUj4Fd+yUYluYzIn0klA1b?=
 =?us-ascii?Q?Com2g+v6isbmk+CazeEnGdTSEeNV8M1492h/daBcOMFs7Uf+lHsC7BvbKPo4?=
 =?us-ascii?Q?gwwJaTPP91C4gaxcG5QLTimbrBznhhJaPRYw3N1jOcL2vXT51AdalRPkofy9?=
 =?us-ascii?Q?F0fM4n+OSUzglQcq6tgq1V+cpTOggb2nXNSnSblkAqVXBOZFX+F9PVjP79J0?=
 =?us-ascii?Q?4wmCXf0qrG/b4reUPeyA8IFpB8xunbRPr4xDy0BUKlDAueJxihtg2srDNNg+?=
 =?us-ascii?Q?12omnlENAPV8PyP0Zu85E+zwaW57x+1m8H4rW477v3ZGtF00nVW2oucJRexT?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d06fe4-a91f-44f9-e51f-08ddda0ff88d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:20:28.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwTTReWP3lB7WCio7IdoTaK1fqSRneDvU5pvD4+lqIPhbb9GhHWPkxGxNctn1n15ZYDx9eYyl8lHQFRCl8bzvauvnMoNvrbLEJZTi+tAMJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

On Wed, Aug 06, 2025 at 01:17:02PM -0700, Alison Schofield wrote:
> On Wed, Aug 06, 2025 at 11:57:23AM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>

snip

> > > 
> > >  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > >  {
> > > +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
> > >  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > > -	int hbiw = cxlrd->cxlsd.nr_targets;
> > >  	u64 val;
> > >  	int pos;
> > >  
> > >  	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > > -	if (hbiw == 1 || hbiw == 3)
> > > +	if (!nr_maps_to_apply)
> > 
> > I wonder if this also should have a...
> > 
> >     static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
> >     BIT(8) | BIT(6) | GENMASK(4, 1);
> >     ...
> >     WARN_ON_ONCE(!test_bit(cxlrd->cxlsd.nr_targets, &nr_targets_valid_mask)));
> > 
> > ...because I could not immediately convince myself that all callers will
> > have been careful to not pass invalid nr_targets?
> > 
> 
> Here I assumed the only caller is the validated caller in the CXL Driver.
> However, in the patches that add testability of this function [3] I did
> add guards against bad hbiw's. Let me compare what you suggest here to what
> I did in the later patch. I did think it would made sense to add the
> checks in tha patch that exposes it further.
> 
> [3] cxl/acpi: Make the XOR calculations available for testing
> https://lore.kernel.org/linux-cxl/e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com/

I took another look at this and see that the pending test module is
not the only caller to check. I'm thinking the check should be
at the time nr_targets gets stored...like this:

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f36ff413f5d..2784255e7811 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1777,7 +1777,10 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
                                   struct cxl_switch_decoder *cxlsd,
                                   int nr_targets)
 {
-       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
+       static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
+               BIT(8) | BIT(6) | GENMASK(4, 1);
+
+       if (!test_bit(nr_targets, &nr_targets_valid_mask))
                return -EINVAL;

        cxlsd->nr_targets = nr_targets;

So - you'll see further checking when these are refactored to support
the test module. The above fix to cxl_switch_decoder_init() seems needed
regardless of this patch or it's future refactoring.

> 
> 
> > >  		return hpa;
> > >  
> > >  	/*
> > > @@ -47,7 +57,7 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > >  	 * bits results in val==0, if odd the XOR result is val==1.
> > >  	 */
> > >  
> > > -	for (int i = 0; i < cximsd->nr_maps; i++) {
> > > +	for (int i = 0; i < nr_maps_to_apply; i++) {
> > >  		if (!cximsd->xormaps[i])
> > >  			continue;
> > >  		pos = __ffs(cximsd->xormaps[i]);
> > > 
> > > base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
> > 
> > Feel free to add:
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Thanks for the review!
> 
> > 
> > ...with or without the @nr_targets_valid_mask if you determine it is not
> > needed.
> 
