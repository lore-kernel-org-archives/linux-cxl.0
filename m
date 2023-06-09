Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D156C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jun 2023 01:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjFIBCb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFIBC3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 21:02:29 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8630DA
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 18:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686272548; x=1717808548;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=e45NKuncGGQ1jNDvdA3+QNk//EIPqbxrEDnYWKpXidY=;
  b=QAcMRMdProOGOX9RIB4XAQp9p9tinCI/0ptqsMKsmci9nd8thkjMqBkQ
   hHPGtLAo9M6ICpO5GGy9Sc8SvuLKjEhGUC8bC0EfuUFlwkW2FAm5H3dW1
   lSULIZFQoEj55gPXGAFYowK15s6VKexVxQks9Pldn4Stnge7Godl73521
   KPTSy7PTMfZJZHJgrp91o3FOvQ6s8bZ51X0bp1P6QGvS9+cBFfHzpsV32
   1GfhpH8/txkz05noQdXM1ePf3icay49qzwpKEEZA9YdgHbgKp8apRLtPB
   kidJWTBCztCyLJpppm5bTTP6WiuRqio18OKyrEQtTsEdzNEq1SI9w8sII
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="86584759"
X-IronPort-AV: E=Sophos;i="6.00,228,1681138800"; 
   d="scan'208";a="86584759"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:02:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY8EZqix2sf1Ff2o3xI1dRyArZ0cCQiQttlu0wPVFuToF8Dupg62CZbRAK9PUPHwLYWqpVhbjgy/SWrKzV9/42DmENfSA9IeTdYu/EF/CAY7Hz7DVTpNokrjqxQxvaUarZK68kTNssIGYpYhHFrDNB4rYj0M032GQtD0TIA5uTpQx/tGzWei/15cGodriaxCpucr8KsFNQXT+b6lsfTT4H6wqOagreX69xGZ8hIYPxIPYPHKlGOxx8voUAe6gHY6PxEAkm4IMq5/69SMbrr9uE2+L1VcriveyzH2tscqC1ZKi2UsKW/WMsnXnc5Qc0suzVvUnt6dbNkDQcy/EApLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ifOTLTu9iorQMSTx6vibAHClgj5qHNjEtKOV9UfHSg=;
 b=FGPo5dZq9k5Owtk8eFkfWnW6DkZRM72MvFpm/IaKpSqD/iXJGkegwg5aGi9Tnq9aegJLk78DcJEmmV7fLYjGBQtqClE4QTwWqRbPXvK0V0AM41EtHjzlJ2QFJT5bHnPyTML4Qsz+CVDP5VqycBtc5AgrKlcmynvxTn1G6LZhwwYWIO3aJsecfz4lEnBo/xYAshQhqBLF4oj72GYhPmk7j9ILEkmZ9UCVfi7oHvehV6uMG8I/P/++8T3DbdE+E/GPbMr6sWKA7cYiuRJdy+nCAwC7BqUsaZkGocNsKTNUCYZsuj30GgsxgSwkzo+uvglWHqzzlJ6/0sb/ZmWst45Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYCPR01MB8818.jpnprd01.prod.outlook.com (2603:1096:400:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 01:02:21 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%3]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 01:02:21 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngAAINJ+AAAQwYfgAEURk5AAOy5fAACGuOZgAakjsIAAHOczMABJBe2AAAzMGzA=
