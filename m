Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9CDC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 07:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjFHHjn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 03:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjFHHjm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 03:39:42 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7491BDF
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686209980; x=1717745980;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ip+4JmWPXeKcVcH2zHLVRfXFi2ALMnMFjmIb4+ITmYc=;
  b=WS8Isf4so4wXGt5dy4qTTDCsqlhG4TpjhFBDTBaxy2QXrUKhtDTCwdXc
   4oO7GwsHenPBDbZJIXGEEFcgUrsZDONasTwavbm8oxFjw7inkDm80bz/9
   /DGTRR/0P0JDg+ZPn3T5V3ULJKGn+J0SObxRfXSyJo1hYymRDe3bznF1B
   dFDU2rMx7/ObkBYLa6683rTo+raMfAxEuK2KNM2j13lRPZ9A0rdMNQrFt
   l44pDrY3wPJyUoWQxdUVwG8fBbmUs5g7vxL6YvisfNn0fzyrxR+3y5ugp
   0x/IOVqSxycvzlO/X48BvzTDx+Jb/6mW1Omm8sIfti3KlZJF+SH0wo/iK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="86672151"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; 
   d="scan'208";a="86672151"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 16:39:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNODsEHNV83QEbfLbzScdELwtnFo+1xuYJR2yxxSZA5CswgeHMDCK+altuimnzAVaRwEaQNSbmHDcWF1sX7AgvBrML7ZdeLrZi266T50WCLM5Cec7q5S3PyBGoN8tJ2IZOthHSdkRdrvr0z0CidTncegwryyWOA6RHITxuwcwDhG95wzZBCPrjMbOCKQ9RqRH8rbip8Rgo5MVLkjbnAhMMdh6jFFQOmB3rqMecjfEkcUgN/I3jRx1ByDJkwmH+sEejV2hpkHDMqPsssDGVGVsnj81EVmxToVxfFqblJyLKPW9pjCfhxgJhHvzVGzPB416S02y2YtV08flu6Fo7DD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siMXhR609HPhCBZksl1Z5qpNS8RoZNZw+DInk9DSSDY=;
 b=a0kOSg/68euDrz/o+MEZM9i9KwT3Su7s3IvVFd/qwq2fxrTh7PsStDXkBppVpdY0Vue+8vYQXSZnYCCe3Gf5Xi9cA3nz9mW0EUDv0HHcx12LO3fohZYIRVrJAv4+KqlN/MxkCrTxObf43jrR3zNN+3Ljrj/34XuxOFwmuy3DI8Kcb43C76fvZxiTW0dTuIiSYUhn3SWTp0lnV3fF8ooGQJpsoYI01Bg9XHYRVGkm7U5REiJM59w/r4pV5jLfTySsW2jKkj63A5Wg87Fg+qgR4QYXn7GMI95xtgsNGoxtMb3DFpmyjoB9jR0zcwG2B7eeYmb4NCmxAgcqb6pKaPv3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYCPR01MB9601.jpnprd01.prod.outlook.com (2603:1096:400:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 07:39:34 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%3]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 07:39:34 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngAAINJ+AAAQwYfgAEURk5AAOy5fAACGuOZgAakjsIAAHOczMA==
