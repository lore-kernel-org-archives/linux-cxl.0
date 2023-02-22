Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5EC6379F
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjBVBSZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBSY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:18:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752D1ABE3
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677028703; x=1708564703;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oab6FGTxMJklZzP/glb9LMZAiPwXU/31F67xt6GBn3M=;
  b=DHrsqnuOq+uOenQ3N/OJcLMQtnIixgs/qe1HHueoF1uvnh1WB2gd8tbq
   sojWe+IhqkvPpQEiA9k4Xd6UJ1pr6zBNRPshrOiTtyM/ySO1f5/pNsh7T
   w/Kk8Mgs5f3m37UU2c8DQCdctwcZNsVi+nSVC7A3aHh0a1hHmLSDtaRY8
   BZ4fpW1LlEu2B6TW8/ZU1p7iiJ9lciugkHwWZUBuvrUYTXYKaWMeNGVud
   VWwYefYgV21XqM/XJcOM6ndqjAMBJM1du0nV0dNV0i6Q+25UGWNbTG28O
   5G88RkX3o7pGV1v/RNucEep50sfUp8PIlMvZI+IY3U6EIKP8STxkwe5Qn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="320942363"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="320942363"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="795712936"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="795712936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 17:18:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:18:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 17:18:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 17:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6Ei1I4FhMCiqWuEJD8jCjx7K+tJishRHCHkFiA2WLh/3b5wmlZEMha/0iy2OPZNcW2dbNfvIWhZAOEr7G+v6BsWxrb28EKcdl3Z68xhCZY4JUNQ+qqxvvAs+Wsz/W4E+i3oEZWUUTHPTVF4JjBqYWYDBiXVKj0yRYmqpr+GJY+80hdpKBfgcD3FIiChDBHulK4Un/z8UEvO3yNkJi/n9UAjKEfNSOFhKXTw8s/5AiM2abkmP7nOPV6HT53pxFvIp7LZQ4bgUzekEyI6OrWMKrz7J7vg27xxMfq4UlUo8D7LMbKOpjcal+OHCf/oO0QASLkmGty7bRf9/N+GJWzZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMIZbWwf1CN9xPQDcs4rncWD1A8Q8oBr5ostE6QwG3U=;
 b=W6oRTAl5rH6bUZaHiHVemQ1+kYfTAnbOb1D5Yi9H1hGtSvEU9EsPWEEjg70eAlIbN6uZ3JeAGCcg2U+uhQ2GQOm8+TpftEnLehYdVajaCiuDGVL5YedtS3Lk7onIxPg9MsDShcJzHovmWk+2LlxdIWlLE6yNTXCbpZjVexDscX4GZOEvWIjAWs/o0xIgYssN65J++iuUx59x5dB4hSO9Bmc7tXaYoqpeOCWpndKq+JsTf/OvIm0xk2pJWBWgvAf6m2XjaEF+IMPANejFWzFmTCZA9+NOimRe/nMre4QaPKIkJQwJ+uYgc3NL3pjNpuKEL5xuqlCfv+uvlqEqRFPGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 01:18:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:18:05 +0000
