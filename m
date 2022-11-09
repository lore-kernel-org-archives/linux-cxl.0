Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49997C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 00:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKIAbo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKIAbm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 19:31:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032021EC74
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667953902; x=1699489902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lq3NxvbIg9yzp18jy6QLpU89tMOCJaZXjLxEUoWru2I=;
  b=TBwnR2T+OaWC7Zum5O4GUx6tIaruZrgCwFP2pkLlInA1G9YGpSvQHR2L
   ol+zRlJiFEGm7M6viWht/lieLrLC2rW6iLhqSsYZ6Lz6fQVq72t1PacHq
   2VNXwoL6BZbYYXvOVmhYv3wZn9BQbNJnKB8QUamYcX8bU3vwkOwzULc1S
   BNp70U3Er6OFWD9CC5shB5D4fC0YpeTFjOZOYBVVM0hP25TK9ghsCYUMf
   fQbT/35rhAIG6BRwUnHF9W4WHqj6AAsAhhqZ/pFTjt434RnnfvfQ/SS/D
   OUtS5v8Z0U9KiUfIRXbUAlfWF2bCQitbXoA8PJp0LSNDIojnxtwohZYrD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397139596"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="397139596"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 16:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="587570704"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="587570704"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2022 16:31:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:31:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:31:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 16:31:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 16:31:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPbqDOrtqL700PQg5cX4/aonqYx/3r8RZJoq3f8msln1VY5kgfWtOueikzXx1cNw8Mk2VGV3TADvMIGPUsS49WEC+j8+lsKirTohhOLGxVwqvKvSFR0tmCsew6mnRTTnI/SgbTV2ry17JazDOfWxL0midiF0BD/GDB4NsTn2bKd/gSPIf58dwS0S53YKaUh282Ge4Svz0UUBXRIHO46hPQ4/CCZhemJQWp+vs7CuFmrqTwiolEtubAe2FLG95i9Up1n9tAwCW56i3nM5SFzglmISQHPbiQ7d1OFgWHlAT80B49ub5xfs5iuRw1vCXinqIyXAKIVzQwnJPojvDpzLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq3NxvbIg9yzp18jy6QLpU89tMOCJaZXjLxEUoWru2I=;
 b=BMowzYCmsULPf7ZSpQt3vTj5IMUH4a+ZWqYC5oLQyryI/aOOA0Kx4mr+7zSygaBdmfFW/IG24gsWmBJt4qKDwHrfMpCgLKtDX+J72ZcJy5qyAaNuuOOekPIeq8XInbC0oHczJ6R+p8BDs7wXrAMMpLe8tfv/cT3mghNX/Z7659ZrKbRjzR/DfRNtmGIp0Nugd+BtOxHPMaE0hGZMrD7cPk1lOYZGXOyuNzinKajRBx7843ckNXBlF9HgXI/sZvtsPt17Z+SiWM8zwprNmijv7gBkzQ9o0GbBI8c1OqhiNLrLj82r8YmB9VgJpzEwdjVeBaDJ4FxgzVIDIsFmopzAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 00:31:36 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 00:31:36 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 06/10] cxl: add logging functions for monitor