Date:   Thu, 8 Jun 2023 07:39:33 +0000
Message-ID: <TYWPR01MB10082CE5542BCFCEF127CDD399050A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <647f73cf40c29_142af82942f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <647f73cf40c29_142af82942f@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-07T07:46:14Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=32343471-5c94-48c0-b1a0-0966e587040b;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: e76fcaea5aba4a8cb9d388401fa849e9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYCPR01MB9601:EE_
x-ms-office365-filtering-correlation-id: 0676837e-d64e-45fa-216c-08db67f380ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: th1pBM5rGyb2yQy3Y9PUXi/tLHvtP26WXnCDS1DnTfKQFLscl7dJjv8E94B2x1m/sOUvglHrGeftoD1Mn69qBUEqs1GFjMfWVgvCCGQ7Ti2EjZqC4lMaQ7JWLjrNnfyMiqa2pOx5Cqm+oePdQXPoQMoDLpCmkfBR5Xv4O3iQUzuv+qEB5vlnhH0aeJUe7TOmJI2WkQ0Y5Is3t9zuKDRpVAK/FD4gXRj/10RcAZxAd2PWK+MLgHTnrprYwb+AARefEtgSvbGxsTuIdQkmKwbmnBdcWHFkda8TQy+Ok1XISrqz6FPPdMCruV2lQOVwscrkX+h/ExDL+8rSipYZPlA6HEgLq8yXIqFaHaw6GoN4nE+gwNlf4/imfk1uD5LQ/jI4YxijgH9nBB/eA9H4zcsnywmNzXlMJko4qWk+/7vv+abgp6BTZseCFHQBL0ZYtIYHFI/Qd6s9M53EwB8/i5Alz4YoTFHOVBuSHEuSWOona7nnLxd1bbCDFIkgkoh13bBgRR+veq+tcIQiFaAUQRtNYxu9Yz6QQhyPP0PmK/jPEMH9PKyhS/uNi9x1BZ/oZ1opnXyBTQfh7Wv+qs/3zWsrhOXW6C8mRHtx4a4Pv+vJbCxROX/pSe3U98GFtjus7gkANpSIY6yHedDOxt0qjMCROA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(1590799018)(186003)(83380400001)(478600001)(71200400001)(38070700005)(6506007)(9686003)(26005)(55016003)(1580799015)(8936002)(86362001)(66556008)(316002)(122000001)(66476007)(64756008)(76116006)(82960400001)(85182001)(7696005)(66446008)(66946007)(5660300002)(2906002)(52536014)(41300700001)(8676002)(38100700002)(33656002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MW9PRUQvcEpFVUpzbDFLVlVPb2JPTGRTOHZWajFnVnRaK0E3ZmN2RWVi?=
 =?iso-2022-jp?B?VkxYdkRiWnJEQ091dEw1bEQ2YS8wcmxhalJ3QzlkaVZpZWJRTDRCNlRh?=
 =?iso-2022-jp?B?aGVzSE9PRDdZZWFuYTJnbkZGTFhkeVc4eDRRVTBaZHJHUG84OXVBT2c3?=
 =?iso-2022-jp?B?c1ZvVStnSGErVWNsRkwrRnFkeW1CYmk4M2drS1dSdDIxRVhYMEExbzhB?=
 =?iso-2022-jp?B?dW1QcjBQQ2ZqN2h4M1FhZWltQ3BNL2ZsODJSUzJqRnhGRWxMclh6ZzY3?=
 =?iso-2022-jp?B?TmwraGJpTHJDemh4azJMOFNLN01HVTJyVnUvSVVCV1RSSGEzTjgrNEhr?=
 =?iso-2022-jp?B?ckF5TTJrQU5zY1dROVNNdDBhaVdhUG55V25kZGV4Mkc1ZzFnKzd3bG5M?=
 =?iso-2022-jp?B?REVWTmxRcUkwYmxFMS9uWmNtL01RUjh0ZmQxVlBOMWY0K3EyOFRQV2ZH?=
 =?iso-2022-jp?B?NHNvLy85UmRFeWhyOUltTHpKR2lQZEF5NzM3ODFSS2JPMTdtMnh4cEt1?=
 =?iso-2022-jp?B?OWNTVDdLb2lTbHE3Ny9iOFdQMS9Ea2c2VnM3VG5obkZUZnlPNEtLUWln?=
 =?iso-2022-jp?B?QmZrbzlNRG52SVZrTjFBSEhMUklWZGVZSFFHa2ZWdm9RUmw3QnNoTW1q?=
 =?iso-2022-jp?B?cFcxYWQ0VDBqOW1oNmIwMTMrcEFXZWprVU1GZy9VZWtyR05jNnQ1L3Fl?=
 =?iso-2022-jp?B?YWUrSWlSeUphNSszZ3dIUkhqODJDcFh4ejA1R096Y3RPcVRzR29EZVRH?=
 =?iso-2022-jp?B?TUg0R3UrNmhFWVo4RzhiTHlOd1kvRHQrVEc4T0E0VmE3dXcvaWsyNEhh?=
 =?iso-2022-jp?B?cDhoeGZ6T0JKWlRJOG1nTUxCamtWcHdPSlFhNi9CWE9CWkwyVVJIRjRE?=
 =?iso-2022-jp?B?aWV2YUZnWmc1eEw5YnhaL3BQaklHdlliM3JhU3V5SWlnSzR6eWQra2Q4?=
 =?iso-2022-jp?B?UllCNGtOaXdFbENQcXlzcloxQ29leDJQL1dOYXA2ajM1OXA1NTVqNjA2?=
 =?iso-2022-jp?B?eXZ3TEF1WG5CTTF3cUkzS0FuVklOemt5elRnQjQ3UXZGRDZnYkZZQ1Zp?=
 =?iso-2022-jp?B?REhqeGpTMzd3d3REenhxOFdjeU9kVkhJVWlIaXJYYU0zWjlJNUZNekg2?=
 =?iso-2022-jp?B?M29teEVzQUVTemJyRVNnblBzaldCYk85akRYTVJvaXFqcG1ha0JjZ2o1?=
 =?iso-2022-jp?B?TlpZV1NOUXlBOFFQdTJtSTl4QlVSSjg1SW8wa3p2WnhYQTZqYW1NTUtG?=
 =?iso-2022-jp?B?QmNmTVBhTWtIL0ZiR1YrMkF6S3RidmQ4OUczSytrTDdIcDNGTHp6clZT?=
 =?iso-2022-jp?B?ckN4cFI5OFRESjQzMXA0V3hpdi94RHZlYjBSQUNFdkNhNzRwdmd0SmZv?=
 =?iso-2022-jp?B?MUl0TVkwd3QvSHpZYWJBS0JRMmVmUTlxanJ4djV3aG8reis2dzkxZjZh?=
 =?iso-2022-jp?B?NC9ZNUJ3UmFyK1Jka2lPVzJJTmdQRUtQM1JlaHcyQ1UrQ084cWhld0Vu?=
 =?iso-2022-jp?B?dnczT1I3eGJCemlsblA2TVI2ZkFtSDJ0djJlVW80R1FtUDdnY2NSc3gz?=
 =?iso-2022-jp?B?aTlUeHQxQi9LNk83V0NmOVo1dFRXY0IreHZSVGFXRnM1bE9wczA5YWdE?=
 =?iso-2022-jp?B?NzlzRHJpUnhWa3Qva0V5eDdUSmlyMU5qYjhndllvYVh0b2ZPUUhta3VD?=
 =?iso-2022-jp?B?Y0EvNVQ0clFkaGhaTEcxOEtWMHdMeU9sK2RyRHJUQVdOWnB6RXBQWmtW?=
 =?iso-2022-jp?B?RGx1U3VjTHEzRk00SmhjVElqZnFoRUcxZGc3eDdPRFp0dEs0U01ZS2FE?=
 =?iso-2022-jp?B?UG5oZjdYTExzRWdOYmRMaVppWE9uc2lLZ0U5YkNtSlZ6Nll0dEcrc2xN?=
 =?iso-2022-jp?B?WUVaUmdoQnhhS0F4eUFtVXltQ2JTVnhXYVlnblFKZklWeTRnNUhWcG9y?=
 =?iso-2022-jp?B?dTBOem1KcG5La0JaM05OMVc1RG5CL2FGVmh0T1BIb1Z4d29NNzZXV0F5?=
 =?iso-2022-jp?B?dDhBQTcveFpzSFJ5WVhjLzQxQlNML1hwVG5ZQjRUeDAvdjFHTXlrVlJU?=
 =?iso-2022-jp?B?OWtVdHVWamJLNjZmYW9ieS83K0tUK1k1L1lMWHVSeE5mbmVQUnhCZ3Z2?=
 =?iso-2022-jp?B?V0NHMktHV0hlbXoydGIyT2hTOHRBTTZIRjF4a2IwZlEyTCtMOE5XOU9G?=
 =?iso-2022-jp?B?M1dPd0MzZzJhV296S2NFTFlzeTlyeGhDUFg2aWJZaGZLK2JIbE5vU1ZI?=
 =?iso-2022-jp?B?WDQ1bGJxNDZLb1NUSlQ3NHpLU09lcVRVT0RoV3VJMU1haWp0WlRPQzBK?=
 =?iso-2022-jp?B?Kzlzdw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fk2Z1wqfbH5uCq1W7s+EAfTo6e549Sza+oFzdXr9x9HnuF0cQ077hoYpD0Qp2hKaYXLISdcjIZ1BenJMJuvHiX8GCAiWdjgB1vbTbJ90z4m2btUVY5vx8R4h22cScU2uFVPmSwwWYNEZ9FyXowpOg24JjOgosksmhILVz7tjRXbsbv8PaYz34oBjeBnlnehL0htUQh1EkB9iMhhJGivlI7H42NKi94FZYqdtPilrOKyLnBQgE6pI6mIm/j32RhzhjRrc1cPu7zNbVSFmzfpHEG1bs6/yUbvyUOQdT7DK58JUllP9lh0/QrGkH5+2GpSrezqK9640Vsg6oLopHnsM7CzbRSyk9vlXBoFX/u9k0aDSXavthuJ2sSt/ZriDBlcERoyGqpmx8NYoraPREZ0+kt89bOgR3sfjAbNPlEAGL5rPpcPkwXHrJnfkOEHMkcmsXE0VJC5120PhWgIPGuudUc5MexfOZ0pbkegcm1lWCGKIaak45Qd8ybr+/JKy4CvTvIFrzdxoFkraEx6o9GWLweGcMI5q/qAos0iP9gqRKE93DR67CclMd2AAe1YdSJNlope5USGZE7009+5XhRZvncowjRPSeZSI/jMV3CctuAFmduB5ZGcr6c4qcEBA/iyCmex9UnR/qCsL1X2tNBmbOpwkPlAWJAQ8lglQDRnM10XbndG6FY8ug+6GsP8yozY0BBRW/XiXDx78YsS8QYZFgFad4XpjRrnktPeS+0M4bJHDIPu9GOmbCbfqgjplUI8jx9atzfkulRDZahkmwdVIy3RUslovfcgVyy/SJo0UR6U=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0676837e-d64e-45fa-216c-08db67f380ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:39:34.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T09IALhEK0itDCUbcbilKgeO7I+AJNHm/vZCBkTxAiSw2/un9PFb4n1j4R1k4uzn614XmeExrmA/5ri1ggPKsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9601
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > Ah, sorry... My description of question was not good.
> > I understand that PCIe hotremove is not suitable for trigger of CXL mem=
ory.
> >
> > What I would like to ask is "Are there any agent or daemon which gets
> > a hotremove request from outside of server and executes offline and
> > cxl disable region without users operation?"
> > I suppose such memory pool manager (or others) would like to ask the
> > agent to execute such operation.
> > (Probably, the agent need to get the request by REST API.)
>=20
> No, there's no coordination between the kernel and userspace when the
> attention button is pressed. So any coordinated removal must be handled
> before the removal is attempted. I think it would be useful to have a mod=
e of
> operation where pressing the attention button just notifies userspace and=
 it
> handles the coordinated shutdown of the device.
>=20
> If the question is having a management API to trigger removal I am not aw=
are of
> any work in this space.

Hmmmm, my question is NOT about attention button now.=20
(I noticed that my quote of previous mail may be not good. Sorry).
I would like to confirm what component/method is still necessary for memory=
 pool.

I imagine that there is(will be) a total memory pool manager which manages
a lot of Linux systems on each servers which have CXL memory.
And I think that an agent/daemon will be necessary in each Linux system to =
hotplug operation
like offline/online memory blocks, and/or requesting configuration of Dynam=
ic Capacity Device=20
to a Fabric Manager.
I guess such agent/daemon is not created yet for memory pool feature.

Here is my current understanding of an example of steps for memory pool.=20
This does not include attention button, and use DCD.

1) The pool manager will request hot remove to a daemon in a Linux system b=
y REST API, ssl, or somekind of
   network interface.
2) Then the daemon will execute memory offline some memory blocks.
3) It will correct offlined memory blocks until requested amount, and reque=
st=20
  configuration of DCD to Fabric Manager.
4) Fabric Manager will configure Dynamic Capacity Device.
5) The memory pool manager will detect finish of its configuration somehow,=
 and request hot add to a daemon in
  another Linux system.
6) The daemon will request configuration of DCD to FM
7) The daemon will detect new area somehow and online blocks for them.

If I still misunderstand something, please let me know.

Thanks,
---
Yasunori Goto

