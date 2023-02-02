Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB7BC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 17:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBBR41 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBR40 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 12:56:26 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AC6A717
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 09:56:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312HnXRi026985
        for <linux-cxl@vger.kernel.org>; Thu, 2 Feb 2023 09:56:23 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nfjr8wm9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Thu, 02 Feb 2023 09:56:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3V313kIhAf1solgQJzRgMAdZFhedpGI+Eu2niJ8Tpe5ZCNxmfsa9D+WxMT08Dxn4Mg4owF25EksIijPCIVH2k0OB6vxHQ1dSq3hiHGiRs1/qI9wOurm8hGS4MG4KrGP1vjrGPe6fypqvl4M7VC4xaXsrHzHzESGnFT0PXzl3/toKXEJMjr0HRPlzLsiLqHvI1C+aX2dHgzq7tsM1pxVIZVscNZyCyvNR1LzRDSuRiAYS58c6Qcwf+ejQjpDq9GWxBo5d57ivtKsZ6If4m2QQHfPWgzvv7EaMa9et1jb7ZwL1VRfIWiC6T24rwVC6qxziVHEX/zbpNaISEm5AejrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZOz0uaetmGmUyFPl6Yzx8hO73JARXqj+zTywAhL9Wo=;
 b=JduJbBkpu5LFZq2S2yUeU0fC0FOeNTieMP1yGLWnAr+uIjsaz9Y9X9wVWPCJbtZCrWTTkLUA4VkGEZS2NED0u4pSP2yp6XzT6k1imkHmJhZmYo9C3B5He/0SaMiv8YmzV4B5iDtPGlL2jUhpr0b7FOSHMfxPNTUHHINMIeE49Ke0z+BMGTrWVdMnhy7WFrz8AO0vGvhbyGwLWAlmQ4nkmuWSplgzrmo8/z0qRJhXyuqj2A+raAD3itg+ylrQXRFEcm2hHf2IQlkEDaTdwxSMLaqc+7IWbH+qwp0JVPbvjo9SOYmMc236Sf7z+va9P+oKTdft0qSpa9bprDDBV/S6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZOz0uaetmGmUyFPl6Yzx8hO73JARXqj+zTywAhL9Wo=;
 b=RtMhbyA5hzsg/KdMihBLxmEgkak7mnNFjjA9JW6WdB+Ec745NvaXU2Nm0JPWf1oS4TAo/nzM+DFest3mgWtTlstCWztIsWTGKH3iFw+PFY+DEniWPZabewdty7icScVudlo6+yW0qgfMYGR5w31OE7y3coG4dsHgFJUZgHX1uxQ=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by PH0PR18MB4592.namprd18.prod.outlook.com (2603:10b6:510:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 17:56:21 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::3232:77bb:59d9:ae1a]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::3232:77bb:59d9:ae1a%7]) with mapi id 15.20.6043.036; Thu, 2 Feb 2023
 17:56:21 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: DAX system-ram usage by the kernel
