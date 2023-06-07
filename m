Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6DC7EE25
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFGXB1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGXB0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 19:01:26 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CBE4A
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 16:01:25 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357LwI1E023585;
        Wed, 7 Jun 2023 16:01:17 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r329c07w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5S+WQhvYzwWs2vtPYejvcdulzmcDjDi8m1LEUlVOPBijhGcSi62vVRXFY8aqJmDP8Lb3aPeZzLQ3Smgvjo4Fk8xXmVbsePHguyBUJdnXeSWOCwNSFOhQEEzae1sXCYn0CVockzEGG083lThuYVwaytuL7enk0LShcLf21b2HuygvA1bbA0h0VionkC8ykoOlxTouGCSHLbjhJjveP8H4wsCgvhVJ5yOUgGg9hwAI0TNFzJqge1TFwzmu6V2pPFvVNcePqheqrSBxc7+m3xXpshlYHHGihiJy74lN6/iw5Jqxj3cTVrN3LuZo+CoL0G5gxjWu1+HoSsodyx/1lsF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oF2niV+Fup8KLmooqMy4jayNB1fRcLV/SSIn2IVZnI=;
 b=gkXBJuqKsD1ISIc6Ip00c6FPYhTnPHq7Y9B5f6bOv6MI7+B/8ytxjI4K4yIHUER1yGGNYl+bSfuLe9foNBZ7AOSgazoqL9mX4m1ZXPVfmn2o9dR9pwr7rc2xH4WCDn84AD89dpvrMZe1Q8vlN1LcqhL3CZhuJOHLwyWxbcnGM90mT2QCpf1goIPVdRcGjDAAT/S6OOLmGIpF/9QcFpISa8DjdXcU2eu1rF14git+8PqnryDvhARi/y8aapreaxLpuHRAPt0QZs7Joehl8VkNAHSU0NAILNd3kJopv5zRoXt1dwcX81SUrne6PwNGp5tEfUz1xEj9AYFdWi2kpmLR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oF2niV+Fup8KLmooqMy4jayNB1fRcLV/SSIn2IVZnI=;
 b=rCKjhP89IJ/HYpnDmoIAA2S1dWsCcZbvVekFeprlyRPI8YbROc93lyvguV9FRxrlosNHHxiNopKxV/0ekqK7TnUMrfCD8tQW7aZuqPmd/v2xoHLVhPuxyjuCSXUJz6whibQQBT6kRWGqqeziQwPYDzt4xiILY4e/FJrCBA1JdZE=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CH3PR18MB5488.namprd18.prod.outlook.com (2603:10b6:610:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 23:01:11 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 23:01:11 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Concept of LD-ID in QEMU
Thread-Topic: Concept of LD-ID in QEMU
Thread-Index: AQHZmZPzuyNYjWTGNkuynwSsq4z6hw==
Date:   Wed, 7 Jun 2023 23:01:11 +0000
Message-ID: <DM6PR18MB2844C099FB0671E864AA953DAF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-15-terry.bowman@amd.com>
In-Reply-To: <20230607221651.2454764-15-terry.bowman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CH3PR18MB5488:EE_
x-ms-office365-filtering-correlation-id: 93bf2f6f-8b91-4a4f-9554-08db67ab1619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mp71bySUlJ3opRLZSLRm+pNM6vjhfyjvM1PJUiWJ+g2ZohTm+n2CnUE3k22I1uLAns1gkM1arXWLITmvTGMHyIUT+qIW/LSmeveXB5g3KsI48OjbvuZDFPal5pCRFj/Og1lmC6rycKPZ8ikHbqPiLYZcl+v9b07xzCLp8PHP43LowH7cARrXfeEy3Nj9UqNAUqkaU/whQYT/vVfSoQC61iu2mONbQie9/qYE224pJ962EaLasAo1std+hFl0YpsacGK11N+tMnWSfzSwMk5/lFGM7stG9eHb3tJkX7Z34rbkI0veCLw8oCXpmwZ9jqU9rqkJXNzDbf3ypXEq6sGcueuapmsGdQMIzwPlaj2Ks8xhx0Kvid+6ww7wvBW6mFWD4Ur0uUBaTe/BDXWQkmzemDAamjMy0M00XVW8JqL0FIV7zuFK+fG3flEzDehOP+XLBBHrweSScJydP2P39J4epXRLSt/zDcUm1pBMO6rZjM3Qp9Pu6L6SbIy8RBAji/tIkqy5ZRNPAnIOI5eddHsinGJg6zYCMkEkuKWdc+6ZWGd2bFDVIEplWVacGVTIwf47rrwyZPcvhoZMOGf7+q0kSgENNyPOTnCkjZjGp9f3u68P8ByqcPDPM3At4t+IncZ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(7696005)(478600001)(55016003)(52536014)(5660300002)(41300700001)(316002)(26005)(186003)(4326008)(76116006)(6506007)(66946007)(64756008)(71200400001)(6916009)(91956017)(66556008)(66446008)(9686003)(66476007)(2906002)(4744005)(38100700002)(122000001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ezet1xFiNoVnQOviFZJKtslYXr794DkS0cBPyTfjWVZdwLXKt7JFysi3vr?=
 =?iso-8859-1?Q?soOPYp4d386L9BkrW0omaDuU4hxZdbrPxzFGlDB2+NH8IR9XRQEOhDcSnZ?=
 =?iso-8859-1?Q?hIw0Y6MNniWGrNIa4UTZ+FrVtd34r4zDlntF6ZB+K/AabDwPwZOtIsHsdw?=
 =?iso-8859-1?Q?dWelz0wPJPFEvzL+sdSjfjaJNEiv4HNP7PxWFencD1Wgi2mAJ8TqusPJIs?=
 =?iso-8859-1?Q?IQTe8RToWzx1qmOPWCQ97xPBNcek1Irn4/d/S42yoK24UEcUofbgV5AxmW?=
 =?iso-8859-1?Q?0EY2KvzeZKn8CmtYPQ0dvC2qtdweMvhc2c+/dHKO/M9ERwe2d63UmhNMXZ?=
 =?iso-8859-1?Q?esFosyTuk+4sMqnDf7J4nEyC8p7rxc2qO5wKGGrzx692yG13b0ZeDfPIfL?=
 =?iso-8859-1?Q?kdH9phr0uOXVFSoGXGxwI8DWbW7RPYFqn/BI8CNbTz4z3H7RVejcqFzpUC?=
 =?iso-8859-1?Q?X4ElXkl2vGtPhKK9gmmRPbDn1YlrVBKWosrk+LGIysHFyF0o3LQ5zhxqRX?=
 =?iso-8859-1?Q?Nht94OlR1RUxALkuxM+EUdi6p0YKIpy863E5f13H7XtEfke3/K3GCOHvmU?=
 =?iso-8859-1?Q?4nYfnyzvFSteDH1763XJaZGcw+nZx3hFsQr2uuWbyOk9A6hJD6DDacdqv4?=
 =?iso-8859-1?Q?CinZeYwS7/IUUvZ54JwAGKDWxxz16PIjytEqq+qUcpf4d46DCKkarjpj7/?=
 =?iso-8859-1?Q?jDIc6yC92+wNYGDx2F3/IB4zMgzl3/gBNQ6NAKqYEJieUogIlOTbGHicJW?=
 =?iso-8859-1?Q?R/x5gfB/ASFJ3UG1auNzlPRIWZH7zQMFLdzMocU+K3WH+IRuWq+l5gOvJ/?=
 =?iso-8859-1?Q?FShSPbestUhqRKBZ5Ri7TkKkhsuVAxTZztoq/kmKkWzSp8uaWSx6Kbd4bz?=
 =?iso-8859-1?Q?0qhdyIrLOv198LfW9mChn1RiRxoNKExWewiHjThwtOx4AVY/e7G6JU1vuu?=
 =?iso-8859-1?Q?vSbz5/Mwkye488Ss9aoeWEGKBl9GMJueZun8Ii4KNGNKUVmx+6qTPrMbkD?=
 =?iso-8859-1?Q?TjLL8ADq1Lcy7sHMRWzM+C4mFMxnWl3Rfx2td1CYewfZQfI+hiRYNJilnv?=
 =?iso-8859-1?Q?3S+pvIxEOoodLnpLUIcYV3g14kWm/3PJ3ver4gZNQWeDhkN4FD1+qF1Gcy?=
 =?iso-8859-1?Q?/a24DZmGEEgImyt46FaquEacSNnL/TfJNcJ7ENB7zbfOYMq+ImV3H4p/ox?=
 =?iso-8859-1?Q?43ceNxUXq9Bg6UNHLd2YXvtGPa2uc6NFhe/hx0BsCsxLVcv8lixTBz+aXi?=
 =?iso-8859-1?Q?pEUuYWbCCVeKFf9uV6QCkwvhnM0UxnC+rLv9LsFunLvjKNHc2BsivQuJUS?=
 =?iso-8859-1?Q?rL/yF9iAXzKQmY4yTwQGCxpPWfLjB2ikiCqAtUcv52mVX0vOdTgcw3prFh?=
 =?iso-8859-1?Q?5T6p74x35qTPt1ZNIG7fanVmSxTY9tRGrKi4bQdZn8egUnzIRczES/+cvC?=
 =?iso-8859-1?Q?QuMrM6d19Q/eWY+BKgwj0SO7Bt/LzfQVfOlNW0zrYG9dRC+YhLV+uYVy69?=
 =?iso-8859-1?Q?elCZDcw3UE0evOKXe/TA5oCULbCBMbqeq63a3Y7uEWtBS1Xrl/utWaKXha?=
 =?iso-8859-1?Q?k5faVFK5JC8QfjqIxape9uGssNwxYADEkT5xDavxN/0aXFMKl1CSo9xy9e?=
 =?iso-8859-1?Q?BxV6U/RUMxwUN9uAFPuxcyYXObhAcNKioo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bf2f6f-8b91-4a4f-9554-08db67ab1619
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 23:01:11.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozJ1lbOZ8vfI1Jpe7G4quRW6rjEcwlR4ds8Z1ZQSkmfwCjgCj7WRgykdxK5p44uR1at4/bFZ/Jx0k7So4F7b0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5488
X-Proofpoint-GUID: h5P--aTnxhg9EfkvausC9dL53hlk-evJ
X-Proofpoint-ORIG-GUID: h5P--aTnxhg9EfkvausC9dL53hlk-evJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,=0A=
For DCD sideband there needs=A0to=A0be LD-ID. Is the following approach acc=
eptable?=0A=
=0A=
=A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem0,dc-memdev=3Dvmem=
1,id=3Dcxl-vmem0,num-dc-regions=3D2,ldid=3D0 \=0A=
=A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem1,dc-memdev=3Dvmem=
2,id=3Dcxl-vmem1,num-dc-regions=3D2,ldid=3D1 \=0A=
=A0-device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D24,target=3Dcxl-vm=
em0,cxl-vmem1")=0A=
=0A=
With this configuration, the same i2c device is handing both LDs and in FMA=
PI commands we use the LDID specified above.=0A=
=0A=
Thanks,=0A=
Shesha.=0A=
