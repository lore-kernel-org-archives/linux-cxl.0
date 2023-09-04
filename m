Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78264CA0FF3
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbjIEQYD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354699AbjIENfo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 09:35:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93022191
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 06:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFQizA8xPXHg0hl9uHm0dqd3HC6DPbACzLsR9dqhMRX2KY2CCXIhXdedOfyKqpuNoXtkkOXFOTvAWwrnyOkZCnCqSkeWjCesIlJbH/0q2/hAWzB5yDHKHyWgE88LRMwfaUyoSAGLSmsP4cBVJRuGk0KuJS3qFoS7aoEARtyTz0Yl50Y6OyOmVmnlNarQiQAbBi0aJySSLZOyErZ/TMar8hqCrAGC6fnp7wEBLtmURfRWX9ZCKDXUxULIiorfTVpxDlo4nkNsrhAaxIVrk/at24h3pdfkUujghnr0QU653A+T0qAvWZQ9MUNIR2wogmSaH+4K8ik4RoYstgEAvLFkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNoHOmjkBt3/Wn8RBRc1kTIb4XKKn+p9w5ogiU3TXdI=;
 b=Ds8iZpwnZ2EoFcBj/FBIcI182J2K4N9Ixrqo9omJByl3J+4PbyaTXf/ZqyBr9nIWmoztKvO6aX4jRYtGaegjqGEcP5OPMI212MHx9qS2+nKwySbEZNwXu3SS8mZ9l8hdagPeOjlkjjnzh0IIbRLaLhHdjn5+6LoqC9uJxnV/Dn8qrky2XkR1zTxKygjoMUZFK7XAY87FLVVh7Oc5rKzCqa709uE4Yq+NQlAOZG2DACJiCmIjgMUyj8QXBhx38UVmXPKWp0r9GWIIA7Qc8K5DDPB/saJ6JT4bPWQrzi797EdKms9JBV1w6dF+eUlLNNrnW7QFTV1Ansa9bcMt7s62ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNoHOmjkBt3/Wn8RBRc1kTIb4XKKn+p9w5ogiU3TXdI=;
 b=ZXei3Oz5T0a8wCsPTlOlwAJ+LyFQzUBviNS3pJTXjGrB9PDsyKzZP5SZMPJHpPCEpUXHpEmS+fXrYI/JwrGD906EHJWIdLkhgP6l61vaRTQQGNSZDBZVDBH9ucjs/4yTRUM7dGHO3f6Q8VPNf5TejcRAoGrAUI95SY3jf7V4HSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN6PR17MB6970.namprd17.prod.outlook.com (2603:10b6:208:477::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:35:33 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:35:33 +0000
Date:   Mon, 4 Sep 2023 07:11:44 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 3/5] cxl/type3: Expose ct3 functions so that inheriters
 can call them
