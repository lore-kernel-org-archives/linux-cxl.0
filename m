Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D9C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 00:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKIA6x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKIA6w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 19:58:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD612755
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 16:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667955530; x=1699491530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o7QAx6JAfdLG1ic106I4vgXkRncq9jNCzWkEDRMXe8k=;
  b=bMwcJjFRDfxF5seG0VRdMxgElw6iUqK988m/7luwYIwjjNZ8vJjFb5zD
   sTbXaUset4V+j4eD4dXAoESRAGbkymOess5y2Rns1TKBN2DaKAVh8B2MZ
   Y9VXImJhFDQRd1TTRdCNj7Toz4frxTeRwqXUNEKLNU/g/Jm3hfcSmdsPY
   OuWO89+IkWQa3R4IrNR0EIXNFVvZdfNy0NtlF6hfmmvkXnkbVwApndq1g
   TNsmVXlhkR7PhHbw/BNtv/VWze3/xliTYi3x/VwwNL3IKgwpdsK5/Og1+
   7KyypPTpHNnt09kzZd6TJcQvIKANeGBxhxxXHXWZXXBJcCOD4atFWgDTB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310849007"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="310849007"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 16:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="639001845"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="639001845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 08 Nov 2022 16:58:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:58:49 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:58:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 16:58:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 16:58:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVOIIEx1/lcHCqOFjikOsTK8CV3qFqJmjj13ZdSl/LIc7/ZkAeQmI6EwOQtu7ay++tWH+qJIJeyO8S1HUqEmsqhdmhkXkiONa2DKrzgbvLxAT9JbZo/7bCvi3bj5CjzcRJuv1OKeLmxUvxkNOht4Wb3yBp7gq9JM671qqxjfvkPz8ZwfyakNxQxkaVgSYxQCQj1iNjUj/84jg90Fop9KPHUa+YXrktFqAHpIsc2Ts0HGgOI8nemfBMAk2Pod+0QCJjNVqFK3uh4LedRY8OI5HyEkLL2MwwC79XGTF2jmhn/4yjKl7ZErAdo1TM5g19QfX/2pkpIg/V4alA5D75IomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7QAx6JAfdLG1ic106I4vgXkRncq9jNCzWkEDRMXe8k=;
 b=b+I9Fk73loumam+tD83gb3Gug92x/zG9UIdoY5S4/KQqJvqrPrAY2f3rqe3cuG6B2Fa5wiomJZCTdaLW3vAiaHAfUcp5vb52TtFuxYgXzN3hl2YOUrwiigVilNtYuMCYynH6qm9BG46m52S8rDES3EcYYKLa6D7igGnZ3LFoBdTrY7byQ1mwDxYLI2/746zW65SHhQqOBSmE4a9VQuguq+W8lWOAEmqTR5jLqXptFAx/SGKNzlMeciWgoFoQHsswT0DSw9egyByoCVCtDUJY/35kY+UcCnPt1DL2yAPFDjKhXNrJxMmP4Qvbv2PFcyHYmcJZMWVVjJFcGBW/JOaDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 00:58:41 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 00:58:41 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 10/10] cxl: add man page documentation for monitor
