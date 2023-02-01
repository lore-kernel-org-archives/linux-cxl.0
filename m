Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC88C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBAR5Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBAR5Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 12:57:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618A7D9AB
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675274243; x=1706810243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g0b5pWwyhzFnY8R7q25Kblq3gBO9ZDiQa1ICXUhx/Gk=;
  b=VBvyJMn/DS9F2MTNgXfEuASfNsj/39fUaiZrW8+xTNCGuLRddrvMAkEk
   71PkKfzeMyNUBMpmaLO/MR77aZE/29GSQvjxeOcn7HYq8BpP++S/r8J2a
   3KskAN3ENGRaXsMljRTBD7CC7KsggD34AV+4cItkv0I6kC9Yy6M1NCU7M
   CpHH606eVcaJ0GNtKYp2uqfr5V3aELYg+3xT531jsrW46eO6H8y1xploH
   BI27GxAIpOd5GS8h/WuvVMo4XtFZxCiRiLJhB5UhDeOvddeC+ZnICEgpa
   fQmnFzvLR0pLY9XRsUyARr7AyQro3qyBlj8IBBUEHHIGt21N73tyFcY4d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="311863624"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="311863624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="642525163"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="642525163"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2023 09:57:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 09:57:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 09:57:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 09:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkd523MNTKBEYF/UB/7LMkOqwjarOEPsTBk6vzn26wNjggIwVfUnLl/YgGYKWAhTeam/FaYqg+Udo2Oq+yxsZk128VkOjJQSpMDaSeHwai4mLv2lmoIrSUlhsd+Hy+YFFM5m5/4Xib9HCE5JAUOmg7KmUEdt0aojS/374FZ0f0ioNiSVz54dqOD0LWWJUrHKb89EsfO5RLoJtEtk82Lg6kKmML24PAAvOZPj6rXz9Qr04k0u9nQV0flamYeRNQHrRSgSfB045kZvbKgv6BPFMj1e7YdvbnQDKHcVQBlmwzbY3fydrlyGVE/kZQOY9TftpvmzZJO5EbJooSPrfPqjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqD/J4ZqLsAqqxNF5gUtInxe56PyF2NEGvz2YYT1/mE=;
 b=kqJvVrvktZbM/ClMVLuXbP3FtjwnaeZLg5RwjhqSRV5F/wWdpk4XdjePQA81Ju8FVpltiAYa9eIt3YtgbLMMxAIqsRmcuSG2sZwt7UhQLEyHaXsieQZjcPRGUc8BPGx3QVy1jt5ue5yptp3hLYRX0dJ4IbVzwFETQgQDPpY/z4NOGgyxClAI41/ff2jTFYl6mAzxRIaYDc+N9pm/GReNA9gTX64MRqXFVNZYO2PNxPgtHBPQ8gZ23S6dc/1B+ktDQOwgnd5XsxYsMHpzBXlwz+sVXZypXP3aoJHWzhwH44qnah+DBMBDRhsZNs3cvniHnEZcYcWiNV2a9YoSSup7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 17:57:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 17:57:18 +0000
