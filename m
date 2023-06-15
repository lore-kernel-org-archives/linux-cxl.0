Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF07EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 22:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjFOWrM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 18:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjFOWrL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 18:47:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783D2D40
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686869222; x=1718405222;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZWZvmAsF+2LZU4qaiuO7jE4YIQNGHQSDREXf0EO5F0s=;
  b=ktxNSIAJ/PqhvKE3HiXDp+G8qIPSIbDSmSH6bHp6ZbWGOQHqHae3vO8u
   LPTp+o3BaYVexqT1kN9Kl9NRdLRLh2FHsVCpN98YQ8lcTlxu9EqQNSMSs
   X3O3iSX4Mm9vEp+RE6r5SWBMXp22hmd4WeMiZFY7WjV11MXzgx85038RY
   THKXroTOdEAOqMsr8x+k0//Wk9j1OJL7YIZeqFp/uDLwisjXmJ+NpOONu
   LmIE8AGcj3ULDwWvh7L0IMPKmyp1fb0NvVmBvS3V409qCjPcQawZEdCwH
   xMNjS/UDLNSze7LSFVlsQrJhsxbEqTL2rQku7P6ZXbWtJAmqcrb04tuq0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361576830"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361576830"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="662945633"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="662945633"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 15:47:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:47:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:47:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILauff2VDUadyCjiRxHbUZFuEVFo824+S85yOj0cx34ps6oLtSBzXKxKtWfg2UAG2UTwzaMQPezJiK0e66hbUtNXv6uxqdlGKDAJUajDL3n5mlqAi/5M9CnO/9mkSsXxK7idLQuxJJssgmEtE31FoXOZbjo1N0MeUln3/XndzxnzQdIKWe92aVGKk+SCJBQCGDZfHG18OZfkNE1EsYNTrvo1uPatHReei4ckKJ1dGpcZFn1r2bJoPiIinrlARhEz7zTIgGnAIbOBSqGu3D8XEZ5BsyOoCQLibuy6ZOx64Ask9VVQrCqJehZt/VNR9pdSMksRtWq4MUX+N3tu/Saj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1vkOEG8zmXDakZvU7I8uZSMYxeNwc5YZZjvZJEJfN4=;
 b=Ye8NKcoHLk3yxGbMTAbyUhoc+CA6iN4rr4GjE/gCKutzx9WTUkWJ1EEJKlTYh7yxotNz4o7GIufiSQ0wsZxhCP8aRPy7G8YNJTUSyO8tKcP66hE4xU6WxSKOkL7XdCxmIJi8vvbNfJW/BmBi0nndsYdfpEf8QprXfDY/+d9w3bYVbTtz/zeiOTzl+FDaUy7VfC7l4H2PiHALn0sDZtjfsLMuvdzsLzViRTKA6OlYtLYFhiFn4dxE4f6d2FZrXXupIdhFPhyTMTa8mTvj6noooTEnJ88CFaa6HR7mIJ2PxFqqUvqT6hNyD2488/8mthgkeSJYKBFpF9oPZigGgs6qlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 15 Jun
 2023 22:46:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 22:46:58 +0000
