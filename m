Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407012FF9C
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249296; cv=fail; b=hGcSunZE0cjQ8hLxRDUatq8/6t9PsDQTyPGcYQgZwSni8nV94by5vZUvX7AP5gUpAQlEcJc6Mfmbwaxt/NbNQ9+Usjov/G55LE6laDiFWc3YZN8h6a+mbHRGUKZdcqE6P4ynGG+v4JZIaUD2jE1O/alDcjxzts+gPN9BNUudRGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249296; c=relaxed/simple;
	bh=s5UpMwW7BoEahgv8WND670K/XvsEeE6Q3vkQixNgrC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ubI96mANeJuA6wwEDlhdH/SIEHj8UreNyFYCaKjZ1sXS50ujQqjYE13MNg190gix3Mx8jIngBlpK+Pm+h5ZASHPVlPHn76Q9oswk6NypocmczwzwT/nR2S2coPbXNgSctpAjSuZDhSFAnLTQNYye51RsWn90hA22I+5JuhGxLYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG3sGZj4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG3sGZj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249295; x=1749785295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s5UpMwW7BoEahgv8WND670K/XvsEeE6Q3vkQixNgrC0=;
  b=nG3sGZj4cWXPO9SmJhyybaaEH9wpwGM4lgZvDOE6Fx+gYQToHzHD/R3D
   vFdYWRIcVTlMDALEPtD8ZmjlgfepQBcDSNVCkNNwk6qL8vHidCx79h5fO
   oatOxV50F20mmB62RfCy1n9/Dr21D/RDxkmBQLgm3ebYxLCmr90Q0lRuA
   xK8k8gMJtaL3vHcDi/8BDSYy/9RsGLhx3Lh6w7+2JBAMCLJTYBDQvvkId
   bpnqLvBMvxgQwb2VsIz9geNIkidUdpXC0qFlDfdq0V+q1xnbQn6ICy6ra
   rBC5JGj8x4ao/6Zy7HkfhW+YYhKkNScq/Oc1EpStyTv2THt3dVOcklLaG
   A==;
X-CSE-ConnectionGUID: oF9kMzOgQ+O6Q5Rw6hsvGQ==
X-CSE-MsgGUID: TVBxHbzaQoaySJiw/MgBxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32587786"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32587786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:28:04 -0700
X-CSE-ConnectionGUID: Z+XhixYEQGOVXnxnmWP4OA==
X-CSE-MsgGUID: tILO8LieR7CeJTAx5IrsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40099115"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 20:28:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 20:28:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 20:28:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 20:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq6fNnF0Ch1byp3W4FVyQAwr3x1UyaGt0zIM/ETxPGy8Fthw8fo3NOaG1q2brey7tSv4mNtT1JGM69Nlq8le/evzoF9P3cWqS2oaznRsvLQukdH9tHbh6iAWRvDX2Ef0qtMVF2YFQDQ1vubGnv90EzYtqYVHb1XzP7vD3tb1jP7U2VCwoQBHVnzp8iuY5+8R9n6fQHyV4AijeigeeCq5j2iemF3X74wu4H2xOwe9kf/r62EoYiLbFfGop7EAt/9b7qbPSS8EX1gPyFNIymRfA53N/9eEwF24bBSzfLDpKTTveepnTI1sxhpPCpKBZEYJxmS6H8SMQEw8SQVEA5IROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPuvi5nAVyKH3FrXSdDTQ750AlosGAdvvDsgK5osYnE=;
 b=JKNjvoEQeePbbHtnb1XwJu2vlxORxQ/2T5RDBuRPZjtBtb62umZFF7a5OQsgRx0EoBMV5YTPnonT2p6SmC7mrCrTQA137kyU7cZNrhTbHf3uEa/UdHXwPyDfGySLBDRl54P/2mcTJBSdq8zTK7y1XtT/yPuoN9guGlep7VoSnYrfvbW2Z7bmJMXq/Cibrw7latJoDGvJy3GMYBFHOkrTyPC8l2bJw0aaAP8SLWmU9PGbwcT/LPLP5Q5TBJnzRVFsyySh1OdUrTnKN6qWS5IHPAH3h9cQPlbRRVvDz9vvLDPXEBs8hQeWFKrFZbkDdhk+R5jHHByVWmeyoz9uJDAZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 03:28:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 13 Jun 2024
 03:28:01 +0000
