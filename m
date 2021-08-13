Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED7C432BE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Aug 2021 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC4A61151
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Aug 2021 17:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhHMRCS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:02:18 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:63777
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233364AbhHMRCB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 13 Aug 2021 13:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmYfakiJx3GfJ/lPSEyBGQzrT3bndr+gGYUZ3oOJSaPSyx9DpywWy5KhIFtXyKCEREqqmAlHEGqcIesocfjTxR19rfxIVQ7NJAklzeokk/o3rx2lhe+ylEpPHOyd0A1Aw5Ti4EMxMKqDFb1Dae+fZq0Zr/XgE9Ar8ZtIQYBCgxIuIB/GJ/+5Ba5ZZCDmvkS5tH/7lxNa9tPYv+f+N/j+TOsZjV/6ZH8qJJaat96+p9M55c6AIl+wlUBZrYVLQ+8ojv5bdvePzyw8mXUa6LlI3AasJenG6Yb8+M6jelpEUOAUPfRBhN8q+PrUK0SyT5VNtRjy+9E4pPnAA1zibK15xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiQPjOLLlxuaWmzMHK9K0hMbyiooGXdEI1TuDlCAMz8=;
 b=WPGtxiSNEaiSuxXmTbOkMOkLYOYdVJtyxjZ5NkVpQKNy2kvVKdbWZgaRRE2uw1ycSKH9mlwizhOdTjV/Z+0k6bvCZldaQkO7tlR/RnQNqqI/lEQNrvbjdYau1vO/lwSLgNJ8diOb7uLRplqTkUlQ7JOAVf/kyV75oCMu3oz/lLN+NiNzSXWiXsa4p2TvaEu21BRH7BgMCLVLxWVFOB45Qk+c6vwZGmOcf/nIW7eNqiYjWMknStVsN9uAJHBXwHl/eKZgX1HggXe9pG+wv4kb9V2YALOMEk/tK/9NzUsgWoB60mLN1kljqWF7QSZwlJV5as4kPx9XVc6ZuUV6NeBK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiQPjOLLlxuaWmzMHK9K0hMbyiooGXdEI1TuDlCAMz8=;
 b=VSYbJ7tD1sBSdCHtjEBqkIgHILpZ8E7wHCmgYUHrxAs0Nbo4oeNR0BikFpPVbZerBzEDERPrJgACJblzkferBoElaFyWF2CnVpg6jTXWMH72mjcFOBA7DtegFZO0G+M/Wc05sZswUfpquqdwzux524D6xlNyHqGwUYFFB3j8qLs0UagJW1dvGbcaVWb0Vn6+oKsk2BeBN8v3cLdfKli4d1a+x8Ygu+/yIaUptieyGePKfT7Gne/HBSeCg+R0SWp480ey8lmSsj+n9FJ5eskKRDDcqnaVyODYS1v8bwDslc1BOHa6tnCpKQO37vnZVk8bziIht6P22bblWBmg/qSr9A==
Received: from DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) by
 DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Fri, 13 Aug 2021 17:01:33 +0000
Received: from DM5PR12MB2534.namprd12.prod.outlook.com
 ([fe80::5120:d8f9:95c2:c1f1]) by DM5PR12MB2534.namprd12.prod.outlook.com
 ([fe80::5120:d8f9:95c2:c1f1%4]) with mapi id 15.20.4394.022; Fri, 13 Aug 2021
 17:01:33 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: RE: CXL Hot and Warm Reset Testing
Thread-Topic: CXL Hot and Warm Reset Testing
Thread-Index: AQHXjtfrDArBRCuetkSyTwwpxulViatvD4aAgAKZddA=
Date:   Fri, 13 Aug 2021 17:01:32 +0000
Message-ID: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
References: <20210811194747.44688-1-johnny.li@montage-tech.com>
 <CAPcyv4gecCFVDeV2VwoaNwqycqkHNdKZT4-4KkcqLEbQ9RBsmg@mail.gmail.com>
 <DA610719-EB4C-40B5-9F53-26760E3BE754@avery-design.com>
 <CAPcyv4gm5sP4q75do27LMHYHHwqx2tK+OSfWmXUUmQaSEtW+Jg@mail.gmail.com>
