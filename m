Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95663B3
	for <linux-cxl@vger.kernel.org>; Sat, 10 Feb 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547766; cv=fail; b=uiOCK4OqrPx9CzPgijT4X8K3M50iUkZRr+xszVjspRk4OkUQKetfJkbZ2Z1BK3aol6jAxq1rzzWXezlO8FP4cTAf4V3GxlwhTf5RAw3aMgqxNgifUYzCJ5hU5PoaVKmb5mXgYYFilx4X/1MzjGY7FqmDMbwiGCqEotYQ+dUIjqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547766; c=relaxed/simple;
	bh=mRaHO43ilsGthUjEIuCVcpGY5DfjBpstRhoP+6zzgxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkSNW326ITxibxx0beacpMxZv/YEoXnUbf8wrEHuGK1R+UfzcdpBGOteyHSzlDiP8Zr1Adtjxm9xruoV9CFIPrDsZmSQ+1p1hQuaYGmHPotZtiktM5AT9bJbsVcMzzbucj2/QJKJ1XGLJ8CvYozcINyeGyvFqNKSJWoTtyzFlQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFw6hg28; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFw6hg28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707547764; x=1739083764;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mRaHO43ilsGthUjEIuCVcpGY5DfjBpstRhoP+6zzgxI=;
  b=FFw6hg28SEiljcix0LOmRDy/+xfXJV3hZg4U3tOBzP7snI2jVIZmaq4+
   ucC1xL/DZp4C4KVDdNwP8eXaOPPO5V37JCxeMio+ui3SYq/r0C99wTP+f
   rD8PoPxJHoPpuCx3l1LqEjTqvOdi/0AYfA74UaPbt6qgdJcQU9IaKaXYY
   VDP+z5AgoRziGJgJXBkJSn2/JJDchZd21pU9G4WnCi+Dd2NDIMIWFzH1h
   P9v7aN6I2ITN3cdZQgI4vCCHHMIAJwW8AdQ3IrIq+hkc4wpn5slHvPjf5
   1TTDp7CqL1/J8GsTpabGKZQsXYqH/gmMAudwIxXHiHCX2o0PrLMq/aBpc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12631896"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="12631896"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 22:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="25348399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 22:49:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:49:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRpq53bmuBWZng6S7Si/f/nkn1CHCzij+DMGEjMXND0j3ybxMgaVaSx6nAeCTTKXBJmjznmQpJl9ovYTST/EivzRIr3DTm6EGEjHQrJvmRZtevpesTozNtGHDlkgVLuLJlC5RHcV9+lsleNwTJ8DYYx4KDfkbi7c4vP1qB4PfqnA5KKFeMVGazrJ+wbc94IKlg72+ICjqRHkaamMmwBlPXh25IFfTPo063KmM3x33IBRWL5ylx5szZhf7jEK5yIMkrtSvUXybUr1X5qgIIjovj6fg+SvwaX4bUhUU5jBdeRIRBTu+a/b1/WzTJk6U3JNoLePQiXJ8NxPQMNjmog/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDOlQovwp8FLVNK+NIwLufq8pXM+wwqqHIvEh3cVWfU=;
 b=ZajTv3PO94AVxEoJDtFiuWHKB5H5eFXYCw4AG+LyZKMJ7zdQ6qdVpvwCZV+NxZoC1ShpEy+mfJkwagBfoEH56eIVwDXlGgJXJuHsYyYmF62HYUtAFR4Z5Zckz0xtEgRfvfKeobNBlTleRHWK+abQayVb3GbX/5sEFDpSmdvp6FsiZUVHQ091w6oKbpI3BCYYyWU7Edf14GBI1AQdpQ9LfgFU0TB593AhUJqD3O2YdyYrlaToJC1DfhFUUYJ6U3oFKU9wNiumcIMsDIY8PtGr9oFym4duRryvLBWfLclM+jeqzNxrWAD7DQMeEpWf6WmqIAFRa1qD7DBtYBiIuURhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.24; Sat, 10 Feb 2024 06:49:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:49:20 +0000
Date: Fri, 9 Feb 2024 22:49:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 4/5] cxl/core: add report option for
 cxl_mem_get_poison()
