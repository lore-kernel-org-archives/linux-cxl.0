Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D3C77B73
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 07:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDWHy0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDWHyZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 03:54:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E094
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682236463; x=1713772463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W5xGN1Q6Hm/1l+ilGuHT4pKPapYkiybf2Eo7VHknzoA=;
  b=dPm5K+FL+cNsEpKYxLVJXpND4r0TrpOkD2L81T07pycPC7U10/RE8/zx
   WShdUOWZk5+Eby8sz493SDVoEgrgOorfohWhzhb2eI2bIs4mf+vhCbokn
   1gT2mWKOi1TuYq5TX759UolODanNC7g6w+mbDlDCNDqCZPYSY6YMUHuQS
   gOENxGOnPJkGxspYo/ZbZEdb1lIVmSGoCEbpnSWYOaFAlBd8G54HuEep6
   HYi7zLzItKoiUQuaCztz1hNMvu8nuuyBlP99U4MihCCc4xJOA4HffzUaw
   8L4y/j882HLREsgr56y1QS2K5IlJDKeJrEDQmqxOxc/n6KPT8eTDDbY8C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="343743594"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="343743594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 00:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="757340254"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="757340254"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Apr 2023 00:54:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 00:54:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 00:54:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 00:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfi+ttsXzRPl2Dz+x4tMFYpAZ2zcTaJqqL6T12UlXtSByOjcRpcPKQsvytDG+/21VPDOfrzxpPNYqOYTxCiTWwnO0wshrKN9F9nU9+t22i9c10zLIlu4WqpNAXsD3CQUyoJ6QR7ExqUmSelLLGe255G2VKzOJE5kqI1Q4A7t2dgQ+iJ1DSVJiN/ZnRuIwp8JF9i0M1krLB5IGsmUs4+UQPm2b1XtkYcT0TTNiWoa9iYX2j+zLJOVwBUIh0bX/rfO1HjZ4j8iApH3Srsm5UDgi86eSDWk8I9YMQr1SxBBI7l50jAMnCJkGFXD1DHcWYBo/qQuCvrunuKA9Qb7h53W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4qhOQzzlzzDIbXKjSgOT4HcnnsB8T++FFd97Hw+36k=;
 b=VZLxGQCmoiLC8YqwGs441UTxq2NZKUOnP4lyaYdA/0vLnDi9pB5eyIVD6oKRx3DCywRZFUlYODRFFAsHloSV2gs+MSfMX88fJIA7PetWRdAYXmUxqGF0xP5IAkDHKst/XEoDrQ1PdtXjYuMXn5j8gXCYiGAj1n0RarvprEvwskP2JFRS0T3T+6Rd3n9ftac8ioCefTDXSUxGThd8ePcJ2xONJF/cvNlBtW9eZKDnwXyioj4GgrcKqDNqvvCCKa4EugnHOI1h350xtsGwWAD1EKoLTTTG3QC65Y/oLReNcAM1uEgvrJef7sZF3oca/a5A5/X5CcSAcHCwQGv1Yxay6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by DM8PR11MB5622.namprd11.prod.outlook.com (2603:10b6:8:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 07:54:20 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::4814:d85f:2e45:1828]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::4814:d85f:2e45:1828%4]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 07:54:20 +0000
