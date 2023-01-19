Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2EC00A5A
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 17:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjASRP6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASRP5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 12:15:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEA8C910
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 09:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C50QWXXdDqZf4V/2elmWb/D8qzGtJYhcr88G+pY9jdNEXD6K4jGk/yGn3dtuKoi1bUlaQa+OxFYf1vCTYDOX4PlTSWBRzq4o3Jze8evMEgIMKR7payaCdxZ/aFKuLzs0bq/bw1kt9xV3o88EA4d/Ocs83vT29k1r1HCrV2UtZEKpWK1+qq2Hg4DEJVE+CdHtC4V+Vq6nuGJbLZ81lK6JXegKEIfHM6/D6rBcmHt2/6md/rrx7Btm2kdyz/67IEdbhEf2P8Fmnt0x7TjmuM9NT6zJH/P4e4BZO0Vurxjf2Pe5okYhDGGe/knYURgVHmvU/mUcdZpFFc12z80BQ6/tUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TAZtZYQC2r7RLC7OZPxxPxT7UGIqWQGpZX0Rxxsu0E=;
 b=NhazAtSojx9WcAAPAQ6xNXloFPURbwJR6h1xNYOE07MXFARGynfyrti6fEY4+ingcj20gmMI1XrFKAN8tYFefDUO/xiHbVe4B5qMd+cmt19FotnWb8XAjXrDysBGwZwsbgfC9baog5vmt3eATmPRGzm4YmPkMWkwk6O5sgmlulJ/txP2LMLrNWCaTZ4gOsR13oQrGvf9JkB6yn/y5N/Q5XqGUtkPlJEJya0sGZkU9eitjTrT/y2sddB1qymSI28K1NCmPy+0A2X2jshS1h4+qWMZB5CFe7xPyY2gJmis60zdyCaTH8hOAeyuNHNPCyOYPK3XFevWoLwPLoJ7dDp5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TAZtZYQC2r7RLC7OZPxxPxT7UGIqWQGpZX0Rxxsu0E=;
 b=Wb0/TumvwBKlbA31OwgXTfS2q19MHxEFqTLkJmYAI2LJYvnY1ADzwrrM7h8dv0m2zU9gM0tIPgdkB5MakGcx1WQuAJXu+pAbdRVuC55oK9QpfroHwpP7gk3NfOdMb/cs7i1sP64FvZuKuphXcIXHRHUk79Q9+jUiR/Qo+cI8VCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3890.namprd17.prod.outlook.com (2603:10b6:a03:235::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 17:15:51 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 17:15:51 +0000
Date:   Thu, 19 Jan 2023 12:15:45 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        Ben Widawsky <bwidawsk@kernel.org>, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y8l6wYKstOB/iBzT@memverge.com>
References: <20221128150157.97724-4-gregory.price@memverge.com>
 <20221219124211.000032b7@Huawei.com>
 <Y6CNcuIzUVmKL0SM@memverge.com>
 <20221219172502.00001338@Huawei.com>
 <Y6CloIiuruB/h7qp@memverge.com>
 <20221220153453.00000436@Huawei.com>
 <Y6IMoxKZOc7eUPCg@memverge.com>
 <20230103155629.00007466@Huawei.com>
 <CAD3UvdQ7nZab7Y+tbc1Ox-zqzse4C16dwv6qtOAgfe4dA6_crQ@mail.gmail.com>
 <20230103181524.00003e14@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103181524.00003e14@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY5PR17MB3890:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f97610-dd2e-4cbc-0791-08dafa40d07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQNuck21yp5UlZyO22fVZtepbHA5BiPi64F/2sZitFk3B9IRHPQ2KQe85KjLzM9ijdirUUQ5zsFIYcJErB5cUgoDJoPKXxm3eGBai2uG1A8j3YRkOz5sSyk5QaMXF3E5SnLnFTkcgEmD8LMRx6JbdboCg6bRdlNoyrBU5aN0zhs54RpxhioIilBj2dpWqzaB9AvZrM6SdaB4IRy+9D4qPgVslatsYIt1IzSArU4P5F/hS5O9kCae3MeC+4i4QQ6/ebB56GSUOI0P/+jnR8F9JiSAFHbxun3KzkIXZHmu1/HPE1LJ43/e6BexmsfZ08a9G5dgnQnjk4PS7fGw+ydUSQOQvNyE73PPhq77d69ag9xfCilbq4dHHgpDmIzPFAslC+3cfehKzt3xlxQFP4lmSSljb5hXSY3d2JzwvrmG7KJIaXrY9er+5p1anTxBa8uXwsxOx5VFB9Btu/JzSBRRNuivpFxr/Gq4Ajkwqo0lShU2sO02B/ANRaUV9LvOIL+ngY0cbSwMfqsHWsGbB8Fpgnnpgk0hxqAbLGQTv2HFT75nC7cS8b2/2rgFQCyKnv9Ym3pBBOIisCfCEVm+m3yU4Hpv4jv8y3LAqW4+3bY1Fm74TTzeECRngLsDjn6oBypUkY9LTnCh75tz6AUbedlFo9uMmmm+tZTwfhynUJvPa7nvi1K1ASeAkrh/Ibc8o6h8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39830400003)(396003)(451199015)(6486002)(26005)(66556008)(478600001)(41300700001)(6512007)(186003)(86362001)(316002)(54906003)(2616005)(38100700002)(66946007)(66476007)(6506007)(36756003)(2906002)(5660300002)(6666004)(7416002)(44832011)(4326008)(4744005)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gM7rRZqp0ESSFxMqfxqWjBOb2Em98RlWl1RQW/SMR6nZrzipnCzsnh1uWr+j?=
 =?us-ascii?Q?jT05bvL6pDdpm3hjtoFwdxcOGN37x2PIBu3koMi3qs4o7ru94ITlMJQa6hWo?=
 =?us-ascii?Q?yhg4gXPKcTu7n4cmsrvtc6Uw6RFIPt1P2mI6xbQbqwgxyqrQHUuCmeUT/DbT?=
 =?us-ascii?Q?Su4TWgfjs5RozkLUdrOKcSbMA1kr0X4Q/6X506KXEe+WyrNNkmr6oytTXEy8?=
 =?us-ascii?Q?ZRgXAiVelif92xIjZn/s/p6v4c3A6NPowqJLLFX9yEMMDfp5WA7SL5xzNH2W?=
 =?us-ascii?Q?zIoj3ZpvFz4LTPAKzLG7Py68kNTExb8U27BJnrukqG8kdGFvyHYkqMoK/jCI?=
 =?us-ascii?Q?Gt1DbzfG38SMUEcRxSSQOaUcGgbBwAkHNdMtaIkfhgoQYe1XEYVobruzrCh1?=
 =?us-ascii?Q?YMbeGnnHmaHSbGmPcbt7Snra29GBnlQ4DM6RrvlTo3tUrFNnBICy3PKvmzVT?=
 =?us-ascii?Q?2njUrnscX/Dti+c5kFLUdecYuv6J2PgmgbKCgTL/yeRslWr5JxrBqxxqGVEz?=
 =?us-ascii?Q?MCSkG5DLUMuEHI4chdRMD15Z9sZ/As1CEDmqSJnQ5/2IXGKh+zF2fKIyYJu4?=
 =?us-ascii?Q?hk63kQbqa2Cr0answ97c/T6Csz6wmU528W7mfAOd97O+Cu6B1dEZ+eGmyImq?=
 =?us-ascii?Q?mpOn4pj4TUHXWM5DyJRodUtIQC5mdBQKecggtDk9CVcQrRAz71rHNAXBfoOy?=
 =?us-ascii?Q?6t2NFq+q7YnY1cATi5zOPBl7ZVp1KAF3rwcsTg7alGHaOE4qoEzseZLqDH2T?=
 =?us-ascii?Q?a+x/QTYFlXaT8frp0TvkqySMxDqmkdByVlB0aWcvNL+OjVDxcPfVkS1B72cC?=
 =?us-ascii?Q?9D/CFlTbTVEj/HYthpFw9oBLxsbOYoAvtn3gsXvEbe7/+E9T7GNvZiva9AN4?=
 =?us-ascii?Q?LSIWEw4mYtxSP4Snb1aJVStU9B27a0l9XIIZHFhPzFxAHKjJmcl22cAzneMy?=
 =?us-ascii?Q?rZ5hPRN6pQSCAjZlpFPV/oIXjAFPk4j6Ez3Z6Xhl5HBEUsWGGsk9GYv1jlZs?=
 =?us-ascii?Q?hApMKYnkpP/kK6vS8g74Ws8s1ArmeS2VnDX69ij2QFkd8wlh9lZXBRx9Irh8?=
 =?us-ascii?Q?w/YbwBT7PW0y6XodL/U3/e6jPDC90qIHJEPsc2Bw0Axhe5PkMDLYwAibQJcz?=
 =?us-ascii?Q?Xj9DeXaDhxumqeD0OOTOsXXg0ixtqzFpyoSNtiNNaCR8goLQUnxgEdYIgwrQ?=
 =?us-ascii?Q?MLG+v65Ztc2cmQwqHx9FokfnFOKw6/Fca7UIDLgHx/9HWzyu7qHXYIRL6N49?=
 =?us-ascii?Q?4a8KM7JmbckwOh+4v9yHCv2cV2A2rleMaufkZs6Gbxl7gIF63e+0M01NhGlI?=
 =?us-ascii?Q?tPIouhA8SnIDvrzhCjCLjmFuGosdcKtgSsg59lh8VJmtitUIMfnHO9yaQSEb?=
 =?us-ascii?Q?eja7LHC1iK9MRi7N74GDHgnj1GWfkOGbPE4MJ3DX8dLm0r4iMVTw37CMN8d/?=
 =?us-ascii?Q?TOg9AxsLBiXbHbASCFBG0ALUq8ssNALgMt7+xM89WL97q+F+Y96naFKMR7TL?=
 =?us-ascii?Q?08XJA36nZoczg1Uu6raLeujhP4aEXiTGGKwissAnAfLPeseDyrojDDO88sy4?=
 =?us-ascii?Q?ddDpbfraobCeAs4Bk1+tKaw5C+y//xlAeydb7LVB/zACd1btkP1pTWFotSEA?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f97610-dd2e-4cbc-0791-08dafa40d07b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 17:15:51.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULJ0i+Wd2DRY1Rg0AyoDWlKR+GGKdL13WqO8kCwQzv4EwC7+9mQuDkvu7qGpPZKjliavt1DhDwLgXaxHVaIiA+cMspeBgarksPD4KJabANw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3890
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Found a bug, not sure how we missed this, probably happed with rebasing
and some fixups. We're presently reporting the volatile region as
non-volatile, 1 line patch.

Jonathan do you want a separate patch shipped or would you rather just
apply a fixup to the commit in your current branch?

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 919cdf141e..1c5168e2e4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -187,7 +187,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     /* Now fill them in */
     if (volatile_mr) {
         rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           true, 0);
+                                           false, 0);
         if (rc < 0) {
             return rc;
         }
