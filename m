Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85445E784B0
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJBQ5d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbjJBQ5c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 12:57:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63503B8
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696265849; x=1727801849;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WImtoB0wIkGfkzAQjqnUNvWU2KpKIte3MCZA4wfdr9c=;
  b=neUJBmumo0qu3kpSzec9OF4rnrHVI/D6PIQkyIyZXGtJ2x+oI+oWLIJl
   bHg2Qx+mLgRDf937CCj1HC0h2WL49Ee2nYOgElLiFUde88laR6Rdn8lsD
   XT6YolNOaJzcBjuRB0IMvgqbl86UjIvIKLOt6ZjYiPPMEa9fnTfjGVrnm
   QklKbC3Hqwb3w+xgsdtTv9bnDWjYblYZG5JrtSVIdsv26/gmDKdCKTERG
   FsHr7KKyCrICbqnBZlWUsTTzTZouj7XUyeZW1kav7zdPIAY2TaHPAhaU9
   rhVpN7AwHU912jArcYW2+idz5oc3XLZEV/+9rpxINQuInzGvY3rPjRzRu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379969445"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379969445"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841037939"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841037939"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 09:57:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:57:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:57:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 09:57:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 09:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKdh58do2girO1JjzTMCMgeAlnRtR4LdKjVLpFDRpYlW4FGLRqQFSakhjsLytAgJNO1scwQBjmfchyH6H0dRBdJpOmqubknOimJtP/yc7DS2Q79xcZBW78ThFtK3kLIP6QH5Lm1xye9CzQYhCB+t2jUH90RptAOt8Six/2wBwVHcfu2B4f/fBrEP3Xs7+AtOJ+eTqM9MFwFTKKduRATZi73z6ecSQbJ9gNfwEyrOj0WwS1UwY3OjIIaXpYzXUyfGhZuUE45BSXtoxSD+67GeElsnW4zICe9onLGGKWiMS3QQTGRVSaBcUEJjQSbG1zTe64U8TUb6/YFicUJs1YAxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK1pPlQqY8fzNnuMQz7AIP4oKYQIeC2TbkyvNNHtZ6Y=;
 b=GLGJ8L6PjbeFKUDx0lRXJLVybUAfkHJovBHEDKnd7RL6suq7tJnPBT1MlOS2F/YvzXzVTijzBCSUzZ8mviFnGgzxd9Rq4heIl2wQWbXepIX+52UgDVdLLZ5vD5hYjacjBxjIPhW0+TV5xOSrXTW53C874P73wbwuoYXq95Lxh7yuWSEOV3oyvpDRxS3AKbQS4g7BjsVWg3SznIatpmXg+DHGlbOLBV2Mg2eHD9oFHZlN27i0lIEudLkYfvVXWbti6fqftVoX2urhRH7q31k0hdYj+vgiAhiz/gbdE9qzEIrSrpMRqaYNfYV6UHc62zqffNXCUrxxemev7p7HNuHLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB7777.namprd11.prod.outlook.com (2603:10b6:930:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 16:57:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 16:57:23 +0000
Message-ID: <22e96f40-b8c5-4ade-a254-e51a243f897a@intel.com>
Date:   Mon, 2 Oct 2023 09:57:20 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d458790-28b6-49a0-7479-08dbc368a62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW4Pwnr8c7dJ5vMtuqGm/JLjlRWL1hl/BFPC0QVLdfHJ7MwedyOtHHmz2/BH/wGaC9YC5mzj/0bYfIg/YJS5NMmzuqpdujE7+t/EH0fY+AOhuO+06nPT5vYFvikUWqsL7CSzuIBs7wcGojPTIR0pK+IWLOClfoCpW6MXWI36iCamzfCNPDmCY/k2OXiNmkmfxVUhm6fkI4igZxt1xs/J9HvwNm/sbji6BoTOw7mVRox/jkgBQkF/oixDVRBi6MjrQkigBM3lQWHwi5EAmrIS9q0uovQkcgRgxFpqmmGLteX+Re3XNvmxZ+CtKiwMs1+hv6ijDfO0swn7p5ZMcTxC0pc8pE9A/ydG+L2SPX4zHN/+4ZjyvLaSA3vZB4lbi/XyrNoLSYlmVT3KxMOniIm9x4UOGT5Rq0+t9B+fEZEkYkTE9144FLYaLyJpBg184qB9HEuVnmMc3w/zM4nMsS5LRzMbCfzHd9fRX9CAAe1+QdeMebnup4e1OMXTjWm/tYBFbfHZ+4gyh7n/nuVMLkWrdupWiDgUjEBp5vjwOUOVlAISTqb4Qq8cH7lOUxEYv8vCqGuNkI4oUQ+uQ3EbPadvhpEfVebDfNDnpAZgK7U4lJr8eksTSmojZw/KJ20yreqz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(6512007)(6506007)(6486002)(2616005)(53546011)(107886003)(36756003)(38100700002)(31696002)(86362001)(82960400001)(26005)(478600001)(2906002)(83380400001)(4326008)(316002)(66946007)(8936002)(66476007)(8676002)(41300700001)(44832011)(5660300002)(66556008)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VOVnBIYmZIM2J2NnNIQjFDNlN1c3VZYjZTQnVDcGRDNitZMDJXdTE4Z3VY?=
 =?utf-8?B?aGZsZXBETVdEMis2R2duNExuOFZjSW9hOC9IOG5UQ1ZtL2M5SXViNEo0MWdw?=
 =?utf-8?B?UEV0K2JBWU9nL3JUenBCNVh0RDhWeGxpeTdpY2FkSEV1WDN4eXpBZ1ZIZGFU?=
 =?utf-8?B?SkZER0orVHlOZUdwWG9CSVkvc2lJeU9jTzFHcXdXTTE5VUZPQnlXZENZaW1U?=
 =?utf-8?B?SnNqRS9FQjl3Y3IzeFJBUW5XdFVxSVlrYVBmQnQ0THV2WmdZVldaSnhoU3pm?=
 =?utf-8?B?VlFER25yZ01mYkZqWG9wMTQ4d0czTkpTZmRENEtLZm16eDB2M3d3VUYvYWh1?=
 =?utf-8?B?VWRNcW56Y0tzSTVyeitDMVVOZnZrNmtxZHJiWE5aWC9ZNndGUTU2dHdkd2pD?=
 =?utf-8?B?Mkl5akgrR3gwT0RaSmx0ZmgzTkZjMnU1bDF0anB2bHFLWEh5NFdMandRc0V2?=
 =?utf-8?B?NmNxVTFCL3VBcTJBejJnRCtuZ1Z1cUl6djI5U3hoR1VpTkN4YXNGU3Jxd1RT?=
 =?utf-8?B?WTg3MmlHdXVJN1dDM296STUvVS85a1RQelhva0R2aEtTOGR5V0VCTU1GUDhu?=
 =?utf-8?B?NWJDaGtsRU55emhwdGJlZ2VFbXkxVDhobXorNGp0NFdMNHFBc25NTjdCQ2Z3?=
 =?utf-8?B?TjhBSG1Wa1gxRkpDRUtvdXRMTVNpY2J4ejk1Vk9NSGMzeVhYLzhkd0c3YkVR?=
 =?utf-8?B?TUJHeEt1dmZ3cnZvclFGNjVuQ1ZGNkV4SEhZeTBXNmtybXplZko3T2VrSmY4?=
 =?utf-8?B?ZjZYbGI2RmpCZDBLTnlHTmxvVXdOekc3TmJ1TGh5aUxXaDU4bUoxc0NsNmVU?=
 =?utf-8?B?WkIzWlEvWXR4azJSSDZLczFKL3hpQmFqRU16andyWlI3TFViTVpPaWt6OEFP?=
 =?utf-8?B?NFZQODVWbWZQSmIwTTN4UWZwaXNMWHFtZlBwVU16d21vVjRaNWd2NkF3a2Q5?=
 =?utf-8?B?a3VOcEVFUElMVzB1Y0dSaHpaN0ZkQ20yUEZ4ZkxVaUtIN1U2cGs1YlYwbGhE?=
 =?utf-8?B?SFh6cFl0TGZ0eVFUUmpEMXora2FFQUJCMUhIcUJ3enpDMTY0L2hnZHU1TEpv?=
 =?utf-8?B?aGs3c1V6VWZ5WkM3VkFPTEUyY0hjTFlFTmhVeW9oajV3SWNZL3lXcXc2WXVr?=
 =?utf-8?B?RVVtOUJhNWdiUXZNMitJQy8vd1o0QmZrUkgyZ2FiekpTTVlUYmRRSXJMNFdH?=
 =?utf-8?B?Nm5SYjNmK1Bsa1RTTW80c2ptZTRSYXRTQXZ2L0RRLzhlYmxUU1RMR3ljMFJQ?=
 =?utf-8?B?eWVrdkFWcU9semFETjcyc044bTgwMlN1cVdNaHphbnl2RUdoTXArU0U3ZGEr?=
 =?utf-8?B?MXM2MWE4cllYQzR3NmlvOFRCSFpueFlqZnFMbjFrWnpPcGlaaGlWV3JRQm9t?=
 =?utf-8?B?NERDT2cvY001OW9ZbkpPNi9HMG1oVDRtNXlrd3dGZk40OSt5emJ2aVd6WmMr?=
 =?utf-8?B?TkcyckNXRXR6bzFBL254aC8wSjRNRDBUZnJzSnJQNitIVzhvVjM1MS9lQzRl?=
 =?utf-8?B?RHhoOVBha0NvazdaSHR3cytxY1llUjFtQ0c1ZmdBZFQ3NWd0QlFlQ2xmZXNk?=
 =?utf-8?B?SlQvSFN1T0tac3dSWFF4OXdvUHRXVDJ6a294STlxSmE0QTNsRUE0YXpLRVZi?=
 =?utf-8?B?ejVWOXgyajZOZWF2Qmo5RFBScDIyRk5SR3NRSFhpWWxNMHBTN05adHVnSzk1?=
 =?utf-8?B?bTFzbE82Rlh3blBWNFFXb3M0blQ1Z2NwSmtSWXkrUElnWE40Unh1VldjNVVW?=
 =?utf-8?B?dk56Y0x3VmFJVE1IT2ltV3l2MDhianNLMjNnNXZTb1Q4OEhzWmhrTkwwblpW?=
 =?utf-8?B?b1VrSk9aVm9wek5ycGprUW9BVWc2cG9FcTBvcWlObkh1WHpSZFBQOS9lNTFP?=
 =?utf-8?B?bk1vdVF2MGQwQ1k1cUdsS1gvKzRiVGdScmk2QmwyQXF2MnRBMHlCeENhLzZH?=
 =?utf-8?B?aVBidVRIM2JGS1d0YW1wbFlWK3BEN25TRy9ETnFBT3BXN3JrNlcyekcybWtJ?=
 =?utf-8?B?ZFF4cnprM2d0dlQvSE9qcjF5cXk3Z1VTMmZKNTlMYzJ3ZTlrNmNRcDdpQ3FF?=
 =?utf-8?B?TVVjV256eVoyWGpIMVVDNXVQT1lLR3RBQ2VBUG9ramd2WHFIUjBWRjZvTGh0?=
 =?utf-8?Q?kEYiq4E+CCo8KVAlof5vv0XBi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d458790-28b6-49a0-7479-08dbc368a62f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:57:23.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRlNYs83lX38oO/atuWTnvG9SCBVG0imib9wD8IagO2n9jIy0M35Ee+GZDDb3Kzh2WTwFcZqSxYtlUS+RUmpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7777
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/29/23 16:09, Dan Williams wrote:
> In preparation for fixing the init/teardown of the 'sanitize' workqueue
> and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> to be the single location where the sysfs attribute is notified. With
> that change there is no distinction between polled mode and interrupt
> mode. All the interrupt does is accelerate the polling interval.
> 
> The change to check for "mds->security.sanitize_node" under the lock is
> there to ensure that the interrupt, the work routine and the
> setup/teardown code can all have a consistent view of the registered
> notifier and the workqueue state. I.e. the expectation is that the
> interrupt is live past the point that the sanitize sysfs attribute is
> published, and it may race teardown, so it must be consulted under a
> lock.
> 
> Lastly, some opportunistic replacements of
> "queue_delayed_work(system_wq, ...)", which is just open coded
> schedule_delayed_work(), are included.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c |    3 +-
>  drivers/cxl/cxlmem.h      |    2 --
>  drivers/cxl/pci.c         |   60 +++++++++++++++++++--------------------------
>  3 files changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..2a7a07f6d165 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (mds->security.poll)
> -		cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	cancel_delayed_work_sync(&mds->security.poll_dwork);
>  }
>  
>  static void cxl_memdev_shutdown(struct device *dev)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..55f00ad17a77 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -360,7 +360,6 @@ struct cxl_fw_state {
>   *
>   * @state: state of last security operation
>   * @enabled_cmds: All security commands enabled in the CEL
> - * @poll: polling for sanitization is enabled, device has no mbox irq support
>   * @poll_tmo_secs: polling timeout
>   * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
> @@ -368,7 +367,6 @@ struct cxl_fw_state {
>  struct cxl_security_state {
>  	unsigned long state;
>  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
> -	bool poll;
>  	int poll_tmo_secs;
>  	struct delayed_work poll_dwork;
>  	struct kernfs_node *sanitize_node;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aa1b3dd9e64c..ac4e434b0806 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		mutex_lock(&mds->mbox_mutex);
>  		if (mds->security.sanitize_node)
> -			sysfs_notify_dirent(mds->security.sanitize_node);
> -
> -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> +			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> +		mutex_unlock(&mds->mbox_mutex);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>  		rcuwait_wake_up(&mds->mbox_wait);
> @@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		int timeout = mds->security.poll_tmo_secs + 10;
>  
>  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> -		queue_delayed_work(system_wq, &mds->security.poll_dwork,
> -				   timeout * HZ);
> +		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>  	}
>  	mutex_unlock(&mds->mbox_mutex);
>  }
> @@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 * and allow userspace to poll(2) for completion.
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> -			if (mds->security.poll) {
> -				/* give first timeout a second */
> -				timeout = 1;
> -				mds->security.poll_tmo_secs = timeout;
> -				queue_delayed_work(system_wq,
> -						   &mds->security.poll_dwork,
> -						   timeout * HZ);
> -			}
> -
> +			/* give first timeout a second */
> +			timeout = 1;
> +			mds->security.poll_tmo_secs = timeout;
> +			schedule_delayed_work(&mds->security.poll_dwork,
> +					      timeout * HZ);
>  			dev_dbg(dev, "Sanitization operation started\n");
>  			goto success;
>  		}
> @@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	struct device *dev = cxlds->dev;
>  	unsigned long timeout;
> +	int irq, msgnum;
>  	u64 md_status;
> +	u32 ctrl;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
>  
>  	rcuwait_init(&mds->mbox_wait);
> +	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
>  
> -	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> -		u32 ctrl;
> -		int irq, msgnum;
> -		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -
> -		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> -		irq = pci_irq_vector(pdev, msgnum);
> -		if (irq < 0)
> -			goto mbox_poll;
> -
> -		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
> -			goto mbox_poll;
> +	/* background command interrupts are optional */
> +	if ((cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) == 0)
> +		return 0;
>  
> -		/* enable background command mbox irq support */
> -		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> -		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> -		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
> +	if (irq < 0)
> +		return 0;
>  
> +	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
>  		return 0;
> -	}
>  
> -mbox_poll:
> -	mds->security.poll = true;
> -	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
> +	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
> +	/* enable background command mbox irq support */
> +	ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> +	writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
> -	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
>  
> 
