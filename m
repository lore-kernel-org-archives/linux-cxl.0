Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9672C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 07:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjEPH7U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjEPH7R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 03:59:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3C1BC7
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684223956; x=1715759956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7NURx4VvR8MhUGrzDrTMX0zzGDw5U8P6qqfiSeTuYsQ=;
  b=DvgfStzYPZ1d1zN+nvM5yZJk2mlfTIEXS6cwbnENwsEnBZbDm0IjOsLx
   Ag1Y/EdqImFsuNTw6KAlIskTUF0ubI5ST+Wkx/NVrdME8H3NbqvUKYMaR
   A3xLEIyvEe+rcByZ8uFrvUgqIUD0CzvFxEFludSQoiEXxptrFc0dzoQDH
   o+r9iajHQcXrt+cqabPrnkU4n98WdXseHRuCycl0B4NUFTtCLr8DhYX9B
   GNr9LwZpw/ZchHuE/N+RvBbE/5IRYBewWSVzimIvWlhw88kmb91KxVbsA
   9rwLgC4LGjMohaUO4oZubRlrf4680BQ4auUWj7TBRJP8ddDNx9Gv1gF6x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331028615"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331028615"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 00:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="825480562"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="825480562"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2023 00:59:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 00:59:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 00:59:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 00:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKEpCztIumv9BDw4f1H8XAx4zcMTS/zjF+oqCSPX6wDg8xDVEQ6ZHXVSPAvKRweOE9tg8YazBFOxH4Hh8Z95sG5cxK6kBZkwI2IwbDk/z7rMQeOTYj0QYnzDem0xzMyis2r1QrKO83MEFw5Ws5QZ/KPkfAcPInfrFJyaJuv8z/PD6s9sArieESMzl7sESUICi0+0gzr8m4FsQkSbIeYw6nd6JqjAtWgfby4NanlC3HM3DDDErZ3QxnKFHReM6n5VVB54rrcZaODx4p7EIUQzPy9/aJHvb/29kA/cQ6lo31O2JF5DlqPmgYkvvJjbbDwF5B2zJO9s/ccbOcS4kObnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7Vrrzk+v0s8TwyNe3CAFqvrOwHR6yFNaeZYTn8oB9g=;
 b=KsqyKfGMSK5Q20LNpICqqgIVHgbGl8PZN7b8AD1kqtvGjjz6ciVOO/y5mSFCMdP2HVUm8lHgGl9A9S4U1S0oet3SXq06UYJDtzS6vxf8IVATcgnmbtqrxW5MtJXQjKtWdn0KMxYTENkQBA+y0PrWfKTlGSKEOiAjFSWP1ZKW0nzVy+i4c+ggfFtwwD6YdXeclJ3vOqUZDY1RkugYRS27wiIDGMZ5yh/kqewTRFuqVjhkr+9F4iLbdXS85jHzFYbFUG0lFphRA6ysHTO7880eTCFrfn2aYEIEaaCjWMCHyItHfsaizMiO8bdafU7IzE3nlb2xB2+nl0LKOXKTpCyg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 07:59:12 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::af69:5a1:7a30:d730]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::af69:5a1:7a30:d730%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 07:59:11 +0000
