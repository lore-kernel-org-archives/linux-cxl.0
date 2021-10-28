Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595FBC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Oct 2021 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F1610F8
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Oct 2021 02:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1CXR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 22:23:17 -0400
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:56128
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229846AbhJ1CXK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 22:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5PdhKssIzMQag1JA1vtxklOtVP2tVqdwVg1QMjNE7vYI2nMTwbVfc3+KnU4N1a4sn70wU5Plfp8kOJ2CBAkF1QKcuMt9GuQDmUHDoWLn1A13drN5G0LDX8kfyzrSLRMOyGaUC/YxU5rAtHgmU3JF+QwqNilc5k7OvG9GKiNyXWQjmD6nclJCx6THQvtAHYBeWzrcVy/LFuUW3+mLyZ2dBJD9wb4YF2widzxVx3oan+1HVi9zcIuexhgWiWXx3aCqB/fO6H6055jHElLlm9ytFw4cwSuS+AxgwOiBJMlC/oLMAEG9hA7goeQUTZHnfYfi7mEyBvWJIC8tDFCJ0kkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xUaIaC6L7RMBFqtjlxRP2dqFz262C91JlJppWxJ9cw=;
 b=TPvCdyG1LqJk4+sg6vYesJJ5e4GIIEduND1A3VU6ziWwyUl49U6Utbt9RK4+u+0I4sW7visth20O63oVRSHDfsuNkyJLLzZ4UpGAXng7wbPZecd+2kewfzutGShxxY7xtIVUJGhkpe1G3bZ2upM1lXy6ZhnLStdOvDP80w0Zbj4ljx6As45TcCsNgybWJSCjkSdsMhI278lZbQ84eg+QXvS8FIQj6XiY3BdYo92FJ2/lbZIrbs0ewhgaw2Ie5gXcMciWmA1etGsIB9OtARAhpcxO7sWxyFvqinj7r47NETL9kor92bI+ifdT9TkVID1T93CQXGm8e/bpDH4s0mrYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xUaIaC6L7RMBFqtjlxRP2dqFz262C91JlJppWxJ9cw=;
 b=ZrtVK3uUXY7XEwy5z3oSdPqDuDtzg3ACOwvxPpf8fNLoBZ/qJjRgU9fUGjjjRunfy/g6TWK24PjIe0nkbWhWyE4O0PHxpPqrUfuLTgZsqtL/0HIk3wmkKvL1jxd7nqnF+TC2PDn3pII9XJ1AcgGMqU3KxlTy8J2td2H1FOhl9jg=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB1193.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 28 Oct 2021 02:20:42 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 02:20:42 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogZHJpdmVycy9jeGw6IHN1c3BlY3RlZCBudWxsIHBvaW50ZXIgZGVy?=
 =?gb2312?Q?eference_in_core/bus.c?=
