Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1vCOupj"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B41A5
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 17:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704142; x=1732240142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0fCLCdGPAS0Qr/tAA0jqqDudWHJGqK+6F4EQYZK4Uro=;
  b=Q1vCOupj+QUVnu/ILtj4GedP70PQ/7Hb6EkQaIV79+bM58Cpx/k1mDgp
   vlTDrTbZpiEQyCkAQjKH99D1pV8ZQB3n6agNeS20NXsdHyACBGKMY0YrV
   6oybY/40e7LVlgcdbT743OU5J0xc1OREHgkR5ZMX6f4oOFNiRLCXjXjDO
   YrGghU5I61KW68PNauI4ZfGVLRljprCmwl+7wMrrB5SWzRgmTWuIzzdB/
   flhD2lMD9nrSLGhnep6xOiIvwedqAdtIRWOy8Ld2lfSkGVlIjbRzDKcTP
   8E1WDG8AZy11WhDXMk+78Q5ThzK0L4M/8MVj/XrTPal0hBb/R2tBHKuzY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="391952439"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="391952439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801909003"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801909003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:48:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:48:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:48:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:48:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz7sv+te664e0zFJE1ZVCxCEzpGJbJv3RRFUiVYY5CgLA2y84dJ9f14vqBM3jfGTlymlAdxiFx7kTxSjWwoqtN+cjB8f34g69dqAWw8ZPYC8mxfNHKtpudgyprer5TBJGdSiKBKQ07WqqGBmg2jSdTgtTw+CN444f1+O0KPZ4zqZgzNB5/BCxwtwISbE1XnCytkGRhPSETHdLR4zIp8u1I5hdS6Z3UBw8iR+Flyhw2+cbXGsHca86J5C9TYDyfF69kBJALUbVyFbHFRfVwNOMTJoj+L5Dyt3X7vdP1lC1alNVq9hHF02bL6O0IsILSnJFbRcY2V13zUK072xLxZzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f640bp6SVaidBm1wjfKFmWbSgFjs1mifJa6wMzuFFB8=;
 b=Nr80a2pWXIetD9dA7YtLGh/RUiCNjtCz0oWb2pd6jGxW1jo8tPHjIuTe2vo3CEXrlwWuR2L+loI58u6QvXI++IvRP1jJUeTx5P9dqrTo1xykB9laYllROD+qbpq130i+LsQaRoh2nJCtp0Tj5JDmYF9rpvBvgu0p4OK64P3OX4xSGavEvez6BCJdsJIVfJ7wYSNdcdrbGxJN660whTb7CBrW4wtcliH9YxWbTTfGvQ/77e3DLlxIMUdSGeSAvvN1uOHh7Suz3WeMaOAIiQb2+ya0Ul34PwNeC2J77m0om/fvs71ypTnOb2O5YU825eUqG2DL2iGVeW+WIfLbZdHMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 01:48:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 01:48:47 +0000