Date: Wed, 12 Jun 2024 20:27:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7] cxl/region: check interleave capability
Message-ID: <666a673d8e0fa_c79a3294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
 <66691eedbe8_31012947f@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmoZfZPcGNYCqQGL@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmoZfZPcGNYCqQGL@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: e135f000-ddb6-4785-9e2d-08dc8b58d437
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VlC4+46pYMMLfi4B7m7QZLOfTzJQHROmKHgW7IoiWayM5HFgm7l1Yv2qelHu?=
 =?us-ascii?Q?/juR05TZPspK9SxJ6Qw9xy0L8e96bND46t6GA2Ls8QutE264GYs6194BSDxc?=
 =?us-ascii?Q?Vcrct7zDgxlTcIqi09M8fbw43SYafZLIN4JOHx21pk86ogWpfSGobBq0/Glr?=
 =?us-ascii?Q?j+2y328Rz4qM1aG3Q5eXuSg4NgwgP1eQAovRMztvdusKXlhqDF6i+B8VF3QB?=
 =?us-ascii?Q?G1UrfiG05wRgh2U5M+toSQlFboiK2b6T6nfuJzfAMjVifGeIdMLYqtAa9FWo?=
 =?us-ascii?Q?XCVs1yfbYW8ouEWRzyw0MesuRu3xJtniouKgX03A6ZhFK62WifSrUsmM5XTm?=
 =?us-ascii?Q?N+9IaeCK9rxwWQ9aGxP8X4gsr0PgxXK4eYzg4rf57eZRLUN7oPfdDzPba5sm?=
 =?us-ascii?Q?rgdX8UxGn3Rc6OSihAqoF29GYVFqHDPNsTKqWqLYXDn6EUJb1KvtwTzkYReF?=
 =?us-ascii?Q?GqQ6c4FYQAWxXIFmKsL/17+Mr0oUjXXZND8mxvBDnhs4UOSaMM6VMZKfkaHN?=
 =?us-ascii?Q?0a7a6eee3m8Rz+n5yFPMThwhKM7n0TCbXOzG48KycWuoy1E036j3M5DQNt+S?=
 =?us-ascii?Q?n/IGb92MtXpagv5sxTPHWwhHL3BZn/0ViMnsiUZubmbI2GE+P+y8Onm3CTQ1?=
 =?us-ascii?Q?uEkSducM6EosnZ4RY3BmKEKR8wm6qxdp3S7Ys/q48nhHkdCYHX/1iy9+1iTT?=
 =?us-ascii?Q?2aK+Ow3/CMNBV3FwxCIg0H4xfvqLK+n6LXMFJBsgCBHomcgvzseRk9icFKfg?=
 =?us-ascii?Q?2PEQuKy7gPZb6LVQ3lRkNbeKgxsldgCwfYtdOy/HjFbhMlNVNAZcrhaDMUta?=
 =?us-ascii?Q?AljBjqFHTMdamlV3phJ68PguuA4Ylso7DqOaKoyyS3MLDuC4e+/tziNiMAdn?=
 =?us-ascii?Q?jvlvfmphgQzUxaYT28qRtYMg3AlPFy5yBvNDiLAoXtNLirNtzCMvLDx0FOXA?=
 =?us-ascii?Q?vf4d7Trciyaci8y7k4QM3Qr3sXzoNyjZ5hZAx4rrzy0jR83OlXcrP20qlH+A?=
 =?us-ascii?Q?X+u+kRn5+D8PRhlzLcmdfXJ3wXo/3pH1roHDoBm28NYmDzkLEuzRVFj3URxz?=
 =?us-ascii?Q?yZsbCWkct1sMOKzPdC+1ZixnUHauiofHK0i3Qz6v9Vi37P6EiteBomm1aXDE?=
 =?us-ascii?Q?7ottHJP39HTrAC8Sl+N+7UG2MkTLNvAu6DhG0CXnDoRcTlwSlXdydXhCEtGS?=
 =?us-ascii?Q?rYUILDe4k/7qeLaJJsGOTlVcQAER8if4q22FqpvVfuRYS78OvWftCqqmdKFJ?=
 =?us-ascii?Q?0C16Lcvx2ZQE3uiCDGtfxDs4X+mBXdwqFhrnj2nrex5oUj0ivpIbAuIwzOHw?=
 =?us-ascii?Q?Ko+g7WU0a6qYszIygppyGLlC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qtz2fUSoW0X0cZ77qL+Mv6Rd91lg7ImjcIpT9Ivj1V5k8yrBsRvK95XVRhDW?=
 =?us-ascii?Q?AQAXf1pXPi1e7KooDro+1ec1Pz9QaWuUyQ4wT50AoMOfyORirlTPiI/oWrcv?=
 =?us-ascii?Q?bLgTEAH0EfAjBcKCN+JoUB9cQ+fRGjAS+IzBbO9GO/5b/W2XD4qiFkAnYUro?=
 =?us-ascii?Q?zn844/bTRMJGiTVmwZwcJc88nVYIFbStHjWPYroFTjgCvi1zY+SMQcib//JV?=
 =?us-ascii?Q?BTBhXKJx67DbUiGDIu5HP3hm8uWSZdfqL0XljEGvYkXCqL3f65COrhEyN+eI?=
 =?us-ascii?Q?1XpxCt3nyj1L2lBUEBojodWmZSnnYJm61Rn1NxVWLFG+I08YLpLiKcfAvWQL?=
 =?us-ascii?Q?zLxB4fladjRMfp4bYN0/+llNHdunYO+I312Pgn4CYX4ZBsBqAQPdMNsdi3ah?=
 =?us-ascii?Q?4aYu+EuQf4979hku68VrEtQNzDQU32C0c8no1ZK4Tq++PU4pqOc+sAypEOmP?=
 =?us-ascii?Q?8wV6x3bY58JKgPh+OD2Q+ikhN8Jw0sft9KWOz4VyOz6N67hOBiO63AEORJnm?=
 =?us-ascii?Q?HetnYaJbd4FffStrVcVdYgbhhR+tJ8wSwraujDiTb3ttrAMEQc8TCyYSy8g+?=
 =?us-ascii?Q?nmSmRLVF2/QFLCYPNnISgOkf1fPmBtTFvy4WCqKgLFRjSR7LjxtlPmYkoBBf?=
 =?us-ascii?Q?LUXQt4vA5zRca9Jz6eGbwVXruBltCT4oGqEX0N4iuvGBb1+9AcpMTDaNvzbr?=
 =?us-ascii?Q?XKwfgMLW1nazAnpdaXp6/4FQer5qxGzm2tB3xxYygFdAkvJUlYJbTIGiVZ0f?=
 =?us-ascii?Q?cjF4kbAGQhqO8TxyjFoBbAqIAhUdVGqxWvgfpAs9KyPl+PfT+rRvMz18dnok?=
 =?us-ascii?Q?uP7x6DlJHtU7cKJepkoJwy+5BIqbDyD1zH2DG42DILJlhHNN5wNlNryJAzJF?=
 =?us-ascii?Q?5kxSAuoRunjnoH1cg0i2SsrzAPf2fgp7XeyEarDdOoEOdLkJX4yVZdB8Rv2e?=
 =?us-ascii?Q?lXeLAAf2JuruG712buFrQ048PMwjiD12ghdhzrC3qXI4215kA01ybhJT2FZj?=
 =?us-ascii?Q?RbHMpEE4+/rwYHPYNQ3MHOGlLg5v9Cl6/iS4ZgQ84LCRmhioizi1DE81mmkN?=
 =?us-ascii?Q?nF6GktfLQPY28zZoPMG4HjLw2bExG44tinUWz8nkhA9J3RgRwskpDM+KQaxO?=
 =?us-ascii?Q?LZwjOP+qgbQcyPscuStG4KmKVkGKuBG4ivH70R4eUlj42gfQ2ROmeM8+/v1t?=
 =?us-ascii?Q?1q0p7scb8YFW2MMeXwpgcnHADpGTZdJQ//Z9uU7vGBugZUnzaLUnHrNBhEt8?=
 =?us-ascii?Q?zkJajwT/PMRw83Pj0DQfKRGX5YSUNL6EjUs87NFe916LeBPVqnTdSDc3zwhe?=
 =?us-ascii?Q?5cKFYV3cixuVDiCAMK1+2K4pL0mam1cI5j3Ope2iDz4n4USnIW8XhY1IrUMa?=
 =?us-ascii?Q?xVK0netR7riI/l3vvfKv46RHVKOkeUXvyEoGYkfWDvM+/3QYcZ7yidS3WDJY?=
 =?us-ascii?Q?TNSNCdNSdBVO6LD8a1DFU7BhscZ0djojI7iC1ECiB+Z1S6rDUmSmCuyN6RJB?=
 =?us-ascii?Q?VHWuzOyGjE39ybo3iMT3VgEOv/Rpsn9lRLqtCtL78LPlHq4GVVLKebk3XL0C?=
 =?us-ascii?Q?/fJtWAGrZzGI/bcwD41ztCNEsqvG/uH6Cx7cDxdLyRF7oL8qxlMbC7k5T1rd?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e135f000-ddb6-4785-9e2d-08dc8b58d437
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 03:28:01.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcaJJ8SxRQ/19zDGHxzLloXPZ7ZyZoWqNiiBgg9DutVo7FleZOuTB/D1u8VI07zALYGduU09NxQ5K5Hj9buVd+P3sF/WKA8GlimyJS7XiOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 36cee9c30ceb..7fe617122d33 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
> > >  
> > >  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
> > >  
> > > +/*
> > 
> > Minor detail that can come in a follow-on patch is that this needs to
> > be:
> > 
> > /**
> > 
> > ...in order for the kernel-doc system to autoformat it like it does
> > other 'struct' documentation:
> > 
> > https://docs.kernel.org/driver-api/cxl/memory-devices.html
> > 
> > However, the reason it needs to be a follow-on patch is that this file
> > is not currently included for parsing and needs something like this:
> 
> We'll need another revision of this patch to address the cxl-test module

Thanks for running that by the way!

Now, I tend to not want to leave people hanging figuring out how
cxl_test works, so in this case I think the incremental fix on top of
the crash fix is this:

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 908e0d083936..4b2416d9f66f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -635,6 +635,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
                return ERR_PTR(-ENOMEM);
 
        cxlhdm->port = port;
+       cxlhdm->interleave_mask = ~0U;
+       cxlhdm->iw_cap_mask = ~0UL;
+
        return cxlhdm;
 }
 
I.e. allow everything for now.

The good news is the patch does work to reject decoders without the
proper capabilities.

> dependencies so how about adding the "/**" in the next revision.
> 
> I'm suggesting this because cxl_mem.h contains other kernel doc
> comments that are not being picked up because cxl_mem.h is missing
> in Documentation/driver-api/cxl/memory-devices.rst. There also seem
> to be other ommissions when compared with the kernel doc notations
> in drivers/cxl/ :  core/cdat.c, core/hdm.c. I say 'seems' because
> I guess it could be intentional.
> 
> Can Yao add the kernel doc notation in the next rev of this patch
> and then come back soon and sync memory-devices.rst for all of
> drivers/cxl/ ?

Sure, but any review issues on the second patch should not hold up
merging the first since they're unrelated changes.