Date:   Wed, 1 Feb 2023 09:57:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63daa7fa7f9dd_b941e294a7@iweiny-mobl.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
 <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
 <63d843729334b_a2cd4294c2@iweiny-mobl.notmuch>
 <63d85857b1648_8e2c29465@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d85857b1648_8e2c29465@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0cd464-9339-4491-f2a7-08db047dc258
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFk8pG00ict65nkDz5d1EYtOltQd3eJCWO/V0w5ltZ4cB5fscTnJCfkqW5JSBYs/O2+imz6dUz+BDCasGhA2SrIaxD96ireEJK/mWSArZ3dRU+3+vm4aI6ksmLfjVWd2KQCFzSjYLnqU2aA5hAYh7NqGlULfmcZvuyDPDzkeJibA7zZoL3IpZEdaZVdv8a1BZAdegAJU1RKOFJL8Gx7OlVUfyPbn2d+/+8CUnSvkk8sD4IfxSPxxHc6OkxgaH5D+18PxFh4wZS8Psz34vrqC2TAejr/v2Tq6LD4azjND1u7jYb6o02UAAh3/TCEN6X3WniSEysOBvIHZrqFkwb41gWlZ8SqZH1OEzhOKICRVbbJ+iVZTfB89D9uVWARRQeB9cYGq9e3OrlGq/FsqbEak2zfIPS1OvSwdRkCKSB4mDdz9omLrixj/ynwJhsQgQwQAt0kYjdTfEe17aZhbjBVcLa7+nn2U2gI6PRRQ/Vwh08dG3q2d+bhHrVvdIQTWxdQoBrRJf2rn3V61pe+hU/gXZFvUZlxqooPr8uIlzEIoTD+0bOFFw04tvu+WPsInQyD2kalcU4kIYIEep8eO3sj1Xqqj9teGM6veYqRcHFGb4VQAhebWEMMnoIq5T7/dqcIDfUolUxjwgMjN5TjCdjGOLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(44832011)(107886003)(6666004)(5660300002)(9686003)(2906002)(8936002)(6506007)(6486002)(478600001)(186003)(26005)(6512007)(41300700001)(110136005)(38100700002)(82960400001)(54906003)(86362001)(316002)(83380400001)(4326008)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLkvyda4H9g8vQizGFT5HsoQ3IOlaMjFGOxSo9wsGaxmvmkeFaCiBr2eNvPn?=
 =?us-ascii?Q?cgGCtB3QsOF55FYk/BeY2z2laduwm0WWfkZ7JQuSxSLt0WHpqTCXUlCdVv1L?=
 =?us-ascii?Q?ozA7g3rJw6aw3py98TpAGQxISlEK6duN1DD/u/fipp5yeZZgEDNNHR3DjbqN?=
 =?us-ascii?Q?v0+USHIhSUMxCgEkb1ReN2W0fnpKxpF8foIBJ5D3+VMxcwqV+8xzC+sU1Eba?=
 =?us-ascii?Q?NMa+6cA3lFRa2wBHh6kAuBg6xdHJa+1bYnD29/KlBWpka+iT3H/MGSDbghVN?=
 =?us-ascii?Q?Y2Ve9zsR9XWXTLuMzufIcDAIBQp7087AhaOuV/yqsLEkb3v8bYYLimPgg0KL?=
 =?us-ascii?Q?B1STdQk2Kx3A0ARv5W5ubnSwxxVAz9VaTyyWPdwleag6NbEu019Nb23i6mMR?=
 =?us-ascii?Q?gn2JYi6JKeyPj8bb16F0iHPgn5Bsoi3vhgjzXj8BlyDDW0qlYUc1hNvpXD1+?=
 =?us-ascii?Q?jMQAqJjEV29WX+V56ih1EJypohW1ZnQxU/Oj+mWTYjWNg24yaudZXJFqQlxL?=
 =?us-ascii?Q?QKX//gOfG64bZQTKGsHYe6eQJk6c6ceO+x1PaLJVcAjwTaL4XaA1uUIhyXRU?=
 =?us-ascii?Q?ug99aQZsRCLN2ugRqbFSOyfQu+BovJPxg76ef2wRPiZ3W80TYCk/BpZEslKh?=
 =?us-ascii?Q?SWsTEWPB6smn6lKmidbEfF4JgyV2PDQtKe91mkxXv1/brlbGdy1EuDb7GJAH?=
 =?us-ascii?Q?Q3dxQvksRt9ngKlGr+W32aDZPRJUbvSrqMLkSdpEhNreX/zvwWcRo8aA9rk7?=
 =?us-ascii?Q?fZReRqisEd/RJR2P715/otAyQoz+/3jOWn9UeAXXerJp0GCaXupgX3/eBDAW?=
 =?us-ascii?Q?49Te0JfR2Tb1gQ6dM9us6eoHPvdM/SnFJ7a6wGNUciAT6j15xPyi7fh1U58v?=
 =?us-ascii?Q?Qg7DHeJfVh3553hIPykC6G7dpzkNotvJgyJvvqThBLQgpnh5nsNiBnHvFPmv?=
 =?us-ascii?Q?ty2DNq14b4hN99pV/5cA4DruV/hIFVowg0grrqTuoCgL6oKoKU6yrRpg5Fhi?=
 =?us-ascii?Q?KFIB+lpEPjuhMmAd1LxRVYHS8yhC86S8X1nNEJwKdYXdKTl4PQD5fxQz0Z6a?=
 =?us-ascii?Q?tTe8Zg5wslep1CqffZl1amEzXzHYsVwUsRCrNYxdxZXxXhSHgEcg+kuv4HI1?=
 =?us-ascii?Q?EF8pqJ8jlpQNF4D0ZkmKrLTvjbiWcY8BeddsYxRhXDWR9eu8nspkVsMklgcc?=
 =?us-ascii?Q?Ix9wXJxmIjt6hLIkpmFwVO46U+VRtzEZyeHtOFhBH0l3KS8OsnQmH+7xx/uw?=
 =?us-ascii?Q?TWUy9mKD7ik6DbLzfctUO3rtn5ASCm+7vrgwZFzWaTNlQf8lnpBCxm1nF7pp?=
 =?us-ascii?Q?p7sSHDF3qwN5xVNlZM+rLptV56n62FOf2wCb+GcJg37ayheVpenm2GgrLR7X?=
 =?us-ascii?Q?qDRCOuDlZeWg3+lO/ogaCg0v7wczS1C9E8PljpdNXkZu2hdsG6BmlWlRAT9D?=
 =?us-ascii?Q?Cko3nD7p15bs4wjihySolRwivOPj8E75TVKiRtHGKxVixdvQBeP54Gjy7dWG?=
 =?us-ascii?Q?j5+kn/VLWq2OX80rlN/9JIY5uGGsF5mibjofsBRQbMeNm/LffdqniOOoSnH8?=
 =?us-ascii?Q?CNmen+C8AWma6SqpALyn8+Ja3JBaUaC0X0pm9sO7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0cd464-9339-4491-f2a7-08db047dc258
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:57:18.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDNCLM7YGfyNLdj4MJzD3veSE9qedxj3qsyC6DY7Y3wv4VRlz7+cyoFT+ndH+RFYIyTQ8x78WZFmEgZG4r1WtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5461
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Ira Weiny wrote:

