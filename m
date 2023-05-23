Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E13C7EE2A
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjEWIf2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjEWIdq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 04:33:46 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB2E0
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1684830694; x=1716366694;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=icAqU1yWhGtPpZczt7hHpWSqX3zWOPup+nLsBZJgpfw=;
  b=jmfDmt9WRkOJ5FPhZF4Goju6qepeZ30hMUH6rKX5kg1dvR7AWSHsknzu
   il+bGq6kDzBIF6HUZkJ/DySly5bgpOehFyKeIFH3HVUqKdDZHW61WGh0F
   qTsIJ7uqyFrCjVXXaqbbqjvXH2J/T0p/ZGmBjIZI6LRJQjDg6xao+W69d
   eovwWfU2+Zg7GqHrgnIpAD0er0K94wduiyudBwjQhgAwTPjVh+Ysx8q+D
   piJY83SWsKX0Wt036JVFOPKh16YXqm6qIJCqFMN0d5pYYmgPzyofEFocB
   pMRDFtIC62/ML4ctbRfnFzkRFFW4IZHD2oRZUKIi6yy6YBC7e5Z/0OMIS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="84991567"
X-IronPort-AV: E=Sophos;i="6.00,185,1681138800"; 
   d="scan'208";a="84991567"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 17:31:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdlQdGp7XVsNLqZABAL70nL9fBZeCnTIkjJzK1vlto93R+jjgn0VRuDha9OBL0HtV5YzHlsCMQiqiOILKmUl/wx8N/88w4jGrar06WAUVlr84fwfFocuinMFIsx4GenZRYc2QV/jp6V6UMAWvyY+W/efyA/+D2iYCcj9pdLRaCexilmQjFBqMnrbpZrGVUzMmMk50d1WXZBnDHlYccf+H3yDYV696IpclxzA5KbEiLdLd8NFgI5vMKQe9rDd2sjqbzZ2MHFNJQ1Xvao3PAVgwqns2UXHFqvBJSEPHU/4/mkHTrNldK2KN1Zt0XpnmnlNkGBuWj89up4huRbYlasJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b0tRntiJrg1TtwOJANZo2h7zDlf8fcMr7c4wURAIcQ=;
 b=lZscwPVZyan3BfrEajoWMFehMIlu0mcl6Ehgk1j5ch6WCze7QNDI/qVZGmT+xUpEsSOZDFtK7ku7tXnTusZQgGPOOmMqcpHRs/M46yqxtnK7aRP9Nn3YWdws6G46feq3slluYzvsy3YfUuaV7AUNviFSKkInZp7oqIlRnuHg5ChAEZ3jCdTFnPc8hrjyNhn+Tf5Kwonh0wBOdT/pLwmKa5nEaLzrgl3zNlv2X9N9BlRv5AHHighN9C2kZsjUJeKanbcelOBp5HwYPKyWrOw5QtAGtMfWhUwvhxBWeKJME6YH6MpNNG4ItqRZ7kvgTD2rfECoYvDkq0xJDj5TKZoWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYCPR01MB8208.jpnprd01.prod.outlook.com (2603:1096:400:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 08:31:27 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:31:27 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngA=
Date:   Tue, 23 May 2023 08:31:27 +0000
Message-ID: <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-05-23T01:56:18Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=5a36f7c3-cabb-4105-b71e-1958c159f868;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 47dc1071bca443cfa8b7917f82d6caeb
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYCPR01MB8208:EE_
x-ms-office365-filtering-correlation-id: 1044f241-8897-4cd6-4dce-08db5b681a1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMqCW5/vh7eO4e5il2WuX1ppMEHJ4waqlDEyIyNxKrOUEdbIGiwTqHfZrS9gx71gaq2ttS1Bn+Ej9GMmyOkCdZucmJP7TwRt2wCFm948awhZW7z/LHxpvxc8H8OCmKa0DfS8C8+1QIl7hgp6063GbZERdp51c4fGwrQK6iA1yGXFQyxF7PvUS3+BrgRknH66mLyTeD6yj36u43D5xH+/qUMSKZQ4xt+cS68vip2PbztQV57BseLVa42I2z3YCHsVMEEqW9ly0Z9mr/AflMan490elVIarRmrlRdSY1g9CHBdvyt28UNeAuaiIt2yGMIl0DScSiMk9/zllKm6Zr1q+RznRci6CjGPt//ZInBEOWURLAqOtYNT0EgKLloOsJ92NeW9IJt3m5dEDkw0BFTIJxjQ49x9GNR76uCwwYups511B/IgpFWG8DOX0j8ag1uDW+4/57ZfqLLyfhj80peMGbpkbbzYzsPATShObNWsLvR/TULg7k4W7CWmmzNwWuQlhUSNrBHVGQv7D3u8n4PRK3qubBZcbEFLfVwD2Utw7zr3g7Ato3xQG5NyYgf+NetJNx2IX31j0NGf7/DbEK9GzwMAW863L9a4TrU/obFf1RaCS91uy3562iKF0fmjIYrTLAdUIO0BcIcv34UrSsfjRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(1590799018)(451199021)(83380400001)(1580799015)(71200400001)(8936002)(55016003)(52536014)(8676002)(5660300002)(33656002)(38070700005)(41300700001)(122000001)(2906002)(85182001)(478600001)(86362001)(110136005)(9686003)(82960400001)(38100700002)(186003)(26005)(6506007)(64756008)(66446008)(7696005)(316002)(66556008)(76116006)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OFRNOHoyMXovanRIeVh1UWdXYVVPcUMxaUMxWDdvRXZyc1cxWHk3QXVn?=
 =?iso-2022-jp?B?ZElCd2JnZzMrcS9mYVNUQ0FjQzExcGh3VnloWFBNRWZvVld0R25DNWhs?=
 =?iso-2022-jp?B?VHN3SFFTWVNhSVNkdzlVUEFXM2dmeWZjQU9WNHUvYUY2c0wxRCt3ZG4y?=
 =?iso-2022-jp?B?M0RZOWY1a2l3VEg3SzBZV2pVYnoyV1ZXY09sWklLcVJKSVg2TGFjRzNY?=
 =?iso-2022-jp?B?UDFXcW0yZk5HNFR6aE42bGJKNnlEOTdZeWNTWlVvTFlBeW1aRndXRWM5?=
 =?iso-2022-jp?B?bFM2U0VPRGc5djZLWHNvamphL1NqWTRKbUs4OERvNE94SFFFM21POExp?=
 =?iso-2022-jp?B?K0ZBQWUrU0Fwd01WVWlJTEdLSkJkRHZQaHh0Qnh0SFBQaHlQbXJWbVN1?=
 =?iso-2022-jp?B?S0diUUdrQkZqYzRFRWxwckt4citQa2xwQVZyVWY4NjBTQ1AveEtjRmhk?=
 =?iso-2022-jp?B?MC82TmRGRTRjZjJ5L2c0NzlVSTd0QlhLWnRJNXR5L01hay9yUVhna0VK?=
 =?iso-2022-jp?B?UjQxQ2VRWUdENldnR21EQTV6VHZoMXlXSjN4eTRVdHh5UHdZUzRmTDZu?=
 =?iso-2022-jp?B?QzhkSkpWTlZhMmxISjFnOXpKMFBtSTBHWmlpNFhLUGNJZXlOWHU0MkQr?=
 =?iso-2022-jp?B?TFEyNHlVS1lhMU1ueG1HWlJkYlFyZDFPaVlGQjBGV1BoU3RGNWhLSTE1?=
 =?iso-2022-jp?B?Wk13eThUa0JReHlDRkw0WlFFbHUybTNZNHhBbFZtdjViSlVUT2R5Unlo?=
 =?iso-2022-jp?B?YzlWNXFmQWZkTGt4aE1lUXVuM0hLZzlBS1Z1b0hFTHdYT29iZXlmOGxL?=
 =?iso-2022-jp?B?eUtpSkdOaEdzTWZ6M3BMOEZ3ZTFRWjJjdzYyQ3Y3RDdlQk9XZi9wY05k?=
 =?iso-2022-jp?B?ZVh2Tm1MbXZhU0xOMU5zZWV1aXlYemluekhIV0NnOVJORG41R2pHdWdL?=
 =?iso-2022-jp?B?YWM1MzZnRVZZd2ZObDRSUllaaU4xZVZlZEMzV3BhQlZaSDVoc1lkNDlL?=
 =?iso-2022-jp?B?WmtCaC9TTEE4SWdxelQrOVZ6bDFoVTdtSkNzSG9VT3hIKzFEd0IzNFli?=
 =?iso-2022-jp?B?bFlyWUxWdWZqVjd4ZkFFRDJEWEVEWmpYSExqY2g2eFY5K2NSVnp2TjVl?=
 =?iso-2022-jp?B?cWlvWHBxbXFyKzJycjdQemhqamh6b0dzSk5EdHZzV1VDbTdQMmZPUWRa?=
 =?iso-2022-jp?B?Tkw5ZnN1ei82QmdXMlJYZnVvS28zTmw2VUxHVFJ4MjUyZ2VwZlQ1UFd0?=
 =?iso-2022-jp?B?azgrd1lCd3Jjem8zS2xrTENjYXhLR1JhV0c3ckF2aTRVbitRZ0ZMSHJH?=
 =?iso-2022-jp?B?ejBYUWFwOWVuSFYwKzlQQ0tUOWNuSDhoQ0VvS2gvVW92bGMzbFRTZnMz?=
 =?iso-2022-jp?B?bGNZcjhnTnFreGtVOUFMZ1ZBZVZTcGllUno2eHczRjhQYmt5Q05XZHJW?=
 =?iso-2022-jp?B?dTdCRXpDc3hXTDA1MmVDdnFJTE5oY1ZEZUVLaDdpK1h0NXJRMzVIajFL?=
 =?iso-2022-jp?B?WERzK2NDc3oyTkRaS3RvZ0J4Z3dmcFdvRldsWEdmSCtHWGdTRGdTZzVV?=
 =?iso-2022-jp?B?emphOEt5bk1YeEtvajdxS0pRbDlqWkUxcUtVdkRxN0JVazJVYVMvcXND?=
 =?iso-2022-jp?B?WTRCcGVDTjZKbzJseEpWdnJhUzQ1amtZZTFJZXpLaEZpQ2d1bnpHZmFS?=
 =?iso-2022-jp?B?dWNyUTdaajBhMWJLL3RpOCtDMXhiSUQyN2tPbnNJUEFLOVNNUFNpdmNq?=
 =?iso-2022-jp?B?a1czNGd0MXFIMVJCUzFZaDZ0NTUrV3ZUVVFQZEMwMkVHWldMQndEeHBt?=
 =?iso-2022-jp?B?ckJjK2pPVm51Q3RTNU93ZWNGc0hlTUZ1V0dCWnRteklMdDl6VUlML1BR?=
 =?iso-2022-jp?B?RklycExWSEVqSnNDNy9CTWl3MDlWZm4ybm9XOEFqNncyQmVXaHJqREU0?=
 =?iso-2022-jp?B?SkZYSmdxWE9EQ3U4SjE1Zmk3Ti9RT2t6dklMS2JlV1BaQ0hqTDBDbzE4?=
 =?iso-2022-jp?B?ZzFia1FOUFk2L3FSVTdCeXhCRW1DTDM2UVV0MVNNdk5zMXl4elN6SW1u?=
 =?iso-2022-jp?B?dVRkY1M2N1poc3BPUUFLMDcvN2dsaUgrSWlKZE5hb1hVR2hrZ1VJNWQx?=
 =?iso-2022-jp?B?aFNNbHpBL2V6RW5FSnFTQXNNeHNvV05yZGtzZGp3dzJRUTBQK1p5RWRQ?=
 =?iso-2022-jp?B?Y3BUaCt2cUZuZ3BqdHV4YitvTkt4YVA1SmZVdk1RS3RGdVZGV1RkbnVQ?=
 =?iso-2022-jp?B?dTNoT2UwR3VLY2dYVmhVcTQ3QnEvNG9kUFRXb1pDY0hQRHdHTGxiQ1Ju?=
 =?iso-2022-jp?B?R2g5Rg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TKquVOuIw61ufwHXE6QpwT2/GMKQ8ZBG4xN2T3Qziit/d6CHPSSdIxlSqJF/Z8mpt1KxXgiwdC/SQoElXUA5OS4ss4MeZl5IFUM9mDLAQAWUvSmHL0BjDG36EaPYadhvvAWJUNgpT7ugXDbx9+DfH18WJTySe9c024sZfx2iFqFUDlrN8ZAB/rp+vRE8zQx/pegj55uksq2TtkNFeSXiG+3PPP1ZXruuVLY+x8qAUVaHi2HtCUcKoPDvB+p9uIIwY2Y2ebjGv4ZiIFNYImc9OIjT/jybSWekYQmehujcuEwCeb9wgL8zXa49p6v8xob9QU9yAEcOxmhip1xeChj1RiLYdm9dLAIll/nThL5bJySmMHmpwBHRUJ35jlArJ9PSNQsIqM49v7sfEaeD3B+vLo1DuYNNruArfDUaQcc4YwN4NhbC0KFr+4SHkFv6FxiEk45b58MUba1uWzbvRGW+OuXZX4fYbs0W+9qsBvwle4qxYvW1c0K/eXTE6mQS/z5VIzilQ60rV09MoXTMpej9SIFUsIPMxWYuOuipTtS6lgyJVrufJKnHe+1mryiQ6EZEbaGXQkfgBI0rza3hk8hylXAacpDOWxiXHSWXFqt4c3TxhFWYg1IZMRRsvAb5cG/VnOAPiFmTboqdEUetfaIQekjztH6+/eJjlA8xC59hrudywZQNggIz4PtztGS7WbpimHNe83u37kVT71YCT7/5p9pOk5Gb6Al9WBAcGFCvOX7ikV2g92u8Q/iX7A8wIYWXjHvPPI2+62Lzx8T5IiM6qoa2CekfQkWXQ1AIYeHovcw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1044f241-8897-4cd6-4dce-08db5b681a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 08:31:27.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOGj4bBEOMyOBCaBgKHtaM8VCXuufP+6HlYvsvdbaFmsgOG+vzs6y1ZTvmKoyA6nJ4WRiRNzyQbhp9bY/wkdhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8208
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Thank you for your answer!
Its progress seems to be better than I thought.

I would like to ask more questions.

> Yasunori Gotou (Fujitsu) wrote:
> > Hello,
> >
> > I have some questions about CXL device hotplug (especially type 3 memor=
y
> device).
> >
> > Though my team members still need to work for a remain issue of
> > Filesystem-DAX, or RDMA for persistent memory yet, I would like to
> > move some of them for CXL type 3 memory device after finish the above
> works.
> > This is preparation for it. I would like to confirm current status of
> > CXL type 3 memory hotplug.
> >
> > Q1) Can PCIe hotplug driver detect and call CXL driver?
> >
> >     CXL specification says as follows
> >     "9.9 Hot-Plug"
> >     "CXL leverages PCIe Hot-plug model and Hot-plug elements as defined
> in PCIe
> >     BaseSpecification and the applicable form-factor specifications."
> >
> >     At a glance, PCIe hotplug driver seems to be able to detect any PCI=
e
> >     hotpluged device, and call its suitable probe/attach function. But =
I'm
> new
> >     around here, and  I'm not sure it can actually call the suitable CX=
L
> driver.
> >
> >     Can PCIe hotplug driver recognize a CXL device and call its driver?
>=20
> Yes.
>=20
> The cxl_pci driver (drivers/cxl/pci.c) is just a typical PCI driver as fa=
r as the PCI
> hotplug driver is concerned. So add/remove events of a CXL card get turne=
d
> into probe()/remove() events on the driver.