Date:   Thu, 15 Jun 2023 15:46:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <648b94db15005_1c7ab4294c@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
 <ZIpSJ0o4b+sCkZND@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIpSJ0o4b+sCkZND@aschofie-mobl2>
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f55489-f5b7-4ec3-611d-08db6df26cdf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TE850flX7glw/HzK65O2jfweP0eK/mCLZwuiJW0YxEJvR1F7arXrAagknJSIZ3NcwJvA9RaOvrvPVvOlrMMTn9PpXSXdEwOwlMKSv5WD0/ICyt1AjwY3iF7t1yzaQvBBito5at2iGX2/KHBrAtQ7XSQ2EGW0Odfr46ZOD19/y+rx/MgZfJh49/HWDiP/K8xkPtqg1rNtZXSO7YTEHOs288nIylv0hZyXHU4+65RyXd9/eEsWxpUGZ/Sz7m76eBoJSAoM7TDFlqpdUTPdnkUdXSQQqxBOVmIVHUJDA79BbWAp9I9wu6EgSfgHyis7/0orpeyboYNVJdjCUuce14cQ/Wq/XljDBMQXX06l9X/5hRho/xIVrRz89/0ZUs3U+cXTEMY5Fox6Von2SMSaxIaTeqBSxftexES1czPIa+MbdiR8fCYsuiekX7LYSUwiopJBkDGn0a9jujsgmxDC0/cYC7rwCmAgmj8CLr/MEP6W+/IgXsVNC89v3984fm3s8hCh650dv5IB3IzSfH/FQlbRfnbf4qmGDHpkM30nskKxzxiZe1tz2dYEu93lF1+Is99v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(186003)(6486002)(478600001)(6666004)(6512007)(9686003)(6506007)(83380400001)(54906003)(82960400001)(41300700001)(316002)(5660300002)(38100700002)(8936002)(8676002)(66556008)(4326008)(66946007)(2906002)(44832011)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+Oeq8wD2ns3wCe6bOA/hBkJiKwUKn1QuoGPsn5cUFqcOf2W0LzVves46gN1?=
 =?us-ascii?Q?+pWOfAEQP0bfrvJSWIepfMpdRkC606oyCEkGtQJPHnl/RewT1eoxNLNjnVyB?=
 =?us-ascii?Q?V0kKoeOWa1XgLfgc/7DNx7RqJi5MluKHxhsZB9LXDNsbPtxcCc6V4sU5peOd?=
 =?us-ascii?Q?BTAHUcC2e+kIItghiRqiR5YvjTBP0oWtvpjUFIR7jHtN6cFFTYut7AqejeZW?=
 =?us-ascii?Q?Yv0PRajslBJnHgYBK5luhH9bUbvtrcsDpvlJ2sjizpjOSdYW6jNsvo7rUtEA?=
 =?us-ascii?Q?ixB/he7xLCKltG0jnr6PWNtm6agM5LvRYBJ8jENTvkKeySZNFHqY5FBK779b?=
 =?us-ascii?Q?TTg6jc2mlLX4WV9+Vr9mpAMhT/wDa0vaDznauEUBH4ZJbfUTosh7QpBLR5/L?=
 =?us-ascii?Q?HfJoELcVWehtozCD5sNWzemNoZYo2n6TKv5jSCoX9eEkKbHHuCR24nBWZGb7?=
 =?us-ascii?Q?m54FGL2aJfFAziOA+N1ICy0yrgU9h0B2Xsg4PyjxETVQ1bnADJRvcsEvXifV?=
 =?us-ascii?Q?IpyTln4JhB0TPy2gs22wppRfJNCnQvdVAOstosF1yVDCtb4q0ndWNZ2N1j+0?=
 =?us-ascii?Q?w7Ue+8p+8YFs/o0Nb6RJouW+MzLAcb903wHO0npcRIUjka4u7YmqBTyvsrNE?=
 =?us-ascii?Q?1WXgH3HMy+sJqE4/AAQWQiIfoLmGvzLWBDLQt0zgi5GrXV+EH41NDJLiY37X?=
 =?us-ascii?Q?Ngply/JtV/Pg+PoxFu5B8c0XWza9xztzRpAvGo6aZ2mGHDKuWD4euR1dOoy0?=
 =?us-ascii?Q?kzlV8uhFbELucB9iupa/LmqC1V9PbCEnrss/NhgQOd5epH7/mvEPfAOYvvND?=
 =?us-ascii?Q?GfoDsxHK/2GhR1tGCWmx9kFDR78tVpfioIv+cqbEZi/O2iekXCM8jNuL6UCz?=
 =?us-ascii?Q?yBLR5j4d6VNrP0sJlCoLYFpcMVXmWmxuQjBf/Ta/ql610h3UNlcTvN4Wew3G?=
 =?us-ascii?Q?lZuaU9d46wS9nuBcyXpouFuhu7u0DR6Nt1WXZNSYFxdScgwWbK2miaVG/y4Z?=
 =?us-ascii?Q?XIRC9knxgvJ4BC8KjBfXVNm4VMQPixNeec4AwEG6hvtmH03RRihGnNN2A9pv?=
 =?us-ascii?Q?ZBHHA8cJxBYIKSAdqVRQqLNyid6UJeJNIA+doir6m1cq8DAuMNRRymj8ziO5?=
 =?us-ascii?Q?zKHdy0J13ZY6fp8SBuQHeY/hJRHex9x7I7XYs88GxeRlmn2d8c8JwZb9ZkOf?=
 =?us-ascii?Q?notaIIL2DQWTKi6SfSqwEAcI8AEO6MVvsDic9y7OwDGPmlCjnCSn23elbV8o?=
 =?us-ascii?Q?lWsfMFnkrDAxKFbHVxd0OYR+6uiTBPD/MgvNUbvnJVUgSl3X74I8MNh3Rqz8?=
 =?us-ascii?Q?qNrHUx7Z7PjdtfU4iSHTh67hIf2qfdag956gDl4yYT/9cRef9Sp3Va5aef18?=
 =?us-ascii?Q?TMK/PMbMml54fCaSGqkxJpphBKiJdkpj/+XMNfbtuaWU0QUAUDXUjFU7cLZZ?=
 =?us-ascii?Q?6fXqc56iKIIaohrmiUNJnn/uYf2uQ9vVQhfd+ksW1FFnQg9aHdZRzzDuCGI4?=
 =?us-ascii?Q?Xo5V8zdMZvs0wTGJ8E4OWbZQBvZs2WehtJc7q1r2NU7Ej7gf1O4ZuG5WFIgw?=
 =?us-ascii?Q?T/Vaml6oOhBVBVubwjygRWrp0YKx2evUWV2FsiRCoRLihlmyLgMwioRrErfj?=
 =?us-ascii?Q?Rs5y0AeBDbnhcp8YyjfnYghW+5/FaQOXFXJZCxgM0VvL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f55489-f5b7-4ec3-611d-08db6df26cdf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:46:58.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRAMRT4AqYzLci9o8au9WvTnSqsALaBOOgwAfkDSAHWLjsENC5vkkOF2Yh+HRmUF1r1ieDJzvYUTLeTaJOB9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:28PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Read the Dynamic capacity configuration and store dynamic capacity region
