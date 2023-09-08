Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9C1EE7FF2
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 13:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIHNMy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjIHNMx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 09:12:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80A19B5
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694178769; x=1725714769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ONAQku2Q+Vo77gvZ0BxhAamhEWbvM7J6PCyx4L57l8=;
  b=S6nep1p3wu4909CEbQYgQUlZHQpmeecwtx1Cw/0arRxc/su1ydS1xhyl
   7xNRz0GuOA3kgDemRsaWS2rAuy7yWZdlrRTjGrVwP9GMGNxFHdhJiohi0
   lNgEd0zVOKTv92+XfIaGQcB7w8Op19u7ZgCdCxEPBZ1y1ZEsd760yrHCw
   mfWQ4F+DfUCkWxOF2jmA6OW+iMs6T9i1/nlE8NlJln/ZydBQBLhUnQFBo
   U2GhdrFu2n730JM4nHzN6BX237ABlD7Cx+b/mGzxopE56PpB50ujm9CdM
   5y/T2i6gEN+BdKySsS1tIWsC+pzj5gdtq2i2XiO03MZZBV4E+rTw3KKhp
   A==;
X-CSE-ConnectionGUID: VmneYmmLQMemfxyKZ5JaGg==
X-CSE-MsgGUID: I5lgTqu7R0efAp2votjXYQ==
X-IronPort-AV: E=Sophos;i="6.02,237,1688400000"; 
   d="scan'208";a="243310975"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2023 21:12:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWwkM0CoWt4ewBkaaMXyc5uASrBds4x2XQpChDBqqiJriBfdaNwJ0WGezxzQG3tAEP493EhOAo+5gaC+m3oT+K7YRD8LBwrqi+AUv4KUoOgCWif8Mj7JiWI5HiSfJ3E1TTp5wPYXM6s3zC/ESuD4ZEGe8cjShu2l0ztKnE88JY3T9XdnwyKoBhtzA1AkqTOxwpI1EtzcyEWqYUzBO7H5pw01HZNB84Kp5lAwb8jXNqCg8kZQelRTLnfgrEMgMynPAqtQaXMenvLj0FtfIgbSibfIuhBXMJ4AiVzfI63eMP9qVT8asp4xBkFbYDigFsrfy5abXuxebbkY5LsUWNbApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ONAQku2Q+Vo77gvZ0BxhAamhEWbvM7J6PCyx4L57l8=;
 b=e7dSItqLpXNw/LNkRPC/z4aUTlTqIr9Mb0jOoxsAfOZxO5jRBdtXdvLw0IHPM80LsJbVTCpdxy6hTkfbc/T3RKUAaNTtd43Uxx7iJtHdbf24pVBEZoX0N9QvVZa035+X5NfC/t+gsPDPb6yO2EkZs+zAz6SOP9L74uSt/hjZ79rk9H1TvrgL/cgthVEtQ5d60Qwo8+WmTiFGCR5IPCQH1o3yOdE3I+yMNsvXWIAIJ0FwpMw1K/gSS2qMS3j68whOjwA1yVIZwXJxmksklSFq8jtGPSnVPkuyRFNXJ0XxexNRifqUJg+OAcN56l7wvHacvP9jSlZJSSJghVaySVpoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ONAQku2Q+Vo77gvZ0BxhAamhEWbvM7J6PCyx4L57l8=;
 b=d3ngLL/Q2SFyJHpztgUsBUi94JO8KoMu4Re8uR2HqGlO+jKFH6nQdwceusHBH/608FpiFmR6jR1TIRdSpRX/osQlknGYuyUnUeh9ffCCiGGUDqrxR323hHI1FPJKqxedmtAQIxvoW5WZA1ZWppvhXUdwQhiePH6QPNS+DQQ40Gs=
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) by BL3PR04MB8105.namprd04.prod.outlook.com
 (2603:10b6:208:348::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11; Fri, 8 Sep
 2023 13:12:45 +0000
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::b35e:d4f9:1de8:f321]) by SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::b35e:d4f9:1de8:f321%6]) with mapi id 15.20.6792.009; Fri, 8 Sep 2023
 13:12:45 +0000
