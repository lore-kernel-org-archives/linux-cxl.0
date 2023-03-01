Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB80C6FA9D
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCATCI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCATCH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 14:02:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DD415148
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677697324; x=1709233324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Enjn48xl305fz3NpX3NnSF+bxR8hGQV5o3YbqxUbipw=;
  b=bEtkhODiw0FcsVuIf+g292fQsT7ycq1oiTVamI1E2RA6pUP1ikGXhjIT
   ow9Mqm2RJf2q51QRFv1BIcw4aR8tc35PigVgY7ndfGmR2z+iIEWa0wZxt
   6KPkg4pBUe1FBVBNhweE6jtrqSJSlpEnTq0gAKND2GCLxvZdUiqCv/cxi
   cTzSs5fo0X+YUcfvnecBe3nFgYhOaw5xNMR6LQhS1ug93E8YWWvdpPA21
   bZ4yAUZugQlNGXOrvWYMyad0q/wVVuQzLOJvd7E/vUL/0m33cywDCna7T
   sMDFZiPwSskZyCEKA4McFUrQv9Wp6rJ3Ju1b4dPB79tAAeNaF+rFdXtYc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336786242"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="336786242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 11:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652112322"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="652112322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2023 11:01:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 11:01:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 11:01:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 11:01:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 11:01:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5i+8ZlygElKbLqSkYMjUX9U8TqqTKKwEJYgGQusdLtefOS5c8ZsMeeus8+40kEwfDcsrTvf+2L+DKkbIYznQtsRoCUzq9WN2RR9nSWf1BvjaIR4rJWPhQ1Arw/tDIdiAKEVfC0SaO86760//f30nvrPCOdnOptikFY1ancCrulYZ5RYv4LXDcX0+yyTDzcbkv0bwVyipzF984jMduYVRrNShbS+/w2QIg0U/hYR+nctdt0JEnpnn8JcOxqgrXs3cyd/crvJeCH4v0MV5aVkhA80BY9dnvaM5Ebkzgb0Fg7ej26W0HBFY+CkVqdZfJlbW3FNhbygO937biCwo3YA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enjn48xl305fz3NpX3NnSF+bxR8hGQV5o3YbqxUbipw=;
 b=K9ZWxgR62sWSFA9Bm3o0bOPlLqv8hH2Bxly8PNLFeLylkFazE846ksOnQsaKqszWompTWvk8FLa743vztVad0sZFhDMZ6x2spoFr6/IheI5XvJMSSHlJFQaW8+jySbsr9cMvAWnX8/mR07NNLzki0sQ9w3zBBTykbLLxIGrWLlNXDwafiL7unf5LyxSyGpgvqRS+W+kTRFvZXFVwNcDQ0yE9YWuvOWsWEeQC9VCnk1MOsMGohDrJZlVK9F1PnYGt+olmyg4HM52G6M6uwosubdy8gWQ37RTlvQIdo0RGCBgWtTtO6E5EtbWm4nnnR7dzNASHyrE05qNcTtbPsiRGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 19:01:27 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 19:01:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>,
        "im, junhyeok" <junhyeok.im@samsung.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Thread-Topic: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Thread-Index: AQHZROewN3/kkfI3bU2BKHP/Q5uiIq7iK2wAgAH83QCAAi5YgA==
Date:   Wed, 1 Mar 2023 19:01:27 +0000
Message-ID: <49e6870cbb846beadce4ef475226af0601db63fa.camel@intel.com>
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
         <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
         <20230220045709.94027-3-junhyeok.im@samsung.com>
         <Y/whyOESQ0fRIpNZ@aschofie-mobl2> <Y/3MpsTbFfZhTp7C@dell-ArcherCity>
