Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9450C636CD
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 18:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjAaSAJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjAaR77 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 12:59:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968DA21948
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675187980; x=1706723980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M0wrMqG/qxtAJSkp6hMoapZanus1xOQjB/ejh6sV1LM=;
  b=Ef4tWlQwIgy2vM7XqmYvjiZRxo0Jdelk8zOG+fCPs9gp0YTaZ7zQxIOt
   3xh0VuL9q+rWV+vy/YxlE6ObvogAmaromAFAOyo70aelnQ8moHhzoyNaa
   ahIA9Wd2xNOiXhiOIjZmHB6419mirBdcM4NbJjQ5wNSVUBiMe3nXo7NbS
   CJiXl4WLRizpz/72v2hFsbPoUAyPuxLQlhCKvbhtkje/OuUxysazoVXcF
   +15vw8dCwz1gk/rtPcCmGCMfSChLiV7HTuouwLDGSe/koxZBtiLELc5AR
   i73YiQIzBOg//VR2LfORtl7hX1Of3AiUwl6bM6yzHP/Oy7VTHIJPECZCE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="311530189"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311530189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="807220817"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="807220817"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2023 09:59:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:59:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:59:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 09:59:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 09:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anREapUMpngLk+7A0aL2C8o1Ksdz4PkXAJPsCPYJkh0HklcrclHAd3q/NG/C+ocsTJqIvhe8TRgkpPddQYsDXjTrMFXGZdRialZTMG4Gg4WkHoS5GiyayzQ3UmbCW/pHSzimCAJ6/rRvZSAtalFTe1BzPOz0Pliw9I3NHG75o27rNUT+fjF9g3HWrcxOQGeUtsZGG1I8XNHm6Gdkf7iZCqHALv2g4OH/XzTPeTIPh1KWnKKps9ntlWH7pWcA1SWnB+6N6RQTnMaeHiGbqlrph0NpwHD07eniABmRoqyBc/mlmOaq2ZMerbnjX2Zn6PS8ZowjM7Z+uTwG3cGUwt9oEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0wrMqG/qxtAJSkp6hMoapZanus1xOQjB/ejh6sV1LM=;
 b=obM3xPGsiKOmD/aaQnHPwouhgCyciCvxNp88N5vI8V4OR+XghKLF0I60JDMm8k1VJkMLeaSqmi5d67ZU6d91wEv5++XZnsCzfGuCGc5Y26h3HmU43Kr2xBw2/643UTsJPmUiXbvompQTansKY4l5d3nivInGg+s9GmEj91C78aDU7XdHnsVrCnBlNLwqWATtMDaxszxnCUzbMcfHOjI6cgtw0IB0+EJ5B4RacryAAF7UZlO6sb05Quv8aTFnd2/bnm81qv4YDXJyTyeIrrhPe0J0tKe8AF7HmAqbeBuCVSZ9HqsVWiEc3pXBARbvc+5KHHzmggc8PVuvez84teoAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:59:26 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 17:59:26 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Thread-Topic: [GIT preview] for-6.3/cxl-ram-region
Thread-Index: AQHZMU8Tzl/mI+opREuUxaim5hiM666wPGeAgADPFICAAAxKAIAF8J4AgABisQCAAA13gIAAJzQAgAAtVgCAAQvNAA==
Date:   Tue, 31 Jan 2023 17:59:26 +0000
Message-ID: <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
         <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
         <20230126185025.000016a0@huawei.com> <20230126193424.00005034@huawei.com>
         <Y9fRVu+yLza4d5Vt@memverge.com>
         <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9gva49IPFOXYlkH@memverge.com>
         <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9h2VhGuraZfEJfD@memverge.com>
