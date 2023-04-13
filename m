Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2683C77B6E
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Apr 2023 20:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDMUyb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMUya (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 16:54:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7217ED8
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 13:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWnfzHO2mqaxMS6OFXsDkwq3QswcfKSmyxYcyZ7r6F+bSY6mqbz9enpY2cJiJ7DqZCDECzD+YM5WAsfbGeajtGLFOy2mgdgxfFcq/AbkBt4wwMQPPPMs0YakvILmBFcLjCplP01O0lhiaFUWXdOIbBiREaCuRRIkKocWRlUEqQzd1aYLOwvwRRvGWZrH6BEuwe8Mxx/8qkdV8V/LNGh/rqjYilMuseyMrhOl54YjtFoYP/8vN8bQwHP37o7/i2tbiOp/dg7gBrve7PSn7+E5BukeuDRZT76AzlKcn3pNhfLHSGtscnBN1f4x0UJvsHj5lGm14Vt+rP4d1w5Ds/zqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4mWbibBvNwoI8V7T8JfTXk4TawSmx99IP3VWOOaoAE=;
 b=dBqT/KJQbvonpTx306UQla4kV93TLiBRFfDCRPfdbjXffTE3TQ0m9l4RUNwrKI1h4J9tH4F6vrLR9XpkNteemvBYc9q/rrXP+i/8aL0xIIXO9tMw+0a+v600nrB796VjT1xIp3Ww9M/2nIKfpb1Gs7WtYdcd5iBKIexMGzNjacQldMM8MKIb5JEDB6KpBC1vO1fAlO0CHDsCWmQSLbhUK3HTmV4LtIFnPy1px1yZ5zIVfe7PrqVf65OX3mH26h4u8fCWP1xbkOCT+3LvYi/wznqBxR1meja5EDRznxAEyfSbN/QV+pM8GqoxXFGypa/XeVZ7mJfGjL2hGBrjRta+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4mWbibBvNwoI8V7T8JfTXk4TawSmx99IP3VWOOaoAE=;
 b=tq6siQCQ1xoZxhVpbA0uQzcFWUGmH+NlXOfLy9pxCEAw3XNhKQvY3YlTesdXYEePpID4+H6M81yC/4G1sYq0+ao0Fv0W5dqPtI1VjLcTmeKlJOOlTLbNfNcRvNlEnAdccabVAY8EHMzFtCxRTuBIARhYtlaiXqqrKjAKl7XjkBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BLAPR17MB4163.namprd17.prod.outlook.com (2603:10b6:208:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 13 Apr
 2023 20:54:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 20:54:26 +0000
Date:   Thu, 13 Apr 2023 07:39:43 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <ZDfp/+7uTyh2wWcX@memverge.com>
References: <ZDb71ZXGtzz0ttQT@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDb71ZXGtzz0ttQT@memverge.com>
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BLAPR17MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b5244b-2647-47e1-d8d8-08db3c614450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ42OoENfS9fhi3UexuK635R9jFNjqX9NfByQP8FtjM1RXPFv1jgEOYopckSUIH06RtCsJlFg9V9EK+PfkOc8HMNPjHpdpfRLlyWXg6eg5WGni2N6peUwS3a/NnePRvdVL4KpD0dC52o3CVoru/8aM0eniPwDnxG9JFGeNpYQcXOy8VJwKS7RvhpTQv/t3vdk18Vn1qaa7GcOIh6ydcWaZ1JOL4Piqku9mUamv4+ruNHaTxQa5YLSvQMdM/IGYGD9XxuntkdiVZD7qy3qQvQf8djnYfXnSHNCelbmlYm+O1ByOrRUSO7MQlVj9J4n+L0CDa/cC/bIa9700GBzIx7kYxIcc4f6NQMo4mOp8FKbFhNoTpK329dc7mw+YP6tIl4ijzw2oMUVszUoqf1iO4X47juBm/h6kUjm6bxTkfe5jafOGhhVIOHFnOaD/GWeYkE/luv2gPJjOdGeKIJe/T8j785f5wQDLnG1kTqS9vOjt0KPQ2h/emqqON3gnAeNLhQv1DloHHUAUVEtAS9lPdCrTO0W1JIT6Xbklc4Hrai3RSi6LffwdSyKLEOp+K7oWjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39840400004)(346002)(396003)(366004)(136003)(451199021)(6486002)(8936002)(38100700002)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(6916009)(54906003)(5660300002)(44832011)(41300700001)(8676002)(83380400001)(186003)(2616005)(6666004)(26005)(6512007)(6506007)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yr+/Cp4mb0aapsHRf1PItIFioQYTGKP76UXz4jXvrZ5Tiao9rhVVb0EFA89C?=
 =?us-ascii?Q?THpao4jWW+VPegj3W/lHcyKHMmxVlGPDADwzlmdtBehwAtLKXzOHlyZssz5r?=
 =?us-ascii?Q?TsEUglxm4negoHSSBi2rB1m3IhalJ8a+zspaXoayq5Rh9532fRvpIJnJnRbn?=
 =?us-ascii?Q?PCbUSnaTFekX7pv4035lX3LiSenwEtvV3Bv0kD+EWUOjOV8fCSLp/PUQRDRO?=
 =?us-ascii?Q?F84Yvv2LH4uEz8K8613MkC+EP6bVgznLWv8+VplAv4U9MJsz7WQg0owWWnsR?=
 =?us-ascii?Q?qop1yxkneDftrK/fzlVMK4LSNYM7qCflUAOCrnoYdK0P3JNA6rQvKThdLopx?=
 =?us-ascii?Q?27rEdkJVy7jP1AWDkbMgioaFa2C7Zlw/mDCeKBASfGvmF4W/LycWJaWLRFIY?=
 =?us-ascii?Q?JIjlr7Nsu1j4ICeWJ/E1Z/oh/T7HuSVDdgv+0ZYF3rld8hdPNwPZNW8uo9Ow?=
 =?us-ascii?Q?GVBL3Q4mjUfEPYWflO7wXd0KljsOzlMYw1gkRKA35CKU950zohijtuOllZ4c?=
 =?us-ascii?Q?NhHpLYW4B067jps+q2s/CCEzivVbHRJkyhuQDq043/0lVd02EmtLXJWOwtej?=
 =?us-ascii?Q?zZfNrb4wNIkrKSsgFZh/e4zryZi0LFauIyXXAf/teZmtxkYRKmXVUbxIqLHX?=
 =?us-ascii?Q?blUk5nw5G6bil/J5XUzrriiNzsdYP5vb3qDvjGDL9FftAnwDoyGmbDJAeOac?=
 =?us-ascii?Q?+TJrWfuJgBPWUwVZXdQo6ybpHLGKor7mJfapoaBjUMwythhrgMzP4VwfrbEL?=
 =?us-ascii?Q?5vEtV6gSiiwCeV+Q4qfLDnOZ8bkXSkc/62XN6FNvZM9fPmJ61DLiPdycac7v?=
 =?us-ascii?Q?5eQsO1ZJ7UwCxnWwqa5dXcASg8m0JeZUnMC6+7MuYIjFyRpqKNwMNP2gbQFJ?=
 =?us-ascii?Q?AnJ7jSKTEwoTDVL6t2NVspH876eTAq9wGKJg+sWYE1OtlsghbOyOlQkjh24T?=
 =?us-ascii?Q?sdDPE+KrpNgfjHrjEbWD0iYkc3tVCpwCsWz4VeJtG+ctQeAmQHYEXIVcLVbp?=
 =?us-ascii?Q?831jmKF8vvgqBf1vfAhI8CpNwNWzOWUBsmg99Zk8Qpdo/6H4nFw1IYoKe26B?=
 =?us-ascii?Q?Uw7XnNaQL2Bw1bXspWYumCMyDQFY8JlJnJ4xa9kqlbveHi7+1OL2RzXEkVT5?=
 =?us-ascii?Q?jgY22OrW7jz0h7JTi1lehJIDQ8BAvoU6IFb8X4bY9gB/Ku4y1alW+J9+1dld?=
 =?us-ascii?Q?F0noFCPHJGm4IZDbeCBBgJBcnLxPuhAFPSQcdEBBvlNQevIKD8EMiu7KKnoB?=
 =?us-ascii?Q?lbfVmxHSeZRkLAVPwY9kOx41FCHvybfWKak3MKI8k2CvaW6oWBBUyUjhxjw6?=
 =?us-ascii?Q?go2PMjwujbo/r3MWmls/33l57C8JhKMcbcjHwl3aL03lS5y8eSjzDNdzWm0s?=
 =?us-ascii?Q?oNal9YbGkx04g4wlkDY/YgNaUQktUj4v88v2qXUmNW7aPZmgWgbsBmfMW2Qw?=
 =?us-ascii?Q?wYTNHPvzQfTR8jLROZdsADNRq0Sn9Pa+WZqIcEgddQRfIKxmVkxu+BtZl8X+?=
 =?us-ascii?Q?RO4LDvq3zgz1CclT6jNn7RUH5uSqqXVthW4iXv99/xWhuZAMZIjFvjrK3FIy?=
 =?us-ascii?Q?XKlZDjjeMlwMZfoWrY4ESSRljZBWWhH8APKkdsUT5g7Qnjn/BaJe+XPcDFHx?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b5244b-2647-47e1-d8d8-08db3c614450
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:54:26.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcmSDHM7g6OBETbxfGB8IqqDyTqaK0QwsvaJplawg+/hfqi1Et/FWwtWBTVSVA7jbco5fQyeHhii2oN39gDYZMn/uqvvSHzAdUtvLnCu1oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR17MB4163
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 12, 2023 at 02:43:33PM -0400, Gregory Price wrote:
> 
> 
> I was looking to validate mlock-ability of various pages when CXL is in
> different states (numa, dax, etc), and I discovered a page_table_check
> BUG when accessing MemExp memory while a device is in daxdev mode.
> 
> this happens essentially on a fault of the first accessed page
> 
> int dax_fd = open(device_path, O_RDWR);
> void *mapped_memory = mmap(NULL, (1024*1024*2), PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
> ((char*)mapped_memory)[0] = 1;
> 
> 
> Full details of my test here:
> 
> Step 1) Test that memory onlined in NUMA node works
> 
> [user@host0 ~]# numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> node 0 size: 63892 MB
> node 0 free: 59622 MB
> node 1 cpus:
> node 1 size: 129024 MB
> node 1 free: 129024 MB
> node distances:
> node   0   1
>   0:  10  50
>   1:  255  10
> 
> 
> [user@host0 ~]# numactl --preferred=1 memhog 128G
> ... snip ...
> 
> Passes no problem, all memory is accessible and used.
> 
> 
> 
> Next, reconfigure the device to daxdev mode
> 
> 
> [user@host0 ~]# daxctl list
> [
>   {
>     "chardev":"dax0.0",
>     "size":137438953472,
>     "target_node":1,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":63,
>     "total_memblocks":63,
>     "movable":true
>   }
> ]


Follow up - i was investigating why my dax region here only created 63
2GB MemBlocks for a 128GB region, and the reason is a forced alignment
of dax devices against the CXL Fixed Memory Window.

[    0.000000] BIOS-e820: [mem 0x0000001050000000-0x000000304fffffff] soft reserved
[    0.000000] BIOS-e820: [mem 0x00003ffc00000000-0x00003ffc03ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000001050000000-0x000000304fffffff] soft reserved
[    0.000000] reserve setup_data: [mem 0x00003ffc00000000-0x00003ffc03ffffff] reserved


some debug prints i added

[   20.726483] dax cxl probe
[   20.727330] cxl_dax_region dax_region0: alloc_dax_region: start 1050000000 end 304fffffff
[   20.728405] Creating dev_dev
[   20.729033] dev_dax nr_range: 0
[   20.735481]  dax0.0: alloc range[0]: 0x0000001050000000:0x000000304fffffff

The memory backing this dax region gets squashed by this code:

+++ b/drivers/dax/kmem.c
static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
        struct dev_dax_range *dax_range = &dev_dax->ranges[i];
        struct range *range = &dax_range->range;

        /* memory-block align the hotplug range */
        r->start = ALIGN(range->start, memory_block_size_bytes());
        r->end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
        if (r->start >= r->end) {
                r->start = range->start;
                r->end = range->end;


and we end up with a mapping range of:

start=0x1080000000
end=0x2fffffffff


Why NUMA-mode works under these conditions without crashing the system
is escaping me at the moment, given that the page faulting system goes
through the same driver.  But my guess is that pfn-to-page mappings are
off in some way when placed in devdax mode, whereas they're correct
under numa mode.


Note that the above code chops off the first 768MB of the dax region and
the last 1.25GB of the dax region.

The CFWM is required to be 256MB aligned, but this code will force
anything mapped into that area to be 2GB aligned.  I don't think it's
safe to safe the BIOS is wrong.


It seems like the dax region ranges are being tied to memory block size,
but that a raw devdax does not necessarily utilize memory blocks.  Is
there a potential bug in the mode-switching code?

~Gregory