In-Reply-To: <Y/3MpsTbFfZhTp7C@dell-ArcherCity>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB5971:EE_
x-ms-office365-filtering-correlation-id: c49770e2-fc56-4dc6-eb61-08db1a875c2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnuoNNHh0RO0srDD+IjOj7lPLUkmcjlwpWuUS8CUq7AVz06rFovtJD+diTYkRdg8HRAynLpwgL+Y3srLTn5STlJnld04fFNiibOM83of86AfsvzH/xm64P0U9MdvbROohquF+zvp3wRHJKe5Q5kB70EouocPeHwSUKCGcAygA+QaUaJbDzl43MsCVAzex0uMZfML48IAzH7KtYuAXMZvffJcLNbVhGIm+J/Usz+aIe9r1QDIio8SrmgLx0r3uFGaRXTmpnLWkLZzFwzcERXF5MgKLNlKAi/uTLVWgsm3Q2+kV/ENVLjqrSqy/aPi07xUHTu6gPXSwG9DZkG8YZQG1eGaJG19Zo4rmV0i57GdIdwuC4jfmvjmWmRWeYZl+wFI9KWDhpBl4JfS5KJJ6UF5nvY0Mwx+oKsD9ht7gIoQIKM2v9ZLTY/FHcKAkFhODfeY1UglTLt+VG8kLMM77RnKquB7mg3DIw2Gp2NFBFXYDRW4j4C/26mbZaLpJdowmLbn8moJAGHPIPWbJ7xHEnaU+lpbqkg7SdHo+YT9PVgpsY2OfUTAyzGfgiZr3C3VKAZY19DCExnDlfvDgZhrfH0hDoLUDszdDLFIJSBPdW+N/2qHD3yyqJ9HsDOUzNDjtd1DBsUG+yTM6GAkoCmhtH332LMgyIkPv95NDs46bCnX1ObDHAeBohVLF5Vt5duH5pgJLDXqhk7L0jE7XIgPGZrLDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(91956017)(2616005)(82960400001)(38070700005)(38100700002)(122000001)(110136005)(54906003)(36756003)(6486002)(316002)(6512007)(6506007)(2906002)(478600001)(71200400001)(5660300002)(86362001)(8936002)(41300700001)(4326008)(26005)(186003)(8676002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU1vNkVqOGZ4MmVrM1R4dTM0MG1HUjZuUmtzcFFqdFdDdHJzaXRWV0N5enNZ?=
 =?utf-8?B?OU5Xb3RqU054Y3pzVlo5TkxYbTk0eFNiak1TMWIyTTBOSkkyUjhtWFdmdjB1?=
 =?utf-8?B?dFZrd2Mxbmp3U3NTQTJVU05nTU5ybE9kd0Jnbkp5YVhGcHJaWWt0WEpNRzhm?=
 =?utf-8?B?cWhNemZnb3pUVktQT1Vvc29XTVhtSU9nUGM0bHJyUnZLWmQ5UVFiNXppYUtT?=
 =?utf-8?B?dUhVcnRHMStidHowM1Fmd0tKWlNwem1UZk5XbUhwVkZhYTgzWWhXUldHd0JU?=
 =?utf-8?B?cTJRZXAyZEFFaEVZdE5Ibm5jQWo2ZlplTHorVUlIZ3Q5S1BNVU92WEhlM204?=
 =?utf-8?B?M2dNY2d1NVFUZ1FHdk1QSXIvNFN3NnNiMXVkdzhtWmpGR3ViNzhZclQvcUhC?=
 =?utf-8?B?L0lmMGJKZGR0WUgwVm9EMjZNb1JETWhmREE0TzRNaXhnOWY5NlBQcy9IRlhr?=
 =?utf-8?B?aTRYTHNNUWZNQkR5ODRWTFV2ZlJRdUtZMEVBWEhhQm9lVEwzWXpmNTZaWTlB?=
 =?utf-8?B?bTkwbDRYNHVUcmR3S00zeDdmR05KWnE5RTFjMmx3RDcrN0JGRDF5T3NhVlJZ?=
 =?utf-8?B?UE1OclZqS2NDSnRiVUhTdXk5cmpua3NPVnliTmtiWTZtaERrT2JzdEd5Q2pH?=
 =?utf-8?B?M09DRTdBbHl1ay8waWV6dk1sd3Znak5YK0pkNkxzdXRjaXQvMTlKUVl3OWhJ?=
 =?utf-8?B?TU5RdGdySm1FK2xmNzdqWVpNUm1Oam0zN3ZDd04yRDJ6N2w5cnV6SHFCUHVZ?=
 =?utf-8?B?dzFLUHdNM1NXaG1TUkl5UXRDeXNpVmFyVjJWdDNINGpyamI5NDM4eWl2Q0dG?=
 =?utf-8?B?VlkxcWIrUHR6RjlEQ3lxK1dnZnVVSjBQK25DUGhaQUthcWpaQ1dYTktoVFNO?=
 =?utf-8?B?aDl5Zkc1Y0laYWR2Z0swMEhyZ2Z3T0lEb0tleUVOKy9jWFAzRk0yWDNPZnZm?=
 =?utf-8?B?R1grWkN1dGFXS3ViZHNVN3d6dHZ1aENIOUdJd1VPZzdGUGcxaVVOMG1HNGpo?=
 =?utf-8?B?dm80eU5URVBOL09ZQTI3MitOMUZ6eWJxVXNKd1IvdXhGc1drVVFnS0wvdGlV?=
 =?utf-8?B?NWp5QVBDTlVER3hyRTcyek1DSjhsZ3k1dTBoUjlZdVAra1RweXJ0MjZLU3RK?=
 =?utf-8?B?aWFFK2V1VERCNWJwTk4xMS8vSk9EVytHU2RYUXVKY3l3OW5BUUk1RzlWMGxM?=
 =?utf-8?B?dlFJaHdsY0tCNlc1d1dHa3lqUWN2VVIxWWNmMUM0czFQQ2Z1YkdkbmZmWnh5?=
 =?utf-8?B?K0pHbmpNdUIzVXpxaW84c1BFbjBXbXBIVTIxZWREWXMvRFU2L205U2RTTkht?=
 =?utf-8?B?dy9yMGJocDlVUUJEemJRbEFranUySHRudTcxU1ZHMTZIcEhjTk14MDRxbzV0?=
 =?utf-8?B?VGlOVGRXUDcyTmJaTnN2Smd2VTRnK0FkRERJamtqMnRweS9scmRza0twK05J?=
 =?utf-8?B?enVNT3VWNTQ2TCtDUUxqa2JsRmw3VnI1MVpxejJETjl0ZExXQldnQUNFRk84?=
 =?utf-8?B?VlRJZ1pwb1hhZHREaXp4WUJGZFQrTHZwbTRSZy9OYTFQQlYzQnNhWG1zcnFF?=
 =?utf-8?B?Zkc3MlJlUlZYWXlTQlBaWWxIM3NRS3A4elhNQThXMmNLbks5a24vbkxXcUl2?=
 =?utf-8?B?Y29YYWJNOGtQaElFcnRYNFdOY29HWEhWMm5Ub1Rxa3U1enBTYkZzNERUQ0R4?=
 =?utf-8?B?RlJtNUgzNnpDMy9jbTlzYW5rK21BRThHaEhJT3ROOHZSNHRJWStBSWZJVVhU?=
 =?utf-8?B?aGxWRDErUTdvZEpPVWRZbjd4Zkk4RDI4OVgxVDFoVUhIckJremlpdStSZm1r?=
 =?utf-8?B?Wi9uYllUb3dYeUV2a1AyNmV4OWhRMTQ4YTd2Z1MyVENTWnJJN25qNStSR1lX?=
 =?utf-8?B?Q3hxdmFsdFFHeC9Gc3BRYnJsOTV5U292SVNNa1JCOTZlZzhIcVpiRTdmZWxZ?=
 =?utf-8?B?SFZtdUxTQmJ6NWlXSEpaUHlYSkVPdjFIa0FyTFFUVFNKS2pHRFAxb0Nla3Bn?=
 =?utf-8?B?RlQrb1paUklYZVVNL2oxdVJPZnNOVEtmY3hIOEl1QmFwNVVSeTdmUWcyUWJE?=
 =?utf-8?B?enNQUDIzc2I0MHF5c2tuT2dRVmlTbTF0OEJQWTB1aE0rUlVqK253cnUxS3dw?=
 =?utf-8?B?SnpDbVRVakoxdFI3eUpBOWNLUS9ZYXk5QXRZQTV1SnJraU1TUEJFa09teDVo?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B7D36DF520EC74F8A7404CD4CA423C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49770e2-fc56-4dc6-eb61-08db1a875c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 19:01:27.2321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5FUfUBAyLMCuh5l4C/gE911pMUFHxcaz40NsTNCP/X/4yZ7D6dXSTWtoF6CXRXmRvav2i/k5E+x2sMIPRNLYT+AQPJtqfoz/7X0q95s5Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTI4IGF0IDE4OjQzICswOTAwLCBKdW5oeWVvayBJbSB3cm90ZToNCj4g
T24gU3VuLCBGZWIgMjYsIDIwMjMgYXQgMDc6MjE6NDRQTSAtMDgwMCwgQWxpc29uIFNjaG9maWVs
ZCB3cm90ZToNCj4gDQo+IA0KPiA+IA0KPC4uPg0KDQo+ID4gPiBBbHNvIHNpbmNlIGl0IGlzIGV4
cGVjdGVkIG5vIHVzZSBjYXNlIG9mIGluamVjdGluZyBwb2lzb24gaW50byB0aGUNCj4gPiA+IHNh
bWUgYWRkcmVzcyBmb3IgbXVsdGlwbGUgZGV2aWNlcywgdGhpcyBjb21tYW5kIHRhcmdldHMgb25s
eSBvbmUNCj4gPiA+IG1lbWRldiwgbGlrZSB3cml0ZS1sYWJlbHMgY29tbWFuZC4NCj4gPiA+IA0K
PiA+ID4gwqB1c2FnZTogY3hsIGluamVjdC1wb2lzb24gPG1lbWRldj4gLWEgPGRwYT4gWzxvcHRp
b25zPl0NCj4gPiANCj4gPiBtYXliZSAtbSBtZW1kZXYgKHRvIGJlIGxpa2Ugb3RoZXJzKQ0KPiAN
Cj4gQUZBSUssIG1lbWRldiBpcyB0byBiZSBzcGVjaWZpZWQgd2l0aG91dCAiLW0iIGV4Y2VwdCBm
b3IgJ2xpc3QnIGNtZCwNCj4gYnV0IEkgdGhpbmsgdGhlIHJlYXNvbiB5b3Ugc2FpZCBpcyB0byBk
aXN0aW5ndWlzaCBtZW1kZXYgZnJvbSByZWdpb24oZS5nLiItciIpLg0KPiAoSSBhbHNvIGZvdW5k
IGluIHlvdXIgcHJldmlvdXMgcGF0Y2ggZm9yIEdFVF9QT0lTT05fTElTVCB0aGF0IA0KPiBtZW1k
ZXYgYW5kIHJlZ2lvbiB3ZXJlIHNlcGFyYXRlZC4pDQo+IElmIHNvLCBjb2RlcyBhbmQgZG9jdW1l
bnRhdGlvbiBzaG91bGQgYmUgbW9kaWZpZWQgbGlrZToNCj4gwqDCoMKgIGN4bCBpbmplY3QtcG9p
c29uIC1tIDxtZW1kZXY+IC1hIDxkcGE+IFs8b3B0aW9ucz5dDQoNCkp1c3Qgd2FudGVkIHRvIGNo
aW1lIGluIG9uIHRoaXMgcXVpY2tseSBiZWZvcmUgaGF2aW5nIGdvbmUgdGhyb3VnaCB0aGUNCnJl
c3Qgb2YgdGhlIHNlcmllcyAtDQoNClRoZSBjb252ZW50aW9uIGhhcyBiZWVuIGlmIGEgY29tbWFu
ZCBjYW4gb25seSBoYXZlIG9uZSB0eXBlIG9mDQondGFyZ2V0JywgdGhlbiBubyBuZWVkIGZvciBh
IC1tLCBvciAtciBldGMuDQoNCmUuZy4gY3hsIGVuYWJsZS1yZWdpb24gcmVnaW9uMA0KDQpCdXQg
aWYgaXQgY2FuIChwb3RlbnRpYWxseSkgaGF2ZSBkaWZmZXJlbnQgdHlwZXMgb2YgdGFyZ2V0cywg
dGhlbiBhbg0Kb3B0aW9uIGNhbiBiZSB1c2VkIHRvIGRldGVybWluZSB0aGUgdGFyZ2V0IHR5cGUu
IGUuZy4gY3hsLWNyZWF0ZS1yZWdpb24NCndhcyBvcmlnaW5hbGx5IGludGVuZGluZyB0byBhbGxv
dyBib3RoIG1lbWRldiBhbmQgZW5kcG9pbnQgdGFyZ2V0cywNCmhlbmNlIHRoZSAtbSBvcHRpb24g
dG8gc2F5IHRoYXQgdGhlIG5vbi1vcHRpb24gYXJndW1lbnRzIHNob3VsZCBiZQ0KdHJlYXRlZCBh
cyBtZW1kZXZzLg0KDQpUaGUgb3RoZXIgcGxhY2Ugd2hlcmUgeW91J2QgaGF2ZSBvcHRpb25zIGxp
a2UgLW09Im1lbTAsbWVtMSIgZXRjIGlzIGZvcg0KZmlsdGVyaW5nIG9yIHJlc3RyaWN0aW5nIGFu
IG9wZXJhdGlvbi4gY3hsLWxpc3QgdXNlcyB0aGUgZGlmZmVyZW50DQpvcHRpb25zIHRvIGZpbHRl
ciByZXN1bHRzLCBidXQgYWxzbyBvdGhlciBjb21tYW5kczoNCg0KICBlLmcuIGN4bCBkaXNhYmxl
LXJlZ2lvbiAtLWJ1cz1jeGxfdGVzdCBhbGwNCg0Kd2lsbCBkaXNhYmxlIGFsbCByZWdpb25zIHVu
ZGVyIGN4bF90ZXN0LCBidXQgbGVhdmUgYWxvbmUgcmVnaW9ucyB1bmRlcg0KYW5vdGhlciBidXMu
DQo=
