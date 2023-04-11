Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9AC7619A
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 04:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDKEda (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 00:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDKEd3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 00:33:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2116.outbound.protection.outlook.com [40.107.102.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8110E
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 21:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDRjquoVztHaT/f2lJbo3r++DvRcWqaEyWcym7yclURD/1EuJ9b6DElAnxnnOYghjpi8okONgSG0O6tcEof4ZbhqS3mMCFNiCnusATV/193QuhXQ0BcI8ILQA/+l0QEjhe7/f44S9P4fA5EyiLfpPSjJSpLJFYy1fY/6yyzzzkqCWJpHdciSjDhwq01JSENR7WDG8GSrMbgdpHBOFRQ+wy2KlTE19D1ACorLxxADbmvZyOdMxcz0JhVz2fV2lYW6zn1XOtQJZMv8THMkZr5XlM7M17BISRT4ype+pidHg5+aBPKidZnAu90Yqz3aOzhNvP+r273vwtPsX6u5Rxyg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuPkVeKJlIQ/0vdAU6O+H18cKkuJexaK+f2ib3q6hI8=;
 b=NWsHcHWVRlcDJcoV3Im3eQ43EYNmzgiWsouy9AnyZqkdn8Ce4KwqVV06w4cStD5p3MfEisCPPQYBfaScDkoeJorv6EAzidWz9u44AY5s1PURQLnxBkc5FsujGWJ9RHKIZBDXUsWZES7YgQ3DcES1ICG8Dszo4JNS7fAG/st8faSU+v5JuWF+d+ktBi/4NH2vBuA35erspd044wJdrHS+mlmFvarteEacT/KzOfmEjqv/S+4n4HBD/M7mnRHIfh9hIlATBRXrw6QkuyCEFw/i5zynkKsPqp1UKjRpGPfvkz668z/4pY3MfLJ4CopMrTXwO+lOKoToo7DInnb9Ev6k1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 04:33:24 +0000
Received: from IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698]) by IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698%3]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 04:33:24 +0000
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
Thread-Index: AQHZaZS3JrIHO5cgzEWWdYXqvZvfo68jP8HggAIRZICAAAH3oIAABMCAgAAqryA=
Date:   Tue, 11 Apr 2023 04:33:23 +0000
Message-ID: <IA1PR12MB62363D430C430431DEBFD7C8E89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <IA1PR12MB623638228AD6EE30F336CDCDE8949@IA1PR12MB6236.namprd12.prod.outlook.com>
 <2fb46081-b9d1-47af-b2e7-a0eb68797386@stancevic.com>
 <IA1PR12MB623666337403D0D7B4B9D47DE89A9@IA1PR12MB6236.namprd12.prod.outlook.com>
 <2ae1bdc2-60bf-e6a2-722a-ad42295a4929@stancevic.com>