Date:   Fri, 9 Jun 2023 01:02:21 +0000
Message-ID: <TYWPR01MB1008297489868FEE5D0D9CEDF9051A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <647f73cf40c29_142af82942f@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082CE5542BCFCEF127CDD399050A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <64821fd31d563_1433ac294a3@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64821fd31d563_1433ac294a3@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-09T00:43:32Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=309528e1-8636-4559-88dd-d031d60ee3a5;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: a432ac6dce7741889933c0c0ad43f887
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYCPR01MB8818:EE_
x-ms-office365-filtering-correlation-id: 7f1a9b8a-c177-4a3a-5057-08db68852e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MG+cPJhBeyp0iy4V113xNBUJTSkLhqn9AAHniGVOkZujW2NBfYE83Yi882U2MpifxLzpuNU5G6npnU5hjzS+6TvBfa5IxVMYsQqaKxXA7OGJsJeMCp/1lqGtJxDxeg+lMkj2aipKUqqTU9SevdDU8XASLWAC21iF42SImrFEedktHfh9eT8NxRmmXOlls202+c4nQxcWy2eJKv+K/PFSqLOIYBTicPn8tNDbNHINIyUBrp04jpFotuHX8rHDPUHD1gO4nWSXUHIncFPInwpWMyGQqQSWaeluXkXMSgKgapUOY2sazpGrUV0Ft7T1lHG9yapUVkE7b5zLhGgJDNbTAE9IN6OTQ00VcQbn7Ea3/XRPzN2zWz4shpaJl4ilWVcl6kDQs1GtZkIKWi0hSWqgQdeaLmYSjP/uBTa9IV8ZHtuAWRLPUninwjX4As/Mug+pl7+r9sug0+FoH5L4NBHqHlBxEp1e5abP3UbzLF2O04ZXMp5ePhW/uJArbm+KQ6exR2rLDSiNovvPI1LU2lmIEYCjncAylnvSM6fOKslJwy2cI89Ym/68K6TeaOmLxehJmkMlcEH3lAnWcPjlLOr1zDt0s3pDGxR7lD43nj/tHay71r5q6gzGlXWSQQlGZ9vkXpF+n0b1s+quE5vrJKhagw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(1590799018)(451199021)(110136005)(478600001)(41300700001)(71200400001)(7696005)(316002)(5660300002)(52536014)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(8936002)(8676002)(1580799015)(26005)(6506007)(9686003)(186003)(2906002)(55016003)(122000001)(82960400001)(83380400001)(85182001)(86362001)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?LzdWYjJmT1NSeFV3RVJ2T3pvLys1U3dqVitYMDNjRWIzMVNWRGdKZWlE?=
 =?iso-2022-jp?B?L0lXdTllOFo0Y2lRZnQxUmdJSW1IaVJGVlE3SXJiN3p6ZDd0akEvUjF6?=
 =?iso-2022-jp?B?ejVXYWptcVpYMUJtaEJVL3JSR2NyTFFlbWVkMDkxajYwVGs0KzhlM093?=
 =?iso-2022-jp?B?YVY5UTQwU2YxaGc2YTIwaGZ0K3NnckYxNGRFM1cwT29jWlVUZXRYRTQv?=
 =?iso-2022-jp?B?SlBHTVRSTlVwM1pwcUFiZU5TV0c5bHd0blFtdTY5WTVvYUxHZlZibVMy?=
 =?iso-2022-jp?B?QUlkZzkxdjl3d1EwUnRzczN6ZXY2OUJYSzErV2cwM0NYcnlvWVhOanAz?=
 =?iso-2022-jp?B?ZjhtK3pVS0F4bVg2aUl0K0U5a3dDUVF1NjFSdTJSNTA0Z1oweS9BMDl3?=
 =?iso-2022-jp?B?eHM5S2NxZkNrOENqb2tTMnpWZ3pkakRBMGVsRk95cm9mZWpWcFRMU1kw?=
 =?iso-2022-jp?B?bVU3MzRRY05vVDZQSi9NRHNGcEFJSmZLSTJkeHE5UXJpVGNvVFJHK1pG?=
 =?iso-2022-jp?B?aEhlN2FEZlVWdGY5d0Y2LzU0S0NqYVQvQUtqOC9waUMxQllFWGZvMDRW?=
 =?iso-2022-jp?B?WHZiVlo2aEltdTV1ZVE2Mk9Pek1HUkwzNkJicHRwV3pVckJacnhHdEcy?=
 =?iso-2022-jp?B?aFZ5K2V1NmZOb0xqekd0czZxYlJWbGxnVzNKaHJEdjk1ODF4eXRDSHFJ?=
 =?iso-2022-jp?B?OHJMa1VYZkdFREZOMDdwOUZKb2F2VTlVUFBkWDVFdDU4NHVYanZDZFFj?=
 =?iso-2022-jp?B?VFErd0Noa3ZZa1JKVlFpNUhtcmZKcWZTY3NxNjNNd1A1SDI5bFlrcUp3?=
 =?iso-2022-jp?B?QjN0MFNuMmRMcE1UTnl5RzAvUmIyN3pKM2tlNHJWWUsybG1wNnUwMnZr?=
 =?iso-2022-jp?B?aFp4akJDZlkvZzdtMUw5bVBGc2hBMlh4aWQxRU5FSGppRjNBS3BBM1hO?=
 =?iso-2022-jp?B?SnEyb0NwLzNQdlJhcDVkRDZPc0JxRWpzUHZCbWZsR2NmTExpd1RTaE84?=
 =?iso-2022-jp?B?MU9NR3FnbXZRRlBobUU2c1hDNkkyeEtheWlPV0o4eXAydVUwRVVBeGFR?=
 =?iso-2022-jp?B?bGlhcnorUXQrRlRQYWszcDQ4aGFQNEZoMWFWRmJwQkpaM1gwU0lGellE?=
 =?iso-2022-jp?B?VFdyLzdrUk1VcUFWc0ZmT25iQWlwbWFFdzF4d3VVL21JWDRCQ2tFL0pU?=
 =?iso-2022-jp?B?SjRWYWJwUkFoYnpnM1BibHJORVNBdkcyYUFKdUczOUFoajc2WUhCcVVC?=
 =?iso-2022-jp?B?NkRyUHZtUU1jU3BIcG1pczN2d21lYy94eG56TXY3b0diamlJdXJxY3Ez?=
 =?iso-2022-jp?B?dUtmTmMrS2xzdVVyV3h6T1RrenEyTzYwVW1PZ25ublRHcHBvMHFuOE10?=
 =?iso-2022-jp?B?WEhJVWg3enJZU3o1ZnhyaHJIa2FHU0RNRVVjSnJwTUgvQ2h1T1FxUmk5?=
 =?iso-2022-jp?B?UHlwaTJIbnIzenJOMTlLcm84OFhyaUV1eHNZTi9Nc1VtakpERytGUkNT?=
 =?iso-2022-jp?B?ek43dHcxc1Y3SnRPMHFzU01BRENiQkRxTElFaWZvcGZvVE1TYXgyMG9q?=
 =?iso-2022-jp?B?ZEJuUGwrT1NDSVloak5BU3kzZjBKM3pPSGpWZzc5ZW9LNlhmY2Niam1R?=
 =?iso-2022-jp?B?VUtNSVgzbm5RamZvQWNWc2lneEFZbEJKZ2lPZEV6RWh5UXRoRGpVQXJM?=
 =?iso-2022-jp?B?SU1jNWJZemNqOE9pbWhvM1l5NHdySkxuYTM4RVNBUTg1M1pFSllHc3Vu?=
 =?iso-2022-jp?B?WW5TY093eEZxMng4eGxYWmx5Rld1TzVGSnlCSTFrMmp1NWI2UGZBN204?=
 =?iso-2022-jp?B?T2xrMENOeTFYWjEyVnRuYlQvdVFsZzFmM0c5WDY0Y0NEZ2UwY2tHVWJx?=
 =?iso-2022-jp?B?T3duUWRvNjc3VkpwWWtrOGs5MGZUMjhTS0w5RmN5cFhjWVIxNk8xV0xL?=
 =?iso-2022-jp?B?R1RIbzBzaU1Hc2xTekYvZ2p5a0RNcmo2bHJXcmJPRENyV1kvaVc4RFlm?=
 =?iso-2022-jp?B?M1lLQXRUZlVCdlUxTlhGQkpvQmFOWEpxZGhtTG5zb1RMV2lJRlJBdEh3?=
 =?iso-2022-jp?B?aGQ1Z2dSaXVoQzlxNE42eXZRNnhiSXhDSjFsNUtXbW5pVk5xekgrOXY1?=
 =?iso-2022-jp?B?WGcxNDBROEx6L2lXQVl1bDRLdWlSa1VMdkYxVjdsSXdHYURBYzlyZ1ZZ?=
 =?iso-2022-jp?B?T2EwaGZScjhjS0wydysvbWhObzI0TkF1UTU3WW5sYlVRandzckNRMGEx?=
 =?iso-2022-jp?B?cjJ6eDlNQk5xMFl6dDltYjYzV01hOEtkcUNHRCsrdys5QXc5R241cjVX?=
 =?iso-2022-jp?B?SEdLOA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dlfcUrwlTTXjgCQPAQhtK6e0pnNwm7wy05WjTcGqkZKHPPQRyo720hik6jkLIOunPW94Ad1PWjYzgZLDQ94R+8E7iieqz2hbiLxWwyYyT0NYqRAkQEHg81vLLO8u9EAIrTiKgSy5N9k0JkZiIHTSeUVylM8nwLkbyS4O0psAmmyvbCOoJAcNOaR40WVxp1vVcMu5UGKdYo/P8M2QifW2aCZvjTKYCVh1F6aW+mUGKHXaFl/EnOq3MtnzlIH2bbG46JrPnCyc7Bk8scbtujels+rBc+oFaXcwSEsAGttSC0Xvj4xee83Max+XNH/V+nBhh8aeZS541PfNvCeW/4Z2D0iWPo4AbnCDb0qHUvSVZrALw2/1N4FFqW7nl9p99B6wY85LzlIsyZnoCh6Q8vxOxe9iQY+1P4QMGFkavJrg58tTVDKk9erMRHeZG/c9814J96idmt0KDMJywYvdzVBWjpwpvJS3W4hBkFy7g6pvCMA23tPfI3Lleqo67Mv0ZFVHcycF6Ys4iIIJEosmOfCIcJdcQoPsaVDtE/cGcQ3bR7y3mBEN+uKH+uUdcD2b5dmHi8cLoyOKWxMY8GERLuRzDLjl3hPVN/1Oel4bcJ566mgkWgsArskk5G2vz/V4qk/uU/8Ym3FoJzDyw/9amKeuet44hir1tX42M/L7we/7tSUwD03wLq1/Fvg2SkuNHaWLjqiZkFXtF+MS11aLSHPT1TC4LZ9cf3EWGbTrdFeBzkjLgPq3lhpY2WhRi7KnQqLElKjyHj648LZbpkVCsDxUXU5Xy6x7EYAuFNpwoZKwwf8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1a9b8a-c177-4a3a-5057-08db68852e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 01:02:21.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFB+O5DYIMS26VM3pifffyGkNGWPpz0uOHjNMtdrdEM7+zWhLm5vDhkWR59kc/1XgUzzOawPK1hf+vGwGhj63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8818
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > Hmmmm, my question is NOT about attention button now.
> > (I noticed that my quote of previous mail may be not good. Sorry).
> > I would like to confirm what component/method is still necessary for me=
mory
> pool.
> >
> > I imagine that there is(will be) a total memory pool manager which
> > manages a lot of Linux systems on each servers which have CXL memory.
> > And I think that an agent/daemon will be necessary in each Linux
> > system to hotplug operation like offline/online memory blocks, and/or
> > requesting configuration of Dynamic Capacity Device to a Fabric Manager=
.
> > I guess such agent/daemon is not created yet for memory pool feature.
> >
> > Here is my current understanding of an example of steps for memory pool=
.
> > This does not include attention button, and use DCD.
> >
> > 1) The pool manager will request hot remove to a daemon in a Linux syst=
em
> by REST API, ssl, or somekind of
> >    network interface.
> > 2) Then the daemon will execute memory offline some memory blocks.
> > 3) It will correct offlined memory blocks until requested amount, and r=
equest
> >   configuration of DCD to Fabric Manager.
> > 4) Fabric Manager will configure Dynamic Capacity Device.
> > 5) The memory pool manager will detect finish of its configuration some=
how,
> and request hot add to a daemon in
> >   another Linux system.
> > 6) The daemon will request configuration of DCD to FM
> > 7) The daemon will detect new area somehow and online blocks for them.
> >
> > If I still misunderstand something, please let me know.
>=20
> Yes, I agree that a daemon like that is needed, I am not aware of any cur=
rent
> work in this space.

OK!

>=20
> However, I wonder if there is existing virtio-mem-like management
> infrastructure that could be repurposed for coordinating host-mem dynamic
> memory adjustment.  In other words coordinating a shared pool of memory
> across multiple kernel instances is a problem that has been solved before=
, CXL
> just makes it so that the coordination is across physical hosts rather th=
an
> virtual.

Hmm, I'm not sure. I'll investigate it.

Anyway, thank you very much for your answer!

----
Yasunori Goto

