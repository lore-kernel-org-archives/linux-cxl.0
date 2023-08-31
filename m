Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902CC83F2E
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Aug 2023 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHaQ7j (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbjHaQ7j (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 12:59:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33427A3
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 09:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0zhTN0pnERuuHL70GHj0+y2XKPX3NYUwkEUGfo5vbkUg7QkDIZikPxU3AcBz1/shqOtvNnmGe3xkiiUGtfMuo2KZUkmK2S97MXCzZwbWKxA9xSQ2yDYNomEzqVsBv+1OmnBugv+w9L5ENmvgqU9n3cFNdbpGD0lVGkr94s5NFenoZUhOSllLQ5Edg751Bhfj2ygmc+shfoYNpCdCZ5UFKutQY8Jy3baQBGtNNDxY7UFy1IXLjQY+ttANG1eJYAqX2RBMYauzyax/cgYE0LJ225Q92hcvb5pAX2QBn2/481UmZg1zvAuRf0VIAkq71syNpmbx5TIFqy/qdFWzKXBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw8oI+ymk/6cREMEQrCAVbwzgBZWgxLuQRj2rrcloqo=;
 b=DlEpXiASGVdy2lBMwtya9BDFjn5Wp3OcCKicxiyLhDHaG7qEbpApe1hA0jQX8mzS2L5HtlEk4WXn5cLW5IjtAxGXQMGYhSxubtjl8Mnae3kSxVtjDyBlzAKckjIYu2R3HmFVtMnPrTMOcfJU4ANZN1fPwSVPiZ+7td46PUXo8IHQb/YMEtwSos0JHrI1EYbnyMd3cRPOTLFmmCyWGEtdrIVdGXasdXAmDyj1sXlQDFbSeMX1r5yz4U+sogAVmZCMcQP7XWaT9559yaeWZKTZXNAKk8lk9lVx2UwOCGGzGs97nXeONda9d/o8hrizl15675IXgv0BhMGdTeEm+lDBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw8oI+ymk/6cREMEQrCAVbwzgBZWgxLuQRj2rrcloqo=;
 b=ex2x67mzcO5eNN+KIkeKY8UhNdPcLAx7PvjplZQy2kxB6UMN8+bJX4QPdC6GbHnAq/EfE3sA6TiUksAyTT+dav/XbHVneYvxgDa5jUrkINLkjCZySBcu8+ZWrM2LQ+r6zJfCawpBt0bvoz0Z90SO7m8zOHXx7Cy6urkwQH0USJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4879.namprd17.prod.outlook.com (2603:10b6:510:8d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:59:32 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::76eb:3cc8:b142:feb5]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::76eb:3cc8:b142:feb5%7]) with mapi id 15.20.6699.034; Thu, 31 Aug 2023
 16:59:32 +0000
