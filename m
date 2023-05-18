Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87294C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 22:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjERWGn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjERWGe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 18:06:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C860610EC
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684447570; x=1715983570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rGyKOBGQlZWc0G3b1kvElWQehSy0tnqJzuwA9xUg1ts=;
  b=NFdqjYMcgn9QTyF7s3mvR062z7sGEBRJuYnr/XCK87BnvAcnBrPfKE0G
   603SwcfA9AMMR7amaEIuFuw56O/reoph/suZjmuGhsCA72ASB2lYVeB42
   HnbIvvkXhivrTVQw0gVmnAtsUwyqEVbwdmm5VVGy4T/KTSpr1EDN72CDa
   8WsW8hlodN/CZVN0mdNkMpMIHwUk755FpICNbVmVl9J1/s8VAuJvaOnMW
   raqO/Z+qFC/nQIhun+dQWwM/1HQjkTaF7meKA00MlOSEhO2nzNrEztrQ+
   PyjTi1NyqRVb6VS09aluUWNdLWJqjB0v08SokMELJYV0TUXLzi7YAbuE0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="380419767"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="380419767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 15:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735259149"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="735259149"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2023 15:05:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 15:05:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 15:05:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 15:05:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 15:05:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPDPr/JhZyZNARGncOIA7sbViVQ/zHNOtKKF3l04iE1MUtIvspsu9UqoQAnXLTCsI6truCjqcb4YXE/naOl86WiZNfBeu20//3CoDnQKQ5NZzeyuw9ZVfu5WyKkxBqMijCq+q7Trzblkjk+pmR7zBlNuIn/td19yd+oBLWViUhowMosmrPa+lGcYmvTZYrbOGH0yTZusPsW9t+Q4D9QaNsgU9+MddS2IGgZG5tjJSnmH+AEAB1GYxsmJIob1kDnnc3vg9COeEpKCoGFNGnG7M4/mZn6wbEEg+n3SxsZsBpaJRWK2M7fVoklq1iq673RLYraNsfwUTr1DzMwsdSu7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESx+c2S7Gd0GDJf73oeTD7wMvayh/VSuiyuU8JDQkuw=;
 b=XOrQs0ToIpJMcwrcSt8Coc8ec/POdNsTIUUlZx5rAcXAX8MBFLU3dQpxuVB8FLUG9dvYVU/xX/FqysjLrMtGi/PEmoRm4B5mKKB+3ovivhdV5RFHWVRvoA3UYQIFWlwGFqD/3wFipCzkFJf7rYKe5qKU3+WL7po3SnvkM1qGSiFNj/ultlvNOZVwML+mCPuRpAQNcovqZvULdLTUZvhs1gZt7ouTJ+EhGg5UCeyjrnegtYfh15IsdOKM8Nx+xmFGgX77IthtHXmlI+b+TO7OyH6uQCRCX4/R2+jPf+11HO3AlCAHJ+wU9VrErS4uspbWfeHpfsvF0l5h90qGY+oxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 22:05:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 22:05:03 +0000
Date:   Thu, 18 May 2023 15:05:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH v3 2/2] cxl: Move cxl_await_media_ready() to before
 capacity info retrieval