Sounds good!

> >
> > Q2) Can QEMU/KVM emulate CXL device hotplug?
> >
> >    I heard that QEMU/KVM has PCIe device hotplug emulation, but I'm not
> sure
> >    it can hotplug CXL device.
>=20
> It can,

Ok, then, are there any test-set for CXL device hotplug with QEMU/KVM emula=
tion?
It will be more helpful when actual CXL memory device will be released.


> but as far as the driver is concerned you can achieve the same
> by:
>=20
> echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind
>=20
> ...that exercises the same software flows as physical unplug.

Ok. I see.

> >
> > Q3) After called CXL driver and detected a CXL type 3 memory device,
> >     what sequence is/will be executed?
> >
> >     IIRC, kernel created /sys/devices/system/memory/memoryNNN
> directories when
> >     memory device is recognized. Then, online operation was executed by
> >     a user or an application.
> >
> >     However, CXL specification seems to require more configuration like
> >     interleave, region, and namespace by Fabric Manager (cxl command?)
> >     after device detection before memory online.
> >
> >     So, my understanding is that the above configuration must be execut=
ed
> >     after device detection, and before memory online. Is it correct?
>=20
> Correct, after the device is added and the driver attaches there is still=
 a step
> needed to configure a CXL region.
>=20
> For now that step is to manually run:
>=20
> cxl create-region
>=20
> ...later we might consider some udev rules to automatically assemble regi=
ons
> from discovered capacity.

