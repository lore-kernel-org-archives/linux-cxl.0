Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79229C54EAA
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjA0XuV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 18:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjA0XuU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 18:50:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB086636
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 15:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674863418; x=1706399418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QQe/PJVl/q1K9blXftbH2Epk0ODzW+nquPuOaxbkYFc=;
  b=XETGqMakKPWWyUC4z6bwNIFf9cndjM5/xObPyms8WrYnfJgo1mBper9s
   t9mTcGC+f1XgvMMbktoczqmDKAtK9XPaS4wPhBORxIEf4+zT7eTR7aRMH
   ZJ4dmwHCsmb23rbGTrh7R2uOFUwHMJduUefdd36QlepsRALAKU2o5PME1
   2u7R7Nq9ytOt6DjNGuhFwG122uEePhsxVfjGAFK3aOdmy5G+Bym1YpsJ7
   xpxHL0p20aabguzzWDElUZLLaqWusVEVZemLW0CuQBHfyFGUc2yfnnPX9
   njEBHJvAsrECHaOCKinRI9AEO9WDoQeOca7LNMJKKLZuCafcPap7HfRGY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327239480"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="327239480"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771742135"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="771742135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2023 15:50:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:50:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:50:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 15:50:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 15:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lybPq0ohEJex28nTNDDkOFgkur1jBjljEAqoybQHXb4K5kmjE9XO4eIVVWoEvEPHUCz5aevXyk6sLCm8E6vbbleKWqtMq57FcmqAal4YCIJVMXU8VQBKEIaFD994JfeCxnrwM7l7TUxemsis8M+lY8oYqmOVZkIP/UISHKzLVpBcc7K3w1UABpw4s/hg2p3r/BOb/uUT1fgQO4PVYHwYXeiRzs5Q+JnB2WmFblsr6MVRzMyIpPqeByo0Dckeb3Au33x1C8qiRVUry0Cx6PcFsCrcBqo/E7IQTemnVZhXHvIJaSYrCHaIhd2jS13MUoPT3ZWE5FOi7AcBZZdI+b6Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8KrbgqfjW4+oCCy1yxiZyg2sOWEtIS9rCcvY4+TSno=;
 b=bWo2NgMs7HHxVsCDUpluNnzNXAoRXRsuTdcCiN6JzcNDu0ByGzI+eo8oLE13oewU67Cv6H74LDuaVQz9P7EOnPBwb4Gym+apenGegbEfe5rgyNLFtoRDzSXNoUARl53IqXQap67chD0W5VOQNH0f6PuqnaXq2L74twh9nEgeyDwcgk4r+z8fVWB1/XjkFZ/sfx7S1g8KMK3eTc8arylaTLOmyCDAsLZK4YbknasvkgQakvbbYPPzXFwuZyOBljh1+qeid4wNBOLpuKRfwYTDj8fIZIhWvAVWeXNtjEVh/MVlbtwhbnJbkDgSfn8gR0GloycBpHg4n8NWPpX3Ck2dNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 23:50:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Fri, 27 Jan 2023
 23:50:13 +0000
