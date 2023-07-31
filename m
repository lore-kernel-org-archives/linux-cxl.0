Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0FC001DC
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Jul 2023 06:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjGaGGm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jul 2023 02:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGaGGl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jul 2023 02:06:41 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755ECE7B
        for <linux-cxl@vger.kernel.org>; Sun, 30 Jul 2023 23:06:40 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UJWAEF009878
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jul 2023 06:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=TNu1oI8pXrOXaHJArhmxANSAzsatUG9ixVy/4ekubfk=;
 b=SkFPiqybgiKlayE3vLyobEl+wZxADh6o90S58EBKazfFqijJ5hQU0iLvP9qaslOOUfrE
 C2jje0hZLb2P5AFVBvestfh1y5FAMRr+ns/kAE86tQzMYITnjhhjJgC8bsypGWC37ar8
 1ioqII9hxoNN8V1krVK1pgWN8RMT7HuInrb3fOHPQsUsYKYtEC43V3Lru0Z/RYilxUcB
 b97a5njUlXlPAUsKcL4BuDMX4MFNZR5VUcQVAe0A1l/nY1Srlba99JdppIyGGw+nF86H
 Vtiw7xlfhmp9Mkok8Fp3zITg5koXW69KMpn3VOj9IrUdBfIrC+1JhC5L1IEc38+lP5n3 xg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s4r56vrdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jul 2023 06:06:39 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 2F943800187
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jul 2023 06:06:38 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 30 Jul 2023 18:06:29 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Sun, 30 Jul 2023 18:06:29 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 30 Jul 2023 18:06:29 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aADCUl0e+h8KiFNWQxJJeO0PvE/kRCG6924pOqf6vVJ9beohxKCelNCxTfnBzH3clG1mmh/IJnd5KBsKihRfQBDJa9T1hw2rVaHvxRd0oCYeW3d8CvxizzPHEkG3DkV6Z/tbJts6AACiPDBI27tn633sTHxOERnIzYun6FAi/YI6MCWzEXVg/j2s6mi50sN/j2p+iJk2vLIPEXl/LSRvTtgC3ARiqvyj+HX3KCYsgvzW5rGLY9NPOPZJNUDd5qOpqql66TZ0XL6LFoDlkN1vfbSpS5Ns9Ir86kNkAcJ0oXqqKfSybH9R3aj7dTE/XCtjEfKm1Yac+MbGtFo5Ae3rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNu1oI8pXrOXaHJArhmxANSAzsatUG9ixVy/4ekubfk=;
 b=brdue5OVBu9ET9iqnd71gR1B0HNS32eF3U7fZsrEThVkFbkrRcBU3natd8ZkWHJ4dp1Vx+XgOZK9zjXKJgj/o+FDgokRKUtqFKH1DWM65qrea8vfawJ782P1o8p8vDXrJnhOnAVcEsTtvYHG3V1WYQ8nNbK60smrl+vSi9r2hI6V3De1IAEwbuXq0v5y4fKqFgtnWVMZX+nqekv/d5X/Wq0u8LOUVwlKhqCMsATNC+q2yUqz8cG41BnGH4yXWaj4Y7nj1KgklUl+6rvTCzFv/trnUrOvXKZbMixmwmZ+wmQXxmUeXIuva76DdRd8VZUIED71O/7WcZxSjr8FmQCGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::12)
 by PH0PR84MB1407.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 06:06:27 +0000
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d82:c195:aed6:e7f]) by PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d82:c195:aed6:e7f%5]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:06:27 +0000
From:   "Parthasarathy, Mohan (HPC/AI and Labs)" 
        <mohan_parthasarathy@hpe.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: CXL RAS flows on Linux
