Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7CBC433B4
	for <linux-cxl@archiver.kernel.org>; Wed, 19 May 2021 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301D5610E9
	for <linux-cxl@archiver.kernel.org>; Wed, 19 May 2021 16:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355390AbhESQrW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 May 2021 12:47:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37630 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhESQrW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 May 2021 12:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621442762; x=1652978762;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6ReTqdHYlyh1KnQln95bkCOKK4lTlBJgStzWxUV4bIY=;
  b=C66k2YxLOOVXHTL/H4U09VSVdDAX5q4e4hgG+Yh7adaYTHLmZ3D56Tr8
   cIueE27DvZ4xQYMEH0zNt0nu+UUqbtME5owOeBrDbg7KZdCynrX7sgzl9
   Okrmz6D7vnBrrsjzLo+P73JMtm+MqNNq/0qKeTwZtaCe15XtTXnvHdAgJ
   AfjUj0D0OWTqCnLpCXn5NYTZjwIN+U34Frr1Go5MX9/TaDQK0KVs25sdW
   5o+AJSCEhahkjBImAUjILIAzfT2ii8ynPaegUoA/KBWJjN1GDvB/p0i8O
   Chrs13oms74tN+mgR3H2bjaUpcrJG7B+yULN7C9kf4SJbnFYuJwR/61/T
   g==;
IronPort-SDR: rd2h2XIp/I9GhSzoZb4+sQp+VVgTLzBAARzNiw4m4Qq4D5pLzuZQjudRvv9NIvQbiaWFqUwYap
 KnWTKwg8HuNKReZlzy+gDuLpzPPkwmTtY4qUNQtHAKMtWtfKg96T9X9Sr2MTnlavmj1QR7pNYv
 IOAUhcMqQsVYOXQoXoduCliyAHY4vD+J2xS2UKHV6Es+r8Xnw9GrBc3+qtDPhYgwBHtnfmvaOA
 9WHFz3UyQ2Eysd3X+5yl/5BUqlgmqVHYhFIOmdzpENCgIe/ikZAuTpTmVVVPgHoZUYtoCT13t6
 RmM=
X-IronPort-AV: E=Sophos;i="5.82,313,1613458800"; 
   d="scan'208";a="122230553"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 09:46:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:46:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 19 May 2021 09:46:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfjYzcbot64yYkrZqgCRJOuIx2npuDV9tr7n3GXWA4Q0wnrrNInr31+6CAEJUssRwcseibFs0g90q6KlU0h9m9qbOWTeI613YJSaWX3o+bEjq0muBuApiHyVCqQLivewvLnOazvF+HM/+1HP+uCfc8mN98SwUVg5E1j/i98DfOybzBa7cu/1ACstUywhH23zMjUQ4ubITMvVNw0OUPDO56ZUqq5rrRtgntenXlKg9zid3cLgxHTOCI9Xn0KcAK/E1b1oyq8zOccW07Ne4xTSujGTr+VSucHTEE3PvYHPxW/6/3MpN4fSNKMjh/XAQNaGw8XhELFNiKR6eULTM67kQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ReTqdHYlyh1KnQln95bkCOKK4lTlBJgStzWxUV4bIY=;
 b=Kpiaxnbcv61w/5eI7fYJr2o+ip0HMMF7+n0gKTgzQOG26ynsu2v1RYVbC6Z+4oYTEe2EVCYm6c620xhvy8Q3N/qYmV88z6F2hBJkZx5d+uVZTCIUsaP9JRaFvIVU50Hrj/B7XyAqHJlRxEWr/FpZkhLIDnjmwQl49za4sXC9yMnJXfHevbUBi+fuzH/L9dx8NnJS+WrmYdlBADDagcIycvTSgGmJEDV9kE7isFkRC2gKlYJq1+SS7rh/kilT5iCXmMbXXUjbGjZNg59nQzr+nZqmCrdNiLyifaWEUIuFX7ajHOLHib8eVEcbq4Ata1wwDdGDd2dyZICLLRlOfB3YEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ReTqdHYlyh1KnQln95bkCOKK4lTlBJgStzWxUV4bIY=;
 b=YRUjbJ3li4tLuxHYBA2Mmd2Nfc13lF5rFRkHP/z54bLJ9DNY83LDc2qf1otSCEB3QMv1vwS8knkG8qAuLQDqI63lTnevL/BFIZHEAIMgPeyudQHphum1PZ47JgHCxmte9n4x25cbA8D4SjsP5f1rN8SkIqm6+qfh900SDZhI4Xk=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3662.namprd11.prod.outlook.com (2603:10b6:208:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 16:45:59 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::5c3a:4fee:564f:feda]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::5c3a:4fee:564f:feda%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:45:59 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <Ahmad.Danesh@microchip.com>, <cpetersen@fb.com>,
        <mahesh.natu@intel.com>, <dan.j.williams@intel.com>,
        <Vincent.Hache@microchip.com>, <Ariel.Sibley@microchip.com>,
        <Sanjay.Goyal@microchip.com>, <scolee@microsoft.com>,
        <jhinkle@lenovo.com>, <guru.anbalagane@microsoft.com>,
        <kevin.marks@dell.com>, <bhirano@micron.com>,
        <chet.r.douglas@intel.com>, <dcaracci@micron.com>,
        <jgroves@micron.com>, <andy.rudoff@intel.com>
