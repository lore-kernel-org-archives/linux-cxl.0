Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23624134D2
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168784; cv=fail; b=ZyBHzPb6pCIdgGrM7teN9CBRs+ksvp4lzwefX3eBJ9pPu4OEQrATHTICDBVq0HwmQZ81fOiIbv2CMT+CFGAq/w5MVTNSRxJWw3cJ6OHROg34CDBt9Ci2uOCRKR98ho8nHVlhImhoBb3XVQDwOGz0hVedvws0YLJ8ctmPflOa1Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168784; c=relaxed/simple;
	bh=rg8Yu6rnEmo39s1JxL1VS/vLesLP/opXCgibsdIyaRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bb1jhYcdigXaFFuvKc+Kp6fizCGiU4PByHLRWVLkPgr1aDO6MZIo6Y6FfpI2WSJSnWSTOZ5QpXd4otsoduB/91zzScYxRryOoePUawlpxOa4LagmOO5rfNH4ZFB5lkZfUU47dOgu0jm8og8S7is8Bn8K1R6n9rEs0ez4LMXR3tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuhzLpaF; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuhzLpaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168782; x=1737704782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rg8Yu6rnEmo39s1JxL1VS/vLesLP/opXCgibsdIyaRc=;
  b=WuhzLpaFsQNsgthYbZBw8sCWTo3J7LDNDW+QS5hiyrJmoytgeTwmOLH9
   FVymOojhP7ELAFlBrosmO3pux6VBeu6Qvrsx1Ay9XNT/hfZ5dxSInFUU4
   Fl5Xk7M+qe89x4LzhHVVQuftCe+BZXGrs0rBrIlnKyjHwYjdPPZAxBy3F
   jRUyB7BTjN0JRUAJfXW72KgfSV38M5mykOZRLkUDc46nJKBA5iVA4HWL+
   l6+dmtZYRoV9JRESQ8lqiNnLFAxgvRNMa93jc4z7reWkxWV7s/5j6I+Du
   Qrh2w6oU6+YTghg1ZFTVvUOCD9r+ydPF9PLn/4KqsRZx7Ck1ebZzGtjsY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399249027"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399249027"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909919126"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909919126"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 23:46:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 23:46:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 23:46:18 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 23:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrW95yT6+x7amuvxCZzHzPVyH5ll7xbckOlq3TB9nE0Fhc4re3eYwdqzaogT1HjmH1XiBMUS2U91AUJ6lHw+HxjOPNLv9nYCQqY5LzpThXKpNe0htk01M/5KNp6oBsvurCG4CDLV9UkUfg/+frBAD5eJQB8f/blKsAC/AAzoC0UXRbSmE1hJ+uyX0aRZuwS5bxAlUdLKc29yV8z94Z7/hP3Ts8bahikJH90zBUx3Ae0ivHJuuYJGVHhA1ZTRp8ntzxkM5YI6MqEQpsKF0lPRaRExqiaO6HTnxotmJ/FfSpTCykPQ/6b/urjSVVYUjRCZigNiZ4nwQMpo8zf/H8gvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XzEhTegMb95KnPrg5Tby6zBWGHVFpirE22LQdtgJng=;
 b=LKrFJx5iLjefWxIM02HcRaOTZ0N9l6+S5tVJfl/E+GDmOP71kWDS6OsdNoKO+NCweF7ucVZqJJ2LhfRG7MxDhKtDdCnSUYg845RbBN88mhbYZNc34/P5gxlXsuITcsurIrsugWRgtdwqrr+9huacR/UnLBIhQBCGTKZyHcbsS3ZVldjiO/qLt5pwwlp3k5r525AuquF1J5w5QdjUZ/cQLKQNGSWRnFDhybiqffeCrGLXLFnOoRLRe7R8bT/xf1CVscEbwrn2H33UUnKit5gn7YT3k6sldcD/1VuHS5mKV5d5T2jjxAJ+orAne8xL5h3xJWlcaQRGb8dSFQekWjrckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 07:46:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 07:46:15 +0000
