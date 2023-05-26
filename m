Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8500C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 08:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbjEZIGM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEZIGL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 04:06:11 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A7A3
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685088363; x=1716624363;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SwpwPuJ2T6ry7xZH75UX4ptL4c5RaAMFJkDcWWKIqdg=;
  b=d+miyEXDU6s7cOCnAuTdNf3rA7IfCDoDRYuN2ohtR1iY0uU95l0Vthzw
   m9R6avP9EQai5EEX/hegnOnS4slO4ihfbJrtk3Rwjbqs5bn75QtZ+b84h
   8e9VGMqaBHpPUB0hHrGnrUD4EtxJJPOu57xb3voKBMjEX+rGmkNMn3UOv
   tn3xKlqv8djdVnLqQYlDXrDUTb0kCcmiHPlTn60fz6N8n6sMDTlFSp6gH
   6i4NgPByJA07kT91BrHjmi9MQzkDa5etnxHsEipvy18erEaADdtzzS7CW
   LBI6LjkyzaQ5plQumhHOqCN9Wb2fPpCp2ihszKxS4d+EIRDi7nS7tothS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="85341021"
X-IronPort-AV: E=Sophos;i="6.00,193,1681138800"; 
   d="scan'208";a="85341021"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:06:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF8MSWFPQV/3nWQMV4bWtZdnxHjtPkKa9ZpZDqA0Nmz7oQqXenQr8bGnmTTIwF3VyDFz2w3KHz7tyF2qRVfTNWIBEx3805c4DeUjyBdyPAuz1tXi34/ufXx0c12jeTHAhzdxMOCzzxnKDPlxIHgkYSXBI9EldJZ5GGWtVMIUpK6Uka8dTbT+bO+7wIS7ngnBVUsSeAoj0Pf18s7FYQ24NeGkmvR+wttUxC0wSIxnxofBRgmI7uT8xWuoQdLbaIda6/DWFWaW9ZZI8t5ty9EfNwqp9bza4vqCE2wDjgOkEwTFlr0tliMG/rX3AWq1bT78+QYV4IG8fNWGTnVUbaIf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwpwPuJ2T6ry7xZH75UX4ptL4c5RaAMFJkDcWWKIqdg=;
 b=lVf8v7fgE4srsPsWSurEMkTJ0jUIgcbgCASMu/FhhJlM2F5OvKoZDAubtB3bz++difNAd+AQmkuOaP/KBmx8St8VQ/NqPsASH3Z7dM3lE0xiqgH9lC5sevzTqMfXv1bUG2Zgd1LkemaSwxcDT79kthoC4JyQUReur+bgtm/gX3XVE+UqthYdARhWTaZt7J2ZpFue4jql5Cjsc4WkvkCvHM5qSXiTmezUpI0gslZ4Btz8YeUhWE8QulxXkfpBYCUavK9V3Mj0kTtL9W0bsbAsgDiGZBZOKuW5O7quXfaK3l8hdKE/Yc1FLGGvtcgnMp7Ev0LiELo2oHFxeEeOsZVivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYCPR01MB5886.jpnprd01.prod.outlook.com (2603:1096:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 08:05:57 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%6]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 08:05:57 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngAAINJ+AAAQwYfgAEURk5A=