Date:   Fri, 27 Jan 2023 15:50:10 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <63d463328d2ac_7f63c294e2@iweiny-mobl.notmuch>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
 <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
 <20230127100406.00006c65@Huawei.com>
 <20230127121013.00007966@huawei.com>
 <63d420d6dc5fa_3a36e5294cb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d420d6dc5fa_3a36e5294cb@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: f10b4de5-d3e2-4e9d-10f6-08db00c13bd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szS4p5aTlPmu/IwADhEEXcMPU0c2R+SwOyuHNavu0IZUgYiSy04b0NvN/KB7o+hceM9uwRnszhZyZXmE2Rq2OIPiYLH5MWxojQcSdFluYWQlKCC0bmx9xxKGFnFoM9D59/5iiRo34/Ww8gz9gueJgGQAvs8W4z/Fw4jZhQImxxOnzU0N6GruCpljktJeYAWuAIk/SseEhJiBMw+H2E5PfaYby0mH6HJSek/vt4bu90dunm+O6UF+1UsetqNO9rHMsUNhhHHkfGXZO7U1R/TL80K5Ym1eyO9IXYDaJtHkNiew9rlJQMvdLweuQQRAqwhaLsiVcRtLpQ0n9I2uNBxcRlldeHCS2oqMttCTVzo4ULH80+ZmXzpXW3LNjYazu9JLj1occwJXlIG83ZyPJ2TsKCg5gkXaK9knGLNCh6Ho1G5n6zj9jdjYOVnivTXPY3leiNdrLprjww12d2uCFpIIMtzJQgEE4ucDzK1OFhvpC9u9Ex+RzCVgVgG50jkJfcBHHWxDvrcuGbbQ16JPpnBREBw6heXbEuyi7sjzCHeyLFwhtxbkYBFLalIRO0Qv6xpZ8WC1uQ7gi+ftekTXji+Hn1Z0or3M0IBCDmLrkrRfPFpHYRkRj3S9MQcHb29t/2mpcG5YCBSKGZ9LYhVZUHp96C+BadvjZ1TJhUj1lsDX+1TkUxD5s0FfzqumtR1jnIbisolEtcUppLe78WUXSTwOqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(2906002)(38100700002)(44832011)(5660300002)(8936002)(41300700001)(86362001)(83380400001)(54906003)(110136005)(66946007)(8676002)(66556008)(66476007)(4326008)(82960400001)(6486002)(53546011)(26005)(186003)(316002)(6512007)(478600001)(6506007)(9686003)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmI9tsOLbXIpBREClVLDL8aMibe2ALWOaHfpch6VW93YVDD+Dp9FvOoyyQbA?=
 =?us-ascii?Q?e0YmoaUsTUym2Zd3AsryVI+UxkjKtjlsPrwlyaQg3MUdzrMpYedqyftK8Rtc?=
 =?us-ascii?Q?O57WLfWLZN6WUVB7UiavRt16exXfLeeuUSlDgkCT7CPaQRdXp4TH6NlpKTG9?=
 =?us-ascii?Q?skeOKAFQUiYDFBZgIdYm/GNac7Ntuva5WaFfipDxlFaWpFL7KX1AKDEMzrVH?=
 =?us-ascii?Q?J5PB1HtLK+OlRlc6omiMrniNQWreLnbYgoPi3oRoj/5XfUdVHoGNEdSoN246?=
 =?us-ascii?Q?WLmDwy3yj+fY6wfX+Aw5h0uLbpkvxb+yNpFTG7KkUrI8rLGiw3055iGpt9/7?=
 =?us-ascii?Q?W3YuhVI/Zjbj47DhslZ5Si/7cp2iDe/pF+31folUzH+fVjivPRmf/a35o3Rj?=
 =?us-ascii?Q?6pDARoAfcMFPm9uALhTdO04I8IUbG82NYUpGTeyWDZMG+TkjNWo6LVhT4ob1?=
 =?us-ascii?Q?dHMXQcoLyjb+8dhZDCarm8q6AVpk8fsK9PKjeG3VsHXauwID0K5Ix+2mcbKz?=
 =?us-ascii?Q?qnTAYm62YNvdohf79Fkgi+xohyoGYavSzVQSoLDHq8O75lMOqnzb1V9CRoiB?=
 =?us-ascii?Q?k7z6W/yeiBWOWbUbayRpqDIRDsi0I+aiwT/eIQLXkeywlHQFNexo2DcAGjqS?=
 =?us-ascii?Q?9Q5I+PQlOcg7dhimPN7+UU0cQpSfkM3ys97SrzFhwbtG3RMlpqlql+Ve0vcb?=
 =?us-ascii?Q?eR5yS7CEMFT/9HibRAqGTw+KTwpBmcPlFXnzD1ECeZIruzJ7swwkwiZTLvC0?=
 =?us-ascii?Q?ID4FoxPz4+15Di8O35nQquwsBMYw0L01r+pLVX6sNPNw2kRD7wg7jpq7oLz2?=
 =?us-ascii?Q?Nq0zPBt+dMv2hb+O2mXX0pwQIbarwMwTxeoiKsViPZCXrrOiESs8bgthEHor?=
 =?us-ascii?Q?bv6vs2BzvxcBD6kOS1WZBHbcb6jHwpUNTymU40XPwpEYPskuaWP5EFpoDUrI?=
 =?us-ascii?Q?9riSjrTs171/Bnn48wr7pjWzlgW1j4DYFNQ9CR9+/S4iNOKPk9NDEl7cEevg?=
 =?us-ascii?Q?qtqarAyrDUgGHndmsRVBpYAWT53/EoPxfzY1qmEoD8Q7iyNy6PI5tkKggpp4?=
 =?us-ascii?Q?U8baLPV78TF/2O/aXp54NyH7lFPThuAxG6KJqE5Hop2mghJ1mwLG+ECuBd2b?=
 =?us-ascii?Q?vGOzU1+uv1LhaCFwzdROo8arTD5aZFEZyAiQ+gsQxMXYjT9S9mxvIiYZf50K?=
 =?us-ascii?Q?HYtvYW/3R2joKlkSbYNX4YUjJ9onkgWuLpf6z+P2uFON7hPGjGCAGukRMNj3?=
 =?us-ascii?Q?3lDej/qMcGQXj1gu0qL6fEZelpePZ2NYOXMLAnOiVv85hCDYw4MPxtzkTl4k?=
 =?us-ascii?Q?4fFUfgmZpfDbd92ggMHi1qodnml+4Scu8GAKyQgLvuCKF+WufUFqqgv5u7gP?=
 =?us-ascii?Q?TG/xv9MTbKDWS0VWz26/MilfEQ7KLZHBhrJHM+1skDGVb22TEyzzIo3aY6RC?=
 =?us-ascii?Q?ZXmCNzEFDeRmn4NJceKe/sGmLEpm2tjhlHfNH8tkgc5cmkdY4mnjjJRzCVCZ?=
 =?us-ascii?Q?1VkgDV/ngfVT4YC6lFY7bzvReLfP1DhJbnKKfWpiUt2YN4SHfuJS96J7MwZO?=
 =?us-ascii?Q?55ZrmdHAXjR17mZg6wGDgHvYnk1kyWmDftn34HsT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f10b4de5-d3e2-4e9d-10f6-08db00c13bd2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 23:50:13.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/j9lkgXpfSoCYOmsJ6PxWtUVB+SXvEa34vSNhQRvSRx2K1Hae4V7TtpcnP+GFoxSsQtdyw3xe9V9OmmPNfanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Jonathan Cameron wrote:
