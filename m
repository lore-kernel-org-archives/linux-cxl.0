Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230C1172A
	for <linux-cxl@vger.kernel.org>; Sat,  4 Nov 2023 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fq/h/hXT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4FE0
	for <linux-cxl@vger.kernel.org>; Sat,  4 Nov 2023 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699128987; x=1730664987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oVmNTBRI1qwGDIEmAD7A0V11rs4Hob/grrJZmVtoeBo=;
  b=Fq/h/hXTvat65+ma2NY4ZGFWaRT+cA4AdQfUJCHrSs4OfNka7Xw4Qi2w
   JziSFDrQS8XH0Liz/du0PMehoo/a/LZpBgk7f6ASV0kExs7NCwufplGaU
   CHvx+F7TeAnRY9Sql48te1tvh9rn89T6wLZVwGdXNNkRhIG5tCX6xYlzn
   //6uSkUjfCFiPXIgysc00ys6STwGXDqvsTih92vxksu0UHX2OdGDKxsab
   E2EJYBOelwSBfDlWZPQE6An8LUOnwhL2BExHGkOdGvIR4D6Gmnoy95tFl
   hRryUK85bRlR8tgCJg86y1CAN2+WHXz+cpLE7Tl9NsV5KIK1HaT+hVj5W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="10642964"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="10642964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 13:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="935426662"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="935426662"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2023 13:16:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 4 Nov 2023 13:16:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 4 Nov 2023 13:16:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 4 Nov 2023 13:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSE5ILuXjF5ERjrRc7itZoSR4yiZympR1m7Ql1Tmzg2WSsbHd/GpW0cuyX5Ts8khBCWGmx6i3XXK/rRq5ejSRvsUE+teOjCNuQ9UOYKOJr1beV4cK6eX5hJZtHwd1KV3c3p4YNE33Qut3+ex1CcDM1yO6GwZzIXPSrvmSjd2cdg3xYayAl8l48d4KIoxt7DHE41b1N/pZmBjaPSCGSQTOOw80oKkx94THwKQBfoMcUNZHX9vfBPiQS15Bet+1YoH/T4UmHt2PpADEtSFVTF3BYvD7dHseMhbNe+SltTkwAZpO5Xn69NAib7qffOS6BwGiBQ+wEHUK8yOLt9IJP9Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFl38xYYgJbtdX2MItnlLF9lhODh7KhMfbmoQNk/u5Q=;
 b=mqyzyEXzL49wGELWDjvvENTrl1AKNFWp0ZV1+apSL5uFXd/p1JrBJXBWMSNzIaoYGwI0mF359ISsCRF8TDd5aXED+KGH6UMPsjd8zCGet2LOR1RC9+IthMZML2wd3iOuz/UH2VuGWjy88E8vKvYTW8Xz1T24CZE1Okh0q98qbNgU+NwI79bz9hGbj6ontk4+ar3p2Uq81Eh3iK7/iH0Amvo2QApEr7MZadxjansl6labsC2u73ViJLsUBi3gQjhV1tCkIZQeHrUaUcbn6Qpk+75eLin1Mw3oJPWe3nrT8XWD3z/Aq8KlGugBTzxhAr93Z/HhiX643KTqKQ+pF33AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 20:16:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 20:16:22 +0000