Thread-Topic: drivers/cxl: suspected null pointer dereference in core/bus.c
Thread-Index: AdfLJaDBodqHZTJVQG6Of5lGN9neHwAHk/OAABedi0A=
Date:   Thu, 28 Oct 2021 02:20:42 +0000
Message-ID: <TYCP286MB11882405E880C87E418D4A858A869@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB1188F633AE0B7A52EB6917478A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <20211027150429.ofg4vnwmnkj4aiky@intel.com>
In-Reply-To: <20211027150429.ofg4vnwmnkj4aiky@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f4adeaf-761f-4ea3-80c7-08d999b98af2
x-ms-traffictypediagnostic: TYYP286MB1193:
x-microsoft-antispam-prvs: <TYYP286MB11931DBDBFA927FE4A6294648A869@TYYP286MB1193.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPFqAM/X6TBjYlxtkzC9o2eCN6Vf+YZLuBrVf0KOCLCe945zykbU/cXxPLQwq0/jBlc+uxkKLgfKxILTt856AgOhlaBvsto2PC6mD2ALTkg+3w/ywhBTjAijKlhKjldLwPxiCTb0dIX5qQv7X/N196n5zHBmDPv7iRx//oRl2iLNTbv/Nt5NoHncbku4+1ozMQOQDz1YgLa3IyvdPKuj93fQc8pbZnvOSQhQkuOh5IuYKSMBvzuttWAMfGiVV73bm7W3MPoUpzDo9iNVoY6l6IyucViSzh8ZbvahADcWdOPOKOeyTjWfRRwCHD5QY8rn4mgcHgxppH55lxAuAycD5UdWgSe0eIwpAmedSO3xgWRIW9avaGk2L96o6gHqFmRia6uOYLu6a1ujyKjHxUJ1iPhle0GeVFMpipIoBfnVhpK9tp5XVh3+bxg34L3FA8pAJ1gJ2mgLvWl5tJJjkV4TWKhXA3StrCvGiBreFZaS3Eu1XJSIuQ3Bw+yzaUyh1/MiKIRWPySERquddani0IQIF17hpmBrvCTJMPUnlR2KqAZ+i3Gip0p0wmcbGSZGXzufixl7zz6RJa2Be0GbIAiQVRsiyNS8AbxIcUiiljXLIyXmj/mZ+voLsgcJ5/nQ1TwMU9OjVCT40uLwNZ1Yruvt7RhlykrU6OCX+DSrX/mOzrZHJs26SI7UXJQReWgTNW3G3S46DEO1eESeYRwasN9H3ZXu6h8kIgLdVZf0pZWYgqjqgirvaJMkHep8iBJ3QI9Btn2Nv2tFNO8JRmJ+DxaQYsB5LxtYPE/pfY+vplbK1Ko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(86362001)(71200400001)(5660300002)(53546011)(4326008)(6506007)(8936002)(83380400001)(54906003)(38070700005)(316002)(786003)(508600001)(224303003)(66446008)(66556008)(38100700002)(2906002)(186003)(26005)(52536014)(122000001)(66476007)(64756008)(966005)(45080400002)(55016002)(7696005)(76116006)(9686003)(66946007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3RKWjM4dlNxdmNHY1lrUFAvM244a3Q5Tm9xd2NTVHBJZGltWUZkYnZRcXVw?=
 =?gb2312?B?d1BZN3U0RmtnTGE4ZTZ0RGMxMkVqQjd4YVk2MlMzYUh1dVBZMDNqZ1NPcWdG?=
 =?gb2312?B?TU9QcjBJMm9kbWRuZnNNTURIZUNNREFHeDRsREJBN0ZkSFlITkR0Yk83QjU2?=
 =?gb2312?B?Y2hNWUMydmxxeVhydEJhcEtzbklLMVZadzVGQ3JZN2Z3QWYwZGpaK3dSTXNJ?=
 =?gb2312?B?NVp1TGRGN1QrSnYveXFmWnpoUXNrUm03TURJNVRneExETjQvNG5VaHhjNmF5?=
 =?gb2312?B?S1FxWDBDZHEwc21sb0xwemhMWmdSUlVZdklWdXdJdlAxQkVXRjhmUFdkNXNB?=
 =?gb2312?B?QU9MTG0wOEpaT1V3SjhoK2piWUlKRzQ3SFNuVGVPdFJSRVkvSjdodHhuWkdL?=
 =?gb2312?B?Nld5OVl0RWE2ZmFRaURZblowWHVPaHl6N2JUeU5LZUo2Vm9hS0RHWkpXU3Ns?=
 =?gb2312?B?MVZrTURRc3NTOHp4OVNpRDlUVjJxSGgrSlJBYml4OHZxZGY4TktqblpvMFZq?=
 =?gb2312?B?ZE94R09NdnR3MkxiOTN4YVBuNGViQ2FabzdBcmVyNnQwSWcwQ1lrbU5venpD?=
 =?gb2312?B?NjN6bmlxVnpLMWRWSHBiU2xpaDc3T3RMWmYvSjdBT25RVzU3aDdLbTd2ZzNH?=
 =?gb2312?B?VzYrdHAzWXlIdnVBZFl3azFvMkFkSk02UHFxT0JZVjZ3VTdRMk15MW9zL0FV?=
 =?gb2312?B?UUhLY29BdmJFb2FYTDBORjhHRDFyZFh6emlIaFpsN0g0L242WmJXbjZWcVlM?=
 =?gb2312?B?Y29yL2RQdXRvRFZOU2xLZk9aMExJNU1yQ05CWGpaZ1grdWlZL1FPcSthcTdv?=
 =?gb2312?B?dHIvcGZKcm56ZGlkajhVSHJpZiswTUN6dE9nUFMwdytnSG1UMTUyTGllUXU5?=
 =?gb2312?B?MlVFNUo5bGpIRjBwTHhBN2dRYnd1V1E5bVB4NFVBWWdjeXFxN3BvVWQ1TnhX?=
 =?gb2312?B?NHBjRXdTRlp3T2N0U0o0SmFDNkllUFRTdnFKaTM1MTdKNjJSbWxuRjYrTW9D?=
 =?gb2312?B?d2UzMmFRT0xHVzA3U0swZk03RzVCT2ZDZ2UybjA4SHhLVGlvc3R4eW8xT1ky?=
 =?gb2312?B?NDc2dVB5UUVMZ3VNM25ZbTZnZ0JJbS9HaXVFRHlyN3l2VWIvampzNTY5N3kr?=
 =?gb2312?B?TC9GYmdNbDZnRkxtS2h0TzU3N2VXVHZqMm84NUhGQzNHczJ5T2dnT0xScy9Y?=
 =?gb2312?B?cVU0Zk9JRC9lLzlYNklYdThoQWd3WFU4UTNwbXlPN1gydFdxMnZWTUdjVitE?=
 =?gb2312?B?QVFwTUN3Rlo0MmFTdDc0d0kwOVJpTXhnNVM4ei9QMy9oZEoydUNxMEU5ZUJU?=
 =?gb2312?B?RXMyM0s0QXVHWXJRMXNodytnODVuQmdQU3NXZng5UjVkbjM5V1diSkxyR3FR?=
 =?gb2312?B?TDlGclVEeTFhcGxvRVZ3RmF3SmZFMDlodmZKdmhHSFVFTDlXSC9LMmxqRzFw?=
 =?gb2312?B?RDhnbFZScHJjajVtNUZkSmlrMlkzUERWeUFXL0tPNG9LQ29INmVVSkJaVnpl?=
 =?gb2312?B?RmJzS1ROcW9zd1U5YTJrMXU0UzdGMVJEOGtLbitDa0VnRHlHME8wU21rQzJp?=
 =?gb2312?B?R0IwWkFlTFdHdGRNdnRJcEdobkFzQ2NaQjY4ZCtQNktpV3RHZGtINWZwQ3hq?=
 =?gb2312?B?c0lJOHV4SnV3K2c2VnNRRTlacEl2YWpNUlhJQ0liWWRmbkhvRElzT2dPTzBC?=
 =?gb2312?B?NlhzYTY5UmFKTXJLcHE3aXdzcFR6R0lNeThySEdpKzNKWlduV2t3SUZtdVVS?=
 =?gb2312?B?NVM2V09iTFZJSkN6YW9GRGRXTVVIcmEraVQ3UkZqcnByNkIvbmsrc2ttdi9q?=
 =?gb2312?B?OHNlVU9CSmZkc1J0Mm5LbVVTc3FmbE9DZGFuSHIyWkVNdkk2SGs1RUJaQzBt?=
 =?gb2312?B?NHd3QlhQNWRuM2JOa3VYS0taR0YzU2g1dEd2bFJETFhSY2JEbmVYQlludGl2?=
 =?gb2312?B?ZE04WXdQQWhSQVQ1TlBiS1JrazlwZzZrZlM3NlNYSnZuYlZGa0VvaGRNRDF2?=
 =?gb2312?B?cWVXajhWMnVZQ2w4WGpUUjdWS0RRYUt0TmI3NGlKbVNkNHhnUGVEbWtCRmRi?=
 =?gb2312?B?OENxVXJlMTVnSU1DcjR4ZDNOU2hOVjdUcDFZQzJQK3NMR0pBNzZMUUZ6Zk1z?=
 =?gb2312?B?WUpKNFFFeUNiR0lybGhiUXdrZWp2ZXhKeTQ1S2tLV21GTFN2UWRQellUTTlP?=
 =?gb2312?Q?b9jqUAGyrUBJXwWiC9qaX50=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4adeaf-761f-4ea3-80c7-08d999b98af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 02:20:42.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/aqx4SFQRfzOECXQxHl6xXioOoeP5jaR/w5uE0TO5Bo597tiOHNrHSJE1aVWNDq7El9TcohI9Pb0AR+bco/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1193
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