Date:   Fri, 26 May 2023 08:05:57 +0000
Message-ID: <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMjRUMDE6MzU6?=
 =?utf-8?B?NTJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0xZDBhYzI2YS1mMzkzLTRmM2It?=
 =?utf-8?B?OGYzMy05YjFjNjQyN2RlZGM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 00f6724e5ab84d869808f547c8270319
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYCPR01MB5886:EE_
x-ms-office365-filtering-correlation-id: c4036099-1a31-47a2-759c-08db5dc0092d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGmiH7o28jP3vSVjsqtGtNivLU6t97k3gBXz5/j2gmbtIkHt60spc4aPRyHbvhKoMuoBez1K30lnxHmsggvxl4GgB7MWd7mAedHUuN6XAAs2qLQDx0K0LeuPm+fLwLVhTP4QVIBjGXYpZDjlqTWVjcTiEstlOyuKdvKie3esTeHaZOo2XwkfBTOyyZm33didZKhXL0HgnqvAOKd1SeWskiBNxzU42OqyqVNJA53poMvZYE5SQ5GvEo0pRrSiqvFLhXeIilDomJyobzBq9QmtgsGOhRxiBYVevOcCc5zJ1Vs08kOPVeY7wRlDWPN3Qq7WLr0WYEBU+6oscaeBlB+yQ8aInHZ3V48YqBn6fKnZV/00Bk+donKinJ3KS3EmPQhAJ4WosFXkGMoUDrRDX3bysck1BPXY1zeafBpx3tPxaOnGjvr1/nPZnvbBd6OKQGj+itqaXAKGTSpO8crHYi1eNzztvgYJvj8c1B/utT4z6RJo+TvbLKuSQXslCLIvVQLaq/h/s25zq16nnYbmujeP5/K30MvMlQXbX3ZoSg8VCqG4nQ29GdAZ00aSyfKblQEtO2Twao4KcRfrevnxqaGP8HTN0rahr2Z70Gpf39+xvUkKUNox6u2UdRbg6PWsksrK5k7n6hQ9nc1n1+8dx9TXoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(1590799018)(451199021)(5660300002)(110136005)(478600001)(966005)(41300700001)(8936002)(316002)(52536014)(8676002)(7696005)(71200400001)(9686003)(6506007)(1580799015)(66476007)(66446008)(76116006)(66946007)(64756008)(66556008)(26005)(186003)(2906002)(83380400001)(38100700002)(122000001)(82960400001)(55016003)(38070700005)(86362001)(33656002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0JrODhpYVBmZ3ZBVHFFTUkxRkRtQTBuQmRyOWs1VUswUXBMQ0Rlc0E1cUhD?=
 =?utf-8?B?NjkxWFp6SE5IRXgyeUpHZ3Y4MUlwWVozOHE4bm42SU85REZxbEtVY09LYzBn?=
 =?utf-8?B?NzByUzZ2TGVTNE5hUHJLK3M1SS9kMGQwZXVzeVBWaDFHbGFSVWxJSFBmazhq?=
 =?utf-8?B?UlJUbjA4NGxqZVdXYisra3hybmFER3NXUmdKb05LWGl0Mks5c3hwMlhhNkVw?=
 =?utf-8?B?aXhZV1dvekNqNTNraE9LWnNydFRGN3kyTUtIU2p1TDJHVjdpWGhibHFQZGVl?=
 =?utf-8?B?TmVEeEkzVW9MWGNHdEZkWEIrNm9mRk4zQ0lzdGVJSlprMTBvbkZZbFBydklo?=
 =?utf-8?B?d0ZDK3Z2RTBtVU5pZTZYc0lqL2xOdHM2TTlSMWMzdzdXZncyUXdlRU9STGsv?=
 =?utf-8?B?OTJxbUVjb3VzMTB6azltcW9tNGNzNVdBQTBBYmI4dTNOVGNjQjAzUHltNWxB?=
 =?utf-8?B?NURtODRwWHhBQzFXTE9QUzRBalNGZmxYNlVjVGJiY29sZlY4UmdRdTcwZGQw?=
 =?utf-8?B?Vi9mWW5mVjBpVXpXclI0NU5IMlY0VjgzRW5YY1VRZjRFT2ZZK1lRbVEreWln?=
 =?utf-8?B?SjFjU0lrRnhhVERjY25adzZIbzU4L1BidVhBZGFCMFdEYjNpSWFxNS90M2c3?=
 =?utf-8?B?TWVZaXBHUHhBSnlnNHJYR3FEWjFPYnRKcml2eGxzZlRqSnRjZmJqVHhiOXVo?=
 =?utf-8?B?YkpVR1lFQzdDQTB5cG1Baml1eHMwQW0wRHlpRUlKRTFQSXBUV3ZGbTNKdUsw?=
 =?utf-8?B?SXZPQ08xa2hoc052M3pzcjdMUnJ0QU9ESGcwbFJiTFZsK0plVDlRL0JHK2Vl?=
 =?utf-8?B?bkRxRzc5ajh5SUNRNDRHY0ZDb1cvSWQyTjBEZ3ByVjM4a1lCamlLZUhaOHZH?=
 =?utf-8?B?cHh2VTR1YnJQSkQ4c3N6YlpmQndtcStWSE1qTzA5alBrOU1odFMxRlZwT2pk?=
 =?utf-8?B?aUZLTkxWWkxGMUZWVlA5SHhPendIOXFuQkYyM21rN3gyNzJmVVBIRlJmMHJ1?=
 =?utf-8?B?cVNJSWs0S1I4S3g2cWY5WDV1U2hYSlJuUWlUT0JNMmFsdThZRVExWFRYaVpT?=
 =?utf-8?B?QmxYSzRCZGorWllmbmwvS1dXVytvbWluMFFma2E1MDFZTHZmMXJ4SmU3N25t?=
 =?utf-8?B?Ky80Vy9vN0IvTzBBZFV5L1d2eElqZU9KWTJvaVlwYk52c1hnMkY4WlQzTERM?=
 =?utf-8?B?R2ptQ3pwZ0g1QWtsN1ZZc1JUZ21XTWdZRHRaZnNYVmNOTlc5Z1JuT3BUZ0JF?=
 =?utf-8?B?RDVsNjdvK2NCeTZhdExqUEF1ZTVYOEpuWU5mbWVuU2F6RmFPN3BlM05ONlBB?=
 =?utf-8?B?WmdiSHFYelpyY3MxdXZBSTZHWHlwWmFnM2hwbjliOUtucW9aVjFVdndQNGRI?=
 =?utf-8?B?ZGpUODdyOEhyMTNwOVRSRFpMS3U0T3Y2dmxHb25vbStlM2FxL0FLYzViT09T?=
 =?utf-8?B?a0RDV3NmV201UFRhS1I5ak13U3M4WCs3UEFySWdjOEZSY1JjVzZ6K2VaSHlS?=
 =?utf-8?B?cFkvb2swWWs0V3Q1M1U1SEtoYkJrREZaWExvMFNJdWUrN1o0UzZ5V2xNWDlS?=
 =?utf-8?B?QkQxbHJhUFFZQlN2U2JyK2l4ZWpnemQ0Z3plQ3hqNVcxanBaVkxweDhlWFNs?=
 =?utf-8?B?SjhhenpCL1NCTHg4MERwUlJkNnkzNGZHeDBIdGtTYm90bFZ4NlZRSTBTZHpL?=
 =?utf-8?B?eEFVbEo4ZU9NWm45cWN0cEUzOTM5aWNITXEzTWM3bnlnWityc2UweVpKclpx?=
 =?utf-8?B?NjUvalRvRzdGMkt1WkZIRGYrZ01ORmdwSzI3VTUxTFhMQkhmZ01IdGxJNWJw?=
 =?utf-8?B?Mkx1TEtydEswMytwL3JmdFhPN2RackEyVHV1VW10ZTBnVHFCWjJmMVZWMzFX?=
 =?utf-8?B?VldRNVRwak42ckQ5UitnRFp6TlNDbU5PU0pmRnBlQzdqbGJNVDVUWFpyenhQ?=
 =?utf-8?B?U2plM3dtZDh1dnUyTzNHS3Fab1lDVGlIZVFvYUgzd2dTeEdZU2ZDRWxoZzRp?=
 =?utf-8?B?amswNFRzalIxRUIrY0pqTjZ4R1Y3M2wvN3lnVlBpbFRmcEZGblVlYmhpVDRF?=
 =?utf-8?B?Q2dvRldiK1BKbGcrN3E5cmp4UFdGbEFTSHRNTUdXVUpIUjNneWtYR2ZMSkZi?=
 =?utf-8?Q?JOIi+be5iJDDcOvCGuhTudWCZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c4G0HfC2FOppVj0S/Z1NhGSeUY9H77Lq5Q0Xf7NlVrRODjdVvdZ//5hzwdDj0PBaTpA/LgUgusLsdoLSPXvP/lPE0y1oJC+7qdVnKM1f44/CNZLn2XgsJTrJwFhUDuSX99Y6WC53B8YeZ42wLyZc8J+NJP3ScFCptf6UUZAAAT2n37RXhjPXrnZXaWwGzQtCnPZlIm47ajd5NywU+EsubOn6B01ES3HzXe8EtsvLULySkzep4p5S24Zavpam17AxuDtT3BTrz887OrTVfXlGhZC6WZSI2YTTk2g1PNwwKI4zHQAS89WPQArWFxrWEKhBG16qbrBScW9qc6Y02c6v4laz+g6tVZ+kH/uasT2hGmcVYCAPSJK71bsEFnLAfrkAktGhe1toCiyEF2GVUWbJu/zKqY4Pog0KR/Yy77ibQWDJZt7zUu03oESA6EPIKm3WatPKOxv2vZ9uumxMMXqfSn87S/NqiIbo645Mxk3z1Oclo3Ax2VH5vMu9zkBjvRtLdGCC7bWp08fc6BT7deHQ4HeIQNNnL4ESuwV4WfmFOeFZKAQsAC1g2cDhOy0wYChdd+joRIl6kpERILXEeZ0sTrbi+R2DusNTtnSRtSPfXHdWCl2mg6gQi5p8i4BVzFmnxajNnYH7d/noM+gwNOOMbjybon2pFc8nDK8Ox6pIWW8eW+HzvUCQHxn/ml6RfqV7+sT1QTJGKyhOTBaoCn6NrlgRw6kHgJEy8vm7IiLIoi/YZoSGKqSQCkR+f/InUtLBX3QE81wQrCldvQFc3S/xjF0Xq/p4j6ijoU3rQ23cBME=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4036099-1a31-47a2-759c-08db5dc0092d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 08:05:57.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdpAGe65yVV1TJS6Q0H1xJ5nM0R+g+4cDMf+X+fkhdpfHl5nF7YwLG14PnUlacb86RyTMzNo90N+6vNj8N4PWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5886
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

DQo+ID4gPiA+ID4gUTQpIEN1cnJlbnQgQ1hMIGRyaXZlcnMvdG9vbHMgc3VwcG9ydCBIb3QtcmVt
b3ZhbCByZXF1ZXN0IGZyb20gUENJZT8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICBDWEwgc3Bl
Y2lmaWNhdGlvbiBzYXlzICJJbiBhIG1hbmFnZWQgSG90LVJlbW92ZSBmbG93LCBzb2Z0d2FyZQ0K
PiBpcw0KPiA+ID4gPiA+ICAgICBub3RpZmllZCBvZiBhIGhvdCByZW1vdmFsIHJlcXVlc3QuIg0K
PiA+ID4gPg0KPiA+ID4gPiBDdXJyZW50bHkgdGhlcmUgaXMgYSByZXF1aXJlbWVudCB0aGF0Og0K
PiA+ID4gPg0KPiA+ID4gPiBjeGwgZGlzYWJsZS1tZW1kZXYNCj4gPiA+ID4NCj4gPiA+ID4gLi4u
aXMgcnVuIGJlZm9yZSB0aGUgZGV2aWNlIGNhbiBiZSByZW1vdmVkLiBUaGVyZSBpcyBubyB3YXJu
aW5nDQo+ID4gPiA+IGZyb20gdGhlIFBDSSBob3RwbHVnIGRyaXZlci4gV2hpY2ggbWVhbnMgdGhh
dCBpZiBlbmQgdXNlciBkb2VzIHRoZQ0KPiA+ID4gPiB3cm9uZyBzZXF1ZW5jZSB0aGV5IGNhbiBj
cmFzaCB0aGUga2VybmVsIC8gcmVtb3ZlIG1lbW9yeSB0aGF0IG1heQ0KPiA+ID4gPiBzdGlsbCBi
ZSBpbg0KPiA+IGFjdGl2ZSB1c2UuDQo+ID4gPg0KPiA+ID4gT2suDQo+ID4gPiBUaG91Z2ggIlN1
cnByaXNpbmcgcmVtb3ZlIiBpcyBub3QgZ3VhcmFudGVlZCBieSBzcGVjaWZpY2F0aW9uLCBJDQo+
ID4gPiB0aGluayAibWFuYWdlZCBob3QtcmVtb3ZlZCBmbG93IiBzaG91bGQgYmUgcmVhbGl6ZWQu
DQo+ID4gPiBJJ2xsIGNoYXNlIG1vcmUgd2hhdCBzaG91bGQgd2UgZG8gYWJvdXQgaXQuDQo+ID4N
Cj4gPiBUaGUgbnVhbmNlIGhlcmUgaXMgdGhhdCBldmVuIHRob3VnaCB0aGUgUENJIGhvdHBsdWcg
ZHJpdmVyIHN1cHBvcnRzIGFuDQo+ID4gYXR0ZW50aW9uIGJ1dHRvbiBhbmQgcGF1c2VzIHRvIGxl
dCB0aGUgT1MgYWNrbm93bGVkZ2UgdGhlIHJlbW92YWwuDQo+ID4gVGhhdCBhY2tub3dsZWRnZW1l
bnQgaXMgbm90IGNvb3JkaW5hdGVkIHdpdGggdGhlIGFzc29jaWF0ZWQgZHJpdmVycw0KPiA+IGlu
c3RlYWQgdGhvc2UgZHJpdmVycyBqdXN0IHJlY2VpdmUgYSAtPnJlbW92ZSgpIG5vdGlmaWNhdGlv
biB0aGF0IGNhbiBub3QgYmUNCj4gZmFpbGVkLg0KPiA+DQo+ID4gU28sIHRoaXMgbWVhbnMgdGhh
dCB0aGUgQ1hMIGRldmljZSBtdXN0IGJlIHNodXRkb3duIG1hbnVhbGx5IHdpdGgNCj4gPg0KPiA+
IGRheGN0bCBvZmZsaW5lLW1lbW9yeQ0KPiA+IGN4bCBkaXNhYmxlLXJlZ2lvbg0KPiA+IGN4bCBk
aXNhYmxlLW1lbWRldg0KPiA+DQo+ID4gLi4uKmJlZm9yZSogdGhlIGhvdHBsdWcgYXR0ZW50aW9u
IGJ1dHRvbiBpcyBwcmVzc2VkLiBJZiBhbnkgb2YgdGhvc2UNCj4gPiBjb21tYW5kcyBmYWlsIHRo
ZSBkZXZpY2UgaXMgaW4gYWN0aXZlIHVzZSBieSB0aGUga2VybmVsIGFuZCB0aGUNCj4gPiBob3Rw
bHVnIGF0dGVtcHQgbmVlZHMgdG8gYmUgY2FuY2VsbGVkLiBNeSBleHBlY3RhdGlvbiBpcyB0aGF0
IENYTA0KPiA+IG1lbW9yeSBkZXZpY2UgcmVtb3ZhbCBpcyBub3QgcG9zc2libGUgaW4gdGhlIG1h
am9yaXR5IG9mIGNhc2VzLg0KPiA+IFRoaXMgaXMgd2h5IHRoZSBEeW5hbWljIENhcGFjaXR5IERl
dmljZSBkZWZpbml0aW9uIGluIENYTCAzLjAgYWxsb3dzDQo+ID4gZm9yIHRoZSBmbGV4aWJpbGl0
eSBvZiBwYXJ0aWFsIHJlbW92YWwuDQo+IA0KPiBIbW1tLCBJIG1pbmQgc29tZXRoaW5nIGhlcmUs
IGJ1dCBJIGNhbm5vdCBtYWtlIHNlbnRlbmNlIHdoYXQgaXMgaXQgeWV0DQo+IFByb2JhYmx5LCBJ
IG5lZWQgdGltZSB0byByZWNvbnNpZGVyIGl0LiBQbGVhc2Ugd2FpdC4NCg0KT25lIG9mIHdoYXQg
SSBtaW5kIGhlcmUgLS13YXMtLSB3aGljaCBkb2N1bWVudGF0aW9uIGRlc2NyaWJlcyBPUyB0cmln
Z2VyZWQgaG90cmVtb3ZlIGluc3RlYWQgb2YgUENJZSB0cmlnZ2VyLg0KQmVjYXVzZSBtYW55IGhh
cmR3YXJlL2Zpcm13YXJlIGRldmVsb3BlcnMgZG9uJ3Qga25vdyB0aGUgY2lyY3Vtc3RhbmNlIG9m
IExpbnV4Lg0KVGhleSBtYXkgd2FudCB0byBpbXBsZW1lbnQgc2FtZSBzeXN0ZW0gbm90IG9ubHkg
Zm9yIExpbnV4IGJ1dCBhbHNvIGZvciBWTXdhcmUgb3IgYW55IG90aGVyIHN5c3RlbSwNCmFuZCBt
YXkgd2FudCB0byBvYmV5IG9ubHkgdGhlIHNwZWNpZmljYXRpb24gb3IgYW55IHNpbWlsYXIgZG9j
dW1lbnRzLg0KQnV0IEkgZm91bmQgIiBDWEwqIFR5cGUgMyBNZW1vcnkgRGV2aWNlIFNvZnR3YXJl
IEd1aWRlOiAyLjEzLjcgT1MgbWFuYWdlZCBob3QgcmVtb3ZlIHNlcXVlbmNlIg0KaHR0cHM6Ly9j
ZHJkdjItcHVibGljLmludGVsLmNvbS82NDM4MDUvNjQzODA1X0NYTCUyME1lbW9yeSUyMERldmlj
ZSUyMFNXJTIwR3VpZGVfUmV2MXAwLnBkZg0KVGhlbiwgSSBjYW4gdGFsayB3aXRoIHRoZW0gYnkg
aXQuIFNvLCBpdCB3YXMgc29sdmVkLg0KDQpNeSByZW1haW4gcXVlc3Rpb25zIGFyZSB0aGUgZm9s
bG93aW5ncy4NCg0KUTYpIEFyZSB0aGVyZSBhbnkgd2F5IHRvIGhvdHJlbW92ZSBmcm9tIG91dHNp
ZGUgb2Ygc2VydmVycyBub3c/DQogICAgQ3VycmVudGx5LCBhZG1pbmlzdHJhdG9yIHNlZW1zIHRv
IG5lZWQgdG8gbG9naW4gYSBzZXJ2ZXIgYW5kIGV4ZWN1dGUgb2ZmbGluZSBhbmQgY3hsIGRpc2Fi
bGUgY29tbWFuZHMNCiAgICB0byByZW1vdmUgbWVtb3J5IGluIGl0LCByaWdodD8gQnV0IGluIGZ1
dHVyZSwgc29tZXRoaW5nIHNvZnR3YXJlIGxpa2UgbWVtb3J5IHBvb2wgbWFuYWdlciwNCiAgICBG
YWJyaWMgTWFuYWdlciwgb3IgYW55IG90aGVyIG1hbmFnZW1lbnQgdG9vbHMgd2hpY2ggY2FuIG1h
bmFnZSBtYW55IHNlcnZlcnMgQ1hMIGRldmljZXMNCiAgICB3aWxsIHdhbnQgdG8gcmVtb3ZlIGVh
Y2ggc2VydmVyJ3MgZGV2aWNlcyBmcm9tIG91dHNpZGUuDQogICAgQnV0IEknbSBub3Qgc3VyZSBp
dCBjYW4gYXZhaWxhYmxlIG9yIG5vdCB5ZXQgbm93Lg0KDQpRNykgQXJlIHRoZXJlIGFueSBpbnRl
cmZhY2UgdG8ga25vdyB3aGljaCBibG9jayBjYW5ub3QgYmUgb2ZmbGluZWQ/DQogICAgRXZlbiBE
Q0QgaXMgc3VwcG9ydGVkLCBzdWNoIG1hbmFnZXIgc29mdHdhcmUgc2VlbXMgdG8gbmVlZCB0byBy
ZXBlYXQgbWVtb3J5IG9mZmxpbmUNCiAgICByZXF1ZXN0IGZvciBtYW55IGJsb2NrcyBhbmQgY29s
bGVjdCBzdWNjZWVkZWQgYmxvY2tzIHVudGlsIHJlcXVlc3RlZCBhbW91bnQuLi4uDQogICAgSXQg
bWF5IG5lZWQgbXVjaCB0aW1lIHRvIGNvbXBsZXRlIGV2ZW4gaWYgaXRzIHN1Y2Nlc3MgcmF0ZSBp
cyBsb3cuIEkgdGhpbmsgdGhhdCAidGltZSBvdXQiDQogICAgZm9yIHN1Y2ggY2FzZSBpcyBub3Qg
c28gZ29vZCBpZGVhLg0KICAgIElmIHRoZXJlIGlzIGFuIGludGVyZmFjZSBmb3Igc3VjaCBhcHBs
aWNhdGlvbiB0byBrbm93IHdoaWNoIGJsb2NrIGhhcyBsb25nIHRlcm0gcGluIHBhZ2VzDQogICAg
b3IgYW55IG90aGVyIG9ic3RhY2xlcywgdGhlbiBpdCBpcyBkZXNpcmFibGUgdGhlIGFib3ZlIHNv
ZnR3YXJlIGNhbiBhdm9pZCB0byB3YWl0IGxvbmcgdGltZS4NCg0KICAgIElmIG5vdCwgSSB3b3Vs
ZCBsaWtlIHRvIGludmVzdGlnYXRlIG1vcmUgaG93IHRvIG1ha2UgaXQuDQoNClRoYW5rcywNCg0K
LS0tDQpZYXN1bm9yaSBHb3RvDQo=
