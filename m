Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D452C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Nov 2021 22:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1F161260
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Nov 2021 22:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhKRW4C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:56:02 -0500
Received: from mail-sn1anam02on2131.outbound.protection.outlook.com ([40.107.96.131]:55922
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231526AbhKRW4B (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Nov 2021 17:56:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/keEyh0xiYmv+FUwR29Y2N0AA1hZjtvt3BeH7Tzcwg+ziMLJqPP4ljEr4XDgnYM4wvi028ReeCQZeJv6Et6zsJm+F38a1nfV/YVa5m1M2J8PBhZ+MU+AAAOKXCON4RMPtSYq4Vu689xsv9SJXVzwoFcJPaP4dunIyv7so5QOeDaewnJBM0GgsaG3jUc7wd79bbLd3RBXrFe+6m/G5F2WuyMc38gthWqN7uUrdHSE8+V496wDIo3n5TGbTtAsCD55fQ1rDSwrLqiR6gmvsw0ofUw4o4CrBdAb+Bl43DC+O+uER5BI8UHvkVIZ4mOjGP2SUTaUBXMtnVAKF+dihY5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEEQ4AO3Nt+v/P9eoUkg6yy7qwvZt+LjZSfP6GhBudM=;
 b=UXH/1B1LuauFXl+X4UU9G3sjgsXPTHHLVLHd7vNOpS4RRsqdAdNknItLZ5c1I6hxeXHKngg7XmxQNbebNQFw7ciIEWxQ/VPUykH1+7zs9Gd4j0Fu08ZWDmTm6ff3Yi7ZdUHOsRiDLhhMx8VfaRN4AOROBI/kYu4uuZBCQ/XYOQ3kutQ3NGDXKPVQb4qg7hu3nAfR5gMmnkVOpoQNNXIJHoP2Sl5cJ5r6qGSiKSWQaN+b0NxJTfnSc8VUBJvQU5CqGXdWMu4J0Kml4FiMgxB4SwArPP6dkXr/fhDiYPuAaKv4qtXXrTTFcmIYw3q4CxT3u7TTRopLdDJUQseWgZzuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 22:52:56 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::fdcf:4e98:b845:f650]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::fdcf:4e98:b845:f650%6]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 22:52:56 +0000
