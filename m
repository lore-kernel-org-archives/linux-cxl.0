Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B5C27C40
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 19:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjHWTjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbjHWTjS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 15:39:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E610D4
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 12:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwX3oY8ZlieBw7iBdY+ERcY5Gr8asidZJDj2+TSi24dha0t0Yl9jDhCnx7QoaOgiSGKKgkoI0ezEom3WeQthuexR7sYh+tB8UbAKjVPMM5rXQsWA6G8Dr+ZN3gZEw9eOrNYEfRyDap0P35kzhffvnnLghVx4BJfjnpefQHJz1bIBIYJ95CuNWZVQqJHoY2d2GCyl9i7iXZtTxARWmDvKynUBJUD5yykFE5bvE7Hm5AdyAYfgs0iOxN5GWf73D2g96LES266cF32yvLCV5p8NFbXeUFMUIZjHoA6loesJX52arJ180CbdhbCiWQPpZjul4yKjzAD/hKfrsNsU8wFCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vpFh9MUn6uRZnAKkd/VdOsE50/odVdWuVB91qKDiMY=;
 b=ja4CGlN//nfdK5sCHI5sNmhqik+rfTQQ143n93wHNI1uNvkhmSTcqxOQpgbd/m6ZySjQJiLezIl1+2kLAxIKtbvk7yu4NuSl0pSS8RTbBn/JocEHH+sxc0JcBpuMYJ7Ah8tD/2BiYmDgQt3U5PXpslTfoZkXSMJXzjAGf1qxIk9hPpjcbnfvD+IQ2ntDNUFnLW/Ud4KLFPVABYNeLgnSBZ2/yt2XcuT2v5UUWC8MNccoSoyF4TBVmsNNe+D7Gvz2QrBvzgfMhrg8pWeKfXWckJiDyMewhAyB520jle6M8FCTFe/nEuPuOq99tFHkOW6COr0Pph5kpY6u2UGwZ/0jAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vpFh9MUn6uRZnAKkd/VdOsE50/odVdWuVB91qKDiMY=;
 b=dohUPfmJF21usrpkCkQDWj5ksCUyTwIRjb6+iqazkMeBLVf1VrzFt4W1rsmzwc3tZUunrLqrLXYo3ZBHDf46LWOSRxg81EBAarBoXhkmD/dWLxxD7zPkt+qNowbLR+elDZsSvb421gBvjIIwDBM2YqdPXcJ2e43tpOaMGu3OAko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY5PR17MB6120.namprd17.prod.outlook.com (2603:10b6:930:33::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:39:10 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::180f:5cff:3e12:e654]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::180f:5cff:3e12:e654%2]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 19:39:10 +0000
Date:   Wed, 23 Aug 2023 15:39:02 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
        linux-cxl@vger.kernel.org
