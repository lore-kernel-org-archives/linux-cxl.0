Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84255C636D7
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBVBbW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBbQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:31:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2692E806
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677029475; x=1708565475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d/duY+V1sVrG56LMfP9k3BCrt3HB+02cCCYdeRcerUI=;
  b=fBjPN/RqITkrrGc3WTye5ZzXCXo5FjuQ/BRSX8Nq1ttZ2aCWhMdB5pG6
   O3unfUY7MYSH/fuY5TtrLqK5S6OyZIPvJN/1hZ9CQNa2+c+rqot8vM1KO
   ijMc8szkVvQnzV5jMXNA1fEIkh/wwGLzb8PKvCqZtPud5k+ZrDIRkpELn
   AFWPc36VPL9vNmcfUmYT1xH34Ds2EesPFJ8TIgPNXraim+fJZlJWjkMxj
   D+omspxbj+xtWy5kgoiUltmCRWoKbm+3I2xEUL/BP3NvAGb4YG6K5PsUd
   NY3T/uteaMxtM6CpO2ndkllLE29wRhK+lUpl4FEPSEUBxSo2R9y6vMxPH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="316530453"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="316530453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845940143"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="845940143"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2023 17:31:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:31:12 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:31:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 17:31:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 17:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZNP/v1m2Cw592R9Sf2Y1gZL6L4AHenGOyKRDh7W6UcR+mOXlLO9YF1Ag8aeDh8BbaK6tdIpTJ28PPw3eNByEnkr/nGne3NiZlmid/nOi0x1GmRy3oouvPFqV9+uXgh4Mn7HBgFG3/dBYMfHFBE39O6YXnXOUEmDmyEnSeiyy+ZfQrJ2rjtuCwLZwgYR/dJE+9LPRNWuQ2t7FJef+LRDpDHbPsS6NjWZz4YjoGpz/oNONEGecbbJo+7tZlCDKlmIjuFP/qw/SD/14iumViMCUh+C4ekE0U82fVDiXtKXSr3KrvFTVQOA0YGnybJUpFAQnXQQuSMgQ4EK5kDsZKlChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IghqwL5zHkDFZwDbK7UWldVbLm73GqLu94ATy2hLurk=;
 b=PnSNklIP36q2+6/tWz4iZjgN/d8B4K9XfDcdlCzqpIPjMzewhCfBT00feIddgdWBHwFe4LyM/84N/xTofyt/mbE8707S6YO9EyCh5a/rA2rfnV35YJIovxxsiPX84kVqLeJNwXqwvTP3lcv+xUmb32vBDC4l/IZmuAXpnSX6QQSpXOTQASdhwS1cILV2yVI+B9r2HwJAkJzJ9kCe3hLmRufnG4byBg2J+ykvIoMjKw9UCjncvTUHIDGX7qoJ+9f6sTFd7s5wkRyr6Q62G0p7NfUla/6uaf9CqXXhk+PCEBh4hxzQCWH6lek25U898R3Af2khM0BykEOZ0r3d7bdgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 01:31:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:31:07 +0000
