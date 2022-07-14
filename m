Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 19:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiGNTTw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiGNTTu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 15:19:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E92C647
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657826389; x=1689362389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/uSzkjg64jm0aaiL/XWjE/GBR+6dwGXYC9Qu6EZYkQ8=;
  b=kGqRu58kw3eyME6WOm69+L4tXqQXtfspHHbS2ExGv3Y4+y0t7f3SgFvJ
   MN6O33pWyynEw7JVOIxf9LFBTyR07QP2K0I7Ppt7DxDYKoiVPbb61to/u
   0P1GgKjx4QYviiq6Nh5qhWo+XS57EsXpcfvEVg/u+mZAifBUbPQIE6kdM
   8K1m95v0tDCpaCUXeFaE6utQC2RhNWWuG+GWzcF4mtNUhiWFrMNdulNfj
   VHWvU8R2pRdAAhsMjjk5t5NxbUqINGGHvhjQbHCEyEL7WgLk9eMC9Mt4i
   elKuDxyf3r7KP8prT879sRnaXTZSpQjT5ygU/pvgyAh/J+wDEVNKXYWRK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284367971"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="284367971"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="593483081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2022 12:19:48 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 12:19:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 12:19:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 12:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfiomLQrQ508P3o8/tRHGSOQ/YKhqC//6v9MNb5X/+EtNnXCmuioPS1quGawcQknm72ZEIk0gTu896uO9Jame5SHVSUchprSTExb2XvNYi727gsuyXnyj9Ha/8Y67kuWSTInPgQHM8auoVSsq8dokeDIwDbgwv/o6upjsScnmE2UhuP73U4SLeOpPAKspN4Z3L3YGO6KERYyJGPk8Welr8uFINKv54j8GYJMfxpz8PaPoBlBlUHxWUL1eQ4bFFq4AEqohbqhFMgY5MBWpfOFh2REABUnuyDR2sEymy7NKzHK7iMGH0ssedWqrRuPhaM98tWMI8VPW/QjpoGChJ23Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uSzkjg64jm0aaiL/XWjE/GBR+6dwGXYC9Qu6EZYkQ8=;
 b=RuO7z3RcExWM3LnzeDoAPODYZW8vQjfs9VI7Gbk/kxDk6c2KuTUcYvCQe/LFle91X2a34AQrFTBKC9hoB9L8Ze8qQNA+YCw9OQ8J8lAwQND2+gQQwYJhOF+PiZ/46Ufee3AsWiOB0NWiIEKVYmoQIVhiqm5Hj9/X5plpuOX9W1T1JeeAinuKF3hKm8AXgwOl55vWvFxRtWZ3Y8TixdlRRSXhAtp3YckAQunZMiZO43m2L/7djQgrbJPGIiWDDl0r5T2yL9g3n94Fkka720AMAgaWPHapFA8cfH6iL8qhyg9ZWKTT9A25g7G4sLfipKMsb7xJlryzbiILqNVcT+4n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN9PR11MB5515.namprd11.prod.outlook.com (2603:10b6:408:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 19:19:46 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17%5]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 19:19:45 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH ndctl] cxl: Add list all option to the cxl command