Message-ID: <ZPW7cIkWN70KooYo@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-4-gregory.price@memverge.com>
 <13f5859d-9da7-4862-ba1e-487e60098fe7@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13f5859d-9da7-4862-ba1e-487e60098fe7@linaro.org>
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN6PR17MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: ab09720b-e0c9-48eb-c2a9-08dbae14fae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RooWvYOR/+lBLKYewjzk/eGiSGpxTTdy+4Z6AksUyadQiAiIW2n0etrdUxvxzTqViVnUYYESByBC7Hd7WBWDgyJBELm8hqS7EHEnukc7lSFAc/ksXPOGsw9rY39LExv78nBEU/65UuthYWxeXdkrkk30c2Ml4Z5DDsORGDLihDMHaK4Spf+PMx+hzlTDVGM6Aobx+U9Ho6H/5ig32e+mQpkRaopacAR7lWgFr6R83Zkh6RLf6Equ0k9LjE3ancqzeg5bP+K9ud8JdulxG5pHQ54Xx4cCUVvC+aWXwvZcD+GIm+mJ1H+6YKRZUe8BvjTN2Dsg+aRdbDBZrtMVoqXDMmuLQnYCU08xvDhuhDiENnRTzylsyDRtJCj1w0QE9eRL9f4kT+frqa6fWqmznoAi3/0OUR+N+AQk8G9vOiBosdVMXYrhxPY0+YzlTmcH2AoUnEaDg3CCQ+SEdj2V8OcoWPaq5XSZR1yUwa9w31ROfOLzQNsRrScK2/ut1aVJKhNFmwQSAhU6uiHrypk1gDkCuep2x9JoZTlkGnhK0uA+Mtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(136003)(346002)(376002)(1800799009)(451199024)(186009)(53546011)(6486002)(6506007)(6512007)(86362001)(966005)(36756003)(41300700001)(5660300002)(44832011)(8676002)(8936002)(4326008)(316002)(4744005)(2906002)(66946007)(6916009)(66556008)(66476007)(6666004)(478600001)(38100700002)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oB7lxLedrBf0DrSJlRJS34MnBgD8oGuhtN+K+tPQkpnljwYEJZkAOjzOPQ?=
 =?iso-8859-1?Q?y2VWfsQev6F96j55FOfxPoXRPVVo4KgI5XuZUVQfyMwxaugy2Dqfgd7cZf?=
 =?iso-8859-1?Q?HQElsgXylqrtGaGVT00sXZC6gjR6y6pJfunJLsWKr9spMCp84mUeNGN52B?=
 =?iso-8859-1?Q?ecNWdK1IX/OjIVWm92U77WSHYTRj4YDPA8yvJ3Y5J+fVHqB2roWrCB8gNJ?=
 =?iso-8859-1?Q?Bm0/OcfnG9JbFGEy0lXlyx8UaKT7QPgyIQNwDXNluYQcbUhQJ42o4qUdCZ?=
 =?iso-8859-1?Q?bY/+ZfBbW4BoBb35TkhD9pDJavRyOeIflwzWFXBIkmX0fktjx8yy8jbVJJ?=
 =?iso-8859-1?Q?nOulYydXCcLuk2mxnCT53+9AQdSsJMj1nH7nP6rLMol/QtHzy6kn8zr3YB?=
 =?iso-8859-1?Q?LDCeWxhlF5vbe0/uqQQpo0qqHgNIQ4+5lbRGuJQqmoR3HkuUcYBuoU4jpn?=
 =?iso-8859-1?Q?qd12s8IXm4vL3LDHEpM/72l2tOGvyUIEE7VnOnERBCBqkkgcchHbQjPUlP?=
 =?iso-8859-1?Q?pq7nwqdzkp2BRIrmFnQRZqq03J6MiFEv6DnoiO06/8QC20MpzPm/SFX9Hf?=
 =?iso-8859-1?Q?lopfVHkkPEWnyvaVEwv7Nsc7+BdvqWKwuIMXQkB7v2Ssk5dBGpxW+jk1Ot?=
 =?iso-8859-1?Q?19Kcg2fJBxv9HbpEW+/QM/qT7xQ8eHBbqjpvKD+RZxP5RpyQtPnyVPMadw?=
 =?iso-8859-1?Q?xaqG0hax/nd3g9xQJrWxMNYauJ47wVdoGdA3PQH8nVrum5ZYVUPuQpR6nW?=
 =?iso-8859-1?Q?8SkDAAi7l7h71mM5Em6xsZLoTO9kIJllVOg7+tzHIujuZ/kDlQJu8O+s6m?=
 =?iso-8859-1?Q?veNRALzLSkgGTduy6Qiw9PSCqtXkmEPVDupYY72MqXnoKP1kv0qnZ/NQ6+?=
 =?iso-8859-1?Q?bU0mUQ2pPNiZtGIhaU9p6qVMwEkul4Xm8stS5tg3MsSCoZHde9rcF/Kebz?=
 =?iso-8859-1?Q?pMHymVqZrJnUmCuSM3a5LKRbv0ifUlaLPieRJjwln1MRzpNB2JynG8djdP?=
 =?iso-8859-1?Q?O9jtb3DL+KcpcEE31l88REgZJwXIf456CimKUmJRdIF9hAsgnQZzlU+tCQ?=
 =?iso-8859-1?Q?ZQta0QVDEhdjDf7QN5A5NraWJi3d3EkEVJWoAYje5KyywF3uqOo5kAll4B?=
 =?iso-8859-1?Q?Vfx+/i2Fw9+u1YbeY37YWDDh6KXp14T8sjtT99EdQFIW2gzw1XixFb7XOo?=
 =?iso-8859-1?Q?pMdbrBETsr7j8qlG1t4vp9pwnnKR4YU9/eKeshAqnC8vAQQVS0j9brMwMZ?=
 =?iso-8859-1?Q?iekxfn4modrd99UF0aV+dWdDJvEpgqFFo4lGa7y0Deqse8/NXPZLUVz80q?=
 =?iso-8859-1?Q?aEncC4ihep14TBQNTy9/RO9EKIBhimprtu3Mjqy7E4nF/jInRXtXL3FBBo?=
 =?iso-8859-1?Q?2myWTonzA9iC16iiC3pEcGhcnWiMLrfbv2xgdPQaD6sQKeKquwUwEhx9aM?=
 =?iso-8859-1?Q?Cecb2lGtuAqmCs4xZnRvy4VNblbXBet+fb7IyXhoaU7vteSjm+/R3Fd0wn?=
 =?iso-8859-1?Q?gsvDo4vL1PacJR2Uscea9FYIOhGXT0ZOy/hMBFlc9dFc85JPkATMOpCbh/?=
 =?iso-8859-1?Q?mdKOeqgYGuWRxHAos12I0HcN7V4/U/i2gYaQHLi8jV4Jf/kShD6ULzO4id?=
 =?iso-8859-1?Q?pyJfL9uTeV1rJu3Q/7+MAeyi1TrBElVEPhmQg7tXQY8HrOU0aCIw0mzQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab09720b-e0c9-48eb-c2a9-08dbae14fae8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:35:33.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRtIAeE26lsqK8k1yR/vhBmDXdmwQew0S2Iw++GIOmOE7PnbDMFwHpJ3OoO7ltmGKA1IU1Aq5N2ojstMhNIMuFh2wjyi45X2IB++IUUZUnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR17MB6970
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 05, 2023 at 10:59:15AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gregory,
> 
> On 1/9/23 03:29, Gregory Price wrote:
> > For devices built on top of ct3, we need the init, realize, and
> > exit functions exposed to correctly start up and tear down.
> 
> You shouldn't need this. Your device class can inherit from
> the CT3 base class by setting its .parent to TYPE_CXL_TYPE3:
> 

realized this after the fact when testing and patching, forgot to remove
it, good eye.  Still learning QEMU internals.

> 
> You can see some documentation about QOM here:
> https://qemu-project.gitlab.io/qemu/devel/qom.html
> But still you'll have to look at examples in the tree.
> 
> 

Thanks!
Gregory
