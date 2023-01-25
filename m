Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7082C54EED
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 18:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjAYSrQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAYSrK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 13:47:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F545AA70
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674672427; x=1706208427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gwdc4r25u6fEh8AHw172imLYz/TSCQTkh7TYYFLvLyc=;
  b=JVEXM+ftXw6cMPnI3RzoEYBHNQoGV6HPc+1oEzp3xIKgrWkw1Cq0C6od
   O6k72UxM0n0rSSDd1iRn/437jCgg1FF58z/JxmAhUFxwHTAvCTHiCBTQ/
   jqOygnq0hb44/pOIOxXOvkLPdlEc6quRbm6emeA8HgTTfRDNuyRYnRh+9
   NbKsF5PyKLVi3Ba8+zu5PsPkZKnXx4wUFGiCQ2QVbAota4cC5gTHF7TMR
   8WQxEjNPJQNeaHjk+hsTNIIygCWldjoHC/R88Cz9f+WFeryfvG7ZJTPwF
   n5s38VJ/WpTkUpKhyreAABgaRgyAfraJJVPxFM4jFHVE4XjAFQWXqf4xA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="327894190"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="327894190"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991366338"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="991366338"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2023 10:47:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:47:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:47:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:47:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xi0Dt+GfEpoeX4702t74RiE2K1eSUiPD/Tf4fsrLN9kgv6inEJwns8WBN7vMByqtno81BJ+8b0PTzlrYBwXNkqcfVZq4JL3g3nhWgqC7jEhIvU97FTUlk88ogT0GP/9/YdewFjFtHzrC2Fz26ZlmvVGOeSfoLRN3B3meu17iN1zTi6OUG1A+b1ylou5rEyDWOjCvSAaObswUI5k28M1piu3MD522ObpqULDx7gFwbXQs9DNUruThv0gUv+IpVGT9/w4XSrV8D6Ga/JdmDzSw3oROegTHZfp3IhRnybG3YPtU7jflsBfjJmoRXD31wSpzs8x2BDussoLuRwj0hO6TMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwdc4r25u6fEh8AHw172imLYz/TSCQTkh7TYYFLvLyc=;
 b=cxOfDLvoQGkQLckHjVSVXWaD6ut+Xbdux+qaJGAmCjGFiQVKl9Z9VvVIWMBQ7+srImLQW+Rt8BH++hODprX+txm7I5uxmWzQmo62MLXGgjhriP4YptcznNvQ30KluW0gsw4BhLeuTxDnIdLJJZcD35cAKMlZxq5gQt+faWVRXHbG6yzyZkU3RAacFFLPiDfSwO0uSCdx/jay8hIV9AjdEkyT5yEuIM2bg8GOXhuNDg9s3PMxgpjDGSgjaHF7bjgI6KsKwfwoc2ax7/bkEcWLbQhavjbCRgMHb3Go/y72djVRUuiuvKTQkQtVz1XdWp4tueG7VxXV8F3etVcDjG/OaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:47:03 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:47:03 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] tools/testing/cxl: Remove cxl_test module math loading
 message
Thread-Topic: [PATCH v2] tools/testing/cxl: Remove cxl_test module math
 loading message
