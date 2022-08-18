Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06769C00140
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Aug 2022 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbiHRRpy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbiHRRpw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Aug 2022 13:45:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9E6FA05
        for <linux-cxl@vger.kernel.org>; Thu, 18 Aug 2022 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660844751; x=1692380751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8QwpaxVppjlJ848EYm2bdSbvG0jJr5CaCyBleDPF5J4=;
  b=IP9h64UwhnfCCBc25xzfMXaX5aJmhjO0CqsZHYS77uNnCAeGn/948Zpj
   sSrJzbkTDSS/yV8h8CM+yCx6j08KaU/2AkUBozgy1po2vhgJZuUPS2Mdl
   izgBIViHUFlZNbcT4+e2DbhCI1QfMh1cRwhecwetvUt9pVDI+OarPUwj1
   8g+HO8zS/6Ki+X3z+Hz7WgRugTBfnyOtIChtqbnYMqWBPz00satFDf7Ba
   E7Z+iABu5t5fvr9xj5m8PWdW7BJt6AG8hYH7yniNAnX7s/XSfytcb3lE6
   rAexTUedPeUd6Rwu2aJ4CSzwkw+Hh1CMXc7d1yji8Gxon3dJ+5dxBsk3i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318849365"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318849365"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 10:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558623066"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 10:45:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 10:45:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 10:45:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 10:45:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 10:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=barcQIBpG1X87au4Qqbjq0gdmWsFPqUHWQZ6uJPGZnHqRmQ9APCMarYAlP1FuKiKpWdOMJ5Jar9FZjPQ0xQpwZkQP7VP9QULWzZHBwaE3/+5PGU5/I7s523YxpJz99QhvfFHaZlQSYvCUIS4aab2RrRNpq02yDKtnnqQP+zZ4sA238WHhu0jjpFC8wOzNhRWOabmtbov7yBi+c7SMuX3Dop3mBBnFE6gubZRZD8rDz/ETkDhP0SYRrNtPmu9u9uCLlXF/Ssr4xgW5mHG9ubdMULL18FyPnRD0aheGEyWCJZjBmGjQ0GHu57WJf7p6tO1aurZfdYd2+gHIix1JUEUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QwpaxVppjlJ848EYm2bdSbvG0jJr5CaCyBleDPF5J4=;
 b=U1btZmDYG1e5HpTvgWgFPLFiIc41xJ9IawOqn8mDREhmgAWU/c8y9BV3csoMPYLGL2iSSCQIpUX7QGdtgpUjjYaZIgNmtsqtXS1SQ+2RQHN12HiUAhD0uU9pjhqln8Q0gflDUmqtTLhHq/tq0AZ8M7IRKWVHM48gBdys2YbkL4l+lNgG0JeGg9yUdwwj8itzgeZd+Ws7g0pVcea2TGnHa5p4OmRPPKaJKYyKvse+dWyGuwtBW9bRd1BxMj5Yb5FXnlsOXoolD0TUbnm2nF7DsE22OQlbT9FKAw0/z4Ppak0yWKM5bQxDyr4LF0uM7VQC480cW5TpkMKuakvuwqkGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 17:45:48 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 17:45:47 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "lmw.bobo@gmail.com" <lmw.bobo@gmail.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Thread-Topic: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Thread-Index: AQHYsyGCkMuFK5Y6JEm53hXSCW00HK207m0A
