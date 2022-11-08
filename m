Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64340C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 23:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKHXqG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKHXqF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 18:46:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C756541
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 15:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667951163; x=1699487163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QfAOosNtL3sVCEHwmn6VNyCBUXiBYESsQS326SbwFgw=;
  b=QXHk8UyWFGvA8mzDeW4yr1IyY61S/veHSu0Wh1G98XFwJYa5R3vuAI+L
   wzdK/NNIO7SZ+APAPtyHtWwv1+sMuHGCZ/4tMx3f3SZahJwOEOAzHu5fW
   SQWGwO20YrZv64Ygzv5fLQzcoM09oTaljuwK0uElMQIZ2PMFkJ93wwdkI
   BsnkLW76kzd+vl2Ob3sk189thK20xNhecwRkclFbUG3EjDQJByM3jYk5L
   OPxk0P6gFL2NZUrWCDAfH66eV4c3VSGXwSNTJMwxHTEVKttAdGs0EXT9G
   wtDKMYJLicdyONRvbJkL/TVwJ7Fo+PblqFblGJtrb4D81B/ZjDMftRsc4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337569639"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="337569639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705484184"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="705484184"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2022 15:45:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:45:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 15:45:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 15:45:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISgwULrG+ZfOMC2wbmYgJ3sUsWAeI7/qJYo05hh9rWKZUHlFXdBNlodx8tXoZ6n/Sk8JR5Td8x36LnBHrhuF6sDL3blLCKDikonLlZAhWZYwbNnx9EvqgVWdBSyYtFzPZJ5ZxQG5pcgq1pEGsHx3C9eNe66LAdZ0OkMS+O13VOhQmnlA+hjc98Q+4CRn7j3bRudzS/3MG2eSUUGDQfVJttnQUWw21vn95dDld40ZKUKw7HSmV7LKiaaKyRKvun2GDMNLwLE3FhwfkeUSVTGHxvrn8n07jc44kZmSqLzbzet/jSlK+b0hCpL7VRTYLptM/1seNtxbpk3AUe9lfxI/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfAOosNtL3sVCEHwmn6VNyCBUXiBYESsQS326SbwFgw=;
 b=LniH1bKh3FhikJ9e0LL0XFoioi6LaLhJgN8yyLkqX1sgCwx61gtv2kxtSwtiSgb1sZ18by6qcQedyQa5a+fb/fNRVHO/OALPTlCNfpKoUU97BHoXPI0NrehNBmGHgapG+tmeK8SAnHlNhXq726oxD3nDJm7ntN/iJpen1kKNpc8OidkwXveIcWUTJ9SVnlgw4sS3MVx4sXjG1ZfdMa83PaIYdI7ppy17BTDgEq5xpRtCN77NM9TKOcR1nziQyAFJYIQqYYHjwChRNEmv/QxK1VNwQ8qoS9g8x2QsA9vzCo9dfI3BVs0uSiGt9iicIcZG4vHjn96/IGlCGpIa/dxFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 23:45:48 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 23:45:48 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 02/10] cxl: add helper to parse through all current
 events
Thread-Topic: [PATCH v4 02/10] cxl: add helper to parse through all current
 events