Date:   Tue, 21 Feb 2023 17:31:03 -0800
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
Subject: Re: [PATCH 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <63f5705742795_1dc7bb29450@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
 <20230217181812.26995-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217181812.26995-7-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: d45f29fb-72d5-48e9-2648-08db14747884
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHkFGwF4kuJA/O0PQ2PvhuEHCp4O2MOKEJuBW70WNRvgdOHzMPnAUNaNjurvS75rEImvbVnbQUmgcJ7vmvSWtXLwZrr+mtgNEBPwRbTosnWSo+PA/eYLsCXfW/tiL3rDfomXmNy2vyuNHP8NAUYoZZ1szz9Asrtv0Kfo/a5oIkNd1Q+ExIPmwYf0bUgat/AZas2LwVKa38UJ9uLbmXWeT/jpc8LL3k956U4qoRWDV2/f7IH+N9Xuqp+KZcDIQkfkFwWfpVXx3RrM80cJCtvtDNjsAoyfMF1AG+FqRXtNx89IVtELb1shxc9LzafCcvs/VD6O+uoBOa6cN2wX8gTOZKnpFfJO7Y5jyOw9JiyDe0dkPpsONkfBlKlDHJgKq1YCJOu6PO20iqt5kWm72j8v6Bnei8DK+FStDUeXxrJ//Rk3QTWFYqWBcGMH/IEKis73XzhKf3KLSifSJfvaXqB6a01lZqYjZcbGlo6BFDEjjVN0Ye7LAFGLj/AOeIU1flzm1Go+Qae+gctoW/+dz/zbCHfxP1AGRrleGcwZC3EVDVeM6JmZEtzUuXQtasJqveFv2+4TjMps08I2XQx0dQxxilwVM+hPrWBj9ttwudPRUWtJthIu0y/gF+zxPM4cAAjLG8lm6w8nL/Oo3ieX58NEvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(6666004)(107886003)(478600001)(6486002)(83380400001)(86362001)(82960400001)(38100700002)(9686003)(26005)(6512007)(186003)(6506007)(8936002)(8676002)(4326008)(66556008)(66476007)(66946007)(2906002)(41300700001)(5660300002)(7416002)(44832011)(15650500001)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOgAuF7EZdPNm3w3SANNfGOUw+wi96er1ahMakO+ZQx1sd/UQXEn9aTokQwO?=
 =?us-ascii?Q?fwUIFYXFcl1hR+z7nYdsuRMTgKoJMjtDiXZOLgl7D96ivjjXjrmMtZKTsggM?=
 =?us-ascii?Q?yRphS46dfl+ZtxqxgrMVRHU69B7JG7G3EujyiPUYDbirhXjA3QkLDF41OSy2?=
 =?us-ascii?Q?Ukz5cQ43eMYlvfvuAcS0W1zrzIaQ6TMa18JyXBwO/FnQKV848excwwk89c8Z?=
 =?us-ascii?Q?/czEaW9tFkUIuI4zxR/nzBAjqsEOLjwKUh4LMyjzuyXsZM4mWf4h0qStmRnM?=
 =?us-ascii?Q?+3BPeNgf/yJaiO1SQS15BL//vPpesh3jQtqRYpXl2Il8IG8b8H/0lJAgos0K?=
 =?us-ascii?Q?2pq1zdZ0Z08Rn5RXnMjldNbBQjzAtfehaL0hZ2OJmPUhwtOLHdK27rUW56zZ?=
 =?us-ascii?Q?ii0flXAy6VNdh8WIX7J2Dx04bJ6VWtKQfz4ptKIbY5x885sQcMpBANosttHV?=
 =?us-ascii?Q?M2kSOMuPTXCUPCSOnzD4xlYPu63pf3eYQjPQDAXcYVSw7bXlq6R5r44SHzDD?=
 =?us-ascii?Q?EPdiPKKzXWnJ+8fSFaEUrTieraIx9ZgbjtdsBNF7qkN4mHwh9apnOJOYcrox?=
 =?us-ascii?Q?mne9+jujBe+lRIAKJiyh8pPNAOtO3i76YQO2pYJiEcoD/LMK6hxcgAgIU7JV?=
 =?us-ascii?Q?sA/tsjZKbFajbEHCWM1NOtl2U/DM6YXxP3HCo34IOIMO036F5+suBMzNQI6F?=
 =?us-ascii?Q?jKFD5OyEtTOrQwbK3qAjpPq9gWpDmfNxB5BBmectw6hhOhMASPtJ0EiAY/Y3?=
 =?us-ascii?Q?OMdAM6y9QYA/cKAQTqwlhkZaqqVnoKkWKyUV+ApuYSuZt39N9W4nfSbXlny4?=
 =?us-ascii?Q?GrGmqjne/SIEShbOotS01NTUVP7PX3LxzRgGkVLR3213si/GjcIlAQV+y6SY?=
 =?us-ascii?Q?grwaEAJxjGaFvwqd6c56YROaglcQfTo4KcLwNonlQY1Dnn+ClMuNf3H9Dq6j?=
 =?us-ascii?Q?FdqD/vXT1Qa6p0cY8SMB32TO+7MrcLg6fxwlTqSzBW0Tg8sS16NCuwfmSZ9V?=
 =?us-ascii?Q?JVVEfpWz+x821vyuxS1i/ExksLpPdnuVA9udf4Eam3qW1vqO8NCOfg5E0Dmv?=
 =?us-ascii?Q?226Gqcij62YSsuUHdgvJ52X3HI8BrSRWy9TktByFYG5xyDSy7dA32uZIvDlH?=
 =?us-ascii?Q?guwxfbSWvCSgW78cyZm/oIq2eg0sFQVwah82LRWTJZPXhlmYyyxw84MhKNgE?=
 =?us-ascii?Q?i4MnA3BuWv+hhYXzc2SgnusnXh2+cz9DML0ZUfatZq03CJ/B8zZpf4B2nonK?=
 =?us-ascii?Q?N88DdWuBnzEyeCSTHL7YpBIFvZjKfwTwer95LTR81oYMEhBeeDFuIcln3/3I?=
 =?us-ascii?Q?yqTxYAnZID4soKjL1/TCbu9VBwtvVVW36XUZplmUp3Lixm9J6ij3gXzdbxoG?=
 =?us-ascii?Q?a78PZnURsEFxJGvT7fpw8tqy8vvZaCWzv0d/9aCaEGMQXHk8LRg5N2j3Eii5?=
 =?us-ascii?Q?PqFmYtd+UyGb7zciV2tz862OTZpx8/GZMh4owGNUFx55I9O+aepaViPV40Uz?=
 =?us-ascii?Q?LsaPOSoU29hlnl2L5dtdA4FikroGHoaOFzF+hbXej4LxfEOYK7yDh6WePb7I?=
 =?us-ascii?Q?4+8FfpLQOa7zxlqmwlQoY+ULt9IGJOjR6pflYhC0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d45f29fb-72d5-48e9-2648-08db14747884
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:31:07.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oblbvzgajhnoh09Mix+1z4EFF6Rp+jPwXSQGWzUTKnw9HmahnyNjVsxx4ZsM5YyMHwqF6VKTEqIm/Ea3hQzHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5885
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 77 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 36 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 114 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7d3f7bcd3a..f56c76b205 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -65,6 +65,7 @@ enum {
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
>  };
>  
>  struct cxl_cmd;
> @@ -474,6 +475,80 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    struct clear_poison_pl {
> +        uint64_t dpa;
> +        uint8_t data[64];
> +    };
> +    CXLPoison *ent;
> +
> +    struct clear_poison_pl *in = (void *)cmd->payload;
> +
> +    if (in->dpa + 64 > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((in->dpa < ent->start) || (in->dpa >= ent->start + ent->length)) {
> +            continue;
> +        }
> +        /* Do accounting early as we know one will go away */
> +        ct3d->poison_list_cnt--;
> +        if (in->dpa > ent->start) {
> +            CXLPoison *frag;
> +            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {

Isn't this always impossible because poison_list_cnt was just decremented?

I wonder if the early accounting is correct with this check.

> +                cxl_set_poison_list_overflowed(ct3d);
> +                break;
> +            }
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = ent->start;
> +            frag->length = in->dpa - ent->start;
> +            frag->type = ent->type;
> +
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +        if (in->dpa + 64 < ent->start + ent->length) {
> +            CXLPoison *frag;
> +
> +            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +                cxl_set_poison_list_overflowed(ct3d);
> +                break;
> +            }
> +
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = in->dpa + 64;
> +            frag->length = ent->start + ent->length - frag->start;
> +            frag->type = ent->type;
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +        /* Any fragments have been added, free original entry */
> +        QLIST_REMOVE(ent, node);

Seems safer to decrement here and check limit prior to adding the
fragments above.

> +        g_free(ent);
> +        break;
> +    }
> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline)

Per Qemu coding you need '{'.  But is this check needed? ...

> +        if (!cvc->set_cacheline(ct3d, in->dpa, in->data)) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -505,6 +580,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
>          cmd_media_inject_poison, 8, 0 },
> +    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> +        cmd_media_clear_poison, 72, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3585f78b4e..8adc725edc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -925,6 +925,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }
> +
> +    if (vmr) {
> +        if (dpa_offset <= int128_get64(vmr->size)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
> +    return true;
> +}
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>  {
>          ct3d->poison_list_overflowed = true;
> @@ -1146,6 +1181,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->get_lsa_size = get_lsa_size;
>      cvc->get_lsa = get_lsa;
>      cvc->set_lsa = set_lsa;
> +    cvc->set_cacheline = set_cacheline;

...  This is always set?

Ira

>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3cb77fe8a5..0a05f21e40 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -326,6 +326,7 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -- 
> 2.37.2
> 


