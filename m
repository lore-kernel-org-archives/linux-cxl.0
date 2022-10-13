Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B06C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJMTlA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMTk7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 15:40:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF23183E20
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 12:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9HN19d3oZ/z+lAVxTbuI0IY+jsC+DnQUQS8l6k02iM32MJ5TGREqteSzQkup+AeHSyuskrHPMamMiRi+DpiGsvbwdKQ2ajeGOvWwQB7dNEWI9dQCBx3S+x+0BspFx7zq9CeIg3mrEvyK38hIjOi1kHY/BB1Wmc3/oTcUDOwOV5Qgyifi3RcrUV+wGXPcGYjlaTX25QXqwuX0bVO+I8HECUGdhiaDeBFl81OpLBqPqPPfecGZz6TIUhY9F2JitQc5tdswXd28vpl3ydq1dswQ845G/M+BGvdYBP+HEPBigk/7CDrTdO7aENlCaECa1fQn3W8Ry/wpVmC7kGRb8r9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+chQ5uadZX4fbCkDh+tSOg1taXTTpXXTY1rssMuLu18=;
 b=hAc26JW9EMIePSYLarA7BDWeznPNCii0D6Ok+iTireqbIt9x965Vc6aPLBzN65OskD6xD2PZh3IPCfZzjrgP2MleTtJu70scOjLOoqzJxknaDK1hPCV4T1iUyNmkkO2vRmJ3eQjktKO4ocdCAFxJdE6uapIdHhzXUKHRJQw4b0ZHadAkhP5VLToE7U35WcGQsWbwfXhFC4Ry4KLeI3l2EVfmoPm49qLUJYadz1s5lBPDxPx/U32ixklLL+yUZu3MBxz01rwDFQMu65+MNTmL5LwbkY7g+VYCSnZ+vfNMXg7rpIH6RW7D5ABkIlCkzLsI7IRX4iHTPWnkLj0i/QxHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+chQ5uadZX4fbCkDh+tSOg1taXTTpXXTY1rssMuLu18=;
 b=rsB62i/W1Ee3bub8QyYGQAxxg7LdQ4zY1cmSeFarst04Xl6hXvmcszjecAQ1HF741P+CiGFw2MVnirWgPub3rga3bKHFY9LgR+g3xwMnAJ6rXP6rDncQ9o5Dih+ciafN7IZfREZstqlsD08kp4JVQHDzwLsQ0vKtQy2Q60sHDaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA1PR17MB5124.namprd17.prod.outlook.com (2603:10b6:806:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 13 Oct
 2022 19:40:54 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 19:40:54 +0000
Date:   Thu, 13 Oct 2022 15:40:47 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        mst@redhat.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [PATCH 5/5] hw/mem/cxl_type3: Refactor CDAT sub-table entry
 initialization into a function
Message-ID: <Y0hpv8jdqi+r7f4r@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
 <20221012182120.174142-6-gregory.price@memverge.com>
 <20221013114711.00005623@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013114711.00005623@huawei.com>
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA1PR17MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd9c4f7-6483-4d7e-b9a1-08daad52d7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5fCvKw+qaBhV4iM2E/Uba/xMMn4CnSEZSnFN2FCUar32HAMNLfijKha1OSBcZ0vBry2X+ggyk3EnIqAGluNVBgtTCuYuL0ZjtQK36p8gwv8w9pUA0kVXy1VGtl7vftzU1ArZdIezFj5QOMVgM3cfAvAjlPa/W2VJksMlgoFDUyVWSZg0FtLztanXy73KvEaPHPlzl4bL0wV6sJ+2UvkefLtgUSsZLQKVTQXhrTUGGWE1ikt0KSRDDxmMRveNuVgpk3hBAjNGH6bJDUUS8jSw9eP4ZULdhMj/BVTWiiv2bE5C9GqxAfRVPiTIK61oZelxcPHY1LqXSkbAgLkVLoVozWJJcAhESMbrZmB4hKbgQfp+V8ijQF1Vx0bcqOSCfZHvMH4axV2KPUZ+Ga7fQzYsC6mIZI/HTu0S6FTG4g9dPqTv9ApC6+nZEifKlDNJWoI0U1+khehV77Hn5o6Dhb4ISrCCsBpKPvc0YDGjbraAuqe+/UjgnT7fZvUAOFsGLl9b1aoQHQWMUeMKMAeBb1JKjVIMWEn2ZJnqiUoRcRb4soJ5owJh5a7BaRT5eDfsDAGtSkjtcQUMFbhtugFghjp44+VmsTCAoqvVNGbIBel/SODGNFbacE6Q0eBHPZdhsL6hgWiHJ/lnMRdxa8G6kyGrmdI8U2kYu6NnZKR1gw2sgpznsXWKYUp0NZnbjjBmpPkgoUqGS9Ra4660lS4E9ZSWZ1Ap3q0qpJNNZZV2DliFI+G/DC77OsjBRgu3gcZs+hk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39840400004)(366004)(396003)(451199015)(66476007)(316002)(2906002)(8936002)(7416002)(44832011)(66556008)(6916009)(6486002)(478600001)(38100700002)(66946007)(86362001)(26005)(6512007)(5660300002)(8676002)(4326008)(6666004)(41300700001)(36756003)(6506007)(2616005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXI4WA2QH10iuLrjiYexMATGD5OUDiy1qHEhbrD7YX2SsK5wviTK3SAmVAdC?=
 =?us-ascii?Q?iVygty8w1qDitS1W3xEpjrbnmZkyf7+5oCc84hAAIwZsDeqM2RG5LOOyoEqR?=
 =?us-ascii?Q?nYGoJOtP2XDjK5yQpMkM3MEmm/uW4cwkFFue/9LJJ4El2/DoJZdwMbH63wGg?=
 =?us-ascii?Q?vwaSQ95nr3CqJ2T/ofoZRRh0qo892rpuzlfz29c4pehNEymLsXJyEPXqVJ93?=
 =?us-ascii?Q?BpRl95qHSnmMHeSHpbl9zR0C3+U4U68fEVyNrQY5hmXb8B6+6kYIxQV+VhUW?=
 =?us-ascii?Q?podBcf5dlB8vBXD9rY++smGFTC5l48mJFkueDRbN49zKS4Qvlj9iGvpjk8+f?=
 =?us-ascii?Q?UvuKyVLkRW6Y5qZ0fgWZfJgkLlBfGlV1f9pS2JYhNC89jIsntHWgwdYfDmcF?=
 =?us-ascii?Q?5p27GO74iogMbQPQbSSdcg4yKQ2mytlSqXx10DU1fif6QZvGgOTwEubde5QK?=
 =?us-ascii?Q?IbWHU4Ofxik7d0KZGDLL9kbPSUADhtfP2YmxPig9JVucB5JjRS042uAaNX/w?=
 =?us-ascii?Q?pFdJultHvHI4jXKBy3cYkjj9KrugSHA9K3Iiy0ieXslQQfjJMiCN7H6VD6Ua?=
 =?us-ascii?Q?UUnOWJUgMSPgszhCegnt1saXrHTd7jK7NFNelM7kKV5jWJSMKpj0ECbkdAPm?=
 =?us-ascii?Q?VZgOVhyLtW69gHEEk1gQNZODs6q2KjTAXhUhGg7ckjXvfR7cy0KnToPuyhuL?=
 =?us-ascii?Q?DswASbQ8MIOw2DFaSkWNJro8qc4wb7GTBnfgbSwgOdlkaqM+0Lt+uY2yQHe2?=
 =?us-ascii?Q?aeJt9TMomCR/kEeJ2H8qe72mNvhgxZssUeUDfjoslNKWz4xDV/zP92jSeeQv?=
 =?us-ascii?Q?Oly3S5B4yKx7I2z9YJ8j1Pev+l4muOJiUEbvg4zADbaJ3SwVaKgpWEWFQEbN?=
 =?us-ascii?Q?Di6C6Y4NG/y1xJck2td38HIGQbiXchh4VRh9E9n6vfzH7MFFun+DXU0wT6zL?=
 =?us-ascii?Q?w9IaqLjuI60APm5attwH0VpixJtjcuPXZaaD9agI/6QFLidP34aWJ97x9036?=
 =?us-ascii?Q?r1J97eKXKKTttUnM4E3ohE2h85levY2+J5+sVNayEZ7Ndann+jL/ss/UklUU?=
 =?us-ascii?Q?n6ZDXapIzr4t8hjdBl1qoAekZqFM/9jAncCUlyi0arkx+jKUOQxJL38rnVSq?=
 =?us-ascii?Q?8JLM9bGx1Ih9PfGbVXp9oUva/Ga3dxoNQmirkcXd5+pFj7HP+L76479HRrzW?=
 =?us-ascii?Q?yKCMCbKsY/TJ6qjCVWLMwkMG8sI0K+Mad5W8rvUBPvnF90/q3knS6m2zHRo8?=
 =?us-ascii?Q?GHgs4C/UTurds4CuVKl4oGh1x9TE3ZLn7EWDjxLvABzXZD1j04dPfP83rJ7D?=
 =?us-ascii?Q?6Nf3BmZOEUS1nCqOX4HwmL3gYl7cJHuAGvDWT009rJHmCijAM7xe9/ZiavS7?=
 =?us-ascii?Q?g9KqzSCjAiKVCxShRurK7tuPoim/UU4RvmBZxuXDHG90vVeIVYm0ZWMQCONp?=
 =?us-ascii?Q?74Xj7qP2IFIEKE76MqJQA6bUDBQx0r9ixpUNngDZxut5YVEfLv/Ae4tveFxX?=
 =?us-ascii?Q?DM6oD8WT0PnQzCo3QB40oSFpD4iuO/+hKeWpNubJBaRSGXxqMYxdgoNm64rc?=
 =?us-ascii?Q?FZLe3n68C7Gzz8pl5EL3uhugXgZobbKKKYw8wHI72fWM7rQSqN/M6SAXdJdg?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd9c4f7-6483-4d7e-b9a1-08daad52d7a1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 19:40:54.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULHqSd58E8KgGV78pTM/xriP1SYaEAL98wclDNXyK6m1vRNxWsw6o98lqb6r0GbkmIT/wT4I08B0WZrRCOUetuSS7cPuBYv5zwclaodWv6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5124
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> >      /* For now, no memory side cache, plausiblish numbers */
> > -    *dslbis_nonvolatile1 = (CDATDslbis) {
> > +    *dslbis1 = (CDATDslbis) {
> >          .header = {
> >              .type = CDAT_TYPE_DSLBIS,
> > -            .length = sizeof(*dslbis_nonvolatile1),
> > +            .length = sizeof(*dslbis1),
> >          },
> > -        .handle = nonvolatile_dsmad,
> > +        .handle = dsmad_handle,
> >          .flags = HMAT_LB_MEM_MEMORY,
> >          .data_type = HMAT_LB_DATA_READ_LATENCY,
> >          .entry_base_unit = 10000, /* 10ns base */
> >          .entry[0] = 15, /* 150ns */
> 
> If we are going to wrap this up for volatile / non-volatile 
> we probably need to pass in a reasonable value for these.
> Whilst not technically always true, to test the Linux handling
> I'd want non-volatile to report as longer latency.
> 

Here's a good question

Do we want the base unit and entry to be adjustable for volatile and
nonvolatile regions for the purpose of testing?  Or should this simply
be a static value for each?

Since we need to pass in (is_pmem/is_nonvolatile) or whatever into the
cdat function, we could just use that to do one of a few options:
    1) Select from a static value
    2) Select a static value and apply a multiplier for nvmem
    3) Use a base/value provided by the use and apply a multiplier
    4) Make vmem and pmem have separately configurable latencies
