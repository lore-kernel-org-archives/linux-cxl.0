Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3225EC636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 20:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAaUY1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 15:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjAaUY0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 15:24:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41249953
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675196664; x=1706732664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IpQEszewnQz9oJ+FxI3D7ruRO+nH2ttfjrT1KSzqb5A=;
  b=YH2Z9o4ADIGq5DeealUUkJJmjZNungdHTu1qRYMe/c8yfgGWDkDGbs7d
   jjBQd8AoGdK8mqZPXNfCeRKxMhDS14gipGvkIAJvRjNp7FXIesG+iEHos
   k5YBS4D5u/UC2J80oh6Pf7IoESYU3MHrgiMzOv8iSI02zbOP4KguesQBY
   ULE3cIF9lg9XCGt/UiXm+x8qODRGcLmryyopgnFeVmWDeejRIJ7i2JOwo
   ltEV2DR1Nb44XZakaOCYtgN0aMBuqVPD71lYlSmCdMRHU6cYzXd6jp4G2
   OBbO/EMBincP852latMGIioM5Ai+/t1zxoYkBGbvXrwmhXg2D4iTru16p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315918468"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="315918468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 12:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="753365709"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="753365709"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2023 12:24:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 12:24:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 12:24:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 12:24:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWUZF+/jGJaDnOugxctVBfu/f3S4TZ8ZkR6tkehus5J66bXXk6anem7MgBMd7KwM3h/Ph6bzeC99VFCFZfZaVgH8JpBYZs+DLV9mmxAybIe3sAxj+Pxdyiea/Zw2OtPjqlpNcZ0MlE+u334LiEr0+ESuwopEB9bqCw9FUVcbpxeMCKdhM8MiNNLeHvh8HJkmw2AXS6CQoJ/HFrwiXuVNfeJ2P3v4EDt48g85zW08GjeD9VWAtBOMUnZ+1m4yxM2frdTfkxNgDn0Bbv/pAaLvtXpBqYEwXZjREBo4vElqAf3LR2JEJVWfELCVOZgb6lDPp3fP3LAEBmA9wAKJ52HVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpQEszewnQz9oJ+FxI3D7ruRO+nH2ttfjrT1KSzqb5A=;
 b=T4XXg97mT2Ry3YmvqezztAP83/qCDBCtwRJ+azYhurhpmwSudkwenAzUIkxcONToD2+oKZMjvie2cE96lqdvItBfe4oXEj7gF956dPhpae7Bm9MLx7SiZ/9FBqwQ8MSThVVnQIvFPVbfQ08rfGwo/JWt/LEdRpNDrompKOIwNKYsWjQwTIV8O6EL5TMmdUVemh+d2/Lw32CHETLJf+xcwFPIkNKebwopjefEVHXnXWA5CZEKz7Cp1P2ng/g3RuxjA/wykPJ3bJTmqm75nqGblfEmhDoYEJwWc+fXOyI2r4XA9SuQr42C6OdsXdypRM5VWmQR6HARfAry0nlPMQGB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 20:24:20 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 20:24:19 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "gregory.price@memverge.com" <gregory.price@memverge.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Thread-Topic: [GIT preview] for-6.3/cxl-ram-region
Thread-Index: AQHZMU8Tzl/mI+opREuUxaim5hiM666wPGeAgADPFICAAAxKAIAF8J4AgABisQCAAA13gIAAJzQAgAAtVgCAAQvNAIAAEceAgAAMAACAAAq0gA==
Date:   Tue, 31 Jan 2023 20:24:19 +0000
Message-ID: <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
         <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
         <20230126185025.000016a0@huawei.com> <20230126193424.00005034@huawei.com>
         <Y9fRVu+yLza4d5Vt@memverge.com>
         <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9gva49IPFOXYlkH@memverge.com>
         <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9h2VhGuraZfEJfD@memverge.com>
         <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
         <Y9ll5S3Y4BZkakNn@memverge.com>
         <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
