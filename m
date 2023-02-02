Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F20C05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 19:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBBTQ0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBBTQ0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 14:16:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659A6BBFF
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 11:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrcP4lCBd/Ly4TASbxPTonfur0TJNC6QGo4NnZmkctJBYnNoS/iQ6aUA4UHarUe0a3vAVuXGVSVWysf3znHZot0Ihu/exJnb+khuCFtgHzddGLDLT+VRRS9HQ2A/hARUUVNIJDmllyNuD4MnllXAWjr+dPEW9QJODRRnky7mDmdqvM1b0UkFJOMrs38fqvfDcye7it3lYzZxorKZIQCq8Jql4L53MUMYZ8rdJqDdMSLstNxSzww2CFDiW2XS2hCE+FXNyWXSqIAeH6H0GBizVQ+ju/YlOffNxn/A9TF/BgprRKPmorZY/BP9332xV1k+PHSA0fAhrre6+VQlVua8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH3aXCe9VvNA/8KfFmqE1iijzl+/U2ci2lzlEuyCYR4=;
 b=b1lFnt1ft8iweCrI3klCQY7kGUEIYnIWYEjgmUjnRNzZdW6sSqBrDahpWcQ1SVRpnCz8wMT+3PshOedZ2fUJ/vAfcQCvVKhCO6rU8801sIf/JHzeOL7+ICyWkhyYQnJALcumDVqq6/Q2q54LONY87PIGyKnl+7QZE4wyDgoBpsV3jFzc7Sioe8cHJ1ZryyJE4SxPeyePy/DkoMr79z2vfre00gsv1R7nxhYEGg1mczgPHEeDGFvT66c+TU0/RnpT5EUIXLWHo6qMm2n79Yn8Xl33+s+lTsYz3vi75OthrW31JbTCQcM4Q9QdaWyXtk/oOdBJGQQEWE5Lm+vSePoVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH3aXCe9VvNA/8KfFmqE1iijzl+/U2ci2lzlEuyCYR4=;
 b=JMkDQ+U+r/MWLCVcmfutKFh208iRCb3RJOANWe2l37pEgjZbakYOIZCfhnNMv3donQANeBxq11CIdmtU2CDqxHx8M8RdOeCXOb/hGfSlf1v4HZeNM+UFyuXZGo2nCbcwoZ26/N7/HMtTBt3KF/z0OkL0hTsw+rpAXzCCzxPOCfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4699.namprd17.prod.outlook.com (2603:10b6:303:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 19:16:18 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 19:16:18 +0000
Date:   Wed, 1 Feb 2023 20:06:59 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9sMs0FGulQSIe9t@memverge.com>
References: <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
 <Y9ll5S3Y4BZkakNn@memverge.com>
 <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
 <Y9rWskfaz9dLoW+l@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rWskfaz9dLoW+l@memverge.com>
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c599a-69cb-4c4a-f69d-08db0551f643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIBbsSxzqnhBU9AJOQR7AWR6AeCnlQ6xlUPlzWD1GQ3UlzElbhwSpaXQoe5Lh1o51avnDfHPlY3eqOcTgiKHLPq0sJa0QR2k8MpCHcRw3gmV87ceJS9SgePtLA6sJVM0YZr1EICAn7BgqMRvIFz6Aoeu6u0tkEIQLlKQBl5qgyKIzMn1yH8sKLQcB15MKiuEfxqOs2z2+/lKk3LVuv0msOxW3y3XXkXS2DxIS8+aOunH2V8hN67C0lRQrg/188LDXod+0i1jSnDJZDCQxrhvztJ8XypfAQvLouSQDNd2juzS5hdJv4m2tDRRLrOOv294HsfZv9huwI7GwoONLybjD6dIgfCtUcqubVdEBdO8/DV3MYqL0f+2Gi0UKR+OVFCSL/tCQnB5gNIPdFGMKtwGqrJSBeyqjSQebijlHwOnf0Xb0ZJl2a464Ao0E891Q6E6+1p5s1/dvJkiInNEs4YR7I+iJv5T6jM7zLJ4UwS/Fhjv8VYpsFALfve8bPLNUUfyL+DB8toanNPWh7ybkQqvjle1RsI5MKF6sBctgROPSq9w16qAVz4oEifUS+Z6VbIqYKnTYWxBDCKsV7NFwjjJxrwzyIuvJKHFM4B2rS0TfLxYVPmWBq9fZLodAtnXIPoXQYvOXgpOMm2X+HWCnDseuU8bRsC03vwE0LUmmWvKy2MvUtkIDFsISi6aUnZ09p3m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39840400004)(136003)(366004)(346002)(451199018)(8936002)(41300700001)(186003)(26005)(6512007)(38100700002)(316002)(66476007)(8676002)(6666004)(6916009)(966005)(66946007)(6506007)(36756003)(66556008)(54906003)(4326008)(478600001)(6486002)(83380400001)(86362001)(2906002)(5660300002)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DStm3L8/mwM/YyOuHsajgIrHVHQ1ejNcrH1AjyhgQh18Na22hjReAi4Svl9F?=
 =?us-ascii?Q?Q4/ZVaSS1XA63xGm2MkDe9YbgZCxcQRIWjWGeZZMBEZ4yseTlnvkPrtKSCA7?=
 =?us-ascii?Q?8FKLgjoQiZ8BdezG6d74Ye5o4crGLHfzhDAiBFxXF7auhzh77OkwQoVzj8xj?=
 =?us-ascii?Q?pew5G1EQBLsz59gr0uNZ8IlkEEXSy0iGvoFDSkHRdAUstoJZcvR18EHDZWK6?=
 =?us-ascii?Q?DooZvOmi+fSsnRBxH9r934Zw9WLajAYIb1wtXFQa6O6ytXsb4hGSib49VvBW?=
 =?us-ascii?Q?26ebE+JGsO6A1KFchVt9nCyvmuFE08DV2e1/KnvaDVml/PBzgIRDg/Gvfk+j?=
 =?us-ascii?Q?nBozPY61vBkkfTzqiUuYN7A380UFYZ11xV/H4Ah1fw/VEPKsrWKtmb1/HaC5?=
 =?us-ascii?Q?MRLQDVUXxVPbro2uvOoFhygZAB/dxUg//8rnT4FDx4hCQaqI5qE7sw4qrnvf?=
 =?us-ascii?Q?lBplOfP5okO+oPL6dXvI4e7SorGcikVcJ+7dP1DnbMp3dqooCN1wMrAg4FkB?=
 =?us-ascii?Q?+KWafbcQ3mAYaSKN84mKAEPILHU5upQZs6NPQKkLxm5I8h+MuQamSCU35sOc?=
 =?us-ascii?Q?JtI1MDmGXixFjVSgH4Wj2FNCp896JNq4AqfoEWTuZH3874mT6v+gHLDV678U?=
 =?us-ascii?Q?ilZRbno0pcDGeb1mCDFwCKptbn6yzGYT6nIko6cyEGk5NbZysV1KhXdaUOEJ?=
 =?us-ascii?Q?k4Etu4xYeQlL5QMiRb00HNIWnv9idw0VDI2DusUKfzeDLoSfwu0aJe1t546L?=
 =?us-ascii?Q?1jT2NIKqDrbKWEucwL3Ha7WIWfV+6pnBucI5hoFacfK9fB2XiVzvXZvYGtMQ?=
 =?us-ascii?Q?y1F6J5OtEuvqj3GB9LFEs4Elxpa46mUF1+RCPvt5ru01Arcw8L2Z8vD4E1FX?=
 =?us-ascii?Q?4MsTcG8Xpxfaki9KQX0qfI+1RR4Eqrvwh9BUrc8A52LFR2eel9v4wQQYPE9P?=
 =?us-ascii?Q?RzJ+zF8oLzg3mOBpTvc5g+qHHAmeVcf1xYGFDP9EHpg3c0AVMTrA/OU7S6Ua?=
 =?us-ascii?Q?7+yh5U97GmrB0LdRQ/IdV/9FG5TomObaPPUTGrPZa0aTpLSvWa/2mycy6xN2?=
 =?us-ascii?Q?1aOFx5+94a/HA7pYCyTkDCkLamJZIxd/254FEhO23DTv3zhEfg0hqFzHzDm9?=
 =?us-ascii?Q?UTc730pHVn+wtEtmKsF/9qPGNz6V+2SrN7HemFJP8QQZ6LvOuOauacOJwfWv?=
 =?us-ascii?Q?QIVr42HU6fCh1RUtFjgmoDULYsZGEo6axpSPrfK/tRvr78JPTN6bdxS2QMCY?=
 =?us-ascii?Q?atXnDiGeH7InvmQsMAx1s9wK9xHCrwHrTdJpzju9k1zpO8lobtcXyMWXI9it?=
 =?us-ascii?Q?rptJ+9TFnQ36I09QRdf0g6eoxU9fwQH0lY3h/L5Q6lWUEDwDw8EDL+VzWaGl?=
 =?us-ascii?Q?QGUQ2vdn3RYL9hrTaUsWiRGi7Q92wZ/GB+v5SBJ3Dp7t7LDC5QiCwqW9Jm31?=
 =?us-ascii?Q?WvKyn6p/NmV06hlTDlDnSGeai2u5eXzGPW8DRdJOQvGa894QM/fuuCC468B/?=
 =?us-ascii?Q?8Ql398Znra89q3h6igrsaM8d2p0cO8sqPqTZ33OLsMTw4cNTygHceR/Fnpfm?=
 =?us-ascii?Q?HQLz+TzUyEL1awijLQDPOlSZ/lnwdU4MxATC/BS8xQaKse3rO+vf9+fs+1Ta?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c599a-69cb-4c4a-f69d-08db0551f643
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 19:16:18.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4rM525FU8AbQC3YhclkIGbQvQO3usRxdZksJF6oARtt/hoxWzSfD1r4lhlyrBcHU6J/i2yjr5PCY33U6q9tBlkzl8FaLErtigdmrTH5O8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4699
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 01, 2023 at 04:16:34PM -0500, Gregory Price wrote:
> Looks like i can bypass this with CONFIG_CXL_REGION_INVALIDATION_TEST
> but just wanted to report back incase this is not intended.
> 
> On x86, this invalidate_memregion() call maps to not having the
> hypervisor bit set:
> 
> bool cpu_cache_has_invalidate_memregion(void)
> {
>   return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
> }
> EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, DEVMEM);
> 
> 
> 
> I presume if i enable the invalidate_test bit in my config this will
> work, but if anyone can validate that this is expected behavior without
> it, that would be great.
> 
> Thanks!
> ~Gregory

