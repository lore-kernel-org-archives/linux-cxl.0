Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED556E784AB
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjJBRAO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbjJBRAN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 13:00:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05DEB8
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696266009; x=1727802009;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxZWWdHqegy2Sfv8KjQbmEzkovALpdxGV09gkCg25cM=;
  b=PnberAPLBsokCN4QCpB8Z6keSs0jnzwCUsYcfxb5xpCnEgx0DNtZ4cLY
   e8DXTG4J9UpPDXIvAq3bs78c2z03PQJAWpalZ6xUhN0EkMPRt+O3nzQ5E
   gCZHjKrs7uWrtcFdcd+qTtV4O+gH67ZipjN+I0Oqlruchv4sCd1/tpsJq
   Cq9tiPikmtKfCAR3xLkv10lRaRbS+ag4qnulfEzy9H01tjaC9X/tv24SO
   I/mVgHGOFuEhLv2ZgnIslXTMH5J9F+1AapK8iu+1JXoryoAwkrQ3osU7R
   8VaY72bSSKsNxDMdx2fnEvJTwsaxkV1H7HiVNWq6wG/m579KqiVxMv6x7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373035232"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373035232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816350541"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816350541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 09:59:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 09:59:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeWiTXdvbeFWNF3ZU82lXPT0WGKzNj2yu7zmaD/yWjueEobnPYxDBvvXOLXRO39mXQzNgzPlsDqyTEJ1tmpN6iz222msRMpExeN3K8zsz6z+wsc5PcPe25kRkPxKcpnXs8pLb4upEiQDPsCOR3Pgh4S16N0kgrXJ+EJw3kMSuj/d/Q9oc8L4VRpgM8BjikmgW1bSlMsFEsfdglDK6TNRkAJBlnxiLsAB28H0jcMGMGwamLcXdWrlSSOVidjSqSoUuRK6q77PH12TkAhhzz0vTBdyhj3kPpLshE9kut8rgiiNrRBvQP0WUqs792YoiCfUgJ337iOnM0UFvA1ADrOs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvrbTN1qJVfPnzZdtIjOwuAvNcDtzHqW3tpEbujQ0e8=;
 b=LvlV4EGd1Qci2BW5eHshgxExyJWUpNa8/d7t7PdH/fqmuQfLkTeLy0HvU6FO4Z9Ri+4lmj09f1frRryWBh0h6ZGw92tBBPsJbVOxO2bfwb+83zuEej41PuG8kbiciiIjvuoopksVlf4tHU8a4SnMPMrjaENqGwh/eMp8NaQTgy97jf1GLlUjtqE5gsw+dCRbJCq6ll6LT9h45pmeSKRktKSSD+B4cnhyuDnHf4e0aaxWYm9nWefw19L+2SYneaoJfwwiJJwzQWItfFzWC/4FxVI1DO35kjQr0WwxQxXGhg3AaFG8UqORxrc5ypP7JFwA43ACLz+hWCQ60oFYQbyHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 16:59:48 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 16:59:48 +0000