Message-ID: <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 148c8eb4-4cdc-4ea5-8369-08dc2a04686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdpoeGosxqJ1MnmjAGPsBY+OCDf9jisENRyACPy1IdDfRmgTIoWW4wHLoV21Y425rQGD0pJe5pwaE70rpWAO4uSEYCng8frPioJbfISCP6xMnwEyXsRxg+Wcnlaf2TKqLHxXlok0Z491CY8rl6bxeGOMF/JnmUEOV+lpXca5ptqBuVVi82Xu8E5bYm6LsmV+pCZi5HPma51UIipdKf21iPFq51vI5ZQtQVulAWd2iHJNgJnymjuVSTU2IAqjoiBOsT2Y0Lv/ANNfy6gjGwfRG6VDWF04U9BNWx5N8yysUl/sYHSwQIMtXLPEZUfIBKx6CA1fP9N8vlZ6OVIM5kiG4rUQs8bOquJrpP11TYypIvph93fmP5cfKRVhGUBVUHOa+y5YWZkVRu3b6Y3JPS9OR9xgzqqGIOPOfXBi66whMoi4gjgy5phJECssn9xzjzAVDi9lEx4XShw8DfnzY05OViOtHZJmot6wkdFCHGgwsYCvDeJ/7TZwtEEMY+okeeEBTL/ENOdC3lCwY3R9nlSDwHjZf4n5y/jlF5TbMexgrAryJ0+wmZso2DBtg0bpE521
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(107886003)(9686003)(26005)(8676002)(2906002)(4744005)(8936002)(5660300002)(38100700002)(316002)(82960400001)(6506007)(66946007)(66556008)(86362001)(4326008)(6512007)(41300700001)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IN4Zag4ieah3zPEII1+mcTUdOUIf4jS+bdJLAQtCLna2oR7WTL2jAIK+oqd/?=
 =?us-ascii?Q?/aM/X5E2T6i1QXS+lqYzuZIup2GzfxaxS62ESk34XQptcRZ9/RVFJ712Or50?=
 =?us-ascii?Q?7wFFxlm86T/LYMQYU+jaLQCEVPsrRp8bmd9tUcj5Nb3cGkUQT6twdKg9BxeP?=
 =?us-ascii?Q?x7AJJmkg922AOOLnhcJF338XjKop2hYWEcQhv8epL43Wbpjl+NPA6B+q03pv?=
 =?us-ascii?Q?sWwIiOoRRhZ86f6iQpoId9Xdhwtjjl4ZCMLS0hWuTrKr7oAdenOPtiZeR0pv?=
 =?us-ascii?Q?7i1s2ftorwGjcaOmXknog+QLq2WyiowcpKVWWNl4WsVQx8z3P93imIBZ+djZ?=
 =?us-ascii?Q?DJNgbuaTq+jUeQ4Ox+v2rFFnX5p5EZuPJko+MGCOLlUqUKNrLWVpVXTfV1nx?=
 =?us-ascii?Q?gBimGnbH9X8rZo68eWF37meo1o3o0DEog81R3vLTSHIg5tqOEeeby2qug1v2?=
 =?us-ascii?Q?muptjGE0EMJOc1u36TnSH/vP2607iSzVi/2Z13jCQxv6UeEyaJdbC4zRghWo?=
 =?us-ascii?Q?cOp0dJhz2ven2xcBGo3cQ/2WKOmEe8/wG3+akOOkHeIQ27DkWYyNim4KbY78?=
 =?us-ascii?Q?1oU4l0eDFUsmNxl+g4phb3xkbQsbyOVfJdi6Q0u1votaE+z0Wvld4txpXDWz?=
 =?us-ascii?Q?7dIO+COdyDLj0imRNMzAz2YRGkARu2ws7uQGgtbycXlHUXoki6l/xOKtxFYi?=
 =?us-ascii?Q?kKVj9y7kLl1PW0iwM536V5v3lybUWGBPKWaJgMCCKr7Tvh/bVqIQlyojhShe?=
 =?us-ascii?Q?vcc2s/r5xb0NHkeEqJh6imjzGnoSL5Zd+EAwjPt/GmTLdcqYxQQpchcm506e?=
 =?us-ascii?Q?pQ+4gIoRomD5nhYGRdHYyJZIvlBQNc48KFm3Ht+vqZAp+DCf7LVoIyOJvRi2?=
 =?us-ascii?Q?tvHNbtomMk9EruwFWwc+1zATBFmoOE2dcPNSO+P0U1H22Ohb1oD+7U2Kab7K?=
 =?us-ascii?Q?tatBJ7zbPuSxLxCk3TGIcu3MVH0WFpP1MGmmW4FGLDIiFdd8rJ/biN4cwSD+?=
 =?us-ascii?Q?XDv1LrabQ2CAW1Z0wkkn2yMPFdslyl1fFnZrosq9RNbSm1+RmTPkN3g0gC/B?=
 =?us-ascii?Q?0bfb7JZUMojEcLQDhBi4b1fOJaVwjRRIVGZo8sJ4UH15F5uBqvrJONimIuKK?=
 =?us-ascii?Q?jEGT0n0QXSEaXBjKkGeiAc0qAkn1XQldGQ7armsICvvxIfyUyceXskM8/7S1?=
 =?us-ascii?Q?76yXiUDdrVhEQ36183BAHZ6gnIFg5E8c2CtmriQ30D00Ar/nNGzAedJXaAvr?=
 =?us-ascii?Q?qAE6XrG6lsA/D4WfGDHYtAcEfprcx3Hxwbi/e4SkXyy25hqwyHeSTdR6wxZE?=
 =?us-ascii?Q?oJrqJcOFEe8+Q79q1eeAXlFlOdN0yLA1OdImqe3D5cgcaIcRX9tvx3aES95e?=
 =?us-ascii?Q?nMuBwWZXup/3UJbMxc2rEuoaYnO62ylIkCBXCoe1YlnOjaSB8F2JqMcxeNEl?=
 =?us-ascii?Q?AGbpoVed6UvXh1ZRX4XL0Z/c5ACN229qMn3KI7C0VHHOS0oFpd+A/lZEnj8j?=
 =?us-ascii?Q?W3Dtl/Aqp9Y9C6laOsAuuHZ++wDdZRybx2M7Q0DSEz0AVDagDOa8QU/Swtrh?=
 =?us-ascii?Q?++3YASfsVTyritX7665Un3VdOWyda3zvckuGa/TkF/7D9SQz5B5See/oisC2?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c8eb4-4cdc-4ea5-8369-08dc2a04686c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:49:20.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOsdVmEJ5P2m9IwiY18uIfAQhY6E3FoORGoNcFaDMy67XRCEvi9hIyJlAZwUt/MZGSxF/4rnRtv2briocFlyJOMtmRbVrMQ3qu5c5u/QixM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> When a poison event is received, driver uses GET_POISON_LIST command
> to get the poison list.  Now driver has cxl_mem_get_poison(), so
> reuse it and add a parameter 'bool report', report poison record to MCE
> if set true.

If the memory error record has the poison event, why does the poison
list need to be retrieved by the kernel? I would expect it is sufficient
to just report the single poison event and leave it to userspace to
react to that event and retrieve more data if it wants.