Thread-Topic: [PATCH v4 06/10] cxl: add logging functions for monitor
Thread-Index: AQHY86A3MsHsWW4vSUaS3bBXHwySLK41vf6A
Date:   Wed, 9 Nov 2022 00:31:36 +0000
Message-ID: <2c0c6d427440d8cca65e28158b6b1323aadd86c4.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793222281.3768752.3333516400569686550.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793222281.3768752.3333516400569686550.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY8PR11MB7394:EE_
x-ms-office365-filtering-correlation-id: c4e5d244-6cfc-4269-be7d-08dac1e9c2e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KcS2TwVKLsaOuvvn1SMEVbQPb5xQ1vjLSB+cxvn3ug7Koz8G47UF0j6avnVW1zjXozXB7fhw8Kz+9M+Tk3bnKYX8cff+qqdXkEnI9Wbp4cxRhr9weFXH3GXjCmBi+YxH6zGGDuWVNQP48j/pC5s0NU9GXD/MfheSud62Xdv+q/H57DOpCxPfC1HXrxiLxMNeHJN4D0pbYNvryUIzLfYeyNrmlU+2Nydw8SU6eqJnlDuyXMubmy8G3jfFpbQj4XYbhdoZ9P1cSnFnmLo1VeEcbeLf0IOg0bW4W+TaIGMz94tPpOeAzB+YeCkM8Hk9w37mRkCKEBoCLS01YbFPeDvVfRvTFjY80vnNWEq2Yj9aWyMRw31UAcDxVBUgd3eansBnV3lfD1W4qSfVT5Vmn9c5FR6N+R4AX1QZgKDfLHizokurchIQ5edmErtbBLtx62ViSALOae8GCJP4ubs64qLOCJgS67UEgDKfUP3UL6otLFgw0NEqjZ1A92VhJXhfwlPDpDgFz4nynPXluIaoZCE8Fk/uMyLyfTvvmC4wZOcPvCyeul16C3l7K7/8PcuxwyRvzOd5A45kbMb6kR8kCOTsKYYi0mHO0bCZw1qlWgF9HmK+5Dtb3GV2kU5Rdj9uNbKj1PwcLkTaKHyk77MX8edenu5z/PnUXwVQ/sLfDMj03HFOwTA1pTg6VfwiKXuvLhml4TMNqZ9z2lhCsK9ZcInVA2+BWoXjvm5vDokf2Ra1tkPgxfpgZ2Kvrufn8xOc5/vQqA71uORlFI8SsvPiUQ3Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(2616005)(83380400001)(186003)(38070700005)(82960400001)(86362001)(36756003)(38100700002)(122000001)(110136005)(41300700001)(91956017)(66556008)(66946007)(76116006)(316002)(54906003)(66446008)(4326008)(64756008)(66476007)(107886003)(478600001)(6512007)(26005)(6506007)(8936002)(5660300002)(8676002)(2906002)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2pvVlVKckZyaHNNYVo4SDAwSCtNY2FKNGNIeWZDZzFaOXQ4TWJ1WFR6a29m?=
 =?utf-8?B?STUwTWpkNVQzbWliS1UySHdnZHVZVndBV2VqcVNTL1kzcXZFZDkvQktEYVZ5?=
 =?utf-8?B?Tmt0L3ovV0xtVEcwOFNxOUVJVjZsSUhIRU4wdFFoY0FveWh5OGE3Q3hUNkdV?=
 =?utf-8?B?eHVOY0N0M25RNy9uS0ZTVEVDL1RBY0x6WWUyTUtHRzhkcUE0Z3FmcExVUmdK?=
 =?utf-8?B?V1R5ZXdjcWEwZSs3NmZETTd1WS9RMzZGREVOcGZMaGV5TWcxbG5ybW4vdGlL?=
 =?utf-8?B?SGdsbnRIQVVEQWd0cmhtb2NyekNPM0tmMTRzSzJQMjY1Um1JenM5UDNwZ3JR?=
 =?utf-8?B?R0lxeXpldEV0R1hOM2ozZ0JlSUk2MlpmekltT1lLNUczcjNaeVo5cDhTY1FS?=
 =?utf-8?B?N2hSY0plUVpnYVNwdCtYcEpmdSt0SENYSnZCZ1l0ekdlQ0JWdDRlQkQwMVN3?=
 =?utf-8?B?amVEclhRRkFqdC9tbFZoRllvV25mUFBiNDZVb2FmaWs2WEpVeUV1cUlpWlVE?=
 =?utf-8?B?N0pQYmNyRDZudE5iVFh3T0FnWkl3Sk9ka3Z0YXhrYU53cS8xTGhCS3lpYjU0?=
 =?utf-8?B?ZjFpeHRkbnRZemU4amVrTmtGcTJXb21kUDRDTFNEV3JxeTVwQXJIWUZpUnZj?=
 =?utf-8?B?RUtwZW5yeUZ4TGlZVlQzMGUvUHY1T0tjRjFJcmJJQXZXNFBVZHNDbGxNMktm?=
 =?utf-8?B?b1RRcHFYOFZ5bHZIUXhaOVdPYXdWaW1uTWprVE1jUnZpamtpNVNyUEZ4NGlD?=
 =?utf-8?B?Z1hzNmNRUUl5NFRGMnJqRkJybE5uS0p5amdoNldzRXIyOEx3Y0liQU5XVEJG?=
 =?utf-8?B?Mi80Y2RlSFRqMmVmdzBCTXBEUllqZ2kvejcyZ2JlTEQ4akhTb1E4R05GQmVI?=
 =?utf-8?B?dUlUVy9lcmxDbit0ME9BTlhhUko4ZmZvYmZ1Q0oweHpyWVpxREZaMm5UYjFX?=
 =?utf-8?B?d2NtQnBwNFZjdjVOa2NlT2JsamE4cTBMK01BbVlRUW5DS241UVVqZ1ZwRzQv?=
 =?utf-8?B?R1ZjWmp0TzgxNlViTFZ1QWNyd2syZ0phQjJZQ0MyU0FpQVViT3ZOZWQyUGhl?=
 =?utf-8?B?K3B6U3N4NmZBVm1GZ1RwcWEwQjNtdklzMnltbkwyNnUvNU5KRmxMSFc0cXBa?=
 =?utf-8?B?RHlReVBHMDc5cHVmT0dOY2hrWkdRT3N3dmVtMkVKcHNxYkVSeVBYQkN5NUpm?=
 =?utf-8?B?RWQraFRaeUh0eEwzMzhrd1I0QTI1bFVMOWkxT0RZcGJTdHdiMGxjQzZoMlIz?=
 =?utf-8?B?czc3MFJmanpCU3pCTG1xZExSRmRaK3dmbDI5ZXF3YnRuRzYxQ3AwbGxObnFK?=
 =?utf-8?B?NklJYlU4dTNteUpYNW5PdG14bkdIdjBYMDZONEZHQ21XWmdsUUo5aGpOVGpI?=
 =?utf-8?B?dXhBRWo1RUtwMitOOVpxaVF5SXBJTUNONlNvKzExaU9wbWw0bHUwZGhWWDFk?=
 =?utf-8?B?ZW5QQktZam1XaTdxbms4WGxOSjJ0UUJDNVNTcDlUWElpR3lWWEx2Ti8xTVRx?=
 =?utf-8?B?YStNQTBOaXFJQ2lraEVTWFg4a2QxaVo4ZDhwQVI2c0tPRm0vSXZxekFqNzRl?=
 =?utf-8?B?RGQxMy84TzNPSVNGZGVTMzFDRXUyUDV3Skt2TnJSU0p0bkxJZjd3Z3JiVUJZ?=
 =?utf-8?B?WTNHdHdCT0VyMUtnWDRmR1V2ZmNEMGdzN29Na0prbWZMamRFbjNYdHRZSHNW?=
 =?utf-8?B?QWNrZFFkaEpvV0Yvd3cxYTREWVpNdHBrNUZRd1ZvKzRXdFcrWTN0dVB1LzFl?=
 =?utf-8?B?T1NTcjZoZUMwNzdGYTI0K1E4bUNDckI1cGlERmlQcVFjV3RKRkNoall5by9K?=
 =?utf-8?B?U25WVFlOdWE4R1ZvMEVKdFlyVDY0MWp1UjhzVkhGVUc0TzJkY3VvV0EzcWdj?=
 =?utf-8?B?S2t5Z0NQU004VFByMkk2Ukg1RjVrdzRHYjIzRG9Gb2tNQVE3U3ZOcGVJTFZQ?=
 =?utf-8?B?NG4yT0pWTlJZZWFkTFJtQ0M2Uis0UGptNkN2N2s3SHZaVnhwaWE1a2MveHdG?=
 =?utf-8?B?TGRaMkZQRC90U0FaZWc1NGZtVHBWRlM4THMxWE1LZERhd28xTllYS3RnRnE0?=
 =?utf-8?B?R3U1TkM4ZHpoSWFmcmM4L3hXVWRJNTA5YlZiTUhuODIxVkpHUGVpa0pWdVl2?=
 =?utf-8?B?b3FSZjlQdGUxdTd2cmVHbTlqc1REMEF2MUJtQzB0SEpZMis5ZU0zT1NRK3Yz?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612572283E6EC94793329576D6821852@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e5d244-6cfc-4269-be7d-08dac1e9c2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 00:31:36.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+hz5+fTl2OF16kfAQtNwsgIZTsJ5v75NXsc1AkpfZigguuxOFM760iGFs0EOXaFQOFmKXiChWWGYrK9QNgGo1Mq1jE+JhQdP0OTflbtGF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjMwIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IER1
