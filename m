Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CBC77B7F
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 15:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjEPP3j (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjEPP3i (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 11:29:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E487EE8
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 08:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmfgMkJgpOi8DlFSOZgut7lHuPDESTDoWDo9FVRvVdosQT5jXmL6WGyOjzpR1Yt+rs7B7Krf+nP63Od7fnN9IpzDp/0+37ht75LSrIowALP2CjE8r5RqtV0VRzJ3mmt2+rQ/fcr73SFTV91nNEknvnHUNDc5UWW43vTn8XYCv70T3uTlIbKTztEoJFmNcdF72zB4Spc+dEqNsJMNAcLeb54cRGJvszz1+1+jFZzBBOCSiMRf+vkwDdFaViYltGRNz42xckM0QS1OOy9RhAeIsChibh9rViCRMROf4qiDFdID2ZTXLOCLH2hgO3CJEjAjrM6WcJyzmMHTSBsx2U8n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rptxG4ulVWfshbYPwj0KGXyroR1+uNkXB39JBMer0Bs=;
 b=azo8eSv+a3i94yWhDLyu6o4UAimQGovJlL89SoG1EVHlPuSIDB3PL3l2ENQ+nyWkKkl4K/TXN4q5DZbux8N6F0+D0y8uE41I3NJIU5pKN01XailVPsAzgBldC4Z6RLyZnDG5iAD5s/c13Y7F+mCbLcs/Vf2SSQfrRe0dZP3cQFcgNnxviH88tl1T7TcwmvSEeQWRpkoxn061/D4NLJRcXvSbKPQY6jQ1/7fsUNqr1DVr9a7HIDeiQawXyjBD1VFRXtYLLmM8uz2PBa9eMjMJGPGob1ajMcD46zx0vfLEsG3pV/+uy3wv+iuwI5N+szi7LXvjNmTG+NBPTQUrP7g6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rptxG4ulVWfshbYPwj0KGXyroR1+uNkXB39JBMer0Bs=;
 b=vfP1lzrDxZggVM7iMkKUmy4ErkUSMbxWOA26GblRzTfdXgskjKYlGuNSxitjS0imVvREE0i0ScfUxHqkC3nHhCiIzJhmLuqnr6qSdVg3raRLhViYE8WfbEWyid0rogecLAgcBbwjoFRXSdKtUsWQCrnbgUP5MOULU0fyrgNCWjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB4168.namprd17.prod.outlook.com (2603:10b6:5:295::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 15:29:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6387.028; Tue, 16 May 2023
 15:29:28 +0000
Date:   Tue, 16 May 2023 02:43:15 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZGMmA0Rs/9wYNxaU@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzQxmafPCCWJOx@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRzQxmafPCCWJOx@memverge.com>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d369e1-b7db-468a-c79a-08db5622564e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzUvVnJshnqOTjjsmZb79iP7uqwy76GrjY9v+8m6vqh85luYEPMCbAF43tJ5+Zbh4LwAhhFr5Wy3Tzgps2ObSQauNGLF6NxYytRRBbljHVH99bpgvToz0eyvUAi6albNbvfFbIyBi4VX1kcdtAgevfVCpT8o8fe6AATYqT0ReDy46omfo7HPX6EeG8FcUzj/hkDpY4o2ljPbivfN4W9rNF3FD3owROKYwAkNzOUEYBBvP22x4Cjg/APEeE+cmrhDZDJcCMqlcF/3Fv/58CyuBDaL2VNIGcwihy7SJbEJYvT8CdPZIbq8KvWtCDe4OdvRhC9+OSKYQIz+rAzYCdy0SzC0Q0QwQipXPHkrqbxnfChAr547+WvwYuGPRo8FRQjKnMk+ol1a4ACqQBYGdkbo1BKle6GuBQmPONJ5O9Wn0ciNSqz1k+v2K1Gqxmh0BiVq6uaQYvxoc5XXgnqm48q6oaimKnudGL+ZouGBuSAX6YsCAk1DttHGnb5C4zavF4h2LMiSdqwObCvaUqaGQjpZ8fY7rGOK7eGvYfX0zu5b6BlSEno/4hFM7TuqcXJdi+hT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39840400004)(451199021)(4326008)(36756003)(6916009)(2906002)(44832011)(8676002)(8936002)(5660300002)(86362001)(41300700001)(66476007)(66556008)(316002)(66946007)(478600001)(6666004)(6486002)(186003)(26005)(6506007)(6512007)(83380400001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFYAtYw8jAnc3oPylomidmdqayza+VcKvzhtXzyT0wIFNIgRf+EaztOU5FZs?=
 =?us-ascii?Q?ZTnSp1WWqfeCRdUYOsH38dfqXyZtu6LmZXHjaiUAkciV5GlLLMAKeFOJnfWq?=
 =?us-ascii?Q?auahGU6dBMztvhQyfsmrKrClHLLHlbLqjG/l7/pSKpIdLknfQ9x6DDE7mvUc?=
 =?us-ascii?Q?SHAJtAUX/h5RyTLbWe3NkmaAdNgl9edYILCFiiXm4WkVc3VerwhrgLPOuywX?=
 =?us-ascii?Q?XU3alCMFZ1E/qfbKuwtXDJHIJwidaAnZA5jagA/cT22iQRv8WBs9+bnMd910?=
 =?us-ascii?Q?O4P9BhwX11Z2NSHRpdUgYHZ8Ihcw8PtmgpiKPyAma5AMu8JInz3yPsy6qR9V?=
 =?us-ascii?Q?tLYeQEgPxDtlRMdFCXJ9sgVEeqlx7gMtThmGmLnVO40oJcDe4zpr6ypXJ9oJ?=
 =?us-ascii?Q?lkVheLfEcDmBN2jI2XWYH+stGPg719NlzibEtwTDA9qy5RUwtfYwGCbMSXu3?=
 =?us-ascii?Q?djjR+9OYSu9vM3tTw+BRiJnzlL/YRWiWbWUvVe9QK8ldX6On/2ji8+/IiP4v?=
 =?us-ascii?Q?dKn2BnLLRdVkWEMSdVuJ7jp3FJ8KW4dPkmbYbvO8xovWTKVftjGtoNk41x54?=
 =?us-ascii?Q?Xzlcy4cBZA6CNIa9fhWyU/SsVKDzBRqHOfgHLy1UIkiM7WfGhFtvJYBdhh2l?=
 =?us-ascii?Q?nhydRK8wjYwvaaXTj14Xe8zwuwcn/4HlavlxwNBHpEjADLhmEH/x0dlC4Nvm?=
 =?us-ascii?Q?pfu1+G7zDL2YHlZRJf/MFt+N7IVacIE0HvNqwFLws8rR8p3TVc2vQQK9VKvf?=
 =?us-ascii?Q?mrhwuDgtQXBFaHvlk1BlZgZ4ksDuEEbmZ3zVHcmbZ6yCdn2FeJrv9xScb9ZP?=
 =?us-ascii?Q?ik4nIoQUZ72A2rdDYTrg3Ymt0hrDjFnxNviVHnNC3wPNOBMHq6MlcRKi7aXO?=
 =?us-ascii?Q?Bq4GsEm+liJmMIk/jxMLC1EM6csQWVoZN1Kl5iHQJbO5YxjQqQj/Gh6kfFut?=
 =?us-ascii?Q?JQ9FxJCwzaBz9iLq9qRbRBKkxiXTymHoYdtEMeHGzbfgl1wvyQPA0aCz6gR3?=
 =?us-ascii?Q?cuV7TwYFAP+wob22WB0azl/ZWJtJrXLi5sd8NIbu4LvRQFLfPMup5qYzXrgg?=
 =?us-ascii?Q?qRTTmdou8RLQPWzeE+4rro3Dn2BtE/GBBnGrfzIDyi7KiRXpnO70QNFvA0Hm?=
 =?us-ascii?Q?/A4N4XX9kKAMmdelCd/yksNicNiKlUV9Gm4/KMPGKwcDHhQYrPEtchaxaU6f?=
 =?us-ascii?Q?lrEPjbPzwv2z07iKnJZ6DInFnzaW5W1NEr2yAHg5f8E9SYKYWv9bwsgrnPJe?=
 =?us-ascii?Q?TH9VMkoncTZ/PxNa1XaiRtVGnsGGyheVM2xwsgNN+I53fRiEPOHpaDrkoUNp?=
 =?us-ascii?Q?lUI3rqIMulpyuGgDUYTRKs6ZI5r/wVmfI0eoUPdJyU+1ne0chA2Y3MwouZxL?=
 =?us-ascii?Q?+zDdM0A7qFXw/JFMfWWDh8NKg2XUyhJ03TCq/khGK0iKNm96MU2R2sX2dFC4?=
 =?us-ascii?Q?RT7vxHpTT1Kd0yoqZvuj5ghsayTjsYAwOBPiWLbcKaTKsBh8Ak60mMKa5Xrb?=
 =?us-ascii?Q?dCcpeJ8uNbCRJDMbyaM5zSjMNBCz1QRvPb0UN0Dy07ZEnQBTo2U1qnHmdnhw?=
 =?us-ascii?Q?CmPmZZ5KDElgGjrnUn9+sCvLKoNbDQILzDZUkvFg/sm7v62h43jNlHDdw7x6?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d369e1-b7db-468a-c79a-08db5622564e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:29:28.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQwnNnqMX5G00USErHcI6+y0QMEHumN87oUgPhU3TH7G0ZUX/iThbED+PNd75ZeaDQCGwOLyyzb8GxLJ6re/Iv359WRqgbJYgWwsr6vUeyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB4168
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 01:20:03PM -0400, Gregory Price wrote:
> 
> Given this system is single-socket, and has only a single CXL memory
> expander connected to it, and that a CFMWS for 0-1fff.. seems
> irrational, I'm going to go with the Range Register is wrong.
> 
> > > confirming this is the issue, i *forced* the dvsec range register to read
> > > out base+0x1050000000
> > 
> > Nice!
> > 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 7328a2552411..6fc6df0f7b5a 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -340,12 +344,16 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> > >                 if (rc)
> > >                         return rc;
> > > 
> > >                 base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> > > 
> > >                 info->dvsec_range[i] = (struct range) {
> > > -                       .start = base,
> > > -                       .end = base + size - 1
> > > +                       .start = 0x1050000000 + base,
> > > +                       .end = 0x1050000000 + base + size - 1
> > >                 };
> > > 
> > > 
> > > And this resulted in everything working "as one would expect"
> > > 
> > > [user@host0 ~]# ls /sys/bus/cxl/devices/
> > > dax_region0  decoder0.0  decoder1.0  endpoint1  mem0  region0  root0
> > > 
> > > [user@host0 ~]# numactl --hardware
> > > available: 2 nodes (0-1)
> > > node 1 cpus:
> > > node 1 size: 0 MB
> > > node 1 free: 0 MB
> > > node distances:
> > > node   0   1
> > >   0:  10  50
> > >   1:  255  10
> > > 
> > > [user@host0 ~]# echo online_movable > /sys/bus/node/devices/node1/memory33/state
> > > [user@host0 ~]# numactl --hardware
> > > available: 2 nodes (0-1)
> > > node 1 size: 2048 MB
> > > node 1 free: 2048 MB
> > > node distances:
> > > node   0   1
> > >   0:  10  50
> > >   1:  255  10
> > > 
> > > 
> > > Basically the question is:
> > > 
> > > Is the DVSEC Range Register expected to be programmed by bios, and are
> > > not being programmed correctly?
> > 
> > This debug experiment makes me think perhaps the *device* is at fault,
> > not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> > to set up the decode as expected, but reads return 0? That's the only
> > way that I can see that forcing that offset results in successfully
> > talking to memory.
> > 
> 

Wanted to follow this up with some additional information.

The reason this patch / debug test worked is because the platform

1) Does explicitly programs the range register base with 0x0.

and

2) Does address translation on the root complex and puts 0-indexed
   addresses on the wire to the target devices.

So under this platform, one would expect all of the RCD's to have their
range register filled in with a 0x0 base.

This is frustrating and this won't work with the existing driver code,
because the driver code expects the device's to have the correct range
register value set.

The only thing I can think of is adding code here to check whether this
situation is occurring, and then attempting to read information from the
RCH topology to fill in the info->dvsec_range[*] with the correct value.

I'm not really sure what that would look like, nor whether that's a
defensible patch given that the spec wants RR encoded with the HPA, not
a 0-indexed address.

Just food for thought, my frustration is palpable at the moment with
this problem.

~Gregory
