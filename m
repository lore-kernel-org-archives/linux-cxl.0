Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEB5C77B7E
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 10:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbjEYKd5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 06:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKd4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 06:33:56 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 03:33:52 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E725E6
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685010833; x=1716546833;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=D/QqGmxJWGbYUh+WmHrAkMl7NqtFjgnjkodJS6KMpYQ=;
  b=PKa856kquNTd8RrIy2w+bimcVafFFC7Jx7SepsXDMAbuk99AAQwsOEwl
   GdRSIUoIw5nGsge4K5Va6UNdVcXk36hufnCjY8oe8ByKlHoC1fEzdwoBN
   TXtaBTHQJsy4Zn4tzcomfk7ZwmGZnAR/Ky6ZwWoi9CkR+dFfi4/5XnQZ6
   rcFFyNcP0Xv/nwL5a6rkqR2qB5/m280As5Qt4S18rbQxeZZFdAKTHgdNc
   ZGxITIR19zPWi52ZRDvszTl9XiwO1kZVpyDslrVmKvd0NvWzStoiLpFwo
   KVsmM9sSM6JoYB738firjccYhBuKEXhbMibEkEgTMwgodBGjb1A29YKKy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="85397963"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; 
   d="scan'208";a="85397963"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 19:32:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAu13GBFc2C+Qduenzjf6Z0+e5v+30CbhhMq/fysZ1FRmGyQzZL9+5cx86zTlUeieiJ9ogr6foGZWQ0c7GXAaKhssNfuJqQYt9UIyLqhAzP3nTQ6IZlTdG+81N18Ci5ixhCSTfY4wNTlAiPOGm7wO/sX1tdt5Z3ehKPyVrnSlNtF2tqGjb7Gd/bRduGKQsJQyqIYSl6gK4zqd5nGJc70180Oc6Kd9lIRGhBGGrABuTeynDpF4r8S/s8j7MRi75ofQFLNjRzXm25KISFQv1H/1mbsHnD/ZZ42fZ+ym7PF2DVr5q15g9GVrsHpUNS0zQ9i384zWJ0jSV2i0oDvfP9D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/QqGmxJWGbYUh+WmHrAkMl7NqtFjgnjkodJS6KMpYQ=;
 b=jsK0xUUfjpl0s7ZlLd+Ut0sSDEqJYe3yEIfHDxJjYz6wj55dto380ZCQdBp6hriK3BnjaO9PzzYGO6CzjGe1HxLRBPpFE2yhCDzCFzzNmVfaqa+DP3YFoocI8M8khPSIhQ8bFG3pKebBYJspWmNMvJWu9i+TWdRu4zC23omt5AjDOgWQYZW9FyeVbTsmjPJ4dx4ZKXRIgqUwyquwYiC+isKkGUAZrQSr+9Dz8qE2ceY4DEO90gXmgaPWkb1Wg5gswgIW77lq6IOsFka3tY4pwMPIj0fLKD7lUpyqgqJ8nXwK31crUXfZstD6QC/RUsWKKKUNxsJd0KNZoHP0N42tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYYPR01MB8021.jpnprd01.prod.outlook.com (2603:1096:400:ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 10:32:42 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 10:32:42 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngAAINJ+AAAQwYfgAChaTQAAGGzQYA==
Date:   Thu, 25 May 2023 10:32:42 +0000
Message-ID: <TYWPR01MB100823C75C64916F57826039890469@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646e78c67ce17_33fb329432@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646e78c67ce17_33fb329432@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMjVUMDg6MzA6?=
 =?utf-8?B?NDBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD04ZmJhYTM0ZC1lOWEyLTQ2NGUt?=
 =?utf-8?B?OTgzZS05ZmRjMjJiZjgzOTY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: dacc6d66238b4d7d9b181344475d271e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYYPR01MB8021:EE_
x-ms-office365-filtering-correlation-id: f4faa25a-428d-4266-8047-08db5d0b5efa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3J52OPemSB291z9geJr7IIovdP7J9s01cKhge9QHrPhbkRxtFvrx3BjSNZZE/8jgzLHFseuDN74YUmx/20twRm2//eWFfGVYlaBKiUPKWtaTBn7kgHv2SabamFG/X9UbKI80i0ubY/lr9NVDflf6Ftl7CJuXCJ/2LIFv3uolkzjllmN11yRL0qqB6FmLEMICOHJVg7D43QP9gXbRCV7k5HQPuccA90IBRa1hr6/NXmCpPgvocKLeqJMQJ6Qm7kXI98LljV+AGbE+RwJKAHIaYAt35V0fiYk8P97Zm8/PmGl2XvkqJmr09ZdoKmzZgYJczBgVdGRYcaTF8BQ/wkD9v1w/bcYxIULbsKEmL6Hf/k9a2x/PDwYo0hpFMnKKpMhX1LuuoEkdKQ5IFXE7h2lXvTEckQKSGN6XWPQGP9if54WeAE0kuYMuuYnmjPb89Q6/UoiUZTouTQn/lXHLjjDITGbejUApRYV/lcRf4hGVk6yfHuE3ABgvPyIkynOOop0DKv+MvxAuid3AS06s6mTFAWC7A00AvcpD5XbQOAfgmP3UA6nNOBuyMcZ8TS4p+g9oA7fnRW6+/7ae/xrIwx5Gn+Rki7Ir3w8R8/1gCgyuMiCX5+4IcGKOJEDJDzeWXC8r9kW5IzZIpSPSidNK6aGAOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(1590799018)(451199021)(2906002)(83380400001)(186003)(85182001)(33656002)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(55016003)(966005)(71200400001)(316002)(7696005)(41300700001)(8936002)(52536014)(8676002)(5660300002)(478600001)(110136005)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(6506007)(9686003)(1580799015)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGNMa3JKRnI1ak5xeDYyeTJMREEvWnZwZU9NbWhRUkM5RjVJbWxubXBxTTBM?=
 =?utf-8?B?Vy9QWWlJbWxKa0NvaU1BVmh2RWVNbjljWEJCYXpPREk5WWQrNHZNMHR1eTN2?=
 =?utf-8?B?THpMUWdVMytINzYrWUY0QmJkMFNjeTh3M2RHSG1TRW02Y1pKUkE0Q3YwMEtP?=
 =?utf-8?B?MVUycjVpWG9NSVR1SDBVL2JDNm1oSzAyUEJXS1J2MGJFd0w1UjErNndCcnNw?=
 =?utf-8?B?SW15Z0M1RmowR3g1bmZKSDBKenJhYXV4SVdBL1NOSDdVdzRCK2hkb2tuSFRX?=
 =?utf-8?B?SGpKU3k5VllNMUwrQW1ycWhGM2s1Q3hEZ01aZ2pvWVAyZ3Y1dGJQNDVDNUpC?=
 =?utf-8?B?b0llR2h1SG8zdFlEWjhaaytNalRrcThCMTJraU1NS3F1SlJqS09JWjd4S1lH?=
 =?utf-8?B?SnhkclV5dnE0YURaQTh2RlY0RVBYcjc0bExEU1h0Nm5tZWFRZmVPaVZTclBV?=
 =?utf-8?B?Zm9ISDIyelZHQ2lWYll1clovam5xMW9GaFM3YkhMRzVla25nZUsybUcwVnNn?=
 =?utf-8?B?Z3p4QVpyY0hvcWJOazRONVIza1FhbHpEeVdoc1oxbWNzUTQ5c0JYQXFtQjBw?=
 =?utf-8?B?R3diSUNVK1JJVThoQ1pGUUxzZFFGeURuQThLOUZCWGR3Y2YyS0twN1BtSTlG?=
 =?utf-8?B?K2hvYWQ2SjNlamRBYWo5ODhxVjhkcjA4cUNYdTRiZWR3N1FkMjMyNUhsb1lQ?=
 =?utf-8?B?R0pQN29Dd0RlSDZ5MmtiWDFpWnl0VTBhaGpzaFB5b1VBSkQ0b05aY0xSU3Vo?=
 =?utf-8?B?NHk2MDMvckRuQlVSTkpmeUptNEwycklQVzIyb3MwOEc1U01pOFBMbEVhL1da?=
 =?utf-8?B?aW9kUkorbkVRNzROTmdkUWt4WXJXUFgzWVdmS1h2cVJCVFVFRWMzcVgrcnBD?=
 =?utf-8?B?STF2TjJWdGN1bm5ZNExuWUV1c3ZBaFNVa0hWMXpZQUhrVFBKelJMa2E2QmtW?=
 =?utf-8?B?Y3h2MDQybk9BSm55UUtkZzNBemJ0TGRqUEJaYmlCNFNJZXBmczFqNVg4d1Ay?=
 =?utf-8?B?dWxldHBLSEJiWTRZZXI4d29NQVgrQVFRTmxxOWxjRGN3cVhWR01pWlV0eXQw?=
 =?utf-8?B?V3plaTg5ekJVbTBLN09ZV0RpRjJZck1DM3RxekFYZUNUTzRXVmdDQnNvVVR2?=
 =?utf-8?B?dm91cldYTTFKWFZoSDROQzNiZ1lkZm5vcXhVNjdiWW9SVGxNQWdZWndJK0dp?=
 =?utf-8?B?UTJ3S2lUY1p3R05Hb1daYW9IeGs3NHhOUHJXRnhLSE5BYXo4bGNsOFZ5cU51?=
 =?utf-8?B?dUhJeUFDS0M2a2U0R2Zmd0hLeVpnTkpJK1YwalQ3dGxzRXA0RGNlMkJQWXZB?=
 =?utf-8?B?cUdsQ0UvODRkUi90eE1lYVZlclhSMFdrNGhnWTBYRTVDVXkyWUJVMWd2djJt?=
 =?utf-8?B?UWJCRFNUM2RNSTJ6aE1IUitUM0hFNVhZWmZnM2NzNkNUVWZlL2xJOEUrL0p3?=
 =?utf-8?B?UWlPcEtsVEhLNzFmdG9hbFpMUXYxb2NHN2FFdktxakxDRDVvYmpGSkVFYlZR?=
 =?utf-8?B?QlN3OEZUcmlsanhEVExCY1ZwS3NDTUtkRS9za3EwVW4xUnhFdm1xaTVZMVVi?=
 =?utf-8?B?QnpsWHVvRFJ4MXJFa1RtaXhCR1hpcm5TamVnZXRJejZITC9mUndFK1VzUGh2?=
 =?utf-8?B?YllNUXg1WFlJZTNTK1dBVWd6NHB5VCs0VXhvbDZtbExHQ3ViNkMrSE1RQnBh?=
 =?utf-8?B?d2hUblp4SmYva0p0VTA2UmRad2R1MDZWOVVCL3llWTF5Qzc1akZNMjhIVC9y?=
 =?utf-8?B?Q1NnS1lIQytUMVV1Y2E4NzJKN3dpSkxscWViUDRyNzZzRjV0VEZnQms4cGRm?=
 =?utf-8?B?dmZYRHhoOGJSVTlpelpEOEZibytTMkpvVXQrYk5SOU1GZHE4S2IxWE9aZmJU?=
 =?utf-8?B?eTBsTkFEbGRsL0dTWFhvdVg0T2p3dUkxc2w3bHEySENlTjBUUzBFbGZqc3NK?=
 =?utf-8?B?YkV0MWEzZjZmWXVvMkJ2N0Q4UHNjc1llM0RYNDJBalc4MWlSY0Jid1JxbWdE?=
 =?utf-8?B?NkQ2TXdqOTJOWXJvK2RLZTE3M09FazdHYURnYkNxMTlIZjhmUm9MaVFUWUUr?=
 =?utf-8?B?UlYwM0x5dWdrZUFBSXVHWTdYRnhPS3FaWjRiQkJNempsK1c5WWVmWlVIV3ds?=
 =?utf-8?Q?mWkRxRougZxY9ra2/DOY9OSLs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tv52Y5WKfWX8xB28bUNoNqhCPp/RJt2LnDVe3Q+8iHbiGMkyWGRwafM3PhIVE2Kux0Dg+78+cAIZ+ilt21SlkuJhTwt7YI9C578FZ/bk+ZY3Xv3ANJ9cxqhSCteScfBT+/cHGzZa5aY396xxmmwCuW6thk/RENjJlK3ME0yCvZeDuGcF/BdMZOdr8gcZKm1Es0lAPrbTNO2PuqMop2MF7Uu92Xgp7LBnnO52+FjJqw56cboVWFO2MP6q8twNm2djSQCE71B/eyFu5SNQCON74T95e4pYa/TTN7Fbjod+bai3hTKGEFxDga0HYPqveNfLVv3Z/bqo//ccvxpdka1aaqj3YwtLzkHZeh0ar1hHgZri+r/IDAy7U3IXlAyx0x1nxSDkHcTHcKx2b6K+bejNuR3lqS8xZj6aTSx63xrhViIeMwRoxW8XbB2GLBYqKC9uqyNFdDGVEDKKeITBuMm8URPkUX4S30V6J/r4e7iHeXlm2gVPeriuKWJM9I8btwaKz1TVGpSPkPvRCCtOxaG1wunewf1Lx5IFc6XEg4ynJQ8VZgMx6uF6DkGaWqtVzDipxpPMikztTp+8NzGCHNkBlfr00YzngXWHhF0WgdIYFzhOFoZhh2vdI/2vkUQ/O/ShJY+HO3kM+gyvGY9Amg5wrDIZWB12RPxIdf0UumXGGPQYS3L0aizweEOUxdTvKFf8J8nDh8JupfE1E4favLmlgnPWuJaIubUxyqWjVPOwuTYxrJOaCQa5rl+0l7KGWc/pZRHFjBa/ItVNECSVMzHFSnplS/QvfXVfeEWKZYmNDvo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4faa25a-428d-4266-8047-08db5d0b5efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 10:32:42.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/HwXKCepDgSTOi/++5kvn0dAcsbtY+w3ZmP5erLQ1B2Utb4KQjU5OlbYL8f/XC6VzLXyK8y05Qd+wHHvDBPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8021
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

PiBZYXN1bm9yaSBHb3RvdSAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gPiBZYXN1bm9yaSBHb3RvdSAo
RnVqaXRzdSkgd3JvdGU6DQo+IFsuLl0NCj4gPiA+ID4gSWYgYSBibG9jayBob3RyZW1vdmUgc2Vx
dWVuY2UgZmFpbHMgaW4gdGhlIGRldmljZSwgaXRzIHVzZXIgd291bGQNCj4gPiA+ID4gbGlrZSB0
byBrZWVwIHRoZSBkZXZpY2Ugb25saW5lIHRvIHBvc3Rwb25lIHJlcGxhY2luZyBpdCBvciBzZWxl
Y3QNCj4gPiA+ID4gb3RoZXIgZGV2aWNlIGZvcg0KPiA+ID4gZGV2aWNlIHBvb2xpbmcuICh2aWNl
IHZlc2EpLg0KPiA+ID4gPiBJIGRvbid0IGZpbmQgd2hpY2ggY29tcG9uZW50IGhhbmRsZSB0aGlz
IHNpdHVhdGlvbi4NCj4gPiA+DQo+ID4gPiBJdCBkZXBlbmRzIG9uIGhvdyB0aGUgbWVtb3J5IGlz
IG9ubGluZWQgYW5kIHdoZXRoZXIgaXQgZ2V0cyBwaW5uZWQNCj4gPiA+IGJ5IHRoZSBrZXJuZWwu
IEFzIGxvbmcgYXMgYWxsIG9mIHRoZSBtZW1vcnkgaXMgb25saW5lZCB0bw0KPiA+ID4gWk9ORV9N
T1ZBQkxFIHRoZW4gdGhlcmUgaXMgYSBnb29kIGNoYW5jZSB0byBiZSBhYmxlIHRvIGdldCBpdCBi
YWNrLg0KPiA+ID4gSG93ZXZlciwgWk9ORV9NT1ZBQkxFIGlzIG5vdCBhIGd1YXJhbnRlZSB0aGF0
IG1lbW9yeSBjYW4gYmUgcmVtb3ZlZA0KPiA+ID4gbGF0ZXIsIGFuZCBaT05FX01PVkFCTEUgcmVx
dWlyZXMgc29tZSByYXRpbyBvZiBaT05FX05PUk1BTA0KPiBtZW1vcnkgdG8NCj4gPiA+IGJlIHBy
ZXNlbnQgdG8gbWFrZSBpdCB1c2FibGUuIFNlZSAiWm9uZSBJbWJhbGFuY2VzIiBpbg0KPiBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL21lbW9yeS1ob3RwbHVnLnJzdC4NCj4gPg0KPiA+IEkg
a25vdyBpdC4gUHJvYmFibHksIEknbSB0aGUgZmlyc3QgcGVyc29uIHdobyBwcm9wb3NlZCB0aGF0
IGtlcm5lbA0KPiA+IGRpdmlkZXMgaXRzIG1lbW9yeSBpbnRvIG1vdmFibGUgYW5kIG5vdCBtb3Zh
YmxlIGFyZWEuIChJSVJDLCBpdCB3YXMgQk9GIGF0DQo+IE90dGF3YSBMaW51eCBTeW1wb3NpdW0g
MjAwNCBvciAyMDA1KS4NCj4gPiBBY3R1YWxseSwgbXkgbmFtZSBpcyBzdGlsbCByZW1haW4gaW4g
Z2l0IGJsYW1lIGluIHRoZSBlbXB0eSBsaW5lcyBvZiB0aGUNCj4gZG9jdW1lbnQuDQo+ID4gLS0t
LQ0KPiA+IGFjMzMzMmM0NDc2N2IgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9tZW1vcnkt
aG90cGx1Zy5yc3QNCj4gKERhdmlkIEhpbGRlbmJyYW5kICAgICAyMDIxLTA5LTA3IDE5OjU0OjQ5
IC0wNzAwICAgNCkgTWVtb3J5IEhvdChVbilQbHVnDQo+ID4gYWMzMzMyYzQ0NzY3YiBEb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL21tL21lbW9yeS1ob3RwbHVnLnJzdA0KPiAoRGF2aWQgSGlsZGVu
YnJhbmQgICAgIDIwMjEtMDktMDcgMTk6NTQ6NDkgLTA3MDAgICA1KQ0KPiA9PT09PT09PT09PT09
PT09PT0NCj4gPiA2ODY3YzkzMTBkNWRhIERvY3VtZW50YXRpb24vbWVtb3J5LWhvdHBsdWcudHh0
DQo+IChZYXN1bm9yaSBHb3RvICAgICAgICAgMjAwNy0wOC0xMCAxMzowMDo1OSAtMDcwMCAgIDYp
DQo+ID4gIDoNCj4gPiAtLS0NCj4gPiBJJ20gZ2xhZCB0byBzZWUgbWFueSBwZW9wbGUgaGF2ZSBl
bmhhbmNlZCBpdCBhZnRlciBsZWF2aW5nIGZyb20gd29ya2luZyBmb3INCj4gbWVtb3J5LWhvdHBs
dWcg8J+Yii4NCj4gDQo+IE5pY2UhIFllYWgsIEkgaGF2ZSBub3RpY2VkIHRoYXQgbW9zdCB0aW1l
cyB3aGVuIEkgdGhpbmsgSSBuZWVkIHNvbWV0aGluZyBuZXcNCj4gZm9yIG1lbW9yeSBob3RwbHVn
IGFuZCBDWEwgSSBydW4gaW50byBEYXZpZCBIaWxkZW5icmFuZCdzIHdvcmsgYXNzb2NpYXRlZA0K
PiB3aXRoIHZpcnRpby1tZW0uDQo+IA0KPiA+IEluIG15IHVuZGVyc3RhbmRpbmcsIG9uZSBvZiB0
aGUgYmlnIHJlYXNvbiBvZiBtZW1vcnkgaG90cGx1ZyBmYWlsdXJlDQo+ID4gaXMgbG9uZyB0ZXJt
IHBpbiB1c2VyIHBhZ2VzIGxpa2UgSW5maW5pYmFuZCBSRE1BLCBhbmQgSSBndWVzcyB0aGF0IG9y
IGFueQ0KPiBzaW1pbGFyIGZlYXR1cmVzIG1heSBoYXZlIHNhbWUgcHJvYmxlbS4NCj4gPiBNYW55
IENYTCBkZXZpY2VzIGxpa2Ugc21hcnROSUMgd2lsbCBoYXZlIHN1Y2ggZmVhdHVyZS4NCj4gPiBC
ZWNhdXNlIEl0IGhhcyBhbWJpdmFsZW50IHJlcXVpcmVtZW50cy4NCj4gPiAtIFRvIGFjaGlldmUg
ZmFzdCBkYXRhIHRyYW5zZmVyLCBzdWNoIGZlYXR1cmUgd2FudCB0byBza2lwIHRoZSBrZXJuZWwN
Cj4gPiBsYXllciBhbmQgcGluIHVzZXIgcGFnZXMgIHRvIHRyYW5zZmVyIGRhdGEgZGlyZWN0bHku
IFRoZSBtb3N0IG9mIENYTCBEZXZpY2UNCj4gbGlrZSBTbWFydCBOSUMgd2lsbCB3YW50IHRvIHVz
ZSBpdC4NCj4gPiAtIE9uIHRoZSBvdGhlciBoYW5kLCBrZXJuZWwgaGFzIHJlc3BvbnNpYmlsaXR5
IG9mIHN1Y2ggYXJlYQ0KPiA+IG1hbmFnZW1lbnQuIE1lbW9yeSBob3RwbHVnIGlzIG9uZSBleGFt
cGxlIG9mIGl0LCAgYW5kIGl0IHdpbGwgYmUgaW1wb3J0YW50DQo+IGZvciBDWEwgbWVtb3J5IHBv
b2wuDQo+ID4NCj4gPiBJIHRoaW5rIGl0IGlzIHNhbWUgd2l0aCB0aGUgaXNzdWUgRlMtREFYIHZz
LiBSRE1BLCBhbmQgT24gRGVtYW5kIFBhZ2luZw0KPiBpcyBvbmx5IG9uZSBzb2x1dGlvbiBmb3Ig
aXQuDQo+ID4gSSBleHBlY3QgT0RQIG1heSBoZWxwZnVsIGZvciBtZW1vcnkgaG90cGx1ZyB0b28u
DQo+IA0KPiBJdCdzIGdvaW5nIHRvIGJlIGludGVyZXN0aW5nLiBZZXMsIGFzIG1lbW9yeSBiZWNv
bWVzIG1vcmUgZHluYW1pYywgbG9uZyB0ZXJtDQo+IHBhZ2UgcGlubmluZyBpcyBnb2luZyB0byBi
ZWNvbWUgbW9yZSBhbmQgbW9yZSBwYWluZnVsLg0KDQpZZWFoLi4uDQpJIGd1ZXNzIHRoYXQgbWFu
eSBjb21wYW55L3Blb3BsZSBkb24ndCBub3RpY2UgdGhlIGFib3ZlIGFtYml2YWxlbnQgcmVxdWly
ZW1lbnRzLg0KU28sIEkgd291bGQgbGlrZSB0byBwcm9wYWdhdGUgdGhhdCBPRFAgc2hvdWxkIGJl
IHN1cHBvcnRlZCBieSBtYW55IGRldmljZSB3aGVuIHdlIGNhbiBjb25maXJtZWQgdGhhdA0KT0RQ
IGlzIGFsc28gZWZmZWN0aXZlIGZvciBtZW1vcnktaG90cGx1Zy4NCi0gU28gZmFyLCBPRFAgd2Fz
IHN1cHBvcnRlZCBieSBvbmx5IE1lbGxhbm94KE5WRElBKSBjYXJkLCBidXQgd2UgYXJlIG1ha2lu
ZyBPRFAgZm9yIFNvZnRSb0NFLiANCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yZDRm
NjAyMy0wODk3LTI0MTQtNDVjMC1lMTZiMTE5ZGQ5ZmJAZ21haWwuY29tL1QvDQogIFRoZW4sIGl0
IG11c3QgYmUgcG9zc2libGUgYXQgZHJpdmVyIGxheWVyLg0KLSBQQ0llIHNwZWNpZmljYXRpb24g
aGFzIEFUUyhBZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2UpIGFuZCBQUkkoUGFnZSBSZXF1ZXN0
IEludGVyZmFjZSkuDQogIFNvIEkgdGhpbmsgaXQgaXMgb2sgZnJvbSBzcGVjaWZpY2F0aW9uIHZp
ZXcuDQpUaGVuLCBpZiBtYW55IGRldmljZSB2ZW5kb3JzIHN1cHBvcnQgaXQsIEkgZXhwZWN0IHRo
ZSBwcm9ibGVtIHdpbGwgZGVjcmVhc2UuLi4uDQoNCu+8nkl0J3MgZXZlbiB3b3JzZQ0KPiBiZWNh
dXNlIGl0J3Mgbm90IGp1c3QgUkRNQSB0aGF0IGNhdXNlcyB0aGUgcHJvYmxlbSBpdCdzIGFsc28g
YW55IGRldmljZQ0KPiBhc3NpZ21lbnQgdG8gYSBndWVzdCBWTSB0aGF0IHdhbnRzIHRvIHBpbiBh
bGwgaG9zdCBwYWdlcyBiYWNraW5nIGd1ZXN0DQo+IG1lbW9yeS4NCg0KQWhoaGgsIGNlcnRhaW5s
eS4gDQpJJ2xsIHJldGhpbmsgYWJvdXQgaXQgdG9vLg0KDQo+IA0KPiA+IEFib3V0IHJhdGlvIHBy
b2JsZW0gYmV0d2VlbiBaT05FX05PUk1BTCBhbmQgWk9ORV9NT1ZBQkxFLCBJIHRoaW5rDQo+ID4g
dXNlci9wbGF0Zm9ybSB3aWxsIGNvbmZpZ3VyZSB0aGF0IEREUiBEUkFNIHdpbGwgYmUgWk9ORV9O
T1JNQUwsIGFuZA0KPiA+IENYTCBtZW1vcnkgcG9vbCB3aWxsIGJlIFpPTkVfTU9WQUJMRS4gSXQg
aXMgZWFzeSBmb3IgdGhlbSB0byB1bmRlcnN0YW5kLg0KPiANCj4gV2hpbGUgdGhhdCBpdCBpcyBl
YXN5IHRvIHVuZGVyc3RhbmQsIEkgd29ycnkgdGhhdCBpcyBpbiBjb25mbGljdCB3aXRoIG9uZSBv
ZiB0aGUNCj4gbWFpbiB2YWx1ZSBwcm9wb3NpdGlvbnMgb2YgQ1hMIHdoaWNoIGlzIHZhc3RseSBl
eHBhbmRlZCBtZW1vcnkgY2FwYWNpdHkuIFRoZQ0KPiBjb25mbGljdCBjb21lcyBpZiB0aGUgY2Fw
YWNpdHkgb2YgaW5leHBlbnNpdmUgQ1hMIG91dHBhY2VzIHRoZQ0KPiBaT05FX05PUk1BTCByZXF1
aXJlbWVudHMgdGhhdCBjYW4gYmUgc2F0aXNpZmllZCBmcm9tIGxvY2FsbHkgYXR0YWNoZWQNCj4g
RERSLg0KDQpJIEFncmVlLi4gSXQgd2lsbCBkZXBlbmQgb24gdXNlcidzIHVzZS1jYXNlLg0KDQpU
aGFua3MsDQotLS0tDQpZYXN1bm9yaSBHb3RvDQoNCg0K
