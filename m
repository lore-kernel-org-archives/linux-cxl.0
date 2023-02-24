Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57767C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBXASn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBXASm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 19:18:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD148E0E
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 16:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677197920; x=1708733920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0vKyfUgfnhayr5Y3YwwGeI1HW0y1dFPt9xK3SQEOY8g=;
  b=Vkmh1lrGOO+nG443M4R4hQ2DbzXMy4J87spXlxYK9WapLeP4h1qZP+5e
   Glv4xkv8gD9Hy6f0aQpBYa9Hd9CqeNvBK01zIQ53iSM/7p2ZNfM5iGTol
   muPWOp3u4w/AnZDn24LOabzSb3x1qCAJ3GQHNpdKAd2IWU6SbSsX5vJ2e
   8CMq4NX05PEzko9yygVbQH1bdrKAATjEAdKHenipu/vJ1rbSO+55JGUFV
   0qzFUh6dsf/i4yuU6L3WQsX12N+wJ4rfbuFMt8i5cM/i/CemhimHaiuKF
   gkStoEAft6PlQWVxyQZvrZ8JOwdUAnQmUo/YXsZQFVj8yAqUn9g88w/m7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="360861615"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="360861615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 16:18:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="705057280"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="705057280"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2023 16:18:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 16:18:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 16:18:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 16:18:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 16:18:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFdfShDEtE90AcYaRjdUatrg53hd7HOMl5jYXEd2P6z+8E/fwWwz39y+vFL/EtuOizThoGvyY9vgH/pdWzOx1YHcZWeSmM4J9eY/8/NF8K02rK+JVnnJT6KNnItr65OYwjJToTv+WvxE9NEMdpd5P979njpfWCDnqRitVKKLjN80LaJyUSfbQaj2Pj2oGanApzbZNxk7c60k3UH2iqk9csVvid46E5iIMcaAHqajiER45+GQnvZ3HoUsmf6+bNlK43zzAJ1+z/X1r/gupmJ95kA8JVW7A0yAOJ8aV89bSHzNG9JNBtzImGhky9858uHtDSoEPnvYL9GHU8jgP7ebZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vKyfUgfnhayr5Y3YwwGeI1HW0y1dFPt9xK3SQEOY8g=;
 b=nQK2jwpvngRzDUxuIOkYzWSDxOSeb+FIcxqPKZih29s1lAUaQPqQ5exVEefkWEEm68xVGpjzqLhlkkD8lwyLwcOnhdNg8nue7sDjqudyzdd7ZTliO5lv90ENkf7duajN+J0MnQ+acQ7poktrEO2GXNX3Hb9L9xQwU9pMN3nP2ohmZgpCoWOpsKONz6qvp0eZagHEfIPspDv4XoaWdKUe0bcMhZ6QlbruwHvTcoi0EMllWxYHLmmChuNQQhrlChb5PFzM0rFMqn1aJfYeQnpArdBPFsOt3SOHIEOIge6faelhQRwVNP96tvn1TMAJROY+PdaSzptHkiGEL+tj0DFa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 00:18:36 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 00:18:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
Thread-Topic: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
Thread-Index: AQHZR8V7jBEpgGmkW0y2v5Nq2IJKM67dLYMAgAAOAIA=
Date:   Fri, 24 Feb 2023 00:18:35 +0000
Message-ID: <0daf23ea2d52bfebbaaae76f461dd8566df4961d.camel@intel.com>
References: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
         <CGME20230223232827uscas1p20e3b2e7f942b1672d951a2b2cf4ffbc2@uscas1p2.samsung.com>
         <20230223232817.GA469785@bgt-140510-bm01>
