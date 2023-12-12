Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gz7hT3pD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D19CD0
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 16:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702340716; x=1733876716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S/LSFY0hFyJKImFnYPjt/X2vYn5+k6Nc8XgkvHh+iZE=;
  b=Gz7hT3pDX7VZ7aXSzv4RegZFUeHCay31BiYGp2VZUUqYlPS1HKD1GOHG
   A58EBMLa7bYwDZYfJPU7wVNkadkGROSPTpwSuz/3cBfWiTA3+8GqZJIHu
   pIi6Y9dMd9hzZQajMvPruWfFC4qELM7Us0aYdWoIMZg74kn8x07BAGhrd
   aF27c81hdGKd5ZY56HhWo5S+WisncfzUMuPsJZpmD+FEI6YDzJ0NPe4OT
   Xa1Sa0pkW2hoqug17/9Q0VOSI65BLH2C1MRMtvuJnTCQYJRrpj4k+06tE
   ApTKRLMw0DR3MmbKkAcvz8ILXjtv4K/7NZWeTMuXC1xij4Z8msoaKz42X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="13424058"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="13424058"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 16:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="749496581"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="749496581"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 16:23:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:23:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:23:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 16:23:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 16:23:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zstw47NQiLl501nDclOeoIgvtsLMPNA5Yk65iAnqXXY0e777M8LY31jm9V1vxaM4ZGHb/zzcYbaLOx6psNFDdZSuakV3U1yR6ePrPsjhH6IDLfTv2H6bUUIJ7GDiSiJqjzm5rwIoz+ut3M/g7P8YH34SWZqCYVL6xZTIIu/uo+FiyUaBwsiGU5PtuehmVvGJFrJWjEK/ofpjuSpVVWR+AE451+8kWzyXOGSpf8J8piTftAUntsFub/zWlSXViVfYHHZkPf3dTR/KZYUUpu/Zu5i4mnRZbZNOOsK+7Py+ypQPnueBDLEuzcPiOoAcdp+wGjD9wzAWfDkru09NzbC3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpKvqAqCrXDt4anU15qJMtIDg7/UoavXhuftaxZcyJI=;
 b=iHWd8G8PsIBORdqsfln6JzYvf22KpEhNLRFQJe+TVNuVlxsd1kam8eDMG5UQMG+LkhxogvM4zbNt7UYI06ebHA1xpWO30bLjAc7KDIdX/kFDA4FAOA+ouCMyOv9Dd/UrnlmT2zqWVjS1eEohQO1OjxQH4jKy+Deapz+hZBvjnEBgCU2doXaAzx7SOgbjtU48GzLPp1sGkD97NfmO+la+VSBebP5U3RSRksfcgYHfVqgTVpndob1FK4mYFp0n7RyMN/NuR7mGq5TZuYTM5qKXGuWrWQcyvRQokUVzllHge6pNgxFFVmoG9Vwg+JyABRcG+zpAfTXqY8hE6YA4rM6wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 00:23:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 00:23:44 +0000
