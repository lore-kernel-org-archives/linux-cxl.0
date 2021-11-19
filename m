Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621ABC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Nov 2021 02:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4355561211
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Nov 2021 02:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhKSCc4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:32:56 -0500
Received: from mail-mw2nam08on2112.outbound.protection.outlook.com ([40.107.101.112]:52065
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231736AbhKSCc4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Nov 2021 21:32:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSdv3gRpHC1U6AWdHTXYq2JdTzjBJE5BqumQKaXN7tlth2vRHCJOPx22pSt27rBjncyEpRlH4/ThAKKjv21gzQxkWhq3WlisN4l9jv0svP8nf24uUgQK5GHiLMCaueLhon7mZzeiK+YpyOG1zEuD71ugNCuzDHmuLVoAKdY9RW2AzLzSrBWIVEzeqCvTuobjI7Fz7axy7EO7AupGUkdqdL6f3xJqcctJZ7G1uEZoE1hBchQvDcA8w0XJdhnIm66jNQPdPCly0LFgIgYsjUhIm1hZ6X4QuFW5DbKcziOw/73lBXGj/7Zt+BEIi5iJLsC0f2apVHjNWyfgir57gQwnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVIFbcERLbJ8kGTYsKXbJ8R0lzNPV1qONHnqq8+c2Ho=;
 b=DfGFggZzAtoWZ3CeUilXixd6Xj0MWdlv/ZcBrpBZGmVpTfUTY/AJhdVT09pcqx7ozzWodpMUG4a89n9snx+IAqyubrHr5N0dXzXiP0vx5eOlxamJaa4PbfsTP3+/PLmbln+13b1T8Y/lOoTxyG7WliVmnwSZITbaR1+EN+2jnOk17pbhUPrULXbp1EnVGc+dTNZgQcG5xK2AOksYwQ3vovMm4uj7BfsIGkjqd1X69jpMZHq45NZtJyoBFJZQ1eoRf6w2pzBVoS5VZBQOJh06AbLDRxLjPySXFmZFMVrSfL6KEqeSEAZ+zY/atibg/wjkklizf/J6WI01260nw9qYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by BYAPR12MB3510.namprd12.prod.outlook.com (2603:10b6:a03:13a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 02:29:51 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::fdcf:4e98:b845:f650]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::fdcf:4e98:b845:f650%6]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 02:29:51 +0000
From:   Shreyas Shah <shreyas.shah@elastics.cloud>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Saransh Gupta1 <saransh@ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: Follow-up on the CXL discussion at OFTC
Thread-Topic: Follow-up on the CXL discussion at OFTC
Thread-Index: AQHX2+CvgZdbGOWQAkmzzqDeTIciUKwJ3UEAgAAI7MCAADEjAIAACybA
Date:   Fri, 19 Nov 2021 02:29:51 +0000
Message-ID: <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
 <20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119014822.j247ayrsdve4yxyu@intel.com>