Thread-Topic: [PATCH ndctl] cxl: Add list all option to the cxl command
Thread-Index: AQHYl6+TB0B5eJ/hWUuV3hB4+Dn+Iq1+PfkA
Date:   Thu, 14 Jul 2022 19:19:45 +0000
Message-ID: <8546b123eb6303db6b863a2670d64aa87434f196.camel@intel.com>
References: <20220714182737.60714-1-sunfishho12@gmail.com>
In-Reply-To: <20220714182737.60714-1-sunfishho12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf61fc5a-dce0-4d63-f1e9-08da65cdcff7
x-ms-traffictypediagnostic: BN9PR11MB5515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ng6HD9FYEJNlUcWG/Zv6/QSNw4O4g7kKqms5maj8yTddgOaSjNdFocLhym7MmgssMTQfPasUZXDLbBA93boJQGkaAhGoPcIX0gnqy108nEIQW0B7DIbD7sn57zAB6Mc0SOt5YducIycWbStb72xF4Q6juwbJN+CVssg86XGkxDxY0nrOpmu5222IRrOcgltR+PIIf/lUAea1MGBhVMQWrhKfw2PrmtGpRSBSDIA3v1eNpbhutzy9mjaDebVdu90C4mDB53AwmVhA8FU+ArV4XFupZ9OlKSxze/hNdDVqVjy3E86arsn5xxzSRjQNvm/NrV56+jYm0S3bR2nrX1h+1DjlLA5xddWf5+r4W726w2+6cPm2gzIC8PD7yR6p9/Sb6tqUFC9DlgY6EjgnIHKKqoCuHwWC0BYzjqTfr5XHpnAdBAnMl6BOY8yKGAN26sFFVI8BQnpLwydoLTaSB+K5cr2VRi9i0D9SxpMEQp6SwUD6l3JMHYokPbtgeRd9+8066dBJRyMES0+es69U35ZczLbolCTCKbMFGbVYfcyV9JoCIygZlDxcoxBM0zM0QEGznQSA68ZJHa8dnW7WtUpoBuGScfzhmo2faioRmITqKmh3bQkP1h1vnIilDGkSrT0rGzFyenCfsqdjPmzoaFj6i2dRa0h1+JAs8vlhL0Ov0lxul9sbTQS/qDLt3pfqb0tYGRLy1yc997fNkT5Mfj9iR1wNNmuLLbNGWBj/KqRGIRygE/CmCg3Xz42OPX3gpXYj7pQ9+ImtfvxOGsdAZVnvEDugorG1QsD7U2gEkMkf2/g3Y/ZsK7qp1ZCrr5iSrwO5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(376002)(39860400002)(66446008)(2906002)(8936002)(66476007)(8676002)(91956017)(66556008)(5660300002)(76116006)(66946007)(36756003)(64756008)(316002)(4326008)(478600001)(54906003)(110136005)(6486002)(71200400001)(41300700001)(86362001)(6512007)(82960400001)(122000001)(186003)(2616005)(38100700002)(6506007)(38070700005)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHFGRXVMUVVVR2h5OGI0bkNWM2VwS2NJZXYvUlpROSs0U2l6Z3NmWEltK0Rw?=
 =?utf-8?B?QmI0Rk1ITlRxY0JBZWpCTjVqKzlPdFhLQi8vRDQvUjhGWkNrVWw4ZGxKQUlj?=
 =?utf-8?B?SUFWbEIzYUF6N2RRTjRrRlgvcXJEcU9YeDdMcSs0LzVaNkhDOHRJd2lhSVg4?=
 =?utf-8?B?MTI0OUtaMUorek1ydkN2VGk3ZnlHOXIwZmFyY3pNajNJRUY5dnI0S2psUTlk?=
 =?utf-8?B?S1QvZFlKTmplTXpucktGNmEwMjdpRlJpMEQ1ZXpoMlRYbDllWUxxZTU2UXFu?=
 =?utf-8?B?SXE2SDBjdmRlOWJMU0cySjN0TXBKZGE5ejdjL0lKblk4Ni9FK3U5cVBGR2dp?=
 =?utf-8?B?Q0M5M2NNZVppUkFoOFJhbHNNanh6SkQ0TDRoRnhOaVI1c2RLVm5IeVZwQXJp?=
 =?utf-8?B?dWlFZDBBbnJtYVdKcGQxd3pRVExqdXI4SjlMQS9XSkhFMStyclBZMVphbjlt?=
 =?utf-8?B?YlgyYVBDUEJFazdENFFWOXc4L3FYL2pCZXRaanNLeHBDZ1RBVS9hWmUrZjA2?=
 =?utf-8?B?RkZkRjd0akJNM2ZXZUFPb2ZJMk5wYmJOSXFhZDJuMFhGQStzZFhGNkxDMTM4?=
 =?utf-8?B?cE5kYmVycFdlcU5KeTNybmpOaTg3WXRjTHRQR2pwQ2k5KzVhRC9BUlF1WWlq?=
 =?utf-8?B?KzJNQjlYMlRBSnZpQnE5aXROOU5teE9LOHhMNVhjOWRROEMzTmsvL1hIUVQ3?=
 =?utf-8?B?V1ZJRmMvdDFla3dqMkdRWGpDc3NPczlnbHlOTnB4QzlVb3ZtcU01eTRqTFhV?=
 =?utf-8?B?WXVzeTkwUk9LTzNlYzc2bThMc29YY1pseWNhRGJWQmcydngzNmI1V2I4THNo?=
 =?utf-8?B?WGJQa0dpb0tocE45aGY5WG9aMkhBQzc1SnNHeUQrZjNBSDIvVDBEQjJyY3J5?=
 =?utf-8?B?UmxTZWt1OTFZUGVkTWd2eEpramlMRXlwaDRuYm1mOGtpZnd3dUdwK0Y1QTg0?=
 =?utf-8?B?WldFTXJRRzdtaW5VVEZVZnJ5QzFrcGY2a3VTZUlzTkYreExNeXN5MTdzMHFY?=
 =?utf-8?B?M0dCdUpYZ0Fnd3pJc005MjNZK3ZQdVpLS0RzaVpyOFNXeTZ2d0hLZnNqbkZ6?=
 =?utf-8?B?YjRyYVNtZnZmQlllZTNIZkxxZzhnei9JRWI2VTlLbCs2N1NMTEFHamtYL2dJ?=
 =?utf-8?B?d3gvZjhSVGdsbUlhOWwzdDJiakVudGFJOHBXOWpBcXgreVNmNThIUTNnU2w0?=
 =?utf-8?B?RjJrKzcrZmdxaFRQK0QxazZhbUdhZDhKamhZSTVkNHdyOC8rVVJWR1VmOXAr?=
 =?utf-8?B?WmlrLzU3dWhNaktBKzZJekhvOWRpNzR3WmNDQTYwNEVSODRySE1QUGxrdUMv?=
 =?utf-8?B?cHpOMlhmSDFVV2Z1Zzd5T1dOc1F5QmlOWkZOSm5wZHVyUDJYQjV5UTkxeDNK?=
 =?utf-8?B?Nm1vSVl1blVuTEU4amRnK0x3TTlsVzEzdG52R2ZNS3h1UjQ3K1E1LzFUeGRk?=
 =?utf-8?B?N2lFNVpBWDdkZ2dOcjV1b2ZocDdCZ0l5K0crQXAwVnVrZkg3TkgxYU1RR2tS?=
 =?utf-8?B?dWxVbnBlaGtrSjg5Z2FqQXlEaXY2ZTFDUXdLbEwzdDBNb3R3L1RNNUhyZ2NQ?=
 =?utf-8?B?c3cxOGsxd0hHMHNSUlRwVEp1bUw1WUtSQmlWRkxTQzdlS0N4RE9QeFBBV1Rx?=
 =?utf-8?B?ZFQwTW9ORDA4aDFyTHpkS0NEVGNMSlRQQnlmLy9uSTdWTHlKZHBoN1Qwa3J6?=
 =?utf-8?B?SXVYTzlSdDE1TWR1QVBiZkltMnRVa2ZkWENOVUNFYXUrNUVCNW5FZTZxWUxJ?=
 =?utf-8?B?UUZ4elJwOGVEbmtKdkRLOWdDaS9EcVMzNFR2ZmFLNzNNS05LMEI5Y2lIKzBZ?=
 =?utf-8?B?S3Yybk10c2U0R3hoYlJwbDNHUFQ4QVBXNjNvTkdtam8wMHI2NEVnZjIrR21O?=
 =?utf-8?B?YU1pNTgxb3FCSWtLdHI4ajA0K09zWGNpUXJhbldIb2hNWEVzMUdFSm9la3Fy?=
 =?utf-8?B?NjR5enBiQ1kzZ29nOUtlZUF5OG5oNmRkWm5LN0k2QnFETlQ0SHlyUjFHYlU4?=
 =?utf-8?B?NXAzSjI4SVgyVjhTZEtzVVFqYnpac0dxdHdidTBXeW9oQWR6YjhncWVyYkwy?=
 =?utf-8?B?aEVzQm5HTmJIeGZaUCtBdjB3UFdsbnRlU3BTVGdmMVhPZHc3OHpZUTBKZmMy?=
 =?utf-8?B?WjhxcUl5U2tZbVRSUkl5WUc5c2RQUWhITnlWekRqVmgrRUJiWEl4b2JGa0FT?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65C15F61D9248C4794FAA8CEBA9EA16F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf61fc5a-dce0-4d63-f1e9-08da65cdcff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 19:19:45.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3TTz8bsUWPJOhmiD2iI9LLEeVupWUS9ohpgTZtHi0KpZ7Zz6NSRtjcv1U01P/axnthRqD6Mrjc/JvbSW1rm1rWwRIK9BQgWAe8fbUUcL6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5515
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTE0IGF0IDExOjI3IC0wNzAwLCBzdW5maXNoaG8xMkBnbWFpbC5jb20g
d3JvdGU6Cj4gRnJvbTogTWF0dGhldyBIbyA8c3VuZmlzaGhvMTJAZ21haWwuY29tPgo+IAo+IFRo
aXMgYWRkcyBhIG5ldyBzdWJjb21tYW5kIGN4bCBsaXN0IC0tYWxsLCB3aGljaCBpcyBlcXVpdmFs
ZW50IHRvIGN4bAo+IGxpc3QgLU1CUEVEVEhJaXUuIFRoaXMgYWRkaXRpb24gbWFrZXMgaXQgZWFz
aWVyIHRvIGxpc3QgYWxsIHRoZSBDWEwKPiBkZXZpY2VzIGF0IG9uY2UsIGFzIG9uZSBkb2VzIG5v
dCBuZWVkIHRvIGFwcGVuZCBhIHN1YmNvbW1hbmQgZm9yIGVhY2gKPiBkZXZpY2UuIC0tYWxsIGlz
IGFsc28gZWFzaWVyIHRvIHJlbWVtYmVyIHRoYW4gLU1CUEVEVEhJaXUuIFdoZW4KPiByZWdpb24g
c3VwcG9ydCBpcyBhZGRlZCwgdGhpcyB3aWxsIGJlIHVwZGF0ZWQgdG8gaW5jbHVkZSBpdC4KPiAK
PiBSZXZpZXdlZC1ieTogQWRhbSBNYW56YW5hcmVzIDxhLm1hbnphbmFyZXNAc2Ftc3VuZy5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBIbyA8c3VuZmlzaGhvMTJAZ21haWwuY29tPgo+IC0t
LQo+IMKgY3hsL2ZpbHRlci5oIHzCoCAxICsKPiDCoGN4bC9saXN0LmPCoMKgIHwgMTUgKysrKysr
KysrKysrKysrCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCkhpIE1hdHRo
ZXcsIHRoYW5rcyBmb3Igc2VuZGluZyB0aGlzIC0gSSBhZ3JlZSBpdCBnZXRzIHRlZGlvdXMgdHJ5
aW5nIHRvCmxpc3QgbXVsdGlwbGUgdGhpbmdzLgoKSG93ZXZlciwgSSB0aGluayB3ZSBzaG91bGQg
ZG8gdGhpcyBzaW1pbGFyIHRvIG5kY3RsLWxpc3QncyAtLXZlcmJvc2UKb3B0aW9ucywgd2hlcmUg
YWRkaW5nIHRoZSBudW1iZXIgb2YgJ3YncyBhZGRzIGluIG1vcmUgYW5kIG1vcmUgZGV0YWlsLgoK
Rm9yIGV4YW1wbGU6CgpjeGwgbGlzdCAoZGVmYXVsdCkgOiBSZWdpb25zIGFuZCBtZW1kZXZzICh0
aGlzIGlzbid0IHRoZXJlIHRvZGF5LCBidXQKaW4gYSBwZW5kaW5nIHNlcmllcyBJJ20gYWJvdXQg
dG8gc2VuZCBvdXQpLgoKY3hsIGxpc3QgLXY6IC1STUJEUFQKCmN4bCBsaXN0IC12djogLVJNQkRQ
VGkKCmN4bCBsaXN0IC12dnY6IC1STUJEUFRpSEkKCi11Ly0taHVtYW4gY2FuIGJlIGV4Y2x1ZGVk
IGZyb20gdGhlIHZlcmJvc2l0eSBsZXZlbHMgYXMgdGhhdCBjYW4gYmUKcGFzc2VkIGluIGlmIG5l
ZWRlZCwgYW5kIHRoZXJlIG1heSBiZSB1c2UgY2FzZXMgd2hlcmUgaXQgaXNuJ3QgZGVzaXJlZAoo
aW4gc2NyaXB0cykuCgpUaG91Z2h0cyBvbiB0aGlzIC0gZG8geW91IHdhbnQgdG8gdGFrZSBhIHNo
b3QgYXQgaW1wbGVtZW50aW5nIGl0IHRoaXMKd2F5PwoKPiAKPiBkaWZmIC0tZ2l0IGEvY3hsL2Zp
bHRlci5oIGIvY3hsL2ZpbHRlci5oCj4gaW5kZXggNjk3Yjc3NzljMDhlLi43MDA5YzAwYTFjMjMg
MTAwNjQ0Cj4gLS0tIGEvY3hsL2ZpbHRlci5oCj4gKysrIGIvY3hsL2ZpbHRlci5oCj4gQEAgLTEz
LDYgKzEzLDcgQEAgc3RydWN0IGN4bF9maWx0ZXJfcGFyYW1zIHsKPiDCoMKgwqDCoMKgwqDCoMKg
Y29uc3QgY2hhciAqcG9ydF9maWx0ZXI7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmVu
ZHBvaW50X2ZpbHRlcjsKPiDCoMKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqZGVjb2Rlcl9maWx0
ZXI7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBhbGw7Cj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgc2lu
Z2xlOwo+IMKgwqDCoMKgwqDCoMKgwqBib29sIGVuZHBvaW50czsKPiDCoMKgwqDCoMKgwqDCoMKg
Ym9vbCBkZWNvZGVyczsKPiBkaWZmIC0tZ2l0IGEvY3hsL2xpc3QuYyBiL2N4bC9saXN0LmMKPiBp
bmRleCAxZTlkNDQxMTkwYTAuLjczODI4MmU5NTQzNCAxMDA2NDQKPiAtLS0gYS9jeGwvbGlzdC5j
Cj4gKysrIGIvY3hsL2xpc3QuYwo+IEBAIC01MCw2ICs1MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb3B0aW9uIG9wdGlvbnNbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiaW5jbHVkZSBtZW1vcnkgZGV2aWNlIGhlYWx0aCBpbmZvcm1hdGlvbiAiKSwKPiDC
oMKgwqDCoMKgwqDCoMKgT1BUX0JPT0xFQU4oJ0knLCAicGFydGl0aW9uIiwgJnBhcmFtLnBhcnRp
dGlvbiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiaW5jbHVkZSBt
ZW1vcnkgZGV2aWNlIHBhcnRpdGlvbiBpbmZvcm1hdGlvbiAiKSwKPiArwqDCoMKgwqDCoMKgwqBP
UFRfQk9PTEVBTigwLCAiYWxsIiwgJnBhcmFtLmFsbCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJpbmNsdWRlIGluZm8gb24gYWxsIGNvbXBvbmVudHMgb2YgdGhlIENY
TAo+IGhpZXJhcmNoeSIpLAo+IMKgI2lmZGVmIEVOQUJMRV9ERUJVRwo+IMKgwqDCoMKgwqDCoMKg
wqBPUFRfQk9PTEVBTigwLCAiZGVidWciLCAmZGVidWcsICJkZWJ1ZyBsaXN0IHdhbGsiKSwKPiDC
oCNlbmRpZgo+IEBAIC04Miw2ICs4NCwxOSBAQCBpbnQgY21kX2xpc3QoaW50IGFyZ2MsIGNvbnN0
IGNoYXIgKiphcmd2LCBzdHJ1Y3QKPiBjeGxfY3R4ICpjdHgpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1c2FnZV93aXRoX29wdGlvbnModSwgb3B0aW9ucyk7Cj4gwqDCoMKgwqDC
oMKgwqDCoH0KPiAKPiArwqDCoMKgwqDCoMKgwqBpZiAocGFyYW0uYWxsKXsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyYW0ubWVtZGV2cyA9IHRydWU7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBhcmFtLmJ1c2VzID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcGFyYW0ucG9ydHMgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwYXJhbS5lbmRwb2ludHMgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwYXJhbS5kZWNvZGVycyA9IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBhcmFtLnBhcnRpdGlvbiA9IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBhcmFtLmhlYWx0aCA9IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBhcmFtLnRhcmdldHMgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwYXJhbS5odW1hbiA9IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBhcmFtLmlkbGUgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChudW1fbGlzdF9mbGFncygpID09IDApIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChwYXJhbS5tZW1kZXZfZmlsdGVyIHx8IHBhcmFtLnNlcmlhbF9maWx0ZXIp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyYW0u
bWVtZGV2cyA9IHRydWU7Cj4gLS0KPiAyLjM0LjEKPiAKCg==
