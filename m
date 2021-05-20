Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF09C433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A054761006
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 11:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbhETL6n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 07:58:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52786 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbhETL5I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 May 2021 07:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621511747; x=1653047747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a8dHZkC1dDQoYanw3GktucqJPRdoowTVYXIq03pg4Uc=;
  b=2Sl41fONWeylfS5iA0cIRD5XuO4HP61S8huBbmygmeYLtnsgx6feCrqy
   LjrzA9XFbmJyMQ3o3Gg2QOYPwmAoZ3IwBiETNIfM3N+ruo5dSnbpGwwyD
   CKho0L1HZ38S+Qzr+4tBsoxiOfLyHu3aI3+HVPf8QHUu9sFpqB5VWJhRw
   FyG+++UMCMbZ0KVPUDTzz4jXafrijd8NoYJxQ7wXUs8CQ5LT66FYG/UE+
   faHOLX+TzX4+yahtm3JF+/xhP0/D+cJLxHxyKVOLa0JDPkaLxN258hFxX
   47IWKZsc2nrHj+HOQvaJGjA7iOXf2UMi7qEK7wA+Xn+VrazRczMt0/gBq
   Q==;
IronPort-SDR: Klvwj6kbP/iBXCqQuJftwjB45ifEN6/OPrUoQsoyoOd7i3ChDjlTxN1OLM6PMtlDxIiyo3SQXa
 4Pafp7cuzLrxiJIIMARXWqAnvm/fr1zgKPRocYUV8cAuSqH9r45GsStsaswfYgT3g+pZ9m753Y
 +yJFVt48RcpyJCO/0FN3Y2kDn7r0tsbVcxYa6aI0GBOhJeDbY9fYZGZhCeWcofKbBeKvBqNPlV
 cdgeAOVyPAa60uI95oIfolJLHPdWhF5yuKcYBuPru2S4GPQYNVgNbkJ5hjxri24RKfps0IFh1G
 ASs=
X-IronPort-AV: E=Sophos;i="5.82,313,1613458800"; 
   d="scan'208";a="128824978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 May 2021 04:55:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 04:55:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 20 May 2021 04:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAwvxgM1BPLm7GGhyQFAE4t+FisvLQv5i8WDHHAoYOumPERu0st/pEJPyvl0LaWRkuHg/8daNDW4yXB0YwpkAHNTj5zOOuHeEHsZ6AQ/v99ZXD543wbGeS/zgmoZsxAUpUHvdfZScqfHzkv61W3SCHJjgNZTVGlDkKxqZOstzbxCKD9Gqozl3iRHZKFkkUzVKH7+vOIGYIIfweUqRldNYW3e/qoeVRMBgNCWW9y24KQFtGnRPkNHeq5TpEQdDMUxmXrvrfle51pI5EaJ6CggLxXDgj41Fft23o8hAUWIhxEyM/Y126q/UeCQYa4k57eQZdABLyY/dwdEiNFYmurXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8dHZkC1dDQoYanw3GktucqJPRdoowTVYXIq03pg4Uc=;
 b=UYDsuHiBXlUDEk+qfo3liUqeU7HhxSF04VesS2pjuUnPdypoXe36rsNT/ZrF8lEGQPRjuMg+THkTSm8tJvG0PyzrHfUNZuaNYRJvlS+DiZoFnF9bVqZ/WqAkKczN+N7dW83Rr33fpZkjw6O8NZXvhp9MbIc9tuAqDOx5Z234Y96Omj4OSq0sM618itb+Jg8TMatt0rC1kfYwf84iYTRRmdxEVUnFAleRUCVFCLE5AxE1sqhJzU5EXFREVIJ2QrG5ksPjGpwpSrgN35+g+fiL68X/kAvOgcLN2VkQ00Dc+BFbQNA/KAc07ZgO/+/4obsYvPSQfsqGvnI50McIcBsqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8dHZkC1dDQoYanw3GktucqJPRdoowTVYXIq03pg4Uc=;
 b=guSpFOmbfaEyOaAhQZUXXYUwkQ8SLIx3+Lnrcz0gMBp+6xlPsmtBAJCk3H7vdn9z06xnWzxWpLIApZ4nfAnYg9dvVQTxlnLACPp4D9CfLnWA4PaW5Y2tbFPM9uoGCZvGmqOao6KtCkkLINBhbkbsXUUEwvP5dWni/abZnFGXoGQ=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB4160.namprd11.prod.outlook.com (2603:10b6:208:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 11:55:45 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::5c3a:4fee:564f:feda]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::5c3a:4fee:564f:feda%7]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 11:55:44 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <Ahmad.Danesh@microchip.com>,
        <cpetersen@fb.com>, <mahesh.natu@intel.com>,
        <dan.j.williams@intel.com>, <Vincent.Hache@microchip.com>,
        <Sanjay.Goyal@microchip.com>, <scolee@microsoft.com>,
        <jhinkle@lenovo.com>, <guru.anbalagane@microsoft.com>,
        <kevin.marks@dell.com>, <bhirano@micron.com>,
        <chet.r.douglas@intel.com>, <dcaracci@micron.com>,
        <jgroves@micron.com>, <andy.rudoff@intel.com>,
        <Vineeth.Pillai@microsoft.com>
