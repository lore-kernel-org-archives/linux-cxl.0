Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A3C38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjA1AU4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjA1AUb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:20:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587678D41D
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674865127; x=1706401127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6Ky7KRx2PO+/bp+uyrK3koOg8QrF0bohkM6N17qcQZc=;
  b=eweUMrxCCmeeCcnWJUoGOS0quY8Rf3CXHP5lOhZkIrd/CbxYaBQ4ikww
   4/JAXORUg1RkZS5j7jig0APQpZxv66kcLxSAXiEu1cgqsSAffYUd91Nn6
   wj5i8rA2ysdM8btaCE2A0zfr97E0nzbHgti5lFR8uIYptJrY9P1zCogmM
   KeNpLQj8Nn6NpQSP3Bss59/mbfT5q9LV1AmPVa9dvrYPenq2ACMPlSQTr
   SYqblwbcKESfGL2e4nHKhg9R9qFAhtgT7g+zjQk+4SlUlgxZgUvEwqoJM
   AZ5QyDlmpMtszAeuSpBxFzyrvRSBQEUJskH7Da5OJiV2chMF2+r81ktig
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413452596"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="413452596"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:17:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656794623"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656794623"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 16:17:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 16:17:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 16:17:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 16:17:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWiZfxIQfQdnfSO7GPybIq4LKlqFPYDMQEJ8xFl4G7n3qZC6LpokTPdABBBxz0s8Gs9S94i+KCL3bL8ZZ5grJissvs7cVEGN6YRat46+vqg1+D1A0HXE4loi+/Gqykdil3uVOmjkuVZFcZ7frtimMFkO03oOtEUaR44AZolnrNwTrabmAU/IozvfF5W3+PUXZYk2GMUukp83JI4Irs7jPdohFAmG1ZkobGM0vQ4ZDVuEfIiLk9ugf06fheVHDqzRSdS/mWz5tqMQF20VeR9Y52/IGkf8X6zroOl6AV7dQVN4J+L3DElfcNWTbkhN+zzhoxLpof4hs9fhzG99G9Xd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raiH0VIRZvGOX0DP+3p7TxlnTiKw4VUyuRQ2341TF+g=;
 b=XdoFhRwVVDfcULfDjPUoGJCvJSFQR2z9Vxqn0dgTgov0qVI/v6/TM3AIqh1BJMxAvwO3+qijar1yIAQ22VDT3Z8BCWToY9I/xMIB5TZ1ukoBNT0uX4mICMTisng6Q9NzM3gQZ/L0agdwQ9sKgcpRXPZk+tI4hppGFWeZ6Pe+OWYkHx7VETbpUw4CQZEIHbkMCRkJzFTjUa22JOCi74gq13aacPMpvzQlduw2sjw8/a1FSUNPqWZYvm5oJbOg5Kr6opl/z4UhNgrOclVtuzXYaPFyzAJu4HSgJl6yjkQ9nkF0FH+jGjycU9ZeCNvW3zMtswTijNCvXeS6Vqlc9ArNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 00:17:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 00:17:34 +0000