Thread-Topic: DAX system-ram usage by the kernel
Thread-Index: AQHZNyvkJf6njRN2RkywZ+9fiejneK677t4q
Date:   Thu, 2 Feb 2023 17:56:21 +0000
Message-ID: <DM6PR18MB2844A9ED953484909A27850EAFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
In-Reply-To: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|PH0PR18MB4592:EE_
x-ms-office365-filtering-correlation-id: 9a2f95f5-be48-49c8-603b-08db0546cb0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFGpwJaaKrfudRCz0zMOgWfGll04I10wo6w0DQO4Etl8ZVKcaxHR04N3gu88NOx9LnmnoKDy5FuxCfGD72hqbsV2jn7y6+LM3yMNgStA8sgO7sqTjblmuJW/g12bo/x0L96PiP8wceT3c+KlCtdq5dEQFvuD4atoE6uMyGCYAFGotDcGsJh6TFBDaawPIxo1nsioAl/y1MBRCR8bbscpHiLec6lq0kHkzDKAOAjQXROBK25wIA9ICUjomcGdP14vbyyYcLPjBdksFKtckPii59UlWrdEqFIRb8Jjl/nGvPOdkB1VRoGvSY6oU5yDMgg23nD3mQi3oGWgQ0JBPYMMoCAsNBZiYoQEhwRcYljNuLsV9pK6a3MMiGwcvLYuVIw9Eb7SE4W/Ygis6jbw85SDH7khqDrnnt9E71hayUv5L1nSy3otjF+yt8Gg9QyysCkSjUiJSNpcKdgJLiY/j9gVdaJ64oGkW0nRpr5az1L09szEvDJOUYJj3uqBZy0tMLhNDu/dtE7t3ojIZlQlyQHHhO+BQtj+Tv59p/lVejqF0QceHQWUOa8nLF7MjmIEw1cIeRB9n03E9X9rlywY3Tx/g0dsNUWTUuphyJcZzQohUBn7SngNWP2cfDw3+Fa06TrMx4Z4+9SvVmMzNTyecTzqi8FP/V1lulPl/6QIZRWI7eEoqz8aqHNdiyyPH/VYxq67FulbfW5t2HcR4eBKfuRALA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(2906002)(7696005)(478600001)(91956017)(4744005)(33656002)(71200400001)(76116006)(6506007)(26005)(53546011)(2940100002)(9686003)(186003)(5660300002)(38070700005)(52536014)(8936002)(86362001)(55016003)(41300700001)(8676002)(66476007)(66556008)(6916009)(64756008)(38100700002)(66946007)(122000001)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k8Mg9QlpqcKe14tjyjglq52ooF15cgvB8Jt2d7ptwth1fBL4DhGc/i/51C?=
 =?iso-8859-1?Q?g/qUTotBUYM5ZxqsBpj73nIfcS9eXmDQtyskLweviuma1MSABEQJ3sLx2E?=
 =?iso-8859-1?Q?7qg5vzIC2I7odNOqtx92EpMeLPpgSSzBDFqVOaEaspHqNwkZip7yia1nlk?=
 =?iso-8859-1?Q?vHWnx/3UGcmdTimI8DpAho+P3MTzxpn52byPVpikFllG7xfwNwLoajcIJO?=
 =?iso-8859-1?Q?CK8QKtsIwNZV/0kQvCFO9rtVNmgdRl9w1p3NOVbK8JR0lfLmBWxOUAlWHC?=
 =?iso-8859-1?Q?D2s7+eDzs9mnJ6+KwuYJPqD141Zi2hRe5PBssPKR6ekhyhGugDfuSAwXdx?=
 =?iso-8859-1?Q?WWhsAo7SJXyTOLEdYEdtCHued9HnFV5vvu7DlVUImbxgjY9GoVR0/oGL2T?=
 =?iso-8859-1?Q?65y4ioZKUOzj2HDKPtDlcatoVJ0LTVchRKZmPvBUR/Y8s1uINVGtlYO7DZ?=
 =?iso-8859-1?Q?pD5HUWxXolwUIkwLP09hazQuFokGOqhARa7G5xz4DOcwd3CIixv3ELvS20?=
 =?iso-8859-1?Q?SXSoQkgfiPdCSLQo5Pt90SF8kaRCMVpFXhtplsLdsFaKEG3ddUWc33GEHq?=
 =?iso-8859-1?Q?Ct7s18TIzbeT+IAwNdZ+5iaKr5siP7nrJW9hWK+gPNogY7u2nysB/bwg3C?=
 =?iso-8859-1?Q?EDovb7TcwYbK5lrxa9uqRcTvzS1j0ToBn11L8L+eSjyNMzBQCAvBqRgxCZ?=
 =?iso-8859-1?Q?Cg7XquON5I2VrwW2rXZG+mhAheffe1i5zidUkkROn7hXGAgrD6YUrt5DQy?=
 =?iso-8859-1?Q?16zRDnXafsJKZeyjfayfDK2bjmWFZTZ4sduc2c2cfaBRPurcK8dzCswjbb?=
 =?iso-8859-1?Q?wwkguikHn8C5LLMDaUoaxhfNSIxCe2ejZrlIB8MHYOSRPUpBw5P+kONlaU?=
 =?iso-8859-1?Q?9BPiC3pePU0O4Fmztxb5jUdVnEgAVYf7RDBHA5sw1/eYluycN3kK1OApwI?=
 =?iso-8859-1?Q?lMCWMvRpxH/goY0wFOInurzZ5ebwfgsY7W4ZT7qC5m97otuu993yZnvLSY?=
 =?iso-8859-1?Q?wsGrQjKdpXWpeZwgegB4uFG2cCoSqJRp0k12rL4hkP1LVnBLkU70mllPgI?=
 =?iso-8859-1?Q?3dGOS1Syd5I53EyJ1f9tVZv7uhbPuog42jzfW8s7Qg/M9XOxJ1hZbeHuAL?=
 =?iso-8859-1?Q?QmIgAwv/wG6NB1sCwL6Di0SmtAz9FGUG/9aAdy0oK0ArsscKePeQko/Y+g?=
 =?iso-8859-1?Q?1tDs4WX5Z9mmZbt1cHAGjTVIZUSkKwYYm4tLOoKSg/O5t+polWDZ/TmAKT?=
 =?iso-8859-1?Q?6ej5mWoQDGJ271eVjKnIjJGzh7piirRDlQ9ZJghVoTH1YrZxVtK8FkE99u?=
 =?iso-8859-1?Q?Vq/tYyLiQbrHKgJjdSE2gmGy6AnwfDUn3PpPiLOWfiG5uTCuXKFUdiCJUW?=
 =?iso-8859-1?Q?f3tvayFeH3scKsT2l5/BTdXiWzhhn1fjSd2caWvlcUMJYMVAVoqc36klt/?=
 =?iso-8859-1?Q?ZtHsW2/z0vAmHSGcXA/JKNwhs5DjxZxPEwNkir9Weycukfh+SvhBNEPc1C?=
 =?iso-8859-1?Q?TaGxbmw7CLdA9e/5XQtnIXopbQy6eZJR6MAE5c5hmgCgucFeNut3geJCCR?=
 =?iso-8859-1?Q?PW/qzoBU8alG9PZiIxOceOo8PwnRcZbTkGuuff70UmIm14fGmHAvvrQvah?=
 =?iso-8859-1?Q?5nYNoWk4jYhJ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2f95f5-be48-49c8-603b-08db0546cb0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 17:56:21.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+rfxuuY0hirTW2A8nHfAgl9jBrZjOwziGbmnrjJqNj9FCUZDvznaZPT7YIIdpAZhDBc5IGdjcJmvyBSYfGLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4592
X-Proofpoint-GUID: Rg9ZAI-3PX3aGMMqaVcu0aTH3LPcGFmj
X-Proofpoint-ORIG-GUID: Rg9ZAI-3PX3aGMMqaVcu0aTH3LPcGFmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Sent: Thursday, February 2, 2023 9:35 AM=0A=
To: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: DAX system-ram usage by the kernel =0A=
=A0=0A=
Hello All,=0A=
=A0 =A0 When a CXL memory is assigned as system-ram using daxctl after boot=
, can kernel allocate memory from this memory range which cannot be moved a=
nd prevent this device from being made offline ?=0A=
=0A=
After some reading,=A0i found that this memory's valid zone will be "movabl=
e" and not "normal". Therefore, kernel's kmalloc, mmp and page-tables will =
only allocate from normal zone. Correct me if I am wrong.=0A=
=0A=
Thanks,=0A=
Shesha.=
