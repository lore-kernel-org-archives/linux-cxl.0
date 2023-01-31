Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ADC636CD
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 18:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjAaSHV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjAaSHV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 13:07:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883004204
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 10:07:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyn1FS8u2bpUD0TKOYY5O6Gi3iQwQ0GpHb9yVlnH73hY01bqeRDTueve2nTtA8ZcPwrBjEY7gSnKbavHTYqgokPAxE1HKRb117PQ/zDPCUto7r4ybowRazBQB0qc0tIecjyOMehiGgAiwapd4T4wu4Q9HfS6NG2FFYRssGTuQD1YaThJGVbOvHd00aaXJoyx4jgRxiBYmtfF589h/MxlWZBoQXhiwwQxiGRQ8mioysBiyObKvBPU3vl2SagO639ax8eZpjOPvg4w9/+6+3/nUeShu6gIWbF2SO18y6NaUFSO0hNsFCpwaq0CCNpAv5mBrUhhm6rYjf3LNfTwA1hx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxZ3JNXVFb9GDQo6uner947C1Qun50MLoDSdEXGjTwY=;
 b=h5JJLrwkJ2ge/spF1k07++bGsuaF1b8ODMlM4FAsFSYSHT13DhjuNUPznBq6ztV9sWpw8ln3nr47qy1cQsnT5kspwor3hPqy8U8rt4hYAci/JU3Asf6M45wyBFDvDHLdTWDrjE3c9g6oLulLxRTV5xV7F38nbRg3AtZcsqCSBT6QymkJABbhC9UZhbM+v87sjWIFbvdpTSq445nKaFjmjqwjYPvIJ6JXmvOQ3S+xMGyKg/rR0Y2mRhDlDk92K7dV/Kiiu4oR/qyp+EBJ5fnqrxaYxJpk37DTIvxhVChag1x+3sM2Kh59xLZxiRfBWT0u+0KcKKN0E3Vgv16XuUvZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxZ3JNXVFb9GDQo6uner947C1Qun50MLoDSdEXGjTwY=;
 b=wc/Fodb8qIA9F0ztlp6g3+T+P6ZD9YKLmg5zGLkkXKta3WQbO6FbvAxvw42U3nrzrZpr28Lfujw+I9BXLqtBuK8SBiudgaCD6+p8gq1AGJrYdu40pNgZyWC9ihwsH6F3FC3h9HBrW7g4quiM9ISRRsr98Lteo3AqCczu/QGEPks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA1PR17MB5208.namprd17.prod.outlook.com (2603:10b6:806:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:07:16 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 18:07:16 +0000
Date:   Tue, 31 Jan 2023 12:34:19 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9lRG3BqlLrvhm1i@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fS+vJft+P0FYWQ@memverge.com>
 <20230131145616.00006c9c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131145616.00006c9c@Huawei.com>
X-ClientProxiedBy: YT4PR01CA0201.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::9) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA1PR17MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f23252-3caa-4a3c-7870-08db03b5fc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pu93xv3IZHgQARA3Bhn3VJRM6IBdUM5XWHGD/4nxVv21Y7c7ttsGxiAUPAS3sMVpt1eKUpExTmfZrNzfvdOUfQWaSGKTduxWPVPty0RvGkQc9Smio5PCjbiPsAOCJsSbjB4dnuxHwRmRUZI3UjLiVNYMSGVb5CaW4ZplNvJcwy4cy/PJSSmQ9searax1vx6hvUq86ghBbtE/48Ppl5tfgIfAD/PuiXp0AiGxRT+43wepA3fQyt1x+USVMA3Z4+H4RyevB3sXhxnP/UdU1AqoiTHf46coXfkokjbWqisRVc0WzCF0cGH5lxp3v4tpxxXm06maHJpzMJX7pUK7jAc/cCdsKI/rUHmlkzKr8sGvtW601AcY0iHhnfKqZraXThUJLA815nkRKQpOtUCT66+MvdVp9bLP+zjbwFbyI1ifZhsbJdnXv6klvZ6n2o0qTru7azKVO3xcSg2B6LKv31CfXZgjiVml2KP0e9n0T7kxKHc2K/D141qKeR8K4xtOFlIx4ZPJl/b0bYExCT7OeiE6QYHR65/1W16hYeo6hni3jP5IazxtjzsCRUKAl2l5l/6G1/PB/pJDuDbOdlkaBkI/rzfB8KjZ+FmqqrzkhcGhMbfEWeowLl63dYo/RoI0Gi2SBa7ruo4EmCI0ILBIIU98n50pTJA0H1P57x1ly1hPyqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(136003)(396003)(39840400004)(451199018)(6506007)(38100700002)(83380400001)(966005)(86362001)(6486002)(478600001)(186003)(26005)(6512007)(36756003)(2616005)(316002)(8936002)(41300700001)(2906002)(66476007)(66556008)(6916009)(66946007)(8676002)(4326008)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tZoH9f7DH8d0gNxQJGO+jc0RXSMWa4X7WXIXpcnHctLGBgEXd4d2qnSPZuB?=
 =?us-ascii?Q?gAcIsbKYyPiqWcNY8oxhxmny6JLZoQqaJjjkncrtyB4RRCAZfKRtPE2s3BQN?=
 =?us-ascii?Q?6X6lHYBtNq+nPW1c83PIQf5szbImwLB+QH/8IONZxKWDC5Z027ZWaBKGYwAc?=
 =?us-ascii?Q?n2EEkHCVqTeA6SrqsNuZTcTrWjP/ZhthW4B7typ4tUGQSDBsRxM/JigsnYqJ?=
 =?us-ascii?Q?SKG4eGVjZ/Q7h4IjdNVuMWavttkSSYKY/Q7SbA0TRH4ALBe3x479JCICseih?=
 =?us-ascii?Q?48UWX1gcgq5EnrUOzhawJeR4vMcxA0WpdlL/15rOn3X6evFmiawvzkHOoLfN?=
 =?us-ascii?Q?cfEzNGkd1cLpa0MRTHVhvjWNDpLKUsjv+5puE5Sit5goOhBwE3XWusmRREWe?=
 =?us-ascii?Q?VkKt1YPQaHkFoSTzFKZMgfJUMTy/S9+Chfr36HkZImaOkUMgfJAht975HHZi?=
 =?us-ascii?Q?R2KHBMNlkTiCL9QVcP1LKAhkI35gYawQLujkNx4E+S57P8D4QSkXzjrtPr4c?=
 =?us-ascii?Q?kuEN1n+dnxKU/wevWpi1kl3tBAi6YbdLFZOKi7OxwFaATPoWZz7oDz7xOVtX?=
 =?us-ascii?Q?6UDjTYhSz8+vITeQjmXJzWZAeiZXpfYZTlccL9rfjHv18mzKa9W7QBcsRYM2?=
 =?us-ascii?Q?X9UFTriMAIGuemsOtw/WVFwdRh04plbH0BCJ4em8QnZGUvPzC5DsCigjnmeD?=
 =?us-ascii?Q?KSIf7AnufUIPtJ91LPOynKFaNy4PGuYjasAcBTutW33OS1Kart67ONzMiz1E?=
 =?us-ascii?Q?ZO2WAf9WzpWML9ib2NPqSYD4q9TD3ew/Kb2weBcgO5Lw3dM/1lpoRCLH7ix/?=
 =?us-ascii?Q?z8OHxibDXtZ7EikR/AmEpGwoV0oAyiPiwN5u7Stk3WPoDp41f4uxEwIUgmWv?=
 =?us-ascii?Q?Rl8mWmV+DdrubgaYW2hh/Umj46U4eaizgz6pGJie09427/bIv/yRcVhIKYax?=
 =?us-ascii?Q?5k8Et8Q11LGj3EGDeP32JP3hJ5BWxkx7e7Vr4SbAYWMiRG1GSH6GCFhWn5TY?=
 =?us-ascii?Q?mJTMG6TUrF+FKNboXZyupoGLfJbqSyRS7imNSLtqW51KQ2pnxrv9HLvfV70n?=
 =?us-ascii?Q?1onTT5wP+j4fQutWCpj3rjztqKNfTjpdwZpFaZ5l0qdBN8b56UpBMwg7f5Iq?=
 =?us-ascii?Q?OOFH2Lp9pM2D40wTgyaSLkC3rs3cuR44JsogCamHQ48PO/tZFp86onR15i4G?=
 =?us-ascii?Q?j1Fn7+xRlXHQYvpmdYzX+j3BSAPaAL5tOcHJGWerowpjZuflaEsRKKDb5Xvl?=
 =?us-ascii?Q?UJ/ClDUAmnqaN9+IjnaVDxTG/BC3fS3qA4PerhCnakDczkSPZzNeykvpSu8z?=
 =?us-ascii?Q?LdPF33TjVwEQ+dvFzSaenxz4VY2FgPvlgzLFnK29+zvaAaNkZfolgfDJX+Sj?=
 =?us-ascii?Q?w9K/akVVWlwJHQoEEQixGCFfh/5Np0/bIVV0xrtfzgnomceNuliTtiqXPda0?=
 =?us-ascii?Q?0CeWq/3p2zJyI9kpqUGn+6OO72QgHeHoS9H1lH4JcoIoIet1Z4ZCZYrN7aDY?=
 =?us-ascii?Q?8hUokgpUwYjH46mn/XFjAvsrVolNOuTNgDoqyT2LUzAB9G1xG6Qdz1GC5sV2?=
 =?us-ascii?Q?ubKjONqW/SCLLvAipM0DdkYiT+tlHvBZMAbKCWMr+w/V6TYdVjgvkg8y+VDd?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f23252-3caa-4a3c-7870-08db03b5fc7c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:07:16.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC5kU9J+Thq0wjdwXwP4x8vTEyGuhBL+iSRzxjeyxZYv1yztqYW7yon2ZXwG4+gSwbWeth/iYaQ0m9OJKKeF8Y3RUNrWVhxgwoRPpCwJyjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5208
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 02:56:16PM +0000, Jonathan Cameron wrote:
> On Mon, 30 Jan 2023 09:23:54 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Thu, Jan 26, 2023 at 07:34:24PM +0000, Jonathan Cameron wrote:
> > > Looks like decoders are programmed correctly as I can read and write from
> > > the HPA using devmem2.
> > > 
> > > This is against http://gitlab.com/jic23/qemu cxl-2023-01-26 which has been
> > >   
> > 
> > Johnathan, can you explain how you're accessing the memory? I don't
> > quite follow.
> 
> Command sequence is pretty similar to yours (not checked it's identical)
> and once commit is done, using a version of devmem2 (not sure it was this one)
> https://github.com/hackndev/tools/blob/master/devmem2.c 
> (if you want 64 bit read / write add the obvious additional parameter ;)
> 
> with appropriately loose kernel configuration that /dev/mem works
> 

Very cool, i have confirmed this all works *and* that we can actually
back the memory with a file and see changes

For readers, and sake of completeness:


Kernel:
https://github.com/l1k/linux/commits/doe
+
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region
(merge cxl-ram-region into doe)


QEMU:
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-26
(might need to revert last commit if you're not on arch)


QEMU Config: file_memexp.sh

sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 2G,slots=4,maxmem=4G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G


Mapping the memory in the host (still not confident about the interleave
settings, but it works)

map_memory.sh
# Program the endpoint decoder for ram of size 1GB
echo ram > /sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size

# Create a region in the root decoder
echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region

# Configure that region's interleave and size
echo 4096 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 0x40000000 > /sys/bus/cxl/devices/region0/size

# Link the endpoint decoder as a target in the region
echo decoder2.0 > /sys/bus/cxl/devices/region0/target0

# Commit the changes
echo 1 > /sys/bus/cxl/devices/region0/commit



Hack up devmem2 (it uses strtoul, i needs to use strtoull)
https://github.com/hackndev/tools/blob/master/devmem2.c

Then run it

[root@fedora ~]# ./devmem2 0x290000000 w 0x87654321
/dev/mem opened.
Memory mapped at address 0x7fb8697fb000.
Value at address 0x290000000 (0x7fb8697fb000): 0x00000000
Written 0x87654321; readback 0x87654321


Validate the memory actually got written to the backing file:
[gourry@fedora build]$ xxd /tmp/mem0 | head
00000000: 2143 6587 0000 0000 0000 0000 0000 0000  !Ce.............



:]