[snip]

> > > > +
> > > >  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > > >  			  const struct cxl_send_command *send_cmd,
> > > >  			  struct cxl_dev_state *cxlds)
> > > >  {
> > > >  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
> > > >  	const struct cxl_command_info *info = &c->info;
> > > > +	int rc;
> > > >  
> > > >  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> > > >  		return -EINVAL;
> > > > @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > > >  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> > > >  		return -EINVAL;
> > > >  
> > > > -	/* Check that the command is enabled for hardware */
> > > > -	if (!test_bit(info->id, cxlds->enabled_cmds))
> > > > -		return -ENOTTY;
> > > > -
> > > > -	/* Check that the command is not claimed for exclusive kernel use */
> > > > -	if (test_bit(info->id, cxlds->exclusive_cmds))
> > > > -		return -EBUSY;
> > > > +	rc = cxl_cmd_id_user(info->id, cxlds);
> > > > +	if (rc)
> > > > +		return rc;
> > > >  
> > > >  	/* Check the input buffer is the expected size */
> > > >  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> > > > @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > > >  	 */
> > > >  	cxl_for_each_cmd(cmd) {
> > > >  		const struct cxl_command_info *info = &cmd->info;
> > > > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > > +		int rc;
> > > >  
> > > > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > > > -			return -EFAULT;
> > > > +		rc = cxl_cmd_id_user(info->id, cxlds);
> > > > +		if (!rc) {
> > > > +			if (copy_to_user(&q->commands[j++], info,
> > > > +					 sizeof(*info)))
> > > > +				return -EFAULT;
> > > > +		}
> > > 
> > > I like where this is going, but I think it is still useful to return all
> > > the commands even if they are not enabled or currently exclusive,
> > > especially since that expectation has already shipped.
> > 
> > I recognize that there may be an expectation of functionality but
> > userspace can't _do_ anything with the disabled/exclusive commands.  So
> > why not actually fix cxl_query_cmd()?  Effectively keeping the current
> > behavior will neither fix nor break existing user space.  But more
> > importantly the patch I've proposed makes existing user space more
> > efficient without breaking it either.
> > 
> > This is because returning these command only allows libcxl to issue those
> > commands which then fail.
> > 
> > The way I see it, there is no value in returning those commands at all.
> > Unless we want to have user space provide additional debugging for the
> > reason for the commands failing.
> 
> There is value, similar to the motivation to print the status of enabled
> commands. It is useful to know what functionality is limited by the
> kernel and what functionality is limited by the device.

Ok.  Do you think we should then update libcxl to use these flags?  Or are
you ok with the try and fail behavior now?

[snip]

> 
> > 
> > >  
> > > -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > > +               /* reflect exclusive and enabled */
> > > +               if (test_bit(info.id, cxlds->enabled_cmds))
> > > +                       info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> > > +               if (test_bit(info.id, cxlds->exclusive_cmds))
> > > +                       info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
> > 
> > Ok Just to make sure I'm following you.  This is then expecting user space
> > to check these flags to know if this command is available or not?
> 
> No, there is no expectation that userspace check these, especially since
> they were not mandated before, but they are optional useful information
> for future debug.

Ok this is obviously easy to incorporate.

> 
> > This means additional user space changes to use these.  Which is ok.  But
> > what is the value?  Current user space will still be broken and future
> > user space will be more complicated.
> 
> Value is as above, more user visible debug information which will be
> important as different levels of enabling make it out to different
> backport kernels.
> 
> > Right now libcxl issues a query before each command to ensure the command
> > is available.  These flags can't be cached.
> > 
> > The patch as I have proposed simply short circuits the already failing
> > path in libcxl with minimal changes.
> > 
> > Do we have a use case for user space to report the current disabled and
> > exclusive commands?
> 
> Nothing beyond future debug flexibility.

I'll respin with this change.  Let me know on any user space change you
might want.  Another option would be to add a libcxl 'info' functionality
which reports the above flags?  Not quite sure how that would work exactly
but I could put some thought into that if you want.

Ira
