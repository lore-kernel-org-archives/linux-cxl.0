Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A1C54EBD
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAFRMD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFRMC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 12:12:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F3F6145B
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 09:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673025121; x=1704561121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qE7X3cfJ/3BcaE7KEPFhgMAUSvYOMDzecFR5FPDuMMU=;
  b=T/yF9/7eWHfIOVthkUufvn4Hj3J/GgzfEk2JB96VK3sg2izJhplk18T0
   uQVSd2IMuGWU+MHtYPrQIBQPiRbNfQO6hQG3BumzeKFNiDLTOjPfKF/HP
   ZbzcW+deJSlpuzGbW8aO0vdl+otCntzNeuBpLuKbdmj9cf+t0NJ0DaTuy
   erdJmWqsH0hlr+snatq/37dgSu37riuncMMQEJN7gs/e9Xht/5EJ2hlvt
   UMv5zr7V1uFmyH4UGrbA3rkaGU/DEelWZ9ZcHJMoTMNtB63ltmcQHjfMD
   DByNMvXVmMm3s8lcD/21V1G8oNCrUhwod9h+lEXxWEUTEKrsO7LhjqYXo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302215051"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="302215051"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 09:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984720884"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="984720884"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2023 09:05:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 09:05:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 09:05:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 09:05:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 09:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uel+x/TNElKa7yRPKKxLqBwPdRyi63Uy3BCNmxihWi2CQ6pXS/q0brviku0rqj2u5QgJN3SloSvOGgn4dcPNTTmqtiLBEWKQQ36VjW08pHqxxIH4ZgMy6r80S05ld3b4igVFcKSmfnq66QbxkiPk2/2MUUMVDt19CuoEiJurIi6TdLNR9Ur5Fm8AfHpBKC1yB5lHxu4agR3D5iUaxUthPX1l7V9/6N3mUny/Z6ly+z2Uug7H16JEU3s7l7qtK6AIPU38sLFz1oand+OdS/z4VZhf9FpmzFAZhsP9lafP6P+n3z46VH9b+eSnYBJMX0haw/jxZ5Peut6maYDzGDv9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I78cyuAMH9QZ81/l+teJbcKbxtqzDs2D3nDVfNlr5e4=;
 b=EFvR0ao+CidRDKzY/xlqb3km6hAjdOZ6Dxjqg79o2FfbTCN2dOxBv1b2XE84WenTPmRX9yiJsSP2u4dAddalD2E0D0Ca74FBcjZLtFl4TbtdiNYfpsbbWK5/Ti2RrwClq3P418XbdlC4q/wQllsKG/NoYzp6wdB9amnYY0AkpDvhlcVDIQ8IQ/1ZMJpFbAyHhDd2NiTwR+EN2eoqXYuoXVOO1hNCMYxbumgf/BcLvjMpkMJSYr6A0AAq6Wb6h2bCA/iVODa0ym586onNch8zeGwTDF2ZI3Qi9VxfmXeJcSy5Niog/vjwec2V+p8YgXTdS/rryJ4oindevdCaO5rFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 17:05:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 17:05:38 +0000
Date:   Fri, 6 Jan 2023 09:05:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cxl: fix cxl_report_and_clear() RAS UE addr
 mis-assignment