Date: Wed, 22 Nov 2023 17:48:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/core: Hold the region rwsem during poison ops
Message-ID: <655eaf7d73e_b2e82943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114025342.1123681-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4ecf8d-3cf2-4e49-8441-08dbebc6552e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SifPkqWfO76uqEKA2rHXo/bTa/Oe758V4C1mAhKd2E3prBAhUmbBYrDT3syH9H2PBSwK0jvIC7Wj2WqpZuv0+AruxwbJUWICDfRE4jVilb59aVZD3gjsUDAeuLjCpqnh5ibSCSrbzP2nNb648sv/n5E69L5cLHfFyRSqbpddwyrrnfgfbxTcxm5tuoTHaaQTwvRDSmRH+h2e2TJhJGvMwPtxcc69qfhYgVpSwhVRsKzn8OUFXUTyieEMFtTg76/yBGmVzIWL2S6qOcCcC82CfTf+U7Qx9BRxT4feZ+RVGR87HIz/g+9/WiRLasXdGfg0tqIU76l/L9oLkXYALxbCCxq6vkmXlyA0ZpjwUYrIu//dbGRXpZ4PF27SK/nSRZs2cGF3zl0cJsNvKMmLyo5NwpDAqHZBlGtC5/68Pvl8aGfDAoxLT/hwIuZy/itbKN1yVK6u7Wq0EdWp9nmAmC8dQMGvB1Mi8Bp19sO5aLpm7ZCKqX0S5ZuwVygNcn0+cHSx0dM//LXji8hY6Xcl+a2HjiicDcAEkeG2Ge7amvg2nrnZKS9VG5/OLS+Y+4xBSII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(8936002)(8676002)(5660300002)(6506007)(4326008)(41300700001)(2906002)(86362001)(66946007)(66556008)(9686003)(6512007)(110136005)(66476007)(38100700002)(83380400001)(478600001)(6486002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/LrllaJ7vcOiJxnLMG739BH144UPgYkGbqTpzIZZkQibBUsQ2L/p62Vxm4X?=
 =?us-ascii?Q?DEh2ZI5v+52B4WdI221A+HTw34z2njYrUDwgqkHKWDMA8wer98e1kdzD6ij6?=
 =?us-ascii?Q?i+s3KZzsiNEcSDBlrbLpU36F0L9iPcRENAwhTp/VwvIC2Ma5wzRc/+Zl9YNA?=
 =?us-ascii?Q?uLHx1V3hw/jStNfZngbLBew1stR+IAw76tYk/V9BQgVNS36X2ta3jGJ9mjPk?=
 =?us-ascii?Q?8JtwXz8lpEAN2ZZR+T1wT/6xPpUpJSISmeI6GL0WIj8AfWBlhzwInWpDpnKy?=
 =?us-ascii?Q?oVUOH+u8P6FWDO/pllOR54PzbZ7vtsH42Crvl4NRDnPKmVgP0nszuRaO9+HD?=
 =?us-ascii?Q?DCEhCqbLsQl9Z50cisGmnvlwlo5XoqsDTbBXPxeRnrL/YWHyGwH45DiVgMuu?=
 =?us-ascii?Q?EPnnsOyIABVgefZyKQ5kPgmEeYv56Sk6UM5KUtDFEUTmKLwZPlmSoqlAUrH7?=
 =?us-ascii?Q?iQ+5Z7EIB34ALsScGkXir7zUiobx5bG1Ka3K7O/oSJZepfl20elbmZ45uB0p?=
 =?us-ascii?Q?z+fuwLA2qSgoTfvbm+qM+uHQ8cGXc0gwTnwQKJnP9gdYJV4p1yot2E+Y8wwl?=
 =?us-ascii?Q?zwkK4oTpG2xJzGs4lRKtcBa09hdR3hhUoDm5PQyn9HtT0Z7v88eyUs7iXJZI?=
 =?us-ascii?Q?zEADCFVsZMBtVrjXRflqlAU3XdQRGLRUh4G/CWT2sPyfGs6SoOvzVIsCstTk?=
 =?us-ascii?Q?Htsr/Hs2kdv/N3+RP5DIzOB4OQG3jVlAnTrjczIBpOeAxUHGPC6Ix0B+cGu2?=
 =?us-ascii?Q?aaT+i6FmY8k1lwtZKb3i7qBFUFDv5DJROZp1BSB1TA2NwVSQcXuuSVFpvf4U?=
 =?us-ascii?Q?/8Q2SxAZgWz4eVsnkRYBb/DTNNBmr1EGE5K97qoxirUuK2kVvu5mF2DdUH1z?=
 =?us-ascii?Q?jZcJAkdcLu8JRak/A534kbn4OHNxaE4M8vfwm1j3SpdzQZLYop/ThrLeQrAE?=
 =?us-ascii?Q?+tzp03WIWiRORrW39op++PQWdfEMlMPpaNVsl9sxTH1ffQxhX/uHS0L93pfV?=
 =?us-ascii?Q?JyKSmUtJRm29QpMSOmPNXsGvZNslj/saQJEzp8ecDP95z6gCQthScVaaC6Xs?=
 =?us-ascii?Q?aVlmjkpsTuBUS4hPiqFybFC6bSohTdk+zsUsYhnVee8frbUDO1zTk9JjcCPI?=
 =?us-ascii?Q?BGZMNpBhVMXMCzmFhVuRxjfljYpVlEW/2tVUImX36dS0z8j9eRXsJMxT5g8w?=
 =?us-ascii?Q?5c6RJJkt/jD5NwzcqDLoCDc7nbOZCv2hbf56MyTonE/brcL90Sk4U05YXC4e?=
 =?us-ascii?Q?xnT57R884RIQ0Ul2/k9S0TiboZbezYQyEodYPQJovVUBVkCdwgAlsmC8PA/I?=
 =?us-ascii?Q?0v/NDFxTLNqnZpYC+UCZiRo9wpOOmtFfCt4CZY6rG7lspGXjB8NQr1tC/BoQ?=
 =?us-ascii?Q?JQt4p6NyPa7jfGathjk7kGFey6dPSrqB199WNKmFcMITi9kK/zEQmK+04w48?=
 =?us-ascii?Q?aNoudDeU8PKZdAQ981KJXkLdZV5UUGbIiQUsMaDa2KjvrGVcUwZty01C4UeM?=
 =?us-ascii?Q?bj9NPMNETV9w5fstcFARCAsxhf5DFp+3FC8shQ6gkg2lqqR4+qmarr8O6hyA?=
 =?us-ascii?Q?TwXdIyE7fE921tnHqm96teC8bGtldZd0eIxGEJMTeKpHlHp5/nTvWzlHduUO?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4ecf8d-3cf2-4e49-8441-08dbebc6552e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:48:47.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onBBGotEJJ1O6ugj6xZaJAnWsaRh6OwemkPomL2yi5MuBI4wcQnYR1vI50ifKJj/bVY9gL0in3jkbDzpH1jEPq7jV/T8lAWpk9/ssXa6zg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> added a lockdep_assert_held() to make sure all callers hold the