Thread-Index: AQHY86A1lgebN+YvDkiWCiGL07t/+q41sTKA
Date:   Tue, 8 Nov 2022 23:45:48 +0000
Message-ID: <6e0d8c9cfb2adb2c0039d1bbe42cc8a0dbc0a9ec.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793219956.3768752.10060411389279195687.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793219956.3768752.10060411389279195687.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB6374:EE_
x-ms-office365-filtering-correlation-id: 1be9d6e5-ed93-4105-5888-08dac1e35cab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4FPL4wRFF7a/WW7F79Is56NrxjUF413TyhbyjSRa4vCz0LFW1cYWN6Ry7diX43Vvze4IpI+P8IPLaQvEuG4fuYCX26xVF4mhMBmJ5okZ7S1W1B/GoYLdz7ZANU2fRV9QUF+gb/qWpXcYlMQEryzBgrMRHBQLyOnhXfgHVvT3hhBYZipyy3CHsckrxZdMSFKjFLXR9vjMOmxTQr8fphgC0eLKT4MLeiTJc0JKMVG+opOdEPvHTdOrj/AWKvUMMf0rrVN0WvHwcXLuTF0xi0it7/m5ug+empBGlTsU0953COKGAqc0zcI0y4OGEdcemz5mlM7jYxSrVBLIfv5nh3wNnf2hlYkJi9becY+yVCdatHhcl9cKmsImlgea4ElwI4vK26H7o9M3zgkKLcyQc3Xcmx6YaEdqjdWKvmkb48YhUBwYLX1X8snpzK409nnhrW28um3GnNgWniaYZ4kaq1jOvm1PKaFXxlA/rm9snHTP2MTN6NNHegvUll0A8EjW7CDZ4g9VXLYSdMF0NpN2o/ivqSjBNeBrUq+s6DivH6W0NldC941/inLXwgZc6DfTWfn5Art2w/5r/xBDyaCt9g1KzkKj63froHJvCJ+utlh0V+YJkTr72KlKLKGKZBGDUYZubYXbjjkb+z50eHy7RqkWAhlJPtidIi1DQFDhbrIyHQavpaDy0jt94Cbn3AgKCQbrjwcv+57xVS5NAqAfMxeSBvEmGtQx7E+FYO7j8ik+9VGUNiCYulJMNTcaBFppPbsQF1bPbuLXolJ/uwfIg7y4TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(71200400001)(316002)(54906003)(6486002)(107886003)(110136005)(4326008)(66556008)(64756008)(76116006)(66946007)(8676002)(66446008)(86362001)(91956017)(478600001)(41300700001)(66476007)(83380400001)(2906002)(38100700002)(122000001)(26005)(6512007)(82960400001)(6506007)(186003)(36756003)(38070700005)(8936002)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFgvUVFHYzZucjllTG5uSktMUlBGSUtrb09aRnVoZ0FOdVZhU3VvUWJnSWt1?=
 =?utf-8?B?UjJlLy80d1lVQ0lkL1d3MDBJOGFhTkN5N3QzVEhlcUM3U0x2VDBTMEZWaVFy?=
 =?utf-8?B?UEhSNHRQVUNtby9GeHZYb0dGNTc4dE5TWTlQdnV2YWZZK3pDTGtPWTJDMXZX?=
 =?utf-8?B?bnJuM0xKMTYvUlNnSzRpeEZPdmFJaVV1ejJsQWxWS3pFMzZPMmhGZG4wSmVh?=
 =?utf-8?B?M2tPa25OZUJaWnRBUEFQV1hKeFpCMnNzci81SmxXd1NKUThYSFBmL0tjbVZs?=
 =?utf-8?B?TjVoMTBSVW5IUU04QmhsQmhhNlVTTzZPWEhSUk5YcjlGL2NsRzUzWnZsdFJQ?=
 =?utf-8?B?MjNmV2NNU3VnN3VkMGxXRUFjenN5MDN4WFcyZlhnNEFScE9mdCsxbkZ4ZGlG?=
 =?utf-8?B?ZTdlTkxKR1VId21pK2dDd250aFlPcTZRQVVGWVh4Ujg2TWFTWG9tOG1PMWtn?=
 =?utf-8?B?Z3c5bEVncExEbUlJMHdTOHBzVzEvNjMwV2cxcmYva3g2b0F1ODZuSUFDWVBm?=
 =?utf-8?B?Slo4U2R2ZVQwWU1tSlNKUFAzRXFDTmpJeWlWZ2RMNHZpaXpqbGIwbmlRdlYv?=
 =?utf-8?B?OENyTWsvYkI3bENoa1lSeDkrWmM3U1dWdWYxM0NNMzFCcXI5V080OWt1NkFN?=
 =?utf-8?B?b2c2bjF3Vjc1SW9vTFFacG1vT2d3SVVMQmIvWUJqZ2psNEdQc2hVbmFtRnd4?=
 =?utf-8?B?L3M2dVpSamV3WVZIaE5tdXVkTGt5N2ZFZ0NIZmFYalVMSnNMWklrekZnS3ZF?=
 =?utf-8?B?SWUrTVU2M0tkRUJXb3E2TjBsaW0vMHBkbThDKzBOdWpUNjVjRWF4VUo2a2w2?=
 =?utf-8?B?eFRYcmhhbTM0YXE3VGtBeEVUT1dRQm9mUVF0NkRUUFo2cmpHR0V1TzROTDlq?=
 =?utf-8?B?WkorZ0w0MmJmRmJIV2ZzODBhRlFRdVJXQ3FCZ3hjb21xellIRDVGcFNndmFX?=
 =?utf-8?B?QnNNeEtHRTR0bWsvMXNIVithSSt1cTV6WHpPSUJVZEdwdUhLQzk1dHBiU0RZ?=
 =?utf-8?B?c0RmWERtWTFsYlBTWXd2UXBHS1dDZlFzVVdjWWZPd29CMy9NVU5UcGs5M3ZT?=
 =?utf-8?B?Y1h6clgwTXdqdFdlV3BPMGRLRTdwR01RaWl6VG9ZdEozZGdnSEthV2dIN3BI?=
 =?utf-8?B?bFVFdVI2RktoMGhaQnBsM3I1b2hHb1ZBd01TQTRVVXUxV0dmRUJxZzVOcTda?=
 =?utf-8?B?c0RVTVlQeENBckZCSDJHcWJHa2VNbm5QMUVqUDNPckV4amVrLzI0Nk5kNTRt?=
 =?utf-8?B?YnJMdzd2UEFhaDc3VFNQKzhCVWY0SWR4L09lLzNNNTd5K1l6SmxUTWk4Rll0?=
 =?utf-8?B?WGRzaE1Sei9sY0pLOHRtd2ZTOUF1Y04rZ2t5NUlIT1JabElaRjdKc1ZuRERP?=
 =?utf-8?B?UjNZWDFBY0FzdVZMUjVIemV1bUpsS0hkUnV4SEQrWkhNUlN5SXc3Z1JQMkhT?=
 =?utf-8?B?MEVvY1Z2d3VhaEFaTStaZmczNEo3a2tiNHRxVXYwSDl5b0RhZGFvdXpxL0Er?=
 =?utf-8?B?YTE1OFJSejh3Y3NhL2RtN05oSmJOQWt2RktVZHhsWWVtdmxiYXcxeEpQMzQ0?=
 =?utf-8?B?QWRXMlN4OHI5dWhwc2YzK0lpZ0VpQitFTmlnQ3U2Nk0za0hjZXpNMGxkeTVr?=
 =?utf-8?B?aldGU2I1NllEQ1F4bnJoSDhYVCtSb0NLKzFMM0FlK1ViU1JZTis2T2pyWHhK?=
 =?utf-8?B?cW5JUCtnZCtGWlN5Qll5d2NJTkFiRXp5QmZRVXVpUUJUNytmWmlpeUxtL0or?=
 =?utf-8?B?Yjl4QmdnUktCQkVKQWRyWklES012aVhXTkxaZHluN0RrdWhGV0hlWGZFTmdE?=
 =?utf-8?B?NVNzbjVidVE1akFjQ2VQUmRETEhEY1h3SGI3S1ZoWFhxaWhhM0RtTFZmRW43?=
 =?utf-8?B?ZkZHV1Z1eVhhNHFxb1BsTFVWSFNyZm9ib2xYdmdTeVJkc0JtSWZjQ2hoWEtN?=
 =?utf-8?B?WldEVWRYZW1Xd2lMRFhNY2YxOWF5V05ZNWtqZE9OVWx6dXVjWGdBcnpFQnRP?=
 =?utf-8?B?YmNKcTdoTWRzNjVRT0s4UDdBUS8wWk5PVXFQSCtTczcrRVZIZURNZ0FzVjIy?=
 =?utf-8?B?TXZReDlqWDFPbWNhdzJrWFJTeVRNQkNqaE5KNXh1T3BQQXI3TkE5eHNjWGJJ?=
 =?utf-8?B?ZlJOWW1aMjJzSkgyUmkvMkx1OEhJVUQ2aHByQTQwYVB6cFRPeXUwWWpwRDZ2?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF8EAC87EBE5984DA52D76D2D415DA05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be9d6e5-ed93-4105-5888-08dac1e35cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:45:48.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5I32knhox8WPd4K4L9nHeAWM389EuOpWDmggd01h/HiRHSWuragKysGNmnLSzgsFOewtre1rhGDgnNmo1mdGnkbUcLpozOFrgyOQF3DfhWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjI5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IEFk
