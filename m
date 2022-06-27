Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C9C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Jun 2022 06:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiF0GEw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Jun 2022 02:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiF0GEv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Jun 2022 02:04:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7F2BD5
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jun 2022 23:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBUKzMcaKHJnq5ZxdKiAZtnQbGDiUBKQwWFYFWefYAXjxDmhqwny5wYLdqdaqNY+ISkD/UN6r6R+p5TMtxifFhhR9rscGQErqeaj18cbdiu3dHi1TaN36ANalJsdIkrylICKqP0O6hl8MB6hTZG3RCHEgZapzYst4Z5fCGxVgXUDLjUT8DkY1T/dSBkWUBRpb6v1v2XdI2jFMIaQovGvA7fi4n7lR4vYT7dEWEKHgYlW14DR4eJU5d+heuS4CTpqLjyukBlmr1aHvxvw5M9iv/iPE+zgWmNh/22iToz8hnpz+/guU/fngP0zjD9p9fLuRu53WrDYlrNDqGqBx7zZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HqN5xhJpjklv9ovCa5VxSGas7Pn5gE9raVeG4VlDVM=;
 b=BE/MFw2uG2eEjG+4vdUZpjdTnTcS0qZ8HIWX/eVLH1XsXE27RStE8vGLbV2Qn9LC7wOlCaqJB+UZ4IO9guB9BOsMIaoMKM+vtJktsZq7aDnen/wv7fCwZZw522zCmywLMooG/ZtA7Fn4TAHR10+UgSXdZ3Vr9FdfQ1CKVbzCdRnm4yuZK2t+lLWq1El4M5GZKn8wlsIjWBguIETB20ZTRMjAOX/agw3DUWdvLg+1BPQicoRwVTkyQr0Y+7z64HeeKx3rikt4odb0A7Xi7LECoXwPdGLfvBR7lsmzSKQKCdkMhpSfchJw1pai9Mzi0f0N7SLjpjLpWdg1NEveuWH5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) by
 CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Mon, 27 Jun 2022 06:04:47 +0000
