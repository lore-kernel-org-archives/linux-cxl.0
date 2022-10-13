Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C8C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 16:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJMQ1X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJMQ1T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 12:27:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11239127421
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 09:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yeoo+ul5qCqhzSI7GAb/4mgqbfPQYbqtxF130CCDzeQS0LTtOhjLVz6Etca2rxvVTEhdhNjEHzp6v7CJVKahSq8DjrX/JKcuiXU5dOMwDH555BdIXuH0a9cgs/Avnl4j1YK7/Yl8ODUeiNGWWCKK4YLVS4zNkoLvbdOoOgCwzkwMI4ZUizS1H8effEsg+GOR3Jm+/x/JXIzlmhGNS1qpcYaxWZTSlJE+bjBe4vDSeA6AFDOW86dYsBEtkd+CRvf7usqNNsy6qap5ZL7ex0Br2iE0YSpv74Zj0rtGwvxaHs9uZHEf2avPphGPYG+kvvO6pUo+xC39/n2ZJY/ldSO8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azGL0t5LMjk1iP7tgVayjuNPiRSkX2SEOJto0/1l9K8=;
 b=a5wE67yta7l/ElWzdY1oWHPvnTKWDyXQYXOTJMV2QnPA4QT+cFG6/8O6vEFHUqZCrzcHrYBRdwZIqRkR4HK8UQEq0WivfinYwPqUPDik0EBUHPtox1F1Dwq1s+Ua5q1JMsIzQmuqS0eTSt7rvnbFBOSPSIr4lkg7Fu3AEPUJpMdJsSK+Zgl3fPkHUHBrIM9UyveHw1AUVhw+IgQqn6t3GzbBiDXdUC4AoL4G97m964GYG/U+hCa+ciGkTNQwxXGM1dCwCFf/iHZ5+rn/Ce7KTBFTLQei3MjMKKqbnO+8wtTuYJpQfxBi2VgtnSqbAjOpmXlTqzvt248/cXLNwWPuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azGL0t5LMjk1iP7tgVayjuNPiRSkX2SEOJto0/1l9K8=;
 b=YPh/bj0l4RdXj1xHCSPvplBHUwLESvXPStKUg8PRArdNxY+TMhXpY6UyXEiIrZFrKy/714AtRRffJIAbohmPLyTLRHd2F+Ao5wYBQT/xEL2VH1uui59QS1ErvzfDRKc+JzX58wLhmIXlldCI67YvaXqp+g1ndmD8y3vBXEzi2+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB5097.namprd17.prod.outlook.com (2603:10b6:303:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 16:27:14 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 16:27:12 +0000
Date:   Thu, 13 Oct 2022 12:26:58 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, ira.weiny@intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v8 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <Y0g8UgumJwqU4QyB@memverge.com>
References: <20221013120009.15541-1-Jonathan.Cameron@huawei.com>
 <20221013120009.15541-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013120009.15541-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::32) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7717c743-f06b-4022-3734-08daad37c83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 860a+qAWLTi0Qy4ZZ9GR+vOcT6drmw2owUrL2hkK9pG4asuOi+l05t4OnVw3hmsfUl5UiVI22TLhyqsuiF1owuRDgvriXBZMJa8Ja7Wq+Wbmd7I+XapAD7FK4G4kvY8423RY1nxRu/7y68hi5j9ILMVoghzWvJndgFpPT6zfMvmyqxTexXFSS/DWPAJqL5AO6cjaD1VFZzOvEPtklr3ihvOjPW0GgJoUffUsx1Ip73spbYda9lfzBb0Pl8W5F+ovOLxR100Q7sHO91Pgn5IDWHmyN97RGmg9Ffun/sPybL1bq0kCXz/G2EivUSTl2STYMc8+GWLHLDVUKtvcMHCECtKqYPktzNgFS0WMW6jmoOMG/vBj/CuYTLvxsjawVfFzdTEPwzaIa3M916rPSQ1NoT9mTBnpXpeHcehQhxdZiHAbHSqDCmRHGek/Lk6rrogqO82FK+uCAkk/QXsU5ZiC+zpq3gjScPtHsFqdTGuM5GWwIw90IGnZOk4Tw9887GAEkdgEN8h7iawUdPj2Z+BpzeG3wTBS5SsUUMMUeywszSEPHuZAwLsfSNVandFq2cZKVCSr2kYh0HrpffMYs9IEUiurTLKDbVPS4iCI/kG+Kczlbmykul2AFjhjef6kj1sRhdRtnK3qHDAzmb2N1n2MSF28/lSJFO26ye8xpmesijUXJzyd1dLKYk0KUg6dSWGyrA/w+FUtZYYYZSrYAUzanw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(39840400004)(396003)(451199015)(86362001)(5660300002)(8936002)(44832011)(478600001)(6486002)(41300700001)(66946007)(66556008)(8676002)(4326008)(66476007)(54906003)(316002)(2906002)(36756003)(38100700002)(6512007)(26005)(2616005)(6916009)(6506007)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTNN2SI8ICABWKFJt5uJljFBHB2jl2g8ULHUEFSDssc4RKL9QhzXfPajEuJ8?=
 =?us-ascii?Q?w538o/iTYTKEmK5aYWzh6cU55WcQgWNulXYgie0sOxvv0kQblzBn0b2Uq3kg?=
 =?us-ascii?Q?eYwdQiIpL9IJTlghOzbvEb5x3/td7e2V/6tSzOjwEOPx5sBGEAyNkfWk/dpi?=
 =?us-ascii?Q?EGEXDuPcTaJ4BnIlNwN917IF7hiMv/9HT85mm5zQOQ1gh1WehOuvacS0x/l7?=
 =?us-ascii?Q?gsUtXjC9XnAO5TkGKi6B9QxFXH6TpDsBbeipZe2S5fO+jOjZtaVoWgdAR97B?=
 =?us-ascii?Q?XskrYbNruWSb9rv63r2UgFB90kBq7W7ezH4fkVwtznPlD+nEzXKiIubmBn5Z?=
 =?us-ascii?Q?1VtCE70pVq2mX4DIFHw0JqwlyRoZq/RFTJu18IH/2/xyAgGGYk39R7LR7XU/?=
 =?us-ascii?Q?TubaCbc9Nj5o5BGdkzWYAbmH7ewpmUU9ikeCyLnqhwWPtp0A+vrHnjKjBWJv?=
 =?us-ascii?Q?eCI/0kxtcFBBNoy6VC23YZcHUJO9VKfcKSTOUMysDfdTtMqnfW9l6/EAZLi1?=
 =?us-ascii?Q?wiVazQEgUvTksuBzcEoAwcsBZ/6Lezr3cMIS+1Lf7kpDItoO7XgVAtEks7lW?=
 =?us-ascii?Q?RVDspKlcXx0O+4OyURXddeYZYY5Z6EW02ezj1gplKkvrQ3gAnG7Aeib1JQo0?=
 =?us-ascii?Q?9nEsjscQ3Uf6VE03VrVBDg75dmgJA1a877YDR1p/mS//duJEeWCxf3ujwPEt?=
 =?us-ascii?Q?LeivsV94DKUV8uTFy5tq0CLVD8XwLG9liAI96TIfV2UMUSFyaeYO/VYZHa1U?=
 =?us-ascii?Q?FVK69/kz5dYU4db6KOTJcBZr8lHgc0IuzQPXe/z1YHJpkdKFzvyKVhEL89oc?=
 =?us-ascii?Q?mDW34GT8WV6zScG6msDJdmpKXSJbzmur6md9YtVesST2Kntz7y7WrtwCZgn9?=
 =?us-ascii?Q?OcMoPQWAnUOG97fzaZVfacYnxhy4uZJQAiEarzx8wi6M8w19PqiMXwJqbyDj?=
 =?us-ascii?Q?CiKMHO7lK50SAcM/XpsjbNSla4xHuamHUL6cMkSV24B9ZQTxwek0b4FUsC4y?=
 =?us-ascii?Q?1tziBP6FKCt7l48TJ727Gng//pQ3wMeseOM0iJdJkVYXSX8ELP6FmA6JHUH1?=
 =?us-ascii?Q?EhDEYPSzzd/yrwDASSp/DjTKF5QhBS0RACSO8XmwhshJXqbQhEXRaPlEQ5pv?=
 =?us-ascii?Q?LJgk4axfsUqqc4GEKgc2xCLB+u7bM/wb28BgvZaUlKgAT4DRRts6GnQtrS6I?=
 =?us-ascii?Q?g/NHC/TGN7HoBQ70JrkBte77bzWj+R9Tu68eip+bZOyuJpcwT25WtpP/lVLw?=
 =?us-ascii?Q?zyvzU4LuFN3T867etfyzefX5eI3WSbnjJSzSY8jmB3jJErm15KMv5kurx0vf?=
 =?us-ascii?Q?5Lft8KT2svVBKutr0Iw2wR1w9GQS/Y4QMfJnu67AH39RGofgApwpVkCkt8GR?=
 =?us-ascii?Q?0gYGPtfFk0f2nmFq1LvqEkUHjEv6M+o3sm1S0VVI7go1xvOanWGuHkifosPn?=
 =?us-ascii?Q?t80OKLz830oljGj0WMM15cadag+5rO31hj6j7NnsXHS881a9kmDtC0bvMOnB?=
 =?us-ascii?Q?CEy+UecaKtz/X1gY3g0EsiWP6XnBd6QZQHjn7DS2WlMNOzoYNdFXFIMzNxzv?=
 =?us-ascii?Q?f+rf+8nuDBe/3A2N7dbb7EXjjG+y5rreWhgQ3u6NPRgpz3IIN0igVaphhtwl?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717c743-f06b-4022-3734-08daad37c83e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 16:27:12.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY8JBdnlpvO7zfBx3strELk1E3Doz0SwXVi59XYZtoDrhOQ7ljWLGoM+/hinhbAqDXrjsy31MFHWtyw/GBD5BDSWlOrqTmSN/r2Q39gfT70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5097
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Other than the nitpicks below, lgtm.  Not sure if you need a sign off
from me given the contributions:

Signed-off-by: Gregory Price <gregory.price@memverge.com>

> +/* If no cdat_table == NULL returns number of entries */
> +static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> +                                         int dsmad_handle, MemoryRegion *mr)
> +{
> +    enum {
> +        DSMAS,
> +        DSLBIS0,
> +        DSLBIS1,
> +        DSLBIS2,
> +        DSLBIS3,
> +        DSEMTS,
> +        NUM_ENTRIES
> +    };
// ...
> +    if (!cdat_table) {
> +        return NUM_ENTRIES;
> +    }

the only thing that i would recommend is making this enum global (maybe
renaming them CT3_CDAT_[ENTRY_NAME]) and using CT3_CDAT_NUM_ENTRIES
directly in the function that allocates the cdat buffer itself. I do
understand the want to keep the enum and the code creating the entries
co-located though, so i'm just nitpicking here i guess.

Generally I dislike the pattern of passing a NULL into a function to get
configuration data, and then calling that function again.  This function
wants to be named...

ct3_build_cdat_entries_for_mr_or_get_table_size_if_cdat_is_null(...)

to accurately describe what it does.  Just kinda feels like an extra
function call for no reason.

But either way, it works, this is just a nitpick on my side.

> +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> +{
> +    g_autofree CDATSubHeader **table = NULL;
> +    CXLType3Dev *ct3d = priv;
> +    MemoryRegion *volatile_mr;
> +    /* ... snip ... */
> +}

s/volatile/nonvolatile
