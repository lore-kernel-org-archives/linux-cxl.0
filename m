Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4045012
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598000; cv=fail; b=skgqGEMco+WVrKF79CbgZTeA/HShA3yTFKspjtQNJY6RhJs/dlGi/sPzFOMjmwRs6Ig+8b5mET4H8AEQUUfR+3gXzwHHyTo0SyaBCbTj3tU4UcKZnhX5GF5z1Xc8JLvoqKkT5DXpN3Ij83FZtUGxUMrgPKW+0x+i9BGeuMGk2uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598000; c=relaxed/simple;
	bh=k6t7oi/Y8bE/Zasud8cIpjIwJC7vZB8/Ik04/hNUXnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUUCkVxyqIevIh5+SNqpwZHQ6LSR7KFosdaqHYkI3f8msldPQEFPqRM5XO5uD1ugilvlAzWttwapKO8bo84B0FmMavLZEGv9DPMDhVketLEWvACT7sEufs1bG1+4+MrL9m742mG3XnYLZB30GdAgUTcm0rYPp0ASi5DkuPX5zL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meHacXT7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meHacXT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706597999; x=1738133999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k6t7oi/Y8bE/Zasud8cIpjIwJC7vZB8/Ik04/hNUXnQ=;
  b=meHacXT7c9zMsGjXl1VhfP+lD4s7ctZLvSgGc2SWxB0Frjx1GEVixqhx
   HZtl/zTt5MU1A6fuBKBySgdogUw5Z2VR2ntaTMz3QCBMYt+6+9tm/ROXv
   BAQO4MGM02bvQSFu7+z2pPAE44m5LEkz1OxGmDEEqGUYQp3s+wSGQAAHX
   dHGvp9hr9H3aXypWrUgwc/sJsf1+Gz48yClKx3oYmiiyC5nsejDMmwmxx
   1cLaJNARJ3UjJDIAuUy61a1PasKt/9nLRwt1bJfwaaxyQyLzIIP/ejN7e
   hKhsULfJG3NL29XCZwJCLjtHZkkoevzKKgIMvIIiAbl6iVWKWsJCO92uQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9827398"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9827398"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29792469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 22:59:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:59:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:59:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 22:59:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 22:59:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/aJm5lM306hu8XUwVfYFgUw5w6LK3PYPtZhvv71buBxgD/e+PiHlIaRCnecmOejaP2ZwLmNxERWzApqFbzkB7xAqMDeygfoLJLFLcfEsZdple+8U42StbNWWU2PNFjEZEyH7lRiqIwsPtFsiVFL/n78XogbFa6IFss6Kt6O+9QSLynqp8nUGIk5oFAv8JyEQ1B87sDyCX44gQspmRXchnyVnDSvbYQTPInHIBneG/ZjtFExpv9hsozylk8/KmdfYTN+gb8pw6htQCg8rjxx31uAPU1y80qJ/YHlR/DA999ZV6xxwYbjHEmYIMDHfKcQxEP/1VVff36Zju0qxpn+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdpMZMefuz3cbTfgMHAAUJuBmeGpiTzp904V1+RpkLw=;
 b=NYGxQVKbLICki6Ewqc9BLUn6mc2atreCNFW8Dh5Ggg7SUOqYkAvGMi+9pBitN1HyJDUPAHIUj6FeEEvFwbGZSfBRwXJUmIdc8YG3FlFzvY3fvZAltTEI9J14TAjnOjrMtkyWPdvm3lQT0lw8615m9qpnjdUf3AcDvv52etueahZa2GJmX7JMRtLi0f1F6dyMSiLwNZiS4aXfISy5EK0R0m+2/MFwBwneDKeK5CAkPxqDPkgBSiXJq/HtbS/Z3A4+HKD9gRMqAK4GFY2iJYV0iED8xmhzT51eoHt8GEAZJR0gpGzp93USFG/Os2ugKEDpXX4ATY5T5ArStoIcKvImDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5410.namprd11.prod.outlook.com (2603:10b6:610:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 06:59:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:59:53 +0000
Date: Mon, 29 Jan 2024 22:59:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Quanquan Cao <caoqq@fujitsu.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, Quanquan Cao <caoqq@fujitsu.com>
Subject: Re: [PATCH] cxl/mbox: Code readability improvement
Message-ID: <65b89e67ca4e9_59028294a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130055844.19811-1-caoqq@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130055844.19811-1-caoqq@fujitsu.com>
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: a5608503-7178-4bee-251b-08dc21610f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGyi4p/AE4Qlo39RQwGcxaA9WfsSRq/KX6rbILlLkfmPz/WY/B2fnSAxFYvRA7zTEUnG1vIqixH8uqV82N1XArxuQ4fao//fWob7yfV3GarnDX13LnMvFCwgVn7Wiscn8XKActRe0Jbjh2+x08pP6mh59sXF90Se4/3vpWuX95VQwbbOHK7mvvMaYpwLnquDHKA/CXEaBGHS23aHfCEHzmsM+dJvgepBt2jHwQPUDs/sEIH5GaeaUArat+0vvtoi1sw2ZqhIwH4StUv524dfWcYQ4re6Z43owVhw1Of5xns8sgUh6VZH6OGKeS2j2Qr9TjLU8gB7UKvIe/yhz1i6vOpzGI9epXup1tCavPijoJS+nfNx3AnhQIcNgO7qF1gu+L0046WeqfI8pSnj8y6GvhivqoQ9Ei/4musEqZ9vMXY/TV3qT2kwo15QfT3n5eK8xs+1IUUYe0QhisQqpUL71rMPVrAoJSKqSrbT07WREEs/Gvv/V9sW+aBtra0xny3ibf0knldGNkJl8MkeNr4Nj0A4cdLMCF6jyxhOf67PXgr/BVJWoRP7x9Z6DMN7zBlR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(5660300002)(86362001)(4744005)(2906002)(4326008)(8676002)(8936002)(316002)(66946007)(66476007)(6512007)(66556008)(6636002)(9686003)(478600001)(6486002)(6506007)(82960400001)(41300700001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHddk/iUfSuDi4lQSaeuEwsfUJVlSXq7jAOtBOrbMfIiLWJQG0KohvGC0R6x?=
 =?us-ascii?Q?/+Jhhd9k171VTR9YgKO/HdA+++ClhxkKS4JHae2fWGQAk8jfURJIvHcsBkX1?=
 =?us-ascii?Q?9LjAe9FyFlo+vfUApwxlHvYscv2HgvKqkqBW2AHzIWvZOnEGXy7ldVPod+jv?=
 =?us-ascii?Q?a+XQmHeVSZL9ZqwslASwYm8oZgCX/j1wN3QhA+eOJKyM/8YEUMRsKLaD2cTJ?=
 =?us-ascii?Q?0IzroYRxCKg8nnA9b9NpS/P4huKG0bfBBX6aIMzQIvG+WrN23yr9DRPQKwFM?=
 =?us-ascii?Q?dalsPvovNTHKhKkCCPkANxgXYvS50ePOPp9pALePWhpt2by7nZVw21sVCJKK?=
 =?us-ascii?Q?hVnf1uewdK08RPb1jrzUUCRZEi4ZM9yPYGln9ppVE7PRqRr/BQjB9jIS4UQn?=
 =?us-ascii?Q?EkQC8rz95Qmnqf2V+tV2t07w2o6FoR0Z/QVXou2ZdKt6ycctqcbCmAsP6wvh?=
 =?us-ascii?Q?OP5t8cIDmbpxtAsgdVFMQ3iUBN0+YZ/7yw0x1cD8Z+jA05ORAJBbPRkmWC0I?=
 =?us-ascii?Q?LrF8LRrh/q8ara6Qqr5NM84WhLIbmAH6J8HWug59C5JBZxzbtsl7Rg30uRXL?=
 =?us-ascii?Q?3/gp7Rnxysa6a0GZFLSkDfTKx9nxkHxjl2xVUxo7O/huJFeTC/e1e/wOQRuQ?=
 =?us-ascii?Q?OA6hVDOgqXTUwH7M/QzICqV7PAfgFxdH2z0CWBBVotbtyQ2oHndr9K3fzwnG?=
 =?us-ascii?Q?/o3MD4Z1HhdvANAfsCO+0VvvQvSJL0lI+RPyNVPT+qfac4Lo9LinLO9SfS22?=
 =?us-ascii?Q?g/WrKZgHTysIPQeJ0oHVb7UhfJyd4mF2P4LaZoZXQTb/rulOR1xXORJomoiv?=
 =?us-ascii?Q?ewI26ymG+WKKMAryEe0i5tNRecULXkQUuMh7JUjlA+7Re1mF2Z/lCiJu8iDA?=
 =?us-ascii?Q?Niop3jhSt7evmZllmPqSJ5NTN+Xa3doKrBTn78ZpdJKWlDgq/3xLJUC47h1X?=
 =?us-ascii?Q?FkQ6lqmyerBw0IU8VjbgzST1qtLIU7AEA0ukVd3426HahpBu4H9SdeJ5ib+Z?=
 =?us-ascii?Q?lH179L0g+5xBlrkaehLOBeyBtFRRVl6YivdD50HtiyJLyDBHgcFLPokxjGpf?=
 =?us-ascii?Q?cA8ZIXofRUF7T5kgt2iawKv4uk3V5azIjUbjxYdHlsgQ2+gxlNHv8O88A8Om?=
 =?us-ascii?Q?KRTa+UfhrB2qPze3vPjxPtPd2QAvNEDgjPP+e2JBSSZk0GAicVAHCMXnHJ9W?=
 =?us-ascii?Q?oVatwjDowO77LxNrcfWUWrzeKMFBxmI/J74GVnkSafjhP06fXSKfpjW3pDTI?=
 =?us-ascii?Q?qZ40sZ8PwrmQjjpaMd7KvF2+7Obp7n2g8VQfRMK13+mGYKJYi9MrPuXcSAMk?=
 =?us-ascii?Q?/ptZBbc0T7lUSyBuPDEdkurGC22FIT6aBySP51R3P4JN84QsM0x5szVNbaW3?=
 =?us-ascii?Q?rMei4mTYpvsU1Xl26CCU5jnoJbZX82d8NgNdigpvlXUrImb7mwCw3Xt3SWxl?=
 =?us-ascii?Q?sBHAfKL8+IC1EIr5jw7M+9Nomu4PeR9rO4Wr4PHuxcnaxbycAoni5S4BCHuN?=
 =?us-ascii?Q?4Y+jktFLVysXFhFGEdJ9qXNfH0rZ5VMC/qjKeXGnPudUwB97f1zu8pcMCKKj?=
 =?us-ascii?Q?OEChP3pQeyp0gzLlvz6mgxEUiCWgfjWm/Wdhcx1zuYd8jyeMCplutBEuX7P2?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5608503-7178-4bee-251b-08dc21610f8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 06:59:53.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2x0PuLKBmBFtXBEaWw6FCVdPIMrjOpTnobbvhKDLWPZqsWmEE2Ju39q0/So/3Lb13/Pyg3t6qs9w0xYpqXfaPGKLp+21Gtaa2D6atnxqi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5410
X-OriginatorOrg: intel.com

Quanquan Cao wrote:
> "send_cmd->id == 0" indicates an invalid command, so replace 0
> to CXL_MEM_COMMAND_ID_INVALID to make it easy for reading/understanding.
> 
> Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..2e5ee05011d6 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -485,7 +485,8 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>  	struct cxl_mem_command mem_cmd;
>  	int rc;
>  
> -	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)

"non-zero" is readable to me, and less characters to parse means current
code is literally easier to read.