Date: Mon, 11 Dec 2023 16:23:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <6577a80df2820_a04c5294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c0a50b-d69e-4826-004a-08dbfaa899c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mes81U0u7b/u9hcQPQWoYtxKAc8OJtGC8PdxmB+e4DMO1RH+eMks2UrgkC2za6HsF0oTd8SvEH/0ouBOROj+Zt2YL3LV08EvezXbILCV97WsIWJMxmyveb3qaaPmIs1A94ofu2kJob9df8rb7bNn2gBNLea+PStczY+drxSOk5Aiwecem9uwBv8dYvcFq94Iw7DXrXaq7xoHkzfcHsAqCHI18JtAOY7wuAlD8XDp26B19LiIpeHnUPlTsTQDrTeFDcUUY0jbUIMK8BO4FWXYW0K8x+D0TOozYfUBsxdDPCZXEOm9KKdtvnYLBTX7an6nB/rAC5pB2OS7W/6PHV6l8VBedtrp2gLxfMVLfKhDRi4MG4BmdOYiSFFNDY2EZAS7BsqejTufb0BdzQRoCfCCsgATOzVUV3HPo555ER7IOb8FPyZn4Q/AsIHq/s8JFuOwjBpBHQTcKsiH/BroOlkrmMGAkYxE2vx/AZ6AcN/gwYkC/ei7ReLHY5ZrSjlnQomo20uuKI6R8UnCdYjdaCIIZP+YMFCZDPWkC4z3mUWyTEhUXeB7/k7a9PDO8nF9z6vT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(6506007)(6512007)(9686003)(5660300002)(41300700001)(4326008)(2906002)(478600001)(66946007)(8676002)(8936002)(316002)(6486002)(66556008)(66476007)(38100700002)(82960400001)(86362001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WkX+SQAi6mgF5phmNCDFb/xGV+NiBD3AtuPbgBmF3IrXH32V+JZ121ErHvqP?=
 =?us-ascii?Q?7JMDE+unDd6ahf5IJsXYluxs/yhldBosqFxHUQKwbOlW3zZv/BeAxBIHL45J?=
 =?us-ascii?Q?qaPAXzoD2nzWOKTdfWHTDiKHnX5pcfT4u7e9U0NXdvKkXHkSnSnCN9Ach3XI?=
 =?us-ascii?Q?FWctxtxoAh99xThn8fWflF5InQqXp0QQG9f9PpvQXY3rK9JzZf1AKwRHW1mC?=
 =?us-ascii?Q?g/dI+PFjoVDymYBMRVDWVlm+72fq8i8yk/QBJlQZfSxtbgSPUizYUmPzDFR1?=
 =?us-ascii?Q?0RcsCWKJ7X1lncTkk86zL2JSSPiDZlnPlehYaokCLjoQpWFVNJlHvDv38Zqj?=
 =?us-ascii?Q?TIRdze+EB4UjjQzPwBcvCnj8wSL/uJm5ztIdbqrz7jFF5lfZrTKgU0gKYTFd?=
 =?us-ascii?Q?MST2et7QOPr9nfNKJq6oqe0IYn7B3L6U022YvddONJ4PG/8oUO3dGleMakTa?=
 =?us-ascii?Q?9bkOLngUmBTaXJBFfWIUeXLFupNGFXt013BVak83dWMJhiwRZ7kWa+BbnV/d?=
 =?us-ascii?Q?ODrJAjOJBWREDqs62GDUfsqGJ8Iy6DmbmeRHKeP0ACKVONnvb5wc+A/V9dl4?=
 =?us-ascii?Q?RK6v1ucaLBoip83K2ZtnhklU4RPDmmUMlnJZwMLTxHqbDb/7ZU3EKffm9Hag?=
 =?us-ascii?Q?dbANKL0I/sIR+OPZ201C2tudoZ6DX2HxBQO1nY18BfwQgYm2Eb3c0u8b9ZAB?=
 =?us-ascii?Q?bitlNyM2IJ8tAiHmAek7f0wieEg2V604+1kLjT5LAA3e8qe3wW+5GTzONsvx?=
 =?us-ascii?Q?RLpUdIFwMO/4khTnO1vvQfpUuCBnQd0sEc9+lw+qg6QMDINWG1OX3LW0nDwa?=
 =?us-ascii?Q?3oqLSrCLf7CE+t0j2M8HgqO6z1vAuunGHi50j6bQg4dyECh1NYO28WuVUy4M?=
 =?us-ascii?Q?srdHv188kCeY59RYrhOvt+r/uqELCBO6FpYSMuhlnwqbFCu6VCrjU7L4DGuC?=
 =?us-ascii?Q?WZ9pnZShGmmxr4BCsTEwLJJVYtCwRQE8OqQ99xgTsAUz+s3l/YxzyFtPJO3E?=
 =?us-ascii?Q?fVVmDsT8OHQn0m8m+gblKO6oFvtBOJit0l6CneO3K9+WG7V3xkI02SPXfL2W?=
 =?us-ascii?Q?TAg4qa/cPYcuiFe0bf9hgab/vrOJe+hb58UrM2BEihQEPRToMJTtn0qJ99cs?=
 =?us-ascii?Q?IgYg/90l8UdclLHEAbL+54VhkpU1/tadeBA0QRKj8qC8GZcu4cvUMZION9VN?=
 =?us-ascii?Q?M2/H4xe6jwtqxgfvjeZxXvi8ZyiILbqL18HObKhhWIxHYFSKQr0mzI3pK/Sc?=
 =?us-ascii?Q?tffL9CDq8OUdGW92K7To086Av0nCdR8JFfqH5Y9zWn+bOHtpwBytlQ3KZ6Yb?=
 =?us-ascii?Q?qNB5ATs83nI5/mu0mRqawGIl5l65Lg5Bh+qkOSWUbYamNDZ9/oZ438QHNVHo?=
 =?us-ascii?Q?Zr/Nj1ROHIBj2WTgmmDO1Q4/TndT1yqRD4SUx6cWumAj+CftZbtIfV3iMRJu?=
 =?us-ascii?Q?MXdXHuchdCwucp0JMJo2hiRhSTURIW8x6M2Ek/llwjBL0qWO14GbWDwnljMn?=
 =?us-ascii?Q?6LesCPKsCxFmYjGL/lNGO6K7E74AOY/e1BanN7bN3Ku6I/5NaS/5PcLN+Nl3?=
 =?us-ascii?Q?QGtfypqssIMT3HDjhwMpSn7lmDsY49UixW88P2O6qpIoBvz6DQjw0NOtPh7I?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c0a50b-d69e-4826-004a-08dbfaa899c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 00:23:44.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTDX6FQ1uwen/A2IqL3uORCq+wvGSAR3YNuRs8vCVSXt2epWgs6KaJGQNVye129VGtC70UDKvZFUBMwmqbawDc+Jj6dx8TNT8oT/mg5BX6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contributes to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contributes to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c               |   24 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..e96f172eb6a6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,43 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		events when cxl_poison event tracing is enabled.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated read bandwidth of the region. The number is
> +		the accumulated read bandwidth of all CXL memory devices that
> +		contributes to the region.

Units?

...ditto for the rest. Ideally these descriptions match the units of the
same named fields in Documentation/ABI/stable/sysfs-devices-node for the
HMEM_REPORTING attributes. You might even link that.