Hmm, I suppose 2 types of udev rules may be necessary.
The first one is for notify new CXL device is detected, and cxl-command ass=
emble=20
a region automatically.
The second one is for notify region is configured, online is execute for ea=
ch
memory block on the region by the notification, and rollback when one of th=
e block
fails hotadd If necessary.

>=20
> > Q4) Current CXL drivers/tools support Hot-removal request from PCIe?
> >
> >     CXL specification says "In a managed Hot-Remove flow, software is
> >     notified of a hot removal request."
>=20
> Currently there is a requirement that:
>=20
> cxl disable-memdev
>=20
> ...is run before the device can be removed. There is no warning from the =
PCI
> hotplug driver. Which means that if end user does the wrong sequence they
> can crash the kernel / remove memory that may still be in active use.

Ok.
Though "Surprising remove" is not guaranteed by specification, I think
"managed hot-removed flow" should be realized.
I'll chase more what should we do about it.


>=20
> >     I think that CXL drivers/tools need to find which sections belongs =
to the
> >     requested device, and execute offline them at least. In addition,
> >     Fabric Manager may need to prepare removing the device due to
> configuration
> >     change.
> >
> >     Does current CXL drivers/tools can execute them?
> >     Otherwise, does it need to be implemented yet?
>=20
> Currently the 'cxl disable-memdev' command is not smart about determining
> when the device is in active use it just claims that it is always in use.=
 That is in
> progress to be improved.

Ok. I see.

>=20
> > Q5) How CXL driver treat region/namespace size against section size?
> >     Current x86-64 section size can be 2Gbyte, but CXL region size may =
be
> >     able to smaller than it.
>=20
> The section size is still 128MB, the hotplug memory block size is what ex=
pands
> to 2GB. That size limits what can be onlined via the dax_kmem driver.

Oops.=20
OK, I understand I should change my word "section" to "hotplug memory block=
".

One of the background of this question is "rollback".
"If memory hotadd or hotremove for a memory block fails, is rollback availa=
ble?".

If a block hotadd sequence fails in the device for some reasons, its user w=
ants to remove
the device for the moment, and may want to retry hotadd again or try other =
device.
To achieve it, already onlined blocks before failed block should be offline=
d again.

If a block hotremove sequence fails in the device, its user would like to k=
eep the device
online to postpone replacing it or select other device for device pooling. =
(vice vesa).
I don't find which component handle this situation.

I noticed that current users prefer online after device detection immediate=
ly, and kernel
supports it. Though it is natural for some use-case, I feel it may be obsta=
cle for rollback of
CXL device hotplug failure.

Thanks,


