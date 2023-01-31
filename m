Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC5C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 03:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAaDpj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaDpi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 22:45:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5827EFBF
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 19:45:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiZOeJwoDd4aoKcecDay4jlQaGOnppa39bm2gGP+DQfAZrmgpS1z0FN7lJrPiTqF2OcG7kU7E4itVivr5YxrLZseRWPK173U1+m9AYYBhbzZ83rLcUl5T0Kb9h2vwn8jb3odaYm4HO1hp/+DNUlyYt2K29s8cdupjqglpcAC/cHJjCPaPkpfTECnOn8fA7kuazADSGQZtyimRku5Ojernmhz/UEXU/BfCwaXBcSa07yG1rxlb/cl2UnxQ3Y3quy3jBRYdfvR1udEzowalX/fFExFrrR6RbQzyFdKLrEuaXdoA+cn8uxO9vrg4RnN9sF70mWQfzproR3z3X+loltFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK7sXVNuSx6gxLB5UYGStisiAC1FdJ3i5IDeQMpqQNQ=;
 b=IFxAPCw5r5OK7EV5VOc8iFLJPTKzN3uHdqDp8oIbXXKlI4RlSSkKvWNbicTUvbKzZ01CBeCmsPgB+yqiYJ4RjQMl6e2/AnBhX8FnYm3IT7kwa8aoVUZR7x6wGRXRwbHcYr55rmV0eyR6l9B4Xrqj7+4hSKcvuAuOzwwrovJksPNMAFWy/6PS2T5j3vQPk2aUJIOArQvTO9XkQnFuEOBt2YSW/w+IoajX3luZ+U+fpf1h/qWC0VbpmwM07T/UaTGHVI9OZm5m/1PTb4UeY+ITXBJcL3pp5zp5vdTkFG6vUHCQLxfi9JAqj13DhTwTKtY79T8nCCFKsO7Tb3cohhHYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK7sXVNuSx6gxLB5UYGStisiAC1FdJ3i5IDeQMpqQNQ=;
 b=JKun58alaBmDl3Un2MU9DWA2/8Zi8HNgrZG3TRoQu2frZQQFCUjd/qIH5gYELvqD+ldIH6+Jtkt51wJ05wCB+HNZGBk02JoXnIWcj2liDiJksDkIpFQP+kAgnCqeFohGYliP0XeEFJ0Cg0CdEKYw6Mc0OfTwbjKpec6m2AmZJHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB6977.namprd17.prod.outlook.com (2603:10b6:8:18a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 03:45:36 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 03:45:36 +0000
Date:   Mon, 30 Jan 2023 21:00:54 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9h2VhGuraZfEJfD@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a4c7ac-a88c-4a92-7221-08db033d9c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljaDHIzNEHHrGsJ22Q/iff0hqlAvjXuN/NZJjEzBiyDg/ldslad5KUmvjBKyYK1JpgufJqE0XcTmaxaGcSMKdXEJbUjjiArSYUCeYeAveh60C0YbbSgVcb+B1sytyOkBncYgO8S8+d6CKuqBSZW7XSRCmwyGIRh5k9JNUJWv9VZTjfstSUZ2FPjTXUkU1O8BSGjbsxPTtQLGjFN9/JglMxG4sR/4DDGS0f7orHmPaEdrK/ik+c0GaB5T09fVtu+T5hTbb4CDd+U8T/q0QyoBRjD41caBzGDDEFt+QmFwgwz9T4UqNgkJCUNdO+4zJE0EfsykJ/0xvVNrNnIXj2VqyIRuuTkzGYIZ6WkCJcnECfeO2VSa0ZFCMiz1o4LgvXXmIy49QDjtVvIt/Ucsu44IFhIiesqgo22J5d+Z1NqeK6Cpz7gcAFEdrY8WMe7mSdmHgdtL3BN2ENyPmZR3K3vjWowEvtunEV4LVBgtX/QzJbsiw1qi27RtZIh6h72AE/TsSdBzCbU7AQO5UOelfJrAvXUxeJcbGRjBQGwFkC2U+d7zMY2oc/j84sZFY6YV/z+o8E0O1/e7mAvKUYMNgF8ZYwN+h08w32zTLjKzax8glmvTjLxLq0VkmyYq8ikefBNaCpnBRntq/oNBqXDmog1nKyZwrRi71yJG8TnxpYQFxVJX/XHAHxSqOQRlIoU66qhWOal4a96e6Lq2BBm6TtBo9vCOdPweQiyh+5k43DVhX1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199018)(44832011)(2906002)(36756003)(2616005)(316002)(6666004)(966005)(6486002)(478600001)(186003)(26005)(6512007)(6506007)(66946007)(4326008)(6916009)(66476007)(66556008)(8676002)(8936002)(5660300002)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lkdUdFTkwrYzR2Z0R4RWF3VC81WkhsQzNzemN5NlJ4b0xzY3pINE9HUURT?=
 =?utf-8?B?L1cycjRaUEF5TkVMcUVJZWZucUVvUmEwY2JtQ2drSGlJRVpOOGErQ0dhT3Rs?=
 =?utf-8?B?UE1PcEJQV2Z4Z2RuK0craVNqMWRSTFpWRDBhbXQ2WXFHNDZONXBQZHZiTkFV?=
 =?utf-8?B?ZzJXL3FialgzWk5JTDE2Tk1mQ1ZrQllMWHNsT1ZTQnpqQkNjY1VEL21Fcklj?=
 =?utf-8?B?TGNuTG1LZGgvMUZuRUFKUzhsZG1TQit3UnI3alFSUXZNY2RIbUdrRXR2OXRX?=
 =?utf-8?B?aUs4ZlRwajU5UTBGbHFCVkhzL3o4N2RpRWlFVWVGTTZMNmlCZnFVRVRic3hp?=
 =?utf-8?B?R3ZzT3M5Z0tNdkY3ZDBQMmd6RTJxTHlkdlgxbzZzUzhGait6NXAvT0NXcHJG?=
 =?utf-8?B?cCtOeUhXbVFHWnVxS1hyQ1pabkp2ZGJSK3J0dEkxSENsbUdBREVyMktBZm5P?=
 =?utf-8?B?OGEwOU9qaHBFOFByMzJIREhwSzNaWm1YcFNoSGRyUUpNY0VPYlFEd3ZXais1?=
 =?utf-8?B?cDJqSG9xNThxci9oUURaQ21lTTNUcmM4c1NmQm83MU5QNUpZVTZRYS85SlVW?=
 =?utf-8?B?bDBQQ2l4Y04wK25yYUl3L0tPWEZ5dGJ5djNEQzRFWEdnbGI3OUZMRk1YZDRj?=
 =?utf-8?B?Q0RnMWN1OHJjQmJmOTAxRUFiK0cyUU9LMEM5VlowT1dwZHFOSjgvT3Q0cTFT?=
 =?utf-8?B?QTBXbHpKOVpsZnZHbk9BOVUvQnpnQWkxK3AyVVVmUFI0a1BwbjJtaWZWamlS?=
 =?utf-8?B?b2xneUp1bVZIWHRjNGFreC9iK1M0Y3dDVEt6VzNiekI0dEc0VlJjQjIzR0Fy?=
 =?utf-8?B?TnhsOTFKYkE4SzJtblZxZHNFeS95YWFQQWlFQlRNSnFYSnZVRmk2Q1J4ajRw?=
 =?utf-8?B?N1Q2b2NiMFE4RnZvank1T1hBZys4Tk5JS0VlditpMS9kd1F3WVdPQ3huWThL?=
 =?utf-8?B?SytoOTZic01DMnhzSXlPYzEydDYrdW40dkN6Vnl2N21Ja0pIQk9BYk1rQ0Ez?=
 =?utf-8?B?U09EV1J3c3hydzdNVDV3cTJsOFZIeVR4UkQycUhIODRHS2dZODlSR0VsMmpG?=
 =?utf-8?B?UHJvQXJadU5HMzJEc3VOVjN4K3FIRnBSWlBSdHhhZWZ1QjVpd1NhOXZQWlY5?=
 =?utf-8?B?eEZ5RU5zK2tVRFVPSXFPRmF6Zmt1V05ndlZhczRCL2lkaUs0TWhGRWNJOG9z?=
 =?utf-8?B?TU4yUWZ2ZUJFRkVYZWprMExBcURBaXFtc2pPTzN2dXhvanpvd1gwYmpvQXNo?=
 =?utf-8?B?UHlpelVmVW8zQjhwQkpEOXNJVXhhSzRPdHd0cGxRanpLK3lhM2U5WDJJR2Va?=
 =?utf-8?B?cjhZZlo0TCtwZHo0UFcwWUFIUVdwYUN0QnlYVXNBSVdiL2krWWhRYVNMbDNa?=
 =?utf-8?B?Z0hVMlRXcW5DbWNPVDJFbnhPTnVPSXVrb0xFWnNQeWc0VW9SeEUzL1RVSVd6?=
 =?utf-8?B?SnNMUzhBdW1abG8wbDZjRTRPaTU1M1VjblRFQTl2RlBlN1ZIdnVXSzRxaFBu?=
 =?utf-8?B?WGowTWtuQW5XN3RsVCthdmphVkx3MXdSNWdxZElCWDQxekx4Sjh2VDdLc1lP?=
 =?utf-8?B?anFqKzl5aUEzcVlmeENlSVZBa2lQVlduWGx2WklESnY4V0l1bEVmWFFaT3p4?=
 =?utf-8?B?UlgwRjRhUXBEYkxUdXpYZ0RJaGk1bVJrVjRrQndhak5yT3FETU41dlR2ZnJ2?=
 =?utf-8?B?SGdnZW0wQ2phUWtsMFM3K1FiR1ZOa1REbE03V1JYVndyR2RWWkFPNDQ0NXIw?=
 =?utf-8?B?dDJMREdRL1p2RDI2dnZYcWVIQW12ZWdLV3dvZDVYYnU2WUFlUWUxK1EwTkpI?=
 =?utf-8?B?RGthV1lhYnlnc3pPd2RZSi9PMDJMRWo3bHcyaXVFQjRhcU1DaytxUEVvcnNX?=
 =?utf-8?B?WmZPQ1VVeGE1b2RneU83WnJuekJpOTg5cHA0QlU0aEVONExGd083Tko0N1lq?=
 =?utf-8?B?bldlbEMvMndLbjFoYkRLTjIzTnJvWk9RdVFnUi8rM0t3MnJoSzNlLzdXSVdE?=
 =?utf-8?B?SkhBWnBTNTRhMkxiWW4rMStTeFFKN1c3V1UwRHlMekovUEs0ZHRQZjFjVHNr?=
 =?utf-8?B?N3p3OHduMncvQVNUTWhlc2NjVWhIZ0dabkxVNk9ITWZuaHRFZ24rcm02di9l?=
 =?utf-8?B?K3hOdFIxejNtQ25qczhFZ0F1cTBVajJxRUJmY3hESWM4Tlp5TmlMcnVtb1RH?=
 =?utf-8?Q?cCZjTmBJUE5sv9HzaaVZ5Us=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a4c7ac-a88c-4a92-7221-08db033d9c77
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 03:45:35.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRZr+xFW4k+2Wo2UIjLPcWC+3cSKWzb6bhf06JzvDDTA09cc6gILZ2mf9xJgltGZcyPY8lf2C9vE25bGWfk6TT2a/9tblcnzXKyNXyAvxiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6977
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 30, 2023 at 03:18:38PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > On Mon, Jan 30, 2023 at 12:10:08PM -0800, Dan Williams wrote:
> > > Gregory Price wrote:
> > > [..]
> > > > I found the same results.
> > > > echo mem0 > /sys/bus/cxl/devices/region0/target0
> > > > 
> > > > Not sure if bug/missing feature, but after attaching a device to the
> > > > target, you get no output when reading target0
> > > > 
> > > > ```
> > > > [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> > > > 
> > > > [root@fedora ~]#
> > > 
> > > Hmm, did you not get:
> > > 
> > > "-bash: echo: write error: Invalid argument"
> > > 
> > > ...at that step? Because targetX expects an endpoint decoder, not a
> > > memdev.
> > > 
> > 
> > ¯\_(ツ)_/¯ bug?
> > 
> > I went through the kernel code and thought it was looking for a memdev
> > but i guess i was wrong
> > 
> > // ... snip ...
> >     dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> >     if (!dev)
> >       return -ENODEV;
> > 
> >     if (!is_endpoint_decoder(dev)) {
> >       rc = -EINVAL;
> >       goto out;
> >     }
> > // ... snip ...
> 
> Oh, yes, it is a bug. I fixed it up when I address this 0day report:
> 
> https://lore.kernel.org/linux-cxl/202301281313.kVrIreUj-lkp@intel.com/
> 
> ...I posted another spin of that branch with that fixed up.


This worked for me, though it took me a bit to figure out how to wire
everythign up - still not sure this is entirely correct but this is the
string of commands that were required to successfully attach an endpoint
decoder to the root decoder.

Note: The root decoder has interleave_(granularity=256, ways=1), and the
region code appears to require the same granularity?  Does that mean
we're stuck to 256b granularity? (unless i misread the code, which i'm
about 75% sure i am).


Command string:

# Program the endpoint decoder for ram of size 1GB
echo ram > /sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size

# Create a region in the root decoder
echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region

# Configure that region with the same interleave granularity
# and ways as the root and endpoint decoders
echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 0x40000000 > /sys/bus/cxl/devices/region0/size

# Link the endpoint decoder as a target in the region
echo decoder2.0 > /sys/bus/cxl/devices/region0/target0

# Commit the changes
echo 1 > /sys/bus/cxl/devices/region0/commit