From:   =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Thread-Topic: [Qemu PATCH v2 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Thread-Index: AQHZvyd8GCwEW8xWH06l9DaX+skObrARLf8A
Date:   Fri, 8 Sep 2023 13:12:45 +0000
Message-ID: <ca63022b-0447-74b8-06fc-0e6d47455ebc@wdc.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p28b38d294f90b97f99769466cc533b4de@uscas1p2.samsung.com>
 <20230725183939.2741025-7-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-7-fan.ni@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0401MB3582:EE_|BL3PR04MB8105:EE_
x-ms-office365-filtering-correlation-id: f06c4cf1-0097-403e-d1af-08dbb06d4abd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztJonTAigEQf16Y3G3VrEgU8WJL6QcCZ8LXMa0ZphbJQLMFF25GY8mv79mLI3oiBoXH5MVsir/MuqJg4zj5LRvDbduODSASqU2eZVeJ73NU04JdVzlF/JsvbUS4/Sg5BUDnmIaBJV2Xt2uiZRvH+wQp7KhwYv1qlpJKFcdnXs0mD6FJi87HKdIzu7tVWWsXr4Fh+3EVHUFPEsLASColyS8/+S+Pq9yNBD9vrR2izazHXbpx4SKyUzd2A95tDkYdCn2k+KDjih70IzyCfqbGnCzQinnfdGfbdSD17ZjmSEr6WVtdYF2BnSUxr54ETWwjWuuOipM00it7IKYwIpCpmK5bpu5tzrfeMAQNUSrT6+wXBdZv/BnermjxIr+NMyDAVatc5cvDpd3W9/PtCF/Dp1rkaJmNaDVBd19PpwjqrabzIvZ0nsTAFW/f8MyaK1xHolXfnQpwZouEDcAHONSxSMzFeVIv2QvYLgbg2BelwwRSyzJ5RFrxonczvCcFZIgwEzSGFNw8EUiVay5OVvwR2CbTG7LsK80gWKo4+SsH6VFt4BZNnvH7Iqvg2U/Zpw8Pjg/w3D2e10FjMMdnCsCJvwkabX64aB03YKMX0M+xO+8pSWJzkdpx7hK9L/q2VxdfWbH3yEsnduLWkhjjbKB3qtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3582.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(122000001)(82960400001)(31686004)(71200400001)(53546011)(6506007)(6486002)(31696002)(86362001)(85202003)(85182001)(36756003)(38070700005)(38100700002)(2616005)(26005)(41300700001)(15650500001)(2906002)(6512007)(83380400001)(478600001)(76116006)(91956017)(110136005)(4326008)(8676002)(8936002)(5660300002)(7416002)(64756008)(66446008)(54906003)(66946007)(66476007)(316002)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdPcDFzRVpoWW9CRE84T28wZlpGak9lejNyRzUvbHNEM0w1UytmKzViSEhj?=
 =?utf-8?B?N294VExIVFdxWWs2R0w0NmZyL2pqczFzRE8yTDQ2UzBnMFVnVnlhck44VEg2?=
 =?utf-8?B?L1lKYXBYNDNYNHJ0RkZSbU40d3l5VEVPMjA0QytlWmJuYXdxUThuVzhpOTQy?=
 =?utf-8?B?TGdmWG5qamhhN1NadUNKb28yMEJsTHZLaTFLSzYrSjFTR1BQMjU0RTMzYnV5?=
 =?utf-8?B?L2JEb0JUeTgzMCtYNnN2WnpsRkpUY3BvcGYwblc5bDhBQ1lqQ1IxS0E1Uklt?=
 =?utf-8?B?SnNnUkRjRm84ZlUrOEdhQlZ2QnlPZmJSQ1FwVnBXSjlSaWV5M3RwelJ6aC9T?=
 =?utf-8?B?S1U3T2dqRS95MjhtV0phKzh4ZGtSRHAzUWZXUVlqQVptcVMvZkd5eDZqa1ow?=
 =?utf-8?B?VGlvOWk2c3FPRWJiUzI4MUhTb0R3ZmE2RXlKQVphb2RkUTdLN0tnbTNPZStK?=
 =?utf-8?B?ZUZxYWpwMXZuWGpOZzZxRm11ZUdWVFRNdDVCSVJ2OUhHZGc4THJiZ1p4VHBB?=
 =?utf-8?B?T05YUjdBZldsdDJnVkluVFJQUkhhN2hRbG1GM3lvN2tzR2IwTldCdUljRlVj?=
 =?utf-8?B?VEtWa2lyYTl5RGpnck81SDlnTzNtTmpiSjIxemhVeXE2MzduZHdidjVXc0FQ?=
 =?utf-8?B?RE51TXJ4NCsvVEF4N1prbHZZOWdWQk94bEpSYWFmaHNrbXpTUkNKTlowUFFT?=
 =?utf-8?B?VGtKbGNmalpNSWpNQkVDSDAxeDNUUFBtd29yTXEydTc3ZldWUDhxVjNSRmU4?=
 =?utf-8?B?cW45NzV0ZnJyNzdvZDVMQnRaMDJpbDBZQXMrcmMwMHZSaXFkczJ6d1BPYnRS?=
 =?utf-8?B?eU4zN0t0d09zaVdLNzdaR1VZdWdzRlVjM2RwblFOeDd5em5KaWtPQWN1a1A2?=
 =?utf-8?B?eTIvc0lSUVhzUGozdXlsM1FuTForSkQ0Z0U3bGM0MWRRcmtqVkdrdXpUMUkz?=
 =?utf-8?B?VW5XUTFkeGNXaXRrSm5DZzBISnJQTDBzd2lZSmxqTkNoU3N2VXgxVzhxRUdy?=
 =?utf-8?B?b2tnbmp4QmN0S1B6QTF3T0lvc0VJcVJ0QVhyUCt0bW5aZmRDbzV3TFpjZVFK?=
 =?utf-8?B?aENPWFgzU1p5RG9kYzFjeEpneEp0SzUyL0NTcGtjT2JraTJ1QlZMWnRGSkhT?=
 =?utf-8?B?RnNaa2lxTjJOUEVuWXk0VERoY3N0dVVnZXFZVE1nSTI3SlZ3TjhHRXpIZEor?=
 =?utf-8?B?b0dwaThiOFV3NlFFcllKQSt0dUJEa0tsMEQ1SzVRcU9vbW9CbktqM0c1ZFpm?=
 =?utf-8?B?dndxcHo1eTF4R0p6a2NPK0ZvTGlieFZFSTRYRzFZUmRoSlRiekxYa1FOT05B?=
 =?utf-8?B?SzZkV3crb3E3UzNBNEVEeCtRdkFwT2pza2poemZEQmRnQjUvYlRGTm95YlN6?=
 =?utf-8?B?cnU5SlEyWVEzSndFWEtoVGxQVmx4bnZuRHFlUjI3N3V2VDkxSnVGL1BYd2Yw?=
 =?utf-8?B?NHY4VWVZTFpUSStGSnhtbHZ6YVlKaTNxc2ZpV2I2NFhobjlMd1pzYVVONkJP?=
 =?utf-8?B?bHhKRGpvUFZOdlhqWGRZdDEzSGg5WEVUZXhJQUxkcmFCNlRDcFRQNmF3NkNp?=
 =?utf-8?B?c29IZ0VMaS9yaDEwMjZKMnpRTzhCUkdvNmRSejNSRE9MUW0vajFqdmZpNE1D?=
 =?utf-8?B?UVpGNWRkWXphMndtT3lDQzJNY2M2YlRNZ1N1RFgxNkhsZ1F0NGN6cWZnL1Ft?=
 =?utf-8?B?R0xFZlBkRUJ4MElmejAxQXhzM1hJenJRblg4dDhWSkVaQzBSUFNXRUpMaTVZ?=
 =?utf-8?B?THEwTmZuZGdnVUR4dklWZGdNbmJZQXBCUTJSdDBRWkNzVUxtVlVHYndzUjBp?=
 =?utf-8?B?eGNPRHV4T1B0THhOY3RTZFJhT0c1UHNVdzk1bVFNTC9BS1QzUkp1WU8zMTQv?=
 =?utf-8?B?aGJnVmZxWG9Ocy9aNDJObEYzRU9nc1NIZkY2d1g1aDFucVJacTY2YnJ6YW5q?=
 =?utf-8?B?Vm40ZkhJdmNFODhxcHU5MEgxSDZnbWZPZ09obzErdHNDZXZwby9lR1JvY0Zw?=
 =?utf-8?B?Wk8yR3lRRDlXamtsSTdtdCsySEFoVUN2SVdpMmZqNERsT0hqcHhVOTFWa3hu?=
 =?utf-8?B?RzNzd21yV2tFdUEvbDdOVzQ3MmtOUTgwaW10empKSVhDQW5RWURLdUtud0tn?=
 =?utf-8?B?NmhUVnk4NFlWbzF5bVdBdk83emp0RHkvYmJHZFRUTHFlUEhURnNJaGw0ZFdF?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC4B56633C1F542A3015F340549B15A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b0VCSC90SXRxVnJtbWV6MEdlTWJtYUZ5dEJUcURPR3V3WGZRYm1nYUR6SUxW?=
 =?utf-8?B?MitsckM2cEpJTjVPQ1VWNytNWWE5WklGT216d3NyVkRqUFN1U2VuQy8yaHNV?=
 =?utf-8?B?b0NTZ09CS3p4QU0ycTF3OElTSFR1WG5aeTNLdXozOGtKU3p1Y2J2cFRVZDk5?=
 =?utf-8?B?NEpUZ0pUbnJucnVqKy9zYkdMbUIyUStCNzNJejRRMkYySnRKS09RWExxMDk5?=
 =?utf-8?B?WDg4NHlQRW85MWt5L0xaeTF0SDIyOEoyVzF4a2VPZXFROWxsWk04K200djVQ?=
 =?utf-8?B?N3lUcnBlTFdtMWpYU2NlM2pEMURZUVBRZy9lSjNoTWNrZUNhMjZ0Smk0VWY4?=
 =?utf-8?B?VzFPL0NETE1jeFhNU1pIQldDWnk3Z0lZWGgxQlBRSUN5N1lnTDd5U3Y1QUxr?=
 =?utf-8?B?MGxrVDZ1OHBsQjF3aHVTc2tYSVVkSEtyOXUzKzJWRkZtc1JnTFl4dXN4ZVZk?=
 =?utf-8?B?R01yVGxuQTZvOXJOQllHbzExSlBkZUxJcHlvUFdiQnNwNDVta09YSUpyUnlD?=
 =?utf-8?B?U3ZibU13TnBJeHlGZ3ljeFRXaXg1QlNiNzZiQ3JXSVlLUTNneDBXNTFyM2N6?=
 =?utf-8?B?R1Z1U0V5ajY1ekt5NnNWTFRxYjFmYVM0UUxZcFArS3B0cUJ6bGpRUHRwZjNO?=
 =?utf-8?B?ODVwdkxLT1BLNSswVXJKcjAwaHNkZ2FBd2UyZW53VFZGc1BpS3N2bWJST2Rt?=
 =?utf-8?B?OWc5MXZ3UHlsdjZGbnRKUWNoMGNaTDJKY0FiM3FBc2xxK1l0d2lDTGdBVG9M?=
 =?utf-8?B?OVNJQkJHV1lPcXFyVFUyaEYreEtMM1lRL2sxZ3hSUTJ4ZUYzdC8vbmM4d0Nr?=
 =?utf-8?B?aDdNVVpDU1NwTVNKNWZ0VlRSRWJWL0JPMEZwa1FaMkVXWHJmcy9ESFltL3Bu?=
 =?utf-8?B?S2t0QTJOY3dRQmZSQ2VEdjhKZFZpRWQ2MzZRZTFEaVhWUHBrMXdwNDVBQkV5?=
 =?utf-8?B?Z2RuNkhNYjM2eVhRZ2kxY3dVZ0l6MnM3azhnUVdTcDkweG0reUtGcWtmdDRr?=
 =?utf-8?B?RFEzSHB3ZmZRdEZtUGtFQ0tsNGQ2dC9HR3kzRnVqWDQ3dzVVSlFDakhkcHhr?=
 =?utf-8?B?VkhtRzRyMTRKa1gya0ZKT0NNa2xhcm5admMxTEhyZ0JKQnduRjVWQTFiVWJZ?=
 =?utf-8?B?cGI4Mm9JdzlXcUZLTG1IRkNFcncwOElyOGdMbjJUU0k2MXFScVhSa2NWNDQ2?=
 =?utf-8?B?UTNsSkVqYmZ4QUVBMStxQ2M1RGVPSEphdjZIN3p2SG4rUEFLZFJQUFVJT1Z2?=
 =?utf-8?B?enNKTHFTenVrSk9iWFpTMDE4b1p5RU9EaVhrZHh2Sk9LdzVxMk0yR2R1Y3E1?=
 =?utf-8?B?b2plYkM2YjMxM2tBRlNmU3B5Y0ZLTEpBcm9IOGZHR0ZwUE1uWjJXTU93TGx6?=
 =?utf-8?B?SlR3d2RIaXdDZ0hiZWZKRWsxS0pVTGR0elBOamVGNE9lOWdialI0Q0p1Z3lo?=
 =?utf-8?B?bHhUbGZmdWR2ZWxwcEhCSTErUVBYYXlVdjFZcWxMT0lzU3pUYitVMHBvQmU5?=
 =?utf-8?Q?azyPN4+IO6HP//m+Zfij2CnQbL5?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3582.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c4cf1-0097-403e-d1af-08dbb06d4abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 13:12:45.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P67ZoOaggHlCW9ZedLY36oyIK4BwA+1RAmEMLE+NeVDWmGKc7LA/otJnhaDCexSiWWD3gDdTtxZ1cAuJRtJhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8105
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gNy8yNS8yMyAyMDozOSwgRmFuIE5pIHdyb3RlOg0KPiBGcm9tOiBGYW4gTmkgPG5pZmFuQG91
dGxvb2suY29tPg0KPiANCj4gQWRkIGR5bmFtaWMgY2FwYWNpdHkgZXh0ZW50IGxpc3QgcmVwcmVz
ZW50YXRpdmUgdG8gdGhlIGRlZmluaXRpb24gb2YNCj4gQ1hMVHlwZTNEZXYgYW5kIGFkZCBnZXQg
REMgZXh0ZW50IGxpc3QgbWFpbGJveCBjb21tYW5kIHBlcg0KPiBDWEwuc3BlYy4zLjA6LjguMi45
LjguOS4yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmFuIE5pIDxmYW4ubmlAc2Ftc3VuZy5jb20+
DQo+IC0tLQ0KPiAgIGh3L2N4bC9jeGwtbWFpbGJveC11dGlscy5jICB8IDcxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBody9tZW0vY3hsX3R5cGUzLmMgICAgICAg
ICAgfCAgMSArDQo+ICAgaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oIHwgMjMgKysrKysrKysr
KysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaHcvY3hsL2N4bC1tYWlsYm94LXV0aWxzLmMgYi9ody9jeGwvY3hsLW1haWxib3gtdXRp
bHMuYw0KPiBpbmRleCAwNTExYjhlNmY3Li4zZDI1YTk2OTdlIDEwMDY0NA0KPiAtLS0gYS9ody9j
eGwvY3hsLW1haWxib3gtdXRpbHMuYw0KPiArKysgYi9ody9jeGwvY3hsLW1haWxib3gtdXRpbHMu
Yw0KPiBAQCAtODMsNiArODMsNyBAQCBlbnVtIHsNCj4gICAgICAgICAgICNkZWZpbmUgQ0xFQVJf
UE9JU09OICAgICAgICAgICAweDINCj4gICAgICAgRENEX0NPTkZJRyAgPSAweDQ4LCAvKnIzLjA6
IDguMi45LjguOSovDQo+ICAgICAgICAgICAjZGVmaW5lIEdFVF9EQ19DT05GSUcgICAgICAgICAg
MHgwDQo+ICsgICAgICAgICNkZWZpbmUgR0VUX0RZTl9DQVBfRVhUX0xJU1QgICAweDENCj4gICAg
ICAgUEhZU0lDQUxfU1dJVENIID0gMHg1MQ0KPiAgICAgICAgICAgI2RlZmluZSBJREVOVElGWV9T
V0lUQ0hfREVWSUNFICAgICAgMHgwDQo+ICAgfTsNCj4gQEAgLTEwMTgsNiArMTAxOSw3MyBAQCBz
dGF0aWMgQ1hMUmV0Q29kZSBjbWRfZGNkX2dldF9keW5fY2FwX2NvbmZpZyhzdHJ1Y3QgY3hsX2Nt
ZCAqY21kLA0KPiAgICAgICByZXR1cm4gQ1hMX01CT1hfU1VDQ0VTUzsNCj4gICB9DQo+IA0KPiAr
LyoNCj4gKyAqIGN4bCBzcGVjIDMuMDogOC4yLjkuOC45LjINCj4gKyAqIEdldCBEeW5hbWljIENh
cGFjaXR5IEV4dGVudCBMaXN0IChPcGNvZGUgNDgxMGgpDQo+ICsgKi8NCj4gK3N0YXRpYyBDWExS
ZXRDb2RlIGNtZF9kY2RfZ2V0X2R5bl9jYXBfZXh0X2xpc3Qoc3RydWN0IGN4bF9jbWQgKmNtZCwN
Cj4gKyAgICAgICAgQ1hMRGV2aWNlU3RhdGUgKmN4bF9kc3RhdGUsDQo+ICsgICAgICAgIHVpbnQx
Nl90ICpsZW4pDQo+ICt7DQo+ICsgICAgc3RydWN0IGdldF9keW5fY2FwX2V4dF9saXN0X2luX3Bs
IHsNCj4gKyAgICAgICAgdWludDMyX3QgZXh0ZW50X2NudDsNCj4gKyAgICAgICAgdWludDMyX3Qg
c3RhcnRfZXh0ZW50X2lkOw0KPiArICAgIH0gUUVNVV9QQUNLRUQ7DQo+ICsNCj4gKyAgICBzdHJ1
Y3QgZ2V0X2R5bl9jYXBfZXh0X2xpc3Rfb3V0X3BsIHsNCj4gKyAgICAgICAgdWludDMyX3QgY291
bnQ7DQo+ICsgICAgICAgIHVpbnQzMl90IHRvdGFsX2V4dGVudHM7DQo+ICsgICAgICAgIHVpbnQz
Ml90IGdlbmVyYXRpb25fbnVtOw0KPiArICAgICAgICB1aW50OF90IHJzdmRbNF07DQo+ICsgICAg
ICAgIENYTERDRXh0ZW50X3JhdyByZWNvcmRzW107DQo+ICsgICAgfSBRRU1VX1BBQ0tFRDsNCj4g
Kw0KPiArICAgIHN0cnVjdCBnZXRfZHluX2NhcF9leHRfbGlzdF9pbl9wbCAqaW4gPSAodm9pZCAq
KWNtZC0+cGF5bG9hZDsNCj4gKyAgICBzdHJ1Y3QgZ2V0X2R5bl9jYXBfZXh0X2xpc3Rfb3V0X3Bs
ICpvdXQgPSAodm9pZCAqKWNtZC0+cGF5bG9hZDsNCj4gKyAgICBzdHJ1Y3QgQ1hMVHlwZTNEZXYg
KmN0M2QgPSBjb250YWluZXJfb2YoY3hsX2RzdGF0ZSwgQ1hMVHlwZTNEZXYsDQo+ICsgICAgICAg
ICAgICBjeGxfZHN0YXRlKTsNCj4gKyAgICB1aW50MTZfdCByZWNvcmRfY291bnQgPSAwLCBpID0g
MCwgcmVjb3JkX2RvbmUgPSAwOw0KPiArICAgIENYTERDREV4dGVudExpc3QgKmV4dGVudF9saXN0
ID0gJmN0M2QtPmRjLmV4dGVudHM7DQo+ICsgICAgQ1hMRENEX0V4dGVudCAqZW50Ow0KPiArICAg
IHVpbnQxNl90IG91dF9wbF9sZW47DQo+ICsgICAgdWludDMyX3Qgc3RhcnRfZXh0ZW50X2lkID0g
aW4tPnN0YXJ0X2V4dGVudF9pZDsNCj4gKw0KPiArICAgIGlmIChzdGFydF9leHRlbnRfaWQgPiBj
dDNkLT5kYy50b3RhbF9leHRlbnRfY291bnQpIHsNCj4gKyAgICAgICAgcmV0dXJuIENYTF9NQk9Y
X0lOVkFMSURfSU5QVVQ7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmVjb3JkX2NvdW50ID0gTUlO
KGluLT5leHRlbnRfY250LA0KPiArICAgICAgICAgICAgY3QzZC0+ZGMudG90YWxfZXh0ZW50X2Nv
dW50IC0gc3RhcnRfZXh0ZW50X2lkKTsNCj4gKw0KPiArICAgIG91dF9wbF9sZW4gPSBzaXplb2Yo
Km91dCkgKyByZWNvcmRfY291bnQgKiBzaXplb2Yob3V0LT5yZWNvcmRzWzBdKTsNCj4gKyAgICAv
KiBNYXkgbmVlZCBtb3JlIHByb2Nlc3NpbmcgaGVyZSBpbiB0aGUgZnV0dXJlICovDQo+ICsgICAg
YXNzZXJ0KG91dF9wbF9sZW4gPD0gQ1hMX01BSUxCT1hfTUFYX1BBWUxPQURfU0laRSk7DQo+ICsN
Cj4gKyAgICBtZW1zZXQob3V0LCAwLCBvdXRfcGxfbGVuKTsNCj4gKyAgICBzdGxfbGVfcCgmb3V0
LT5jb3VudCwgcmVjb3JkX2NvdW50KTsNCj4gKyAgICBzdGxfbGVfcCgmb3V0LT50b3RhbF9leHRl
bnRzLCBjdDNkLT5kYy50b3RhbF9leHRlbnRfY291bnQpOw0KPiArICAgIHN0bF9sZV9wKCZvdXQt
PmdlbmVyYXRpb25fbnVtLCBjdDNkLT5kYy5leHRfbGlzdF9nZW5fc2VxKTsNCj4gKw0KPiArICAg
IGlmIChyZWNvcmRfY291bnQgPiAwKSB7DQo+ICsgICAgICAgIFFUQUlMUV9GT1JFQUNIKGVudCwg
ZXh0ZW50X2xpc3QsIG5vZGUpIHsNCj4gKyAgICAgICAgICAgIGlmIChpKysgPCBzdGFydF9leHRl
bnRfaWQpIHsNCj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgIH0N
Cj4gKyAgICAgICAgICAgIHN0cV9sZV9wKCZvdXQtPnJlY29yZHNbcmVjb3JkX2RvbmVdLnN0YXJ0
X2RwYSwgZW50LT5zdGFydF9kcGEpOw0KPiArICAgICAgICAgICAgc3RxX2xlX3AoJm91dC0+cmVj
b3Jkc1tyZWNvcmRfZG9uZV0ubGVuLCBlbnQtPmxlbik7DQo+ICsgICAgICAgICAgICBtZW1jcHko
Jm91dC0+cmVjb3Jkc1tyZWNvcmRfZG9uZV0udGFnLCBlbnQtPnRhZywgMHgxMCk7DQo+ICsgICAg
ICAgICAgICBzdHdfbGVfcCgmb3V0LT5yZWNvcmRzW3JlY29yZF9kb25lXS5zaGFyZWRfc2VxLCBl
bnQtPnNoYXJlZF9zZXEpOw0KPiArICAgICAgICAgICAgcmVjb3JkX2RvbmUrKzsNCj4gKyAgICAg
ICAgICAgIGlmIChyZWNvcmRfZG9uZSA9PSByZWNvcmRfY291bnQpIHsNCj4gKyAgICAgICAgICAg
ICAgICBicmVhazsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4g
Kw0KPiArICAgICpsZW4gPSBvdXRfcGxfbGVuOw0KPiArICAgIHJldHVybiBDWExfTUJPWF9TVUND
RVNTOw0KPiArfQ0KPiArDQo+ICAgI2RlZmluZSBJTU1FRElBVEVfQ09ORklHX0NIQU5HRSAoMSA8
PCAxKQ0KPiAgICNkZWZpbmUgSU1NRURJQVRFX0RBVEFfQ0hBTkdFICgxIDw8IDIpDQo+ICAgI2Rl
ZmluZSBJTU1FRElBVEVfUE9MSUNZX0NIQU5HRSAoMSA8PCAzKQ0KPiBAQCAtMTA1OCw2ICsxMTI2
LDkgQEAgc3RhdGljIHN0cnVjdCBjeGxfY21kIGN4bF9jbWRfc2V0WzI1Nl1bMjU2XSA9IHsNCj4g
ICAgICAgICAgIGNtZF9tZWRpYV9jbGVhcl9wb2lzb24sIDcyLCAwIH0sDQo+ICAgICAgIFtEQ0Rf
Q09ORklHXVtHRVRfRENfQ09ORklHXSA9IHsgIkRDRF9HRVRfRENfQ09ORklHIiwNCj4gICAgICAg
ICAgIGNtZF9kY2RfZ2V0X2R5bl9jYXBfY29uZmlnLCAyLCAwIH0sDQo+ICsgICAgW0RDRF9DT05G
SUddW0dFVF9EWU5fQ0FQX0VYVF9MSVNUXSA9IHsNCj4gKyAgICAgICAgIkRDRF9HRVRfRFlOQU1J
Q19DQVBBQ0lUWV9FWFRFTlRfTElTVCIsIGNtZF9kY2RfZ2V0X2R5bl9jYXBfZXh0X2xpc3QsDQo+
ICsgICAgICAgIDgsIDAgfSwNCj4gICB9Ow0KPiANCj4gICBzdGF0aWMgc3RydWN0IGN4bF9jbWQg
Y3hsX2NtZF9zZXRfc3dbMjU2XVsyNTZdID0gew0KPiBkaWZmIC0tZ2l0IGEvaHcvbWVtL2N4bF90
eXBlMy5jIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+IGluZGV4IDc2YmJkOWY3ODUuLmYxMTcwYjgw
NDcgMTAwNjQ0DQo+IC0tLSBhL2h3L21lbS9jeGxfdHlwZTMuYw0KPiArKysgYi9ody9tZW0vY3hs
X3R5cGUzLmMNCj4gQEAgLTc4OSw2ICs3ODksNyBAQCBzdGF0aWMgaW50IGN4bF9jcmVhdGVfZGNf
cmVnaW9ucyhDWExUeXBlM0RldiAqY3QzZCkNCj4gDQo+ICAgICAgICAgICByZWdpb25fYmFzZSAr
PSByZWdpb24tPmxlbjsNCj4gICAgICAgfQ0KPiArICAgIFFUQUlMUV9JTklUKCZjdDNkLT5kYy5l
eHRlbnRzKTsNCj4gDQo+ICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaA0K
PiBpbmRleCAxYzk5YjA1YTY2Li4zYTMzOGIzYjM3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3
L2N4bC9jeGxfZGV2aWNlLmgNCj4gKysrIGIvaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oDQo+
IEBAIC0zODUsNiArMzg1LDI1IEBAIHR5cGVkZWYgUUxJU1RfSEVBRCgsIENYTFBvaXNvbikgQ1hM
UG9pc29uTGlzdDsNCj4gDQo+ICAgI2RlZmluZSBEQ0RfTUFYX1JFR0lPTl9OVU0gOA0KPiANCj4g
K3R5cGVkZWYgc3RydWN0IENYTERDRF9FeHRlbnRfcmF3IHsNCj4gKyAgICB1aW50NjRfdCBzdGFy
dF9kcGE7DQo+ICsgICAgdWludDY0X3QgbGVuOw0KPiArICAgIHVpbnQ4X3QgdGFnWzB4MTBdOw0K
PiArICAgIHVpbnQxNl90IHNoYXJlZF9zZXE7DQo+ICsgICAgdWludDhfdCByc3ZkWzB4Nl07DQo+
ICt9IFFFTVVfUEFDS0VEIENYTERDRXh0ZW50X3JhdzsNCj4gKw0KPiArdHlwZWRlZiBzdHJ1Y3Qg
Q1hMRENEX0V4dGVudCB7DQo+ICsgICAgdWludDY0X3Qgc3RhcnRfZHBhOw0KPiArICAgIHVpbnQ2
NF90IGxlbjsNCj4gKyAgICB1aW50OF90IHRhZ1sweDEwXTsNCj4gKyAgICB1aW50MTZfdCBzaGFy
ZWRfc2VxOw0KPiArICAgIHVpbnQ4X3QgcnN2ZFsweDZdOw0KPiArDQo+ICsgICAgUVRBSUxRX0VO
VFJZKENYTERDRF9FeHRlbnQpIG5vZGU7DQo+ICt9IENYTERDRF9FeHRlbnQ7DQo+ICt0eXBlZGVm
IFFUQUlMUV9IRUFEKCwgQ1hMRENEX0V4dGVudCkgQ1hMRENERXh0ZW50TGlzdDsNCj4gKw0KPiAg
IHR5cGVkZWYgc3RydWN0IENYTERDRF9SZWdpb24gew0KPiAgICAgICB1aW50NjRfdCBiYXNlOw0K
PiAgICAgICB1aW50NjRfdCBkZWNvZGVfbGVuOyAvKiBpbiBtdWx0aXBsZXMgb2YgMjU2TUIgKi8N
Cj4gQEAgLTQzMyw2ICs0NTIsMTAgQEAgc3RydWN0IENYTFR5cGUzRGV2IHsNCj4gDQo+ICAgICAg
ICAgICB1aW50OF90IG51bV9yZWdpb25zOyAvKiAwLTggcmVnaW9ucyAqLw0KPiAgICAgICAgICAg
c3RydWN0IENYTERDRF9SZWdpb24gcmVnaW9uc1tEQ0RfTUFYX1JFR0lPTl9OVU1dOw0KPiArICAg
ICAgICBDWExEQ0RFeHRlbnRMaXN0IGV4dGVudHM7DQo+ICsNCj4gKyAgICAgICAgdWludDMyX3Qg
dG90YWxfZXh0ZW50X2NvdW50Ow0KDQpIaSwNCg0KSSBkb24ndCBzZWUgdG90YWxfZXh0ZW50X2Nv
dW50IGJlaW5nIHVwZGF0ZWQgYW55d2hlcmUuIFNob3VsZG4ndCB0aGlzIGJlIA0KYWRqdXN0ZWQg
YXMgcGFydCBvZiBjbWRfZGNkX2FkZF9keW5fY2FwX3JzcCgpL2NtZF9kY2RfcmVsZWFzZV9keW5f
Y2FwKCk/DQoNClRoYW5rcywNCkpvcmdlbg0KDQoNCj4gKyAgICAgICAgdWludDMyX3QgZXh0X2xp
c3RfZ2VuX3NlcTsNCj4gICAgICAgfSBkYzsNCj4gICB9Ow0KPiANCj4gLS0NCj4gMi4yNS4xDQo=