Message-ID: <Y7hU3qxkZpd4/Xf8@iweiny-desk3>
References: <167302318779.580155.15233596744650706167.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167302318779.580155.15233596744650706167.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7b7d7f-61b5-40b3-7bf8-08daf0083c0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1YNi1/8BzNvdiMr7C9qEa4Ir/ifSyc3iVau2cpXPjT0lOXuRNM6c7Ea4dEwOMC1Juskp10TI3VZGS2H9X/3aFLbyv/ExHec/vmZKyfROSCaUmEarm3FCAq4ZZXJjV/LOS9DcIKLmlLsLZC6naxAXzPHmAWAl8isnv+D0gA+fYecZwsTTqLYBth1XpR6XiCszEsM//li9J0oZDnQ9ZdEDjVtOROXim9i2h1g3cNQWk0zGcojc6vcc35uzIb0xc5Ez18qLF5WZ+LXqmKaDHIq320JOpY+NZCCHby32SaSFp+CcRWkVjNi2bCEjMDvVBA43VnfUMQMxNmRuK6GLuGCWQ9com/QRs/viEIPX3wgBM2rfhOR2wdDi4BciTfdGyrky7f8nhZX/875HzG4MLvVm0APQhu+wiFRlPCNGB8l5jkqtfIgsl949hQm1D4azlKs6vAWdS6A/tgkxK4PJIlJRrmjpxMqjv0iJvW9XJXJE0MLpiFn0cEHlH7v4TqTyPx7cZZ/biGUQbLMg5Jjvl5H7uhbnQQLK7PLg91eStpe4y/RvdbV6aGsGeVzlja37qsbVAbd5gBbA/QbLkXvznY4kHUpCASLNAkwjceBYhNhpGQbOTy7ZX11Szkai6vXu9NoGBCv5WooBeq5G5JjQRHhGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(33716001)(83380400001)(26005)(9686003)(6666004)(6512007)(6506007)(186003)(86362001)(82960400001)(38100700002)(4326008)(41300700001)(8936002)(2906002)(5660300002)(44832011)(6862004)(8676002)(478600001)(6486002)(316002)(6636002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxyO9xJuM9kYq85zdA67mBuv4gCPb7BccG+1ifzw0bxnm08uakbuarIH8Kyn?=
 =?us-ascii?Q?mQy+zkTYRBRyCF6vBXok65MOPEHYjksaPmeW8gSpv1AOtqffs1dCnc1OLGOj?=
 =?us-ascii?Q?YNM2Usg1dKfp1+IWSk/pox/kLjgPRv/oPZ+jy05eAU4jiZkyP/w9gmiS6Mxa?=
 =?us-ascii?Q?+0udaYVEDkCm9oL43B8Imrk7gb8b8GjnIX/4H8Y+PLuHwyCKVfnF+NrCxFjc?=
 =?us-ascii?Q?EJx9+CwqiCwqcl5nvSnhH5VDqwcEu5S0KaX3kgNocsfHX7rkzfAEkfq8xmg3?=
 =?us-ascii?Q?AU5S/zAf/0vAIiy/uawMst/JxT34vs2Dr3ojhV95xjNcNwh9daEZey2qaU6p?=
 =?us-ascii?Q?nR+0/XXWe1Kl1GgjYzyv/5v61hnwDbCv9MdW74KXYZ+vnk/ivJqG1BpN7rgw?=
 =?us-ascii?Q?Mwz+uAat6wGYfiMEI5BjKb46segM9IalgWzQ58iw+FrwHpTo186/OMIx2qb7?=
 =?us-ascii?Q?rYnRmdtx3VTL5/C1HVTolln4rWeLO0MJbbDz7NGHGJm7ZaAUPo97UQcoGcKI?=
 =?us-ascii?Q?tGZdrLWBf60c/Rt99TMdizL/ZifwhP1sz7oYGwBjPz/69wExl+xZEOe2sU4X?=
 =?us-ascii?Q?J5Xrbk1GLIQxhOa6Gqm+KtZG4vv8XaUHluFkn85tKWi4n0dyswNK48s2xeqr?=
 =?us-ascii?Q?TZLYWeSm/1Y275f1cgMEKjc9uFd7eXDii9xMxDiI+tP9mnoRRtBSaWvxEIoC?=
 =?us-ascii?Q?ZCTDT119es80sZI2euB1tlvPBPnJTObUNWLY58ZonuTLIujCrGzVGBwKK/81?=
 =?us-ascii?Q?yH1/fTcygvBnsnqV8koa13WTZW0160pmeME/jMJYXWLdiEWV1LGyFjA0bgvG?=
 =?us-ascii?Q?+5nmfxW7P4OI+fUCgUWsqpk6oRLmcUgol0VUgb4L+nMcdn+gaB8/I2thg9uU?=
 =?us-ascii?Q?csqYwDqYmRRoWgN5+ACgdXy1LA0N8D+IjrY9KX4dDgtvKONs++Ar0QVViLWd?=
 =?us-ascii?Q?Q+EzPIOcHLEelG2sH2S3GHOsge4IDaWA7PWc2Bh1NEx9w/NnaBcN6mvCo29g?=
 =?us-ascii?Q?zNEHuZIHfV//reHAzbRESi2KodHFsXSU/mZqWg/b7G7RTfmtW8nE272mnyZs?=
 =?us-ascii?Q?Q1qc8SxiYK75QN2aiX+UiqoK5BBI8mJlJ4ugSwE0bbG9IiavyEQbkt9gySCb?=
 =?us-ascii?Q?Se+OJO9VsL603EN18jIfuap0ds8M20uS3faCqGz/sB3/8dm8xi0myQm65Xb3?=
 =?us-ascii?Q?w72eHq9ZHR1ETJTjtQiRDXKiw3zNyqYgErFCTqAShNi9oGKRAtj7ZmS3GC7F?=
 =?us-ascii?Q?OrBzFXTlpGh5Y/NRUHx8L+G49eQ6EBVqJ619qXcPkfDbA+7KjA/EnbdgQTN+?=
 =?us-ascii?Q?PGed2fE/C43Ae7BHZ2q6dr6JVDXejBJibP7FpF2MJZ0ylLDzfh2sKKXobp4k?=
 =?us-ascii?Q?B55ctkM1BK4XICe0DI+wCedA/WJRJe422WODjMNC1E/t2F5Hbf1Fo3R6paA6?=
 =?us-ascii?Q?F+LVSCOqESZmTsybt35kE2bE8vpdVXa2CNNldOYPRoLqia/OcqGuxJzRI0Nz?=
 =?us-ascii?Q?FWzl5E7TqLcII1Qv+90yWslb0UlHNZoKVYthCCv4dyhTADxsBqaY6RTufhzK?=
 =?us-ascii?Q?59X+4zFpJZHbwccZ1Oi/3aNu85Xe/RmageedccKbIml1nFzZ8kGf23JXJEaG?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7b7d7f-61b5-40b3-7bf8-08daf0083c0d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 17:05:38.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X/2y2eXIRzsLcWtgGw6D+KBN9jq9qeI1J2VfIpzmwCxjiLDAEr+PTmKQWaMIUW5S199tHmyAHQsXltKyLLhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 06, 2023 at 09:39:49AM -0700, Jiang, Dave wrote:
> 'addr' that contains RAS UE register address is re-assigned to
> RAS_CAP_CONTROL offset if there are multiple UE errors. Use different addr
> variable to avoid the reassignment mistake.
> 
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..258004f34281 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -554,8 +554,11 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> -		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
> +		void __iomem *rcc_addr =
> +			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> +
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   readl(rcc_addr)));
>  	} else {
>  		fe = status;
>  	}
> 
> 