Date:   Thu, 31 Aug 2023 12:59:24 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH 3/4] cxl/type3: minimum MHD cci support
Message-ID: <ZPDG7EKSXmMSAiJa@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
 <20230721163505.1910-4-gregory.price@memverge.com>
 <20230807155609.000055db@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807155609.000055db@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9da406-3fb3-4bdb-9c41-08dbaa43a587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clUV1BX4IG3c0WHCisgramXvYA/xy/wDgG+eVv7Ee4zsj2lpdd4SDorONC8vIpkFzsDdfJ3R0UsiVCwT8kzv0zo0wzICzomzufmGnTO3poRiPPW7tJR/9CeDHhuN6Pj6fcnadFjYEcS9e5WYCm3oQyVLYz2oIAMElaSfg8Nn79js5i1z9dq5lrU094Svk31P3o+wfRroHMLEV8zYgJig0girTmF4OaxaROqnbXWf2Y8H3+bR+Z9omso+5iERkAGSuBceDrS4k4iBUe4duSpKgq4yxJlhBm9lG6T6YRDZJSJWXuVaKN5vBaF3n53a5PwuoevQew9js0GekhCZdTKO2zluFlexw3JB87UzixmNVuTdDtA3zwPThDaW5S2FB/GNP1unN+mB10fZE2akocZZztkQYxAeMCCORoA143wPl+TPQuNIKzmv7PLiTj46gXOdg5lCP5u1TFdnW5ljPLzZibdD5zIk35+1+kzEu7WLTvj+ujjS6zG2ZKlJbU+UAWIMhNamBJ/GqpJhv6fTKeqIk5M8ppmq36C13IEZevistaKFFBOWb8THh1+h9IijkXVY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(41300700001)(8936002)(83380400001)(66556008)(8676002)(4326008)(478600001)(66476007)(6666004)(6486002)(66946007)(6916009)(316002)(2616005)(6506007)(26005)(6512007)(2906002)(38100700002)(5660300002)(36756003)(86362001)(44832011)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjRSeU5qT09xK1NaSW5EcUt6Uk5RTEdjNFpGcDlTdk9SekcwRUFXRnlXeDQ2?=
 =?utf-8?B?anJaMzZMOS9PRkFsdk1Lc3E4Y0RRT3RzSEdwL0drVksxWVhRS0lrVEJtMUxL?=
 =?utf-8?B?Y2ZkQWtncitYRTJVMVowZ2xCMkEzQzFHZmhqRytuR2dpOG44OGZocW9heHNm?=
 =?utf-8?B?WFVYQ3NvaTQrbm5rMGRCQnZwUm5UbC9PL0oyVzNRa1NVTVEwRmxBUWFBMVRY?=
 =?utf-8?B?M0FDaW4wOWc2clFNN1VlMXpOSFhXTEJ4YWJNQ0F3VDRaQTFSZjRDdTE0ZFJP?=
 =?utf-8?B?ZVRHR05uZjl5OFNST0p6U2lPeitxMllUTnR4VEpFK3B6U1A2SEdORytDd1J2?=
 =?utf-8?B?OFRSS1V5ME1rVkpCMTc3S3oyL3FDSVprVnNqNzJNS2REQmZpdkFzRGcyc3Jr?=
 =?utf-8?B?Uk1Kc0RIK2xHT0lEY2FnbkV2Q0sxT2ZkWkdXdW5IaUpCWHFQWW5JMnQxSlky?=
 =?utf-8?B?NDhJc2VtMEwzQW1QZjlwZmFMaHlqOFpoVXBoeUVqNk1nUUFldVBTOTBkaXJT?=
 =?utf-8?B?YWs1TmpLeXprenRXcVV1UzBVc040NmpqVWRlUm1BdUR2OVpSSU81MHdYTlNU?=
 =?utf-8?B?ZXNjamZyclJPd0hJdkErSTZPRmU5dUJlbDh1STFObmsyUjFJakdGVmF6YWRy?=
 =?utf-8?B?S1Y5Sy9XL3ByNG9ZNklwK3dOYW9RZ3o5R3BCaVl3Z0UxL1pkR1BEVzBuK1cy?=
 =?utf-8?B?Z3A1b1phdFB1bGpZT3c2TXNUV2tncEhkelZwZDB1MnJiV0p4YXdXUmwwU3Z1?=
 =?utf-8?B?eUFZMlpHbTZKV1dSSmpXWmljbXJ3VGxxY3VpTE5vTVNhN003NVprL2h3amNT?=
 =?utf-8?B?TGZ4SWNkQWJ6WjFSa0hPZUdGRGlaaEppcXpFeVRQZzZrSXg3T3Y2NWlOWVBr?=
 =?utf-8?B?ZVhSR003YTRVVmVIK3o3Z3R3SW9HRjk4ajNjM1VSc2hkOWtLeU5vbElDVitF?=
 =?utf-8?B?bWdYd2tqcmxVQnhiOXRUNzU5RUFURXIwK3JuYkpPdXAyZ1lLazNBVmFodExK?=
 =?utf-8?B?emxlZ0JuRlhtK3JDeG8vbEFKTnd1MVZuQ09rL1UyMjd0MTA4VUMzdTNORzlB?=
 =?utf-8?B?UkFHdFhaVnU1SDBsakszN05FeDlKYWl6L1hDT3p6ajlrbWxaSmI1UnpKR2pY?=
 =?utf-8?B?SWlabEs5d01NakFYYWJaMUIzeUVjTnJHR2lwQks4RndjQllmMCtGZlpwQUVl?=
 =?utf-8?B?VUt2RmpZbGQxcGlubzZIUnAvQllMdTYvMTd5RzlYRm81TEZyTlhNWnRWWXlD?=
 =?utf-8?B?b3Q1YzZveXNyeWxEMlZBNFlMRTFMYVJGT01RSFpVdm9CNHZWOUtyWm1lTEhI?=
 =?utf-8?B?N0tveFM5Yi83Q1d3Y051Mjd0cnZlMS9JZTY5aEhaMlZlYUdQVHFGVGIvYm5I?=
 =?utf-8?B?dklVYVBMaGx2QzR0UGsvb2dzZlQrdmhqdUVkQVJVYXFXNGhXN1lOMU1zak01?=
 =?utf-8?B?d2MxZC8zVzlUbzlWT0c1YkZtOWdGWFF6eEptQmtJMzlaaUVkMHI3ZFZyakJm?=
 =?utf-8?B?SFJIaEtoU2pISnlYSDNYSkF6N2FmdWJQV0k0WmRGYklWVWlmMDJTVXhBSFZD?=
 =?utf-8?B?YzlEMm01Ykkzc0ZGSFlBREg1TFpBbU40NFovOU5TNk5SRkF2TUZlSWY3eUl3?=
 =?utf-8?B?eExWY1dSWHpqN2YyVmQ3Yk9ZeTJ5ODdFb1RWZUdmLzhHMk9aakxjUG5vaXV2?=
 =?utf-8?B?bFMwVEU4RGtzZlBKMm9LeWo4NWtPTzA4dnZ0cmI2YnF5aE5yM1FOYkZpUnpX?=
 =?utf-8?B?NTQ5YlNJNWtGK2FxRldzVm9ZZWxBQ2lXUm5XSXhWMGhDaUhPRUFzQ2ZteDkv?=
 =?utf-8?B?THhVWk00d1A0eHA0VUNYZmtpTnpubmg2SGFHM0ZtbEhUUUFZUnR4b28zNjFp?=
 =?utf-8?B?S05IK012a25LWE5ML0wrZHM3VithSFJseFpLcnlvNlBuU3FJUjBqUzNqNWFI?=
 =?utf-8?B?TXJmVy82Yzh6K0puTGtEK0JOOXVDWXJxUTJGQ0lscFpKK0Z3RDdYckZFN1hZ?=
 =?utf-8?B?Zk0ydTZpQjFFRVZJd3AzZFRBTFNwbUZic3pRZkQ4RW81amgwMmNoVlR0M3VQ?=
 =?utf-8?B?cksvR3k5NU12bVNEb0F4UzZQb0U2NU1ORG1sVGtoRmg5bWJHRFlraGdNNEx4?=
 =?utf-8?B?azZDRG5CSXBmcVhoRklyOTR1QnBrd08vamJsZnAwUUcyMkRMSVYwQ3VGQ0lK?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9da406-3fb3-4bdb-9c41-08dbaa43a587
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:59:32.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMpuut8crJHebwI4BNdwS97KUlp3kZ9twh0LBPJegnPVIqMS0l3SzktA7XDPJEWt1WX634Kd0Onm9p9Sq+7IS74moiBRXdEXKts3KIJ0vrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4879
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 07, 2023 at 03:56:09PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Jul 2023 12:35:08 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > Implement the MHD GET_INFO cci command and add a shared memory
> > region to the type3 device to host the information.
> > 
> > Add a helper program to initialize this shared memory region.
> > 
> > Add a function pointer to type3 devices for future work that
> > will allow an mhd device to provide a hook to validate whether
> > a memory access is valid or not.
> > 
> > For now, limit the number of LD's to the number of heads. Later,
> > this limitation will need to be lifted for MH-MLDs.
> > 
> > Intended use case:
> > 
> > 1. Create the shared memory region
> > 2. Format the shared memory region
> > 3. Launch QEMU with `is_mhd=true,mhd_head=N,mhd_shmid=$shmid`
> 
> I'd definitely like some feedback from experienced QEMU folk on
> how to model this sort of cross QEMU instance sharing.
> 
> My instinct is a socket would be more flexible as it lets us
> potentially emulate the machines on multiple hosts (assuming they
> can see some shared backend storage).
> 