Thread-Index: AQHZMOjCQ3o0xLFPqkm0jr/3PquziK6veP8A
Date:   Wed, 25 Jan 2023 18:47:03 +0000
Message-ID: <d405785afd711077b972e7e33dca03c48c1a05cb.camel@intel.com>
References: <20230125181336.667448-1-alison.schofield@intel.com>
In-Reply-To: <20230125181336.667448-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY8PR11MB6913:EE_
x-ms-office365-filtering-correlation-id: e83b0695-85f8-4508-00e5-08daff048cb6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGm7/269gzeoJmYVe0d/YdrZE8wIKeQ1ZP0mk9YNnHpWKyqFnbJEPRi9hepycoNWVenBK6aDyfJwe5ovm/FHtGuE1w53nI/Ne8O74Lw4NkAF4PRN1G5u3dwgmolvfRhhzKY3A4fdRmHTn9Z496Z4cg5Jc0A9cSVqVpJYXn+ClwsdaahSspbU4ZjPWXxGt5LVhIdHwPATsrXYN6naK+ht27wGTR0U3Qcq2ZjBNrTClgT+PhaWkExY4p2yjn9jPGEzaWeXKo5Rkpm+vT5cqHqPJa9scl7dS332taFtmBM0xmV7YoyeeD8Z4LZpBokQqwmZoSXGvCr0uGBPWukloAPvdfLVeUhD/eHlNye7kOM8czsmpjuzxoUY6VUoPURBfhq86NFm3DwLxxaSLD32CQouK5UaDxKDuQGlE2g2TTSEhqmgt1dR3x5z6l+kFWs3Q9XkSJNl6tEtztsnk8ILrcc2ouaNqo32Pw4wtuCZiHA81I/358XWFwpYO2RV1L/bCCPE1FfO6L1EkYuD4LUxPEri2QX3gg9WkjdCE6HLG+wqKO72xx6TjvSBD+rT3fVskhhsOheDDLP+SCZ9CAW0B9CLR66VxNMLD7+HmCVjWe4chLPG2qpgk8JCK50nQ/pYySaJwhNNnrhP3Q5gOEJ0lX68VTWZ8KITelmtuRhkWx/9vihGxyGVoDsM0MOkCPH7bS5/3njVl21sIddlNaNIFj2Ueg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(83380400001)(2616005)(41300700001)(8936002)(36756003)(2906002)(38070700005)(82960400001)(86362001)(122000001)(38100700002)(5660300002)(15650500001)(6486002)(6506007)(316002)(110136005)(6636002)(478600001)(6512007)(26005)(186003)(8676002)(71200400001)(66476007)(66556008)(66946007)(64756008)(4326008)(66446008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJtR2NIN2FDbGpoenhKZmNUU25HUEpNZFJxMnlFS3dkbnM5NjR1MThpWUtv?=
 =?utf-8?B?dWQ2c01NTGxSNHE2UEp6aHkxTGlsd2JXNXNWdDFCd252VDN0MHlDU0N0MmxM?=
 =?utf-8?B?VXJOSXV4ZCtoMkM5SE5ydUprTXRvazg4elVjOFltSC81OUpQWkQ0WmpiRTRT?=
 =?utf-8?B?SklKMTJINHJVbjlVRWtmVmJYYUM4UjJ5OC9tZFJBSHFsNzBKalNkZXRSVGhH?=
 =?utf-8?B?MlY3NjFIRXMwUldZc0RyODdmcjFHMU0xdGVPT0FUNk8zdGpzSlVKWFZHZGRx?=
 =?utf-8?B?bDBhTlpIeXJZeUhaVHF0eERZV1pHVnZkbFBSa1dLbGNpdGtiVzRjUUU4ZnFB?=
 =?utf-8?B?UzdTVDBaemQrM0FkbDBISzRMeDY3VjFJQ1M0cWdubFdDQVpDdFRFN2ZCY1d5?=
 =?utf-8?B?dzRRT01PSVkza0FneThZWmZvQ0VKK3d2UEFXckJxa0tTT2FlaldQZ2xOMGFi?=
 =?utf-8?B?ZHA3RnIxc1ZiWHBDYUlRcjRZU2RCOGQzS3l1R3g0am51OW14dVlETHcvN1FV?=
 =?utf-8?B?Q0hJdzNPeHUxSTNNdFJESmFoaGJ2VEphczlGeStNakg0SEgyUjJaQURSTE92?=
 =?utf-8?B?TDF0R3hZZXRqUjVLSFpqMlBSYStIYyt3MFBOWW9CUVI0QjZhczFyd3ZxQXJt?=
 =?utf-8?B?Y0xyQ0RYVHB6T0FDOUYrN2hscU9pNm1MRk5hQzFDMmZIbk9rWEtOZWh3VFNu?=
 =?utf-8?B?QWlLTy9FOGgzS2U1dS9TZ3JEN2tjeTNrZ1p5M3JpYmU2RHRFNVpXQ0lRbGF0?=
 =?utf-8?B?ZkVlL3AyOXg0TW43VmN1cHo0aWlkYnFEN2VKZEtaK3JDZmp2VEJYb2lJUy83?=
 =?utf-8?B?dm5rcTNkZDhLQXNBbDVROVo4bnd6UGErNitvV29WUWYwZkNSN3pDNVNPdDRt?=
 =?utf-8?B?NGpZNHhHbzhsbjI4L1hTa3c0M3dNYVVycjh6U2VDa2FwOVgrU0ZIZURHZHNw?=
 =?utf-8?B?MXRqN0J1Y3NlNWd6NnB5dlk5eTFicUNkVEtzRitySW0wODR2Wm9TeUhNK2ZS?=
 =?utf-8?B?Q2hQYWNTNDQweDUrN0Q1U3FtWVJQNStxQmE1K0hGM2RFL21iaW9LMktYQXQz?=
 =?utf-8?B?b0FXemQzMXpnR09sR3ZOWHhHVTVvd3A3Vmk4UUd6dkZrMTYrREFodEVBUGV3?=
 =?utf-8?B?M3U1N1RwTHpUNzIwVlJuRko0Y2lvU1R2ZTdMemQvdXhEK0N6d2NPVS9hd21o?=
 =?utf-8?B?bWJYaHc1QldFVDliTDVaeUdnRHNSM25EamhhMlFRanhoY0U2Nk16YTloN2dQ?=
 =?utf-8?B?ZWNVVzFzRnRlK2hiSTRBeTFFRy82L2FnSzlHa1BOVDFFM3VGZmYxQWZndHh2?=
 =?utf-8?B?OEpqdmlzcVQ0Q2Z0MWdzN2VlZFBRL0p4cnJDWlhvbTA5WlRpZmFQSDZ1alpI?=
 =?utf-8?B?S3dEdVpNSzNWTXdOaHhEVVNYUE5OdnBCb1NKOThDYnBiZXNIK2RLdHEzbmNn?=
 =?utf-8?B?U1RsWFk5TkordVpjOU0yclY3Y2hQNnBBbEQzbDVZbXc5OUNDSTdYZE83bVpF?=
 =?utf-8?B?WUwzMXNoSVA5Tlp3d0RMVjJUZjBwMDlsemo1UFExUmRESXlydlMwNUNoMml0?=
 =?utf-8?B?aXVIbTdJL1AzVDlHUHJuNW02RnRacnpzdjlvc2cwMWtyOWtHdjNlTnh6UWgz?=
 =?utf-8?B?MFl6RjVuMFhSaUZjZ1hubmJZenVhSjJJdjYzOEpIU3BnVkFyb05Gc25KY0hi?=
 =?utf-8?B?ZW9qVkhsS0I1dlg5YlFqNGlVVS90UWFEU2VHcnBOeGNHOFJvdkNnUGNjRmoz?=
 =?utf-8?B?RGtvc1BSV2tLemtjZDRETkRUZEFaSy81NmdEQnJDSC9YTkQ3STd4bUVJNndx?=
 =?utf-8?B?Nk5JZXFBZW5ZS3FwQ1BNZFhMc2FkRHZySkxVMnlVS3pZclVRcnF3TDhUVnJY?=
 =?utf-8?B?UUg2YWViSnNtVnVkNlBTQ1M4VFp6cWxjdTFkeDZtQUlVV1RUR0NNbFZKMFRy?=
 =?utf-8?B?aEVUYWN3OVJTTGJ5UFFzQm4xNkc5WlZDb1c0UUh2cE1mSHJRK2p2Y0NIZFhH?=
 =?utf-8?B?MVZHZmh3QXZjRi9mcm5oSStpenNjdUZpZVhYQkRYVTNEejZiK0pvZ09xQUxN?=
 =?utf-8?B?WHpGRUNUb3R3NHBCMmlnajFhRzhLYktNVENSVlBTWENMYm5HakxmTm82Rmxo?=
 =?utf-8?B?Q05UOFpramVwVkM5QVFYZk5iMDRCT2ZPM29tZE5LNHl3cm5nRmlRLzRzL1Bq?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A3A8EF014A4D42A43F6F8A0AE6C385@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83b0695-85f8-4508-00e5-08daff048cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 18:47:03.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMDybHsnt5OcyeBbuq6HEJa0uEFkvlWJENFuG7rlLCn7nJM0mpcrNz9jLe05PdKphx9dMsJXmI52lC0rOkfqnX7Y2bIF1zrbjHA8eHu69RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDEwOjEzIC0wODAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBDb21taXQgInRvb2xzL3Rlc3RpbmcvY3hsOiBBZGQgWE9SIE1hdGgg
c3VwcG9ydCB0byBjeGxfdGVzdCIgYWRkZWQNCj4gYSBtb2R1bGUgcGFyYW1ldGVyIHRvIGN4bF90
ZXN0IGZvciB0aGUgaW50ZXJsZWF2ZV9hcml0aG1ldGljIG9wdGlvbi4NCj4gSW4gZG9pbmcgc28s
IGl0IGFsc28gYWRkZWQgdGhpcyBkZXZfZGJnKCkgbWVzc2FnZSBkZXNjcmliaW5nIHdoaWNoDQo+
IG9wdGlvbiBjeGxfdGVzdCB1c2VkIGR1cmluZyBsb2FkOg0KPiAiW8KgIDExMS43NDMyNDZdIChO
VUxMIGRldmljZSAqKTogY3hsX3Rlc3QgbG9hZGluZyBtb2R1bG8gbWF0aCBvcHRpb24iDQo+IA0K
PiBUaGF0ICIoTlVMTCBkZXZpY2UgKikiIGhhcyByYWlzZWQgbmVlZGxlc3MgdXNlciBjb25jZXJu
IGFuZCB0aGUgaW5mbw0KPiBlbWl0dGVkIGNhbiBiZSBkaXNjb3ZlcmVkIGVsc2V3aGVyZS4NCj4g
DQo+IFJlbW92ZSB0aGUgZGV2X2RiZygpIG1lc3NhZ2VzIGFuZCBtYWtlIHRoZSBtb2R1bGVfcGFy
YW0gcmVhZGFibGUgdmlhDQo+IHN5c2ZzIGluIGNhc2UgYSBsb29rdXAgaXMgd2FudGVkLg0KPiAN
Cj4gRml4ZXM6IEZpeGVzOiA3YTdlNmVkZmNhODUgKCJ0b29scy90ZXN0aW5nL2N4bDogQWRkIFhP
UiBNYXRoIHN1cHBvcnQgdG8gY3hsX3Rlc3QiKQ0KPiBTdWdnZXN0ZWQtYnk6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gU2No
b2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAtIFVzZSBjb3JyZWN0IEZpeGVzIFRhZyBpbiBjb21taXQgbG9nLiAoSXJhKQ0K
PiAtIFBhcmFtIGFsd2F5cyBhcHBlYXJzIGluIHN5c2ZzLiBEb24ndCBzYXkgb3RoZXJ3aXNlIGlu
IGNvbW1pdCBsb2cuIChJcmEpDQo+IC0gQ29tbWl0IG1zZzogcy9tb2R1bG8vbW9kdWxlLCBzL21l
c3NhZ2VzL21lc3NhZ2UgDQo+IC0gTm8gY2hhbmdlIGluIGNvZGUNCj4gDQo+IMKgdG9vbHMvdGVz
dGluZy9jeGwvdGVzdC9jeGwuYyB8IDQgKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBWaXNo
YWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvY3hsLmMgYi90b29scy90ZXN0aW5nL2N4bC90ZXN0L2N4
bC5jDQo+IGluZGV4IDMwZWU2ODBkMzhmZi4uZWRlODRkZTY5ZjU5IDEwMDY0NA0KPiAtLS0gYS90
b29scy90ZXN0aW5nL2N4bC90ZXN0L2N4bC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rl
c3QvY3hsLmMNCj4gQEAgLTExMzUsMTEgKzExMzUsOSBAQCBzdGF0aWMgX19pbml0IGludCBjeGxf
dGVzdF9pbml0KHZvaWQpDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaW50ZXJsZWF2ZV9hcml0aG1l
dGljID09IDEpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjZm13c19zdGFy
dCA9IENGTVdTX1hPUl9BUlJBWV9TVEFSVDsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjZm13c19lbmQgPSBDRk1XU19YT1JfQVJSQVlfRU5EOw0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhOVUxMLCAiY3hsX3Rlc3QgbG9hZGluZyB4b3IgbWF0aCBv
cHRpb25cbiIpOw0KPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjZm13c19zdGFydCA9IENGTVdTX01PRF9BUlJBWV9TVEFSVDsNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjZm13c19lbmQgPSBDRk1XU19NT0RfQVJS
QVlfRU5EOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhOVUxMLCAi
Y3hsX3Rlc3QgbG9hZGluZyBtb2R1bG8gbWF0aCBvcHRpb25cbiIpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgfQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcmMgPSBwb3B1bGF0ZV9jZWR0KCk7DQo+IEBA
IC0xMzI2LDcgKzEzMjQsNyBAQCBzdGF0aWMgX19leGl0IHZvaWQgY3hsX3Rlc3RfZXhpdCh2b2lk
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgdW5yZWdpc3Rlcl9jeGxfbW9ja19vcHMoJmN4bF9tb2NrX29w
cyk7DQo+IMKgfQ0KPiDCoA0KPiAtbW9kdWxlX3BhcmFtKGludGVybGVhdmVfYXJpdGhtZXRpYywg
aW50LCAwMDAwKTsNCj4gK21vZHVsZV9wYXJhbShpbnRlcmxlYXZlX2FyaXRobWV0aWMsIGludCwg
MDQ0NCk7DQo+IMKgTU9EVUxFX1BBUk1fREVTQyhpbnRlcmxlYXZlX2FyaXRobWV0aWMsICJNb2R1
bG86MCwgWE9SOjEiKTsNCj4gwqBtb2R1bGVfaW5pdChjeGxfdGVzdF9pbml0KTsNCj4gwqBtb2R1
bGVfZXhpdChjeGxfdGVzdF9leGl0KTsNCj4gDQo+IGJhc2UtY29tbWl0OiA1ODljMzM1NzM3MGE1
OTZlZjdjOTljMDBiYWNhOGFjNzk5ZmNlNTMxDQoNCg==