Date:   Fri, 27 Jan 2023 16:17:24 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <63d46994aedf0_3a36e529477@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
 <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
 <20230127100406.00006c65@Huawei.com>
 <20230127121013.00007966@huawei.com>
 <63d420d6dc5fa_3a36e5294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <63d463328d2ac_7f63c294e2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d463328d2ac_7f63c294e2@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a390df-cb90-4c91-b1ea-08db00c50d7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0H2IzDz5InuhqckU2QumpoJzxUGPdY9GT/31K4IDOMwLbaDDZbaVoupOsUVamIbS/Xch2OZbWAMybVNSgWZCKsxmZu+4Gc/fUOHspfiF2vKWJN/RFlZ5l+38hsJiQlmTu178TFY1xoqPgjwN3Jdjm5PQBy2VYYToOdvleCIlExziSFN8Qw1wTCGqkTHc6C2ZpHwAFhqjsjwqfDsC3Z2TV710summk/mW8Ek3ts/7pazZpsFOdoqlX2PGnOQJnLTAfQOyhInYXnDpR5mGJKlCj8WMd5LtoWL+xbTcWOYvUO4TECk42VrRjS6t2rblBvsOwIYboIU8gR07sxGOcWaHXwvYtOl2xmR38UlGc/yDT8hKVaQGnr0aa3MKNGzPcl4B37rUibrkVqTNkwmtV9oOIPVrkJjuRwkmPLHawsfS5AMQpGV+60ZwRnr5ceR+cSVS1RZExSv90FDfcSe42fPUZ9FM0cdEb90pFAr1Qwua7KYH7iT5XY1jvkgeo3cKrXBpmXQwsevba0JLGdUp9WUY/lR1cmCa58cv7R/C6MVO5nhz/3B3bHw6JDOkx6wHxnCl1imSBehs0Pjyqg9PhbejKqCWwVvZ/5iaeZ5gzSrwjaz9GYI10/x49tjunPVhRMzSYmQxQ+45dXE9FWnNvyeITRVFp+nGW505S8N1O5KEXgOwgbyIq0qLCfb3ZJYP5KzaIlWkhX2TO0uerf6K3c7a8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199018)(6486002)(186003)(9686003)(26005)(478600001)(6512007)(83380400001)(6666004)(316002)(54906003)(41300700001)(8676002)(38100700002)(82960400001)(6506007)(53546011)(110136005)(8936002)(4326008)(86362001)(5660300002)(66946007)(66556008)(66476007)(2906002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dvKUBUmRUjNVXQdGxU6nb7FeEkmR85qKi+aI+EwKOWGIf2oCXiyJKhv35Ku0?=
 =?us-ascii?Q?JZXR3oYLKvrmoU39R0mskou0ft/fGA6ItI8FlofZuxiNWMaBtVmNWxgZ+jFK?=
 =?us-ascii?Q?upunDX1A+7hecZ3vsxlCySEbRcBxioMp/Dh1EHleiRODBaVbXhNtRylzMzKO?=
 =?us-ascii?Q?RjCFX7M170TZCKXChhADGuFc5OhVM3vNDnGXxx7+aYz44cxY4GJivk42TC2V?=
 =?us-ascii?Q?gjfAQpTQSkIuEc9XdnrRh4mlh6P8RpkGXMwBJU0zGtC9Zdl/OGTgSYizhDX8?=
 =?us-ascii?Q?/NTOcvmMh9A0YIKCSAwBtZIUrDOewq+ZLcmFhfcUQgixp5vmcGipX+7SrzJi?=
 =?us-ascii?Q?fmpM/RjL5iST3/G372Lk2nH3rgljefvLxR9EprDHQIE4rb0LKD5LcdsaCnvW?=
 =?us-ascii?Q?KSnKCk9PNdIJWRCb8/N9ux4dj7m7KM2Nig6P2MeIzGYQEy+yfiPzPaPNJ00p?=
 =?us-ascii?Q?buobmGo9ceLYYoc8rnp4p91+s/aKAbk0jQ/Vo8zIyswi3wOh20EXBgqKzIWu?=
 =?us-ascii?Q?Vssa+R5LvWb7b9Ted6eSjFV4lAXsGUWV4twPqdCM11gHqwQIC7SJ6628moFq?=
 =?us-ascii?Q?Zd1f+7DcVaKIHDZDBo1gbEYpuMVHyLCSkMbJrQZmrKiFwoAkmGCHXEtCHFkG?=
 =?us-ascii?Q?h5/K5iBLD67Gf0Y3cWgck72OHMBrMgzIGSKSsY5a+O2lUmb6IqaDkWj5QsKL?=
 =?us-ascii?Q?e6NG8+W9Ku/LMyRIAiIc+xjn2ozjh4CuSACDuF4VFyf47d2sNJPpnGUtY89d?=
 =?us-ascii?Q?p50BKiUaQV/FzowTvVMSJsh5QKsZjBr2T70iG6oFrOz5QTUGflbXLnwNqyrB?=
 =?us-ascii?Q?75Rew9P8ojF53//lFTjQ/8EiYQlYXnizG6/9ojDgo5C1qxF924uNz8Xy7H8Q?=
 =?us-ascii?Q?uYHw/tdj8nn5jPz74pyt+FydKsuVe8ZINDwb1nMfOQ10hBhPXOhINKkgjrgB?=
 =?us-ascii?Q?vbkoHcMMocSPUAwXyE4j3NzPNqh/MX7eza0QRpxek4gyVhLhV3hNhlvSSrkK?=
 =?us-ascii?Q?5MJOTwMVu4rR6q5qgk+GzctCT6sxLStDV9mmkOd/GyfpN58v9rzYBuNZ2W7e?=
 =?us-ascii?Q?gj/xEQ1mtPfAFVd+ux/yJlIosODKZtuer3mVZ9Z7n58qtuZAZSBtw2VgfDyF?=
 =?us-ascii?Q?279bkiR5yjd6SmTFF6S/fCdwtBYsSrtO8gj9bjuTebHKh+dRISOORXKihjfu?=
 =?us-ascii?Q?KbNROd/pwk/Y0AoynF8MEm0iUcDqUDLYWmKGYfOa5Cgri4LsRqJTnVswbGvQ?=
 =?us-ascii?Q?fmDn/jzkqw+92DztrsZcBCf9XBdxJlR1EiAhqOu8Vcc5QsbOMW48/lxhGQ6f?=
 =?us-ascii?Q?/MbklHbyenVQBNmwlQOw714jMKoP2+9hyvN4GhjO/8Yf1JZyC5IKyXAcQyWA?=
 =?us-ascii?Q?0L6tDSYbJmM5YRXYSNDQQY0C3Pc2Ids8NOIQa2ulhfS0FCn5U5HwoOhcg/9V?=
 =?us-ascii?Q?jQQgFqhWF/HylvJ3wjVvsXVDkKhZjL/LWiaN7YhSjVQE+1jp7Ubq1SyYK2hj?=
 =?us-ascii?Q?Kn2iDMv+IfLTNm8KYMP9s+coyhOQEsAiqGEIhbs1naLhxGx5PM/z4KbfE6TL?=
 =?us-ascii?Q?hj0MoeUr5tj1BT3Ja45WgTquVMRM6h3f0wNGk9t651Nv2Gn9vXMnrwv0ZJgy?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a390df-cb90-4c91-b1ea-08db00c50d7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 00:17:34.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/geap49g8XejFiZne+0jtmofErWSO6WW82RXlFYdHkdvEsqLrSx4QHnvHIxEBs2huhSmQVbO20MqcfrltKRgoixnrfOh4/ZbBtSqemJgno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> Dan Williams wrote:
> > Jonathan Cameron wrote:
> > > > > >  /*
> > > > > > @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> > > > > >  
> > > > > > +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> > > > > > +{
> > > > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > > > +	struct cxl_mbox_set_timestamp_in pi;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Command is optional and functionality should not be affected if
> > > > > > +	 * the command is not available.
> > > > > > +	 */
> > > > > > +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> > > > > > +		return 0;
> > > 
> > > One side effect of dropping the userspace handling is we loose
> > > the presence in enabled_cmds (based on the CEL).  I've replaced
> > > this with specific handling of the Not Supported mailbox return code
> > > and suitable comments on why I'm not considering that an error.
> > > 
> > > Hopefully that compromise makes sense.
> > 
> > That does make sense.
> > 
> > That also has implications for the debug messages that will say that the "set
> > timestamp" opcode is unsupported.
> > 
> > What do you think of the following to try to clarify the distinction of
> > supported opcodes that are used internally by the driver and the ones
> > that are wrapped by a user command?
> > 
> > -- >8 --
> > From d36b9ce647e615be8241d7fbf86ce555c72cc2a4 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Fri, 27 Jan 2023 11:00:52 -0800
> > Subject: [PATCH] cxl/mbox: Indicate internal vs user enabled for command debug
> > 
> > At initial enumeration provide an indication of whether the kernel will
> > use an opcode internally, and / or make the functionality available via
> > user ioctl command.
> > 
> > Given that 'enum cxl_opcode' needs to be updated before the kernel can
> > use a CXL opcode internally, use that list to populate known_opcode().
> > 
> > For the QEMU CXL emulation this results in the following debug messages
> > at startup:
> > 
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x100 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x101 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x102 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x103 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x200 Enabled: 1 User: Get FW Info
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x300 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x301 Enabled: 0 User: none
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x400 Enabled: 1 User: Get Supported Logs
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x401 Enabled: 1 User: Get Log
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4000 Enabled: 1 User: Identify Command
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4100 Enabled: 1 User: Get Partition Information
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4102 Enabled: 1 User: Get Label Storage Area
> >  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4103 Enabled: 1 User: Set Label Storage Area
> 
> I think this is nice debug output.
> 
> This kind of threw me though.  It looks like all enabled commands have
> user commands.

Only because I ran it on my branch without 'Set Timestamp' or 'Get Event
Records'. I would also expect that since the Security Commands are
internal-only that cxl_test output would show those commands enabled,
but without an associated user command. Turns out that's a quirk of
cxl_test where it fails to publish the opcodes in the CEL, but still
attempts to call them nonetheless.

I think that needs fixing. I think cxl_walk_cel() needs to cache the
availablility of the event commands and if not present exit out of
cxl_event_config() without failing. As it stands those will fail the
driver load on any device that does not publish those optional commands.

> Would it be better to s/Enabled/Kernel.  Or perhaps driver?

Yeah, "Kernel" makes it clearer.

> Should we also check anything that is exclusive to the kernel and report
> that?

Exlcusivity can be ephemeral, like the label storage commands that are
ok through ioctl as long as nvdimm is not attached. The truly
kernel-internal exclusive commands will be "Kernel: 1 User: none".

> FWIW I've got a patch warming which updates the query command to factor in
> the kernel exclusive and hardware support, in case anyone is looking at
> this debug output as a way to determine that.

Cool.

> 
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 48 ++++++++++++++++++++++++++++++++++-------
> >  drivers/cxl/cxlmem.h    |  1 +
> >  2 files changed, 41 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index cae43cea00cd..45206465fd4d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -587,6 +587,40 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
> >  	return 0;
> >  }
> >  
> > +static bool known_opcode(u16 opcode)
> 
> Perhaps driver_known_opcode?