Date: Wed, 24 Jan 2024 23:46:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <ave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Message-ID: <65b211c51ce57_2d43c2949e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
 <6595c83083418_8dc6829468@dwillia2-xfh.jf.intel.com.notmuch>
 <a32d859f-054f-11ca-e8a3-dff7a5234d0a@easystack.cn>
 <65b1da5b2933b_39fcf29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <8498fb54-b003-e9b5-ba50-2e6eb8e257f5@easystack.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8498fb54-b003-e9b5-ba50-2e6eb8e257f5@easystack.cn>
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7990bbc4-463f-4bd0-34f4-08dc1d79b563
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvPydxYeyE3tQnRtR8pl+cbFjovCV1men4mOFcB7ZOGvVCB3yKPLrauLHvfNP0pKZrPfaKDV4fogTEvMc/RFyaGNIMSk+C0id5bIfUf44q8Exlc5+HSmoo+wBGozLja2vPVuw4kmSvu8N7kxT6VZ0ApGP9yv13umDfcMYh4oFaz8O0ZIcnlf5FzVUXxrJI1/vs/uYxAj8kN3mZFEHne1PvlSWQm2wvTi3ef2+FwS7rxiBJoKtu/ITpiFkto715Sx4IxrTzTICRAkRkzj9h7tbvieAHRrKK9IrZNcU/3cD7rJin9tZVNJ83viKgcUImBH1tOKUSEViI2TCou8ke90Zbaa+/gF173DN+Y8UFMVuZQpo+IvOKTDCX5iRuWplFOWov+NPs/sFP0zGVfnf0MFy8Vav9A/Uspi9Q4W293xzSZCRP7M9sAxMoxxLPc+WPE5bsKmtu7WrDTI/GkJYVFWZSo+IYty7IgszSTwoKkeMZSiQjdDSQrdJxBT4rSx0tfOMKrEUCoJbj33tCVh5XZZpvtrzFnfHabTXiGBpynC3KPK5khf5zhvjXEONxXF/2Nw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6486002)(26005)(478600001)(9686003)(6506007)(6512007)(316002)(6636002)(66946007)(66476007)(110136005)(66556008)(4326008)(2906002)(8676002)(5660300002)(8936002)(38100700002)(82960400001)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XutdNh4jF0SYm2hDnZ+YCSrDn7OOLmUyFFSbtnfaSXoBL9+JLiHB44YkS/Bb?=
 =?us-ascii?Q?4fuCP7MvxhoS4dkiGcZJ6hRJyJJW0gBacjTPsoIqUTnNZ/PVMx4DOVmM7gnU?=
 =?us-ascii?Q?loD2Phe729yKss+wNw1FpHdoE5H0eQFTqF/gKamu+mzAog9CgcrKQ5q/2S9h?=
 =?us-ascii?Q?vWn+gDBIUvE1AUfj+wLGjq3mN9tBkRJMrNN4GAr+l3ouROxzP1c9LCFymXuX?=
 =?us-ascii?Q?Y1zwJX5f1xdDpVWWLDb3FG67S4aVAO8OAWRSyBQnfk8ogJuMhQERZmFNpRP2?=
 =?us-ascii?Q?5myWRfLdglbkM9qVwkY+5jhxTRENfRBvjPX/Evv15ymNGf+MtAZcJJV2te+h?=
 =?us-ascii?Q?qddbPXYgVemGJjGopMu266juzVIYPX+b4xo1ILenfv7KUmGEuBUOeDEI/3xW?=
 =?us-ascii?Q?4fEq6AzvSCFlx0iAEcpPcoib9nevNZh4H4/s3igkLmyJxsYCv7K8bFcUjw/J?=
 =?us-ascii?Q?ry8hKKOYfQXAjoZ9kwWxnMWW3wHH8bTIIYNR/8hVxfmXXfJAtmUh9Cm1sPaU?=
 =?us-ascii?Q?F/l/fzhBHNJtNEJjyh6jpom+Xd7nQSKOeD0qd3j6vMImSBhn7G/24fWEWuPT?=
 =?us-ascii?Q?WQkAtA998ptn3UDWepQudlp6BROx+zNzlN2Ow82syLzXlz1RXix7mWuwAcKD?=
 =?us-ascii?Q?MH7VpicSD5ig2JO8KPlBFTmXFWlm/d2BGPDyz/Yo07Oqv0T98wsnbpSVfiOk?=
 =?us-ascii?Q?Xz+O0IKYg/GA3ukaIAxofs2GSYRrE6DGDzUvBbB0oPYIfmbzbEmiEc4lEwxN?=
 =?us-ascii?Q?Ixb513MyxNjyrh8otq6LhobAyY9AWDUGYKIgZ90Te0etp8PYD0w6vTjQwl45?=
 =?us-ascii?Q?iGvcToSWS490FTGFWSQC62WX/n2a7l2oihIJtae/gXdIgSVp7k63Al8XJ2ZM?=
 =?us-ascii?Q?sWJQ+n30yG1r7KXrfAj/jKwu7OwMiCnmyftxCyEuzp2qVdrJayrzqbaMK3ZW?=
 =?us-ascii?Q?xdyepozJThINRt5K+7NFOS16gk/tuLYshS+0TG/x5PGT0yNeKohRAP/C5yNN?=
 =?us-ascii?Q?iOXvLnu12wq6Cu75EWmwIf0oRUZViqjyIEjk7JWd9KRx3Jo7/OBuKzTXsqaZ?=
 =?us-ascii?Q?Biw1MonkgI0P4NuWs84CHmDZJBntf4BPlgNRSUxxq/D5stmMKJ/3b5olysZE?=
 =?us-ascii?Q?HYYbMrEJAXMpKY1oB36EcGtHrxeq6gt4yWmi2TPgYQXuV13bRVM0E0PLaxQi?=
 =?us-ascii?Q?F3roLF7oJIu7NELYG4Ct4YBZGlRAsiTHS4A8++fOU8gf0wwyYDdsFME6RTYK?=
 =?us-ascii?Q?VtRuTg9XKJyQQqQtM82343TTyZmSjQo/EubIVnrWEdnQhuhFee24rYeSP1Be?=
 =?us-ascii?Q?tS/AyyQUlAiSq/saS1f7QbeV6KMyNPxfJHK75JqUuZ399S+J9hgLtBy9cJ0M?=
 =?us-ascii?Q?Y5sxBY2l9myfdgj4Z4bnKbud4pT2giS3TGuWMmbe98novHkcCAiplV6sULu/?=
 =?us-ascii?Q?bwr39LD/DxnS4EIu/34XUsF1iDK5lrOU4TZIjb3lHLhno+li3XcGCkbemiiI?=
 =?us-ascii?Q?RKrgQDV/ZcpNJM15tThn79PAHHF2aMjkCkRAE0J7qCih/i5ctViodYQbQyec?=
 =?us-ascii?Q?pXSMVu6vSaMKfnLUtWKEYam29jtV33bUHPpJnEUxx4K8a3rLZNi6tTpAllEd?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7990bbc4-463f-4bd0-34f4-08dc1d79b563
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:46:15.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVbbylIn51WRBl9G5h1NCzKEHz70Gf64kNBf7H+X4yFO3WA6icRQTPne3DlC+/Etkskgg0DU3Qkf0dIVeqgYq7+Dzn/drnEElbW87o2UUco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
[..]
> > A faster way to get to a device-dax interface fronting reserved memory
> > is to use the efi_fake_mem= command line option.
> > 
> > For example:
> > 
> >      efi_fake_mem=4G@13G:0x40000
> > 
> > ...assigns 4GB of System-RAM starting at the 13G physical offset with
> > the EFI_MEMORY_SP attribute. By default the kernel creates device-dax
> > devices for that dedicated memory.
> > 
> > For dax mapping performance testing you don't need any of the CXL
> > driver infrastructure since the CXL driver has nothing to do with the
> > data path.
> 
> Thanx for your information, I create cxlv because I think there could be 
> some other use cases other than device-dax to use cxl memdev. In that 
> way, we need emulate cxl memdev in cxl driver level.
> 
> If we always use cxl memdev by creating a region and creating a 
> device-dax, I agree we dont need to emulate it in cxl driver level.

Upstream Linux has no apparent demand for cxlv as cxl_test, QEMU CXL,
and/or EFI_MEMORY_SP enumeration of device-dax already covers the need.