Subject: Re: QEMU freeze with CXL memory in Normal zone and stress-ng
Message-ID: <ZOZgVm3fx8fEf8xq@memverge.com>
References: <CAGEDW0dTTvnm-ZzSv_aDLNKj-gZja1A2s3+HKfY8wBn5rX4XdQ@mail.gmail.com>
 <20230823175526.0000368e@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823175526.0000368e@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY5PR17MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 376ddd1d-730c-4d61-cc12-08dba4109f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ccVYy566I3lDfz594nFNMPzMxnyBoBG6ZrtlkB8L5SH4ysddlfL+wOLtOKQQLqLf63kPwce/nIoc2CEXqnH/Y/GCgmLnduYYspjpGPecJYT3l8t6PRH46IFCcK3WIWuqdyJv6YIjZ4O5OFIGsyWykjDpqg/K+VOTtn/Bk6EKrqdvlbnIH/gWWkoY5608qcOk+vr/lzy0IkX7gz+awqLl3LtAvxdbGZu/PcHMLBXRHwv8kw5+nWCI0UAvp71zpBZA7+kjaz7h12D6pnQLvLtiCW5i8EVTNVb47ASajl+khAa1t6/IIiS0iGP88H3JW5d7rcycFttJd307zvmhe2pdQqWWPVR1I/L+0RBxX3P2IeIWXSLCv7VPvfKvQnZ8HRxDHZnz2dXjxg+J8NMtonOsb0g+M1E23/IR9oogYGjgB4cX7/6aNahEDuEiOJ+SaSZmEiRVoqU/pyrLgfmQKo26AdkrkKAT8O09PyRtIKvYdtWFu8uPfcdVnNeqBc5eRYwydOStBlHXo2c3JMGAN406KGpRoVv0ThsNTPPfhy9capb3WqAUMJcvc8DbkAtV+5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39840400004)(376002)(1800799009)(186009)(451199024)(6666004)(6512007)(6486002)(6506007)(38100700002)(66899024)(26005)(83380400001)(36756003)(2616005)(316002)(6916009)(2906002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(44832011)(4326008)(8676002)(8936002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZDL010bDNKbCtuMk1EY2tZWDVJVGlIZUdVZWpibFRNZEtCUzBlUmNnek9X?=
 =?utf-8?B?VlVrUFl0R0VqVkovTVczRVpiQXpuenBZaVJwYkVtMGlVbXR5R2RiUy92R2FI?=
 =?utf-8?B?S0FwQm1mUnVXL05mMDhWNmc5RGRsVDVsaldESGVOOXRvc2c3eUFLQzUyL05Y?=
 =?utf-8?B?NlhlR3ZEZGFrUFRIWmpUa0kwSlRVcnBWaGlmSU5NNDVnT3l3aFVtU0pvRlFH?=
 =?utf-8?B?UjE4TlZscy9xdk9TMHY0L01VaEh1SWNlVHR6T3RYeVhKTFdmTmZvQ3JIN3pY?=
 =?utf-8?B?cGgxKzUrdkNqeDhKT0NCYktobFJzS0hrNDRNcXlGRTc2eGQ2VzFMaFFmUU9B?=
 =?utf-8?B?MThnMVhzenF5L0JueVFXdURnci9uRnQ0dlpvVFREdWR0UWZWbmxWZzA1NlFy?=
 =?utf-8?B?S2NZUzBrTWlxRHlnbmlyQlZqMWJJYmtJbTN2TUlRSkFBV3htRkQ0dXhwT3E3?=
 =?utf-8?B?VzRBaGdOMk5vaUtSMG9KNXdSQ2NweDRzMmF1Y1V5TGF6bDNDZEtnWHpZVE42?=
 =?utf-8?B?K3NCd3pTN2FWWUNxWDhycXdJaHNlaGFoZThxZWJuRFl1VTNyeXV1aks4TWt2?=
 =?utf-8?B?cWJoUjY3OW1JejBFdmw0NFh2WVBndGNOaVBpOWZUeldDbTMwVDhnNlJyMlV3?=
 =?utf-8?B?WFh6WFptY2JxMmpVMS9lWUtRb3ZhQ0o0QXpkOVVSaTAwOFkrc20xZXpFbk9J?=
 =?utf-8?B?NnkxTnlrZ0JkanNIbFJPYklxUW9Zbk5mTm5YZ0hnYUFkN2pPVEV4c0tFcVd6?=
 =?utf-8?B?Y01DS1ZYQUZlQlJJYmFjUWU1YWtJZzdJbk1HT01zOEMxWWRiNG9QWXNvMi9p?=
 =?utf-8?B?eXgrN3RVZ2VxQzAxTDUra1NPY0g0ZUlQNXltNEx5akFMYmNwU29UQXR1UEVT?=
 =?utf-8?B?SkZ3RkM5VWl1cVhwVUtnaiswdUhveFlndlI4alN0N1V6VVByelRLOFNzYVJy?=
 =?utf-8?B?VTIyL1E2TVMzZGtwR0ZVeDY2L2pjNXlaRk9wUzVKWW92cUx6STd0eHRmQU1G?=
 =?utf-8?B?dXhoMkdRcFNMSlpMbk9DeDkvcjc1VDFFc0JDUC9EUVZoR2VuWEQ5c3BEMThv?=
 =?utf-8?B?SG1kMXRjUXZmZllTZWVUOTJja2kxM1lXd1pQZ3ZzTFBEYWMvKzgxc1BxTUcy?=
 =?utf-8?B?OGFxUk56Y2tiOHhvYnVTNlMrb1cwcW92a3NzY1ZQOUdiNDBrckJSOEZvbEt0?=
 =?utf-8?B?Q1NFUWN3enFHSkVCbTl2OStheWdQZ1VJYlJLc09vSVRWdFd4WVhkQzJnNHdL?=
 =?utf-8?B?NWhhUVR6QkI2dUZHYXdlVUcwanVFNjM0SGJORDFWVjBxQXJDa0hIV1h3cjBP?=
 =?utf-8?B?UGhISmxIU0RuQW9RUi9YVGc2UjJqTitObTRpKytTZkVBem1MalgvMXNEQWVW?=
 =?utf-8?B?WnIxZCtKeE1IcXVhWnFLN3MzR3U4YWxQYzNIZG55aEM3VGpaa3gwRmxpcmFB?=
 =?utf-8?B?K2JDNXpUdllWdUFxMzhyNS92bWxBM2JKdFlpVXNSNzgrZ2hMaklLYTlocUYv?=
 =?utf-8?B?U3lDYlFOTHFrQ1BGNUp4UlF0M1JrMW9IU3VhMzVrSHV0d1ZrVjk4a0RoWncr?=
 =?utf-8?B?THlxclgyOUQwaGlNVHBWckpMdDJYQ0ttZ1BxNGhGZHI1Uk5Da2Q5Sm1qZXc1?=
 =?utf-8?B?QmlmQW84bE1NaUdkUTU4SlFWMEIzVGg1KzczYVgzSWZXS2pnVVpZcld6eHdU?=
 =?utf-8?B?TlR4UzNMWVpmYUQzY1Q1ZDVQYTdpZWVQZytUckVWVjhVUit4VWF5RlpESk9u?=
 =?utf-8?B?bUFMdS9rNWZsOVRaWFVmTUw2RCtxNWpNTDlud29CRzdxWXBGNFFmYmJhWWxz?=
 =?utf-8?B?ZGRLdXN0c0hwejg0a3ErZllZVnI5K2R1VTBjaVFha2IyTlR3TFo1OGlNN0dO?=
 =?utf-8?B?ZDB6TlV5VmZVcThwZkprWEE2MFlkaXlxWWgxQWlsb2xhUS8vRzhXY0xqaVBO?=
 =?utf-8?B?eEEwSWxRVU5UcVpxZlRaQVduU092a2lpWndLbisrUUpkc3hvWU4zbVpkT2NE?=
 =?utf-8?B?L0JoMnkvTmVReWQydlVRL0lVV3FERWZ1NVhSbEJKTnNrSWl2Yzc1KzRBa1BC?=
 =?utf-8?B?VHpFQ0I2eFRTaGFNdTBXOE1NSUNmZ0YwcUVSOENUWkZjaGFBZS9NMFlUdGhw?=
 =?utf-8?B?NEJHUWlHQ0dLTjNDNWlrVklYOVA5Nk02aU1GOE4wS0tIOWd0dmY4TjJKdGRi?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376ddd1d-730c-4d61-cc12-08dba4109f62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:39:10.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4u9hAvadJVB43k7NByqCPcwhK7ddz1FYpWcCT38CvL//ATfot10rV3wEQBXydsUrW2OF2rSaNnNgK5J6PF/19q+P/RFPw9x2BUR99yq/Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR17MB6120
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 23, 2023 at 05:55:26PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Aug 2023 16:20:55 +0200
> Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com> wrote:
> 
> > Hello,
> > 
> > I have noticed a system-wide freeze when using CXL memory as RAM in
> > the Normal zone to run stress-ng. I am writing to check if this is a
> > known issue and/or if anyone has hints on how to debug this.
> > 
...
> > 
> > Running stress-ng in NUMA node 0 (not CXL) works fine. When the VM
> > freezes, the QEMU monitor can still be accessed, but the guest kernel
> > does not seem to respond to any external commands, e.g., (qemu)
> > sendkey alt-sysrq-c. Then, QEMU also freezes when trying to quit it.
> > I have tried to debug the (guest) kernel using gdb (starting QEMU with
> > the -s flag) but, after the freeze happens, gdb reports that “The
> > target is not responding to interrupt requests”.
> > Debugging QEMU works but I haven’t managed to find something
> > helpful that way. Also tried (briefly) kdb with no luck there either -
> > the kernel does not respond at all.
> > 
> > Patching hw/mem/cxl_type3.c functions cxl_type3_read() and
> > cxl_type3_write() to count the calls shows that CXL accesses happen in
> > both cases. In the "ls" invocation, I see around 100k reads and 100k
> > writes; in the "stress-ng" case, I see approximately 4 million reads
> > and 2.3 million writes before the VM freezes.
> 
> Long shot, but can you add code to print the address and size of each access.
> There might be something nasty around edge conditions that we've gotten
> wrong in the emulation - I thought I'd poked them all but maybe not.
> 
> Right now I can't boot QEMU x86_64 TCG to due to an unrelated crash (nothing
> to do with CXL at all but is present in 8.1.0 release) so hard for me to
> try and replicate :(
> 
> Jonathan
> 
> > 
> > The issue does not appear if the CXL memory is initialized in the
> > Movable zone instead, i.e., when using the daxctl command without the
> > --no-movable flag:
> >     daxctl reconfigure-device --mode=system-ram all
> > 
> > The issue however appears when using a volatile CXL device and
> > initializing CXL as Normal with the command:
> >     cxl create-region -d decoder0.0 -s 1073741824 -t ram
> > 
> > Any ideas are welcome, thanks in advance!
> > 
> > Kind regards,
> > Dimitris
> > 
> 

Something i think that is not well understood is just HOW slow the
performance of CXL memory in QEMU is right now.

1) No caching of this region is allowed at all because it is considered
   an MMIO region by QEMU/TCG.

2) Code running out of this region cannot produce TCG buffers, and so
   any code page hosted on this region must be constantly fetched, by the
   TCG non-JIT/binary translation emulation engine - even if it was
   previously executed.

   This can cause instructions/sec to drop from 100s of millions to less
   than a million in my experience.  Degenerate cases can be very bad.

3) Beyond instruction fetching, any data access requires an MMIO-style
   data-fetch, as opposed to a simple memory buffer mapping and direct
   access (e.g. what normally happens in a TCG buffer cache).

When you initialize the region in ZONE_NORMAL (--no-movable), what
you're really saying is "sure, place kernel resources there".  Once you
get memory pressure, you have the potential to start having the entire
system utilize cxl memory for kernel resources, as opposed to just
stress-ng.

To me, what you're describing isn't the system freezing.  I have
observed that the performance of CXL memory is so poor that the kernel
will simply prefer not to use the memory at all (as it in will prefer
using swap space instead, because it's that slow).

When a system crawls to a halt like this, it's anyone's guess as to
whether things like watchdogs and background tasks start preventing
forward progress.  Your interrupt injections may be masked by emulated
timers and all kinds of other stuff.  Basically you end up in a
starvation situation, and the only real answer to that problem is
"execute faster".


Until there is work to enable caching of CXL-hosted memory, I'm inclined
to say "Working as intended" because the accesses are happening and the
system appears stable - if extremely slow and non-responsive.

~Gregory
