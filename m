Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39EBC7EE23
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 18:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFGSjA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFGSiz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 14:38:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8191725
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 11:38:46 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357I7MUA027507;
        Wed, 7 Jun 2023 11:13:04 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r2a7bvyx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:13:04 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357ID32e003250;
        Wed, 7 Jun 2023 11:13:03 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r2a7bvywy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhiIq45c424x8VYR7GSp5B83DOE/Xx18ArTcJxBbtaipiHRC56zW/uJw2UNzRVWiwgj5IDbI2VTZdCs/bJq+H1w9MlF3YKClpHUnG1l6XSAVuCj+9Cigr7xlT5xER8BtC3l/mu5yPwvos1oh2nJLft/7gZtjYGAJ84EYQNQL9JgzJX5XZI4HvZXKB+8+HJoA8kk3n118S+gNhAYT3/8Q8t8wgZUjqAw57WLAX5NiTW5X1XXy3CaZ8PtVrJQ/QfJV1dfRISfUnK1vUGXE8zEjVIDw0FenD0CRdq4VtJQ4e8NDT8MWjwurPKHpk/GfkGC5dNlQws5xtnLkBHu+0PNZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW4TBilgOTe5bw6pCHYuRNJDAm4BOVCMzPtN2aAVfh0=;
 b=YZPhAhgDeo8ZN95Ovs/yihh9dMl2iUYfBr3Pjm2D27+hOABEAPZ/NqFAH/d1yPfvcY8wAliz5MQTXyxrlriGcMuTc8Dbi2sx5UU4524i3s/TKfeNhk2J8rqkdEQoAvvd7sbiUUfvXxZpjGX5eNrKTFc6cVNoJX5zmAm5OhY+Bn9Xhrn3qzfdWVvURUEF3QdebMD8VG7iS81RAojbrQQHPWFZGs2NX8c3bdcW7O89P7i03MMwWmpRKj3p6M9zia6oFsQxKq8F+fAgLOYzkU9ILp3haSChoZsBNNb/9f1OefUXcynlu8pTZXCoAW/oxxGvwRtgVsyt1R8DjoEpYH1ePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW4TBilgOTe5bw6pCHYuRNJDAm4BOVCMzPtN2aAVfh0=;
 b=F/oDBxoGeGwhX6L4mO7yT6BJXKvLVuuCZcsARgTWYCij4IZydpOMyDrE9Gy7jqnkiv7vhqx4gcoiQDD4GvvCawCEFRsjpt0klcJZZO12tsue/YFFEYnYDm7YPs5taQajw8o4yaj6EAMGMQeFQWgx0B/XXnS/mJ6P+RM66GUlQx8=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by MN2PR18MB3624.namprd18.prod.outlook.com (2603:10b6:208:261::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:13:01 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 18:13:01 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK98n/AAgAAEVoCAAymO8A==
Date:   Wed, 7 Jun 2023 18:13:01 +0000
Message-ID: <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
In-Reply-To: <20230605175112.GA2290821@bgt-140510-bm03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|MN2PR18MB3624:EE_
x-ms-office365-filtering-correlation-id: a580ea23-aa3a-46d9-d849-08db6782d486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzeCi7XOSsnLBw7whN3ytF8OKCGPTrxHNC9GJV/h8qAImLOyQEnkXPQHqzpjtndJfiTJ5yVs8W6AZzyoNOYjCqzudPo+rIHwpTC3gnUAhi30hpmPHIb6pHEumuqjBjh/44BupFjfGwF1+sXa5jGA/8lyHSJB5a/moT8uGMSzrPLJSBlLpm/3DH/G4f0jE/IypB3AuPcCcGJRe0xkejTeAY3vANpo02k5YCSzRS6I+AbOCFFsOKU7wryAdf/D5hrCah4aS9c+T7LCwYYOSnIImOkaoTdfQ+ky2Q87a2Q0NIwhoKRHK3dJnFioRhcvB1+SY7tsg184Js23qmHthcQIOAKriHDmQfgSAo/PuG/ZYCp0DW/VqPGefpNcEl5mjdN1bSyb1bgslxDubOvIkoL9P6iPfJbeg55EEie6BClD/qSai9oj0Vp4zEGq/CdOFfDQz4INPuSPxG4UjaqAsPabVCqJVpCIVP696JWzUVSE/0vK6hWTIswjbKUlEOvCHNbC5Y5KKUhm1VpY2CoktsbysBbRXkBxtr7iWO/QzyBOxfaG/3ZAJtS5Y8iX92leHfQZJqLcIsdRJQZElqD7sSmf5yeAV1DoTAcqZuyLnq8Iq5POKhp24BWOc22bajVCUyFL92kLqzJ318DbIOSKvLp9vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(6506007)(53546011)(26005)(9686003)(7416002)(52536014)(83380400001)(122000001)(86362001)(2906002)(186003)(33656002)(316002)(55016003)(38070700005)(5660300002)(30864003)(8676002)(8936002)(41300700001)(38100700002)(91956017)(66476007)(66556008)(76116006)(66446008)(4326008)(966005)(66946007)(110136005)(54906003)(64756008)(45080400002)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ho42Q4yMm1OASFQ7wIqKnIgLe1KJxFkxA8eNgfS/TAFJOFyrtiIIpqMf8l?=
 =?iso-8859-1?Q?zlquDnoA+ZNkRmsB3dOd1+g5sSOP2aT9sIY1uie4o7gSgfqbE3eWHtGLL1?=
 =?iso-8859-1?Q?JqhvSCWD2Y0odS2RVP1byaepoxAAtTAD2OFhOsds79zymnyLBsdQj8XYvF?=
 =?iso-8859-1?Q?C/Z+3W2RPN4PjgLhEIp2j4f/WROwmSNZVuNLTrwMOONvkZubBvgnfT7RMz?=
 =?iso-8859-1?Q?Pdw/dGLbGZWQCU4aEVjozPlywt929qriK4e7Rjrq9fDySdhtah4IRQ6HMj?=
 =?iso-8859-1?Q?2sf8bPXtkh4oGhJFGsD7n32tVVeusqniT7/oFJ9nVQq8qWZmHrP4w+DjZo?=
 =?iso-8859-1?Q?gFD7tUvKIENS+roSNqCQmRgyhJnUSNLSwCuZzPZq68qKO0F+AggncnjaWv?=
 =?iso-8859-1?Q?vRc94bIt3T4FvoEmCkBvjyGXet+uYfLnHITb89RZuQxzWrTtsyBB3RRP+U?=
 =?iso-8859-1?Q?3LoWhD+1OOOGEMeCaZm4DHo3WK58lwOkQFRs80MfEiM5FqqiIk9rdp8j7s?=
 =?iso-8859-1?Q?YUDDPUw2FrUUUZ4Xz2Gn3IUY1WJyVIClNbUNHXeVWU5gVt25ATpsdXt/JJ?=
 =?iso-8859-1?Q?EgfGH7Fq65RquU2MPlymH8KWKNr6SxryG2wv1wgd/WyysYnpeHsIpzC+y5?=
 =?iso-8859-1?Q?7sg6pT5NH/X01RZAKDaxfhp0vLk3LCOYynmw4sDXYO+Rz6gCBrheHhl6SA?=
 =?iso-8859-1?Q?QGLHxSaeoapkS1ZsmTzzM2Aot1Vx3n49hkUZLE4Bs/bSTLN3xOZ1/pb2Zx?=
 =?iso-8859-1?Q?uhze24WuyU3xNWkikSTUpwpjYcMCL5IN5WQze4TTWaQGcKnYdFMCZMgh0Y?=
 =?iso-8859-1?Q?Vys8e30F5F5jtVNl1tTjHXJ6fommB0RCb8s/62g1f+LZh5iT9IW2hXhF9F?=
 =?iso-8859-1?Q?4+nWLlhY5q+RxnsadbGoGoLs6CnJEGaMN7BTHUFxaCmsjPLFIILPwLx/1s?=
 =?iso-8859-1?Q?GzjggpxvMBNDflLpk2szzMiZXxV907uC62KP4JVhFngA59KUzbPESCiL0j?=
 =?iso-8859-1?Q?tpBSeQPodoV9zPIALJdHapgMM5gSLqCi8jSuv9WEUwSbizErLL3ioBBzzr?=
 =?iso-8859-1?Q?IOmvYRIj+AkvgrnQmrEX6bGI4O2ORMAEeC44tayKbQ1V7CuLu0K7TSqacR?=
 =?iso-8859-1?Q?BGusOyxH9BlOOqFOj22IMJrrT/G65IHHrU0/AIj0JFDsdJNJ8JbPPARdrC?=
 =?iso-8859-1?Q?lp0gi8NQKURLq/FpJLDyO27TAKloMlRT1EwKrlV7AYmMpQDkLOlNpvh99g?=
 =?iso-8859-1?Q?U9junjvCaoN2+SNNQZaM4/s/6OKhM2lqUKxwCDBq6r95ONM8GlTt49jpH+?=
 =?iso-8859-1?Q?YjcFXG5VadlodxysmGJpjKfFue35UteSrbwVc+6lxxbGxnK0F3NBQacz/u?=
 =?iso-8859-1?Q?0Y1DtX01cYCdu/OkNuPt1jG4Id9Mgup5Wa34vayrqfiGxyD1azG0BSLisg?=
 =?iso-8859-1?Q?RK2zJbZRwm59AYtIh/1XZ9xrQsM6ZXtEJFUK5PTI9U8yF+E3jL1E/1Ahoa?=
 =?iso-8859-1?Q?G+zgJXeCBv08+4dAeKY/avfdEYaKsMNeUw3cysHK3b6hVhQBy4sDZuB2S8?=
 =?iso-8859-1?Q?dTYTxwm7tZuqxu7to+BfksXMjTeoWJoianlYgaj9kVYlRmHg+2OAQ+n6C6?=
 =?iso-8859-1?Q?brpstqnLeoYmL/wv3VKMdxgHsjiIlnaCHq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a580ea23-aa3a-46d9-d849-08db6782d486
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 18:13:01.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcxsrM5bbSxk06WV64CxM3ssgf/YGBvsI1JHFUAsb7SbV0tcRk/hGQmhSQawal23rlzOqhZxU5wIY7gkD0F0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3624
X-Proofpoint-ORIG-GUID: fBJxay3rNmkMSkP_J1TnmH8SEATLKHFU
X-Proofpoint-GUID: _PUDY8uDdLFL1xHMZCmgoE_dsSFnuCdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Fan,=0A=
   I am implementing DCD FMAPI commands and planning to start pushing chang=
es to the below branch. That requires the contributions you have made. Can =
your changes be pushed to the below branch ?=0A=
=0A=
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25=0A=
=0A=
=0A=
From: Fan Ni <fan.ni@samsung.com>=0A=
Sent: Monday, June 5, 2023 10:51 AM=0A=
To: Ira Weiny <ira.weiny@intel.com>=0A=
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@huawei.=
com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl@vge=
r.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; hch=
kuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.c=
om <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@inte=
l.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave=
@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifa=
n@outlook.com <nifan@outlook.com>=0A=
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =0A=
=A0=0A=
On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:=0A=
> Fan Ni wrote:=0A=
> > Since the early draft of DCD support in kernel is out=0A=
> > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/20230417=
164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiG=
sqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGNOk$ =
),=0A=
> > this patch series provide dcd emulation in qemu so people who are inter=
ested=0A=
> > can have an early try. It is noted that the patch series may need to be=
 updated=0A=