Date: Sat, 4 Nov 2023 13:16:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Add cxl_num_decoders_committed() usage to cxl_test
Message-ID: <6546a6921b1b5_3f60294c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169903435790.565298.13848186970380289757.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169903435790.565298.13848186970380289757.stgit@djiang5-mobl3>
X-ClientProxiedBy: MWH0EPF00056D14.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1c) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aee0018-2eda-41ba-9332-08dbdd72e8e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or3rU1hU8bkGpEH6ueMF79pm0Ys8Eum7fc3twyHlCzXW0bw2K1QAsNwyCtg3zt3ubs2wiYZUpdbI0lQHPeJ8ga2osgf2LpNcZ7t2jCpgTL4ghQN3/zMbh+pFMZN9o9ZFYiKjOuv/zFeE1nrvX61YHHZ8Bj7/lkAwU9/ANU6fehKd+4xZX+rUHNPsTmeqekkEsCl8VuzfWtADeH76PtHWJfhxZ1zF63oFlIGIH7zDPeRRAeJ5jiv8IioHXrmc8KOsAS2yvmm3PQGhDPgbOFjRmDmuUt4SV+3XJixSMwpJZsm+HFKjjiv9EiSMriZa2KRSlLph4GUfnQTE596CLqfoQNvqF/2dszZojbZpOoPyYlD3XwA3Ym6KuEQZb/RSKpELsZrz8MX3yyhMW8oN5oW8f52QjCRjU+3e8Tle4tu34HtHO84bUJCXS07ILDKuEPNVW/LTjW+BTwOeQIOCuYSL0ykOhVovzHDROcr81Inr3MTraoI140xRWMuOyeZNZ1dI9kmujZb/U0n/4NtN+/fzL1cj2z6d6UcimCFhyx6O4T/7oyxZRCnO652kdRIxPWC3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(107886003)(9686003)(6512007)(86362001)(82960400001)(38100700002)(83380400001)(2906002)(5660300002)(316002)(6666004)(26005)(6506007)(478600001)(4326008)(8936002)(8676002)(66476007)(66556008)(66946007)(41300700001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5oU4dqEy7NMv+g83dfcBB6DmNVvDVQ6GDtQ28GTMXWOWgFlf4MSMHiRPcT24?=
 =?us-ascii?Q?AeIdn8ub3J9+7LbbQ5x1ZneKFkvheB0xrCVlSEuHiFV5vhNFUW4N5IDO76Y0?=
 =?us-ascii?Q?hpV2/PToQS+4HQwj5LNHbgw+RQVKXJ+vuci1oTldIlgVMAqYAtKvg1jwsMfZ?=
 =?us-ascii?Q?gbHD/qvQScunZrWfD0EvXQug2Y4KvdVDUNw5vDcLqX1k41Hl9pxZycueEwnk?=
 =?us-ascii?Q?I2uVJMRHCSFzq7tVK24EhqjuBxJAOkr9KXHoUHVvGiKSXO03AvNy9ikApxgP?=
 =?us-ascii?Q?Pp4LnhnDkj1W9DHgyTYCqIvzCiyWpP0snf6KB3TRa8lNG5AHfrzyoswZacRf?=
 =?us-ascii?Q?legc+IuU95tTnoTV/tDZnctQ7qTsWiF38bYLmpF9E03FQ9c54A2C0IbkLDsX?=
 =?us-ascii?Q?eQWvzdICveI6xHgiFkNtDu3VGrfud3bOl8EdWcprlmPbM47Re3RF04lrQ+KC?=
 =?us-ascii?Q?WCAgTp+BHEM6hc/Z1cv8CvDC7aeWq5ATBOKVdIamWAdgMf9cDMaWqLh80g+w?=
 =?us-ascii?Q?VF8fIShhrNdw6t31E31+MmKL1/ro8vrVFYyzsozLT17n4mhTqCK7ixwK+bQ+?=
 =?us-ascii?Q?ljZWWCy1Tx7dqEunHt3Qp7/l+5Qi7sA5ow1i/cTgidbx2/f05gZuURNOwtrj?=
 =?us-ascii?Q?95n/vibf8xiTYujxPen+LLW6eQHQL+gp9e18GBJH6SnRUW0M5BGOBLhWbGLz?=
 =?us-ascii?Q?tpusy4ogWpCmCqmC/wxWZpabm2C6zWX8iOi2SGxAe1Eli7ohINd/Jm9xQIFF?=
 =?us-ascii?Q?rF1XKILhWNICiKXANPSxE56STti7V5PR6aFwt5CRT4o+WTc7xJSOp8XFWPKl?=
 =?us-ascii?Q?Z6iUw+H+k7YuW37ZIDONRlPgHLO4J11FtS/7QqmuXjwNyePUkrIW4J3suulR?=
 =?us-ascii?Q?/z9eeuAGPaeX7/obSZ5Tlj+MjOqxyOwID1tKuDRtuDqljwlQSLeiK/a1eDdf?=
 =?us-ascii?Q?aUCN7nn4Kp8frn4dp8F4WzALAfvAV71LYhZNp3g9ePefyV+Nt07hlGxH1fZZ?=
 =?us-ascii?Q?FZmPYJDP5QK8AYVcTUlLLFJ2enhsUFPSCEB80C7Y9EJ1WV821Z+5eCfFDrs8?=
 =?us-ascii?Q?b2DQYUCYWDmTQS30J8+tWV8yJX75O6OL/uA1d/abDiiQ8OfoemI5NtSmt1Ru?=
 =?us-ascii?Q?jwkxIpiXrvpGy6YrdFLG2Z2onlW6EeoyAPxOohb15G3wViVetPJa2kXrRCxs?=
 =?us-ascii?Q?9xqU5Ms4LgjLupms4RhWc41PjoCnqBWCzHgD0eK18GEGPRdCrn5K8YU+fiBM?=
 =?us-ascii?Q?nrIHVxFIUVD+ufoZud7xhvuDuBSN79dxr9zTYOXLsxEuGFAg++p1VNMhCuvc?=
 =?us-ascii?Q?ohKtzAJ95mFLdTypZB2jGi3UYENx/mSzCgcrJSa2OB6uTNNn+vp3nTipRdcI?=
 =?us-ascii?Q?rntDqMsHSYrX+u4ZTnG59cfCirMJO9B+IIQzkKRkYE0RU7NuWQP7q6kQU0d4?=
 =?us-ascii?Q?yZNcvOCLZNtNQIFqzLwDlC/fs65VdtWpyN2f2S0tRCnFVsLRKOTcD6yy1Usn?=
 =?us-ascii?Q?VqrotpxMvFGKE09+9J/H4lnBf9cOT1/OPo/IMMpDSnuGmsO8+jvmyVbxJ5Z0?=
 =?us-ascii?Q?SGFn2QDWMvVZNxgy/sv6jBnmVT3USpfYJ21vJ4a39tXmcnKhFpuWW9GdZMmc?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aee0018-2eda-41ba-9332-08dbdd72e8e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 20:16:21.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaEqGXnm6s0b84vPRjR4teuj7vXdyKdVhnES+v7Pd0h9Lrg3m/K9moHV60Dyi218D6BMKna/2LLvs4kn1iUINgsPCIuU+BQYwr/qn1HOD4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
> conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
> replace the open coding.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c      |    1 +
>  tools/testing/cxl/test/cxl.c |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..26d17c205408 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -43,6 +43,7 @@ int cxl_num_decoders_committed(struct cxl_port *port)
>  
>  	return port->commit_end + 1;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);

I don't like the fact that this export only exists for the test module
to consume it. I would prefer hiding this export in the modified
cxl_core.ko that gets built by tools/testing/cxl/Kbuild. Perhaps even
refactor the duplicated code between mock_decoder_commit() and
cxl_decoder_commit() into a common helper, but in general try not to
pollute the production code with cxl_test-isms.