cGxpY2F0ZSBsb2cgZnVuY3Rpb25zIGZyb20gbmRjdGwvbW9uaXRvciB0byB1c2UgZm9yIHN0ZG91
dCBhbmQgZmlsZQo+IGxvZ2dpbmcuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBjeGwvbW9uaXRvci5jIHzCoMKgIDI1ICsrKysr
KysrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
CgpIbSB3ZSBhbHJlYWR5IGhhdmUgdXRpbC9sb2cue2MsaH0uIExldHMgbW92ZSB0aGVzZSBhbmQg
YW55IG90aGVyCnJlbGV2YW50IGluZnJhIHRoZXJlLCBhbmQgdGhlbiBpbmNsdWRlIHRob3NlIGlu
IG5kY3RsL21vbml0b3IgYW5kCmN4bC9tb25pdG9yLgoKPiAKPiBkaWZmIC0tZ2l0IGEvY3hsL21v
bml0b3IuYyBiL2N4bC9tb25pdG9yLmMKPiBpbmRleCBjM2Y3ZTM2MzllYzAuLjUxOGQ4MTQyZTQw
ZCAxMDA2NDQKPiAtLS0gYS9jeGwvbW9uaXRvci5jCj4gKysrIGIvY3hsL21vbml0b3IuYwo+IEBA
IC0zOSw2ICszOSwzMSBAQCBzdGF0aWMgc3RydWN0IG1vbml0b3Igewo+IMKgwqDCoMKgwqDCoMKg
wqBib29sIGh1bWFuOwo+IMKgfSBtb25pdG9yOwo+IMKgCj4gK3N0YXRpYyB2b2lkIGxvZ19zdGFu
ZGFyZChzdHJ1Y3QgbG9nX2N0eCAqY3R4LCBpbnQgcHJpb3JpdHksIGNvbnN0IGNoYXIgKmZpbGUs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBsaW5lLCBjb25zdCBjaGFyICpm
biwgY29uc3QgY2hhciAqZm9ybWF0LCB2YV9saXN0IGFyZ3MpCj4gK3sKPiArwqDCoMKgwqDCoMKg
wqBpZiAocHJpb3JpdHkgPT0gNikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmZw
cmludGYoc3Rkb3V0LCBmb3JtYXQsIGFyZ3MpOwo+ICvCoMKgwqDCoMKgwqDCoGVsc2UKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmZwcmludGYoc3RkZXJyLCBmb3JtYXQsIGFyZ3Mp
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBsb2dfZmlsZShzdHJ1Y3QgbG9nX2N0eCAqY3R4LCBp
bnQgcHJpb3JpdHksIGNvbnN0IGNoYXIgKmZpbGUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGludCBsaW5lLCBjb25zdCBjaGFyICpmbiwgY29uc3QgY2hhciAqZm9ybWF0LCB2YV9s
aXN0IGFyZ3MpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBGSUxFICpmID0gbW9uaXRvci5sb2dfZmls
ZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHByaW9yaXR5ICE9IExPR19OT1RJQ0UpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRpbWVzcGVjIHRzOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2tfZ2V0dGltZShDTE9DS19SRUFMVElN
RSwgJnRzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnByaW50ZihmLCAiWyUx
MGxkLiUwOWxkXSBbJWRdICIsIHRzLnR2X3NlYywgdHMudHZfbnNlYywgZ2V0cGlkKCkpOwo+ICvC
oMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgdmZwcmludGYoZiwgZm9ybWF0LCBh
cmdzKTsKPiArwqDCoMKgwqDCoMKgwqBmZmx1c2goZik7Cj4gK30KPiArCj4gwqBzdGF0aWMgaW50
IG1vbml0b3JfZXZlbnQoc3RydWN0IGN4bF9jdHggKmN0eCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgaW50IGZkLCBlcG9sbGZkLCByYyA9IDAsIHRpbWVvdXQgPSAtMTsKPiAKPiAKCg==