> > accordingly if the kernel side implementation changes.=0A=
> =0A=
> Fan,=0A=
> =0A=
> Do you have a git tree we can pull this from which is updated to a more=
=0A=
> recent CXL branch from Jonathan?=0A=
> =0A=
> Thanks,=0A=
> Ira=0A=
=0A=
Hi Ira,=0A=
=0A=
I have a git tree of the patch series based on Jonathan's branch=0A=
cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gith=
ub.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6TpIC=
IjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X057Yeq=
RTTQTQNfNA-Gfir_Q&e=3D .=0A=
=0A=
That may be not new enough to include some of the recent patches, but I can=
=0A=
rebase it to a newer branch if you can tell me which branch you want to use=
.=0A=
=0A=
Thanks,=0A=
Fan=0A=
=0A=
> =0A=
> > =0A=
> > To support DCD emulation, the patch series add DCD related mailbox comm=
and=0A=
> > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory devi=
ce=0A=
> > with dynamic capacity extent and region representative.=0A=
> > To support read/write to the dynamic capacity of the device, a host bac=
kend=0A=
> > is provided and necessary check mechnism is added to ensure the dynamic=
=0A=
> > capacity accessed is backed with active dc extents.=0A=
> > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not su=
pported=0A=
> > , but we add two qmp interfaces for adding/releasing dynamic capacity e=
xtents.=0A=
> > Also, the support for multiple hosts sharing the same DCD case is missi=
ng.=0A=
> > =0A=
> > Things we can try with the patch series together with kernel dcd code:=
=0A=
> > 1. Create DC regions to cover the address range of the dynamic capacity=
=0A=
> > regions.=0A=
> > 2. Add/release dynamic capacity extents to the device and notify the=0A=
> > kernel.=0A=
> > 3. Test kernel side code to accept added dc extents and create dax devi=
ces,=0A=
> > and release dc extents and notify the device=0A=
> > 4. Online the memory range backed with dc extents and let application u=
se=0A=
> > them.=0A=
> > =0A=
> > The patch series is based on Jonathan's local qemu branch:=0A=
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-20=
23-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFd=
wKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$ =0A=
> > =0A=
> > Simple tests peformed with the patch series:=0A=
> > 1 Install cxl modules:=0A=
> > =0A=
> > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem=0A=
> > =0A=
> > 2 Create dc regions:=0A=
> > =0A=
> > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)=0A=
> > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region=0A=
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity=0A=
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways=0A=
> > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode=0A=
> > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size=0A=
> > echo 0x10000000 > /sys/bus/cxl/devices/$region/size=0A=
> > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0=0A=
> > echo 1 > /sys/bus/cxl/devices/$region/commit=0A=
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind=0A=
> > =0A=
> > /home/fan/cxl/tools-and-scripts# cxl list=0A=
> > [=0A=
> >=A0=A0 {=0A=
> >=A0=A0=A0=A0 "memdevs":[=0A=
> >=A0=A0=A0=A0=A0=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"=0A=
> >=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0 ]=0A=
> >=A0=A0 },=0A=
> >=A0=A0 {=0A=
> >=A0=A0=A0=A0 "regions":[=0A=
> >=A0=A0=A0=A0=A0=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"=0A=
> >=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0 ]=0A=
> >=A0=A0 }=0A=
> > ]=0A=
> > =0A=
> > 3 Add two dc extents (128MB each) through qmp interface=0A=
> > =0A=
> > { "execute": "qmp_capabilities" }=0A=
> > =0A=
> > { "execute": "cxl-add-dynamic-capacity-event",=0A=
> >=A0=A0=A0=A0=A0 "arguments": {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/peripheral/=
cxl-pmem0",=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128=0A=
> >=A0=A0=A0=A0=A0 }=0A=
> > }=0A=
> > =0A=
> > /home/fan/cxl/tools-and-scripts# lsmem=0A=
> > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BLOCK=0A=
> > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0=A0 0-15=0A=
> > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 32-79=0A=
> > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 338-339=0A=
> > =0A=
> > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > Total online memory:=A0=A0=A0=A0=A0=A0 8G=0A=
> > Total offline memory:=A0=A0=A0 256M=0A=
> > =0A=
> > =0A=
> > 4.Online the momory with 'daxctl online-memory dax0.0' to online the me=
mory=0A=
> > =0A=
> > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0=0A=
> > [=A0 230.730553] Fallback order for Node 0: 0 1=0A=
> > [=A0 230.730825] Fallback order for Node 1: 1 0=0A=
> > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total page=
s: 2042541=0A=
> > [=A0 230.731110] Policy zone: Normal=0A=
> > onlined memory for 1 device=0A=
> > =0A=
> > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem=0A=
> > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK=0A=
> > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0 0-15=0A=
> > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=A0=
=A0=A0 yes 32-79=0A=
> > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=A0=
=A0 yes=A0=A0 338=0A=
> > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 339=0A=
> > =0A=
> > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > Total online memory:=A0=A0=A0=A0 8.1G=0A=
> > Total offline memory:=A0=A0=A0 128M=0A=
> > =0A=
> > 5 using dc extents as regular memory=0A=
> > =0A=
> > /home/fan/cxl/ndctl# numactl --membind=3D1 ls=0A=
> > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0 git=
-version-gen=0A=
> > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=A0=A0=
=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 acpi.h=0A=
> > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapshot.s=
h=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools=0A=
> > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel=0A=
> > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=A0=
=A0=A0=A0=A0 cscope.files=0A=
> > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=A0 te=
st=A0=A0=A0=A0 util=0A=
> > =0A=
> > =0A=
> > QEMU command line cxl configuration:=0A=
> > =0A=
> > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D=
/tmp/cxltest.raw,size=3D512M \=0A=
> > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cx=
ltest2.raw,size=3D512M \=0A=
> > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/ls=
a.raw,size=3D512M \=0A=
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \=0A=
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \=0A=
> > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,dc=
-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\=0A=
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave=
-granularity=3D8k"=0A=
> > =0A=
> > =0A=
> > Kernel DCD support used to test the changes=0A=
> > =0A=
> > The code is tested with the posted kernel dcd support:=0A=
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJBm!RH=
zXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21q=
5Iza3M$ =0A=
> > =0A=
> > commit: f425bc34c600e2a3721d6560202962ec41622815=0A=
> > =0A=
> > To make the test work, we have made the following changes to the above =
kernel commit:=0A=
> > =0A=
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0A=
> > index 5f04bbc18af5..5f421d3c5cef 100644=0A=
> > --- a/drivers/cxl/core/mbox.c=0A=
> > +++ b/drivers/cxl/core/mbox.c=0A=
> > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_ME=
M_COMMAND_ID_MAX] =3D {=0A=
> >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),=0A=
> >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),=0A=
> >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0=
),=0A=
> > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),=0A=
> >=A0 };=0A=
> >=A0 =0A=
> >=A0 /*=0A=
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c=0A=
> > index 291c716abd49..ae10e3cf43a1 100644=0A=
> > --- a/drivers/cxl/core/region.c=0A=
> > +++ b/drivers/cxl/core/region.c=0A=
> > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *=
cxlr)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D exten=
t_gen_num;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of preal=
located extents :%d\n", rc);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT_TYP=
E_DCD]);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVENT_T=
YPE_DCD]);*/=0A=
> >=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0 return 0;=0A=
> >=A0 err:=0A=
> > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds=
, struct resource *alloc_dpa_re=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(dev_d=
ax, hpa,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res));=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> >=A0=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, G=
FP_KERNEL);=0A=
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c=0A=
> > index 9e45b1056022..653bec203838 100644=0A=
> > --- a/drivers/cxl/pci.c=0A=
> > +++ b/drivers/cxl/pci.c=0A=
> > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state =
*cxlds)=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the dc cx=
l_region */=0A=
> >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings, =
CXL_EVENT_TYPE_DCD,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTO=
EN);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);=0A=
> >=A0=A0=A0=A0=A0 if (rc) {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed to g=
et interrupt for event dc log\n");=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.=
h=0A=
> > index 6ca85861750c..910a48259239 100644=0A=
> > --- a/include/uapi/linux/cxl_mem.h=0A=
> > +++ b/include/uapi/linux/cxl_mem.h=0A=
> > @@ -47,6 +47,7 @@=0A=
> >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
> >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents")=
,=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
> >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")=0A=
> >=A0 =0A=
> >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a=0A=
> > =0A=
> > =0A=
> > =0A=
> > Fan Ni (7):=0A=
> >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output=
=0A=
> >=A0=A0=A0=A0 payload of identify memory device command=0A=
> >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representat=
ive=0A=
> >=A0=A0=A0=A0 and mailbox command support=0A=
> >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC regions th=
e=0A=
> >=A0=A0=A0=A0 device supports in qemu command line=0A=
> >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 devic=
e=0A=
> >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/rel=
ease=0A=
> >=A0=A0=A0=A0 dynamic capacity response=0A=
> >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents=0A=
> >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity=0A=
> > =0A=
> >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-=0A=
> >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++++++=
+++++++++++++++-----=0A=
> >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-=0A=
> >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++=0A=
> >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 ++++=
=0A=
> >=A0 5 files changed, 924 insertions(+), 67 deletions(-)=0A=
> > =0A=
> > -- =0A=
> > 2.25.1=0A=
> =0A=
> =