ZCBjb21tb24gZnVuY3Rpb24gdG8gaXRlcmF0ZSB0aHJvdWdoIGFuZCBleHRyYWN0IHRoZSBldmVu
dHMgaW4gdGhlCj4gY3VycmVudCB0cmFjZSBidWZmZXIuIFRoZSBmdW5jdGlvbiB1c2VzIHRyYWNl
ZnNfaXRlcmF0ZV9yYXdfZXZlbnRzKCkgZnJvbQo+IGxpYnRyYWNlZnMgdG8gZ28gdGhyb3VnaCBh
bGwgdGhlIGV2ZW50cyBsb2FkZWQgaW50byBhIHRlcF9oYW5kbGUuIEEKPiBjYWxsYmFjayBpcyBw
cm92aWRlZCB0byB0aGUgQVBJIGNhbGwgaW4gb3JkZXIgdG8gcGFyc2UgdGhlIGV2ZW50LiBGb3Ig
Y3hsCj4gbW9uaXRvciwgYW4gYXJyYXkgb2YgaW50ZXJlc3RlZCAic3lzdGVtcyIgaXMgcHJvdmlk
ZWQgaW4gb3JkZXIgdG8gZmlsdGVyCgpJIGNvdWxkbid0IHRlbGwgd2hhdCBhICdzeXN0ZW0nIG1l
YW5zIGhlcmUgLSBtYXliZSBjbGFyaWZ5IHRoYXQ/Cgo+IGZvciB0aGUgaW50ZXJlc3RlZCBldmVu
dHMuCgpzL2ludGVyZXN0ZWQgZXZlbnRzL2V2ZW50cyBvZiBpbnRlcmVzdC8gPwoKPiAKPiBUZXN0
ZWQtYnk6IEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPgo+IC0tLQo+IMKg
Y3hsL2V2ZW50X3RyYWNlLmMgfMKgwqAgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gwqBjeGwvZXZlbnRfdHJhY2UuaCB8wqDCoCAxMCArKysrKysrKysrCj4gwqBjeGwv
bWVzb24uYnVpbGTCoMKgIHzCoMKgwqAgMSArCj4gwqBtZXNvbi5idWlsZMKgwqDCoMKgwqDCoCB8
wqDCoMKgIDIgKysKPiDCoDQgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9jeGwvZXZlbnRfdHJhY2UuYyBiL2N4bC9ldmVudF90cmFjZS5jCj4gaW5kZXgg
MWIxYjAzN2U0OGJmLi40NjY3MDQ0ZTRhNjYgMTAwNjQ0Cj4gLS0tIGEvY3hsL2V2ZW50X3RyYWNl
LmMKPiArKysgYi9jeGwvZXZlbnRfdHJhY2UuYwo+IEBAIC0xNiw2ICsxNiw3IEBACj4gwqAjaW5j
bHVkZSA8bGliY3hsLmg+Cj4gwqAjaW5jbHVkZSA8dXVpZC91dWlkLmg+Cj4gwqAjaW5jbHVkZSA8
dHJhY2VldmVudC9ldmVudC1wYXJzZS5oPgo+ICsjaW5jbHVkZSA8dHJhY2Vmcy90cmFjZWZzLmg+
Cj4gwqAjaW5jbHVkZSAianNvbi5oIgo+IMKgI2luY2x1ZGUgImV2ZW50X3RyYWNlLmgiCj4gwqAK
PiBAQCAtMTk5LDMgKzIwMCwzOCBAQCBlcnJfamV2ZW50Ogo+IMKgwqDCoMKgwqDCoMKgwqBmcmVl
KGpub2RlKTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+IMKgfQo+ICsKPiArc3RhdGlj
IGludCBjeGxfZXZlbnRfcGFyc2VfY2Ioc3RydWN0IHRlcF9ldmVudCAqZXZlbnQsIHN0cnVjdCB0
ZXBfcmVjb3JkICpyZWNvcmQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBj
cHUsIHZvaWQgKmN0eCkKCldoYXQgZG9lcyB0aGUgX2NiIG1lYW4/IEkgY291bGRuJ3QgdGVsbCBm
cm9tIHdoYXQgaXQncyBwYXJzaW5nIHdoYXQgaXQKc3RhbmRzIGZvciAtIG1pZ2h0IGJlIGJldHRl
ciB0byBleHBhbmQgaXQ/Cgo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGV2ZW50X2N0eCAq
ZXZlbnRfY3R4ID0gKHN0cnVjdCBldmVudF9jdHggKiljdHg7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oC8qIEZpbHRlciBvdXQgYWxsIHRoZSBldmVudHMgdGhhdCB0aGUgY2FsbGVyIGlzbid0IGludGVy
ZXN0ZWQgaW4uICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHN0cmNtcChldmVudC0+c3lzdGVtLCBl
dmVudF9jdHgtPnN5c3RlbSkgIT0gMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChldmVudF9jdHgtPmV2ZW50X25hbWUp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHN0cmNtcChldmVudC0+bmFt
ZSwgZXZlbnRfY3R4LT5ldmVudF9uYW1lKSAhPSAwKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsK
PiArwqDCoMKgwqDCoMKgwqBpZiAoZXZlbnRfY3R4LT5wYXJzZV9ldmVudCkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGV2ZW50X2N0eC0+cGFyc2VfZXZlbnQoZXZlbnQs
IHJlY29yZCwgJmV2ZW50X2N0eC0+amxpc3RfaGVhZCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJl
dHVybiBjeGxfZXZlbnRfdG9fanNvbl9jYWxsYmFjayhldmVudCwgcmVjb3JkLCAmZXZlbnRfY3R4
LT5qbGlzdF9oZWFkKTsKPiArfQo+ICsKPiAraW50IGN4bF9wYXJzZV9ldmVudHMoc3RydWN0IHRy
YWNlZnNfaW5zdGFuY2UgKmluc3QsIHN0cnVjdCBldmVudF9jdHggKmVjdHgpCj4gK3sKPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgdGVwX2hhbmRsZSAqdGVwOwo+ICvCoMKgwqDCoMKgwqDCoGludCBy
YzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgdGVwID0gdHJhY2Vmc19sb2NhbF9ldmVudHMoTlVMTCk7
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCF0ZXApCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRU5PTUVNOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByYyA9IHRyYWNlZnNfaXRl
cmF0ZV9yYXdfZXZlbnRzKHRlcCwgaW5zdCwgTlVMTCwgMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN4bF9ldmVudF9wYXJzZV9jYiwgZWN0eCk7Cj4g
K8KgwqDCoMKgwqDCoMKgdGVwX2ZyZWUodGVwKTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7
Cj4gK30KPiBkaWZmIC0tZ2l0IGEvY3hsL2V2ZW50X3RyYWNlLmggYi9jeGwvZXZlbnRfdHJhY2Uu
aAo+IGluZGV4IDAwOTc1YTBiNTY4MC4uNTgyODgyYzFlYjM1IDEwMDY0NAo+IC0tLSBhL2N4bC9l
dmVudF90cmFjZS5oCj4gKysrIGIvY3hsL2V2ZW50X3RyYWNlLmgKPiBAQCAtMTEsNCArMTEsMTQg
QEAgc3RydWN0IGpsaXN0X25vZGUgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9ub2Rl
IGxpc3Q7Cj4gwqB9Owo+IMKgCj4gK3N0cnVjdCBldmVudF9jdHggewo+ICvCoMKgwqDCoMKgwqDC
oGNvbnN0IGNoYXIgKnN5c3RlbTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkIGps
aXN0X2hlYWQ7Cj4gK8KgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqZXZlbnRfbmFtZTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAvKiBvcHRpb25hbCAqLwo+ICvCoMKgwqDCoMKgwqDCoGludCAoKnBhcnNlX2V2ZW50KShzdHJ1
Y3QgdGVwX2V2ZW50ICpldmVudCwgc3RydWN0IHRlcF9yZWNvcmQgKnJlY29yZCwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGxpc3Rf
aGVhZCAqamxpc3RfaGVhZCk7wqDCoMKgwqDCoMKgwqAvKiBvcHRpb25hbCAqLwo+ICt9Owo+ICsK
PiAraW50IGN4bF9wYXJzZV9ldmVudHMoc3RydWN0IHRyYWNlZnNfaW5zdGFuY2UgKmluc3QsIHN0
cnVjdCBldmVudF9jdHggKmVjdHgpOwo+ICsKPiDCoCNlbmRpZgo+IGRpZmYgLS1naXQgYS9jeGwv
bWVzb24uYnVpbGQgYi9jeGwvbWVzb24uYnVpbGQKPiBpbmRleCA4Yzc3MzM0MzE2MTMuLmM1OTg3
NjI2MmU3NiAxMDA2NDQKPiAtLS0gYS9jeGwvbWVzb24uYnVpbGQKPiArKysgYi9jeGwvbWVzb24u
YnVpbGQKPiBAQCAtMjEsNiArMjEsNyBAQCBjeGxfdG9vbCA9IGV4ZWN1dGFibGUoJ2N4bCcsCj4g
wqDCoMKgwqAganNvbiwKPiDCoMKgwqDCoCB2ZXJzaW9uZGVwLAo+IMKgwqDCoMKgIHRyYWNlZXZl
bnQsCj4gK8KgwqDCoCB0cmFjZWZzLAo+IMKgwqAgXSwKPiDCoMKgIGluc3RhbGwgOiB0cnVlLAo+
IMKgwqAgaW5zdGFsbF9kaXIgOiByb290YmluZGlyLAo+IGRpZmYgLS1naXQgYS9tZXNvbi5idWls
ZCBiL21lc29uLmJ1aWxkCj4gaW5kZXggZjYxMWUwYmRkN2YzLi5jMjA0YzhhYzUyZGUgMTAwNjQ0
Cj4gLS0tIGEvbWVzb24uYnVpbGQKPiArKysgYi9tZXNvbi5idWlsZAo+IEBAIC0xNDMsNiArMTQz
LDggQEAgbGlidWRldiA9IGRlcGVuZGVuY3koJ2xpYnVkZXYnKQo+IMKgdXVpZCA9IGRlcGVuZGVu
Y3koJ3V1aWQnKQo+IMKganNvbiA9IGRlcGVuZGVuY3koJ2pzb24tYycpCj4gwqB0cmFjZWV2ZW50
ID0gZGVwZW5kZW5jeSgnbGlidHJhY2VldmVudCcpCj4gK3RyYWNlZnMgPSBkZXBlbmRlbmN5KCds
aWJ0cmFjZWZzJykKPiArCj4gwqBpZiBnZXRfb3B0aW9uKCdkb2NzJykuZW5hYmxlZCgpCj4gwqDC
oCBpZiBnZXRfb3B0aW9uKCdhc2NpaWRvY3RvcicpLmVuYWJsZWQoKQo+IMKgwqDCoMKgIGFzY2lp
ZG9jID0gZmluZF9wcm9ncmFtKCdhc2NpaWRvY3RvcicsIHJlcXVpcmVkIDogdHJ1ZSkKPiAKPiAK
Cg==