> > information in the device state which driver will use to map into the HDM
> > ranges.
> > 
> > Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> > command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> > ---
> > [iweiny: ensure all mds->dc_region's are named]
> > ---

[snip]

> > @@ -666,6 +697,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
> >  static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  {
> >  	struct cxl_cel_entry *cel_entry;
> > +	struct cxl_mem_command *cmd;
> >  	const int cel_entries = size / sizeof(*cel_entry);
> >  	struct device *dev = mds->cxlds.dev;
> >  	int i;
> > @@ -674,11 +706,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  
> >  	for (i = 0; i < cel_entries; i++) {
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> > -		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> > +		cmd = cxl_mem_find_command(opcode);
> 
> Is the move of the 'cmd' define related to this patch?
> Checkpatch warns on it: WARNING: Missing a blank line after declarations

That seems unneeded.  Perhaps left over from a previous version.  I've
moved it back.

> 
> >  
> > -		if (!cmd && !cxl_is_poison_command(opcode)) {
> > -			dev_dbg(dev,
> > -				"Opcode 0x%04x unsupported by driver\n", opcode);
> > +		if (!cmd && !cxl_is_poison_command(opcode) &&
> > +		    !cxl_is_dcd_command(opcode)) {
> > +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> > +				opcode);
> >  			continue;
> >  		}
> >  

[snip]

> > +
> > +	/*
> > +	 * Calculate entire DPA range of all configured regions which will be mapped by
> > +	 * one or more HDM decoders
> > +	 */
> 
> Comment is needlessly going >80 chars.

My checkpatch script is set to 100 lines due to the recent change.  But
this line length is unneeded here.  Thanks for noticing.

Fixed.

> 
> 
> > +	mds->total_dynamic_capacity =
> > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > +		mds->dc_region[0].base;
> > +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> > +		mds->total_dynamic_capacity);
> > +
> > +dc_error:
> > +	kvfree(dc);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > +
> >  static int add_dpa_res(struct device *dev, struct resource *parent,
> >  		       struct resource *res, resource_size_t start,
> >  		       resource_size_t size, const char *type)
> > @@ -1112,6 +1275,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> >  	struct device *dev = cxlds->dev;
> >  	int rc;
> > +	size_t untenanted_mem =
> > +		mds->dc_region[0].base - mds->total_static_capacity;
> 
> Perhaps:
> 	size_t untenanted_mem;  (and put that in reverse x-tree order)
> 
> 	untenanted_mem = mds->dc_region[0].base - mds->total_static_capacity;

That looks good, fixed.

> 
> > +
> > +	mds->total_capacity = mds->total_static_capacity +
> > +			untenanted_mem + mds->total_dynamic_capacity;
> >  
> 
> Also, looking at this first patch with the long names, wondering if
> there is an opportunity to (re-)define these fields in fewers chars.
> Do we have to describe with 'total'? Is there a partial?
> 
> I guess I'll get to the defines further down...
> 
> 

[snip]

> > @@ -334,9 +349,12 @@ struct cxl_dev_state {
> >   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> >   * @firmware_version: Firmware version for the memory device.
> > + * @dcd_cmds: List of DCD commands implemented by memory device
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> > - * @total_bytes: sum of all possible capacities
> > + * @total_capacity: Sum of static and dynamic capacities
> > + * @total_static_capacity: Sum of RAM and PMEM capacities
> > + * @total_dynamic_capacity: Complete DPA range occupied by DC regions
> >   * @volatile_only_bytes: hard volatile capacity
> >   * @persistent_only_bytes: hard persistent capacity
> >   * @partition_align_bytes: alignment size for partition-able capacity
> > @@ -344,6 +362,10 @@ struct cxl_dev_state {
> >   * @active_persistent_bytes: sum of hard + soft persistent
> >   * @next_volatile_bytes: volatile capacity change pending device reset
> >   * @next_persistent_bytes: persistent capacity change pending device reset
> > + * @nr_dc_region: number of DC regions implemented in the memory device
> > + * @dc_region: array containing info about the DC regions
> > + * @dc_event_log_size: The number of events the device can store in the
> > + * Dynamic Capacity Event Log before it overflows
> >   * @event: event log driver state
> >   * @poison: poison driver state info
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > @@ -357,9 +379,13 @@ struct cxl_memdev_state {
> >  	size_t lsa_size;
> >  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >  	char firmware_version[0x10];
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > -	u64 total_bytes;
> > +
> > +	u64 total_capacity;
> > +	u64 total_static_capacity;
> > +	u64 total_dynamic_capacity;
> 
> maybe cap, static_cap, dynamic_cap

Since these are new it is probably better to use shorter names.  Also we
have good kdocs for each above.

> 
> (because I think I had a hand in defining the long names that
> follow and deeply regret it ;))

Well no one made a comment to correct them.  So remember:  "There is no
crying in CXL!"

[snip]

> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_dynamic_capacity {
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> >  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> 
> This ^ goes with the cxl_mbox_set_partition_info above.
> Please don't split.

Oh yea that is bad.  Fixed.

Thanks for looking,
Ira