Subject: CXL Vendor Specific Capabilities
Thread-Topic: CXL Vendor Specific Capabilities
Thread-Index: AddMzmouHMJcDmirRxSkUzaFgoYHKw==
Date:   Wed, 19 May 2021 16:45:58 +0000
Message-ID: <MN2PR11MB36459D88FEB3BB66E5844DE7882B9@MN2PR11MB3645.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [159.2.3.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca4abac-66b3-4a90-df1d-08d91ae5947c
x-ms-traffictypediagnostic: MN2PR11MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36627ACBCA45DEDBCEEF0D0A882B9@MN2PR11MB3662.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw0m7AOH0bORHjVl9GjI6fOzaRWcErmdFVHDrSUAcBmCr4vjx27zu+WKo9qhCljIlWlqy5MJsBdDXJ2Pnqh9tFZMR7RlwrnMQGc2pqEekziL27NMHhKKyXFq62kWQK1Pw/e8h6tIDmnBOTFoOfT2tzQ0ZO9slc7rL4SZLstazdC993vBP9dZWuWi/Bj0AFf+N3VK9qAt5Gs84IPbtWENeKZYB6Tf60O/8pKJIF61By7oQx1uSHVW7690Kz6okqGQeBEjwVhl4HrRYJC75A77S4m2FgpdCrMOQ7kY69s6qosWI36kmiCcLxH69E3rKIyP2z48vZDpwPzvZd92YVzS7GneT5La38ahMCRTd4OHcB0plzixwcOsfZZj44TFYUCknS+Yvkt9QSNYqC+3V3QEX1SnDMC73oc+ym9v0+poyb75qm9DMIapSRXbqunkPVgcNtckzKh1ARMAgFrNc3S25dEs22Qd++wsDfcBttd3DNzQf/3uUTMqfvFdMrcQ9VUTphnraYjJxV6DLAye14qQbP3tiV4cna1cf+MUaCRdslXom5UfQH+QI0+Z9PfhuBccVChh00EMlgG2VPAnpyZLYhao9dKwPcJKA+gnOVz9MLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(7696005)(9686003)(6506007)(38100700002)(122000001)(54906003)(71200400001)(7416002)(83380400001)(5660300002)(8936002)(316002)(8676002)(55016002)(52536014)(2906002)(76116006)(66556008)(478600001)(66476007)(64756008)(186003)(3480700007)(6916009)(66446008)(66946007)(4326008)(33656002)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZVZoOGFsQmx6YndDeFFhYWZoaGozekRaem1TTnpScEZhZERPcDhTRW1PWW90?=
 =?utf-8?B?b0kxemsrbCtLd254dW5qVlhqM2lIZHlGcWhRZW0wYnVrMjU0WDVDekJPTFZV?=
 =?utf-8?B?ODBxSC9YYmpIWDJBSlBFUEpRemdydUVoZjV3aU5wRThHWGJqcGNpamZvQmI3?=
 =?utf-8?B?MFFoa3pUUkxLbVlkRnRNcjNaMVBQaWNpUXlXREZBWXMrY1VXNTEzajVoZGkz?=
 =?utf-8?B?YVNyVCtXWG5SM2M1Mlp0UWdQbE9VYUlEbUR1Z01RVVBoRXd3Vm5MWlZtUmM1?=
 =?utf-8?B?UEl1NkgvSHpDTkRXMmpuVVo0UXlLaGxQb004R2hxalJES0Q3ZVlaNFp5ajd6?=
 =?utf-8?B?eWNjRkM5YXRYT3VBd0h3M3RsTi9zTEs1SmZOeVUzM1VGeVplbVpibDVBa25H?=
 =?utf-8?B?TXh4UnRsb2wvQzd5K1pVZG80bUlpeCs3MjlmRUlSV1o0MlkvL0FOT1FzNVpP?=
 =?utf-8?B?Zm8yd2haUmZNM1lPcW93WE96bmZOTUwrcnlpZGtFdHY0M0dlRWJUV2Zjd3Yz?=
 =?utf-8?B?NEQ1QWEraERnYktpWEFwN2x2emZ1dWNSbUFiRmVMRng4WTVVZ1loWmtGZ2gv?=
 =?utf-8?B?WFdGNmdCRjlHSEx5UFdzYkY1OCtmOE9tMjFRY0p5a0phRllVQURHN3NCb25W?=
 =?utf-8?B?UUhVY0dXL21nRXRqalBZVzIvWFE5QWhiVmhsL3dRZEUwVzYrU1lVV3BlYmpv?=
 =?utf-8?B?a1RJSHA4Z05ObXIxZExKUVI0cUJnYjdQR0RwOTFsbzJORUpwdjVldFhsdEU3?=
 =?utf-8?B?SndPRnRQenZKMjdFeEFJMXNaSmtNdlF3WlVZMFVSTXlxMHZVUC90d0YxVGdT?=
 =?utf-8?B?NHFkaS9GU29sTmJSSlE4Qi84RWRkdmY3R213VlIvaFpzRE9nK005dnljaW5V?=
 =?utf-8?B?T3RLeWRlZWRPZHMxQVdmQWgwZ2tEdlVpNE9qWEs0QTFrVkNLRXVXSmRLRFJB?=
 =?utf-8?B?Q2gyV2t1aWc1eHNxeCtMVFpwVGk3L1RZQnhvTUFsUXl1ME91c0lnYXg4dmVi?=
 =?utf-8?B?MzZvNVFWc3RIWk5XaWY3YXB0MFpnUjdmbTBhSGNCMUVUaFlvN1p5OVpRWFFD?=
 =?utf-8?B?SWVpcXJCNVo2QXVkU1hQLzlKYjJYS2dMb0E0bEk4SDdxVEkrRzZ3U0pxN1lM?=
 =?utf-8?B?UW9qRU5zdGFVZHJnTXh5TzFVdzBoeVVnejlLTFV2UjRqd0xjSFh1dzd2SDVD?=
 =?utf-8?B?ZGpLSkE5dDdaVjN5SGVoNVRLNFNtTXZTaTgwU0VBUUx1L1o0alN1TmxiREZv?=
 =?utf-8?B?RlB2MDRrNFVJdSszM1k2REQvVVJFdzI5d1hYZEhrdGdqRGxBT0xuVldvMDVD?=
 =?utf-8?B?R08xbys3UFUxWHpTR0EyVTUvMW5sN2lkd2VudEk0SkNNZ3JoUUJwTmpwVnZ1?=
 =?utf-8?B?bEZUdWNmU0o1Q3crQzZvdHRVa3NQdGtaUDVrclIwVDkyK3BaMFBTWXNwYTRL?=
 =?utf-8?B?bVJzcGRnRHNtdzA2L2c2eGdOSVdnUmI0MStCRElDcnlhb3l0RGtMM0gxMTRo?=
 =?utf-8?B?QjlodWQwTEwySVhGeHAvRzFTUHJxUnlTd3ZQaHhLY3I1czFkSm1mUk1CcHNY?=
 =?utf-8?B?Q1h0aFNGUHNQQVZGc1BlVnIzaElBWXhITmhwVVl1RVlXV2RhWFRYSiswYk5W?=
 =?utf-8?B?dy93aWd6cktQWnlhRFRDTDdmYmwySGpjaGVhYlYyWEcxTVpiRi90ZmJOdlBU?=
 =?utf-8?B?NDgwekMzMjhuaEp4cjg5NU8wc285TGlSYUJlOU1NTWF4LzdoWXNVNXgvbUxL?=
 =?utf-8?Q?4WU7Ok/xEatCLxak+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca4abac-66b3-4a90-df1d-08d91ae5947c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:45:59.0110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzNKBVhR3aNdM+TjKX/8L/qIN0aHszWpMK2QM6d4RmwGrKrX84zFt7PmPPoDIGUzMBmJhhdiYEIQuI4BRumgsOsfIOOA+WDtLKbnwr0ZYBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3662
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

UmUtb3BlbmluZyBkaXNjdXNzaW9uIG9uIHZlbmRvci1zcGVjaWZpYyBjYXBhYmlsaXRpZXMgb24g
bGludXgtY3hsIG1haWxpbmcgbGlzdC4NCg0KQmFja2dyb3VuZDoNCj09PT09PT09PT09DQoNClRo
ZSBkZWZhdWx0L3JlY29tbWVuZGVkIHZhbHVlIG9mIHRoZSBDT05GSUdfQ1hMX01FTV9SQVdfQ09N
TUFORFMgS2NvbmZpZyBrbm9iIHdpbGwgYmxvY2sgcGFzc3Rocm91Z2ggb2YgdmVuZG9yIGRlZmlu
ZWQgbWFpbGJveCBjb21tYW5kcy4gIElmIHRoaXMgS2NvbmZpZyBrbm9iIGlzIGVuYWJsZWQsIHBh
c3N0aHJvdWdoIG9mIHZlbmRvciBkZWZpbmVkIGNvbW1hbmRzIHdpbGwgc3RpbGwgdGFpbnQgdGhl
IGtlcm5lbC4NCg0KVGhlcmUgaXMgYSBjb25zZW5zdXMgYW1vbmcgZGV2aWNlIGFuZCBzeXN0ZW0g
bWFudWZhY3R1cmVycyB0aGF0IHZlbmRvci1zcGVjaWZpYyBjYXBhYmlsaXRpZXMgYXJlIGEgbmVj
ZXNzYXJ5IGNvbXBvbmVudCBvZiBzcGVjaWZpY2F0aW9ucyBhbmQgd2UgbmVlZCBhIHNvbHV0aW9u
IHRvIHN1cHBvcnQgdGhlc2UgY2FwYWJpbGl0aWVzLiBXaXRoaW4gcmVhc29uLCB0aGVzZSBjYXBh
YmlsaXRpZXMgbmVlZCB0byBiZSBlbmFibGVkIHdpdGhvdXQgdGFpbnRpbmcgdGhlIGtlcm5lbC4N
Cg0KS2V5IHBvaW50cyB0byBjb25zaWRlciByZWdhcmRpbmcgaGFuZGxpbmcgb2YgdmVuZG9yLXNw
ZWNpZmljIGNhcGFiaWxpdGllczoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCiogVGFpbnRpbmcgdGhl
IGtlcm5lbCBkdXJpbmcgaGFybWxlc3Mgb3BlcmF0aW9ucyBpcyBub3QgZGVzaXJhYmxlLiBXaGls
ZSBzb21lIHVzZXJzIGhhdmUgZnVsbCBjb250cm9sIG92ZXIgdGhlIGtlcm5lbCBhbmQgY291bGQg
cGF0Y2ggdGhpcyBiZWhhdmlvciwgdGhvc2UgdXNlcnMgd291bGQgcHJlZmVyIHRvIHVzZSB1cHN0
cmVhbWVkIGtlcm5lbCB2cy4gY2FycnlpbmcgcGF0Y2hlcy4NCg0KKiBUaGVyZSBpcyBhZ3JlZW1l
bnQgdGhhdCBzb21lIGNhcGFiaWxpdGllcyBhcmUgY2FuZGlkYXRlcyBmb3Igc3RhbmRhcmRpemF0
aW9uLCBidXQgYSBwYXRoIGZvciBlbmFibGluZyB0aGF0IGNsYXNzIG9mIGZ1bmN0aW9uYWxpdHkg
dW50aWwgaXQgbWFrZXMgaXRzIHdheSBpbnRvIHRoZSBzcGVjIGlzIG5lZWRlZC4gIEl0IHRha2Vz
IGEgbG9uZyB0aW1lIHRvIGdldCBhbnl0aGluZyB0aHJvdWdoIHRoZSBmdWxsIHByb2Nlc3Mgb2Yg
YWNjZXB0YW5jZSBpbnRvIHRoZSBzcGVjIGFuZCB1cHN0cmVhbWVkLiBUaGlzIHdpbGwgc2xvdyBh
ZG9wdGlvbiBhbmQgc3RpZmxlIGlubm92YXRpb24uDQoNCiogVGhlIHJlYWxpdHkgaXMgdGhhdCB3
ZSBjYW7igJl0IHB1dCBldmVyeXRoaW5nIGludG8gdGhlIHNwZWMuIFRoZSBwcmltYXJ5IGNhc2Vz
IGFyZSB2ZW5kb3Itc3BlY2lmaWMgaW1wbGVtZW50YXRpb25zIHdoaWNoIGFyZSBub3Qgc3VpdGVk
IGZvciBzdGFuZGFyZGl6YXRpb24sIGFuZCBwcm9wcmlldGFyeS9kaWZmZXJlbnRpYXRpbmcgZmVh
dHVyZXMuDQoNCiogTGltaXRpbmcgdGhlIHVzZWZ1bG5lc3Mgb2YgdGhlIHBhdGggZm9yIHZlbmRv
ciBjYXBhYmlsaXRpZXMgdGhyb3VnaCB0aGUgZHJpdmVyIHdpbGwgbGlrZWx5IHJlc3VsdCBpbiB1
bmRlc2lyYWJsZSBzaWRlLWVmZmVjdHMgYXMgc3VwcGxpZXJzIGFuZCBvdGhlcnMgd29u4oCZdCBh
Y2NlcHQgdGhpcywgZm9yY2luZyB2ZW5kb3JzIHRvIGRldmVsb3Agd29ya2Fyb3VuZHMgdGhhdCBi
eXBhc3MgdGhlIGRyaXZlci4gSWYgdGhlIGRyaXZlciBwcm92aWRlcyBhIHVzYWJsZSBwYXRod2F5
IHRoYXQgZG9lcyBub3QgdGFpbnQgdGhlIGtlcm5lbCwgdmVuZG9ycyBhcmUgbGVzcyBsaWtlbHkg
dG8gaW1wbGVtZW50IHN1Y2ggYXBwcm9hY2hlcy4gVGhlIGRyaXZlciB3aWxsIHRoZW4gYmUgYWJs
ZSB0byBwZXJmb3JtIHNvbWUgcG9saWNpbmcsIGZvciBpbnN0YW5jZSBiYXNlZCBvbiBDRUwgY29u
dGVudHMsIGFuZCBDWEwgZGV2aWNlIHByb3ZpZGVycyBjYW4gYmUgY29uc2lkZXJlZCBnb29kIGNp
dGl6ZW5zIG9mIHRoZSBMaW51eCBjb21tdW5pdHkuDQoNClJlY29tbWVuZGF0aW9uOg0KPT09PT09
PT09PT09PT09DQoNCkFsbG93IHJvb3QgdG8gaXNzdWUgdmVuZG9yIGRlZmluZWQgcGFzc3Rocm91
Z2ggY29tbWFuZHMgYnkgZGVmYXVsdCBhbmQgdXNlIHRoZSBDRUwgdG8gZGV0ZXJtaW5lIHdoZXRo
ZXIgYSBnaXZlbiBjb21tYW5kIHNob3VsZCB0YWludCB0aGUga2VybmVsLiAgQ29tbWFuZHMgdGhh
dCBoYXZlIG5vIGVmZmVjdHMsIG9yIGhhcm1sZXNzIGVmZmVjdHMsIHNob3VsZCBub3QgdGFpbnQg
dGhlIGtlcm5lbC4gIENvbW1hbmRzIHRoYXQgaGF2ZSBwb3RlbnRpYWxseSBoYXJtZnVsIGVmZmVj
dHMgc2hvdWxkIHRhaW50IHRoZSBrZXJuZWwuDQoNCkV4YW1wbGVzOg0KPT09PT09PT09DQoNCkNh
c2UgMTogVmVuZG9yIGRlZmluZWQgaXMgbmVlZGVkLCBhbmQgdGhlIG9wZXJhdGlvbnMgZG8gbm90
IGltcGFjdCB0aGUgbm9ybWFsIG9wZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBUaGUgQ0VMIGNvbnRl
bnRzIGNvdWxkIGJlIHVzZWQgdG8gZGV0ZXJtaW5lIHRoZXJlIGlzIG5vIGltcGFjdCBhbmQgdGhl
cmVieSBwZXJtaXQgdGhlc2UgY29tbWFuZHMgd2l0aG91dCB0YWludGluZyB0aGUga2VybmVsLg0K
DQoqIEV4YW1wbGUgMS4xOiBJbnRlcmZhY2luZyB3aXRoIGNvbW1vbiBkaWFnbm9zdGljIGZlYXR1
cmVzIHdoaWNoIG1heSBoYXZlIHdpZGUtcmFuZ2luZyBpbXBsZW1lbnRhdGlvbnMgYW5kIGNhcGFi
aWxpdGllcyBhY3Jvc3MgZGlmZmVyZW50IHZlbmRvcnMuIEUuZy4gU2lnbmFsIGludGVncml0eSBk
aWFnbm9zdGljcywgZGVidWcgY291bnRlcnMuDQoNCiogRXhhbXBsZSAxLjI6IFJldHJpZXZlIGRp
YWdub3N0aWNzIGRhdGEgZnJvbSBwcm9wcmlldGFyeSB2YWx1ZS1hZGQgZmVhdHVyZXMuDQoNCkNh
c2UgMjogVmVuZG9yIGRlZmluZWQgaXMgbmVlZGVkLCBidXQgdGhlIG9wZXJhdGlvbnMgaW1wYWN0
IHRoZSBub3JtYWwgb3BlcmF0aW9uIG9mIHRoZSBkZXZpY2UuIENFTCBjb250ZW50cyBjYW4gYmUg
dXNlZCB0byBkZXRlcm1pbmUgdGhlIGltcGFjdCBhbmQgdGFpbnQgdGhlIGtlcm5lbC4NCg0KKiBF
eGFtcGxlIDIuMTogVmVuZG9yLXNwZWNpZmljIGRpYWdub3N0aWNzIGZlYXR1cmVzIHRoYXQgYXJl
IGludGVuZGVkIHRvIHN0cmVzcyB0aGUgZGV2aWNlIG9yIG1lbW9yeSBmb3IgcXVhbGlmaWNhdGlv
biBhbmQgdmFsaWRhdGlvbiBwdXJwb3Nlcy4gDQoNClEgJiBBOg0KPT09PT09DQoNClE6IFdoeSBp
cyBpdCBhIHByb2JsZW0gdG8gaGF2ZSBDT05GSUdfQ1hMX01FTV9SQVdfQ09NTUFORFMgZGlzYWJs
ZWQgYnkgZGVmYXVsdD8NCkE6IFRoaXMgcHVzaGVzIHRoZSBwcm9ibGVtIHRvIHRoZSBkaXN0cm9z
LiBEaXN0cm9zIGFyZSBsaWtlbHkgdG8gZm9sbG93IHRoZSBLY29uZmlnIHJlY29tbWVuZGF0aW9u
IGJ5IGRlZmF1bHQsIHNvIGluZHVzdHJ5IHdpbGwgbmVlZCB0byBoYXZlIHRoaXMgZGlzY3Vzc2lv
biB3aXRoIGVhY2ggbWFqb3IgZGlzdHJvIG1haW50YWluZXIuIElmIHdlIGNhbiByZWFjaCBhIGNv
bnNlbnN1cyBpbiB0aGlzIGZvcnVtIHRoYXQgd2UgY2FuIGRlZmF1bHQgdGhpcyBrbm9iIHRvIGVu
YWJsZWQsIGRpc3Ryb3MgYXJlIG1vcmUgbGlrZWx5IHRvIGFsc28gZW5hYmxlIHRoZSBmdW5jdGlv
bmFsaXR5Lg0KDQpROiBXaHkgaXMgaXQgYSBwcm9ibGVtIHRvIHRhaW50IHRoZSBrZXJuZWwgZm9y
IGFsbCBwYXNzdGhyb3VnaCBjb21tYW5kcyB3aGVuIENPTkZJR19DWExfTUVNX1JBV19DT01NQU5E
UyBpcyBlbmFibGVkPw0KQTogU29tZSBmdW5jdGlvbmFsaXR5IGlzIGhhcm1sZXNzLiBJZiB0aGUg
a2VybmVsIGlzIHRhaW50ZWQgd2hlbiBleGVjdXRpbmcgYmFzaWMgcmVhZC1vbmx5IGRpYWdub3N0
aWNzLCBpdCBtYXkgYmUgaGFyZGVyIHRvIGdldCBzdXBwb3J0IGZvciByZWFsIGlzc3VlcyBhcyB0
aGUgc3RhdGUgb2YgdGhlIHN5c3RlbSB3aWxsIGJlIHN1c3BlY3QuIFRoZSBkcml2ZXIgc2hvdWxk
IGJlIGFibGUgdG8gdXNlIHRoZSBDRUwgdG8gZGV0ZXJtaW5lIHdoZW4gdG8gdGFpbnQuDQoNClE6
IFdoeSBjYW4ndCB3ZSB1c2UgVmVuZG9yIExvZyBmb3IgdGhpcz8NCkE6IFNldmVyYWwgcmVhc29u
czoNCiogVGhlcmUgaXMgbm8gYWJpbGl0eSB0byBjb250cm9sIGZ1bmN0aW9uYWxpdHkuIE1hbnkg
ZGlhZ25vc3RpYyBmZWF0dXJlcyByZXF1aXJlIGlucHV0IHRvIGNvbmZpZ3VyZSB3aGF0IGlzIGJl
aW5nIHJlYWQuDQoqIFRoZSBkZXZpY2UgbWF5IHJlcXVpcmUgdGltZSB0byBjb2xsZWN0IHRoZSBk
aWFnbm9zdGljIGluZm9ybWF0aW9uLCBidXQgbXVzdCByZXNwb25kIHRvIEdldCBMb2cgaW4gdW5k
ZXIgMiBzZWNvbmRzIChwcmVmZXJhYmx5IG11Y2ggZmFzdGVyKS4NCiogSXQgaXMgYSBzaW5nbGUg
YmxvYiwgd2hpY2ggY2FuIGJlIGFjY2Vzc2VkIGF0IGFyYml0cmFyeSBvZmZzZXRzLiBUaGUgbGlt
aXRlZCBzZXQgb2YgdXNlIGNhc2VzIHRoYXQgY291bGQgYmUgY292ZXJlZCBieSB0aGlzIG1vZGVs
IHdvdWxkIHJlcXVpcmUgZHJpdmVyIGNoYW5nZXMgdG8gZW5hYmxlIHRoZSBWZW5kb3IgTG9nIHRv
IGJlIGR1bXBlZCB3aXRoIGZpbmVyIGdyYW51bGFyaXR5LiBCdXQgZXZlbiB0aGVuLCB0aGUgZmFj
dCB0aGF0IHRoZSBob3N0IGNvdWxkIHBvdGVudGlhbGx5IHJlYWQgYW55d2hlcmUgaW4gdGhlIFZl
bmRvciBMb2cgYXQgYW55IHRpbWUgbWFrZXMgcm9idXN0bHkgZW5jb2RpbmcgYSBzZXQgb2YgZGVi
dWcgZm9yZW5zaWNzIHRoYXQgYXJlIHBvcHVsYXRlZCBvbiBkZW1hbmQgKGluIHJlc3BvbnNlIHRv
IEdldCBMb2cpIGZyb20gdW5kZXJseWluZyBoYXJkd2FyZSBpbnRvIHZlbmRvciBkZWZpbmVkIG9m
ZnNldHMgaW4gdGhlIFZlbmRvciBMb2cgZGlmZmljdWx0Lg0KDQpROiBXaGF0IGFib3V0IHNlY3Vy
aXR5Pw0KQTogV2hpbGUgdmVuZG9yIGNvbW1hbmRzIGhhdmUgdGhlIHBvdGVudGlhbCB0byBiZSBh
IHNlY3VyaXR5IHJpc2ssIGl0IHNob3VsZCBub3QgYmUgdGhlIGRyaXZlcuKAmXMgcmVzcG9uc2li
aWxpdHkgdG8gc29sdmUgdGhhdCBwcm9ibGVtLiBUaGUgaW4tYmFuZCBwYXRoIHRocm91Z2ggdGhl
IGRyaXZlciBpcyBqdXN0IG9uZSBwYXRoIGludG8gdGhlIGRldmljZS4gRm9yIGEgZGV2aWNlIHRv
IGJlIHNlY3VyZSwgdmVuZG9ycyBhbmQgdGhlaXIgcGFydG5lciBjdXN0b21lcnMgbmVlZCB0byBs
b2NrIG91dCBhbnl0aGluZyB0aGF0IGlzIGEgc2VjdXJpdHkgcmlzayBhdCB0aGUgZGV2aWNlIGxl
dmVsIGZvciBwcm9kdWN0aW9uLiBHaXZlbiB0aGF0IHRoaXMgZGV2aWNlIGxldmVsIGxvY2tvdXQg
aXMgbmVjZXNzYXJ5LCB0aGUgY2F0Y2ggYWxsIGxvY2tvdXQgYXQgdGhlIGRyaXZlciBsZXZlbCBp
cyByZWR1bmRhbnQgZnJvbSBhIGRldmljZSBzZWN1cml0eSBwb2ludCBvZiB2aWV3Lg0KDQpROiBI
b3cgYWJvdXQgd2UgYWRkIGNvbW1hbmRzIHRvIFVBUEkgaW5zdGVhZD8NCkE6IFZlbmRvcnMgc2hv
dWxkIG5vdCBiZSBhZGRpbmcgaG9va3MgaW50byBhIGNsYXNzIGRyaXZlciB3aGljaCBpcyBzdXBw
b3NlZCB0byBiZSBnZW5lcmljLiBUaGUgZGV0YWlscyBvZiBhbnl0aGluZyB0aGF0IGdvZXMgaW4g
VUFQSSB3b3VsZCBuZWVkIHRvIGJlIGZ1bGx5IHB1YmxpYy4gQW55IHByb3Bvc2VkIGFkZGl0aW9u
cyB3b3VsZCBuZWVkIHRvIGJlIGZ1bGx5IGV4cGxhaW5lZCBhcyB0byB3aHkgdGhleSBhcmUgbm90
IGFibGUgdG8gYmUgYWRkZWQgdG8gdGhlIHNwZWMuIFRoaXMgbGltaXRzIHRoZSB2aWFiaWxpdHkg
b2YgVUFQSSBhcyBhIG1ldGhvZCBmb3IgdW5sb2NraW5nIHZhbHVlLWFkZCBmdW5jdGlvbmFsaXR5
Lg0KDQpDb25jbHVzaW9uOg0KPT09PT09PT09PT0NCg0KSSBsb29rIGZvcndhcmQgdG8gYSBoZWFs
dGh5IGRpc2N1c3Npb24gb24gaG93IHdlIGNhbiBtb3ZlIHRoaXMgZm9yd2FyZCwgYW5kIGhvcGUg
dGhhdCB3ZSBjYW4gcmVhY2ggYW4gYW5zd2VyIHRoYXQgaXMgYWNjZXB0YWJsZSBmb3IgdGhlIGtl
cm5lbCBtYWludGFpbmVycywgQ1hMIGRldmljZSB2ZW5kb3JzLCBhbmQgZW5kIHVzZXJzLg0KDQpS
ZWdhcmRzLA0KQXJpZWwNCg==
