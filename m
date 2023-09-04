Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19762CA0FFA
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjIEQYG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354715AbjIENrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 09:47:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD597191
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 06:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrjOWjzwSqeb7zWr3ij/XilynL9EUiK1X8YR6mCIbuHPiDOX/OsyUYjS14mYAJIMRuk2RB1+wLxNfvHWwb3o8ZzsdwP2SF8NSbh9RaqLxT4DVFc9sxk47GG4SE8yTcp2EQwVFLl5esTh1PqnjWbC741H0Rus2uh3Q5CmPBgqG7bR98Sy2uO3WLufavqgEQv/Re4qI57qravHAXHgND7D2ihh30VA4nhtV6UDcK6F5D6aok1O7YT0e+OLuK3XvXQTktMuNXAvLxZAOD48pY3HTri2tL73auNfuE05QtdN8upkoYqXAssqm4JNCECZVln1zMfAtyp9scIrQf8CRLXczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnBf8VxCXY/zJdCrlVcyIqFDywhXcnhupaHceYUhh2U=;
 b=nwmDZh0pqTEYhSAqjQm0Do2Cn/4VlUH1K7Mfj9p7RvwpeRnbsHfNXJP0GLl8MUEYyA+ITPHrozHhEYpZCP0+8voJ5IMiIz7fAHkbU3HFssAtvS6h1tdZ8F8rLfN3QdU9Ndm5C92xuwY6LnkgAhWqzOQuz2AMfbvwNj4FoIQWspPsO+2DhKWIBgMis4iYkW+qokOY8ypO8vVt5bnqIp6CmkkPldVfPWBsoto6utXuycY9cjyIhL/nkulwBPFcFFOkQtYP1ZeU1siOiYs52EcnzkXpBmE0txxHLkLz+Lsp60zXJ+gh90GS61rHT8rWGkteRghv+GzJntfBvom4ARUrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnBf8VxCXY/zJdCrlVcyIqFDywhXcnhupaHceYUhh2U=;
 b=lhnC6IFj7yppLeCa4IWeqYBzfbH+F6BK83kM+i1Z7txL+sgv5NGOUAQqJKctuCzlyrrsq28Xt05zXRPglKBIQBo+/yKYDP6m6P6zua1WAgwqj5NzKed0fA4QDQxawWqcyga76u0TGYHPrq1o2erZEZ0l16uYHO6dAhV0Dl9YUAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS7PR17MB6710.namprd17.prod.outlook.com (2603:10b6:8:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:47:40 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:47:39 +0000
Date:   Mon, 4 Sep 2023 07:24:51 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 0/5 v2] CXL: SK hynix Niagara MHSLD Device
Message-ID: <ZPW+gzIPjbOV87oS@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <6c7c4237-4052-cec7-d515-8ac6dc33ec1f@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c7c4237-4052-cec7-d515-8ac6dc33ec1f@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS7PR17MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: fd76a69b-1014-410f-39fd-08dbae16ab9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcudRC3wHChWKqPtZdaOtQVUZxWbM6kCSAnEOklapdmL0V+/5tcTxS7MTSHthkI5ZqsYKOdmI54glrO8qnYeP4JbHhyKJSetymMaR++8l/Vt+wMM/TXr3jo6i3sQEfj5QxvjauJmu/3WRRtmrL0uqu7pNh9oY1lCpfJy+nCl5Bema64/10oBGZ1ES74EVOK0sHVG5+s+nnutU9xP9n0iIXPyLmKEybN8JxJ962aajZIPmWUEBoH45FstLuASwKeKzMfIXp1LTy1IRg6KilYbxZ7zaXlYHat/DC3nxNZ2FwIDELmJyzfQ0GabTMEirsgb/eciAMqetgKy6Zbehw8kzFhBViXJJlsNb7zJfS3Dt7u3CQ9WkTQyjATvoZvZbubroRXQXdMdFyTpt7qA/Y3llJ3v/9fuds7shUY3h2bhSyHDWXc7jYy6hSZK1DSDuvz7R9kVJG2UPHspOAg2JqY5RNJ840iB7ITB02ioB0affLO98wysytgRkzXZQJtB1O/ark+QN8xTCpZVc8QTwbOy7C3Uxe2DA/EDPS1x9pdV7+/CHhx+r7n5IYJRYTtxWKO2AxdF+uCwXbagNKlK7ORJVd8qx8kIqR3xWi68N0XAhFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39830400003)(451199024)(186009)(1800799009)(8936002)(8676002)(5660300002)(6916009)(316002)(2906002)(36756003)(66476007)(4744005)(66556008)(66946007)(4326008)(44832011)(41300700001)(6506007)(6486002)(6512007)(53546011)(26005)(6666004)(478600001)(966005)(2616005)(83380400001)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Lhh8LL3ovFL5352rn/T611G93y8mPR/y6aqCHzkH6ZSBbkKbfIaGjSjurD?=
 =?iso-8859-1?Q?OCUUtGb5ydXpr9iL5uYLMy9EKWymJmBK42VFdU0XVLmWkVoeTr0gR9xn/5?=
 =?iso-8859-1?Q?uDu8keb87Y8PmHyJWO1IEqsxSdmFr1WmyG6seEJTLIts2tkVuVe54Zh/EO?=
 =?iso-8859-1?Q?djJ1tWTGEImqost/FkNC+sbhmj8xy//7gfWy4Dkhis0rhZCBgZfLEFuwEB?=
 =?iso-8859-1?Q?cZavdRtPJUURZ8rmDbw4jfLVeKPq/QX3oRZxETbGPUD/d3FEdQ7KAAfD38?=
 =?iso-8859-1?Q?8l00LqHEmpKWI+Le8UCa16gtu841G7g85jHEm9tJH9LGOP1l/W9vSqLCGz?=
 =?iso-8859-1?Q?SlDsE8tD51xjkTArkMo34FqOhR3LtsDnpxZxN2js294pHeYMqI/Hc5OQZE?=
 =?iso-8859-1?Q?pN8ACCzIG36pR8/vQIJCVtPG2ks5C2Ih56MnOhuBwyq47OwZsMG3Mg8AXX?=
 =?iso-8859-1?Q?hS6CUeDE609iY3EgaZNxbu602Xw1nEEzjwJUajyFSLsLpvkNzwIepm+R6A?=
 =?iso-8859-1?Q?bIjMfC5q7AIGLLJuwp5EGweuD8a3jlMvTC7JfxWo4xea9pnGAfuyKH2Wkm?=
 =?iso-8859-1?Q?NawpCbyaU144KMibUWwHOx3Ob5iYNWqHMixV93JIKqQGZqEvh62hoha2CG?=
 =?iso-8859-1?Q?qo7VAUdSh0SWoynj/+A09b++ZAXI+rwU1aRmXR+kB6uJFsFKUmtwiyeNj2?=
 =?iso-8859-1?Q?C3O04+yq2aiCJEsESWPIAOW/uuOS5K4ufyqRIqQINS6ccjO3y8VZ/42Xac?=
 =?iso-8859-1?Q?4I9G2EeCdJezZFm4JH4tyJRxD7DF1+rzH8r+chnW4ymJ6T4WlkhjWg3UTW?=
 =?iso-8859-1?Q?Mxe8Ts1nHCWAQwLGJgIcJUKDA2NakKJgIxsmccicAxqxUzATXTiLfj6Qu8?=
 =?iso-8859-1?Q?rrqHIC7FlRRomf8XNeu1rMqBFi1kMxDP0jQ01GX4Dwc44BOzOUGhz/zbN8?=
 =?iso-8859-1?Q?8kIKAo8HtpZHVwt0Au9ZPlweRDtun4OkwnSCWpitpoZgeb/gtwqZIpAZij?=
 =?iso-8859-1?Q?JUSAhir4ggC3s2TSL+shrp5eH6/PVDPSVK+Q6Wk5R1b5e44mZoouQlo2gg?=
 =?iso-8859-1?Q?Ve4eT35aByKAj7rN4aqKJizUGvt7QAhduMufu6yVrU4Y8qb0OKxy4rNAYD?=
 =?iso-8859-1?Q?DNnxhSp5R2QtiBvt2n8qepEFeuvwHIgNeMsihMEqNUtdmYAmOT/geKTyO4?=
 =?iso-8859-1?Q?/OP4Or/yPk5C1+I74SDy5Iv53hjAAaZen5GNdA/TBmmOHTPd080j4y7Y+b?=
 =?iso-8859-1?Q?je/QbJ0nX4PvJ11zP20UUS06rFdJtbuZsrLYR9wwQOxUmy5CewKDI5dtja?=
 =?iso-8859-1?Q?wZwq27wYHtewYzKgslHApT6hytg48aYz0alsljZgqqcNQJoi/KMSu+hI4X?=
 =?iso-8859-1?Q?hU6Hpy3YaKixlD8DuvHT9pNKbUdjGUbny+QNleDnxWpKnThHSkWTe8uG8Y?=
 =?iso-8859-1?Q?4yRpyIsO7muLkpALGcUkV9WA5zuoAHdfuVtJQSHnvaV7NuIOrycGY4wTkX?=
 =?iso-8859-1?Q?VOGHVxjNAjs5ux3yk3M+CYLB37pUoPIYdAIdWXATLZt9r76011H5VSCjmx?=
 =?iso-8859-1?Q?JS/9dvj1qHFH6lhODxY9MQA8Sr4xRHgxAOQKtrXZQJ56HdiHSCQwEAJ22c?=
 =?iso-8859-1?Q?+T8YIMsCGyYxJO73wFhYCxxXjx1onCatImcpFcfx/8i46FKHkitBfoNg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd76a69b-1014-410f-39fd-08dbae16ab9a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:47:39.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3AUNCIDqaw4PphYD+BmXOg2OoQiKo2JzvnT0mGECbRcWVv+88dOhBrRbsqPkYX2Tkz8fboEi0Oeq8QnOsK/25rxYu23Yf5dYpkQrMKSTaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR17MB6710
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 05, 2023 at 11:04:56AM +0200, Philippe Mathieu-Daudé wrote:
> On 1/9/23 03:29, Gregory Price wrote:
> > v2:
> > - 5 patch series, first 4 are pull-aheads that can be merged separately
> > 
> > This patch set includes an emulation of the SK hynix Niagara MHSLD
> > platform with custom CCI commands that allow for isolation of memory
> > blocks between attached hosts.
> > 
> 
> Being at commit 17780edd81 I can't apply this series:
> 
> Applying: cxl/mailbox: move mailbox effect definitions to a header
> error: patch failed: hw/cxl/cxl-mailbox-utils.c:12
> error: hw/cxl/cxl-mailbox-utils.c: patch does not apply
> Patch failed at 0001 cxl/mailbox: move mailbox effect definitions to a
> header
> 
> On what is it based?

This is based on jonathan's branch here:
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-08-30

I try to keep things on top of his working branch to avoid any rebasing
issues.  I should have included that with the cover letter, my bad.

~Gregory
