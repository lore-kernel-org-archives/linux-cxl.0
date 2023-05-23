Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D459C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 13:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjEWNet (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjEWNer (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 09:34:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7145DFD
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 06:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+WMADGna4Dbhx7zpnmMtP+jy9mIemkhduOlFnMj/W7vEObhsKeBUZLLzIQckIH+5dXJ93BUPvCBaT/ejsvQo2rJ1ocg0iqRYy3TTyd2PqRB88KZh0RUEGP4nD0RsxPWvGQtZ1A5k8VZ6AgF9q+vwrU0mw2Uh8QQGO9UJBuFlmI17EyzOKLuXDy7gi0rBLWAckzFNJINZvhr9opvOkY4DQtQaKYciPhx7i/+d0BdNJFjpP2f6xVNX2xEziVtn6mQgKPchEjvAvXVfpLe52kZwz6aJH/rPpNr4Sihot3TccmCvhdmbc46mRY4M/WZ3M4dbNgikqDSjyA5jKNUbHudhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiBZe6e3zXkZWUJ/d+950Tws8IfqJRW3fGynlF8fh5g=;
 b=GM5PGTbf75mSSGdmP6Jxo4PAWn7+d79fLeGUeos00o80v5UM/mzCck6pYchYyopSK8CGjKfGOEZ5FeD3/MyU/OJOBDslTZXc42Wvq/f4FxoKaXeRTWJSiARGvutyCrVuGN/WfC8h1NEiDG+QhFtZEF8o5eTt7/qQTIAjCOcfSlTV3/+HbSlyL7JfHQ7i+rQ6d9mfAv42pvKGDOZID4MWmd8ou/RtG2yA5ANNukVQrqH0PNs7mhX1F18biYNSY19DJX0S7l1oPjfscQapx8OPjYSLEzJE6aymbwzkqZ6YqYS8OU2q05eqMCO5rUicjoUfZEjWHzFeNW7u9vU1EThWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiBZe6e3zXkZWUJ/d+950Tws8IfqJRW3fGynlF8fh5g=;
 b=RKsRoG5GDQiVc6dISAkCq7h0PGh1R4Ra8KZD0/w6pwAR/FL1DmQdCkSLUFqNKxJFth4XAdlUB0XVpt9acLkIxX6eZUsin90wz+XGrAjyKS9HFJltah4Wi9rTv5JSJu1fbh6W7RHBTDPOmFcJQKurl+PfbvNF2+E43aa3YF8UP09H2EBIWhTvCNhGYoMvrEdN3pGhXMRs3at5FRA4HEkpUZXfAo08tkKd7sxriVdDoeQvnFHfISRzUH+1BS1Wds6RAuZ6BkGaO9HedGPdv+tDu0bm6QhWO9cPXdzp2doVp/VSTnUDJIgT6VT2LJeSLMuH1njEyOppmr7er+UnWPuyJg==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:34:44 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 13:34:44 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lA=
Date:   Tue, 23 May 2023 13:34:44 +0000
Message-ID: <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|CY5PR12MB6347:EE_
x-ms-office365-filtering-correlation-id: 7a03622e-5a5b-4610-ca7e-08db5b927833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTgdJTQoNzmrLJ+cOtLzgow6CfPFuCzRevsX5vEP3XmBufdLWLtyXRkVrh7fIXds81vqB9lVr226MvkuIcfeDrp1hOUu41gJx5ZD2+17b2lrtESzHiQtfGgD3sBTAVUW+CE0k5H0guAwcBCX25g9N9mA0oZSyabLm2/wxAzrCYh+IVUCPFsNOQeG/o0jgj8ENcVEvei9NGY9fg5CfrHZxczDHqSd3v+E6xsxCtjCCXzBXvQTVMXg2tL0jDy+MZGlRqMF0UmUiL/bqWa8iOzmKiobZ0Id1TfUK5ookU5ySPPQDELJKKZzTLxNmTb5klKGoRTuIQmBJL5SER4ApsIyBBFtsT1pFgZm6880YoNS6BHxYR21j8vdo8nl3fgiKOIpo/L4BTGKuLCerBSeLfQYv8lkcU9cP0eCcatRGEhCB8JPDsn5K0NZO7XNOXs739GhRiYkfVnbfCr6SP/ur9cctummZ2HjG93l+4tMHGGlj1baEzwjFUrvRNV2hnDXicCTvpplMS11IaZt+Vco6y5Ajk9HN98jQR2cCnLXDtguZuJ2jFa5iEvLqESdOhaZ7bv/Lomp3kX1h1eUMPUBf9MBEB3Tfo8zuYNRydO123A95uEFytSwkTbnu43PAognqji7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6506007)(26005)(9686003)(186003)(53546011)(33656002)(38100700002)(122000001)(83380400001)(2906002)(55016003)(478600001)(316002)(71200400001)(76116006)(66476007)(66556008)(64756008)(4326008)(66946007)(66446008)(38070700005)(7696005)(41300700001)(86362001)(52536014)(5660300002)(8676002)(8936002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cZx84r5Bz2fmWif5Tv1Zfs3lk4SVf3CA51H1/br+3LpDcEVsBNPWRqi8rzjI?=
 =?us-ascii?Q?a3x+0al/KHDyhAd0JWAe1cr2RQUFnPEGaHSGxK/qpG3NzRfhXiPFjBZwZDGR?=
 =?us-ascii?Q?XSgbHT1aVpsCI3YI2KvB6rOZTummNSQ51hyrw/Qaytq6T7fSd/S40/i4GUqs?=
 =?us-ascii?Q?IRFafT2IGiEJ7P8uGbOShF9J55OAtFLvRV/878e+5ZslJwt2bjl3kNq8wQ7I?=
 =?us-ascii?Q?fFEX7GK2JNBacwknbw0kgdbtcVPtMagI1BRvTR9hOiQtC1Cln3LbPW5arRYu?=
 =?us-ascii?Q?Ai7KorlqR74ZHOtm94hGqgKafkP2w4gNpHO5Sbwjt121wr0ehavzx20zvl/A?=
 =?us-ascii?Q?OGyzSMyslw+pwnHaRJp9+XloypK4lfwmMajraJ+EZQEamj9WIua8XlySBPZ+?=
 =?us-ascii?Q?Kh06EF8Y1tEXGCFnx8i1NCW1Y5+R9I5Ci7Laps+c3EJG72bUo7lyYvwFyWFC?=
 =?us-ascii?Q?OeBo/1ybL6IYDBFg+wJvhf62gjvxF4N270FBpURvluTcGqRfdStm5Ez73g6n?=
 =?us-ascii?Q?b3r6ztPaXcNP/jQJ2vIOJmnf6JaehlMGwMdtfXMTa1Xx/TnJqSWIVUoWOS2R?=
 =?us-ascii?Q?zaSIlp2HGUkEy8i4ZELg74qA/G49AbEC4zWQzCv7jyThxz+X3uN8QhrGQvjm?=
 =?us-ascii?Q?azNBYJkBtkMIH1ugYoy9jQrKLYcC+r0PX7NbEHTxvL/eAyOEWLnxQm9OpNX0?=
 =?us-ascii?Q?QJ8cEX0NgOonTjVN4R8ph/+4D7HRWSk9qo9p9kjGN8lsKChch7eHCBAmbg63?=
 =?us-ascii?Q?L495ylCgmwXhFbSXYgmTbtNqnR2aMgdD1RRxSuEAjyU4XYkggXvivnSzCS86?=
 =?us-ascii?Q?y6f6oxDkcaSQKGAJaHGni7tfcur5yafBKau5Hvb0bOJal4USp3Xr+7f+md8z?=
 =?us-ascii?Q?VRTZYuWhaKdvAHo80Ovi+KojSk/bDHLqE90ezuc976mZiviGzTVoIhIBFA/8?=
 =?us-ascii?Q?Xd2ZC3jkKVRTwX6vANhkyxFa7q/Z1IIBgspemUPuwLGLaGN9NNuoaj2kYbRD?=
 =?us-ascii?Q?1Dnj9OZeeBhp3FYwaUj5mMpLTyKWW7Ea7L3h1HOHGyKTCie6kQKwN3XdspDH?=
 =?us-ascii?Q?HMr/LY+DS4ODtIiCiaH6VqOso6xXPrScahbUhvqxyNT6ANJzExPrIPZoMbLl?=
 =?us-ascii?Q?knIjjKTy+F2iz3kVG5CX7FBx5SzX6+5ZmpWG6yx5KJCTzU+rLuVbrHBxVLkU?=
 =?us-ascii?Q?aBVX4ZlU74ejj5Tm4Iop9cK0oBdFWzH0ES6AG/sP5kvsSjjBc7Ap0n+ze/Um?=
 =?us-ascii?Q?k2NlCjif1qs1e+nO5v9N/FF389PFAWhkxkArFDgnAuMnvgGvfgxMvYTNjjZ6?=
 =?us-ascii?Q?Fe8uEroGlnBPxHANZR8362I8GBveU+pgNQUw9lOoArb7Sn0iFfOtj1H7UcMQ?=
 =?us-ascii?Q?Htyo6/BASDW6RkJ7uHmbNR0U52RqSjJD7qXIjRWJlzJROKlze06k45loeB2g?=
 =?us-ascii?Q?mZK6GxterUYc7FdTXG38YvnRycDNcbkaRGbEGBH4ve3gRUXyJFST2yt1bVVy?=
 =?us-ascii?Q?ImOcs9bsq0Bhx9T0z9TpuTJGRhOTw27zfUe+Gsj+GrEQiTPt0PIazkL0TGMa?=
 =?us-ascii?Q?fJeWpGARCGSZFh1oarI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a03622e-5a5b-4610-ca7e-08db5b927833
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 13:34:44.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQqjfORymv3q2mNBUNxdCLJli1vHd4aRLoKjyn+QVKDQ0SimK7Zyl7HpE2zEx5pc3EvhZ8aQJj0XRN7OBu0h2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,=20

> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Monday, May 22, 2023 7:12 PM
> To: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>; linux-
> cxl@vger.kernel.org
> Cc: 'Dan Williams' <dan.j.williams@intel.com>
> Subject: RE: Questions about CXL device (type 3 memory) hotplug
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
>
Is there any notion of a cache flush when memory is removed (or in future C=
XL reset)?
Generally, CPU caches must be flushed when memory is removed because any ev=
ictions
when the memory isn't present can cause async errors which can be fatal to =
the system
or at least to VMs, depending on ISA. If the kernel does the cache flush, i=
t must be done
with only uncacheable mappings present to prevent speculative fetches after=
 the cache flush.=20
Even so, kernel VA based cache flushes will likely be slow, so may be bette=
r to have the notion
of an arch callback that can invoke firmware to do the cache flush.=20
Perhaps arch_remove_memory is the right place to invoke such a cache flush/=
FW call?
I think the CXL specification should also address the need for cache flush =
when removing memory
or doing CXL reset.
=20
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
>=20
> > Q5) How CXL driver treat region/namespace size against section size?
> >     Current x86-64 section size can be 2Gbyte, but CXL region size may =
be
> >     able to smaller than it.
>=20
> The section size is still 128MB, the hotplug memory block size is what
> expands to 2GB. That size limits what can be onlined via the dax_kmem
> driver.
