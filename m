Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE67C77B6E
	for <linux-cxl@archiver.kernel.org>; Sun,  9 Apr 2023 17:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDIRk1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 9 Apr 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDIRkZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 9 Apr 2023 13:40:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2138.outbound.protection.outlook.com [40.107.243.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A613C16
        for <linux-cxl@vger.kernel.org>; Sun,  9 Apr 2023 10:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIMEKVhY1PTaT7EJT4Nkwoc8kCqd4rphG3onW/WAf8zwLah6qoBZIRi0DKFegUwznZDrFarKkH55WTCANhjZ5rah41XcTz8Exx/UrKIjmy6s85cmdC2BJBkvhlz7JEkux4YXIecoyZzHaX4slaFzVlqiwZ3dj5DTZn9Fe1nh3EG7+MeqMA7bGUtH/XkPbKDLOIEfW0lsL8HVXx1Eplfrcv4jjJYYvMRU97YKQVXPdX6pO/L8BQZj0NY2FtRPhRxQC6HgYr4+tYgVlLa+7tU1StJcAxEBENBLAHcBXQagWrp0iX/48TfwLZSfHymZrzPgKO0PShTR5P5eooB9sbLp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0igWW2fWA36vrpJLA9N0Igo4BpJL3RtZEzGPufCekz8=;
 b=Nh7kNKc8SC3hOsxF/IvdPy1q5fJraDptaaLQO2VlcmRfT889rY9RFrjzz16MT239+tADrTP/fbjizuT2OxNz41fkBkw93kFF6oFo/hftiHtw9PHbgvmDhu0ob3EPXpArz4S5CIgORY5ImpVifR9Jqd9gjd5HAqqg3x9ohb9uuWwDTQSSPWKojubaSTFiO2H8BDOrYdnZIRw0/PaFP91J+3uOFE7DcZV7xAWmr8LTfCQ3prYabEhifIwDsm+FKat4PqqvG92+rh8VPqxo4eYGo9hGt9aNfrtUhQsPHV8OA3w1DEEd8CzhMZD8evkQuHAjyPk0bGG9LU9aW0Y+veYrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 9 Apr
 2023 17:40:10 +0000
Received: from IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698]) by IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::b59d:8208:1318:5698%3]) with mapi id 15.20.6277.035; Sun, 9 Apr 2023
 17:40:10 +0000
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
Thread-Index: AQHZaZS3JrIHO5cgzEWWdYXqvZvfo68jP8Hg
Date:   Sun, 9 Apr 2023 17:40:10 +0000
Message-ID: <IA1PR12MB623638228AD6EE30F336CDCDE8949@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6236:EE_|DM4PR12MB7645:EE_
x-ms-office365-filtering-correlation-id: e3150e30-a031-4d56-0446-08db39217748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZT+dgOEy5cAcYAg5QeGWN3wMuQovkG16UmLu67Zjh+sFOZ4OuNGUbBS3O9mOLEMRtR3wPtXMdje+oYNcYGM9ybNE4G7qf6GmGiMCPmaKyQOmJVHv2544YJoF+X9Uol50YnC3yW9h1+N4w6SRakRngXNLFoKg5tELWEkY+0A6ucihBvzPvQ5jc5MYUnoM+LkYN8hE1PVVotdUe+UVjqtKMiMQvDf76FQsuqkqRtXiU3E0Pa08YrULdDYHBa5mHaymj+4drspA1ZwlXQRAYyXEl9ga4Xa1BAHHDf2eqWetI3PsA0rs366dAHFZnQR9xTqZj5NetMfk4Z0sbV2Qf61T+9VylW2UsiWsVVulo0nQOpBARwE0rMhSvgG7WY5+JiCKmidQhUM255Phizx38CsGpeaNNHptLdWUqKPBE3s4tLlY2NLeDtp2TqYyKipqfPS8Nr1Zw0I31YBBg+ttUwkZfVoWoqeog3He+DI3vpm3W0AjyotCUzOc6jpOstzhMnJsutwsjbedjdTRtzK2v5f7T8nl93oBGUZt7wvYdcuLfW7/CwEi3/31jsd7dtfYccTnZD6ZeWHeRlcd5su71CJDOdwiVnDeNLtD3LnHGNilXmqHpm7n1AqfHZJSqvQFQHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39830400003)(376002)(396003)(366004)(451199021)(86362001)(33656002)(110136005)(316002)(76116006)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(966005)(7696005)(54906003)(478600001)(71200400001)(55016003)(5660300002)(2906002)(52536014)(8936002)(44832011)(38070700005)(38100700002)(122000001)(186003)(53546011)(9686003)(6506007)(83380400001)(66899021)(518554002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHE4cjJpalhmWHE5KzZtTUR0R2tMd1FueGdTRUh1bUJ3YnM5V0UwalExUUJE?=
 =?utf-8?B?ZSsrVjZORnMzakJESTlEK0w0TzJURkNoeFI5dkdhak12ZkhRdkc4cnl0VnRq?=
 =?utf-8?B?ZDUvaFppdnJTK3AxdkZmSTQrRmhwaWpveXAxTXNFZlNmcFArWUVvaW56VU1W?=
 =?utf-8?B?SE5UaEZ0eWdBUlpBY3NIUmg1UWNwTGdUMEF6MFQxcFkzakZJZXc2cGdEc3Bz?=
 =?utf-8?B?NE5Cd3ZJYi9GVS9QeklIRDFVdDdnQzdlQlhWQndTRUtFZUQxMzlzNzhtTENX?=
 =?utf-8?B?UnlNWStJYjlnUU1hNTdvNFhTSUdoakJ3eWJJR1FXaENDK2tmNzczcVdhRHZY?=
 =?utf-8?B?VlFnOFF5RXJGUjk0K21NVzFMNTlnUjZYZWVMeEVBYjkzdzR4OVFlTjQ2TE1y?=
 =?utf-8?B?S2pkenhydjVmZFdXMWxMRmVjRUJFeEg1a2pwMnlmeVltR1FQRXF6NHluQ1pW?=
 =?utf-8?B?LzVHTm80ZklHeGhuS05ZWm1QYnVQTmxkVHhUU3N0Sm9ZZFJZTFg2K2xobnhY?=
 =?utf-8?B?cFdkdVhrVlAxZ0dLV2NaUWh1RVZaODFza1dwZGZNdkNLREkyU1VmS0M4akNs?=
 =?utf-8?B?SWZkT25MOUswQ3dNb0pyOFBrbUI2ekM0ckVoaFNhc3N0MjZjRThWRHVycmJu?=
 =?utf-8?B?K21ncXRaZUNDbFFZUDNRTFUzaXBZOEl5KzdFY1diT1RHclBrSHhJdFptM3dG?=
 =?utf-8?B?bU9rTmI2cXliWVJDR0orVVQwMEZPS3N0QkRGb3ZaOVAwL0JpcUxTdGRSV3ZI?=
 =?utf-8?B?STRDUEg3TFd4STRaelJZRkpYR3RPd0pRazBSWHZBa0JSWStSNXpZZVc1djJV?=
 =?utf-8?B?Q2lMQXdtNHAyQnVwYzV5c05nVk8zTjlGaHBtWkJzSkdwQkVwaWFzZFppZUUv?=
 =?utf-8?B?WThpampZUC9aT2tBVFhVbEwreUx5cVIweFNsTmorcTRpaW9xemtVQU8wNVY1?=
 =?utf-8?B?OHAvWTZWSk0vYUdGbENuT3d4UFRLbWV5SDhlaDd2VUorY2VUVlFnQzlaNnlE?=
 =?utf-8?B?dUVZMzFZVVRHTTVhazBqY0FzUzkrdGE5Z2tVSmZZNXhkWWNXejRONjkwdHhI?=
 =?utf-8?B?SHJFL01KYW5DSVVKMnI4Z2IxVVdLdTZqSnQ5QWVVTE1uaW1sOEptWDZmN05v?=
 =?utf-8?B?V2pNSFB4NXNjQWREbFhUbTNxREJIZVU5bGtJd0duYVRNeFpDanlaT1Z5YThu?=
 =?utf-8?B?ZTF6YkdTU2dDWTJBMnMxYkY1N0IzUkloTGNZelgzQVFsZ1l0SUVHQlV1RnNn?=
 =?utf-8?B?SVBXT0J4K3JCOS9MZTA1blVIa0pQNWhnMThpV2hCRHVaRzR6OEJNRmxEQ3ZZ?=
 =?utf-8?B?TU9RdVU1QUQzRWticUxwcnczNklJM2pCQXV6Rnh5N1lvU3ZnRGI3WEpvUlpx?=
 =?utf-8?B?eE4rcURGZUlBWlVPYS9wK1NqRkNZMGMwSTcyRjJuemRmOUpDckg0d1FVY09P?=
 =?utf-8?B?Z2gwcWZ2Y1A5OTQ2Q1pnaEFIZnlkRm4rVEhiT3hVNXUvbTNtbFJ0SlY5SmNR?=
 =?utf-8?B?VFdxUUN3T3p5ZmZnK3VzWXlBV2VKVXg4bStTMWIxNnhJK0JjeG05SzVLcCs4?=
 =?utf-8?B?STFQVzhDTFNrMWZGVy9wZ29ZVDY2SThVV3JKbW5KUEtWc3pxMk1aNzByejVN?=
 =?utf-8?B?UHA5emlYRHBEdkI0MDlCTFhXWjBsandLVG1UeklnSG80K3BGcXJnK00rZHpr?=
 =?utf-8?B?aFNtTStrK1lSZUpUVHN5YUlock03Tm9WNlNoQXROd1ZMcWdmMmJXTERTaGdq?=
 =?utf-8?B?Vnp2bW0xUnJGTGdiU2xpWURhT0VUWDllV3NnSmhKZk5nWGFyUGx0alV2T29m?=
 =?utf-8?B?TjFSVzB0eDFPUm51ZTVGN0l5MjhhNHkydmJtUGN5T1ljNGR1Wjd3QmVYNUp6?=
 =?utf-8?B?OGFSYmxhR2hWTTk0amRKQnJ3dlZZWDVObnVKM3EwZUMzd2RVMWZsWGt1ZEF0?=
 =?utf-8?B?cjRVb2FUNmwwcHRWbjhPOXBSSGN5TTBsbVphcXJrQUZyVmJmUXVQcmV6ZVpi?=
 =?utf-8?B?QlBWWThoQWk5U1dnMFNpbDIzaUMvV25RVzUrbnYyQlpLWWcyTXdteHQ0b1RZ?=
 =?utf-8?B?YWNvUHZqSTMzNlo1ZndnUnc4ZXYrM1dLY0xySTgvMVEyVEdSNzJCVFdiNkJ3?=
 =?utf-8?B?T00vOG4waS9oTzVoWXBwWGpqQ0V2Z1NOWUJ1REtLT0R6bFFCZHBVd2psZmR1?=
 =?utf-8?B?a0x5TzZXbU04OUpxUzZFRCt0T3h0N2kyVFJjU3MzUFYxVjZHMUpzS1R4Y0Qr?=
 =?utf-8?B?Y1VJQXJES3l3ZlptZExkWFpVOEZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3150e30-a031-4d56-0446-08db39217748
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 17:40:10.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzUax40L4+VUAI3OFjUC0f6+xde8ZTotCdU7GFeosR+lii4KAXP9Q3zsHOhIF6KBTgP+9J6zOaolj+o6LVJ8YCXE/tm6+BT8vQTKzAP3vmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

SGkgRHJhZ29uLA0KDQpUaGUgY29uY2VwdCBpcyBncmVhdCB0byB0aW1lIHNoYXJlIHRoZSBDWEwg
YXR0YWNoZWQgbWVtb3J5IGFjcm9zcyB0d28gTlVNQSBub2RlcyBmb3IgbGl2ZSBtaWdyYXRpb24g
YW5kIGNyZWF0ZSBhIGNsdXN0ZXIgb2YgVk1zIHRvIGluY3JlYXNlIHRoZSBjb21wdXRlIGNhcGFj
aXR5LiANCg0KV2hlbiBhbmQgd2hlcmUgaXMgdGhlIEJvRj8gDQoNCg0KUmVnYXJkcywNClNocmV5
YXMNCiANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERyYWdhbiBTdGFuY2V2
aWMgPGRyYWdhbkBzdGFuY2V2aWMuY29tPiANClNlbnQ6IEZyaWRheSwgQXByaWwgNywgMjAyMyAy
OjA2IFBNDQpUbzogbHNmLXBjQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQpDYzogbmlsLW1p
Z3JhdGlvbkBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LW1tQGt2YWNrLm9yZw0KU3ViamVjdDogW0xTRi9NTS9CUEYgVE9QSUNdIEJvRiBWTSBsaXZlIG1p
Z3JhdGlvbiBvdmVyIENYTCBtZW1vcnnigIsNCg0KSGkgZm9sa3MtDQoNCmlmIGl0J3Mgbm90IHRv
byBsYXRlIGZvciB0aGUgc2NoZWR1bGUuLi4NCg0KSSBhbSBzdGFydGluZyB0byB0YWNrbGUgVk0g
bGl2ZSBtaWdyYXRpb24gYW5kIGh5cGVydmlzb3IgY2x1c3RlcmluZyBvdmVyIHN3aXRjaGVkIENY
TCBtZW1vcnlbMV1bMl0sIGludGVuZGVkIGZvciBjbG91ZCB2aXJ0dWFsaXphdGlvbiB0eXBlcyBv
ZiBsb2Fkcy4NCg0KSSdkIGJlIGludGVyZXN0ZWQgaW4gZG9pbmcgYSBzbWFsbCBCb0Ygc2Vzc2lv
biB3aXRoIHNvbWUgc2xpZGVzIGFuZCBnZXQgaW50byBhIGRpc2N1c3Npb24vYnJhaW5zdG9ybWlu
ZyB3aXRoIG90aGVyIHBlb3BsZSB0aGF0IGRlYWwgd2l0aCBWTS9MTSBjbG91ZCBsb2Fkcy4gQW1v
bmcgb3RoZXIgdGhpbmdzIHRvIGRpc2N1c3Mgd291bGQgYmUgcGFnZSBtaWdyYXRpb25zIG92ZXIg
c3dpdGNoZWQgQ1hMIG1lbW9yeSwgc2hhcmVkIGluLW1lbW9yeSBBQkkgdG8gYWxsb3cgVk0gaGFu
ZC1vZmYgYmV0d2VlbiBoeXBlcnZpc29ycywgZXRjLi4uDQoNCkEgZmV3IG9mIHVzIGRpc2N1c3Nl
ZCBzb21lIG9mIHRoaXMgdW5kZXIgdGhlIFpPTkVfWE1FTSB0aHJlYWQsIGJ1dCBJIGZpZ3VyZWQg
aXQgbWlnaHQgYmUgYmV0dGVyIHRvIHN0YXJ0IGEgc2VwYXJhdGUgdGhyZWFkLg0KDQpJZiB0aGVy
ZSBpcyBpbnRlcmVzdGVkLCB0aGFuayB5b3UuDQoNCg0KWzFdLiBIaWdoLWxldmVsIG92ZXJ2aWV3
IGF2YWlsYWJsZSBhdCBodHRwOi8vbmlsLW1pZ3JhdGlvbi5vcmcvIFsyXS4gQmFzZWQgb24gQ1hM
IHNwZWMgMy4wDQoNCi0tDQpQZWFjZSBjYW4gb25seSBjb21lIGFzIGEgbmF0dXJhbCBjb25zZXF1
ZW5jZSBvZiB1bml2ZXJzYWwgZW5saWdodGVubWVudCAtRHIuIE5pa29sYSBUZXNsYQ0K