Date:   Thu, 18 Aug 2022 17:45:47 +0000
Message-ID: <2e395b9e710cdeff65dae276cdb4957b43fe2714.camel@intel.com>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb08381-4512-497e-e13e-08da81417bdf
x-ms-traffictypediagnostic: PH0PR11MB4790:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPZf1RS5k6urKh2FkCbOtUAoixG17WXf9V9Dho37WiQ6AhqYTVby8S5EYz265+nFgilep0w/Bw5Mc7xcEAEzSnQn5Y8/Pp67ixUJdqlfS/c7Vm/l7OVQrUV5Cerap7d+J2J16JA6altq6o+O1nNunawCVB1HR1YeLcNncCPuHkK1+0Scepa+N1XNHYr7D8tqsFPiLhldZsWfUEBN0+lJfjUbci9qspEJCAtTflOZ+1xdjY8jKIjG5XdRygCKw2w1Xh1CVuwbLSUf3csZ2CHs6CS7DRHGEnupLkCfVaSHsvZUU7x6RdGOJ4eC2I26oSFZi/f4MDeTd56OoMBBlqkUTtrnfaRfBPqctTFnjEwlQKrxoz94XBuTJ9YRtM+jPB6UC3zC+wRIcAio2IEXTtOUEumTvKWqGtaUOFa+I2Qvroq4UGEUkVkU8IMMfQqdy5G9tJueGGklW6hoLDwckGY9k9HWDXJe7gP7e9b8uU5e1hWvvr0tUCFvqt8CS+9QdP/wT0h9ZTyESHv2ytr74yzxZ+93R5u1T8fwsM5/GqWrsLrGfCVdZg/1Rxt8tjJaRsLHu6wdNnahHpqpUYzWe4PB1bly9Hh4fYdbjiZVcZ8wjaYssuXTWKzCbmsQNtTpT/d5prPZqgdtsRQ3/Vra60WoSUGbVANL30qAvMQOFbhHOinllrRxa6qBFMrQNQq/P+gMJcGHuRzp3QJ/lnyCVAG+VUUQlig82KjuH+XGRjX+TbVq+p4L97+tUDTFvvqlMcLXi95b0RfJh8VA4b+TlZbuCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(346002)(39860400002)(91956017)(71200400001)(82960400001)(6506007)(26005)(316002)(5660300002)(66476007)(110136005)(66946007)(38100700002)(66446008)(86362001)(4326008)(66556008)(64756008)(54906003)(8936002)(8676002)(36756003)(6512007)(41300700001)(38070700005)(186003)(107886003)(2906002)(478600001)(122000001)(6486002)(2616005)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?My8vaVlzbkkrcXpjZGtaTXJYT0JxbWpheWMxQ2JUWktSaHBWMmlxSHVEd3Uy?=
 =?utf-8?B?Ym9OWjRkUEhCNXJMeFYyREQzQVl3OEtpYWQzcUFoTEFQTkF6Vi9xdlo5MlNn?=
 =?utf-8?B?elcvVEVzTnIrdzA0UGRobDVYRXZXVGR5V1A3cTNSWGVjSXRWTnlPNmhjZFVW?=
 =?utf-8?B?V3ROd2Y1SGVWaThzbVdOM3U0VFdlQVVSaGdGa3lnNXVnWGhoRzB1aFRqa2t3?=
 =?utf-8?B?Nk1TSGZoMzVFS3BOeTVwOWVkd2UyaGEzbjg1VUtPemtGb1Joc3JCbFZmU3Bl?=
 =?utf-8?B?VVQ5dk95Q0pPYXFCSC9KNFc0MWJsT0ZxRGdtZDhRYmJzUzBsWmd4ZmdJWjFT?=
 =?utf-8?B?ZWdpN0VjTVloU1NYWlZUWmRnb3RxaDZPQmMvajZoZEt6RW5QWlRCL2xmdFFi?=
 =?utf-8?B?MkR3NXkyU0M4RDVqQnllUy9IM25FUms0SERuajNhWURvZTlJZUU3MXVCYzZk?=
 =?utf-8?B?dGl2c3BLdThXajN2M3lNYVEwekUyNDEza1hMbVRTNmdPODlmS2toS3VNVjQr?=
 =?utf-8?B?Z3JQZi82TkhsY1EyYUx6UldBYjM3eitKYzNVb0Vyekx4REhLOWNpTEErSFVR?=
 =?utf-8?B?UHgzMmVlSURkOFgvUXJlTWMzaHZIVlVZb0sxNStpYzRhT212bjhWUm9jcm1V?=
 =?utf-8?B?ZENJdzZhelVMU0t2SFpyOUlFb3FMZDhIQ09nZnBnU1FZSzJqeGxHMGFsbGph?=
 =?utf-8?B?QzNQNUM5T1pZcis5R2M1VlVIZlB0cTB6akc5VkV0UFJJOXVkcU5mMEEveVVC?=
 =?utf-8?B?Tm90T3hDZVEvMXJIbThRZEtkRitWdWMrV2dEQ2RtNUFGMXUyWFNHb0tyejN4?=
 =?utf-8?B?SkdhY0UzMDFaVnlacVJZc1pZOEJxb1VlSTRSUjZhcVhKU0tCaHFCNGgrbjVG?=
 =?utf-8?B?ZXUyTEUwSkl3Ny9OMWV6eUJqMTU1TEI0dHlYdjhLMGl4RlhnS1Y5bDBhZzJl?=
 =?utf-8?B?RDJJU1lUbkxKRTQ0a0lYb2FaNFlYUGppcVVZVEtzK29MQ1dJa0IwaXRBV1hp?=
 =?utf-8?B?OW56VDlsY2JtQzhKS090TDRkSEp2WkNqSTJjamVmTGpVREJpclU0L0dkOEta?=
 =?utf-8?B?TUdUcmNXdEFCQkg5cWNYS2ZJR0IxT3RKMEN0MmZZNURvbVN0TllxS3lnNEdn?=
 =?utf-8?B?T0gxOXFPcVcxRFRteFprZVkyMGZURnJUMitZc3poMzR6LzFFQVIxaFFCQzYr?=
 =?utf-8?B?NXlrb0hNTGZNM05NbXA2eVdINStqTTlvV08yT0VQbHVLRjdPRDNTaUxhQXc4?=
 =?utf-8?B?ckZXVDVCakxkZHZ4TmJQLytiakN6SStIeE1nZVFhQVB3eFkwa2dTNWpBNEFl?=
 =?utf-8?B?UXpTREJ5bnhYS2VIRThYYklHVHMyaXdpNWNWQXFPZERYUnh3bkxmM1drK1lZ?=
 =?utf-8?B?Wlo5LzJKajl3ZkN1bTBXQTV4UWZpK1dhbkFPcE1xQnRJYjhYNXhBZEkya0dB?=
 =?utf-8?B?MUpUMTBoRGlPczJaU1BoY1pJVmhrZ1ZKMDhnR0laclNJTFJQbmFQRE1JTmg4?=
 =?utf-8?B?djY3bjB4cVB2Wkp5MWQ2VmZMTFlMczZkRnF4b2dZT3V4alowb2RwWiswSld0?=
 =?utf-8?B?Z0hJT25XQk5hR2M4VmNJY0NDTzd2dlQ2YUVmV0lzNysxdVpBRG9rWkhCRDBo?=
 =?utf-8?B?OWc3NDlSM2MvSEdId0E1UEppL0tKdXZTMzRPc3U2RTUwN3ZXaGV5QS90bS9w?=
 =?utf-8?B?Mk9xbXh0elpQenpCalk1aWNmM3N4QlhRalI5Y2JOQi9FUXBHcVBuNTdSM2k4?=
 =?utf-8?B?eTJHTEY4dTJCMTcvN0F6NDNQWkN0TUU1cWFVbC9KUUU0ZTVyU2VpWW9QaWlE?=
 =?utf-8?B?cm13Yk0veUUxWmdQNEI5UW9CNURvUDRvSm5RVnpja0Q0MTlmSnZPWlhiZlZx?=
 =?utf-8?B?UENYVFduVS9USno5NEh2NFAwNHFKemFNQTlRM0RPL0hNZUFOdFpKYktWN0dV?=
 =?utf-8?B?c29LWVdnalZRdS9ZczF1YWtMWEFGVk14V1NlM1phbE96bEhjRWYxL2RQRUNT?=
 =?utf-8?B?SzJhUHl0cEZObHI0SHRsRE9yK2MvTmNIeUlkQkVlQXFVRk94WDJWMnF1YW9B?=
 =?utf-8?B?a1pYcGxjNHUyWmtwU0pIc2JGT2hxYTRlR3lUd3UrVWJ5b2Jia3NNelRQTmhO?=
 =?utf-8?B?NW9qTDVveW4vdXppK1JnUzFUYWNscXZnYXA0Qm96YUxDeUFvSk9ybFIweUc2?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9050325A48CB43A3B2BBC8C4222ACE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb08381-4512-497e-e13e-08da81417bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 17:45:47.7317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+EOIhxmXxf930rDXwEifqkpMkw+5dQz57Ii1FKt3CEGyJNuEeWilZ/ieBaa6QUZpr/SDRjOYGYvC0ajoKcM+8qSFCPADBpMP6KQcdCozfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTE4IGF0IDE3OjQyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE5vdCBhbGwgZGVjb2RlcnMgaGF2ZSBhIGNvbW1pdCBjYWxsYmFjay4KPiAKPiBUaGUgQ1hM