Message-ID: <d9ba88f8-9cc1-44f8-6e92-cb46683de938@intel.com>
Date:   Sun, 23 Apr 2023 15:54:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20230421092321.12741-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|DM8PR11MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b73be01-89eb-424d-1c82-08db43cff13c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5HP3yI63KXtxoOIT3cG5aTNK0HDV3vvb+xW4pV1VzvmcRULyLQHdmmjygNPlF5GXrmSphwOs86jX5fWlWNyInDfDOoXaZIjyDrCiBE5JK9k6JkfCIKy180ze7li0ssk8TSSDwmkr8cTkORdq27rSI0TQyTEP4S2T1Ir5ycAxQGVkkhAVv8PoPeXa05QEllSh1F9nRaGEDQaqCaUulzrhnuSreJ0bHL49DvXprbjVvj9OK6qsQlTB2YLCZeKVWtA0TcvrFc20iCiRK6QN1and64xxoo2g7KErEva/jo2hZa1ZNFSR9/5vCnHvdbLOnoE5WZo3lG/CnFC91vtrN4ucDgxjDswLGfMv+VQ8BCiv8A0LrpSYcPYms5IfAgi4WvRFE1fJMoO00N7qERGrv+Iw7Xy30uN6PONEMx645y+XVlWT7LZ+t8CgzHbN0HAhCRtBpiBOFfMyQhtiffTOPJY+7x6v2tUnTyWBJO9L+zrECXY+pYBInlmDMyuf4vGZncAJuinZnBkpDrg6lZcAquSpVw12zvTCmlVkM/9NqqUGF0OWGQSOiA7a77kkVk0atCDlEWI67rfBQZhxp2K4CyWUQCmnhnJwyCmGg4/9bS0ac+ab61owUif1NHAOnFaZtQHPAUl9if8nZMq3n45zjqPWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(31696002)(66899021)(86362001)(36756003)(107886003)(186003)(53546011)(6486002)(26005)(6506007)(36916002)(6512007)(6666004)(4326008)(6916009)(66476007)(66556008)(316002)(82960400001)(83380400001)(66946007)(2906002)(38100700002)(41300700001)(8676002)(8936002)(31686004)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNMb3ZPTTEvbGREZG1Kay9UcmJ2RDVtaXVmbWc4eWhQTVNjeVZxUWxRZkZX?=
 =?utf-8?B?MC8zak94U20ra0dCMlB1OUFzY2x3VXN4bUllMWNTOXNNYVRLM3M1VFFWeXZP?=
 =?utf-8?B?ZGMwclRIYUtKbzY4VTBrYzArNGI4bkR6S2xpVUxiK204WTQvUmxNeFNiZXk3?=
 =?utf-8?B?UnhDSGNHa1dMZ1VWVDZ5SG5vSHQ3Y0U0ZDdORmV1Z2RRcjZtcExuYkJ3Tlkv?=
 =?utf-8?B?Zm5NRzFQejZDU3B4dERRRnBOYkJaY2JHWHQwUWVRMXdPdDlsdWk2MVNMSjJ5?=
 =?utf-8?B?bHBzOHZ5NjY0eTI2THFCNGgxdnMvQUg1eWl6anJ5ejJXbjlVQTFYMjdTQ0Uz?=
 =?utf-8?B?aDJCZ1ZjR0FsNnFaZmprbzVYQlRHUlhpZUtFU3RrYkZOdHlyYmxPN3d1K1JV?=
 =?utf-8?B?OFFoWHBZNVF2K1FyeS81clUxQ3k0MllVZVBaSWJXQUliZW95b05IMUtNNTdQ?=
 =?utf-8?B?WjliT09qQ0FrOHlvVlRiV3ljdGFzOHJOREp0aXpLMEpibXgvOFVONDhTenFZ?=
 =?utf-8?B?OXBHRzYrME1SZUNpNkhmWEJWa1hPUlRQRHJyY1YvUyt3RHFuUmZQcjUzS2ZD?=
 =?utf-8?B?OTZ4K2dvTHhIb252SzdsbnlEWFlBK29xYUcweXNIZEp2ZjQxbXRNK3Y4Z2tT?=
 =?utf-8?B?M2Y4NjNmaGl4TytJRkxDaGl2bkR6RWNwSXFWMVltWWFaM1BXVlRKUDJtelE2?=
 =?utf-8?B?ZUY1ZWZtcmhBa21PaUZET2VaSFo1akt3d0s0Q0RVT3JPamRVR1J5RVBZaXpB?=
 =?utf-8?B?SU1uN2pQSDl2Uk5XVUFPcXpJTm9SN0czd1N2dllDNXE4eHZOMGxWZUhmREhw?=
 =?utf-8?B?QjJmakVKUVZJS2xJUTNSUlNkdEhMaG02c0pxcXhydThSbVBmdlJ2L090cFRx?=
 =?utf-8?B?ZTRqT2c3RUVTMjBKZE5YVlNZKzBTVDh2Ny9uZXR3Q044bmNiQzdmUmdWcHNP?=
 =?utf-8?B?dVRnaG9qbGRHSktjMnhDUlgxRVpoZE5EQ1QrbjRFZWFoaHNzOXU2Z3F3cCtj?=
 =?utf-8?B?TjRVU1JjdFBsSElSbzlIRmxTK3hNT0pJSzZSRW9oOTg1SVJGS2RpL296M2Ft?=
 =?utf-8?B?L0daV0g3VS9vZHdkTmd0dUwrTDFYWndTMkQwL3BtVlB6cTJZdk9wSmpmMlo2?=
 =?utf-8?B?UEJyTFh0YjcydnJCRC8vTHZiM3pTbE8wdjNjdU9aVUhIWFVwSndpRTN1OWts?=
 =?utf-8?B?a0FQQnQvT1l1TkY4OXZwUE0xL3pnWlMrNE9wWWdsdzFYR0h2V01xZlhaZndU?=
 =?utf-8?B?WjZlaTRVbzI4aks4N1p5WjI4amZBVW9tVjJFOFBtRUpJclB5V1g0OFJEdXhX?=
 =?utf-8?B?TzczcDNiTU5YOG9Hanh0SGVGaWtCRFU1c00yYW9FT21tVDdBWkJ1WWN0bEtG?=
 =?utf-8?B?ZXp6MHVENmYvYU12RGYvMWRTSGdNSGpLSlNvMllsR3BkbnFNem8zM0UzdlV1?=
 =?utf-8?B?VE9tUkh3OHduZVlGR2V6cjJiN3R6cXUybW5nNWl4TG9aZXYwa1lKMXRVZEtx?=
 =?utf-8?B?Mm9FWXRIUjdoY2ZQNVZOWXJjSjRVbVN0S0l4ajdSZFZXRlErVk5ZWGhPWUdT?=
 =?utf-8?B?cWhKZFNieXk0cmlENWdsWEQzZjR3b1R3Sm13NWRIWS9zZDE0SFBnVXBIZUpI?=
 =?utf-8?B?ay9sdklFQmdDYklCR0JsVjl0MEViUWVGcTVNU3BDcXZmaFNxVW9Rb0toSU8z?=
 =?utf-8?B?c21rNGVtQU5rMDk0S2NrNWhzU1dUOUNKS2FKWC9JWGdpay9ZQzdDczVLdm12?=
 =?utf-8?B?MDdsbnFLd3JKNVF0UnVVZkVIWENrdk1NV1lpWUJDVnk4dzR1WEZQMVhUVG9r?=
 =?utf-8?B?cjN1OW5EVzdLeWpsTml2M2VXT09Ya2hHRFpDaThsdEd3U1dEWVNVVDZiYVh1?=
 =?utf-8?B?MHo1Q1pHMmxTa3pSdWUzOG55blZyWVVyeVJucm9xK0JyMHVoS0puN0FqajdW?=
 =?utf-8?B?cDJ1SEpCV0FUbzk5RHI4dnEzREhFZk5tSnc0N3BsSlBTenlLaXFCdTBSUzc3?=
 =?utf-8?B?WjJZTlhsSXM0Y0ltOE1EbmNRazU0Z3ZkVkJZVUJ0SUc3YlNiK1Bsc1JiczFM?=
 =?utf-8?B?ZStiNlp6TlE5QmhnVUFDbWliQU95S2tGdkFyaGl0WVgwRHFQQTc5amxGenNu?=
 =?utf-8?Q?tnKl0ixnBXqC1+LR3rNYFq2QE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b73be01-89eb-424d-1c82-08db43cff13c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:54:19.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFm9Y+s2UyqUlIXYX6y1OrCCbfGli8JkbCV/jspY3ydmPiNb6bNdmPC2CwGFtvk1kMy2kTrR17BzAnCBstp2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5622
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/21/2023 5:23 PM, Davidlohr Bueso wrote:
> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run in the background asynchronously (to the hardware).
> 
> The driver will deal with such commands synchronously, blocking all
> other incoming commands for a specified period of time, allowing
> time-slicing the command such that the caller can send incremental
> requests to avoid monopolizing the driver/device. This approach
> makes the code simpler, where any out of sync (timeout) between the
> driver and hardware is just disregarded as an invalid state until
> the next successful submission.
> 
> On devices where mbox interrupts are supported, this will still use
> a poller that will wakeup in the specified wait intervals. The irq
> handler will simply awake a blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken. Similarly
> any irq setup error during the probing falls back to polling, thus
> avoids unnecessarily erroring out.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

