Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA2C77B61
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 01:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDKBSs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDKBSp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 21:18:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD011728
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 18:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRNj7Q7i53NohrbPkCpWZATE4VxMLoF0GPo7fEo5xpGCXcaNFS70zVzdF8wezxVGclCO7XcCCX0dpil13tkkNTCewtKiZ01p6SXJ5MZQiy2XfSRuviAI/uUj840DoyMw5hh1TsF59ajXkaK6pfSCHYcwFWpGahzuSI0/ARZv3412XmEZkxPH2awL0X71reszXCvyv/8+P2SxuoSupu4QnKUrwz1U8v1fXaORr9tYevjfepguMMJ2vdL7nTWKJBgCiOa5tzSbZ0KZVR+Q5sjcvDoRWhDauSVNNWX+Q/HRPP05BhSoh6tj0bD7z3CyE6hHuaqaa1KqnVR0fMmDNp6yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd9HLSjRY2JX3m0dd25B1qxtG8ZNfvQfAoCt7o/+I7g=;
 b=jAOOLYIBzlUrScpREgzVmqKfCKThp9O2rR7RAxLEzOr2I3ymb+UwZG7HrXrmvnHpAIDP1NPGWm9TGimp47rBwNXsbmJxHo3WCdPkWpavKmny8jU34/hqE0OWY4ACfzcsq6aGh+/xCJlWPqjPixLENMEC4Ld1BOmhOsxkbNvrLUankgOmFmVbpSvLq1IGZS8+DB4pJyxfJsjjZzwZJ6FXgRXiMU18KLxw1lQ2Zbt5foN32v4Z7LIJXgc0TAzXoqVgb4Ncd27BP91XzOaWet/KV6WK5IgUzH1ayAVjDvLu1r4M/YQxSEdqjBj7CjMujEmQo7X9dfQT0c2p7onGrogtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 11 Apr
 2023 01:17:52 +0000
Received: from IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698]) by IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698%3]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 01:17:52 +0000
From:   Shreyas Shah <shreyas.shah@elastics.cloud>
To:     Dragan Stancevic <dragan@stancevic.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "nil-migration@lists.linux.dev" <nil-migration@lists.linux.dev>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: =?utf-8?B?UkU6IFtMU0YvTU0vQlBGIFRPUElDXSBCb0YgVk0gbGl2ZSBtaWdyYXRpb24g?=
 =?utf-8?B?b3ZlciBDWEwgbWVtb3J54oCL?=
Thread-Topic: =?utf-8?B?W0xTRi9NTS9CUEYgVE9QSUNdIEJvRiBWTSBsaXZlIG1pZ3JhdGlvbiBvdmVy?=
 =?utf-8?B?IENYTCBtZW1vcnnigIs=?=
Thread-Index: AQHZaZS3JrIHO5cgzEWWdYXqvZvfo68jP8HggAIRZICAAAH3oA==
Date:   Tue, 11 Apr 2023 01:17:52 +0000
Message-ID: <IA1PR12MB623666337403D0D7B4B9D47DE89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <IA1PR12MB623638228AD6EE30F336CDCDE8949@IA1PR12MB6236.namprd12.prod.outlook.com>
 <2fb46081-b9d1-47af-b2e7-a0eb68797386@stancevic.com>