For the sake of completeness and lurking readers, here is my complete
setup.  I was able to successfully test cxl-cli onlining a region, and
that the memory is accessible to the guest via /dev/mem.

Was also able to verify the routing through the decoders via gdb.

Looks like the last step is to setup a dax device and them wire up up
the memory blocks and attach them to a numa node :].



Linux kernel configurations required:
CONFIG_CXL_REGION_INVALIDATION_TEST=y

linux branch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region
merged into
https://github.com/l1k/linux/commits/doe
plus this additional commit
https://lore.kernel.org/linux-cxl/20221215170909.2650271-1-fan.ni@samsung.com/


ndctl branch
https://github.com/pmem/ndctl/commits/vv/volatile-regions

devmem2
https://github.com/hackndev/tools/blob/master/devmem2.c
you'll need to modify the strtoul to strtoull to write to the correct
addresses, right now this is 32-bit bound and the CXL physical addresses
are always agove 4GB.


qemu config:
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


[root@fedora cxl]./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
[  128.790228] cxl_region region0: Bypassing cpu_cache_invalidate_memregion() for testing!
{
  "region":"region0",
  "resource":"0x290000000",
  "size":"1024.00 MiB (1073.74 MB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":4096,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem0",
      "decoder":"decoder2.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region
[root@fedora cxl]# ./cxl list
[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "ram_size":1073741824,
        "serial":0,
        "host":"0000:35:00.0"
      }
    ]
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":11005853696,
        "size":1073741824,
        "type":"ram",
        "interleave_ways":1,
        "interleave_granularity":4096,
        "decode_state":"commit"
      }
    ]
  }
]



[root@fedora ~]# ./devmem2 0x290000000 w 0x11111111
/dev/mem opened.
Memory mapped at address 0x7fa9997db000.
Value at address 0x290000000 (0x7fa9997db000): 0xAAAAAAAA
Written 0x11111111; readback 0x11111111


on host:
[gourry@fedora linux]$ xxd /tmp/mem0 | head
00000000: 1111 1111 0000 0000 0000 0000 0000 0000  ................