> > > > >  /*
> > > > > @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> > > > >  }
> > > > >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> > > > >  
> > > > > +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> > > > > +{
> > > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > > +	struct cxl_mbox_set_timestamp_in pi;
> > > > > +
> > > > > +	/*
> > > > > +	 * Command is optional and functionality should not be affected if
> > > > > +	 * the command is not available.
> > > > > +	 */
> > > > > +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> > > > > +		return 0;
> > 
> > One side effect of dropping the userspace handling is we loose
> > the presence in enabled_cmds (based on the CEL).  I've replaced
> > this with specific handling of the Not Supported mailbox return code
> > and suitable comments on why I'm not considering that an error.
> > 
> > Hopefully that compromise makes sense.
> 
> That does make sense.
> 
> That also has implications for the debug messages that will say that the "set
> timestamp" opcode is unsupported.
> 
> What do you think of the following to try to clarify the distinction of
> supported opcodes that are used internally by the driver and the ones
> that are wrapped by a user command?
> 
> -- >8 --
> From d36b9ce647e615be8241d7fbf86ce555c72cc2a4 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Fri, 27 Jan 2023 11:00:52 -0800
> Subject: [PATCH] cxl/mbox: Indicate internal vs user enabled for command debug
> 
> At initial enumeration provide an indication of whether the kernel will
> use an opcode internally, and / or make the functionality available via
> user ioctl command.
> 
> Given that 'enum cxl_opcode' needs to be updated before the kernel can
> use a CXL opcode internally, use that list to populate known_opcode().
> 
> For the QEMU CXL emulation this results in the following debug messages
> at startup:
> 
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x100 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x101 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x102 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x103 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x200 Enabled: 1 User: Get FW Info
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x300 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x301 Enabled: 0 User: none
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x400 Enabled: 1 User: Get Supported Logs
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x401 Enabled: 1 User: Get Log
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4000 Enabled: 1 User: Identify Command
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4100 Enabled: 1 User: Get Partition Information
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4102 Enabled: 1 User: Get Label Storage Area
>  cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4103 Enabled: 1 User: Set Label Storage Area

