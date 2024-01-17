Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62522EE0
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jan 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515956; cv=fail; b=cPrucdt02IZnAbBqOFABAhDqUcL+f+EEVTsAo8AM7zS4txEcUpCVnteVtoS6CpUkeIMKM4GO91HefeNL2I8iL03bAOFHBtubEv1OyNmaQIsZmrB/F9kbG55wzmwG5fi7dMn4RP5fa84o8UfoIbKsoDiYodbhmvMVBmFEECVoNpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515956; c=relaxed/simple;
	bh=U0OI+KtjH3cD1ECpkzXXNnU/kUyBBvCyfYHGNwnSMHo=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=g5v43MZfVZb9CawtFH0WWhrxguiV5CPVG3n3WTumdyBNqz3fk6rGGk9+NBe6Nosu4N5QwuCKWbZynaDd2eP+ZIa+zWa7dQWe32J22yfd4/4JfS37Z6hmSEXw6cJgqlOcm+SrZ3oS29AXf1KdAbMS1FH3BN8eFuA3MmMeFAdtztc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox1wiwPc; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox1wiwPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705515954; x=1737051954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U0OI+KtjH3cD1ECpkzXXNnU/kUyBBvCyfYHGNwnSMHo=;
  b=Ox1wiwPcD+KGdc0LiSrZcODQOsJchnH+xCS3Vpi58tkWyhVrjj3Zao7V
   cf1AobNmVnNVOsQjm9UuGQz7SluSkTiausUUQDyAQ3soNTEcYhNv/TtX5
   mr3r7cXCqpuimNrG0/zxoBbPChY+Pk3pe8Bqy79ziDJ77f2bKqrQQgvrc
   MfFBaIkLo/sCtcP75Ju2ruA2D3+Mqe6M5WLTRBuOcnYsvmS0UBRlSvnyF
   rlPpgazfoR5BgB4OPxd/l8tWR9729GKSaPHMPBKYiJkQmrkniMev+aL82
   J5n2nUBUno8E29DHtIVqsdSLrxAyq0OyRlBV40qJInrwxckab//C2ZLYI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="399117331"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="399117331"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 10:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="26546846"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 10:25:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:25:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 10:25:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 10:25:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFST3ZQnK7pHF1hXDbuNUF1OMDOIEOwdTj983t7RPILHCBBmp9mBCf6dSCdtJ1Ez80AfDQT93c+FQ8U3FsPjpEXrns2aMrc5iiTs4hEbiyOczXL3rlI/rnLbFMVTvObcAyf/mH8Ed+GnjakboRa0KlIgX0zWBDElVkNLDySU133sF0lYSWpZVFeylg9mUtIaCmbTu0DfoV91GAzR6xMKo0ydxK0S20VKL0UwySERfouJQ6JAxCuzlX5wmC2S2iqtzThxnMiEt1SwfJyR+u39PqgSHzkztpL/Stvn2l4g/R+o41v6OU/rRaZFLOzLVDCbfHxVrLCcvyjPmwFHMBznqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxB3lJhc9SZAzW+9kMBGgtYszJq/iEZ1xEzpDPpuwA0=;
 b=T/UGsSsQzwmRmSoiEN9UhbWv8+CfM/TfYc10XjB+RWi74lNXnkiCHhQcTNToCv4jtZo3cg8CcYPg3Sg3GHK3N4U5tSCzmtprPN6QLH3SP+btHb8v8YR/3fKZv12QFkMRAd8aU/U4rlXSQczp2pGX+4KPiN0LTq0NBwA7DNiBChUm/9BJ+v7eGCCJQOKgigJn3V2lLSl/MtESFp+ultXp24Hnx0QrJjtC2RweZqItGhcI8XEEPka59qYKCfot0g2tN1hgZuSfnDYg5g9UhuiStx8fITwKMLyDrOsudQnIOBl2CFAdGeAsEsz3gVK5nnFd0VVosVXhb13rVjcgGujjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 18:25:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 18:25:50 +0000