In-Reply-To: <Y9h2VhGuraZfEJfD@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BL1PR11MB5953:EE_
x-ms-office365-filtering-correlation-id: c1aabb3b-8f5c-4722-e394-08db03b4e482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nl4WbeSw/f6/VqIVJ/kXWo0gu9Keh3uleMHxWShna1H+n+SIX8VUQB9UcmbTPTJynI9fd+m32OppbxdgQTTplBAFgIgGGi21jAJHsvR7YxMYtxPZPvsk7QFxOtZpG4S2q36RAKcVChsl4sIW+KaMq3xlMQUXwHAzy+FNKahFsAr+GwD8cCf5Yl62vovawTjbD5u3TD8Nh7yPoVAw++r8RlSwt/xRpzpQlHImp9QP7Mdanrf4Q0bDos4nTy0485TkVr8wI4+QYaYsOgj6AGyDfXsUhbQbX9txd7U7lLueGYWR1NHBwDCQuSAxRlWhf1KVzBdcaPBWb+1FL3lv5QLhelha3kpltkDtEl0r6lpwwARBKfYdbPwgnC3LqEkCZSpkiex8u9hhaAZsXWQEPSzw8g2KRjOobxqM+WBvBGp2xe9Frbs7jfaYZ/4QVasBsPaHCCfLt9OIqb4UdmmjThjgVYN81e4Pc/VL4HrZEi7hSWy0dobAJ1gWanl+mSSnpfi87Z16lU704sHb/fxcMvTRtVqB/niuS/n6oAPZbB3IYwoKJ/hG9W/QtVmdSllG3ZGN6B1ah3tzb4H/JgvjH6pVQ0VJczxj5VZCuBhLT6EbqK37kQbz3B0AcvBLRIcZOBzMHfiLOeZID8wXCY+boUZqC4b52pRz4x0l4ScH+RoGa51hIkuPq2oJ33x3tdfQkoQ8EnR60cBjJDmRP+iT7HayH+q8DAZBlcC75AUpkUE7+KU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199018)(2906002)(36756003)(2616005)(110136005)(316002)(54906003)(71200400001)(966005)(6486002)(186003)(478600001)(26005)(6512007)(66556008)(4326008)(6506007)(64756008)(76116006)(66446008)(66476007)(91956017)(38070700005)(5660300002)(8936002)(86362001)(41300700001)(8676002)(66946007)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVNeUg4SGRxZGNRUlVubGxLN2ZyL0lDSnJ6L2pjVldXY0hSUXZISDRFWjJD?=
 =?utf-8?B?M3ZxRnN1SjRKTHNwQ1ZxNVRUNG9idHQ1ZDdVQi9SZlRUVFBjTzVLMzVOWHRZ?=
 =?utf-8?B?c1BrM1E1U2o2cUxkVWo4ZkRYT3AyUEJDM2g3S3Z4ZmdVTTJKU3lTNGhWQTNO?=
 =?utf-8?B?amVINlpnSlFodzRzN2lFMmlHdkRaelAvQkgvVmVzTE5MVHJYWXcyNjFTSmZX?=
 =?utf-8?B?UWN5d0prWEh5M05zaHBSUC9pd2xucEpYNWM4MzEzVnM4M2xPb3RJRWNqaWJv?=
 =?utf-8?B?ZFhJUVVmMnZlNS9EY3Q0cmNpYmtFN3hka1JqNWFReEo1KzYxZlRBZml4c3h1?=
 =?utf-8?B?VUE5eDBFWVJtRFBRc29Ddnp3eGl1bjBvSkgzRU5HbHRBYlF3YW1BMWUxMVRh?=
 =?utf-8?B?bXFQRk8rdFU5eTZJR0NKNEJhcmVDUVRiTmsyN2tERmFJM3p2U2x4YVpMOUdj?=
 =?utf-8?B?bmdkVzZNdUtMTFNLVE1jaHlIR0ZIa3AxcjVIbDJxWks2ODBTRVZsRFYzb2dV?=
 =?utf-8?B?bFFockZQRlA4VXl3bUFmdTJESTJad0tCVFlHblRGdWdmUjVsbVJFY0dyYm1N?=
 =?utf-8?B?UXlVeFgrbXEzandKWnFCa1VQdkRnTzRLNGNJWEsraDNLTVMyb00veDNUK2M4?=
 =?utf-8?B?SEhTK3VOM2RwM3hFSkJFeTl2cnpQTllEdkhrWGp5OW9kRWIwczVRVWRiOG4y?=
 =?utf-8?B?Z0t3b0JqOHZ1MFZoaThicVJmRmR1UzF4UGg0LytxV3VFV2UycndrZGUwS08v?=
 =?utf-8?B?T2xDNnZMbG9KcHpUek9nL3FTMTFBcnE0ZUZSaTZEOGdncy9mZ3VkaTlKQ0ZS?=
 =?utf-8?B?MWxkMnJZcEYvdzJ4ZzR1aG0yMUI4aEFtUnB4YUMxb1V1WnJHcFJVeEpOZzBV?=
 =?utf-8?B?QlhQc3VBa016aW1EeWVPWFJUTXRhYlV4a0FmNnFMbXJvYXdYbUNhZnlVQy9K?=
 =?utf-8?B?RUxSWGozeGptalBaRUR0dEpMU090MVllREt4cno3eENza3hwbEppcE1SWGM3?=
 =?utf-8?B?UU1YYUwwMGx6blVJRmVXT3MxK1kweWdnRFJDUitqbnpLcGthZGlZYVFNVnZY?=
 =?utf-8?B?RVhrdk1DRjd6VWdYakQ1Q2FSWDRGTm5Oak9tVFdVTzE4OWhaekRCMERMYTV6?=
 =?utf-8?B?MVVhMDMyQmordVg5QTY4WlVBbkd4ZHE5dWJIaVJkMmR6L0Jzdk1kT3hzVUFR?=
 =?utf-8?B?THo5TUxWbWRQTHRFUnE1ZmFGcENvYXp5VlU2bnlYa3JEeW9RNVlkTEYrczBB?=
 =?utf-8?B?by9IVnNqRmxSN3p1NW1BRlhGamFBWi9Nclp4TE5aSURXUStESzFiaU5naWtB?=
 =?utf-8?B?aDRodFRudjZTUzUxZ0hMMEpBVm1MYjdSWVFPSXlkSHhOdXNYZnZKMEt4Q3hD?=
 =?utf-8?B?SXh2QmRGc1JiMXNRZS84aFFEQS9aT2dMTVF5U3dEQVZraXFmWG1QMlpCdjdH?=
 =?utf-8?B?bm9BSUJSREQ3d2RRRURzOU1qOGN6dmVyNTQ2a1hzYTkzd3Bwb0xuYTVETWM3?=
 =?utf-8?B?U2Y5eXJXUUN6QU1ZblVNNnBsbExJaXpMQmJZS0hBT2VhZFJJK3JKQmVxTUlY?=
 =?utf-8?B?M05EaG8wUUdpM05UUmczOE05UDJrZXd3UTV4bWt5bzNISDRKaFA1Znd4QUt1?=
 =?utf-8?B?cVJxbDZIaVVmZVFiU2ZKZU1DaitLQVBFVEVSSGtSS2lyWHN5VHhIbnM2dG1D?=
 =?utf-8?B?OWNSbmcxNWZqb0UwUThUSGFCcTEwNzFYb0NRb212Sk9RV3BJRlZPZmh0ZVc1?=
 =?utf-8?B?c0hUbTZNZmFVZ0x0Vmk4Zk0zY0VKbVljNE13alFWOXIzSWFVS1VENGNaNXcy?=
 =?utf-8?B?aklyR2hWVFA2L0JCSHprTXBkZ1VQWkw1cm5ZcWh5WmxuNFBhMCtpU0NjQzIw?=
 =?utf-8?B?QjkyR0hBbWVMQ0YreG1sL2RqNU1jdU41OUh0MkJRV0d3d2pKRjBFRU5TdXph?=
 =?utf-8?B?L1BBY0dKVjdmdHY4R0dtOU9GUFVqSTlUWHpSVWFTak5rMThwa1E4Slp3TzEv?=
 =?utf-8?B?TTJKMy85RGVrZjdaRm9FZHVMMmtJZzkvb2E4a29VOUI0b0hJWXJocjdHOEd1?=
 =?utf-8?B?WC9GYVdDdm9sODljTnRTZ3MwN2JHdG9RSDkvTGx1Q2x4WGc1R0dxRDJtSzNi?=
 =?utf-8?B?TXBaRU9zVzFkSFdYdGtyUWZHaFR6TmdvL01RWlk4ZXo4T1JqTlRGQ2RpVGhG?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <490430C3FC8EFC48B20CFE7FAAE83B46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aabb3b-8f5c-4722-e394-08db03b4e482
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:59:26.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77Kr4zzVurvTOPoDo97jGMIaacVjSS4SRcNQhVT3hrebN3kymClnVnrEdQBv56bTWT8uIRHNeCUn27WUFjB8UDqK4C6pUBq4mzgxzzjZ6yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDIxOjAwIC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0K
PiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAwMzoxODozOFBNIC0wODAwLCBEYW4gV2lsbGlhbXMg
d3JvdGU6DQo+IA0KPiANCj4gVGhpcyB3b3JrZWQgZm9yIG1lLCB0aG91Z2ggaXQgdG9vayBtZSBh
IGJpdCB0byBmaWd1cmUgb3V0IGhvdyB0byB3aXJlDQo+IGV2ZXJ5dGhpZ24gdXAgLSBzdGlsbCBu
b3Qgc3VyZSB0aGlzIGlzIGVudGlyZWx5IGNvcnJlY3QgYnV0IHRoaXMgaXMgdGhlDQo+IHN0cmlu
ZyBvZiBjb21tYW5kcyB0aGF0IHdlcmUgcmVxdWlyZWQgdG8gc3VjY2Vzc2Z1bGx5IGF0dGFjaCBh
biBlbmRwb2ludA0KPiBkZWNvZGVyIHRvIHRoZSByb290IGRlY29kZXIuDQo+IA0KPiBOb3RlOiBU
aGUgcm9vdCBkZWNvZGVyIGhhcyBpbnRlcmxlYXZlXyhncmFudWxhcml0eT0yNTYsIHdheXM9MSks
IGFuZCB0aGUNCj4gcmVnaW9uIGNvZGUgYXBwZWFycyB0byByZXF1aXJlIHRoZSBzYW1lIGdyYW51
bGFyaXR5P8KgIERvZXMgdGhhdCBtZWFuDQo+IHdlJ3JlIHN0dWNrIHRvIDI1NmIgZ3JhbnVsYXJp
dHk/ICh1bmxlc3MgaSBtaXNyZWFkIHRoZSBjb2RlLCB3aGljaCBpJ20NCj4gYWJvdXQgNzUlIHN1
cmUgaSBhbSkuDQo+IA0KPiANCj4gQ29tbWFuZCBzdHJpbmc6DQo+IA0KPiAjIFByb2dyYW0gdGhl
IGVuZHBvaW50IGRlY29kZXIgZm9yIHJhbSBvZiBzaXplIDFHQg0KPiBlY2hvIHJhbSA+IC9zeXMv
YnVzL2N4bC9kZXZpY2VzL2RlY29kZXIyLjAvbW9kZQ0KPiBlY2hvIDB4NDAwMDAwMDAgPiAvc3lz
L2J1cy9jeGwvZGV2aWNlcy9kZWNvZGVyMi4wL2RwYV9zaXplDQo+IA0KPiAjIENyZWF0ZSBhIHJl
Z2lvbiBpbiB0aGUgcm9vdCBkZWNvZGVyDQo+IGVjaG8gcmVnaW9uMCA+IC9zeXMvYnVzL2N4bC9k
ZXZpY2VzL2RlY29kZXIwLjAvY3JlYXRlX3JhbV9yZWdpb24NCj4gDQo+ICMgQ29uZmlndXJlIHRo
YXQgcmVnaW9uIHdpdGggdGhlIHNhbWUgaW50ZXJsZWF2ZSBncmFudWxhcml0eQ0KPiAjIGFuZCB3
YXlzIGFzIHRoZSByb290IGFuZCBlbmRwb2ludCBkZWNvZGVycw0KPiBlY2hvIDI1NiA+IC9zeXMv
YnVzL2N4bC9kZXZpY2VzL3JlZ2lvbjAvaW50ZXJsZWF2ZV9ncmFudWxhcml0eQ0KPiBlY2hvIDEg
PiAvc3lzL2J1cy9jeGwvZGV2aWNlcy9yZWdpb24wL2ludGVybGVhdmVfd2F5cw0KPiBlY2hvIDB4
NDAwMDAwMDAgPiAvc3lzL2J1cy9jeGwvZGV2aWNlcy9yZWdpb24wL3NpemUNCj4gDQo+ICMgTGlu
ayB0aGUgZW5kcG9pbnQgZGVjb2RlciBhcyBhIHRhcmdldCBpbiB0aGUgcmVnaW9uDQo+IGVjaG8g
ZGVjb2RlcjIuMCA+IC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lvbjAvdGFyZ2V0MA0KPiANCj4g
IyBDb21taXQgdGhlIGNoYW5nZXMNCj4gZWNobyAxID4gL3N5cy9idXMvY3hsL2RldmljZXMvcmVn
aW9uMC9jb21taXQNCg0KSSd2ZSBwdXNoZWQgYSBjeGwtY2xpIGJyYW5jaFsxXSB0aGF0IGluY29y
cG9yYXRlcyB0aGlzIGZsb3csIGFuZCBhbGxvd3MNCmZvcjogY3hsIGNyZWF0ZS1yZWdpb24gLXQg
cmFtIDxvdGhlciBvcHRpb25zPg0KDQpGZWVsIGZyZWUgdG8gZ2l2ZSBpdCBhIHNwaW4hDQoNClsx
XTogaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvY29tbWl0cy92di92b2xhdGlsZS1yZWdp
b25zDQo=