In-Reply-To: <20211119014822.j247ayrsdve4yxyu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adf511a-ea75-4bd1-4fc6-08d9ab04772e
x-ms-traffictypediagnostic: BYAPR12MB3510:
x-microsoft-antispam-prvs: <BYAPR12MB3510B609A91FB0FA86B7E94EE89C9@BYAPR12MB3510.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxnLUFzwE/zucLEn+9/PceTpENb9wqnYbSZmL3QdibYwB822XxIqccmYqrPTDvm2rakCvJqh7oAx4lb6Qb800cXLUUD74L4z85FqmV6O09iEsTwcvEqQGXQeJkH7xJJeeUEhgsKoABuEWitW0+7yYrfk8eOSbSYw7MCvUndf9pQAffa2zkT14coXci9TCv5g2iz6VYrlT20dHJ9ooKUJi2YB9shDh9nTAO35QT9xExDDTWjtK2YlOJjzhQ99+9rthlAH2kUMoW1QRkQQloUFpedMubXIciiy6T0JjlpVPvIl0TFrXYhu8F9AdbrrH3uYTfvN/k9Y9Ut8Mf2zS/RUA/FmXeE6mnE8uGgsVWDVLLdBdVb9sEGNZ8hZbklEp1YZ5/SsRpsrglUCf2fk9ip9eN9UEoHX9Dw1mfOhKegZMgX01ENbiotphG6Of9p17UukSdj9dkgTX/A5vEGzlHLHqytUpJV/m2VH9uj8ovAd8/GzmK/6ko8mEKXoLjoLpdsZYEHezphxdVOsYQBUiEvo9SizL1TLwcEjVKruPYEjU0hsKpkjDdI0d0K9xmXBNz6VPVk4wFKopdLOoBil5P7iWa2yXKzmt7wDafQ/uimOYqXivq4VwY2XDGsdYhpwxu6TyrMLc0D3ujBIOyEeWkB1qy92bdkI3wvDFNE+e+M9CX+6w77jW5YxPAMeW/+XDCkaSdJc18Qz41VsXIne+2U1AN5cUZd/k0VZt7M7TYXAQs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39830400003)(136003)(366004)(86362001)(9686003)(122000001)(54906003)(66946007)(6506007)(33656002)(66446008)(508600001)(55016002)(38070700005)(186003)(8676002)(71200400001)(6916009)(53546011)(4326008)(5660300002)(316002)(66476007)(64756008)(26005)(66556008)(4744005)(76116006)(38100700002)(83380400001)(8936002)(44832011)(52536014)(7696005)(2906002)(71440200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PANbT3fk0eQgFIk9iPX+fITyXrsjMAuMfe9PE4BP++GLWsBL7u0+rqVa7QYu?=
 =?us-ascii?Q?L/Y3A48yMQJYUxTRqJZIXeefKjyk14H61SGnz6WxcnaqJK3s3JIsQZbxDhZe?=
 =?us-ascii?Q?/CI1yqFa0IhNtOGKJqRgx/kFH7kQaT0ctK7u8mBbQHPJ2lRJJ0h6j8wwXDPa?=
 =?us-ascii?Q?JoOyZ0iIxJh0Pbt814zYZYPASoDQXbPoLShmKJTQPBdef0uETdvymjK6ctvi?=
 =?us-ascii?Q?6GEO/lvjgWzcFll0jgVvkU8e2VQO/iO1aH1f/yY7h+2TdjFywVf8tJRKRTqL?=
 =?us-ascii?Q?Tidc5GPGgJ5TEGUdnZfiYqqJJWIY8P3WWbbFeWi/6JZCT57BTODouY6n/M67?=
 =?us-ascii?Q?6XhLyfiOkLwPD9sq5FuGrG/9lmnV8wQ+FaTuTcilkb9LOiaON7MFwZGs3uYq?=
 =?us-ascii?Q?YHljWzWFsI4zmc2eaLXdSTuMrmx9ddvYQ44DZSjMZsQ4opgrxGxqQDJf2sil?=
 =?us-ascii?Q?HrMDCn+nD5l7TzWyY1eCVJ7a6trrY1qwBgDbdXFIJ3lssV31ifuYe/WV/U/l?=
 =?us-ascii?Q?tzYSUaPW0h0jdoIh6XEqToRaTzHJTX6McooHsINNpLqNBZv9TkIjZly907qZ?=
 =?us-ascii?Q?UTj3yiDv8ohcvqdl/tRpT4ILNM9Mk6Wf1L1pCt5B+B1QBSMPMhyeHE73456R?=
 =?us-ascii?Q?q8CvHM/AHE9I9ZC0QgxgNLo0kLi3Qrt0ZvUAElkk258T4TUh92ho/bxWa8W7?=
 =?us-ascii?Q?MemhJ8Nc3zPkoR1COQQidvEUvda5a+IPZYrroOJR4g2jGbm+jHlpQy5+VEiG?=
 =?us-ascii?Q?sH1hR1u0wa/J7kOkJyIdYEjsSAEnvhhNOU93m+Q2CtMc3E54FJtY2r+H7TX0?=
 =?us-ascii?Q?KrsGDiyEAGg2IEoVgi08GhfOakJ7CPD9p2l9lz11lnSnlB+Z+Qw7JTS9Fay3?=
 =?us-ascii?Q?nxc8oRUx8J2VgDmhJjBQQmR6GZpyKZq25Cnj1THnsILKKbkwJLR2cr7S3BDP?=
 =?us-ascii?Q?ScNd4GC4HuL1e3yj0Rs65fc4RPSe80MfqrA/w+YinVWO+dSa7tPD39snRqX2?=
 =?us-ascii?Q?jT6+PT0nbi9mJNECkvXe4Av9m3e0SaVPkk9dJ2gH8Oz97OWVc7jh1nvoUphl?=
 =?us-ascii?Q?T0gpt24rN4/njUV9uatugYv6N29cHvBC7HCzwV7tuF01GXLVIFzqL5e8TC3C?=
 =?us-ascii?Q?WGbr02IainkcV8QzpfwR1pW0xuiPnpeukD54F+v9UyyEXUUCytMpn4rZONzS?=
 =?us-ascii?Q?hkWKO79n9rfu6fOTNhyW9Z7/N3AxxF+KTB3QtW50ZHbARgYOVIH0OpMUJmBy?=
 =?us-ascii?Q?M7pY8FxIudNQgfAa4eBVtPxosdE4uZFrPS9p1WRDRun2vpkxJcJ7DqowuaCL?=
 =?us-ascii?Q?O7K2g8oidejx2BfhU7nf4rBdXa0GBhYZL/0Snmbc3IF4ejP4Tgi/IzYBMcIj?=
 =?us-ascii?Q?D9hsccWEW4wEHjctRawl407s6Er72KRQBDptgrCYhnP2pZztp0/IivTTBl3L?=
 =?us-ascii?Q?iJ7k5t7ZrH4H3jlS3VT4oRfRZNvI5F+/vv/H9qUMDuEH7PAadC6s0Nqpn5ET?=
 =?us-ascii?Q?pteeSVWwcHPkjNzECBFKnASIM+p186QnaWw1K9AJItmUC9Rg5HM03aaiL13B?=
 =?us-ascii?Q?pPZCxNY18Edph4odVFmEIwOn8qH36FSM4zAV3+QW6a8evrkBq5YZzlysqySX?=
 =?us-ascii?Q?vpYjQTrXjjy1+PUWlFe1gH0wSs0b+dbMrO3cXBxgf21kf68YyFZptZa+FwP4?=
 =?us-ascii?Q?3AmKSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf511a-ea75-4bd1-4fc6-08d9ab04772e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 02:29:51.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5k7iP38mH1A6wuhjL8ljqdsr0MThNIJK75NSEMQBddjZ66Jfq9oUhjtOFV8ueukI73GHhTJzREzPuDGFMZlEQXMEr8XpbLzrhrv6Hku0nLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ben

Are you planning to add the CXL2.0 switch inside QEMU or already added in one of the version? 
 
Regards,
Shreyas

-----Original Message-----
From: Ben Widawsky <ben.widawsky@intel.com> 
Sent: Thursday, November 18, 2021 5:48 PM
To: Shreyas Shah <shreyas.shah@elastics.cloud>
Cc: Saransh Gupta1 <saransh@ibm.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; linux-cxl@vger.kernel.org; qemu-devel@nongnu.org
Subject: Re: Follow-up on the CXL discussion at OFTC

On 21-11-18 22:52:56, Shreyas Shah wrote:
> Hello Folks,
> 
> Any plan to add CXL2.0 switch ports in QEMU? 

What's your definition of plan?

> 
> Regards,
> Shreyas

[snip]
