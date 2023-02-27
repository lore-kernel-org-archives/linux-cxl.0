Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A39C64ED8
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 11:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB0LGx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjB0LGw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 06:06:52 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E21199DC
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677496010; x=1709032010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hL6KJgdO0oDmfzo+YYY8G5AzvFw3+HkHCdJD0ubrRyM=;
  b=KF41RszIG29s+italhs5Rv3iye/Zzf7wYLoFD7v4EPYLYQYDiZXYmC7c
   /kO021B5wTe9ojY7ovrzPVQ1CUzlYvgv4zCFRUZiuycyu7yWNMg6rXxdH
   1J8Du7lb82jhk3wKXGCvIy82YkzFFkNEdJC6mhXwEyXuKsupxH7NnVtq1
   JYgIO2G4dTjEbKB5ER4Klh0jT3ctODhaQfALFAQ+qrU1M2tyDnfvkILPu
   EtPEg1JK1PkxaEaiDtGi8RBPQrcxRvY1ZYKrbTKFlqrxFbqsp7bPkyWZ1
   U6ZwTCRNcU4eW9e2jlIJEYLdfEO6seCVifMZ4cj8+FyStKBl61OoTU6SI
   w==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669046400"; 
   d="scan'208";a="328628669"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 19:06:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXtTBnecq725lz/jNWu9SQ5cglzSqX1J00vDkPSD9WXjVvFi1IHQcqjKGDLL2RNcMIYhDLuRNoazQWCbcgCjXm8j87hRV+FvPgInml/izKz8YmjlybBcD0iOE88OBWMqmPzqLi8Eq+CSv5QSg40gC0iFMtXRsqsPynRE9wcjEkT40TwTFWgzc+ccCjfan+1Zhq6RHp446bgd/tqalF/YeIDNJfmaEgkyMp4dygqZfSy6j+w2tZ0VAF7pInYp2WDq2Udu0vvKVf7UjmfZQPFzwBebwzyB1A4c2ZxLyS1K3HWpDAWA7iP0aXySElx9YJ9Mrt7ZWRxMs1hPFq1T2kMEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL6KJgdO0oDmfzo+YYY8G5AzvFw3+HkHCdJD0ubrRyM=;
 b=Xk2rEah6LSIAndGfde+bIz4RYo3sIGFDATHrAkSgtO8cdN0p0xCJx0EDWwi4s2YP16RKKKF2i26wOq3L/HLtZC5MAeBXnsHN2MN2iejmOcKAc4lprlhcR0k28Vfv6xvnk4jQXgoT2iRg2qXFCyTI2w+ByrZRDbM98ROqOPrt0XpDX4bW1iADiybk8K1zMHZhMzjf/RnDYKE15kSjqD8+Sq3V18GBuIz1TAeg4qRoPP3zAmk1FjtCIhcKr1XXNbrhhBdOz5QCHuAftBquxx4tO/jyhqmTOpdI53mhDrFKYL9fgxSuWqHvO2tP37JU0Zo9pJc88kGrO9aL7Cqa3a+GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL6KJgdO0oDmfzo+YYY8G5AzvFw3+HkHCdJD0ubrRyM=;
 b=dp2FgSEaz6vB0xj25QDt1d5oigywfufwNQP9wMc04hbF3bZaP58/sIHmg2OUxkUzh2S6Vxvu1wWrgYAnyfpe9kkfaCPPyqPhCVc/oYNeEjS3s1ozgWfrPv9eLSyCFCJHC/OdCFN9ZCFgMY/QyffocdU2ob05hGUjKyjaWhMRM8M=
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) by BL0PR04MB4466.namprd04.prod.outlook.com
 (2603:10b6:208:4f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 11:06:47 +0000
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9882:834e:7bd4:2c6f]) by SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9882:834e:7bd4:2c6f%6]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 11:06:47 +0000
From:   =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To:     Gregory Price <gregory.price@memverge.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC] CXL: TCG/KVM instruction alignment issue discussion default
Thread-Topic: [RFC] CXL: TCG/KVM instruction alignment issue discussion
 default