IHNwZWNpZmljYXRpb24gYWxsb3dzIGEgaG9zdCBicmlkZ2Ugd2l0aCBhIHNpbmdsZSByb290IHBv
cnQgdG8KPiBoYXZlIG5vIGV4cGxpY2l0IEhETSBkZWNvZGVycy4gQ3VycmVudGx5IHdlIGFzc3Vt
ZXMgdGhlcmUgYXJlIG5vbmUuCgpzL2Fzc3VtZXMvYXNzdW1lLyBvciwKJ3RoZSByZWdpb24gZHJp
dmVyJyBpbnN0ZWFkIG9mICd3ZSc/Cgo+IEFzIHN1Y2ggd2UgY3JlYXRlIGEgc3BlY2lhbCBwYXNz
IHRocm91Z2ggZGVjb2RlciBpbnN0YW5jZSB3aXRob3V0Cj4gYSBjb21taXQgY2FsbGJhY2suCj4g
Cj4gUHJpb3IgdG8gdGhpcyBwYXRjaCwgdGhlIGNvbW1pdCBjYWxsYmFjayB3YXMgY2FsbGVkIHVu
Y29uZGl0aW9uYWxseS4KPiBUaHVzIGEgY29uZmlndXJhdGlvbiB3aXRoIDEgSG9zdCBCcmlkZ2Us
IDEgUm9vdCBQb3J0LCAxIHN3aXRjaCB3aXRoCj4gbXVsdGlwbGUgZG93bnN0cmVhbSBwb3J0cyBi
ZWxvdyB3aGljaCB0aGVyZSBhcmUgbXVsdGlwbGUgQ1hMIHR5cGUgMwo+IGRldmljZXMgcmVzdWx0
cyBpbiBhIHNpdHVhdGlvbiB3aGVyZSBjb21taXR0aW5nIHRoZSByZWdpb24gY2F1c2VzCj4gYSBu
dWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuCj4gCj4gUmVwb3J0ZWQtYnk6IEJvYm8gV0wgPGxtdy5i
b2JvQGdtYWlsLmNvbT4KPiBGaXhlczogMTc2YmFlZmIyZWI1ICgiY3hsL2hkbTogQ29tbWl0IGRl
Y29kZXIgc3RhdGUgdG8gaGFyZHdhcmUiKQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVy
b24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4KPiAtLS0KPiAKPiBXZSBjb3VsZCBmaXgg
dGhpcyB3aXRoIGEgc3R1YiBmdW5jdGlvbiBwZXJoYXBzIGFzIGFuIGFsdGVybmF0aXZlPwo+IAo+
IMKgZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8IDMgKystCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdv
b2QgdG8gbWUsCgpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRl
bC5jb20+Cgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYwo+IGluZGV4IDQwMTE0ODAxNjk3OC4uYzQ5ZDlhNWYxMDkx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKPiArKysgYi9kcml2ZXJz
L2N4bC9jb3JlL3JlZ2lvbi5jCj4gQEAgLTE3NCw3ICsxNzQsOCBAQCBzdGF0aWMgaW50IGN4bF9y
ZWdpb25fZGVjb2RlX2NvbW1pdChzdHJ1Y3QKPiBjeGxfcmVnaW9uICpjeGxyKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRlciA9IHRvX2N4bF9wb3J0KGl0ZXIt
PmRldi5wYXJlbnQpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY3hsX3JyID0gY3hsX3JyX2xvYWQoaXRlciwgY3hscik7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3hsZCA9IGN4bF9yci0+ZGVjb2Rl
cjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0g
Y3hsZC0+Y29tbWl0KGN4bGQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKGN4bGQtPmNvbW1pdCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGN4bGQtPmNvbW1pdChj
eGxkKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAocmMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fQoK
