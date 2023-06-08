Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC90C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjFHSKi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFHSKh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 14:10:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF1194
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 11:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmbG2UEql+gCF58mOJ8SS+B4Qr011tkJJvhDRxXwPIvOR30j79WauMlK5chAiHBYPimstGmFbisNSxZiQF6XkI5VCSPfjCSW5ux9ZfoOXYjEh89LhGbJofVRoFbd0AzwEdLAEts5QiRqGD8rZ+IlS1uaecCO689xReqXMvlUUxMwdtLjt6jW4viwE+4gfqk7Ng8Fv9ogUxj6jFTkbXh8ZbYpSSIH3YJ8gkGyHzp1kR3Z59PD9yBnearCCcny9HPIAgQnMYT/H0DJuAA1eYdyvKX6DlsgKeHZq2w7VwaQculz3Nuj4T+VNPT0hBCbxK/0XvcjGo5waUxANKzuQdoA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHMSw/jr9b39nHptmAwUX4guO68jnnNCcK1LcX7VFo0=;
 b=OId1yOU8VYUnKEtpIQm2DvAMurV1ES+0lYDvYYMPJbfOD6ljjQZ9SQQVtwJfSFCbLCpEzVGENBQHDfgeVQggevoFu8MRdPZ6X96lASgDjCB8LZpyE+R6SYI+n5Otb4ye7oGcpXoQ4dbPVQA002bbCU3pFS8bv8FulqyA1bD1wUJvt0cVabb9gWMgtbDOHtZKinP7P5+hF5y2AlzkjrhipYa1RzM6w+EJpBgULu+84eDdH7Etz28z8S1TWU8Xa+X2Ymd9PV9KH8RcDWVvqCshmYW2xzOS50tVIVmZAtZYowecb9oSqlylywuD30rjVLKonV07ZwpC5q2YPS3k0OfgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHMSw/jr9b39nHptmAwUX4guO68jnnNCcK1LcX7VFo0=;
 b=id9LvR0Bi9KlgCkPsGZrajSH2EDzQjjVYgRTovnPOqsKs98UC0hGoNI/+ten6ImRyfV6q50+shz7cL3tw83w3jK8ckrWr+RPc+Xw4ovNXrFilMDulCRYFKnq3DcPVeYFvr0Ix7Il3AsBUn8Q4H8Nk1anV4mdt1mMwAZxj12BY3vSgK4y9igWE9Ht1oxEswjk2ILXshUMrfxPKrt5Rbrk+Ttx8q22i1VEEDD0miysiArZiz6GfLX2AK9FAL4Oy4BRTD9/wi6KL6ltWs/kcDNXd0mikr6P5bX82enCES/PApfUjDfaUvE2G0vPb9VqPEgOymp5rM3DJIiJKeB7X8j1tg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SI2PR06MB5290.apcprd06.prod.outlook.com (2603:1096:4:1e6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 18:10:30 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 18:10:29 +0000
Date:   Thu, 8 Jun 2023 11:10:16 -0700
From:   "nifan@outlook.com" <nifan@outlook.com>
To:     Ira Weiny <ira.weiny@intel.com>, sheshas@marvell.com
Cc:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <SG2PR06MB3397ED98E693C77C97345792B250A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <6481f70fca5c2_c82be29440@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6481f70fca5c2_c82be29440@iweiny-mobl.notmuch>
X-TMN:  [MFhblnyWeXvtqiRMGNDzoSpSt9Dw65qMRgVWrFtb0co=]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZIIZiLKJ9Cdp0eAy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SI2PR06MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d4c245-1b45-446e-6769-08db684ba44b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/4WKWoVCgNIt3N036b+jm98pcqUa6DTNpNtm87kV1Euvnr5bdUWkaTwoamOBL0jpNzLNmzOBATj53gG09JMiVnTLGqyXxq/Z85iS56bmLyNuZKuKrv98ucbiQ84VaYm11odxRS5aexED1t2DQH7jskDCS7199Z8yzxx1u43PT9NuTfZLB7iBV/C3FaH0TfHeweEe8mOE9s2RxypZlPYm8FyZ9zETeVcGo0OZhXTQ9+Qg+coLTSUHNDd4Vul+qbPEujRW5fEnAVaLXCvPrBx19Qg4nFxM0RLQpWNT/Xh+DuCDJWRdrihM/Fo4kk/zfgGMi+JE4JY14SNy5RYU/b9FvAXjGVjc52ZsuFebBooPgWaXU7N/Yil35x8H4ZQ38UWdutF6DRIE3WhP+HVCs9xVxbhUMFLqo2pBIzMskiodgMtSt1B3pvAaR6TyKD7agt8jQRbyzpD7V0eYpiMLghsQdfG5N4S+u7kUCUIngvbxcPTSEgCw9pvwQAcw9Tdjhv9pqLDJuzZ/S+/6m9n1MO+rVNdCC84vGm2/PbRlOrJ1JWQsxfU2t/T19kgKQyxdb6w2wpkeNyMzwrl4Rev/XKfrQrDhNU2JwF26bo4iih2TG8iZwB4y8CltoUt/XHDfFui50WNn7H9rph7HyADPe98Dg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNRbUg0K1VNM1htYVNRaUxiTjhydXM5VHBnR2VnKy9BazNvT3JyTkI4TFQw?=
 =?utf-8?B?a2dCbmg2Y09UcENkZmFEd05sYk5maU1BcEhKbk1BbnhsZVdIL3JoRGZyRDhM?=
 =?utf-8?B?RnkyOTJuVksyOWZ4eXZRUHdweDlKN2NvRlhsL2xYaktsWk5rZjRlL2txTzhv?=
 =?utf-8?B?MTYxcVRjOTZOOXJ3azJKREVxQlVJd2tsVWtaY0h0WGZwTHZ4eGJHYVJWdmNC?=
 =?utf-8?B?UUJxMm5qWWNPVUdlZnhTVDd5OVg1MDBlbVRrajVFZkp4QXlDS0pIOFdKSXJ3?=
 =?utf-8?B?by95NFh2YjdDZlg5VEtvd2pCalJla0dqYlRrTkZORWVzVVVnbWtwaGFnOXRY?=
 =?utf-8?B?RDYvWXRtRUk5QU1OSWgvRGl6VlBCZWVYeWpmeXIyYjZTQjJJSFRaRERiaWdK?=
 =?utf-8?B?czBldk1YQ3hTeXBjc3B5QmN0NUlvRU9LSjdDL2l0YU5wRXVoTWJSS0VCRGg2?=
 =?utf-8?B?V0VXODJGOUFzZmt4MGlTZ2N1cm1QWjFNcmJnLzRCbllpR0F0MEZubUI1U0o3?=
 =?utf-8?B?K3FRcDZ1R3g3bDJSeUFWbjFQVHFTeld6UWtVQnZTdEUxM3psU29oVitCNWli?=
 =?utf-8?B?RldzMHBQbjJ5c2JBdUdtcWViWmxjSnNIRkFycUw4TTZBMWV1NVNqTThnWG01?=
 =?utf-8?B?WjJXWU50OTlLSTJvRnY1TWhnbUEyYURmVzZuNEtqMDd6ckpLQ1NxUDdRcVhZ?=
 =?utf-8?B?L0tDWExIajVnWHFOSTkwRmx0UFBPZnUyaHh4OXBOSmRpelNrYnJodjd3WEpH?=
 =?utf-8?B?aHBoeUtEdGx5WHdkQ3hlcGtOeFU5bmM2ekg0RnBlaGNsZnZkMnhKRGY4eXVq?=
 =?utf-8?B?SlhKelhCUW01SEtiUG43VG0xeVdCbTVRdFFBZzhFdnE1Q09kMXJZbHZOZENX?=
 =?utf-8?B?a0tQb3ZYTElDcHFlYkFuVEZscWtCT01scVlmTkxuRTduVGtKMkZXY25IR0h5?=
 =?utf-8?B?NUtOaWRKRzlYbHRZek1kdnc3NC9oMDdmc2NWQXR5TDBRN09YUVFoVFhUY1gw?=
 =?utf-8?B?RUJ2MFlNaW8zUVBod0ZGU2lwTUx3bDJkYTA4QzJUaHVUODRSeVJiMmpvN1ZK?=
 =?utf-8?B?K1MzdTJRdk5ZWmNmRnphZ3dPZlA4UjdWODY0blJKdG5udTNpQjJrT2RHemVN?=
 =?utf-8?B?ZjAxeFNyL0RlN3c0UnBEYkpPRDByM0RWNHhFVUtNMXByK2lWRHRSUTRrdGI5?=
 =?utf-8?B?c1FCOXVaREFrMjhJbTNETW00STQvQndLdjRWYkk5Y3UydlovOEdXQ0w2QlpJ?=
 =?utf-8?B?UGtJQU5WeElYK3NCWURXd1h5Y1V5Ym4xb2ZNeUJyRGhNZUVod3JRT2V4Yjhu?=
 =?utf-8?B?NnFKaUYrZmdKTEFUL2xMVjhPdTZMdDFEV2hpZDU2RHNncmkxWmhhMDQ3YTQ0?=
 =?utf-8?B?SGdxQlBlUFlGQW01dktMaDUxbmtqbVBCN1QwYVJOaVl6Mi9YVXV1d1p5SnI0?=
 =?utf-8?B?QjRTVHNrWmxEbzVLb3oxMWZzUitUQytjdktvbDdBL3VOSGtTWnpLQU44UEIv?=
 =?utf-8?B?N0U2eUJFcDFMOUp0RVlESzVEZm43eXFkbmR6amZrUGdLQXNlUlBWR2pVTStp?=
 =?utf-8?B?bzdxMUU5aUllN296RzdPWDdCQzRZZTVpck5mY0pqdkFsSzJnK0dVUFJWaU1t?=
 =?utf-8?Q?DmQS+YxO6IfeeJZJ2V1Ou8DDFzz8c4rBhSnQOYQY852Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d4c245-1b45-446e-6769-08db684ba44b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 18:10:29.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5290
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 06/08/2023 08:43, Ira Weiny wrote:
> Shesha Bhushan Sreenivasamurthy wrote:
> > Hi Fan,
> >    I am implementing DCD FMAPI commands and planning to start pushing changes to the below branch. That requires the contributions you have made. Can your changes be pushed to the below branch ?
> > 
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25
> 
> This is the branch I'm trying to use as well.
> 
> Thanks,
> Ira

Hi Ira & Shesha,
FYI. I reabased my patch series on top of the above branch and created a new
branch here:

https://github.com/moking/qemu-dcd-preview-latest/tree/dcd-preview

It passes the same tests as shown here:
https://lore.kernel.org/linux-cxl/6481f70fca5c2_c82be29440@iweiny-mobl.notmuch/T/#m76f6e85ce3d7292b1982960eb22086ee03922166

-- 
Fan Ni <nifan@outlook.com>