R290IGl0Lg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpDaGVuZ2Zl
bmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IEJlbiBXaWRhd3NreSA8YmVuLndpZGF3
c2t5QGludGVsLmNvbT4gDQq3osvNyrG85DogMjAyMcTqMTDUwjI3yNUgMjM6MDQNCsrVvP7Iyzog
WUUgQ2hlbmdmZW5nIDxjeWVhYUBjb25uZWN0LnVzdC5oaz4NCrOty806IGFsaXNvbi5zY2hvZmll
bGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5j
b207IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgSm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3Jn
DQrW98ziOiBSZTogZHJpdmVycy9jeGw6IHN1c3BlY3RlZCBudWxsIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgaW4gY29yZS9idXMuYw0KDQpPbiAyMS0xMC0yNyAxMTozNToyNSwgWUUgQ2hlbmdmZW5nIHdy
b3RlOg0KPiBIaSwNCj4gDQo+IGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4gdWIuY29tJTJGdG9ydmFsZHMlMkZs
aW51eCUyRmJsb2IlMkZtYXN0ZXIlMkZkcml2ZXJzJTJGY3hsJTJGY29yZSUyRmJ1cw0KPiAuYyUy
M0w5OCZhbXA7ZGF0YT0wNCU3QzAxJTdDY3llYWElNDBjb25uZWN0LnVzdC5oayU3Qzc3ODQ2OGJh
MDU4NDQzMTNmDQo+IGY3MTA4ZDk5OTViMTlhZCU3QzZjMWQ0MTUyMzlkMDQ0Y2E4OGQ5YjhkNmRk
Y2EwNzA4JTdDMSU3QzAlN0M2Mzc3MDk0MzgNCj4gODIwNDUxNjMzJTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaQ0KPiBMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1UejRIeVhBSDZvdjV3WjdpamhM
QnZhDQo+IEl5RUM5Sm9qRFpNV01TVVk3cEhMZyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gV2Ug
bm90aWNlIHRoYXQgaW4gbXVsdGlwbGUgY2FsbCBzaXRlcywgdGhlIHJldHVybiBwb2ludGVyIG9m
IHRvX2N4bF9kZWNvZGVyIGlzIG5vdCBudWxsLWNoZWNrZWQsIGNvdWxkIGl0IGJlIGEgcG90ZW50
aWFsIG51bGwtcG9pbnRlci1kZXJlZmVyZW5jZSBwcm9ibGVtPw0KPiANCj4gVGhpcyBpcyBkZXRl
Y3RlZCBieSBvdXIgZXhwZXJpbWVudGFsIHN0YXRpYyBhbmFseXNpcyB0b29sLCBpdCBjb3VsZCBi
ZSBmYWxzZSBwb3NpdGl2ZSwgd2UgbWFudWFsbHkgY2hlY2sgYW5kIHJlcG9ydCB0aG9zZSB3ZSB0
aGluayBtYXkgYmUgdHJ1ZSBpc3N1ZXMuIFdvdWxkIHlvdSBsaWtlIHRvIGhhdmUgYSBsb29rIGF0
IHRoZW0/DQo+IA0KPiBUaGFua3Mgc28gbXVjaCwNCj4gQ2hlbmdmZW5nDQoNCmFkZCBsaW51eC1j
eGwuLi4NCg0KSWYgTlVMTCBpcyByZXR1cm5lZCwgaXQncyBhIGRyaXZlciBidWcuIFRoZSBXQVJO
X09OIGFuZCBzdWJzZXF1ZW50IE5VTEwgZGVyZWYgb29wcyBpcyBkZXNpcmFibGUuDQo=
