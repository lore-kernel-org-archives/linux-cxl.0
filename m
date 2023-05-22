Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6EBC7EE26
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 08:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjEVIHs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEVIHr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 04:07:47 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 01:07:45 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33DB0
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1684742866; x=1716278866;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o6i4rD1g0wNuhjLDGxy48M/+5Jlzxp4AelU6BVzpCGY=;
  b=yG9yU0nSgmrQHbuFAppsphuYxTZcxqGQtIpQ/dzV9Rpz8C0KSH5b+Pe1
   7AIPzLkccPtc41qcRawhxyIXhK8nOfPpaVA7AalTwlev0Cvvc7qp6uxn+
   RBysvmxmh5vaNOj6wT+qMLR39HzMyMRnNyVu3JVazZuFDgsjnkLYuUwsN
   y6y7B2bUdG8Twv4pjXrCv2wqchG9ZW8kJPc6jvhXP6P+uMZm+ckLC3hPr
   p+NhZ478xnuK2Bw7Fdzv135E/FpiSSrbtwgkoeiPnvbSgaf5i6kb5WlnC
   xxsb9r0PBGmKVe/lW0/NIxqEpT/Wz9ODc3OcswVamVBEgEpfdnCS//m/B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="87546330"
X-IronPort-AV: E=Sophos;i="6.00,183,1681138800"; 
   d="scan'208";a="87546330"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:06:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+35ANhIP6bMlC3rgaiD0/jJiseC8LaRGq0aCTmWiqeCNaiwkZpHHGouu7E87l4PwWexdqo4Hw/lYZLEkgT3+fP5i7SRLvGC0PO09U1kP8pIcMuYw6rVLId0RTt/2YNySR1FcGgEm0dmeUBK1pPl8tkbFCeiDXnggXI69h2PjLcrQP6g+nxiiwx76svVOykapbrIugqIcEhaAZbyGYt7C1qs9valY0QqBkS3APghhOu76+RJ4+R+uytZ+wdtGL+D8l/YJ9xAEqgYgYAx1f9kpX+BHO2Kwl6REvPd8z14A1R2xsytI18P/ipw4DrW6+QG/dFhkox+MF9mjmWmhRFdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEGTsAp1WK1pO3feSBIXrTdBD6l2Xog0T5HJwr0XYpY=;
 b=VYoBrxK53mhgciJgxQtGRHI+FuanBYPUxEqu+zoyfM77n5YOGshNAw4f84BWQXQyNwiMZ2FBpewFQoBkHpjJVZXTojrbIUGrFwSBWrX+grrw9k6J5IbYT7r+8CP1JC3biLBfy3iUPGKWnJ/bIvs31mX+cx7I2GYc5rvGu1Iag7HZEzZTcRoI+r8QSYCut8wYW+lsWeCmQT3QGzyTG7QonnRt99znLhpUO/HTZEuQc6Fm6hY7XSkjq2++D21s0NXvODQOJ6IpC6FWC8KpTjnepneEXgDFWF4HFmKUahih7zmSznhC84305LsbBshTNBlGCzd/9ajrFvT3q/drwqI4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYWPR01MB11362.jpnprd01.prod.outlook.com (2603:1096:400:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:06:36 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:06:35 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     'Dan Williams' <dan.j.williams@intel.com>
Subject: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpg==
Date:   Mon, 22 May 2023 08:06:35 +0000
Message-ID: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-05-22T07:56:45Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9d2fd20c-f593-407a-afe8-3e9d61b194d5;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 46c1ecca2b8f49d2aed84a188f93e0cf
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYWPR01MB11362:EE_
x-ms-office365-filtering-correlation-id: 2ad38cdf-e81f-4fcf-743f-08db5a9b769d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrZrMhW+2CUOJF13PG4Hy78q+AkA6ppO+dN/443AmLXeHdkf6f+qgMN53y1O1E1YUDYsFuCx90O1Yg/rSt8aegwczASC1LUr8WsPe164Kd80wElBGe5ilm286i/yEn7xE+f4YrmkMJhPc4J7i6M34uqVCEsF15cUCENE3C+S8LC1tTXBCln4E18snY2yghFsFTmyaRep6CUwxUA/1y3meiQU1C053LXp6qT/bqdpZczETvRBO/o8BKrXN+MKshIb1SegfjZiqBx86YSQ1fM5f58puRY1Hor+sr2IiLAwhLg3FJnyg/Kw0yNrXd2PYBR9u35rRdJcfRuRmXhe9+MHw3KszJ7YV2W7GAMwDstB4DOgBk5Vck4kDEqnub+M4sCN5HIQbRa7yo+rxR2HyzAt1BYw2h+pJ1TIi/JT76mpEIl19eg6iwXxZdIRY9vNRWchkE1zA57r5EpQjdfpxPwB43qkP5hqbG/XXH4WnRVWzTCm345eiPe173XDuuHpJDJcu27HMfklDSPy49BdebkRqWh7KW/Baz3FtrKV8I7uSjFBoVcKF5HxRKvIK94ZHv9Ot6t8+o206SNmYJN9qC/dHn/XCqwOOYP6MsKqifE5LnbqttyV5WOTWR2k945yAcpgOzvgaIDoalR+6OwY7nKzOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(1590799018)(38070700005)(122000001)(1580799015)(82960400001)(38100700002)(33656002)(86362001)(85182001)(55016003)(9686003)(52536014)(6506007)(8936002)(8676002)(2906002)(478600001)(186003)(64756008)(316002)(4326008)(6916009)(26005)(41300700001)(5660300002)(71200400001)(66446008)(66476007)(7696005)(76116006)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cXUxS3JReXRQOW8rMFNzcUZ0TjlLUGE4L3YxTDI0Z1o0TEtKRUNjY1Na?=
 =?iso-2022-jp?B?UjJISDNLS0hsL2Y0YTdUby9FWXdtbWVPK3VHWVRHZ2V6ZWUreGZqQVpF?=
 =?iso-2022-jp?B?eUQ5M2s2RVNDNmhLcTlBYysyZzR2RlJoalBXUFhEZ25laXoyQnFPa0Fy?=
 =?iso-2022-jp?B?aDczYUE0dFdYTW9hYVdXdTFIS3FLMVNKellnaFQwQk94VzllL1dKcFB4?=
 =?iso-2022-jp?B?YVRBN1BCdS9ZRFFuY0NXeDMwcFdUU2g0Ty9rcHhTcnZLdlVCdkhBQU9W?=
 =?iso-2022-jp?B?RGg2OHRPcVA0Smp6TTd4N3hpdUV3VHRnZmNTNE1iRDNJZWVHMkxnTEpE?=
 =?iso-2022-jp?B?UDNYR2pVcmppRDRKZERKbXUxbUxNdzF5c2tzUEsrV3JHcTl5b212aks0?=
 =?iso-2022-jp?B?QkFhZ2ZYdU5oUjVpZHYzTzNkRUZ1aXJTUk1qR3dNMTkvTTBiN0JhVEN6?=
 =?iso-2022-jp?B?cjI5d1psQzdwTW9leTV1bzlsMFk3cVNtNmdseG9HbXpMbW81Y0hjN2pi?=
 =?iso-2022-jp?B?STZMdHA2aU1KVkFkc0lSTm4zVnFCSTlldmtvVzVVaGZJM05CTEYzRlN2?=
 =?iso-2022-jp?B?VWpIaGtRaDFvVjBwU0oxcmltK0hhaGFlSzJyRExpYkJncENROGxqbUdh?=
 =?iso-2022-jp?B?MjdqY1haQnppd2I4a1RRUFlaWFZEQk1abmJ6MUJTYThXSy8xdzQ3UDZy?=
 =?iso-2022-jp?B?Q2w4cjd3ZTJKY3dOUzh5dDd1WWVBQkZLaWVLdCtVczZ6SzVUMHI5MWFx?=
 =?iso-2022-jp?B?ZkJKNzhOKy8rWFJsaUlVLzNXazg4OVlnc21uOE1rOUNhR0tQdkVzYm1U?=
 =?iso-2022-jp?B?a1NpRzN0YThSemxkN2VhTFJuaFJmSHZLb2RUNkpxajhUaEc0UzJZNHZ5?=
 =?iso-2022-jp?B?Rkx5d1dOYnUxU255aVdRYkQ4SGwvRThFdGdRYncxRGFQT2xZZGhWaiti?=
 =?iso-2022-jp?B?MWIxbmNXaGVpQmpZZ1B3Q2EzTnVYZVo5THRTeWR1eDVEd1F0RExoQk5h?=
 =?iso-2022-jp?B?MFlMVTFTQW11R3FRRnZJK0ptc2NSM2ZlTHZOYkpMRnJNa2tVOERlRzdz?=
 =?iso-2022-jp?B?elZHdWNhUmd1RU93OGluUzV1WllFNVJIV3NTNHBGc2IzTmhTcGpKV2ZC?=
 =?iso-2022-jp?B?K2swQTM3Q05ScDhkUlBnempmRUNEUENtOGFNQitVV3lXaXJVckxSNHE1?=
 =?iso-2022-jp?B?NUpMWkxwOThSUHh3WjFtMVFMb21YTHp5WjFHQnBCL0NMNE5oMmVIcENa?=
 =?iso-2022-jp?B?Wk9PVUdGRnVOZFRscThqbVdmZW16cTBPUm5TbWcyc2lRUGN4ZlFOSEJl?=
 =?iso-2022-jp?B?djR5WkhLaS8yU2lxVm1KbWM3aWZSR2JVM21kemkvNFZha01mWGNWTVhY?=
 =?iso-2022-jp?B?dGNvWmx0alNZWHJIcWZrenpKdnk2dE1ydVpjdFhnR09HSjg4YUpTeUNB?=
 =?iso-2022-jp?B?U01VOXU4MkJrdUJubjI4NzZvQlArMmdJOWsvWDVQTnRXYXVSTjloVnZl?=
 =?iso-2022-jp?B?TEl1TjRTb2p5N0ZEaGxkYk5VSWE2UnBWcklJM2NyUXhYd2dYUFJ2aVJZ?=
 =?iso-2022-jp?B?cDM4akYvWUpiL2g3cWN3SmFNQUJaOTVzSWxMaFNRWkkveGFZTU9GSmVD?=
 =?iso-2022-jp?B?ODdiS0tLbjU0aTBxbit1Y21kTEVmMUhEalpNeTNSS3p1ZWd4TGxCR0Zx?=
 =?iso-2022-jp?B?clQ4UkdQeDl0RVUydWg2dHhTVnMzOTdlcTZmeS9zL1BWNUc0SHl1SmFy?=
 =?iso-2022-jp?B?TlAvZFJHQnMzSnBZNFA2TklmT0xqWld4bFBCQTg4ci9iUmZZNkUyR1ZB?=
 =?iso-2022-jp?B?UHBzdisrRkVNYkdWOGVPY25Xa0ZRY0FOcjc0OUxYZEt6Y3RKSnFGUWZ2?=
 =?iso-2022-jp?B?dFRWQnBRbXFRM1BENmRSTmRWREVUeTRJUkFXakhadWowRU0wTWFBN3RH?=
 =?iso-2022-jp?B?ZUw2QTVmUlhkaEFmWTFUOWhld1h6cVcxcDVqQU1GamV1bTJyOFI1TVE3?=
 =?iso-2022-jp?B?eXpiS1U0TkM5ZnhlaEhsUUt0RkVuUFpsUUFwOGVpcTQ1U2RteVNUWGFw?=
 =?iso-2022-jp?B?czNCWTlXbjZRNm9penNnYWVkcXp4Z1ZmSU9TNHhCQlJ6aGtnVzdGblZG?=
 =?iso-2022-jp?B?b1JVOGNTOTIwNG1TbmpYSkhwdWg2eVYrUHhDZXp1eXM4R2tnQ0xheGdZ?=
 =?iso-2022-jp?B?M0ZjYUE1b2FGSlhuMTd0TWV6VWJLZnNKUndDczh3dldHcGZEbURTNlg4?=
 =?iso-2022-jp?B?NW9odm5FdXVPa0RKbS9hWEY0bnM2UjdZcCszK1FiQVVmNStMeVV3OFBN?=
 =?iso-2022-jp?B?Mk96SQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6khUq8BhEHp3rrDBJp3RdjiLkSD8PivWQdBo6vk/Ho1LcJFCP46KIqrLR82EWVyAYvBmnS98JJvKTN91VYHtyeR/tKMC8BWSqbPtEpWVmlwnSnDbeJ0uubE5YpChlzOoxknUoM5F9XTwxq/0hGG8VOEqya3Ywr1MxqFkcDhJ0T79LYwwmXr/dHIcs72yGY045RAcH2Dh+5TnuPjlQ+d+Q7EG4st/jl7OVYU0I8IW/nH1esMoH8SIMict/7x3NCnV4yGTIJ7+yAFzECafpoqccIXXMhihFS64MDix1pXhhdrYUT/E9TQvV91IcVX207SgvhnpLr0LM7TgSjsT8XbDyzG4/DC/dOratuF4psJMpc7j2CIL4RB07s7yAvAx8z/y58Pqslt49k1QjLJN4xJgJF5vGx2Y1YSEZdHIOlWHqcBL6xaqnklQuS1yFHqOY2oEMH82j3Kfj7OWue2oKEYqRFQPV0qBzpBYIUO/fr0sg8mD46QTMWLQoTK/QQ85BY3bcgwQj1CwFr/QSEy3STo+bukY9F+32Xg+T1mMMpRrkFvTX4m/3H3WkhrJudf1q3nho3AoiQZm1CT9YaNJoOXE1lxoFcrHI4USvoA+ckscHA04H6z7oIn6PRoPdHtDOk5a9UxsbAAiKfdhEiwc5QI0dT5gGCyEDLZSw5Bd+N9lJ6W/D46h43yFstbHZeQOzzqICX0iPkoJ7kTrT98FSfIi/eui/fUtCqL9w/X7JaPFoiyvSdzjIDWc8IxPFCGZwWbNXxdC8/6edHGpfmb37aEzfKFxmtZzVLC/VWe7Gt7FBzE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad38cdf-e81f-4fcf-743f-08db5a9b769d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 08:06:35.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Odnb/EMwFIfqOPjNbfZu59EUKbsUh323dJJhc31+NTBfW50t1bb9fehgW+swf81khGyDEjbDh8BMSmymh3rr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11362
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I have some questions about CXL device hotplug (especially type 3 memory de=
vice).

Though my team members still need to work for a remain issue of Filesystem-=
DAX,
or RDMA for persistent memory yet, I would like to move some of them for
CXL type 3 memory device after finish the above works.
This is preparation for it. I would like to confirm current status of CXL
type 3 memory hotplug.

Q1) Can PCIe hotplug driver detect and call CXL driver?

    CXL specification says as follows
    "9.9 Hot-Plug"
    "CXL leverages PCIe Hot-plug model and Hot-plug elements as defined in =