In-Reply-To: <CAPcyv4gm5sP4q75do27LMHYHHwqx2tK+OSfWmXUUmQaSEtW+Jg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69262bfc-3f4a-47a5-3112-08d95e7c00bc
x-ms-traffictypediagnostic: DM5PR12MB1500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB150055E93158AC3668C4870FBDFA9@DM5PR12MB1500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TREWWV39y1q2c7TsahlP4Tgi1UdbOrh4qlVmfHJlX2LxvtwbbKiNOd6jbP/b7Xeb75kH8Ro41c5jTHpEYSsVNz+O376NIHP3l7Yj5MwRWLSLF01zEdImPqObiEhkogkxtdsB6l7FlO+lIREShdg9KnEVQuQ9vL4NttzzWUIYctVJeAhvjT8uTPW2AadeMTx9Y0uKB7wx2QHlvnkBfphiHil/OuOsyKzsU5eOV2jUXP8V6Z1uwgDdTZ/t5rYExEcBlYbwmspWolB7Ti9ArOvRmAmhuex/EWYqo8Hdk0wieUeKm9WHIm5r1MRDdyfF6sSvgSreud/PTxu3Khg/jX3pjlE4lBC8tVuwBIJcmCmbR20I31O9G/8GhCCf3kiEggkr1+/4KwiPVVbWvgyb+o54RyHt4KO/ar6hEC2AgzLaoph2ijevAKzC029Y/ohTlw8yxD0qdk+mefiE46MoPlTyFvt7gyQwOhTl0rxQSYLqhpuErp0qj9nv29OLPD0tIeyXENlbvogTMCeGSoIVhXGQjqUzU4VNDifPM6WepkJ47pM6BauUuDloPh5Sv4sQBq2lSF/7eI6JlvURbLp/aUc8MZXMy1HNOp2laI0T1lg/zScMB3Ltr8l4+7jJWk3lxOSG0xLqtn5T1WMQot04VWkH8zQmFoAwlV3nlNr5zqF8SAfZDQ2MVLVBki+hGd3vEoK2WD1dd9X5jouRNScNcUyc1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(52536014)(66476007)(64756008)(66446008)(66946007)(508600001)(107886003)(8936002)(71200400001)(55016002)(83380400001)(54906003)(76116006)(110136005)(86362001)(4326008)(316002)(9686003)(5660300002)(38100700002)(186003)(122000001)(38070700005)(53546011)(7696005)(26005)(2906002)(6506007)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkRYc29aNUg0NXpNMnF1L0k1WHJTT1pmRS95OG9GMEhMWDlHaTVuQ2w3T2sy?=
 =?utf-8?B?ZFV5WjFOcVBjS0tub0Z0QWN0V3VWMXRLUXJpcFhqam9rU1puRDVSM3lraWZV?=
 =?utf-8?B?Q0R3d3ZiZ0dQL2duaVJ3VE5yMGJ2MDNNeUtrc0p6cmQ3RTNpaEdxZkp6NmE0?=
 =?utf-8?B?djRVY3gwaFl3NlQvMXM5RTA5UGZSR0RvRGhrUXhuLzc4bUgwamg5ZTRPL0pn?=
 =?utf-8?B?ZWpMMmJCcDFwUm0wQnhhUm00WjlSZ2FTcUZWeWNHN0NpYW5OZThDUThMRS9Z?=
 =?utf-8?B?WU9Tb2NiSnJ5RkFSOUFOMjZhT0s0dmszVHNaT2N4dEhqS1BvYUxzKytBT2Uy?=
 =?utf-8?B?dTRTSXlmNER5Y2lMRFJrVXIrTHVpVTgvUWxyNmtWV1UwVWdUVjdGMGxBaEVj?=
 =?utf-8?B?MW9Ndy9WQUpWOEkwWGs2WUlFcGxqVWNRV2lnbUhGekR2bkx3cDVJeWM0V2o1?=
 =?utf-8?B?QjB6ekpucEo0MHpXQm1OV1FpeHhuREt6MXczWVQ2Mm1HZXlHbDFKT0RQQnNX?=
 =?utf-8?B?UjdMUnV2a1oyZ25YN29QeFBaVFhzOWFVenlPUmxHYjZ0dm5IZzN2dHo4Wmps?=
 =?utf-8?B?dXRHYkJNLzdmbEY2SGlJV3RrQmxYNzZxVFpjb2JFTk9CSDBiRXNvVGhSVHR1?=
 =?utf-8?B?bmptcVAzZDUwbTJzRHJSaFFnU3VmK016cld4VFBuR04xa01QOUl2eFNEWm5a?=
 =?utf-8?B?NWJNVHNRK3ppMXdaUGlZZVpWd20zdmkxUVRzbVFHR0JVZUlFUGVidmNGZzZj?=
 =?utf-8?B?QkNwNEE3cVdyL0hSWXZ3T2lkdzcyT2g1ZmovWjBkZHVOd0VUbmFlTXZacHNp?=
 =?utf-8?B?azI1L0xmY0MySU94blBIRTZycGpaZkdhbDRZYm5ZaUR5SXZvTVBRVm8xeDRX?=
 =?utf-8?B?RzlhMTg0MXR3cjlKQ2JpN25icU9COHNOK0x1YWVDRE1IdHJMeXVPV1lpTlli?=
 =?utf-8?B?S0xQQk80SWNxNHdDQUlPRk5oSHhBYnNiV2VBZ2ZCQVRWY0xDVlJiaXR4K0Zn?=
 =?utf-8?B?SGZhMkRNd1lnYWhkTHZtWGtTcnY1UXR6SXhJZUFQUlNuQjc1UktLM05YS21E?=
 =?utf-8?B?aDFhc1FGWXVVT05WaW9yZW5GRkNRcFI2Y2d2RHFrdDlwZnlXUkFaVWIxdnFT?=
 =?utf-8?B?N1FSdGhxWkhpUTFJYXQyZ2tlbWxCM2RXa0VCYmZSNEJsL3ZCMDhVU1lHSVFk?=
 =?utf-8?B?bnJpVnQ1bEFaWFhEWEY4SXVGT3Jab0lDWUZHVk82ZjFiTWZJMHp1NlFVMDlJ?=
 =?utf-8?B?bFhHd0ZHSXdSSWdoZW55eVcyUW4yV1lmemFsQVNuZy9oMEJNZ0tUR0lVM1lS?=
 =?utf-8?B?MXNDQnVMVWd6VGdhaXdUd2dscG9VUHBabFJoTEVFaFhUVW5WbVVoWE1TZVVQ?=
 =?utf-8?B?M0RLQTErRWl0Ymh5NGVGUXJIQlFMK3hTdWprS3FqTWxRc1U0UzlJKzg1Z3Ix?=
 =?utf-8?B?KzJsV1k2S1hXbEtSU3BlYWZZOEN2YXJLZ3BmYW5WT0QwanBrejZDbWxEcCtU?=
 =?utf-8?B?ZExUV3ZXRElZNzA3eWdRa3FQM3hqTStEd1hGSFRtN0E5eUlHUGwzazlHS0U1?=
 =?utf-8?B?YlQzc0EwZTJvWUZoeS9ZYjJQb0c2aXI2S3I5eVBML1BiR1A3bHZURG1MdnFs?=
 =?utf-8?B?UFE0emRQQWFPVWVrd3kzeVNxTWozV0dBUmtwZVd6TVRaa1hjQnpWQTEvRXZB?=
 =?utf-8?B?UkNWTTRZN0NVOW81RjVoMURKZEtKRW5LRDhIRFlFSXhNYkRZQmFQNE1LNWpS?=
 =?utf-8?Q?VOCPKik2gNszVZoMkuSRs5kTQTa3/Yp9EjhohIN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69262bfc-3f4a-47a5-3112-08d95e7c00bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 17:01:32.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udWJ7rnQXON5UcUdfJjLLp8zbRI1NLrxYmwesaiFXr7CamT6By1jlnnbBzXZFv8evJmw4KK5qTFlZqQkGQJhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

SGkgRGFuLCANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2ls
bGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gDQo+IE9uIFdlZCwgQXVnIDExLCAy
MDIxIGF0IDk6NDIgQU0gQ2hyaXMgQnJvd3kgPGNicm93eUBhdmVyeS1kZXNpZ24uY29tPg0KPiB3
cm90ZToNCj4gPg0KPiANCj4gL3N5cy9idXMvcGNpL2RldmljZXMvJGRldmljZS9yZXNldCBpcyBh
IG1ldGhvZCB0byB0cmlnZ2VyIFBDSSBkZXZpY2UgcmVzZXQsDQo+IGJ1dCBJIGRvIG5vdCBleHBl
Y3QgdGhhdCB3aWxsIGV2ZXIgZ2FpbiBDWEwgc3BlY2lmaWMga25vd2xlZGdlLg0KPiANCkNYTCBy
ZXNldCBtYXkgbmVlZCBzb21lIHRob3VnaHQsIHNwZWNpYWxseSBmb3IgZGV2aWNlcyB0aGF0IGRv
bid0IGV4cG9zZSBGTFIgYnV0IGRvIGV4cG9zZSBDWEwgcmVzZXQgKHdoaWxlIGZvcm1lciBkb2Vz
IG5vdCBhZmZlY3QgQ1hMLmNhY2hlL21lbSwgdGhlIGxhdHRlciB3aXBlcyBvdXQgQ1hMLmNhY2hl
L21lbSBzdGF0ZSBpbiB0aGUgZGV2aWNlIGFuZCB0aGVyZSBpcyBkaXNjb3ZlcmFiaWxpdHkgYXMg
dG8gd2hldGhlciBvciBub3QgbWVtb3J5IGNvbnRlbnRzIGNhbiBiZSBjbGVhcmVkIGFzIHBhcnQg
b2YgQ1hMIHJlc2V0KS4gV2UgbWF5IG5lZWQgYSB3YXkgb2YgdHJpZ2dlcmluZyBDWEwgcmVzZXQg
ZnJvbSB1c2Vyc3BhY2UsIGFuZCBpZiB0aGUgZXhpc3RpbmcgL3N5cy9idXMvcGNpL2RldmljZXMv
JGRldmljZS9yZXNldCB3b24ndCBoYXZlIGtub3dsZWRnZSBvZiBDWEwgcmVzZXQsIHRoZXJlIHN0
aWxsIHNob3VsZCBiZSBhIHByaW9yaXRpemVkIG9yZGVyIGluIHRoZSBrZXJuZWwgaW4gd2hpY2gg
Q1hMIHJlc2V0IGlzIGF0dGVtcHRlZCBiZWZvcmUgbW9yZSBkcmFzdGljIHJlc2V0cyBsaWtlIFNC
Ui4gSUlSQyBDWEwgcmVzZXQgY2FuIGFsc28gaW1wYWN0IGFsbCBmdW5jdGlvbnMgdGhhdCB1c2Ug
Q1hMLmNhY2hlL21lbSwgYnV0IG5vdCBsZWdhY3kgUENJZSBmdW5jdGlvbnMgb24gdGhlIGRldmlj
ZSB3aGljaCBkbyBub3QgdXNlIENYTC5jYWNoZS9tZW0gKHRoZXJlIGlzIGRpc2NvdmVyYWJpbGl0
eSBhcyB0byB3aGljaCBmdW5jdGlvbnMgYXJlIG5vdCBpbXBhY3RlZCBieSBDWEwgcmVzZXQpLiAN
Cg0KVGhhbmtzLA0KVmlrcmFtDQo=