Message-ID: <a52ed47c-1f7c-4669-b067-147f61136c64@intel.com>
Date:   Mon, 2 Oct 2023 09:59:45 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 4/4] cxl/mem: Fix shutdown order
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 250cd40f-f43e-48a0-8bfd-08dbc368fc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyL7f8yEpaaeUCyT1xp66EMvpnkU6wP9KTn0VHdF3aDKKRTEuOQsFpbQPmk2NDQafbMy3aHEy1WTDHk8pkp0uWwBs+VtV0R1XVb5bESKh8mh0eunX5Pdjohhfmrwn5XhgvG9pNSUip3vr8pzIpiRa5LRzD1bsyOi6X6mIffbPVtZkkag+W6L8eJMxJS7Bn/yE7o/cQDh8suvICon2VnS5hkIzuCkazaGZrSkes1iuoN0kgXqCtH77wUrGvSAtVoueM6ssRYxZqRIFeFuR/mKQGagm/KbVKb/oShERv17+u2z8a1OxbYi+KK84ma/Pjqajsc91PbhJi4fKdZ2knzYufsbvvzJ16pH99qIT8yN+lZZm+kUy78+njZabnmuzgkW3YGQOM+4cUnN9RHrRVFnhF+cEhpbg4Ckbe1hnT2DQoogBCmuMgvhu9iNkKCs0TR/OgW1G4CNSiAt3gtZhM7oaPqyaK9s6a86d7EWso7XyG57NcVR0VQ6TcLFWaVtrFmuyplujIRG1O/10UjJl/n5z0rQjppgpbLePHQF2kHWEn4jiGH/SBHAdhxAqyVU840GMFP6hnIG4Sy8UO+/xnEd60ZWwx3ZZL1S1UJv9vWVBjihME1xJ7BMYjHDBq7DvNCE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2616005)(478600001)(26005)(107886003)(6486002)(6512007)(82960400001)(6506007)(53546011)(6666004)(38100700002)(44832011)(4326008)(8676002)(31696002)(8936002)(66946007)(66556008)(5660300002)(41300700001)(316002)(36756003)(2906002)(66476007)(86362001)(31686004)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ovVThVeWd2emFaRmtRM1NPUWh0NkVsVmZUcE5RTzB2MG5XaW5pWW16MjVW?=
 =?utf-8?B?c3gxOHpuSG56VUx6Uy93dkI1bVF5WXBLZGJ6aG5kUzl5SVVPVUJPUnY1dHM4?=
 =?utf-8?B?UE94MFlUMC8yWmg0NGNUelNZOVJsZWxhcXVTQzZXMXJZZ3UxMi9TVmMyQlVy?=
 =?utf-8?B?MDNTdVU1K01SMnM3RTMvODNPTG15VzNHWEVDZHJMdHJsSVB0S1BkUTNTZER4?=
 =?utf-8?B?bGlpNit5Z041b3Z4S0FwSkF0Q0lRYWszdW52dVViSXFnZmp2WjZyS0p5MXVO?=
 =?utf-8?B?Y0ZNVjF2UjM1SVpieVNHUTI4eGR1QUZaanBuMHRJN3N4ek93ZFZHNjI4MHVD?=
 =?utf-8?B?TEhDcGUrcXdtdXlnWVhwb0xIM002VGp2UU1vS2M3bnUrZlBYZHRkNzY2TGY3?=
 =?utf-8?B?V2JHNE05QzN2cWpHeG1VOEhDRVFlb3ZyMmY3clpNc2JXVzFFNk0xUEpWVm0x?=
 =?utf-8?B?eHlSWWJjMzU2S3Z4OUU1Y0hMc3gvbmpHVDBMRWtqR095TkNsUk9xcFdYQzJ2?=
 =?utf-8?B?alkwdm1wY0NuRy85WnJFZUErV2tBWnlMem5kT1kyT1FzT3FQa2txN3lKeU1M?=
 =?utf-8?B?dUVBZEFMSUE5clAwN1AyN2lmdVFUSGRzbmdiVFBmVUJhaHVvTUltTTRZNkc1?=
 =?utf-8?B?VDlNODNFTnZLRG82bWpyd003K1c5SE92RWhqSzJTbmx3ak9NakFkcTdiRnlx?=
 =?utf-8?B?d0dHbGUzdG1reElubHY2ekZiTXBDWkt1djBOZ3ZvYTE2TFlPN0x6LzhpRmtL?=
 =?utf-8?B?cllreWpGWXJQMHVxcWJqUjJMcXJYaFZMSkxwVmJ5YVFVQzJZTkxSOVE3WHo2?=
 =?utf-8?B?QUFVa3c1V0owYnpoanNlY1FEUFZrWlZ1WmxjUXVUN1EyS2hsVjF0WWY2dTB4?=
 =?utf-8?B?TmtLRlI3TWlTbGk5UGRWVjNOYzJoNHA2ME45UTV4dktqMmFNdVlVaEY3U2RX?=
 =?utf-8?B?ZThFSCt2WlF1R0NheitFaDNFclpSK1owNldGSTI2SWlFbHMwNVpBdmhBZjZp?=
 =?utf-8?B?dHpHbUxubDNyNldBeWQzUXROZS9CaWtXVTRPNDRsS3Q2UlVRcWNlZURwSlF3?=
 =?utf-8?B?NkNCTkJteHVYYkh1OWJBOFFaRWJMQVBPVzIybXhUck00UXQxNnRwTE9qRit2?=
 =?utf-8?B?KzNVYm5qNC9BbVljbkk5a0tMSzhnNFNWSk1JNVgzbGhJMXRnaXRuL1pkRnBs?=
 =?utf-8?B?TkxrdGtYTlEzNWkzbjZOaEVmYm5xMnB1eklydTB5UjVRZENucnl1bGpCYkhz?=
 =?utf-8?B?SjVrRWhEb0VXSHppNHhnSWdPMXZWZHlDR2pVUklKZG5jeDB6cGttUWJxaVIv?=
 =?utf-8?B?bUFkd3RGSXpjcmVPaEQvNm0xMkVaMTlzNmtlRmZXMzVPQ002YUVWRXQzTCsr?=
 =?utf-8?B?Z1d6Z2s1Slh5S1VzNjdMdEdkY3piYytqNXl4TW0yS1p2K0tEVHNhejdwMVlQ?=
 =?utf-8?B?Sm83YmxhSExYMkMrR1pUNlBleWtqaTBtU1E1Y08vL0VCTUR4L2syL0d2Q0k2?=
 =?utf-8?B?T1cwSWtLSGFvQkFoQ21yZkY2K2JmNUpEWDdjaXU4QUdtR1FKVDRRdzAySXg3?=
 =?utf-8?B?UGpRQ2lTdnRZaWJneXBpZHNHN2JzRXJxWDVCTjJiWi9pZ2V6NWtxU2F2WVhU?=
 =?utf-8?B?RUNXSVorZlgwWkpsYUVtbUJCUHpSSDB2K0pkWlNnUWpCdks3Z1plZXpBcHZY?=
 =?utf-8?B?bWdhSVdCemNRVktIREpkZGdrUURSK1ZGVUpFSFczMnpVWlhoTWFXMkJBdUJS?=
 =?utf-8?B?eFBpUjloYlBHQUplWUtPc2g3Ui9RK2hySkpmODRHRnJPSFZkZVcwN1YzTjd4?=
 =?utf-8?B?QW9oOTY0Q2JJTVM5d2FteEY5MWY0ZU16S0RZSW9zeXV5dnNqd2lGUG1UMEc4?=
 =?utf-8?B?T1RhRzdtZXU1QlJkS3lnbTcvT2wzWGZoNE9YTDVsSDg0ejYzU2lxTkVxVUNU?=
 =?utf-8?B?QWxLcjZWOU02UjI2VitHTHNxYjJ4Nm83VjZhOXdFcjRnUXh6NzRkYXNmVW0x?=
 =?utf-8?B?U0kyOXRIRUFoeCttVlk4QVZLM1lTVGFFUmJqNHJwUm1Yb05zbStLU2s0SW5r?=
 =?utf-8?B?WElhc2Q0WmNNSDg4MENzS3FZVjlsTXE0ZW51SXk5bFQvUFE5d2FvODh0eGNE?=
 =?utf-8?Q?N3CWM5K+hIbfdLbkuthnINqID?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 250cd40f-f43e-48a0-8bfd-08dbc368fc5a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:59:48.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cicyP4byxxEf/ZlYknynlqk8W3RUnwdxRi0tEU8XeBmhaL+uN6TsSZOG7Z+WNDW2vS1EHBDxrkSvXRbLB7/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/29/23 16:09, Dan Williams wrote:
> Ira reports that removing cxl_mock_mem causes a crash with the following
> trace:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000044
>  [..]
>  RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
>  [..]
>  Call Trace:
>   <TASK>
>   cxl_region_detach+0xe8/0x210 [cxl_core]
>   cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>   cxld_unregister+0x29/0x40 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   device_unregister+0x13/0x60
>   devm_release_action+0x4d/0x90
>   ? __pfx_unregister_port+0x10/0x10 [cxl_core]
>   delete_endpoint+0x121/0x130 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   ? lock_release+0x142/0x290
>   cdev_device_del+0x15/0x50
>   cxl_memdev_unregister+0x54/0x70 [cxl_core]
> 
> This crash is due to the clearing out the cxl_memdev's driver context
> (@cxlds) before the subsystem is done with it. This is ultimately due to
> the region(s), that this memdev is a member, being torn down and expecting
> to be able to de-reference @cxlds, like here:
> 
> static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> ...
>                 if (cxlds->rcd)
>                         goto endpoint_reset;
> ...
> 
> Fix it by keeping the driver context valid until memdev-device
> unregistration, and subsequently the entire stack of related
> dependencies, unwinds.
> 
> Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a950091e5640..e78b5ead14fa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -570,8 +570,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> -	cxl_memdev_shutdown(dev);
>  	cdev_device_del(&cxlmd->cdev, dev);
> +	cxl_memdev_shutdown(dev);
>  	put_device(dev);
>  }
>  
> 
