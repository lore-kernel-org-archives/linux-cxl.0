Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB572C64ED6
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAOwA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCAOv6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 09:51:58 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BD3D92A
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677682316; x=1709218316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T3pg/qcx/1o3DEqVo84Kk/aZVeceJqJLsA5mL608dfM=;
  b=L+e48UyefO28ouSMQCwbbsC3tBmQYieOYzneYNSza5fZnNTQTHGFW+Qc
   ZoLkORqSJUbsZJOpfD2AETbBeVFp6iH3NlfoJwHMxl7Gcek5C904c/v9n
   WARBrgZPIlROuc2ZZ7lasq7bhHaFuqB4SSS7ZSFNCJsRqZWPMuqU31RJ7
   /AXoQFSslQPW8Saq8AP7xIl5l9GwDO3udRbBeyjEBlaOrr3s7MD/P31YH
   sZ9gX63bKwVOijFPac6GqHu78EO1uUpRolb11LR9PtsY+Cbp02vIcAQT0
   AsCGkh2OFY9osQGDqlw9RGZ2kTtUozHFfz+oilo2TG8qBFpaQI4omrJ6P
   A==;
X-IronPort-AV: E=Sophos;i="5.98,225,1673884800"; 
   d="scan'208";a="222820378"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 22:51:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2JdcTO8ShafWRM60u8EgjZjf+cuw5DWxgUOvbzLu+8mW+wczkBURMQm3/HmY4E3Mf0oLkh8gYBBUr1h69Vks6Tc1HHBXPkZ3wOd7aF5CW7oI08gA1g1rKSy9lDSN9kZ3EwfLQYhhvMIfCfGJWfxzEw3rYAZrQnUW59/VTzo+QkeJzk2WcZKDZr7yAAoaxTTgAwWW3PEhetHUqcSfJJ4STaENOlcvh+CLM+wk038WwdVsvXpwHu879FjyZt4yQTaYYF5fgfYqillUrZhmGExIiMXVQzx9xXIY1Hptodk4rhw42a5ulh/qxqWGSF74QRd0WQB0QFIHq85kTA0Mw6x2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3pg/qcx/1o3DEqVo84Kk/aZVeceJqJLsA5mL608dfM=;
 b=Mg/w1E/anKTrxRUmRHAuJao8vTQ2ALU8/4XWcT0yMHzqkkz9JeimjeD3hJhLdolnsqaL5g0X4NeuzKuZn/sLTePPk4hKZUmY8d4vwJVBV3iCb78/E8dsb6/PX5/WzlsoaDi51wX8eF9pgy/ooN/sJ14zCC6zhnwPqiWKmWmJ2UlTay1AzE5407VPnBcMzDcuVqYMXrcBpC6OyvkwcNWwSAGRMfN52shhwDmbQPDUJwtarTG4tz8ZTmkOiD1QM3sspi9HTTJA465S1TLR+Yo3BFC/QgpnnwjjNC97qRUtbR9yCzxlnl4mWGy8lgPmkXkGQ+13k0Cech9JvpeYd8310g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3pg/qcx/1o3DEqVo84Kk/aZVeceJqJLsA5mL608dfM=;
 b=SDpcHxk+ZCPG4/ib1qY/p0UdUknvzHFLIVGcZQeTDC6pxzIqcl4dfRkwWpEyk+jvvNNjpKChPpm2w11quN5C1ihsQW+Cs68+TbK4jREYpzFxo/A6fuH7xzwIhVpvMVZ2KFE1PjAb+7o6OZ3wbHebsIE7uPQPPZmBV2DZI5aRdAk=
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) by DM6PR04MB6843.namprd04.prod.outlook.com
 (2603:10b6:5:245::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 14:51:53 +0000
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9882:834e:7bd4:2c6f]) by SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9882:834e:7bd4:2c6f%7]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 14:51:53 +0000
From:   =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC] CXL: TCG/KVM instruction alignment issue discussion default
Thread-Topic: [RFC] CXL: TCG/KVM instruction alignment issue discussion
 default
Thread-Index: AQHZRgtxeLLIt7yTxEGDfnIKQ5YZqK7iqxIAgAGNcQCAAdYcgA==
Date:   Wed, 1 Mar 2023 14:51:52 +0000
Message-ID: <e199668a-c808-ef35-3e75-7e3d95bdf990@wdc.com>
References: <Y/Cm5nuJl3G2CG2p@memverge.com>
 <b066510e-8420-26ba-019b-fef2b255634e@wdc.com>
 <20230228104916.00003d9a@Huawei.com>