From:   Shreyas Shah <shreyas.shah@elastics.cloud>
To:     Saransh Gupta1 <saransh@ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: Follow-up on the CXL discussion at OFTC
Thread-Topic: Follow-up on the CXL discussion at OFTC
Thread-Index: AQHX2+CvgZdbGOWQAkmzzqDeTIciUKwJ3UEAgAAI7MA=
Date:   Thu, 18 Nov 2021 22:52:56 +0000
Message-ID: <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com><20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
In-Reply-To: <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24c5fb63-cd92-46ad-ba33-08d9aae6299a
x-ms-traffictypediagnostic: BY5PR12MB4888:
x-microsoft-antispam-prvs: <BY5PR12MB48883843207B7C760A73CDF5E89B9@BY5PR12MB4888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTdLVHD1+l9k40e8cTXgg0RMpzBpilOXdSsovlpFJA+ORv3txQlCmSmTWR9O/9LUgAAHucqBa8/ZdSZPY6UxHphay+GjEYtWOVA2lZ8cVJlZaHUYFxB8KE5Kny2pHoLmMRuQdGY/LeO7/RSvUjvWTDl3sTwB1KEdWv0nHIeVycyrJPHWtGnit+FZx0wBolSUGwgaRCFsp4CO6LiRS0LLcJHMahG9v4FOSc0WoPdcayjSJwMskacuYtytK2lB/ZUmN8+3X29o5AQxWkHlguqhKSQR5cjKsu1Cg4YSdn8Ukhboho8UofHu/KLzpR6PpzCH9TfWEUDrlnwoY4MRyr7hL99MBZ0g+dLJCRcJ5AHMORPLzg/7xk/xzDgB/wObNyVlyLtlrC2x2/uJKsXMofl00Z/zpsn8icIEmwHlWkCVWq4dzYP5dZcCwEBPG6dJzoPy9z1hUSkY3Ipz9Gcdh5CGuFVGmn3c593CTIc745P4EY6aKOPr6GvWCXjgiKZOKAKQh8710MIpqldk5epkrIKVFUy7aHJbgJ7jFX8yARjvT0rGJ93kgcoVD+TrH1S4LKCbwW/m/a8Np+RlY7M2dc6P0aAazTsZFmWMHKVtJDiHXpPe5m5OBlsz1+RAtrZRy6ZFhIdeAPjvtrpJ5cypsCAVKgnfziG16oXdX7mNJu8UZjfJYVz+eTJ2rDLjyBRVW7jxBXg9jF/eXk/GkJ55Kf/L2jKYwIdYN9d7p3GuEsChK5rlhLmtQeIiFeX599AFSe9KWvo7FZAD7tZaoncsIaezI64OCeZJwTXxv6cweMYuh4LLSsK9DZwq4p7lihUebb36m+ommmwJLK5bj2+HlkGevg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(366004)(396003)(376002)(136003)(316002)(110136005)(508600001)(966005)(54906003)(7696005)(5660300002)(52536014)(71200400001)(6506007)(186003)(53546011)(8936002)(55016002)(9686003)(83380400001)(2906002)(44832011)(26005)(38100700002)(33656002)(66946007)(122000001)(4326008)(66446008)(66556008)(76116006)(66476007)(64756008)(8676002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sUJ0XlFp6lv4eZ9Uu7Cba+y0CjWPS+P9OyWq/0/bpyQKcIMaSr7c1UsZ9mMH?=
 =?us-ascii?Q?ayFGbnUFQ0ptTca04JFslzNYRu3H+A2VqaSiKlw0iHFBlOuVvPJmzd8lrNo3?=
 =?us-ascii?Q?H4JN2tIP0lziVETOYZVYnB8I5E9seESVelUwzAwnRraB3yExAsKY91Zyo07i?=
 =?us-ascii?Q?ofhUUW2JadOlKD0XJtVFpURTtneAf6v+ilm4f00LaFLMzRfbldTdLMFtjVa2?=
 =?us-ascii?Q?OrM1VEvxi6lIGh1qBJ8LMriYCDrlOSahPjuz2cmIM5zzW4NPwvXt48P76drV?=
 =?us-ascii?Q?0ClY59n6y7uWwaV3GICijzVSsP6oS42jFxrzCTh3OnEHgdmqARLMycc2Lf7I?=
 =?us-ascii?Q?ha1LABF/FOlzUZdCZaT2iTdxFFFR9lykz1cS/eE17sUGvUOld6AlZYT0uvNw?=
 =?us-ascii?Q?jVQpHUeZ3WVjDFoKftDLtJQ8bxdLz+f1oXUZveWyYFyxI6NJj7IKgC6baR8h?=
 =?us-ascii?Q?oKTWUqnk3bPCcVRKNDvCa7J0+X3UFKZ2H871ulyJHhRxjQ8BMpv608wqiVy0?=
 =?us-ascii?Q?vajPb72n7MB0deOJb61UBVwntiXjs6fSfYuNx6kvn+sdbjhmzdNidgrUME6J?=
 =?us-ascii?Q?zwiM4n0R7boenZNixP6RzQOuKKI4MsudcF7RenJAq3zpayu6be9M08yKGjej?=
 =?us-ascii?Q?qQbyB6FOuumMyXz7VysnzgYYaem4A2aLlRKh0nHB73EVkMjTiwNPWPtKuAEZ?=
 =?us-ascii?Q?AF6dU7kAMS8od09bRTFIGGnerFkLdWN/P1K4if1+0ZBZ8gr6FsR/SlX6TVKT?=
 =?us-ascii?Q?Yat7CTqy2t9sxnSqFw0K3JM4tD655JPtgz9IAfZn9g2gcBE2lf3/qK0cAlMv?=
 =?us-ascii?Q?piUuqW42m9q2W/n28Wb8Q4tq1RksJYRc1fnHNoxAulIYaHcq4bmpSU1CnaXl?=
 =?us-ascii?Q?9PUUM/cJGJI8pj1RyR4desFzSjer95A9fwgR+wegRmWAw8csYR0TxJxxFGU2?=
 =?us-ascii?Q?F6/ePq3zpVPwJOgLq/FqffMnW+riDykwt84f7HselhMceUK/m+/a6GDFh09B?=
 =?us-ascii?Q?IhmUYxrCXCbOj55Z/4c9oGVJrtW/D8tklhcVPCPHrqv3C8ib+XIPv30ZZEHJ?=
 =?us-ascii?Q?45upPWjFVtCX4i4ymSLeYtS/JkqLhHgWYlKNNdZcCLFPqIuUSBgiZxjJxxGW?=
 =?us-ascii?Q?92T9m2JszK0T9jfBak9AXFoXodLxzYtClDzZ1h+2opEHZwXY+D8y3TeYu+1e?=
 =?us-ascii?Q?tbcotqbSJypV5KI7pEVOIhK34rCz8o0Rnp/aOQM2/8TjJcELeHXvUFwkF7t9?=
 =?us-ascii?Q?lWld3EdZAlOvPpbAq8nI7DQpbLpzRx+u0ZNZwc2wrBLRcQ+miTDsrq0vTTke?=
 =?us-ascii?Q?mbBQBcHeAcS7xDyhzLdQXd0KBMumVtu8jWbS3TSctsRaWCLBv/l8cFG1yewk?=
 =?us-ascii?Q?1Sx0RJ6ke4h2SQQtldOT4gXTAuaklX5eQttnfH9FDgXevkdFxCQKSkQ+uFi1?=
 =?us-ascii?Q?/NiwJmOw0iL62jTuGbjchHwh2F3PJNu2eSeoMe7/T3w+TwOHwyAJVG/05BhW?=
 =?us-ascii?Q?89+CrTTeLOCN6VBekiuFYYv1rmAvBnh+ZMdrkSpVVrGbWI1C5nTho9dox5Fi?=
 =?us-ascii?Q?FDkvDFmmj6hfTlP38KEVK/uGao6ucbWOY2hYL7RC/HxMIl3S14IEKaiZE4Xu?=
 =?us-ascii?Q?F1YLvpnAPuo2Yq6VI0q+amhnVZYovhEMmXLoDF727eM5cXy9+Nco0jJ41fUD?=
 =?us-ascii?Q?OHaBgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c5fb63-cd92-46ad-ba33-08d9aae6299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 22:52:56.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6cgzC29KsorcIGuoOEv+wsiI8UOtH9cr+cSpWqe1SiTawMEPv9qQ55ygf13UIjbWfByI8q5jp9X1hyRvirDKKORAt/H2QKcGXEG/nNx1KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello Folks,

Any plan to add CXL2.0 switch ports in QEMU? 

Regards,
Shreyas

-----Original Message-----
From: Saransh Gupta1 <saransh@ibm.com> 
Sent: Thursday, November 18, 2021 2:21 PM
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; Ben Widawsky <ben.widawsky@intel.com>
Cc: linux-cxl@vger.kernel.org; qemu-devel@nongnu.org
Subject: RE: Follow-up on the CXL discussion at OFTC

Hi Ben and Jonathan,

Thanks for your replies. I'm looking forward to the patches.

For QEMU, I see hotplug support as an item on the list and would like to start working on it. It would be great if you can provide some pointers about how I should go about it.
Also, which version of kernel and QEMU (maybe Jonathan's upcoming version) would be a good starting point for it?

Thanks,
Saransh



From:   "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
To:     "Ben Widawsky" <ben.widawsky@intel.com>
Cc:     "Saransh Gupta1" <saransh@ibm.com>, <linux-cxl@vger.kernel.org>, 
<qemu-devel@nongnu.org>
Date:   11/17/2021 09:32 AM
Subject:        [EXTERNAL] Re: Follow-up on the CXL discussion at OFTC



On Wed, 17 Nov 2021 08:57:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Hi Saransh. Please add the list for these kind of questions. I've
converted your
> HTML mail, but going forward, the list will eat it, so please use text
only.
> 
> On 21-11-16 00:14:33, Saransh Gupta1 wrote:
> >    Hi Ben,
> > 
> >    This is Saransh from IBM. Sorry to have (unintentionally) dropped
out
> >    of the conversion on OFTC, I'm new to IRC.
> >    Just wanted to follow-up on the discussion there. We discussed
about
> >    helping with linux patches reviews. On that front, I have
identified
> >    some colleague(s) who can help me with this. Let me know if/how you
> >    want to proceed with that. 
> 
> Currently the ball is in my court to re-roll the RFC v2 patches [1]
based on
> feedback from Dan. I've implemented all/most of it, but I'm still
debugging some
> issues with the result.
> 
> > 
> >    Maybe not urgently, but my team would also like to get an
understanding
> >    of the missing pieces in QEMU. Initially our focus is on type3
memory
> >    access and hotplug support. Most of the work that my team does is
> >    open-source, so contributing to the QEMU effort is another possible
> >    line of collaboration. 
> 
> If you haven't seen it already, check out my LPC talk [2]. The QEMU
patches
> could use a lot of love. Mostly, I have little/no motivation until
upstream
> shows an interest because I don't have time currently to make sure I
don't break
> vs. upstream. If you want more details here, I can provide them, and I
will Cc
> the qemu-devel mailing list; the end of the LPC talk [2] does have a
list.
Hi Ben, Saransh

I have a forward port of the series + DOE etc to near current QEMU that is lightly tested, and can look to push that out publicly later this week.

I'd also like to push QEMU support forwards and to start getting this upstream in QEMU
+ fill in some of the missing parts.

Was aiming to make progress on this a few weeks ago, but as ever other 
stuff
got in the way.

+CC qemu-devel in case anyone else also looking at this.

Jonathan



> 
> > 
> >    Thanks for your help and guidance!
> > 
> >    Best,
> >    Saransh Gupta
> >    Research Staff Member, IBM Research 
> 
> [1]: 
https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t 

> [2]: 
https://www.youtube.com/watch?v=g89SLjt5Bd4&list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&index=49 