Subject: CXL Vendor Specific Capabilities
Thread-Topic: CXL Vendor Specific Capabilities
Thread-Index: AddMzmouHMJcDmirRxSkUzaFgoYHKwAj5KoAAAQNOFA=
Date:   Thu, 20 May 2021 11:55:44 +0000
Message-ID: <MN2PR11MB3645E75023DC9C3478194CFF882A9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <MN2PR11MB36459D88FEB3BB66E5844DE7882B9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <YKYxmpzIHdc3yI5X@infradead.org>
In-Reply-To: <YKYxmpzIHdc3yI5X@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [159.2.3.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbe34a3f-a4f2-4722-a0ec-08d91b863346
x-ms-traffictypediagnostic: MN2PR11MB4160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB41609B68DD77C6EE201DD91D882A9@MN2PR11MB4160.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tEcpbO5pfplXsnI3vQwE5Uo1g6Z7v/MUMHHohbuOdwNDnT8Cri/bpcMxztX3icwHKqw+HkfragARWLtFGzZm8G7Zeq3Yag+3wGtrVsuw3KA68MYHE7XC+s36wU2TRziSj55R3k7X9KLj72n5j0xOPk7b09uLCmh35S6NyyTKm8ujY6XetEqX+MP+hGV4pLh3qzqRu9dOD6sS2AIcv/3Ju69CUcuBkNMPzzgrXG7G1jgTk2Hr1ME4fln6r8Zl/SPUDQC97lTZncx8A/Z/ek9R3c4TdgeFDiLBxxza3OfpVHohL7iw0qsXSkt4QN1wjmRtAoaTICvZACXbgXgNTPeoZKjILO1W3j45xquFoKXAV0AVlf7b/wN7l6JrWSm5oYcnZVIuf1e0HsKXTYzOCOZTYj7czW5kRhP6dIGX38hKRLL3pJr+kKMssHtN+ZRTkAhr3hXtEQRFTZLdaeSIZPrrCWqcWSzXmGtJcBFX/BVLD0uHo7prGPqP2kCEAwItoCkmILxThGBNRSuxrtengYQxR1C/M+t6ZYVY3mxWIS6mjp+ZEa+KUu9mXkA8aP7ulTxX+6cCOeFMRY0bYuzNUOCmI+ti7ac8iCYvORRgYoLNdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(38100700002)(7696005)(122000001)(2906002)(316002)(4326008)(8676002)(3480700007)(5660300002)(26005)(8936002)(6506007)(83380400001)(7416002)(52536014)(9686003)(71200400001)(54906003)(86362001)(76116006)(55016002)(478600001)(6916009)(66556008)(64756008)(66476007)(33656002)(66446008)(186003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qkk5eUV1eXpoaTJMK25VellkZ2JQSmRLVW1Mdm9GSmVKL3NCT1QxZzBldkNI?=
 =?utf-8?B?dks2TmVpSEo3ZHVNRlJ0NDhvZ2V1WGsrVUZqaFJQc3gvNW82M09UaDlDanln?=
 =?utf-8?B?WjIxa3ltSzU4VDFmWFUrTTRIQnVKejF4TEQzTmZwc0Ird3d5eXBkZU8vN3Mz?=
 =?utf-8?B?WlBZT0MyRU1tcmEwdmNxemprelg4YUR4Tm9JaS9jOWZNd0hPQm1WeW1lV2JV?=
 =?utf-8?B?allkRzhuVEJUOGdVVzFKSXo4cytJSHIzdDFjeC85WUtHNU9VdzNzcE5QaDdK?=
 =?utf-8?B?WkVFVFlNYzZ4RHVzQzk4blNiYUM5cXc0ZW1FMEs5NnA4V3hLZ1JHYzNHSlU4?=
 =?utf-8?B?Wlh6dzRpejJwRmhORGZqS0ZnMTZJYS9XS3VaSXR3NjUyMGlYUUhOeWpLSm9s?=
 =?utf-8?B?dzh6alBlOU1pYittVlI2TGxHUFk0eHZrcnhxNVFMM3VISmFvUFkxYi9GTEFS?=
 =?utf-8?B?YXRQa2MxMnpRMmN3RnJPVURlQ3U4bldsbmE5SEdUSlljcnpWZVU0bjZpdS9q?=
 =?utf-8?B?K1ZlNlNSMjlsakhvWXR2bk9pOUdINldCeGx2bHBVQmkvbDhYdFZtZjZtTm9T?=
 =?utf-8?B?SHd4NFZNaDN4Rm93Uy9EMTRjS2M0NjExa2k4RjNDbXRyN21MRVNBUzVBVmFu?=
 =?utf-8?B?QlpqSFNoQUUzcS9kWWNsWmdXcnRoNWhoeFhGUmJ0SmYzWDdlTWRIcXVNSWxH?=
 =?utf-8?B?UEV2ZEZVYUFUcFdYNUw4UG1ocGt2UEp2aXlYVk1rc0ppd3NKNU5uU1VucUpE?=
 =?utf-8?B?ZFdjMElaQUZZb3dmOFM1NjhqdVRoK20xM0tqMjQyc2p6ZG4xT1pHbmJabU1p?=
 =?utf-8?B?eVBZWDgzbHJpaHpQa256dE4vbEpYWm9DNkRzdGk0SXhpUERLMDdUU1FjU0RN?=
 =?utf-8?B?WjdXR0pJYW5PaEtpR01jblYzVCtjZlpJaTViZzh5UExhZU1LWUlQNm4wMWw4?=
 =?utf-8?B?RzhxSXMzcm5tUDF3U0k1T2NnYm1GdUpHTmYwbzhCamtMRGpyT1Nuc2drZHps?=
 =?utf-8?B?Umdia1pQQ3hMUlBwTU9ZMUttbXNBR2MvZ3diTGc2SEgyY1hHaExzYmo3djR1?=
 =?utf-8?B?d1pUSWFxWFc4N2dTRnNzQkJsNG05SXc4M0pLdk1HOEFkVHlhMzN4MFpuU1B5?=
 =?utf-8?B?UllEYkxzVnFXQXY5eFUzY21ja0JSM0FvdHF5eHpsR3RkTnNxYmpzY0hzTGV0?=
 =?utf-8?B?OVJxWHpBQXcyQUp4bGdzckwwc2NIWDQ5TUw4bnU2S0dyZjBIOHBkVjIzOG55?=
 =?utf-8?B?U1ZMcU9Pd2RmQ2NqTTZzaFVDcXRsQWtid1IvN25kdDZUMWdHY0gvWWF6YlRQ?=
 =?utf-8?B?ZlBocnYydHBYZE9ZUzY0Q1M1TDNGN0Y4N3RUcXpQYTRTVE1ZQWFrTXBFY2pT?=
 =?utf-8?B?cEtmOTJDVUhGcHhVVkgrRnRMM1dvZzM5RmhaZXZvOE1oK2xYNWt1ekx4Tkxp?=
 =?utf-8?B?a2pabVVGM0p1bi9EWTEyaW0zOU83NWJZOXBJb3owTTcwUmJVb3RxTTJ1RmEv?=
 =?utf-8?B?b2kzcnlpajIzNXZRNzk1YTFnbWQrbDRDOFBjMWQwQ3pKWDVnOHN0R2l4TjN4?=
 =?utf-8?B?WDgwWVhVTU1tTlZTV3M1citSZElYVzNlZlpZLzhTbTI3UTJ2ODhuQzdVN1lB?=
 =?utf-8?B?RUxDcyt4VTBZQUFUMlpqekJUNEd4dVRWN2FDbXA3Tjd2V0NRNkE5Tjg2UHE5?=
 =?utf-8?B?T0ZEYzFpdG1wTHUrb0VZVmM1VzlFYkV4UFV3K3pwOVZVOTgwbmJWTFlOWkdu?=
 =?utf-8?Q?KDtgwJQtRuLYVxcuAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe34a3f-a4f2-4722-a0ec-08d91b863346
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 11:55:44.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AY4tjpZt9wJYmciIQEThXbGBCmVjh6jD1Xh5BFJejFM9L7yYiuCtdYhcNTa67dFPhSW+/4nYeQBfSSOBpI0FZ1HswqRlL5YbSQfEVRw/fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4160
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

UmUtcG9zdGluZyB3aXRoIDgwIGNoYXIgbGluZSB3cmFwLg0KDQpCYWNrZ3JvdW5kOg0KPT09PT09
PT09PT0NCg0KVGhlIGRlZmF1bHQvcmVjb21tZW5kZWQgdmFsdWUgb2YgdGhlIENPTkZJR19DWExf
TUVNX1JBV19DT01NQU5EUyBLY29uZmlnIGtub2INCndpbGwgYmxvY2sgcGFzc3Rocm91Z2ggb2Yg
dmVuZG9yIGRlZmluZWQgbWFpbGJveCBjb21tYW5kcy4gIElmIHRoaXMgS2NvbmZpZw0Ka25vYiBp
cyBlbmFibGVkLCBwYXNzdGhyb3VnaCBvZiB2ZW5kb3IgZGVmaW5lZCBjb21tYW5kcyB3aWxsIHN0
aWxsIHRhaW50IHRoZQ0Ka2VybmVsLg0KDQpUaGVyZSBpcyBhIGNvbnNlbnN1cyBhbW9uZyBkZXZp
Y2UgYW5kIHN5c3RlbSBtYW51ZmFjdHVyZXJzIHRoYXQgdmVuZG9yLXNwZWNpZmljDQpjYXBhYmls
aXRpZXMgYXJlIGEgbmVjZXNzYXJ5IGNvbXBvbmVudCBvZiBzcGVjaWZpY2F0aW9ucyBhbmQgd2Ug
bmVlZCBhIHNvbHV0aW9uDQp0byBzdXBwb3J0IHRoZXNlIGNhcGFiaWxpdGllcy4gV2l0aGluIHJl
YXNvbiwgdGhlc2UgY2FwYWJpbGl0aWVzIG5lZWQgdG8gYmUNCmVuYWJsZWQgd2l0aG91dCB0YWlu
dGluZyB0aGUga2VybmVsLg0KDQpLZXkgcG9pbnRzIHRvIGNvbnNpZGVyIHJlZ2FyZGluZyBoYW5k
bGluZyBvZiB2ZW5kb3Itc3BlY2lmaWMgY2FwYWJpbGl0aWVzOg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cg0KKiBUYWludGluZyB0aGUga2VybmVsIGR1cmluZyBoYXJtbGVzcyBvcGVyYXRpb25zIGlzIG5v
dCBkZXNpcmFibGUuIFdoaWxlIHNvbWUNCnVzZXJzIGhhdmUgZnVsbCBjb250cm9sIG92ZXIgdGhl
IGtlcm5lbCBhbmQgY291bGQgcGF0Y2ggdGhpcyBiZWhhdmlvciwgdGhvc2UNCnVzZXJzIHdvdWxk
IHByZWZlciB0byB1c2UgdXBzdHJlYW1lZCBrZXJuZWwgdnMuIGNhcnJ5aW5nIHBhdGNoZXMuDQoN
CiogVGhlcmUgaXMgYWdyZWVtZW50IHRoYXQgc29tZSBjYXBhYmlsaXRpZXMgYXJlIGNhbmRpZGF0
ZXMgZm9yIHN0YW5kYXJkaXphdGlvbiwNCmJ1dCBhIHBhdGggZm9yIGVuYWJsaW5nIHRoYXQgY2xh
c3Mgb2YgZnVuY3Rpb25hbGl0eSB1bnRpbCBpdCBtYWtlcyBpdHMgd2F5IGludG8NCnRoZSBzcGVj
IGlzIG5lZWRlZC4gIEl0IHRha2VzIGEgbG9uZyB0aW1lIHRvIGdldCBhbnl0aGluZyB0aHJvdWdo
IHRoZSBmdWxsDQpwcm9jZXNzIG9mIGFjY2VwdGFuY2UgaW50byB0aGUgc3BlYyBhbmQgdXBzdHJl
YW1lZC4gVGhpcyB3aWxsIHNsb3cgYWRvcHRpb24gYW5kDQpzdGlmbGUgaW5ub3ZhdGlvbi4NCg0K
KiBUaGUgcmVhbGl0eSBpcyB0aGF0IHdlIGNhbuKAmXQgcHV0IGV2ZXJ5dGhpbmcgaW50byB0aGUg
c3BlYy4gVGhlIHByaW1hcnkNCmNhc2VzIGFyZSB2ZW5kb3Itc3BlY2lmaWMgaW1wbGVtZW50YXRp
b25zIHdoaWNoIGFyZSBub3Qgc3VpdGVkIGZvcg0Kc3RhbmRhcmRpemF0aW9uLCBhbmQgcHJvcHJp
ZXRhcnkvZGlmZmVyZW50aWF0aW5nIGZlYXR1cmVzLg0KDQoqIExpbWl0aW5nIHRoZSB1c2VmdWxu
ZXNzIG9mIHRoZSBwYXRoIGZvciB2ZW5kb3IgY2FwYWJpbGl0aWVzIHRocm91Z2ggdGhlDQpkcml2
ZXIgd2lsbCBsaWtlbHkgcmVzdWx0IGluIHVuZGVzaXJhYmxlIHNpZGUtZWZmZWN0cyBhcyBzdXBw
bGllcnMgYW5kIG90aGVycw0Kd29u4oCZdCBhY2NlcHQgdGhpcywgZm9yY2luZyB2ZW5kb3JzIHRv
IGRldmVsb3Agd29ya2Fyb3VuZHMgdGhhdCBieXBhc3MgdGhlDQpkcml2ZXIuIElmIHRoZSBkcml2
ZXIgcHJvdmlkZXMgYSB1c2FibGUgcGF0aHdheSB0aGF0IGRvZXMgbm90IHRhaW50IHRoZSBrZXJu
ZWwsDQp2ZW5kb3JzIGFyZSBsZXNzIGxpa2VseSB0byBpbXBsZW1lbnQgc3VjaCBhcHByb2FjaGVz
LiBUaGUgZHJpdmVyIHdpbGwgdGhlbiBiZQ0KYWJsZSB0byBwZXJmb3JtIHNvbWUgcG9saWNpbmcs
IGZvciBpbnN0YW5jZSBiYXNlZCBvbiBDRUwgY29udGVudHMsIGFuZCBDWEwNCmRldmljZSBwcm92
aWRlcnMgY2FuIGJlIGNvbnNpZGVyZWQgZ29vZCBjaXRpemVucyBvZiB0aGUgTGludXggY29tbXVu
aXR5Lg0KDQpSZWNvbW1lbmRhdGlvbjoNCj09PT09PT09PT09PT09PQ0KDQpBbGxvdyByb290IHRv
IGlzc3VlIHZlbmRvciBkZWZpbmVkIHBhc3N0aHJvdWdoIGNvbW1hbmRzIGJ5IGRlZmF1bHQgYW5k
IHVzZSB0aGUNCkNFTCB0byBkZXRlcm1pbmUgd2hldGhlciBhIGdpdmVuIGNvbW1hbmQgc2hvdWxk
IHRhaW50IHRoZSBrZXJuZWwuICBDb21tYW5kcw0KdGhhdCBoYXZlIG5vIGVmZmVjdHMsIG9yIGhh
cm1sZXNzIGVmZmVjdHMsIHNob3VsZCBub3QgdGFpbnQgdGhlIGtlcm5lbC4NCkNvbW1hbmRzIHRo
YXQgaGF2ZSBwb3RlbnRpYWxseSBoYXJtZnVsIGVmZmVjdHMgc2hvdWxkIHRhaW50IHRoZSBrZXJu
ZWwuDQoNCkV4YW1wbGVzOg0KPT09PT09PT09DQoNCkNhc2UgMTogVmVuZG9yIGRlZmluZWQgaXMg
bmVlZGVkLCBhbmQgdGhlIG9wZXJhdGlvbnMgZG8gbm90IGltcGFjdCB0aGUgbm9ybWFsDQpvcGVy
YXRpb24gb2YgdGhlIGRldmljZS4gVGhlIENFTCBjb250ZW50cyBjb3VsZCBiZSB1c2VkIHRvIGRl
dGVybWluZSB0aGVyZSBpcw0Kbm8gaW1wYWN0IGFuZCB0aGVyZWJ5IHBlcm1pdCB0aGVzZSBjb21t
YW5kcyB3aXRob3V0IHRhaW50aW5nIHRoZSBrZXJuZWwuDQoNCiogRXhhbXBsZSAxLjE6IEludGVy
ZmFjaW5nIHdpdGggY29tbW9uIGRpYWdub3N0aWMgZmVhdHVyZXMgd2hpY2ggbWF5IGhhdmUNCndp
ZGUtcmFuZ2luZyBpbXBsZW1lbnRhdGlvbnMgYW5kIGNhcGFiaWxpdGllcyBhY3Jvc3MgZGlmZmVy
ZW50IHZlbmRvcnMuIEUuZy4NClNpZ25hbCBpbnRlZ3JpdHkgZGlhZ25vc3RpY3MsIGRlYnVnIGNv
dW50ZXJzLg0KDQoqIEV4YW1wbGUgMS4yOiBSZXRyaWV2ZSBkaWFnbm9zdGljcyBkYXRhIGZyb20g
cHJvcHJpZXRhcnkgdmFsdWUtYWRkIGZlYXR1cmVzLg0KDQpDYXNlIDI6IFZlbmRvciBkZWZpbmVk
IGlzIG5lZWRlZCwgYnV0IHRoZSBvcGVyYXRpb25zIGltcGFjdCB0aGUgbm9ybWFsDQpvcGVyYXRp
b24gb2YgdGhlIGRldmljZS4gQ0VMIGNvbnRlbnRzIGNhbiBiZSB1c2VkIHRvIGRldGVybWluZSB0
aGUgaW1wYWN0IGFuZA0KdGFpbnQgdGhlIGtlcm5lbC4NCg0KKiBFeGFtcGxlIDIuMTogVmVuZG9y
LXNwZWNpZmljIGRpYWdub3N0aWNzIGZlYXR1cmVzIHRoYXQgYXJlIGludGVuZGVkIHRvIHN0cmVz
cw0KdGhlIGRldmljZSBvciBtZW1vcnkgZm9yIHF1YWxpZmljYXRpb24gYW5kIHZhbGlkYXRpb24g
cHVycG9zZXMuDQoNClEgJiBBOg0KPT09PT09DQoNClE6IFdoeSBpcyBpdCBhIHByb2JsZW0gdG8g
aGF2ZSBDT05GSUdfQ1hMX01FTV9SQVdfQ09NTUFORFMgZGlzYWJsZWQgYnkgZGVmYXVsdD8NCkE6
IFRoaXMgcHVzaGVzIHRoZSBwcm9ibGVtIHRvIHRoZSBkaXN0cm9zLiBEaXN0cm9zIGFyZSBsaWtl
bHkgdG8gZm9sbG93IHRoZQ0KS2NvbmZpZyByZWNvbW1lbmRhdGlvbiBieSBkZWZhdWx0LCBzbyBp
bmR1c3RyeSB3aWxsIG5lZWQgdG8gaGF2ZSB0aGlzDQpkaXNjdXNzaW9uIHdpdGggZWFjaCBtYWpv
ciBkaXN0cm8gbWFpbnRhaW5lci4gSWYgd2UgY2FuIHJlYWNoIGEgY29uc2Vuc3VzIGluDQp0aGlz
IGZvcnVtIHRoYXQgd2UgY2FuIGRlZmF1bHQgdGhpcyBrbm9iIHRvIGVuYWJsZWQsIGRpc3Ryb3Mg
YXJlIG1vcmUgbGlrZWx5IHRvDQphbHNvIGVuYWJsZSB0aGUgZnVuY3Rpb25hbGl0eS4NCg0KUTog
V2h5IGlzIGl0IGEgcHJvYmxlbSB0byB0YWludCB0aGUga2VybmVsIGZvciBhbGwgcGFzc3Rocm91
Z2ggY29tbWFuZHMgd2hlbg0KQ09ORklHX0NYTF9NRU1fUkFXX0NPTU1BTkRTIGlzIGVuYWJsZWQ/
DQpBOiBTb21lIGZ1bmN0aW9uYWxpdHkgaXMgaGFybWxlc3MuIElmIHRoZSBrZXJuZWwgaXMgdGFp
bnRlZCB3aGVuIGV4ZWN1dGluZw0KYmFzaWMgcmVhZC1vbmx5IGRpYWdub3N0aWNzLCBpdCBtYXkg
YmUgaGFyZGVyIHRvIGdldCBzdXBwb3J0IGZvciByZWFsIGlzc3VlcyBhcw0KdGhlIHN0YXRlIG9m
IHRoZSBzeXN0ZW0gd2lsbCBiZSBzdXNwZWN0LiBUaGUgZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRv
IHVzZSB0aGUNCkNFTCB0byBkZXRlcm1pbmUgd2hlbiB0byB0YWludC4NCg0KUTogV2h5IGNhbid0
IHdlIHVzZSBWZW5kb3IgTG9nIGZvciB0aGlzPw0KQTogU2V2ZXJhbCByZWFzb25zOg0KKiBUaGVy
ZSBpcyBubyBhYmlsaXR5IHRvIGNvbnRyb2wgZnVuY3Rpb25hbGl0eS4gTWFueSBkaWFnbm9zdGlj
IGZlYXR1cmVzDQpyZXF1aXJlIGlucHV0IHRvIGNvbmZpZ3VyZSB3aGF0IGlzIGJlaW5nIHJlYWQu
DQoqIFRoZSBkZXZpY2UgbWF5IHJlcXVpcmUgdGltZSB0byBjb2xsZWN0IHRoZSBkaWFnbm9zdGlj
IGluZm9ybWF0aW9uLCBidXQgbXVzdA0KcmVzcG9uZCB0byBHZXQgTG9nIGluIHVuZGVyIDIgc2Vj
b25kcyAocHJlZmVyYWJseSBtdWNoIGZhc3RlcikuDQoqIEl0IGlzIGEgc2luZ2xlIGJsb2IsIHdo
aWNoIGNhbiBiZSBhY2Nlc3NlZCBhdCBhcmJpdHJhcnkgb2Zmc2V0cy4gVGhlIGxpbWl0ZWQNCnNl
dCBvZiB1c2UgY2FzZXMgdGhhdCBjb3VsZCBiZSBjb3ZlcmVkIGJ5IHRoaXMgbW9kZWwgd291bGQg
cmVxdWlyZSBkcml2ZXINCmNoYW5nZXMgdG8gZW5hYmxlIHRoZSBWZW5kb3IgTG9nIHRvIGJlIGR1
bXBlZCB3aXRoIGZpbmVyIGdyYW51bGFyaXR5LiBCdXQgZXZlbg0KdGhlbiwgdGhlIGZhY3QgdGhh
dCB0aGUgaG9zdCBjb3VsZCBwb3RlbnRpYWxseSByZWFkIGFueXdoZXJlIGluIHRoZSBWZW5kb3Ig
TG9nDQphdCBhbnkgdGltZSBtYWtlcyByb2J1c3RseSBlbmNvZGluZyBhIHNldCBvZiBkZWJ1ZyBm
b3JlbnNpY3MgdGhhdCBhcmUgcG9wdWxhdGVkDQpvbiBkZW1hbmQgKGluIHJlc3BvbnNlIHRvIEdl
dCBMb2cpIGZyb20gdW5kZXJseWluZyBoYXJkd2FyZSBpbnRvIHZlbmRvciBkZWZpbmVkDQpvZmZz
ZXRzIGluIHRoZSBWZW5kb3IgTG9nIGRpZmZpY3VsdC4NCg0KUTogV2hhdCBhYm91dCBzZWN1cml0
eT8NCkE6IFdoaWxlIHZlbmRvciBjb21tYW5kcyBoYXZlIHRoZSBwb3RlbnRpYWwgdG8gYmUgYSBz
ZWN1cml0eSByaXNrLCBpdCBzaG91bGQNCm5vdCBiZSB0aGUgZHJpdmVy4oCZcyByZXNwb25zaWJp
bGl0eSB0byBzb2x2ZSB0aGF0IHByb2JsZW0uIFRoZSBpbi1iYW5kIHBhdGgNCnRocm91Z2ggdGhl
IGRyaXZlciBpcyBqdXN0IG9uZSBwYXRoIGludG8gdGhlIGRldmljZS4gRm9yIGEgZGV2aWNlIHRv
IGJlIHNlY3VyZSwNCnZlbmRvcnMgYW5kIHRoZWlyIHBhcnRuZXIgY3VzdG9tZXJzIG5lZWQgdG8g
bG9jayBvdXQgYW55dGhpbmcgdGhhdCBpcyBhDQpzZWN1cml0eSByaXNrIGF0IHRoZSBkZXZpY2Ug
bGV2ZWwgZm9yIHByb2R1Y3Rpb24uIEdpdmVuIHRoYXQgdGhpcyBkZXZpY2UgbGV2ZWwNCmxvY2tv
dXQgaXMgbmVjZXNzYXJ5LCB0aGUgY2F0Y2ggYWxsIGxvY2tvdXQgYXQgdGhlIGRyaXZlciBsZXZl
bCBpcyByZWR1bmRhbnQNCmZyb20gYSBkZXZpY2Ugc2VjdXJpdHkgcG9pbnQgb2Ygdmlldy4NCg0K
UTogSG93IGFib3V0IHdlIGFkZCBjb21tYW5kcyB0byBVQVBJIGluc3RlYWQ/DQpBOiBWZW5kb3Jz
IHNob3VsZCBub3QgYmUgYWRkaW5nIGhvb2tzIGludG8gYSBjbGFzcyBkcml2ZXIgd2hpY2ggaXMg
c3VwcG9zZWQgdG8NCmJlIGdlbmVyaWMuIFRoZSBkZXRhaWxzIG9mIGFueXRoaW5nIHRoYXQgZ29l
cyBpbiBVQVBJIHdvdWxkIG5lZWQgdG8gYmUgZnVsbHkNCnB1YmxpYy4gQW55IHByb3Bvc2VkIGFk
ZGl0aW9ucyB3b3VsZCBuZWVkIHRvIGJlIGZ1bGx5IGV4cGxhaW5lZCBhcyB0byB3aHkgdGhleQ0K
YXJlIG5vdCBhYmxlIHRvIGJlIGFkZGVkIHRvIHRoZSBzcGVjLiBUaGlzIGxpbWl0cyB0aGUgdmlh
YmlsaXR5IG9mIFVBUEkgYXMgYQ0KbWV0aG9kIGZvciB1bmxvY2tpbmcgdmFsdWUtYWRkIGZ1bmN0
aW9uYWxpdHkuDQoNCkNvbmNsdXNpb246DQo9PT09PT09PT09PQ0KDQpJIGxvb2sgZm9yd2FyZCB0
byBhIGhlYWx0aHkgZGlzY3Vzc2lvbiBvbiBob3cgd2UgY2FuIG1vdmUgdGhpcyBmb3J3YXJkLCBh
bmQNCmhvcGUgdGhhdCB3ZSBjYW4gcmVhY2ggYW4gYW5zd2VyIHRoYXQgaXMgYWNjZXB0YWJsZSBm
b3IgdGhlIGtlcm5lbCBtYWludGFpbmVycywNCkNYTCBkZXZpY2UgdmVuZG9ycywgYW5kIGVuZCB1
c2Vycy4NCg0KUmVnYXJkcywNCkFyaWVsDQo=