I think this is nice debug output.

This kind of threw me though.  It looks like all enabled commands have
user commands.

Would it be better to s/Enabled/Kernel.  Or perhaps driver?

Should we also check anything that is exclusive to the kernel and report
that?

FWIW I've got a patch warming which updates the query command to factor in
the kernel exclusive and hardware support, in case anyone is looking at
this debug output as a way to determine that.

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 48 ++++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxlmem.h    |  1 +
>  2 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index cae43cea00cd..45206465fd4d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -587,6 +587,40 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  	return 0;
>  }
>  
> +static bool known_opcode(u16 opcode)

Perhaps driver_known_opcode?

> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_FW_INFO:
> +	case CXL_MBOX_OP_ACTIVATE_FW:
> +	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
> +	case CXL_MBOX_OP_GET_LOG:
> +	case CXL_MBOX_OP_IDENTIFY:
> +	case CXL_MBOX_OP_GET_PARTITION_INFO:
> +	case CXL_MBOX_OP_SET_PARTITION_INFO:
> +	case CXL_MBOX_OP_GET_LSA:
> +	case CXL_MBOX_OP_SET_LSA:
> +	case CXL_MBOX_OP_GET_HEALTH_INFO:
> +	case CXL_MBOX_OP_GET_ALERT_CONFIG:
> +	case CXL_MBOX_OP_SET_ALERT_CONFIG:
> +	case CXL_MBOX_OP_GET_SHUTDOWN_STATE:
> +	case CXL_MBOX_OP_SET_SHUTDOWN_STATE:
> +	case CXL_MBOX_OP_GET_POISON:
> +	case CXL_MBOX_OP_INJECT_POISON:
> +	case CXL_MBOX_OP_CLEAR_POISON:
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS:
> +	case CXL_MBOX_OP_SCAN_MEDIA:
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA:
> +	case CXL_MBOX_OP_GET_SECURITY_STATE:
> +	case CXL_MBOX_OP_SET_PASSPHRASE:
> +	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
> +	case CXL_MBOX_OP_UNLOCK:
> +	case CXL_MBOX_OP_FREEZE_SECURITY:
> +	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
> +		return true;
> +	}
> +	return false;
> +}
> +
>  /**
>   * cxl_walk_cel() - Walk through the Command Effects Log.
>   * @cxlds: The device data for the operation
> @@ -607,15 +641,13 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  	for (i = 0; i < cel_entries; i++) {
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> +		bool known = known_opcode(opcode);
>  
> -		if (!cmd) {
> -			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> -			continue;
> -		}
> -
> -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> -		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
> +		if (cmd)
> +			set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode %#04x Enabled: %d User: %s\n",
> +			opcode, !!known,
> +			cmd ? cxl_command_names[cmd->info.id].name : "none");
>  	}
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..21f97d631823 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -299,6 +299,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
>  	CXL_MBOX_OP_MAX			= 0x10000
> +	/* update known_opcode() when adding opcode support to this list */

I'm wishing there was a way to not have to do this.  All I can think of to
make it easier would be to make 'driver_know_opcode()' static inline and
in this header.  I'm sure some macro magic could be used too.  Although
I'm not always a fan.

Ira
