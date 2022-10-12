Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC87C43217
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 16:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJLQCD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJLQCB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 12:02:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AC264A4
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 09:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/XHrvoqyvXMs8gN6/HFd3K9rIo4bqztXe+GTPyu17ukGPcNu6erPFpA2JsXOOBm00I0nKrjd/MOPk1dmZxElZ4tQ5LeGu8/qJnL8sk7IjPtP4vfx7XKJMTcHGDL+YBFGLfvzzIFhI+Wozt2tRQ2Qvx7mKUNJ06qatlA3ov5q39w2TEltg2C6EzySAowue8qm8UX8jwJg0KdKZAJBmvKis0mX2r7Dxqo9yYyvfbzEHG0uIW+ydhQP0o953ZTSMQWVW4faqz+ErBFyP7DyxOR9p/qCOziFR9ih8Wu7GAyVeGvs1OQhYiNsTtcO6HGuU40fRApQAd7TqoIwWvPq0vhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtxeJfCIvMsnJ/sIF83lB1hSeIdJ0ftLnU+V/pykVIc=;
 b=TnVxmWaVBhieqV2t2oQ5eYaW69lyuNRuuOof6cBZ/t6daOffjbI1QPFaw4X5V1WdYyf+QTh5qNiXc3PbEsCqfr7bkfiT3hXtsmjvjLXip7sShLE2wdLfVZZz8M3R7rHKdiJMXV3ajgdJ9c1bXtcbY8TNJ6MFylRecHcJFj7o0kKq9GiGY3XpC5PHGaYfhGPi9vT+Dw0vs6ITwhl7HKmWsubE7dsCO9gsNP4HRV+fUl3Cx2KSmMa+5NOyJug8eJbEYOhM3lheIt22aWqb6E7bvDsbUh+Wc5xrYT8p0ZiYEaJ6J7fvjVYeIUdFcX7P3ua7kSd8o+CObnlu8urEFvkGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtxeJfCIvMsnJ/sIF83lB1hSeIdJ0ftLnU+V/pykVIc=;
 b=yEOW8qd3ADYax1y6HKcx3vsnV8rsufMCH6BQE8AOYmc3GhGfWO3xmyTCNxobkokWCtMWsz8N2E4386UtVH9sLDJqhi4MnrMR3LBi8RRXwP18eVundtbUafKt3+1jcwuF3e80GGCNEQ5p+RXLQs3dJzQ7ET5jxL9Jbl9in2CgHfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5661.namprd17.prod.outlook.com (2603:10b6:510:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 16:01:57 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 16:01:56 +0000
Date:   Wed, 12 Oct 2022 12:01:54 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, linuxarm@huawei.com,
        ira.weiny@intel.com
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <Y0bk8g2zn2tpUS3a@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: MN2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:208:178::15) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e2edd4-8915-4104-b485-08daac6b1638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1gWqcfi5WZr7QmozkPEYoL43WfFMSaAoTThcG6vHL8iqKVdm46YMNYD+22Gma9LL3m9aifa4Meug4Jp+Kavo8ZR/t9EZzOnW/uNLRY04X+Klkgo4qH7ZEDMKuF3o6mOvfVXbGLt0mPwV3O2HwPtPY948CCvcgBFeSWO8YqFFWoLufADbrq0ZNcZhFk1KmVJW+U7cV8iQKu8GlFvERj9816i2m6jNHrr4PHeU8O1yiRhPh2lUylEKye+Za5WPMULw8M9s7ttUmenqrDTKhPV4pjmdGrIKGxolzhZBBUB2zuHvamjsnbLEcE6FSSvnI63vrg1weNIselVfB9OmyGa1syj5vxp2kGWHOl8U5lk4iGhDDpXzfLhGg6SCHgZSMjHbFNFC8uqpwTohR5jDHJHNePdoZ7JEuy/p20hdQ1H4o9RDq8OTpA+lsUSKR+T2raFPNayH81awF3JdGtlxp/Al2bfK6EGFitQow7zZXV5txT1egkbA7VrPnPEmJplMqRi9HK54SUgrvxJV+zqp6PZwVCXixB0uWIbQIlLqxVf5ui9nynAjhu6NDKB6FC+Pp+yVVql2/dWjtpPZAd4KZ8AQQOyOFHZ72Ic52cBU+iO+kXDPbE+efsvt+h4FBEORsWrUBEua/mAAGsV2SY/YwAoxbOG2OtCgZTEAU646tM81dIZrsaK5IoYtecSuFv7g8u6RkCzNioZyQM9FoZYaasB4iGLZRYf+y0QxzIPhoGXAtib7LgWH8Oh3wwIYsf6/me8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(366004)(346002)(396003)(136003)(451199015)(38350700002)(36756003)(6506007)(44832011)(2616005)(186003)(41300700001)(8936002)(5660300002)(86362001)(2906002)(26005)(38100700002)(6486002)(478600001)(6512007)(52116002)(66476007)(8676002)(4326008)(66946007)(6916009)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sT7/kxp7andWNNVCpLnxRtBf3hmSc+fZ6lvbaTrs02E7r+IdRGdeIeOYYNJW?=
 =?us-ascii?Q?n7SIrogXHs3r7I0MNbrlmBriUMI1XHv1mj5M/G1s5ed1IlAFC/DGwE6zKmXt?=
 =?us-ascii?Q?N2ZChOZJsExkJWUr535wL6Cnw4tBU/9h+0lE3CM+uETXekrFNSJzg4bsn1Eb?=
 =?us-ascii?Q?7BnOGAXidjKK3ctPuBDyWuM1URnwiyDEREWO+3Z7p8VwE8kJwOEko6btDs4e?=
 =?us-ascii?Q?9ArOnrapj6dauXBPpYrsJRV3crC0Da1xBdJtaUjzpPSUnYcDarraGKDcM1M5?=
 =?us-ascii?Q?d8QbFSRl/xwXIYNK87KagD+U1JelWheuf73JA/wfTowJubym6TRs5Am2gvLp?=
 =?us-ascii?Q?rIq/zoaB8iLHkb8ZVvERPXsSE2sia/m5tEV39z6poGsAQnhTA6zaYNnYxDFX?=
 =?us-ascii?Q?IcUugVTSWKMATGpgI/3t5STX02zeFqIfo/beYw8WhKxow6io7UNQv9SOTi6w?=
 =?us-ascii?Q?Zc7ly4G+0ka3NK8OYnEIuJwa6zcUyhsVzg/uBlAziL8+mv1oheqyNL/zFsCo?=
 =?us-ascii?Q?fLyAokAT/GxjuwxDehTM9E9Zfqxh1meuyEp9Q0mh046yY7815ExpvRE1ycox?=
 =?us-ascii?Q?VWpGQw0iUyjxuVaVkiYED9aS54OYSyB11acpW95YjvrN0Dk4Zz05/2ho3+Wx?=
 =?us-ascii?Q?2qTeLRQk04W0KcdR8UYJkBXVMt1+mdEGkWVZyYqS8Twxa81v6sHOCDlkTNjO?=
 =?us-ascii?Q?yl8xG6cXmwSqvF2BO1BYrWXtbZZkmlFg4EeofVMM/hxnMLP/HEMXzG7v4a+o?=
 =?us-ascii?Q?KhcuorNIGoifpr2eEwqidn9s7dDLpPrzWKtt+4CbvKowK/Ka4sSchyK+pLZR?=
 =?us-ascii?Q?pqoLqjEIxZKNOOZdbrDxnamiLZAzFA+a7LnIuFzQGyTy5xNNmK4Rqc2QXbR1?=
 =?us-ascii?Q?7DNdv9abGJV5rzNfof556eJ1Etvk2QxsYu8sY6OBrBQgVAa4tTHqEDs3LQU9?=
 =?us-ascii?Q?ocf4pEkTHzdGRTDrUS2dbvDmP9BS8TLA27PvVVRTZ4eM5J09tpIuXtHQRcav?=
 =?us-ascii?Q?+4JDy9hnG7ILmZ1kUCm778QsbnbVikQfgUnvPkVfCEcwRWujU9AkQkSSN2BX?=
 =?us-ascii?Q?IGthkejt+bK1fDHV+w22CUWM6OrllKzuqDjdf86f8NO5C1vVfykYXCvpqQkU?=
 =?us-ascii?Q?WG3aiX2ejvu9E+yCuYLUuLpTG7Ldl1EzqqkEgEtj6HhEj6K+qp0cVfmonnLg?=
 =?us-ascii?Q?SXDLAtH6abjdUDKAHTIlAvhzMmJkC98OFv9QUq+IlcGDqgNOPjwVwjQctWSv?=
 =?us-ascii?Q?8bug07kO3j/wpYPWcZrXq2xc8Ncl02UtFp8d0ZbjW0Es+5E5BrTDoe45x+Il?=
 =?us-ascii?Q?CKRYD4iaK3uFUjKuRgmD+Dkk8+SgTX4+zfPVmeaDpJ1GAh0VPVJ0gch8nYi8?=
 =?us-ascii?Q?Zii3Gl8Fyk6Z3u1xFZ/Ci8sZOTKyiRdsp1QlLTsxmZryzhbh5TcT92oIJ/jK?=
 =?us-ascii?Q?0nu/lf+molHi59BY9Cytpmw8c6YXU00HDRHZhICI9nQygpLvhlapUHjceMK+?=
 =?us-ascii?Q?i6nmwP4BKy8lHgBLynvJutkmWCij04iqcTtmkgn7vXFsVoja6/YgcqohFCud?=
 =?us-ascii?Q?P4IkeNSOGqAzyM2T5mH5TUrFxxpgZAj8dh+ysHo//b7gU1trXzTHdxifTGpA?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2edd4-8915-4104-b485-08daac6b1638
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 16:01:56.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsu3Crkc+31mBK0p0s1YFRy8S29MgcN2ZkCSq5qq4HwJ4OtjkINUtF6VgC37iVRFhsHGIzU0J99biYAVyUu+K6fRm+fC36zInVv0s0mn7eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5661
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This code contains heap corruption on free, and I think should be
refactored to pre-allocate all the entries we're interested in putting
into the table.  This would flatten the code and simplify the error
handling steps.