Date: Wed, 17 Jan 2024 10:25:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <65a81babe2436_3b8e2943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
 <ZafUwceT4N-bmS6F@rric.localdomain>
 <65a81a40cea43_3b8e294ee@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65a81a40cea43_3b8e294ee@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fd6e3a-21d9-4679-31cd-08dc1789bb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98/4VS3ggLfB67L4vtkBLVhLCb0NcJT8XM/ioI+OLLxIjCgruva247y+85k02yRjvpWVQV6MlT4P9oJuA3/OX4S+79TdPOWCYihiHOVRg3UBRUOtMsSKdIQW57evLG3THlIQ3BAr2at5hP6gmaul2S4dSai8aVuGnBi/BIYBnO8IO4K+uLARzuViQEtGhYf0t8HBrefo7MW/cs0LgATKyXqm3eSEyC/ernxCmy4lPsMQg13922hs9D7voMGhBnIT0l4Y6KMqbOvSrMGjTlZjkhFy+BuDbUcMqg8oF/0zhz5sUfz9U7h2JSnISJGLeRyfdltU0TyZOL7MKXcqcEaxhm8sVQjLftNlgIOmybfHM+xFVr9kLl+s/L5mzloCEHvf1ajIRvZnLgdwgkGxW+OrbsmwiewtL8Jg/eu9/lsS8MWmaZE93JnJTVyJuRdkiBPxbIc0Nlg83rnl/luO03EjNDjS8h3fW/kbhVFEzGjJjEw2LaPa+2uQ3fBgU2hlrBohqN6wdq+U0ZAkOJRmXgpnk1vMJCFMz9aW/ISJMQu2X7RDz4mpkoAP5wr1u7zrtUsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(107886003)(6666004)(6512007)(9686003)(38100700002)(5660300002)(4326008)(8676002)(4744005)(41300700001)(2906002)(8936002)(6486002)(478600001)(110136005)(316002)(66476007)(66556008)(66946007)(86362001)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/nh8PziyEWPKuQIFbYdVC+UaRSRmgXNbwQr/pCSdCTjOt0fqsDJsYKGOZLEa?=
 =?us-ascii?Q?PIoiaoIhWPRe3Xftlsrj9Jfgv11MDbsHgoTUN0TC1DGbOAzPz3FY7v5pvInN?=
 =?us-ascii?Q?BjNES1T/hvF0kSmiROssJfPX1PuHvlHXTyvUb0QDQU866VeSNNe3D8VQCeAb?=
 =?us-ascii?Q?/V/E/LXm3uG3KaE1woOZG5Hy4K9sNqJK58rtuyfb4006FLVu8GaBYvWmzjW0?=
 =?us-ascii?Q?RhEwz86ADtI+FQOmXq55FCSyu9A2m10u9Wwy2BUDRGmHu6Vp0C3IVKHH9YBP?=
 =?us-ascii?Q?BhjUkO9R9OOtEtU+tHRbXRCK/FrFOJ7W019sUhKrBU71/9tPAvMvSJE1wDlC?=
 =?us-ascii?Q?Gut05ZhYTC8aT9jdvxKyDkppGhW+GRnPMMJa8o/2MpRwjIKO31fc1Z9uguDx?=
 =?us-ascii?Q?WK9hQCgdUK5Tv0TpZABCOh0pnb0wQ8+q9Swt159NGt7HmDWQGmQkylmTq3Vi?=
 =?us-ascii?Q?Z92+ZwnYvIzIym7gKlE7q2riizBpzsuXGxa4Of1w8slSIzQIPz7U5flnPJQm?=
 =?us-ascii?Q?rpyS/sKw9q99MaiRR8pQSQ0ciIQa1hQ5KCDeUcq+DvNo/rWJNBQf7ofFmpTZ?=
 =?us-ascii?Q?afjcKNtigY4vPaTdlCu5MM/DAqQtPLZ6rm8qcdVmtrBygGwDqcbF9A1a5D5/?=
 =?us-ascii?Q?Av2Mf3KO9CfmC3sroarFoRcYXzNBn4YtCtAn4yOJGOfldU1oxipSqLuj3Ag2?=
 =?us-ascii?Q?fuvQBXqPauXo0XKi7LuvcQxUdDdpCLxdFj2crTA9ckOuxpHkJ3tMkfwNsACZ?=
 =?us-ascii?Q?yYux3eMaEBgEIFuJ6Oxbx93wtcq861nUV5ESh8Tc6LrBY3P9jnMEzRwbqzrz?=
 =?us-ascii?Q?0THrjCGm8cTsOQhclES166LK3wJH7WHajCcZuXj3BREU+mZJzVlN2VbaNUyf?=
 =?us-ascii?Q?ZmcQEN4oILbt7eojvNwjmhsnKkIBBYPmY+S28fXGx/M+ySmWS5X/NYKDguvE?=
 =?us-ascii?Q?EL88iR8+T9uRSHcJbKjoZ8zzacGk4wfjx4dWLK70oHrX1hJaD3/94zUbSRGK?=
 =?us-ascii?Q?FYZ+40wAXdaU1gYveFyVQWWpB3nX4FLe3857C6jopxRJpdAZM5jfFlpYsPfK?=
 =?us-ascii?Q?WCbmF3+K0y/6WSX8+MBQ9bafy3SmAMlPpXYFFkJFOteoagsxPkZq1Uh/Gu9t?=
 =?us-ascii?Q?XCeQ/dK9MJ2n0kjEjtxbq3913pA9CL8ZjoE4iV5vCEZMV3nlg6PCX1ZwadxJ?=
 =?us-ascii?Q?aUiLvAKn/qYpUfFVKKk4QHtn51SG5jCFwttZRK3G4zOccyMLEk/xo/wZighq?=
 =?us-ascii?Q?VdOZvqsNEvMDzQwuNh30HNzTrzAZ5jCyE3q8m2Ewr7hgRnuuncgIqMCP94CO?=
 =?us-ascii?Q?pt9xa4h4EXE+p65oDPxxsYXauQmspncvMZ0emlHqce+b8tZxGRZ5YbfMjeDL?=
 =?us-ascii?Q?yJCUHDKtpxpUtl4Q0HYSvVLWMBfGZD4f2hIZGYkOb2HklLaJK0WZ8tPISEMe?=
 =?us-ascii?Q?DLDOTFU8NyKT1vWvWp1GfV9n/WGVFseYt6sYqUj3NjHJxapEGYkcrkVd8CDF?=
 =?us-ascii?Q?3TPIDAQxeHrV2dLeguBL370gOP8NXUtrYpB3jpXL51GGQlbxW2bkIbzj7SRx?=
 =?us-ascii?Q?VKLzV8rGlNRu0mMLTHsZKRPpvJEMgxaFHYdMkgt0Ct0F/26Gj9XuLcdbYl5u?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fd6e3a-21d9-4679-31cd-08dc1789bb38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 18:25:50.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rhq1rzXWM3Uqak//JnO12vmFGSQcLicjskagOKIw3vUIS5v7EoR/ssFr23SNCu+1vw4d0762Xw81oE90NSV0Lfw7qRSplGfubwg3lfYaGXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Robert Richter wrote:
[..]
> > Should I rebase my other CDAT patches on top of this one and send a v3
> > of it?
> 
> I would say keep the goto for now because your cleanup to eliminate the
> awkward "cdat_buf + sizeof(__le32)" makes it easier to use cleanup.h
> helpers as a follow-on.

In other words, I drop this patch and await your cleanup based on the
current baseline.

