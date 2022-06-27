Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7451C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Jun 2022 19:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiF0Tsa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiF0Ts3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Jun 2022 15:48:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016F1B7B1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jun 2022 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656359308; x=1687895308;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=YMJ17URMlUh5GPTpLHV7vLSHZG+fZN/xOueH171xU0E=;
  b=hs7uU+4zGxQksHzwgKRpxJFqjU3hrzqEGFVLTRVhdfxYuaT3axXPIfo+
   kFli9bXBVJP54tOgaDM/AbXXNpfWadD0KHaoXcoKJC+jDTVEOt7tcgp85
   Fz/nfnP1suUvx6DJMstaHZ+uzn46v5Ox7SjdvreX4eUpiYPYYlLt/1o4I
   /Jp7KyBZUwysHQKKwh6J8kopJBmNcvmyZM7/UHF0HGf3rSl2McJrv4/ux
   tV7LAOwvllob0F2nKuaqQqkZXm7S0EUzAZYzL7Fe3g4YQ5mv/8vPeMS09
   qIxwtDidBnXF2XQkZUTYTYewD2xSe59lSR92HB+mJtoDAtazmE5Lt/yxo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367862045"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367862045"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540230946"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2022 12:48:27 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 12:48:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 12:48:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 12:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAupAd4myY7RatS4x+K3DmB6+DsS3URJkbVGIk1ZrU5HlPQlShZSlUg1KDKDQDV0Xfr9rPcYZ68H4WM3bx53gyW8hieBfswDc88PcofYyRwtWsx+aNliiQR4qpMa18qh8IcQj4vkQ1ZFV156DQVYihlSKHioETTQEzJZlTta2Py8iW2/J2VcI1zrIdTIU/zoJag1TGohxXiXkk4oahh4rFgRA4XCkwFokUzhmOa9rtsXOUAnQc8JC/Z/w3pJ7UwrMSMmDuoq/+fkl4wtG+Ig7oSyKs6HIflMY24Z+7GVyKV8F0e2c/5sLaZCpk+qsQNwoMjO2k12CP2uGnxuZBDdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz0qHHTGX2Cr+whOfMWW0IxUDS7ffsET8UP26Beh9JE=;
 b=ZWvBoDK7zci9veu4/UulTUFdmAJwP+96zvcFKqrmSsQPRacXRWEAHDsjqVdve1VcVfYSC5CYw5+3nYOxQ1phuXTj4Y02k+rFIgrycGuLR/EHjJuJ0R29bhsjKN5Zkt62FT71W8kQmg9/gv00Bmwo6CMAf56RLc6yMDK+qLQAeelhqlupRyFLVBeZZ1edzFaSmxxhvhFHft34vA6v9tOXUAo6HaE0XcLv90+MZkHxOHL/+PJ2vPwuazYWsflq1E7iLKCkxisQWMzGO3kz7Ak3RezaiCCJ4RUgpC2uErPvDZdVqROX3x2IiDtspwjHeyBNRJdYxZ7uoOuihY46NKHJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5574.namprd11.prod.outlook.com
 (2603:10b6:8:39::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 19:48:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 19:48:25 +0000
Date:   Mon, 27 Jun 2022 12:48:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mani Subramaniyan <mani.subramaniyan@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: DVSEC FLEX BUS CAP bit 3: MEM_HWINIT_MODE
Message-ID: <62ba0987bc7cf_1134f9294f0@dwillia2-xfh.notmuch>
References: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS7PR12MB60074C18A01B242F165F68009CB99@DS7PR12MB6007.namprd12.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef44fd7-941a-44ab-60ee-08da5875ffae
X-MS-TrafficTypeDiagnostic: DM8PR11MB5574:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+PDP30h+OHi+vq0cws/eM4u/sKicH+7yPO+tCJsn43/Z9b4YzwbOkvAUtu0YMiJLKjvWN+6MfRSMyFeDzlk3bB9Pve9nSH2VdkZhc8cOcV9zDHs+uoLas3C7vDErQhMDbnerg37j8IiAgYMj8W+RJNZC4FR/NMxlMw4T7bBCMaR069MBvpVKIhzA4SaN8ySeSy8PhTK9DFpA0ta6oMjWHac60FjVblXWO/eJTozYrrc5pfI+X5ZW+pGnOFYpHfJENG2ksDbt6UEb8Za69XsnbBhT749UML1yjjFIZkX/nRVJdnIhK56TMVZ18iTPWjXCiuav1yETuQJZlWQgeS2977REbFp0bJvOQJkXH8QMUT8rJfpnWX/EKKyU6eUoqRbQHGPXTPG14OO0QdvuUm9/HFIcg8pIagd/UojDRC+943A19K1wFLTXT3pkAt4817/DfdljVBfNKkDsRlZlCWfwd5NH8K7n9pHXDTg2SRtwXBP9IQ5UElDMDREJsz7/Uk6uqix5K3JfYIKIaOdsRJEWynA1HQMdsWTANRy11bz3xAmHqAN+54e5e7rYSlF6pO7fUiSbDkhFJd26CwdMfCpa7nFVpnDVWQw18RcCsr23xsuJMdwrwlKkDeWpCormuihDF6KhHbrX7YLk6qDYwTxTBXZ+EvNR8ohgICCXLVBal8O3/tbmUhu3/55NNND8HmosBTPYAdCLXXfEsI4EYsudVr5vkfK8gyQHI8nZvmp5iovTAaM2b4E739GNZx1SE3rkqnctBmM0jrUaa3h+erHHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(366004)(136003)(316002)(66476007)(26005)(38100700002)(41300700001)(8936002)(83380400001)(66556008)(6506007)(66946007)(110136005)(478600001)(86362001)(82960400001)(186003)(2906002)(6486002)(6512007)(966005)(5660300002)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nn50sX2bffxI8DA4/Xq5pV1jdvIxYqYCYDHpnvmvZ55HE7M+1No/u/49u2HV?=
 =?us-ascii?Q?RAQNhZW0BQxQFyUGL+0RD7kGOjbsx3o4bx4TAGSxPu43v+YhBnHb9X2v0xFr?=
 =?us-ascii?Q?dOyiMK6xW5LNCSf2cNXvgeUvuyP8WgO6EU6bKEuhX23d6vYAv3LIXcoGPZdF?=
 =?us-ascii?Q?Iuk7NbgUwR6HYiPuH81cEUaK02OJIe5h1/ClDQNT/qfecfaz3efa8qi3xg0b?=
 =?us-ascii?Q?A5EmkMRB68EyuIh7FPOsfdnuITvb+NycWQlyOwwo6bhurcMtwQHGfpHdAMfu?=
 =?us-ascii?Q?SeSs+l5JM/2O776MlXwASx5KJbpGiIxYBGyd3uvGBi7btV3mDUy7JB6qdZZm?=
 =?us-ascii?Q?X924dm7RHqUuEBVZfqWWFm/ePsRXc9+sE5dsRLnCQy1iVOjFTJ7lSwFOGo9p?=
 =?us-ascii?Q?M01p1Cm+t7YTQ+ANxqRzTiCUnSwbXFdRY24HV4wvkgXbimITOUZ0dvTQafuN?=
 =?us-ascii?Q?Rrs/jC0CKT1O13Z/9Q2w3ifRO8zPweIe0CuaHPGt7kSbfKXaLeWoyoDMrzW9?=
 =?us-ascii?Q?jpvRfwZ6HzuyOMJzxkSUKZhLu+6W5vsnAj3M4AXgMxXr8XXmNWWSEy+Ow/tC?=
 =?us-ascii?Q?JVtBn9emqY32WJoR8/Qp42qIL/+qHcvc3ZW40usaexendNarPDn2SpQtzOJl?=
 =?us-ascii?Q?phmABcpSpeVBABi9zhjWJ4+FicjjWIydx8Lhr8tnK3+yKlstIBnx6hq6Biww?=
 =?us-ascii?Q?CdTsslnVpIG8rVnELcOBK2sVqZObLAzPwxqNsieF2YloF4URJ98Y+t7OnmAm?=
 =?us-ascii?Q?Zg9t4QP9axAA3Q50GCQw1W3I4LciWLpHHWfqp6pyXY1iIK1BeA25/zT+9Knf?=
 =?us-ascii?Q?slp2L820YTN7JLqzRnC7ORcnJUVgQJDsT28VS3ttSHWQy0jNZWBEtAAZboAY?=
 =?us-ascii?Q?ymmHv5dXEdIs3BHCknYIoHfYNdFdmYEnnes+Na2WxqHfWQgEgUMJar0ZhA6D?=
 =?us-ascii?Q?poiI+cVcA02EjgC3/GiPefk9MAb+iLoyt7zmcFshbW4gU1f4iRAuM8IFQsP1?=
 =?us-ascii?Q?qQp8IxSIB9bAnWB1E6Kdu23pNSDx4yPZnYKNIMDC4Tt7xzh/c46isRNH5Uho?=
 =?us-ascii?Q?U0+6D0qDJi6SJb78r4WRhlNsFAAXyr8zl1HVTYHKQLBxBykggi9yhuR5zFcg?=
 =?us-ascii?Q?3AQ/6YZfaySPmRPJV6Wf4fiYuQB0Ob2V7rML77E9cVQioiyM06GppC3qqtW2?=
 =?us-ascii?Q?Uhe9UdZ9uVFvKN0Wzwt14MyoXp4tMCFlizwjV/DPlvYhmylR3xDk5e0eCU+U?=
 =?us-ascii?Q?YOnm48mjC5PUyAxPJOHIT+IHWRwctdenKKlGaVn+CDLWo8j+AEx2dNcT4tzM?=
 =?us-ascii?Q?MqhFqy7r3CsqDtawmuGwkn0D3KmHylHT+aJwTYwWvg2N24ES0+JopBCZgL+k?=
 =?us-ascii?Q?n/gniEBtzxdoL2AzrRdCR1FIfN+WwjFNJwrIudNdtAm5M5FQMexyRsboSLiV?=
 =?us-ascii?Q?dhRDMBbcI2zXnrFl5n+VPkDCWz+AVwpZZ0AnmIvNP7yc6dqmCjITUYrASYO6?=
 =?us-ascii?Q?BMjvxYpeeT6k4V4EVluW0yxloPDAbmtUPf0UaFPrjjMpu1PG4hOQdj3Yzl6k?=
 =?us-ascii?Q?pN51shnU5qh7VTzGhslkV7e3WcnsEkYiWH77ymdsEJcLKdHA1xW657lBoPAm?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef44fd7-941a-44ab-60ee-08da5875ffae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 19:48:25.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4oTkEtn80vDnCNwLjlPUDayDIMDkUuULv8Qes9d789hMBYe4+cA7o2WquWihXJlcGllUyf0LIWJww871kCm13E/TPJPXbww963xZiUOU/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Mani Subramaniyan wrote:
> While reading the CXL spec (both 1.1 and 2.0), of the DVSEC Flex bus
> cap (offset 0ah, bit 3), I see this: "3 RO Mem_HwInit_Mode: If set,
> indicates this CXL.mem capable device initializes memory with
> assistance from hardware and firmware located on the device. If clear,
> indicates memory is initialized by host software such as device
> driver. This bit must be ignored if CXL.mem_Capable=0."

Hmm, to me the specification does not indicate how OS drivers can initialize memory
in the MEM_HWINIT_MODE=0 case. It says impossible things like the
following in "9.11.5 CXL 1.1 device discovery":

    The OS device driver is responsible for setting Memory_Active after
    memory initialization is complete. Any subsequent accesses to the HDM
    memory are decoded and routed to the local memory by the device.

...which is impossible because Memory_Active is an RO bit. So yes, you
have discovered a gap in the Linux handling of the MEM_HWINIT_MODE=0
case, but I think it looks like a gap in the specification as well as
what the OS can expect of memory readiness in that case.

> 
> I figured that I would clear this bit so I can load my driver for the
> CXL type 3 device and also reset the memory active bit in the HDM
> entry (range low address bits). I was experimenting this on QEMU
> version 6.0.50 from Ben Widawsky (branch cxl2v4-doe), running an
> Ubuntu 64 bit Kernel ver 5.18.0.rc7.  Here is what I see in dmesg
> output: 
> [   62.234755] cxl_pci 0000:09:00.0: timeout awaiting memory active after 60 seconds
> [   62.235793] cxl_mem mem0: Media not active (-110)
> [   62.236447] cxl_mem: probe of mem0 failed with error -110
> [  123.674758] cxl_pci 0000:09:00.0: timeout awaiting memory active after 60 seconds
> [  123.675800] cxl_mem mem0: Media not active (-110)
> [  123.676450] cxl_mem: probe of mem0 failed with error -110
> 
> In spite of these error messages, I could use the CXL memory without any issues!

Sure, the driver has no role to play if something else has already
programmed the HDM decoders.

> My purpose is to load my driver on this device and then initialize and
> bring the memory on line or use the memory for my own software not
> giving it to general memory pool of Linux. 

This is a flow that the native Linux driver will support. Memory will be
assigned to the device-dax subsystem. From there it can either remain
dedicated access through a device special file, or optionally shared
with the general Linux memory pool. See the "persistent reconfiguration"
section of this man page for examples of what this policy might look
like (i.e. it's still a work in progress):

https://github.com/pmem/ndctl/blob/main/Documentation/daxctl/daxctl-reconfigure-device.txt#L244


> 
> Since I am new to this alias, and not following the threads fully (did
> do a search though), can someone point me in the right
> direction/clues?
> 
> My questions are:
> 1.	Shouldn't the Linux CXL code have looked at the MEM_HWINIT_MODE
> bit first and if that is not set, should not have complained about
> this mem active bit, assuming that the software/driver will initialize
> and then make the memory active at a later time ?

Perhaps, if there is clarity about the OS responsibilities in the
MEM_HWINIT_MODE=0 case.

> 2.	If a vendor driver loads,

For generic memory devices expander device why is a vendor driver in the
picture? For accelerators the expectation is that they can use some of
the core CXL infrastructure to manage HDM, but we (upstream Linux
community), are still awaiting the first use case to take advantage of
those core APIs.

> talks to the hardware to initialize and make the hardware change the
> memory active bit state, how does the vendor driver, if it wants to,
> gives the memory back to the kernel? Should there be a kernel call for
> that purpose or this is very similar to dax initialization and so there
> is no further need for a kernel call? 

It's very similar to dax to the point that the shortest path to get what you
want is just use dax and the generic driver, unless I am missing a
reason why that is not possible?