Date:   Tue, 21 Feb 2023 17:18:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH 5/6] hw/cxl: Add poison injection via the mailbox.
Message-ID: <63f56d49deb1f_1dc7bb29489@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
 <20230217181812.26995-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217181812.26995-6-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b484012-f505-4e32-5d41-08db1472a62b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fumtL9vexsr4oj4gtsknrHHQWB7GyMRlaTSGKPrs6iRlSz8HKk4M/WbSDysNLzQYCKvG6dSLbNvHFSppJ61GMkOywqnarBZR0BvhOrinoV2yqPnHecq7ZA3MKm5JGlLr8wnOeWRKL/wFnnuWoOG1/glyoXeqHu65S6KQT/ePF8FbQMQhCmZSrOQbBjYI278FwqUgGSFhyHYKieHHK4gqj5oZ7uZYcGSa68NydASZOgT569cQVUEaBMn1lz711Wc9ZaCjTqovHfvmEduJvJ2+Z8/P50oluv2CFKQisLLEAKRTuUDD3/oObVl6+Cq7SVpqIyY4TEj9/b0zu3v6CXJz7uIsPIjGNhpuhnUoEt3iOFaVAbAcg5aOvP2vZQpXzrF/LXFl15IHTidAJre7pewzW5q0qk6pVwoNIX0C/ev6UfpkvyA1rA0wyDNNW8qlpJ6ruo9rEYBkM4nXMQit3XAda4bJVDIw3J/v42X0pR6DsualiEjYGQgbHXTbLIjlZFpYa5ff/ybbgaZ6y141C2ccp08iJK96wqaPmCqjc6NUxXYfDQkeou+o9tl2LgDm42DeoPAH4NUPPukktw+DM1YPF5tv9kdFZCEQVSsm2u3TJxdgdI1vAEwtkLTtjJlDwFtLPBHEbaK5pi1uYmNjbPEkVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(2906002)(86362001)(44832011)(82960400001)(110136005)(38100700002)(15650500001)(6512007)(6486002)(478600001)(186003)(6506007)(26005)(9686003)(66476007)(6666004)(66556008)(66946007)(316002)(41300700001)(83380400001)(54906003)(8676002)(4326008)(107886003)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dChpRbffdrMR5WfE8ETM8B+2cRmpc0GchGBDxpsKXyXfk6H/1B+Wu+iFpiV3?=
 =?us-ascii?Q?9eZ9eXcsUUmotC5x3iYLPBgrseJzmNzEXRkuCtUed89FIWx8lIhU3XzxPh+h?=
 =?us-ascii?Q?Jy+IvsD6FbNo2o6szGT+LwxmP0UbhnXt1xlME26hctv1FRrvOUDI/joW8WeP?=
 =?us-ascii?Q?Ebobsr+Xa9QQboBItkK438JBFQl5yTYDCy1FLwylpwI6o7Hfoi8idjPJIYur?=
 =?us-ascii?Q?/bPw3nR5MXdofn3F1c6m/m0uX67+TXBiH41Smy03tziw+XcAIhqKZWgJLnlL?=
 =?us-ascii?Q?/jsO1nXaxw6iUgZ1C0+G2HrRhpE0AFG2Xbb3VOwNelX0+W3hzszn3bGuWhLy?=
 =?us-ascii?Q?Qg0VZLNoOJpDMItwf5B5JzlRySAFcwI9TICowqUiVMW1gic0BI8U3rgnORBB?=
 =?us-ascii?Q?pztubJ0OMYt1F6eDhf+WRs16/0lTChSF39mZF+o8jGFbGpiSiPlbinMWpMHP?=
 =?us-ascii?Q?72d4qe1QIWFKYpiG14DtQR0XDA2Ih/YCGvm9ox9ZUZbnMRN7hdSCRPVsl639?=
 =?us-ascii?Q?QtgIeyzOK6TSdQ7moEJjAXN0WedDhcw5oxyfj3VaTtgfNsu6KdItEvGU3mmR?=
 =?us-ascii?Q?XrQfa9xZZWo0OtHaYIrP73qsdal0fP2qQmLZgbucsFvL3E15eMnY70zQrVnx?=
 =?us-ascii?Q?b2rko0slAWNihUztLL5i1jTKKz8GRwVh0+VkdNT+wk4hxfrHeGdB2q3J+fCk?=
 =?us-ascii?Q?tn82AnfKFrpunk7bpmpxy+Fx/oXFzNPvFwx+sOPVQeRYOaMTBncDzsMap8F9?=
 =?us-ascii?Q?8lQ7CGVlcE8ScNxW/fGBUHoOhuitEsbUmYdzfvpJ8cvAU9Vy6viwaA8PFTj3?=
 =?us-ascii?Q?WLIS5EJKtlUi870A3K/39XPpfys37UFYmUHxjFG0OCyEhKr86ixySykj/7XG?=
 =?us-ascii?Q?Ja6rvMCcWpr6bDDF2Nu/d8mfhHqmv4mDVA33HIQN0PkpLFeYi+WUN4KEtE4g?=
 =?us-ascii?Q?2g75E2Fwf1TaYXdHvcTy2+c6/pqtCTudFJWnnYfy9tlG3mkbyzJKJz4n8lkE?=
 =?us-ascii?Q?QFrnkF71w7LQ31AnXftyriroHfhiCpwCf5EU+18V61H0wNLKG/Et5gTUUpPe?=
 =?us-ascii?Q?ewP53PGOi1gfNOvJ8kCH/5w/ABK+Y3kY02Y0gJ4Cnb52hr2kKfvepQ80j+6v?=
 =?us-ascii?Q?4YHA8eKtKa3W2c9R3NyLXQ6dcJfEwhs0YZYW5ihFqhoDl4xc/hIrFKdzgmco?=
 =?us-ascii?Q?1qJ+iuXgosRtZYIoC+XUAq8ylUS1oGTauW5q0yuMIgVfWfA+VS4LZNkOOql8?=
 =?us-ascii?Q?LSvSWJXIe2b1MbcYj/2pskPOoT8tDmEcECj+yPHdRYrRaJlAhtF6ATKefrq6?=
 =?us-ascii?Q?SAS4hY4T6jyLf1muQm4I9qEVW89PqaxbrQ3EbX+tTRAxkKRwuhH2JbLH3E55?=
 =?us-ascii?Q?Aa55T691qOKvR71UFeS8SnXX2OLuVd66sL0w54chELB+OV6Na11/EpFr3Gtv?=
 =?us-ascii?Q?dg5Q82UbYt3mcH2z2zuYDFhnumDivvZBVE/v+fHeYHJBMupUSrHpaQeiROic?=
 =?us-ascii?Q?hlRzGL4o7n/f+hbH+7JEuqjW1u/AY1HuBtl+v2Qm87BolnMqJFk5Pzp+Tlyt?=
 =?us-ascii?Q?DXCX7evS4eUcEMNGtGYnXYWbBH15pwPWYENKD65+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b484012-f505-4e32-5d41-08db1472a62b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:18:05.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMGO/2DgHPP4KhwAzHVgvGlGe1ya8N+wtjbULWazTAJuiNKaXGMsQuwH/2FaC8s2AfscarFp75O1rBP6VbiMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Very simple implementation to allow testing of corresponding