Thread-Index: AQHZRgtxeLLIt7yTxEGDfnIKQ5YZqK7iqxIA
Date:   Mon, 27 Feb 2023 11:06:47 +0000
Message-ID: <b066510e-8420-26ba-019b-fef2b255634e@wdc.com>
References: <Y/Cm5nuJl3G2CG2p@memverge.com>
In-Reply-To: <Y/Cm5nuJl3G2CG2p@memverge.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0401MB3582:EE_|BL0PR04MB4466:EE_
x-ms-office365-filtering-correlation-id: 275f893c-579f-498d-dbae-08db18b2b7fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjVfdRjWZ6pwNtY4/LaPgRTWZAFl0E23vtmxdJM49gE/fartDZ27FiIGnEnQJS1wn7dnlotsMvqUVTKkcEoXOF2NfyVJvUgSRJ28nL+DpS3FUEXhR/MdcHriLy+/C7KcxzMuaqQ3R57MOl9HCIPYbV34Fd5zZMYWce3U7bXy2xHNXqlovdw930ieGWF3x/KkToCVyS7yXUn+7iosTZBPBAoRcwbgdChTkAh60vmPXYutc/bKEfyBcJyahsWp6ScAGFu/FQnXtSBaoCb+yaIyZVDWlLUZK6du50EZ2SUup3Q1rcSCaPeJJFcF3Z9mJp5xCgONhauBb1iT0CZ4cF/pFWQkFaz7StVanFU/wp0/kvH2X66Hrbi2GVDcmmLmxW1RgT/U3bl53bFSChcmfxIyl6ikFOm4kVEJp/SyRjTl3b0vjVVYTkhCICv5dnaTZAqzWHyV094tVeBVlWRixBCJJjg0jZii0fm6Th8xl/MXEK2SZgkxX6KcjHOVnhNTp7q+xv8AGHD5AkT4ho8h68BDtXthZwFICwJtK9w9uSLaLjS5a2LtYDiVEr2+iN8rxVc7KSgoeNhUzPNbIA8KOWkLDypAD+b6C5PxwQgmBQvxG7Pi9ETaMVhF/LSKCU+WwZlSTky37C1gjHSuwykcFn2n5ytaPfBjCdJMcAvKGi2+a4oGb/r+W2XJ+zLT1Zfl83mAR8rD0COICKPGUL/1aWYYn2O+hQiUI/SbuVYpB9H9iKQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3582.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(36756003)(85182001)(8936002)(85202003)(5660300002)(6506007)(53546011)(6512007)(38100700002)(122000001)(83380400001)(26005)(186003)(2616005)(82960400001)(31696002)(86362001)(316002)(110136005)(41300700001)(91956017)(66946007)(76116006)(64756008)(66446008)(66556008)(8676002)(71200400001)(4326008)(478600001)(6486002)(38070700005)(66476007)(31686004)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ZWWmFVTEpRazErOC82ZnBmQXFnSGovNUlxaXV4dlRIT2U0QzNxWmxFVmU1?=
 =?utf-8?B?VjhxQmtja2ZGNjdjd25ZWjBlU01Sak15QlFMR1JVRjA0UTB2VVMwRFJZRy9l?=
 =?utf-8?B?N1NZa1FwY294TUhmUVk0YWVXM0phcEE1M1o2ZXJ3RElIakh4QVlIT2xLcUFK?=
 =?utf-8?B?OGJxeDFmS0Q4eDl4emZzWVJvK3NiUUZlV2xqRTVmOG5MMHNuaDdoTExDOXEy?=
 =?utf-8?B?MWV5dHhNYTgzSzRucnJHTkVFSWx4dGxkUWxQZ2hzYnNZemQ3SzIwZm8vMm5w?=
 =?utf-8?B?NTVnVlRPZFo5ZGYyYjVUTFdHRlZkWVAzU0ZPeWJhRTN6aEUxMzJQcXltZmh5?=
 =?utf-8?B?ODBuV0FoQlArR1lkcDNzQWdJUWZjb3BtN0lrTUY0THcvdlpZYXozYnloVUtR?=
 =?utf-8?B?MThQdnFjeWtqczRqZE5KNVk1UTdIbFhpRERDcHdMQmxKbkM5NmRZeGlmdGNk?=
 =?utf-8?B?aDB2UWNDanB3aFg1QlpWZkllMkJleUZCYVd6SUpnbGhTTUdvMCtmaExGTEM2?=
 =?utf-8?B?YllQYWY3Z3M5WHRORHk0ckVOWGhRNEJkQm53VWpKTWNod2dxaEV2SmdZREJ5?=
 =?utf-8?B?SzNLNjNtZ3BUS2Z3UlYyTGVDWmt5RnI4Nnd4b3A0bXhTcVBsczRCT2M0cmhy?=
 =?utf-8?B?clNib2kzYk5QLzFYY0cvdWcwSnFlbjVBcmtEZWZ6V1VGSmNYTVJYMFpYSlQ3?=
 =?utf-8?B?eURnM0tDN3pTaUQ0UHNONjF1UEd6M3MvcG5xczhvTHlCREI5azRDdURqYXlM?=
 =?utf-8?B?aFh4UXhWd0lKUGJkUE5oUS9BOWRmS2xlblJmMXJ3SjdKaGxyblFITFhEdW9B?=
 =?utf-8?B?ZTF5Tkc4ZEJadVJZTUE2SHJZMlR2MElBK1lqcXlERVI0aUdMUi9LcUgwamNV?=
 =?utf-8?B?OHlVbU5hZ3ZpalZDMDhLenFLWnBLa1o4NnQ2ajNCcVVLNFoxbXRzRlhtMUhv?=
 =?utf-8?B?OUlXRmJ3UWhaT3FETGJZQkxCdnhTQmp6dytEZm4rdHlqalFaVTBReFo5RlZY?=
 =?utf-8?B?czNESFlHNWU3VDBhLzhjcEpWSHR0eGpZMUs1bVhpZ2prNi9XMGZ0Q0dXc1RR?=
 =?utf-8?B?bk4wejlvdlNGeEpGSnRONXU0ZFpuSDJucm94YnYzL0RxWDNhNUE0QUs4djRF?=
 =?utf-8?B?aGZNbDNIK0xWY1VDVjBNMUd0MW5tczZEYXI5NmJaNXJQZ0FBRGYxOVZndmpJ?=
 =?utf-8?B?WGtaSnlOMW4zTDFpbnRWOEFCNk8rSjgwTTVUb3NKTFEvdjFRbllFbWNMWWxV?=
 =?utf-8?B?TjBseUZUd1piZHZTYjNEdmdOemd5OFo1RGwybGttUUVGb1ZyVzg4bGtrakVi?=
 =?utf-8?B?Mjh2SlNQNmFTenVtV1ZtR1NTV29rOU9PNkJDcU1WNUhsb0pEWlhGNlM0Mm5j?=
 =?utf-8?B?UjloR2RIOTBjNTVZNWU2OWYxN3hON0F6K21NS0VwRndyeGJUcnpQcGE3aUth?=
 =?utf-8?B?dmJ1OXkzc0lRUXB4emN2THd1Rkx0ckxzNGxDU0FzaW9ORjRKRFp2UXN2TmpD?=
 =?utf-8?B?dXYzNUFMMjFFaVZxSW1yTUlic3JSTldxSGRaVHJEUzc5MW82TFlyRGdZdldT?=
 =?utf-8?B?cDlLT2EyUzBNQldlek9kU0psL1lCUElyU1pOYXZjY2RhVzQ2ZVNJblU0dUN1?=
 =?utf-8?B?dUt4V2RZOVBlMHZ2Q21KVGJTWDVjNU1kbWxxSGVCaUZNWVhzeHNRRUwrcGVT?=
 =?utf-8?B?SzRBNzJ5clEwMk5nSzlaZ0ozZmYyTG82aVNvY2NmSDNzOEJxR3l5a3N2SU1P?=
 =?utf-8?B?MWtPaXZQa3F2Zktra1BFNTJJWmlEdThXYWFwOVMwNE5kdlB6NTNCNUxqREpC?=
 =?utf-8?B?UjJtcE5JVGZTWWYxd1gyWFhqclpQRHRZaVZmUUdSQVJkN0dvTTFQdWRBbTQw?=
 =?utf-8?B?L1ZlUVh0VzBVa2hud1VsanJzTnJKRVlnWGFqZW43YnBUNHZIdWFzM1NCSEpR?=
 =?utf-8?B?dDZFZyt5ZVNhRVlEc0N5c1BFaUZNVzZIMVcyeXo0cWdxZzNud0t1bG9YN3gx?=
 =?utf-8?B?ZG9oVGN0VGFSdHdnQkdPR21RbXhySlp4Wmp3b0gwL3EyT3F6d0p6UGNZL2hW?=
 =?utf-8?B?dU9Pb2E4VCtRc2M1Vi8vS0syanJXa3lNQzlXa2xCbkpYODFlUDJBVXdSUW1R?=
 =?utf-8?B?aDZqZFIzOEEyclFmY0NLdmtYNys3RDF2NFhudytVVHpqbHloZ2VRakhiRGRJ?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE23ECC6F7243E4DB0CB084CD1EB911E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2/N7y6mm/VaE5ARcWpT9q10c93JzYRl5Sc3oLO6H+zmNDMoij6PpLf4iUkP/AoGt4OgHNJqMfB49McwGwdrxuMNs1+wEM03NnZqnUDTtesWBUOb0JyR8aROmm/c5Wib5nBTz3uwFqQ+YkJQ/WRZAApo89W9wCnDAAmJJHllNIGJ8Xl3xDXPxzrAbfa8MqDk7G3lNJXvP/qF0DuUhfuAg4XK4b8FwiO03kFGeeBget+MdYsBthP/4f8AHvjI1C1gqSP5QS1LvM4vxes0Bcm3vKiRCrA+jLvY3/wdKxsb8MUKk5US96lw5X+Q3I7Mt3ybZ8KwYFMe8ualNoT+3KXJBC927D3Ex0iZ+xze2bu/uDiSqwWUL4YUfjA3INXFN+A2tSBZ94TEpBy5Iz47ju5OMTStFRjhmpeJseA62229mShZzfUiCF0550fnnBk0smdfEB5Ayp74cWN3EvfXL9XRnbYUmV9zR9vly+pvQ89cilnWYVWY29XC3S8KH1bes4GGA75xPZiBbYXf8ef7wVO+qifp4FX4Mzu5e6XKmL1lCozRC+p5aT5lN1YUbkPqPwvxSb0g/+a/lVaQ0VLi7RY/XhA/GqpV2A5fkVP3iQwmpt/S09cYmgZx1PR43wdbsm3FryCWSp9H9/WAwPPvsdQeaRS4fs553ptE2d9sAN5bxDmwwvxkWxTnvEH9UrX61FLKKvkWp4fp1dYcbFuJaFXB8WM4C/qFCdu5CGho+NzO+0ve5NFJlO8R2UmgOcNCQ0WxCCB1J9hNpduvb1uqwr2l9z8dQ3e1fQ8ZoyMubRPHevQ6sDCFI9vHG8ixk6uvo1h1/DcX6WDOqiirWAYRLoopSXjggDIWridGwPj2652e+bxK1cTelqc51wr34/SW7b1A2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3582.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f893c-579f-498d-dbae-08db18b2b7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 11:06:47.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZS092V8ToE5ZhP4hbyd6gblhMFBVaPeQPPw4suhSHeqAJDN4Ee8kiKDZoeykuduRnfPUFpSm4TLw4zGGPJdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4466
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gMi8xOC8yMyAxMToyMiwgR3JlZ29yeSBQcmljZSB3cm90ZToNCj4gQnJlYWtpbmcgdGhpcyBv
ZmYgaW50byBhIHNlcGFyYXRlIHRocmVhZCBmb3IgYXJjaGl2YWwgc2FrZS4NCj4gDQo+IFRoZXJl
J3MgYSBidWcgd2l0aCBoYW5kbGluZyBleGVjdXRpb24gb2YgaW5zdHJ1Y3Rpb25zIGhlbGQgaW4g
Q1hMDQo+IG1lbW9yeSAtIHNwZWNpZmljYWxseSB3aGVuIGFuIGluc3RydWN0aW9uIGNyb3NzZXMg
YSBwYWdlIGJvdW5kYXJ5Lg0KPiANCj4gVGhlIHJlc3VsdCBvZiB0aGlzIGlzIHRoYXQgdHlwZS0z
IGRldmljZXMgY2Fubm90IHVzZSBLVk0gYXQgYWxsIGF0IHRoZQ0KPiBtb21lbnQsIGFuZCByZXF1
aXJlIHRoZSBhdHRhY2hlZCBwYXRjaCB0byBydW4gaW4gVENHLW9ubHkgbW9kZS4NCj4gDQo+IA0K
PiBDWEwgbWVtb3J5IGRldmljZXMgYXJlIHByZXNlbnRseSBlbXVsYXRlZCBhcyBNTUlPLCBhbmQg
TU1JTyBoYXMgbm8NCj4gY29oZXJlbmN5IGd1YXJhbnRlZXMsIHNvIFRDRyBkb2Vzbid0IGNhY2hl
IHRoZSByZXN1bHRzIG9mIHRyYW5zbGF0aW5nDQo+IGFuIGluc3RydWN0aW9uLCBtZWFuaW5nIGV4
ZWN1dGlvbiBpcyBpbmNyZWRpYmx5IHNsb3cgKG9yZGVycyBvZg0KPiBtYWduaXR1ZGUgc2xvd2Vy
IHRoYW4gS1ZNKS4NCj4gDQo+IA0KPiBSZXF1ZXN0IGZvciBjb21tZW50czoNCj4gDQo+IA0KPiBG
aXJzdCB0aGVyZSdzIHRoZSBzdGFiaWxpdHkgaXNzdWU6DQo+IA0KPiAwKSBUQ0cgY2Fubm90IGhh
bmRsZSBpbnN0cnVjdGlvbnMgYWNyb3NzIGEgcGFnZSBib3VuZGFyeSBzcGFubmluZyByYW0gYW5k
DQo+ICAgICBNTUlPLiBTZWUgYXR0YWNoZWQgcGF0Y2ggZm9yIGhvdGZpeC4gIFRoaXMgYmFzaWNh
bGx5IHNvbHZlcyB0aGUgcGFnZQ0KPiAgICAgYm91bmRhcnkgaXNzdWUgYnkgcmV2ZXJ0aW5nIHRo
ZSBlbnRpcmUgYmxvY2sgdG8gTU1JTy1tb2RlIGlmIHRoZQ0KPiAgICAgcHJvYmxlbSBpcyBkZXRl
Y3RlZC4NCj4gDQo+IDEpIEtWTSBuZWVkcyB0byBiZSBpbnZlc3RpZ2F0ZWQuICBJdCdzIGxpa2Vs
eSB0aGUgc2FtZS9zaW1pbGFyIGlzc3VlLA0KPiAgICAgYnV0IGl0J3Mgbm90IGNvbmZpcm1lZC4N
Cg0KSSByYW4gaW50byBhbiBpc3N1ZSB3aXRoIEtWTSBhcyB3ZWxsLiBIb3dldmVyLCBpdCB3YXNu
J3QgYSBwYWdlIGJvdW5kYXJ5IA0Kc3Bhbm5pbmcgaXNzdWUsIHNpbmNlIEkgY291bGQgaGl0IGl0
IHdoZW4gdXNpbmcgcHVyZSBDWEwgYmFja2VkIG1lbW9yeSANCmZvciBhIGdpdmVuIGFwcGxpY2F0
aW9uLiBJdCB0dXJuZWQgb3V0IHRoYXQgKGF0IGxlYXN0KSBjZXJ0YWluIEFWWCANCmluc3RydWN0
aW9ucyBkaWRuJ3QgaGFuZGxlIGV4ZWN1dGlvbiBmcm9tIE1NSU8gd2hlbiB1c2luZyBxZW11LiBU
aGlzIA0KZ2VuZXJhdGVkIGFuIGlsbGVnYWwgaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIGZvciB0aGUg
YXBwbGljYXRpb24uIEF0IHRoYXQgDQpwb2ludCwgSSBzd2l0Y2hlZCB0byB0Y2csIHNvIEkgZGlk
bid0IGludmVzdGlnYXRlIGlmIHJ1bm5pbmcgYSBub24tQVZYIA0Kc3lzdGVtIHdvdWxkIHdvcmsg
d2l0aCBLVk0uDQoNCj4gU2Vjb25kIHRoZXJlJ3MgdGhlIHBlcmZvcm1hbmNlIGlzc3VlOg0KPiAN
Cj4gMCkgRG8gd2UgYWN0dWFsbHkgY2FyZSBhYm91dCBwZXJmb3JtYW5jZT8gSG93IGxpa2VseSBh
cmUgdXNlcnMgdG8NCj4gICAgIGF0dGVtcHQgdG8gcnVuIHNvZnR3YXJlIG91dCBvZiBDWEwgbWVt
b3J5Pw0KPiANCj4gMSkgSWYgd2UgZG8gY2FyZSwgaXMgdGhlcmUgYSBwb3RlbnRpYWwgZm9yIGNv
bnZlcnRpbmcgQ1hMIGF3YXkgZnJvbSB0aGUNCj4gICAgIE1NSU8gZGVzaWduPyAgVGhlIGlzc3Vl
IGlzIGNvaGVyZW5jeSBmb3Igc2hhcmVkIG1lbW9yeS4gRW11bGF0aW5nDQo+ICAgICBjb2hlcmVu
Y3kgaXMgYSkgaGFyZCwgYW5kIGIpIGEgdG9uIG9mIHdvcmsgZm9yIGxpdHRsZSBnYWluLg0KPiAN
Cj4gICAgIFByZXNlbnRseSBtYXJraW5nIENYTCBtZW1vcnkgYXMgTU1JTyBiYXNpY2FsbHkgZW5m
b3JjZXMgY29oZXJlbmN5IGJ5DQo+ICAgICBwcmV2ZW50aW5nIGNhY2hpbmcsIHRob3VnaCBpdCdz
IHVuY2xlYXIgaG93IHRoaXMgaXMgZW5mb3JjZWQNCj4gICAgIGJ5IEtWTSAob3IgaWYgaXQgaXMs
IGkgaGF2ZSB0byBpbWFnaW5lIGl0IGlzKS4gDQoNCkhhdmluZyB0aGUgb3B0aW9uIG9mIGRvaW5n
IGRldmljZSBzcGVjaWZpYyBwcm9jZXNzaW5nIG9mIGFjY2Vzc2VzIHRvIGEgDQpDWEwgdHlwZSAz
IGRldmljZSAodGhhdCB0aGUgTU1JTyBiYXNlZCBhY2Nlc3MgYWxsb3dzKSBpcyB1c2VmdWwgZm9y
IA0KZXhwZXJpbWVudGF0aW9uIHdpdGggZGV2aWNlIGZ1bmN0aW9uYWxpdHksIHNvIEkgd291bGQg
YmUgc2FkIHRvIHNlZSB0aGF0IA0Kb3B0aW9uIGdvIGF3YXkuIEVtdWxhdGluZyBjYWNoZSBsaW5l
IGFjY2VzcyB0byBhIHR5cGUgMyBkZXZpY2Ugd291bGQgYmUgDQppbnRlcmVzdGluZywgYW5kIGNv
dWxkIHBvdGVudGlhbGx5IGJlIGltcGxlbWVudGVkIGluIGEgd2F5IHRoYXQgd291bGQgDQphbGxv
dyBjYWNoaW5nIG9mIGRldmljZSBtZW1vcnkgaW4gYSBzaGFkb3cgcGFnZSBpbiBSQU0sIGJ1dCB0
aGF0IGl0IGEgDQpyYXRoZXIgbGFyZ2UgcHJvamVjdC4NCg0KPiBJdCBtaWdodCBiZSBuaWNlIHRv
IHNvbHZlIHRoaXMgZm9yIG5vbi1zaGFyZWQgbWVtb3J5IHJlZ2lvbnMsIGJ1dA0KPiB0ZXN0aW5n
IGZ1bmN0aW9uYWxpdHkgPj4+IHBlcmZvcm1hbmNlIGF0IHRoaXMgcG9pbnQgc28gaXQgbWlnaHQg
bm90DQo+IHdvcnRoIHRoZSBpbnZlc3RtZW50Lg0KDQpUaGFua3MsDQpKb3JnZW4NCg==