In-Reply-To: <2fb46081-b9d1-47af-b2e7-a0eb68797386@stancevic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6236:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: 396ec722-d052-4df5-d91b-08db3a2a9261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2WNGXXteJo4CUvnTxkkUOi9TgOqpTeqwmie256mQZ76WTHYnTRQtlupJ9vkSBHpqg1eKe4dU06pZUleKnsJjpisEkgugA5t/gSlMSsscvHq0cqdMdgHqmUCcxXTL/fe32R7ASIdqR4aiQNCCug0J85jz4v5Ba297gOlnN0aG79Ui+CeLK4x2YQKmThnFmOTIBoGm4Ph8OFvVrRBqlmE4veOSlwo4Aezwm44XMHu8lNfxHDEPE34CpuyJdm6HewndnXEXMLNBCjaT0HZ1YyhSbsnVYYzpifJNIczqdqmka4ordcAkedOJN7B8xIpiFqFeWt5bFtqhv+5Ga4lx2b7GK4vbHZ9+TLEWM7WHgL35NxKGKGj5xw1Trz/u0weDHZIgDTCnXEr8Ne1v0adtyenBLEft6LFmYosH0nHy6dWoN382o8giMdS674sqga5c52tEwTjWLsuewdC6CbA9fh+qJSWlp1+8vNBj7MdPeiFXjq8XbpskkXx1Tru9fK9PRNe+nqBp7L5ZEj94YYUGXUwX6zNWV/hWZ93eXaZef5Wq/2AuCguZmCNFEECvmmId//OyPklBeFJnlY+wbPTGLa20Id9LL+pd/QxIhF1v9FeG9XdCvDo5bmLl7p+QWk6xY3kz4HGGL9PwJwKg96wh3u3dNoiHGDMuiB7Y3JpJynNnH4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39840400004)(451199021)(38070700005)(66556008)(53546011)(122000001)(26005)(966005)(186003)(38100700002)(83380400001)(9686003)(55016003)(5660300002)(8936002)(44832011)(2906002)(52536014)(33656002)(478600001)(6506007)(66476007)(66946007)(76116006)(64756008)(110136005)(54906003)(71200400001)(41300700001)(316002)(4326008)(7696005)(86362001)(66446008)(66899021)(518554002)(71440200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUc3SEc4aWRqemVxRU8zRm1LaGhxVmcydkVQbGpJN2Zxd3VnUnh1bEttbmcz?=
 =?utf-8?B?a0d2WENTTTdERFV1REpPZTN3NXhxcXRlZ01TUXVucy8ya21wVHhoMzQ0Q1JT?=
 =?utf-8?B?RUFCOXdMbFpXaW5adkpNWGFLZ2RYd2kzMmZOVHF3bERsQzJqQTl1MG14MXho?=
 =?utf-8?B?bG93eStxVkl6bkIvT3ZlcXRRZll6dXAzVVp5SHZPQWZ4MXY5MjhiVFNqSnBR?=
 =?utf-8?B?eTVER0k0OFdZVjg0MS94V3BwOFlHTlZYZWkzclo2TWEvbWNvb09hcTZHNWdj?=
 =?utf-8?B?K0FMeEY4SlMrY1NjWHc5VUtKa3hGN1hJbHJDOS9PTXR5ekxSSUtlQWtzRWgx?=
 =?utf-8?B?a2d1UzdwRHRUSVVPTm9QSU5kcjdHRVZsTG8wVHN3UzhSdHAweWJWcnlaYkND?=
 =?utf-8?B?V3JCcGVYVjhzLzY3bHYxUjVYQW15ZC9nQUxSZWtwV2hvTmhUWjlyd1kzNXFl?=
 =?utf-8?B?Q0tUN0ZtbHdxMGwxcVBXV0YzVXNxRU9zWmNvOGRob0lTalZJTU5Yd28yV2RX?=
 =?utf-8?B?U1lRSjNPajVQUjZDdXNEMUN1MmxhSDRQbEtlbU5uRGFiUDBlMW9qSkp2UG1n?=
 =?utf-8?B?cFg0NVpSNnJRYWpRNDBWeUJuSFlZWUs2V2JkNk1iMTBUckpFb1RHcko3TWtL?=
 =?utf-8?B?cFpEWm5talJ5bWFjVWtIQmtYUGdzMzhycnhTZDQvM1VjRUpobHA2VkdlN0JF?=
 =?utf-8?B?Q0RkejNCOXBIUFVkTkk2WnBwUTAzQkxLSWgzUG56KzdqTzFlaGJzbFRzdlhq?=
 =?utf-8?B?NUZ1dEtiNFFYcGlSLzh6SFBUb0cwY2tjZHZMZHhiYUhhY2F0dE9BQUtFc1Fx?=
 =?utf-8?B?cnl0R0ZvMUlZNXUzcTd2cTUxZ05xVVNJVE9IRFBlUWUyaVFsbEpNZEU0dDNH?=
 =?utf-8?B?RFdUb0xvYmJIZHViTjJLTUxVYjBJZzlST1BrZnp4UnRkS2g4bHpaaUl2RUl5?=
 =?utf-8?B?b01jSHo4WlhCVWRIRUhFcnU5MnRpZjBYU2lXZGkzTzJnRDVuOCsrMVBsenhM?=
 =?utf-8?B?aEJHSEJvR3ZhSEdYUWc3Z3RVMnhwMWI5WDRKaDJFNjErcjlZSjlFOTFtVTdO?=
 =?utf-8?B?TmZCM0k3TUR5RHB6dGVlRVp0c01TYm5BU1ozczNOQm5pWHJlNTZkcmFCcGlL?=
 =?utf-8?B?MlhVY2RkdDRSTHhYdDVuRnh2SVZpcmQzYVhFOW0vTlNidHBFbzcvOE9LUEVO?=
 =?utf-8?B?TDI2UkdyTE9NVnY5Zk5UeDJtYVNFVzJnUUtiOUI1UUdrUjE5YjZvNjF1TFV5?=
 =?utf-8?B?RHdHWk5WcXpVcFpBVDVENGZBcmNIR1B0bUczVDEvaFFJQVIrOGNyTFhzaFI5?=
 =?utf-8?B?VENzZC9nUDlkbDB6TVN1TWdpUzlhQkMybWRRYy9zS1pyMFp4N2Y2MWZ2eTZx?=
 =?utf-8?B?WUhoWUsrMEs4WDg3dFdoQVF2bHZ2Qk54L1R4a3g4bmFYK0lnRmoxMVdqMnE3?=
 =?utf-8?B?UWZ2b3JxdFQ3aTNCQkxRZEw4SnlyUU9FckM3YVNGQmZhbng3cUoxVW9hNXFB?=
 =?utf-8?B?Q0wyTHZwUmhFNFpqbjNoVGl6NCtGMFVrWEJIYmZpd2RUUTdsY1MvNE0wak4r?=
 =?utf-8?B?RXVwVy9QOWgxb3NsL0dnRDN1NkpYNlNXWXVTMU9mcDN5S0tyVCtLSklDNjFY?=
 =?utf-8?B?SDI2Zk5yTVRDZWFUZ1JPYlJ6ZXQ5cUptc0dLZWJnRnRieEdJS2JFSEpwQVo0?=
 =?utf-8?B?ZlU4UFBJMVdsbjJpdFRrK0FnZzRjWWVMU2JteUsySkJ2ZmZRMlQ5ZWJCcjk5?=
 =?utf-8?B?ZGUwMWxlcGpoYkJFR0xYd3dWSWNQbXpVampXUytKTUFoUklESzA3aTNMd0dw?=
 =?utf-8?B?TEtBN2d3bE43QkcwUlpXanBoOHRHU1kyY1pmS3U5eGdDbnJKS1RqK28wMkpL?=
 =?utf-8?B?eEJ3a0pSM1E3SWJNTURzS1gxSU1nN29ubEhHVThGei9DQ1Y3NEdDVEtCMEN0?=
 =?utf-8?B?Rm1yRktmN3FaTjBjNW1xeVdBSkNXR25DakJwYTc4cVVrS0ZzZjlkajRTT0ZD?=
 =?utf-8?B?S0dhUWcxODM0TlcvdjQ1YmlwTGhqRzBUNzJ6VVNsdFpNbHJTaDNFNWU4eFJ5?=
 =?utf-8?B?cDRLeGlzMjh0dHlMQWNsbFZTd2NpMVUrcjk4SCs5R09rVzdKWGk0RTlVaTEx?=
 =?utf-8?B?NFZuSlZkNVhZeVVjNUxSeTNFZHNzZllKWmZ1L0QwZWxVOXpWRE1HSzFNVWtD?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396ec722-d052-4df5-d91b-08db3a2a9261
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:17:52.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfyBHUY5mqh0osJrwfHr/731/2ljwaVLyXDTKvb73MhAa/nadAqhm2sq/NGQ35IeNGIWh0POPs38YWvTae3TRC64ZVw4D4kBWkGKt12Ep1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

