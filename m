Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A1C433C1
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Mar 2021 22:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E39B61985
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Mar 2021 22:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhC2Wo5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:44:57 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:7480
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhC2Wom (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Mar 2021 18:44:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctb02sxSvFNwIPZ5kSQjaL7/C6/FSO38C2crzfLVgFywOXuKxRF3TZHiu0LO5rITA7JrrsARNhr+EjyWqt6EJgnwU956mlitsQj/v+kfQzJze1fxtS2OEb+c5Rp92DFXgXxESf6Hwr2MHVTlDNsVSNzB75IUmY9aoiHq+9Np3hAe2jGNmfJ5Gsghix0tbPEGQ7sg8mgW0k07GdUH8RzIH+5Hh9hrmw3dybhwv8M2UW2JRj3KTC2/TdZlWAGAjI5w7NdjcGG9KPT/zHio2UnW6bKccV5bOqOd6cHKKeh0Yy9IyYEH+5o2h0x1mZsExKoMr0pVIU2NjxbcGMOc64H20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7S0WmBCSt2JBZNPsTBYrx9TBqeAt08OspjoD5aDAGc=;
 b=JvCsPYsjWt+PU0nIMZK6RqXyDKKSKjG25YC09XrSv7DYiDb1jawPQVJByOlLPx0ByMr0+VeRusk2COfK37OLo1YTseQgVuDb6jGEl1CiazwS/kGR6VgJ7TEfGajlEC7p6B8lLb/aymxpHIB2xVzwNWX2J5vR2MaNtD4p/PzqlrcH2Ds83Nnf413jYhEcdIWRuBSMcOY9MIh/53smzUOJYNGpwVvm7NytKrgXsohH8bgEN0Eae1zXOwY5GuruTYfiUKAwLP3QXLt+topvmLw+TwEq81aKPGVwKnqqAxA3Ejkl7e47QORfGzxSBNM9Xk7uY+sKTIksF5T9Yb+iq0YAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7S0WmBCSt2JBZNPsTBYrx9TBqeAt08OspjoD5aDAGc=;
 b=DW3Qyt2A1OxeypsGr8HxZ7uBN4Wc5Js6HMD98/C5+/4vmdWnCe9OBNjqSwtoff6ERUMVtmyyQGsyfsAA6OG6c3P7CCgIyVPSqFFi2IosOdcVvFvldO9TaqnaoQtqN03wpKCV3dPsu/N/t9QwwNV9IWc4ac/hGyNXHPFgACSYzxV/Yw/qQNgTPnctIq4ueZK9j2WoGlC4Udgeu/pl7kId1kJB1Cr2oLJeLHnpWP2yiAQPK4Kc4hIFnklDc2YgUzEJpgmUdYT/TZiIBJtXntTyfH+JWaiGMKGyoQeyg4+5hp7x1N0E3mwhKs6SGKy9vPfzNfU83nlh8A7AUSLHpP1qZQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Mon, 29 Mar
 2021 22:44:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 22:44:41 +0000
Date:   Mon, 29 Mar 2021 19:44:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/mem: Fix cdev_device_add() error handling
Message-ID: <20210329224439.GI2356281@nvidia.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210325171126.GD2356281@nvidia.com>
 <CAPcyv4hMHAK4=eGuvP5Bg_2YfQCLt5cd5ku0tUUNY3VCxkKmaQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMHAK4=eGuvP5Bg_2YfQCLt5cd5ku0tUUNY3VCxkKmaQ@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:610:5a::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:610:5a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 22:44:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lR0ch-005fed-Gm; Mon, 29 Mar 2021 19:44:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 426acf13-1031-4d68-4368-08d8f3043d61
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35944BB37841E878480D5764C27E9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58O/i/aOxbQKxzAnj+hU6MyJ87OjSPbvdcN/Cfxd/GOMitYW8PhP8jvJALG2e/pfRwtS4lsPqSGFqRErYRU3T5Hj4L9MVxVkhEvT6xV62Louzgjc1aoLT7EfLK1GpLRF2YEiPMZnsGsCPz0DRnW76v/WzYlK3vVZvc2lduncPQhZTAXWmkr9aakSQWjf30mz2oenwQ5DCMYyvMQ/H4g374fa/HI0S4xj9Of32lNIUmfIWfejO49EMAILwVAXqG1fMlsWuybVf1D/iBB6Up0oTyR++COU205vkzhWLpL6znoTcTkHcWTKfhtntz0+ZdakCsqpS2BJNjfrX5F/sx3n1oYUxIqbDtmAsTuY4eLtvNnWLE/5hRuEgvQFFXPVO3xgdxPNBNpnZ8X4iVWIu3+Q1XVqNpE8p8Vw034HLeTUYEXjVx7oDUKw+2Bd7GVvPzmxHmhSMV2F31Jq3QIwLBj4ow2T5tdQ4zB9eAyCw0U30DB89MNJA/QTDQbeETwvvKPLxcsNcwkQyPOQ9gF6WMosbUEYhoHCg64JLlenSzFv6aMArBLVrnSFdIqqrDpsKE+mwqF1VJ9OVTwPLmA9359h5RW9etDiHoAr132JtOYX9ISyAV50xoD9IXu/TlwK/TVTYrjEGz3OjdZ/w5YEld20NBSOxc7SNsUfJAfhrA1QAfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(66946007)(66556008)(1076003)(426003)(186003)(26005)(66476007)(316002)(6916009)(2616005)(8936002)(54906003)(8676002)(33656002)(9746002)(9786002)(86362001)(83380400001)(2906002)(4326008)(38100700001)(478600001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9cW4a27o2ZOdXZKTGHxXMJqhQNQgYd7jN2OTr1fKoPTiolyTy0/T6OLoMgoW?=
 =?us-ascii?Q?oF4HbY2rbad5/0gOjCAmkLNHFqbNkOxFBlYr6g7hnYlI3dF6Ioc0A7YfCHGV?=
 =?us-ascii?Q?8Bft1ZdyFD7gDUrDhsNCr6bGbrPDEp+d/qusgsFL8r670N3nkMcTdkiyKzic?=
 =?us-ascii?Q?sFYnBmh1uljpluzOlimCupMQtgpfu/g1eEx3/epiIwNz8sUfAFqxWT8bErYg?=
 =?us-ascii?Q?B02u8UFh3NSlcXkW0KLGdDru+Cf7SIdIw8QQDHgQ7H6TgQuyQEWUisfC946R?=
 =?us-ascii?Q?kDLrjNDxaOQpccK+5XMuJj0VNDKm8mXaemGX9TFKkChVjhDXa8XDAG2wdyUg?=
 =?us-ascii?Q?/YvG0Gp/bnYiAL3sBp5K5bi5GMRWabt3hB6zinyY7V2TY+4kqr42GSzc9iMj?=
 =?us-ascii?Q?BRkYtdfuigOXyx8jAwMjNXlFQjg/tAgLBz+x+jBlu5qaroTxuU+u6Ek2R2U6?=
 =?us-ascii?Q?ybvliXG77VWEyEEOppC5GzUmkQiFHTBfartbjvesK8+tecjRC/8IB1v2CQ0u?=
 =?us-ascii?Q?i+QbMbBRLPVHNQ+jea1brS9P+x77YYQplA1ihXFkmyvKpjRsZ/YLPfkrlu1u?=
 =?us-ascii?Q?rMREX1l6wZQTLyi8eIDcLTpYiZbNmtwsYWNcl6WuOZPqZxvGzuzTugNFH4Tp?=
 =?us-ascii?Q?powXqZHrt0jL+IS+jIvM9XC/DRao7t1n2gLho9mug/ZVvS2304JhAJOoIOyk?=
 =?us-ascii?Q?T8uphMqql5kj78C112gs7WcntrjLhGTcSa08MsVZ0fll2OzEvAR6ygi+MzcQ?=
 =?us-ascii?Q?vvyke8PwEnaFnV4+GFifwQca2I0wl6YBblxEFtUPDeowcedzorH/m6kMurOF?=
 =?us-ascii?Q?TmOwtYagSgY0x8dT+Dw5QbQFjkmLI6s7J8P9155WQZuBUffvir8tLKW33+SX?=
 =?us-ascii?Q?Mcf1Q80Qs9R/ATeCiIlnvSjIC439CQdVy+8Cmwh0Mg9Zmq/+gUDLgeZ/2X76?=
 =?us-ascii?Q?W4UmD5Ti1M3e/rRDbOCgKanexgqrJqfIcHoJtzJjA5Nf/ZUxTnU9EtYN95Qv?=
 =?us-ascii?Q?439teP2BecUm34KOUmqdapAvfiYqQmUZtHKZXumJ9CloUxKW8S1x2Tu5tlRt?=
 =?us-ascii?Q?4F+nckxeVZ1/64j+VFmKo3uNijNXjCMNg5TFjvDBYZjnqrAy4Eext/mc0nUX?=
 =?us-ascii?Q?wuJUNBgQv2n+lL3uaTaLhsotiSBbfIgdj4p4ZSWTdt41s86rGBfFlKHMY98f?=
 =?us-ascii?Q?uyORCMomxwR/Gbm9klBf1qwSXOaF34y9n91ksttZUtALQG/H5D7lMIY/pk/s?=
 =?us-ascii?Q?8VSZpvJ6XhYQSG6DSUIcVsNDHKk2wtMMXHE8R0Wn0tmXbzqdpe3hocTiBXTH?=
 =?us-ascii?Q?0sa93EsgP5E8nhJJyeEV1MJc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426acf13-1031-4d68-4368-08d8f3043d61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 22:44:41.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGEHTzLM9ECUzlabjzWbXurxldnR8OG77svrECH5nr7mkgteXfJKgc35/LiBvZPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Mar 29, 2021 at 02:03:37PM -0700, Dan Williams wrote:

> Ugh, exactly why I was motivated to attempt to preclude this with new
> core infrastructure that attempted to fix this centrally [1]. Remove
> the  possibility of "others" getting this wrong. However after my
> initial idea bounced off Greg then I ended up shipping this bug in the
> local rewrite. I think the debugfs api gets this right in terms of
> centralizing the reference count management, and I want to see
> something similar for common driver ioctl patterns.

There is a lot of variety here, I'm not sure how much valuable common
code there will be that could be lifted into the core.. srcu,
refcount, rwsem, percpu_ref, etc are all common implementations with
various properties.

The easist implementation is to just block driver destruction with a
refcount & completion pattern

The hardest is to allow the underlying HW driver to be removed from
the fops while the file remains open.

Usually whatever scheme is used has to flow into some in-kernel API as
well, so isolating it in cdev may no be entirely helpful.

The easisted helper API would be to add an 'unregistration lock' to
the struct device that blocks unregistration. A refcount & completion
for instance. I've seen that open coded enough times.

Jason
