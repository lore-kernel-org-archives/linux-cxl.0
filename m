Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF5522F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiVW9a4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704430134; x=1735966134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cx9PtjSK9OURRh3k9cdvpOBg0hMIQ4MYZObkGVBQcew=;
  b=SiVW9a4xjZrxTw5cLgeuOyhIRgrZdq4tEj4DJ6AzukDeMAgkMpgFtZT2
   NETWhGrBmq3q+8aJZRHdQB/zBWIEkmZh1MfNTEIAizVOSTvvHIdYYdjvt
   RnjTR2YWmVT81IgVJhdP+HJODp3wEfuTxi/pePJ/+GK1kZSsrMwEH9dN9
   HcnJ9GTFmtbF2kMwujV4i4YhzRYiMwPvoHWPAshZh9mFf4FlYheirgWox
   SiLtYQ9yH8K+YcOEKxWol6U+brIO9UjwuMIoIZM/qYhNIRT2ujON13Dus
   IIn5ianC2eZhvrhcVuwbGtXyXqgN4L0x2m8QvVKx1vrNKDS0M1Oh5JDWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382410530"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="382410530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 20:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851027774"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="851027774"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 20:48:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:48:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:48:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 20:48:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 20:48:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwKiPwy0Ak8FoFnoG0MSS0coPdpqu625s8KyZU58siI7VHmbe5mxy4qlUwgqj4jBrhXXnlaXoCHX01j1Z4UX1Q3DEoFtxkvtkWyl/gpNaRnRFgtacsIJUs9Gx9Rvy6rxxesk4F0fuvcYzjaASRvEgtVyCGWHOyTX4k8IbFta8U1i/ICIE6+EL+9IRiIrx/uoxDP4bq89CZRlGNRvjrVgEDrbW6ngi2pAk1GOfqA+rCgaKi0X5eciRTdywNgKt8h8mTtWdMEXErjm1BZ3dM0qZ9OMBLS8BuyO7d7GUQJ9rswFrj8A6c3APQs7M0pyokEl7oN+nnFlTg1DJ0IkeXVxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx9PtjSK9OURRh3k9cdvpOBg0hMIQ4MYZObkGVBQcew=;
 b=gIL58XjT0di8uH5sLTcB7nuwfnwTH/XMT2K99U3MNMp4R/8ULfjyGqmPojgzz7hxgl6bCQ+O3zeWO3N9zNoEKNGBSjEP8Yp/bMYYZ1rcnkTCTpQ1lLBfI5s3z89qZzNAgL8tNyke2g/lgQFZoyUcn716TYmOEgVeULDEp2eCsRCC50Mo8Wl+gk3nb+XB5EWjF+XEb3RDRoKk1RcQ7LFKmtMX2fN04l/PiM5bEYFhOkNrI3rBDGd0cv3+9v/EdOgARkppmBDPDbvMDFotJACV+dGbu1pNIc5IlJVJGJzXipwZLoxjB2LngaKufLQ7iJx2WegWVM6ElfRKY33jO5JxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 04:48:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 04:48:50 +0000
Date: Thu, 4 Jan 2024 20:48:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rrichter@amd.com>
Subject: RE: [PATCH v4 5/6] cxl: Refactor to use __free() for cxl_root
 allocation in cxl_find_nvdimm_bridge()