Message-ID: <09aaafe8-76c2-85a0-ab5b-fd337c625530@intel.com>
Date:   Tue, 16 May 2023 15:58:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|MW4PR11MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: ca330db6-ac1d-46eb-d838-08db55e36e96
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXnx+M+DhAANnQvMHQ7bDMwW65Z0q4UxLa79EFUXYxYw5mcb60/xlAv9og8ln7y7vAYL5yrIYa/XyH4rYM9YTrL1V1tMM89Q+2NFW3SC5Cao8Qrnqbawnt0UlZRk6nlHjnCQXEBbc6p9z1V1vQqO9uLBbqBdIc2qJ/343VGAC/Uk1uGmp514iC4/RW6PCJ0yqM4Kn1rczHQSgR148IoVbBySN5OHZkUpvSYXEUkLLKc91485QzDm0BBoO4kSNbJwNtZuie/6u2yyuH9lORI1uu1ZBM2irifHDVA86SAIbMA5fWQV/JMdF1+f5rM0N+aTOsuszHdT8k2SJ7MjG4ODUmLHL2E5ME0OPXRc9V9yyaM1wwaE/PE82xE/WrsGzvgxR2lIdSNP47BJtpxlGQ6Ctm+2jevVvmgs/EHYPMA8nCF9O0/MHOnS0AcH4rz9pKcAlKuBlOXKgDRnwXL/HPv4wwXxQH+vbO5yh2VLOsRj1TRpVHDiPo6+bRUCxJ0ApNSlSMhSc25xPZwuEZHZzL7b3A99Zd2ui9rM0rLzJv0ClPBEwgyTBV/qQbpuPbky85kFekbMJbCXh/B6VqyvCCTmXDp5paVfTuApXyj3MvXT6hZmqmTTDtGlkxQ4PeMiRNmBPOTDnZzvAjlQx5wo0vT8qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(31696002)(83380400001)(2616005)(107886003)(186003)(26005)(53546011)(6512007)(6506007)(82960400001)(38100700002)(478600001)(6666004)(6486002)(36916002)(41300700001)(316002)(66556008)(66946007)(66476007)(86362001)(6916009)(4326008)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi8wWUpCZ0h4bmhxTXVrb25nbE1SSlZGVkFMZ3RFTlhPRFlteFV4N3JlejBB?=
 =?utf-8?B?Tlp1NW1JS3pYZXFydE5Pbnp4akVZd0IzQjJpQ2VWcmlnVERLSW4vMFVVS3Ir?=
 =?utf-8?B?cVZRSENEY1g2LzYvZ3FWTnZDb0h2aElrZ3BDRmNvMSs3dlRmVCs0MVhnUVM4?=
 =?utf-8?B?RkE3dTFDL25uZHFmVE1zMVYvMEJpRVNOazg1dE82ZDNsL2xSUFR3am43Vmxn?=
 =?utf-8?B?MFNmUVpyR1N1VTZTVzFyaEUvNERxNmdkNks1aFBvR2VUelgvYVN3ZFprK0hW?=
 =?utf-8?B?Yk5qVjdxOVFEOFl3QmM5QkJ5cDdsaHlhVHpxNVJ6RTRXMWpFRUN4T0lwMnlm?=
 =?utf-8?B?ODhzOWs5c05FZXZJb1Z4bFdtaTEveVFKdThyOXQxeDJteDZwNFltbjBEd2hL?=
 =?utf-8?B?eUtpcDZvTllLNE4rVlN4WTdOQXJhdnlUNFBpRU1ma2hFVEYyWnVRNXhQRzcx?=
 =?utf-8?B?OGN2S3V5NXlOdVRqdjZ0ZVgyMFJZNlRuTXk0ZzV2OHdpMUgvYzZ1L0hTL09P?=
 =?utf-8?B?VjQwWm1wNnBCbE5CRU41azEyOUFVWXBiNEdYYUFtYmxRbVV0R0J4OVNNVWFt?=
 =?utf-8?B?OWdPN3BhdkJGVXBQSUVQZWxqUmk0aVZXV3RORnlicFRDU2hRWnMvMFhlZXB1?=
 =?utf-8?B?cllZWUdSYkNPNDh3V2kxSXpRUXN4emp5YkduZkpnTEpHYVZHVUVHM2FaQ1B5?=
 =?utf-8?B?cU1hc2dveG52V1dvaEFBUHNyRzl5dTBob28zZmc5Sm96U0taNTRPZUs1blZ3?=
 =?utf-8?B?MGJXd0RyNUY3M3h0ZWhQbm45VmxCMU5ZVHd6WnoxWGRua0c1RHEwSDZRRXkx?=
 =?utf-8?B?QlI0bkNDUWoxZS8zOHZwdnBXem14bTBiS1N1WE53QVV5TWV5dVUvOU9BdE05?=
 =?utf-8?B?MEdibVg1V1Fpdzdza3pueFhhTFM2UGlYUDhSRUxvbHBCOTFEbXhla1VlTkFY?=
 =?utf-8?B?NEJXSWQyUlNIYlp5N20wL3phNjJPc3V3c3JMSlkrZ2poQnc1RWpTWjVKMWxT?=
 =?utf-8?B?NDRjeFZEa1RnOVJkNHNYRnhQMkttWTB2ekpzWVQwbkpWM0xxRzQ2NHRFbTZO?=
 =?utf-8?B?M1JHeUxUcmtVbkhXODdETklkc1hiY0Z5a3A1blNXSzVwMldKOXdLWkxtNXZB?=
 =?utf-8?B?MXhFNU5ydTMrYXF4eWgwaXh3cy8vbVBQRzJRL0t1czE4T3JORWlCdWFwemFP?=
 =?utf-8?B?Z2cvcEVaWFk5NDkrS0tvUkh5cmo1OHdjdjRiZXp1bWNhSnQ0MDJRSEFyb0hR?=
 =?utf-8?B?OVZWakJMbXI2dGpWNHZ3MEpLYm55Zlo1ZElxNXJFcFZGMjVnN211Q0tYUkxt?=
 =?utf-8?B?Snk5NHpjMkdJM3JFL0o1YWh2SlprRUd1emtEbitBemlWaVVkdmVxTmltZVJK?=
 =?utf-8?B?K2Q4c3VlZk85QU1GMUlEb2ZEdkt6RGEvekt1cDR2WjNxdDh3S1J6c1NEaHdO?=
 =?utf-8?B?QkkvUXRDbFZ5K0lUdjd3NHlrWTV2Yk9ML2NjbHZCOEtYWmlyYWk1S1NlUnYz?=
 =?utf-8?B?bmtTd0FPRUVaQjViOEwwY3JKZEtoMXVDZW1BSSsxMzlkdmhES1ZkT0NOZkVh?=
 =?utf-8?B?OXMzd0hxU2FuRGFRVjdNQTNvYXc3bUV3L29GNm5ENGFwVDRDSzRIRStsalNG?=
 =?utf-8?B?S01WajVGZlpuYUVDdFU0OVhLbjd0UUpzYmFIVWhOM3NacFFScU5tWUtkYkpB?=
 =?utf-8?B?VDc3YndhVTlkMTdVYzlma3Rya1RkUzJPWU9PcFNRODNOc1pKazhERDl1ekNr?=
 =?utf-8?B?UXlwVjV5dlRrVk9MWTZjQnlma1lubEl6ckZ5RnJMYlZKZ2ZLa0UvNUdaaUlI?=
 =?utf-8?B?VGgvSTNNT2xDdHB1SDFGNk5QYnFsTllWZGVhcGdXSjRSM2g3N1YvTm8zYUNs?=
 =?utf-8?B?cWlQU3grVW96T002d0lSRVgvL3FKNkQzd2R2SzBCR2twbUtJRkVXNUJUbGgy?=
 =?utf-8?B?UnpiOUZVM2RGY1hINEhVZzNUVGEzQ0ZIYlpnN005RkRxZGZKaHdDTnl0Q2FY?=
 =?utf-8?B?bUZqbXROSW1iSk5oUEhXU2Njc0UzM0pQaGg5WU9UazJCWkoyN3hyTHhDMWs5?=
 =?utf-8?B?YW91WUVuS3YvL0laRXVZZGYrOXNTaTJJU2RLSFc3Ymc5R1NhSUpHRm1jZHlo?=
 =?utf-8?Q?pkEa+vBOLoLkUavdq7y1PKozA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca330db6-ac1d-46eb-d838-08db55e36e96
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:59:10.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SACQ/JZRGpYLx+hcirOzBqoFHHLpGA4VSDRBXL8FaZ6DDrS2YaOd057wJUiByfBOJ+hWZWm6turnExlbtUj6aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/3/2023 10:57 PM, Davidlohr Bueso wrote:

>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>     mbox_cmd->return_code =
>         FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> 
> +    /*
> +     * Handle the background command in a synchronous manner.
> +     *
> +     * All other mailbox commands will serialize/queue on the mbox_mutex,
> +     * which we currently hold. Furthermore this also guarantees that
> +     * cxl_mbox_background_complete() checks are safe amongst each other,
> +     * in that no new bg operation can occur in between.
> +     *
> +     * Background operations are timesliced in accordance with the nature
> +     * of the command. In the event of timeout, the mailbox state is
> +     * indeterminate until the next successful command submission and the
> +     * driver can get back in sync with the hardware state.
> +     */
> +    if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +        long ret;
> +        u64 bg_status_reg;
> +        int i, timeout = mbox_cmd->poll_interval;
> +
> +        dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +            mbox_cmd->opcode);
> +
> +        for (i = 0; i < mbox_cmd->poll_count; i++) {
> +            ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
> +                    cxl_mbox_background_complete(cxlds),
> +                    TASK_INTERRUPTIBLE,
> +                    msecs_to_jiffies(timeout));
> +            if (ret > 0)
> +                break;
> +            if (ret < 0) /* interrupted by a signal */
> +                return ret;

What do you think if adding a dev_dbg() here for outputting current percentage complete for debugging? is it helpful?

Thanks
Ming


> +        }
> +
> +        if (!cxl_mbox_background_complete(cxlds)) {
> +            u64 md_status =
> +                readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +            cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +                    "background timeout");
> +            return -ETIMEDOUT;
> +        }
> +
> +        bg_status_reg = readq(cxlds->regs.mbox +
> +                      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +        mbox_cmd->return_code =
> +            FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +                  bg_status_reg);
> +        dev_dbg(dev,
> +            "Mailbox background operation (0x%04x) completed\n",
> +            mbox_cmd->opcode);
> +    }
> +
>     if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>         dev_dbg(dev, "Mailbox operation had an error: %s\n",
>             cxl_mbox_cmd_rc2str(mbox_cmd));
> @@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>     dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>         cxlds->payload_size);
> 
> +    rcuwait_init(&cxlds->mbox_wait);
> +    if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> +        int irq, msgnum;
> +        struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +        msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +        irq = pci_irq_vector(pdev, msgnum);
> +        if (irq < 0)
> +            goto mbox_poll;
> +
> +        if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> +                     IRQF_SHARED, NULL, cxlds))
> +            goto mbox_poll;
> +
> +        /* only enable background cmd mbox irq support */
> +        writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +               cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +        return 0;
> +    }
> +
> +mbox_poll:
> +    dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>     return 0;
>  }
> 
> -- 
> 2.40.1