Message-ID: <6466a10d32f3d_682c1294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <168444678631.3134781.16327910091008427181.stgit@djiang5-mobl3>
 <168444688047.3134781.17383240940940746871.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168444688047.3134781.17383240940940746871.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 794d0d20-0003-41e9-6d8c-08db57ebee4b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnDYF/c/Ut+hPcegM4HZEAOWMrrHI3J81banIknrXXb0lnC/lJdE/tbBSoS4xpW3LNnqEOkYwreQ3wB22CH7eJZmvNZzjh4Xw5Dd0gpQ+SRkkwGEwVm7Y7q5Pmthm3SX9aH20TnTvGk1uuiQSIAX8yCH0+8sYNFGvqSv24lhg3g49Aiekwd4OJasJkEbz8zf4PqhbDejCHVFr6MrH3b4PJ3FPvyJdFnWxP83qSh0PPu6SfRIlpoXRRSTU4W5PjTpHnwYL5cOFtxjvEG1gQsH+tEYcd/sEIPy8j6k3rgmkAF0rJScLzFhhbFb4TKvcenBjGADORg1yCo6jWc67PTDONs4PGsrDr507Tu0JPqJAc3H1HOqDkSFvbmWSk45/7b6mkX1FrVMQNUrfUsIdQE7VH0oKOBv01dN0JJ7lcDZB0vEuwslKPx+zUBQ2EI9Pc7JkZ05RKZJIjwZzTPHfxRllpK1ZVoPTp+SECPb9KkjOWPQHH7rOWzap6iAzdgxtVYsDu+s4fkteQFexxZV/PESoDuNmKbfUUH0TnCCcI04w5UiNKei9P4Pl6MiF5qICxd7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(5660300002)(478600001)(6486002)(4326008)(316002)(2906002)(41300700001)(8936002)(8676002)(66556008)(66946007)(66476007)(86362001)(107886003)(82960400001)(38100700002)(26005)(186003)(9686003)(6506007)(6512007)(83380400001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8V6yufsI/7+nWogd3swblP9LvCVFT41GMKFfpB4FxrSTl5Dkaw21b5Z1vHyN?=
 =?us-ascii?Q?kC169F9icQ61zz6iLkrlHKzFL0mwq0sVZmwohfT94dYU7qVoCVMYuS3hTtTk?=
 =?us-ascii?Q?iOkQBS4EQL4hsEXuiVtLZaskLidGQAS31gb8fXBVk2fl791tn65enjSSMfV2?=
 =?us-ascii?Q?qWOwtkNXStuxedP07VaonIfsNACUIGuH/Yerj9O9Q19NnwAhStCIcuD8xJvv?=
 =?us-ascii?Q?aYS3rnLM1gvkSTig35O8bpEagRbcUraMm0IfX1mLG9D//TX/4yypx+VEUbAV?=
 =?us-ascii?Q?CbCKW4iSWoNNnQ2Za9/LBHZp2hsV5xXbYejVaaUdM9PiRT7ULR6KZ/yQ+jOW?=
 =?us-ascii?Q?qUb1Twj3D4ohTFFaLtBbnt2okz9rgbnFnCAPn0TYVLN9NV4ILiH1dWv+z3JJ?=
 =?us-ascii?Q?FiK6kfCntgV3P7Ls34pflLF2XkaQ/ZZV22guD4LEbfV5bMAEsooqv03WBcyT?=
 =?us-ascii?Q?GTUjWFMhDHA8n1ziveaC9NhnHJRS478wb9Y8B8l3KZOgaEGWS3LkqkxAUucA?=
 =?us-ascii?Q?IfOgzOuMIEt4OtlcwqZEb4Oo+I8kGUqy3TavpiwcR7jETeOV93I9OUQzH9Kw?=
 =?us-ascii?Q?VOtfl4FIHvirLEWMPqXI1YEJ4tkLgDp0TjIv0f0sZjV0QE8KdJgJTmHoh7LI?=
 =?us-ascii?Q?O5XVMJ7rpQrFnlITFX6DGIowOR/j8qzuxWXsN6TEAenxR2eo/Tr5EBVoyhjt?=
 =?us-ascii?Q?LxZyW0ZtDgdzP2YK/bZHut1MfbraW7cUzwDDhTXI2DdZ8p94lEXvQTS+MxAx?=
 =?us-ascii?Q?EayW7Xb1OUE08/SPZAwpwE2WOC1GjsEQVYZ+/b5kxC3a33QCqjjr/C51cawP?=
 =?us-ascii?Q?DqVEk0USysyQYALLYbVNiWTJGnYw0OzyT9fyFqI+aAUVkyK0syPa5EWDCH22?=
 =?us-ascii?Q?PauKrBAT2e/L2eFNipwzlRplDMkTxCw6V60TXmCOLc5jVuNmr7fgwYKIESiC?=
 =?us-ascii?Q?m5n6wN3pde54/N10fXyS4vIOpIRU1/CYCJHNr0TFDRqwvFTqlK08Xy8NwKWB?=
 =?us-ascii?Q?l8W9izyEtu7rDo17piiyWiQO/nV6UyKureovDJurFNBxh6pqNDBDlP2oOVnm?=
 =?us-ascii?Q?s80pEEicrgrMDqmkiankpdfI0C/VgGuGJonfdBZaobOUZhgcIemxzpPiyUVe?=
 =?us-ascii?Q?zog00ia2jF84eKW6mZSwTY03oVNPsikHz6jR1hCdK73EgEHldIu/N08Oz3jK?=
 =?us-ascii?Q?hjFHlLZCfvlNvUUHzD+CL1Nwk7/kw67V2HX/PTUQxnv6537tKcmIVMMmx3kd?=
 =?us-ascii?Q?CV6KV8kNsClKUwMypOkmSA9baDB444L1ynXZz9zwojp1ybuMrt7OIIHIhvuY?=
 =?us-ascii?Q?3yX8MplGLk//ouIxfrh+Zcp11VhE0lDO+ZFua596vMc8yanD/H/yZNuozaev?=
 =?us-ascii?Q?qs8Yp6BahOrn0Ja5Biq6rANsVby+sl69LzQPYKiRNR4iGL4VF8ZZw3s+JHka?=
 =?us-ascii?Q?TaJIedv8KJcZ1EAnpsFouMupMMzsul+UvL1F9XhbcaGryZiJ1XBXJ7NINPCE?=
 =?us-ascii?Q?R7FINLZphuV0PW778myUi0HLld3THDy0KZNDTuLON4qe0jYI5u00vwDvyWHp?=
 =?us-ascii?Q?BqFQ/YdhGcdTn7XZXO0VXCyOJerv4DSHmOWTKG+DSHyowfaL8BfuW8zDuDj9?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 794d0d20-0003-41e9-6d8c-08db57ebee4b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 22:05:03.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28wrfOYXDK7zbVkxBMdkW2XZeFMW7OZhweW2GVPcyzzvfI+fM1P55/vHaHeScFbQDSOWpVJq4E5ExuCl0Re34ivy4Puy8/TQ+Jq39ssMzLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
> IDENTIFY and retrieving memory device information to ensure that the
> device is ready to provide the information. Allow pci_probe() to succeed
> even if media is not ready. Cache the media failure in cxlds and don't ask
> the device for any media information.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Allow pci_probe() to succeed even when media is not ready. (Dan)
> - Cache media failure and skip any operation probing the media. (Dan)
> ---
>  drivers/cxl/core/mbox.c |   15 ++++++++++-----
>  drivers/cxl/cxlmem.h    |    2 ++
>  drivers/cxl/mem.c       |    3 ++-
>  drivers/cxl/pci.c       |    6 ++++++
>  drivers/cxl/port.c      |    6 ------
>  5 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..114e15d02bde 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -984,7 +984,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>   * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
>   * @cxlds: The device data for the operation
>   *
> - * Return: 0 if identify was executed successfully.
> + * Return: 0 if identify was executed successfully or media not ready.
>   *
>   * This will dispatch the identify command to the device and on success populate
>   * structures to be exported to sysfs.
> @@ -996,6 +996,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> +	if (!cxlds->media_ready)
> +		return 0;
> +
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_IDENTIFY,
>  		.size_out = sizeof(id),
> @@ -1065,10 +1068,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  				   cxlds->persistent_only_bytes, "pmem");
>  	}
>  
> -	rc = cxl_mem_get_partition_info(cxlds);
> -	if (rc) {
> -		dev_err(dev, "Failed to query partition information\n");
> -		return rc;
> +	if (cxlds->media_ready) {
> +		rc = cxl_mem_get_partition_info(cxlds);
> +		if (rc) {
> +			dev_err(dev, "Failed to query partition information\n");
> +			return rc;
> +		}
>  	}
>  
>  	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 001dabf0231b..b24796862e13 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -227,6 +227,7 @@ struct cxl_event_state {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
> @@ -263,6 +264,7 @@ struct cxl_dev_state {
>  	int cxl_dvsec;
>  
>  	bool rcd;
> +	bool media_ready;
>  	size_t payload_size;
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 39c4b54f0715..c03cbbf4aecb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -151,7 +151,8 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxlds->media_ready && resource_size(&cxlds->pmem_res) &&

I think cxl_mem_probe() should bail immediately in the !media_ready
case. There's no point in enumerating ports and registering debugfs
interfaces for CXL.mem operations when the device has no CXL.mem to
offer.