Thread-Topic: [PATCH v4 10/10] cxl: add man page documentation for monitor
Thread-Index: AQHY86BCuhdE+qNYwEq1U9VG4k/RBq41xY8A
Date:   Wed, 9 Nov 2022 00:58:41 +0000
Message-ID: <cc92e8defb8da60a60a1f0e9802e4b4d914f3912.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793224539.3768752.16520384828313781321.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793224539.3768752.16520384828313781321.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY5PR11MB6535:EE_
x-ms-office365-filtering-correlation-id: 374bb62b-3b3b-4e80-a3f0-08dac1ed8b30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODx12Bnicid5EwO6+MlebgNuzyGoNaSVWywl/xG83jvCSo/nbj+xmFXA55xxBQqX3qle5PyTB+F5C6yW93xXs8ITMCcqc/MyGpSbqNusJARk0ekCGDmNwBj4RG8HNO92RECmyRqUPtkbbRocSYkCTV6lDzXAJV2vMh1bNyiACnr0S9ImcL5jbMoUPHGued97k+xOkXAGBaeqO0tZRUIF8qTrJr+ies9CMjBMqgmqIfYXM2EheZ48z1hHRiAmgZw2kXmGcvYvOydqKAWtLF3N7+h1dNdZyJMRhwWu4t4gnMMTgvVKd+LX2XTNNJnu5xDy5D0f2+xRGSDMZ5QdAwog4qJoAATAGNSTI6qhjZG1PyamlSRMTJ9tjU7jBD3/B72ulr/Lgxo4RuweiYBtA48DzclE8f/6Q9JMMPRgIK/zG9wvD6FkNDr6XfmHzWRSFoi6//76fY9W7a1n+SoZtNcsGQx1wNSmZGKgkK6F8eB6rugg3VDQ7s2T6GZ5N4RXYXUFpnlkDDp5M0BsCw1+J30ipqsmDISk6VQujo6vPTaksprrduOx9fQkOnRlfTA6MFPz4qDmenzZrPXUbk/MpZOpX27tnfR0iN3PdTXL/xbvWWnDl8lTLsBkerPMHZA9r3v5fErwGBei2vdKbpmbDTHspsdqwm/RIS08/cVKIl7miKn5+Ewv7f6RllgTtwexFLvtiOGugM5KPtTV2Bm2Hm6CreQgmgcAdUl+4bYEyByxfD0vi0OUUC15UH+/+UAXHLjiY3xjDCUeYs0YiA2LSVVnZWPy7YobHhyDG7MOAt4AoMJA3WbcwSKD6I1cDtudomkq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(41300700001)(54906003)(110136005)(5660300002)(83380400001)(36756003)(2906002)(64756008)(8676002)(66476007)(66556008)(66446008)(91956017)(76116006)(107886003)(316002)(71200400001)(4326008)(8936002)(66946007)(6486002)(478600001)(186003)(2616005)(82960400001)(38100700002)(86362001)(6506007)(38070700005)(122000001)(6512007)(26005)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFueTJpcEJoenM0WWJNS2pReDBibytUb2EraEptVThEUG5WSDN5TkpXNkxS?=
 =?utf-8?B?MHEzd1hiVU9nNmhoOXNRbG54V1MzamtQQ05BWC9qcGwvNnFwR3BVSnNuSHlC?=
 =?utf-8?B?eW1yd2Z2aFJsNlprYnZBK2xVQWlXc0hpemluSWEyQTZwWjI5NU9YbVoybHM1?=
 =?utf-8?B?VXNOWVFtaUlXK0Jjem1wOU9UZzFCaG5vclIyMXJycWFqRm04ajQva3Vsb1ZE?=
 =?utf-8?B?ZDZsbFI2ak1HMlVNZlJ3UktFbTkxUk9PZjhUb3dtRWY3TlBaQVRMNkRBa1Fv?=
 =?utf-8?B?NnozenBVTTE2cndXL2RaZlMxZEhFYm1lN2RYbDFKZEszaHVjcm51dnRsZi9q?=
 =?utf-8?B?dCsrRXlzWjZJQ2xFaDIvWFpWdTQ3UXV2bXA3eFcrQjZEM2d5eTNzbzRsUkVx?=
 =?utf-8?B?SjZiVEdRcm85ZzBhUXN4NXRFS2I1K3hDWjN1WU9wUWx4TDFlN015SWtMRjZi?=
 =?utf-8?B?SE1OT1VIU2tUNE4zQjUwT2U2REFyaURSbm9tUTZBeHl1c29jalo5N3FUMHZj?=
 =?utf-8?B?Q3lDcW83blRqS2kvaE1lV3dHckdPekdOVzhGK0s1YTNVcFRGVGhpS1BQaHBj?=
 =?utf-8?B?SzZBdVA4dzYzQ1RTRWNvRk1VUmh6bG1wRlR5eWNuZ3NUOHVFWklJZXFaZzNU?=
 =?utf-8?B?bnVVNGV3Mlpxdm81VVhhK1BIZnJIMG1ZZGFjYWtCR3J5bzBGOVMyV0dZdUpH?=
 =?utf-8?B?eDdyT2hiZFZoNjhubkpCeUltTTlZYmpzdFdPajZRTXJ1Z0pxOFFobTEyNTFG?=
 =?utf-8?B?N0N4WUF2dVo1MG9ON1Y1Szl5RGZRbWNDSnRlYkM1SkYxbC9BVC9XSFBUWW9x?=
 =?utf-8?B?L2pkempKeXFOaG1YMHRRLzdkTUh2OUREckJnQ1JSQkJGNnhmL1FaN3NHMG4x?=
 =?utf-8?B?SlFWWXBvb21oUEZPdW1LakZhUS9ETUFRemd2K1lNVmg3MjV2ZUR3b3dBWEp5?=
 =?utf-8?B?VTRkQ01Ja0lrL0xLbUVCTDcwaW43V3Q0cEU4R2YyMTdFRmUwdEVUbllYYmdt?=
 =?utf-8?B?YnU2YTFlL1hOM1pNNjltNmlqYjJZYk9EbTFjY1NaYTVkY1F5Rk4xbjR6UWx4?=
 =?utf-8?B?eUhBMlBaWmNxWXMya3NvMGdITmRCZGxYZFkwdENxME1abnEzdzhMbENMNlBj?=
 =?utf-8?B?SWFLNjJGRTU1ZFpCditZbWNweHZ1bm4yK1lYN0tnS2dMT21XRmtMVzRidzZm?=
 =?utf-8?B?TVdzMlI5SDhHcWRvTUtZZW1WKyt0Tk5EOGpRYUovbGw1eXFPcHJ4Z1M0dm8v?=
 =?utf-8?B?NThZcDVwRHp2UE1nek9VN1E1Qm96ZlhlcVdidnNZY2J0TjBxWHRZd0hEdkph?=
 =?utf-8?B?Qi9LQm4wM1hldUZtNmUxcldmQkw3bkE2L3AvMHJtZ3FwYWdpbWpqRVhielJW?=
 =?utf-8?B?dkZyV2piZlJ4MytVMU1yN0ViSld5TWJnMmhUcU9Jb0UrWFFFK3lsQ1dvNDdi?=
 =?utf-8?B?SFBsZjZJWUd5cWQxNGlFK1UvbGc1NFlvbVVsNEhyeG9HMlRuTnh5cG9nV2Vs?=
 =?utf-8?B?aDErUGtJRExQODR6QlkyVDBuNXN0OTBGYzdsVlE5cndnV1lyQ05NcENiNVdw?=
 =?utf-8?B?OStKS3Y5L3F4U0YwRnJQRG5mL1FYeGV4T3F1bDBSOG50NDdJcm9YTEJWYW5h?=
 =?utf-8?B?RVdoV1R3NlNsckYwNlZHRFNPRTlLYmpCT1V5MHRqSmwxYktwT2JQTW5NcUNQ?=
 =?utf-8?B?d0oyWkNQaWtQK1lLazE5ZHl3Y21EcGphTko0QUZWT01iVGNhOUludWJBNFRO?=
 =?utf-8?B?WVZmRmtwdk14cmtoZjFFVzBQWnE5WmlOUkRTeHIzMndkVmxjUFZzNHJ0NWNC?=
 =?utf-8?B?bC9ncmJnWFE2azJ0VmtkeStzSnk2SC9zMGticVlJNXk3VHJqVm9zUnE3eDZF?=
 =?utf-8?B?MW9iQ3JzUVBldzBQNGlkYkh3YUdoY0wrZm9tdmRyYVNGNllMa3RuOTBYdmlW?=
 =?utf-8?B?TXg4ZTBERGEyOUZPVXR6SDFMNXJYMUhWWXNHaVVjRE9XZkJVeXZhRWN6VG41?=
 =?utf-8?B?WkducDJmdmVXdXlscmJzTGZBd29QWTVGL0hlZXZDc3BkUFQ4OUZWZ25TMkJU?=
 =?utf-8?B?dGt1UDlrNThJMlBlbS8wMWJaVmYrUUY2cmc4eWgxdXFkWmlzM3d0c2Izdkxt?=
 =?utf-8?B?c0dqR0NsbG1NYUVHYXZXQnJhempqL2d2UVgzbU0wY0RvU0Zqam5YUVBBZlVw?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D889DC28E0894479ECF0C5865674A32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374bb62b-3b3b-4e80-a3f0-08dac1ed8b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 00:58:41.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygEKwRi+yYaKtPWtWzPHtLbv11J69c3gO845VlRaq/VPRPAhbnterAGJ9zgaLALL4jUKxjnkijNHxNl1qYxym3U8nDCSUemFM+nqduRjdMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjMwIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOg0KPiBB