In-Reply-To: <20230228104916.00003d9a@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0401MB3582:EE_|DM6PR04MB6843:EE_
x-ms-office365-filtering-correlation-id: 2601632a-9432-486c-35b3-08db1a647ec9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sH7nl00wZh7YCAfRY6YlIpsrBHC5C4dgmzGlI5SADYNS9SuNQWFiVQ/NK8v2wytj8NgKITO77ZrJGzQkc1hKS3FAzUFr4LpCzwpgHeGZddjnNVeH3+5ZIAQMH3tMHcsxvbCB+4TdIyAD4nJkBsz5tmWw6RKa8240RnpZgrXhVc209RTK0MHMx3Z0p57ZxUs5BJeAC/IKZNSX8TzPHhnbQo7QJdjRWKK9GTD/MDTIt196FWX7WrtLZzQQmX39E+5wWxS0Jm2Dcy+oTbX/D66GZUzDTHD3xfE1un6I0/zDpDFXhRiv9gaIHKxBgXxAXvpYnlH18wrZy+iHsXbCbaznuj/owUvPPIa/JRI7ZBMgZT6xknZBJ+o9ensxNjtwm3zxXGSaWvGW0D3IJAaDRr1sMmeGUF0pMKdcw1KGRe5NaSPZ3p9Ab4qz9jDAT8L3lr4SW2LhJ9ptU8GCRsZTn4lkYPf1XcSKlgels2cRG5MfXG6vuTPpOSIE1wEpu1ESkLDK+AcMHayock4EnsccYiwAfD3i7by4iVqMcDJVArJDDcaAOxl0sFp6qXCirvXVXt3SkTFpX8FdPPPy6fqslH7kuzqKcbuLzuGAEdFurVT6eDXX3jxPMpFeTsUtQDnnp42rXWl7h4T4S7G6bmr9dIXDTUY0g8kgLkXfQZtHSw75pmI2WDd/JPkHcy820lRT3JoPFL1xdMK/hYEhTjMqKbqyd6BgWOZ7o+2Wbk6Km/9ipRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3582.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(82960400001)(122000001)(38100700002)(85202003)(66556008)(38070700005)(8676002)(36756003)(66476007)(86362001)(31696002)(41300700001)(66946007)(2906002)(66446008)(5660300002)(64756008)(6916009)(4326008)(85182001)(8936002)(6512007)(6506007)(2616005)(26005)(53546011)(186003)(83380400001)(76116006)(316002)(91956017)(478600001)(54906003)(71200400001)(6486002)(31686004)(66899018)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1dzM1lhYTZhdDBzRmxuVXlRNlZOdmJ6K2g1MWZtN21mN2tCUDQxQVNKVTZF?=
 =?utf-8?B?cmMveTB4MFhEMTZhWWdmNkJrMXBpSno3TlE4a1FpN1ZHZnNxeFZFZDdGYXQ0?=
 =?utf-8?B?bElFYWM2ZElOK2dhaXJZNnlJTWlnNS9UbmtDUGpzZDgvdkhLVXVQOU8yQjYv?=
 =?utf-8?B?S2QxdWp5L2pvODlURTVFR1gvOHVURHlrbW1RczVkL0E2RUJiV1lSTS96b2RB?=
 =?utf-8?B?NFFra1J5MDUxNW0rS1Erb2RrVTVFKzZ1UEtmRG1pVXo4L2M0K3p3d1FXWmNB?=
 =?utf-8?B?T01MWTJvTHRpRG5mQlFaYW01cWdmSEIvdzZiQTBIYWU0TFhZNHJmMFNVWGNG?=
 =?utf-8?B?ZjA5UDdRdjNDZnJqdlJlMDdpL3l2dDg5S1MxWHpYdXVrUHVoVFY4YkhGbjB3?=
 =?utf-8?B?TktNMzNwYUFwVWY3bmxXTFJhWjJ0WWV2dDMxdjRacUJWODRYNHBKbzlzaXVT?=
 =?utf-8?B?TElKMEthSERpUEh4bExiOGlGMEVxS0NnbW9ESlNLa21wbUVSVHd2dzhRM3No?=
 =?utf-8?B?L0xzT2d4cFZFMDZqQTRxRnhVQm9uemhXRThJcjR6dmZabUowNG0xVTYxaENT?=
 =?utf-8?B?WlNzS2h3NVlTRWZ1OGF2NlpObmpCanNvTDNuVkRoS2NrcmdTQ2U2VE50OHNs?=
 =?utf-8?B?RkJoaWxLZ3F2KzZrVnJ0d1RZdWNqNEVVcVV3cGFIQmFvWFVseDIxWXpDa3hI?=
 =?utf-8?B?bVE1ZUxSTDhXY3JQdERTMlJ3TDdsMWU2azZpNWdUMnBvaXJGeHZKZE5lYjhH?=
 =?utf-8?B?dlZPM0FtRlgzcXJBRlgrTDlJSzVSSE84VFNHQ3FEeG1rekVSQWg2K1JVOHpz?=
 =?utf-8?B?cGJOSnVXbzNLd3FFQzd5eVJDeHkvZkZ2c2J4ZHJzbDNMck5KeVpQV1VPdzE0?=
 =?utf-8?B?ZGxrYWl2V3E0SHVWaTVKMFdZWkl6ckNJNmtWNGhHcnQ1SEJBNGhKdGpxQXdt?=
 =?utf-8?B?b0docFIxWDJEakxoQ01TenVOSXhsUTZjUmttakxHbS9iZy95dDBzbHQ0Y0JL?=
 =?utf-8?B?a0lMK3hMTkkrQzY4SnFVVWpKWElkdjhKSmNpMWNoNXRUSjNXYmtWckxMLzB2?=
 =?utf-8?B?YXRNUmlFRVRYWE1ZMHUwTGk0c2dBcG9EcGRGMTRGby84WWx5TUhldTIxOTFs?=
 =?utf-8?B?dG9FMTJtbWhKbUNJUkkrN1NPV1RyYk5vRGh6dWVPZTBUT3NvTXYwUHd1M3hS?=
 =?utf-8?B?L0Jxai9CSHlmZmpHYXRXaVVnYkx3NVNvUWtrQXV5T2JNZDJDWW5ldnMrQ3p4?=
 =?utf-8?B?SWd2WE5RQU1NZC9IMUd6WXd1Y0lwcVlBdHV6eWVFc1JZMSs1WXFIOEJ1Q3Ft?=
 =?utf-8?B?dnZKbjhGWGxrbVlONlFLN3FKNHpJUEY0K212cXg5L1YrZk03aVpTVDVvWmpj?=
 =?utf-8?B?Ym94Mkw0eGVvTGhPMHIxTy9jMFBWTk1nSmYxVS9Rd0UvNlBDOXo1SGN0ZCtM?=
 =?utf-8?B?c01qcDVVMTh1MG8zWDNrSzV1dkJjRU4zNEt2UG1KaU83c3ZLdGRVVFBsREx6?=
 =?utf-8?B?WkhocHBIdEdVK0xKY25aSkxiTjc4NmMyT0ZsNzBib2NNdndQVWV2US9GdmMv?=
 =?utf-8?B?MmQ3TGZvL3lYMXlodUc2Z2tFZmtHaVNJalJycEFERUV2SGNiYWFSQmN3dWNT?=
 =?utf-8?B?UU5iM3dRQThWaXlzZlZPNm82VzlQU01TMHRXcW45L2hrSFlWc2ZtT296dGVn?=
 =?utf-8?B?ME9DWG04cUwvN1F0VkpXTFAwcFVuUEhqUnZwMlpyS2pOUWR2MXo2WVJjRTd2?=
 =?utf-8?B?YVAwcHRTYVRqcVNMemFKV01HM1dsRXdGdE1CcWZ4ODN1Zk5JbTFvQ0NWQjJ5?=
 =?utf-8?B?NG5JQW5oc25SNm12VWJhRlR5YTA5dklpRVNmZ0lvT3pDRVB3bE5lVncvYmph?=
 =?utf-8?B?REJvVHREU2ZFV3F1UjQ4T3QvUHpVeWgxVlI2YzI5ZkJvdVp1b0VnNDczVkYx?=
 =?utf-8?B?TUNWRDBkNk9lcVA3V25DK0hqQytyandmaFU4SnIyQUpXL3ZYZHMzV0czbjBu?=
 =?utf-8?B?UUFSR3dIdGk0bmJqMVlEK2RsTUI2c0JOc0g4V29md0x0ZnhLRDlKYmNadUVv?=
 =?utf-8?B?cDBicFQ4UGRKNVM2NTlvTEdUWXpwWStjczdLQitLdnRDb05YQkhJdm5TNjc5?=
 =?utf-8?B?OFE0N0ZhY0tsVzZpMWhKbHJMczJCbW4yM1Z0ZjNocHl3bDhwMmFyU2xmaEFo?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C76B52F9C6B2B4CA708EDE240AC8778@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BZ0bKGy8oNUBH4Njm70rfFZ1Ph9SW7C/HuNbQ9pAVv4gG85T9YDVAmuyIbJs78/20hLFMpP4oWwrkOspWMSRw8vgaseZjmjiYGBH7TCSjts1CCqdlVkbkDHN/JlO6lbPC+N+44GjhcSHLwAn5XDU19OnsDYreAJ7VD5WiSNIGizVp8g6tIPSmyMemfXPw0i9jd5BMDcVYgRZGmGQhFLcYehRmel8KDmK1et1oI85/IdU5qYh/D/LQbsVlPpsLGOyjrgLljFoFyZQ04zVogw/gP5XUp7LdrArTJQx2/kocHBosGymrZmChjtz9JYNHzlm5AYt/G4FrawBcgeKJ8iE56UEiUtEr2EfbH+6dauss84B7Oge4iObMotp95LG0VS70X1TuZgyWjK9oXtAGzjkwrDXiP8Rn4CKQu4AY486DIvigRlNbJy5MR6k02jjblQnOpuWhqa0jzwwYhDDlmiYfnIWNYQ/HTSCC6sqqNg8n3hzzlEb2jy+77rW4siawIUIRnnmCph5iCNaE/qJDR+iN4SlqSUxXRYnuK8Wb7gSXzih5Ee838795X7h9MCxsG1IrJt4AsSiCIseP9/qfjFDjS0tBdiyZ5lsZTAPaYDSkaFD02mgQY0jFsu1pB2LNljkB2sIQVgXpIOaxd8INGIAeXC6x1S4k+qB1llac/BOS0tLMC//DhR0k6s3iHpt0cn1jzyTutOhA6f7ssbRJwugUYAN5bPpTvBj+RI9tmIPx7720t4H0jR1BeLiSKVBMASC2imIMLimm+g9dhGsx1icW7GjtdsiDR6basmeoUi3oj9rlew+h30k5kzbQSJEXheGOCY7YFJ00sZoTk2R+YVrl96gJFIVx2IrTLc6GCgeUAOBcSIvmE+jjcAVkU41U21f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3582.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601632a-9432-486c-35b3-08db1a647ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 14:51:52.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+Lt2xatyeUn/5Zf0FV3OS+dMxw0yP07vLqs0pczgUByA7f3M9VkPQlcvBmHfa0cDQamQPAqb0XsPjk8p8u9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6843
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gMi8yOC8yMyAxMTo0OSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+PiBTZWNvbmQgdGhl
cmUncyB0aGUgcGVyZm9ybWFuY2UgaXNzdWU6DQo+Pj4NCj4+PiAwKSBEbyB3ZSBhY3R1YWxseSBj
YXJlIGFib3V0IHBlcmZvcm1hbmNlPyBIb3cgbGlrZWx5IGFyZSB1c2VycyB0bw0KPj4+ICAgICAg
YXR0ZW1wdCB0byBydW4gc29mdHdhcmUgb3V0IG9mIENYTCBtZW1vcnk/DQo+Pj4NCj4+PiAxKSBJ
ZiB3ZSBkbyBjYXJlLCBpcyB0aGVyZSBhIHBvdGVudGlhbCBmb3IgY29udmVydGluZyBDWEwgYXdh
eSBmcm9tIHRoZQ0KPj4+ICAgICAgTU1JTyBkZXNpZ24/ICBUaGUgaXNzdWUgaXMgY29oZXJlbmN5
IGZvciBzaGFyZWQgbWVtb3J5LiBFbXVsYXRpbmcNCj4+PiAgICAgIGNvaGVyZW5jeSBpcyBhKSBo
YXJkLCBhbmQgYikgYSB0b24gb2Ygd29yayBmb3IgbGl0dGxlIGdhaW4uDQo+Pj4NCj4+PiAgICAg
IFByZXNlbnRseSBtYXJraW5nIENYTCBtZW1vcnkgYXMgTU1JTyBiYXNpY2FsbHkgZW5mb3JjZXMg
Y29oZXJlbmN5IGJ5DQo+Pj4gICAgICBwcmV2ZW50aW5nIGNhY2hpbmcsIHRob3VnaCBpdCdzIHVu
Y2xlYXIgaG93IHRoaXMgaXMgZW5mb3JjZWQNCj4+PiAgICAgIGJ5IEtWTSAob3IgaWYgaXQgaXMs
IGkgaGF2ZSB0byBpbWFnaW5lIGl0IGlzKS4NCj4+DQo+PiBIYXZpbmcgdGhlIG9wdGlvbiBvZiBk
b2luZyBkZXZpY2Ugc3BlY2lmaWMgcHJvY2Vzc2luZyBvZiBhY2Nlc3NlcyB0byBhDQo+PiBDWEwg
dHlwZSAzIGRldmljZSAodGhhdCB0aGUgTU1JTyBiYXNlZCBhY2Nlc3MgYWxsb3dzKSBpcyB1c2Vm
dWwgZm9yDQo+PiBleHBlcmltZW50YXRpb24gd2l0aCBkZXZpY2UgZnVuY3Rpb25hbGl0eSwgc28g
SSB3b3VsZCBiZSBzYWQgdG8gc2VlIHRoYXQNCj4+IG9wdGlvbiBnbyBhd2F5LiBFbXVsYXRpbmcg
Y2FjaGUgbGluZSBhY2Nlc3MgdG8gYSB0eXBlIDMgZGV2aWNlIHdvdWxkIGJlDQo+PiBpbnRlcmVz
dGluZywgYW5kIGNvdWxkIHBvdGVudGlhbGx5IGJlIGltcGxlbWVudGVkIGluIGEgd2F5IHRoYXQg
d291bGQNCj4+IGFsbG93IGNhY2hpbmcgb2YgZGV2aWNlIG1lbW9yeSBpbiBhIHNoYWRvdyBwYWdl
IGluIFJBTSwgYnV0IHRoYXQgaXQgYQ0KPj4gcmF0aGVyIGxhcmdlIHByb2plY3QuDQo+IA0KPiBB
YnNvbHV0ZWx5IGFncmVlLiAgQ2FuIHNrZXRjaCBhIHNvbHV0aW9uIHRoYXQgaXMgZW50aXJlbHkg
aW4gUUVNVSBhbmQNCj4gd29ya3Mgd2l0aCBLVk0gb24gYSB3aGl0ZSBib2FyZCwgYnV0IGl0IGRv
ZXNuJ3QgZmVlbCBsaWtlIGEgc21hbGwgam9iDQo+IHRvIGFjdHVhbGx5IGltcGxlbWVudCBpdCBh
bmQgSSdtIHN1cmUgdGhlcmUgYXJlIG5hc3R5IGNvcm5lcnMNCj4gKHBlcnNpc3RlbmN5IGlzIGdv
aW5nIHRvIGJlIHRyaWNreSkNCj4gDQo+IElmIGFueW9uZSBzZWVzIHRoaXMgYXMgYSAnZnVuIGNo
YWxsZW5nZScgYW5kIHdhbnRzIHRvIHRha2UgaXQgb24gdGhvdWdoDQo+IHRoYXQgd291bGQgYmUg
Z3JlYXQhDQoNCkknZCBiZSBpbnRlcmVzdGVkIGluIGdldHRpbmcgbW9yZSBkZXRhaWxzIG9uIHlv
dXIgdGhvdWdodHMgb24gdGhpcyBhbmQgDQpwb3RlbnRpYWxseSB3b3JrIG9uIGl0LiBXZSdkIGxp
a2UgdG8gZ2V0IGNsb3NlciB0byB0aGUgQ1hMLm1lbSB0cmFmZmljIA0KdGhhdCBhIHBoeXNpY2Fs
IHN5c3RlbSB3b3VsZCBzZWUsIGlkZWFsbHkgc2VlaW5nIHJlYWQgcmVxdWVzdHMgb25seSBvbiAN
CkxMQyBjYWNoZSBtaXNzZXMgLSBhbHRob3VnaCB0aGF0IHNlZW1zIGhhcmQgdG8gYWNoaWV2ZS4N
Cg0KVGhhbmtzLA0KSm9yZ2Vu
