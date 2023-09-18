Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C60CD13D8
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 16:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjIRQ73 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjIRQ7K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 12:59:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488C9D
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 09:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clOFln2z1U7l3el76QMfszlgL1wG2X4iNjSfSFxSApQYq2FMvskiSxjmam4ZVOoXoG/ZWLRfT+7K8ZLWm3bjQEAfipfjNIUh9pRWyMhH+ga4RUdnxlzTSEg9nQad6yil3Dhf21Bt/0Td8aUJoJSqEgm4XF5WfsDdBUtbCMhJPHbdqKB3pgE54To7cOM53xnY29HhBNab3LRz5wwfEHG/Acf47KAyUfkn5aMzwDQ+xu8sSyuMAh2qoY2xKOkcUnEYdcfGBpzWyxlfPKzPaY5mv4h9WhknHLy1C8oo8YNiFVSXZ+bLq/fz+Uvr7pOWR/tnzQ1PeCBYpvXZXVQazr99/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1wdZGnP+4F49I0pNQ2O//zcVvNrYlyT+k4Vq1mpibo=;
 b=gZksqbX2Zwa8bQ0uRqWnUzTt2ER3tUtSI7DNIaRWpjDwrqlrGa0DdSKnv1CAWM1Xo6fzXlsLwxleBEVoYHp8vDl6vHb0Lt/olfJBeyK0476HX/tpyKilUbCqICxwsx4+HcCgAsO6PXwPVxqQ4DdUGTXu/B2N8h5yKm0UfrBKoUqMD86M86dP6K82l+9m5zVp92ZgDWJrEZcRfaTbYwEtUPhOFC6/4XEUaxfLI+r5Or6LzesX+kYP/lIgOglIUpnW8PotCkC+gUkVNVdfWQMBaHRPMX2Bc11fTuejIXH2I39dkbsC8Rcv7PEz/FG8ZtxCsjBEaQ0ZUOA9FVmtoASfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1wdZGnP+4F49I0pNQ2O//zcVvNrYlyT+k4Vq1mpibo=;
 b=vLWbbyt2ImPJd2nhB/KmbPEkxK5G2v4VyMFkh8JPz1YbWnDKAFeWHY2I25TPBdvZbSyY4iP+/KlAtSsuhaYWXtp98y0FwhrQylvKwSILHbmUdRcE4d1BCHL3ZsEzFnb2H6Bbks0ec0ugssce9UbNJ5BVNfK/Py4bb6gPvmZXG7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN6PR17MB6993.namprd17.prod.outlook.com (2603:10b6:208:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 16:59:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:58:59 +0000
Date:   Mon, 18 Sep 2023 12:58:55 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, fan.ni@samsung.com,
        dan.j.williams@intel.com, alison.schofield@intel.com,
        ayush.m55@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <ZQiBz+sKyEVczJ+3@memverge.com>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-5-dave@stgolabs.net>
 <20230912130425.0000569b@Huawei.com>
 <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
 <20230913143028.00003fec@Huawei.com>
 <fdylnvbildmd5oxl5datqz63awg2nqacwavif5yhlvbq7qnnoi@bdikubr3uky3>
 <20230918121128.00004d1e@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918121128.00004d1e@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN6PR17MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 19722d20-54cc-4b42-d9b9-08dbb8688d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VB5LF0wmLuhccr5FkoH76CPfMOcGfQnRigrTIwqSAJfHWeAXyAssGE6zzIZRTo3y2KhM7cK9t4bL3vUPYTI52BM61vYH+6E5Z8Gtnn2iLjYRJiKn6aUV/e9xjQmC3pimWBsGHD/3T+5jAZvZi5P2ayw5gkrVF9ahpHXNAxyfMnIrDqNjT+9HqrkAXMEZQQ5vcGSCwhHC6+UjFoPt9l4Ri0XF/orS55GH75wJSkwE0F9zGMzBS+xFSnGFnRZWYsmDjfK3LBPdAGfIqSmqnBgbtay6OZBJZjhy24KpxpV0TniKXrVIrNPjFdPxc+k7yHgf2nGXr3X1eEFIrtIiavMXrzYGogJSOWsbdaW4l8QQEYyffV6Sruf+9hx4TdS0LW7uirEN/r2+zWrmrPVe8C36gOO/KSQ5c6MfseulbthYEHhHxGMyWzPHTfNV1931kyr9tIk+V6f/NunLq3oCVxX4WhXM6xcc2gdbmL+PdVnT1wT7Bp25WI0uK31dgNQ+6q9NjeDV29Pf26xvnm5M2AKPwe6Lgr6NaL6HN3Bae8DOJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39840400004)(1800799009)(451199024)(186009)(2906002)(8936002)(4326008)(8676002)(44832011)(5660300002)(41300700001)(6916009)(54906003)(66899024)(66556008)(66476007)(316002)(66946007)(478600001)(36756003)(6486002)(6506007)(6512007)(6666004)(2616005)(26005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FFNxcpe9uj2viyv0SZuHyGJPmSWoQp0/kba9RIF9QAwFfu8Q4XiUPuL//Wg?=
 =?us-ascii?Q?31LHwh7C19Mq7l94AfGt0aTjbBkqN8JKLPMOdAxnlAc+AHr8eRB55e1QCSoL?=
 =?us-ascii?Q?sPrQJ/BTVfHSo6SHZ7qx/BeXk3BoJvxfjiASYAQBBfMzJKy2sAkFuFOpRIKc?=
 =?us-ascii?Q?dn4UgiYFx6fpn8ab4+ydmDLOWxylSWl7fcq2UTx0AjSeog7Qk0rp3RuVmFH5?=
 =?us-ascii?Q?uCJo8llRA0ORWD8l2Jvvviz6i8HZyX/tMaiQs82ruOvrj88gDLysX2LtjIHk?=
 =?us-ascii?Q?fiFTqKudso2pHnyPt7HT25b6kmRzpLD4sMyX0xenoewlueXn7SFmlbOkr6Rj?=
 =?us-ascii?Q?/TxNugfSj7MwueftDPFI1RUngRT7dT02sKRJ7dLJlsNDczJTeqBLFmJupzNL?=
 =?us-ascii?Q?2kjLhq6beeSMpQtcM+O7z03EhVIaYtNlwp3ZONomm7zRL1wT4+puvRJGw75u?=
 =?us-ascii?Q?fs4c12IH/IB3mUVuyC+sYFOc7OC5xC/+2JcOYUoNN91CVSZe1H/gO1h7779s?=
 =?us-ascii?Q?Y964tLvA4xm1WZ9FqhSZ//nTjUtg+e9c1QZ5+psIEhBBi+2Ni1o+jqKX3JUY?=
 =?us-ascii?Q?ki00wuC0zwa+aC4C/qGKhpsCOYLiBJrEMsRXOpDigfDrN2qnx2JswkSTh0Nd?=
 =?us-ascii?Q?NoXCLzj5kcLDoJ/FaIkP+roaIrBbFVZkZ9qYesIe7mYV5Q9ucPwgxwumTnbX?=
 =?us-ascii?Q?XedYCXUkApXp+JZpVjapgVmKRy392dTI3Spbe27EPgIkOkOP4cL/oXnbYXx2?=
 =?us-ascii?Q?A4HgdkYMY7e2dAQO+jluu2PiS8fip1rc5fUEKJkBAhN4mAnlrSElI3DLxv56?=
 =?us-ascii?Q?dSvGvBXb3HIDuap0zu3NejZ8lSo1rm0NjnBkv+fFFAl+Qauwa7GRbUBtfwEz?=
 =?us-ascii?Q?9kTtPXpJxxLBOrJo/Dvp2vn6cipy/lBQdm+01b716d8ueXQ9chWRFKloxkSO?=
 =?us-ascii?Q?pAGW+tnJ2L9gig5oiggRLmVkqjQG2++wULmRfRwOfvhIpUFRdO2pRHJFsQC/?=
 =?us-ascii?Q?PIX/ixRdj0ZIJA0w6oxDsxfN8NihJldbv7tM5LIa7fOfnfmvClZLZ+QoLDvq?=
 =?us-ascii?Q?hNj48rzE7TTmZc8dyWMxsnbLEgz9/K6b0/wjNvZFR/LlGMLvqO3rl+zlFsbx?=
 =?us-ascii?Q?Pe0Ub+iFXZ7eEzRJZxITyGg4YD/2CF6RpUmz7bkQIfBR09tj98VlZQgEotHE?=
 =?us-ascii?Q?pp6aEoFxXvSz+gm9ac14kWvmRjRIBlVgauwiCmoX+gh4HECa1oFFI83XtTbT?=
 =?us-ascii?Q?e3jDebgB2rk8c3h0abloDWc5/yrrYQkHDgGCsw5asvA2rVXAquV6qGhv4W4I?=
 =?us-ascii?Q?+hNXk93daPosInlsKWm++Ekg0AhFPfZpZXHmu3xXRrdP623G3YbnZPMXCHPs?=
 =?us-ascii?Q?f3uRFQbXL/rRNr89aaBZQx3qgIB9SoOWGRGArwjj4vq3P5yHHd9FIorlpHn1?=
 =?us-ascii?Q?qQAAnExC25xQ7rRoWDJxgtPv0rZvJ+mfwxdxV18dYJZM6vsEv4cvyUipbRPi?=
 =?us-ascii?Q?C/RwXqp8zRiFaA8CP4s6QGwXpAF3u/4k/50QBqJG3WAwImIpyoVJJeSA/WPq?=
 =?us-ascii?Q?Vf2fVQaGFIV4X0xm5iFJac5my3yS6E7BEil2hZkMqRUFqX3i03hz/a79m88J?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19722d20-54cc-4b42-d9b9-08dbb8688d76
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:58:59.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buPT8X5df5yjcOhZGRI/xll+mDL07pnz+kF7QIlqoeneu0OVcO3sNQFcv8GJE0CWoLiq9pBRFOjzY5Vt729N8MkY3v9efyu8PFIoZvi5BRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR17MB6993
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 18, 2023 at 12:11:28PM +0100, Jonathan Cameron wrote:
> On Fri, 15 Sep 2023 17:11:27 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Wed, 13 Sep 2023, Jonathan Cameron wrote:
> > 
> > >https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
> > >
> > >Fresh and tasty.  Includes 3 series that I've posted with the hope
> > >of them merging soon and another one I'll post in a few mins to
> > >deal with over long lines...  
> > 
> > fyi I'm getting the below:
> > 
> > /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
> > /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:477: undefined reference to `ct3d_reset'
> > /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_exit':
> > /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:466: undefined reference to `ct3_exit'
> > /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_realize':
> > /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:428: undefined reference to `ct3_realize'
> > /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
> > /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:478: undefined reference to `cxl_add_cci_commands'
> 
> Thanks.  I'd not noticed the niagara stuff doesn't have it's own kconfig with dependencies.
> Gregory, want to send a proper fix defining the various Kconfigs down to the actual build directory?
> 
> I'd guess the lazy approach of making CXL_VENDOR
> depends on CXL_MEM_DEVICE
> should work in meantime.
> 
> Jonathan
>

woops! My bad.  I will push up a patch later today with that + limiting
niagara to linux-only (already fixed that up, just haven't pushed it).

I don't think any other changes have been made to that line, so i'll
just push an update to the Niagara patch itself and you can hot-swap
them on the branch if you like.

~Gregory