I'd considered a socket, but after mulling it over, I realized the
operations I was trying to implement amounted to an atomic compare
and swap.  I wanted to avoid locks and serialization if at all
possible to avoid introducing that into the hot-path of memory
accesses.  Maybe there is a known pattern for this kind of
multi-instance QEMU coherency stuff, but that seemed the simplest path.

This obviously has the downside of limiting emulation of MHD system to
a local machine, but the use of common files/memory to back CXL memory
already does that (i think).

¯\_(ツ)_/¯ feedback welcome.  I'll leave it for now unless there are
strong opinions.

> else not needed if we returned in previous leg.
> 
> 	if (ct3d->is_mhd && ...
> 
> > +               (!ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {
> 
> How does mhd_head equal that? Default is 0. I'm not sure there is a reason
> to require it.
> 

Good catch, the default should be ~(0).  Updated in the field
initialization section.

> > +    /* For now, limit the number of heads to the number of LD's (SLD) */
> 
> Feels backwards.  Number of heads never going to be bigger than numbre of
> LDs.  Other way around is possible of course.
> 
> > +    if (ct3d->mhd_state->nr_heads <= ct3d->mhd_head) {
> 
> mhd head needs to be out of range?  Confused.
> 

Woops, yes this should be mhd_head >= nr_heads. Wording is backwards and
so is the code.  fixed.

> > +    if (ct3d->mhd_state) {
> > +        shmdt(ct3d->mhd_state);
> > +    }
> 
> Reverse order of realize - so I think this wants to be earlier.
> 
> >  }

Just to be clear you *don't* want the reverse order, correct?  If so
i'll swap it.

> >  
> > +    if (ct3d->is_mhd && ct3d->mhd_access_valid) {
> > +        if (!ct3d->mhd_access_valid(ct3d, dpa_offset, size))
> > +            return MEMTX_ERROR;
> 
> Brackets for inner block.
> Arguably could just add the ct3d->is_mhd check in the place where
> mhd_access_valid is set and hence only need to check that here.
> Maybe that makes it slightly harder to follow though.
> 
> Also could just unset is_mhd if mhd_access_valid not present..
>

I'm going to change the next patch to fully inherit CXLType3Dev into
Niagara as you suggested.  I will have to see what falls out when i do
that, but my feeling was being more explicit when checking pointers is
better.  If you prefer to to drop the is_mhd check i'm ok with that
simply because mhd_access_valid should always be NULL when is_mhd is
false.  Either way the result is the same.

~Gregory