Received: from DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096]) by DS7PR12MB6007.namprd12.prod.outlook.com
 ([fe80::e9eb:55ac:62f3:f096%9]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:04:47 +0000
From:   Mani Subramaniyan <mani.subramaniyan@elastics.cloud>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Topic: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Thread-Index: AdiJ62AvTeOmYwdPQKq/w7nxUnfXng==
Date:   Mon, 27 Jun 2022 06:04:47 +0000
Message-ID: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a974ed0-507a-4498-2a45-08da5802f079
x-ms-traffictypediagnostic: CY4PR12MB1301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QizL846QZyDjLLiywCVFsY2m9zviWozuUIHYr/3WcBW3db86RO3qoA+LzXeidQP4NdikvCaFNUZdE7k4ZYe/1cpUVzo6ynfBJjDMoen7jib0sHgbK3Ol/inVTIjX+e5srhq6YRhTCKDP6Zc4WdJ3P6e6Gpai+7Br2DRhipNBtClMPOK5tjU1j80PaEWCCpQtnvhqJy/rM2zTUX61qaXJu8MEFVQ02+IaagZMvhTbuew5hnIIlf/0SB4oDJKyws14dWh/qOOK02+zjyKNaDN/jkTJO3GvVALrxE0vIMUvFJBY/7ASIRZ9Gg9fycGYnIL0OQcmgmpoopGcW7CvY8GNiyp2nv5diJ3llnvXNd+2dIbDlLX4QBzZGRN1qJzyL3akIjOat2k/607hbjcT/qbPPh9ej4xuxssoHMXve2celAELW6SFQHqXn22RA5T3W98n/8fnZbnTelP+9KrWUjX+QKC+hVQ1uNBNoJ0s1u4m3gN2NEp2cFuC4+0knq0Q56Gf2vdecutPX5wsJwL2KzMPFQv6GO3QcDESNZobpxgvMIK2jVijXKqRFAPTRzUO5TzDTUlXR+gJwOPG0SxnoOWUUiXtCCfv+txhD9j8h07ASGXgV+Yu4BHuqSUVZxja/o7f7wBUtUUislj4ctPghQ34hhj7Q3Mx8rXbSBwQwcxC+LrzOxmPbC6vfFsSw3p2UPG/sq4nF2SozI0Tz/tVlk5BDuv+/zk4oSlKjQpQ66yrJscxhnq8VDtrAOuNgZ33gtljtHMm1rvfXLJyeOej8ycn7QGMISG5+vE3erogoLX9FM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(396003)(136003)(366004)(346002)(376002)(66446008)(66476007)(76116006)(44832011)(66556008)(64756008)(478600001)(52536014)(8936002)(6916009)(316002)(66946007)(2906002)(55016003)(5660300002)(7696005)(122000001)(186003)(38070700005)(6506007)(71200400001)(38100700002)(41300700001)(83380400001)(9686003)(33656002)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xYSuqEVlV3j9cJZ36xfpECXesB6ujBi1N/MakgI0GMbtsfo6X0AMG334d9va?=
 =?us-ascii?Q?aHmi97J33hVbFbOhUSzpnxpiBSmu4+1fHFPRxBbWVTZC3a3svv47r3RIxD0U?=
 =?us-ascii?Q?8qYHrgJhZDd7G2XORBSIpAjJzNa5yq8bGAru7pNdaFW5u//3ChPVQvY4QVuQ?=
 =?us-ascii?Q?0kow3hHQj+aUEmaK+LTBkFG7+GAYvXljDprXbINrWbE8YLA6QuGfx2tRGypA?=
 =?us-ascii?Q?ybvQWdbmHB3sFnhW/8UdW3cESzq43CuV2EOOcfBFWL8Gal3VfAYR/wu/bX7z?=
 =?us-ascii?Q?nT3ZNUzwSH3TtpmRoR4Wz2mG1bb2ygisxWHMV/JJ3NuNS2bCAaLnxpHKVtPO?=
 =?us-ascii?Q?nKwC1hGALgWp0bi8vjqVUQ9m0O+vR33LnUDgqYdyw9dQn/6LA5hXooaoFc5Q?=
 =?us-ascii?Q?TkyB6zQUMvQoJlGIlZN9bfEIZaaI5RThdam/argHESfCfx1UdbcoYJ0twsYk?=
 =?us-ascii?Q?8H0wvL5IKDszH/n6tpl5AyXYuj8VJg0UQ9XahpFTEOrvDKQXqxccvDH9TjU8?=
 =?us-ascii?Q?8JZTk2UOjUcyfsaV8SkEVrRN30P6VEJ+SPLJHHk3X0O7oujFHMu8Ee1Fw4U4?=
 =?us-ascii?Q?gpRwJuAFlcsK5h5tWcRwRBlEUiELXXDyFt1llrPnkQt6gLxyvjGDuAGGnYBs?=
 =?us-ascii?Q?9dJq1WGX0r2ubAxpU6R0Q39wIpPNYWnjfxhet9/yQkE/QoNFguVbh9l/W0YQ?=
 =?us-ascii?Q?f1SNwYtLFDe6LeWcidH3T0hWvw6vfdwfhIFdvZVw91mKD07WAQozFO3jqPxb?=
 =?us-ascii?Q?VecNfuTFKOsNqPn50BuW1gg1kENCHcuAEGuttnpWRd8S8IFHfq4PKyqmfhrj?=
 =?us-ascii?Q?UoJT0PDh0O0qlOQu1Dz2iJ4hnNLlWb+vW+n3P9onM/0xZT6ATeI/lxbKEyQf?=
 =?us-ascii?Q?n0Z4Kh4M9FlE1i1ovjyx3fhHeKFM01YQp0Ryz1mna8d5NHBCcGl8o0UxICK7?=
 =?us-ascii?Q?nQWFQh88YEGRuW+BE8Zrpzs9KbM2QblGih/APs+PXhq3rDK9Xe8+5MV8vhz0?=
 =?us-ascii?Q?p0UVsV1JvLqQWa/zALuYor75mg2NGiLso80zJdUZECZbHvXkO/Dh+ROsW//e?=
 =?us-ascii?Q?Sgv7giK5ngkHbH7i8JxxpnrsKVIC85fc9HgHMANQtZ86wVCVFWSxEWulqwRE?=
 =?us-ascii?Q?ktDn/ilAm3+3yHl0vYjuL2ly9vW6KFI2oLd7OADjrKPiUg7Iag7twzmnHtA0?=
 =?us-ascii?Q?GGnkDNemTrWEnnTzUoKVI1Z4ABFAvFy8GeVThqMTT/kctZ/VZ4Jo4xl4OxvJ?=
 =?us-ascii?Q?feBFbqZg08yGncqgH5eI8WrWk+bbqJTTTAueIZscwwIrOFpDgyBzMZY7rQ0l?=
 =?us-ascii?Q?nwHVpobWi10FYEiJR0F6P8n5INnu0lxAbVRFgAUp3XUHfULNkOUNMpvbla8z?=
 =?us-ascii?Q?V//KJigLBD3ejZPF8wY930Yebl6rP3X4/emVd3ZyL1i/uzQavjN73VYcsywS?=
 =?us-ascii?Q?Av3An757ZEMhdo2WB2uc00rX2veP9BGrHIGo2ST6JD+OFBEwl5LMTwWR0tIN?=
 =?us-ascii?Q?9qNHgAAMTnIkeWxldR1XwzFeO8uFcihWVpljMYlMPd0qm+kk3V1Tl14Sk17D?=
 =?us-ascii?Q?wWQUxH4sDxBegeYLpLhS48Lt+O2pijRwv4e8FjIzPCM/5iNlglevNTHzlq1+?=
 =?us-ascii?Q?swyMCRBpJA9i8DYCxYxPDDf0+6913dxc94eVcA9GMd00y+pNNGlDxXHHzgPN?=
 =?us-ascii?Q?W9+aBuVXsNEAc4S25iD1+V1QKLc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a974ed0-507a-4498-2a45-08da5802f079
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:04:47.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YG6CWYsupABbIsuGqgyF6j7WMjABfWqwlinCie3Ou8Ecc+hQp6y+cE1cwFKXi0CiQuS3iWWagQnpH99+zqDyt5g/q7qyt/6XfmQ4CBWOKUia2OVqXReDpblGGPzrCUFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While reading the CXL spec (both 1.1 and 2.0), of the DVSEC Flex bus cap (offset 0ah, bit 3), I see this:
"3 RO Mem_HwInit_Mode: If set, indicates this CXL.mem capable device initializes memory with assistance from hardware and firmware located on the device. If clear, indicates memory is initialized by host software such as device driver. This bit must be ignored if CXL.mem_Capable=0."

I figured that I would clear this bit so I can load my driver for the CXL type 3 device and also reset the memory active bit in the HDM entry (range low address bits). I was experimenting this on QEMU version 6.0.50 from Ben Widawsky (branch cxl2v4-doe), running an Ubuntu 64 bit Kernel ver 5.18.0.rc7. 
Here is what I see in dmesg output: 
[   62.234755] cxl_pci 0000:09:00.0: timeout awaiting memory active after 60 seconds
[   62.235793] cxl_mem mem0: Media not active (-110)
[   62.236447] cxl_mem: probe of mem0 failed with error -110
[  123.674758] cxl_pci 0000:09:00.0: timeout awaiting memory active after 60 seconds
[  123.675800] cxl_mem mem0: Media not active (-110)
[  123.676450] cxl_mem: probe of mem0 failed with error -110

In spite of these error messages, I could use the CXL memory without any issues!

My purpose is to load my driver on this device and then initialize and bring the memory on line or use the memory for my own software not giving it to general memory pool of Linux. 

Since I am new to this alias, and not following the threads fully (did do a search though), can someone point me in the right direction/clues?

My questions are:
1.	Shouldn't the Linux CXL code have looked at the MEM_HWINIT_MODE bit first and if that is not set, should not have complained about this mem active bit, assuming that the software/driver will initialize and then make the memory active at a later time ?
2.	If a vendor driver loads, talks to the hardware to initialize and make the hardware change the memory active bit state, how does the vendor driver, if it wants to, gives the memory back to the kernel? Should there be a kernel call for that purpose or this is very similar to dax initialization and so there is no further need for a kernel call? 

Thanks
ManiS