In-Reply-To: <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB5295:EE_
x-ms-office365-filtering-correlation-id: df3f6688-0eec-42e2-b456-08db03c92217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k9KqteM2MkmBTcPxOf4tamXThqlazlgf9iccuhza4TQ7HRXgibR2a0zPoUwsiTxJl/EioBpQO26ZGm8yd06Zmdba/mHq5v58HIZQqqAA8KdMPRprkO1gQAM93kYfReD8sSMcR4hVx37hfp+b6sqBVGVe7HfqtfUPADs7wvTuN+bGNftwLwHjpQjp0Ra6zSKfs9cEq/+a094HW/oAm6/uw02MDu0rcSJO10l165DxJyaXsw25Qd8V+oXIXJ0w6+AZKQus58qoji1myBIykv/FgMS8KbLZuWxZuhl+fOGzW5pzewAypswKlaxp3HZ0ImJd8nH9Z02Zt6okH/LNyA9zhZGEKFTGLU7HNjHi3KO+BAZAZ6PcRuMKIrcYeH847Wzq3ZUafoLhgvtla/fc8Tfhzsw4jTSiD8/qlvRU+ro7f3zrL7OPajKm/wn2T+U1/qFjmt8ipaFo1kJfCXclcIGQL139nUAdfrZxESZoTv5eY1EzgZtp95CJsjIX4i/o8bY4Ocjr6vJupDEQfFkdrVV+Exk2XY6NWGbnOLBizExws/PO7jECKRegMTQEpu5KGnWbq/oGcEktPQShEWSxE0JC5+I4bGPxzCVEYATZrF1aZmTpPXnypgDXFHHJ4f+2SeS2mdruERZ7VhFPwjCVDFo7Lp4c9VgdGCggwgeXe0LQq1jEZyuwEo8LrcfO/WY1XbHDG0VoQeuIvufTLU1IaYqnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(86362001)(36756003)(38100700002)(122000001)(38070700005)(82960400001)(83380400001)(6506007)(2616005)(26005)(6512007)(186003)(71200400001)(316002)(66476007)(8676002)(54906003)(6486002)(478600001)(2906002)(64756008)(66556008)(5660300002)(66946007)(91956017)(76116006)(4326008)(66446008)(6916009)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmZuMmtyUkM3ZWVIelZsNlk5OG5MUnJvNUx6TkR4UnJ0dUE1cWUvVkhWYzVR?=
 =?utf-8?B?akhJVUlEcG5oN1RPN0hxb05nVHRiOHY1Z0VpSFdldVVORjh2VTRnelc3TFp5?=
 =?utf-8?B?S3hPVmJWOGI3bzh3REhDUHE2aVpXbit3T3ByRXIvUE9ZMTVyMHhxVEFCd281?=
 =?utf-8?B?YTlYWThXUW50L050TG5FUUhVdW5PZDMvNU43d2RiOEM3bmJmdlFCL0JaMWpn?=
 =?utf-8?B?dmZiNzMrTmhvYTZWSjhkcmFJZngwM24xcEZUMnpyV0ppdzhKMjIrWmFVY3lG?=
 =?utf-8?B?TUdvYVBsNUV1OEVWZmh6S3V0aDM4Rzh3dzI5azkxUDRscnV2dm1ZMENaSFZp?=
 =?utf-8?B?OE00VFZZZGs3OFJuNytYdkNEZzdOdUdzNGIycDE5QlZzWm5zR254RVltR01n?=
 =?utf-8?B?d2VaZzM2cC9wT2p5T1Jkd3JCQ0F6TUpVdERQNi8rb0M3NlRWQy9pNzdDNnB6?=
 =?utf-8?B?V2ZOTWJDbU54VDFkK2VSdGk3Rzd6Z1gwWEl6MGlWWm95NDcyU0l5OGJyV2l2?=
 =?utf-8?B?UkxYdG5TeE5OZGdUVnUxT0ZiajdYS2kySzkzcm8reDJwdFhVVjlkblBHS3BF?=
 =?utf-8?B?Z1FJeGJhZ0NzTjRleXZ2QlpSVER4dEV4M2cyWEM0QlJkaE1WQkdIa05UVXNa?=
 =?utf-8?B?T0tJV0tVd2lWRlB2NExuSkl5ZFFHN3FybXhIcndBU1hWcDgxT1RZckpLS3A1?=
 =?utf-8?B?ekZmZHRqeU9OeS9NeGpwcFM1ZTg3TXFiOElrenZZUWUwQjUvNE94WVY0N2E3?=
 =?utf-8?B?aWRGTkNVRmVCUHlVZmk0Q1FnRU93NjIwR0h2dFBnZGJIRWNzQ29rczk5ZmUr?=
 =?utf-8?B?Q3QxSWgrbXdYU0podGcxTWNZMUVzQ2g1RHN2ak1WYkhEWjF0OW03VFpQNy8r?=
 =?utf-8?B?OVJkRFBqcjhja09rbmJJbDE2Wnd6LzVuNE9MM0NmZ1loaFQ0aE11RVp5RU5l?=
 =?utf-8?B?MmZMMVZTZlUzeFZjNnlDNzJacnU5RUN1MWQrYmpScFlxeEpuV25ramNDcUg0?=
 =?utf-8?B?cGxpcGY2WjNUeHU0N3N0VXI0OGJZTHlsM1JtN0k3NnlZV2Z2aGovVjVlcHVo?=
 =?utf-8?B?dUI3dXB0aW0zZ3BWMXJEUkh5MjNmYnA1MXhaQUNhTkZXRm9MaktEa04vYk1w?=
 =?utf-8?B?MXlwbDNxYzVrdTNiOVlGVTRDbmpqMGsyVHhpRmZxWlNEODFNU08xb0ZIQ1Nx?=
 =?utf-8?B?REVyZ1ZtQVhBdmx4ZEpSZGRRZ3k3cDl6Qk1Va1Q0Wm9qS2RkdjI4TEdveThy?=
 =?utf-8?B?MG4xbmRWN0dYMzZoK2Z0N1JNcXV2c0xnQ3JzSUIxUDZtU0UzNWVkdzRkR1ZL?=
 =?utf-8?B?TStWY1hSOU9IRnhFU1ltZnU1VXdQM2c1MEdsRUZYV3dNK1B2d3RqaVRPNE54?=
 =?utf-8?B?MVBkeElHcHR4M2M4dzZna1hZb3NqcnpoemhkN0tFcG4xeEw0YVhxc3NxaFpL?=
 =?utf-8?B?dFNQeUY4T0JrN0VQT0ZWUCtuQTE3V0lZRXBaaUFGcldiMDNiSEV0R1ptLzZm?=
 =?utf-8?B?a0R2b0M1Wk9Xc2k2UGp1ekVFSHNMZkJ5ekx4WDdYd1IyMkRkbjZ0U0FHc2ww?=
 =?utf-8?B?YzY3aHZvQWhWOG5zRnIxbGVvUGV2RjJkbkYzK3ordXZnNzNBWURFcEVnMmU4?=
 =?utf-8?B?cUJqSTI3RGVEVHpJU1BDNUU0MGZXbzF0SEsxV1E4ZzI5djFpZmMzQ2JyYmhK?=
 =?utf-8?B?Z2J5VTdmaGljb2lna2s4eG1DYUgyd3lGcFJzYnYvSnlzLzhablZBNzRKdFVU?=
 =?utf-8?B?QXdFWW1zcWVibkhjckxEanhCdEtTZjFkQ3BzOVF6TU9BWXVHRVFQVjVsWVN5?=
 =?utf-8?B?TmQxZ3R1ZitMOHBLTW14T2UrdjlnT2xvdTJTYzN1TUxRQ2xSMUw3Vzg4YnBJ?=
 =?utf-8?B?VkNuUGN4U0doVm9WVzlBbHRWUVRkSUZJdWlmeE1mbE9qYitVbGZ3TTVZUzJo?=
 =?utf-8?B?NzJtMkR0Z3IwY0xnNEJFejlhdlFOSWhGZUQ1UEFsMXR0VzVnWnB4RkptdEdT?=
 =?utf-8?B?WWV0RTlObkQ2anpvd0ZTOCt4dEpyQ0x1K1hkZUxEVk84ckc4OXFaaVVuaFhB?=
 =?utf-8?B?UjRIUnVVQ2Fobm54TkFmUWtuVWRWWGRUM2ovTnZqZC9xbXRJc2JRa1FvTWpX?=
 =?utf-8?B?czFPN2pMNXF0aXpFaWtSTzU5Y2dENGpocHMzbFUwb3FUb0JUR3RqTGl4dW5l?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBEA7415A947A846A979985E0B8EAF5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3f6688-0eec-42e2-b456-08db03c92217
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 20:24:19.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyOeKDbZry5ccY5Hsi029hRpwWL2uBoqRPcckyB9Th8n7bTUpckN5c3sh1BwJOheiCur0dBot3VVURcIHcCbszcG0NJf/SLRZ5gdtdzjYNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDE5OjQ2ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMy0wMS0zMSBhdCAxNDowMyAtMDUwMCwgR3JlZ29yeSBQcmljZSB3cm90
ZToNCj4gPiANCj4gPiANCj4gPiBSaWdodCBub3cgSSBiZWxpZXZlIHRoaXMgaXMgZmFpbGluZyBk
dWUgdG8gdGhlIGludGVybGVhdmUgYW5kIHNpemUgbm90DQo+ID4gaGF2aW5nIGRlZmF1bHQgdmFs
dWVzDQo+ID4gDQo+ID4gLi9jeGwgY3JlYXRlLXJlZ2lvbiAtbSAtdCByYW0gLWQgZGVjb2RlcjAu
MCAtdyAxIC1nIDQwOTYgbWVtMA0KPiA+IGN4bCByZWdpb246IGNyZWF0ZV9yZWdpb246IGNyZWF0
ZV9yZWdpb246IHVuYWJsZSB0byBkZXRlcm1pbmUgcmVnaW9uIHNpemUNCj4gPiBjeGwgcmVnaW9u
OiBjbWRfY3JlYXRlX3JlZ2lvbjogY3JlYXRlZCAwIHJlZ2lvbnMNCj4gPiANCj4gPiANCj4gPiBh
cHBlYXJzIHRvIGJlIGR1ZSB0byB0aGlzIGNvZGUNCj4gPiBzdGF0aWMgaW50IGNyZWF0ZV9yZWdp
b24oc3RydWN0IGN4bF9jdHggKmN0eCwgaW50ICpjb3VudCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHBhcnNlZF9wYXJhbXMgKnApDQo+ID4gew0KPiA+IC8vIC4uLiBzbmlw
IC4uLg0KPiA+IMKgwqDCoCByYyA9IGNyZWF0ZV9yZWdpb25fdmFsaWRhdGVfY29uZmlnKGN0eCwg
cCk7DQo+ID4gwqDCoMKgIGlmIChyYykNCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmM7DQo+
ID4gDQo+ID4gwqDCoMKgIGlmIChwLT5zaXplKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgc2l6ZSA9
IHAtPnNpemU7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZGVmYXVsdF9zaXplID0gZmFsc2U7DQo+ID4g
wqDCoMKgIH0gZWxzZSBpZiAocC0+ZXBfbWluX3NpemUpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoCBz
aXplID0gcC0+ZXBfbWluX3NpemUgKiBwLT53YXlzOw0KPiA+ICoqwqDCoMKgIH0gZWxzZSB7DQo+
ID4gKirCoMKgwqDCoMKgwqDCoCBsb2dfZXJyKCZybCwgIiVzOiB1bmFibGUgdG8gZGV0ZXJtaW5l
IHJlZ2lvbiBzaXplXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKirCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVOWElPOw0KPiA+ICoqwqDCoMKgIH0NCj4gPiANCj4gPiBTbyBib3RoIHNpemUgYW5kIGVwX21p
bl9zaXplIGFyZSAwIGhlcmUNCj4gPiANCj4gPiBlY2hvIHJlZ2lvbjAgPiAvc3lzL2J1cy9jeGwv
ZGV2aWNlcy9kZWNvZGVyMC4wL2NyZWF0ZV9yYW1fcmVnaW9uDQo+ID4gY2F0IC9zeXMvYnVzL2N4
bC9kZXZpY2VzL3JlZ2lvbjAvaW50ZXJsZWF2ZV93YXlzDQo+ID4gMA0KPiA+IGNhdCAvc3lzL2J1
cy9jeGwvZGV2aWNlcy9yZWdpb24wL2ludGVybGVhdmVfZ3JhbnVsYXJpdHkNCj4gPiAwDQo+ID4g
Y2F0IC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lvbjAvc2l6ZQ0KPiA+IDANCj4gDQo+IEFoIC0g
dGhpcyByZXZlYWxlZCBhbiBhY3R1YWwgYnVnIGluIHRoZXNlIGNvbW1pdHMgLSB0aGUgc2l6ZSBh
bmQNCj4gZXBfbWluX3NpemUgZG9uJ3QgcmVmZXIgdG8gdGhlIHJlZ2lvbidzIHNpemUsIGl0IGlz
IHRoZSBjYXBhY2l0eSBvZiB0aGUNCj4gY29tcG9uZW50IG1lbWRldnMuIFJpZ2h0IGFmdGVyIGNy
ZWF0ZV9yYW1fcmVnaW9uLCB0aGUgcmVnaW9uIHNpemUgaXMNCj4gZXhwZWN0ZWQgdG8gYmUgemVy
by4NCj4gDQo+IEhvd2V2ZXIgdGhlIGJ1ZyBoZXJlIHdhcyBhIHBtZW0gYXNzdW1wdGlvbiBJIGhh
ZCBtaXNzZWQuIFdoZW4NCj4gZGV0ZXJtaW5pbmcgc2l6ZXMsIHdlIG9ubHkgbG9vayBhdCBwbWVt
IGNhcGFjaXR5LCB3aGljaCBpcyB3cm9uZy4gSXQNCj4gaGFwcGVuZWQgdG8gd29yayBpbiBteSB0
ZXN0aW5nIGJlY2F1c2UgdGhlIG1lbWRldnMgSSB1c2VkIGhhZCBib3RoIHBtZW0NCj4gYW5kIHJh
bSBjYXBhY2l0eS4gSSdsbCB1cGRhdGUgd2l0aCBhIGZpeCBzaG9ydGx5LiBUaGFua3MgZm9yIHRy
eWluZyBpdA0KPiBvdXQgYW5kIHJlcG9ydGluZyB0aGlzIQ0KDQpJJ3ZlIHVwZGF0ZWQgdGhlIGJy
YW5jaCBub3cgd2l0aCBhIGZpeCBmb3IgdGhpcy4NCg==