> kernel code. Note that for now we track each 64 byte section
> independently.  Whilst a valid implementation choice, it may
> make sense to fuse entries so as to prove out more complex
> corners of the kernel code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 40 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index cf3cfb10a1..7d3f7bcd3a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -64,6 +64,7 @@ enum {
>          #define SET_LSA       0x3
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
>  };
>  
>  struct cxl_cmd;
> @@ -436,6 +437,43 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
> +                                          CXLDeviceState *cxl_dstate,
> +                                          uint16_t *len)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    struct inject_poison_pl {
> +        uint64_t dpa;
> +    };
> +    struct inject_poison_pl *in = (void *)cmd->payload;
> +    CXLPoison *p;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (ent->start == in->dpa && ent->length == 64) {

How does this interact with the QMP inject poison?  Should this be
checking the range of the entries?

Ira

> +            return CXL_MBOX_SUCCESS;
> +        }
> +    }
> +
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        return CXL_MBOX_INJECT_POISON_LIMIT;
> +    }
> +    p = g_new0(CXLPoison, 1);
> +
> +    p->length = 64;
> +    p->start = in->dpa;
> +    p->type = CXL_POISON_TYPE_INJECTED;
> +
> +    /*
> +     * Possible todo: Merge with existing entry if next to it and if same type
> +     */
> +    QLIST_INSERT_HEAD(poison_list, p, node);
> +    ct3d->poison_list_cnt++;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -465,6 +503,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
>          cmd_media_get_poison_list, 16, 0 },
> +    [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
> +        cmd_media_inject_poison, 8, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> -- 
> 2.37.2
> 


