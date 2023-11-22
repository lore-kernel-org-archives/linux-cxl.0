Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNs3gA6H"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A6CDA
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700689393; x=1732225393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZQmWe+LSaTiN4ZtpYg2fn+2+LVVtuC9+Ih+0+hWf3O4=;
  b=LNs3gA6H4+c0xKXGpylIOHaxPLyQhajKj0YKQWZpZbRSLE9xZ8WN+In9
   tp3psS2xTQa4+/8kuFxDCKO5G6753upne7Xitxh60KLBzEtsZryrAfR97
   9Bk1V36IrlNdYjK5Vd7HHSwf1uVR7rbtblywnVw/USMsvhmLtS7zxFdi2
   3GwxkXtIbNFDzcKAp0zYkSPLmxDrpM/87l0UwP8m3DAY0Hiph7qe2QykG
   FoLxhWlW0PftgwXvq0qQmGHFK+rL3JMbT+Bkj82+PqjXGtIeus0TLt4g0
   WShABoZQTzAIdg8UOm37OiVlZxtwUnxymsaj//r8FoyJIWMvsRgS82aXo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389305531"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="389305531"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 13:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="857920082"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="857920082"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 13:43:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 13:43:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 13:43:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 13:43:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv9mqNo7+uMHCUFH2dGyxTLicHTx88yV3zcrmLSuVqlvQLTfvk264DG8MMPu//gPtLftzVm6ZvuHFkHB5dE90Lzz7uqa8JMwLlKVERKWypPUIoPNSfc8nD/OSZK6HUKdtW9ovB7yBPtgnF58vnra94774efFyCsmh1tmoFs6KJx7joKJxon3SLsjEoM+/Z+4xkYpyKLwXuA22TVWPvAVQkC1JajT1MWNwYm7+ohpS35LOMMt2NjUEzZX5xc/XANw3CPDHPRvF5odNx5NBV0epUavjJb6KhvD4Q3cGvhbn8ooemDyaP8XCKBVbiByRZ3qnjjXOIYWuJIdvIzQcuSezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvilG8gNbR2NGDaFGxbeDqhjwiZTQEd1uuTo6jwOWX4=;
 b=LFQbIadeKwX326m2f76BF5tIWWeCmv2xfwHnrWzdaElQGfJKuMNG86KQkoV6lntnZtjiSUjmE5cQjbL4pc0ARQsMvsjk+7TRB09vY9Ec4XoD9t3ZGXU8r5Z3YqNAEbrtqrb7lkDqNAC99RijGIhrq5/Q8zlhBFP9XLB0UAn0IsvXmQHwFp0j2wQk9TAl+0mJJGye4sEtf8Ew6C5+ppeql13G3SkEw67i0MT6ywkpxU3NPWzN9P1N4BsKRAvHKTDSbVIA1nrrsOrZZAWBYVXsbFY+tAuM+xX2ebFDKUsopQd8y24tEOjEFTutT5yhnd8bqujq7je4qIltzTagN85fRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5875.namprd11.prod.outlook.com (2603:10b6:806:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 21:43:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:43:07 +0000
Date: Wed, 22 Nov 2023 13:43:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<peterz@infradead.org>
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d12d17-8fe9-4e3a-1f22-08dbeba403db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhWDba60WyD2igVx1epI0bBYjbWlSSrd5LfYULCzvvgooF2uyfpNZs/R8hpJxqSFbynIef9PBcpOVzNEdMxo/8Hl23SJtZ7UOQgJZ2zIqfr3eS/Dd+Ij+kkiNJ4Awm1AwyyUyxxcFHTvE3yf6wtJDis7sV1tOpERpbQDTvEBnw5uCdK6DKhfTdsvkob7mCz2sj7pzE1Nsb048hTNmnHhYDkurC7z21wQtBYNk4bxLEzFQ8w5St4N422hEUx1MMF3Dm+RLISaglKMbx+zKTpNpfSzYKF0khaH6d1kbBeSI9zT0awIUHGikWCsCAPBwR8DKt8YDFzAWHPksUTWGSnTuLTMH5zMapQzCclLtsZz0jtFwBsB9jdUFOJhaW1LdNgoYUGWxoueradQc0Yuw+QkNvK6MzryruEWbCUmx6dNGSGE31COcpl8JPQglk2lgNioQiJ9MyWFMA917+wcnzBuyOG9VC1/LYfCxBOhFwNZXsV8fD50S8G+OvT0hDdvlqZTUOM9V2XQXtXxFzY+HeqK3mXUcEef1aX/U+xcoVVno4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(2906002)(5660300002)(6636002)(316002)(4326008)(8936002)(66946007)(110136005)(66556008)(66476007)(8676002)(966005)(478600001)(6486002)(6506007)(6512007)(9686003)(26005)(83380400001)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mE5R49gWTgTNDoqUd0lAG3WPLU+Y9VlcHEQ/TeP1f3dcGdpRs4rWHXERxR2n?=
 =?us-ascii?Q?Pci6Z6QHzOM5SJ0V5ugLkpTurIA9I/1LeiYv73eKfiZH/A4rL02mz787o/Ar?=
 =?us-ascii?Q?UBHovKDJJMNKwtJVn9KhjpYL9UtRPtaY9xpm3DqDSRPEgrd7gxytGm72qJRa?=
 =?us-ascii?Q?f4VJjO0E/tVGYkCz35x5I/ViKQf/aZlwMmbRfqn/i3bj2v2GYpCVkfLsGCde?=
 =?us-ascii?Q?D3AOd1CqFk2b8N50Iz/mydrPhum6I+5ajfDOikJfYjydIuGLZJiKWMk3O7hM?=
 =?us-ascii?Q?FMW9R5qq2Z2RXJy3HNNq4eUm3kdZqEqj4j0W5W2WEMSNfIiZ13rVoJ7dp0uD?=
 =?us-ascii?Q?V4KFBMiO6nEqg/5KgPrI35HjZ0lToYFIenHmxbJN+sizj0H3dVFlpzCr8wQT?=
 =?us-ascii?Q?wuzRGShIX6BPtjpvIRvS0hRDq4/eA7BRDq4X4EV1VW5klG9g1mlIBPdgPTE2?=
 =?us-ascii?Q?TdEkfSKV3ZCHOIa6DKOE2KW2Cdu+w5rhny3Vepqmzu+xJR4onJ8A2uu1/khz?=
 =?us-ascii?Q?+5md+1v0mQkgAF12iNzWipCZtUp+gbL4XNtpX5gQ/EbU49lImCHfWbL7D484?=
 =?us-ascii?Q?o+Xt60qT0QPh78gR5eA1AAeiTRGcQptAvGEqpJ62wR+N7OVEbQzgYcBkyxSH?=
 =?us-ascii?Q?vDR58O2T7CHGrhl0Mmcu6WxzgtQEl9fg2feh+8Y7+v03iG8yfy5MvtIq1gXa?=
 =?us-ascii?Q?OvpfMOobKbn2u7k/AxXDWoLFcisiqZOl3w3gSX0I82/M9UlMRNMBv9ufRW01?=
 =?us-ascii?Q?9llBCBXBZlLpcVoyP78//cXvsyfDlHuU6UQGUQpB54yiFNS7fmQhbOwf9G26?=
 =?us-ascii?Q?ei2yj2ovY2T3RRcekwXjcC/EiM9Uv/BBxU3X0PDOZ78sjA5GhBde1tkmOHLI?=
 =?us-ascii?Q?XgFsWoaYNFNmlY4hcJ5VsUX7kiwk3NYTa4rj5uKQlZS0q338HujVZ5q1SqiP?=
 =?us-ascii?Q?eewZIQjKW/VltvQs5GuSN88sNQNr1nRzUk2cr/wd0Jz5B4uV8tf0/L4StM70?=
 =?us-ascii?Q?Idu8yX20ijqf+G3WSd30qnh2bqHTX7rkRQ5fCUpfsXIo+biEzGLAKf5VT8jy?=
 =?us-ascii?Q?RBua/ECimjTc3qFswHXQ9ajZVPAAVbc6A/jevapO/VzBeQTI3s+d8/k95qNt?=
 =?us-ascii?Q?M74ZnEOd+1kFdRXW9VCMQyL0jueYcsCOmXQYRWCUN1ZhfGcka0J2JcCOml4p?=
 =?us-ascii?Q?XZwwR0MmJ/EN7RANewmR//R3deOeQ4CvO/es7Uy3xI7r7tQu3+XFR9My0yXe?=
 =?us-ascii?Q?Ij6OIYx+2XtOy1Frb9csvQ2msQiVaXQNmC4rHz0p7+uEGxNCkFvYa/cKrG5Q?=
 =?us-ascii?Q?qKL1I4F6fkUfnUvU+zHY7Ll1jEDX/j52nW+/0hDFbTcSMDEKn+JyvJi18wt3?=
 =?us-ascii?Q?xtwBlz6TE7Mfplxv1k2we0UXOAUseng8cm2NHm/CndcwP8Fn3NvCrnU2NlTX?=
 =?us-ascii?Q?avs/4pkPMDRjnFG9VTUoewyfR36fKLqK1Nid6mONiHQfUw+XM1QxbyyuZYwi?=
 =?us-ascii?Q?4MFXCh9zMrIQVbFVKHaRfoj1y86E/oQBNoC9u1bBGIg30iXXxf77byOSxTdC?=
 =?us-ascii?Q?GUJC7RTR+r7sIRE9Sftx/3z3Bk46rjvFAcntwpZ6JL9feD4C8H/R9SH4zM5b?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d12d17-8fe9-4e3a-1f22-08dbeba403db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:43:07.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLo4DhvheGUgiEMHRXNfvG2qJkUPJqPBEiei78mqmOgqxK0IXhiTOnuSuMYCyU1AXhOji7o0xMI02GgmvJZ8ug/pSEVYH2atUbbT0KI6OFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5875
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Fri, 17 Nov 2023, Dave Jiang wrote:
> 
> >init_hdm_decoder() modifies port->commit_end without taking the
> >cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> >However looking at the code, it looks like the write version of the rwsem
> >needs to be taken due to the modification of commit_end. Wrap the write
> >version of the rwsem around reading and writing of commit_end.
> >
> >Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Uhmm but do we expect concurrency during the switch/port probing phase?

I answered that that detail here in response to Fan:

http://lore.kernel.org/r/654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch

The takeaway is:

"I am in favor of adding the locking rather than depend on a subtle
side-effect of how CXL operates, and to avoid adding an unlocked version
of cxl_num_decoders_committed()"

I will add a note to the changelog to that effect, and drop Fixes: since
the lock is not strictly required for correctness in this path.