Thread-Topic: CXL RAS flows on Linux
Thread-Index: AdnDdQ/HkPSCwFRjR96+kVl3igVdZw==
Date:   Mon, 31 Jul 2023 06:06:27 +0000
Message-ID: <PH7PR84MB1582BBE2FB47C45DC4BFE78D8805A@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1582:EE_|PH0PR84MB1407:EE_
x-ms-office365-filtering-correlation-id: 957c6faf-03cb-4a81-e877-08db918c4713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2taf8xO1ihorAsCKVvAkMjrSRMgnlXNhWq/p7AchQ8Jyiydlkd8iGEXdUn9eRAZvMF6QY4rMKsqYHkeyqMXrCzpbrLyRnmZ6G9RdcED5GLiZKBUMu9jV/bxoYCmdFp7Z2mVQ0UzYCTHLZ6/JxYMFMyHvZLs0d38jINedzlI0gs8lg5usnKL3aSqiZp9pbauJEvNnzv1yytjXLyGbh644IPKkt+IamBs9ky55tTDZii177UhZivfjJNhtvVnFT5andQ0Euuqdcea+d4yPfti/KSC7Stf9181iro7vNygm72+0hefc7sudU19VknTSbi3slCPxfbX3bnBHF3lsV5ibLh1gd0bYdNjsuTp4my4s/TLBc6F3+yASf+BGhGWtR/JD1uCi654ntKzDJrm/hW+Oyb3g7RzvYjqWPMPxKFsGReX5Lvia2riaiDApHv9qB6ERJQCcWIRu5+mAbhrnz8ctp/1ex1PDv3Ql/8hEs7+a01XQQYTQEhLLRar74hAAB0CbeR7zxDIaFnITpBuVxKzc81xpcODZ8vwHXCWub8BJ0boND7r3sWXimXr/dv73ZONhn7adxk8C9jZXHDPbzM6QE98n0d6t+4g0UYXXQbvfg/j1P/iwnAhPHI7omUD6bDC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(26005)(6506007)(82960400001)(478600001)(186003)(71200400001)(122000001)(7696005)(66556008)(64756008)(66446008)(66476007)(6916009)(9686003)(76116006)(38100700002)(66946007)(4744005)(5660300002)(52536014)(41300700001)(33656002)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H9hV7glhVXWURcWT8oRaX11heCCOQitd8jkKFD5XvVO8a6g/AM6JYfCOSSrq?=
 =?us-ascii?Q?5bCPvZ0BczVK1rN17UxgF5Uy83rqgF2QbKJ6SpMeKt3F38YDGfnB3hKdL1YR?=
 =?us-ascii?Q?5QAOHFvnk89+IAG2Km/EPiPLspQ4aqXoZJRZJtVfsVvpaTtwAi886K1PSNqf?=
 =?us-ascii?Q?5EGG9XkiLqk/nMzWgba056fp4PHeoWdHvwCLyrmO55UZPPg/+YinNLLU66K1?=
 =?us-ascii?Q?RODlqIDGfR2n/czH3FM281jYDGfIWaB+0lZay+C8MHBb4pi2B1KqLGS5+Vgi?=
 =?us-ascii?Q?11TzHOw46nyUmI9vhtXWl2xcUAXJOqSdYaEIDoobl2Gu9POd6CNbGhvIzCiu?=
 =?us-ascii?Q?EP9YiTP3/Lwoz//Geflab5fy2gmS91O2SrTpnUhFoSffVa3aWXqLjcDcWfzI?=
 =?us-ascii?Q?Bkxq60C4OC/YmyW3FEziLvxFtDTAqFMkjvyqySbZut0pwXUUkmItkxV2N89T?=
 =?us-ascii?Q?o2PccMtihwXTTdFZhjdq656r28JkLcyEggnNnxTl9Bc+YH8nYAGfCS5LEhad?=
 =?us-ascii?Q?UcvilNL/3VRjKEZJmz8FaZWNzvL/wcgPeFRwKLDWn1ofpy6VtBv+IEt70I4l?=
 =?us-ascii?Q?2VvPxgV2yZWS+ZXVjtq1UxErfiWIsSfnXV28K3X85hKSj9ZMDCjjwDWZA0Uf?=
 =?us-ascii?Q?04XtDeO9FeWOTgEIYK0A3bKTHRZj0ixthdzNFjgoIcojv3zUi/vYjZ+pMRYQ?=
 =?us-ascii?Q?GKUhydk634WN9eLX7KoWn3RxptpbhPKRcdz+pTtJmSG3sG40cMuyOL/NkqcM?=
 =?us-ascii?Q?cb0o8OeIu6gfcbGE9iTIgMOfzS69w2w5MA/q/mKBAIRM6KpRhUwgJocOWVEj?=
 =?us-ascii?Q?S/KMqja4VebmQ9RmDb66nhwA13yvdRDS0nW8OVWs2UL4FWKyQAuGPcAr6Vfv?=
 =?us-ascii?Q?LcY1z2SCsT/ygnzFTMj5M3cz26sMUAH4nzZp41bsuVez6uBRTS60zuGLP8CC?=
 =?us-ascii?Q?+QWrZw7xlbZ51IihljnrvMtFqvgECFp8evY+6ob5IqCSCBGDSBlyhq7Z/YzU?=
 =?us-ascii?Q?JYssqroR8Uf8EelzTHy3n8wzq63/Tz4AaNJN9RyJtDz1rlYYm7NWYmpihjOa?=
 =?us-ascii?Q?l5ZEZYz8yPUIpCy3XfSCIS3VI638o7BYGBHsMPbV782Ets5kHmhmRRwQc7NC?=
 =?us-ascii?Q?7zOFc1lROD7p0Fl22GhvIlcb1+t5WM1Wj52IHMVc3ZQRTdUUolhFpMhOHjm8?=
 =?us-ascii?Q?BRA1g9J2i/sKwfEHmlV/H+9HjVnCHbxj4faHC1jNPgT6/eFClN9mIDjxwr0b?=
 =?us-ascii?Q?hB+VUDhy3CkfaQmghoZD3zLPa6XZNvs+WoEwjkOhUr81hSfvxwSIYcWhFh5e?=
 =?us-ascii?Q?A1nT+2MlKWPQPNGO3kCEVvopazzVpfa3KxOrf/LmT10EdK6J/iDgka13N/rH?=
 =?us-ascii?Q?1Z50QQ2QfDNhMlsnZPjkxcSZjqjS0ZLLWm0iMoe3t39r7D8Nf9XU4BvYTK7L?=
 =?us-ascii?Q?n6doe/JvM6tl/paTDe3wYegI5NgJCQeqm8klbo2/skOfFfHSlyj5ESVvYyCB?=
 =?us-ascii?Q?7PizsSXzEKhzXJXvA9PdrBicLF+jnkfmvfmUahmPYFiUugJExo9GmKvUlrM3?=
 =?us-ascii?Q?QqFGkMZ7gn9BYrq+Y9OBxMguwXYoYTLr9RA9lvg223Mt4zm1XzzyhUzGAAZ6?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 957c6faf-03cb-4a81-e877-08db918c4713
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:06:27.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npoMTnftdaotr4aPfeI3Nhiw1xHtHg4mQLpDAmHV2RKhxxrc+YsOpDcjqK3XRjjEt38PpZnIVFFS8gwPygRs0JuPzkEFmVg4/mlBeWgB6Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1407
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 4g0j7xWQ8VSUySv6uAZ-HGgcdO5rfepy
X-Proofpoint-ORIG-GUID: 4g0j7xWQ8VSUySv6uAZ-HGgcdO5rfepy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=344
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310054
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi all,

I am very interested in the RAS enablement for CXL on Linux. Is there a RAS=
 project for CXL/Linux ?

1)	Do we have a design specification somewhere on the RAS interfaces on Lin=
ux for CXL that I can read on this ? Any document describing the correctabl=
e and uncorrectable error flows for CXL.mem?
2)	Are there any error injections tests and testcases that I can experiment=
 with to see the RAS flows with CXL on Linux, using QEMU ?

Any pointers for both would be very much appreciated.=20

Thanks and Regards,
Mohan