In-Reply-To: <20230223232817.GA469785@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB8131:EE_
x-ms-office365-filtering-correlation-id: 90b61a55-c43f-4bc9-3295-08db15fcab8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sdtp4AqFHwT199+s3ZqpV78MQZQqJi4QsC/qoAsXjvLA20X5kcKn3sY0L5A0GfNZs+fhXFKRbxpVi8QTdwlr/biGNSXmp+knceU11+lIiyf6bdaL/fECUbRD8S0d+EWSBVsD61MIxkjLJs9HBpluc26H5PGRNXntGemeBTt4JSp+MB93BHaez62KWtvdplJES4r2NItz/PBtZLbc+V8Dlyy0ID1XpA+nu6t8jKeze6+gtpxe6LZ1KK0gKcqQ7EpXajxjbeGvY6ywvuw1Qhm+/A6WScW+LJKAgd93Jpnsb3Ig4I3jObF3e4EH8xtfbNnfjKFeB4Csn6+BrrIBIdaaaW3OsZtTyRlNrLliqZ6c5dExFxRa5w02T0MJhTEhAkykmk4Ps2ODH9jyh5GJAKO+i2uAmtCisW3/aFLx0oijzpYDKjpWvk3OKAUOK3AWDeQVZqj49ZggPp4CEZB7o5hwTIlC8YTywyUD9knKS61psybBxA6M+kAUF6Sivg5zoHj2OEHKPnVb0VFt97GP9fE649ZfWNiKac8Hk9smZQtgYBoq/8vDJYEBXoggP1ksA1DI4IGjoDaSMVpzlc5lrh4jgyokl+qvpw3PTT0HotKBvHOo06g0Kw/QA6edjVVKR8GBzf05ggsJy93Q9sO/Vq/tC5wLkaDJjECRQ6lz31q07XarI7hmC+YS32G3IuOxy+p/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199018)(71200400001)(186003)(26005)(6486002)(2616005)(966005)(6506007)(6512007)(5660300002)(110136005)(316002)(91956017)(83380400001)(8676002)(38070700005)(64756008)(41300700001)(4326008)(8936002)(66446008)(66556008)(66946007)(66476007)(76116006)(36756003)(122000001)(38100700002)(478600001)(86362001)(2906002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0h1T3ZReDVDR0J2WllGeXNkSHR4SDUwRnFTVVFkUlhIRnlBRTFsVXBCZXFL?=
 =?utf-8?B?bEUrVU5XTVFnR1VLSElHcEZ3L0lNa2QxYmJ6UjBsMGp5bk9FTUFsb29VSUth?=
 =?utf-8?B?WnE4RDNNS1ZvUnBaTWpudDRyRlIzNVhJb05nb1NJQmgySjN3ZngvNlU3NERm?=
 =?utf-8?B?TjgwdmV3MXlQUE1SSndPOU9FSTZieUh5NTRSdnRiSmtQSDlmRWpUTUtSM3NT?=
 =?utf-8?B?bTN6NnlXYUwxanVuemtnMlFVSzA2NzBXazFDK3ZFWFhMY1Rnbjd3Z2NKU3cv?=
 =?utf-8?B?Yks1K25DVWc0aFNKajg4YnExZnMyWlpmQVNBa1RQanhnbWlaeWJkd2pyc2gv?=
 =?utf-8?B?eFZvdURqdStSNTVzRWtiTi9zWmFjNngwM2hLUW12bzZpRkZDTW9TREtkWmVh?=
 =?utf-8?B?T2pkaGtWcXdkd1A0TGVxSDRBeFp3aU9zVmlQY3dxaGl2S0dYZGxucHJWbVQv?=
 =?utf-8?B?L3MxbGJRQ1JUNmozU2l4TW0xVDdDbS9rZ1duZUkyV0UrcE5vWFUxYitRRGhI?=
 =?utf-8?B?cTNvdFZkYlJCc3JhVzhrQ2lMb2ZFOFU3VVNVd0R4QnZLQ2Q0TDlXTndjRWd3?=
 =?utf-8?B?eWx0OE9wdUM4K0xBYlh6QnJZUXMreFlyTHNZaFJRUUNTZ285SHl3RVM2eEF3?=
 =?utf-8?B?bWNtWkgvZWljZEhIQmV3cDlEb1BESDE3eW9TQit0djJGMnZaSnlabXZBVDhM?=
 =?utf-8?B?YVRML3ZSOFI2UUNWOVljVll0WHZVSXRlSm95ck0xblRyN0NjcWdub3pJeVFH?=
 =?utf-8?B?U3FTcmc1U1BmcThLeGpQancyOHhTWU9TZDhYRG5OMlNmdVRjN3RxTEZZS3Ez?=
 =?utf-8?B?bzNQMDBjOVVyUVVkN0duWFFsNmZKaCtEYTJJVkw4S09DYms4RzFwRk1Xc0dk?=
 =?utf-8?B?ZGNKMFhLMGhKYzNKcUxDOWtGcVFxWnNwM2p4SGRsSzQ5MmY0ZWY1SWh5a3FM?=
 =?utf-8?B?aUlvQk85RWJ0SGFuRnBrb3UvR1Vnb2t0ZDVNK1RkeVNYT1FBSVpFM0NyZE5S?=
 =?utf-8?B?UDE3NTNQT2VQbzlzWGZ3Y3hKUHNMWXlRb2NVTWhSMG9iZkFVSXRWbys1dDlU?=
 =?utf-8?B?bjFEYXNKbVVhWmNOWkRWbGtlMCtQY3JnSnhjUUxIN0NPaHUxUFNHd2pUa2Nn?=
 =?utf-8?B?cHp2eUtKUW5zVUtyTitVdVV5aWZ3V29MYUIxVy9ubEZFcyt1UUtkZm9WbktB?=
 =?utf-8?B?Y3VPQTVJY3dvelQ2VW1vcjZndzFmK1ppN21WT09KT2Q2bEpERVNNcGczejR6?=
 =?utf-8?B?SWQ3ZXpBRTFDT3lGSEVQUVJtSERBYmlMcDBrcnZvbkFCdVd3cEcyNW83WFRN?=
 =?utf-8?B?TndJdFRoakJxdm1QTnA0ZVZaeUtCU1V3YkhEL1l6OWwrdmoxVFpZYWNqRGc5?=
 =?utf-8?B?bkVoK2MyYm82ZElYSVVLVFAwRUNPeVh0TXpBRjRIUG40QTVMejg3anZrY0tB?=
 =?utf-8?B?Z0swRktJZFJZeXEzZzVXMnV5bW03V1pJOTVNQTdWWjBmeUQrSE1UZElhK09V?=
 =?utf-8?B?aEViL1dSWUs3aCtyRGNGMmFnTGhobWpGM0lIRzNSbzhwYXZnY1JaK3hEN1RO?=
 =?utf-8?B?UHZxams3QXRYSlNQc1czUzlHRTE1YzRWSmJxVWlTMVFSelBsM0RqSStQOWtv?=
 =?utf-8?B?YXVSZjBOQ0FrUlNoRzFKck4ycU1vUk5VQnZ4OFBmVEhUQmoxbjlMS0cydjc3?=
 =?utf-8?B?eS9BOTdPZUpoUkx6UzU3dkJYR0p5K3NOQXIvY3lUMGdsdm9lNHk3ditvYnVD?=
 =?utf-8?B?cHZJLytlWUJvWVhQUGRTT1VnSGdNRE5lUUNWeXVXVGRpdit5ejFlMWV4RnpD?=
 =?utf-8?B?ZXZFL0RpTElzSFE0Uk1rbENhWG5YNXNVTHJzT0dQMVJDZTFtYTZtL212czlB?=
 =?utf-8?B?ZzNyd1AxMU5lakFwaWRWMDJxUEg5VCtTTzQ5eDMwbGo1TmxNUlZONWNheXdV?=
 =?utf-8?B?Z3hWd0Zqd09EQVJDQURSVFFxdGRFVjNFVlBFVnFtK2tHbjNENjR5TG5YbGNT?=
 =?utf-8?B?L3lsUitYSlBYQkF1a0ExUFlXYzFHMWFDQXc2cjB4WFdxRmZHZ2FQN3VMUDEr?=
 =?utf-8?B?aDFUL3RwSHpKaTNDUHJVZDlrV29rQVpVWE5ZUy9yMnBKVWtvOXhwSHRnQ0pY?=
 =?utf-8?B?YUpWL0o3dWhqamE3OXg0VjBZMG84TzY4K1U4WFhSMWg1dTZoeFpHS1ZLQ0RV?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2546CF074653794DBEA0E79EE5D39C4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b61a55-c43f-4bc9-3295-08db15fcab8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 00:18:35.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Us1HFeWzJgVCZkuAw1Z0TLp3pU3RbgG9j1/I/LK3XUBO2auCWaFW/GxwUceJSmz3apZWxXC70+W1RStfp6hPL+binHivbow/2MAEKW9W1Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTIzIGF0IDIzOjI4ICswMDAwLCBBZGFtIE1hbnphbmFyZXMgd3JvdGU6
DQo+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDEyOjI5OjAyUE0gLTA4MDAsIERhbiBXaWxsaWFt
cyB3cm90ZToNCj4gPiBCdWlsZCBhIHN0dWIgdmVyc2lvbiBvZiAnY3hsIG1vbml0b3InIHRoYXQg
cmVwb3J0cyB0aGF0IHRoZSBmYWNpbGl0eSB3YXMNCj4gPiBzdGF0aWNhbGx5IGRpc2FibGVkIGF0
IGNvbmZpZ3VyZSAvIGJ1aWxkIHRpbWUuIFByb3ZpZGUgdGhlIG1lc29uDQo+ID4gY29uZmlndXJh
dGlvbiBsaW5lIHRvIGNvcnJlY3QgdGhlIGJ1aWxkLg0KPiA+IA0KPiA+IFRoaXMgaXMgaW4gcmVz
cG9uc2UgdG8gdGhlIGZhY3QgdGhhdCBzb21lIGRpc3Ryb3MgZmFpbCB0byBzaGlwDQo+ID4gbGli
dHJhY2Vmcy1kZXZlbCBldmVuIHRob3VnaCB0aGV5IHNoaXAgbGlidHJhY2VmcyAobG9va2luZyBh
dCB5b3UgQ2VudE9TDQo+ID4gU3RyZWFtIDgpLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERh
biBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgY29u
ZmlnLmgubWVzb27CoMKgwqAgfMKgwqDCoCAzICsrKw0KPiA+IMKgY3hsL2J1aWx0aW4uaMKgwqDC
oMKgIHzCoMKgwqAgOSArKysrKysrKysNCj4gPiDCoGN4bC9tZXNvbi5idWlsZMKgwqAgfMKgwqAg
MzMgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gwqBtZXNvbi5idWlsZMKg
wqDCoMKgwqDCoCB8wqDCoMKgIDcgKysrKystLQ0KPiA+IMKgbWVzb25fb3B0aW9ucy50eHQgfMKg
wqDCoCAxICsNCj4gPiDCoG5kY3RsLnNwZWMuaW7CoMKgwqDCoCB8wqDCoMKgIDggKysrKystLS0N
Cj4gPiDCoDYgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQo+IA0KDQo8Li4+DQoNCj4gSGVhZHMgdXAsIEkganVzdCBidWlsdCBuZGN0bCBkZXZlbCBicmFu
Y2ggb24gdHVtYmxld2VlZCBhbmQgbGlidHJhY2Vmcy1kZXYNCj4gcHV0cyBpbmNsdWRlIGZpbGVz
IGluIGxpYnRyYWNlZnMvdHJhY2Vmcy5oDQoNClllcCB0aGlzIHdhcyByZXBvcnRlZCBlYXJsaWVy
IHRvZGF5Og0KaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvaXNzdWVzLzIzNA0KDQpJJ2xs
IGhhdmUgYSBmaXggYW5kIGEgNzYuMSByZWxlYXNlIHdpdGggdGhlc2Ugc2hvcnRseSENCg0K
