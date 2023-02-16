Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95227C636D4
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 06:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBQG1A (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 01:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQG07 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 01:26:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13BB59B44
        for <linux-cxl@vger.kernel.org>; Thu, 16 Feb 2023 22:26:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoyTEec3z6YDGZK7ithawGFHzF/G99Vp7yc6OHxjeXpqw9cueJaxmxF+uJeUQvY7TG32tFHkpCjR7zc6at829aiqzZeEuOSbOc8Kl071TimCuP1eohiz/L5mUgbG1/wCZy+Wh8rX/vn0qvrbR19eZcNTEHCSSb4LiDGtDAX6o06/Utl4UM8cBkC29QpvwfEfcjgDpC8NpRoad/QNYH2gRJw5HdjzX2UrIFFcLO+3TWCJMRhT7g/1R+wSeU8nxML95eI2b3Pp8NjaX75BDVL+kmEuJO51YF2vmXedAQxZQQls7wVvX01n4pcSA3b6VxT6/tWyKsnCEmkDlFkxDNRy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKiZfaz4847OyWylB4xD1sEBCjoizgXaSCvNDES1R90=;
 b=aC3rmrMJqDrgEMPwVk7LXN9TpLfE3rXJj7jxrEIj0QihsEuQj9Ugc+YG8NaVcB+vZfPWys5qnP83OJ3moQdNJ5qvIGCC1HGbKXnD78UUuJsy4p46Tj8v79DfFzQZODBgxY0YzhAbdN5oElYa9wScdVhFHNl7hPlAJuY8k21l0X35HXLJTwjOos3Kwg87ayDIlxi6qn/rs6Z9M/nCAhLCMZUgTmLGlsCaGJZ+k263wrxK8zqwyd/AxtuphYT3WzIYqeCGPb5Lr0KzW41v4B0YO0GBX20SOosaggrac+2OyWLaHzGgCipA2qnUUVWoQaVNFel5Q14ZB7gSr/aucXn8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKiZfaz4847OyWylB4xD1sEBCjoizgXaSCvNDES1R90=;
 b=CAcPe5w+aC+LFNqHW/zmdL0KJw56C55De6QvYfo/JnkB2ULQzNZpQ6nbM37KtpxZPxyrk1y8C/oK6s/n58+h52FQEOKapGvzPBs+idIEo1cgTIyYBsoMi1NIa81ju8B+QoTwqvTeXMpmPX2E78Rwenk+v86SrldXaAHuGfUiuJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB4597.namprd17.prod.outlook.com (2603:10b6:a03:35a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 06:26:54 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 06:26:53 +0000
Date:   Thu, 16 Feb 2023 15:52:31 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     zhiting zhu <zhitingz@cs.utexas.edu>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: CXL 2.0 memory pooling emulation
Message-ID: <Y+6Xj39d2rxnowRx@memverge.com>
References: <CA+3q14z5pa1RPQuMB=6foVGcwgCHE+GME+zMES_adpVoDYCsvw@mail.gmail.com>
 <20230215151854.00003e34@Huawei.com>
 <Y+yhfFaQ4Kky93mc@memverge.com>
 <20230216180057.00006c49@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216180057.00006c49@huawei.com>
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0df6aa-1837-4a02-35b3-08db10aff5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrN1841WKqffuNqFWw1PFyUVTkVNH9hnDxABWkIO2V2pAqPOl0qxeGCPDfI3QJ0DQNT1y8frrfWx+guYGJjQkNvpVPb5C6ZrCADDyakoAJkR5qqLtdo4ObjXoWeqK4qbngg0bwy8kb63DqQDpGNcEhym51sVcN821Vpf7EQTe1zHMlWA9BxlHPFuHR3DP+HQD16g5UuM54fAexvsWCRUbhcUvEfX1zBYW3NEnLV33LBo3u0ekXx4NMw5pRWeoePz44JFjiAllJgfhZM9fAFICC+TZM423ZFTwQPTTtjR6HKzE2Pnva8NHFWl+tHLl2MWf5/9Z++ORkoDJhZbdWx4rFCnLCFVhAkluFX5UBApFKfCJceIEiT3TZlQcUtvKoj//NsI+yp2y/uYqlpkMDzL8+WQOdR+YxnpE6ttPWIoDnv5nQwfxkObnkZs8SUG2NxixiRVrJmYSdglx6OvN5OGvDxYAawB4MOK1rh5JMOh3mSLMBR36eNls4PpuXW1BzG8bbOLBQINwjxceogi14L05NIjfbIMMfSPFwhep2Ic4CJQNkROHSy9kSUtlsgCvj8vv1dzJKKws634LjUN27+iFFpM4bpqX9yK2eIsTEZ0hRzD8k5eAL0eXKUV0cohASHceKQENa9hP0cs7R/XUM0lBBD3NznMyGPXkw6+wNEh/vtzdkPDPvejt6o8t16B5K7L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(376002)(366004)(346002)(136003)(396003)(451199018)(6916009)(66476007)(66556008)(66946007)(8676002)(83380400001)(316002)(4326008)(8936002)(5660300002)(6666004)(2616005)(41300700001)(6506007)(6512007)(26005)(186003)(478600001)(54906003)(6486002)(36756003)(86362001)(2906002)(44832011)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r54xhZjctDA4Ie4ozDVJd4qLWZgolqXCfKUl6iqV+Rfw7hmdD24RGyzIQiK5?=
 =?us-ascii?Q?4njOFZyT6FLd8fIRKsaqeMzv6fmCa7lGA4bh1qAhYpxqDPFEP8L3H4CUgPXS?=
 =?us-ascii?Q?2xyvyxTgpBjwizle4Ci/Yj6TIYqAGFYVgfur40i2DIymhNSHiMZ615f1rXYH?=
 =?us-ascii?Q?Q+o/UiPsEOQQcHuansVAFNvGgaAsRFScLFrpA6Tz8HeuAXnBd0H8APnAUNGk?=
 =?us-ascii?Q?QgMJD7El7DiXB9vLnthUOJKWkWGx2y2+mVM0TeKe8RV9BDDK6BIzFQWBxuu8?=
 =?us-ascii?Q?+gFE1c0NFBE51F0Chq/oa4U/Ut6l3FiRljMTeA2fKtJk7a876VcUaQnXWV/l?=
 =?us-ascii?Q?fM6YRSrledGNgCaxbWQt41+Je6NvBshCOM3v1TG2fpbmQ2zcT9/33Z9Kpoo+?=
 =?us-ascii?Q?UcisoYCjNbh9xJU9/TaMT19i5TQ4/thW5pdHnYbXogyZGxTTVSMDxWnoKhDw?=
 =?us-ascii?Q?Ceobh+nSar90eBTjcr+Nr8mtVlzVFWgBRcTLy2kAKFP1PtWmzqLcpFtA1H61?=
 =?us-ascii?Q?PxUCArvEaKFqfvT5qCixP4VrihaC8O3TJ88c1GQKuriY3zr+RJJdmp6KlHyT?=
 =?us-ascii?Q?TEy8g/t1bsy8lFnAT9Ln9Zc1dKyWDyYi1s3qtMqPGqcYQHJKHaQetGCLvhyC?=
 =?us-ascii?Q?hso2d9VB/MTcO743yJWko5JoDoWScqOxPe8ot3xz1bujSSrU3QEoAs2P9rII?=
 =?us-ascii?Q?TCL691GDeGnI+v1cFmCikCDFN77q0W5wvrxgAjdZ1AASfJP+UL89io7N9XK8?=
 =?us-ascii?Q?f2sWDfcoaGXBufIYSueSFK9ma3cqEvt/Z0gfmFVVyq+CiC/fbxOCUXiWpmXB?=
 =?us-ascii?Q?b9+TjL79cwEJ1YkuRzvZMey+VPHIHPL++gHEpMmLA0oQ3quH/ZDUWoJqJvII?=
 =?us-ascii?Q?aZoMh7NtHUuDNvCNNYNRDsXikpoNdL+jsPJhzOmDJ71wPPBJWqlyfms7FFID?=
 =?us-ascii?Q?fW9UPyy9i/XhXAdIADLolENh4EJF/s8lw+/Pdvct40v3x2JfFHEdRzVPFpAO?=
 =?us-ascii?Q?ktNKmXZ4cqVcUW1Sp5dwb+3YyY7tbN8uvvmmLOW97Ff/nyGvmcXspyhdEGZQ?=
 =?us-ascii?Q?GZbDf9Zo2kFGlnB2mUVT/IUTBetUp4EW7EVcPqNWO2VRjpVdAeRFVBlOcXy8?=
 =?us-ascii?Q?D289HS5xMf3EmMVhM6UdrHezpPPMFS5s4BNrL5Dj5TYKte6QZWp1FCgptQ67?=
 =?us-ascii?Q?oTTVLsVyPlUfcGul4UxzIgOxh2tmj+KR0uwYXSIne53MRp60hRM2y2F3/F8k?=
 =?us-ascii?Q?YMkPgo1R1w2iVuzvz+puHXhQDyud0hW8jayRfMAkyT4HQI1TJgHXNHO0zSkP?=
 =?us-ascii?Q?fJIGlYLnFsKjZ5UIrWXmeqESsrGeLOTIR20nBsnoIE5NGeEUDuEomShXnU32?=
 =?us-ascii?Q?FYOvpEUD59YOM+I7afp+8lFnf8RV1iQ1X3DQY8dydTEieh4avg/6Kkzn8WmI?=
 =?us-ascii?Q?9aCEpHqCk5VBsoOU+Re2fkNmulRt/XBo/uA/C3pK8pnF8A4HOV3TNz+WGfpw?=
 =?us-ascii?Q?LxmWq0PlE+1cbl9yqIkW8WPcI9qRIwGkFDsYOIbcYz8OdeKZVt7bFYnkWxKD?=
 =?us-ascii?Q?7tKj2Rb4+s3nYtkCXkYin9t8juX84SZevgkxwlFU/9sgHzwUjuen3YTjFm3S?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0df6aa-1837-4a02-35b3-08db10aff5fe
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 06:26:53.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYEmxoNpkWB6ZEAz0E39ohyUBLZrUZoff24hMovvTKy2T4lsNtq07C0LmzzWav7uc9eUuXWvCNPCJ2Oh4o5YWXZI2cxhHVEzYRHBFDi7+BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4597
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 16, 2023 at 06:00:57PM +0000, Jonathan Cameron wrote:
> On Wed, 15 Feb 2023 04:10:20 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Wed, Feb 15, 2023 at 03:18:54PM +0000, Jonathan Cameron via wrote:
> > > On Wed, 8 Feb 2023 16:28:44 -0600
> > > zhiting zhu <zhitingz@cs.utexas.edu> wrote:
> > >   
> > > 1) Emulate an Multi Headed Device.
> > >    Initially connect two heads to different host bridges on a single QEMU
> > >    machine.  That lets us test most of the code flows without needing
> > >    to handle tests that involve multiple machines.
> > >    Later, we could add a means to connect between two instances of QEMU.  
> > 
> > Hackiest way to do this is to connect the same memory backend to two
> > type-3 devices, with the obvious caveat that the device state will not
> > be consistent between views.
> > 
> > But we could, for example, just put the relevant shared state into an
> > optional shared memory area instead of a normally allocated region.
> > 
> > i can imagine this looking something like
> > 
> > memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true
> > cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,shm_token=mytoken
> > 
> > then you can have multiple qemu instances hook their relevant devices up
> > to a a backend that points to the same file, and instantiate their
> > shared state in the region shmget(mytoken).
> 
> That's not pretty.  For local instance I was thinking a primary device
> which also has the FM-API tunneled access via mailbox, and secondary devices
> that don't.  That would also apply to remote. The secondary device would
> then just receive some control commands on what to expose up to it's host.
> Not sure what convention on how to do that is in QEMU. Maybe a socket
> interface like is done for swtpm? With some ordering constraints on startup.
> 

I agree, it's certainly "not pretty".

I'd go so far as to call the baby ugly :].  Like i said: "The Hackiest way"

My understanding from looking around at some road shows is that some
of these early multi-headed devices are basically just SLD's with multiple
heads. Most of these devices had to be developed well before DCD's and
therefore the FM-API were placed in the spec, and we haven't seen or
heard of any of these early devices having any form of switch yet.

I don't see how this type of device is feasible unless it's either statically
provisioned (change firmware settings from bios on reboot) or implements
custom firmware commands to implement some form of exclusivity controls over
memory regions.

The former makes it not really a useful pooling device, so I'm sorta guessing
we'll see most of these early devices implement custom commands.

I'm just not sure these early MHD's are going to have any real form of
FM-API, but it would still be nice to emulate them.

~Gregory