PCIe
    BaseSpecification and the applicable form-factor specifications."

    At a glance, PCIe hotplug driver seems to be able to detect any PCIe
    hotpluged device, and call its suitable probe/attach function. But I'm =
new
    around here, and  I'm not sure it can actually call the suitable CXL dr=
iver.

    Can PCIe hotplug driver recognize a CXL device and call its driver?

Q2) Can QEMU/KVM emulate CXL device hotplug?

   I heard that QEMU/KVM has PCIe device hotplug emulation, but I'm not sur=
e
   it can hotplug CXL device.

Q3) After called CXL driver and detected a CXL type 3 memory device,
    what sequence is/will be executed?

    IIRC, kernel created /sys/devices/system/memory/memoryNNN directories w=
hen
    memory device is recognized. Then, online operation was executed by=20
    a user or an application.
   =20
    However, CXL specification seems to require more configuration like
    interleave, region, and namespace by Fabric Manager (cxl command?)
    after device detection before memory online.

    So, my understanding is that the above configuration must be executed
    after device detection, and before memory online. Is it correct?

Q4) Current CXL drivers/tools support Hot-removal request from PCIe?

    CXL specification says "In a managed Hot-Remove flow, software is
    notified of a hot removal request."

    I think that CXL drivers/tools need to find which sections belongs to t=
he
    requested device, and execute offline them at least. In addition,
    Fabric Manager may need to prepare removing the device due to configura=
tion
    change.

    Does current CXL drivers/tools can execute them?
    Otherwise, does it need to be implemented yet?

Q5) How CXL driver treat region/namespace size against section size?
    Current x86-64 section size can be 2Gbyte, but CXL region size may be
    able to smaller than it.=20

Thanks,
Yasunori Goto