> region state stable while doing work that depends on the number
> of committed decoders.
> 
> That lockdep assert triggered in poison list, inject, and clear
> functions highlighting a gap between region attach and decoder
> commit where holding the dpa_rwsem is not enough to assure that
> a DPA is not added to a region. In such a case, if poison is
> found in at that DPA, the trace event omits the region info
> that users expect.
> 
> Close the gap by snapshotting an unchangeable region state during
> all poison ops. Hold the region_rwsem in all the places that hold
> the dpa_rwsem rather than in the region specific function only.
> 
> Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
> Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
> Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
> Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")

I think this is an indication that the fixes would benefit from being
broken up into at least 2 commits so that the specific side effect of
each can be commented upon.

For example:

- Fix walking committed decoders in cxl_trigger_poison_list()

- Fix walking dpa to region lookups in cxl_{inject,clear}_poison()

...look like 2 separate topics in this combined patch.

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 18 +++++++++---------
>  drivers/cxl/core/region.c |  5 -----
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fc5c2b414793..961da365b097 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -227,9 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;

What the rationale for dropping interruptible, it seems appropriate here
since this function is directly servicing a debugfs trigger and maybe
someone gets tired of waiting.

> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	if (cxl_num_decoders_committed(port) == 0) {
>  		/* No regions mapped to this memdev */
> @@ -239,6 +238,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  		rc =  cxl_get_poison_by_endpoint(port);
>  	}
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -324,9 +324,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;
> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -355,6 +354,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -372,9 +372,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;
> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -412,6 +411,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..3e817a6f94c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	struct cxl_poison_context ctx;
>  	int rc = 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
>  	ctx = (struct cxl_poison_context) {
>  		.port = port
>  	};
> @@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
>  
> -	up_read(&cxl_region_rwsem);
>  	return rc;

This hunk deserves to be called out that region locking is being
upleveled as part of topic 1, and this reinforces splitting the 2 topics
into 2 patches.

Keep the _interruptible versions throughout, if you want to drop
interruptible that should be a separate follow-on behavior change patch.
The need to keep _interruptible also obviates conversion to cleanup.h
helpers for now.