ZGQgbWFuIHBhZ2UgZG9jdW1lbnRhdGlvbiB0byBleHBsYWluIHRoZSB1c2FnZSBvZiBjeGwgbW9u
aXRvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gwqBEb2N1bWVudGF0aW9uL2N4bC9jeGwtbW9uaXRvci50eHQgfMKgwqAg
NzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KDQpJcyB0aGlzIG1pc3Np
bmcgYW4gdXBkYXRlIHRvIGEgbWVzb24uYnVpbGQgaW4gRG9jdW1lbnRhdGlvbi9jeGw/DQoNCj4g
wqAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2N4bC9jeGwtbW9uaXRvci50eHQNCj4gDQo+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2N4bC9jeGwtbW9uaXRvci50eHQgYi9Eb2N1bWVudGF0aW9uL2N4bC9jeGwt
bW9uaXRvci50eHQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li40M2MyZWNlNzIyMjANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2N4
bC9jeGwtbW9uaXRvci50eHQNCj4gQEAgLTAsMCArMSw3NyBAQA0KPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKw0KPiArY3hsLW1vbml0b3IoMSkNCj4gKz09PT09PT09
PT09PT09PT0NCg0KVW5hbGlnbmVkICc9PT0nIGxpbmUNCg0KPiArDQo+ICtOQU1FDQo+ICstLS0t
DQo+ICtjeGwtbW9uaXRvciAtIE1vbml0b3IgdGhlIENYTCBrZXJuZWwgdHJhY2UgZXZlbnRzDQoN
ClByb2JhYmx5IGRyb3AgJ2tlcm5lbCcgaGVyZS4NCg0KPiArDQo+ICtTWU5PUFNJUw0KPiArLS0t
LS0tLS0NCj4gK1t2ZXJzZV0NCj4gKydjeGwgbW9uaXRvcicgWzxvcHRpb25zPl0NCj4gKw0KPiAr
REVTQ1JJUFRJT04NCj4gKy0tLS0tLS0tLS0tDQo+ICtDeGwgbW9uaXRvciBpcyB1c2VkIGZvciBt
b25pdG9yaW5nIHRoZSBDWEwgdHJhY2UgZXZlbnRzIGVtaXR0ZWQgYnkNCg0Kcy9DeGwvQ1hMLyBv
ciBzL0N4bCBtb25pdG9yL2N4bC1tb25pdG9yLyBJIHRoaW5rLg0KDQo+ICt0aGUga2VybmVsIGFu
ZCBjb252ZXJ0IHRoZW0gdG8ganNvbiBvYmplY3RzIGFuZCBkdW1waW5nIHRoZSBqc29uIGZvcm1h
dA0KPiArbm90aWZpY2F0aW9ucyB0byBzdGFuZGFyZCBvdXRwdXQgb3IgYSBsb2dmaWxlLg0KPiAr
DQo+ICtCb3RoLCB0aGUgdmFsdWVzIGluIGNvbmZpZ3VyYXRpb24gZmlsZSBhbmQgaW4gb3B0aW9u
cyB3aWxsIHdvcmsuIElmDQoNCnMvZmlsZS9maWxlLC8NCg0KQWxzbyBpcyBjb25maWcgZmlsZSBz
dXBwb3J0IGFjdHVhbGx5IHByZXNlbnQgeWV0Pw0KDQo+ICt0aGVyZSBpcyBhIGNvbmZsaWN0LCB0
aGUgdmFsdWVzIGluIG9wdGlvbnMgd2lsbCBvdmVycmlkZSB0aGUgdmFsdWVzIGluDQo+ICt0aGUg
Y29uZmlndXJhdGlvbiBmaWxlLiBBbnkgdXBkYXRlZCB2YWx1ZXMgaW4gdGhlIGNvbmZpZ3VyYXRp
b24gZmlsZSB3aWxsDQo+ICt0YWtlIGVmZmVjdCBvbmx5IGFmdGVyIHRoZSBtb25pdG9yIHByb2Nl
c3MgaXMgcmVzdGFydGVkLg0KPiArDQo+ICtFWEFNUExFUw0KPiArLS0tLS0tLS0NCj4gKw0KPiAr
UnVuIGEgbW9uaXRvciBhcyBhIGRhZW1vbiB0byBtb25pdG9yIGV2ZW50cyBhbmQgb3V0cHV0IHRv
IGEgbG9nIGZpbGUuDQo+ICtbdmVyc2VdDQo+ICtjeGwgbW9uaXRvciAtLWRhZW1vbiAtLWxvZz0v
dmFyL2xvZy9jeGwtbW9uaXRvci5sb2cNCj4gKw0KPiArUnVuIGEgbW9uaXRvciBhcyBhIG9uZS1z
aG90IGNvbW1hbmQgYW5kIG91dHB1dCB0aGUgbm90aWZpY2F0aW9ucyB0byBzdGRpby4NCj4gK1t2
ZXJzZV0NCj4gK2N4bCBtb25pdG9yDQo+ICsNCj4gK1J1biBhIG1vbml0b3IgZGFlbW9uIGFzIGEg
c3lzdGVtIHNlcnZpY2UNCj4gK1t2ZXJzZV0NCj4gK3N5c3RlbWN0bCBzdGFydCBjeGwtbW9uaXRv
ci5zZXJ2aWNlDQo+ICsNCj4gK09QVElPTlMNCj4gKy0tLS0tLS0NCj4gKy1sOjoNCj4gKy0tbG9n
PTo6DQo+ICvCoMKgwqDCoMKgwqDCoFNlbmQgbG9nIG1lc3NhZ2VzIHRvIHRoZSBzcGVjaWZpZWQg
ZGVzdGluYXRpb24uDQo+ICvCoMKgwqDCoMKgwqDCoC0gIjxmaWxlPiI6DQo+ICvCoMKgwqDCoMKg
wqDCoMKgIFNlbmQgbG9nIG1lc3NhZ2VzIHRvIHNwZWNpZmllZCA8ZmlsZT4uIFdoZW4gZm9wZW4o
KSBpcyBub3QgYWJsZQ0KPiArwqDCoMKgwqDCoMKgwqDCoCB0byBvcGVuIDxmaWxlPiwgbG9nIG1l
c3NhZ2VzIHdpbGwgYmUgZm9yd2FyZGVkIHRvIHN5c2xvZy4NCj4gK8KgwqDCoMKgwqDCoMKgLSAi
c3RhbmRhcmQiOg0KPiArwqDCoMKgwqDCoMKgwqDCoCBTZW5kIG1lc3NhZ2VzIHRvIHN0YW5kYXJk
IG91dHB1dC4NCj4gKw0KPiArVGhlIGRlZmF1bHQgbG9nIGRlc3RpbmF0aW9uIGlzICcvdmFyL2xv
Zy9jeGwtbW9uaXRvci5sb2cnIGlmICItLWRhZW1vbiIgaXMgc3BlY2lmaWVkLA0KPiArb3RoZXJ3
aXNlICdzdGFuZGFyZCcuIE5vdGUgdGhhdCBzdGFuZGFyZCBhbmQgcmVsYXRpdmUgcGF0aCBmb3Ig
PGZpbGU+DQo+ICt3aWxsIG5vdCB3b3JrIGlmICItLWRhZW1vbiIgaXMgc3BlY2lmaWVkLg0KPiAr
DQo+ICstLWRhZW1vbjo6DQo+ICvCoMKgwqDCoMKgwqDCoFJ1biBhIG1vbml0b3IgYXMgYSBkYWVt
b24uDQo+ICsNCj4gKy11OjoNCj4gKy0taHVtYW46Og0KPiArwqDCoMKgwqDCoMKgwqBPdXRwdXQg
bW9uaXRvciBub3RpZmljYXRpb24gYXMgaHVtYW4gZnJpZW5kbHkganNvbiBmb3JtYXQgaW5zdGVh
ZA0KPiArwqDCoMKgwqDCoMKgwqBvZiB0aGUgZGVmYXVsdCBtYWNoaW5lIGZyaWVuZGx5IGpzb24g
Zm9ybWF0Lg0KPiArDQo+ICstdjo6DQo+ICstLXZlcmJvc2U6Og0KPiArwqDCoMKgwqDCoMKgwqBF
bWl0IGV4dHJhIGRlYnVnIG1lc3NhZ2VzIHRvIGxvZy4NCj4gKw0KPiArQ09QWVJJR0hUDQo+ICst
LS0tLS0tLS0NCj4gK0NvcHlyaWdodCAoYykgMjAyMiwgSW50ZWwgQ29ycC4gTGljZW5zZSBHUEx2
MjogR05VIEdQTCB2ZXJzaW9uIDINCj4gKzxodHRwOi8vZ251Lm9yZy9saWNlbnNlcy9ncGwuaHRt
bD4uIFRoaXMgaXMgZnJlZSBzb2Z0d2FyZTogeW91IGFyZQ0KPiArZnJlZSB0byBjaGFuZ2UgYW5k
IHJlZGlzdHJpYnV0ZSBpdC4gVGhlcmUgaXMgTk8gV0FSUkFOVFksIHRvIHRoZQ0KPiArZXh0ZW50
IHBlcm1pdHRlZCBieSBsYXcuDQoNCkkgdGhpbmsgdGhlcmUgaXMgYW4gaW5jbHVkZSBmb3IgdGhl
IGNvcHlyaWdodCB1bmRlciBEb2N1bWVudGF0aW9uL2N4bCwNCmFzIHdlbGwgYXMgZm9yIGh1bWFu
IGFuZCB2ZXJib3NlIG9wdGlvbnMuDQoNCj4gKw0KPiArU0VFIEFMU08NCj4gKy0tLS0tLS0tDQo+
ICtsaW5rY3hsOmN4bC1saXN0WzFdDQo+IA0KPiANCg0K