Message-ID: <65978a1c90d13_11cc4c29440@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
 <170441751181.3632067.5542037427417510907.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441751181.3632067.5542037427417510907.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 92778ed0-be56-4b81-984d-08dc0da990ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXlSYsWof+Mg2k8nHcwpsuR4Nb3GFPUXRcHOtkF6jm50S+XO+qJdUwAo84ubYbIMCNX3JFTHqQCCuiP8HMs+H7ADorxcR9PNOoxcSu4gTw9JdOGudTstL35fAVXZacK3V4GP5fu0q25Ui1+GRU6A3y7IlN4CmByNw4eeosRvtZamwgpxPuXMsnbXl03TzDTUm/fSLfSpgi6dqUEsE/OYmTC6Yz/TvcMrtY+u6A/+iqpRPYiO83+u4nlt4PQsD+xvH7urJ0jDTbEnhTRv2DE9Nkj69iZZ8oieEkvIVg//vXvZxCNJHEtM8vY7tl5N/ru3CC3x4lN4eL8aImYpQ0xBeXKTW+SdF0xrv7dELDu6ns1apPvEdjFFPGV/2fUuirVcuw6s3ka6uURaa5PTOT0k84V7/zqz8TL9BoPQ9vMK23mHP88DJeQs37Fnx3YQJnrCGi4xWEjikM8jPr3clBrsl6dwhD2+V4j1XviOcWH5QcWbYSDEHrUtJAPe2SOE9cY0xURehOuM44+w2TEDXkpjldyPPOWuHaN4aibMGvTZCb6zFilDV9UhByyjCunEUjfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(4326008)(6506007)(38100700002)(478600001)(6486002)(26005)(9686003)(6512007)(82960400001)(316002)(66476007)(8936002)(66556008)(66946007)(8676002)(558084003)(86362001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s37IhAmFmzG+2aFLEznSG0D5AcSPS7IqmsOT9g3o5c6VAHpl4huPgRjpArgz?=
 =?us-ascii?Q?Kx2JL0VdmrJtRvV0Un3WcOXA9AE6pYxPaTg0UZWjzO6SoTpd8sLKDXtbKxlp?=
 =?us-ascii?Q?DEHCBIg/6khe+Mcc7IE9u9/hzuy13R9k1Aqgb6H/ubfa5JtRWBNDxvjQR8T0?=
 =?us-ascii?Q?Ito4ShY4s3KqKEyC49LOmhos4fOdiDuPC2hUkJXTX/BdwlbPWinuxSFAJ89u?=
 =?us-ascii?Q?5Cs39TezVWXhkhTyvtUV1gWcKJ0ZNokqAqoO8LVARUW5ZseBj58Md17Dq8n9?=
 =?us-ascii?Q?MO2RecsMOap/+/m+NpXAimrU52I24Ka5nTtOvNs7624sEZrPgNo4z+xIx+x+?=
 =?us-ascii?Q?UEzDf/gIUDAqb9qoEbXIikdSD48CiFPDtY4XzgFY6Q92A/an0B3RXdlVEchL?=
 =?us-ascii?Q?5aCM90p6l1AJv5XtF00t0xyfjRXG/wtxc3VlvzRiOR3xngG0S7NrSFpoHbKI?=
 =?us-ascii?Q?ZysIJ4/OGK35t04Z/xTeTA6gBRcX9LimnDJSnAmdFIiGjUWkMnxRFPAoU8Up?=
 =?us-ascii?Q?nE+FYnVgsKrhp1HR3c1i71Q0mxUmOfX+QtZm24RVthk5ZiYi9u5JQpeobmHU?=
 =?us-ascii?Q?hoLPn7hL4CgiIEGT09vPfPL3Lsv6TXQMqORRWhBKL48MOIRnPoSfs4NbJf5Y?=
 =?us-ascii?Q?lKz9V3lRBQD2OSXWnId7yXAeKtA8mt2ombsIcwbgrpibMlsK9wI5p7Jf8fWG?=
 =?us-ascii?Q?eT7wS61ozPSpIwBQgp1HUyrHfWc9RbByG1kJE1i+KbMJIwFzoksj0a+i70No?=
 =?us-ascii?Q?QM/w5wnyYbtVvL8fCBOIRV9KTUuYBgc9ASLvtHAbhE8zx7iipU+FJsodQ7Zk?=
 =?us-ascii?Q?m9qqHTx7TYZgssdW+o3HsqZefjrcZEhWhh5hv4DJ6ixpnAwX683pAnoStYfe?=
 =?us-ascii?Q?zlGXQayxV9koc3lxy8i1dg/Gd8s9hBi0ndRIxZ8/YG7k/bDEEgJ/iusHA3Ua?=
 =?us-ascii?Q?aGDXR+4XubBefh+k7GeWCau9YPp7As/DTovic4qDu4T26ssR7Hi9XGvjkwvy?=
 =?us-ascii?Q?XrnZK0uMq6j4VrhRDzGY+lTEb2UMt9qVnEyijA1bHOObpt9z1p7eS5BpNYwq?=
 =?us-ascii?Q?JRrNXR/KI7i2nksKFmr5Asi2BRoYrGaTEcdhndumS3WSexUP57eOv6T93YYq?=
 =?us-ascii?Q?P4urmrfQ0MjZxJegjexQJkg5mAcMnqTjnxK0lbUay9IJqN2IdN/+FW1UWMFz?=
 =?us-ascii?Q?hUlYmCNl1IAz6l5p0hiVXstxPrynQB7Yg1m4F9W7d99lqW/9mhQb9lWPunP6?=
 =?us-ascii?Q?Im9Nj8jYiVVu6YdzC5VKP868OfLS6Mp5ZLAtkR+MouWkwVPsF2CYLoNd/1nc?=
 =?us-ascii?Q?MEa6AaPLkx7FRfogJeEXudtZsMRYIv8DU5/aQgtz8JvaF2YiIPgPJUSSw93y?=
 =?us-ascii?Q?eDXTmTlF2SSIVgLbHtAIZ9z/IXxBWPuyAyHMBQJa8RO0x5kBqSWb+yhjBYDw?=
 =?us-ascii?Q?FKqNXZzsBq6z15j62BJZ9es2TNQgnMAdtfmvXptE2OKKyIsym/k7QSFtZmCN?=
 =?us-ascii?Q?FhrT3b6mjqTWWj7aHIJtFizWSd0sSATqXb8j3U8Njhv8xzxeud2Ae/Vgg+Lw?=
 =?us-ascii?Q?efdBY3m6911sg2m6QaTFTkJC0ZRC2bz8/eTZKld5N9goqQQhAYfAJceU0qOU?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92778ed0-be56-4b81-984d-08dc0da990ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 04:48:50.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7v8eWEAjf79UC1RvJ1eszEunUDs0ZxMyTv9In//oeBgUpM9SsCowCQ2t7ib+jVZmvBkTQRIoxL7pLGk9fEwHNq+obq2uGxVxZNi7Nh+5hzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Use scope-based resource management __free() macro to make cxl_root
> allocation safer in cxl_find_nvdimm_bridge().

I would say it is perfectly safe as is, but the benefit here is dropping
the open coded put_device().

I think the local @port variable can go too. Fixed that up.