......

> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 reg;
> +
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
> +}

should using a MACRO to define '100' be better?

> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	/* spurious or raced with hw? */
> +	if (!cxl_mbox_background_complete(cxlds)) {
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		dev_warn(&pdev->dev,
> +			 "Mailbox background operation IRQ but incomplete\n");
> +		goto done;
> +	}
> +
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	wake_up(&mbox_wait);
> +done:
> +	return IRQ_HANDLED;
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>  
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +	/*
> +	 * Handle the background command in a synchronous manner.
> +	 *
> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> +	 * which we currently hold. Furthermore this also guarantees that
> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> +	 * in that no new bg operation can occur in between.
> +	 *
> +	 * Background operations are timesliced in accordance with the nature
> +	 * of the command. In the event of timeout, the mailbox state is
> +	 * indeterminate until the next successful command submission and the
> +	 * driver can get back in sync with the hardware state.
> +	 */
> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +		u64 bg_status_reg;
> +		int i;
> +
> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +			mbox_cmd->opcode);
> +
> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
> +			int ret = wait_event_interruptible_timeout(
> +				mbox_wait, cxl_mbox_background_complete(cxlds),
> +				msecs_to_jiffies(mbox_cmd->poll_interval));
> +			if (ret > 0)
> +				break;
> +
> +			/* interrupted by a signal */
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		if (!cxl_mbox_background_complete(cxlds)) {
> +			u64 md_status =
> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +				    "background timeout");
> +			return -ETIMEDOUT;
> +		}
> +
> +		bg_status_reg = readq(cxlds->regs.mbox +
> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +		mbox_cmd->return_code =
> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +				  bg_status_reg);
> +		dev_dbg(dev,
> +			"Mailbox background operation (0x%04x) completed\n",
> +			mbox_cmd->opcode);
> +	}
> +
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
>  		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>  			cxl_mbox_cmd_rc2str(mbox_cmd));
>  		return 0; /* completed but caller must check return_code */

why does here only handle failure cases for non-background command? Maybe I missed something, I think that we need to do same thing here for background command.

Thanks
Ming

> @@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	unsigned long timeout;
>  	u64 md_status;
> +	int rc, irq;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>  		cxlds->payload_size);
>  
> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		irq = pci_irq_vector(pdev,
> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
> +		if (irq < 0)
> +			goto mbox_poll;
> +
> +		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> +				      IRQF_SHARED, "mailbox", cxlds);
> +		if (rc)
> +			goto mbox_poll;
> +
> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +		return 0;
> +	}
> +
> +mbox_poll:
> +	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
>  