A bit on the nose, this is the driver.

> 
> > +{
> > +	switch (opcode) {
> > +	case CXL_MBOX_OP_GET_FW_INFO:
> > +	case CXL_MBOX_OP_ACTIVATE_FW:
> > +	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
> > +	case CXL_MBOX_OP_GET_LOG:
> > +	case CXL_MBOX_OP_IDENTIFY:
> > +	case CXL_MBOX_OP_GET_PARTITION_INFO:
> > +	case CXL_MBOX_OP_SET_PARTITION_INFO:
> > +	case CXL_MBOX_OP_GET_LSA:
> > +	case CXL_MBOX_OP_SET_LSA:
> > +	case CXL_MBOX_OP_GET_HEALTH_INFO:
> > +	case CXL_MBOX_OP_GET_ALERT_CONFIG:
> > +	case CXL_MBOX_OP_SET_ALERT_CONFIG:
> > +	case CXL_MBOX_OP_GET_SHUTDOWN_STATE:
> > +	case CXL_MBOX_OP_SET_SHUTDOWN_STATE:
> > +	case CXL_MBOX_OP_GET_POISON:
> > +	case CXL_MBOX_OP_INJECT_POISON:
> > +	case CXL_MBOX_OP_CLEAR_POISON:
> > +	case CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS:
> > +	case CXL_MBOX_OP_SCAN_MEDIA:
> > +	case CXL_MBOX_OP_GET_SCAN_MEDIA:
> > +	case CXL_MBOX_OP_GET_SECURITY_STATE:
> > +	case CXL_MBOX_OP_SET_PASSPHRASE:
> > +	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
> > +	case CXL_MBOX_OP_UNLOCK:
> > +	case CXL_MBOX_OP_FREEZE_SECURITY:
> > +	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> >  /**
> >   * cxl_walk_cel() - Walk through the Command Effects Log.
> >   * @cxlds: The device data for the operation
> > @@ -607,15 +641,13 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
> >  	for (i = 0; i < cel_entries; i++) {
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> >  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> > +		bool known = known_opcode(opcode);
> >  
> > -		if (!cmd) {
> > -			dev_dbg(cxlds->dev,
> > -				"Opcode 0x%04x unsupported by driver\n", opcode);
> > -			continue;
> > -		}
> > -
> > -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> > -		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
> > +		if (cmd)
> > +			set_bit(cmd->info.id, cxlds->enabled_cmds);
> > +		dev_dbg(cxlds->dev, "Opcode %#04x Enabled: %d User: %s\n",
> > +			opcode, !!known,
> > +			cmd ? cxl_command_names[cmd->info.id].name : "none");
> >  	}
> >  }
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ab138004f644..21f97d631823 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -299,6 +299,7 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
> >  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> > +	/* update known_opcode() when adding opcode support to this list */
> 
> I'm wishing there was a way to not have to do this.  All I can think of to
> make it easier would be to make 'driver_know_opcode()' static inline and
> in this header.  I'm sure some macro magic could be used too.  Although
> I'm not always a fan.

Yeah, a val_is_in_enum() helper seems like something someone would have
wrote...