Also, should we consider making a union with all the possible entries to
make entry allocation easier?  It may eat a few extra bytes of memory,
but it would simplify the allocation/cleanup code here further.

Given that every allocation has to be checked, i'm also not convinced
the use of g_autofree is worth the potential footguns associated with
it.

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 568c9d62f5..3fa5d70662 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -12,9 +12,218 @@
> +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
> +                                void *priv)
> +{
(snip)
> +        /* For now, no memory side cache, plausiblish numbers */
> +        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> +        if (!dslbis_nonvolatile)
> +            return -ENOMEM;

this allocation creates a table of entries, which is later freed
incorrectly

> +
> +    *cdat_table = g_malloc0(len * sizeof(*cdat_table));

this allocation needs to be checked

> +    /* Header always at start of structure */
> +    if (dsmas_nonvolatile) {
> +        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
> +    }
> +    if (dslbis_nonvolatile) {
> +        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);        

using a local reference used to avoid a g_autofree footgun suggests
we should not use g_autofree here, and possibly reconsider the overall
strategy for allocation and cleanup

> +        int j;
> +
> +        for (j = 0; j < dslbis_nonvolatile_num; j++) {
> +            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
> +        }

this fills the CDAT table with sub-references to the table allocated
above, which leads to heap corruption with the current code, or
complicated cleanup if we decide to keep it

> +    
> +    return len;
> +}
> +
> +static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
> +{
> +    int i;
> +

And here we free every entry of the table, which can/will cause heap
corruption when the sub-table entries are freed

> +    for (i = 0; i < num; i++) {
> +        g_free(cdat_table[i]);
> +    }
> +    g_free(cdat_table);
> +}