In-Reply-To: <2ae1bdc2-60bf-e6a2-722a-ad42295a4929@stancevic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6236:EE_|DM6PR12MB4896:EE_
x-ms-office365-filtering-correlation-id: a66fa966-ef2e-400d-dbf8-08db3a45e30d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D81ZXRxWVdI2WeENh6YZD1q/2Gn1tEIfV8VNiFiuGU8VbjMGEYnCY0cpwvasRXtJhtpo6W7yUruzQWkRFKTl4H6XbJUhotf0byKN0x7gytdNkxusiAIjGdczA3i2B8jwwqe8rbmbVVukdABwrOTILZBUv+eM3+5MHGKvVUJcSBUF8XA3SRgckGdsZGxzaoUwY1YGLr5sJ7Q52v69LsvWl8fqQ41XSGNMg528iFdvsFaXog92LR9QZoKmrhwFl8uHu2rn6+c2hCNb5PHE80n8NOkRzdNBJ4VuG+I8+1aUCpAYY/IzSRh+DolDUGb+Jx8KMCB/5zCAixpjR740iGWivWcP3CzNNP6wCiiQa/XqWryNdzo+MykxedJsv6x63xrkHAmA8FEOOZOagG25ViXp4Ipwl2x/osAvm26k3vb0L2LtlGiepIcCGUwva/zz+mxMtDzoXo+YDb4N39g6gM+P0DMewLan4tx5kNjIo6h3nt8Jcybc6j0stZUhsE4YoRkahCIG9QUwJbDHmqkiZo3LiLGkz82dZRyv1uOskfP2LQkPNx+MGm1YhFAz1ZCaqmUCmHQwYUEinl2Se0dCK+L19VHgrGtI279i1o/PpZ37lWogAlWDlTEmFF9VlSJ4QvCyxnXhhIIrNa9pm/LCIBh+W7/g3PrKoZc1ufVFBn6auNY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(478600001)(7696005)(71200400001)(6506007)(316002)(110136005)(54906003)(53546011)(9686003)(186003)(966005)(2906002)(44832011)(66556008)(76116006)(66946007)(4326008)(52536014)(64756008)(41300700001)(5660300002)(66446008)(66476007)(8936002)(38070700005)(38100700002)(122000001)(55016003)(33656002)(83380400001)(86362001)(66899021)(518554002)(71440200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUxWcEQzb3FPTHJqOU1pdnN2SmNJZ0FsUVBIMDJDSkpScDdMa0I2NkdNT2hX?=
 =?utf-8?B?dFRKLzVucDZDbzdjdGVKMDhXemkxSXBHNE81ZkswWWlUaDU1VkZ5dGNoUDVy?=
 =?utf-8?B?Zld4dnpLKzBKbWwzTlJDNGFyOERlM0Y0M2NSK1NNcnd5UnVsdDRxb1ZNWGlX?=
 =?utf-8?B?SXZtaTVVM29FaytSaEo5S0dvQUVLaGRwQ2thaVNmL1FjdU9vMGt1aWloTXdp?=
 =?utf-8?B?c1p4TjNTbW1UUHp1YXZNYzB6SlJ1RXlXci9vMW40eGxZeUc1Mko0NkJQVVR1?=
 =?utf-8?B?MGtaem8vcUJWTkE1REY4SDlnc2RvQjEvL05aWWtac1BoMUowb2liVzZkYVFE?=
 =?utf-8?B?bzVlRXdlZ1QwblJmcy9LNU50MlQ5M1YxNmJDend0Zzgremh5dVhhTVlrMWJv?=
 =?utf-8?B?ZkwrK09FU3RVN2l2TmVaQVNJWXBBVUlxQzVNYmhVZWlLaFNPdlBjbTQ2T25I?=
 =?utf-8?B?dmlXbzBBZlNabmtMWFFKRUFVMTlCcDlrK0V5U3lvdGtqdk9PWW1Zb28wc3NJ?=
 =?utf-8?B?djRUcEFVNkxYSHJtRmVKM25QY0FuaFhYdFNVcjAvUjFpUjB0K1Rwbm51dDVo?=
 =?utf-8?B?T1E4OXBvRnZrWEEwUGQyYTVQRVJOczVodWs2YUtrR3FPM2ZIbHZZT2tBWFVJ?=
 =?utf-8?B?TVlqZWhiWnNzd0d5RXBDUzJOUUkyMFEwZEpuSmh6OC9zaHNWbExydnVqckxk?=
 =?utf-8?B?ZVJhRTJTdTgrc2ZYakR4QmgvSlR6UTU4Z1VuMExyeUlDU1BXL3pyUlZVTUhn?=
 =?utf-8?B?N3hkNXBXUVN0dys1WEx2S3RFZXVLdFMwQTVpaGxxbllEL3NqdXhUYll2OWIz?=
 =?utf-8?B?VHFBTm5oNEM2TjVlQjB0K1BJb2hnbHJOWmxIMWV2cmRqSVNrTm9JckJpMVh6?=
 =?utf-8?B?UFhuZ1JDTHNiSno3dE5IZHZLVjBnS2liU2ZUQUlESElNZU80TlgzZC9USmF6?=
 =?utf-8?B?VGFGQ05EWE5DTzROVjJCNmhJMElaMWNpenRGamp2T2I4TmloTWNVbDJLRDdU?=
 =?utf-8?B?T3JqOCtnY3U0ZHFaUVkrWTdtT29PejBOTEo3bDd0MG1PQUc1aXlXU2F2RERo?=
 =?utf-8?B?N0tzY1BadnptZUVEZVdQWGhla05hZ1VwYXNQU0ZWVkFDbWZFejRhYytNa3dX?=
 =?utf-8?B?UmRxTWIzZFpWSzhJVStSdVAzSDZtK0VNR1gyVWFoRHd5ZFpySDRDSTNPUVRi?=
 =?utf-8?B?anpTOTlOeE40bGRQVktQcnBRUmpFMVlKLzVmRGtyRFhKVncyVy96aWRNZGth?=
 =?utf-8?B?ZmJTdjBQSUlVZ2EzY3ZmSjVxTUpTaXY2QWNNUzlONWQrN1VhajJXQjVpNmR0?=
 =?utf-8?B?bGZmWDZPSis3SE9BYzMrbWxzQXovVlJxeGYzNTQ2eGtTL1grc1ZuVHdiUDh4?=
 =?utf-8?B?cGZMM3hVVEpCeDRRUDdHZjNLbzhCK3VqTVZtZWdGajhoUFgyelpXamxsYy9C?=
 =?utf-8?B?UG9WcmNXM2I3dmluQ21obE5ybHB1WTNZSGVLamE1VkMvL2FlSTgwcC9zcW1Z?=
 =?utf-8?B?RWhUbU9Ddzl1OW5OU3lGRVk2YTU0N2ZJc1RVOVYwb05haHZxU2I0SEVNWW5n?=
 =?utf-8?B?NURyRm42ZjE4RE1xcVVYNFJUUUVVc29BVEdPeSsvcnZXZkxZYUZ4Z3E1cXh3?=
 =?utf-8?B?Sk5XdklnK3crcHl1MWQ3TGJ4OElFMnQrWW9aaGdtTVAzeGhjMkk4UzdhNnRN?=
 =?utf-8?B?c0kwcTJVRE80cGoxRjZka0ZuV0ZoWWplUm8zRUtyczZjQmhlbUdDd3RhdGxE?=
 =?utf-8?B?a2hCWUF4aUdCV05NVk5xWjRLN0R4Uk9YOTUyaWxHN2Jxb1BzYnJoWExVZWhE?=
 =?utf-8?B?ZGZIVnpSTTJmTGJJcEc0UlJlV1diN1FhdThCVTNWYjd4NzIzeklMaXhBQkkz?=
 =?utf-8?B?dTlrcDJBZ3RWQzVNVFFrdWtPaXB4eU9UY2xRSFJmTTRBU3UvMVMrNms0Slpl?=
 =?utf-8?B?cXlSeldyK01mRU5WVTlBQjROVkppUnFHYmRVVjVhZGlBMlZ2SG4xWlFrYVI0?=
 =?utf-8?B?RndmRXBMZlJUTngyR0JCckR2SGd3bjRmVDRLVjdseWdsYUcvSm15akhHMmYz?=
 =?utf-8?B?dkNaV3JYbG92U01OM2tEZUR5NEhiVElubHlkSjhRaXc3WGcralVaSFVqbkRq?=
 =?utf-8?B?WU5Qd3BpOFNmc0UzU09MM0VKV1VOWFRLZXNlQzYrT0NpRTYvSnQ2QmpTYUdu?=
 =?utf-8?B?OVpiWkVxajAzN1FjMy82TXRHMjI1YUo5ZGpTd3hFbWVXZVhkSitxZ1lvYUZs?=
 =?utf-8?B?TVAzdmtBRVU2TzFueGZsU0Z6VmJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66fa966-ef2e-400d-dbf8-08db3a45e30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:33:23.9177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7f1AYP5vC0F49J3zkTOUvIBXhdVsuXuUiJ2YB9Vx79K2uZsruCnWEm2uJg8MPZn2CD4QWO3lI157ddofOaXJUWlzDMBBPhTIdKq0cmYbM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

SGkgRHJhZ29uLA0KDQpEbyB5b3UgYWxsIG1lZXQgb24gWm9vbSBvciBUZWFtcyB3ZWVrbHkgY2Fs
bD8gDQoNCk1heWJlIG5leHQgdGltZSBJIGNhbiBwcmVzZW50IGlmIHlvdSBoYXZlIGEgc2xvdC4N
Cg0KUmVnYXJkcywNClNocmV5YXMNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBE
cmFnYW4gU3RhbmNldmljIDxkcmFnYW5Ac3RhbmNldmljLmNvbT4gDQpTZW50OiBNb25kYXksIEFw
cmlsIDEwLCAyMDIzIDY6MzMgUE0NClRvOiBTaHJleWFzIFNoYWggPHNocmV5YXMuc2hhaEBlbGFz
dGljcy5jbG91ZD47IGxzZi1wY0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KQ2M6IG5pbC1t
aWdyYXRpb25AbGlzdHMubGludXguZGV2OyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tbUBrdmFjay5vcmcNClN1YmplY3Q6IFJlOiBbTFNGL01NL0JQRiBUT1BJQ10gQm9GIFZNIGxp
dmUgbWlncmF0aW9uIG92ZXIgQ1hMIG1lbW9yeeKAiw0KDQpIaSBTaHJleWFzLQ0KDQpzcGVha2lu
ZyBzdHJpY3RseSBmb3IgbXlzZWxmLCBzb3VuZHMgaW50ZXJlc3RpbmcNCg0KDQpPbiA0LzEwLzIz
IDIwOjE3LCBTaHJleWFzIFNoYWggd3JvdGU6DQo+IFRoYW5rIHlvdSwgRHJhZ29uLg0KPiANCj4g
QnR3LCB3ZSBjYW4gZGVtb25zdHJhdGUgdGhlIFZNIGxpdmUgbWlncmF0aW9uIHdpdGggb3VyIEZQ
R0EgYmFzZWQgQ1hMIG1lbW9yeSBhbmQgb3VyIGRlbW9uc3RyYXRpb24gdG9kYXkuIFdlIGFyZSBu
b3QgYXBwbGljYXRpb24gZXhwZXJ0LCBsb29rZWQgYXQgdGhlIGxhc3QgZGlhZ3JhbSBpbiB5b3Vy
IGxpbmsgYW5kIHdlIGFyZSBjb25maWRlbnQgd2UgY2FuIGFjaGlldmUgaXQuDQo+IA0KPiBXaWxs
IHRoZXJlIGJlIGFueSBpbnRlcmVzdCBmcm9tIHRoZSBncm91cD8gSSBjYW4gcHJlc2VudCBmb3Ig
MTUgbWlucyBhbmQgUSZBLg0KPiANCj4gUmVnYXJkcywNCj4gU2hyZXlhcw0KPiANCj4gDQo+IA0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEcmFnYW4gU3RhbmNldmljIDxk
cmFnYW5Ac3RhbmNldmljLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMCwgMjAyMyA2OjA5
IFBNDQo+IFRvOiBTaHJleWFzIFNoYWggPHNocmV5YXMuc2hhaEBlbGFzdGljcy5jbG91ZD47IA0K
PiBsc2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gQ2M6IG5pbC1taWdyYXRpb25A
bGlzdHMubGludXguZGV2OyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyANCj4gbGludXgtbW1A
a3ZhY2sub3JnDQo+IFN1YmplY3Q6IFJlOiBbTFNGL01NL0JQRiBUT1BJQ10gQm9GIFZNIGxpdmUg
bWlncmF0aW9uIG92ZXIgQ1hMIG1lbW9yeeKAiw0KPiANCj4gSGkgU2hyZXlhcy0NCj4gDQo+IE9u
IDQvOS8yMyAxMjo0MCwgU2hyZXlhcyBTaGFoIHdyb3RlOg0KPj4gSGkgRHJhZ29uLA0KPj4NCj4+
IFRoZSBjb25jZXB0IGlzIGdyZWF0IHRvIHRpbWUgc2hhcmUgdGhlIENYTCBhdHRhY2hlZCBtZW1v
cnkgYWNyb3NzIHR3byBOVU1BIG5vZGVzIGZvciBsaXZlIG1pZ3JhdGlvbiBhbmQgY3JlYXRlIGEg
Y2x1c3RlciBvZiBWTXMgdG8gaW5jcmVhc2UgdGhlIGNvbXB1dGUgY2FwYWNpdHkuDQo+Pg0KPj4g
V2hlbiBhbmQgd2hlcmUgaXMgdGhlIEJvRj8NCj4gDQo+IEl0J3MgYSBwcm9wb3NhbCBzZW50IHVu
ZGVyIChDRlApLCBpdCBoYXMgbm90IGJlZW4gYWNjZXB0ZWQgeWV0LiBUaGUgYWdlbmRhIGlzIHNl
bGVjdGVkIGJ5IHRoZSBwcm9ncmFtIGNvbW1pdHRlZSBiYXNlZCBvbiBpbnRlcmVzdC4gVGhlIGN1
cnJlbnQgcHJvcG9zYWwgaXMgZm9yIExTRi9NTS9CUEYgc3VtbWl0WzFdIHJ1bm5pbmcgTWF5IDgg
LSBNYXkgMTB0aCwgYnV0IGl0J3Mgbm90IGhhcHBlbmluZyBpZiBub3QgYXBwcm92ZWQgYnkgY29t
bWl0dGVlLg0KPiANCj4gDQo+IFsxXS4gaHR0cHM6Ly9ldmVudHMubGludXhmb3VuZGF0aW9uLm9y
Zy9sc2ZtbS8NCj4gDQo+IA0KPj4NCj4+DQo+PiBSZWdhcmRzLA0KPj4gU2hyZXlhcw0KPj4gICAg
DQo+Pg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IERyYWdhbiBTdGFu
Y2V2aWMgPGRyYWdhbkBzdGFuY2V2aWMuY29tPg0KPj4gU2VudDogRnJpZGF5LCBBcHJpbCA3LCAy
MDIzIDI6MDYgUE0NCj4+IFRvOiBsc2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4+
IENjOiBuaWwtbWlncmF0aW9uQGxpc3RzLmxpbnV4LmRldjsgbGludXgtY3hsQHZnZXIua2VybmVs
Lm9yZzsgDQo+PiBsaW51eC1tbUBrdmFjay5vcmcNCj4+IFN1YmplY3Q6IFtMU0YvTU0vQlBGIFRP
UElDXSBCb0YgVk0gbGl2ZSBtaWdyYXRpb24gb3ZlciBDWEwgbWVtb3J54oCLDQo+Pg0KPj4gSGkg
Zm9sa3MtDQo+Pg0KPj4gaWYgaXQncyBub3QgdG9vIGxhdGUgZm9yIHRoZSBzY2hlZHVsZS4uLg0K
Pj4NCj4+IEkgYW0gc3RhcnRpbmcgdG8gdGFja2xlIFZNIGxpdmUgbWlncmF0aW9uIGFuZCBoeXBl
cnZpc29yIGNsdXN0ZXJpbmcgb3ZlciBzd2l0Y2hlZCBDWEwgbWVtb3J5WzFdWzJdLCBpbnRlbmRl
ZCBmb3IgY2xvdWQgdmlydHVhbGl6YXRpb24gdHlwZXMgb2YgbG9hZHMuDQo+Pg0KPj4gSSdkIGJl
IGludGVyZXN0ZWQgaW4gZG9pbmcgYSBzbWFsbCBCb0Ygc2Vzc2lvbiB3aXRoIHNvbWUgc2xpZGVz
IGFuZCBnZXQgaW50byBhIGRpc2N1c3Npb24vYnJhaW5zdG9ybWluZyB3aXRoIG90aGVyIHBlb3Bs
ZSB0aGF0IGRlYWwgd2l0aCBWTS9MTSBjbG91ZCBsb2Fkcy4gQW1vbmcgb3RoZXIgdGhpbmdzIHRv
IGRpc2N1c3Mgd291bGQgYmUgcGFnZSBtaWdyYXRpb25zIG92ZXIgc3dpdGNoZWQgQ1hMIG1lbW9y
eSwgc2hhcmVkIGluLW1lbW9yeSBBQkkgdG8gYWxsb3cgVk0gaGFuZC1vZmYgYmV0d2VlbiBoeXBl
cnZpc29ycywgZXRjLi4uDQo+Pg0KPj4gQSBmZXcgb2YgdXMgZGlzY3Vzc2VkIHNvbWUgb2YgdGhp
cyB1bmRlciB0aGUgWk9ORV9YTUVNIHRocmVhZCwgYnV0IEkgZmlndXJlZCBpdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gc3RhcnQgYSBzZXBhcmF0ZSB0aHJlYWQuDQo+Pg0KPj4gSWYgdGhlcmUgaXMgaW50
ZXJlc3RlZCwgdGhhbmsgeW91Lg0KPj4NCj4+DQo+PiBbMV0uIEhpZ2gtbGV2ZWwgb3ZlcnZpZXcg
YXZhaWxhYmxlIGF0IGh0dHA6Ly9uaWwtbWlncmF0aW9uLm9yZy8gWzJdLg0KPj4gQmFzZWQgb24g
Q1hMIHNwZWMgMy4wDQo+Pg0KPj4gLS0NCj4+IFBlYWNlIGNhbiBvbmx5IGNvbWUgYXMgYSBuYXR1
cmFsIGNvbnNlcXVlbmNlIG9mIHVuaXZlcnNhbCANCj4+IGVubGlnaHRlbm1lbnQgLURyLiBOaWtv
bGEgVGVzbGENCj4gDQo+IC0tDQo+IC0tDQo+IFBlYWNlIGNhbiBvbmx5IGNvbWUgYXMgYSBuYXR1
cmFsIGNvbnNlcXVlbmNlIG9mIHVuaXZlcnNhbCANCj4gZW5saWdodGVubWVudCAtRHIuIE5pa29s
YSBUZXNsYQ0KPiANCg0KLS0NCi0tDQpQZWFjZSBjYW4gb25seSBjb21lIGFzIGEgbmF0dXJhbCBj
b25zZXF1ZW5jZSBvZiB1bml2ZXJzYWwgZW5saWdodGVubWVudCAtRHIuIE5pa29sYSBUZXNsYQ0K
DQo=