VGhhbmsgeW91LCBEcmFnb24uIA0KDQpCdHcsIHdlIGNhbiBkZW1vbnN0cmF0ZSB0aGUgVk0gbGl2
ZSBtaWdyYXRpb24gd2l0aCBvdXIgRlBHQSBiYXNlZCBDWEwgbWVtb3J5IGFuZCBvdXIgZGVtb25z
dHJhdGlvbiB0b2RheS4gV2UgYXJlIG5vdCBhcHBsaWNhdGlvbiBleHBlcnQsIGxvb2tlZCBhdCB0
aGUgbGFzdCBkaWFncmFtIGluIHlvdXIgbGluayBhbmQgd2UgYXJlIGNvbmZpZGVudCB3ZSBjYW4g
YWNoaWV2ZSBpdC4gDQoNCldpbGwgdGhlcmUgYmUgYW55IGludGVyZXN0IGZyb20gdGhlIGdyb3Vw
PyBJIGNhbiBwcmVzZW50IGZvciAxNSBtaW5zIGFuZCBRJkEuDQoNClJlZ2FyZHMsDQpTaHJleWFz
DQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRHJhZ2FuIFN0YW5jZXZp
YyA8ZHJhZ2FuQHN0YW5jZXZpYy5jb20+IA0KU2VudDogTW9uZGF5LCBBcHJpbCAxMCwgMjAyMyA2
OjA5IFBNDQpUbzogU2hyZXlhcyBTaGFoIDxzaHJleWFzLnNoYWhAZWxhc3RpY3MuY2xvdWQ+OyBs
c2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCkNjOiBuaWwtbWlncmF0aW9uQGxpc3Rz
LmxpbnV4LmRldjsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3Jn
DQpTdWJqZWN0OiBSZTogW0xTRi9NTS9CUEYgVE9QSUNdIEJvRiBWTSBsaXZlIG1pZ3JhdGlvbiBv
dmVyIENYTCBtZW1vcnnigIsNCg0KSGkgU2hyZXlhcy0NCg0KT24gNC85LzIzIDEyOjQwLCBTaHJl
eWFzIFNoYWggd3JvdGU6DQo+IEhpIERyYWdvbiwNCj4gDQo+IFRoZSBjb25jZXB0IGlzIGdyZWF0
IHRvIHRpbWUgc2hhcmUgdGhlIENYTCBhdHRhY2hlZCBtZW1vcnkgYWNyb3NzIHR3byBOVU1BIG5v
ZGVzIGZvciBsaXZlIG1pZ3JhdGlvbiBhbmQgY3JlYXRlIGEgY2x1c3RlciBvZiBWTXMgdG8gaW5j
cmVhc2UgdGhlIGNvbXB1dGUgY2FwYWNpdHkuDQo+IA0KPiBXaGVuIGFuZCB3aGVyZSBpcyB0aGUg
Qm9GPw0KDQpJdCdzIGEgcHJvcG9zYWwgc2VudCB1bmRlciAoQ0ZQKSwgaXQgaGFzIG5vdCBiZWVu
IGFjY2VwdGVkIHlldC4gVGhlIGFnZW5kYSBpcyBzZWxlY3RlZCBieSB0aGUgcHJvZ3JhbSBjb21t
aXR0ZWUgYmFzZWQgb24gaW50ZXJlc3QuIFRoZSBjdXJyZW50IHByb3Bvc2FsIGlzIGZvciBMU0Yv
TU0vQlBGIHN1bW1pdFsxXSBydW5uaW5nIE1heSA4IC0gTWF5IDEwdGgsIGJ1dCBpdCdzIG5vdCBo
YXBwZW5pbmcgaWYgbm90IGFwcHJvdmVkIGJ5IGNvbW1pdHRlZS4NCg0KDQpbMV0uIGh0dHBzOi8v
ZXZlbnRzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbHNmbW0vDQoNCg0KPiANCj4gDQo+IFJlZ2FyZHMs
DQo+IFNocmV5YXMNCj4gICANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IERyYWdhbiBTdGFuY2V2aWMgPGRyYWdhbkBzdGFuY2V2aWMuY29tPg0KPiBTZW50OiBGcmlk
YXksIEFwcmlsIDcsIDIwMjMgMjowNiBQTQ0KPiBUbzogbHNmLXBjQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnDQo+IENjOiBuaWwtbWlncmF0aW9uQGxpc3RzLmxpbnV4LmRldjsgbGludXgtY3hs
QHZnZXIua2VybmVsLm9yZzsgDQo+IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBTdWJqZWN0OiBbTFNG
L01NL0JQRiBUT1BJQ10gQm9GIFZNIGxpdmUgbWlncmF0aW9uIG92ZXIgQ1hMIG1lbW9yeeKAiw0K
PiANCj4gSGkgZm9sa3MtDQo+IA0KPiBpZiBpdCdzIG5vdCB0b28gbGF0ZSBmb3IgdGhlIHNjaGVk
dWxlLi4uDQo+IA0KPiBJIGFtIHN0YXJ0aW5nIHRvIHRhY2tsZSBWTSBsaXZlIG1pZ3JhdGlvbiBh
bmQgaHlwZXJ2aXNvciBjbHVzdGVyaW5nIG92ZXIgc3dpdGNoZWQgQ1hMIG1lbW9yeVsxXVsyXSwg
aW50ZW5kZWQgZm9yIGNsb3VkIHZpcnR1YWxpemF0aW9uIHR5cGVzIG9mIGxvYWRzLg0KPiANCj4g
SSdkIGJlIGludGVyZXN0ZWQgaW4gZG9pbmcgYSBzbWFsbCBCb0Ygc2Vzc2lvbiB3aXRoIHNvbWUg
c2xpZGVzIGFuZCBnZXQgaW50byBhIGRpc2N1c3Npb24vYnJhaW5zdG9ybWluZyB3aXRoIG90aGVy
IHBlb3BsZSB0aGF0IGRlYWwgd2l0aCBWTS9MTSBjbG91ZCBsb2Fkcy4gQW1vbmcgb3RoZXIgdGhp
bmdzIHRvIGRpc2N1c3Mgd291bGQgYmUgcGFnZSBtaWdyYXRpb25zIG92ZXIgc3dpdGNoZWQgQ1hM
IG1lbW9yeSwgc2hhcmVkIGluLW1lbW9yeSBBQkkgdG8gYWxsb3cgVk0gaGFuZC1vZmYgYmV0d2Vl
biBoeXBlcnZpc29ycywgZXRjLi4uDQo+IA0KPiBBIGZldyBvZiB1cyBkaXNjdXNzZWQgc29tZSBv
ZiB0aGlzIHVuZGVyIHRoZSBaT05FX1hNRU0gdGhyZWFkLCBidXQgSSBmaWd1cmVkIGl0IG1pZ2h0
IGJlIGJldHRlciB0byBzdGFydCBhIHNlcGFyYXRlIHRocmVhZC4NCj4gDQo+IElmIHRoZXJlIGlz
IGludGVyZXN0ZWQsIHRoYW5rIHlvdS4NCj4gDQo+IA0KPiBbMV0uIEhpZ2gtbGV2ZWwgb3ZlcnZp
ZXcgYXZhaWxhYmxlIGF0IGh0dHA6Ly9uaWwtbWlncmF0aW9uLm9yZy8gWzJdLiANCj4gQmFzZWQg
b24gQ1hMIHNwZWMgMy4wDQo+IA0KPiAtLQ0KPiBQZWFjZSBjYW4gb25seSBjb21lIGFzIGEgbmF0
dXJhbCBjb25zZXF1ZW5jZSBvZiB1bml2ZXJzYWwgDQo+IGVubGlnaHRlbm1lbnQgLURyLiBOaWtv
bGEgVGVzbGENCg0KLS0NCi0tDQpQZWFjZSBjYW4gb25seSBjb21lIGFzIGEgbmF0dXJhbCBjb25z
ZXF1ZW5jZSBvZiB1bml2ZXJzYWwgZW5saWdodGVubWVudCAtRHIuIE5pa29sYSBUZXNsYQ0KDQo=
